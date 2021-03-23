my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\part-r-00000";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\Sample_mutation_relations";
my $pmid_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\Biorels_runs\\medline_100k_2_sample\\candidates\\06212016\\candidates\\DTC_with_pmids.csv";


undef %H;
open(I,"$pmid_f")||die;
while(<I>) {
	chomp;
	@F = split(/\,/,$_);
	$H{$F[4]} = 1;
}
close(I);

open(I,"$in_f")||die;
my $i = 0;
while(<I>) {
	chomp;
	if (/\"id\":\"(.*?)\".*?\"title\":\"(.*?)\".*?\"abstract\"\:\"(.*?)\"/) {
		my $id = $1;
		my $t = $2;
		my $a = $3;
		if (defined $H{$id}) {
			open(O,">$out_d\\$id\.txt")||die;
			print O "$t\n$a\n";
			close(O);
		}
	}
}
close(I);