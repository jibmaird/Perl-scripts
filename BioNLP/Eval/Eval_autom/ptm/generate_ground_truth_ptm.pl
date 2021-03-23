use warnings;
use strict;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";
#my $brat_d = "C:\\Users\\IBM_ADMIN\\ws02132017\\wdd-ivt\\src\\main\\resources\\groundtruth\\source\\relation\\ptm";
my $brat_d = "$data_d\\eval_ptm\\gt_tmp";
my $oneline_d = "$data_d\\eval_ptm\\gt_oneline";

if (not -e $oneline_d) {
	system("md $oneline_d");
}

#read entity filter
undef my %Filt;

open(I,"$data_d\\eval_ptm\\shared_ent.txt")||die;
while(<I>) {
	chomp;
	/^(.*?) .*?Protein\s(\d+) (\d+)\s/;
	$Filt{"$1 $2\-$3"} = 1;
	
}
close(I);

#read gold

undef my %G;

opendir(D,"$data_d\\eval_ptm\\gold")||die;
my @File = grep /\.a2$/,readdir D;
closedir(D);

undef my %Ffilt;
foreach my $f (@File) {
	
	open(I,"$data_d\\eval_ptm\\gold\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		
		$F[2] =~ /T:(.*?) /;my $t = $1;
		
		if (
			defined $Filt{"$f $t"}) {
			$G{$f}{"$_"} = 1;
			}
			else {
				$Ffilt{$f} = 1;
			}
	}	
	close(I);
}
foreach my $f (keys %G) {
	next if $Ffilt{$f};
	open(I,"$data_d\\BioNLP-ST_2011_Epi_and_PTM_training_data_rev1\\$f.txt")||die;
	open(O,">$brat_d\\$f\.txt")||die ">$brat_d\n";
	
	while(<I>) {
		print O;
	}
	close(I);
	close(O);
	
	open(O,">$brat_d\\$f\.ann")||die;
	open(O2,">$oneline_d\\$f\.txt")||die;
	my $t = 1; my $e = 1;
	foreach (keys %{$G{$f}}) {
		print O2 "$_\n";
		my @F = split(/\t/,$_);
		$F[1] =~s /(\d+\-\d+) /$1\t/;
		$F[2] =~s /(\d+\-\d+) /$1\t/;
		
		$F[2] =~s /^T://;
		print O "T$t\tGene $F[2]\n";
		my $ttar = $t;
		$t++;
		
		print O "T$t\t$F[0] $F[1]\n";
		my $trel = $t;
		$t++;
		print O "E$e\t$F[0]\:T$trel Theme:T$ttar\n";
		$e++;
		
	}
	close(O);
	close(O2);
}
