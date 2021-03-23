use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946\\pmid2";


undef my %H;
open(O,">$data_d\\..\\precision_ann.csv")||die;
open(I,"$data_d\\..\\lep_obese.txt")||die;
while(<I>) {
	chomp;
	my @F = split(/\s\s+/,$_);
	if ((defined $F[22])&&
		($F[22]=~s /Medline\_//)&&
		($F[26] ne "Prepositional")&&
		($F[31] eq "GENE")
		) {
		$H{"$F[22]\.txt"}{"$F[26]#$F[28]#$F[35]#$F[47]"} = 1;
	}
}
close(I);

opendir(D,"$data_d")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

my ($rc,$r,$a,$t);
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		my @F = split(/\./,$_);
		foreach (@F) {
			foreach my $k (keys %{$H{$f}}) {
				($rc,$r,$a,$t) = split(/\#/,$k);
				if ((/\b$r\b/i)&&
					(/\b$a\b/i)&&
					(/\b$t\b/i)) {
						print O "$f\t$a\t$r\t$rc\t$t\t$_\n";			
					}
			}
		}
	}
	close(I);
}
close(O);