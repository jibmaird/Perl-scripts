use strict;
use warnings;

my (@File,$f,@F,%H);
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907\\brat";
opendir(D,"$data_d")||die;
@File = grep /\.ann$/,readdir D;
closedir(D);

#Read target list
undef my %T;

my $i = 0;
open(I,"C:\\Users\\IBM_ADMIN\\Data\\Medline\\CDM\\tfidf.txt")||die;
while(<I>) {
	chomp;
	/^(.*?) (.*)$/;
	$T{$1} = 1;
	$i++;
	last if $i == 1000;
}
close(I);

undef %H;
foreach $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		if (/^[ER]\d+/) {
			@F = split(/\t/,$_);
			my @G = split(/ /,$F[1]);
			undef my @Found;
			foreach (@G) {
				/^(.*?)\:(.*)$/;
				my $type = $1;
				my $term = $2;
				if (($type =~/^Agent/)||($type=~/^Target/)) {
					if (defined $T{$H{$term}}) {
						push @Found,$H{$term};
					}
				}
			}
			if ($#F > -1) {
				$_ = join "\t",@Found;
				print "$f\t$_\n";
			}
		}
		elsif (/^T\d+/) {
			@F = split(/\t/,$_);
			$F[1] =~ /^.*? (\d+) (\d+)$/;
			$H{$F[0]} = $F[2];
		}
		
	}
	close(I);
}