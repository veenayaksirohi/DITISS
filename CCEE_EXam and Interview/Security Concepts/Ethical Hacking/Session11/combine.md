# Network Security & Ethical Hacking Notes (Placement + University Exam + Viva)

---

# 1. TCP Communication

## What is TCP?

**TCP (Transmission Control Protocol)** is a connection-oriented protocol that provides:

* Reliable communication
* Error checking
* Ordered delivery
* Flow control
* Congestion control

Works at the **Transport Layer (Layer 4)** of the OSI model.

---

## TCP Communication Process

### Step 1: Three-Way Handshake

Used to establish connection.

### SYN

Client → Server

```
SYN = 1
Seq = x
```

Client requests connection.

### SYN-ACK

Server → Client

```
SYN = 1
ACK = 1
Seq = y
Ack = x+1
```

Server accepts.

### ACK

Client → Server

```
ACK = 1
Ack = y+1
```

Connection established.

### Diagram

```
Client                    Server

SYN -------------------->

     <---------------- SYN+ACK

ACK -------------------->

Connection Established
```

---

## Data Transfer

After handshake:

```
Client <------> Server
```

Data exchanged reliably.

TCP uses:

* Sequence Numbers
* Acknowledgements
* Retransmissions

---

## Connection Termination (Four-Way Handshake)

```
FIN
ACK
FIN
ACK
```

Used to close connection gracefully.

---

# TCP Communication Flags

TCP header contains control bits called Flags.

---

## 1. SYN

Synchronize.

Purpose:

* Start connection

Example:

```
SYN=1
```

---

## 2. ACK

Acknowledgement.

Purpose:

* Confirm receipt

Example:

```
ACK=1
```

---

## 3. FIN

Finish connection.

Purpose:

* Close session

---

## 4. RST

Reset.

Purpose:

* Immediately terminate connection

Used during:

* Invalid sessions
* Closed ports

---

## 5. PSH

Push.

Purpose:

* Send data immediately

---

## 6. URG

Urgent.

Purpose:

* Process urgent data first

---

## TCP Flags Summary

| Flag | Meaning            |
| ---- | ------------------ |
| SYN  | Start connection   |
| ACK  | Acknowledge        |
| FIN  | End connection     |
| RST  | Reset              |
| PSH  | Immediate delivery |
| URG  | Urgent data        |

---

# Banner Grabbing

## Definition

Technique used to identify:

* Operating System
* Service version
* Application version

---

## Example

FTP Server Response

```
220 FileZilla Server 1.6
```

Attacker learns:

* FTP running
* FileZilla version

---

## Banner Grabbing Methods

### Active

Directly interact with service.

Example:

```
telnet IP 80
```

```
nc IP 80
```

---

### Passive

Observe traffic.

Tools:

* Wireshark
* Tcpdump

---

## Tools

### Nmap

```
nmap -sV target
```

---

### Netcat

```
nc target 80
```

---

## Risks

Reveals:

* Software versions
* Vulnerabilities

---

# OS Fingerprinting

## Definition

Technique to identify target OS.

---

## Active Fingerprinting

Send crafted packets.

Analyze:

* TTL
* Window size
* TCP behavior

Example:

```
nmap -O target
```

---

## Passive Fingerprinting

Observe network traffic.

No direct interaction.

Tools:

* p0f
* Wireshark

---

## Common TTL Values

| OS      | TTL |
| ------- | --- |
| Linux   | 64  |
| Windows | 128 |
| Cisco   | 255 |

Exam Question:

> TTL 128 generally indicates Windows.

---

# Proxy Servers in Attacks

## What is Proxy?

Intermediate server between client and destination.

```
Attacker
   |
 Proxy
   |
Victim
```

---

## Why Attackers Use Proxies

### Hide Identity

Real IP hidden.

---

### Bypass Restrictions

Access blocked sites.

---

### Anonymity

Investigation becomes difficult.

---

### Chain Proxies

```
Attacker
  |
Proxy1
  |
Proxy2
  |
Victim
```

Harder to trace.

---

# HTTP Tunneling

## Definition

Encapsulating non-HTTP traffic inside HTTP/HTTPS.

---

## Purpose

Bypass firewalls.

---

## Example

