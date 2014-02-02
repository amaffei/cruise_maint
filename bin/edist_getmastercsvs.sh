#!/bin/bash
# edist_getmasters.sh
topdir=~drumbeat/git/cruise_maint
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
wget --no-check-certificate --output-document=$configdir/r2re_terms_master.csv 'https://docs.google.com/spreadsheet/ccc?key=0AjSDHgC95uZsdDNCaEdhTS1xVVJJdEZ5R2cxZG1ZOUE&output=csv'
#
#
#
wget --no-check-certificate --output-document=$configdir/vessels_master.csv 'https://docs.google.com/spreadsheet/ccc?key=0AjSDHgC95uZsdDlKaGZEOEUyLURjbjBtdmJua1YxcWc&output=csv'
