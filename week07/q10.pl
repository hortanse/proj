#! /usr/bin/perl
use strict;
use warnings;

use DBI;
my $dbh = DBI->connect("DBI:SQLite:dbname=gene", "", "",
          { PrintError => 0, RaiseError => 1} );

use CGI(':standard');

my $title = 'answer to question 10 of week08 homework';
print header,
    start_html( $title ),
	h1( $title );
	
# handle processing of form if this is a submission

if( param( 'submit' )) {
     my @gene_query = param( 'gene_data' );
     p( "You have the following gene queries :"),
      '<ul>';
  
    foreach( @gene_query ) {
      print li( $_ );
    }
  
    print '</ul>',
      hr();
#handle gene queries
    foreach $query (@gene_query) {
	    if ($query eq 'gene') {
		    my $sth = $dbh->prepare("SELECT name FROM gene");
			$sth->execute();
			while (my @row = $sth->fetchrow_array() ) {
			    print p("The gene name is '$row[0]');
			}
		}
		
		elsif ($query eq 'organism') {			
		    my $sth = $dbh->prepare("SELECT name FROM organism");
			$sth->execute();
			while (my @row = $sth->fetchrow_array() ) {
			    print p("The organism name is '$row[0]');
			}
		}
		elsif ($query eq 'tissue') {
		    my $sth = $dbh->prepare("SELECT name FROM tissue");
			$sth->execute();
			while (my @row = $sth->fetchrow_array() ) {
			    print p("The tissue name is '$row[0]');
			}
		}
		elsif ($query eq 'expression_level') {
		    my $sth = $dbh->prepare("SELECT expression_level FROM gene");
			$sth->execute();
			while (my @row = $sth->fetchrow_array() ) {
			    print p("The expression_level is '$row[0]');
			}
		}
		if (scalar @gene_query == 4) {
		    my $st <<EOSQL
			   SELECT gene.name, organism.name, tissue.name, expression_level
			   FROM gene, organism, tissue
			   WHERE organism.id = gene.org_id AND tissue.id = gene.tis_id
EOSQL
		    my $sth = $dbh->prepare( $st );
		    $sth->execute();
		    while (my @row = $sth->fetchrow_array() ) {
			    print p("@row");
			}
		}
		  
    }
}


# and then print out the base form regardless whether this is the
#  first time or the tenth
 my $url = url();
 print start_form( -method => 'GET' , action => $url ),
       p( "What data do you want from database gene : " . br() . checkbox_group( -name      => 'gene_data' ,
                     -values    => [ 'gene' , 'organism' , 'tissue' , 'expression_level' ] ,
                                                      -default   => [ 'gene' ] ,
                                                          -linebreak => 'true' )),
       p( submit( -name => 'submit' , value => 'Submit' )),
       end_form(),
       end_html();