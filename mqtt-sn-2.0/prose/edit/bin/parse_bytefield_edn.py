#! /usr/bin/env python
"""Parse bytefield-svg .edn packet-diagram specs implemented in a clojure based DSL into raw JSON instances.

This is prototype 2 of 2 for the packet-dictionary exploration (see
collect_packet_specs.py for prototype 1, which finds and orders the .edn files).

NOT a general Clojure reader/evaluator.  A survey across every .edn file in
src/images/packet/ (2026-10-13) found exactly one piece of real dynamism anywhere in
the corpus -- a byte-for-byte identical boilerplate block (a `row-header-fn` defn plus
a `doseq` that draws the "7,6,5,4,3,2,1,0" bit-index header row) -- copy-pasted in
every file with zero variation.  Every actual packet-content line is a flat
`draw-box`/`draw-gap` call built from a small closed vocabulary: a string or (text
...) label, and an attrs argument that is always a bare :keyword (resolved via
defattrs), a {:span N ...} map, a vector combining either, or nil.  So this reads
exactly that subset -- lists, vectors, maps, strings, keywords, symbols, numbers, line
comments, and the one #"..." regex-literal reader form -- and raises rather than
guesses on anything outside it (an unrecognized defn/doseq shape, an unexpected form).

Output per .edn file: {"source", "defs", "attrs_registry", "items": [...]}, where each
item is {"kind": "box"|"gap", "label": str, "label_annotations": [...], "attrs": {...}}
-- a deliberately low-interpretation, close-to-source capture.  Byte/row grouping and
the optional/group-header semantics implied by :bg-lightgray/:bg-mediumgray are a
SEPARATE, later transformation -- not done here, so the raw capture stays inspectable
and the schema can be built iteratively against real instances rather than guessed
up front.

Usage: bin/parse_bytefield_edn.py src/images/packet/connect-packet-diagram.edn
       bin/parse_bytefield_edn.py --manifest build/packet-spec-manifest.json --out-dir build/packet-specs
"""
import argparse
import json
import pathlib
import re
import sys
from dataclasses import dataclass, field
from typing import Any

ENCODING = 'utf-8'

_TOKEN_RE = re.compile(
    r"""
      (?P<ws>\s+)
    | (?P<comment>;;?[^\n]*)
    | (?P<regex>\#"(?:[^"\\]|\\.)*")
    | (?P<string>"(?:[^"\\]|\\.)*")
    | (?P<lparen>\()
    | (?P<rparen>\))
    | (?P<lbracket>\[)
    | (?P<rbracket>\])
    | (?P<lbrace>\{)
    | (?P<rbrace>\})
    | (?P<keyword>:[A-Za-z0-9_+./*!?<>=-]+)
    | (?P<atom>[A-Za-z0-9_+./*!?<>=-]+)
    """,
    re.VERBOSE,
)


class Keyword(str):
    """A Clojure :keyword -- distinct from a plain string or bare symbol."""

    def __repr__(self) -> str:
        return f':{str.__str__(self)}'


class Symbol(str):
    """A bare Clojure symbol (unquoted name) -- distinct from a string literal."""

    def __repr__(self) -> str:
        return f'sym:{str.__str__(self)}'


class ParseError(Exception):
    pass


def tokenize(text: str) -> list[str]:
    tokens = []
    pos = 0
    while pos < len(text):
        m = _TOKEN_RE.match(text, pos)
        if not m:
            raise ParseError(f'unrecognized character {text[pos]!r} at offset {pos}')
        pos = m.end()
        kind = m.lastgroup
        if kind in ('ws', 'comment'):
            continue
        tokens.append((kind, m.group()))
    return tokens


def read_forms(tokens: list[tuple[str, str]]) -> list[Any]:
    """Read all top-level forms from a flat token stream."""
    pos = 0

    def read_one() -> Any:
        nonlocal pos
        kind, text = tokens[pos]
        if kind == 'lparen':
            pos += 1
            return read_seq('rparen', list)
        if kind == 'lbracket':
            pos += 1
            return read_seq('rbracket', Vector)
        if kind == 'lbrace':
            pos += 1
            items = read_seq('rbrace', list)
            if len(items) % 2 != 0:
                raise ParseError(f'map literal with odd element count: {items!r}')
            return dict(zip(items[0::2], items[1::2]))
        if kind == 'string':
            pos += 1
            return _unescape(text[1:-1])
        if kind == 'regex':
            pos += 1
            return _unescape(text[2:-1])
        if kind == 'keyword':
            pos += 1
            return Keyword(text[1:])
        if kind == 'atom':
            pos += 1
            if text == 'nil':
                return None
            if text == 'true':
                return True
            if text == 'false':
                return False
            try:
                return int(text)
            except ValueError:
                pass
            try:
                return float(text)
            except ValueError:
                pass
            return Symbol(text)
        raise ParseError(f'unexpected token {kind}:{text!r} at position {pos}')

    def read_seq(close_kind: str, ctor):
        nonlocal pos
        items = []
        while True:
            if pos >= len(tokens):
                raise ParseError(f'unexpected end of input, expected {close_kind}')
            kind, _text = tokens[pos]
            if kind == close_kind:
                pos += 1
                return ctor(items)
            items.append(read_one())

    forms = []
    while pos < len(tokens):
        forms.append(read_one())
    return forms


