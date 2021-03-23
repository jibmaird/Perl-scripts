use strict;
use warnings;

my @R = ("Dtc","Ptm","NonPtm","Unconstrained");
#DEBUG
#my @R = ("Unconstrained");

foreach my $r (@R) {
	undef my %H;
	my $tot = 0;
	$_ = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\$r" . "Runner.log";
	open(I,"$_")||die;
	my $rel = 0;
	while(<I>) {
		chomp;
		
		if (s/^.*\[main\]: class com.ibm.wda.ls.$r in .*?: (.*)$/$1/) {
			$rel = $_;
			$tot++;
		}
		elsif (s /^displayName: (.*)$/$1/) {
			if ($rel > 0) {
				$H{$1}++;
				#$rel = 0;
			}		
		}
	}
	close(I);
	print "* $r ($tot)\n";
	foreach (sort {$H{$b}<=>$H{$a}} keys %H) {
		print "\t$_\: $H{$_}";
		my $rec = $H{$_} * 100 / $tot;
		printf(" \(%.2f", $rec);
		print "%\)\n";
	}
}

