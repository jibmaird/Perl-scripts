use strict;
use warnings;

my (@File,$f);

if (not defined $ARGV[0]) {
	die "Usage: perl extract_gt_files.pl dataset\n";
}

my $dataset = $ARGV[0];
my $gt_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdals-annotator-biorels\\data\\SemMed\\$dataset\_sample\\DC\_$dataset\_gt";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test09162016\\$dataset\_gt";
my $pred_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test09162016\\$dataset\_brat";

if (not -e $out_d) {
	system("md $out_d");
}

opendir(D,"$gt_d")||die;
@File = grep /\d/,readdir D;
closedir(D);

foreach $f (@File) {
	$_ = $f;
	s /^.*\-(.*?)$/$1/;
	system("copy $gt_d\\$f $out_d\\$_");
	if (/\.txt/) {
		system("copy $gt_d\\$f $pred_d\\$_");
	}
}