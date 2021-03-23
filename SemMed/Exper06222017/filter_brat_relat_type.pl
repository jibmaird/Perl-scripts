use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017";
my $in_d = "$data_d\\brat_1000";
my $out_d = "$data_d\\brat_POSREG";

if (not -e "$out_d") {
	system("md $out_d");
}

opendir(D,"$in_d")||die;
my @File = grep /\.ann/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$in_d\\$f")||die;
	open(O,">$out_d\\$f")||die;
	while(<I>) {
		if (/^E\d+\t(.*?)\:/) {
			next if $1 ne "RegulationPositive";
		}
		print O;
	}
	close(I);
	close(O);
	
	my $f2 = $f;
	$f2 =~s /\.ann/\.txt/;
	system("copy $in_d\\$f2 $out_d\\$f2");
	
	
}