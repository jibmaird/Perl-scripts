use strict;
use warnings;

my (@File,$f);

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\ftmj-combined-150-000001";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\patents";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\ftmj_sample";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\20160714";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\ftmj_sample07152016";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion runs\\ftmj_nonptm";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160721b";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160726";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160801";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160817";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test10252016";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20161109\\20161031-1400";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20161216";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\DTCtests\\2017\\test01042017";

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\medline_sample3";

opendir(D,"$data_d\\xmi_orig")||die;
@File = grep /xmi/,readdir D;
closedir(D);

$_ = $#File + 1;
print "Total files: $_\n";
foreach $f (@File) {
	open(I,"$data_d\\xmi_orig\\$f")||die;
	$f =~s /\.xmi/\.txt/;
	open(O,">$data_d\\txt\\$f")||die;
	while(<I>) {
		chomp;
		if (/sofaString=\"(.*?)\"/) {
			print O "$1\n";
		}
		elsif (/content=\"(.*?)\"/) {
			print O "$1\n";
		}
	}
	close(I);
	close(O);
}