use strict;
use warnings;

my $data_d2 = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06272017";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06162017";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017";

	

open(I,"$data_d\\result.txt")||die;
open(O,">$data_d\\result2.txt")||die;
while(<I>) {
	print O;
	chomp;
	if (/^False .*?: (.*)\-(\d+\-\d+)\-(.*)$/) {
		my $f = $1;
		my $rg = $2;
		my $rel = $3;
		$rg =~s /\-/ /;
		#read predicted gene annotations
		undef my %H;
		open(P,"$data_d\\brat\\$f\.ann")||next;
		while(<P>) {
			if (/^T.*?\t.*? (\d+ \d+)\t(.*)$/) {
				$H{$1} = $2;
			}
		}
		close(P);	
		
		undef my %T;
		my $t = "";
		open(I2,"$data_d2\\gt_noneg\\$f\.ann")||die;
		while(<I2>) {
			chomp;
			if (/^T(\d+)\t.*? $rg\t$rel$/) {
				$t = $1;
				print O "$_\n";
			}
			elsif (/^T(\d+)\t.*? (\d+ \d+)/) {
				$T{$1}{l} = $_;
				$T{$1}{rg} = $2;
				print O "$_\n";
			}
			elsif (s/^(E\d+\t.*?\:T$t)//) {
				print O "$1$_\n";
				while(s /T(\d+)//) {
					print O "*" if not defined $H{$T{$1}{rg}};
					print O "$T{$1}{l}\n";
				}
			}
		}
		close(I2);
	}
}
close(I);
close(O);