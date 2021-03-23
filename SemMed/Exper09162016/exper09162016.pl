use strict;
use warnings;

my @T = ("linezolid","treats");
foreach my $t (@T) {

system("..\\Exper08222016\\extract_sentences_for_debug.pl $t");
#Run Testbiorels
system("perl extract_answers_into_brat.pl $t");
system("perl extract_gt_files.pl $t");
#Run java evaluation code
}