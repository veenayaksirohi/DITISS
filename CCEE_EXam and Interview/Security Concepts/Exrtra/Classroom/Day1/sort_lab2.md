Rules
``````
# ls /etc/snort/rules

Log:
````
# ls /var/log/snort

main configuration file: /etc/snort/snort.conf

NOTE: take backup of original data.

# cp -av /etc/snort/snort.conf /etc/snort/snort.conf_orig_$(date -I)

4. Analyse config file:
```````````````````````
# vim /etc/snort/snort.conf

Comment this line:
#ipvar HOME_NET any

And add new line
ipvar HOME_NET 192.168.206.0/24


And comment all the rules except

$ sed -i 's/include $RULE_PATH/#include $RULE_PATH/' snort.conf

local_rules.

:wq

Test the snort rule/config:
```````````````````````````
# snort -T -i enp0s3 -c /etc/snort/snort.conf

-T : Test
-i : interface
-c : config

Initializing rule chains...
0 Snort rules read
    0 detection rules
    0 decoder rules
    0 preprocessor rules
0 Option Chains linked into 0 Chain Headers







Time to configure own rules:
`````````````````````````````
** Snort rules are divided into two logical sections, the rule header and the rule options. **

1. Rule Header: The rule header contains the rule's `action, protocol, source and destination IP address and netmask, the source and destination port information`.

action
protocol
src ip
src port
dst ip
dst port











2. Rule Options: The rule option section contains alert message and information on which part of packet should be inspected to determine if rule action should be taken.






Rule Syntax:
````````````

<action> <proto> <src_ip> <src_port> -> <dst_ip> <dst_port> (msg:"<msg>"; sid:<signature>; rev:1;)









For custom rule, signature ID starts from 100001, before 100000 reserved for snort.


Rule Actions:
`````````````
alert		: Alert and log the packet
log		: log the packet
pass		: ignore the packet
drop		: block and log the packet
reject		: block the packet, log it and send TCP reset 
sdrop		: block the packet and do not log it
react -> send response to client and terminate session.
reject -> terminate session with TCP reset or ICMP unreachable
rewrite -> enables overwrite packet contents based on a "replace" option in the rules




+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

________________________
a) ANY packet detection:
````````````````````````
# vim /etc/snort/rules/local.rules

alert ip any any -> any any (msg: "IP Packet detected"; sid: 100001; rev:1;) 

# snort -A console -q -i eth0 -c /etc/snort/snort.conf
sudo snort -A console -q -i eth0 -c /etc/snort/snort.conf

02/13-12:39:48.921203  [**] [1:10000:1] IP Packet detected [**] [Priority: 0] {UDP} 143.244.134.227:123 -> 192.168.86.128:48971



Packet Crafting:
`````````````````
Network Operations with Scapy
------------------------------

Scapy is a powerful interactive packet manipulation/crafting program/framework.

+ Install it

# apt install scapy -y
OR
# yum install epel-release -y
# yum install scapy -y

+ Interective shell:

# scapy










________________________________
c) FTP Connection Detection rule:
`````````````````````````````````

# vim /etc/snort/rules/local.rules

alert tcp any any -> $HOME_NET 21 (msg: "FTP Connection"; sid: 1000002; rev: 1;)

# snort -A console -q -i eth0 -c /etc/snort/snort.conf

02/13-12:32:43.635836  [**] [1:1000002:1] FTP Connection [**] [Priority: 0] {TCP} 192.168.86.1:37519 -> 192.168.86.128:21
02/13-12:32:43.636304  [**] [1:1000002:1] FTP Connection [**] [Priority: 0] {TCP} 192.168.86.1:37519 -> 192.168.86.128:21
02/13-12:32:43.692072  [**] [1:1000002:1] FTP Connection [**] [Priority: 0] {TCP} 192.168.86.1:37519 -> 192.168.86.128:21
02/13-12:32:45.712857  [**] [1:1000002:1] FTP Connection [**] [Priority: 0] {TCP} 192.168.86.1:37519 -> 192.168.86.128:21
02/13-12:32:45.714615  [**] [1:1000002:1] FTP Connection [**] [Priority: 0] {TCP} 192.168.86.1:37519 -> 192.168.86.128:21

