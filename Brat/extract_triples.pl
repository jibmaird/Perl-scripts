use strict;
use warnings;

my (@File,$f);

#if (not defined $ARGV[1]) {
#	die "Usage: ./extract_triples.pl data_d out_f\n";
#}

#my $stop = "stopw100";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907\\$stop";
#my $data_d = $ARGV[0];
#my $out_f = "$data_d\\$ARGV[1].txt";

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\sample_6k";
#my $data_d =  "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170320";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\sample_6k";
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170508";


my $out_f = "$data_d\\triples_b.txt";

opendir(D,"$data_d\\brat")||die;
@File = grep /\.ann/,readdir D;
closedir(D);

undef my %R;
undef my %T;
open(O,">$out_f")||die;
my $i = 0;
foreach $f (@File) {
	open(I,"$data_d\\brat\\$f")||die;
	undef %T;
	while(<I>) {
		chomp;
		if (/^T(.*?)\t.*?\t(.*)$/) {
			$T{$1} = $2;
		}
		elsif (/^E.*?\t.*?\:T(\d+) .*?\:T(\d+) .*?\:T(\d+)$/) {
			#DEBUG
			#if (not defined $T{$3}) {
			#	print;
			#}
			print O "$f:$T{$1}\-$T{$2}\-$T{$3}\n";
			$R{"$T{$1}\-$T{$2}\-$T{$3}"}++;
			$i++;
		}
	}
	close(I);
}
$_ = $#File + 1;
print "TOTAL FILES: $_\n";

foreach (sort {$R{$b}<=>$R{$a}} keys %R) {
	print "$R{$_} $_\n";
}
print "TOTAL RELS:$i\n";
close(O);