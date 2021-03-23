use strict;
use warnings;

my $f;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\Sample_mutation_relations";

undef my %H;

opendir(D,"$data_d\\brat08122016")||die;
my @File = grep /\.ann/,readdir D;
closedir(D);

foreach $f (@File) {
	open(I,"$data_d\\brat08122016\\$f")||die;
	while(<I>) {
		chomp;
		if (/\tMutation (.*?) (.*?)\t/) {
			$H{$f}{"$1\-$2"} = 1;
		}
	}
	close(I);
}

foreach $f (@File) {
	open(I,"$data_d\\brat\\$f")||die;
	while(<I>) {
		chomp;
		if (/\tMutation (.*?) (.*?)\t/) {
			$_ = "$1\-$2";
			if (not defined $H{$f}{$_}) {
				print "NOT FOUND: $f $_\n";
			}
		}
	}
	close(I);
}
