#! /usr/bin/env python
"""Extract sections from source files concat per binder."""
import json
import pathlib
import re
import os
import sys

import yaml

ENCODING = 'utf-8'
NL = '\n'
CB_END = '}'
COLON = ':'
DASH = '-'
DOT = '.'
FULL_STOP = '.'
HASH = '#'
PARA = '§'
SEMI = ';'
SPACE = ' '
TM = '™'

PathLike = str | pathlib.Path

DEBUG = bool(os.getenv('SECTIONS_DEBUG', ''))

# Optionally dump the look-up tables (LUT)s for section display and label:
DUMP_LUT = bool(os.getenv('SECTIONS_DUMP_LUT', ''))

# Configuration and runtime parameter candidates:
BINDER_AT = pathlib.Path('etc') / 'bind.txt'
SOURCE_AT = pathlib.Path('src')
BUILD_AT = pathlib.Path('build')
SECTION_DISPLAY_TO_LABEL_AT = pathlib.Path('etc') / 'section-display-to-label.json'
SECTION_LABEL_TO_DISPLAY_AT = pathlib.Path('etc') / 'section-label-to-display.json'
EG_GLOBAL_TO_LABEL_AT = pathlib.Path('etc') / 'example-global-to-local.json'
EG_LABEL_TO_GLOBAL_AT = pathlib.Path('etc') / 'example-local-to-global.json'

# Parsers and magical literals:
IS_CITE_REF = 'cite'
CITE_REF_DETECT = re.compile(r'\[(?P<text>cite)\]\(#(?P<label>[^)]+)\)')  # [cite](#label) pattern
IS_EG_REF = 'eg'
EG_REF_DETECT = re.compile(r'\[(?P<text>eg)\]\(#(?P<label>[^)]+)\)')  # [eg](#label) pattern
IS_SEC_REF = 'sec'
SEC_REF_DETECT = re.compile(
    r'\[(?P<text>sec)\]\(#(?P<label>[^)]+)\)'
)  # [sec](#label) pattern NOTE: we blocked "1-9" initially too
MD_REF_DETECT = re.compile(r'\[(?P<text>[^]]+)\]\(#(?P<target>[^)]+)\)')  # [ref](#anylabel) pattern

# Detecting code block references with label values
# e.g. ' #  ((#run-object)).'
SEC_LABEL_BRACKET_CB_DETECT = re.compile(r'\ +#\ +[^(]+\((?P<label>\(#(?P<value>[0-9a-z-]+)\))\)\.')
# e.g. ' #  (#run-object).'
SEC_LABEL_FREE_CB_DETECT = re.compile(r'\ +#\ +[^(]+(?P<label>\(#(?P<value>[0-9a-z-]+)\))\.')

# Reverse detection patterns for documentation purposes
# e.g. ' # A run object (§3.14).' or ' #  (§3.1.2).'
SEC_DISP_BRACKET_CB_DETECT = re.compile(r'\ +#\ +[^(]+\((?P<disp>§[0-9.]+)\)\.')
SEC_DISP_FREE_CB_DETECT = re.compile(r'\ +#\ +[^(]+(?P<disp>§[0-9.]+)\.')  # e.g. ' # See §3.14.14.'

SEC_OVER = '[sec]('
CIT_OVER = '[cite]('
CIT_TOO_DIRECT = '[cite](http'

# Specific tokens:
HC_BEG = '<!--'
HC_END = '-->'
YAML_SEP = '---'
TOK_TOC = '(#$thing$)'  # Transform phase ToC label string template replacing $thing$ with the old value
TOK_SEC = "<a id='$thing$'></a>"  # Transform phase section title label string template ($thing$ -> old value)
TOK_LAB = '{#'
H = '#'
YAML_X_SEP = DASH * 7
TOC_HEADER = f"""{YAML_X_SEP}

# Table of Contents
"""
CLEAN_MD_START = '# Introduction'
FENCED_BLOCK_FLIP_FLOP = '```'

SECTION_DISPLAY_TO_LABEL = {}
SECTION_LABEL_TO_DISPLAY: dict[str, str] = {}
SEC_LABEL_TEXT: dict[str, str] = {}  # Mapping section labels to the display text

