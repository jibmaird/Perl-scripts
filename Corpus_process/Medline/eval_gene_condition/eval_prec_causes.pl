use warnings;
use strict;

my $f = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\T258857\\ann_sentences.manual.csv";

my %M  =
("tnf-alpha"=>"tnf",
"tnf-α"=>"tnf",
"tumor necrosis factor"=>"tnf",
"tumor necrosis factor-alpha"=>"tnf"
);

my $ok = 0;
my $t = 0;
open(I,"$f")||die;
undef my %H;
open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\T258857\\error_causes.csv")||die;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	
	if (($F[0] ne "")&&($F[0] ne "X")) {
		$F[3] = lc($F[3]);
		$F[5] = lc($F[5]);
		$F[3] = $M{$F[3]} if defined $M{$F[3]};
		$F[5] = $M{$F[5]} if defined $M{$F[5]};
		$H{"$F[3]\-$F[5]"}{ok}+=$F[0];
		$H{"$F[3]\-$F[5]"}{t}++;
		$ok += $F[0];
		$t++;
		if (($F[3] eq "tnf")&&($F[5] eq "ankylosing spondylitis")) {
			print O "$_\n";
		}
	}
}
close(I);
close(O);
foreach my $k (sort keys %H) {
	my $ok = $H{$k}{ok};
	my $t = $H{$k}{t};
	$_ = $ok / $t;
	print "$k: $ok \/ $t \= $_\n";
}
$_ = $ok / $t;
print "\nALL: $ok \/ $t \= $_\n";
