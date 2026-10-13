#! /usr/bin/env python
"""Validate every parsed bytefield instance in build/packet-specs/ against the schema.

Step 3/6 of `make packet-dictionary`, between parse_bytefield_edn.py (step 2) and
derive_byte_rows.py (step 4): a regression gate on the PARSER's own output shape,
distinct from the combined-dictionary schema checked later (step 5's output against
bin/packet-dictionary.schema.json). If a new .edn file (or an edit to an existing one)
produces an attrs/label shape this schema doesn't recognize, this fails the build here
-- loudly, before derive_byte_rows.py has a chance to silently misinterpret it --
rather than only surfacing as a wrong byte table several steps downstream.

The schema (bin/bytefield-instance.schema.json) was written FROM real parsed output,
not designed up front, and should keep being maintained that way: when this fails on
a legitimate new shape (not a parser bug), widen the schema from the real instance,
the way the font-style-vs-box-style attrs_registry case was resolved originally.

Usage: bin/validate_bytefield_instances.py [--dir build/packet-specs] [--schema bin/bytefield-instance.schema.json]
"""
import argparse
import json
import pathlib
import sys

import jsonschema

ENCODING = 'utf-8'


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument('--dir', default='build/packet-specs', help='directory of parsed *.json instances')
    parser.add_argument('--schema', default='bin/bytefield-instance.schema.json')
    args = parser.parse_args()

    edit_root = pathlib.Path(__file__).resolve().parent.parent
    schema_path = pathlib.Path(args.schema)
    if not schema_path.is_absolute():
        schema_path = edit_root / schema_path
    instances_dir = pathlib.Path(args.dir)
    if not instances_dir.is_absolute():
        instances_dir = edit_root / instances_dir

    schema = json.loads(schema_path.read_text(encoding=ENCODING))
    validator = jsonschema.Draft202012Validator(schema)

    instance_paths = sorted(instances_dir.glob('*.json'))
    if not instance_paths:
        sys.exit(f'no instances found in {instances_dir}')

    failures = 0
    for p in instance_paths:
        instance = json.loads(p.read_text(encoding=ENCODING))
        errors = sorted(validator.iter_errors(instance), key=lambda e: e.path)
        if errors:
            failures += 1
            print(f'FAIL  {p.name}')
            for err in errors:
                loc = '.'.join(str(x) for x in err.path) or '<root>'
                print(f'      at {loc}: {err.message}')
        else:
            print(f'ok    {p.name}')

    print(f'\n{len(instance_paths) - failures}/{len(instance_paths)} instance(s) valid against {schema_path.name}')
    if failures:
        sys.exit(1)


if __name__ == '__main__':
    main()
