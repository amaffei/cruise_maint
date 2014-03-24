#!/bin/bash
# edist_getmastercsvs.sh
#
# Brief Description:
# Go to google and grab the 3 master spreadsheets, stashing them in ../edist_cfg directory
#
# Arguments:
# None
#
# TODO
# ----
# Make sure that no N/As appear in the csvs grabbed from Google
#
topdir=..
configdir=$topdir/edist_cfg
vocabdir=$topdir/vocabs
bindir=$topdir/bin
testdir=$topdir/edist_test
outputdir=$topdir/edist_test
#
# get instruments_master.csv
#
wget --no-check-certificate --output-document=$configdir/instruments_master.csv 'https://docs.google.com/spreadsheet/ccc?key=0AjSDHgC95uZsdGhkOVltdDA4QjhLaTZOLUR2U2JzUnc&output=csv'
#
# get r2re_vocabs_master.csv
#
wget --no-check-certificate -O - 'https://docs.google.com/spreadsheet/ccc?key=0AjSDHgC95uZsdDNCaEdhTS1xVVJJdEZ5R2cxZG1ZOUE&output=csv' | grep -v "^[LB]" > $configdir/r2re_terms_master.csv
#
#
#
wget --no-check-certificate --output-document=$configdir/vessels_master.csv 'https://docs.google.com/spreadsheet/ccc?key=0AjSDHgC95uZsdDlKaGZEOEUyLURjbjBtdmJua1YxcWc&output=csv'