TOC_TEMPLATE = {
    1: '$sec_cnt_disp$ [$text$](#$label$)  ',
    2: '\t$sec_cnt_disp$ [$text$](#$label$)  ',
    3: '\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
    4: '\t\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
    5: '\t\t\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
}

TOK_EG = "<a id='$thing$'></a>"  # Transform phase example title label string template ($thing$ -> old value)
EG_LABEL_TEXT: dict[str, str] = {}  # Mapping example labels to the display text

# This value leads to empty line needed on GitHub to respect the new line for non-numerically starting lines
TOC_VERTICAL_SPACER = ''

# Data interface robustness hacks:
CHILDREN = 'children'
ENUMERATE = 'enumerate'
LABEL = 'label'
TOC = 'toc'

CS_OF_SLOT: list[str | None] = []

CITE_COSMETICS_TEMPLATE = '**\\[**<span id="$label$" class="anchor"></span>**$code$\\]** $text$'
CITATION_SOURCES = ('introduction-03-normative-references.md', 'introduction-04-informative-references.md')
GLOSSARY_SOURCES = ('introduction-02-terminology-glossary.md',)

# Type declarations:
META_TOC_TYPE = dict[str, dict[str, bool | str | list[dict[str, str]]]]


def load_binder(binder_at: PathLike) -> list[pathlib.Path]:
    """Load the linear binder text file into a list of file paths."""
    with open(binder_at, 'rt', encoding=ENCODING) as resource:
        return [pathlib.Path(entry.strip()) for entry in resource.readlines() if entry.strip()]


def end_of_toc_in(text: str) -> bool:
    """Detect the end of the table of contents."""
    return text.startswith('#') and ' Introduction' in text


def detect_meta(text_lines: list[str]) -> tuple[META_TOC_TYPE, list[str]]:
    """Extract any YAML data from top, remove used lines from text lines, and yield meta as well as remaining lines."""
    meta_lines = []
    if text_lines[0].startswith(HC_BEG) and text_lines[1].startswith(YAML_SEP):
        for line in text_lines[2:]:
            if line.startswith(YAML_SEP):
                break
            meta_lines.append(line)

    from_here = len(meta_lines) + 4
    if from_here > 4:
        text_lines = text_lines[from_here:]

    return yaml.safe_load(''.join(meta_lines)) if meta_lines else {}, text_lines


def load_document(path: PathLike) -> tuple[META_TOC_TYPE, list[str]]:
    """Load the text file into a list of strings and harvest any YAML meta info (if present remove the lines)."""
    with open(path, 'rt', encoding=ENCODING) as resource:
        return detect_meta(resource.readlines())


def dump_assembly(text_lines: list[str], to_path: PathLike) -> None:
    """Dump the lines of text into the text file at path."""
    with open(to_path, 'wt', encoding=ENCODING) as resource:
        resource.write(''.join(text_lines))


def label_derive_from(text: str) -> str:
    """Transform text to kebab style conventional label assuming no newlines present."""
    good_nuff = (' ', '.', ',', ';', '?', '!', '_', '(', ')', '[', ']', '{', '}', '<', '>', '\\', '/', '$', ':')
    slug = text.strip()
    for bad in good_nuff:
        slug = slug.replace(bad, '-')
    parts = slug.split('-')
    slug = '-'.join(s for s in parts if s and s != '-')
    return slug.lower()


def label_in(text: str) -> bool:
    """Detect if the text line contains a label."""
    return '](#' in text


def example_local_number(text: str) -> int:
    """Harvest integer local number of example or zero (0) if failed."""
    ls_text = text.lstrip()
    if ls_text.startswith('*Example ') or ls_text.startswith('*Examples '):
        rest = ls_text.split(SPACE, 1)[1]
        de_colon = rest.split(COLON, 1)[0]
        number = de_colon.split(SPACE, 1)[0] if SPACE in de_colon else de_colon
        try:
            return int(number)
        except ValueError:
            pass
    return 0


def example_in(text: str) -> bool:
    """Detect if the text line contains a magic example token."""
    return example_local_number(text) > 0


def code_block_label_in(text: str) -> bool:
    """Detect if the text line contains a code block section label."""
    return '(#' in text and ' # ' in text


