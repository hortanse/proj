#! /usr/bin/perl
use strict;
use warnings;

#Place the function from last week's "two argument" random DNA generation question 
#into a module. The module should export the function.

#use lib '/home/ychou7/proj/week04';
## please change this directory to your directory point to Base.
use Base ('random_sequence');

print random_sequence( 50 );
print "\n";
print random_sequence( 50 , 1 );
print "\n";

