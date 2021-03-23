use strict;
use vars qw (@File);

my $data_d = "C:\\Users\\IBM_ADMIN\\Data\\Corpora\\semmed\\Exper\\test06222017";

my $size = 1000;

opendir(D,"$data_d\\GT")||die;
@File = grep /\.txt/,readdir D;
closedir(D);

if (not -e "$data_d\\GT\_$size") {
	system("md $data_d\\GT\_$size");
}
if (not -e "$data_d\\TXT\_$size") {
	system("md $data_d\\TXT\_$size");
}

my $i = 1;
foreach my $f (@File) {
	system("copy $data_d\\GT\\$f $data_d\\GT\_$size\\$f");
	system("copy $data_d\\GT\\$f $data_d\\TXT\_$size\\$f");
	my $f2 = $f;
	$f2 =~s /\.txt/\.ann/;
	system("copy $data_d\\GT\\$f2 $data_d\\GT\_$size\\$f2");
	
	$i++;
	last if $i == $size;
}
