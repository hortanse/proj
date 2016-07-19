#! /usr/bin/perl
use strict;
use warnings;

use FindBin qw($Bin);
use lib $Bin;

use Base qw(random_base);
use ORF  qw(translate_dna);
foreach (0..20) {
    my $dna = random_base(50);
    translate_dna($dna);
}