#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

use v5.16;

use Text::CSV::Simple;

my $base = q(/home/jkline/b/books/oreilly/machine-learning-files/johnmyleswhite-ML_for_Hackers-693be94/);
my $datafile = qq($base/01-Introduction/data/ufo/ufo_awesome.tsv);

my $parser = Text::CSV::Simple->new();
my @data = $parser->read_file($datafile);

foreach my $line ( @data) {
  say join ",",@$line;
}
