package Base;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(random_base);


=head1 NAME
    Base    generate random base sequence of a given length
	
=cut

=head1 SYNOPSIS
    use Base;
	my $dna = random_base($length);
	print $dna;
	print "\n";
	my $dna = random_base($length, $random_length);
	print $dna;
	
=cut
	
=head1 DESCRIPTION
    The routine random_base allows you to generate random base sequence
	with length given by the first parameter
	or with length between 1 and the one given by the first parameter
	when the second parameter defined
	sample outputs are:
	TTCTGTGTGTGAGGCATGTCTCTTCATTGGACTATACATTACAGTCGGGA
	and
	CGCATTCTACAAACC
	
=cut

sub random_base {
    my $length = shift;
    my $random_length = shift;
    my @bases = qw(A C G T);

# change the base length to be a number between 1 and length depending on the second argument
# being defined
    $length = int( (rand $length) + 1) if defined $random_length; 

	my $dna;
    foreach (1..$length) {                # loop over the base length
        my $choice = int( rand @bases);   # generate random integer between 0 and 3
		$dna .= $bases[$choice];
    }
	return $dna;
}

1;