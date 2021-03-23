use strict;
use warnings;

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907";
#my $orig_f = "$data_d\\nostopw\\nostopw.txt";
#my $new_f = "$data_d\\stopw100\\stopw100.txt";

if (not defined $ARGV[2]) {
	die "Usage: ./removed_rels.pl data_d orig_f new_f\n";
}

my $data_d = $ARGV[0];
my $orig_f = $ARGV[1];
my $new_f = $ARGV[2];

undef my %H;
open(I,"$new_f")||die;
my $tot = 0;
while(<I>) {
	chomp;
	s /^(\d+) //;
	$H{$_} = $1;
}
close(I);

open(I,"$orig_f")||die;
open(O,">$data_d\\removed_rel.txt")||die;
open(O2,">$data_d\\kept_rel.txt")||die;
my $kept = 0;
my $remove = 0;
while(<I>) {
	chomp;
	s /^(\d+) //;
	my $aux = $1;
	if (not defined $H{$_}) {
		print O "$_\n";
		$remove += $aux;
	}
	else {
		print O2 "$_\n";
		$kept += $aux;
	}
}
close(I);
close(O);
close(O2);

$_ = $kept+$remove;
print "Total: $_\n";
$_ = $remove / ($kept + $remove);
print "Keep: $kept\n";
print "Remove: $remove \($_\)\n";