```
SSH over HTTP
```

Firewall allows HTTP.

SSH traffic hidden.

---

## Uses

Legitimate:

* Remote administration

Malicious:

* Data exfiltration
* C2 communication

---

## Detection

Look for:

* Unusual HTTP traffic
* Long sessions
* Large payloads

---

# IP Spoofing

## Definition

Forging source IP address.

---

## Example

Attacker:

```
10.10.10.10
```

Spoofs:

```
192.168.1.1
```

Victim thinks packet came from trusted host.

---

## Uses

### DDoS

Hide attacker.

---

### Session Hijacking

Impersonation.

---

### Bypass ACL

Trusted IP exploitation.

---

## Types

### Random Spoofing

Random addresses.

### Subnet Spoofing

Same network.

### Fixed Spoofing

Specific address.

---

## Prevention

* Ingress filtering
* Egress filtering
* Packet validation

---

# Enumeration

## Definition

Extracting information from target.

Performed after scanning.

---

## Information Gathered

* Usernames
* Groups
* Shares
* Services
* Hostnames

---

## Enumeration Protocols

### NetBIOS

### SMB

### SNMP

### LDAP

### DNS

---

## Tools

### Nmap

```
nmap -sV
```

### enum4linux

```
enum4linux target
```

### SNMPwalk

```
snmpwalk
```

---

# Password Cracking Techniques

## Definition

Recovering passwords from hashes or login systems.

---

## 1. Dictionary Attack

Uses wordlists.

Example:

```
password
admin123
welcome
```

Fast.

---

## 2. Brute Force

Try every combination.

Slow but effective.

---

## 3. Hybrid Attack

Dictionary + mutations.

Example:

```
admin
admin123
Admin@123
```

---

## 4. Rainbow Table

Precomputed hashes.

Very fast.

Mitigation:

```
Salting
```

---

## 5. Credential Stuffing

Use leaked credentials.

---

## Password Cracking Tools

* John the Ripper
* Hashcat
* Hydra
* Medusa

---

# Cracking Windows Passwords

## Windows Password Storage

Stored in:

### SAM Database

```
C:\Windows\System32\Config\SAM
```

---

## Hash Types

### LM Hash

Weak.

---

### NTLM Hash

Stronger.

Still crackable.

---

## Methods

### Offline Cracking

Obtain hash.

Crack later.

---

### Pass the Hash

Use NTLM hash directly.

No need password.

---

## Prevention

* Strong passwords
* MFA
* Disable LM
* Account lockout

---

# Redirecting SMB Logon to Attacker

## Concept

Victim authenticates to attacker-controlled SMB server.

Attacker captures NTLM authentication.

---

## Result

Can obtain:

* NTLM Hashes
* Credentials

---

## Common Methods

* Malicious UNC paths
* LNK files
* Phishing

---

# SMB Redirection

## Definition

Victim redirected to malicious SMB share.

Example:

```
\\attacker\share
```

Victim attempts authentication.

---

# SMB Relay Attack

## Definition

Captured NTLM authentication is relayed to another server.

Attacker doesn't crack password.

Simply forwards authentication.

---

## Flow

```
Victim
   |
Attacker
   |
Server
```

Victim authenticates.

Attacker relays authentication.

Server grants access.

---

# SMB MITM Attack

Man-in-the-Middle attack on SMB communication.

Attacker:

* Intercepts traffic
* Modifies traffic
* Relays authentication

---

# SMB Countermeasures

### SMB Signing

Most important defense.

---

### Disable NTLM

Use Kerberos.

---

### Network Segmentation

Limit exposure.

---

### MFA

Additional authentication layer.

---

### Patch Systems

Prevent exploitation.

---

# NetBIOS DoS Attacks

## NetBIOS

Network Basic Input Output System.

Ports:

| Port | Protocol |
| ---- | -------- |
| 137  | UDP      |
| 138  | UDP      |
| 139  | TCP      |

---

## Attack Types

### Name Service Flooding

Flood NetBIOS requests.

---

### Resource Exhaustion

Consume system resources.

---

### Session Flooding

Create excessive sessions.

---

## Impact

* Service disruption
* Slow performance
* Crashes

---

## Prevention

