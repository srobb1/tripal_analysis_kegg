#!/usr/bin/perl
use strict;
use warnings;

my $html = shift;
open HTML, $html or die $!;
while (my $line = <HTML>){
  chomp $line;
  while ($line =~ /(q\d{5})/g){
    print $1,"\n";
  }
}
