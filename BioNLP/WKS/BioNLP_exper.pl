use strict;

use warnings;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\BioNLP-ST_2011_Epi_and_PTM_training_data_rev1";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\uima\\BioNLP_train";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\BioNLP-ST_2011_Epi_and_PTM_development_data_rev1";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\uima\\BioNLP_test";

system("perl brat2uima.pl $data_d $out_d");