class Vector(list):
    """A Clojure [vector] -- distinct from a (list) form."""


def _unescape(s: str) -> str:
    return s.replace('\\"', '"').replace('\\n', '\n').replace('\\\\', '\\')


# ---------------------------------------------------------------------------
# Interpretation: defs / defattrs / draw-box / draw-gap, nothing else.
# ---------------------------------------------------------------------------

_KNOWN_ROW_HEADER_FN_BODY_HINT = 'addr-label'


def collect_keywords(value: Any, registry_keywords: dict[str, list[str]] | None = None) -> list[str]:
    """Collect the :keyword name(s) referenced in an attrs argument, fully expanded
    through composite defattrs names, e.g. [:bg-mediumgray :field-name] ->
    ['bg-mediumgray', 'field-name'], and :optional-byte-left (itself defined as
    [:bg-lightgray :byte-left]) -> ['optional-byte-left', 'bg-lightgray', 'byte-left'].

    Expansion matters: the corpus uses BOTH the vector form [:bg-lightgray :byte] and
    a composite single name (:optional-byte) for the same "optional field" concept --
    checking for literal 'bg-lightgray' in an item's own attrs_keywords would silently
    miss every item written the composite way.

    Kept separate from the flattened CSS-ish attrs dict (resolve_attrs) so later
    semantic classification (optional field / group header) can match on the STABLE
    symbolic defattrs name an author actually wrote, rather than on a flattened fill
    color -- a hex value is a rendering detail of what the name means today, not the
    thing that means it (confirmed identical across the corpus right now, but
    matching the name is the non-fragile choice regardless).
    """
    registry_keywords = registry_keywords or {}
    if isinstance(value, Keyword):
        name = str(value)
        return [name] + list(registry_keywords.get(name, []))
    if isinstance(value, Vector):
        out: list[str] = []
        for elem in value:
            out.extend(collect_keywords(elem, registry_keywords))
        return out
    return []


def resolve_attrs(value: Any, registry: dict[str, dict], warnings: list[str] | None = None) -> dict:
    """Flatten a :keyword / {map} / [vector of either] / nil attrs argument.

    A keyword not found in the local defattrs registry is a bytefield-svg library
    built-in (e.g. :bold, :mono) rather than a bug in the source file -- there is no
    local definition to resolve it against, so it's kept as an opaque pass-through
    tag ({"_keyword": name}) with a warning, instead of failing the whole parse.
    """
    if value is None:
        return {}
    if isinstance(value, Keyword):
        if value in registry:
            return dict(registry[value])
        if warnings is not None:
            warnings.append(f'attrs keyword :{value} has no local defattrs -- treated as a library built-in, kept opaque')
        return {'_keyword': str(value)}
    if isinstance(value, dict):
        return {str(k): v for k, v in value.items()}
    if isinstance(value, Vector):
        out: dict = {}
        for elem in value:
            out.update(resolve_attrs(elem, registry, warnings))
        return out
    raise ParseError(f'unrecognized attrs shape: {value!r}')


def resolve_label(value: Any) -> dict:
    """Flatten a bare string or (text "..." :style [...]) label form.

    Returns {"text": "<plain-concatenated text>", "annotations": [{"style", "text"}]}
    -- "annotations" holds any non-default-style spans (e.g. the italic "(AM=F+1 or F)
    -- only present when ..." conditional notes), kept separate from the main label
    rather than mashed into one string, since that conditional text is exactly the
    kind of structured fact a packet dictionary should keep queryable.
    """
    if isinstance(value, str) and not isinstance(value, (Keyword, Symbol)):
        return {'text': value, 'annotations': []}
    if isinstance(value, list) and value and isinstance(value[0], Symbol) and value[0] == 'text':
        parts = value[1:]
        main_text_chunks: list[str] = []
        annotations: list[dict] = []
        current_style = 'plain'
        i = 0
        while i < len(parts):
            part = parts[i]
            if isinstance(part, Keyword):
                current_style = str(part)
                i += 1
                continue
            if isinstance(part, Vector):
                # [:style "text" ...] or [:style [:style2 "text"]] -- nested span
                style = str(part[0]) if part and isinstance(part[0], Keyword) else current_style
                text_piece = _flatten_text_vector(part[1:])
                annotations.append({'style': style, 'text': text_piece})
                i += 1
                continue
            if isinstance(part, str):
                if current_style == 'plain':
                    main_text_chunks.append(part)
                else:
                    annotations.append({'style': current_style, 'text': part})
                i += 1
                continue
            i += 1
        return {'text': ''.join(main_text_chunks), 'annotations': annotations}
    raise ParseError(f'unrecognized label shape: {value!r}')


