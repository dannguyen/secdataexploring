#!/usr/bin/env sh
_SRC_DIR=data/datasets
_DEST_DIR=data/datasets/formatted

mkdir -p ${_DEST_DIR}

echo "Stacking num tables"
xsv cat -d "\t" rows data/datasets/num-*.txt \
    > ${_DEST_DIR}/num.csv


echo "Stacking pre tables"
# csvstack --tabs -e latin1 \
#         data/datasets/pre-20*.txt \
#     | csvformat --out-tabs  \
xsv cat -d "\t" rows data/datasets/pre-*.txt \
    > ${_DEST_DIR}/pre.csv


echo "Stacking sub tables"
# csvstack --tabs \
#         data/datasets/sub-20*.txt \
#     | csvformat --out-tabs  \
#     > ${_DEST_DIR}/sub.tsv
xsv cat -d "\t" rows data/datasets/sub-*.txt \
    > ${_DEST_DIR}/sub.csv


# skipping tags for now


# Note this issue for the --quoting 3 thing
# https://github.com/wireservice/csvkit/issues/382

# chardetect on the files results in:
# data/datasets/pre-2010q2.txt: ISO-8859-1 with confidence 0.73
# i.e. latin1
