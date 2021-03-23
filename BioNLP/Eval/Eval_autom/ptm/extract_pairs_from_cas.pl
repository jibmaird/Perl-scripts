use strict;
use warnings;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\training_genia_cas";
#my $out_d = "$data_d\\..\\eval_nonptm\\pred";
#my $type = "NonPtm";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\eval_ptm\\cas";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\eval_ptm\\pred";
my $type = "Ptm";

opendir(D,"$data_d")||die;
#my @File = grep /\.xmi$/,readdir D;
my @File = grep /\.txt$/,readdir D;
closedir(D);
#DEBUG
#@File = ("PMC-2626671-07-RESULTS_AND_DISCUSSION-06.txt.xmi");
undef my %H;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	open(O,">$out_d\\$f")||die;
	while(<I>) {
 	    s /sofaString=\"(.*?)\"//;
    	s/<ls:Document.*?>//g;
    	while (s/<(ls||wdd):(.*?) xmi:id=\"(.*?)\".*?begin=\"(.*?)\" end=\"(.*?)\"(.*?)>//) {
			$H{$3}{t} = $2;
			$H{$3}{b} = $4;
			$H{$3}{e} = $5;
			my $aux = $6;
			my $id = $3;
			#if ($aux =~ /canonicalName=\"(.*?)\"/) {
			if ($aux =~ /textToNormalize=\"(.*?)\"/) {
	    		$H{$id}{tn} = $1;}
			else {
	    		$H{$id}{tn} = "";}
	 
    	}
	}
	close(I);
	open(I,"$data_d\\$f")||die;

	while(<I>) {
    	while (s/<(ls||wdd):($type) xmi:id=\".*?\".*?begin=\"(.*?)\" end=\"(.*?)\".*?canonicalName=\"(.*?)\"(.*?)>//) {		
			my $b = $3;
			my $e = $4;
			my $cn = $5;
			my $aux = $6;
			if (not $aux =~/targets=\"(.*?)\"/) {
				next;
			}
			my $th = $1;
			my @Th = split(/ /,$th);
			
			foreach $th (@Th) {
				print O "$cn\t$b\-$e\tT:$H{$th}{b}\-$H{$th}{e} $H{$th}{tn}\n";
				print "$f $cn\t$b\-$e\tT:$H{$th}{b}\-$H{$th}{e} $H{$th}{tn}\n"; 
			}
    	}
    }
	close(I);
	close(O);
}