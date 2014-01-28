#!/Users/drumbeat/perl5/perlbrew/perls/perl-5.18.2/bin/perl

  use strict;
  use warnings;
  use Tie::Handle::CSV;

#
# Going to parse instruments_master.csv
# VocabID,VocabName,EcfmDefName,EcfmCategory,EcfmDefActions,Edist,EcfmDesc,TermUri,ModifiedDate
# R2RE/9011,acqsys,Acqsys,data acquisition system,,Yes,de/multiplexing and timetagging data acquisition system,None,1/23/14
#
  my $file = "/Users/drumbeat/git/cruise_maint/edist_cfg/instruments_master.csv";
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
      if ($csv_line->{Edist} eq "Yes" && $csv_line->{EcfmDefActions} ne "") {
	  # print $csv_line->{EcfmID} . ":\t" . $csv_line->{EcfmName} . "\n";
          print "\"" . $csv_line->{EcfmDefName} . "\",\"" . $csv_line->{EcfmDefActions} . "\"\n";
      }
      }

  close $fh;
