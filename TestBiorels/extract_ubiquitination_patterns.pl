use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample2";

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
				$P{$1}{'sent'}{$_}=1;
				$P{$1}{'tot'}++;
			}
			elsif (/ubiquitin(.*)$k/) {
				$P{$1}{'sent'}{$_}=1;
				$P{$1}{'tot'}++;
			}
		}
	}
}
close(I);

foreach my $p (sort {$P{$b}{'tot'}<=>$P{$a}{'tot'}} keys %P) {
	print "$p ($P{$p}{'tot'})\n";
	foreach (sort keys %{$P{$p}{'sent'}}) {
		print "\,\"$_\"\n";
	}
}
