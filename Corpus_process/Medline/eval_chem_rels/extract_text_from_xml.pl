use strict;
use warnings;

undef my %T;
$T{"angiotensin converting enzyme"} = 1;
$T{"angiotensin-converting enzyme"} = 1;
$T{"angiotensin i converting enzyme"} = 1;
$T{"ACE1"} = 1;

undef my %H;

my $i_file = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\pubmed_result.xml";
open(I,"$i_file")||die;

my $str = "";
my $id = "";
while(<I>) {
	chomp;
	if (s /^\s*<PMID.*?\>(.*?)\<\/PMID\>/$1/) {
		$id = $_;
	}
	elsif (s /^\s*<ArticleTitle.*?\>(.*?)\<\/ArticleTitle\>/$1/) {
		foreach my $t (keys %T) {
			if (/\b$t\b/) {
				push @{$H{$id}},$_;
				last;
			}
		}
	}
	elsif (s /^\s*<AbstractText.*?\>(.*?)\<\/AbstractText\>/$1/) {
		my @F = split(/\./,$_);
		foreach (@F) {
			foreach my $t (keys %T) {
				if (/\b$t\b/) {
					push @{$H{$id}},"$_\.";
					last;
				}
			}
		}
	}
	
}
close(I);
my $j = 0;
foreach $id (sort keys %H) {
	my $i = 1;
	foreach (@{$H{$id}}) {
		open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\recall_files\\txt\\$id\-$i\.txt")||die;
		print O "$_\n";
		close(O);
		$i++;
	}
	$j++;
	last if $j == 500;
}