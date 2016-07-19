package ORF;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(translate_dna);

sub translate_dna {
    my $dna = shift;
	print "\nThe original dna is : \n $dna \n";
	my $len = length($dna);
	my @dna_array = split //, $dna;
	my %test;
	foreach (@dna_array) {
	    $test{ $_ }++;
	}
	if (keys %test > 4) {
	    die "\nThere are non-nucleotide characters in the dna sequence! \n";
	}
	my $start_condon = 'ATG';
	my $stop_condon = 'TAA';
	if ($dna !~ /$start_condon/) {
	    print "\nThere is no start condon : $start_condon",
		"\nin the dna sequence : \n", $dna, "\n";
	    return $dna;
	}
	else {
	    my $start_position = index($dna, $start_condon);
		my $stop_position = index($dna, $stop_condon, $start_position + 3);
		if ($stop_position <= -1) {
		    my $dna_sub = substr($dna, $start_position, $len - $start_position);
			print "\nThere is a start condon and no stop condon \n",
	"The translated dna from the start condon to the end of the sequence is : \n",
	$dna_sub, "\n";
	        return $dna_sub;
		}
		else {
		    my $dna_sub = substr($dna, $start_position, $stop_position - $start_position + 3);
			print "\nThere are start condon and stop condon! \n",
			"The dna is : \n", $dna_sub, "\n";
			return $dna_sub;
		}
	}
}