#! /usr/bin/env python
"""Assemble prose sources along the gfm-plus and pdf channels (html is default and a gfm-plus derivate).

Select output format with -t (html is default):

  html -> build/tmp.md  + build/toc-mint.json  (input for pandoc -> toccata.py) - - > html delivery item
                +-> (is gfm-plus delivery item)
  pdf  -> build/pdf.md                         (input for liitos) - - > pdf delivery item

"""
import json
import pathlib
import re
import os
import sys
from typing import Union

import yaml

ENCODING = 'utf-8'
ENC_ERRS = 'ignore'
NL = '\n'
CB_END = '}'
COLON = ':'
DASH = '-'
DOT = '.'
FULL_STOP = '.'
HASH = '#'
PARA = '§'
RS = chr(30)
SEMI = ';'
SPACE = ' '
TM = '™'
GREMLINS = ' .,;?!_()[]{}<>\\/$:"\'`´'

DEFAULT_CONFIG_PATH = pathlib.Path('etc') / 'assembly-config.yaml'

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

DEBUG = bool(os.getenv('ASSEMBLE_DEBUG', ''))
# Optionally dump look-up tables back to etc/ as a cross-check against sections.py output:
DUMP_LUT = bool(os.getenv('DUMP_LUT', ''))

# Parsers:
IS_CITE_REF = 'cite'
CITE_REF_DETECT = re.compile(r'\[(?P<text>cite)\]\(#(?P<label>[^)]+)\)')
IS_EG_REF = 'eg'
EG_REF_DETECT = re.compile(r'\[(?P<text>eg)\]\(#(?P<label>[^)]+)\)')
IS_SEC_REF = 'sec'
SEC_REF_DETECT = re.compile(r'\[(?P<text>sec)\]\(#(?P<label>[^)]+)\)')
MD_REF_DETECT = re.compile(r'\[(?P<text>[^]]+)\]\(#(?P<target>[^)]+)\)')

# Code block label reference patterns (label values inside inline comments):
SEC_LABEL_BRACKET_CB_DETECT = re.compile(r'\ +#\ +[^(]+\((?P<label>\(#(?P<value>[0-9a-z-]+)\))\)\.')
SEC_LABEL_FREE_CB_DETECT = re.compile(r'\ +#\ +[^(]+(?P<label>\(#(?P<value>[0-9a-z-]+)\))\.')
# Documentary reverse-detection (§ display style, used for authoring checks):
SEC_DISP_BRACKET_CB_DETECT = re.compile(r'\ +#\ +[^(]+\((?P<disp>§[0-9.]+)\)\.')
SEC_DISP_FREE_CB_DETECT = re.compile(r'\ +#\ +[^(]+(?P<disp>§[0-9.]+)\.')

SEC_OVER = '[sec]('
CIT_OVER = '[cite]('
CIT_TOO_DIRECT = '[cite](http'

HC_BEG = '<!--'
HC_END = '-->'
YAML_SEP = '---'
TOK_TOC = '(#$thing$)'
TOK_SEC = "<a id='$thing$'></a>"
TOK_LAB = '{#'
H = '#'
YAML_X_SEP = DASH * 7
TOC_HEADER = f"""{YAML_X_SEP}

# Table of Contents
"""
FENCED_BLOCK_FLIP_FLOP = '```'

# Matches inner appendix sub-headings like "C.1 File Size" or "F.2 Something"
APPENDIX_INNER_PATTERN = re.compile(r'(?P<display>[A-Z][.0-9]+\.?) +(?P<rest>.+)')
LOGO_URL = 'https://docs.oasis-open.org/templates/OASISLogo-v3.0.png'
LOGO_LOCAL_PATH = 'images/OASISLogo-v3.0.png'
TOP_LOGO_LINE = f'![OASIS Logo]({LOGO_URL})'

SEC_NO_TOC_POSTFIX = '{.unnumbered .unlisted}'

