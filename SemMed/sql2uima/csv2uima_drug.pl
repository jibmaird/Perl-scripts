use warnings;
use strict;

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Samples";

open(I,"$data_d\\treats_sentences_DC.csv")||die;
undef my @F;
my $i = 1;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	foreach (@F) {
		s /^.*\://;
	}
	@F = &fix_offset(@F);
	if ($#F == -1) {
		next;
	}
	
	my $o_e = $F[3];
	my $o_s = $F[6];
	my $o_t = $F[7];
	my $p_e = $F[8];
	my $p_s = $F[9];
	
	my $sent_t = $F[17];
	my $sent_s = 0;
	my $sent_e = length($sent_t) - 1;	
	my $s_e = $F[21];
	my $s_s = $F[24];
	my $s_t = $F[25];
	
	next if $p_s >= $p_e;
	next if $sent_t =~ /\</;
	
	if ($p_s < $s_e) {
		$p_s = $s_e + 1;
	}
	
	
	my $p_t = substr $sent_t,$p_s,$p_e-$p_s;
	
	
	#DEBUG
	#print "$s_t#$p_t#$p_s-$p_e#$o_t\n";
	
	open(O,">$data_d\\txt\\$i.txt")||die;
	print O "$sent_t\n";
	close(O);
	
	open(O,">$data_d\\cas_gt\\$i.xmi")||die;
	print O "<?xml version=\"1.0\" encoding=\"UTF-8\"?><xmi:XMI xmlns:cas=\"http:///uima/cas.ecore\" xmlns:xmi=\"http://www.omg.org/XMI\" xmlns:actionapi=\"http:///com/ibm/wda/ls/actionapi.ecore\" xmlns:ls=\"http:///com/ibm/wda/ls.ecore\" xmlns:tcas=\"http:///uima/tcas.ecore\" xmi:version=\"2.0\">
<cas:NULL xmi:id=\"0\"/>";
	print O "<cas:Sofa xmi:id=\"1\" sofaNum=\"1\" sofaID=\"_InitialView\" mimeType=\"text\" sofaString=\"$sent_t\"/>";
	print O "<tcas:DocumentAnnotation xmi:id=\"2\" sofa=\"1\" begin=\"$sent_s\" end=\"$sent_e\" language=\"en\"/>";
	print O "<ls:DocumentMetadata xmi:id=\"3\" documentId=\"$i.txt\" source=\"$data_d\\txt\\$i.txt\" offset=\"0\" field=\"text\"/>";
	
	print O "<ls:Drug xmi:id=\"4\" sofa=\"1\" begin=\"$s_s\" end=\"$s_e\" multiCanonical=\"false\" context=\"7\" textToNormalize=\"$s_t\" componentId=\"wdd/drug\" mentionType=\"general dictionary drug unmodified\" normalized=\"false\" exemplary=\"false\" normalizedAsChemical=\"false\"/>";
	
	
	print O "<ls:Context xmi:id=\"7\" sofa=\"1\" begin=\"$s_s\" end=\"$s_e\"/>";
	
	print O "<cas:View sofa=\"1\" members=\"2 3 4\"/></xmi:XMI>";

	close(O);
	$i++;
}
close(I);

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