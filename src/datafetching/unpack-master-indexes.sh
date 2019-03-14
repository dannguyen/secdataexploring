#!/usr/bin/env sh

_DESTNAME=data/master-indexes/formatted/all-master-indexes.csv
mkdir -p $(dirname $_DESTNAME)

echo 'cik,company_name,form_type,date_filed,filename' > ${_DESTNAME}

find data/master-indexes/*.txt \
        -exec sed '1,11d' {} \; \
    | xsv fmt -d '|' \
    >> ${_DESTNAME}
