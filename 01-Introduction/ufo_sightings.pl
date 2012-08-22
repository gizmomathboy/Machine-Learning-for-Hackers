#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use v5.16;

use Text::CSV::Simple;
use Data::Dumper;

my $base = q(/home/jkline/b/books/oreilly/machine-learning-files/johnmyleswhite-ML_for_Hackers-693be94/);
my $datafile = qq($base/01-Introduction/data/ufo/ufo_awesome.tsv);

my $parser = Text::CSV::Simple->new({
     quote_char          => '"',
     escape_char         => '"',
     sep_char            => "\t",
  }
);
$parser->field_map(qw/DateOccurred DateReported Location 
                      ShortDescription Duration LongDescription/);
my @data = $parser->read_file($datafile);

my @good_data = grep { length $_->{DateOccurred} == 8 
                       &&
                       length $_->{DateReported} == 8
                      } @data;
my %states = map { $_ => 1 } qw(ak al ar az ca co ct
               de fl ga hi ia id il
               in ks ky la ma md me
               mi mn mo ms mt nc nd
               ne nh nj nm nv ny oh
               ok or pa ri sc sd tn
               tx ut va vt wa wi wv
               wy);
#say Dumper(\%states);
#exit(0);
my (@us_only);
for my $line ( @good_data) {
  my @clean_location = split(/\s*,\s*/, $line->{Location});

=pod
  say scalar @clean_location;
  say '>>>',$clean_location[1],'<<<<';
  say $states{ lc $clean_location[1] };
  next;
=cut

  if ( @clean_location == 2
      &&
       exists $states{ lc $clean_location[1]} ) {
      #say join ",", @clean_location;
      $line->{city} = $clean_location[0];
      $line->{state} = lc $clean_location[1];
      push (@us_only, $line);
  }
}
say scalar @data; 
say scalar @good_data;
say scalar @us_only;
say scalar grep { $_->{state} eq 'in' } @us_only;
say Dumper($us_only[0]);
#say join "\n",@{$data[0]};
#foreach my $line ( @data) {
  #say join ",",@$line;
#}
