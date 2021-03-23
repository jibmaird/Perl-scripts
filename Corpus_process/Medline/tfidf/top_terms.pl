use strict;
use warnings;

open(I,"C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\tfidf.txt")||die;
my $i = 0;
while(<I>) {
	next if / vs /;
	print;
	$i++;
	last if $i == 50;
	
}
close(I);