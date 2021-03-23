use strict;
use warnings;

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

#read nested rel filter
undef my %Filt_rel;
open(I,"$data_d\\eval_nonptm\\nested_rels.txt")||die;
while(<I>) {
	chomp;
	s /^(.*? \d+\-\d+).*$/$1/;
	$Filt_rel{"$_"} = 1;
}
close(I);

#read answers
undef my %A;

opendir(D,"$data_d\\eval_nonptm\\pred")||die;
my @File = grep /\.xmi$/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d\\eval_nonptm\\pred\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		
		$F[2] =~ /A:(.*?) /;my $a = $1;
		$F[3] =~ /T:(.*?) /;my $t = $1;
		
		if ((defined $Filt{"$f $a"})&&
			(defined $Filt{"$f $t"})&&
			(not defined $Filt_rel{"$f $F[1]"})) {
			#$A{$F[0]}{"$f $F[1] $F[2] $F[3]"} = 1;
			$A{$F[0]}{"$f $F[1] $a $t"} = 1;
			}
	}	
	close(I);
}

#read gold

undef my %G;

opendir(D,"$data_d\\eval_nonptm\\gold")||die;
@File = grep /\.a2$/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d\\eval_nonptm\\gold\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		$F[2] =~ /A:(.*?) /;my $a = $1;
		$F[3] =~ /T:(.*?) /;my $t = $1;
		$F[1] =~s / .*$//;
		
		if ((defined $Filt{"$f $a"})&&
			(defined $Filt{"$f $t"})) {
			#$G{$Map{$F[0]}}{"$f $F[1] $F[2] $F[3]"} = 1;
			$G{$Map{$F[0]}}{"$f $F[1] $a $t"} = 1;
			}
	}	
	close(I);
}

#Eval

undef my %R;
	my $ttp = 0;
	my $tfp = 0;
	my $ttn = 0;
	my $tfn = 0;

foreach my $t (keys %G) {
	my $tp = 0;
	my $fp = 0;
	my $tn = 0;
	my $fn = 0;

	foreach (keys %{$A{$t}}) {
		if (defined $G{$t}{$_}) {
			$tp++;
			$ttp++;
		}
		else {
			$fp++;
			$tfp++;
		}
	}
	my $tot_g = 0;
	foreach (keys %{$G{$t}}) {
		if (not defined $A{$t}{$_}) {
			$fn++;
			$tfn++;
			print "FN:$_\n";
		}
		$tot_g++;
	}

	my $p = $tp / ($tp + $fp);
	my $r = $tp / ($tp + $fn);

	$R{$t}{p} = $p;
	$R{$t}{r} = $r;
	$R{$t}{t} = $tot_g;
}

for (sort {$R{$b}{'t'}<=>$R{$a}{'t'}} keys %R) {
	
	print "\tTotal gold sentences ($_): $R{$_}{t}";
	print "\tPrecision:$R{$_}{'p'}";
	print "\tRecall:$R{$_}{'r'}\n";
	
}

my $p = $ttp / ($ttp + $tfp);
my $r = $ttp / ($ttp + $tfn);

	print "\nOverall: Precision:$p";
	print "\tRecall:$r";