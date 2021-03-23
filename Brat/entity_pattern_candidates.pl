use strict;

use warnings;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T218924\\sample_6k\\brat";

opendir(D,"$data_d")||die;
my @File = grep /\.ann/,readdir D;
closedir(D);


undef my %P;
foreach my $f (@File) {
	undef my %E;
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		if (/^T/) {
			my @F = split(/\t/,$_);
			next if not defined $F[1];
			if ($F[1] =~s /com.ibm.wdd.(.*?) \d+ \d+/$1/) {
				$E{$F[2]} = uc($F[1]);
			}
		}
	}
	close(I);
	$f =~s /\.ann/.txt/;
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		my @F = split(/\./,$_);
		foreach my $sent (@F) {
			foreach my $e1 (sort keys %E) {
				foreach my $e2 (sort keys %E) {
					if ($sent =~ /\Q$e1\E(.*?)\Q$e2\E/) {
						$P{"$E{$e1}$1$E{$e2}"}{'sent'}{$sent} = 1;
						$P{"$E{$e1}$1$E{$e2}"}{'tot'}++;
					}
				}
			}
		}
		
	}
	close(I);
}
foreach my $p (sort {$P{$b}{'tot'}<=>$P{$a}{'tot'}} keys %P) {
	print "$p ($P{$p}{'tot'})\n";
	foreach (sort keys %{$P{$p}{'sent'}}) {
		print "\,\"$_\"\n";
	}
}