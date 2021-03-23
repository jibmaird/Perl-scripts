use warnings;
use strict;

#my $ifile = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170425b\\NonEntityNetworks.ThemeInEntity.csv";
my $ifile = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170425b\\NonEntityNetworks.ThemeOvEntity.csv";

open(I,"C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170425b\\ActionAPI.Roles.csv")||die;
#"Input Document","aid (TEXT)","verbBase (TEXT)","name (TEXT)","determiner (SPAN)","value (SPAN)","head (SPAN)","headNorm (TEXT)"

<I>;
undef my %R;
while(<I>) {
	chomp;
	s /^\"//;
	s /\"$//;
	my @F = split(/\"\,\"/,$_);
	$R{$F[0]}{$F[1]}{$F[3]} = $F[5];
}
close(I);
#print "$R{100057}{823}{'agent'}\n";

open(I,"C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170425b\\ActionAPI.Actions.truncated.csv")||die;
#"Input Document","aid (TEXT)","verbBase (TEXT)","name (TEXT)","determiner (SPAN)","value (SPAN)","head (SPAN)","headNorm (TEXT)"

<I>;
undef my %A;
while(<I>) {
	chomp;
	s /^\"//;
	s /\"$//;
	my @F = split(/\"\,\"/,$_);
	$A{$F[0]}{$F[2]} = $F[4];
}
close(I);
#print "$R{100057}{823}{'agent'}\n";

open(I,$ifile)||die;
while(<I>) {
	chomp;
	s /^\"//;
	s /\"$//;
#	print "$_\n";
	my @F = split(/\"\,\"/,$_);
	if ((defined $R{$F[0]}{$F[2]}{'agent'})&&
	(defined $R{$F[0]}{$F[2]}{'theme'})&&
	($F[4] ne "be")&&
	($F[4] ne "have")) {
		print "$R{$F[0]}{$F[2]}{'agent'} - $F[4] - $R{$F[0]}{$F[2]}{'theme'}\n";
		if (defined $A{$F[0]}{$F[2]}) {
			print "\tS: $A{$F[0]}{$F[2]}\n";
		}
		print "\tA: $R{$F[0]}{$F[2]}{'agent'}\n";
		print "\tT: $R{$F[0]}{$F[2]}{'theme'}\n";
		print "\tTE: $F[5]\n";
	}
}
close(I);


