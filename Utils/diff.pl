use Text::Diff;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test10132016";
#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Rel_tests\\Ptm\\test12132016";
#my $f1 = "$data_d\\PTM.Consolidated.csv";
my $f1 = "$data_d\\PTM.Consolidated_Minus_AllConflicts.csv";
#my $f2 = "$data_d\\PTM.Consolidated.threshold40.csv";
#my $f2 = "$data_d\\PTM.Consolidated_Minus_AllConflicts.threshold40.csv";
#my $f2 = "$data_d\\PTM.Consolidated.newrule.csv";
my $f2 = "$data_d\\PTM.Consolidated_Minus_AllConflicts.newrule.csv";

my $diff = diff $f1, $f2, { STYLE => "OldStyle" };
my @F = split(/\n/,$diff);
foreach (@F) {
	if (s/^\> //) {
		print "NEW RULE: $_\n";
	}
	elsif (s/^\< //) {
		print "PREVIOUS: $_\n";
	}
}
