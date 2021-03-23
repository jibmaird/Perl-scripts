use File::Copy qw(copy);

use strict;

use warnings;

if (not defined $ARGV[1]) {
	die "Usage: perl brat2uima.pl in_dir out_dir\n";
}

#my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\BioNLP-ST_2011_Epi_and_PTM_training_data_rev1";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\bioNLP\\uima";

my $data_d = $ARGV[0];
my $out_d = $ARGV[1];

if (not -e "$out_d") {
	system("md $out_d");
}
if (not -e "$out_d\\txt") {
	system("md $out_d\\txt");
}
if (not -e "$out_d\\cas") {
	system("md $out_d\\cas");
}


opendir(D,"$data_d")||die;
my @File = grep /\.txt$/,readdir D;
close(D);

#DEBUG
#@File = ("PMID-113854.txt");

foreach my $f (@File) {
	undef my %H;
	for(my $i=1;$i<=2;$i++) {
		$_ = $f;
		s /\.txt//;
		open(I,"$data_d\\$_\.a$i")||die;
		while(<I>) {
			chomp;
			next if not /^T\d+\t/;
			my @F = split(/\t/,$_);
			my @G = split(/ /,$F[1]);
			if ($G[0] eq "Protein") {
				$H{$F[0]}{type} = "Gene";
			}
			else {
				$H{$F[0]}{type} = "PTM";
			}
			
			$H{$F[0]}{b} = $G[1];
			$H{$F[0]}{e} = $G[2];
			$H{$F[0]}{str} = $F[2];
		}
		close(I);
	}
	open(I,"$data_d\\$f")||die;
	open(O,">$out_d\\txt\\$f")||die;
	
	my $sent = "";
	while(<I>) {
		s /[\"\>\<\&]/ /g;
		print O;
		$sent .= $_;
		#DEBUG
		if (/\>/) {
			print "METACHARACTER: $_\n";
		}
	}
	close(I);
	close(O);
	&print_uima($f,\%H,$sent,$out_d);
}

sub print_uima {
		
	my $id = $_[0];
	$id =~s /\.*$//;
	my $H = $_[1];
	my $sent_t = $_[2];
	my $out_d = $_[3];
	
	my $text_file = "$out_d\\txt\\$id.txt";
	my $xmi_file = "$out_d\\cas\\$id.xmi";

	#sentence text and boundaries
	#my $sent_t = "aspirin treats headache";
	my $sent_s = "0";
	my $sent_e = length($sent_t) - 1;
	
	#print xmi file
	open(O,">$xmi_file")||die "$xmi_file";
	print O "<?xml version=\"1.0\" encoding=\"UTF-8\"?><xmi:XMI xmlns:cas=\"http:///uima/cas.ecore\" xmlns:xmi=\"http://www.omg.org/XMI\" xmlns:actionapi=\"http:///com/ibm/wda/ls/actionapi.ecore\" xmlns:ls=\"http:///com/ibm/wda/ls.ecore\" xmlns:tcas=\"http:///uima/tcas.ecore\" xmi:version=\"2.0\">
<cas:NULL xmi:id=\"0\"/>";
	print O "<cas:Sofa xmi:id=\"1\" sofaNum=\"1\" sofaID=\"_InitialView\" mimeType=\"text\" sofaString=\"$sent_t\"/>";
	print O "<tcas:DocumentAnnotation xmi:id=\"2\" sofa=\"1\" begin=\"$sent_s\" end=\"$sent_e\" language=\"en\"/>";	
	print O "<ls:DocumentMetadata xmi:id=\"3\" documentId=\"$id\" source=\"$text_file\" offset=\"0\" field=\"text\"/>";
	
	my $i = 3;
	undef my %Sent;
	foreach my $e (keys %{$H}) {
		$i++;
		my $j = $i+1; 
		if ($H->{$e}{type} eq "Gene") {
			print O "<ls:Gene xmi:id=\"$i\" sofa=\"1\" begin=\"$H->{$e}{b}\" end=\"$H->{$e}{e}\" multiCanonical=\"false\" context=\"$j\" confidenceText=\"m\" componentId=\"wdd/gene\" mentionType=\"GENE\"/>";
		}
		else {
			#<ls:Ptm xmi:id="815" sofa="1" begin="4114" end="4128" canonicalName="phosphorylation" sentence="831" negation="false" negationText="FALSE" displayName="phosphorylation" componentId="wdd/ptm" actionType="direct" uncertaintyFeature="negation=FALSE,actionType=direct,Readability=31,PTMsInAbstract=4,PTMsInSentence=1,NonPTMsInSentence=1,NonPTMsInAbstract=49,AminosInAbstract=0,AminosInSentence=0,GenesInAbstract=44,GenesInSentence=4"/>
			print O "<ls:Ptm xmi:id=\"$i\" sofa=\"1\" begin=\"$H->{$e}{b}\" end=\"$H->{$e}{e}\" canonicalName=\"$H->{$e}{str}\" sentence=\"$j\" negation=\"false\" negationText=\"FALSE\" displayName=\"$H->{$e}{str}\" componentId=\"wdd/ptm\" actionType=\"direct\" uncertaintyFeature=\"negation=FALSE,actionType=direct,Readability=31,PTMsInAbstract=1,PTMsInSentence=1,NonPTMsInSentence=0,NonPTMsInAbstract=0,AminosInAbstract=0,AminosInSentence=0,GenesInAbstract=1,GenesInSentence=1\"/>";
			$Sent{$j} = 1;
		}
		
		$i++;
	}
	$i = 3;
	undef my @F;
	foreach my $e (keys %{$H}) {
		$i++;
		my $j = $i+1; 
		push @F,$i;
		push @F,$j;
		if (not defined $Sent{$j}) {
			print O "<ls:Context xmi:id=\"$j\" sofa=\"1\" begin=\"$H->{$e}{b}\" end=\"$H->{$e}{e}\"/>";
		}
		else {
			print O "<tcas:Annotation xmi:id=\"$j\" sofa=\"1\" begin=\"$H->{$e}{b}\" end=\"$H->{$e}{e}\"/>";
		}
		$i++;
	}
	
	$_ = join " ",@F;
	print O "<cas:View sofa=\"1\" members=\"2 3 $_\"/></xmi:XMI>";

	close(O);

	
	
}