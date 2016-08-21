##This is set 2 question 6

#! /usr/bin/perl

use Modern::Perl;

use Bio::DB::GenBank;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);

# get accession number from command line
my $accession_number = shift;
# get e-value cut off from command line
my $evalue_cut = shift;

# get sequence from GenBank by accession number
my $gb_dbh = Bio::DB::GenBank->new();
my $seq = $gb_dbh->get_Seq_by_acc( $accession_number );
print "NAME : ", $seq->display_id, "\n";
print "ACC NO. : ", $seq->accession_number, "\n";
print "Sequence : ", $seq->seq;


# prepare blast factory
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp',
                                                 -data       => 'nr',
												 -expect     => "$evalue_cut", #input
												 -readmethod => 'SearchIO',
												 );
												 
print "\nSumitting Blasts.\n";
$factory->submit_blast( $seq );
print ".";
print "done.\n";


print "polling for results\n";
while ( my @rids = $factory->each_rid ) {
    foreach my $rid ( @rids ) {
        my $result = $factory->retrieve_blast( $rid );
	    if( ref( $result )) {
            my $output = $result->next_result();
            $factory->remove_rid( $rid );
            print "\n";

            foreach my $hit ( $output->hits ) {
			    if ( $hit->accession eq $accession_number ) { next; } # non-redundant 
				my $data_blast = 'out_blast_' . $hit->accession; #
				open OUT, ">", $data_blast or die "\nCan't open $data_blast ($!)";
			    print "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n";
				print "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n";
				print OUT "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n";
				print OUT "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n";


                foreach my $hsp ( $hit->hsps ) {

                    print "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";
					print OUT "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";

                }
				
            }
			close OUT;
        }
		elsif( $result < 0 ) {
           # some error occurred
           print "No blast result for the evalue cut";
           $factory->remove_rid( $rid );
        }
        else {
           print '.';
           sleep 5;
        }
    }
}
		