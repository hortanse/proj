#! /usr/bin/perl
use strict;
use warnings;

#Use Test::Simple to produce a simple test framework that exercises the module from 
#the previous questions.

use Test::Simple tests => 2;
use Base_q3 'random_sequence'; #what I am testing.

my $dna = random_sequence(50);
my $len = 50;

ok ( length($dna) == $len, "string length checks" );
ok ( $dna =~ /^[ACGT]{$len}$/i, "string composition checks" );
