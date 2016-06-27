#Modify the module from the previous question by adding documentation (in POD format)
#to explain the two ways the function can be called and the different results of each.

package Base_q3;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "random_sequence" );

=head1 NAME
	Base_q3	generate random base sequence of a given length
	
=cut

=head1 SYNOPSIS
	use Base_q3;
		my $dna = random_sequence($length);
		print $dna;
		print "\n";
		my $dna = random_requence($length, $random_length);
		print $dna;
	
=cut
	
=head1 DESCRIPTION
	The routine random_sequence allows you to generate random sequence
	with length given by the first parameter = 50,
	or with length between 1 and the one given by the first parameter
	when the second parameter defined
	sample outputs are:
	TTCTGTGTGTGAGGCATGTCTCTTCATTGGACTATACATTACAGTCGGGA
	and
	CGCATTCTACAAACC
	
=cut

my @bases = qw/ A C G T /;
my $length = 50;

sub random_sequence {
        my( $length , $random_length ) = @_;

        if ( $random_length ) {
                $length = int( rand( $length ));
        }
        my $dna;
        foreach ( 1 .. $length ) {
                $dna .= $bases[int(rand(4))];
        }
        return $dna;
}

1;
