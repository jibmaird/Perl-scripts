# Extract txt files from gold standard

use vars qw ();

open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\adjudicated.xml")||die;
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016\\txt";
my $pmid = "";
while(<I>) {
	chomp;
	if (/<MedlineCitation pmid=\"(.*?)\">/) {
		$pmid = $1;
	}
	elsif (/<Sentence section=\"(.*?)\" number=\"(.*?)\" text=\"(.*?)\"\>/) {
		open(O,">$out_d\\$pmid\_$1\_$2\.txt")||die;
		print O "$3\n";
		close(O);
	}
}
close(I);