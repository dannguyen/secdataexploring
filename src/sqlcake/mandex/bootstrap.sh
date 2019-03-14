#!/bin/sh

# This script creates the data/sqlcake/mandex.sqlite database


# example call:
# ./src/sqlcake/mandex/bootstrap.sh  data/sqlcake/mandex.sqlite  data/master-indexes/formatted/all-master-indexes.csv



DBNAME="${1}"
SRC_PATH="${2}"
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
sqlite3 ${DBNAME} < ${SCRIPT_DIR}/schema-mandex.sql


# import the data

sqlite3 ${DBNAME} <<SQL_CMDS
.bail on
.timer on
.changes on
.mode csv
.import ${SRC_PATH} mandex
SQL_CMDS

# sqlite3 ${DBNAME} <<SQL_CMDS
# .bail on
# .timer on

sqlite3 ${DBNAME}  < ${SCRIPT_DIR}/indexes.sql
