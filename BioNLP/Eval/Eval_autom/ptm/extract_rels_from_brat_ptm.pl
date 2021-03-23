use strict;
use warnings;

#read gold
undef my %G;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";
#my $gt_d = "$data_d\\BioNLP-ST_2011_Epi_and_PTM_training_data_rev1";
#my $out_d = "$data_d\\eval_ptm";

my $gt_d = "C:\\Users\\IBM_ADMIN\\ws02132017\\wdd-ivt\\src\\main\\resources\\groundtruth\\source\\relation\\ptm";
my $out_d = "$data_d\\eval_ptm\\gt_ingestion";

if (not -e $out_d) {
	system("md $out_d");
}

open(N,">$out_d\\nested_rels.txt")||die;

opendir(D,"$gt_d")||die;
my @File = grep /\.a1$/,readdir D;
closedir(D);

foreach my $f (@File) {
	undef my %H;
	open(O,">$out_d\\gold\\$f")||die;
	open(I,"$gt_d\\$f")||die;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		$F[1] =~ / (\d+) (\d+)$/;
		$H{$F[0]} = "$1\-$2 $F[2]";
	}
	close(I);
	$f =~s /\.a1$/\.a2/;
	open(I,"$gt_d\\$f")||die;
	open(O,">$out_d\\gold\\$f")||die;
	$f =~s /\.a2//;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		
		if (/^T/) {
			my @F = split(/\t/,$_);
			$F[1] =~ / (\d+) (\d+)$/;
			$H{$F[0]} = "$1\-$2 $F[2]";
		}
		elsif (/^E(\d+)\t(.*?)\:(T\d+) Theme:(T\d+) Cause:(T\d+)/) {
			
			print "$2\t$H{$3}\tA:$H{$5}\tT:$H{$4}\n";
			#print O "$2\t$H{$3}\tA:$H{$5}\tT:$H{$4}\n";
		}
		elsif (/^E(\d+)\t(.*?)\:(T\d+) Theme:(T\d+)/) {
			
			#print "$2\t$H{$3}\tT:$H{$4}\n";
			print O "$2\t$H{$3}\tT:$H{$4}\n";
		}
		elsif (/^E(\d+)\t(.*?)\:(T\d+).*?:(E\d+)/) {
			print N "$f $H{$3}\n";
		}
	}
	close(I);
	close(O);
}
close(N);
