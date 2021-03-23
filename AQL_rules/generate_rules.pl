use strict;
use warnings;

#my $left = "When NONNEG NONNEG are exposed to DRUG1 , GENE2 becomes PTM1";
#my $right = "DRUG1 PTM1 GENE2";

#my $left = "DRUG1 PTM_POSTREG NONNEG PTM1 NONNEG of GENE2";
#my $right = "DRUG1 PTM1 GENE2";

#my $left = "REGPOS0 GENE2 PTM1 with DRUG1 treatment";
#my $right = "DRUG1 PTM1 GENE2";

#Orig: Lithium and sodium valproate (VPA) are effective in the treatment of bipolar disorder (BD)
#my $left = "DRUG1 and DRUG3 NONNEG DRUG4 are effective in the TREAT1 of COND2";
#my $right = "DRUG1 TREAT1 COND2";

#my $left = "DRUG3 and DRUG1 NONNEG DRUG4 are effective in the TREAT1 of COND2";
#my $right = "DRUG1 TREAT1 COND2";

#Orig: VPA led to continued induction of c-Fos
#my $left = "DRUG1 led to continued REGPOS1 of GENE2";
#my $right = "DRUG1 REGPOS1 GENE2";

#Orig: VPA led to continued induction of c-Fos, in addition to induction of c-Jun
#my $left = "DRUG1 led to NONNEG6 in_addition_to REGPOS1 of GENE2";
#my $right = "DRUG1 REGPOS1 GENE2";

#Orig: Lithium and sodium valproate (VPA) are effective in the treatment of bipolar disorder (BD)
#and may function through the regulation of signal transduction pathways and transcription factors such as c-fos and c-Jun
#my $left = "DRUG1 and DRUG3 NONNEG DRUG4 are NONNEG10 and may function NONNEG3 REG1 of NONNEG11 GENE2";
#my $right = "DRUG1 REG1 GENE2";
#my $left = "DRUG3 and DRUG1 NONNEG DRUG4 are NONNEG10 and may function NONNEG3 REG1 of NONNEG11 GENE2";
#my $right = "DRUG1 REG1 GENE2";

#Orig: Renoprotective effect of benazepril in diabetic rats may be partly related to the inhibition of angiotensin II -P42/44MAPK pathway.
#my $left = "DRUG1 NONNEG3 may be partly related to the PTM1 of GENE2";
#my $right = "DRUG1 PTM1 GENE2";
#my $left = "DRUG1 NONNEG3 may be partly related to the PTM1 of GENE3 GENE2";
#my $right = "DRUG1 PTM1 GENE2";
#
#Orig: Inhibition of Hsp90 function by geldanamycin (GA)

#my $left = "PTM1 of GENE2 function by/with DRUG1";
#my $right = "DRUG1 PTM1 GENE2";

#Orig: Pharmacological inhibition of Hsp90 with geldanamycin
#my $left = "PTM1 of GENE2 by/with DRUG1";
#my $right = "DRUG1 PTM1 GENE2";

#Orig: CRP stimulation of Syk-deficient platelets demonstrated that in vivo tyrosine phosphorylation of SLP-76 is downstream of Syk
#my $left = "DRUG1 PTM1 of GENE2";
#my $right = "DRUG1 PTM1 GENE2";

#Orig: silicone oil injection for the management of complex retinal detachment
#my $left = "DRUG1 injection for the TREAT1 of COND2";
#my $right = "DRUG1 TREAT1 COND2";

