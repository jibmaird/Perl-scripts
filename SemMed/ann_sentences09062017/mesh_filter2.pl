use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity";

undef my %H;
open(I,"$data_d\\depression.mobd.sent.csv")||die;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	$F[1] =~s /^.*?\://;
	$H{$F[1]} = $_;
}
close(I);

#DEBUG
#undef %H;
#$H{"7719400"} = 1;
#$H{"4760487"} = 1;
open(O,">$data_d\\depression.mobd.sent_filt.csv")||die;
foreach my $k (keys %H) {
	$_ = `perl solr_query.pl $k`;
	my @F = split(/\,/,$_);
	my $found = 0;
	foreach (@F) {
		if ((/Depression\//)||(/Depressive Disorder/)||(/Adolescent/)||(/Humans/)) {
			$found = 1;
			last;
		}
	}
	if ($found == 1) {
		print O "$H{$k}\n";
	}
}
close(O);