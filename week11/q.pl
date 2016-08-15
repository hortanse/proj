#! /opt/perl/bin/perl

#homework of week11
  
use warnings;
use strict;
  
use CGI (':standard');

use LWP::Simple;
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";
  
my $title = 'BioPerl Week11 Homework Solution';
print header,
start_html( $title ),
h1( $title );
  
# handle processing of form if this is a submission
if( param( 'submit' )) {
    my $db = param( 'dbname' );
    my $query  = param( 'query' );
  
    print p( "Your database is '$db'."),
          p( "Your query is $query.");

    my $esearch = "$utils/esearch.fcgi?" .
                "db=$db&retmax=1&usehistory=y&term=";
  
    my $esearch_result = get($esearch . $query);
  
    print p( "ESEARCH RESULT: $esearch_result" );
  
    $esearch_result =~
    m|<Count>(\d+)</Count>.*<QueryKey>(\d+)</QueryKey>.*<WebEnv>(\S+)</WebEnv>|s;
  
    my $Count    = $1;
    my $QueryKey = $2;
    my $WebEnv   = $3;
  
    print p( "Count = $Count; QueryKey = $QueryKey; WebEnv = $WebEnv");   
}
  
  # and then print out the base form regardless of whether this is the
  # first time or the tenth
  my $url = url();
  print start_form( -method => 'GET' , action => $url ),
    p( "What's your database: " . textfield( -name => 'dbname' )),
    p( "What's your query: "  . textfield( -name   => 'query' )),

    p( submit( -name => 'submit' , value => 'Submit' )),
    end_form(),
    end_html();