use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample3\\txt";

opendir(D,"$data_d")||die;
my @Files = grep /\d/,readdir D;
closedir(D);

open(O,">$data_d\\..\\ubiquitination.del")||die;
my $i = 1;
foreach my $f (@Files) {
	my $str = "";
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		$str .= $_;
	}
	close(I);
	my @F = split(/\./,$str);
	foreach (@F) {
		if (/ubiquit/) {
			print O "1,$i,\"$_\"\n";
			$i++;
		}
	}
}
close(O);