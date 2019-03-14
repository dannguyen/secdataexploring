#!/usr/bin/env python

from pathlib import Path
from zipfile import ZipFile

SRC_DIR = Path('data/zips/notes')
DEST_DIR = Path('data/notes')

EXPECTED_TEXT_FILENAMES = ['cal', 'dim',
                           'num', 'pre',
                           'ren', 'sub',
                           'tag', 'txt',]

DEST_DIR.mkdir(exist_ok=True, parents=True)
zip_fnames = sorted(SRC_DIR.glob('*_notes.zip'))

for zn in zip_fnames:
    zbase = zn.stem
    with ZipFile(zn) as zfile:
        for _tn in EXPECTED_TEXT_FILENAMES:
            destpath = DEST_DIR.joinpath('{}-{}.txt'.format(_tn, zbase)) # e.g. pre-2018q4.txt
            with zfile.open(_tn + '.tsv') as zp:
                _b = destpath.write_bytes(zp.read())
                print(destpath, "\t", _b, 'bytes')