* Disable NetBIOS if unnecessary
* Firewalls
* IDS/IPS

---

# DDoS Attack

## Definition

Distributed Denial of Service.

Many systems attack one target.

---

## Goal

Make service unavailable.

---

## Architecture

```
Attacker
    |
Botnet
 / / \ \
Zombie Systems
     |
 Target
```

---

# Types of DDoS

## 1. Volumetric Attack

Consumes bandwidth.

Examples:

* UDP Flood
* ICMP Flood

---

## 2. Protocol Attack

Consumes server resources.

Examples:

* SYN Flood
* Ping of Death

---

## 3. Application Layer Attack

Targets applications.

Examples:

* HTTP Flood

---

# SYN Flood

Abuses TCP handshake.

```
SYN
SYN
SYN
SYN
```

No ACK returned.

Half-open connections accumulate.

Server resources exhausted.

---

# DDoS Countermeasures

### Rate Limiting

Limit requests.

---

### CDN

Distribute traffic.

---

### WAF

Web Application Firewall.

---

### IDS/IPS

Detect abnormal traffic.

---

### Load Balancer

Distribute load.

---

### Anti-DDoS Services

Cloud mitigation.

---

# Exam Important Points

### Frequently Asked Theory Questions

1. Explain TCP three-way handshake.
2. Explain TCP flags.
3. What is banner grabbing?
4. Active vs Passive OS fingerprinting.
5. Explain proxy server usage in attacks.
6. What is HTTP tunneling?
7. Explain IP spoofing.
8. Define enumeration.
9. Password cracking techniques.
10. Explain SMB relay attack.
11. Explain NetBIOS DoS attack.
12. Explain DDoS attack with diagram.

---

# Quick Revision Table

| Topic             | Key Point                             |
| ----------------- | ------------------------------------- |
| TCP               | Reliable connection-oriented protocol |
| SYN               | Start connection                      |
| ACK               | Acknowledge packet                    |
| FIN               | Close connection                      |
| Banner Grabbing   | Identify service versions             |
| OS Fingerprinting | Identify operating system             |
| Proxy             | Hide attacker identity                |
| HTTP Tunnel       | Hide traffic in HTTP                  |
| IP Spoofing       | Fake source IP                        |
| Enumeration       | Gather detailed information           |
| Dictionary Attack | Uses wordlists                        |
| Brute Force       | Try all combinations                  |
| NTLM              | Windows authentication hash           |
| SMB Relay         | Relay victim authentication           |
| NetBIOS           | Uses ports 137,138,139                |
| DDoS              | Distributed denial of service         |

# 50 MCQs

### 1. TCP works at which OSI layer?

A) Physical
B) Data Link
C) Transport ✅
D) Session

### 2. First packet in TCP handshake?

A) ACK
B) SYN ✅
C) FIN
D) RST

### 3. Which flag closes a TCP connection?

A) ACK
B) SYN
C) FIN ✅
D) PSH

### 4. Banner grabbing is used to identify?

A) Passwords
B) OS and Services ✅
C) MAC Address
D) Routing Table

### 5. Nmap OS detection option?

A) -A
B) -sV
C) -O ✅
D) -Pn

### 6. Windows default TTL?

A) 32
B) 64
C) 128 ✅
D) 255

### 7. Proxy server mainly provides?

A) Encryption
B) Anonymity ✅
C) Compression
D) Backup

### 8. HTTP tunneling helps bypass?

A) Antivirus
B) Firewall ✅
C) BIOS
D) DHCP

### 9. IP spoofing means?

A) Fake MAC
B) Fake IP Address ✅
C) Fake DNS
D) Fake Hostname

### 10. Enumeration occurs after?

A) Scanning ✅
B) Exploitation
C) Reporting
D) Cleanup

### 11. SMB primarily uses port?

A) 25
B) 53
C) 445 ✅
D) 161

### 12. NetBIOS Name Service port?

A) 80
B) 110
C) 137 ✅
D) 143

### 13. Which attack uses wordlists?

A) Brute Force
B) Dictionary Attack ✅
C) DDoS
D) Spoofing

### 14. NTLM is used in?

A) Linux
B) Windows ✅
C) Cisco IOS
D) Android

### 15. SMB Relay attack targets?

