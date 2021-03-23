use strict;
use warnings;

my (@File,$f,@F,%H);

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\brat08152016";

opendir(D,"$data_d")||die;
@File = grep /\.ann$/,readdir D;
closedir(D);
foreach $f (@File) {
	open(I,"$data_d\\$f")||die;
	undef %H;
	while(<I>) {
		chomp;
		if (/^[ER]\d+/) {
			@F = split(/\t/,$_);
			$F[1] =~ /^(.*?)\:(.*?) /;
			print "$f\t$1\t$H{$2}\n" if $1 ne "Prepositional";
		}
		elsif (/^T\d+/) {
			@F = split(/\t/,$_);
			$F[1] =~ /^.*? (\d+) (\d+)$/;
			$H{$F[0]} = "$1\-$2\-$F[2]";
		}
	}
	close(I);
}