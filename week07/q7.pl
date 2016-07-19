#! /usr/bin/perl
use strict;
use warnings;

#input a 2-D array and output a transpose format 

my $array2d_ref = [ ['one',   'two', 'three'],
                    ['four',  'five',  'six'],
					['seven', 'eight', 'nine']
					];

# Print out the input array
my $num = scalar @{ $array2d_ref };
print "Input : \n";
foreach my $i (0..$num - 1) {
    foreach my $j (0..$num - 1) {
	    printf "%10s", $array2d_ref->[$i][$j];
	}
	print "\n";
}

# Take transpose of the input array in place
transpose($array2d_ref);

# Print out the output array
print "Output : \n";
foreach my $i (0..$num - 1) {
    foreach my $j (0..$num - 1) {
	    printf "%10s", $array2d_ref->[$i][$j];
	}
	print "\n";
}	

# A function to do the transpose in place
sub transpose {
    my $a_ref = shift;
    my $num = scalar @{ $a_ref };
    foreach my $i (0..$num - 1) {
        foreach my $j ($i..$num - 1) {
	        ($a_ref->[$i][$j], $a_ref->[$j][$i]) = ($a_ref->[$j][$i], $a_ref->[$i][$j]);
	    }
    }
}
