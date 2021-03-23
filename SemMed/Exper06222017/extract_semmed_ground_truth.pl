use strict;
use warnings;

my (@F,%H,$pmid,$obj,$obj_t,$subj,$subj_t,$rel,$rel_t,$pred,%T);

#my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\linezolid_sent.csv";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016\\linezolid_gt";

my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017\\stimulates_sentences_filt.csv";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017\\GT";

if (not -e $out_d) {
	system("md $out_d");
}

undef %H;
undef %T;
open(I,"$in_f")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	foreach (@F) {
		s /^.*?\://;
	}
	@F = &fix_offset(@F);
	next if $#F == -1;
	
	$pmid = "$F[16]\-$F[19]\-$F[15]\-$F[13]";
	$rel = "$F[9] $F[8]";
	$rel_t = $F[12];
	$pred = substr $F[17],$F[9],$F[8]-$F[9];
	
	$obj = "$F[6] $F[3]";
	$obj_t = $F[7];
	$subj = "$F[24] $F[21]";
	$subj_t = $F[25];
	$H{$pmid}{$rel}{o} = $obj;
	$H{$pmid}{$rel}{ot} = $obj_t;
	$H{$pmid}{$rel}{s} = $subj;
	$H{$pmid}{$rel}{st} = $subj_t;
	$H{$pmid}{$rel}{rt} = $rel_t;
	$H{$pmid}{$rel}{pred} = $pred;
	$T{$pmid} = $F[17];
}
close(I);

foreach $pmid (sort keys %H) {
	
	open(O,">$out_d\\$pmid.txt")||die;
	print O "$T{$pmid}\n";
	close(O);
	
	open(O,">$out_d\\$pmid.ann")||die;
	
	my $e = 1;
	my $t = 1;
	foreach $rel (sort keys %{$H{$pmid}}) {
		$subj = $H{$pmid}{$rel}{s};
		$obj = $H{$pmid}{$rel}{o};
		$subj_t = $H{$pmid}{$rel}{st};
		$obj_t = $H{$pmid}{$rel}{ot};
		$rel_t = $H{$pmid}{$rel}{rt};
		$pred = $H{$pmid}{$rel}{pred};
		
		print O "T$t\tEntity $subj\t$subj_t\n";
		my $t_target = $t;
		$t++;
		print O "T$t\tEntity $obj\t$obj_t\n";
		my $t_agent = $t;
		$t++;
		print O "T$t\t$rel_t $rel\t$pred\n";
		print O "E$e\t$rel_t:T$t Target1:T$t_target Agent1:T$t_agent\n";
		$t++;
		$e++;
		
	}
	close(O);
}

sub fix_offset {
	my @F = @_;
	
	my ($pmid,$obj,$obj_t,$subj,$subj_t,$rel,$rel_t,$pred,$subj_l,$offset,$offset0,$obj_l,$rel_l);
	
	$pmid = $F[16];
	$rel = "$F[9] $F[8]";
	$rel_t = $F[12];
	$rel_l = $F[8] - $F[9];
	
	
	$obj = "$F[6] $F[3]";
	$obj_t = $F[7];
	$obj_l = length($obj_t);
	$subj = "$F[24] $F[21]";
	$subj_t = $F[25];
	$subj_l = length($subj_t);
	
	if (($subj_t =~ /[\)\(]/)||($obj_t =~/[\)\(]/)) {
		undef @F;
		return @F;
	}
	
	$F[17] =~ /^(.*?)$obj_t/;
	$offset = length($1);
	if (not defined $offset) {
		undef @F;
		return @F;
	}
	$offset0 = $F[6] - $offset;
	
	$F[17] =~ /^(.*?)$subj_t/;
	$offset = length($1);
	$_ = $F[24] - $offset;
	if ($_ != $offset0) {
		#print "Mismatch: $_ $offset0 $subj_t $obj_t\n";
		undef @F;
		return @F;
	}
	else {
		my $aux = substr $F[17],$F[9]-$offset0,$rel_l;
		my @Aux = ("3","6","21","24","9","8");
		foreach (@Aux) {
			$F[$_] = $F[$_]-$offset0;
		}
		return @F;
	}		
}