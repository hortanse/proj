#! /usr/bin/perl

use Modern::Perl;

use Bio::DB::GenBank;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

STDOUT->autoflush(1);
my $data_blast = 'out.blast';

# get accession number from STDIN
print "Input the accession number : ";
my $accession_number = <>;
chomp( $accession_number );

# get sequence from GenBank by accession number
my $gb_dbh = Bio::DB::GenBank->new();
my $seq = $gb_dbh->get_Seq_by_acc( $accession_number );
print "NAME : ", $seq->display_id, "\n";
print "ACC NO. : ", $seq->accession_number, "\n";
print "Sequence : ", $seq->seq;

my $protein = translate( $seq->seq );
# my $blast = blast_sequence( $protein );
# write_blast(">$data_blast", $blast);
# exit;


# prepare blast factory
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp',
                                                 -data       => 'nr',
												 -expect     => '1e-10',
												 -readmethod => 'SearchIO',
												 );
												 
print "\nSumitting Blasts.\n";
$factory->submit_blast( $protein );
print ".";
print "done.\n";

my $accession_new;
print "polling for results\n";
ENDWHILE: while ( my @rids = $factory->each_rid ) {
    foreach my $rid ( @rids ) {
        my $result = $factory->retrieve_blast( $rid );
	    if( ref( $result )) {
            my $output = $result->next_result();
            $factory->remove_rid( $rid );
            print "\n";

            foreach my $hit ( $output->hits ) {
			    print "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n";
				print "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n";
				$accession_new = $hit->accession;
				# find the top non-self hit
				last ENDWHILE if $accession_number ne $hit->accession;

                foreach my $hsp ( $hit->hsps ) {

                    print "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";

                }
				
            }
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

# get new sequence from GenBank
$seq = $gb_dbh->get_Seq_by_acc( $accession_new );
# it's already protein and need not to translate
# $protein = translate( $seq->seq );

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
			    print "HIT TO: ",$hit->name,"\t", $hit->accession,"\t", $hit->length,"\n";
				print "e-value and score : ",$hit->significance, "\t", $hit->bits,"\n";

                foreach my $hsp ( $hit->hsps ) {

                    print "\tHAS HSP WITH ",$hsp->percent_identity,"% identity\n";

                }
				
            }
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
		