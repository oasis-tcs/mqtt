#! /usr/bin/env python
"""Derive byte/row grouping and optional-field/group-header semantics from a raw
bytefield instance (the output of parse_bytefield_edn.py).

Every rule below was checked against the real corpus before being encoded, not
assumed -- see the derivation notes inline. This is prototype 3 (byte/row grouping)
in the packet-dictionary exploration; the raw per-item capture from
parse_bytefield_edn.py stays the source of truth, this is a read-only transform on it.

Row-grouping rule: items accumulate into one row by summing their 'span' (default 1)
until the running total reaches boxes-per-row -- EXCEPT a 'gap' item always closes
its row immediately regardless of its own span (verified: every gap in the corpus is
followed only by a fresh address label or a new group-header, never a row-continuing
field box).

Row classification, in this order:

- group-header: a lone item spanning the full row width, tagged :field-name or
  :bg-mediumgray (verified: the only full-row-width items in the whole corpus NOT
  tagged this way belong to structure-packet-diagram.edn, a different kind of
  diagram entirely -- see SKIP_NO_ADDRESS_STRUCTURE below).
- names-row: starts with an empty-label, span-1 address placeholder followed by 2+
  items -- holds bit/sub-field NAMES, paired with the next row.
- bit-field: an address-labeled row immediately following a stashed names-row, with
  the same item count -- the VALUES paired against those names (e.g. Connect Flags'
  "0/X/X/X/X/X/X/X" row paired with "Reserved/Srv Sugg/.../Clean Start").
- field: a normal address-labeled row with exactly one field/gap item.

Group attachment: a bit-field row always belongs to the group-header immediately
before it (verified: every bit-field in the corpus is directly preceded by exactly
one header, nothing between) and clears that group on use. A plain field row stays
attached to the current group only while it carries the SAME :bg-lightgray/
optional-* tint the group's own optional rows carry -- verified against CONNECT:
Session Expiry Interval/Will Fields/Authentication Fields are entirely gray-tinted
end to end, and the first untinted row after them (Client Identifier) is correctly
NOT part of any group.

Usage: bin/derive_byte_rows.py build/packet-specs/connect-packet-diagram.json
       bin/derive_byte_rows.py --dir build/packet-specs --out-dir build/packet-rows
"""
import argparse
import json
import pathlib
import sys

ENCODING = 'utf-8'

GROUP_HEADER_KEYWORDS = {'field-name', 'bg-mediumgray'}
OPTIONAL_KEYWORDS = {'bg-lightgray', 'optional-byte', 'optional-byte-left'}
HEADER_CELL_KEYWORDS = {'bg-lightblue'}


def group_into_rows(items: list[dict], boxes_per_row: int) -> tuple[list[list[dict]], list[str]]:
    """Accumulate the flat item sequence into row-groups by span, gap-closes-row."""
    warnings: list[str] = []
    start = 1 if items and set(items[0]['attrs_keywords']) & HEADER_CELL_KEYWORDS else 0

    rows: list[list[dict]] = []
    current: list[dict] = []
    span_sum = 0
    for item in items[start:]:
        current.append(item)
        if item['kind'] == 'gap':
            rows.append(current)
            current, span_sum = [], 0
            continue
        span_sum += item['attrs'].get('span', 1)
        if span_sum >= boxes_per_row:
            rows.append(current)
            current, span_sum = [], 0
        elif span_sum > boxes_per_row:
            warnings.append(f'row overshoot past {boxes_per_row}: {[it["label"] for it in current]}')
    if current:
        warnings.append(f'unclosed trailing row (never reached {boxes_per_row}): {[it["label"] for it in current]}')
        rows.append(current)
    return rows, warnings


def is_optional(*items: dict) -> bool:
    keywords: set[str] = set()
    for item in items:
        keywords |= set(item['attrs_keywords'])
    return bool(keywords & OPTIONAL_KEYWORDS)


