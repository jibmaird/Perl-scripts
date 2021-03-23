use strict;
use warnings;

my (@File,$f,%H,$table);

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test12272016\\cas";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample\\cas";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\sample_6k\\cas03292017";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170320\\cas_6ksample_PTM";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170508\\6k_sample_cas_05172017";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\bionlp06162017\\cas";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\NonPtm\\bionlp06162017\\cas";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017\\cas";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\training_genia_cas";

opendir(D,$data_d)||die;
@File = grep /\.txt/,readdir D;
closedir(D);

undef %H;
foreach $f (@File) {
	$_ = $f . ".xmi";
	
	system("move $data_d\\$f $data_d\\$_");
}