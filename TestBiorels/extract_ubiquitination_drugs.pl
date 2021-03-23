use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample3";

open(I,"$data_d\\DrugTargetConditionInteractions.ObjectsOfInterest.csv")||die;

undef my %H;
while(<I>) {
	chomp;
	my @F = split(/\,/,$_);
	if ($F[3] =~ /Drug/) {
		$F[0] =~s /\"//g;
		$F[1] =~s /\"//g;
		$F[1] =~s /\[\d+ \- \d+\]$//;
		$H{$F[0]}{$F[1]} = 1;
	}
}
close(I);

undef my %P;
open(I,"$data_d\\ubiquitination.del")||die;
while(<I>) {
	chomp;
	s/^1,(\d+)\,//;
	my $i = $1;
	if (defined $H{$i}) {
		foreach my $k (keys %{$H{$i}}) {
			$k =~s /\?/\\\?/g;
			
			if (/$k(.*?)ubiquitin/) {
				$P{$k}{'sent'}{$_}=1;
				$P{$k}{'tot'}++;
			}
			elsif (/ubiquitin(.*)$k/) {
				$P{$k}{'sent'}{$_}=1;
				$P{$k}{'tot'}++;
			}
		}
	}
}
close(I);

open(O,">$data_d\\drugs_ubiquitination.csv")||die;
foreach my $p (sort {$P{$b}{'tot'}<=>$P{$a}{'tot'}} keys %P) {
	print O "$p ($P{$p}{'tot'}),\n";
	foreach (sort keys %{$P{$p}{'sent'}}) {
		print O "\t$_\n";
	}
}
close(O);
