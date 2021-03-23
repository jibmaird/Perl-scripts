use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06162017";
my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\bionlp_gene_false_negatives.csv";
open(O,">$o_file")||die;
print O "Gene\tFrequency\tExample File\tExample Sentence\n";

opendir(D,"$data_d\\brat")||die;
my @File = grep /\.ann$/,readdir D;
closedir(D);

undef my %E;
foreach my $f (@File) {

	open(I,"$data_d\\brat\\$f")||die;
	undef my %H;
	
	while(<I>) {
		chomp;
		if (/^T.*?\tcom_ibm_wdd_Gene (\d+ \d+)\t(.*)$/) {
			$H{$f}{$1}=$2;
		}
	}
	close(I);

	open(I,"$data_d\\gt\\$f")||next;
	while(<I>) {
		
		if (/^T.*?\tProtein (\d+ \d+)\t(.*)$/) {
			my $ov = 0;
			my $off = $1;
			my $ent = $2;
			foreach my $k (keys %{$H{$f}}) {
				if (&Overlaps($off,$k)) {
					$ov = 1;
					last;
				}
			}
			if ($ov == 0) {
				$E{$ent}{tot}++;
				$E{$ent}{f}{$f} = 1;
			}
		}
	}
	close(I);	
}

foreach (sort {$E{$b}{tot}<=>$E{$a}{tot}} keys %E) {
	my $g = $_;
	#print "\n$_\t$E{$_}{tot}\n";
	my $i = 0;
	my $gene = $_;
	foreach my $f (sort keys %{$E{$_}{f}}) {
		$f =~s /\.ann/\.txt/;
		#print "\t$f\n";
		open(I,"$data_d\\gt\\$f")||die;
		my $str = "";
		while(<I>) {
			chomp;
			$str .= " $_"
		}
		close(I);
		my @F = split(/\./,$str);
		foreach (@F) {
			if ($gene =~ /\)/) {
				next;
			}
			elsif (/$gene/) {
				print O "$g\t$E{$g}{tot}\t$f\t$_\n";
				last;
			}
		}
		$i++;
		last if $i == 1;
	}
}
close(O);

sub Overlaps {
	my $off = $_[0];
	my $off2 = $_[1];
	my ($x1,$x2,$y1,$y2);
	($x1,$x2) = split(/ /,$off);
	($y1,$y2) = split(/ /,$off2);
	
	if ($x1 <= $y2 && $y1 <= $x2) {
		return 1;
	}
	else {
		return 0;
	}
	
}