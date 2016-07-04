#! /usr/bin/perl
use strict;
use warnings;

sub random_nucleotide {
	my $length = shift;
	my @bases = qw(A C G T U);
	my $seq;
	foreach (1..$length) {                # loop over the base length
		my $choice = int( rand @bases);   # generate random integer between 0 and 4
		$seq .= $bases[$choice];
	}
	return $seq;
}

sub random_amino_acid {
	my $length = shift;
	my @bases = qw(A R N D C E Q G H I L K M F P S T W Y V U O);
	my $seq;
	foreach (1..$length) {                # loop over the base length
		my $choice = int( rand @bases);   # generate random integer between 0 and 21
		$seq .= $bases[$choice];
	}
	return $seq;
}


my $length = 50;
use CGI(':standard');

my $title = 'answer to question 3 of week05 homework';
print header,
	start_html( $title ),
	h1( $title );

# handle processing of form if this is a submission
if( param( 'submit' )) {
	my $choice = param( 'choice' );
	my $sequence;
	print p("Your choice is '$choice'.");
	if ($choice eq 'nucleotide') {
		$sequence = random_nucleotide($length);
	}
        else {
		$sequence = random_amino_acid($length);
	}
	print p("The sequence is : "), p(" $sequence ");
}
