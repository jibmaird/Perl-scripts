use DateTime;

my $in_f = "C:\\Users\\IBM_ADMIN\\Data\\ingestion_runs\\ftmj-combined-150-000001\\PtmRunner.log";

open(I,"$in_f")||die;
while(<I>) {
	chomp;
	if (/^2016-07-11 (\d+):(\d+):(\d+)\,/) {
		my $line = $_;
		$dt = DateTime->new(year=>2016,hour =>$1,minute=>$2,second=>$3);
		if (defined $dt_prev) {
			my $aux = $dt_prev - $dt;
			$_ = $aux->minutes;
			if ($_ > 1) {
				print "$_\t$prev_line\n\t$line\n";
			}
		}
		$prev_line = $line;
		$dt_prev = $dt;
	}
}
close(I);