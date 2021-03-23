use strict;

use vars qw (@F @File $f);

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test07292016\\out";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160726\\xmi_orig";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test12142016\\cas_06072016";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test06072016\\out";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170906\\cas_sample6k";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170808\\sample6k_cas";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170928\\DTC_rels_20170808.txt";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170928\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170928\\DTC_rels_20170928.txt";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\training_genia_cas";
my $o_file = "$data_d\\..\\rels.txt";

my $tot_c = 0;

opendir(D,"$data_d")||die;
@File = grep /^\d/,readdir D;
closedir(D);
#DEBUG
#@File = ("25033.txt.xmi");
@File = ("PMC-2626671-07-RESULTS_AND_DISCUSSION-06.txt.xmi");

open(O,">$o_file")||die;
foreach $f (@File) {
	print "$f\n";
	&read_xmi("$data_d\\$f");
}
print "\nTOTAL: $tot_c\n";
close(O);

sub read_xmi {
	
my (%H,$cn,$ag,$th,$aux,$id,@F);

my $text = "";
my $in_f = $_[0];

undef %H;
open(I,"$in_f")||die;
while(<I>) {
    if (s /sofaString=\"(.*?)\"//) {
	$text = $1;
	#$text =~s /\&\#1[03]\;/ /g; ##spaces
	$text =~s /\&amp\;/\&/g; #escape characters
	$text =~s /\&lt\;/\</g; #escape characters
	$text =~s /\&gt\;/\>/g; #escape characters
    }
    s/<ls:Document.*?>//g;
    while (s/<(ls||wdd):(.*?) xmi:id=\"(.*?)\".*?begin=\"(.*?)\" end=\"(.*?)\"(.*?)>//) {
		$H{$3}{t} = $2;
		$H{$3}{b} = $4;
		$H{$3}{e} = $5;
		$aux = $6;
		$id = $3;
		if ($aux =~ /canonicalName=\"(.*?)\"/) {
	    	$H{$id}{cn} = $1;}
		else {
	    	$H{$id}{cn} = "";}
    }
}
close(I);

open(I,"$in_f")||die;

while(<I>) {
    #while (s/<ls:(.*?) xmi:id=\".*?\".*?begin=\"(.*?)\" end=\"(.*?)\".*?canonicalName=\"(.*?)\".*?agents=\"(.*?)\" targets=\"(.*?)\"//) {
    #while (s/<(ls||wdd):(.*?) xmi:id=\".*?\".*?begin=\"(.*?)\" end=\"(.*?)\".*?canonicalName=\"(.*?)\".*?agents=\"(.*?)\" targets=\"(.*?)\"//) {	
    while (s/<(ls||wdd):(NonPtm) xmi:id=\".*?\".*?begin=\"(.*?)\" end=\"(.*?)\".*?canonicalName=\"(.*?)\".*?agents=\"(.*?)\" targets=\"(.*?)\"//) {		
		$cn = $5;
		$ag = $6;
		$th = $7;
		my $type = $2;
		my $span = substr($text,$3,$4-$3);
		
		my @Ag = split(/ /,$ag);
		my @Th = split(/ /,$th);
		foreach $ag (@Ag) {
			foreach $th (@Th) {
				undef @F;
				push @F,$type;
				push @F,$in_f;
				push @F,$text;
				push @F,$span;
				push @F,$cn;
				
				$_ = substr($text,$H{$ag}{b},$H{$ag}{e}-$H{$ag}{b});
				push @F,$_;
				push @F,$H{$ag}{cn};
				push @F,$H{$ag}{t};
				
				$_ = substr($text,$H{$th}{b},$H{$th}{e}-$H{$th}{b});
				push @F,$_;
				push @F,$H{$th}{cn};
				push @F,$H{$th}{t};
			
				#if (($F[6] eq "Mutation")||($F[9] eq "Mutation")) {
					$_ = join "\t",@F;
					print O "$type $_\n";
					$tot_c++;
				#}
			}
		}
    }
}
close(I);

}
