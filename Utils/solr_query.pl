use strict;
use warnings;

#VERSION of ingestion
my $d = "20171117";
my $wrkp = "285";

#retrieve doc
#my $c = "FTMJ";
#my $doc = "2075a37ac52383f5a33836cd13f85341";
#my $c = "Medline";
#my $doc = "21489223";
#my $doc = "Pmcoa_e9dfac92bdc001d6cd976199a4a82d26";
#my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=id:$c\_$doc";

#retrieve ids and entity annotations
my $c = "Medline";
#my $q = "%2Btext%3Atumorigenesis%0A%2Btext%3A%22AKT+tumorigenesis%22~1%0A%2Bgene.canonicalName%3A*&fl=id%2Ctitle%2Cabstract%2Cgene.instanceName%2Cgene.canonicalName&wt=csv&indent=true&rows=19";
#my $q = "id:Medline_17553629&fl=condition.instanceName%2Ccondition.canonicalName&wt=csv&indent=true";
#my $q = "id:Medline_17553629&fl=gene.instanceName&wt=csv&indent=true";
#my $q = "id:Medline_23412905&fl=gene.instanceName&wt=csv&indent=true";
#my $q = "id:Medline_23412905&fl=*&wt=csv&indent=true";
#my $q = "id:Medline_17553629&fl=*";
my $q = "id:Medline_19270680&fl=*&indent=true";
#my $c = "FTMJ";
#my $q = "id:$c\_75d4a6baa8a287bb2ba403951a2edae7&fl=gene.instanceName&wt=csv&indent=true";
#my $q = "id:$c\_ce13dbe238c53cb8dce9bf96dba781a0&fl=gene.instanceName&wt=csv&indent=true";
my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=$q";

#retrieve MESH for id
#my $c = "Medline";
#my $q = "id:Medline_25912151&fl=meshTerms&wt=csv&indent=true";
#my $u = "http://watsonwrkp$wrkp\.rch.stglabs.ibm.com:8500/solr/$c\.$d\_shard1_replica1/select?q=$q";

my $a = `C:\\Users\\IBM_ADMIN\\Downloads\\curl-7.52.1_w32\\src\\curl.exe \"$u\"`;
print "Q:$u\n";
print "$a\n";
