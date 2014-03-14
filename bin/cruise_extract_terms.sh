#!/bin/bash
# <command> <cruiseid> <term-type>
# this script will only work for newer $1_elogd.cfgs 
# TODO
# ====
# - need to look into updating it to properly parse older $1_elogd.cfgs
# - do error processing
#
# !!! FOR NOW THIS SCRIPT MUST BE RUN FROM THE BIN DIRECTORY IT SITS IN !!!
topcruisedir=../cruises
cruisedir=$topcruisedir/$1
case "$2" in 
  metadata)
    echo "cruiseid,ship,three,four,five,six,seven,eight,nine" 
    sed -n '/# cruise_info.csv/,/# instrument_list.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//'
    ;;
  instruments)
    echo "DeviceID,DeviceTerm,DeviceCatID,DeviceCatTerm,DefaultInstrumentTerm,DeviceDescription,AttrNameUsed,ActionsUsed,State"
    sed -n '/# instrument_list.csv/,/# people.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//' 
    ;;
  persons)
    sed -n '/# people.csv/,/# working_info.csv/p' $cruisedir/$1_elogd.cfg | grep '^#\"' | sed 's/^#//' 
    ;;
  *)
    echo "arg 2 is not a valid string"
    ;;
esac
