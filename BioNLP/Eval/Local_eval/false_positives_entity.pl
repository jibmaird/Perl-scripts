use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06162017";

opendir(D,"$data_d\\gt")||die;
my @File = grep /\.ann$/,readdir D;
closedir(D);

undef my %E;
foreach my $f (@File) {

	open(I,"$data_d\\gt\\$f")||die;
	undef my %H;
	
	while(<I>) {
		chomp;
		if (/^T.*?\tProtein (\d+ \d+)\t(.*)$/) {
			$H{$1}{$f}=1;
		}
	}
	close(I);

	open(I,"$data_d\\brat\\$f")||next;
	while(<I>) {
		if (/^T.*?\tcom_ibm_wdd_Gene (\d+ \d+)\t(.*)$/) {
			if (not defined $H{$1}{$f}) {
				$E{$2}{tot}++;
				$E{$2}{f}{$f} = 1;
			}
		}
	}
	close(I);	
}

foreach (sort {$E{$b}{tot}<=>$E{$a}{tot}} keys %E) {
	print "\n$_\t$E{$_}{tot}\n";
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
			if (/$gene/) {
				print "$f\t$_\n";
				last;
			}
		}
		$i++;
		last if $i == 5;
	}
}
