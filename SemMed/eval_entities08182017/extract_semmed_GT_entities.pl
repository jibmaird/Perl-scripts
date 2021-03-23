use strict;
use warnings;

#my @F = ("biologic","chem","cond","drug","gene");
my @F = ("biologic","chem","cond","drug");

foreach (@F) {
	my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples\\$_\_sentences_sample.csv";
	my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_brat\\$_";
	system("perl extract_semmed_ground_truth.pl $in_f $out_d");
}