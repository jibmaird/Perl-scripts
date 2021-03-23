use strict;

use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170209\\in_main";

open(I,"$data_d\\000941901.txt")||die;
my $str = "";
while(<I>) {
	$str .= $_;
}
close(I);

my $tmp = substr $str, 1570,200;
print "$tmp\n";

$tmp = substr $str, 19111,200;
print "$tmp\n";

my @F = split(/\./,$str);
my $i=1;
foreach (@F) {
	if (/express/) {
		open(O,">$data_d\\..\\in\\$i.txt")||die;
		print O "$_\.\n";
		close(O);
		$i++;
	}
}
