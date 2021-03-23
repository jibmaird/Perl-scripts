use warnings;
use strict;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";

my %Map = 
("Positive_regulation"=>"RegulationPositive",
"Negative_regulation"=>"RegulationNegative",
"Regulation"=>"Regulation"
);

#read entity filter
undef my %Filt;
open(I,"$data_d\\eval_nonptm\\shared_ent.txt")||die;
while(<I>) {
	chomp;
	/^(.*?) .*?Protein\s(\d+) (\d+)\s/;
	$Filt{"$1 $2\-$3"} = 1;
	
}
close(I);

#read gold

undef my %G;

opendir(D,"$data_d\\eval_nonptm\\gold")||die;
my @File = grep /\.a2$/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d\\eval_nonptm\\gold\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		$F[2] =~ /A:(.*?) /;my $a = $1;
		$F[3] =~ /T:(.*?) /;my $t = $1;
		
		if ((defined $Filt{"$f $a"})&&
			(defined $Filt{"$f $t"})) {
			$G{$f}{"$_"} = 1;
			}
	}	
	close(I);
}
foreach my $f (keys %G) {
	open(I,"$data_d\\BioNLP-ST_2011_genia_train_data_rev1\\$f.txt")||die;
	open(O,">C:\\Users\\IBM_ADMIN\\ws02132017\\wdd-ivt\\src\\main\\resources\\groundtruth\\source\\nonptm\\$f\.txt")||die;
	while(<I>) {
		print O;
	}
	close(I);
	close(O);
	
	open(O,">C:\\Users\\IBM_ADMIN\\ws02132017\\wdd-ivt\\src\\main\\resources\\groundtruth\\source\\nonptm\\$f\.ann")||die;
	my $t = 1; my $e = 1;
	foreach (keys %{$G{$f}}) {
		my @F = split(/\t/,$_);
		$F[1] =~s /(\d+\-\d+) /$1\t/;
		$F[2] =~s /(\d+\-\d+) /$1\t/;
		$F[3] =~s /(\d+\-\d+) /$1\t/;
		
		$F[2] =~s /^A://;
		$F[3] =~s /^T://;
		print O "T$t\tGene $F[2]\n";
		my $tage = $t;
		$t++;
		print O "T$t\tGene $F[3]\n";
		my $ttar = $t;
		$t++;
		print O "T$t\t$Map{$F[0]} $F[1]\n";
		my $trel = $t;
		$t++;
		print O "E$e\t$Map{$F[0]}\:T$trel Agent:T$tage Theme:T$ttar\n";
		$e++;
		
	}
	close(O);
}
