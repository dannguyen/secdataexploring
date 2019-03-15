from lxml.etree import fromstring as xsoup
import requests

ATTR_XPATHS = (
    ('cik', '/companyFilings/companyInfo/CIK/text()'),
    ('name', '/companyFilings/companyInfo/name/text()'),
    ('location', '/companyFilings/companyInfo/Location/text()'),
    ('sic', '/companyFilings/companyInfo/SIC/text()'),
    ('sic_description', '/companyFilings/companyInfo/SICDescription/text()'),
    ('business_address_city', '/companyFilings/companyInfo/businessAddress/city/text()'),
    ('business_address_state', '/companyFilings/companyInfo/businessAddress/state/text()'),
    ('business_address_zipcode', '/companyFilings/companyInfo/businessAddress/zipCode/text()'),
    ('incorporation_state', '/companyFilings/companyInfo/stateOfIncorporation/text()'),
    ('cik_href', '/companyFilings/companyInfo/CIKHREF/text()'),
    ('request_url', None),

)

COMPANY_ATTRS = tuple([k[0] for k in ATTR_XPATHS])


# https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=SNAP&output=xml
BASE_ENDPOINT = 'https://www.sec.gov/cgi-bin/browse-edgar'
BASE_PARAMS = {'action': 'getcompany',
                'CIK': None,
                'owner': 'exclude',
                'output': 'xml',
                'count': '10',
                'start': '0',
               }

def get_company(symbol):
    """
    symbol: a string that can either be a CIK (0001318605) or stock ticker (TSLA)
    """
    parms = BASE_PARAMS.copy()
    parms.update({'CIK': symbol})
    return _fetch(parms)

def _fetch(params):
    resp = _make_request(params)
    return _parse_response(resp)


def _make_request(params):
    resp = requests.get(BASE_ENDPOINT, params=params)
    return resp

def _parse_response(response):
    """
    returns a dict
    """
    d = {}
    xdoc = xsoup(response.content)
    for k, pth in (x for x in ATTR_XPATHS if x[1]):
        e = xdoc.xpath(pth)
        d[k] = e[0] if e else None
    # manually add the request url
    d['request_url'] = response.request.url

    return d

