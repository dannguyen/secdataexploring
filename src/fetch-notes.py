#!/usr/bin/env python

from pathlib import Path
import requests

ZIP_DIR = Path('data/zips/notes')
ZIP_DIR.mkdir(parents=True, exist_ok=True)
YEAR_START = 2012
YEAR_END = 2018
# https://www.sec.gov/files/dera/data/financial-statement-and-notes-data-sets/2018q4_notes.zip
SRC_URL_DIR = 'https://www.sec.gov/files/dera/data/financial-statement-and-notes-data-sets/'
SRC_BNAME = '{yr}q{q}_notes.zip'


for year in range(YEAR_START, YEAR_END+1):
    for qtr in [1,2,3,4]:
        bname = SRC_BNAME.format(yr=year, q=qtr)
        url = SRC_URL_DIR + bname
        print("Downloading", url)
        resp = requests.get(url)

        dest_name = ZIP_DIR.joinpath(bname)
        print("\tSaving to:", dest_name)
        dest_name.write_bytes(resp.content)