## This is set 2 question 2
## creating a shopping database that contains four tables (gifts, friends, retailers, friends and gifts)


#! /usr/bin/perl
use strict;
use warnings;

use DBI;
my $dbh = DBI->connect("DBI:SQLite:dbname=shopping", "", "",
          { PrintError => 0, RaiseError => 1} );



# Setting up tables in database shopping
# gifts table
my $sth = $dbh->prepare("DROP TABLE IF EXISTS gifts");
$sth->execute();
$sth->finish();
my $st = <<SQLEND;
CREATE TABLE gifts (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(255) NOT NULL,
	retailer_id INTEGER NOT NULL,
	price INTEGER
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# friends table
$sth = $dbh->prepare("DROP TABLE IF EXISTS friends");
$sth->execute();
$sth->finish();
$st = <<SQLEND;
CREATE TABLE friends (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(255) NOT NULL
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# retailers table
$sth = $dbh->prepare("DROP TABLE IF EXISTS retailers");
$sth->execute();
$sth->finish();
$st = <<SQLEND;
CREATE TABLE retailers (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(255) NOT NULL
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();

# friends and gifts table
$sth = $dbh->prepare("DROP TABLE IF EXISTS friends_gifts");
$sth->execute();
$sth->finish();
$st = <<SQLEND;
CREATE TABLE friends_gifts (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	friend_id INTEGER NOT NULL,
	gift_id INTEGER NOT NULL
	);
SQLEND
$sth = $dbh->prepare( $st );
$sth->execute();
$sth->finish();



# insert values into tables friends, retailers, gifts, friends_gifts
# 
# friends
$sth = $dbh->prepare("INSERT INTO friends ( id, name) VALUES(NULL, 'John')" );
$sth->execute();
$sth->finish();
$sth = $dbh->prepare("INSERT INTO friends ( id, name) VALUES(NULL, 'Tom')" );
$sth->execute();
$sth->finish();

# retailers
$sth = $dbh->prepare("INSERT INTO retailers ( id, name) VALUES(NULL, 'WalMart')" );
$sth->execute();
$sth->finish();
$sth = $dbh->prepare("INSERT INTO retailers ( id, name) VALUES(NULL, 'JCPenny')" );
$sth->execute();
$sth->finish();

# gifts
$sth = $dbh->prepare("INSERT INTO gifts ( id, name, retailer_id, price) VALUES(NULL, 'book', 1, 30)" );
$sth->execute();
$sth->finish();
$sth = $dbh->prepare("INSERT INTO gifts ( id, name, retailer_id, price) VALUES(NULL, 'flower', 2, 20)" );
$sth->execute();
$sth->finish();

# friend and gift relationship
$sth = $dbh->prepare("INSERT INTO friends_gifts ( id, friend_id, gift_id) VALUES(NULL, 1, 1)" );
$sth->execute();
$sth->finish();
$sth = $dbh->prepare("INSERT INTO friends_gifts ( id, friend_id, gift_id) VALUES(NULL, 2, 2)" );
$sth->execute();
$sth->finish();

# print out the shopping results
$st = <<OREND;
SELECT friends.name, gifts.name, retailers.name, gifts.price
FROM friends, gifts, retailers, friends_gifts
WHERE friends_gifts.friend_id = friends.id AND
      friends_gifts.gift_id = gifts.id AND
	  gifts.retailer_id = retailers.id;
OREND
$sth = $dbh->prepare( $st );
$sth->execute();
printf("\n friends  gifts retailers  prices \n");
while (my @row = $sth->fetchrow_array() ) {
    printf(" @row \n");
}
$sth->finish();

