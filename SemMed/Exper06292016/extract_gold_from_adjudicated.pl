open(I,"C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\adjudicated.xml")||die;
my $out_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016\\gold.csv";
my($pmid,$num,$sec,$offset,$text,$sent,%A);
my $type = "";
open(O,">$out_f")||die;
while(<I>) {
	chomp;
	if (/<MedlineCitation pmid=\"(.*?)\">/) {
		my $aux = $1;
		if ($type ne "") {
			if (!$text =~/^\s*$/) {
				$_ = join "\-",sort keys %A;
				s / /\_/g;
				print O "$pmid\t$num\t$sec\t$offset\t$text\t$type\t$_\t$sent\n";
			}
		}
		$pmid = $aux;
		$num = "";$sec="";$type="";$offset="";$text="";$sent="";undef %A;
	}
	elsif (/<Sentence section=\"(.*?)\" number=\"(.*?)\" text=\"(.*?)\"\>/) {
		$sent = $3;
		$num = $2;
		$sec = $1;
	}
	elsif (/<Predicate type=\"(.*?)\".*?charOffset=\"(\d+)\".*? text=\"(.*?)\"/) {
		$type = $1;
		$offset = $2;
		$text = $3;
	}
	elsif (/<RelationSemanticType>(.*?)\</) {
		$A{$1}=1;
	}
}
close(I);
close(O);