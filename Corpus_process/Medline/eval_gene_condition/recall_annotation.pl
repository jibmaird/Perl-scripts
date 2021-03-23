use strict;
use vars qw ();

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\T258857\\recall_files";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946\\recall_files";
opendir(D,"$data_d\\cas")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

open(O,">$data_d\\..\\recall_ann_dtc.csv")||die;
foreach my $f (@File) {
	open(I,"$data_d\\cas\\$f")||die;
	while(<I>) {
		chomp;
		#if ((/wdd\:Gene/)&&(/wdd\:Condition/)) {
		#if ((/wdd\:Gene/)&&(/wdd\:Condition/)&&(/wdd\:Dtc/)) {
		if ((/wdd\:Gene.*?textToNormalize=\"leptin\"/)&&(/wdd\:Condition.*?textToNormalize=\"obes.*?\"/)) {
			my $r = "None";
			if (/<wdd:Dtc.*?canonicalName=\"(.*?)\"/) {
				$r = $1;
			}
			open(I2,"$data_d\\txt\\$f")||die;
			while(<I2>) {
				chomp;
				print O "\t\t$r\t$f\t$_\n";
			}
			close(I2);
			last;
		}
	}
	close(I);
}
close(O);