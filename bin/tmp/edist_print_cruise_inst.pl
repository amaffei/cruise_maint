#!/Users/drumbeat/perl5/perlbrew/perls/perl-5.18.2/bin/perl

  use strict;
  use warnings;
  use Tie::Handle::CSV;

  my $file = "/Users/drumbeat/git/cruise_maint/edist_cfg/cruises_instruments.csv";
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

  while (my $csv_line = <$fh>) {
      print $csv_line->{CruiseID} . ":\t" . $csv_line->{DeviceID} . "\n";
      }

  close $fh;
