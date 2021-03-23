use strict;

use vars qw (@F @File $f);

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test07292016\\out";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160726\\xmi_orig";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test12142016\\cas_06072016";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\test06072016\\out";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170906\\cas_sample6k_NonPTM";
#my $o_file = "$data_d\\..\\nonptm_rels.txt";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170808\\sample6k_cas";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170928\\DTC_rels_20170808.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170829\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170829\\DTC_rels_20171006.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010\\DTC_rels_20171019.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171031\\cas_6k_PTM";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171031\\PTM_rels_20171019.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010b\\cas_6k_PTM";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010b\\PTM_rels_20171114.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\cas_sample6k_NonPTM";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\NonPTM_rels_20171113.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171110\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\DTC_rels_20171110.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\DTC_rels_20171113b.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180131\\cas_6k_DTC_02092018";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180131\\DTC_rels_20180131c.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180307\\cas_6k";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180307\\DTC_rels_20180307.csv";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180307\\cas_6k";
my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\2018\\20180307\\DTC_rels_20180307c.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\cas_6k_Unconstrained";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\Unconstrained_rels_20171115.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\cas_6k_Unconstrained2";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\Unconstrained_rels_20171115b.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\cas_6k_Unconstrained3";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171115\\Unconstrained_rels_20171115c.csv";

my $tot_c = 0;

open(O,">$o_file")||die;

opendir(D,"$data_d")||die;
@File = grep /^\d/,readdir D;
closedir(D);
#DEBUG
#@File = ("25033.txt.xmi");

foreach $f (@File) {
	&read_xmi("$data_d\\$f");
}
close(O);

sub read_xmi {
	
 my (%H,$cn,$ag,$th,$aux,$id,@F);

 my $text = "";
 my $in_f = $_[0];

 undef %H;
 open(I,"$in_f")||die;
 while(<I>) {
	while(s/(type:Dtc .*?\>)//) {
		#print O "$f\: $1\n";
		my $aux = $1;
		$aux =~/canonicalName=\"(.*?)\"/;
		print O "$f\t$1\n";# if $1 ne "Prepositional";
		print "$aux\n\t$1\n";
	}
 } 
 close(I);
}