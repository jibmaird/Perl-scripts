use warnings;
use strict;

	#files
	my $id = "id";
	my $text_file = "\\txt\\$id.txt";
	my $xmi_file = "\\cas\\$id.xmi";

	#sentence text and boundaries
	my $sent_t = "aspirin treats headache";
	my $sent_s = "0";
	my $sent_e = "22";
	#entity text and boundaries
	my $ent_s = "0";
	my $ent_e = "6";
	my $ent_t = "aspirin";
	
	
	#print text file
	open(O,">$text_file")||die;
	print O "$sent_t\n";
	close(O);
	
	#print xmi file
	open(O,">$xmi_file")||die;
	print O "<?xml version=\"1.0\" encoding=\"UTF-8\"?><xmi:XMI xmlns:cas=\"http:///uima/cas.ecore\" xmlns:xmi=\"http://www.omg.org/XMI\" xmlns:actionapi=\"http:///com/ibm/wda/ls/actionapi.ecore\" xmlns:ls=\"http:///com/ibm/wda/ls.ecore\" xmlns:tcas=\"http:///uima/tcas.ecore\" xmi:version=\"2.0\">
<cas:NULL xmi:id=\"0\"/>";
	print O "<cas:Sofa xmi:id=\"1\" sofaNum=\"1\" sofaID=\"_InitialView\" mimeType=\"text\" sofaString=\"$sent_t\"/>";
	print O "<tcas:DocumentAnnotation xmi:id=\"2\" sofa=\"1\" begin=\"$sent_s\" end=\"$sent_e\" language=\"en\"/>";
	print O "<ls:DocumentMetadata xmi:id=\"3\" documentId=\"$id\" source=\"$text_file\" offset=\"0\" field=\"text\"/>";
	
	print O "<ls:Drug xmi:id=\"4\" sofa=\"1\" begin=\"$ent_s\" end=\"$ent_e\" multiCanonical=\"false\" context=\"7\" textToNormalize=\"$ent_t\" componentId=\"wdd/drug\" mentionType=\"general dictionary drug unmodified\" normalized=\"false\" exemplary=\"false\" normalizedAsChemical=\"false\"/>";
	
	
	print O "<ls:Context xmi:id=\"7\" sofa=\"1\" begin=\"$ent_s\" end=\"$ent_e\"/>";
	
	print O "<cas:View sofa=\"1\" members=\"2 3 4\"/></xmi:XMI>";

	close(O);

