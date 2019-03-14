# S-1 Data stuff


## Getting things running

Requires Python 3.x (Anaconda works well) and sqlite3 and [xsv](https://github.com/BurntSushi/xsv)

### Building a sqlite database of the SEC compact datasets

```sh
# fetch the data
./src/datafetching/fetch-datasets.py
# unzip the zips into data/datasets/
./src/datafetching/unpack-datasets.py
# using `xsv`, compile the raw TSVs into 3 csvs: 
# data/datasets/formatted/pre,num,sub.csv
./src/datafetching/format-datasets.py

# create a sqlite database in data/sqlcake/sec-datasets.sqlite
# import the data/datasets/formatted/*.csv
# index the tables
./src/sqlcake/datasets/bootstrap.sh  \
    data/sqlcake/sec-datasets.sqlite  \
    data/datasets/formatted
```

Result is `data/sqlcake/sec-datasets.sqlite` at ~26GB.

You can see a sample at: [samples/sec-datasets-sample.sqlite](samples/sec-datasets-sample.sqlite)


## SEC Data and Notes

https://www.sec.gov/dera/data/financial-statement-and-notes-data-set.html

- Docs: https://www.sec.gov/files/aqfsn_1.pdf

## SEC datasets

This is a slim version of the full data and notes, containing only 4 out of the 8 tables in the notes version.

https://www.sec.gov/dera/data/financial-statement-data-sets.html

- Documentation: https://www.sec.gov/files/aqfs.pdf
- Data 2013Q4: https://www.sec.gov/files/dera/data/financial-statement-data-sets/2013q4.zip


# Samples

Google spreadsheet containing a sampling of 2016q4 data from several companies:

https://docs.google.com/spreadsheets/d/1WgD0WkvVaUtqTE0Af_ZdCVSFk1eFp7Jv4c87xceG_kw/edit#gid=1935154626

The same CSVs can be found in [samples/dataset-2016q4](samples/dataset-2016q4)


#### Twilio


- Edgar Index: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001447669
    - With params: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001447669&type=&dateb=&owner=include&count=100&start=20
    - S-1 search: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001447669&type=S-1&dateb=&owner=include&count=100
- S-1 on 2016-10-07, index: https://www.sec.gov/Archives/edgar/data/1447669/000119312516733893/0001193125-16-733893-index.htm
    - htm version: https://www.sec.gov/Archives/edgar/data/1447669/000119312516733893/d237988ds1.htm
- 10-K 2018
    - index: https://www.sec.gov/Archives/edgar/data/1447669/000104746919000807/0001047469-19-000807-index.htm
    - htm: https://www.sec.gov/Archives/edgar/data/1447669/000104746919000807/a2237834z10-k.htm

#### GoPro:

- Edgar Index: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001500435
    - With params: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001500435&type=&dateb=&owner=include&count=100&start=20
    - S-1: https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001500435&type=S-1&dateb=&owner=include&count=100
- Original S-1: https://www.sec.gov/Archives/edgar/data/1500435/000119312514204902/0001193125-14-204902-index.htm
- S-1/A on 2014-11-17 (with XBRL): https://www.sec.gov/Archives/edgar/data/1500435/000119312514415127/0001193125-14-415127-index.htm
- 2018Q3 10-Q Index: https://www.sec.gov/Archives/edgar/data/1500435/000150043518000049/0001500435-18-000049-index.htm
- 2018 10K INdex: https://www.sec.gov/Archives/edgar/data/1500435/000150043519000013/0001500435-19-000013-index.htm

#### Twitter S-1:

- Index: https://www.sec.gov/Archives/edgar/data/1418091/000119312513390321/0001193125-13-390321-index.htm
- HTML: https://www.sec.gov/Archives/edgar/data/1418091/000119312513390321/d564001ds1.htm
- Text: https://www.sec.gov/Archives/edgar/data/1418091/000119312513390321/0001193125-13-390321.txt


####  Pandora S-1:

- Index: https://www.sec.gov/Archives/edgar/data/1230276/000119312511032963/0001193125-11-032963-index.htm
- HTML: https://www.sec.gov/Archives/edgar/data/1230276/000119312511032963/ds1.htm
- Text: https://www.sec.gov/Archives/edgar/data/1230276/000119312511032963/0001193125-11-032963.txt

