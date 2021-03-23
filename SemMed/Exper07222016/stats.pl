use strict;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test07222016\\brat";
my @F;

opendir(D,"$data_d")||die;
my @File = grep /\.ann/,readdir D;
closedir(D);
@File = sort @File;

undef my %H;
foreach my $f (@File) {
	open(I,"$data_d\\$f")||die;
	#print "$f\n";
	while(<I>) {
		chomp;
		@F = split(/\s/,$_);
		
		if (defined $F[1]) {
			$F[1]=~s /\:.*$//;
			$H{$F[1]}{$f}++;
		}
	}
	if ((defined $H{"Drug"}{$f})&&(defined $H{"Condition"}{$f})) {
		$H{"DrugCondition"}{$f}++;
	}
	close(I);
}
$_ = $#File + 1;
print "Files: $_\n\n";
foreach (sort keys %H) {
	@F = keys %{$H{$_}};
	my $t = $#F+1;
	print "$_\: $t\n";
}