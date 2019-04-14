#!/bin/sh

# This script creates the data/sqlcake/datacake.sqlite database
# by importing the datasets from data/standardized
#   and other lookup files
# and creating basic indices

# example call:
# ./src/sqlcake/datasets/bootstrap.sh  data/sqlcake/finst-datasets.sqlite   data/datasets/formatted

# sample call:
# ./src/sqlcake/datasets/bootstrap.sh  samples/finst-datasets-sample.sqlite  samples/dataset-2016q4



DBNAME="${1}"
DATA_DIR="${2}"
# https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Script dir: ${SCRIPT_DIR}"
echo "Import data dir: ${DATA_DIR}"

echo "Creating ${DBNAME}"''
# first, kill the file if it already exists
rm -f ${DBNAME}
mkdir -p $(dirname $DBNAME)


# create the database
sqlite3 <<< ".open ${DBNAME}"
# create the tables
sqlite3 ${DBNAME} < ${SCRIPT_DIR}/schemas/tbl-num.sql
sqlite3 ${DBNAME} < ${SCRIPT_DIR}/schemas/tbl-pre.sql
sqlite3 ${DBNAME} < ${SCRIPT_DIR}/schemas/tbl-sub.sql


# import the data
for tblname in num pre sub; do
    srcfile=${DATA_DIR}/${tblname}.csv
    echo "...Loading ${srcfile}"

sqlite3 ${DBNAME} <<SQL_CMDS
.bail on
.timer on
.changes on
.mode csv
.import ${srcfile} ${tblname}

DELETE FROM "${tblname}" WHERE "adsh" = 'adsh';
SQL_CMDS

done

sqlite3 ${DBNAME}  < ${SCRIPT_DIR}/schemas/indexes.sql
