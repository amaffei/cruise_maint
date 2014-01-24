#!/Users/drumbeat/perl5/perlbrew/perls/perl-5.18.2/bin/perl

  use strict;
  use warnings;
  use Tie::Handle::CSV;

#
# Going to parse r2re_terms_master.csv
# EntryKey,EntryTerm,TermDescription,TermType,ClosestMap,NvsStatus,AvailVocabTerms,ModifiedDate
# R2RE/1032,WHOI Athena data acquisition system,,DeviceTerm,,tbd,,1/23/14
# R2RE/1037,cruiseStart,Research cruise started,ActionTerm,,tbd,,1/23/14
#
  my $file = "/Users/drumbeat/git/cruise_maint/edist_cfg/r2re_terms_master.csv";
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
  # print actions.csv header
  #
  print "\"ActionTerm\",\"ActionID\",\"ActionDescription\"\n";

  #
  # print actions.csv rows (NOTE: THESE NEED TO BE SORTED LATER)
  # "abort","R2RE/1035","Aborted device operations"
  #
  while (my $csv_line = <$fh>) {
      # print $csv_line->{EcfmID} . ":\t" . $csv_line->{EcfmName} . "\n";
      if ($csv_line->{TermType} eq "ActionTerm") {
	  # print $csv_line->{EcfmID} . ":\t" . $csv_line->{EcfmName} . "\n";
          print "\"" . $csv_line->{EntryTerm} . "\",\"" .$csv_line->{EntryKey} . "\",\"" . $csv_line->{TermDescription} . "\"\n";
      }
      }

  close $fh;
