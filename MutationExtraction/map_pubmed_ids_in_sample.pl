my $map_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\id_mapping.csv";

my $mut_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\Biorels_runs\\medline_100k_2_sample\\candidates\\06212016\\candidates\\DTC.csv";
my $out_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\Biorels_runs\\medline_100k_2_sample\\candidates\\06212016\\candidates\\DTC_with_pmids.csv";

undef %H;
open(I,"$map_f")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	$H{$F[1]} = $F[0];
}
close(I);

open(I,"$mut_f")||die;
open(O,">$out_f")||die;
$_ = <I>;
print O;
while(<I>) {
	chomp;
	s /^(\,\,\,.*?\,)(.*?)(\,.*)$/$1$H{$2}$3/;
	print O "$_\n";
}
close(O);
close(I);
