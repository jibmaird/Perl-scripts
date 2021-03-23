#Read gold
my (%G,@F,%A,$t,%R);

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016";

undef %G;
my $gold_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016\\gold.csv";
open(I,"$data_d\\gold.csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	if ($ARGV[1] eq "RelArgs") {
	#Rel and arg
	$G{"$F[5]\-$F[6]"}{$F[0]} = 1;
	}
	elsif ($ARGV[1] eq "RelOnly") {
		#Just Rel
		$G{"$F[5]"}{$F[0]} = 1;
	}
	else {
		die "Usage: eval_doc_by_type.pl answer_f [RelArgs|RelOnly]\n";
	}
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

print "Type: $ARGV[0] $ARGV[1]\n";

undef %R;
foreach $t (keys %G) {
	my $tp = 0;
	my $fp = 0;
	my $tn = 0;
	my $fn = 0;

	foreach (keys %A) {
		if (defined $G{$t}{$_}) {
			$tp++;
		}
		else {
			$fp++;
		}
	}
	my $tot_g = 0;
	foreach (keys %{$G{$t}}) {
		if (not defined $A{$_}) {
			$fn++;
		}
		$tot_g++;
	}

	my $p = $tp / ($tp + $fp);
	my $r = $tp / ($tp + $fn);

	$R{$t}{p} = $p;
	$R{$t}{r} = $r;
	$R{$t}{t} = $tot_g;
}

for (sort {$R{$b}{'t'}<=>$R{$a}{'t'}} keys %R) {
	
	print "\tTotal gold sentences ($_): $R{$_}{t}";
	#print "\tPrecision:$R{$_}{'p'}\n";
	print "\tRecall:$R{$_}{'r'}\n";
}