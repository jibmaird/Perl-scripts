use strict;
use warnings;

my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\Medline\\CDM\\part-r-00000_100k_2.del";

my $i = 1;
open(I,"$in_f")||die;
while(<I>) {
	chomp;
	print "$_\n";
	$i++;
	last if $i == 10;
}
close(I);