use strict;

use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06272017";
my $out_d = "$data_d\\gt_noneg";

if (not -e "$out_d") {
	system("md $out_d");
}

opendir(D,"$data_d\\gt")||die;
my @File = grep /\.ann$/,readdir D;
closedir(D);

foreach my $f (@File) {
	undef my %H;
	open(I,"$data_d\\gt\\$f")||die;
	while(<I>) {
		chomp;
		if (/^M\d+\tNegation (.*)$/) {
			$H{$1} = 1;
		}
	}
	close(I);
	open(I,"$data_d\\gt\\$f")||die;
	open(O,">$data_d\\gt_noneg\\$f")||die;
	while(<I>) {
		if (/^(E\d+)\s/) {
			if (defined $H{$1}) {
				print "$f: $_\n";
				next;
			}
		}
		print O;
	}
	close(I);
	close(O);
	#$f =~s /\.ann/\.txt/;
	#system("copy $data_d\\gt\\$f $data_d\\gt_noneg\\$f");
}

