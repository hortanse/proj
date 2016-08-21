#This is set two question 1

package Protein;

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(random_protein);

sub random_protein {
    my $length = shift;
	my $random_length = shift;
    my @bases = qw(A R N D C E Q G H I L K M F P S T W Y V U O);
	
# change the base length to be a number between 1 and length depending on the second argument
# being defined
    $length = int( (rand $length) + 1) if defined $random_length; 
	
    my $seq;
    foreach (1..$length) {                 # loop over the base length
        my $choice = int( rand @bases );   # generate random integer between 0 and 21
        $seq .= $bases[$choice];
    }
	return $seq;
}

1;