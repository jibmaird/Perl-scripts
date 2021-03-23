#Read gold
my (%G,@F,%A);

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016";

undef %G;
my $gold_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016\\gold.csv";
open(I,"$data_d\\gold.csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	$G{$F[0]} = 1;
}
close(I);

#Read answers

undef %A;
#open(I,"$data_d\\Dtc.csv")||die;
#open(I,"$data_d\\NonPtm.csv")||die;
open(I,"$data_d\\$ARGV[0].csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	$A{$F[0]} = 1;
}
close(I);

print "Type: $ARGV[0]\n";

my $tp = 0;
my $fp = 0;
my $tn = 0;
my $fn = 0;

foreach (keys %A) {
	if (defined $G{$_}) {
		$tp++;
	}
	else {
		$fp++;
	}
}
my $tot_g = 0;
foreach (keys %G) {
	if (not defined $A{$_}) {
		$fn++;
	}
	$tot_g++;
}
print "Total gold sentences (they contain some relation): $tot_g\n";

my $p = $tp / ($tp + $fp);
my $r = $tp / ($tp + $fn);

print "Precision:$p\n";
print "Recall:$r\n";