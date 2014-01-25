#!/bin/bash
# edist_make_vocs.sh <cruiseid>
topdir=~drumbeat/git/cruise_maint
configdir=$topdir/edist_cfg
vocabdir=$topdir/vocabs
bindir=$topdir/bin
outputdir=$topdir/edist_test
#
#
#
rm $outputdir/voc/*
rm $outputdir/vessels/*
#
# copy r2r vocab files from voc dir
#
cp $vocabdir/r2r_person_vocab.tsv $outputdir/voc/person.andytest.tsv
cp $vocabdir/r2r_activitytype_vocab.tsv $outputdir/voc/activitytype.andytest.tsv
cp $vocabdir/r2r_organization_vocab.tsv $outputdir/voc/organization.andytest.tsv
cp $vocabdir/r2r_vessel_vocab.tsv $outputdir/voc/vessel.andytest.tsv
#
# build instruments.csv and instaction.csv
# NOTE: perl funniness below sorts all lines but header in a CSV
#
$bindir/edist_make_instruments.pl > $outputdir/voc/instruments.andytest.csv
$bindir/edist_make_instaction.pl | perl -e 'print scalar <>, sort <>;' | uniq > $outputdir/voc/instactionmap.andytest.csv
$bindir/edist_make_actions.pl | perl -e 'print scalar <>, sort <>;' > $outputdir/voc/actions.andytest.csv

#
# make vessel instrument files
#
for i in ae at bh c cb ch en ew hly hrs hx km kn kok lmg mgl mv mw nbp nh oc pe ps psea pstar qq rr s sav sj sp sq ti tn w wh ws 
do
    echo "\"DefaultInstrumentTerm\",\"DeviceID\",\"DeviceTerm\"" > $outputdir/vessels/$i\_instruments.andytest.csv
    $bindir/edist_list_vesselinst.pl $i >> $outputdir/vessels/$i\_instruments.andytest.csv
done

#
# that's all folks!!
#
