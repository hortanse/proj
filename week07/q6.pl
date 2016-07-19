#! /usr/bin/perl

use strict;
use warnings;

#a program to print out the maximun and minimun of a list of number
print "The maximun of 5, 20, 54, 3, 77, -2 is ", max_num(5, 20, 54, 3, 77, -2), "\n";
print "The minimun of 5, 20, 54, 3, 77, -2 is ", min_num(5, 20, 54, 3, 77, -2), "\n";


#a function to return the maximun of a list of number
sub max_num{
	my @array = @_;
	my $max = $array[0];
	foreach my $i (1..@array - 1){
		if ($array[$i] > $max){
			$max = $array[$i];
		}
	}
return $max;	
}

#a function to return the minimun of a list of number
sub min_num{
	my @array = @_;
	my $min = $array[0];
	foreach my $i (1..@array - 1){
		if ($array[$i] < $min){
			$min = $array[$i];
		}
	}
return $min;	
}