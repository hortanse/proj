#! /usr/bin/perl
use strict;
use warnings;

use DBI;
my $dbh = DBI->connect("DBI:SQLite:dbname=gene", "", "",
          { PrintError => 0, RaiseError => 1} );

# open gene data file
my $data_file = "data";
open IN_FH, "<", "$data_file"
        or die "Can't open file $data_file ($!) ";

# parse the gene data file into an array (@gene_data) of hash reference
# and another array (@gene_seq) for the corresponding sequence
my $seq;
my $gene_ref;
my @gene_data;
my @gene_seq;
while ( my $line = <IN_FH> ) {
    chomp($line);
	if ($line =~m/^>/ ) {
	    $line =~ s/^>//;
		$line =~ m/([^|]+)[|]([^|]+)[|]([^|]+)[|]([^|]+)[|]([^|]+)[|]([^|]+)/;
		$gene_ref = { gene_name        => $1,
		              organism         => $2,
					  tissue           => $3,
					  start            => $4,
					  stop             => $5,
					  expression_level => $6,
					};
		push @gene_data, $gene_ref;
		
		if ( defined $seq and $seq ne '') {
		    push @gene_seq, \$seq;
			$seq = '';
		}
	}
	else {
	$seq .= $line;
	}
}
push @gene_seq, \$seq;

#print "number of gene data = ", scalar @gene_data, "\n";
#foreach my $i (0..@gene_data - 1){
#    foreach my $k (sort keys %{$gene_data[$i]}) {
#	    print " key = $k and value = ${$gene_data[$i]}{$k} \n";
#	}
#}

# Setting up tables in database gene
# organism table
my $sth = $dbh->prepare("DROP TABLE IF EXISTS organism");
$sth->execute();
$sth->finish();

my $st = <<SQLEND;
CREATE TABLE organism (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(25) NOT NULL
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# insert values into organism table
# put the entries into a hash

my %org;
#print scalar @gene_data,"\n";
foreach my $i (0..@gene_data - 1) {
#   print ${$gene_data[$i]}{organism}, "\n";
    $org{ ${$gene_data[$i]}{organism}}++ ;
}

foreach my $i (sort keys %org) {

$sth = $dbh->prepare("INSERT INTO organism ( id, name) VALUES(NULL, '$i')" );
$sth->execute();
$sth->finish();
}

# print out the organism table
$st = <<OREND;
SELECT * FROM organism;
OREND
$sth = $dbh->prepare( $st );
$sth->execute();
while (my @row = $sth->fetchrow_array() ) {
    printf("organisms are :  @row, \n");
}
$sth->finish();

# Setting up tables in database gene
# tissue table
$sth = $dbh->prepare("DROP TABLE IF EXISTS tissue");
$sth->execute();
$sth->finish();

$st = <<SQLEND;
CREATE TABLE tissue (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(25) NOT NULL
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# insert values into tissue table
# put the entries into a hash

my %tis;
#print scalar @gene_data,"\n";
foreach my $i (0..@gene_data - 1) {
#    print ${$gene_data[$i]}{tissue}, "\n";
    $tis{ ${$gene_data[$i]}{tissue}}++ ;
}

foreach my $i (sort keys %tis) {

$sth = $dbh->prepare("INSERT INTO tissue ( id, name) VALUES(NULL, '$i')" );
$sth->execute();
$sth->finish();
}

# print out the tissue table
$st = <<OREND;
SELECT * FROM tissue;
OREND
$sth = $dbh->prepare( $st );
$sth->execute();
while (my @row = $sth->fetchrow_array() ) {
    print("tissues are :  @row,  \n");
}
$sth->finish();


# Setting up tables in database gene
# gene table
$sth = $dbh->prepare("DROP TABLE IF EXISTS gene");
$sth->execute();
$sth->finish();

# gene table schema
$st = <<SQLEND;
CREATE TABLE gene (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	org_id INTEGER NOT NULL,
	tis_id INTEGER NOT NULL,
	name CHAR(25) NOT NULL,
	start CHAR(25),
	stop CHAR(25),
	expression_level INTEGER,
	sequence TEXT
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# insert values into gene table

foreach my $i (0..@gene_data - 1) {
# find the corresponding organism id and tissue id
    my $org_name = ${$gene_data[$i]}{organism};
	my $sth = $dbh->prepare("SELECT id FROM organism WHERE name='$org_name'");
	$sth->execute();
	my @row = $sth->fetchrow_array();
	my $org_id = $row[0];                              # organism id
	$sth->finish();
	my $tis_name = ${$gene_data[$i]}{tissue};
	$sth = $dbh->prepare("SELECT id FROM tissue WHERE name = '$tis_name'");
	$sth->execute();
	@row = $sth->fetchrow_array();
	my $tis_id = $row[0];                              # tissue id
	$sth->finish();
	my $gene_name = ${$gene_data[$i]}{gene_name};      # gene name
	my $start = ${$gene_data[$i]}{start};              # start position
	my $stop = ${$gene_data[$i]}{stop};                # stop position
	my $expression_level = ${$gene_data[$i]}{expression_level};
	my $seq = ${$gene_seq[$i]};	# gene sequence
#  insert values into gene table
	my $st = <<"GESQL";
    INSERT INTO gene
       VALUES(NULL, $org_id, $tis_id, '$gene_name', '$start', '$stop', $expression_level, '$seq')
GESQL
    $sth = $dbh->prepare( $st );
	$sth->execute();
	$sth->finish();
}

# print out the gene table
print("\n *** gene table *** \n");
$sth = $dbh->prepare("SELECT * FROM gene");
$sth->execute();
while (my @row = $sth->fetchrow_array() ) {
    print(join( '|', @row), "\n");
}
$sth->finish();

