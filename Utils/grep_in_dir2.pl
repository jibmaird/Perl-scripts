use strict;
use warnings;

my (@File,$f,%H);

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20161216\\txt";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test02222017\\cas";

opendir(D,$data_d)||die("$data_d");
@File = grep /\.txt/,readdir D;
closedir(D);

undef %H;
foreach $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		if (/residue/) {
			$H{$f} = $_;
		}
	}
	close(I);
}
foreach (sort keys %H) {
	print "$_\: $H{$_}\n";
}
