package Base;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(random_base);


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