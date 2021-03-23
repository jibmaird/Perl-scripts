use strict;
use warnings;

#undef my %A;
#$A{"tnf"} = 1;
#$A{"TNF"} = 1;
#$A{"Tumor necrosis factor"} = 1;
#$A{"TNF-alpha"} = 1;

#undef my %T;
#$T{"Ankylosing spondylitis"} = 1;
#$T{"ankylosing spondylitis"} = 1;

my %A = ("LEP"=>1,"leptin"=>1,"Leptin"=>1,"Lep"=>1,"LEPTIN"=>1,"HD-leptin"=>1,"LeP"=>1,"PEG-OB"=>1);
my %T = ("obese"=>1,"obesity"=>1,"Obs"=>1,"Ob"=>1,"Adiposity"=>1,"MBI"=>1,"MOB"=>1);

undef my %H;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\T258857";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946";
my $i_file = "$data_d\\pubmed_result.xml";
open(I,"$i_file")||die;

my $str = "";
my $id = "";
while(<I>) {
	chomp;
	if (s /^\s*<PMID.*?\>(.*?)\<\/PMID\>/$1/) {
		$id = $_;
	}
	elsif (s /^\s*<ArticleTitle.*?\>(.*?)\<\/ArticleTitle\>/$1/) {
		my $tf = 0;
		my $af = 0;
		foreach my $t (keys %T) {
			if (/\b$t\b/) {			
				$tf = 1;
				last;
			}
		}
		foreach my $a (keys %A) {
			if (/\b$a\b/) {
				$af = 1;
				last;
			}
		}
		if ($af+$tf==2) {
			push @{$H{$id}},$_;
		}
	}
	
	elsif (s /^\s*<AbstractText.*?\>(.*?)\<\/AbstractText\>/$1/) {
		my @F = split(/\./,$_);
		foreach (@F) {
			my $tf = 0;
			my $af = 0;
			foreach my $t (keys %T) {
				if (/\b$t\b/) {			
					$tf = 1;
					last;
				}
			}
			foreach my $a (keys %A) {
				if (/\b$a\b/) {
					$af = 1;
					last;
				}
			}
			if ($af+$tf==2) {
				push @{$H{$id}},"$_\.";
			}
		}
	}
	
}
close(I);
my $j = 0;
foreach $id (sort keys %H) {
	my $i = 1;
	foreach (@{$H{$id}}) {
		open(O,">$data_d\\recall_files\\txt\\$id\-$i\.txt")||die;
		print O "$_\n";
		close(O);
		$i++;
	}
	$j++;
	last if $j == 500;
}