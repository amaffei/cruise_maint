#!/Users/drumbeat/perl5/perlbrew/perls/perl-5.18.2/bin/perl
#!/usr/bin/perl -w
#
# History:
#---------------------------------------------------------------------------------
# 2011/12/21   lstolp 	created
#                       wgets voc from rvdata.us
#                       creates symbolic link to latest voc
#			writes to logfile, need to rotate
# 2012/03/19   SL 	Updated to only get/save voc files if they have changed,
#                       and update symbolic links to most current download.
#                       Added perl -w, getopts.pl, -d option, and use strict
# 2012/03/23   SL       Added interface google-docs to get instrument voc 
#                       work still needs TBD here - so commented-out (6/25/2012)
# 2012/07/24   SL       Verify datadir exists
# 2013/02/06   ARM	Get ship instrument vocabs from rvdata.us now
# 2013/02/07   CJS      Add more ships to list re ARM
# 2013/02/11   CJS      Took out qq and wh from list of ships
# 2013/02/20   CJS      Added sq to list of ships (R/V Sikuliaq - Alaska)
# 2013/02/22   CJS      trying again to add 'sq' correctly
# 2013/03/05   CJS      adding code from ARM for instruments
# 2013/03/11   CJS      instruments code changes debugged and tested (comment about googledocs changed)
# 2013/03/22   CJS      sorting instruments file after wget
# 2013/04/05   CJS      changed to case insensitive sort of instruments
# 2014/01/27   ARM      modifying to use as part of cruise_maint system
#---------------------------------------------------------------------------------
#require "getopts.pl";
require "/Users/drumbeat/perl5/perlbrew/perls/perl-5.16.0/lib/site_perl/5.16.0/getopts.pl";
use strict;

## change this if using on a different computer
#my $datadir  = "/shipdata/CRUISE.TEMPLATE/r2r/info/voc/";
#my $ERRORLOG_FILE = "/shipdata/logfiles/getvoc.log";
my $datadir  = "/Users/drumbeat/git/cruise_maint/edist_test/voc/";
my $ERRORLOG_FILE = "/tmp/r2r_getvoc.log";


# Turns basic debuging on and off
my $Debug   = 1;


my $VERSION = "v2.0-20130306";

our $opt_d;
&Getopts('d'); 
if ($opt_d) {$Debug = 1;}

#make sure datadir exists
if (! -d "$datadir") {die "***voc dir [$datadir] does not exist - exiting\n";}

my $url = "http://get.rvdata.us/services/voc/?id=";
# do not need devicetype
my @infofiles = qw/activitytype organization person vessel/;

# construct expected backup filename
#my $date = `date '+%Y%m%d' -u`;
my $date = `date '+%Y%m%d'`;
chomp $date;
print "\$date = $date\n" if ($Debug);


# Remove previous logfile (if any)
if (-f "$ERRORLOG_FILE") {system "/bin/rm -f $ERRORLOG_FILE";}


my($file, $outfile, $tmpfile, $diff_results);



#
# get the info/tsv files from rvdata
#
foreach $file (@infofiles)
   {
     $tmpfile = "$file.$date.tmp";
     $outfile = "$file.$date.tsv";
     my $infourl = "$url" . "$file";
     print STDERR "\$infourl = $infourl\n" if ($Debug);
     system "wget $infourl -O $datadir/$tmpfile >> $ERRORLOG_FILE 2>&1";
     $diff_results = `diff -q $datadir/$tmpfile $datadir/$file.tsv`;
     if (! -f "$datadir/$file.tsv" || $diff_results =~ /differ/i) 
          {`echo "\n===> $outfile differs from $file.tsv, updating $file.tsv \n\n" >> $ERRORLOG_FILE`;
           `/bin/mv $datadir/$tmpfile $datadir/$outfile`;
           `cd $datadir && /bin/ln -sf $outfile $file.tsv`;
           }
     else {`/bin/rm $datadir/$tmpfile`;
           }
   }     

