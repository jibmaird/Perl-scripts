# Goal: break problematic docuement into sentences to pinpoint problem

my $line = "";
my $size = 600;
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\ftmj_sample07152016";
open(I,"$data_d\\txt_orig\\470912.txt")||die;
while(<I>) {
	chomp;
	$line = "$line $_";
}
close(I);
my @F = split(/(?<=\w)\. /,$line);
$i = 1;
for($j=0;$j<=$#F;) {
	$_ = 0;
	$_ = $j/$size if $j>0;
	open(O,">$data_d\\txt\\$_.txt")||die;
	for($i=0;$i<$size;$i++) {
		print O "$F[$j]\.\n";
		$j++;
		last if $j >$#F;
	}
	close(O);
}