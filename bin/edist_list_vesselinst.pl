#!/usr/bin/perl -w
#
# TODO
# - Make sure VocabID and VocabName match in the instruments files

  use strict;
  use warnings;
  use Tie::Handle::CSV;

#
# Going to parse vessels_master.csv
# VesselID,PreferredName,VocabID,VocabName,Edist,Modified
# ae,CTD911,L22/TOOL0058,Sea-Bird SBE 911plus CTD,Yes,1/24/14
#
  my $file = "../edist_cfg/vessels_master.csv";
  my $csv_parser = Text::CSV_XS->new( { 
     quote_char            => '"',
     escape_char           => '"',
     sep_char              => ',',
     eol                   => $\,
     always_quote          => 0,
     quote_space           => 1,
     quote_null            => 1,
     quote_binary          => 1,
     binary                => 0,
     decode_utf8           => 1,
     keep_meta_info        => 0,
     allow_loose_quotes    => 0,
     allow_loose_escapes   => 0,
     allow_unquoted_escape => 0,
     allow_whitespace      => 0,
     blank_is_undef        => 0,
     empty_is_undef        => 0,
     verbatim              => 0,
     auto_diag             => 0,
     diag_verbose          => 0,
     });

  my $fh = Tie::Handle::CSV->new ($file,
				  header => 1,
				  csv_parser => $csv_parser );

  #
  # print instruments.csv rows
  # "R2RE/1034","NOAA SCS data acquisition system","R2RE/9010","data acquisition system","Acqsys","NOAA SCS data acquisition system description goes here"
  while (my $csv_line = <$fh>) {
      # print $csv_line->{VocabID} . ":\t" . $csv_line->{VocabName} . "\n";
      if ((index($csv_line->{Edist}, "Yes") != -1) && $csv_line->{VesselID} eq $ARGV[0]) {
          print "\"" . $csv_line->{PreferredName} . "\",\"" . $csv_line->{VocabID} . "\",\"" . $csv_line->{VocabName} . "\"\n";
      }
      }

  close $fh;
