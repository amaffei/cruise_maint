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
# make vessels files
#
cp $configdir/vessels/ae_instlist.csv $outputdir/vessels/ae_instruments.andytest.csv
cp $configdir/vessels/at_instlist.csv $outputdir/vessels/at_instruments.andytest.csv
cp $configdir/vessels/bh_instlist.csv $outputdir/vessels/bh_instruments.andytest.csv
cp $configdir/vessels/c_instlist.csv $outputdir/vessels/c_instruments.andytest.csv
cp $configdir/vessels/cb_instlist.csv $outputdir/vessels/cb_instruments.andytest.csv
cp $configdir/vessels/ch_instlist.csv $outputdir/vessels/ch_instruments.andytest.csv
cp $configdir/vessels/en_instlist.csv $outputdir/vessels/en_instruments.andytest.csv
cp $configdir/vessels/ew_instlist.csv $outputdir/vessels/ew_instruments.andytest.csv
cp $configdir/vessels/hly_instlist.csv $outputdir/vessels/hly_instruments.andytest.csv
cp $configdir/vessels/hrs_instlist.csv $outputdir/vessels/hrs_instruments.andytest.csv
cp $configdir/vessels/hx_instlist.csv $outputdir/vessels/hx_instruments.andytest.csv
cp $configdir/vessels/km_instlist.csv $outputdir/vessels/km_instruments.andytest.csv
cp $configdir/vessels/kn_instlist.csv $outputdir/vessels/kn_instruments.andytest.csv
cp $configdir/vessels/kok_instlist.csv $outputdir/vessels/kok_instruments.andytest.csv
cp $configdir/vessels/lmg_instlist.csv $outputdir/vessels/lmg_instruments.andytest.csv
cp $configdir/vessels/mgl_instlist.csv $outputdir/vessels/mgl_instruments.andytest.csv
cp $configdir/vessels/mv_instlist.csv $outputdir/vessels/mv_instruments.andytest.csv
cp $configdir/vessels/mw_instlist.csv $outputdir/vessels/mw_instruments.andytest.csv
cp $configdir/vessels/nbp_instlist.csv $outputdir/vessels/nbp_instruments.andytest.csv
cp $configdir/vessels/nh_instlist.csv $outputdir/vessels/nh_instruments.andytest.csv
cp $configdir/vessels/oc_instlist.csv $outputdir/vessels/oc_instruments.andytest.csv
cp $configdir/vessels/pe_instlist.csv $outputdir/vessels/pe_instruments.andytest.csv
cp $configdir/vessels/ps_instlist.csv $outputdir/vessels/ps_instruments.andytest.csv
cp $configdir/vessels/psea_instlist.csv $outputdir/vessels/psea_instruments.andytest.csv
cp $configdir/vessels/pstar_instlist.csv $outputdir/vessels/pstar_instruments.andytest.csv
cp $configdir/vessels/qq_instlist.csv $outputdir/vessels/qq_instruments.andytest.csv
cp $configdir/vessels/rr_instlist.csv $outputdir/vessels/rr_instruments.andytest.csv
cp $configdir/vessels/s_instlist.csv $outputdir/vessels/s_instruments.andytest.csv
cp $configdir/vessels/sav_instlist.csv $outputdir/vessels/sav_instruments.andytest.csv
cp $configdir/vessels/sj_instlist.csv $outputdir/vessels/sj_instruments.andytest.csv
cp $configdir/vessels/sp_instlist.csv $outputdir/vessels/sp_instruments.andytest.csv
cp $configdir/vessels/sq_instlist.csv $outputdir/vessels/sq_instruments.andytest.csv
cp $configdir/vessels/ti_instlist.csv $outputdir/vessels/ti_instruments.andytest.csv
cp $configdir/vessels/tn_instlist.csv $outputdir/vessels/tn_instruments.andytest.csv
cp $configdir/vessels/w_instlist.csv $outputdir/vessels/w_instruments.andytest.csv
cp $configdir/vessels/wh_instlist.csv $outputdir/vessels/wh_instruments.andytest.csv
cp $configdir/vessels/ws_instlist.csv $outputdir/vessels/ws_instruments.andytest.csv
