#! /usr/bin/perl
use strict;
use warnings;

use Storable;
my $dna_ref = retrieve( 'dna_file' );
my @bases = qw(A C G T);
my $seq_number = 10;

foreach my $base (@bases) {
	foreach my $i (0..$seq_number - 1) {
		if ( $dna_ref->[$i] =~ m/$base{4}/ ) {    # matching at exact four base run
			print "$base run found in DNA : \n $dna_ref->[$i] \n";
		}
		else {
#        print "$base run not been found in DNA : \n $dna_ref->[$i] \n";
		}
	}
}
