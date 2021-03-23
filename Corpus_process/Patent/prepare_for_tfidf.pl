use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907";

opendir(D,"$data_d\\txt")||die;
my @File = grep /\.txt$/,readdir D;
closedir(D);

open(O,">$data_d\\patents.txt")||die;
foreach my $f (@File) {
	open(I,"$data_d\\txt\\$f")||die;
	while(<I>) {
		print O;
	}
	close(I);
}
close(O);