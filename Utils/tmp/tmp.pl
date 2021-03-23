
open(I,"C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160801\\xmi_orig\\US8268982.xmi")||die;
while(<I>) {
	chomp;
	s /\s//g;
	my $total = length($_);  
    s /[a-zA-Z]//g;
    
    my $punctuation = length($_);
    
    $_ = $punctuation / $total;
	print "$_\n";
}
close(I);