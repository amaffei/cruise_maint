#!/bin/bash
# edist_scpvocs.sh r2root@<hostname>
#
# Brief Description:
# copies vocabulary files to the current R2R eventlogger installation
# on <hostname>
#
# Arguments:
# Must provide single argument in form username@hostname
#
topdir=..
testdir=$topdir/edist_files
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
