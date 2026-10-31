#! /usr/bin/env python
"""Records -> views for MQTT-SN v2.0: normative content is authored as records, prose parts and artifacts are derived.

  spec_records.py derive    write every view (statement marks and Appendix B, packet diagrams, dictionary, ...)
  spec_records.py check     derive in memory and report every view that differs from the tree (exit 1 if any)
  spec_records.py kaitai-test DIR   parse every packet vector with the parsers compiled from ../share/kaitai/ into DIR
  spec_records.py migrate   one-off seeding of records from today's prose (refuses to overwrite records)

Records live in records/ (see records/README.md); views are files in src/ (whole files or marked parts of them),
views/ (for editors and reviewers) and ../share/ (published artifacts). Requires PyYAML.
"""

import argparse
import json
import pathlib
import re
import sys
from typing import Any

import yaml  # type: ignore[import-untyped]

ENCODING = 'utf-8'
EDIT = pathlib.Path(__file__).resolve().parents[1]
SRC = EDIT / 'src'
RECORDS = EDIT / 'records'
VIEWS = EDIT / 'views'

Views = dict[pathlib.Path, str]

# -- YAML ---------------------------------------------------------------------------------------------


class _Dumper(yaml.SafeDumper):
    pass


def _str(dumper: yaml.SafeDumper, value: str) -> yaml.ScalarNode:
    return dumper.represent_scalar('tag:yaml.org,2002:str', value, style='|' if '\n' in value else None)


_Dumper.add_representer(str, _str)


def dump(path: pathlib.Path, data: Any, header: str = '') -> None:
    text = header + yaml.dump(data, Dumper=_Dumper, sort_keys=False, allow_unicode=True, width=1000)
    assert yaml.safe_load(text) == data, path
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding=ENCODING)


def load(path: pathlib.Path) -> Any:
    return yaml.safe_load(path.read_text(encoding=ENCODING))


# -- Step 1: normative statements ---------------------------------------------------------------------

APPENDIX = SRC / 'mand-norm-stmts-00.md'
NB_HYPHEN = '‑'
STATEMENT_ID = r'MQTT-SN-[0-9]+(?:\.[0-9]+)*-[0-9]+'
# A rendered mark (any variant seen in the prose) or the short form an editor writes: «MQTT-SN-3.1.2-1»
MARK = re.compile(
    rf'«<mark title="Requirement (?P<id>{STATEMENT_ID})"><a name="(?P=id)"></a>.*?</mark>»(?:\[[^\]]*\]\([^)]*\))?'
    rf'|«(?P<short>{STATEMENT_ID})»',
    re.S,
)
EPHEMERAL = re.compile(r'<mark title="Ephemeral region marking">(.*?)</mark>', re.S)
APPENDIX_ROW = re.compile(rf'^\| <a name="tab-({STATEMENT_ID})"></a>.*$', re.M)


def load_statements() -> dict[str, dict[str, Any]]:
    """Statement id -> record (with `file_`: the prose file the statement belongs to), refusing duplicate ids."""
    out: dict[str, dict[str, Any]] = {}
    for path in sorted((RECORDS / 'statements').glob('*.yaml')):
        for rec in load(path)['statements']:
            if rec['id'] in out:
                sys.exit(f'statement {rec["id"]} is defined twice ({path.name})')
            out[rec['id']] = rec | {'file_': path.stem + '.md'}
    return out


def render_mark(rec: dict[str, Any]) -> str:
    sid = rec['id']
    return f'«<mark title="Requirement {sid}"><a name="{sid}"></a>{rec["text"]}</mark>»[{sid.replace("-", NB_HYPHEN)}](#tab-{sid})'


def appendix_text(rec: dict[str, Any]) -> str:
    """The statement as Appendix B shows it: one line, a full sentence (`standalone` where the mark is a fragment)."""
    text = ' '.join((rec.get('standalone') or rec['text']).split())
    text = EPHEMERAL.sub(r'\1', text)  # an editor's working highlight is not part of the statement
    return text if text.endswith(('.', ':', '?', '!')) else text + '.'


def statement_views(statements: dict[str, dict[str, Any]]) -> Views:
    out: Views = {}
    seen: dict[str, str] = {}
    bound = [SRC / name for name in bind_order()]
    for path in bound + sorted(set(SRC.glob('*.md')) - set(bound)):
        if path == APPENDIX or not path.exists():
            continue
        text = path.read_text(encoding=ENCODING)

        def expand(m: re.Match[str], path: pathlib.Path = path) -> str:
            sid = m['id'] or m['short']
            if sid not in statements:
                sys.exit(f'{path.name}: statement {sid} has no record')
            if sid in seen:
                sys.exit(f'{path.name}: statement {sid} is marked twice (also in {seen[sid]})')
            if statements[sid]['file_'] != path.name:
                sys.exit(f'{path.name}: statement {sid} is recorded for {statements[sid]["file_"]}')
            seen[sid] = path.name
            return render_mark(statements[sid])

        rendered = MARK.sub(expand, text)
        if rendered != text or MARK.search(text):
            out[path] = rendered
    unused = sorted(set(statements) - set(seen))
    if unused:
        sys.exit(f'statements recorded but marked nowhere in the prose: {unused}')
    rows = [
        f'| <a name="tab-{sid}"></a>\\[[{sid.replace("-", NB_HYPHEN)}](#{sid})] | {appendix_text(statements[sid])} |'
        for sid in seen
    ]  # prose order
    lines = APPENDIX.read_text(encoding=ENCODING).split('\n')
    first = next(i for i, line in enumerate(lines) if APPENDIX_ROW.match(line))
    last = max(i for i, line in enumerate(lines) if APPENDIX_ROW.match(line))
    out[APPENDIX] = '\n'.join(lines[:first] + rows + lines[last + 1 :])
    return out


def bind_order() -> list[str]:
    return [
        line.strip() for line in (EDIT / 'etc' / 'bind.txt').read_text(encoding=ENCODING).split('\n') if line.strip()
    ]


def migrate_statements() -> None:
    target = RECORDS / 'statements'
    if target.exists() and any(target.iterdir()):
        sys.exit('records/statements/ is not empty; migrate runs once')
    cells = {m[1]: m[0] for m in APPENDIX_ROW.finditer(APPENDIX.read_text(encoding=ENCODING))}
    header = '# Normative statements of {name}, in prose order. derive renders each mark «...» in the prose from\n'
    header += (
        '# `text`, and Appendix B from `standalone` (a full sentence, where the mark is a fragment) or `text`.\n\n'
    )
    for name in bind_order():
        path = SRC / name
        if not path.exists() or path == APPENDIX:
            continue
        recs = []
        for m in re.finditer(
            rf'«<mark title="Requirement ({STATEMENT_ID})"><a name="\1"></a>(.*?)</mark>»',
            path.read_text(encoding=ENCODING),
            re.S,
        ):
            rec: dict[str, Any] = {'id': m[1], 'text': m[2]}
            cell = re.fullmatch(r'.*?\)\]\s*\| (.*?)\s*\|', cells[m[1]])[1]  # type: ignore[index]
            flat = ' '.join(m[2].split())
            if cell not in (flat, flat + '.') and flat in cell:
                rec['standalone'] = cell
            recs.append(rec)
        if recs:
            dump(target / (path.stem + '.yaml'), {'statements': recs}, header.format(name=name))


# -- Step 2: packet layouts -> bytefield diagrams ------------------------------------------------------

PACKETS = RECORDS / 'packets'
DIAGRAMS = SRC / 'images' / 'packet'
GRAY, MID = '#eeeeee', '#dddddd'
Box = dict[str, Any]  # {kind: box|gap, label, label_annotations, attrs}


def _addr(at: str, i: int) -> str:
    """The address label of the i-th row of a field starting at `at`: '7' -> '8', '11+AM' -> '12+AM'."""
    m = re.fullmatch(r'(\d+)(.*)', at)
    return at if m is None or i == 0 else f'{int(m[1]) + i}{m[2]}'


def _box(label: str, attrs: dict[str, Any], kind: str = 'box', notes: list[dict[str, str]] | None = None) -> Box:
    return {'kind': kind, 'label': label, 'label_annotations': notes or [], 'attrs': attrs}


def _gray(optional: bool) -> dict[str, Any]:
    return {'fill': GRAY} if optional else {}


def _heading(name: str, note: list[dict[str, str]] | None) -> Box:
    return _box(name, {'fill': MID, '_keyword': 'bold', 'span': 9, 'text-anchor': 'start'}, notes=note)


def bit_values(item: dict[str, Any]) -> list[tuple[str, int]]:
    """The value row of a bit field: `values` is one character per bit ('0000XXXX') or a list of [value, width]."""
    values = item['values']
    return [(c, 1) for c in values] if isinstance(values, str) else [(v, w) for v, w in values]


def byte_labels(name: str, size: int) -> list[str]:
    if size == 1:
        return [name]
    return [f'{name} MSB'] + [name] * (size - 2) + [f'{name} LSB']


