my $p_d = "C:\\Users\\IBM_ADMIN\\wd_newRTC\\PerlScripts\\SemMed";


#system("perl $p_d\\extract_gold_from_adjudicated.pl");
#system("perl $p_d\\extract_txt_from_adjudicated.pl");
#Manual: Run DTCRunner into C:\Users\IBM_ADMIN\Data\Corpora\semmed\Exper\test06292016\out
#system("perl $p_d\\extract_dtc_output.pl");

#system("perl $p_d\\eval_doc_level.pl Dtc");
#system("perl $p_d\\eval_doc_level.pl NonPtm");

system("perl $p_d\\eval_doc_by_type.pl Dtc RelOnly");
system("perl $p_d\\eval_doc_by_type.pl NonPtm RelOnly");

system("perl $p_d\\eval_doc_by_type.pl Dtc RelArgs");
system("perl $p_d\\eval_doc_by_type.pl NonPtm RelArgs");
