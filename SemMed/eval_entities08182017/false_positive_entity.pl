use strict;
use warnings;

my $id1 = "drug"; my $id2 = "Drug"; my $brat_argid = 1;
#my $id1 = "cond"; my $id2 = "Condition"; my $brat_argid = 2;
#my $id1 = "gene"; my $id2 = "Gene"; my $brat_argid = 2;
#my $id1 = "chem"; my $id2 = "Chemical"; my $brat_argid = 1;


my $txt_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_txt\\$id1";
my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\semmed\_$id1\_false_positives.csv";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_brat\\$id1";

opendir(D,"$data_d")||die;
my @File = grep /\.ann/,readdir D;
closedir(D);

#read read GT
undef my %H;
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
			#if ($id == $brat_argid) {
				$H{$f}{$off} = $ent;
			#}
		}
	}
	close(I);
}
	
	

# read predictions in CAS and check for missing annotations
$data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples_cas\\$id1";

opendir(D,"$data_d")||die;
@File = grep /\.txt/,readdir D;
closedir(D);

undef my %E;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		my $f2 = $f;
		$f2 =~s /\.txt/\.ann/;
		while (s/\<wdd:$id2 .*?begin=\"(.*?)\" end=\"(.*?)\".*?textToNormalize=\"(.*?)\".*?\>//) {
			my $off = "$1 $2";
			my $ent = $3;
			if (defined $H{$f2}{$off}) {	
					print "EXACT MATCH\n";
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
				else {
					print "OVERLAP\n";
				}
			}
		}
	}
	close(I);
}

open(O,">$o_file")||die;
print O "Entity\tFrequency\tExample File\tExample Sentence\n";
foreach (sort {$E{$b}{tot}<=>$E{$a}{tot}} keys %E) {
	my $aux = $_;
	$aux =~s /\t+/ /g;
	my $tot = $E{$_}{tot};
	
	my $i = 0;
	my $e = $_;
	foreach my $f (sort keys %{$E{$_}{f}}) {
		$f =~s /\.ann/\.txt/;
		open(I,"$txt_d\\$f")||die "$txt_d\\$f\n";
		my $str = "";
		while(<I>) {
			chomp;
			$str .= " $_"
		}
		close(I);
		my @F = split(/\./,$str);
		foreach (@F) {
			if (/$e/) {
				
				print O "$aux\t$tot";
				print O "\t$f\t$_\n";
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