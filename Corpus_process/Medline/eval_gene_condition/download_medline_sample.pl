use strict;
use warnings;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170810";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\T258857";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\S264946";

undef my %H;
open(I,"$data_d\\ids.txt")||die;
#open(I,"$data_d\\p53.txt")||die;
while(<I>) {
	chomp;
#	if (/Medline\_(\d+)/) {
#		$H{$1} = 1;
#	}
	$H{$_}=1;
}
close(I);

foreach (keys %H) {
	my $a;
	if (-e "$data_d\\pmid\\$_") {
		open FILE, "$data_d\\pmid\\$_" ||die;
		local $/;
		$a = <FILE>;
		close(FILE);
	}
	else {
		$a = `C:\\Users\\IBM_ADMIN\\Downloads\\curl-7.52.1_w32\\src\\curl.exe https://www.ncbi.nlm.nih.gov/pubmed/?term=$_`;	
	}
	
	$a=~ /<h1>(.*?)<\/h1>.*?<AbstractText>(.*?)<\/AbstractText>/m;
	my $t = $1;
	my $abs = $2;
	
	open(O,">$data_d\\pmid2\\$_\.txt")||die;
	print O "$t\n$abs\n";
	close(O);
}
