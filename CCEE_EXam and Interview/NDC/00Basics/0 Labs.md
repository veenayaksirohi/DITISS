```
Lab: 

table 2 Debian machine 
try they are Able to communicate or not 

installed and check They running services ssh and http 



sudo aptget apache on both machine 
verify go to ip ansd check base pages 
make changes in htmls   var/www/


 ==> command linne browser example browser links 


=======================================================================================================================================================================================
check 6 test before implementing firewall

ssh shuhari@127.0.0.1 connect deb1 to deb1 
ssh form  deb1 to deb 2
ssh from deb2 to deb1 

now to http  

curl http://ip
==========================================================================================================================================================================================

if All working then implement firewall 

check iptaboes is installed or notr 

sudo apt-get iptables 
sudo which iptables 

llist the default ip tables 

sudo iptables -L 
 by defaukt all allowed inut/outpt 

=======================================================================================\
command to change iptables default policy 

sudo iptables -P Forword DROP 
sudo iptables -P input DROP 

now check the input traffic allowed or not 

deb1 to deb1 is blocked now but we want it allowed the we write our first rule i.e rule 

Rule1: 	
	iptables -A INPUT -I lo -j Accept 

```


# iptbled Lab Commad

```
# 6 scenario LAB 1 IPTABLES

```
1. sudo which iptables — check if iptables is installed
2. sudo iptables -L — list all firewall rules
3. sudo iptables -L -v — list rules with detailed packet/byte info

4. sudo iptables -P FORWARD DROP — set default policy to DROP for forwarded traffic

5. sudo iptables -P INPUT DROP — set default policy to DROP for incoming traffic

6. sudo iptables -A INPUT -i lo -j ACCEPT — allow localhost (loopback) traffic
7. sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT — allow existing/related connections

8. sudo iptables -A INPUT -p tcp -s 192.168.229.141 --dport 22 -j ACCEPT — allow SSH access from specific IP

9. sudo iptables -L --line-numbers — list rules with rule numbers

10. sudo iptables -D INPUT <number> — delete a specific rule by number

```

```
iptables -F
iptables -X
iptables -Y
iptables -Z
iptables --version 
iptables -P FORWORD DROP 
iptables -P INPUT DROP
iptables -A INPUT -i lo -j ACCEPT



sudo which iptables — check if iptables is installed
sudo iptables -L — list all firewall rules
sudo iptables -L -v — list rules with detailed packet/byte info

sudo iptables -P FORWARD DROP — set default policy to DROP for forwarded traffic
sudo iptables -P INPUT DROP — set default policy to DROP for incoming traffic

sudo iptables -A INPUT -i lo -j ACCEPT — allow localhost (loopback) traffic
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT — allow existing/related connections

sudo iptables -A INPUT -p tcp -s 192.168.80.1 --dport 22 -j ACCEPT — allow SSH access from specific IP

sudo iptables -L --line-numbers — list rules with rule numbers
sudo iptables -D INPUT <number> — delete a specific rule by number

```


# Nagios LAb Setup

```


```

