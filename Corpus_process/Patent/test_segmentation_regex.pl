use strict;
use warnings;

my (@File,$f,%H,@F);

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907";

opendir(D,"$data_d\\txt")||die;
@File = grep /\.txt/,readdir D;
closedir(D);

undef %H;

foreach $f (@File) {
	open(I,"$data_d\\txt\\$f")||die;
	while(<I>) {
		chomp;
		@F = split(/\n/,$_);
		foreach my $l1 (@F) {
			
			my @G = split(/[\.\?!\n][\s\n\&]/,$l1);
			foreach (@G) {
				my $l = length($_);
				if ($l > 2000) {
					print "long sentence: $l: $_\n";
				}
			}
		}
	}
	close(I);
}