use strict;
use warnings;

my (@File,$f,@F);
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160817\\brat";
opendir(D,"$data_d")||die;
@File = grep /\.ann$/,readdir D;
closedir(D);

foreach $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		@F = split(/\t/,$_);
		
		if ((defined $F[2])&&($F[2] eq "<")) {
			print "$_ found in $f\n";
		}
	}
	close(I);
}