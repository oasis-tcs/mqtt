#! /usr/bin/env python
"""Transform export-post-processed sections into either gfm-plus or clean source."""

import pathlib
import sys
from collections.abc import Iterable

import yaml

ENCODING = 'utf-8'
ENC_ERRS = 'ignore'
NL = '\n'


def read_patches(patches_path: pathlib.Path) -> tuple[list[tuple[str, str]], bool]:
    """Obtain any search-replace pairs from user patching file."""
    patches = []
    need_patching = False
    if patches_path.is_file() and patches_path.stat().st_size:
        try:
            with open(patches_path, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
                patch_spec = yaml.safe_load(handle)
            need_patching = True
        except (OSError, UnicodeDecodeError) as er:
            print(err)
            need_patching = False
        if need_patching:
            try:
                patches = [(rep, lace) for rep, lace in patch_spec]
                patch_pair_count = len(patches)
                if not patch_pair_count:
                    need_patching = False
            except ValueError as err:
                print(err)
                raise
                need_patching = False
    return patches, need_patching


def apply(patches: list[tuple[str, str]], incoming: Iterable[str]) -> list[str]:
    """Apply all pairs in patches to incoming strings.

    Examples:

    >>> incoming = ['a', 'b', 'cb', 'd']
    >>> patches = [('b', 'x'), ('c', ''), ('y', 'foo')]
    >>> apply(patches, incoming)
    ['a', 'x', 'x', 'd']
    """
    outgoing = [line for line in incoming]

    for this, that in patches:
        for n, text in enumerate(outgoing):
            if this in text:
                outgoing[n] = text.replace(this, that)

    return outgoing



if len(sys.argv) != 4:
    sys.exit(f'usage: {__file__} patch-db in-md out-md')

patch_db = sys.argv[1]
in_md = sys.argv[2]
out_md = sys.argv[3]

if not patch_db.endswith(('.yaml', '.yml')):
    sys.exit(f'usage: {__file__} patch-db.yaml in-md out-md')

patches, need_patching = read_patches(pathlib.Path(patch_db))

if not need_patching:
    sys.exit(0)

with open(in_md, 'rt', encoding=ENCODING, errors=ENC_ERRS) as handle:
    lines = [line.rstrip(NL) for line in handle.readlines()]

patched_lines = apply(patches, lines)

with open(out_md, 'wt', encoding=ENCODING, errors=ENC_ERRS) as handle:
    handle.write(NL.join(patched_lines) + NL)
