#Problem with splitting fields

my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\part-r-00000";
my $out_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\id_mapping.csv";

my $mut_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\Biorels_runs\\medline_100k_2_sample\\candidates\\06212016\\candidates\\DTC.csv";

my (%H,@F,$pmid,$aux);

undef %H;
open(I,"$mut_f")||die;
while(<I>) {
	chomp;
	@F = split(/'\,/,$_);
	
	$F[5] =~s /\"//g;
	$H{$F[5]} = $F[4];
}
close(I);

open(I,"$in_f")||die;
open(O,">$out_f")||die;
my $i = 1;
while(<I>) {
	chomp;
	if (/\"id\":\"(.*?)\"/) {
		$pmid = $1;
	}
	if (/\"title\":\"(.*?)\"/) {
		$aux = $1;
		if (defined $H{$1}) {
			print O "$pmid\t$H{$1}\t$1\n"
		}
	}
	if (/\"abstract\":\"(.*?)\"/) {
		if (defined $H{$1}) {
			print O "$pmid\t$H{$1}\t$1\n"
		}
	}
	$i++;
	last if $i == 300000;
}
close(I);
close(O);