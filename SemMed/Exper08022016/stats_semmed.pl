use strict;
use warnings;

open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\linezolid_sent.csv")||die;
undef my %H;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	$H{$F[0]}++;
	
}
close(I);

foreach (sort {$H{$b}<=>$H{$a}} keys %H) {
	print "$_\: $H{$_}\n";
}