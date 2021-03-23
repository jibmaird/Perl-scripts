use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_cas\\drug";
my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\drug\_false_negatives.csv";

opendir(D,"$data_d")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

#read predictions
undef my %H;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		while (s/\<wdd:Drug .*?begin=\"(.*?)\" end=\"(.*?)\".*?textToNormalize=\"(.*?)\".*?\>//) {
			$H{$f}{"$1 $2"} = $3;
		}
	}
	close(I);
}

#read GT and check for missing annotations
$data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_brat\\drug";

opendir(D,"$data_d")||die;
@File = grep /\.ann/,readdir D;
closedir(D);

undef my %E;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	my $id;my $off;my $ent;
	while(<I>) {
		chomp;
		if (/^T(\d+)\tEntity (\d+ \d+)\t(.*)$/) {
			$id = $1;
			$off = $2;
			$ent = $3;
			if ($id > 3) {
				$id = $id % 3;
			}
			if ($id == 1) {
				my $f2 = $f;
				$f2 =~s /\.ann/\.txt/;
				if (defined $H{$f2}{$off}) {
#					print "EXACT MATCH\n";
				}
				else {
					my $ov = 0;
					foreach my $k (keys %{$H{$f2}}) {
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
		}
	}
	close(I);
}

open(O,">$o_file")||die;
print O "Entity\tFrequency\n";
foreach (sort {$E{$b}{tot}<=>$E{$a}{tot}} keys %E) {
	print O "$_\t$E{$_}{tot}\n";
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