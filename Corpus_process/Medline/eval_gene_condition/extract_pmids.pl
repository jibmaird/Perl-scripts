use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946";

open(I,"$data_d\\lep_obese\.txt")||die;
open(O,">$data_d\\ids\.txt")||die;

while(<I>) {
	chomp;
	if (/Medline\_(\d+)/) {
		print O "$1\n";
	}
}
close(I);
close(O);