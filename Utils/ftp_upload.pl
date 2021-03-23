#!/usr/bin/perl -w


#UPLOAD (pw can't be a variable)

my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Entity\\samples\\cond_sentences_sample.csv";
#my $server = "evaluator\@sfs1.almaden.ibm.com";
#my $out_d = "/localdata/davidm";
#system("C:\\Users\\IBM_ADMIN\\Downloads\\pscp -pw biw4you -r $in_f $server:$out_d");


my $server = "dmartine\@watsonwrkp271.rch.stglabs.ibm.com";
my $out_d = "/home/dmartine";
system("C:\\Users\\IBM_ADMIN\\Downloads\\pscp -pw e~daki77 -r $in_f $server:$out_d");