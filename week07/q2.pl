#! /usr/bin/perl

#Write a subroutine that returns a reference to a hash. Write a script that 
#(a) declares a reference to this function
#(b) calls the function via the reference
#(c) prints out the hash whose reference is returned from the subroutine.

use strict;
use warnings;

my %fruit = ( Apple => 'red',
			  Banana => 'yellow',
			  Grapes => 'purple',
			  Kiwi => 'green',
			  Blueburry => 'blue',
		     );

#declares a reference to this function
my $sub_ref = \&hashref;

#calls the function via the reference $sub_ref
my $fruit_ref = $sub_ref->( \%fruit );

#prints out the hash whose reference is returned from the subroutine
foreach (keys %$fruit_ref) {
	print " The color of $_ is $fruit_ref->{ $_ } \n";
}

sub hashref {
	my $hash_ref = shift;
	return $hash_ref;
}