______________________
d) FLAG detection rule:
```````````````````````
F - FIN 
S - SYN
R - RST
P - PSH
A - ACK
U - URG
0 (zero) - NO FLAG

There are also logical operators:
`````````````````````````````````
+ - ALL flag, match on all specified flags plus any others
* - ANY flag, match on any of the specified flags
! - NOT flag, match if the specified flags aren't set in the packet




# vim /etc/snort/rules/local.rules

alert tcp any any -> $HOME_NET any (flags: S; msg: "SYN Packet"; sid: 1000003; rev: 1;)


# snort -A console -q -i eth0 -c /etc/snort/snort.conf


NOTE: To check use 'scapy' IP()/TCP()

>>> a = IP()
>>> b = TCP()
>>> a.src = "x.x.x.x"
>>> a.dst = "x.x.x.x"
>>> b.flags = "S"
>>> send(a/b)

_________________________
e) Content Matching rule:
`````````````````````````
# vim /etc/snort/rules/local.rules

alert tcp any any -> $HOME_NET 22 (msg: "SSH Attempt"; content: "SSH"; sid: 1000003; rev: 1;)

# snort -A console -q -i eth0 -c /etc/snort/snort.conf

02/13-12:56:02.128231  [**] [1:1000003:1] SSH Attempt [**] [Priority: 0] {TCP} 192.168.86.1:38256 -> 192.168.86.128:22


NOTE: To check use 'scapy' IP()/TCP()

>>> a = IP()
>>> b = TCP()
>>> a.src = "192.168.229.130"
>>> a.dst = "172.24.148.225"
>>> b.flags = "S"

>>> send(a/b/"SSH")



from scapy.all import *

# IP Layer
a = IP()
a.src = "192.168.229.130"
a.dst = "172.24.148.225"

# TCP Layer
b = TCP()
b.dport = 22   # destination port (SSH)
b.flags = "PA" # PUSH+ACK so payload is sent

# Add payload
payload = "SSH"

# Build and send packet
packet = a / b / payload
send(packet)











_____________________________________________________


snort Lab:
``````````
1. Create snort rule to detect LFI payload "/view-source?../../../../../../../etc/passwd" and alert "WEB-CGI view-source access" on port 80 from any external IP?
2. Create snort rule to detect:

- From EXTERNAL NET [10.0.0.0/8]
- To HOME NET on port 53
- content "thisissometempspaceforthesockinaddrinyeahyeahiknowthisislamebutanyway whocareshorizongotitworkingsoalliscool"
- flag ACK

3. Write a SNORT local rule to check/detect FTP login attempt ? 
alert tcp any any -> $HOME_NET 21 (msg: "login attempt detected" ; sid:100005 ; rev:1;)

4. Write a SNORT local rule to check/detect SSH login attempt ?
alert tcp any any -> $HOME_NET 22 (msg: "shh login attempt detected" ; sid:100006 ; rev:1;)

5. Write a SNORT local rule to detect DNS queries for a specific domain (e.g., `example.com`) ?
alert udp any any -> $HOME_NET 53 (msg: "DNS Pkt Detected" ; sid:100000545 ; rev:1;)
alert tcp any any -> $HOME_NET 53 (msg: "DNS Pkt Detected" ; sid:100000545 ; rev:1;)

6. Write a SNORT local rule to detect HTTP packet? 
alert tcp any any -> $HOME_NET 80 (msg:"HTTP Packet Detected"; sid:1000007; rev:1;)

7. Write a SNORT local rule to detect ICMP echo requests (ping) ?


























alert tcp any any -> any 21 (msg:"FTP Login Attempt Detected (USER/PASS)"; flow:to_server,established; content:"USER"; nocase; distance:0; within:4; pcre:"/^USER\s+/i"; sid:1000002; rev:1;)
alert tcp any any -> any 21 (msg:"FTP Password Attempt Detected (PASS)"; flow:to_server,established; content:"PASS"; nocase; distance:0; within:5; pcre:"/^PASS\s+/i"; sid:1000003; rev:1;)




























| ID      | Rule                                                                                                    | Description                  | Test Command                           | Expected Alert              |
| ------- | ------------------------------------------------------------------------------------------------------- | ---------------------------- | -------------------------------------- | --------------------------- |
| 1000001 | `alert icmp any any -> $HOME_NET any (msg:"ICMP PING DETECTED"; sid:1000001; rev:1;)`                   | Detect ICMP (ping) traffic   | `ping <WSL_IP>`                        | ICMP PING DETECTED          |
| 1000002 | `alert tcp any any -> $HOME_NET 21 (msg:"FTP CONNECTION DETECTED"; sid:1000002; rev:1;)`                | Detect FTP connections       | `ftp <WSL_IP>` or `telnet <WSL_IP> 21` | FTP CONNECTION DETECTED     |
| 1000003 | `alert tcp any any -> $HOME_NET 22 (msg:"SSH CONNECTION DETECTED"; sid:1000003; rev:1;)`                | Detect SSH connections       | `ssh user@<WSL_IP>`                    | SSH CONNECTION DETECTED     |
| 1000004 | `alert tcp any any -> $HOME_NET any (flags:S; msg:"SYN SCAN DETECTED"; sid:1000004; rev:1;)`            | Detect SYN scan              | `nmap -sS <WSL_IP>`                    | SYN SCAN DETECTED           |
| 1000005 | `alert tcp any any -> $HOME_NET any (flags:F; msg:"FIN SCAN DETECTED"; sid:1000005; rev:1;)`            | Detect FIN scan              | `nmap -sF <WSL_IP>`                    | FIN SCAN DETECTED           |
| 1000006 | `alert tcp any any -> $HOME_NET any (flags:0; msg:"NULL SCAN DETECTED"; sid:1000006; rev:1;)`           | Detect NULL scan             | `nmap -sN <WSL_IP>`                    | NULL SCAN DETECTED          |
| 1000007 | `alert tcp any any -> $HOME_NET any (flags:FPU; msg:"XMAS SCAN DETECTED"; sid:1000007; rev:1;)`         | Detect Xmas scan             | `nmap -sX <WSL_IP>`                    | XMAS SCAN DETECTED          |
| 1000008 | `alert tcp any any -> $HOME_NET any (flags:A; msg:"ACK SCAN DETECTED"; sid:1000008; rev:1;)`            | Detect ACK scan              | `nmap -sA <WSL_IP>`                    | ACK SCAN DETECTED           |
| 1000009 | `alert tcp any any -> $HOME_NET any (flags:+SA; msg:"SYN+ACK Packet Detected"; sid:1000009; rev:1;)`    | Both SYN and ACK must be set | N/A                                    | SYN+ACK Packet Detected     |
| 1000010 | `alert tcp any any -> $HOME_NET any (flags:!A; msg:"No ACK Flag Packet Detected"; sid:1000010; rev:1;)` | Packet must NOT have ACK     | N/A                                    | No ACK Flag Packet Detected |



























______________________
b) PING Detection rule:
```````````````````````
# vim /etc/snort/rules/local.rules

alert icmp any any -> $HOME_NET any (msg: "LOL ICMP"; sid: 1000001; rev: 1;)

# snort -T -i eth0 -c /etc/snort/snort.conf	[ TEST ]
# snort -A console -q -i eth0 -c /etc/snort/snort.conf [ Debug ]

02/13-12:27:06.070450  [**] [1:1000001:1] LOL ICMP [**] [Priority: 0] {ICMP} 192.168.86.1 -> 192.168.86.128
02/13-12:27:06.070470  [**] [1:1000001:1] LOL ICMP [**] [Priority: 0] {ICMP} 192.168.86.128 -> 192.168.86.1



C) FTP Connection 
D) SSH connection 

E) FLAG DETECTION RULE 
F
S
R
P
A
U
0

there are also logical operator + * !