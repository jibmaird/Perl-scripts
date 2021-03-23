use warnings;
use strict;

my $f = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946\\precision_ann.manual.csv";

open(I,"$f")||die;
my $t = 0; my $ok = 0;
undef my %H;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	#if (($F[0] eq "0")&&($F[1] ne "")) {
	if ($F[0] eq "0") {
		if ($F[1] =~ /“/) {
			$F[1] = "negation";
		}
		#$H{$F[1]}++;
		$H{$F[5]}++;
	}
}
close(I);
foreach (sort {$H{$b}<=>$H{$a}} keys %H) {
	print "$_ $H{$_}\n";
}
