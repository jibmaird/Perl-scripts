use strict;
use warnings;

undef my %M;
undef my %H;
open(I,"C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\log.txt")||die;
open(O,">C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907\\tfidf.txt")||die;
while(<I>) {
	chomp;
	last if /^\[/;
	if (/^(\d+) (.*)$/) {
		$M{$1} = $2;
	}		
}
while(defined $_) {
	chomp;
	s /^\[\((.*)\)\]/$1/g;
	my @F = split(/\)\, \(/,$_);
	foreach (@F) {
		/^(.*?)\, (.*)$/;
		next if not defined $M{$1};
#		if ((defined $H{$M{$1}})&&($H{$M{$1}}!=$2)) {
#			print "$M{$1}: $H{$M{$1}} vs $2\n";
#		}
		$H{$M{$1}}=$2;
	}
	$_ = <I>;
}

close(I);

foreach (sort {$H{$a}<=>$H{$b}} keys %H) {
	print O "$_ $H{$_}\n";
}
close(O);