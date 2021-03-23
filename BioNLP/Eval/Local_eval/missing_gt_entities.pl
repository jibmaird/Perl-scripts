use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06162017";

opendir(D,"$data_d\\gt")||die;
my @File = grep /\.ann$/,readdir D;
closedir(D);

undef my %E;
foreach my $f (@File) {
	undef my %H;
	open(I,"$data_d\\brat\\$f")||next;
	while(<I>) {
		if (/^T.*?\t.*? (\d+ \d+)\t(.*)$/) {
			$H{$1} = $2;
		}
	}
	close(I);

	open(I,"$data_d\\gt\\$f")||die;
	while(<I>) {
		chomp;
		if (/^T.*?\tProtein (\d+ \d+)\t(.*)$/) {
			if (not defined $H{$1}) {
				$E{$2}++;
			}
		}
	}
	close(I);
	
}
print "List:\n";
foreach (sort {$E{$b}<=>$E{$a}} keys %E) {
	print "$_ $E{$_}\n";
}