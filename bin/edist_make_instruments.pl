#!/usr/bin/perl -w
# edist_make_instruments.pl 
#
# Brief Description:
# reads instrument master file, extracts instruments destined to be used in the R2R
# eventlogger app and outputs a CSV appropriate for instruments.csv

  use strict;
  use warnings;
  use Tie::Handle::CSV;

  my $file = "../edist_cfg/instruments_master.csv";
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
  # print instruments.csv header
  #
  print "\"DeviceID\",\"DeviceTerm\",\"DeviceDefActions\",\"DeviceCategory\",\"DefaultInstrumentTerm\",\"DeviceDescription\"\n";

  #
  # print instruments.csv rows
  # "R2RE/1034","NOAA SCS data acquisition system","R2RE/9010","data acquisition system","Acqsys","NOAA SCS data acquisition system description goes here"
  while (my $csv_line = <$fh>) {
      if (index($csv_line->{EdistStatus}, "OK") != -1) {
          print "\"" . $csv_line->{VocabID} . "\",\"" . $csv_line->{VocabName} . "\",\"" . $csv_line->{EcfmDefActions} . "\",\"" . $csv_line->{EcfmCategory} . "\",\"" . $csv_line->{EcfmDefName} . "\",\"" . $csv_line->{EcfmDesc} . "\"\n";
      }
      }

  close $fh;
