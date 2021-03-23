
my ($f,@F,%H);


#Extract txt files
my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test08022016";
if (not -e "$data_d\\txt") {
	system("mkdir $data_d\\txt");
}
undef %H;
open(I,"$data_d\\linezolid_sent.csv")||die;
while(<I>) {
	chomp;
	@F = split(/\t/,$_);
	
	open(O,">$data_d\\txt\\$F[1]\.txt")||die;
	print O "$F[2]\n";
	close(O);
}
close(I);

#extract ground truth
system(" perl extract_semmed_ground_truth.pl");

#run DTCrunner

#extract answers from brat
system("perl extract_answers_from_brat.pl");

#evaluate
system("perl stats.pl");