use strict;
use warnings;

my (@File,$f,@D,$d);

my $data_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdd-annotator-biorels\\data\\SemMed";

@D = ("linezolid","treats");
foreach $d (@D) {

	$_ = "$data_d\\$d" . "_sample\\DTC08152016";
	opendir(D,"$_")||die;
	@File = grep /\.ann$/,readdir D;
	closedir(D);

	if (not -e "$data_d\\$d\_sample\\DC_DTC08152016") {
		system("md $data_d\\$d\_sample\\DC_DTC08152016");
	}
	if (not -e "$data_d\\$d\_sample\\DC_$d\_gt") {
		system("md $data_d\\$d\_sample\\DC_$d\_gt");
	}
	
	
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
		if (($dr>0)&&($c>0)) {
			$_ = $f;
			s /\.ann$//;
			system("copy $data_d\\$d\_sample\\DTC08152016\\$f $data_d\\$d\_sample\\DC_DTC08152016");
			system("copy $data_d\\$d\_sample\\DTC08152016\\$_\.txt $data_d\\$d\_sample\\DC_DTC08152016");
			system("copy $data_d\\$d\_sample\\$d\_gt\\$f $data_d\\$d\_sample\\DC_$d\_gt");
			system("copy $data_d\\$d\_sample\\$d\_gt\\$_\.txt $data_d\\$d\_sample\\DC_$d\_gt");
		}
	}
}