#Orig (Defect 239159): N-(3-(5-fluoro-2-(4-(2-methoxyethoxy)phenylamino)pyrimidin-4-ylamino)phenyl)acrylamide (CC-292) is a highly selective, covalent Btk inhibitor and a sensitive and quantitative assay that measures CC-292-Btk engagement has been developed. 
#my $left = "DRUG1 NONNEG4 is a NONNEG5 GENE2 REGNEG1";
#my $right = "DRUG1 REGNEG1 GENE2";
#Orig (Defect 239159): In the present study, we characterized a novel Btk inhibitor, 6-cyclopropyl-8-fluoro-2-(2-hydroxymethyl-3-{1-methyl-5-[5-(4-methyl-piperazin-1-yl)-pyridin-2-ylamino]-6-oxo-1,6-dihydro-pyridin-3-yl}-phenyl)-2H-isoquinolin-1-one (RN486), in vitro and in rodent models of immune hypersensitivity and arthritis. 
#my $left = "a NONNEG4 GENE2 REGNEG1 , DRUG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig (Defect 247407):Furthermore, ATG5 gene expression level in the PD patient was significantly elevated than that in controls.
#my $left = "GENE1 NONNEG expression level in the COND2 patient was NONNEG REGPOS1";
#my $right = "GENE1 REGPOS1 COND2";

#Orig: In contrast, MDM2, a negative regulator of p53, actively suppresses p300/CBP-mediated p53 acetylation in vivo and in vitro.

#my $left = "GENE1 , a REGNEG1 of GENE2";
#my $right = "GENE1 REGNEG1 GENE2";

#Orig: Effect of the angiotensin-converting enzyme inhibitor trandolapril on mortality and morbidity in diabetic patients with left ventricular dysfunction after acute myocardial infarction.
#my $left = "GENE2 REGNEG1 DRUG1 NONNEG";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig: Fosinopril sodium is the first of the phosphinic acid class of angiotensin-converting enzyme inhibitors (ACEI).
#my $left = "DRUG1 is the NONNEG of the NONNEG3 of GENE2 REGNEG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig: Fast atom bombardment, combined with high-energy collision-induced tandem mass spectrometry, has been used to investigate gas-phase metal-ion interactions with captopril, enalaprilat and lisinopril, all angiotensin-converting enzyme inhibitors.
#my $left = "and DRUG1 , all GENE2 REGNEG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#my $left = "DRUG1 NONNEG5, all GENE2 REGNEG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig: This study was conducted to investigate the prevention of these uraemia-induced vascular abnormalities by the angiotensin-converting enzyme inhibitor (ACE-I) Ramipril.
#Problems with parentheses
#my $left = "GENE2 REGNEG1 ( NONNEG ) DRUG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig: An inhibitor of angiotensin converting enzyme (enalapril) augments endotoxin-induced hypotension in the pig.
#my $left = "REGNEG1 of GENE2 DRUG1";
#my $right = "DRUG1 REGNEG1 GENE2";
#Orig: Captopril, an angiotensin-converting enzyme inhibitor, suppressed urinary protein excretion and the expression of desmin in the nephritic glomeruli, but not other parameters.
#Orig: We performed a placebo-controlled trial on the effects of a combined antihypertensive treatment with delapril, a new nonsulfhydryl angiotensin-converting enzyme inhibitor, and indapamide, a sulfonamide diuretic.
#my $left = "DRUG1 , NONNEG3 GENE2 REGNEG1";
#my $right = "DRUG1 REGNEG1 GENE2";

#Orig: 1/S phase transition: cyclin D1 binding to CDK4/6 activates the transcription factor E2F by phosphorylating its inhibitor, retinoblastoma 1 (RB1) and further promotes cyclin E/CDK2
#my $left = "GENE1 activates NONNEG4 by PTM1 NONNEG2 , GENE2";
#my $right = "GENE1 PTM1 GENE2";

#Orig: In the IGF2 exon 8-9 region, mosaic methylation of 56 CpG sites was observed in fetal tissues and in adult blood DNA.
# Not added (low priority)
#my $left = "GENE1 NONNEG2 region , mosaic PTM1";
#my $right = "GENE1 PTM1";