def render_item(item: dict[str, Any], optional: bool = False) -> list[Box]:
    """The boxes of one layout item, in canonical style; `boxes` in the record overrides single boxes by index."""
    out: list[Box] = []
    notes = item['note'] if 'note' in item else item.get('note_', [])
    if 'group' in item:
        label = f'{item["group"]} {item["eq_"]}' if item.get('symbol-style') == 'label' else item['group']
        out.append(_heading(label, notes))
        for sub in item['items']:
            out += render_item(sub, optional=True)
    elif 'bits' in item:
        opt = optional or bool(item.get('note'))
        if item.get('heading') == 'row':  # drawn as an address-less byte row instead of a full-width heading
            out += [_box('', {}), _box(item['bits'], {'span': 8, 'text-anchor': 'start'})]
        else:
            out.append(_heading(item['bits'], notes))
        out.append(_box('', {}))
        out += [_box(f['name'], {'fill': GRAY, 'span': f['width']}) for f in item['flags']]
        out.append(_box(address(item, 0), {}))
        out += [_box(value, _gray(opt) | {'span': width}) for value, width in bit_values(item)]
    elif 'variable' in item:
        label = item['variable']
        if item.get('symbol-style') == 'label':
            label += f' ({item.get("symbol") or item["bytes"]})' + (
                ' - optional' if item.get('condition-style') == 'label' else ''
            )
        out.append(_box(address(item, 0), _gray(optional)))
        out.append(_box(label, _gray(optional) | {'span': 8}, kind='gap', notes=notes))
    else:
        for i, label in enumerate(byte_labels(item['field'], item.get('bytes', 1))):
            out.append(_box(address(item, i), _gray(optional)))
            out.append(
                _box(label, _gray(optional) | {'span': 8, 'text-anchor': 'start'}, notes=notes if i == 0 else None)
            )
    for index, override in item.get('boxes', {}).items():
        out[int(index)] = out[int(index)] | override
    return out


def address(item: dict[str, Any], i: int) -> str:
    """Row i's address label: the stored `at` where the computed one is unknown or overridden, else the computed one."""
    if 'at' in item:
        return _addr(item['at'], i)
    label: str = item['at_'][i]
    return label


def render_boxes(packet: dict[str, Any]) -> list[Box]:
    annotate(packet['layout'])
    return [b for item in packet['layout'] for b in render_item(item)]


def _edn_str(s: str) -> str:
    return '"' + s.replace('\\', '\\\\').replace('"', '\\"') + '"'


def _edn_attrs(attrs: dict[str, Any]) -> str:
    plain = {k: v for k, v in attrs.items() if k != '_keyword'}
    body = '{' + ' '.join(f':{k} {_edn_str(v) if isinstance(v, str) else v}' for k, v in plain.items()) + '}'
    return f'[:{attrs["_keyword"]} {body}]' if '_keyword' in attrs else body


def _edn_label(box: Box) -> str:
    if box['label'] is None:  # (draw-box nil): no text element at all, unlike an empty label
        return 'nil'
    if 'label_style' in box:  # the whole label in one text style: (text "17+C+M+P" :medium)
        return f'(text {_edn_str(box["label"])} :{box["label_style"]})'
    notes = box['label_annotations']
    if box['label'] == '' and len(notes) == 1:  # a label in one style of its own: (text "17+C+M+P" :medium)
        return f'(text {_edn_str(notes[0]["text"])} :{notes[0]["style"]})'
    if not notes:
        return _edn_str(box['label'])
    notes = ' '.join(f'[:{n["style"]} {_edn_str(n["text"])}]' for n in box['label_annotations'])
    return f'(text {_edn_str(box["label"])} :plain {notes})'


EDN_HEAD = """;; Derived from records/packets/{id}.yaml by bin/spec_records.py -- edit the record, not this file.
(def boxes-per-row {boxes-per-row})
(def box-width {box-width})
(def left-margin {left-margin})
{styles}
(defattrs :bg-lightblue {{:fill "#cfe2f3"}})

(defn row-header-fn
  [{{:keys [address gap?]}}]
  (let [addr-label (str " ")]
    (text addr-label)))

(draw-box (text "Byte \\\\ Bit") :bg-lightblue)
(doseq [val (str/split "7,6,5,4,3,2,1,0" #",")]
  (draw-box (text val) :bg-lightblue))

"""


def render_edn(packet: dict[str, Any]) -> str:
    d = packet['diagram']
    styles = '\n'.join(f'(defattrs :{name} {_edn_attrs(attrs)})' for name, attrs in d['text-styles'].items())
    head = EDN_HEAD.format(
        id=packet['id'], styles=styles, **{k: d[k] for k in ('boxes-per-row', 'box-width', 'left-margin')}
    )
    calls = [f'(draw-{b["kind"]} {_edn_label(b)} {_edn_attrs(b["attrs"])})' for b in render_boxes(packet)]
    return head + '\n'.join(calls) + '\n\n(draw-bottom)\n'


def packet_views() -> Views:
    return {DIAGRAMS / f'{p["diagram"]["file"]}.edn': render_edn(p) for p in load_packets()}


def load_packets() -> list[dict[str, Any]]:
    return [load(p) for p in sorted(PACKETS.glob('*.yaml'))]


# -- migration from today's .edn (one-off) --


def _rows(items: list[Box]) -> list[dict[str, Any]]:
    """Group the flat boxes into rows: heading | byte | bits | gap (each row starts with its address box)."""
    rows: list[dict[str, Any]] = []
    i = 0
    while i < len(items):
        b = items[i]
        if b['attrs'].get('span') == 9:
            rows.append({'kind': 'heading', 'box': b, 'boxes': [b]})
            i += 1
            continue
        nxt = items[i + 1] if i + 1 < len(items) else None
        if nxt is not None and nxt['kind'] == 'gap':
            rows.append({'kind': 'gap', 'at': b['label'], 'boxes': [b, nxt]})
            i += 2
            continue
        content, width, j = [], 0, i + 1
        while j < len(items) and width < 8 and items[j]['kind'] == 'box' and items[j]['attrs'].get('span', 1) != 9:
            content.append(items[j])
            width += items[j]['attrs'].get('span', 1)
            j += 1
        if width != 8:
            raise ValueError(f'row at {b["label"]!r} spans {width} bits')
        kind = 'byte' if len(content) == 1 else 'bits'
        rows.append({'kind': kind, 'at': b['label'], 'boxes': [b, *content]})
        i = j
    return rows


def _items(rows: list[dict[str, Any]]) -> list[dict[str, Any]]:
    """Rows -> layout items: bit fields, optional groups, multi-byte fields, variable fields."""
    out: list[dict[str, Any]] = []
    group: dict[str, Any] | None = None
    i = 0

    def put(item: dict[str, Any]) -> None:
        (group['items'] if group is not None else out).append(item)

    while i < len(rows):
        r = rows[i]
        row_heading = r['kind'] == 'byte' and r['at'] == '' and i + 1 < len(rows) and rows[i + 1]['kind'] == 'bits'
        if r['kind'] == 'heading' or row_heading:
            h = r['boxes'][1] if row_heading else r['box']
            if (
                i + 2 < len(rows)
                and rows[i + 1]['kind'] == 'bits'
                and rows[i + 1]['at'] == ''
                and rows[i + 2]['kind'] == 'bits'
            ):
                names, values = rows[i + 1]['boxes'][1:], rows[i + 2]['boxes'][1:]
                item: dict[str, Any] = {'bits': h['label'], 'at': rows[i + 2]['at']}
                if row_heading:
                    item['heading'] = 'row'
                if h['label_annotations']:
                    item['note'] = h['label_annotations']
                item['flags'] = [{'name': n['label'], 'width': n['attrs'].get('span', 1)} for n in names]
                pairs = [(v['label'], v['attrs'].get('span', 1)) for v in values]
                item['values'] = (
                    ''.join(v for v, _ in pairs)
                    if all(w == 1 and len(v) == 1 for v, w in pairs)
                    else [list(p) for p in pairs]
                )
                group = None
                out.append(item)
                i += 3
                continue
            group = (
                {'group': h['label']}
                | ({'note': h['label_annotations']} if h['label_annotations'] else {})
                | {'items': []}
            )
            out.append(group)
            i += 1
            continue
        gray = any(b['attrs'].get('fill') == GRAY for b in r['boxes'])
        if group is not None and not gray:
            group = None
        if r['kind'] == 'gap':
            g = r['boxes'][1]
            put(
                {'variable': g['label'], 'at': r['at']}
                | ({'note': g['label_annotations']} if g['label_annotations'] else {})
            )
            i += 1
            continue
        if r['kind'] == 'bits':
            put({'raw-row': [b['label'] for b in r['boxes']], 'at': r['at']})
            i += 1
            continue
        label = r['boxes'][1]['label']
        name, size = label, 1
        if label.endswith(' MSB'):
            name = label.removesuffix(' MSB')
            j = i + 1
            while j < len(rows) and rows[j]['kind'] == 'byte' and rows[j]['boxes'][1]['label'] in (name, f'{name} LSB'):
                j += 1
                if rows[j - 1]['boxes'][1]['label'] == f'{name} LSB':
                    break
            size = j - i
        note = r['boxes'][1]['label_annotations']
        put({'field': name, 'at': r['at']} | ({'bytes': size} if size > 1 else {}) | ({'note': note} if note else {}))
        i += size
    return out


def _seed_overrides(items: list[dict[str, Any]], boxes: list[Box], optional: bool = False) -> int:
    """Record, per item, the boxes whose original label or attrs differ from the canonical rendering; returns boxes used."""
    pos = 0
    for item in items:
        if 'group' in item:
            heading = render_item({k: v for k, v in item.items() if k != 'items'} | {'items': []})[0]
            if heading != boxes[pos]:
                item['boxes'] = {'0': _delta(heading, boxes[pos])}
            pos += 1 + _seed_overrides(item['items'], boxes[pos + 1 :], optional=True)
            continue
        rendered = render_item(item, optional)
        diff = {
            str(k): _delta(c, o) for k, (c, o) in enumerate(zip(rendered, boxes[pos : pos + len(rendered)])) if c != o
        }
        if diff:
            item['boxes'] = diff
        pos += len(rendered)
    return pos


