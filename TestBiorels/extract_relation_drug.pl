use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924";

undef my %H;

open(I,"$data_d\\NonPTMInteractions.AllBioRels.csv")||die;
$_ = <I>;
while(<I>) {
	chomp;
	/^(.*?)\,\"(.*?)\"\,(.*?)\,(.*?)$/;
	my $t = $4;
	my $s = $1;
	my $text = $2;
	
	if (not defined $t) {
		my @F = split(/\,/,$_);
		$t = $F[3];
		$text = $F[1];
		$s = $F[0];
	}
	if ($t =~ /^ubiquitination/) {
		$H{$s}{$text} = 1;

	}
}
close(I);

open(I,"$data_d\\DrugTargetConditionInteractions.ObjectsOfInterest.csv")||die;
$_ = <I>;
while(<I>) {
	chomp;
	s /^\"(.*)\"$/$1/;
	my @F = split(/\"\,\"/,$_);
	if ((defined $H{$F[0]})&&($F[3]=~/Drug/)) {
		#print "$F[0] $F[2]\n";
		foreach my $k (keys %{$H{$F[0]}}) {
			if ($k =~/$F[2]/) {
				print "* $F[0]\t$F[2]\t$k\n";
			}
		}
	}
}
close(I);