def _flatten_text_vector(parts: list) -> str:
    chunks = []
    for p in parts:
        if isinstance(p, str) and not isinstance(p, Keyword):
            chunks.append(p)
        elif isinstance(p, Vector):
            chunks.append(_flatten_text_vector(list(p)))
    return ''.join(chunks)


@dataclass
class EdnInstance:
    source: str
    defs: dict = field(default_factory=dict)
    attrs_registry: dict = field(default_factory=dict)
    attrs_registry_keywords: dict = field(default_factory=dict)  # internal only, not in to_json()
    items: list = field(default_factory=list)
    warnings: list = field(default_factory=list)

    def to_json(self) -> dict:
        return {
            'source': self.source,
            'defs': self.defs,
            'attrs_registry': {str(k): v for k, v in self.attrs_registry.items()},
            'items': self.items,
            'warnings': self.warnings,
        }


def interpret(forms: list, source: str) -> EdnInstance:
    inst = EdnInstance(source=source)

    for form in forms:
        if not isinstance(form, list) or not form or not isinstance(form[0], Symbol):
            raise ParseError(f'unexpected top-level form: {form!r}')
        head = str(form[0])

        if head == 'def':
            _, name, value = form
            inst.defs[str(name)] = value
            continue

        if head == 'defattrs':
            _, name, value = form
            if not isinstance(name, Keyword):
                raise ParseError(f'defattrs name must be a keyword: {form!r}')
            inst.attrs_registry[str(name)] = resolve_attrs(value, inst.attrs_registry, inst.warnings)
            inst.attrs_registry_keywords[str(name)] = collect_keywords(value, inst.attrs_registry_keywords)
            continue

        if head == 'defn':
            name = str(form[1])
            if name != 'row-header-fn':
                inst.warnings.append(f'unrecognized defn {name!r} -- not evaluated, body ignored')
            continue

        if head == 'doseq':
            body_text = json.dumps(form[1:], default=repr)
            if _KNOWN_ROW_HEADER_FN_BODY_HINT not in body_text and '7,6,5,4,3,2,1,0' not in body_text:
                inst.warnings.append('unrecognized doseq shape -- not evaluated, body ignored')
            continue

        if head in ('draw-box', 'draw-gap'):
            label_form = form[1] if len(form) > 1 else None
            attrs_form = form[2] if len(form) > 2 else None
            label = resolve_label(label_form) if label_form is not None else {'text': '', 'annotations': []}
            attrs = resolve_attrs(attrs_form, inst.attrs_registry, inst.warnings)
            attrs_keywords = collect_keywords(attrs_form, inst.attrs_registry_keywords)
            inst.items.append({
                'kind': 'box' if head == 'draw-box' else 'gap',
                'label': label['text'],
                'label_annotations': label['annotations'],
                'attrs': attrs,
                'attrs_keywords': attrs_keywords,
            })
            continue

        if head == 'draw-bottom':
            continue

        raise ParseError(f'unrecognized top-level form head: {head!r} in {form!r}')

    return inst


def parse_file(path: pathlib.Path) -> EdnInstance:
    text = path.read_text(encoding=ENCODING)
    tokens = tokenize(text)
    forms = read_forms(tokens)
    return interpret(forms, source=str(path))


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('edn_files', nargs='*', help='one or more .edn files to parse')
    parser.add_argument('--manifest', help='packet-spec-manifest.json from collect_packet_specs.py; parses every entry with an edn_path')
    parser.add_argument('--out-dir', default=None, help='write one <stem>.json per input next to parsing, instead of stdout')
    args = parser.parse_args()

    edit_root = pathlib.Path(__file__).resolve().parent.parent

    paths: list[pathlib.Path] = [pathlib.Path(p) for p in args.edn_files]
    if args.manifest:
        manifest = json.loads(pathlib.Path(args.manifest).read_text(encoding=ENCODING))
        paths.extend(edit_root / 'src' / e['edn_path'] for e in manifest if e.get('edn_path'))

    if not paths:
        sys.exit('no input: give .edn file(s) or --manifest')

    out_dir = pathlib.Path(args.out_dir).resolve() if args.out_dir else None
    if out_dir:
        out_dir.mkdir(parents=True, exist_ok=True)

    total_warnings = 0
    for p in paths:
        try:
            inst = parse_file(p)
        except ParseError as exc:
            print(f'FAILED  {p}: {exc}', file=sys.stderr)
            continue
        total_warnings += len(inst.warnings)
        payload = json.dumps(inst.to_json(), indent=2)
        if out_dir:
            (out_dir / (p.stem + '.json')).write_text(payload + '\n', encoding=ENCODING)
            flag = f'  [{len(inst.warnings)} warning(s)]' if inst.warnings else ''
            print(f'{p.stem}: {len(inst.items)} item(s){flag}')
        else:
            print(payload)

    if total_warnings:
        print(f'\n{total_warnings} total warning(s) -- review before trusting these instances', file=sys.stderr)


if __name__ == '__main__':
    main()
