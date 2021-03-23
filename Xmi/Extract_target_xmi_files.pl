
my $dtc_d = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\Biorels_runs\\medline_100k_2_sample\\candidates\\06212016\\candidates";
my @F;
my %H;
my @Files = ("NoDTC","DTC");
my $file;

undef %H;
foreach $file (@Files) {
	open(I,"$dtc_d\\$file.csv")||die;
	while(<I>) {
		chomp;
		@F = split(/\,/,$_);
		$H{$F[4]} = 1;
	}
	close(I);
}
