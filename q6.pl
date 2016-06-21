#! /usr/bin/perl -w
use strict;
use warnings;

open( my $IN , '<' , $file ) or die( "can't open $file ($!)" );
while( <$IN> ) {
  chomp;
  die "failed to match:\n$_\n" unless /REGEXP/;
}
close( $IN );
print "everything matched.\n";
