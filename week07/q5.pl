#! /usr/bin/perl

use strict;
use warnings;

my %bases = ( A => 2,
			  T => 2,
			  C => 4,
			  G => 4,
			);
while (1){
	print "Input the oligo sequence or press q to exit :";
	chomp(my $oligo = <>);
	last if $oligo eq 'q';
	my @oligo_bases = split //, $oligo;
	
	my %result; #find the number of each base
	foreach (@oligo_bases) {
		$result{ $_ }++;
	}
	#calculate annealing temperature 
	my $temp;
	foreach(keys %bases) {
		$temp += $bases{ $_} * $result{ $_};
	}
	#print "$temp";
	#find the GC content of the oligo
	my @gc = ('G', 'C');
	my $content;
	foreach(@gc){
		$content += $result{ $_ };
	}
	$content = $content * 100 / length($oligo);

	print "The oligo = $oligo \n and annealing temp is $temp degree C\n The GC content = $content\% \n";
}