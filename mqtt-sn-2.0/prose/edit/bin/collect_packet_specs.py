#! /usr/bin/env python
"""Collect bytefield-diagram (.edn) packet specs implemented in a clojure based DSL, in prose order, into a manifest.

Walks build/gfm-plus.md -- the already-assembled, already-numbered concatenation of
the spec in bind.txt order (same artifact `make gfm-plus` produces) -- tracking the
current heading path as it scans, and records one entry per figure whose image has a
sibling .edn bytefield source in src/images/packet/<stem>.edn.

This is prototype 1 of 2 for the packet-dictionary exploration: find and order the
raw material (which packets have a bytefield source, in the order the spec presents
them, with their section context) before parsing any Clojure.  See
parse_bytefield_edn.py for the second step.

Usage: bin/collect_packet_specs.py [-o build/packet-spec-manifest.json]
"""
import argparse
import json
import pathlib
import re
import subprocess
import sys

ENCODING = 'utf-8'

# A section number is either all-digit (3, 3.1, 3.1.2) or Appendix-style, a single
# leading letter (C, C.6, C.6.8 -- nide.yaml's structure.section-type-prefixes:
# [Appendix] confirms Appendix sections get letter numbering, not numeric). A plain
# title word never matches: it would need its own dot-digit suffix or to be a bare
# single letter immediately followed by whitespace, which no real title word is.
HEADING_RE = re.compile(r"^(#{1,6})\s+(?:(?P<num>(?:[0-9]+|[A-Za-z])(?:\.[0-9]+)*\.?)\s+)?(?P<title>.+?)<a id='(?P<anchor>[^']+)'></a>\s*$")
FIG_ANCHOR_RE = re.compile(r'^<a id="(?P<label>fig-[^"]+)"></a>\s*$')
IMG_RE = re.compile(r"^!\[(?P<alt>[^\]]*)\]\((?P<path>images/[^)\" ]+\.png)(?:\s+\"(?P<title>[^\"]*)\")?\)\s*$")


def ensure_gfm_plus(edit_root: pathlib.Path) -> pathlib.Path:
    """Regenerate build/gfm-plus.md so the manifest reflects the current source."""
    out_path = edit_root / 'build' / 'gfm-plus.md'
    subprocess.run(['make', 'gfm-plus'], cwd=edit_root, check=True, capture_output=True)
    if not out_path.is_file():
        sys.exit(f'{out_path} missing after "make gfm-plus" -- check the build for errors')
    return out_path


def collect(gfm_plus_path: pathlib.Path, edn_dir: pathlib.Path) -> list[dict]:
    """Walk gfm-plus.md in order, pairing each labeled figure with its .edn if any."""
    lines = gfm_plus_path.read_text(encoding=ENCODING).splitlines()
    edn_stems = {p.stem for p in edn_dir.glob('*.edn')}

    # heading_stack[level] = (number, title, anchor); level is len(leading '#'s).
    heading_stack: dict[int, dict[str, str]] = {}
    entries: list[dict] = []
    order = 0

    i = 0
    while i < len(lines):
        line = lines[i]

        hm = HEADING_RE.match(line)
        if hm:
            level = len(hm.group(1))
            heading_stack = {lv: h for lv, h in heading_stack.items() if lv < level}
            heading_stack[level] = {
                'number': hm.group('num') or '',
                'title': hm.group('title'),
                'anchor': hm.group('anchor'),
            }
            i += 1
            continue

        fm = FIG_ANCHOR_RE.match(line)
        if fm and i + 1 < len(lines):
            im = IMG_RE.match(lines[i + 1])
            if im:
                stem = pathlib.Path(im.group('path')).stem
                has_edn = stem in edn_stems
                entries.append({
                    'order': order,
                    'section_path': [heading_stack[lv] for lv in sorted(heading_stack)],
                    'fig_label': fm.group('label'),
                    'image_path': im.group('path'),
                    'image_alt': im.group('alt'),
                    'edn_path': f'images/packet/{stem}.edn' if has_edn else None,
                })
                order += 1
                i += 2
                continue
        i += 1

    return entries


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('-o', '--out', default='build/packet-spec-manifest.json', help='output manifest path')
    parser.add_argument('--no-rebuild', action='store_true', help='reuse an existing build/gfm-plus.md instead of regenerating it')
    args = parser.parse_args()

    edit_root = pathlib.Path(__file__).resolve().parent.parent
    gfm_plus_path = edit_root / 'build' / 'gfm-plus.md'
    if not args.no_rebuild or not gfm_plus_path.is_file():
        gfm_plus_path = ensure_gfm_plus(edit_root)

    entries = collect(gfm_plus_path, edit_root / 'src' / 'images' / 'packet')

    out_path = pathlib.Path(args.out)
    if not out_path.is_absolute():
        out_path = edit_root / out_path
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(entries, indent=2) + '\n', encoding=ENCODING)

    with_edn = sum(1 for e in entries if e['edn_path'])
    print(f'{len(entries)} figure(s) found, {with_edn} with a matching .edn -- wrote {out_path}')


if __name__ == '__main__':
    main()
