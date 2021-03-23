use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";

opendir(D,"$data_d\\BioNLP-ST_2011_genia_train_data_rev1")||die;
my @File = grep /\.a2/,readdir D;
closedir(D);

my %R = (
	"Positive_regulation"=>1,
	"Negative_regulation"=>1)
	;

foreach my $f (@File) {
	open(I,"$data_d\\BioNLP-ST_2011_genia_train_data_rev1\\$f")||die;
	open(O,">$data_d\\BioNLP-ST_2011_genia_train_data_rev1_filtered\\$f")||die;
	while(<I>) {
		chomp;
		if (/^E\d+\t(.*?)\:/) {
			next if not defined $R{$1};
		}
		print O "$_\n";
	}
	close(I);
	close(O);
}