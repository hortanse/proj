#! /usr/bin/perl
use strict;
use warnings;

use Bio::Perl;

my $data_in    = 'twist.fasta';
my $data_blast = 'out.blast';

# parse the fasta input file $data_in
my @seq;
open IN_FH, "<", "$data_in"
     or die "Can't open $data_in ($!)";
	 
while (<IN_FH>) {
    chomp;
	if ( /^>/ ) {
	    my ( $name ) = split /\|/, $_;
		$name =~ s/^>//;
		$name =~ s/\s/_/g;
		push @seq, {name => $name};
	}
	else {
	    $seq[-1]{sequence} .= $_;
	}
}
close IN_FH;

# print out the name and sequence}
foreach my $seq_out (@seq) {
    print "
        NAME     : $seq_out->{name} \n
		SEQUENCE : $seq_out->{sequence} \n
	";
}

# select the names of sequences to blast
my @select;
while (1) {
    print "input the name of the sequence to blast or q to quit : ";
	my $name = <>;
	chomp($name);
	last if $name eq 'q';
	push @select, $name;
}
# print out selected sequence name to blast
print "\n selected name : @select \n";

# blast the selected sequences

foreach my $sel (@select) {
    print "selected : $sel \n";
    foreach my $seq_blast (@seq) {
	    if ( $sel eq $seq_blast->{name} ) {
		    print "\n sequence out : $seq_blast->{name} \n";
		    my $protein = translate( $seq_blast->{sequence} );
			my $blast = blast_sequence( $protein )
			    or die "Can't blast this way";
			write_blast( ">>$data_blast", $blast);
		}
	}
}

