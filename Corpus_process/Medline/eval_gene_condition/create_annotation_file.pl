use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946\\pmid2";


my %A = ("LEP"=>1,"leptin"=>1,"Leptin"=>1,"Lep"=>1,"LEPTIN"=>1,"HD-leptin"=>1,"LeP"=>1,"PEG-OB"=>1);
my %T = ("obese"=>1,"obesity"=>1,"Obs"=>1,"Ob"=>1,"Adiposity"=>1,"MBI"=>1,"MOB"=>1);

undef my %R;
open(I,"$data_d\\..\\rel_terms.txt")||die;
while(<I>) {
	chomp;
	while(s/(.*?)\s+\d+//) {
		$R{$1} = 1 if length($1)>2;
	}
}
close(I);

opendir(D,"$data_d")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

open(O,">$data_d\\..\\precision_ann.csv")||die;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		my @F = split(/\./,$_);
		foreach (@F) {
			my $af = ""; my $tf = ""; my $rf = "";
			foreach my $a (keys %A) {
				if (/\b$a\b/i) {
					$af = $a;
					last;
				}
			}
			next if $af eq "";
			foreach my $t (keys %T) {
				if (/\b$t\b/i) {
					$tf = $t;
					last;
				}
			}
			next if $tf eq "";
			foreach my $r (keys %R) {
				if (/\b$r\b/i) {
					$rf = $r;
					last;
				}
			}
			next if $rf eq "";
			
			print O "$f\t$af\t$rf\t$tf\t$_\n";
		}
	}
	close(I);
}
close(O);