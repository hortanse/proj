#! /usr/bin/perl -w
use strict;
use warnings;

# use subroution to generate multiplication table
print mult_table(5);
print "\n";

sub mult_table{
	my $number = shift;
	foreach my $i(1..$number){
		print "\n";
		foreach my $j(1..$number){
        	#%6d width
			printf ("%6d", $i*$j);
		}
	}
}