##
## Get the vessel instrument csv files from Rvdata.us
##
##my @vessels = qw/at ch en kn mv oc tn/;
## my @vessels = qw/ae at bh c cb ch en ew hly hrs hx kok km kn lmg mgl mv mw nbp nh oc pe ps psea pstar qq rr s sp sav sj tn ti w wh ws/;
#my @vessels = qw/ae at bh c cb ch en ew hly hrs hx kok km kn lmg mgl mv mw nbp nh oc pe ps psea pstar rr s sp sav sj sq tn ti w ws/;
##$datadir  = "../../CRUISE.TEMPLATE/r2r/info/vessels";
#foreach my $vessel (@vessels)
#  {$url = "http://get.rvdata.us/eloginstrument/$vessel";
#   `echo "==> Getting $vessel Instrument CSV file <==\n" >> $ERRORLOG_FILE`;
#   print STDERR "\$url = $url\n" if ($Debug);
#   $file    = "$vessel\_instruments";
#   $tmpfile = "$file.$date.tmp";
#   $outfile = "$file.$date.csv";
##   system "wget $url -O $datadir/$tmpfile >> $ERRORLOG_FILE 2>&1";
#   system "wget $url -O /tmp/$tmpfile >> $ERRORLOG_FILE 2>&1";
#
#   #
#   # Read tmp vocab file, change from tsv to csv, and re-arrange columns of data for output
#   #
#   my($IN_FD,$OUT_FD);
#   open($IN_FD,"</tmp/$tmpfile") || warn "***Unable to open /tmp/$tmpfile\n";
#   open($OUT_FD,">$datadir/$tmpfile") || warn "***Unable to open $datadir/$tmpfile for writing\n";
#   print $OUT_FD "\"DefaultInstrumentTerm\",\"DeviceID\",\"DeviceTerm\"\n";
#   my ($line);
#   while ($line = <$IN_FD>)
#     {chomp($line);
#      my (@fields) = split('\t',$line);
#      print $OUT_FD "\"$fields[6]\",\"$fields[2]\",\"$fields[3]\"\n";
#      }
#   close ($IN_FD);
#   close ($OUT_FD);
#
#   $diff_results = `diff -q $datadir/$tmpfile $datadir/$file.csv`;
#   if (! -f "$datadir/$file.csv" || $diff_results =~ /differ/i) 
#          {`echo "\n===> $outfile differs from $file.csv, updating $file.csv \n\n" >> $ERRORLOG_FILE`;
#           `/bin/mv $datadir/$tmpfile $datadir/$outfile`;
#           `cd $datadir && /bin/ln -sf $outfile $file.csv`;
#           }
#     else {`/bin/rm $datadir/$tmpfile`;
#           }
#   }
#
#
# Get the instrument csv files from Rvdata.us
#
#$datadir  = "../../CRUISE.TEMPLATE/r2r/info/voc";
#my $infofile = "instruments";
## $url = "http://get.rvdata.us/eloginstrument/eloginstrumentprod";
#$url = "http://get.rvdata.us/eloginstrumentprod";
#`echo "==> Getting $infofile file <==\n" >> $ERRORLOG_FILE`;
#print STDERR "\$url = $url\n" if ($Debug);
#$tmpfile = "$infofile.$date.tmp";
#$outfile = "$infofile.$date.csv";
##   system "wget $url -O $datadir/$tmpfile >> $ERRORLOG_FILE 2>&1";
##system "wget $url -O /tmp/$tmpfile >> $ERRORLOG_FILE 2>&1";
##system "wget $url -O /tmp/xxx.tmp >> $ERRORLOG_FILE 2>&1 | sort -t \$'\t' -k2 > /tmp/$tmpfile";
## the space between the '   ' is an actual TAB (<ctl>-v TAB) added using vi
##system "wget $url -O /tmp/xxx.tmp >> $ERRORLOG_FILE 2>&1 | sort -t '	' -k2,2 > /tmp/$tmpfile";
## ended up using Perl sort. Restore original line here:
#system "wget $url -O /tmp/$tmpfile >> $ERRORLOG_FILE 2>&1";
##
## Read tmp vocab file, change from tsv to csv, and re-arrange columns of data for output
##
#my($IN_FD,$OUT_FD);
#open($IN_FD,"</tmp/$tmpfile") || warn "***Unable to open /tmp/$tmpfile\n";
#open($OUT_FD,">$datadir/$tmpfile") || warn "***Unable to open $datadir/$tmpfile for writing\n";
#print $OUT_FD
##"\"DeviceID\",\"DeviceTerm\",\"DeviceCatID\",\"DeviceCatTerm\",\"DefaultInstrumentTerm\",\"DeviceDescription\",\"Notes\"\n";
#"\"DeviceID\",\"DeviceTerm\",\"DeviceCatID\",\"DeviceCatTerm\",\"DefaultInstrumentTerm\",\"DeviceDescription\"\n";
#
#my(@lines,@sorted_lines,$sorted_line,@fields,$fields);
#
## read in all the lines and chomp them:
#chomp(@lines = <$IN_FD>);
#
## get rid of the first line (header)
#shift(@lines);
#
## sort the lines by the 5th column:
#@sorted_lines = 
#    map  { $_->[0] }
#sort { lc $a->[5] cmp lc $b->[5] }
#map  { [$_, (split /\t/) ] } @lines;
#
## print the results line by line
#foreach $sorted_line(@sorted_lines) {
#    @fields=split /\t/, $sorted_line;
#    print $OUT_FD "\"$fields[0]\",\"$fields[1]\",\"$fields[2]\",\"$fields[3]\",\"$fields[4]\",\"$fields[5]\"\n";
#}
#
## old stuff below here:
##my ($line);
##while ($line = <$IN_FD>)
##{chomp($line);
## my (@fields) = split('\t',$line);
## print $OUT_FD "\"$fields[0]\",\"$fields[1]\",\"$fields[2]\",\"$fields[3]\",\"$fields[4]\",\"$fields[5]\",\"$fields[6]\"\n";
## print $OUT_FD "\"$fields[0]\",\"$fields[1]\",\"$fields[2]\",\"$fields[3]\",\"$fields[4]\",\"$fields[5]\"\n";
##}
#### now continue with orig code
#
#close ($IN_FD);
#close ($OUT_FD);
#
#$diff_results = `diff -q $datadir/$tmpfile $datadir/$infofile.csv`;
#if (! -f "$datadir/$infofile.csv" || $diff_results =~ /differ/i) 
#{`echo "\n===> $outfile differs from $infofile.csv, updating $infofile.csv \n\n" >> $ERRORLOG_FILE`;
# `/bin/mv $datadir/$tmpfile $datadir/$outfile`;
# `cd $datadir && /bin/ln -sf $outfile $infofile.csv`;
#}
#else {`/bin/rm $datadir/$tmpfile`};
#
#
