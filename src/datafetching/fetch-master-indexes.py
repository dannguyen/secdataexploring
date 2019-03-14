#!/usr/bin/env python
# Credit: check out the nice explainer at https://github.com/datasets/edgar

from pathlib import Path
import requests

ZIP_DIR = Path('data/zips/master-indexes')
ZIP_DIR.mkdir(parents=True, exist_ok=True)
YEAR_START = 2009
YEAR_END = 2018


# https://www.sec.gov/Archives/edgar/full-index/2018/QTR4/master.zip
BASE_URL = 'https://www.sec.gov/Archives/edgar/full-index/{yr}/QTR{q}/master.zip'
BASE_DESTNAME = '{yr}q{q}.zip'


for year in range(YEAR_START, YEAR_END+1):
    for qtr in [1,2,3,4]:
        url = BASE_URL.format(yr=year, q=qtr)
        print("Downloading", url)
        resp = requests.get(url)

        dest_name = ZIP_DIR.joinpath(BASE_DESTNAME.format(yr=year, q=qtr))
        print("\tSaving to:", dest_name)
        dest_name.write_bytes(resp.content)