A) Authentication ✅
B) DNS
C) DHCP
D) ARP

### 16. SYN Flood is a?

A) Malware
B) Protocol DoS Attack ✅
C) Worm
D) Trojan

### 17. DDoS stands for?

A) Dynamic DoS
B) Distributed Denial of Service ✅
C) Data Distribution Service
D) Dual Denial Service

### 18-50 (Important Repeated Questions)

18. RST flag resets connection. ✅
19. ACK acknowledges packets. ✅
20. FIN terminates connection. ✅
21. PSH delivers data immediately. ✅
22. URG indicates urgent data. ✅
23. SMB signing prevents relay attacks. ✅
24. Kerberos is stronger than NTLM. ✅
25. NetBIOS uses port 139. ✅
26. LDAP used for directory enumeration. ✅
27. SNMP used for network enumeration. ✅
28. Rainbow tables target hashes. ✅
29. Salting defeats rainbow tables. ✅
30. Hashcat is a password cracking tool. ✅
31. Hydra is used against login services. ✅
32. John the Ripper cracks hashes. ✅
33. Passive fingerprinting doesn't interact with target. ✅
34. Active fingerprinting sends packets. ✅
35. ICMP flood is volumetric DDoS. ✅
36. HTTP flood is application-layer DDoS. ✅
37. Botnet performs DDoS attacks. ✅
38. Zombie computers form botnets. ✅
39. SMB uses file sharing. ✅
40. NetBIOS supports legacy Windows networking. ✅
41. Enumeration reveals usernames. ✅
42. DNS enumeration reveals records. ✅
43. Proxy chains increase anonymity. ✅
44. Spoofed packets hide attackers. ✅
45. TCP provides reliable delivery. ✅
46. Sequence numbers maintain order. ✅
47. Retransmission handles packet loss. ✅
48. Three-way handshake establishes connection. ✅
49. Four-way handshake terminates connection. ✅
50. WAF helps mitigate application-layer DDoS. ✅

---

## Last-Minute Exam Tricks

🔹 Remember: **SYN → SYN/ACK → ACK** (Connection Start)

🔹 Remember: **FIN → ACK → FIN → ACK** (Connection End)

🔹 Ports:

* SMB = 445
* NetBIOS = 137,138,139
* HTTP = 80
* HTTPS = 443
* SNMP = 161

🔹 Windows TTL = 128

🔹 Linux TTL = 64

🔹 SMB Signing = Defense against SMB Relay

🔹 Salting = Defense against Rainbow Tables

🔹 Enumeration = Information Gathering after Scanning

🔹 DDoS = Many attackers → One victim

These points alone often cover 60–70% of university and certification objective questions on these topics.
# 100 MCQs – TCP, Enumeration, Password Cracking, SMB, DDoS, Proxy, IP Spoofing

## TCP & TCP Flags (1–20)

### 1. TCP stands for:

A) Transfer Control Protocol
B) Transmission Control Protocol ✅
C) Transit Communication Protocol
D) Transport Communication Process

### 2. TCP operates at which OSI layer?

A) Network
B) Data Link
C) Transport ✅
D) Session

### 3. TCP is a:

A) Connectionless protocol
B) Connection-oriented protocol ✅
C) Routing protocol
D) Security protocol

### 4. Which TCP flag initiates a connection?

A) FIN
B) SYN ✅
C) RST
D) ACK

### 5. Which TCP flag acknowledges received data?

A) FIN
B) ACK ✅
C) SYN
D) URG

### 6. Which flag terminates a TCP connection gracefully?

A) FIN ✅
B) ACK
C) PSH
D) SYN

### 7. Which TCP flag immediately resets a connection?

A) RST ✅
B) FIN
C) ACK
D) URG

### 8. PSH flag means:

A) Push data immediately ✅
B) Pause connection
C) Protect session
D) Packet synchronization

### 9. URG flag indicates:

A) Large packet
B) Urgent data ✅
C) Error packet
D) Duplicate packet

### 10. First step of TCP handshake:

A) ACK
B) SYN ✅
C) FIN
D) PSH

### 11. Second step of handshake:

A) FIN
B) ACK
C) SYN-ACK ✅
D) RST

