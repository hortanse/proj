#! /usr/bin/perl -w
use strict;
use warnings;

random_seq(50);
print "\n";
random_seq(50, 1);

sub random_seq{
## write a function to generate random DNA sequence of a given length
	my $len = shift;
	my $random_len = shift;
	my @bases = ('A', 'T', 'G', 'C');

##change the base length to be a number between 1 and length depending on the second argument
	$len = int((rand $len) + 1) if defined $random_len;
	print $len;
	foreach (1..$len){
        	my $code = int(rand @bases); # generate random number between 0 to 3
                print $bases[$code];
                }
                print "\n";
}

