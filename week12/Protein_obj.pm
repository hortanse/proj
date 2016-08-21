#This is set two question 3

package Protein_obj;
use Moose;

no Moose;

sub random_protein {
    my ($self, $length, $random_length) = @_;

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

__PACKAGE__->meta->make_immutable;

1;
