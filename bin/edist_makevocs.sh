#!/bin/bash
# edist_make_vocs.sh [test]
# providing the argument "test" creates files in the edist_test directory, othwewise in edist_files
topdir=~drumbeat/git/cruise_maint
configdir=$topdir/edist_cfg
vocabdir=$topdir/vocabs
bindir=$topdir/bin

if [ "$1" == "test" ]; then
  outputdir=$topdir/edist_test
  version=andytest
else
  outputdir=$topdir/edist_files
  version=`date "+%Y%m%d"`
fi

#
#
#
rm $outputdir/voc/*
rm $outputdir/vessels/*
#
# copy r2r vocab files from voc dir
#
cp $vocabdir/r2r_person_vocab.tsv $outputdir/voc/person.$version.tsv
cp $vocabdir/r2r_activitytype_vocab.tsv $outputdir/voc/activitytype.$version.tsv
cp $vocabdir/r2r_organization_vocab.tsv $outputdir/voc/organization.$version.tsv
cp $vocabdir/r2r_vessel_vocab.tsv $outputdir/voc/vessel.$version.tsv
#
# build instruments.csv and instaction.csv
# NOTE: perl funniness below sorts all lines but header in a CSV
#
$bindir/edist_make_instruments.pl  > $outputdir/voc/instruments.$version.csv
$bindir/edist_make_actions.pl | perl -e 'print scalar <>, sort <>;' > $outputdir/voc/actions.$version.csv
#
# make instactionmap.csv
#
echo "\"EventTerm\",\"DefaultActionTerms\"" > $outputdir/voc/instactionmap.$version.csv
echo "\"ALL\",\"deploy;recover;service;other;startSample;stopSample;maxDepth;abort;startLine;endLine;abortLine;start;end;faultGPS;faultGyro;startCruise;endCruise;startTransect;endTransect;startStation;endStation;startSafetydrill;endSafetydrill;maxextensionWire;maxspeedWire;release\"" >> $outputdir/voc/instactionmap.$version.csv
$bindir/edist_make_instaction.pl | perl -e 'print scalar <>, sort <>;' | uniq >> $outputdir/voc/instactionmap.$version.csv
#
# make vessel instrument files
#
for i in ae at bh c cb ch en ew hly hrs hx km kn kok lmg mgl mv mw nbp nh oc pe ps psea pstar qq rr s sav sj sp sq ti tn w wh ws 
do
    echo "\"DefaultInstrumentTerm\",\"DeviceID\",\"DeviceTerm\"" > $outputdir/vessels/$i\_instruments.$version.csv
    $bindir/edist_list_vesselinst.pl $i >> $outputdir/vessels/$i\_instruments.$version.csv
done

#
# that's all folks!!
#
