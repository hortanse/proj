package RestrictionEnzyme;
use Moose;

use Moose::Util::TypeConstraints;
subtype 'DnaBases' => as 'Str' => where { $_ =~ /^[ACGT]+$/i };

# has attributes
has name => ( is => 'rw' , isa => 'Str' , );
has manufacturer => ( is => 'rw' , isa => 'Str' , );
has recognition => ( is => 'rw' , isa => 'DnaBases' , );

no Moose;  # can save computer time because Moose use a lot of computer time.

#method
sub cut_dna {
    my $self = shift;
	my $dna = shift;
	my @fragments = split //, $dna;
	return @fragments;
}

1;