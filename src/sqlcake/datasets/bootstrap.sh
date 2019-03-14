#!/bin/sh

# This script creates the data/sqlcake/datacake.sqlite database
# by importing the datasets from data/standardized
#   and other lookup files
# and creating basic indices

# example call:
# ./src/sqlcake/datasets/bootstrap.sh  data/sqlcake/sec-datasets.sqlite   data/datasets/formatted

# sample call:
# ./src/sqlcake/datasets/bootstrap.sh  samples/sec-datasets-sample.sqlite  samples/dataset-2016q4



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
SQL_CMDS

done

# sqlite3 ${DBNAME} <<SQL_CMDS
# .bail on
# .timer on


sqlite3 ${DBNAME}  < ${SCRIPT_DIR}/schemas/indexes.sql

# .print
# .print ------------------------------------------------ inspections
# .print filtering std_inspections into temp tables

# .print temp public housing
# .read ${SCRIPT_PATH}/filtering/extract_unique_inspections_public_housing.sql

# .print
# .print temp multifamily
# .read ${SCRIPT_PATH}/filtering/extract_unique_inspections_multifamily.sql

# .print
# .print combining temp tables into ft_inspections
# .read ${SCRIPT_PATH}/filtering/filter_inspections.sql

# .print
# .print ------------------------------------------------ properties

# .print
# .print creating filtered public housing properties table
# .read ${SCRIPT_PATH}/filtering/filter_properties_public_housing.sql


# .print
# .print creating filtered multifamily properties table
# .read ${SCRIPT_PATH}/filtering/filter_properties_multifamily.sql


# .print
# .print ------------------------------------------------ phas_scores and owners

# .print
# .print filtering phas_scores
# .read ${SCRIPT_PATH}/filtering/filter_phas_scores.sql

# .print
# .print filtering owners
# .read ${SCRIPT_PATH}/filtering/filter_housing_authorities.sql
# .read ${SCRIPT_PATH}/filtering/filter_owners_multifamily.sql


# .print
# .print ------------------------------------------------ buildings
# .read ${SCRIPT_PATH}/filtering/filter_buildings.sql


# SQL_CMDS


# # Now merge inspections tables into one
# echo 'Merging inspections tables'
# sqlite3 ${DBNAME} < ${SCRIPT_PATH}/importing/merge_standard_inspections.sql

# echo 'Creating multifamily owners'
# sqlite3 ${DBNAME} < ${SCRIPT_PATH}/importing/mf_owners_extract.sql

# # create indexes
# echo 'Creating indexes'
# sqlite3 ${DBNAME} < ${SCRIPT_PATH}/importing/create_standard_indexes.sql
