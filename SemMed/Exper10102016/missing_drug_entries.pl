use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test10102016\\treats_drug";


opendir(D,"$data_d")||die;
my @Files = grep /^\d/,readdir D;
closedir(D);

undef my %H;
foreach my $f (@Files) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		$H{$_} = 1;
	}
	close(I);
}

open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\treats_sentences.csv")||die;
open(O,">C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test10102016\\missing_drug.csv")||die;
while(<I>) {
	chomp;
	my @F = split(/\t/,$_);
	$F[17] =~s /SENT\_SENTENCE\://;
	if (defined $H{$F[17]}) {
		print O "$_\n";
	}
}
close(O);
close(I);