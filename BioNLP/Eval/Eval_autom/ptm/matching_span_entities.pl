use strict;
use warnings;

#Obtain list of predicted Genes that also occur in ground truth (with same span)

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP";
#NONPTM
#my $type = "nonptm";
#my $pred_d = "$data_d\\training_genia_cas";
#my $gold_d = "$data_d\\BioNLP-ST_2011_genia_train_data_rev1";
#PTM
my $type = "ptm";
my $pred_d = "$data_d\\eval_ptm\\cas";
my $gold_d = "$data_d\\BioNLP-ST_2011_Epi_and_PTM_training_data_rev1";

opendir(D,"$pred_d")||die;
my @File = grep /\....$/,readdir D;
closedir(D);

open(O,">$data_d\\eval\_$type\\shared_ent.txt")||die;
foreach my $f (@File) {
	undef my %H;
	open(I,"$pred_d\\$f")||die;
	while(<I>) {
 	    s /sofaString=\"(.*?)\"//;
    	s/<ls:Document.*?>//g;
    	while (s/<(ls||wdd):Gene xmi:id=\"(.*?)\".*?begin=\"(.*?)\" end=\"(.*?)\"(.*?)>//) {
    		$H{"$3 $4"} = 1;
    	}
	}
	close(I);
	
	$f =~s /\.txt\.xmi$/\.a1/;
	$f =~s /\.txt$/\.a1/;
	open(I,"$gold_d\\$f")||die;
	$f =~s /\.a1$//;
	while(<I>) {
		chomp;
		if (/Protein\s(\d+ \d+)\s/) {
			if (defined $H{$1}) {
				print O "$f $_\n";
			}
		}
	}
	close(I);
}
close(O);