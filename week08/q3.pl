#! /usr/bin/perl
use strict;
use warnings;

use FindBin qw($Bin);
use lib $Bin;
use RestrictionEnzyme_q3;

# test defaults
my $enzyme = RestrictionEnzyme_q3->new();

my @fragments = $enzyme->cut_dna( "ACCGGT" );

print $enzyme->name(), ' is manufactured by ', $enzyme->manufacturer(), "\n";
print "recognition sequence : ", $enzyme->recognition(), "\n";
print "DNA fragments are : @fragments ,\n";

# test inputs
$enzyme = RestrictionEnzyme_q3->new( name => 'EcoRI' );  #test constructor
$enzyme->manufacturer( "Klaxan" );  #test method
$enzyme->recognition( "AAATTT" );
@fragments = $enzyme->cut_dna( "ACCGGT" );

print $enzyme->name(), ' is manufactured by ', $enzyme->manufacturer(), "\n";
print "recognition sequence : ", $enzyme->recognition(), "\n";
print "DNA fragments are : @fragments ,\n";
