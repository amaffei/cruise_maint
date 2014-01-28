#!/bin/bash
# edist_make_vocs.sh <cruiseid>
topdir=~drumbeat/git/cruise_maint
configdir=$topdir/edist_cfg
vocabdir=$topdir/vocabs
bindir=$topdir/bin
testdir=$topdir/edist_test
outputdir=$topdir/edist_test
#
if [ "$1" == "" ]; then
echo "Need to incude a host specifier for scp command like username@hostname.whoi.edu"
exit
fi

#
# Copy vocabularies to a test dreamplug
#
scp $testdir/voc/* $1:~/current/CRUISE.TEMPLATE/r2r/info/voc
scp $testdir/vessels/* $1:~/current/CRUISE.TEMPLATE/r2r/info/vessels
