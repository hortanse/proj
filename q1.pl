#! /usr/bin/perl -w
use strict;
use warnings;

my $number = 12;
foreach my $i(1..$number){
	print "\n";
	foreach my $j(1..$number){
	#%6d width 
	printf ("%6d", $i*$j); 
	}
}
print "\n";
