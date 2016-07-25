package RestrictionEnzyme_q2;

=head1 NAME

    Enzyme - The restriction enzyme package

=head1 VERSION

    Version 0.01

=head1 SYNOPSIS

    use RestrictionEnzyme_q2;
    my $object = RestrictionEnzyme->new();
    $object->name( "EcoRI" );
    $object->manufacturer( "Pfzer" );
    $object->recognition( "CCCGGG" );
    my $seq = 'ACGT';
    my @fragments = $object->cut_dna( $seq );
    print "$object->name(), $object->manufacturer(), $object->recognition(), \n",
          "@fragments \n";

=head1 DESCRIPTION

    A package to create an object of Restriction Enzyme with attributes,
    name, manufacturer, and recognition sequence, and amethod to cut
    the input DNA into fragments.

=cut

use Moose;

use Moose::Util::TypeConstraints;
subtype 'DnaBases' => as 'Str' => where { $_ =~ /^[ACGT]+$/i };


has name => ( is => 'rw' , isa => 'Str' , );
has manufacturer => ( is => 'rw' , isa => 'Str' , );
has recognition => ( is => 'rw' , isa => 'DnaBases' , );

no Moose;

sub cut_dna {
    my $self = shift;
	my $dna = shift;
	my @fragments = split //, $dna;
	return @fragments;
}

1;