def load_label_to_display_lut(path: PathLike = SECTION_LABEL_TO_DISPLAY_AT) -> dict[str, str]:
    """Load the LUT for section labels -> display."""
    with pathlib.Path(path).open('rt', encoding=ENCODING) as handle:
        return json.load(handle)


def load_display_to_label_lut(path: PathLike = SECTION_DISPLAY_TO_LABEL_AT) -> dict[str, str]:
    """Load the LUT for section display -> labels."""
    with pathlib.Path(path).open('rt', encoding=ENCODING) as handle:
        return json.load(handle)


def load_eg_label_to_global_lut(path: PathLike = EG_LABEL_TO_GLOBAL_AT) -> dict[str, str]:
    """Load the LUT for example labels -> global."""
    with pathlib.Path(path).open('rt', encoding=ENCODING) as handle:
        return json.load(handle)


def load_eg_global_to_label_lut(path: PathLike = EG_GLOBAL_TO_LABEL_AT) -> dict[str, str]:
    """Load the LUT for example global -> labels."""
    with pathlib.Path(path).open('rt', encoding=ENCODING) as handle:
        return json.load(handle)


def detect_leftovers(records: list[str], marker: str = 'Found') -> list[tuple[int, str]]:
    """Detect left over citation and section references."""
    ref_defects = [(n, r) for n, r in enumerate(records) if CIT_OVER in r or SEC_OVER in r]
    if ref_defects:
        print(f'{marker} {len(ref_defects)} citation or section reference defects:')
        for slot, record in ref_defects:
            print(f'- "{record.strip()}" (slot {slot})')
            if CIT_TOO_DIRECT in record:
                print('  ! citation references should use indirect targets (reference section entries) not URLs')
    return ref_defects


def insert_any_citation(record: str) -> str:
    """Insert citation into citation placeholder or return record unchanged."""
    if label_in(record):
        for ref in CITE_REF_DETECT.finditer(record):
            if ref:
                # Found citation label in markdown format
                found = ref.groupdict()
                trigger_text = found['text']
                if trigger_text != IS_CITE_REF:
                    raise RuntimeError(f'false positive cite ref in ({record.rstrip(NL)})')
                label = found['label']
                text = label.replace(';', ':')
                sem_ref = f'[cite](#{label})'
                evil_ref = f'\\[[{text}](#{label})\\]'  # \[[GFMCMARK](#GFMCMARK)\]
                record = record.replace(sem_ref, evil_ref)
    return record


def insert_any_section_reference(record: str) -> str:
    """Insert section reference into section ref placeholder or return record unchanged."""
    if label_in(record):
        for ref in SEC_REF_DETECT.finditer(record):
            if ref:
                # Found section label in markdown format
                found = ref.groupdict()
                trigger_text = found['text']
                if trigger_text != IS_SEC_REF:
                    raise RuntimeError(f'false positive sec ref in ({record.rstrip(NL)})')
                label = found['label']
                if label not in SEC_LABEL_TEXT:
                    raise RuntimeError(f'missing register label for sec ref in ({record.rstrip(NL)})')
                text = SEC_LABEL_TEXT[label]
                sem_ref = f'[sec](#{label})'
                evil_ref = f'[{text}](#{label})'  # [GFMCMARK](#GFMCMARK)
                record = record.replace(sem_ref, evil_ref)
    return record