#Orig: Migraine, a complex debilitating neurological disorder is strongly associated with potassium channel subfamily K member 18 (KCNK18).
#my $left = "COND1 , a NONNEG4 is strongly ASS1 with GENE2";
#my $right = "COND1 ASS1 GENE2";

#Orig: Our study shows the presence of several KCNK18 gene mutations in both migraine with aura and migraine without aura. 
#my $left = "GENE1 gene mutations in NONNEG COND2";
#my $right = "GENE1 ASS1 COND2";

#Orig: : In this study, three common polymorphisms in the KCNK18 gene were analysed for genetic variation in an Australian case-control migraine population consisting of 340 migraine cases and 345 controls. 
#my $left = "GENE1 gene were analysed NONNEG3 in NONNEG3 COND2";
#my $right = "GENE1 PREP1 COND2";

#Orig: Recently, a mutation in the KCNK18 gene, encoding the TRESK two-pore domain potassium channel, was described in a large family with migraine with aura. 
#my $left = "GENE1 NONNEG6 described in NONNEG3 COND2";
#my $right = "GENE1 PREP1 COND2";

#Orig: Loss of function mutations have been linked to typical migraine with aura and due to TRESK's expression pattern and role in neuronal excitability it represents a promising therapeutic target. 
my $left = "COND1 and due to GENE2";
my $right = "COND1 PREP1 GENE2";

my @F = split(/ /,$right);
undef my @Right;
push @Right,"N1.origSentence as sentence";
for(my $i=0;$i<=$#F;$i++) {
	if (($F[$i] =~ /^GENE(\d+)/)||($F[$i] =~/^DRUG(\d+)/)||($F[$i] =~/^COND(\d+)/)) {
		if ($1 eq "1") {
			#O1.match as agent, O1.prov as AgentProv, O1.match as AgentValue,  O1.canonicalName as AgentCanonicalName, 
			if ($right =~ /PREP\d+/) {
				push @Right,"O1.match as agent";
				push @Right,"O1.prov as AgentProv";
				push @Right,"O1.match as AgentValue";
				push @Right,"O1.canonicalName as AgentCanonicalName";
				
			}
			else {
				push @Right,"O1.match as AgentValue";
				push @Right,"O1.match as agent";
				push @Right,"O1.canonicalName as AgentCanonicalName";
				push @Right,"O1.prov as AgentProv";
			}
		}
		else {
			if ($right =~ /PREP\d+/) {
				push @Right,"O2.match as theme";
				push @Right,"O2.prov as ThemeProv";
				push @Right,"O2.match as ThemeValue";
				push @Right,"O2.canonicalName as ThemeCanonicalName";
			}
			else {
				push @Right,"O2.match as ThemeValue";
				push @Right,"O2.match as theme";
				push @Right,"O2.canonicalName as ThemeCanonicalName";
				push @Right,"O2.prov as ThemeProv";
			}
		}
	}
	elsif (($F[$i] =~/^PTM(\d+)/)||($F[$i] =~/^TREAT(\d+)/)||($F[$i] =~/^REGPOS(\d+)/)||($F[$i] =~/^REGNEG(\d+)/)
			||($F[$i] =~/^REG(\d+)/)||($F[$i] =~/^ASS(\d+)/)) {
		push @Right,"B$1\.verb as verb";
		push @Right,"GetText(B$1\.verb) as verbBase";
		push @Right,"\'normal\' as voice";
	}
	elsif ($F[$i] =~ /^PREP(\d+)/) {
		push @Right,"N$1\.headText as verb";
		push @Right,"\'\' as voice";
		push @Right,"\'Prepositional\' as verb_canonical";
	}
}

