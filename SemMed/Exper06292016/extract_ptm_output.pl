
use vars qw (@File $f);
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06292016";
my $out_f = "$data_d\\Ptm.csv";

opendir(D,"$data_d\\Ptm")||die;
@File = grep /^\d/,readdir D;
closedir(D);

open(O,">$out_f")||die;
foreach $f (@File) {
	&read_xmi("$data_d\\Ptm\\$f");
}
close(O);

sub read_xmi {
	
	my (%H,$cn,$ag,$th,$aux,$id,@F);
	
	my $text = "";
	my $in_f = $_[0];
	
	undef %H;
	open(I,"$in_f")||die;
	while(<I>) {
	    if (s /sofaString=\"(.*?)\"//) {
		$text = $1;
		#$text =~s /\&\#1[03]\;/ /g; ##spaces
		$text =~s /\&amp\;/\&/g; #scape characters
		$text =~s /\&lt\;/\</g; #scape characters
		$text =~s /\&gt\;/\>/g; #scape characters
	    }
	    s/<ls:Document.*?>//g;
	    while (s/<ls:(.*?) xmi:id=\"(.*?)\".*?begin=\"(.*?)\" end=\"(.*?)\"(.*?)>//) {
		$H{$2}{t} = $1;
		$H{$2}{b} = $3;
		$H{$2}{e} = $4;
		$aux = $5;
		$id = $2;
		if ($aux =~ /canonicalName=\"(.*?)\"/) {
		    $H{$id}{cn} = $1;}
		else {
		    $H{$id}{cn} = "";}
	    }
	}
	close(I);
	
	open(I,"$in_f")||die;
	$in_f =~s /^.*\\(.*?)\..*$/$1/;
	$in_f =~s /\_/\t/g;
	while(<I>) {
	    while (s/<ls:Ptm xmi:id=\".*?\".*?begin=\"(.*?)\" end=\"(.*?)\".*?canonicalName=\"(.*?)\".*?agents=\"(.*?)\" targets=\"(.*?)\"//) {
			
			$cn = $3;
			$ag = $4;
			$th = $5;
			my $span = substr($text,$1,$2-$1);
			
			my @Ag = split(/ /,$ag);
			my @Th = split(/ /,$th);
			foreach $ag (@Ag) {
				foreach $th (@Th) {
					undef @F;
					push @F,$in_f;
					push @F,$text;
					push @F,$span;
					push @F,$cn;
					
					$_ = substr($text,$H{$ag}{b},$H{$ag}{e}-$H{$ag}{b});
					push @F,$_;
					push @F,$H{$ag}{cn};
					push @F,$H{$ag}{t};
					
					$_ = substr($text,$H{$th}{b},$H{$th}{e}-$H{$th}{b});
					push @F,$_;
					push @F,$H{$th}{cn};
					push @F,$H{$th}{t};
				
					$_ = join "\t",@F;
					print O "$_\n";
				}
			}
	    }
	}
	close(I);
	
}
