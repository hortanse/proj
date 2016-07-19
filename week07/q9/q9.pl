#! /usr/bin/perl
use strict;
use warnings;

use Test::Simple tests => 100;
use FindBin qw($Bin);
use lib $Bin;
use Base qw(random_base);
use ORF qw(translate_dna);

my $len = 50;
foreach (1..20) {
    my $dna = random_base($len);
    my $dna_trans = translate_dna($dna);

    ok(length($dna)==$len, "original string length checks");
    ok($dna =~ /^[ACGT]{$len}$/i, "string composition checks");
    ok($dna_trans =~ /ATG/i, "start condon checks");
	ok($dna_trans =~ /TAA$/i, "stop condon checks");
    ok($dna_trans =~ /^[ACGT]*ATG[ACGT]*TAA$/i, "start and stop condons check");
}