@F = split(/ /,$left);
undef my @Follow;
undef my @Type;
my $oi = 1;
my $b = 1;
my $n = 1;
my $c = 1;
for(my $i=0;$i<=$#F;$i++) {
	if (($F[$i] =~ /^GENE(\d+)/)||($F[$i] =~/^DRUG(\d+)/)||($F[$i] =~/^COND(\d+)/)) {
		my $id = $1;
		push @Follow,"O$id\.match";
		if ($F[$i]=~ /GENE/) {
			push @Type, "Equals(GetText(O$id.prov),\'com.ibm.wdd.type.Gene\')";
		}
		elsif ($F[$i]=~ /DRUG/) {
			push @Type, "Or(Equals(GetText(O$id.prov),\'com.ibm.wdd.type.Drug\'),Equals(GetText(O$id.prov),\'com.ibm.wdd.type.Chemical\'))";
		}
		else {
			push @Type, "Equals(GetText(O$id.prov),\'com.ibm.wdd.type.Condition\')";
		}
		$oi++;
	}
	
	elsif (($F[$i] =~/^PTM(\d+)/)||($F[$i] =~/^TREAT(\d+)/)) {
		push @Follow,"B$1\.verb";
		$b++;
	}
	elsif ($F[$i] eq ",") {
		push @Follow,"C$b\.match";
		$c++;
	}
	elsif ($F[$i] =~/^REGPOS(\d+)/) {
		push @Follow,"B$1\.verb";
		push @Type,"Equals(GetText(B$1\.Canonical),\'RegulationPositive\')";
		$b++;
	}
	elsif ($F[$i] =~/^REGNEG(\d+)/) {
		push @Follow,"B$1\.verb";
		push @Type,"Equals(GetText(B$1\.Canonical),\'RegulationNegative\')";
		$b++;
	}
	elsif ($F[$i] =~/^REG(\d+)/) {
		push @Follow,"B$1\.verb";
		push @Type,"Equals(GetText(B$1\.Canonical),\'Regulation\')";
		$b++;
	}
	elsif ($F[$i] =~/^ASS(\d+)/) {
		push @Follow,"B$1\.verb";
		push @Type,"Equals(GetText(B$1\.Canonical),\'Association\')";
		$b++;
	}	
	elsif ($F[$i] =~/^NONNEG(\d+)/) {
		push @Follow,"$1N$n\.headText";
		$n++;
	}
	else {
		push @Follow,"N$n\.headText";
		if ($F[$i] ne "NONNEG") {
			$F[$i] =~s /\_/ /g;
			if ($F[$i]=~/\//) {
				my @G = split(/\//,$F[$i]);
				foreach (@G) {
					$_ = "Equals(GetText(N$n.headText),\'$_\')";
				}
				$_ = join ",",@G;
				push @Type,"Or($_)";
			}
			else {
				push @Type,"Equals(GetText(N$n.headText),\'$F[$i]\')";
			}
		}
		$n++;
	}
}

print "create view HPRelation as\n";
#Print RHS
$_ = join ", ",@Right;
print "select $_\n";

#Print Entity ids
undef my @Id;
foreach (@Follow) {
	if (/^O(\d+)/) {
		push @Id,"ObjectsOfInterest O$1"; 
	}
	elsif (/^\d*N(\d+)/) {
		push @Id,"Nodes N$1"; 
	}
	elsif (/^B(\d+)/) {
		push @Id,"AllBioRels B$1"; 
	}
	elsif (/^C(\d+)/) {
		push @Id,"Comma C$1"; 
	}
}
$_ = join ", ",@Id;
print "from $_\n";

#Print Follow
undef my @G;
for(my $i=1;$i<=$#Follow;$i++) {
	if ($Follow[$i-1] =~s /^(\d+)//) {
		push @G,"FollowsTok($Follow[$i-1],$Follow[$i],0,$1)";
	}
	else {
		$_ = $Follow[$i];
		s /^\d+//;
		push @G,"Follows($Follow[$i-1],$_,0,2)";
	}
}
#add type
push @G,@Type;

$_ = join " and\n",@G;
print "where\n$_\n";
print "Contains(N1.origSentence,O1.match) and\n";
print "Contains(N1.origSentence,O2.match)\;\n";
