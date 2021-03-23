# use output from /wdd-annotator-biorels/src/main/java/com/ibm/wdd/annotator/ReadCas.java

use strict;

use warnings;

open(I,"C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T258857\\ann_sentences.txt")||die;
open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T258857\\ann_sentences0.csv")||die;
#open(I,"C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\ann_sentences.txt")||die;
#open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\ann_sentences0.csv")||die;
#open(I,"C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\recall_files\\ann_sentences.txt")||die;
#open(O,">C:\\Users\\IBM_ADMIN\\Data\\Annotator_runs\\Chem_rels\\T255958\\recall_files\\ann_sentences0.csv")||die;
my $id;my $r;my $arg="";undef my %T;undef my %A;
while(<I>) {
	chomp;
	if (/\\([\-\d]+)\.txt$/) {
		$id = $1;
		$_ = <I>;
		chomp;
		$r = $_;
	}
	elsif (s/^text\: //) {
#		if ($r eq "RegulationNegative") {
			foreach my $a1 (keys %A) {
				foreach my $t1 (keys %T) {
					print O "\t$id\t$a1\t$r\t$t1\t$_\n";
				}
			}
#		}
		undef %A;
		undef %T;
		$arg = "";
	}
	elsif (/^Agent\: /) {
		$arg = "A";
	}
	elsif (/^Target\: /) {
		$arg = "T";
	}
	elsif (/^\s*textToNormalize: \"(.*?)\"/) {
		if ($arg eq "A") {
			$A{$1} = 1;
		}
		else {
			$T{$1} = 1;
		}
	}
}
close(I);
close(O);