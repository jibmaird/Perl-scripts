use strict;
use warnings;

my (@File,$f,@D,$d);

my $data_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdals-annotator-biorels\\data\\SemMed";

@D = ("treats");
foreach $d (@D) {

	$_ = "$data_d\\$d" . "_sample\\DTC08152016";
	opendir(D,"$_")||die;
	@File = grep /\.ann$/,readdir D;
	closedir(D);

	my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test10102016\\treats_drug";
	
	foreach $f (@File) {
		$_ = "$data_d\\$d" . "_sample\\DTC08152016";
		open(I,"$_\\$f")||die;
		my $dr = 0;
		my $c = 0;
		while(<I>) {
			chomp;
			/^.*?\t(.*?) /;
			if ($1 eq "Condition") {
				$c++;
			}
			elsif ($1 eq "Drug") {
				$dr++;
			}
		}
		close(I);
		if ($dr == 0) {
			$_ = $f;
			s /\.ann$//;
			system("copy $data_d\\$d\_sample\\DTC08152016\\$f $out_d");
			system("copy $data_d\\$d\_sample\\DTC08152016\\$_\.txt $out_d");
			
		}
	}
}