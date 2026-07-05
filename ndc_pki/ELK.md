threathunting

elk

elasticsearch is database

distributes restful search and analytics engine

elastic search consdistes of

index   it has doc
doc smallest storage unit
shards
replicas





8 or 4 ram

apt install default-jdk  curl

sudo dpkg -I elasticsearch -8.16.1-amd.deb



vi /etc/elasticsearch/selaticserch.yml

un commet  cluster.name=application
node.name



networihost to 0.0.0.0





uncummunt  cluter.initial\_master\_node: \[""]
xpack.securiyte.enabled: fales

xpack.securiyte.enrollment.enbled: fales

xpack.securiyte.transport.ssl:
ensled:fales
vrificatiin\_mode:certification

comment cluster.initial\_master\_node:\["deb1"]



start ans status elasticsearch



port 9200



curl -X get localhost:9200/\_cluster/health

curl -X get localhost:9200/\_cluster/health?pretty

\_cluster is index and health is doc

curl -X get localhost:9200/\_alias/health?pretty  to check the user defined index

curl -C PUT localhost:9200/test-index1/

curl -X get localhost:9200/\_alias/health?pretty

curl -X post  localhost:9200/test-index1/\_doc/1?pretty  -H 'content-type : application/json ' -d'{''name':gabbar,age:30,occupation:hacker}'

curl -X get  localhost:9200/test-index1/\_doc/1?pretty

````````````
logstash
````````````

realtime /server-side data processing pipeline

ETL=extract transform load

logstash pipline

pipline files
input
-beats
-files
-http
-syslog
-stdin

filter
-mutate
-grok(regex)
-dns

output
elasticsearch
stdout
systlog
nagios



sudo dpgd -I logstash -8.16.1-amd64.deb

vi pipel.conf

input{stdin{}output{{stdout{codec=>rudydegug}}}}



echo "heloworld" | sudp /user/share/logstas/bin/logtash

input{stdin{}}filter{mutate{upparcase=>\['message']}}output{{stdout{codec=>rudydegug}}}}
echo "heloworld" | sudp /user/share/logstas/bin/logtash -f /home/shuhari/pipel.conf



input{stdin{}}filter{mutate{upparcase=>\['message']}}output{{stdout{codec=>rudydegug}}}}





vi /etc/logstach/conf.d/one.conf

input{file{path=>"var/log/apt/history.log",start\_postion+>"end",sincedb\_path=> var/lib/logstash/apt.sincedb}}
filter{if \[message]=\~/commandline:/{mutable{add\_filed=> \[istalltiom\_sstatus=>installed ]}else{drop()}}}
output{esatiserch{hosts=>\["http://localhost:9200"],index=>"apt\_logs"}stdout{codex=> rubydebug}}



jourlalctl -f -nb -u logstash

restaert the logstash





`````````````
kibana 
````````````
dashboard

dpkg -I kibana-8.16.

vi /etc/kibana/kibana.yml
uncomnet lines below 

seerverhost:0.0.0.0
serverport:5601

start,status kibina

port 5601








snort 
u2binary



barntyard 
 to convete the u2binary  and put in the database

snort.conf

analyse (snort) alert pscket to tcp por 23 detected 

capture



instal the barnyard

install autoconf automake defaluit-libmysqlclient-dev dos2unix libmari adb-dev-compact libmariadb libmariadbd-dev libtool mariadb-clent mariadbd-server unzip


barnyard req libpcap 1.8.1 

downlad the libpcap to 1.8.1 


dpkg -s libcap0.8 | grep version 

dpkg -s libcap0.8-dev | grep version 


apt purge libcap0.8 libcap0.8-dev





```````````````````````

sudo cp etc/barnyard2.conf etc/snort

sudo makdir /var/log/barnyard2
chown snoert:snort /var/log/barnyard2
touch /var/log/snort/barnyard2.waldo
chown snort:snort /var/log /snort/baryarf2.waldo




``````````````````
maria db



create database snort

use snort 
spurce /tmp/binyard2-masterter/schema/create_mysql 

 

create user snort @localhost identify by toor;

grant create,insert,selct,delete.update,on snort to snort@localhost




