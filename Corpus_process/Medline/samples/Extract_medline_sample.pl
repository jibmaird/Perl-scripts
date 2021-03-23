my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\part-r-00000";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\Sample_6k";

open(I,"$in_f")||die;
my $i = 0;
while(<I>) {
	chomp;
	if (/\"id\":\"(.*?)\".*?\"title\":\"(.*?)\".*?\"abstract\"\:\"(.*?)\"/) {
		my $id = $1;
		my $t = $2;
		my $a = $3;
		open(O,">$out_d\\$id\.txt")||die;
		print O "$t\n$a\n";
		close(O);
		$i++;
		last if $i == 6000;
	}
}
close(I);