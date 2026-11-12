#! /usr/bin/env python
"""Assemble the per-packet manifest + derived byte-rows into one combined packet
dictionary: mqtt-sn-v2.0-draft-packet-dictionary.json.

Prototype stage 4 (final, for now) of the packet-dictionary exploration:
  1. collect_packet_specs.py   -- find+order every bytefield-backed figure
  2. parse_bytefield_edn.py    -- Clojure .edn -> raw JSON instance
  3. derive_byte_rows.py       -- raw items -> byte/row/bit-field structure
  4. assemble_packet_dictionary.py (this file) -- combine 1+3 into one artifact

Splits each figure's section title into a packet code + description where the
source actually uses that convention ("CONNECT - Connection Request"), and leaves
code null where it doesn't (the three plain Encapsulation sections, and the C.6
QoS -1 appendix variant -- forcing a split there would invent structure the title
doesn't have).

Usage: bin/assemble_packet_dictionary.py
       [--manifest build/packet-spec-manifest.json] [--rows-dir build/packet-rows]
       [--out build/mqtt-sn-v2.0-draft-packet-dictionary.json]
"""
import argparse
import json
import pathlib
import re
import sys

ENCODING = 'utf-8'
CODE_SPLIT_RE = re.compile(r'^(?P<code>[A-Z][A-Z0-9_]*)\s+-{1,2}\s+(?P<description>.+)$')


def split_code(title: str) -> tuple[str | None, str]:
    m = CODE_SPLIT_RE.match(title)
    if m:
        return m.group('code'), m.group('description')
    return None, title


def assemble(manifest: list[dict], rows_dir: pathlib.Path) -> tuple[list[dict], list[str]]:
    packets = []
    warnings: list[str] = []

    for entry in manifest:
        if not entry['edn_path']:
            continue
        stem = pathlib.Path(entry['edn_path']).stem
        rows_path = rows_dir / f'{stem}.json'
        if not rows_path.is_file():
            warnings.append(f'{stem}: no derived-rows file at {rows_path} -- skipped')
            continue
        rows_data = json.loads(rows_path.read_text(encoding=ENCODING))
        if rows_data.get('warnings'):
            warnings.append(f'{stem}: {len(rows_data["warnings"])} unresolved row-derivation warning(s) -- included anyway, check build/packet-rows/{stem}.json')

        section = entry['section_path'][-1] if entry['section_path'] else {'number': '', 'title': '', 'anchor': ''}
        code, description = split_code(section['title'])

        packets.append({
            'order': entry['order'],
            'section': {
                'number': section['number'],
                'title': section['title'],
                'anchor': section['anchor'],
                'path': [{'number': s['number'], 'title': s['title']} for s in entry['section_path']],
            },
            'code': code,
            'description': description,
            'figure': {
                'label': entry['fig_label'],
                'image': entry['image_path'],
                'alt': entry['image_alt'],
            },
            'source_edn': entry['edn_path'],
            'boxes_per_row': rows_data.get('boxes_per_row'),
            'rows': rows_data['rows'],
        })

    return packets, warnings


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('--manifest', default='build/packet-spec-manifest.json')
    parser.add_argument('--rows-dir', default='build/packet-rows')
    parser.add_argument('--out', default='build/mqtt-sn-v2.0-draft-packet-dictionary.json')
    args = parser.parse_args()

    edit_root = pathlib.Path(__file__).resolve().parent.parent

    def resolve(p: str) -> pathlib.Path:
        path = pathlib.Path(p)
        return path if path.is_absolute() else edit_root / path

    manifest_path = resolve(args.manifest)
    rows_dir = resolve(args.rows_dir)
    out_path = resolve(args.out)

    if not manifest_path.is_file():
        sys.exit(f'{manifest_path} not found -- run collect_packet_specs.py first')
    if not rows_dir.is_dir():
        sys.exit(f'{rows_dir} not found -- run derive_byte_rows.py first')

    manifest = json.loads(manifest_path.read_text(encoding=ENCODING))
    packets, warnings = assemble(manifest, rows_dir)

    dictionary = {
        '$schema': 'https://docs.oasis-open.org/mqtt/mqtt-sn/v2.0/schema/packet-dictionary.json',
        'title': 'MQTT-SN v2.0 (CSD01 draft) -- Packet Dictionary',
        'description': 'Machine-readable companion to the prose, generated from the bytefield (.edn) diagram sources -- not hand-maintained. See bin/README (or AGENTS.md) for the generation pipeline.',
        'packet_count': len(packets),
        'packets': packets,
    }

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(dictionary, indent=2) + '\n', encoding=ENCODING)

    print(f'{len(packets)} packet(s) assembled -> {out_path}')
    for w in warnings:
        print(f'  NOTE: {w}', file=sys.stderr)


if __name__ == '__main__':
    main()
