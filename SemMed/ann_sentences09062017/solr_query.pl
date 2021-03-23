use strict;
use warnings;

#VERSION of ingestion
my $d = "20170825";
my $wrkp = "346";

#retrieve doc
#my $c = "FTMJ";
#my $doc = "2075a37ac52383f5a33836cd13f85341";
#my $c = "Medline";
#my $doc = "21489223";
#my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=id:$c\_$doc";

#retrieve ids
#my $c = "Medline";
#my $q = "%2Btext%3Atumorigenesis%0A%2Btext%3A%22AKT+tumorigenesis%22~1%0A%2Bgene.canonicalName%3A*&fl=id%2Ctitle%2Cabstract%2Cgene.instanceName%2Cgene.canonicalName&wt=csv&indent=true&rows=19";
#my $q = "id:Medline_25912151&fl=condition.instanceName%2Ccondition.canonicalName&wt=csv&indent=true";
#my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=$q";

#retrieve MESH for id
my $c = "Medline";
my $q = "id:Medline\_$ARGV[0]&fl=meshTerms&wt=csv&indent=true";
my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=$q";

my $a = `C:\\Users\\IBM_ADMIN\\Downloads\\curl-7.52.1_w32\\src\\curl.exe \"$u\"`;
print "$a\n";