def _seed_expressions(items: list[dict[str, Any]]) -> None:
    """Notes and labels -> `symbol` / `present-if`; empty groups take the items their equation sizes say they span."""
    for item in items:
        if 'group' in item and (m := EQUATION.search(item['group'])):
            item['_orig_label'] = item['group']
            item['group'], item['symbol'], item['symbol-style'] = item['group'][: m.start()].rstrip(), m['sym'], 'label'
        if 'variable' in item and (m := LABEL_SYMBOL.match(item['variable'])):
            item['variable'], item['symbol-style'] = m['name'], 'label'
            item |= {'symbol': m['sym']} if m['sym'] else {'bytes': int(m['bytes'])}
            if m['optional']:
                item['present-if'], item['condition-style'] = 'optional', 'label'
        text = ''.join(n['text'] for n in item.get('note', []))
        if text and (m := NOTE.match(text)):
            item['_orig_note'] = item['note']
            if m['sym']:
                item['symbol'] = m['sym']
            cond = parse_condition(m['cond']) if m['cond'] else None
            if cond is not None:
                item['present-if'] = cond
            del item['note']  # generated from now on; a differing original comes back as a box override
        if 'group' in item:
            _seed_expressions(item['items'])
    i = 0
    while i < len(items):  # a group spans exactly what its equation says, whatever the fill colours suggest
        item = items[i]
        target = _equation_size(item) if 'group' in item else None
        if target is not None:
            pool, item['items'] = item['items'] + items[i + 1 :], []
            del items[i + 1 :]
            while pool and Offsets.size(item['items']) != target:
                item['items'].append(pool.pop(0))
            items[i + 1 : i + 1] = pool
        cond = item.get('present-if') if 'group' in item else None
        if isinstance(cond, dict) and 'is' in cond:  # a member testing the same field otherwise is an alternative
            k = next(
                (
                    k
                    for k, sub in enumerate(item['items'])
                    if isinstance(sub.get('present-if'), dict) and sub['present-if'].get('field') == cond['field']
                ),
                None,
            )
            if k is not None:
                items[i + 1 : i + 1], item['items'] = item['items'][k:], item['items'][:k]
        i += 1


def _equation_size(item: dict[str, Any]) -> tuple[int, list[str]] | None:
    """The (fixed, symbols) size a group's original equation states, e.g. 'P=2 or 0' -> (2, [])."""
    for text in [n['text'] for n in item.get('_orig_note', [])] + [item.get('_orig_label', '')]:
        m = EQUATION.search(text)
        if m:
            parts = m['eq'].split(' or ')[0].split('+')
            prev = m['eq'].split(' or ')[1].strip()
            parts = [p for p in parts if p != prev]
            return sum(int(p) for p in parts if p.isdigit()), [p for p in parts if not p.isdigit()]
    return None


def _strip_computed(items: list[dict[str, Any]]) -> None:
    """Drop what derive computes: a stored `at` the computed labels reproduce, and the scratch keys."""
    for item in items:
        computed = item.get('at_')
        if 'at' in item and computed and all(c == _addr(item['at'], i) for i, c in enumerate(computed)):
            del item['at']
        for key in ('at_', 'eq_', 'note_', '_orig_note', '_orig_label'):
            item.pop(key, None)
        if 'group' in item:
            _strip_computed(item['items'])


def _seed_source_forms(items: list[dict[str, Any]], source: str) -> None:
    """Two label forms the parsed boxes cannot tell apart: (draw-box nil) vs an empty label, and (text "x" :style)."""
    empties = re.findall(r'^\(draw-box (nil|\(text ""\)|"")', source, re.M)
    styled = dict(re.findall(r'^\(draw-box \(text "([^"]+)" :([a-z-]+)\)\)', source, re.M))
    k = 0

    def walk(level: list[dict[str, Any]], optional: bool = False) -> None:
        nonlocal k
        for item in level:
            if 'group' in item:
                walk(item['items'], True)
                continue
            for idx, box in enumerate(render_item(item, optional)):
                fix: dict[str, Any] = {}
                if box['label'] == '' and not box['label_annotations']:
                    fix = {'label': None} if empties[k] == 'nil' else {}
                    k += 1
                elif box['label'] in styled and not box['label_annotations'] and box['kind'] == 'box':
                    fix = {'label_style': styled[box['label']]}
                if fix:
                    item.setdefault('boxes', {})[str(idx)] = item.get('boxes', {}).get(str(idx), {}) | fix

    walk(items)
    assert k == len(empties), (k, len(empties))


def _delta(canonical: Box, original: Box) -> dict[str, Any]:
    return {k: v for k, v in original.items() if canonical.get(k) != v}


def migrate_packets() -> None:
    sys.path.insert(0, str(EDIT / 'bin'))
    import parse_bytefield_edn as edn  # type: ignore[import-not-found]  # pylint: disable=import-outside-toplevel

    if PACKETS.exists() and any(PACKETS.iterdir()):
        sys.exit('records/packets/ is not empty; migrate runs once')
    header = '# Layout of {title}: derive writes src/images/packet/{file}.edn (the figure source) from it.\n\n'
    for path in sorted(DIAGRAMS.glob('*.edn')):
        inst = edn.parse_file(path)
        boxes = [
            {k: b[k] for k in ('kind', 'label', 'label_annotations', 'attrs')} for b in inst.items[1:]
        ]  # [0]: Byte \\ Bit
        try:
            items = _items(_rows(boxes))
        except ValueError as exc:
            print(f'{path.name}: kept hand-written ({exc})')
            continue
        _seed_expressions(items)
        annotate(items)
        _seed_overrides(items, boxes)
        _seed_source_forms(items, path.read_text(encoding=ENCODING))
        _strip_computed(items)
        stem = path.stem.removesuffix('-packet-diagram').removesuffix('-diagram')
        styles = {
            k: v
            for k, v in inst.attrs_registry.items()
            if k in ('plain', 'cursive', 'small', 'medium', 'normal', 'tiny')
        }
        diagram = (
            {'file': path.stem}
            | {k: inst.defs[k] for k in ('boxes-per-row', 'box-width', 'left-margin')}
            | {'text-styles': styles}
        )
        packet: dict[str, Any] = {'id': stem} | ({'variant-of': VARIANTS[stem]} if stem in VARIANTS else {})
        packet |= {'title': stem.upper().replace('-', ' '), 'diagram': diagram, 'layout': items}
        dump(PACKETS / f'{stem}.yaml', packet, header.format(title=packet['title'], file=path.stem))


def dictionary_rows(packet: dict[str, Any]) -> list[dict[str, Any]]:
    """The packet dictionary's rows, from the record: optional and group come from the layout, not from fill colours."""
    rows: list[dict[str, Any]] = []

    def notes(item: dict[str, Any]) -> list[dict[str, str]]:
        return list(item['note'] if 'note' in item else item.get('note_') or [])

    def presence(item: dict[str, Any], group: dict[str, Any] | None) -> dict[str, Any]:
        cond = item.get('present-if') or (group or {}).get('present-if')
        sym = item.get('symbol') if 'variable' in item else None
        return ({'present_if': cond} if cond else {}) | ({'length_symbol': sym} if sym else {})

    def walk(items: list[dict[str, Any]], group: dict[str, Any] | None) -> None:
        optional = group is not None and bool(group.get('note'))
        context = {'group': group['group'] if group else None, 'group_annotations': notes(group) if group else []}
        for item in items:
            boxes = render_item(item, optional)
            if 'group' in item:
                walk(item['items'], item)
            elif 'bits' in item:
                opt = optional or bool(item.get('note'))
                names = [
                    b
                    for b in boxes
                    if b['attrs'].get('fill') == GRAY or b['label'] in [f['name'] for f in item['flags']]
                ]
                del names  # flag names come from the record itself
                values = iter(bit_values(item))
                bits = []
                for flag in item['flags']:
                    chunk, width = '', 0
                    while width < flag['width']:
                        value, w = next(values)
                        chunk, width = chunk + value, width + w
                    bits.append({'name': flag['name'], 'span': flag['width'], 'value': chunk, 'optional': opt})
                row = {
                    'type': 'bit_field',
                    'address': address(item, 0),
                    'group': item['bits'],
                    'group_annotations': notes(item),
                    'bits': bits,
                }
                rows.append(row | presence(item, group))
            else:
                kind = 'gap' if 'variable' in item else 'box'
                content = [b for b in boxes if b['attrs'].get('span') == 8 or b['kind'] == 'gap']
                addresses = [b for b in boxes if b not in content]
                for addr, box in zip(addresses, content):
                    annotations = list(box['label_annotations'])
                    conditional = optional or any(CONDITIONAL.search(n['text']) for n in annotations)
                    row = {'type': 'field', 'address': addr['label'] or '', 'name': box['label'], 'kind': kind}
                    rows.append(
                        row | {'annotations': annotations, 'optional': conditional} | context | presence(item, group)
                    )

    annotate(packet['layout'])
    walk(packet['layout'], None)
    return rows


CONDITIONAL = re.compile(r'only present|optional', re.I)


def write_rows(out_dir: pathlib.Path) -> int:
    """build/packet-rows/<diagram>.json for every packet record (the input of assemble_packet_dictionary.py)."""
    out_dir.mkdir(parents=True, exist_ok=True)
    for packet in load_packets():
        d = packet['diagram']
        data = {
            'source': f'src/images/packet/{d["file"]}.edn',
            'boxes_per_row': d['boxes-per-row'],
            'rows': dictionary_rows(packet),
            'warnings': [],
        }
        (out_dir / f'{d["file"]}.json').write_text(
            json.dumps(data, indent=2, ensure_ascii=False) + '\n', encoding=ENCODING
        )
    return 0


