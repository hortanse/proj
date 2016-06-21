#! /usr/bin/perl
use strict;
use warnings;

sub random_seq{
	my $len = shift;
	#my $random_len = shift;
	my @bases = ('A', 'T', 'G', 'C');

	my @dna;
	foreach (1..$len){                # loop over the base length
        	my $choice = int( rand @bases);   # generate random integer between 0 and 3
        	push @dna, $bases[$choice];            # print out randomly generated bases
    	}
	print @dna;
	print "\n";
	return @dna;
}
#store output into files
my $len = 50;
foreach my $i(1..10){
	#print $i, "\n";
	my $outfile = "out" . $i;
	open OUT_FH, ">", $outfile or die "Can't open file $outfile ($!)";
	my @dna = random_seq($len);
	close OUT_FH;
	}
 
