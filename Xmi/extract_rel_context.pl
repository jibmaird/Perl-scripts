use warnings;
use strict;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test10252016\\cas";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test10252016\\xmi_orig";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test02222017\\cas";

opendir(D,$data_d)||die;
my @File = grep /\.xmi/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d/$f")||die;
	my $str = "";
	while(<I>) {
		chomp;
		$str .= $_;
	}
	close(I);
	my $aux = $str;
	undef my %H;
	while($aux =~s /canonicalName=\"phosphorylation\" sentence=\"(.*?)\"//) {
		$H{$1}=1;
	} 
	$aux = $str;
	while($aux =~s /\:id=\"(.*?)\" .*?begin=\"(.*?)\" end=\"(.*?)\"//) {
		if (defined $H{$1}) {
			print "$f:phosphorylation:context:$2\-$3\n";
		}	
	}
}
