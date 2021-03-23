use strict;
use warnings;

#read gold
undef my %G;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";
my $in_d = "$data_d\\BioNLP-ST_2011_genia_train_data_rev1";
my $out_d = "$data_d\\eval_nonptm";


open(N,">$out_d\\nested_rels.txt")||die;

opendir(D,"$in_d")||die;
my @File = grep /\.a1$/,readdir D;
closedir(D);

foreach my $f (@File) {
	undef my %H;
	open(O,">$out_d\\gold\\$f")||die;
	open(I,"$in_d\\$f")||die;
	while(<I>) {
		chomp;
		my @F = split(/\t/,$_);
		$F[1] =~ / (\d+) (\d+)$/;
		$H{$F[0]} = "$1\-$2 $F[2]";
	}
	close(I);
	$f =~s /\.a1$/\.a2/;
	open(I,"$in_d\\$f")||die;
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
			print O "$2\t$H{$3}\tA:$H{$5}\tT:$H{$4}\n";
		}
		elsif (/^E(\d+)\t(.*?)\:(T\d+).*?:(E\d+)/) {
			print N "$f $H{$3}\n";
		}
	}
	close(I);
	close(O);
}
close(N);
