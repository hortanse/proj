#! /usr/bin/perl -w
use strict;
use warnings;

# write a script to generate random DNA sequence of a given length

my $len = 50;
my @bases = ('A', 'T', 'G', 'C');

foreach (1..$len){
	my $code = int(rand @bases); # generate random number between 0 to 3
	print $bases[$code];
}
print "\n";
