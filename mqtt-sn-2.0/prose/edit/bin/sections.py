#! /usr/bin/env python
"""Derive section and example LUTs from source files ordered per bind.txt.

All spec-specific behaviour is driven by etc/sections-config.yaml.

Outputs (always):
  etc/section-display-to-label.json
  etc/section-label-to-display.json
  etc/section-display-to-text.json

Outputs (when track-examples: true):
  etc/example-local-to-global.json
  etc/example-global-to-local.json
"""

import json
import os
import pathlib
import re
import sys
from typing import Union

import yaml

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
DASH = '-'
DOT = '.'
ENCODING = 'utf-8'
ENC_ERRS = 'ignore'
FULL_STOP = '.'
HASH = '#'
NL = '\n'
RS = chr(30)  # Record Separator — used in slugify
SPACE = ' '

PathLike = Union[str, pathlib.Path]
SectionRecord = tuple[int, str, str, str | None, str]

DEFAULT_CONFIG_PATH = pathlib.Path('etc') / 'assembly-config.yaml'
DO_NOT_EDIT_MEMENTO = {'Please do not edit manually!': 'Cf. assembly-config.yaml and bin/sections.py'}

GREMLINS = ' .,;?!_()[]{}<>\\/$:"\'`´'
TOK_LAB = '{#'
FENCED_BLOCK = '```'

# Matches inner annex/appendix sub-headings like "A.1. Document Status" or "B.2 Informative References"
APPENDIX_INNER_PATTERN = re.compile(r'(?P<display>[A-Z][.0-9]+) +(?P<rest>.+)')

EXAMPLE_DETECT = re.compile(r'^\*Examples?\ +(?P<number>\d+)\b')

KNOWN_CHANNELS = (
    GFM_PLUS := 'gfm-plus',
    HTML := 'html',
    PDF := 'pdf',
)

KNOWN_SEC_REF_STYLES = (
    NUMBER := 'number',
    NUMBER_TITLE := 'number-title',
    SECTION_SIGN_NUMBER := 'section-sign-number',
)

DEBUG = bool(os.getenv('SECTIONS_DEBUG', ''))