def main(argv: list[str]) -> int:
    """Drive the extraction."""

    bind_seq_path = pathlib.Path(argv[0]) if argv else BINDER_AT
    binder = load_binder(bind_seq_path)
    for resource in binder:
        if not (SOURCE_AT / resource).is_file():
            print(f'Problem reading {resource}')
            return 1

    lines: list[str] = []
    for resource in binder:
        _, part_lines = load_document(SOURCE_AT / resource)
        if part_lines[-1] != NL:
            part_lines.append(NL)
        lines.extend(part_lines)

    in_fenced_block = False
    clean_headings = False
    sections = []
    for line in lines:
        DEBUG and print('IGNORED >>>>>>>', line.rstrip(NL)[:42], '...')
        if line.startswith(CLEAN_MD_START):
            clean_headings = True

        if not clean_headings:
            continue

        if line.startswith(FENCED_BLOCK_FLIP_FLOP):
            in_fenced_block = not in_fenced_block

        if line.startswith(HASH) and not in_fenced_block:
            if line.lstrip(HASH).startswith(SPACE):
                DEBUG and print('SECTION >>>>>>>', line.rstrip(NL))
                sections.append(line.rstrip(NL))

    print(f'Identified {len(sections)} relevant sections ...')

    level_counts = {n: 0 for n in range(1, 7)}
    previous_level = 0
    defects = 0
    for section in sections:
        level = len(section.split(SPACE, 1)[0])
        level_counts[level] += 1
        if level > previous_level:
            if level - previous_level > 1:
                defects += 1
                print(f'! LEVEL_NEST_ERROR jumping from level {previous_level} directly to {level}')
                print(f'>>> {section}')
        previous_level = level

    for level, count in level_counts.items():
        print(f'- {count} level {level} sections')

    if defects:
        print(f'Found {defects} defects in section nesting!')
    else:
        print('Section level nesting is valid')

    db = []
    is_appendix = False
    root: int | str = 0
    appr = ''
    for section in sections:
        level = len(section.split(SPACE, 1)[0])
        if level == 1:
            root += 1
        text_plus = section[level + 1:]
        if '<mark title="Ephemeral region marking">' in text_plus:
            text_plus = text_plus.replace('<mark title="Ephemeral region marking">', '').replace('</mark>', '')
        if text_plus.startswith('Appendix '):
            appr = text_plus.replace('Appendix ', '')[0]
            is_appendix = True
        if TOK_LAB in text_plus:
            text, slug = text_plus.rstrip(SPACE).rstrip('}').split(TOK_LAB, 1)
        else:
            text = text_plus.rstrip(SPACE)
            slug = label_derive_from(text)
        if not is_appendix:
            a_root = root
        else:
            a_root = appr
        db.append([is_appendix, a_root, level, text, slug])

    if DEBUG:
        for is_appendix, a_root, level, text, slug in db:
            print(f'{"        " if not is_appendix else "APPENDIX"} | {a_root} | {(HASH * level).rjust(7)} "{text}" <-- {slug}')

    display_to_label = {}
    lvl_min, lvl_sup = 1, 7
    sec_cnt = {f'{HASH * level} ': 0 for level in range(lvl_min, lvl_sup)}
    sec_lvl = {f'{HASH * level} ': level for level in range(lvl_min, lvl_sup)}
    lvl_sec = {level: f'{HASH * level} ' for level in range(lvl_min, lvl_sup)}
    H1 = f'{HASH} '
    cur_lvl = sec_lvl[H1]
    for is_appendix, a_root, level, text, slug in db:
        if not is_appendix:
            tag = f'{HASH * level} '
            # auto counters
            nxt_lvl = sec_lvl[tag]
            sec_cnt[tag] += 1
            if nxt_lvl < cur_lvl:
                for level in range(nxt_lvl + 1, lvl_sup):
                    sec_cnt[lvl_sec[level]] = 0
            sec_cnt_disp_vec = []
            for s_tag, cnt in sec_cnt.items():
                if cnt == 0:
                    raise RuntimeError(f'ERROR: Counting is hard: {sec_cnt} at {tag} for {text}')
                sec_cnt_disp_vec.append(str(cnt))
                if s_tag == tag:
                    break
            sec_cnt_disp = FULL_STOP.join(sec_cnt_disp_vec)
            # Hack to amend first level numeric section counter displays with a full stop - do not ask ...
            if FULL_STOP not in sec_cnt_disp:
                sec_cnt_disp += FULL_STOP
            cur_lvl = nxt_lvl

            display = sec_cnt_disp.rstrip(DOT)
        else:
            display, text = text.split(SPACE, 1)
        display_to_label[display] = slug

    BUILD_AT.mkdir(parents=True, exist_ok=True)
    dump_assembly(lines, BUILD_AT / 'tmp.md')

    with SECTION_DISPLAY_TO_LABEL_AT.open('wt', encoding=ENCODING) as handle:
        json.dump(display_to_label, handle, indent=2)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
