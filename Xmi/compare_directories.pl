use strict;
use warnings;

my $d1 = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171010\\cas_6k_DTC";
my $d2 = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20171110\\cas_6k_DTC";

opendir(D,"$d1")||die;
my @File = grep /\.txt/,readdir D;
closedir(D);

foreach my $f (@File) {
	open(I,"$d1\\$f")||die;
	undef my @F1;
	while(<I>) {
		while(s /begin=\"(.*?)\" end=\"(.*?)\"//) {
			push @F1,"$1\-$2";
		}
	}
	close(I);
	
	undef my @F2;
	open(I,"$d2\\$f")||die;
	while(<I>) {
		while(s /begin=\"(.*?)\" end=\"(.*?)\"//) {
			push @F2,"$1\-$2";
		}
	}
	close(I);
	my $f1 = join " ",sort @F1;
	my $f2 = join " ",sort @F2;
	
	if ($f1 ne $f2) {
		print "$f\n";
#		print "\t$f1\n";
#		print "\t$f2\n";
	}
	else {
#		print "OK\n";
	}
}