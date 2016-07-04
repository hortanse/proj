#! /usr/bin/perl
use strict;
use warnings;

#passing two array references
my @first = (1, 2, 3);
my @second = (2, 4, 6);

print "Input == ( @first ) and ( @second ) \n";
print "Output == \n";

products(\@first, \@second); #passing two references

sub products{
	my ($one_ref, $two_ref)=@_;
	foreach(my $i=0; $i<3; $i++){
		foreach(my $j=0; $j<3; $j++){
			my $result = $one_ref->[$i]*$two_ref->[$j];
			print $result."\t"
		}
		print "\n";
	}
}

