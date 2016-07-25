#! /usr/bin/perl
use strict;
use warnings;

use FindBin qw($Bin);
use lib $Bin;
use RestrictionEnzyme;

my $enzyme = RestrictionEnzyme->new( name => 'EcoRI' ); 
#object = class_name constructor 
$enzyme->manufacturer( "Pfzer" ); # setter
my @fragments = $enzyme->cut_dna( "ACGT" );

print $enzyme->name(), ' is manufactured by ', $enzyme->manufacturer(), "\n"; #getter
print "DNA fragments are : @fragments ,\n";
