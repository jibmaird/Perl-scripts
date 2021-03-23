use warnings;
use strict;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20161109\\20161031-1400\\xmi_orig";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20161109\\20161031-1400\\cas";

opendir(D,$data_d)||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d/$f")||die;
	while(<I>) {
		chomp;
		while(s /(\<.*?begin\=\"(.*?)\" end\=\"(.*?)\".*?)\>//) {
			if ($3 - $2 > 3000) {
				my $aux = $3 - $2;
				print "$f $aux $1\n";
			}
		}
	}
	close(I);
}