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
	undef my %T;
	while(<I>) {
		chomp;
		if (/^T(.*?)\tProtein (\d+ \d+)\t(.*)$/) {
			$T{$1}{sp} = $2;
			$T{$1}{st} = $3;
		}
		elsif (s/^E\d+\t.*?\:T(\d+)//) {
				if ((defined $T{$1})&&
				    (not defined $H{$T{$1}{sp}})) {
					$E{$T{$1}{st}}++;
				}
				while(s /T(\d+)//) {
					if ((defined $T{$1})&&
					    (not defined $H{$T{$1}{sp}})) {
						$E{$T{$1}{st}}++;
					}
				}
			}
	}
	close(I);
	
}
print "List:\n";
foreach (sort {$E{$b}<=>$E{$a}} keys %E) {
	print "$_ $E{$_}\n";
}