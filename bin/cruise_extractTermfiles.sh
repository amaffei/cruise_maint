#!/bin/bash
# extract_csvs.sh <cruiseid>
# this script will only work for newer $1_elogd.cfgs 
# need to look into updating it to properly parse older $1_elogd.cfgs
topcruisedir=~drumbeat/git/cruise_maint/cruises
cruisedir=$topcruisedir/$1
#
# Cruise Metadata
# Need to find proper header for cruise metadata. This one made up.
#
echo "cruiseid,ship,three,four,five,six,seven,eight,nine" > $cruisedir/$1_cruisemeta.csv
sed -n '/# cruise_info.csv/,/# instrument_list.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//'  >> $cruisedir/$1_cruisemeta.csv
#
# Cruise Instruments
#
echo "DeviceID,DeviceTerm,DeviceCatID,DeviceCatTerm,DefaultInstrumentTerm,DeviceDescription,AttrNameUsed,ActionsUsed,State" > $cruisedir/$1_instruments.csv
sed -n '/# instrument_list.csv/,/# people.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//'  >> $cruisedir/$1_instruments.csv
#
# Cruise Persons
# For some reason headers included in this csv but not others so no separate header written
#
sed -n '/# people.csv/,/# working_info.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//' > $cruisedir/$1_person.csv
