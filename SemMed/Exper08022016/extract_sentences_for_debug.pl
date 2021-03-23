use strict;
use warnings;

my ($f,@File);

if (not defined $ARGV[0]) {
	die "Usage: extract_sentences_for_debug.pl dataset\n";
}

#my $dataset = "treats";
#my $dataset = "linezolid";
my $dataset = $ARGV[0];

my $data_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdals-annotator-biorels\\data\\SemMed\\$dataset\_sample";


opendir(D,"$data_d\\DC\_$dataset\_gt")||die;
@File = grep /\.txt/,readdir D;
closedir(D);

open(O,">C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\$dataset\_sentences.del")||die;
foreach $f (@File) {
	open(I,"$data_d\\DC\_$dataset\_gt\\$f")||die;
	my $txt = "";
	while(<I>) {
		chomp;
		s /\"//g;
		$txt = $txt . $_;
	}
	close(I);
	$f =~ /^.*\-(\d+)\.txt/;
	print O "1,$1,\"$txt\"\n";
}
close(O);