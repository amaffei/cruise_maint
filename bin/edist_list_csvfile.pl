#!/Users/drumbeat/perl5/perlbrew/perls/perl-5.18.2/bin/perl -w
BEGIN { $Carp::Verbose = 1 }

  use strict;
  use warnings;
  use Tie::Handle::CSV;

# my $file = "/Users/drumbeat/git/cruise_maint/edist_cfg/instruments_master.csv";
  my $file = $ARGV[$1];
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
     auto_diag             => 1,
     diag_verbose          => 1,
     });

  my $csv_fh = Tie::Handle::CSV->new ($file,
				  header => 1,
				  csv_parser => $csv_parser );

  #
  # print instruments.csv header
  #
  print "\"DeviceID\",\"DeviceTerm\",\"DeviceDefActions\",\"DeviceCategory\",\"DefaultInstrumentTerm\",\"DeviceDescription\"\n";

  #
  # print instruments.csv rows
  # "R2RE/1034","NOAA SCS data acquisition system","R2RE/9010","data acquisition system","Acqsys","NOAA SCS data acquisition system description goes here"
  # while (my $csv_line = <$csv_fh>) {
  while (my $csv_line = eval { readline $csv_fh }) {
      print $csv_line, "\n";          ## auto-stringify to CSV line on STDOUT
      }
  close $csv_fh;
