import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'src'))

from edgarfoo.get_company import get_company, COMPANY_ATTRS
from csv import DictWriter
from pathlib import Path

SRC_PATH = Path('data', 'lookups', 'initial-tickers.txt')
OUT_PATH = Path('data', 'lookups', 'cik-tickers.csv')

tickers = SRC_PATH.read_text().splitlines()
data = []
for t in tickers:
    print("Looking up:", t)
    d = {'ticker': t}
    d.update(get_company(t))
    data.append(d)


with OUT_PATH.open('w') as wf:
    outs = DictWriter(wf, fieldnames=['ticker'] + list(COMPANY_ATTRS))
    outs.writeheader()
    outs.writerows(data)
