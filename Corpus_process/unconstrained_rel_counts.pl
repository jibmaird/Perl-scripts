use strict;
use warnings;

my @S = ("nostopw","stopw100");
foreach my $stop (@S) {
	my @D = ("20160907\\$stop\\sample6k","ftmj-combined-150-000001\\test10032016");
	foreach my $d (@D) {
		my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\$d\\$stop";
#		system("perl ..\\Brat\\extract_triples.pl $data_d $stop\n");
	}
}



my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907";
my $orig_f = "$data_d\\nostopw\\sample6k\\nostopw.txt";
my $new_f = "$data_d\\stopw100\\sample6k\\stopw100.txt";
system("perl removed_rels.pl $data_d $orig_f $new_f");

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\ftmj-combined-150-000001\\test10032016";
#my $orig_f = "$data_d\\nostopw\\nostopw.txt";
#my $new_f = "$data_d\\stopw100\\stopw100.txt";
#system("perl removed_rels.pl $data_d $orig_f $new_f");