class Config:
    """Plain YAML to python class device."""
    def __init__(self, config_source: str):
        self.config_source = config_source
        self.active = False

        self.annex_starts_with = 'Annex '
        self.appendix_starts_with = 'Appendix '

        self.binder = 'bind.txt'  # binder text file (assumed in etc-path)

        self.binder_ignores: dict[str, list[str]] = {
            GFM_PLUS: [],
            HTML: [],
            PDF: ['frontmatter.md'],
        }

        self.build_path: str = 'build'  # Relative path from execution dir to build folder

        self.citation_skip_prefixes: list[str] = [HASH]
        self.citation_sources: list[str] = []  # File names, not full paths

        self.delete_when: list[dict[str, str | list[str]]] = [
            {
                'contains': '<mark title="Ephemeral region marking">',
                'delete': [
                    '<mark title="Ephemeral region marking">',
                    '</mark>',
                ],
            },
        ]

        self.etc_path: str = 'etc'  # Relative path from execution dir to etc folder
        self.example_local_to_global_db: str = 'example-local-to-global.json'  # (assumed in etc-path)
        self.example_global_to_local_db: str = 'example-global-to-local.json'  # (assumed in etc-path)
        self.first_authored_section = '# Scope'  # Section title of the first authored section
        self.glossary_sources: list[str] = []  # file names, not full paths
        self.html_title: str = 'No Title Given'  # The title of the document as it appears on the frontmatter
        self.meta_example_global_number: int = 4321  # integer either > count of examples or == zero
        self.section_display_to_label_db: str = 'section-display-to-label.json'  # (assumed in etc-path)
        self.section_display_to_text_db: str = 'section-display-to-text.json'  # (assumed in etc-path)
        self.section_label_to_display_db: str = 'section-label-to-display.json'  # (assumed in etc-path)
        self.section_reference_style: str = KNOWN_SEC_REF_STYLES[0]  # Enumeration: member of KNOWN_SEC_REF_STYLES
        self.source_path: str = 'src'  # relative path from execution dir to source dir
        self.track_examples: bool = False  # Set to true if examples should be discovered

        self.active = self.load()

    def __repr__(self):
        return json.dumps(self.__dict__, indent=2)

    def load(self) -> bool:
        """Load from YAML file at config source with minimal validation only."""
        with open(self.config_source, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
            _data = yaml.safe_load(handle) or {}
        if _data:
            self.annex_starts_with = str(_data.get('annex-starts-with', self.annex_starts_with))
            self.appendix_starts_with = str(_data.get('appendix-starts-with:', self.appendix_starts_with))
            self.binder = str(_data.get('binder', self.binder))

            if a_map := _data.get('binder-ignores', {}):
                _binder_ignores: dict[str, list[str]] = {}
                if all(channel in a_map for channel in KNOWN_CHANNELS):
                    for channel in KNOWN_CHANNELS:
                        _binder_ignores[channel] = [str(ignore) for ignore in a_map.get(channel, [])]
                self.binder_ignores = _binder_ignores

            self.build_path = str(_data.get('build-path', self.build_path))

            if a_seq := _data.get('citation-skip-prefixes', []):
                self.citation_skip_prefixes = [str(entry) for entry in a_seq]

            if a_seq := _data.get('citation-sources', []):
                self.citation_sources = [str(entry) for entry in a_seq]

            if a_seq := _data.get('delete-when', []):
                _delete_when: list[dict[str, str | list[str]]] = []
                for rule in a_seq:
                    if 'contains' in rule and 'delete' in rule:
                        contains = str(rule['contains'])
                        deletions = [str(entry) for  entry in rule['delete']]
                        _delete_when.append({'contains': contains, 'delete': deletions})
                self.delete_when = _delete_when

            self.etc_path = str(_data.get('etc-path', self.etc_path))
            self.example_local_to_global_db = str(_data.get('example-local-to-global-db', self.example_local_to_global_db))
            self.example_global_to_local_db = str(_data.get('example-global-to-local-db', self.example_global_to_local_db))
            self.first_authored_section = str(_data.get('first-authored-section', self.first_authored_section))

            if a_seq := _data.get('glossary-sources', []):
                self.glossary_sources = [str(entry) for entry in a_seq]

            self.html_title = str(_data.get('html-title', self.html_title))
            self.meta_example_global_number = int(_data.get('meta-example-global-number', self.meta_example_global_number))
            self.section_display_to_label_db = str(_data.get('section-display-to-label-db', self.section_display_to_label_db))
            self.section_display_to_text_db = str(_data.get('section-display-to-text-db', self.section_display_to_text_db))
            self.section_label_to_display_db = str(_data.get('section-label-to-display-db', self.section_label_to_display_db))

            self.section_reference_style = str(_data.get('section-reference-style', self.section_reference_style))
            if self.section_reference_style not in KNOWN_SEC_REF_STYLES:
                raise ValueError(
                    f"value '{self.section_reference_style}' of section-reference-style config member"
                    f' is not in {KNOWN_SEC_REF_STYLES}'
                )

            self.source_path = str(_data.get('source-path', self.source_path))
            self.track_examples = bool(_data.get('track-examples', self.track_examples))
        return True


def load_binder(cfg: Config) -> list[PathLike]:
    """EIther yield the seq of files to be concat or raise value error when files are not found."""
    with open(pathlib.Path(cfg.etc_path) / cfg.binder, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
        bind_seq: list[PathLike] = [pathlib.Path(line.strip()) for line in handle if line.strip()]
    for resource in bind_seq:
        if not (pathlib.Path(cfg.source_path) / resource).is_file():
            raise ValueError(f"source file not found: '{resource}'")

    return bind_seq


def slugify(
    text: str,
    connector: str = DASH,
    marker: str = RS,
    gremlins: str = GREMLINS,
    policy: str = 'lower',
) -> str:
    """Derive kebab-style slug from text.

    Every character not in gremlins is kept. Incoming connector chars are
    preserved via a sandwich transform through the marker char.
    """
    ds = connector
    rs = marker
    sl = text.strip().replace(ds, rs)
    for gremlin in gremlins:
        sl = sl.replace(gremlin, ds)
    return getattr(
        ds.join(s.replace(rs, ds) for s in sl.split(ds) if s and s != ds),
        policy,
    )()


def normalize_enumerate(value: object) -> str:
    """Normalise a display prefix to a clean string (strips trailing dots)."""
    if value is False or value is None:
        return ''
    return str(value).rstrip(DOT)


def dump(data: dict, path: PathLike) -> None:  # type: ignore[type-arg]
    """DRY."""
    with open(path, 'wt', encoding=ENCODING) as handle:
        json.dump(data, handle, indent=2)
        handle.write(NL)


def highlight(lines: list[str], pos: int, span: int = 10) -> None:
    """Print lines around pos with an arrow at pos, to help authors find errors."""
    for n in range(max(0, pos - span), min(pos + span, len(lines))):
        prefix = 'HERE>>>' if n == pos else '       '
        print(f'{prefix} {n:4} | {lines[n].rstrip(NL)}')
    print(DASH * 72)


def load_configuration(cfg_path: PathLike) -> Config:
    """Load the configuration from path."""
    if not pathlib.Path(cfg_path).is_file():
        print('INFO: Please run this script from inside the prose/edit/ directory.')
        raise ValueError(f"config file not found at '{cfg_path}'")

    cfg = Config(str(cfg_path))
    if DEBUG:
        for line in str(cfg).split(NL):
            print(f'DEBUG: {line}')
    print(f'INFO: first-authored-section = {cfg.first_authored_section!r}')
    print(f'INFO: track-examples = {cfg.track_examples}')
    if cfg.track_examples:
        print(f'INFO: meta-example-global-number = {cfg.meta_example_global_number}')
    return cfg


def concat_sources(bind_seq: list[PathLike], cfg: Config) -> tuple[list[str], list[str]]:
    """Bare bones collector yielding two list: first lines of all sources  and second source of line."""
    documents: list[tuple[list[str], str]] = []
    for resource in bind_seq:
        with open(pathlib.Path(cfg.source_path) / resource, 'rt', encoding=ENCODING, errors=ENC_ERRS) as fh:
            raw = fh.readlines()
        if raw and raw[-1] != NL:
            raw.append(NL)
        documents.append((raw, str(resource)))

    # Flatten to a single line sequence with per-line source tracking
    the_lines: list[str] = []
    sources_of_lines: list[str] = []
    for body, source in documents:
        for line in body:
            the_lines.append(line)
            sources_of_lines.append(source)

    print(f'INFO: Loaded {len(bind_seq)} source files → {len(the_lines)} lines total')
    return the_lines, sources_of_lines


def special_section_dispatch(text_plus: str, text: str, slug: str, is_extra: bool, cfg: Config) -> tuple[str, str, str | None, bool]:
    """ Determine display value from heading text.

    For appendix headings the slug is re-derived from the text AFTER the display
    prefix is stripped, so that labels match what assemble.py produces."""
    display: str | None
    if text.startswith(cfg.appendix_starts_with):
        is_extra = True
        parts = text.split(SPACE, 2)
        display = f'Appendix {parts[1]}'
        text = parts[2] if len(parts) > 2 else parts[1]
        if TOK_LAB not in text_plus:
            slug = slugify(text)
    elif text.startswith(cfg.annex_starts_with):
        is_extra = True
        parts = text.split(SPACE, 2)
        display = f'Annex {parts[1]}'
        text = parts[2] if len(parts) > 2 else parts[1]
        if TOK_LAB not in text_plus:
            slug = slugify(text)
    elif is_extra:
        m = APPENDIX_INNER_PATTERN.match(text)
        if m:
            display = normalize_enumerate(m.group('display'))
            text = m.group('rest')
            if TOK_LAB not in text_plus:
                slug = slugify(text)
        else:  # Unnumbered OASIS-mandated sub-heading (e.g. Leadership, Revision History)
            display = text
    else:   # Auto-numbering in next stage
        display = None

    return text, slug, display, is_extra


def scan_sections(the_lines: list[str], line_src: list[str], cfg: Config) -> tuple[list[SectionRecord], list[str | None]]:
    """Scan the lines for sections.

    Each section record: (level, text, slug, display, source)
    display is None for auto-numbered sections, str for explicit display."""
    section_records: list[SectionRecord] = []

    # Per-line context: which section slug is "current" at that line
    section_of_line: list[str | None] = [None] * len(the_lines)

    in_fenced = False
    authored_headings = False
    current_section_slug: str | None = None
    is_appendix = False  # flips True permanently on first Annex/Appendix heading

    for idx, line in enumerate(the_lines):
        if line.startswith(cfg.first_authored_section):
            authored_headings = True

        if not authored_headings:
            continue

        if line.startswith(FENCED_BLOCK):
            in_fenced = not in_fenced

        section_of_line[idx] = current_section_slug

        if not line.startswith(HASH) or in_fenced:
            continue
        stripped = line.lstrip(HASH)
        if not stripped.startswith(SPACE):
            continue

        level = len(line) - len(stripped)
        text_plus = stripped.strip()

        for rule in cfg.delete_when:
            trigger: str = rule['contains']  # type: ignore
            deletions: list[str] = rule['delete']  # type: ignore
            if trigger in text_plus:
                for deletion in deletions:
                    text_plus = text_plus.replace(deletion, '')
        text_plus = text_plus.strip()

        # Extract explicit slug override if present
        if TOK_LAB in text_plus:
            text, slug = text_plus.rstrip('}').split(TOK_LAB, 1)
            text = text.strip()
            slug = slug.strip()
        else:
            text = text_plus
            slug = slugify(text)

        text, slug, display, is_appendix = special_section_dispatch(text_plus, text, slug, is_appendix, cfg)

        section_records.append((level, text, slug, display, line_src[idx]))
        current_section_slug = slug
        section_of_line[idx] = current_section_slug

    print(f'INFO: Identified {len(section_records)} relevant section headings')

    return section_records, section_of_line


def validate_sections(sec_records: list[SectionRecord]) -> None:
    """Validate nesting of sections."""
    level_counts: dict[int, int] = {n: 0 for n in range(1, 7)}
    previous_level = 0
    nesting_defects = 0
    for level, text, _, _, src in sec_records:
        level_counts[level] += 1
        if level > previous_level and level - previous_level > 1:
            nesting_defects += 1
            print(
                f'ERROR: Section nesting jump from level {previous_level}'
                f' to level {level} in {src!r}:'
            )
            print(f'  >>> {HASH * level} {text}')
        previous_level = level

    for lvl, cnt in level_counts.items():
        if cnt:
            print(f'INFO: - {cnt} level-{lvl} section heading(s)')

    if nesting_defects:
        raise ValueError(f'found {nesting_defects} section nesting defect(s) — aborting.')

    print('INFO: Section level nesting is valid.')


def map_sections(sec_records: list[SectionRecord], cfg: Config) -> None:
    """Assign display values and dump the ,appings / luts."""
    lvl_cnt: dict[int, int] = {n: 0 for n in range(1, 7)}

    display_to_label: dict[str, str] = {}
    display_to_text: dict[str, str] = {}

    for level, text, slug, display, _src in sec_records:
        if display is None:  # Auto-number
            lvl_cnt[level] += 1
            for sub in range(level + 1, 7):
                lvl_cnt[sub] = 0
            display = DOT.join(str(lvl_cnt[n]) for n in range(1, level + 1))

        if display in display_to_label and display_to_label[display] != slug:
            raise ValueError(
                f'duplicate display key {display!r} for slugs'
                f' {display_to_label[display]!r} and {slug!r}'
            )

        display_to_label[display] = slug
        display_to_text[display] = text

    label_to_display: dict[str, str] = {
        **DO_NOT_EDIT_MEMENTO,
        **{slug: disp for disp, slug in sorted(display_to_label.items(), key=lambda kv: kv[1])},
    }

    dump(display_to_label, pathlib.Path(cfg.etc_path) / cfg.section_display_to_label_db)
    dump(label_to_display, pathlib.Path(cfg.etc_path) / cfg.section_label_to_display_db)
    dump(display_to_text, pathlib.Path(cfg.etc_path) / cfg.section_display_to_text_db)

    print(f'INFO: Wrote {len(display_to_label)} entries to section LUT files.')


def scan_examples(the_lines: list[str], sect_of_line: list[str | None], cfg: Config) -> tuple[list[tuple[int, str, int]], bool]:
    """Scan the lines for examples."""
    ex_lines_found: list[tuple[int, str, int]] = []  # (line_idx, section_slug, local_num)

    for idx, line in enumerate(the_lines):
        m = EXAMPLE_DETECT.match(line.lstrip())
        if m:
            num = int(m.group('number'))
            sec = sect_of_line[idx]

            if sec is None:
                print(f'WARN: Example {num} at line {idx} has no enclosing section context.')
                continue

            ex_lines_found.append((idx, sec, num))

    validate_next = True

    if ex_lines_found and not cfg.track_examples:
        print(f'WARN: Found {len(ex_lines_found)} example(s) but track-examples is false.')
        print('WARN: Set track-examples: true in etc/assembly-config.yaml to validate and generate LUTs.')
        validate_next = False
    elif not cfg.track_examples:
        validate_next = False
    elif not ex_lines_found:
        print('INFO: No example lines detected — generating only LUT stubs.')
        dump(DO_NOT_EDIT_MEMENTO, pathlib.Path(cfg.etc_path) / cfg.example_local_to_global_db)
        dump(DO_NOT_EDIT_MEMENTO, pathlib.Path(cfg.etc_path) / cfg.example_global_to_local_db)
        validate_next = False

    return ex_lines_found, validate_next


def validate_examples(ex_lines_found: list[tuple[int, str, int]], the_lines: list[str]) -> None:
    """Validate few constraints on (the numbering of) examples."""
    examples_per_sec: dict[str, list[tuple[int, int]]] = {}  # slug → [(line_idx, local_num)]
    for line_idx, sec_slug, local_num in ex_lines_found:
        examples_per_sec.setdefault(sec_slug, []).append((line_idx, local_num))

    example_defects = 0
    for sec_slug, entries in examples_per_sec.items():
        nums = [n for _, n in entries]
        # Must start at 1
        if nums[0] != 1:
            example_defects += 1
            first_idx = entries[0][0]
            print(
                f'ERROR: First example in section {sec_slug!r} is number {nums[0]}'
                f' (expected 1) — line {first_idx}:'
            )
            highlight(the_lines, first_idx)
        # Must be gap-free and duplicate-free
        for pos in range(1, len(nums)):
            if nums[pos] == nums[pos - 1]:
                example_defects += 1
                dup_idx = entries[pos][0]
                print(
                    f'ERROR: Duplicate example number {nums[pos]}'
                    f' in section {sec_slug!r} — line {dup_idx}:'
                )
                highlight(the_lines, dup_idx)
            elif nums[pos] != nums[pos - 1] + 1:
                example_defects += 1
                gap_idx = entries[pos][0]
                print(
                    f'ERROR: Example number gap in section {sec_slug!r}:'
                    f' {nums[pos - 1]} → {nums[pos]} — line {gap_idx}:'
                )
                highlight(the_lines, gap_idx)

    if example_defects:
        raise ValueError(f'found {example_defects} example continuity defect(s) — aborting.')

    print(f'INFO: Example continuity valid across {len(examples_per_sec)} section(s).')


def map_examples(ex_lines_found: list[tuple[int, str, int]], cfg: Config) -> None:
    """Assign global example numbers and write the maps / luts."""
    local_to_global: dict[str, str] = dict(DO_NOT_EDIT_MEMENTO)
    global_to_local: dict[str, str] = dict(DO_NOT_EDIT_MEMENTO)

    first_example = True
    global_counter = 0

    for _, sec_slug, local_num in ex_lines_found:
        local_label = f'{sec_slug}-eg-{local_num}'
        if first_example:
            global_num_str = str(cfg.meta_example_global_number)
            first_example = False
        else:
            global_counter += 1
            global_num_str = str(global_counter)
        local_to_global[local_label] = global_num_str
        global_to_local[global_num_str] = local_label

    dump(local_to_global, pathlib.Path(cfg.etc_path) / cfg.example_local_to_global_db)
    dump(global_to_local, pathlib.Path(cfg.etc_path) / cfg.example_global_to_local_db)

    total = len(ex_lines_found)
    print(f'INFO: Wrote {total} example LUT entries ({total - 1} real + 1 meta at {cfg.meta_example_global_number}).')



def main(args: list[str]) -> int:  # noqa: C901
    """Drive the section harvester."""
    cfg_path: PathLike = args[0] if args else DEFAULT_CONFIG_PATH
    config = load_configuration(cfg_path)
    binder = load_binder(config)

    all_lines, line_source = concat_sources(binder, config)

    section_records, section_of_line = scan_sections(all_lines, line_source, config)

    validate_sections(section_records)
    map_sections(section_records, config)

    example_lines_found, validation_next = scan_examples(all_lines, section_of_line, config)
    if not validation_next:
        return 0

    validate_examples(example_lines_found, all_lines)
    map_examples(example_lines_found, config)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