# -- Step 4: presence and lengths as expressions ------------------------------------------------------
#
# A layout item may carry
#   present-if  {flag: <bit name>} | {field: <name>, is: [<value>, ...]} | {field: <name>, greater: <n>} | optional
#   symbol      the length symbol it defines: for a variable field its length (N), for a conditional group or
#               field its offset contribution (S = size + previous symbol when present, else the previous symbol)
# derive generates the cursive notes, the symbol equations and the address labels from them; a stored `at` or
# `note` is an override that `views/findings.md` reports.

VARIANTS = {
    'publish-qos-minus-1': 'publish',
    'subscribe-with-topic-data': 'subscribe',
    'subscribe-with-topic-filter': 'subscribe',
    'unsubscribe-with-topic-data': 'unsubscribe',
    'unsubscribe-with-topic-filter': 'unsubscribe',
}
NOTE = re.compile(r'^ (?:\((?P<sym>[A-Z]+)(?:=(?P<eq>[^)]*))?\))?(?:(?(sym) |)- (?P<cond>.*))?$')
EQUATION = re.compile(r'\((?P<sym>[A-Z]+)=(?P<eq>[^)]*)\)')
LABEL_SYMBOL = re.compile(r'^(?P<name>.*?) \((?:(?P<sym>[A-Z]+)|(?P<bytes>\d+))\)(?P<optional> - optional)?$')


def parse_condition(text: str) -> Any:
    """'only present when Sess Exp flag is set' -> {'flag': 'Sess Exp'}; None when the wording is not understood."""
    if text == 'optional':
        return 'optional'
    m = re.fullmatch(r'only present (?:when|if) (.+?) flag is (?:set|1)', text)
    if m:
        return {'flag': m[1]}
    m = re.fullmatch(r'only present (?:when|if) (.+?) (?:is|>) (.+)', text)
    if m:
        if ' > ' in text:
            return {'field': m[1], 'greater': int(m[2])}
        return {'field': m[1], 'is': [v.strip() for v in m[2].split(' or ')]}
    return None


def render_condition(cond: Any) -> str:
    if cond == 'optional':
        return 'optional'
    if 'flag' in cond:
        return f'only present when {cond["flag"]} flag is set'
    if 'greater' in cond:
        return f'only present if {cond["field"]} > {cond["greater"]}'
    return f'only present when {cond["field"]} is {" or ".join(cond["is"])}'


class Offsets:
    """Walks a layout and computes, per item, its size, the address labels of its rows and its symbol equation."""

    def __init__(self) -> None:
        self.n: int | None = 1
        self.syms: list[str] = []
        self.prev = '0'

    def label(self, i: int = 0) -> str | None:
        return None if self.n is None else str(self.n + i) + ''.join(f'+{s}' for s in self.syms)

    @staticmethod
    def size(items: list[dict[str, Any]]) -> tuple[int, list[str]]:
        fixed, syms = 0, list[str]()
        for item in items:
            if 'group' in item:
                f, s = Offsets.size(item['items'])
                fixed, syms = fixed + f, syms + s
            elif 'variable' in item:
                if 'bytes' in item:
                    fixed += item['bytes']
                else:
                    syms.append(item.get('symbol', '?'))
            elif 'bits' in item:
                fixed += 1
            else:
                fixed += item.get('bytes', 1)
        return fixed, syms

    def equation(self, items: list[dict[str, Any]], symbol: str) -> str:
        fixed, syms = self.size(items)
        size = '+'.join([str(fixed)] * bool(fixed) + syms)
        prev = self.prev
        return f'({symbol}={size} or 0)' if prev == '0' else f'({symbol}={size}+{prev} or {prev})'


def annotate(layout: list[dict[str, Any]]) -> None:
    """Fill in the computed `at_` (row labels), `eq_` (symbol equation) and `note_` (generated note) of every item."""
    off = Offsets()

    def note(item: dict[str, Any], eq: str | None) -> list[dict[str, str]]:
        sym = item.get('symbol')
        head = eq if eq else f'({sym})' if sym and 'variable' in item else ''
        if item.get('symbol-style') == 'label':
            head = ''  # the symbol is part of the label
        cond = render_condition(item['present-if']) if item.get('present-if') else ''
        text = f' {head} - {cond}' if head and cond else f' {head}' if head else f' - {cond}' if cond else ''
        return [{'style': 'cursive', 'text': text}] if text else []

    def walk(items: list[dict[str, Any]]) -> None:
        run: tuple[str, int | None, list[str], int] | None = None  # (field, start offset, start symbols, count)
        for item in items:
            cond = item.get('present-if')
            alt = isinstance(cond, dict) and 'is' in cond and 'symbol' not in item  # alternatives test one field
            if alt and run is not None and run[0] == cond['field']:  # type: ignore[index]
                off.n, off.syms = run[1], list(run[2])
                run = (run[0], run[1], run[2], run[3] + 1)
            elif alt:
                run = (cond['field'], off.n, list(off.syms), 1)  # type: ignore[index]
            else:
                if run is not None and run[3] > 1:
                    off.n = None  # after alternatives of different sizes the offset is not computable
                run = None
            conditional = 'symbol' in item and ('group' in item or item.get('present-if')) and 'variable' not in item
            start_n = off.n
            eq = off.equation(item['items'] if 'group' in item else [item], item['symbol']) if conditional else None
            if eq:
                item['eq_'] = eq
            if 'group' in item:
                item['note_'] = note(item, eq)
                walk(item['items'])
            elif 'variable' in item:
                item['at_'] = [off.label()]
                item['note_'] = note(item, None) if item.get('condition-style') != 'label' else []
                if 'bytes' in item and off.n is not None:
                    off.n += item['bytes']
                elif 'symbol' in item:
                    off.syms = off.syms + [item['symbol']]
                elif off.n is not None and item.get('present-if') not in (None, 'optional'):
                    off.n = None
            else:
                rows = 1 if 'bits' in item else item.get('bytes', 1)
                item['at_'] = [off.label(i) for i in range(rows)]
                item['note_'] = note(item, eq)
                if off.n is not None:
                    off.n += rows
            if conditional:
                off.n, off.syms, off.prev = start_n, [item['symbol']], item['symbol']
            elif (
                ('group' in item or 'present-if' in item)
                and item.get('present-if') != 'optional'
                and 'variable' not in item
            ):
                if not alt:
                    off.n = None  # conditional without a symbol: later offsets are not computable

    walk(layout)


# -- Step 4: structural test vectors and expression findings ------------------------------------------


def _conditions(layout: list[dict[str, Any]]) -> list[Any]:
    """The distinct presence conditions of a layout that a vector can switch (flags, QoS, Topic Type, optional)."""
    out: list[Any] = []
    for item in layout:
        cond = item.get('present-if')
        if cond is not None and cond not in out and not (isinstance(cond, dict) and 'greater' in cond):
            out.append(cond)
        if 'group' in item:
            out += [c for c in _conditions(item['items']) if c not in out]
    return out


def _present(cond: Any, choice: dict[str, Any]) -> bool:
    if cond is None or (isinstance(cond, dict) and 'greater' in cond):
        return cond is None
    return bool(choice[json.dumps(cond, sort_keys=True)])


def _eval_label(label: str, values: dict[str, int]) -> int | None:
    parts = label.split('+')
    if not parts[0].isdigit() or any(p not in values for p in parts[1:]):
        return None
    return int(parts[0]) + sum(values[p] for p in parts[1:])


def vectors(packet: dict[str, Any], type_value: int) -> tuple[list[dict[str, Any]], list[str]]:
    """One vector per combination of presence conditions; checks every address label against the real offsets."""
    annotate(packet['layout'])
    conds = _conditions(packet['layout'])
    keys = [json.dumps(c, sort_keys=True) for c in conds]
    out, problems = [], []
    for mask in range(2 ** len(conds)) if len(conds) <= 6 else []:
        choice = {k: bool(mask >> i & 1) for i, k in enumerate(keys)}
        # alternatives on one field: at most one value can hold
        alternatives: dict[str, list[bool]] = {}  # field -> chosen? per value; exactly one value of a field holds
        for c, k in zip(conds, keys):
            if isinstance(c, dict) and 'is' in c:
                alternatives.setdefault(c['field'], []).append(choice[k])
        if any(sum(chosen) != 1 for chosen in alternatives.values() if len(chosen) > 1) or any(
            sum(c) > 1 for c in alternatives.values()
        ):
            continue
        fields: list[dict[str, Any]] = []
        values: dict[str, int] = {}
        pos = 0

        def walk(items: list[dict[str, Any]], present: bool) -> int:
            nonlocal pos
            start = pos
            for item in items:
                here = present and _present(item.get('present-if'), choice)
                begin = pos
                if 'group' in item:
                    walk(item['items'], here)
                elif here:
                    variable = 'variable' in item and 'bytes' not in item
                    size = 1 if 'bits' in item else SAMPLE_LENGTH if variable else item.get('bytes', 1)
                    name = item.get('field') or item.get('variable') or item.get('bits')
                    fields.append(
                        {'name': name, 'offset': pos, 'size': size} | ({'variable': True} if variable else {})
                    )
                    labels = item.get('at_') or []
                    stored = [_addr(item['at'], i) for i in range(len(labels) or 1)] if 'at' in item else labels
                    if stored and stored[0] and (v := _eval_label(stored[0], values)) is not None and v - 1 != pos:
                        problems.append(
                            f'{packet["id"]}: "{fields[-1]["name"]}" is labelled {stored[0]} = {v}, but sits at byte {pos + 1} {_describe(choice)}'
                        )
                    pos += size
                if 'symbol' in item:
                    if 'variable' in item:
                        values[item['symbol']] = pos - begin
                    else:
                        prev = values.get(_prev_symbol(item), 0)
                        values[item['symbol']] = prev + (pos - begin)
            return pos - start

        walk(packet['layout'], True)
        data = bytearray(pos)
        if pos > 1:
            data[0], data[1] = pos, type_value
        for i, f in enumerate(fields):
            item = next((i for i in packet['layout'] if i.get('bits') == f['name']), None)
            if item is not None:
                data[f['offset']] = flags_byte(item, [json.loads(k) for k, v in choice.items() if v])
            if f.get('variable'):  # sample content, and its length in the nearest length field before it
                data[f['offset'] : f['offset'] + f['size']] = SAMPLE_CONTENT
                length = next(
                    (g for g in reversed(fields[:i]) if g['name'].endswith('Length') and g['offset'] > 0), None
                )
                if length is not None:
                    data[length['offset'] : length['offset'] + length['size']] = f['size'].to_bytes(
                        length['size'], 'big'
                    )
        out.append({'present': {k: v for k, v in choice.items()}, 'length': pos, 'hex': data.hex(), 'fields': fields})
    return out, sorted(set(problems))