### 12. TCP uses ______ for reliability.

A) MAC addresses
B) Acknowledgements ✅
C) DNS
D) ARP

### 13. TCP uses ______ to maintain packet order.

A) Checksums
B) Ports
C) Sequence Numbers ✅
D) TTL

### 14. Connection termination typically uses:

A) 2 packets
B) 3 packets
C) 4 packets ✅
D) 5 packets

### 15. TCP retransmits packets when:

A) ACK not received ✅
B) TTL expires
C) DNS fails
D) MAC changes

### 16. Which attack abuses TCP handshake?

A) SYN Flood ✅
B) ARP Poisoning
C) DNS Spoofing
D) XSS

### 17. TCP provides:

A) Unreliable delivery
B) Reliable delivery ✅
C) Anonymous delivery
D) Broadcast delivery

### 18. Which protocol is connectionless?

A) TCP
B) UDP ✅
C) FTP
D) HTTP

### 19. TCP header contains:

A) Flags ✅
B) BIOS
C) Cookies
D) Certificates

### 20. TCP primarily works using:

A) Sessions between hosts ✅
B) Broadcasts
C) Multicasts only
D) Routing tables

---

# Banner Grabbing & OS Fingerprinting (21–35)

### 21. Banner grabbing helps identify:

A) Passwords
B) Service versions ✅
C) MAC addresses
D) DNS zones

### 22. Banner grabbing is mainly used during:

A) Enumeration ✅
B) Exploitation
C) Reporting
D) Cleanup

### 23. Nmap version detection option:

A) -Pn
B) -sV ✅
C) -sn
D) -T5

### 24. Netcat command can be used for:

A) Banner grabbing ✅
B) Encryption
C) DHCP
D) Routing

### 25. OS fingerprinting identifies:

A) Database version
B) Operating System ✅
C) Password hash
D) MAC vendor only

### 26. Active fingerprinting:

A) Sends packets to target ✅
B) Only listens
C) Uses DHCP
D) Uses ARP only

### 27. Passive fingerprinting:

A) Sends probes
B) Observes traffic only ✅
C) Modifies packets
D) Performs scanning

### 28. Nmap OS detection option:

A) -A
B) -O ✅
C) -sU
D) -Pn

### 29. Default Windows TTL:

A) 32
B) 64
C) 128 ✅
D) 255

### 30. Default Linux TTL:

A) 64 ✅
B) 128
C) 255
D) 32

### 31. Cisco devices often use TTL:

A) 32
B) 64
C) 128
D) 255 ✅

### 32. Banner grabbing is:

A) Passive only
B) Active or Passive ✅
C) Wireless only
D) DNS only

### 33. Service version information may reveal:

A) Vulnerabilities ✅
B) IP Spoofing
C) ARP entries
D) Cookies

### 34. Passive OS fingerprinting tool:

A) p0f ✅
B) Hydra
C) Burp
D) Nessus

### 35. Banner grabbing is part of:

A) Information Gathering ✅
B) Encryption
C) Hardening
D) Logging

---

# Proxy Servers & HTTP Tunneling (36–50)

### 36. A proxy server acts as:

A) Intermediary ✅
B) Switch
C) Router
D) Firewall only

### 37. Attackers use proxies mainly for:

A) Anonymity ✅
B) Encryption only
C) Routing only
D) Storage

### 38. Proxy hides:

A) MAC Address only
B) Real IP Address ✅
C) BIOS Version
D) Password

### 39. Multiple proxies are called:

A) Relay
B) Proxy Chain ✅
C) Tunnel
D) Cluster

### 40. HTTP Tunneling encapsulates:

A) Other protocols inside HTTP ✅
B) DNS inside FTP
C) TCP inside UDP only
D) ARP inside ICMP

### 41. HTTP Tunneling is often used to:

A) Bypass Firewalls ✅
B) Patch Systems
C) Disable TCP
D) Create VLANs

### 42. SSH over HTTP is an example of:

A) Enumeration
B) HTTP Tunneling ✅
C) DNS Spoofing
D) SMB Relay

### 43. HTTPS traffic uses port:

A) 21
B) 80
C) 443 ✅
D) 445

### 44. HTTP uses port:

A) 25
B) 80 ✅
C) 110
D) 443

