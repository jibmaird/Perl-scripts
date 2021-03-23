use strict;
use warnings;

if (not defined $ARGV[0]) {
	die "Usage: perl extract_answers_into_brat.pl dataset\n";
}
my $dataset = $ARGV[0];

my (@File,$f,@F,%H,$i);

my $in_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Biorels_runs\\$dataset\_sample\\09162016";

my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test09162016\\$dataset\_brat";

if (not -e $out_d) {
	system("md $out_d");
}

opendir(D,"$in_d")||die;
@File = grep /\.csv/,readdir D;
closedir(D);

undef %H;
foreach $f (@File) {
	open(I,"$in_d\\$f")||die;
	$_ = <I>;
	while(<I>) {
		chomp;
		@F = split(/\"\,\"/,$_);
		$F[0] =~s /\"//g;
		$H{$F[0]}{$_} = 1;
	}
	close(I);
}

foreach $f (keys %H) {
	undef my %T;
	my $t = 1;
	my $e = 1;
	open(O,">$out_d\\$f\.ann")||die;
	foreach (keys %{$H{$f}}) {
		@F = split(/\"\,\"/,$_);
		for($i=1;$i<=3;$i++) {
			if (not defined $T{$F[$i]}) {
				$T{$F[$i]} = $t;
				$_ = $F[$i];
				s /\[(\d+) \- (\d+)\]$//;
				print O "T$t\tEntity $1 $2\t$_\n";
				$t++;
			}
		}
		
		print O "E$e\tDTC:T$T{$F[2]} Agent1:T$T{$F[1]} Target1:T$T{$F[3]}\n";
		
		$e++;
		
	}
	close(O);
}