use strict;
use warnings;

my $in_f = "C:\\\\Users\\IBM_ADMIN\\Data\\Corpora\\Medline\\CDM\\part-r-00000_10k_ext.del";
my $out_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\Medline\\CDM\\part-r-00000_5k_ext.del";

my $h = 5000;

open(I,"$in_f")||die;
open(O,">$out_f")||die;
my $i = 0;
while(<I>) {
	print O;
	$i++;
	last if $i == $h;
}
close(O);
close(I);