### 45. Proxy logs can help:

A) Investigation ✅
B) Password Cracking
C) Enumeration only
D) OS Detection

### 46. Anonymous proxies:

A) Hide source identity ✅
B) Increase TTL
C) Disable TCP
D) Disable DNS

### 47. HTTP Tunneling can be abused for:

A) Data Exfiltration ✅
B) DHCP Allocation
C) NTP Sync
D) RAID

### 48. Proxy servers operate mainly at:

A) Application Layer ✅
B) Physical Layer
C) Data Link Layer
D) Transport Layer

### 49. Proxy chains make tracing:

A) Easier
B) Harder ✅
C) Impossible always
D) Faster

### 50. SOCKS proxy supports:

A) Multiple protocols ✅
B) SMTP only
C) HTTP only
D) DNS only

---

# IP Spoofing & Enumeration (51–70)

### 51. IP Spoofing means:

A) Fake IP Address ✅
B) Fake MAC only
C) Fake Hostname only
D) Fake DNS only

### 52. IP Spoofing is commonly used in:

A) DDoS Attacks ✅
B) Patch Management
C) RAID Setup
D) Logging

### 53. Enumeration occurs after:

A) Scanning ✅
B) Reporting
C) Cleanup
D) Recovery

### 54. Enumeration gathers:

A) Usernames ✅
B) RAM Size only
C) BIOS Password
D) Monitor Model

### 55. SNMP enumeration uses port:

A) 80
B) 161 ✅
C) 445
D) 25

### 56. LDAP is commonly used for:

A) Directory Services ✅
B) DHCP
C) DNS Tunneling
D) SMTP

### 57. DNS Enumeration reveals:

A) DNS Records ✅
B) SMB Shares
C) Password Hashes
D) MAC Tables

### 58. NetBIOS Enumeration reveals:

A) Shares and Names ✅
B) Certificates
C) BIOS Version
D) Cookies

### 59. enum4linux is used against:

A) Windows/SMB Systems ✅
B) Routers only
C) Firewalls only
D) DNS Servers only

### 60. Ingress filtering helps prevent:

A) IP Spoofing ✅
B) SQL Injection
C) XSS
D) CSRF

### 61. Egress filtering checks:

A) Outgoing Traffic ✅
B) Incoming Traffic only
C) DNS only
D) SMB only

### 62. Enumeration is:

A) Active Information Gathering ✅
B) Encryption
C) Routing
D) Logging

### 63. SNMPwalk is used for:

A) SNMP Enumeration ✅
B) Password Cracking
C) DDoS
D) OS Detection

### 64. DNS Zone Transfer can expose:

A) DNS Records ✅
B) Passwords
C) Cookies
D) BIOS

### 65. NetBIOS commonly uses:

A) Ports 137-139 ✅
B) Port 80
C) Port 443
D) Port 22

### 66. SMB commonly uses:

A) Port 445 ✅
B) Port 80
C) Port 21
D) Port 53

### 67. Enumeration is a form of:

A) Information Gathering ✅
B) Encryption
C) Compression
D) Routing

### 68. Hostnames can be obtained via:

A) Enumeration ✅
B) Formatting
C) Encryption
D) RAID

### 69. LDAP Enumeration targets:

A) Active Directory ✅
B) DNS Cache
C) Routing Tables
D) Certificates

### 70. Enumeration may reveal:

A) User Accounts ✅
B) Browser Cache only
C) BIOS Password
D) CPU Model only

---

# Password Cracking, SMB & DDoS (71–100)

### 71. Dictionary attack uses:

A) Wordlists ✅
B) Random Packets
C) DNS Records
D) ARP Tables

### 72. Brute Force attack tries:

A) Every Combination ✅
B) Known Passwords only
C) DNS Queries
D) MAC Addresses

### 73. Hybrid attack combines:

A) Dictionary + Mutations ✅
B) DNS + ARP
C) TCP + UDP
D) FTP + SMTP

### 74. Rainbow tables contain:

A) Precomputed Hashes ✅
B) Certificates
C) DNS Records
D) Cookies

### 75. Salting protects against:

A) Rainbow Tables ✅
B) DDoS
C) Spoofing
D) MITM

