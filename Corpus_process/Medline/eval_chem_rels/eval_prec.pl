use warnings;
use strict;

my $f = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\ann_sentences.manual3.csv";

open(I,"$f")||die;
my $t = 0; my $ok = 0;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	if (($F[1] ne "")&&($F[1] ne "X")) {
		$t++;
		$ok+=$F[1];
	}
}
close(I);
$_ = $ok / $t;
print "$ok \/ $t\n$_\n";

