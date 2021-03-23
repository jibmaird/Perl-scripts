use warnings;
use strict;

my $f = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946\\precision_ann.manual.csv";

open(I,"$f")||die;
my $t = 0; my $ok = 0;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	if (($F[0] ne "")&&($F[0] ne "X")) {
		$t++;
		$ok+=$F[0];
	}
}
close(I);
$_ = $ok / $t;
print "$ok \/ $t\n$_\n";