def classify(instance: dict) -> tuple[list[dict], list[str]]:
    boxes_per_row = instance['defs'].get('boxes-per-row')
    if not boxes_per_row:
        return [], ['no boxes-per-row def -- cannot group rows']

    row_groups, warnings = group_into_rows(instance['items'], boxes_per_row)

    out_rows: list[dict] = []
    current_group: dict | None = None
    pending_names_row: list[dict] | None = None

    for grp in row_groups:
        first = grp[0]
        first_span = first['attrs'].get('span', 1)

        if len(grp) == 1 and first_span == boxes_per_row:
            if set(first['attrs_keywords']) & GROUP_HEADER_KEYWORDS:
                current_group = {'title': first['label'], 'annotations': first['label_annotations']}
                continue
            warnings.append(f'unrecognized full-row-width item, not a known group-header: {first["label"]!r}')
            continue

        is_names_row = first['label'] == '' and first_span == 1 and len(grp) > 1
        if is_names_row:
            if pending_names_row is not None:
                warnings.append('a names-row was still pending when another one started -- discarding the stale one')
            pending_names_row = grp
            continue

        is_address_row = first_span == 1 and first['label'] != ''
        if not is_address_row:
            warnings.append(f'unrecognized row shape (no address label): {[it["label"] for it in grp]}')
            continue

        names_span = sum(it['attrs'].get('span', 1) for it in pending_names_row[1:]) if pending_names_row else None
        values_span = sum(it['attrs'].get('span', 1) for it in grp[1:])
        if pending_names_row is not None and names_span == values_span:
            # The names-row groups bits by FIELD width (e.g. "Reserved" is one span-3
            # box); the values-row always shows each individual bit as its own span-1
            # box (verified: Will Flags' 4 named fields pair against 8 single-bit
            # value boxes). Align by cumulative span, not item count, consuming as
            # many value-items as each name's own span needs.
            bits = []
            value_items = list(grp[1:])
            vi = 0
            for name_item in pending_names_row[1:]:
                span = name_item['attrs'].get('span', 1)
                consumed = []
                consumed_span = 0
                while consumed_span < span and vi < len(value_items):
                    consumed.append(value_items[vi])
                    consumed_span += value_items[vi]['attrs'].get('span', 1)
                    vi += 1
                bits.append({
                    'name': name_item['label'],
                    'span': span,
                    'value': ''.join(v['label'] for v in consumed),
                    'optional': is_optional(name_item, *consumed),
                })
            if vi != len(value_items):
                warnings.append(f'bit-field span alignment left {len(value_items) - vi} unconsumed value item(s) for address {first["label"]!r}')
            out_rows.append({
                'type': 'bit_field',
                'address': first['label'],
                'group': current_group['title'] if current_group else None,
                'group_annotations': current_group['annotations'] if current_group else [],
                'bits': bits,
            })
            pending_names_row = None
            current_group = None  # a bit-field consumes its header; nothing after shares it implicitly
            continue

        if pending_names_row is not None:
            warnings.append(f'pending names-row never matched a same-length values-row: {[it["label"] for it in pending_names_row]}')
            pending_names_row = None

        if len(grp) == 2:
            field_item = grp[1]
            row_optional = is_optional(first, field_item)
            if current_group is not None and not row_optional:
                current_group = None  # left the group's tinted region
            out_rows.append({
                'type': 'field',
                'address': first['label'],
                'name': field_item['label'],
                'kind': field_item['kind'],
                'annotations': field_item['label_annotations'],
                'optional': row_optional,
                'group': current_group['title'] if (current_group and row_optional) else None,
                'group_annotations': (current_group['annotations'] if (current_group and row_optional) else []),
            })
            continue

        warnings.append(f'unrecognized multi-item address row (not a names/values pair): {[it["label"] for it in grp]}')

    return out_rows, warnings


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('instance_files', nargs='*')
    parser.add_argument('--dir', help='directory of parsed *.json instances (all of them, instead of listing files)')
    parser.add_argument('--out-dir', default=None)
    args = parser.parse_args()

    edit_root = pathlib.Path(__file__).resolve().parent.parent
    paths = [pathlib.Path(p) for p in args.instance_files]
    if args.dir:
        d = pathlib.Path(args.dir)
        if not d.is_absolute():
            d = edit_root / d
        paths.extend(sorted(d.glob('*.json')))
    if not paths:
        sys.exit('no input: give instance file(s) or --dir')

    out_dir = None
    if args.out_dir:
        out_dir = pathlib.Path(args.out_dir)
        if not out_dir.is_absolute():
            out_dir = edit_root / out_dir
        out_dir.mkdir(parents=True, exist_ok=True)

    total_warnings = 0
    for p in paths:
        instance = json.loads(p.read_text(encoding=ENCODING))
        rows, warnings = classify(instance)
        total_warnings += len(warnings)
        payload = {'source': instance['source'], 'boxes_per_row': instance['defs'].get('boxes-per-row'), 'rows': rows, 'warnings': warnings}
        if out_dir:
            (out_dir / p.name).write_text(json.dumps(payload, indent=2) + '\n', encoding=ENCODING)
            flag = f'  [{len(warnings)} warning(s)]' if warnings else ''
            print(f'{p.stem}: {len(rows)} row(s){flag}')
        else:
            print(json.dumps(payload, indent=2))

    if total_warnings:
        print(f'\n{total_warnings} total warning(s) -- review before trusting these rows', file=sys.stderr)


if __name__ == '__main__':
    main()
