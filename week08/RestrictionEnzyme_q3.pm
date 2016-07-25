package RestrictionEnzyme_q3;
use strict;
use warnings;

# default name, manufacturer, and recognition sequence
my %defaults = ( name         => 'EcoRI' ,
                manufacturer => 'Pfzer' ,
				recognition  => 'CCCGGG',
				);

# constructor
sub new {
    my( $class, %attribs ) = ( @_ );
    %attribs = ( %defaults, %attribs );
    bless \%attribs, $class;
}

# attributes setter and getter
sub name {        $_[0]->{ name }       = $_[1] if defined $_[1]; $_[0]->{ name }; }
sub manufacturer {$_[0]->{manufacturer} = $_[1] if defined $_[1]; $_[0]->{manufacturer};}
sub recognition { $_[0]->{recognition}  = $_[1] if defined $_[1]; $_[0]->{recognition};}

# DNA cutter method
sub cut_dna {
    my $self = shift;
	my $dna = shift;
	my @fragments = split //, $dna;
	return @fragments;
}

1;