SAMPLE_LENGTH = 2  # every variable-length field of a vector carries this many bytes
SAMPLE_CONTENT = b'ab'


def flags_byte(item: dict[str, Any], conditions: list[Any]) -> int:
    """The flags byte of a vector: fixed bits as drawn, condition bits as chosen, all other variable bits 0."""
    topic = {
        e.get('name', ''): int(e['value'], 2)
        for e in next(t for t in load_tables() if t['id'] == 'topic-types')['entries']
        if e['value'].startswith('0b')
    }
    fixed = ''.join(v.ljust(w, v[-1])[:w] for v, w in bit_values(item))  # one character per bit, bit 7 first
    bits = [int(c) if c in '01' else 0 for c in fixed]
    pos = 0
    for flag in item['flags']:
        value = None
        for cond in conditions:
            if isinstance(cond, dict) and cond.get('flag') == flag['name']:
                value = 1
            elif isinstance(cond, dict) and cond.get('field') == flag['name'] and 'is' in cond:
                v = cond['is'][0]
                value = int(v) if v.isdigit() else next((n for name, n in topic.items() if v in name), None)
        if value is not None:
            bits[pos : pos + flag['width']] = [int(b) for b in format(value, f'0{flag["width"]}b')]
        pos += flag['width']
    return int(''.join(map(str, bits)), 2)


def _prev_symbol(item: dict[str, Any]) -> str:
    m = re.search(r' or ([A-Z]+)\)', item.get('eq_', ''))
    return m[1] if m else '0'


def _describe(choice: dict[str, bool]) -> str:
    on = [render_condition(json.loads(k)) for k, v in choice.items() if v]
    return '(with ' + '; '.join(on) + ')' if on else '(nothing optional present)'


def vector_views() -> tuple[Views, list[str]]:
    types = {
        e['name'].upper(): e['value'] for e in next(t for t in load_tables() if t['id'] == 'packet-types')['entries']
    }
    all_vectors, problems = {}, []
    for packet in load_packets():
        name = packet.get('variant-of', packet['id']).replace('-', ' ').upper()
        value = types.get(name, '0x00')
        vs, ps = vectors(packet, int(value, 16) if re.fullmatch(r'0x[0-9A-Fa-f]+', value) else 0)
        all_vectors[packet['id']] = vs
        problems += ps
    return {VIEWS / 'packet-vectors.json': json.dumps(all_vectors, indent=1) + '\n'}, problems


def expression_findings() -> list[str]:
    out: list[str] = []
    topic_types = {e.get('name') for e in next(t for t in load_tables() if t['id'] == 'topic-types')['entries']}
    for packet in load_packets():
        annotate(packet['layout'])
        flags = {f['name'] for item in packet['layout'] if 'bits' in item for f in item['flags']}

        def walk(items: list[dict[str, Any]], optional: bool = False) -> None:
            for item in items:
                name = item.get('group') or item.get('bits') or item.get('variable') or item.get('field')
                cond = item.get('present-if')
                if isinstance(cond, dict) and 'flag' in cond and cond['flag'] not in flags:
                    out.append(
                        f'{packet["id"]}: "{name}" depends on the flag "{cond["flag"]}", which the packet has not'
                    )
                if isinstance(cond, dict) and cond.get('field') == 'Topic Type':
                    unknown = [v for v in cond['is'] if not any(v in t for t in topic_types if t)]
                    if unknown:
                        out.append(
                            f'{packet["id"]}: "{name}" tests Topic Type {unknown}, which tab-topic-types does not define'
                        )
                computed = item.get('at_')
                if 'at' in item and computed and computed[0] is not None and computed[0] != item['at']:
                    out.append(
                        f'{packet["id"]}: "{name}" is labelled {item["at"]} in the figure, its layout puts it at {computed[0]}'
                    )
                canonical = render_item({k: v for k, v in item.items() if k != 'boxes'}, optional)
                for idx, box in item.get('boxes', {}).items():
                    if (
                        'label_annotations' in box
                        and box['label_annotations'] != canonical[int(idx)]['label_annotations']
                    ):
                        drawn = ''.join(n['text'] for n in box['label_annotations']).strip()
                        derived = ''.join(n['text'] for n in canonical[int(idx)]['label_annotations']).strip()
                        out.append(
                            f'{packet["id"]}: "{name}" reads "{drawn}" in the figure, the records give "{derived}"'
                        )
                if 'group' in item:
                    walk(item['items'], bool(item.get('present-if') or item.get('symbol')))

        walk(packet['layout'])
    return out + position_findings()


POSITION = re.compile(
    r'\*\*Position:?\*\*:? bits? (?P<bits>[0-9]+(?:-[0-9]+)?) of the (?P<byte>[^.]+?)(?: byte)?\.(?: Labelled \*(?P<label>[^*]+)\* in \[fig\]\(#fig-(?P<fig>[a-z0-9-]+)-packet\))?'
)


def position_findings() -> list[str]:
    """The prose's "Position: bit N of the X Flags. Labelled *Y* in [fig]" against the bit fields of the layout records."""
    packets = {p['id']: p for p in load_packets()}
    out = []
    for path in sorted(SRC.glob('ctrl-pack-catalog-*.md')):
        for m in POSITION.finditer(path.read_text(encoding=ENCODING)):
            if not m['label'] or m['fig'] not in packets:
                continue
            positions: dict[str, tuple[int, int]] = {}
            for item in packets[m['fig']]['layout']:
                pos = 0
                for flag in item.get('flags', []):
                    positions[flag['name']] = (7 - pos - flag['width'] + 1, 7 - pos)
                    pos += flag['width']
            low, high = (int(x) for x in (m['bits'].split('-') * 2)[:2])
            stated = (min(low, high), max(low, high))
            if m['label'] not in positions:
                out.append(
                    f'{path.name}: "{m[0][:60]}..." names a flag {m["label"]!r} the {m["fig"]} figure does not have'
                )
            elif positions[m['label']] != stated:
                out.append(
                    f'{path.name}: the prose puts {m["label"]} at bit(s) {m["bits"]}, the {m["fig"]} figure at {positions[m["label"]][0]}-{positions[m["label"]][1]}'
                )
    return out


# -- Step 3: code tables ------------------------------------------------------------------------------

CODES = RECORDS / 'tables'


def table_span(lines: list[str], label: str) -> tuple[int, int]:
    """[first, end) of the pipe table captioned `Table: ...{#label}` (a \\columns hint directly above belongs to it)."""
    caption = next(i for i, line in enumerate(lines) if line.startswith('Table: ') and line.endswith(f'{{#{label}}}'))
    end = caption - 1
    while not lines[end].startswith('|'):
        end -= 1
    first = end
    while first > 0 and lines[first - 1].startswith('|'):
        first -= 1
    if first > 1 and lines[first - 1] == '' and lines[first - 2].startswith('\\columns='):
        first -= 2
    return first, end + 1


def cells(line: str) -> list[str]:
    return [c.strip() for c in line.strip().strip('|').split('|')]


def render_cell(entry: dict[str, Any], column: dict[str, Any]) -> str:
    value = entry.get(column['key'])
    if value is None:
        return ''
    if isinstance(value, list):  # `join` separates the items; `bold` applies to each item
        return column.get('join', ', ').join(f'**{v}**' if column.get('bold') else str(v) for v in value)
    text = str(value)
    return f'**{text}**' if column.get('bold') and text else text


def separator(column: dict[str, Any]) -> str:
    """The separator cell: alignment colons and `width` dashes in all (pandoc and nide read relative widths from it)."""
    align, width = column.get('align', 'left'), column['width']
    left, right = align in ('left', 'center'), align in ('right', 'center')
    return (':' if left else '') + '-' * (width - left - right) + (':' if right else '')


def render_table(table: dict[str, Any]) -> list[str]:
    cols = table['columns']
    out = [table['columns-hint'], ''] if 'columns-hint' in table else []
    out.append('| ' + ' | '.join(c['title'] for c in cols) + ' |')
    out.append('|' + '|'.join(separator(c) for c in cols) + '|')
    out += ['| ' + ' | '.join(render_cell(e, c) for c in cols) + ' |' for e in table['entries']]
    return out


def load_tables() -> list[dict[str, Any]]:
    return [load(p) for p in sorted(CODES.glob('*.yaml'))]


