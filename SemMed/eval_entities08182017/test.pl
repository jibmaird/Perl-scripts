$_ = &Overlaps("0 2","2 3");
print "$_\n";

sub Overlaps {
	my $off = $_[0];
	my $off2 = $_[1];
	my ($x1,$x2,$y1,$y2);
	($x1,$x2) = split(/ /,$off);
	($y1,$y2) = split(/ /,$off2);
	print "$off * $off2 *\n";
	if ($x1 <= $y2 && $y1 <= $x2) {
		return 1;
	}
	else {
		return 0;
	}
	
}