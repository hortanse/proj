#! /usr/bin/perl

use strict;
use warnings;

#write a program that convert Fahrenheit to Celsius and vise versa

while(1){
	print "Input the temperature scale : \nF for Fahrenheit \nC for Celsius \n";
	chomp(my $scale = <>);
	print "Input the temperature :";
	chomp(my $temp = <>);
	my $tempout;
#Fahrenheit to Celsius conversion
	if ($scale eq 'F'){
		$tempout = 5 * ($temp -32) / 9;
		print "$temp degree Fahrenheit is $tempout degree of Celsius \n\n";
	}
	else if ($scale eq 'C'){
		$tempout = 9 * $temp / 5 + 32;
		print "$temp degree Celsius is $tempout degree of Fahrenheit \n\n";
	}
	else {
		print "Wrong scale : $scale \n";
		last;
	}
}