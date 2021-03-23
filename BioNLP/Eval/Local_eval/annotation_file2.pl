# use output from /wdd-annotator-biorels/src/main/java/com/ibm/wdd/annotator/ReadCas.java

use strict;

use warnings;

my %R = (
	"RegulationPositive"=>"Positive_regulation",
	"RegulationNegative"=>"Negative_regulation")
	;

#open(I,"C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\ann_sentences.txt")||die;
#open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\ann_sentences0.csv")||die;
open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\genia_ann_sentences.txt")||die;
my $id;my $r;undef my %H;my $b;my $e;
while(<I>) {
	chomp;
	if (/^.*\\(.*?)\.txt\.xmi$/) {
		$id = $1;
		$_ = <I>;
		chomp;
		$r = $_;
	}
	elsif (/^S:(.*?)\;E:(.*?)$/) {
		$b = $1;
		$e = $2;
	}
	elsif (s/^text\: //) {
		$H{$id}{$r}{"$b $e"} = 1;	
	}
}
close(I);

foreach $id (keys %H) {
	open(O,">C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\training_genia_brat\\$id\.a2")||die;
	my $t = 1;
	foreach $r (keys %{$H{$id}}) {
		next if $r eq "Prepositional";
		next if not defined $R{$r};
		foreach (keys %{$H{$id}{$r}}) {
			$r = $R{$r} if defined $R{$r};
			print O "T$t\t$r $_\n";
			print O "E$t\t$r:T$t \n";
		}
		$t++;
	}
	close(O);
}