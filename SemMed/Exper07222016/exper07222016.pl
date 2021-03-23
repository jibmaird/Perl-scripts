
my ($f,@F,%H);

# FTP not working
#my $server = "-pw biw4you -r evaluator\@sfs1.almaden.ibm.com";
#my $in_f = "\/localdata\/davidm\/semmed\/treats_sentences.csv";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test07222016";
#system("perl C:\\Users\\IBM_ADMIN\\wd_newRTC\\PerlScripts\\Utils\\ftp.pl \\'$server\\' \\'$in_f\\' \\'$out_d\\'");

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test07222016";
if (not -e "$data_d\\txt") {
	system("mkdir $data_d\\txt");
}
undef %H;
open(I,"$data_d\\treats_sentences.csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	$F[1]=~s /\s+/ /g;
	if (not defined $H{$F[0]}) {
		$f = "$F[0]\-1\.txt";
		$H{$F[0]} = 1;
	}
	else {
		$H{$F[0]}++;
		$f = "$F[0]\-$H{$F[0]}\.txt";
	}
	open(O,">$data_d\\txt\\$f")||die;
	print O "$F[1]\n";
	close(O);
}
close(I);