def table_views(base: Views) -> Views:
    out: Views = {}
    for table in load_tables():
        path = SRC / table['file']
        lines = (out.get(path) or base.get(path) or path.read_text(encoding=ENCODING)).split('\n')
        first, end = table_span(lines, table['label'])
        out[path] = '\n'.join(lines[:first] + render_table(table) + lines[end:])
    return out


def migrate_codes() -> None:
    if CODES.exists() and any(CODES.iterdir()):
        sys.exit('records/tables/ is not empty; migrate runs once')
    specs = [
        (
            'packet-types',
            'ctrl-pack-format-01-structure.md',
            'tab-mqtt-sn-control-packet-types',
            [('name', True), ('value', False), ('direction', False), ('description', False)],
        ),
        (
            'packet-identifiers',
            'ctrl-pack-format-02-identifier.md',
            'tab-packets-with-packet-identifier',
            [('packet', False), ('identifier', False), ('responses', False)],
        ),
        (
            'reason-codes',
            'ctrl-pack-format-03-reason-code.md',
            'tab-reason-codes',
            [('decimal', False), ('value', False), ('name', False), ('packets', False), ('description', False)],
        ),
        (
            'topic-types',
            'ctrl-pack-format-04-topic-types.md',
            'tab-topic-types',
            [('index', False), ('value', False), ('name', False), ('description', False)],
        ),
    ]
    for tid, file, label, keys in specs:
        lines = (SRC / file).read_text(encoding=ENCODING).split('\n')
        first, end = table_span(lines, label)
        block = lines[first:end]
        hint = block[0] if block[0].startswith('\\columns=') else None
        rows = block[2:] if hint else block
        header, align, body = cells(rows[0]), cells(rows[1]), [cells(r) for r in rows[2:]]

        def kind(a: str) -> str:
            return (
                'center'
                if a.startswith(':') and a.endswith(':')
                else 'left' if a.startswith(':') else 'right' if a.endswith(':') else 'none'
            )

        widths = [len(c) for c in rows[1].strip().strip('|').split('|')]
        columns = [
            {'key': k, 'title': t} | ({'bold': True} if bold else {}) | {'align': kind(a), 'width': w}
            for (k, bold), t, a, w in zip(keys, header, align, widths)
        ]
        entries = []
        for row in body:
            entry: dict[str, Any] = {}
            for (k, bold), cell in zip(keys, row):
                text = cell.removeprefix('**').removesuffix('**') if bold else cell
                if k in ('packets', 'responses'):
                    entry[k] = [p.strip() for p in text.split(',')] if text else []
                elif text:
                    entry[k] = text
            entries.append(entry)
        table = (
            {'id': tid, 'file': file, 'label': label}
            | ({'columns-hint': hint} if hint else {})
            | {'columns': columns, 'entries': entries}
        )
        dump(CODES / f'{tid}.yaml', table, f'# Table {label} in {file}: derive writes the table from `entries`.\n\n')


# -- Step 5: roles and state machines -----------------------------------------------------------------

STATES = RECORDS / 'states'
SUBJECT = re.compile(
    r'\b(?:the |a |an |each |any )?(Client and (?:the )?Server|Client|Server|sender|receiver|Sender|Receiver|Forwarder|Gateway)s? (?:MUST|SHOULD|MAY|SHALL)\b'
)
LAYOUT_RULE = re.compile(
    r'MUST (?:NOT )?be (?:present|set to|0)|is reserved|MUST contain one of|MUST be (?:a|one) ', re.I
)


def load_roles() -> dict[str, Any]:
    roles: dict[str, Any] = load(RECORDS / 'roles.yaml')
    return roles


def directions() -> dict[str, tuple[set[str], set[str]]]:
    """Packet type name -> (sending roles, receiving roles), from the direction column of the packet type table."""
    out = {}
    for e in next(t for t in load_tables() if t['id'] == 'packet-types')['entries']:
        senders, receivers = set(), set()
        for part in e.get('direction', '').split(' or '):
            m = re.fullmatch(r'(\w+) to (\w+?)s?', part.strip())
            if m:
                senders.add(m[1].lower())
                receivers.add(m[2].lower())
        out[e['name'].upper()] = (senders, receivers)
    return out


def section_packet(file: str) -> str | None:
    m = re.fullmatch(r'ctrl-pack-catalog-\d\d-(.+)\.md', file)
    return m[1].replace('-', ' ').upper() if m else None


def seed_binds(rec: dict[str, Any]) -> None:
    """One-off: the roles a statement binds, with the reason in `binds-by` (to review, not to trust)."""
    text = ' '.join(rec['text'].split())
    packet = section_packet(rec['file_'])
    flows = directions().get(packet or '', (set(), set()))
    m = SUBJECT.search(text)
    if m:
        who = m[1].lower()
        if who.startswith('client and'):
            rec['binds'], rec['binds-by'] = ['client', 'server'], 'subject'
        elif who in ('sender', 'receiver') and packet and flows[0]:
            rec['binds'] = sorted(flows[0] if who == 'sender' else flows[1])
            rec['binds-by'] = f'{who} of {packet}'
        elif who in ('client', 'server', 'forwarder'):
            rec['binds'], rec['binds-by'] = [who], 'subject'
        elif who == 'gateway':
            rec['binds'], rec['binds-by'] = ['server'], 'subject (Gateway)'
    elif packet and flows[0] and LAYOUT_RULE.search(text):
        rec['binds'], rec['binds-by'] = sorted(flows[0]), f'sender of {packet} (packet format)'


def migrate_roles() -> None:
    for path in sorted((RECORDS / 'statements').glob('*.yaml')):
        data = load(path)
        if any('binds' in r for r in data['statements']):
            sys.exit(f'{path.name} already has binds; migrate runs once')
        for rec in data['statements']:
            rec['file_'] = path.stem + '.md'
            seed_binds(rec)
            del rec['file_']
        header = path.read_text(encoding=ENCODING).split('\n\n', 1)[0] + '\n'
        header += (
            '# `binds`: the roles (records/roles.yaml) the statement binds; `binds-by`: why (seeded, to review).\n\n'
        )
        dump(path, data, header)


def state_views(statements: dict[str, dict[str, Any]]) -> tuple[Views, list[str]]:
    tables = {t['id']: t for t in load_tables()}
    flows = directions()
    out: Views = {}
    problems: list[str] = []
    for path in sorted(STATES.glob('*.yaml')):
        machine = load(path)
        states = {e['state']: e for e in tables[machine['states']]['entries']}
        timers = {e['timer']: e for e in tables[machine['timers']]['entries']}
        may_send = {m['state']: m for m in machine.get('may-send', [])}
        for t in machine['transitions']:
            on = t['trigger']
            for s in (t['from'], t['to']):
                if s not in states:
                    problems.append(f'{machine["id"]}: state {s!r} is not in tab-{machine["states"]}')
            if 'packet' in on:
                senders = flows.get(on['packet'], (set(), set()))[0]
                if on['from'] not in senders:
                    problems.append(
                        f'{machine["id"]}: {t["from"]} -> {t["to"]} on {on["packet"]} from the {on["from"]}, but tab-mqtt-sn-control-packet-types lets only {sorted(senders)} send it'
                    )
                rule = may_send.get(t['from'])
                if on['from'] == 'client' and rule and on['packet'] not in rule['packets']:
                    problems.append(
                        f'{machine["id"]}: the figure lets an {t["from"]} Client send {on["packet"]} ({t["to"]}'
                        f'{", " + t["note"] if "note" in t else ""}), {rule["statement"]} allows only {", ".join(rule["packets"])}'
                    )
            if 'timer' in on:
                timer = timers.get(on['timer'])
                if timer is None:
                    problems.append(f'{machine["id"]}: timer {on["timer"]!r} is not in tab-{machine["timers"]}')
                elif t['from'] not in timer.get('states', []) or timer.get('timeout-state') != t['to']:
                    problems.append(
                        f'{machine["id"]}: the figure has {on["timer"]} timing out from {t["from"]} to {t["to"]}; '
                        f'tab-{machine["timers"]} has it in {", ".join(timer.get("states", []))} -> {timer.get("timeout-state")}'
                    )
            if t['to'] != t['from'] and t['to'] not in states.get(t['from'], {}).get('transitions', [t['to']]):
                problems.append(
                    f'{machine["id"]}: the figure has {t["from"]} -> {t["to"]}, the Possible Transitions column of tab-{machine["states"]} not'
                )
        for name, entry in states.items():
            for target in entry.get('transitions', []):
                if not any(t['from'] == name and t['to'] == target for t in machine['transitions']):
                    problems.append(
                        f'{machine["id"]}: tab-{machine["states"]} lists {name} -> {target}, the figure has no such transition'
                    )
        lines = [
            f'# {machine["title"]}',
            '',
            f'Derived from records/states/{path.name}. States: tab-{machine["states"]}; timers: tab-{machine["timers"]}.',
            '',
        ]
        lines += ['```mermaid', 'stateDiagram-v2', '    [*] --> None']
        for t in machine['transitions']:
            on = t['trigger']
            label = f'{on["packet"]} ({on["from"][0].upper()})' if 'packet' in on else f'{on["timer"]} timeout'
            lines.append(f'    {t["from"]} --> {t["to"]}: {label}')
        lines += ['```', '', '| From | To | Trigger | Note |', '|:-----|:---|:--------|:-----|']
        for t in machine['transitions']:
            on = t['trigger']
            trig = f'{on["packet"]} from the {on["from"]}' if 'packet' in on else f'{on["timer"]} timer'
            lines.append(f'| {t["from"]} | {t["to"]} | {trig} | {t.get("note", "")} |')
        lines += ['', '## What a Client may send', '']
        lines += [
            f'- {m["state"]}: {", ".join(m["packets"])} ({m["statement"]}: {" ".join(statements[m["statement"]]["text"].split())})'
            for m in machine.get('may-send', [])
        ]
        out[VIEWS / 'states' / f'{machine["id"]}.md'] = '\n'.join(lines) + '\n'
    return out, problems


