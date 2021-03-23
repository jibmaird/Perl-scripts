use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";
my $type = "ptm";

my %Map = 
("dna_methylation"=>"methylation"
);

#read entity filter (only relations with shared entities are considered)
undef my %Filt;

open(I,"$data_d\\eval\_$type\\shared_ent.txt")||die;
while(<I>) {
	chomp;
	/^(.*?) .*?Protein\s(\d+) (\d+)\s/;
	$Filt{"$1 $2\-$3"} = 1;
	
}
close(I);

#read nested rel filter (nested relations need to be removed from GT)
undef my %Filt_rel;
open(I,"$data_d\\eval\_$type\\nested_rels.txt")||die;
while(<I>) {
	chomp;
	s /^(.*? \d+\-\d+).*$/$1/;
	$Filt_rel{"$_"} = 1;
}
close(I);

#read answers
undef my %A;

opendir(D,"$data_d\\eval\_$type\\pred")||die;
my @File = grep /\.txt$/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d\\eval\_$type\\pred\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		
		$F[2] =~ /T:(.*?) /;my $t = $1;
		
		#if (
		#(defined $Filt{"$f $t"})&&
		#	(not defined $Filt_rel{"$f $F[1]"})) {
			#$A{$F[0]}{"$f $F[1] $t"} = 1;
			$A{"All rels"}{"$f $F[1] $t"} = $F[0];
		#	}
	}	
	close(I);
}

#read gold

undef my %G;

opendir(D,"$data_d\\eval\_$type\\gold")||die;
@File = grep /\.a2$/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$data_d\\eval\_$type\\gold\\$f")||die;
	$f =~s /\..*$//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		$F[2] =~ /T:(.*?) /;my $t = $1;
		$F[1] =~s / .*$//;
		
		if (
		    (defined $Filt{"$f $t"})) { 
	#		(not defined $Filt_rel{"$f $F[1]"})) {
	
			$F[0] = lc($F[0]);
			$F[0] = $Map{$F[0]} if defined $Map{$F[0]};
			$G{"All rels"}{"$f $F[1] $t"} = $F[0];
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
			if ($A{$t}{$_} ne $G{$t}{$_}) {
				print "Key: $_\tPred:$A{$t}{$_}\tGold:$G{$t}{$_}\n";
			}
		}
		else {
			$fp++;
			$tfp++;
			print "FP: $_\n";
		}
	}
	my $tot_g = 0;
	foreach (keys %{$G{$t}}) {
		if (not defined $A{$t}{$_}) {
			$fn++;
			$tfn++;
			print "FN: $_\n";
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