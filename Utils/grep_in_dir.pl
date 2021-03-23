use strict;
use warnings;

my (@File,$f,%H,$table);

my $data_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdd-annotator-unconstrained\\textAnalytics\\DomainKnowledge";

opendir(D,$data_d)||die;
@File = grep /\.aql/,readdir D;
closedir(D);

undef %H;
foreach $f (@File) {
	open(I,"$data_d\\$f")||die;
	while(<I>) {
		chomp;
		if (/create table (.*?) \(/) {
			$table = $1;
		}
		elsif (/^\s*\(.*?\,.*?\)\,?\s*$/) {
			$H{$table}{$_} = 1;
		}
	}
	close(I);
}
foreach $table (sort keys %H) {
	print "$table\n";
	foreach (sort keys %{$H{$table}}) {
		print "\t$_\n";
	}
}
