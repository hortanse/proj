package Base;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "random_sequence" );

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

#random_sequence( 50 );
#random_sequence( 50 , 1 );


