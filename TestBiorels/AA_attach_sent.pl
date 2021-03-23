use warnings;
use strict;

my $v = 2;
my $r = 1;
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170526";
#my $i_file = "$data_d\\com.ibm.wda.ls.Residue.csv";
#my $o_file = "$data_d\\com.ibm.wda.ls.Residue.sentence.csv";

my $i_file = "$data_d\\PTM.Multiple_Residues_Del_Ind.csv";
my $o_file = "$data_d\\PTM.Multiple_Residues_Del_Ind.sentence.csv";



open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\Medline\\CDM\\part-r-00000_100k_3_ext.del")||die;
undef my %H;
while(<I>) {
	chomp;
	/^\d+\,(\d+)\,(.*)$/;
	
	$H{$1} = $2;
}
close(I);

open(I,"$i_file")||die;
open(O,">$o_file")||die;
$_ = <I>;
print O;

while(<I>) {
	chomp;
	s /^\"(.*)\"$/$1/;
	s /\"\,\"/\,/g;
	my @F = split(/\,/,$_);
	
		$F[$v] =~s /\s+\[.*\]\s*$//;
		$F[$r] =~s /\s+\[.*\]\s*$//;
		my @G = split(/\./,$H{$F[0]});
		foreach my $s (@G) {
			$F[$r] = quotemeta($F[$r]);
			if (($s =~ /$F[$r]/)&&($s =~ /$F[$v]/)) {
				print O "$_\,$s\"\n";
				print "$_\,$s\"\n";
				last;
			}	
		}
}
close(I);
close(O);