def role_views(statements: dict[str, dict[str, Any]]) -> tuple[Views, list[str]]:
    roles = load_roles()
    flows = directions()
    out: Views = {}
    unbound = [sid for sid, rec in statements.items() if not rec.get('binds')]
    for role in roles['roles']:
        rid = role['id']
        sends = sorted(n for n, (s, _) in flows.items() if rid in s)
        receives = sorted(n for n, (_, r) in flows.items() if rid in r)
        bound = [(sid, rec) for sid, rec in statements.items() if rid in rec.get('binds', [])]
        lines = [f'# {role["title"]}', '', f'Term: {role["term"]} (see the terminology section).', '']
        lines += [f'Sends: {", ".join(sends) or "-"}', '', f'Receives: {", ".join(receives) or "-"}', '']
        lines += [f'## Statements binding the {role["title"]} ({len(bound)})', '']
        lines += [f'- [{sid}] {" ".join(appendix_text(rec).split())} ({rec.get("binds-by", "")})' for sid, rec in bound]
        out[VIEWS / 'roles' / f'{rid}.md'] = '\n'.join(lines) + '\n'
    problems = (
        [f'{len(unbound)} of {len(statements)} statements bind no role yet (no `binds`), e.g. {", ".join(unbound[:3])}']
        if unbound
        else []
    )
    return out, problems


def figure_findings() -> list[str]:
    """Figures sharing one caption cannot be told apart in the list of figures or by a reader."""
    seen: dict[str, str] = {}
    out = []
    for path in sorted(SRC.glob('*.md')):
        for m in re.finditer(r'!\[([^\]]+)\]\([^)]*\)\{#([^}]+)\}', path.read_text(encoding=ENCODING)):
            if m[1] in seen:
                out.append(f'figures {seen[m[1]]} and {m[2]} share the caption "{m[1]}"')
            seen.setdefault(m[1], m[2])
    return out


# -- Kaitai Struct: one .ksy per packet layout, and a dispatcher on the packet type -------------------

KAITAI = EDIT.parent / 'share' / 'kaitai'
KSY_HEADER = '# Derived from records/packets/{record} by bin/spec_records.py -- edit the record, not this file.\n'
PACKET_LENGTH = {
    'doc': 'The Length field: 1 byte, or 0x01 followed by a 2 byte length (section 2.1.2).',
    'seq': [{'id': 'first', 'type': 'u1'}, {'id': 'extended', 'type': 'u2', 'if': 'first == 1'}],
    'instances': {'value': {'value': 'first == 1 ? extended : first'}},
}


def ksy_id(name: str, taken: set[str]) -> str:
    base = re.sub(r'[^a-z0-9]+', '_', name.lower()).strip('_') or 'field'
    base = base if base[0].isalpha() else f'f_{base}'
    out, n = base, 2
    while out in taken:
        out, n = f'{base}_{n}', n + 1
    taken.add(out)
    return out


class Ksy:
    """Builds the .ksy of one packet; `problems` lists what the records cannot express in Kaitai."""

    def __init__(self, packet: dict[str, Any], type_value: int | None) -> None:
        self.packet, self.type_value = packet, type_value
        self.taken: set[str] = set()
        self.types: dict[str, Any] = {'packet_length': PACKET_LENGTH}
        self.flags: dict[str, str] = {}  # flag name -> kaitai expression
        self.problems: list[str] = []
        self.topic = {
            e.get('name', ''): int(e['value'], 2)
            for e in table('topic-types')['entries']
            if e['value'].startswith('0b')
        }
        self.stopped = False

    def condition(self, cond: Any) -> str | None:
        if cond is None:
            return None
        if cond == 'optional':
            return 'not _io.eof'
        key = cond.get('flag') or cond.get('field')
        ref = self.flags.get(key)
        if ref is None:
            self.problems.append(f'condition on {key!r}, which is no flag of the packet')
            return 'false'
        if 'flag' in cond:
            return ref
        if 'greater' in cond:
            return f'{ref} > {cond["greater"]}'
        values: list[int] = []
        for v in cond['is']:
            found = [int(v)] if v.isdigit() else [n for name, n in self.topic.items() if v in name]
            if not found:
                self.problems.append(f'{key} value {v!r} is not defined (tab-topic-types)')
            values += found
        return ' or '.join(f'{ref} == {v}' for v in values) or 'false'

    def bits_type(self, item: dict[str, Any], field_id: str) -> str:
        tid = ksy_id(item['bits'], set(self.types))
        seq: list[dict[str, Any]] = []
        ids: set[str] = set()
        values = ''.join(v.ljust(w, v[-1])[:w] for v, w in bit_values(item))
        pos = 0
        for flag in item['flags']:
            fid = ksy_id(flag['name'], ids)
            entry: dict[str, Any] = {'id': fid, 'type': f'b{flag["width"]}'}
            fixed = values[pos : pos + flag['width']]
            if fixed and all(c in '01' for c in fixed):
                entry['valid'] = int(fixed, 2) if flag['width'] > 1 else fixed == '1'
            seq.append(entry)
            self.flags.setdefault(flag['name'], f'{field_id}.{fid}')
            pos += flag['width']
        self.types[tid] = {'seq': seq}
        return tid

    def walk(self, items: list[dict[str, Any]], outer: str | None) -> list[dict[str, Any]]:
        seq: list[dict[str, Any]] = []
        for i, item in enumerate(items):
            if self.stopped:
                break
            own = self.condition(item.get('present-if'))
            cond = ' and '.join(f'({c})' for c in (outer, own) if c) if outer and own else outer or own
            if 'group' in item:
                seq += self.walk(item['items'], cond)
                continue
            name: str = item.get('field') or item.get('variable') or item['bits']
            entry: dict[str, Any] = {'id': ksy_id(name, self.taken)}
            if 'bits' in item:
                entry['type'] = self.bits_type(item, entry['id'])
            elif 'variable' in item:
                if 'bytes' in item:
                    entry['size'] = item['bytes']
                else:
                    length = next(
                        (s for s in reversed(seq) if s['id'].endswith('length') and s['id'] != 'length'), None
                    )
                    last = self.is_last(item)
                    if length is not None and not last:
                        entry['size'] = length['id']
                    elif last:
                        entry['size-eos'] = True
                    elif length is not None:
                        entry['size'] = length['id']
                    else:
                        self.problems.append(
                            f'"{name}" ({item.get("symbol", "?")}) has no length field before it and is not last'
                        )
                        seq.append(
                            {
                                'id': 'rest',
                                'size-eos': True,
                                'doc': f'Not parsed further: the size of "{name}" is not derivable from the records.',
                            }
                        )
                        self.stopped = True
                        break
            elif name == 'Length' and not seq:
                entry['type'] = 'packet_length'
            elif name == 'Packet Type':
                entry['type'] = 'u1'
                if self.type_value is not None:
                    entry['valid'] = self.type_value
            else:
                size = item.get('bytes', 1)
                entry |= {'type': f'u{size}'} if size in (1, 2, 4, 8) else {'size': size}
            if cond:
                entry['if'] = cond
            seq.append(entry)
        return seq

    def is_last(self, item: dict[str, Any]) -> bool:
        def flat(items: list[dict[str, Any]]) -> list[dict[str, Any]]:
            return [x for it in items for x in (flat(it['items']) if 'group' in it else [it])]

        return flat(self.packet['layout'])[-1] is item

    def document(self) -> dict[str, Any]:
        annotate(self.packet['layout'])
        seq = self.walk(self.packet['layout'], None)
        pid = 'mqtt_sn_' + ksy_id(self.packet['id'], set())
        meta = {'id': pid, 'title': f'MQTT-SN v2.0 {self.packet["title"]} packet', 'endian': 'be', 'bit-endian': 'be'}
        return {'meta': meta, 'seq': seq, 'types': self.types}


def table(tid: str) -> dict[str, Any]:
    return next(t for t in load_tables() if t['id'] == tid)


def kaitai_views() -> tuple[Views, list[str]]:
    types = {e['name'].upper(): e['value'] for e in table('packet-types')['entries']}
    out: Views = {}
    problems: list[str] = []
    cases: dict[int, str] = {}
    for packet in load_packets():
        value = types.get(packet.get('variant-of', packet['id']).replace('-', ' ').upper())
        number = int(value, 16) if value and re.fullmatch(r'0x[0-9A-Fa-f]+', value) else None
        ksy = Ksy(packet, number)
        doc = ksy.document()
        problems += [f'kaitai {packet["id"]}: {p}' for p in ksy.problems]
        text = KSY_HEADER.format(record=f'{packet["id"]}.yaml') + yaml.safe_dump(doc, sort_keys=False, width=1000)
        out[KAITAI / f'{doc["meta"]["id"]}.ksy'] = text
        if number is not None and 'variant-of' not in packet:
            cases[number] = doc['meta']['id']
    dispatcher = {
        'meta': {
            'id': 'mqtt_sn_packet',
            'title': 'MQTT-SN v2.0 packet, by packet type',
            'endian': 'be',
            'imports': sorted(cases.values()),
        },
        'instances': {
            'length_first': {'pos': 0, 'type': 'u1'},
            'packet_type': {'pos': 'length_first == 1 ? 3 : 1', 'type': 'u1'},
            'packet': {
                'pos': 0,
                'type': {'switch-on': 'packet_type', 'cases': {f'0x{k:02x}': v for k, v in sorted(cases.items())}},
            },
        },
    }
    header = '# Derived from records/packets/ and records/tables/packet-types.yaml by bin/spec_records.py.\n'
    out[KAITAI / 'mqtt_sn_packet.ksy'] = header + yaml.safe_dump(dispatcher, sort_keys=False, width=1000)
    return out, problems


