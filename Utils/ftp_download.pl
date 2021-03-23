#!/usr/bin/perl -w

#DOWNLOAD

my $server = "-pw ~erreala666 dmartine\@watsondbp17.rch.stglabs.ibm.com";
my $in_f = "/home/dmartine/Ingestion_Debug/tmp";

#my $server = "-pw biw4you -r evaluator\@sfs1.almaden.ibm.com";
#my $in_f = "\/localdata\/davidm\/semmed\/treats_sentences2.csv";
#my $in_f = "\/localdata\/davidm\/semmed\/stimulates_sentences_filt.csv";
#my $in_f = "\/localdata\/davidm\/semmed\/entity\/*sample*";
#my $in_f = "\/localdata\/davidm\/semmed\/entity\/cond_sentences_sample_depression.csv";
#my $in_f = "\/localdata\/davidm\/semmed\/entity\/*.sent.txt";

#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Samples";

#my $server = "-pw e~daki77 dmartine\@watsonwrkp271.rch.stglabs.ibm.com";
#my $in_f = "/home/dmartine/SemMed/*fn10k.csv";
#my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20160907\\cas";

#my $server = "-pw won00de~ dmartine\@watsonwrkp271.rch.stglabs.ibm.com";
#my $in_f = "/home/dmartine/Ingestion_Debug/Data/US20160206578*";
#my $in_f = "/home/dmartine/Ingestion_Debug/Data/*";
#my $out_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\wdals-annotator-unconstrained\\textAnalytics\\DomainKnowledge";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\tmp_data";

#my $server = $ARGV[0];
#my $in_f = $ARGV[1];
#my $out_d = $ARGV[2];

print "C:\\Users\\IBM_ADMIN\\Downloads\\pscp $server:$in_f $out_d\n";
system("C:\\Users\\IBM_ADMIN\\Downloads\\pscp $server:$in_f $out_d");

