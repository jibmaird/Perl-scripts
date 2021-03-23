use strict;
use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Samples";
my $in_f = "$data_d\\treats_sentences_DC.csv";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\WKS_Exper\\treats_DTC";

system("perl csv2uima_DTC.pl $in_f $out_d");
