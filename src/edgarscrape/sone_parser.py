from lxml import html as hparser
from pathlib import Path

fname = 'samples/twitter/twitter-s-1.txt'
txt = Path(fname).read_text()
hsoup = hparser.fromstring(txt)
doc = hsoup.cssselect('DOCUMENT')[0]
