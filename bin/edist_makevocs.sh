#!/bin/bash
# edist_makevocs.sh [test]
#
# Brief Description:
# Grabs vocabularies from rvdata.us and runs local scripts to create all vocabs necc for the
# R2R eventlogger. Then places all of these in ../edist_files/{voc,vessels]
#
# Arguments:
# Providing the argument "test" uses "test" as the version and incorporates it into
# the resulting filenames (instead of using todays date as the version)
#
# TODO:
# - Add logic to only make the "ALL" instrument from actions found in instruments included in edist
#   and the r2re_terms_master.csv
#
topdir=..
configdir=$topdir/edist_cfg
vocabdir=$topdir/vocabs
bindir=$topdir/bin
outputdir=$topdir/edist_files

if [ "$1" == "test" ]; then
  version=test
else
  version=`date "+%Y%m%d"`
fi

#
#
#
rm $outputdir/voc/*.csv
rm $outputdir/voc/*.tsv
rm $outputdir/vessels/*.csv
#
# get the info/tsv files from rvdata
#
for file in activitytype organization person vessel
do
    infourl=http://get.rvdata.us/services/voc/?id=$file
    wget $infourl -O $outputdir/voc/$file\_$version.tsv
done

# build instruments.csv and instaction.csv
# NOTE: perl funniness below sorts all lines but header in a CSV
#
$bindir/edist_make_instruments.pl  > $outputdir/voc/instruments\_$version.csv
$bindir/edist_make_actions.pl | perl -e 'print scalar <>, sort <>;' > $outputdir/voc/actions\_$version.csv
#
# make instactionmap.csv
#
echo "\"EventTerm\",\"DefaultActionTerms\"" > $outputdir/voc/instactionmap\_$version.csv
$bindir/edist_make_instaction.pl | perl -e 'print scalar <>, sort <>;' | uniq >> $outputdir/voc/instactionmap\_$version.csv
#
# make vessel instrument files
#
for i in ae at bh c cb ch en ew hly hrs hx km kn kok lmg mgl mv mw nbp nh oc pe ps psea pstar qq rr s sav sj sp sq ti tn w wh ws 
do
    echo "\"DefaultInstrumentTerm\",\"DeviceID\",\"DeviceTerm\"" > $outputdir/vessels/$i\_instruments\_$version.csv
    $bindir/edist_list_vesselinst.pl $i >> $outputdir/vessels/$i\_instruments\_$version.csv
done

#
# that's all folks!!
#
