my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\part-r-00000";
my $out_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\id_mapping.csv";

my ($aux);

open(I,"$in_f")||die;
open(O,">$out_f")||die;
my $i = 1;
while(<I>) {
	#if ($i < 100000) {
	#	$i++;
	#	next;
	#}
	chomp;
	if (/\"id\":\"(.*?)\"/) {
		$pmid = $1;
	}
	if (/\"title\":\"(.*?)\"/) {
		if ($1 ne "") {
			$aux = $1;
			print O "$pmid\t$i\t$1\n";
			$i++;
		}
	}
	if (/\"abstract\":\"(.*?)\"/) {
		if ($1 ne "") {
			$aux = $1;
			print O "$pmid\t$i\t$1\n";
			$i++;
		}
	}
	if (/\"abstractext\":\"(.*?)\"/) {
		if ($1 ne "") {
			print O "$pmid\t$i\t$1\n";
			$i++;
		}
	}
	last if $i == 300000;
}
close(I);
close(O);