### 76. Hashcat is:

A) Password Cracking Tool ✅
B) Firewall
C) IDS
D) SIEM

### 77. John the Ripper is:

A) Password Cracker ✅
B) Sniffer
C) Router
D) Hypervisor

### 78. Hydra is used for:

A) Online Password Attacks ✅
B) DDoS only
C) Enumeration only
D) Logging

### 79. Windows stores local password hashes in:

A) SAM Database ✅
B) DNS
C) IIS
D) DHCP

### 80. NTLM is:

A) Windows Authentication Protocol ✅
B) Linux Kernel
C) Router Protocol
D) Encryption Algorithm

### 81. LM Hash is:

A) Weak Hash ✅
B) Strong Encryption
C) Firewall Rule
D) Routing Protocol

### 82. Pass-the-Hash attack uses:

A) NTLM Hash Directly ✅
B) Plain Password Only
C) Cookies Only
D) DNS Records

### 83. SMB stands for:

A) Server Message Block ✅
B) Service Management Block
C) Session Management Bus
D) Security Message Bridge

### 84. SMB is mainly used for:

A) File Sharing ✅
B) DNS
C) Email
D) VPN

### 85. SMB Relay attack targets:

A) Authentication ✅
B) Routing
C) DNS
D) DHCP

### 86. SMB Signing helps prevent:

A) SMB Relay ✅
B) DDoS
C) SQLi
D) XSS

### 87. Kerberos is preferred over:

A) NTLM ✅
B) SSH
C) DNS
D) ARP

### 88. MITM stands for:

A) Man in the Middle ✅
B) Machine in the Middle
C) Message in Transit Management
D) Memory in the Machine

### 89. DDoS stands for:

A) Distributed Denial of Service ✅
B) Dynamic Denial of Service
C) Distributed Data Service
D) Dual Denial Service

### 90. DDoS uses:

A) Multiple Attack Sources ✅
B) Single Source Only
C) DNS Only
D) Email Only

### 91. A compromised machine in a botnet is called:

A) Zombie ✅
B) Proxy
C) Relay
D) Agent

### 92. SYN Flood is a:

A) Protocol Attack ✅
B) Malware
C) Trojan
D) Worm

### 93. UDP Flood is:

A) Volumetric Attack ✅
B) Password Attack
C) Enumeration Attack
D) MITM

### 94. HTTP Flood targets:

A) Application Layer ✅
B) Physical Layer
C) Data Link Layer
D) BIOS

### 95. Rate Limiting helps mitigate:

A) DDoS ✅
B) Enumeration
C) Hashing
D) Routing

### 96. WAF stands for:

A) Web Application Firewall ✅
B) Wide Access Firewall
C) Web Access Filter
D) Wireless Application Framework

### 97. IDS stands for:

A) Intrusion Detection System ✅
B) Internet Defense Service
C) Internal Data Storage
D) Identity Directory System

### 98. IPS stands for:

A) Intrusion Prevention System ✅
B) Internet Protection Service
C) Internal Packet Service
D) IP Security Service

### 99. CDN can help mitigate:

A) DDoS ✅
B) Enumeration
C) SMB Relay
D) Password Cracking

### 100. Most important defense against SMB Relay:

A) SMB Signing ✅
B) Telnet
C) FTP
D) NetBIOS

# Most Important Exam MCQs (Repeated Frequently)

1. TCP 3-Way Handshake → SYN → SYN-ACK → ACK ✅
2. SMB Port → 445 ✅
3. NetBIOS Ports → 137, 138, 139 ✅
4. HTTP → 80 ✅
5. HTTPS → 443 ✅
6. SNMP → 161 ✅
7. Windows TTL → 128 ✅
8. Linux TTL → 64 ✅
9. SMB Relay Defense → SMB Signing ✅
10. Rainbow Table Defense → Salting ✅
11. Enumeration follows Scanning ✅
12. SYN Flood → Protocol DDoS Attack ✅
13. HTTP Flood → Application Layer DDoS ✅
14. Dictionary Attack → Wordlist Based ✅
15. Pass-the-Hash → Uses NTLM Hash Directly ✅

These 15 questions are extremely likely to appear in university exams, viva, and cybersecurity certification tests.
