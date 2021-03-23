use strict;
use warnings;

#open(I,"C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170209\\log.after_change.txt")||die;
#open(O,">C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170209\\log.after_change.filt.txt")||die;

open(I,"C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170209\\log.txt")||die;
open(O,">C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\20170209\\log.filt.txt")||die;

while(<I>) {
	chomp;
	if (/express/) {
		s /^.*? INFO //;
		print O "$_\n";
	}
}
close(I);
close(O);