

my $input = "Aspirin causes cancer.";
my $a = `C:\\Users\\IBM_ADMIN\\Downloads\\curl-7.52.1_w32\\src\\curl.exe -X POST --insecure --header "Content-Type: application/json" --header "Accept: application/json" -d "Aspirin causes cancer." "https://watsonwrkp278.rch.stglabs.ibm.com:8443/annotator_service/analytics-annotator/api/v1/chemical"`;
print "\n$a\n";


