use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Samples";

open(I,"$data_d\\treats_sentences_ST.csv")||die;
undef my %H;
undef my @F;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	if (($F[7] eq "o_type:dsyn")||
		($F[7] eq "o_type:neop")
		) {
		$F[0] =~s /^.*\://;
		$H{$F[0]} = 1;
	}
}
close(I);

open(I,"$data_d\\treats_sentences.csv")||die;
open(O,">$data_d\\treats_sentences_DC.csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	$F[10] =~s /^.*\://;
	if (defined $H{$F[10]}) {
		print O "$_\n";
	}
}
close(I);
close(O);
