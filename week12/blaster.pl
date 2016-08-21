##This is set 2 question 5

#! /usr/bin/perl

use Modern::Perl;

use Bio::DB::GenBank;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);


# get blast mode ,dna or protein, and accession number from command line
my $blast_mode = $ARGV[0];
my $dna_or_protein = $ARGV[1];
my $accession_number = $ARGV[2];

if ($blast_mode eq 'blastn' && $dna_or_protein ne 'dna') {
    print "\n$blast_mode does not match $dna_or_protein \n";
	exit;
}
if ($blast_mode eq 'tblastn' && $dna_or_protein ne 'dna') {
    print "\n$blast_mode does not match $dna_or_protein \n";
	exit;
}
if ($blast_mode eq 'blastp' && $dna_or_protein ne 'protein') {
    print "\n$blast_mode does not match $dna_or_protein \n";
	exit;
}

# get sequence from GenBank by accession number
my $gb_dbh = Bio::DB::GenBank->new();
my $seq = $gb_dbh->get_Seq_by_acc( $accession_number );
print "NAME : ", $seq->display_id, "\n";
print "ACC NO. : ", $seq->accession_number, "\n";
print "Sequence : ", $seq->seq;


# prepare blast factory
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => "$blast_mode",
                                                 -data       => 'nr',
												 -expect     => '1e-10',
												 -readmethod => 'SearchIO',
												 );
												 
print "\nSumitting Blasts.\n";
$factory->submit_blast( $seq );
print ".";
print "done.\n";

#Output file
my $out_data = $blast_mode . '_' . $accession_number; #write into output file
open OUT, ">", $out_data or die "Can't open $out_data ($!)"; #write into output file


print "polling for results\n";
while ( my @rids = $factory->each_rid ) {
    foreach my $rid ( @rids ) {
        my $result = $factory->retrieve_blast( $rid );
	    if( ref( $result )) {
            my $output = $result->next_result();
            $factory->remove_rid( $rid );
            print "\n";

            foreach my $hit ( $output->hits ) {
			    print OUT "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n";
				print OUT "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n";
				print "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n"; #print on screen
				print "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n"; #print on screen


                foreach my $hsp ( $hit->hsps ) {

                    print OUT "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";
					print "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";

                }
				
            }
			close OUT;
        }
		elsif( $result < 0 ) {
           # some error occurred
           $factory->remove_rid( $rid );
        }
        else {
           print '.';
           sleep 5;
        }
    }
}
		