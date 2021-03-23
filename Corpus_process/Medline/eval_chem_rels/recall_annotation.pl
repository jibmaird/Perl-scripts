use strict;
use vars qw ();

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\recall_files";
opendir(D,"$data_d\\cas")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

open(O,">$data_d\\..\\recall_ann.csv")||die;
foreach my $f (@File) {
	open(I,"$data_d\\cas\\$f")||die;
	while(<I>) {
		chomp;
		if (/wdd\:Chemical/) {
			open(I2,"$data_d\\txt\\$f")||die;
			while(<I2>) {
				chomp;
				print O "\t$f\t$_\n";
			}
			close(I2);
			last;
		}
	}
	close(I);
}
close(O);