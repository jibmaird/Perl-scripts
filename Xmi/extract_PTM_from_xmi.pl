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

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171031\\cas_6k_PTM";
my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171031\\PTM_rels_20171019.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010b\\cas_6k_PTM";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010b\\PTM_rels_20171114.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\cas_sample6k_NonPTM";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\NonPTM_rels_20171113.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171110\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\DTC_rels_20171110.csv";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\cas_6k_DTC";
#my $o_file = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171109\\DTC_rels_20171113b.csv";

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
	while(s/(Ptm.*?\>)//) {
		#print O "$f\: $1\n";
	
		my $aux = $1;
		my $aux2 = "";
		if ($aux =~/targets=\"(.*?)\"/) {
			$aux2 = $1;
		}
		my $t = 0;
		if ($aux2 ne "") {
			my @F = split(/\s/,$aux2);
			$t = $#F + 1;
		}
		$aux2 = "";
		if ($aux =~/residues=\"(.*?)\"/) {
			$aux2 = $1;}
		
		my $r = "";
		if ($1 ne "") {
			my @F = split(/\s/,$aux2);
			$r = $#F + 1;
		}
		$aux =~/canonicalName=\"(.*?)\"/;
		print O "$f\t$1\tTarg:$t\tRes:$r\n";
	}
 } 
 close(I);
}