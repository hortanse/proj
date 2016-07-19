#! /usr/bin/perl

use strict;
use warnings;

# a program to match a numerical number
my $natural_number  = qr/^\d+$/;
my $integer_or_digital = qr/^\d+.*\d*$/;
my $positive_or_negative = qr/^[-+]*\d+.*\d*$/;
my $ scientific = qr/^[-+]*\d+.*\d*[eE][-+]*\d+$/;

while(1){
	print "Input a numerical number :";
	chomp(my $line = <>);
	if ($line =~ $natural_number) {
		print "It's a natural number : $line \n";
	}
	elsif ($line =~ $integer_or_digital) {
		print "It's an integer or digital number : $line \n";
	}
	elsif ($line =~ $positive_or_negative) {
		print "It's a positive or negative number : $line \n";
	}
	elsif ($line =~ $scientific){
		print "It's in scientific notation : $line \n";
	}
	else {
		last;
	}
}
