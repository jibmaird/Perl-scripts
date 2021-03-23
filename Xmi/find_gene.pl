
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test10042016\\rule2\\cas";
opendir(D,"$data_d")||die;
@File = grep /\.xmi/,readdir D;
closedir(D);

foreach $f (@File) {
	open(I,"$data_d\\$f");
	while(<I>) {
		if (/(\<ls:Gene .*?\>)/) {
			print "$1\n";
		} 
	}
	close(I);
}