def kaitai_test(compiled: pathlib.Path) -> int:
    """Parse every vector of views/packet-vectors.json with the Python parsers compiled from ../share/kaitai/."""
    import importlib  # pylint: disable=import-outside-toplevel
    import io  # pylint: disable=import-outside-toplevel

    from kaitaistruct import KaitaiStream  # type: ignore[import-not-found,import-untyped,unused-ignore]  # pylint: disable=import-outside-toplevel

    sys.path.insert(0, str(compiled))

    def cls(module: str) -> Any:
        return getattr(importlib.import_module(module), ''.join(p.capitalize() for p in module.split('_')))

    documented = {p.split(':')[0].removeprefix('kaitai ') for p in kaitai_views()[1]}  # packets the findings explain
    vectors = json.loads((VIEWS / 'packet-vectors.json').read_text(encoding=ENCODING))
    dispatcher = cls('mqtt_sn_packet')
    ok, failed = 0, []
    for pid, items in vectors.items():
        module = 'mqtt_sn_' + ksy_id(pid, set())
        parser = cls(module)
        for vector in items:
            data = bytes.fromhex(vector['hex'])
            obj = parser(KaitaiStream(io.BytesIO(data)))
            taken: set[str] = set()
            expected = {ksy_id(f['name'], taken): f for f in vector['fields']}
            missing = [k for k in expected if getattr(obj, k, None) is None]
            wrong = [
                k
                for k, f in expected.items()
                if f.get('variable') and getattr(obj, k, None) not in (None, SAMPLE_CONTENT)
            ]
            complete = obj._io.pos() == len(data) and not missing and not wrong
            if complete or (pid in documented and (getattr(obj, 'rest', None) is not None or missing)):
                ok += 1
            else:
                failed.append(
                    f'{pid} ({vector["length"]} bytes): missing {missing}, wrong {wrong}, read {obj._io.pos()}'
                )
            if 'variant-of' not in load(PACKETS / f'{pid}.yaml'):
                routed = type(dispatcher(KaitaiStream(io.BytesIO(data))).packet)
                if routed is not parser:
                    failed.append(f'{pid}: mqtt_sn_packet dispatches to {routed.__name__}')
    for line in failed:
        print(line)
    print(
        f'{ok} of {sum(len(v) for v in vectors.values())} vectors parsed as expected ({len(documented)} packets with documented gaps)'
    )
    return 1 if failed else 0


# -- Findings: what derive notices without refusing to derive -----------------------------------------

BCP14 = re.compile(r'\b(MUST|SHALL|SHOULD|REQUIRED|RECOMMENDED)\b(?: (not|Not))?|\b(Must|Shall|Should) (?=not\b|be\b)')
HAND_NUMBER = re.compile(r'\b(?:table|figure|section) \d+(?:[.-]\d+)*\b', re.I)


def packet_names() -> list[str]:
    return [
        e['name']
        for e in next(t for t in load_tables() if t['id'] == 'packet-types')['entries']
        if e['name'] != 'Reserved'
    ]


def record_id(name: str) -> str:
    return name.lower().replace(' ', '-')


def layout_fields(items: list[dict[str, Any]], optional: bool = False) -> dict[str, bool]:
    """Field name -> conditional? over a layout (groups with a presence note make their fields conditional)."""
    out: dict[str, bool] = {}
    for item in items:
        if 'group' in item:
            out |= layout_fields(item['items'], optional or bool(item.get('present-if') or item.get('symbol')))
        elif 'field' in item:
            out[item['field']] = optional or bool(item.get('present-if'))
    return out


def findings(statements: dict[str, dict[str, Any]]) -> list[str]:
    out: list[str] = []
    for sid, rec in statements.items():
        for m in BCP14.finditer(rec['text']):
            if m[2] == 'not' or m[3]:
                out.append(f'{sid}: BCP 14 keyword not in capitals: "{m[0]}"')
        if HAND_NUMBER.search(rec['text']):
            out.append(f'{sid}: hand-written number instead of a reference: "{HAND_NUMBER.search(rec["text"])[0]}"')  # type: ignore[index]
    tables = {t['id']: t for t in load_tables()}
    packets = {p['id']: p for p in load_packets()}
    names = packet_names()
    for e in tables['reason-codes']['entries']:
        for pk in e['packets']:
            base = re.sub(r'\s*\((client|server) only\)', '', pk)
            excepted = re.fullmatch(
                r'Any packet except (.+)', base
            )  # "Any packet except A and B": A and B must be packets
            for name in re.split(r', | and ', excepted[1]) if excepted else [base]:
                if name not in names:
                    out.append(f'reason code {e["value"]} ({e["name"]}): "{name}" is no packet type name')
    for e in tables['packet-types']['entries']:
        if e['name'] != 'Reserved' and record_id(e['name']) not in packets:
            out.append(f'packet type {e["name"]} has no layout record')
        if re.search(r'\S-|-\S', e['value']) and ' - ' not in e['value']:
            out.append(f'packet type value range "{e["value"]}" is written unevenly')
    for pid, p in packets.items():
        if record_id(p.get('variant-of', pid)) not in {record_id(n) for n in names}:
            out.append(f'layout record {pid} is no packet type and names no `variant-of`')
    listed = {re.sub(r' - QoS \d', '', e['packet']).upper(): e for e in tables['packet-identifiers']['entries']}
    for name in names:
        layout = packets.get(record_id(name))
        has = layout is not None and 'Packet Identifier' in layout_fields(layout['layout'])
        if has and name.upper() not in listed:
            out.append(
                f'{name} has a Packet Identifier in its layout but is missing from tab-packets-with-packet-identifier'
            )
    for e in tables['packet-identifiers']['entries']:
        found = packets.get(record_id(re.sub(r' - QoS \d', '', e['packet'])))
        if found is None:
            continue
        fields = layout_fields(found['layout'])
        state = 'NO' if 'Packet Identifier' not in fields else 'OPTIONAL' if fields['Packet Identifier'] else 'YES'
        if state != e['identifier'] and not (state == 'OPTIONAL' and e['identifier'] in ('YES', 'NO')):
            out.append(
                f'tab-packets-with-packet-identifier says {e["identifier"]} for {e["packet"]}, the layout has it {state}'
            )
    return out


def render_findings(items: list[str]) -> str:
    lines = [
        '# Findings',
        '',
        'What `make derive` noticed in the records and the prose without refusing to derive.',
        '',
    ]
    return '\n'.join(lines + [f'- {f}' for f in items] + ([] if items else ['- none'])) + '\n'


# -- Driver -------------------------------------------------------------------------------------------


def views() -> Views:
    statements = load_statements()
    out = statement_views(statements) | packet_views()
    out |= table_views(out)
    vector_files, vector_problems = vector_views()
    out |= vector_files
    static = expression_findings()
    flagged = {(f.split(':')[0], f.split('"')[1]) for f in static if '"' in f}
    confirmed: dict[tuple[str, str], str] = (
        {}
    )  # one line per field, and only what the static checks did not already find
    for problem in vector_problems:
        key = (problem.split(':')[0], problem.split('"')[1])
        if key not in flagged:
            confirmed.setdefault(key, problem)
    state_files, state_problems = state_views(statements)
    role_files, role_problems = role_views(statements)
    kaitai_files, kaitai_problems = kaitai_views()
    out |= state_files | role_files | kaitai_files
    everything = findings(statements) + static + list(confirmed.values()) + state_problems + figure_findings()
    everything += kaitai_problems + role_problems
    out[VIEWS / 'findings.md'] = render_findings(everything)
    return out


def derive() -> int:
    for path, text in views().items():
        if not path.exists() or path.read_text(encoding=ENCODING) != text:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text, encoding=ENCODING)
            print(f'wrote {path.relative_to(EDIT.parent)}')
    return 0


def check() -> int:
    stale = [p for p, text in views().items() if not p.exists() or p.read_text(encoding=ENCODING) != text]
    for path in stale:
        print(f'stale view: {path.relative_to(EDIT.parent)} (run: make derive)')
    return 1 if stale else 0


def migrate(step: str) -> int:
    {'statements': migrate_statements, 'packets': migrate_packets, 'codes': migrate_codes, 'roles': migrate_roles}[
        step
    ]()
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest='command', required=True)
    sub.add_parser('derive')
    sub.add_parser('check')
    sub.add_parser('migrate').add_argument('step', choices=['statements', 'packets', 'codes', 'roles'])
    sub.add_parser('rows').add_argument('--out-dir', default=str(EDIT / 'build' / 'packet-rows'))
    sub.add_parser('kaitai-test').add_argument(
        'compiled', help='directory with the Python parsers compiled from ../share/kaitai/'
    )
    args = parser.parse_args()
    if args.command == 'kaitai-test':
        return kaitai_test(pathlib.Path(args.compiled))
    if args.command == 'rows':
        return write_rows(pathlib.Path(args.out_dir))
    if args.command == 'migrate':
        return migrate(args.step)
    return {'derive': derive, 'check': check}[args.command]()


if __name__ == '__main__':
    sys.exit(main())
