pki_lab_cli

3 machinreq 1rootca 10 2subca11 3www12



dns both forword reverse


hostname -f
hostname -s
hostname -d


in rootca machine 
```````````````````````````````````````````````````````````````````````````

cd ca
mkdir -P certs crl newcerts private subca/csr subca/certs subca/{csr,certs}


certificate revocation list(crl)



chmode 700 private/

touch index.txt
touch index.txt,attr
echo 1000> serial
echo 1000> crinumber

download root ca.cnf => config+rootca templete (wget rootca.cnf)


edit rootca.cnf  cHANGE TH DIR = /home/shuhari/ca


generate private key 

open genrsa -aes256 -out private/ca.key.pem 4096

enterthe pem phase
enterh the pem pass phrase


chmod 400 private/ca.key.pem


# dc (x509)
configfile name
templete
private key 
output files names
validity 
issued
hasing
openssl req


openssl req -config rootca.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extenstions v3ca  -out certs/ca.cert.pem

chmode 444 certs/ca.cert.pem


openssl x509 -txt -in certs/ca.cert.pem  to read the cert 



``````````````````````````````````````````````````
sub ca 

mkdir -P /hpme/shuhari/subca{certs,crl,csr,newcerts,private}


secure private 
chmode 700 private/


touch index.txt
touch index.txt.attr
echo 1000> serial
echo 1000> crinumber

download sub ca.cnf => config+subca templete (wget subca.cnf)
edit subca.cnf  cHANGE TH DIR = /home/shuhari/subca

generate private key 

open genrsa -aes256 -out private/subca.key.pem 4096
enterthe pem phase
enterh the pem pass phrase


chmod 400 private/ca.key.pem

generate the csr 

openssl req -config subca.cnf -key private/ca.key.pem -new   -sha256 -out csr/subca.cert.pem



scp to csr/subca.cert.pem (sub ca )to  rootca hoem/shuhri/ca/subca/csr/subca.cert.pem 

`````````````````````````````````````````````````````````````````````````````````````````````````````````````````

in rootca machine


openssl ca -confg rootca.cnf -extentions v3_intermediate_ca -days 3650 -notxt -md sha256 -in subca/csr/subca.csr.pem -out subca/certs/subca.certs.pem

cat index.txt
cat serial.old
cat serial

cat index.txt.attr

sha256sum newcerts/1000.pem subca/certs/subca.sert.pem




send cert from rootca to subca 

``````````````````````````````````````````````````````````````````````````````````````````````````````````````````

in www

mkdir in certs in home dir 

deoenload the subca.cnf 



gererate the unencreaptes private key 

openssl genrsa -out www.shuhari.local.key.pem 2048

chome 400 www.shuhari.local.key.pem


openssl req -config subca,cnf  -key www.shuhari.local.key.pem -new	-sha256	 -out www.shuhari.local.csr.pem



send the csr from the www to sub ca 

````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
sun ca machine 


openssl ca -config subca.cnf -extention server_cert -days 375 -notetxt -md sha256 -in csr/www.shuhari.local.csr.pem -out certs/www.shuhari.local.certs.pem


`````````````````````````````````````````````````````````````````````````````````

copy all the cert to webser


`````````````````````````````````````````````````````````````````````````````````



edit domain namein the subca.cnf 

DNS.1=*.shuhari.local



`````````````````````````````````````````````````````````

containacte the all cert to create chain 

cat www.cert subca.certs rootca.certs  > www-subca-rootca-chain.cert.pem


``````````````````````````````````````````````````````````````````````````````````


cp crt and key to etc/apace/ssl 

chmode 6000  etc/apace/ssl/*









