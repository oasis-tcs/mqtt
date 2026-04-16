#! /usr/bin/env python
"""Transform src ref image paths to data-urls."""

import pathlib
import sys

ENCODING = 'utf-8'
ENC_ERRS = 'ignore'
NL = '\n'


if len(sys.argv) != 2:
    sys.exit(f'usage: {__file__} html-path')

html_path = pathlib.Path(sys.argv[1])

if not html_path.is_file() or html_path.suffix != '.html':
    sys.exit(f'usage: {__file__} file.html')

if not html_path.stat().st_size:
    sys.exit(f'usage: {__file__} non-empty-file.html')

with open(html_path, 'rt', encoding=ENCODING, errors=ENC_ERRS) as source:
    lines = [line.rstrip(NL) for line in source.readlines()]

for slot, line in enumerate(lines):
    if 'src="images/image' in line:
        cand = line.split('src="images/')[1].split('"')[0]
        data_url_path = pathlib.Path('build/data-url/' + cand + '.txt')
        if data_url_path.is_file() and data_url_path.stat().st_size:
            with open(data_url_path, 'rt', encoding=ENCODING) as source:
                data_url = source.read().rstrip()
            lines[slot] = line.replace(f'images/{cand}', data_url)

with open(html_path, 'wt', encoding=ENCODING, errors=ENC_ERRS) as target:
    target.write(NL.join(lines) + NL)