TOC_TEMPLATE = {
    1: '$sec_cnt_disp$ [$text$](#$label$)  ',
    2: '\t$sec_cnt_disp$ [$text$](#$label$)  ',
    3: '\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
    4: '\t\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
    5: '\t\t\t\t$sec_cnt_disp$ [$text$](#$label$)  ',
}

TOK_EG = "<a id='$thing$'></a>"
TOC_VERTICAL_SPACER = ''

CITE_COSMETICS_TEMPLATE = '**\\[**<span id="$label$" class="anchor"></span>**$code$\\]** $text$'

# Type declarations:
PathLike = str | pathlib.Path


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


def highlight_in_context(text_lines: list[str], pos: int, span: int = 15) -> None:
    """Show error line in context to help authors find the root cause of a problem."""
    for n in range(max(0, pos - span), min(pos + span, len(text_lines))):
        if n != pos:
            print(f'        {n:4} | {text_lines[n].rstrip(NL)}')
        else:
            print(f'HERE>>> {n:4} | {text_lines[n].rstrip(NL)} <<<HERE')
    print(DASH * 69)


def load_binder(cfg: Config, channel: str) -> list[PathLike]:
    """Either yield the seq of files to be concat or raise value error when files are not found."""
    ign = cfg.binder_ignores[channel]
    with open(pathlib.Path(cfg.etc_path) / cfg.binder, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
        bind_seq: list[PathLike] = [pathlib.Path(e.strip()) for e in handle if e.strip() and e.strip() not in ign]
    for resource in bind_seq:
        if not (pathlib.Path(cfg.source_path) / resource).is_file():
            raise ValueError(f"source file not found: '{resource}'")

    return bind_seq


def end_of_toc_in(text: str, marker: str) -> bool:
    """Detect the end of the table of contents placeholder.

    marker is the clean-md-start value (e.g. '# Introduction').
    By the time this runs, headings have been numbered (e.g. '# 1 Introduction'),
    so we match by presence of the heading word as a substring, not by prefix.
    """
    marker_text = marker.lstrip('#').strip()
    return text.startswith(HASH) and f' {marker_text}' in text


def dump_assembly(text_lines: list[str], to_path: Union[str, pathlib.Path]) -> None:
    """Write lines of text to file at path."""
    with open(to_path, 'wt', encoding=ENCODING, errors=ENC_ERRS) as resource:
        resource.write(''.join(text_lines))


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


def label_in(text: str) -> bool:
    """Detect if the line contains a label reference."""
    return '](#' in text


def example_local_number(text: str) -> int:
    """Return local example number from *Example N: line, or 0."""
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
    """Detect if the line contains a magic example token."""
    return example_local_number(text) > 0


def code_block_label_in(text: str) -> bool:
    """Detect if the line contains a code block section label."""
    return '(#' in text and ' # ' in text


def load(path: PathLike) -> dict[str, str]:
    """Load JSON file into dictionary."""
    with pathlib.Path(path).open('rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
        return json.load(handle)


def dump(data: dict[str, str], path: PathLike) -> None:
    """Dump dictionary into JSON file."""
    with open(path, 'wt', encoding=ENCODING, errors=ENC_ERRS) as handle:
        json.dump(data, handle, indent=2)


def detect_leftovers(records: list[str], marker: str = 'Found') -> list[tuple[int, str]]:
    """Detect unresolved citation and section references."""
    ref_defects = [(n, r) for n, r in enumerate(records) if CIT_OVER in r or SEC_OVER in r]
    if ref_defects:
        print(f'{marker} {len(ref_defects)} citation or section reference defects:')
        for slot, record in ref_defects:
            print(f'- "{record.strip()}" (slot {slot})')
            if CIT_TOO_DIRECT in record:
                print('  ! citation references should use indirect targets (reference section entries) not URLs')
    return ref_defects


def insert_any_citation(record: str) -> str:
    """Expand [cite](#label) placeholder or return record unchanged."""
    if label_in(record):
        for ref in CITE_REF_DETECT.finditer(record):
            if ref:
                found = ref.groupdict()
                trigger_text = found['text']
                if trigger_text != IS_CITE_REF:
                    raise RuntimeError(f'false positive cite ref in ({record.rstrip(NL)})')
                label = found['label']
                text = label.replace(';', ':')
                sem_ref = f'[cite](#{label})'
                evil_ref = f'\\[[{text}](#{label})\\]'
                record = record.replace(sem_ref, evil_ref)
    return record


def insert_any_section_reference(
    record: str,
    label_to_display: dict[str, str],
    display_to_text: dict[str, str],
    sec_ref_style: str,
) -> str:
    """Expand [sec](#label) placeholder or return record unchanged.

    Rendering depends on sec-ref-style from sections-config.yaml:
      number              → [1.2.3](#label)
      number-title        → [1.2.3 Heading Text](#label)
      section-sign-number → [§1.2.3](#label)
    """
    if not label_in(record):
        return record
    for ref in SEC_REF_DETECT.finditer(record):
        if ref:
            found = ref.groupdict()
            trigger_text = found['text']
            if trigger_text != IS_SEC_REF:
                raise RuntimeError(f'false positive sec ref in ({record.rstrip(NL)})')
            label = found['label']
            if label not in label_to_display:
                print(f'ERROR: in insert-any-section-reference ({record=})')
                print(f'ERROR-CONTEXT: {record=} - {trigger_text=}')
                print(f'ERROR-CONTEXT: {record=} - {label=}')
                for skey in label_to_display:
                    if skey.startswith(label[:len(label) // 2]):
                        print(f'DEBUG: - similar {skey=} exists')
                print(f'DEBUG: You may want to execute grep -n {label} src/*.md')
                raise RuntimeError(f'missing register label for sec ref in ({record.rstrip(NL)})')
            display = label_to_display[label]
            sem_ref = f'[sec](#{label})'
            if sec_ref_style == 'number-title':
                heading_text = display_to_text.get(display, '')
                link_text = f'{display} "{heading_text}"'.strip()
            elif sec_ref_style == 'section-sign-number':
                link_text = f'{PARA}{display}'
            else:  # 'number' is the default
                link_text = display
            evil_ref = f'[{link_text}](#{label})'
            record = record.replace(sem_ref, evil_ref)
    return record


def html_glossary(text_lines: list[str]) -> list[str]:
    """Glossary <dl> expansion: HTML needs raw HTML for rendering; PDF uses LaTeX definition lists."""
    patched = ['<dl>' + NL]
    in_definition = False
    for line in text_lines:
        if not in_definition and line.strip() and not line.startswith(COLON):
            in_definition = True
            term = line.strip()
            label = 'def:' + slugify(term)
            definition = ''
            continue
        if in_definition:
            if line.startswith(COLON):
                definition += line.lstrip(COLON).strip()
                definition = (
                    definition.replace('_Examples_', '<em>Examples</em>')
                    .replace('_Example_', '<em>Example</em>')
                    .replace('**Notes**', '<strong>Notes</strong>')
                    .replace('**Note**', '<strong>Note</strong>')
                )
                continue
            if line.strip():
                definition += NL + ' ' * 6 + line.strip()
                definition = (
                    definition.replace('_Examples_', '<em>Examples</em>')
                    .replace('_Example_', '<em>Example</em>')
                    .replace('**Notes**', '<strong>Notes</strong>')
                    .replace('**Note**', '<strong>Note</strong>')
                )
                continue
            if not line.strip():
                for ref in MD_REF_DETECT.finditer(definition):
                    if ref:
                        found = ref.groupdict()
                        ref_text = found['text']
                        ref_anchor = found['target']
                        md_ref = f'[{ref_text}](#{ref_anchor})'
                        html_ref = f'<a href="#{ref_anchor}">{ref_text}</a>'
                        definition = definition.replace(md_ref, html_ref)
                item = f'{" " * 2}<dt id="{label}">{term}</dt>\n{" " * 2}<dd>{definition}</dd>\n'
                in_definition = False
                patched.append(item)
                continue
        else:
            patched.append(line)
    patched.append('</dl>' + NL + NL)

    return list(patched)


def citations(text_lines: list[str], cfg: Config) -> list[str]:
    """Process citation data file lines."""
    patched = []
    in_citation = False
    in_fenced_block = False
    for line in text_lines:
        if line.startswith(FENCED_BLOCK_FLIP_FLOP):
            in_fenced_block = not in_fenced_block
        if any(line.startswith(e) for e in cfg.citation_skip_prefixes) and not in_fenced_block:
            patched.append(line)
            continue
        if line.strip() and not line.startswith(COLON):
            in_citation = True
            code = line.strip()
            label = code.replace(COLON, SEMI).rstrip(TM)
            text = ''
            continue
        if in_citation:
            if line.startswith(COLON):
                text += line.lstrip(COLON).strip()
                continue
            if line.strip():
                text += SPACE + line.strip()
                continue
            if not line.strip():
                citation = (
                    CITE_COSMETICS_TEMPLATE.replace('$label$', label)
                    .replace('$code$', code)
                    .replace('$text$', text)
                    + NL
                )
                in_citation = False
                patched.append(citation)
                patched.append(line)
                continue
        else:
            patched.append(line)
    return list(patched)



def splice_sources(bind_seq: list[PathLike], chn: str, cfg: Config) -> tuple[list[str], list[str]]:
    """Channel specific splice yielding two list: (1) lines of all sources and (2) source of same-index line."""
    documents: list[tuple[list[str], str]] = []
    for resource in bind_seq:
        with open(pathlib.Path(cfg.source_path) / resource, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
            raw = handle.readlines()
        if raw and raw[-1] != NL:
            raw.append(NL)
        documents.append((raw, str(resource)))

    for slot, (body, source) in enumerate(documents):
        if source in cfg.citation_sources:
            documents[slot] = (citations(body, cfg), source)
        elif chn == HTML and source in cfg.glossary_sources:
            documents[slot] = (html_glossary(body), source)

    # Flatten to a single line sequence with per-line source tracking
    the_lines: list[str] = []
    sources_of_lines: list[str] = []
    for body, source in documents:
        for line in body:
            the_lines.append(line)
            sources_of_lines.append(source)

    print(f'INFO: Loaded {len(bind_seq)} source files → {len(the_lines)} lines total')
    return the_lines, sources_of_lines


def parse(args: list[str]) -> tuple[bool, bool, PathLike, str]:
    """Parse the command line arguments received."""
    work_left = True
    dbg = DEBUG
    cfg_path = DEFAULT_CONFIG_PATH
    chn = HTML
    for slot, arg in enumerate(args):
        if arg.lower() in ('-h', '--help', '/h', '-?'):
            print('USAGE: bin/assemble.py [-d|--debug] [-c path|--config path] [-t format|--target format]')
            print(f'       known targets: [{", ".join(KNOWN_CHANNELS)}], default: {HTML}')
            work_left = False
    if work_left:
        for slot, arg in enumerate(args):
            if arg in ('-d', '--debug'):
                dbg = True
                del args[slot]
                break
        for slot, arg in enumerate(args):
            if arg in ('-c', '--config'):
                cfg_path = pathlib.Path(args[slot + 1])
                del args[slot + 1]
                del args[slot]
                break
        for slot, arg in enumerate(args):
            if arg in ('-t', '--target'):
                chn = args[slot + 1].lower()
                del args[slot + 1]
                del args[slot]
                if chn not in KNOWN_CHANNELS:
                    raise ValueError(f'unknown target / channel {chn=} (not in [{", ".join(KNOWN_CHANNELS)}])')
                break
        if args:
            print(f'WARN: Unprocessed {args=}')

    return work_left, dbg, cfg_path, chn


def main(args: list[str]) -> int:
    """Drive the assembly."""
    need_processing, debug, config_path, channel = parse(args)
    if not need_processing:
        return 0

    config = Config(str(config_path))
    binder = load_binder(config, channel)

    etc_path = pathlib.Path(config.etc_path)
    sec_ref_style: str = config.section_reference_style
    clean_md_start: str = config.first_authored_section
    track_examples: bool = bool(config.track_examples)

    display_from: dict[str, str] = load(etc_path / config.section_label_to_display_db)
    display_to_text: dict[str, str] = load(etc_path / config.section_display_to_text_db)
    # label_from: dict[str, str] = load(etc_path / config.section_display_to_label_db)
    eg_global_from: dict[str, str] = load(etc_path / config.example_local_to_global_db) if track_examples else {}

    sec_label_text: dict[str, str] = {}
    section_display_to_label: dict[str, str] = {}

    # Assemble source files into flat line list, expanding citations and glossary.
    lines, line_source = splice_sources(binder, channel, config)

    # Heading scan: build TOC, track section context per line, rewrite heading lines.
    lvl_min, lvl_sup = 1, 7
    sec_cnt = {f'{H * level} ': 0 for level in range(lvl_min, lvl_sup)}
    sec_lvl = {f'{H * level} ': level for level in range(lvl_min, lvl_sup)}
    lvl_sec = {level: f'{H * level} ' for level in range(lvl_min, lvl_sup)}
    cur_lvl = sec_lvl[f'{H} ']
    tic_toc = [TOC_HEADER]
    mint = []
    did_appendix_sep = False
    is_appendix = False
    clean_headings = False
    current_cs = None
    cs_of_slot: list[Union[None, str]] = [None for _ in lines]
    in_fenced_block = False

    for slot, line in enumerate(lines):
        # PDF: replace remote logo URL with local copy for offline rendering
        if channel == PDF and line.rstrip() == TOP_LOGO_LINE:
            lines[slot] = line.replace(LOGO_URL, LOGO_LOCAL_PATH, 1)
            line = lines[slot]

        if line.startswith(FENCED_BLOCK_FLIP_FLOP):
            in_fenced_block = not in_fenced_block
        if line.startswith(clean_md_start):
            clean_headings = True
        cs_of_slot[slot] = current_cs
        for tag in sec_cnt:
            if line.startswith(tag) and clean_headings and not in_fenced_block:
                text_plus = line.split(tag, 1)[1].rstrip()
                nxt_lvl = sec_lvl[tag]
                level = nxt_lvl
                if text_plus.startswith('Appendix '):
                    # top-level appendix heading: "Appendix A. Acknowledgments"
                    appr = text_plus.split(SPACE)[1].rstrip(FULL_STOP)
                    sec_cnt_disp = f'Appendix {appr}.'
                    text_plus = text_plus[len(sec_cnt_disp):].lstrip(SPACE)
                    is_appendix = True
                elif is_appendix:
                    match = APPENDIX_INNER_PATTERN.match(text_plus)
                    if match:
                        # inner appendix heading with letter-number prefix: "C.1 File Size"
                        sec_cnt_disp = match.group('display')
                        if not sec_cnt_disp.endswith(FULL_STOP):
                            sec_cnt_disp += FULL_STOP
                        text_plus = match.group('rest')
                    else:
                        # unnumbered sub-heading inside appendix — auto-number
                        sec_cnt[tag] += 1
                        if nxt_lvl < cur_lvl:
                            for lvl in range(nxt_lvl + 1, lvl_sup):
                                sec_cnt[lvl_sec[lvl]] = 0
                        sec_cnt_disp_vec = []
                        for s_tag, cnt in sec_cnt.items():
                            if cnt == 0:
                                raise RuntimeError(
                                    f'counting is hard: {sec_cnt} at {tag} for {slot}:{line.rstrip(NL)}'
                                    f' fron source {line_source[slot]}'
                                )
                            sec_cnt_disp_vec.append(str(cnt))
                            if s_tag == tag:
                                break
                        sec_cnt_disp = FULL_STOP.join(sec_cnt_disp_vec)
                        if FULL_STOP not in sec_cnt_disp:
                            sec_cnt_disp += FULL_STOP
                else:
                    # normal numeric auto-counter
                    sec_cnt[tag] += 1
                    if nxt_lvl < cur_lvl:
                        for lvl in range(nxt_lvl + 1, lvl_sup):
                            sec_cnt[lvl_sec[lvl]] = 0
                    sec_cnt_disp_vec = []
                    for s_tag, cnt in sec_cnt.items():
                        if cnt == 0:
                            raise RuntimeError(
                                f'counting is hard: {sec_cnt} at {tag} for {slot}:{line.rstrip(NL)}'
                            )
                        sec_cnt_disp_vec.append(str(cnt))
                        if s_tag == tag:
                            break
                    sec_cnt_disp = FULL_STOP.join(sec_cnt_disp_vec)
                    if FULL_STOP not in sec_cnt_disp:
                        sec_cnt_disp += FULL_STOP
                # manage label
                if TOK_LAB in text_plus:
                    label = text_plus.split(TOK_LAB, 1)[1].rstrip(CB_END).strip()
                    text = text_plus.split(TOK_LAB, 1)[0].rstrip(SPACE)
                else:
                    text = text_plus.rstrip(SPACE)
                    label = slugify(text)
                clean_sec_cnt_disp = sec_cnt_disp.rstrip(FULL_STOP)
                sec_label_text[label] = clean_sec_cnt_disp
                section_display_to_label[clean_sec_cnt_disp] = label
                # Build heading line per channel:
                # HTML: inject <a id> anchor + section number prefix on every heading.
                # PDF:  appendix headings get section number + {.unnumbered #label} pandoc attrs;
                #       top-level appendix headings additionally get \newpage before them;
                #       normal headings are emitted as-is (LaTeX auto-numbers them).
                if channel == HTML:
                    line = tag + text + ' ' + TOK_SEC.replace('$thing$', label)
                    line = line.replace(tag, f'{tag}{sec_cnt_disp} ', 1) + NL
                elif channel == PDF:
                    if is_appendix:
                        if level == 1:
                            # inject LaTeX page break before each top-level appendix heading
                            lines[slot - 1] = lines[slot - 1] + NL + r'\newpage' + NL
                        line = f'{tag}{sec_cnt_disp} {text} {{.unnumbered #{label}}}\n'
                    else:
                        line = tag + text + NL
                else:
                    print(f'WARN: heading builder for target / channel {channel} not yet implemented.')

                lines[slot] = line
                if not is_appendix:
                    cur_lvl = nxt_lvl
                if not did_appendix_sep and is_appendix:
                    tic_toc.append(TOC_VERTICAL_SPACER)
                    did_appendix_sep = True
                toc_template = TOC_TEMPLATE[cur_lvl if not is_appendix else level]
                extended = 0
                if is_appendix:
                    extended = 2 if set(sec_cnt_disp).intersection('0123456789') else 1
                    if extended == 2:
                        extended = sec_cnt_disp.count(DOT) + 1
                if '{#' in text and label in text:
                    debug and print(f'{slot=}: Fixed ToC for {line=}')
                    text = text.replace('{#' + label + '}', '')
                tic_toc.append(
                    toc_template.replace('$sec_cnt_disp$', sec_cnt_disp)
                    .replace('$text$', text)
                    .replace('$label$', label)
                )
                mint.append([list(sec_cnt.values()), extended, sec_cnt_disp, text, label])
                current_cs = label
                cs_of_slot[slot] = current_cs  # type: ignore

            # MAYBE_SEC_NO_TOC_BEFORE_INTRODUCTION
            # Only meaningful for PDF/LaTeX; HTML TOC is built by toccata.py independently.
            if line.startswith(tag) and not clean_headings and channel == PDF:
                lines[slot] = line.rstrip() + SEC_NO_TOC_POSTFIX + NL

    # Process citation refs
    for slot, line in enumerate(lines):
        completed = insert_any_citation(line)
        if line != completed:
            lines[slot] = completed

    # Monkey patch away some poor people HTML workarounds from PDF channel
    if channel == PDF:
        for slot, line in enumerate(lines):
            if line.startswith('*Figure '):
                lines[slot] = f'{HC_BEG}{line.rstrip(NL)}{HC_END}{NL}'
            elif line.startswith('&nbsp;&nbsp;- '):
                lines[slot] = line.replace('&nbsp;&nbsp;- ', '  - ')
            elif line.startswith(f'{FENCED_BLOCK_FLIP_FLOP}yaml <!--'):
                lines[slot] = f'{FENCED_BLOCK_FLIP_FLOP}yaml'

    # Process example refs
    for slot, line in enumerate(lines):
        if example_in(line):
            num = example_local_number(line)
            section = cs_of_slot[slot]
            magic_label = f'{section}-eg-{num}'
            pl_anchor = TOK_EG.replace('$thing$', magic_label)
            line = line.rstrip(NL) + pl_anchor + NL
            # UX bonus: anchor keyed by section display number
            try:
                sec_disp_context_part = display_from[section]  # type: ignore
            except KeyError as err:
                print(f'ERROR: {slot=} in example-refs-processing ({err})')
                print(f'ERROR-CONTEXT: {slot=} - {line=}')
                print(f'ERROR-CONTEXT: {slot=} - {section=}')
                for skey in display_from:
                    if skey.startswith(section[:len(section) // 2]):  # type: ignore
                        print(f'DEBUG: - similar {skey=} exists')
                return 1
            sec_disp = 'sec-' + sec_disp_context_part.replace(FULL_STOP, '-')  # type: ignore
            sec_disp_num_label = f'{sec_disp}-eg-{num}'
            sec_disp_num_anchor = TOK_EG.replace('$thing$', sec_disp_num_label)
            line = line.rstrip(NL) + sec_disp_num_anchor + NL
            # Global counter anchor
            try:
                global_example_num = eg_global_from[magic_label]
            except KeyError as err:
                print(f'ERROR: {slot=} in example-refs-global-counter-lookup ({err})')
                print(f'ERROR-CONTEXT: {slot=} - {line=}')
                print(f'ERROR-CONTEXT: {slot=} - {magic_label=}')
                for ekey in eg_global_from:
                    if ekey.startswith(magic_label[:len(magic_label) // 2]):
                        print(f'DEBUG: - similar {ekey=} exists')
                return 1
            global_example_num_label = f'example-{global_example_num}'
            global_example_num_anchor = TOK_EG.replace('$thing$', global_example_num_label)
            line = line.rstrip(NL) + global_example_num_anchor + NL
            lines[slot] = line

        if label_in(line):
            for ref in EG_REF_DETECT.finditer(line):
                if ref:
                    found = ref.groupdict()
                    trigger_text = found['text']
                    if trigger_text != IS_EG_REF:
                        raise RuntimeError(f'false positive example ref in ({line.rstrip(NL)})')
                    label = found['label']
                    sem_ref = f'[eg](#{label})'
                    if '-eg-' not in label:
                        raise RuntimeError(f'bad label for example in ({line.rstrip(NL)})')
                    section, number = label.split('-eg-', 1)
                    if section == cs_of_slot[slot]:
                        debug and print(f'detected local reference for {label} in ({line.rstrip(NL)})')
                        evil_ref = f'\\[[{number}](#{label})\\]'
                    else:
                        debug and print(f'detected remote reference for {label} in ({line.rstrip(NL)})')
                        sec_disp = display_from[section]
                        if sec_ref_style == 'section-sign-number':
                            sec_disp = PARA + sec_disp
                        evil_ref = f'\\[[{number} (of section {sec_disp})](#{label})\\]'
                    line = line.replace(sem_ref, evil_ref)
                    debug and print(line.rstrip(NL))
                    lines[slot] = line

    # Process section refs
    for slot, line in enumerate(lines):
        completed = insert_any_section_reference(line, display_from, display_to_text, sec_ref_style)
        if line != completed:
            lines[slot] = completed

    # Process code block label references
    for slot, line in enumerate(lines):
        if code_block_label_in(line):
            for ref in SEC_LABEL_BRACKET_CB_DETECT.finditer(line):
                if ref:
                    found = ref.groupdict()
                    value = found['value']
                    if not value or value not in display_from:
                        continue
                    label = found['label']
                    display = display_from[value]
                    if sec_ref_style == 'section-sign-number':
                        display = PARA + display
                    line = line.replace(label, display)
                    lines[slot] = line
            for ref in SEC_LABEL_FREE_CB_DETECT.finditer(line):
                if ref:
                    found = ref.groupdict()
                    value = found['value']
                    if not value or value not in display_from:
                        continue
                    label = found['label']
                    display = display_from[value]
                    if sec_ref_style == 'section-sign-number':
                        display = PARA + display
                    line = line.replace(label, display)
                    lines[slot] = line

    # HTML only: wrap special PDF channel only commands in HTML comments
    if channel == HTML:
        for slot, line in enumerate(lines):
            if any(line.startswith(cmd) for cmd in (r'\columns', r'\scale')):
                lines[slot] = f'{HC_BEG}{line.rstrip(NL)}{HC_END}{NL}'

    # HTML only: inject table of contents before the Introduction heading
    if channel == HTML:
        tic_toc.append(YAML_X_SEP)
        tic_toc.append(NL)
        for slot, line in enumerate(lines):
            if end_of_toc_in(line, clean_md_start):
                lines[slot] = NL.join(tic_toc) + line
                break

    # Remove trailing blank lines
    while lines[-1] == NL:
        del lines[-1]

    # Detect and attempt to fix leftover unresolved references
    ref_defects = detect_leftovers(lines, marker='Found')
    if ref_defects:
        print(f'+ processing {len(ref_defects)} text lines for citation or section reference insertions ...')
        rem_defects = []
        for slot, record in ref_defects:
            completed = insert_any_citation(record)
            if record != completed:
                lines[slot] = completed
            else:
                rem_defects.append((slot, record))
        for slot, record in rem_defects:
            completed = insert_any_section_reference(record, display_from, display_to_text, sec_ref_style)
            if record != completed:
                lines[slot] = completed
        ref_defects = detect_leftovers(lines, marker='Still found')
        if ref_defects:
            pass  # return 1

    build_path = pathlib.Path(config.build_path)
    build_path.mkdir(parents=True, exist_ok=True)
    if channel == HTML:
        dump_assembly(lines, build_path / 'tmp.md')
        with open(build_path / 'toc-mint.json', 'wt', encoding=ENCODING, errors=ENC_ERRS) as handle:
            json.dump(mint, handle, indent=2)
    elif channel == PDF:
        dump_assembly(lines, build_path / 'pdf.md')
        # toc-mint.json not written: liitos/LaTeX handles the TOC natively
    else:
        print(f'WARN: dump assembly for target / channel {channel} not yet implemented.')

    if DUMP_LUT:
        dump(section_display_to_label, etc_path / config.section_display_to_label_db)
        section_label_to_display = dict(sorted((label, disp) for disp, label in section_display_to_label.items()))
        dump(section_label_to_display, etc_path / config.section_label_to_display_db)

    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
