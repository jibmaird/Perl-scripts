
#my $in_d = "C:\\Users\\IBM_ADMIN\\Data\\Rel_tests\\Ptm\\Sample_25k\\brat";
my $in_d = "C:\\Users\\IBM_ADMIN\\Data\\DTCtests\\Sample_25k\\brat";
my $out_d = "C:\\Users\\IBM_ADMIN\\Data\\DTCtests\\Sample_25k\\mutation_relations";
my (@F,%H,@G,%MutFiles);
undef %MutFiles;

opendir(D,"$in_d")||die;
@File = grep /\.ann$/,readdir D;
closedir(D);

#DEBUG
#@File = ("10221342.ann");
foreach $f (@File) {
	undef %H;
	open(I,"$in_d\\$f")||die;
	while(<I>) {
		chomp;
		next if $_ eq "";
		@F = split(/\t/,$_);
		if (not defined $F[1]) {
			print "WARNING: wrong format line\n";
			next;
		}
		if ($F[1]=~/^Mutation \d+ \d+$/) {
			$H{$F[0]}=1;		
		}
		elsif ($F[0]=~/^[ER]\d+/) {
			@G = split(/ /,$F[1]);
			foreach (@G) {
				/^.*?\:(.*)$/;
				if (defined $H{$1}) {
					$MutFiles{$f}=1;
					last;
				}
			}
		}
	}
	close(I);
}
foreach $f (keys %MutFiles) {
	$f =~s /\.ann$//;
	
	system("copy $in_d\\$f.txt $out_d");
	system("copy $in_d\\$f.ann $out_d");
	
	
}
