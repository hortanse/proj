#! /usr/bin/perl
use strict;
use warnings;

print "Enter regexp : ";
my $regexp = <>;
chomp($regexp);

while (1) {
    print "Enter string or 'exit' to exit : ";
        my $string = <>;
        chomp($string);
        last if $string =~ /exit/;            # matching exit to exit loop

        if ($string =~ /$regexp/) {           # test matching
            print "$string Match! \n";        # print out matched result
        }
        else {
            print "$string No match! \n";     # print out no match result
        }
}
print "exit bye bye \n";
