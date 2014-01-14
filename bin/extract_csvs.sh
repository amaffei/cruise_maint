#!/bin/bash
# extract_csvs.sh <cruiseid>
# this script will only work for newer elogd.cfgs 
# need to look into updating it to properly parse older elogd.cfgs
topcruisedir=~drumbeat/git/r2relogvocabs/cruises
cruisedir=$topcruisedir/$1
#
# Cruise Metadata
# Need to find proper header for cruise metadata. This one made up.
#
echo "cruiseid,ship,three,four,five,six,seven,eight,nine" > $cruisedir/ecfm_cruisemeta.csv
sed -n '/# cruise_info.csv/,/# instrument_list.csv/p' $cruisedir/elogd.cfg | grep '^#\"' | sed 's/^#//'  >> $cruisedir/ecfm_cruisemeta.csv
#
# Cruise Instruments
#
echo "DeviceID,DeviceTerm,DeviceCatID,DeviceCatTerm,DefaultInstrumentTerm,DeviceDescription,AttrNameUsed,ActionsUsed,State" > $cruisedir/ecfm_instruments.csv
sed -n '/# instrument_list.csv/,/# people.csv/p' $cruisedir/elogd.cfg | grep '^#\"' | sed 's/^#//'  >> $cruisedir/ecfm_instruments.csv
#
# Cruise Persons
# For some reason headers included in this csv but not others so no separate header written
#
sed -n '/# people.csv/,/# working_info.csv/p' $cruisedir/elogd.cfg | grep '^#\"' | sed 's/^#//' > $cruisedir/ecfm_person.csv
