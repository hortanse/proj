#! /usr/bin/perl
use strict;
use warnings;

#Write a simple program with a hard-coded hash of arrays. The program should print 
#out the hash of arrays when run.

my @a1 = qw/GGA GGC GGG GGT/;
my @a2 = qw/CGA CGC CGG CGT/;
my $hoa_ref = {glycin => \@a1, arginine => \@a2};

foreach (keys %$hoa_ref){
	print "$_ : @{$hoa_ref->{$_}}\n";
}
