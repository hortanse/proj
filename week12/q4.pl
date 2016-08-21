##This is set 2 question 4
##To run this script do: ./q4.pl infile infileformat outfile outfileformat

#! /usr/bin/perl

use strict;
use warnings;
use Bio::SeqIO;

# get command-line arguments, or die with a usage statement
my $usage = "x2y.pl infile infileformat outfile outfileformat "; 
my $infile = shift or die $usage;  ## shift @ARGV;
my $infileformat = shift or die $usage; 
my $outfile = shift or die $usage; 
my $outfileformat = shift or die $usage;

# create one SeqIO object to read in,and another to write out
my $seq_in = Bio::SeqIO->new( -file   => "$infile",
                              -format => $infileformat,
                            );

my $seq_out = Bio::SeqIO->new( -file   => ">$outfile",
                               -format => $outfileformat,
                             );

# write each entry in the input file to the output file
while (my $inseq = $seq_in->next_seq) {
   $seq_out->write_seq($inseq);
}

#q4.pl in.txt GenBank out.txt Fasta