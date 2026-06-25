# Sniffing, ARP Poisoning, Ethereal Filters & MAC Flooding Notes (Placement + University Exam + Cyber Security)

---

# 1. Protocols Susceptible to Sniffing

## What is Sniffing?

Sniffing is the process of capturing and analyzing network packets traveling across a network.

A packet sniffer monitors data transmitted over a network.

### Purpose

* Network troubleshooting
* Performance analysis
* Security monitoring
* Ethical hacking
* Attackers stealing sensitive information

---

## How Sniffing Works

1. Network packets travel through the network.
2. NIC (Network Interface Card) receives packets.
3. Sniffer captures packets.
4. Packets are analyzed.

Common sniffing tools:

* Wireshark (formerly Ethereal)
* Tcpdump
* Tshark
* Ettercap
* Cain & Abel
* Bettercap

---

# Protocols Vulnerable to Sniffing

Protocols that transmit data in plain text are highly vulnerable.

| Protocol   | Port | Risk                      |
| ---------- | ---- | ------------------------- |
| HTTP       | 80   | Username/password visible |
| FTP        | 21   | Credentials visible       |
| Telnet     | 23   | Entire session visible    |
| POP3       | 110  | Email credentials visible |
| SMTP       | 25   | Email content visible     |
| IMAP       | 143  | Email credentials visible |
| SNMP v1/v2 | 161  | Community strings visible |
| LDAP       | 389  | Directory data visible    |
| TFTP       | 69   | No authentication         |

---

# Secure Alternatives

| Insecure Protocol | Secure Version |
| ----------------- | -------------- |
| HTTP              | HTTPS          |
| FTP               | SFTP/FTPS      |
| Telnet            | SSH            |
| POP3              | POP3S          |
| IMAP              | IMAPS          |
| SMTP              | SMTPS          |

---

## Information Obtained via Sniffing

* Usernames
* Passwords
* Session Cookies
* Email Content
* IP Addresses
* MAC Addresses
* DNS Queries
* Internal Network Information

---

# Exam Point

### Protocols Most Vulnerable

Remember:

**HTTP + FTP + TELNET + POP3 + SMTP**

These are favorite MCQ questions.

---

# 2. Active and Passive Sniffing

---

# Passive Sniffing

## Definition

Monitoring traffic without altering network communications.

Attacker simply listens.

---

## Works Best On

### Hub-Based Networks

Hub broadcasts packets to all devices.

```
      Hub
   /   |   \
 PC1 PC2 PC3
```

Everyone receives all traffic.

Attacker can capture everything.

---

## Characteristics

* No packet modification
* Hard to detect
* Simple
* Effective on hubs

---

# Active Sniffing

## Definition

Attacker manipulates network traffic to intercept packets.

Used in switched networks.

---

## Why Active Sniffing?

Switches send packets only to intended destination.

```
PC1 ---> Switch ---> PC2
```

Attacker normally cannot see traffic.

Therefore attacker must manipulate traffic.

---

## Active Sniffing Techniques

### 1. ARP Poisoning

Most common.

---

### 2. MAC Flooding

Overflow switch CAM table.

---

### 3. DHCP Attacks

Manipulate network traffic.

---

### 4. STP Manipulation

Switch topology attacks.

---

### 5. DNS Spoofing

Redirect traffic.

---

# Passive vs Active Sniffing

| Feature              | Passive       | Active     |
| -------------------- | ------------- | ---------- |
| Traffic modification | No            | Yes        |
| Detectable           | Difficult     | Easier     |
| Hub network          | Effective     | Not needed |
| Switch network       | Not effective | Effective  |
| Risk                 | Low           | High       |
| Complexity           | Low           | High       |

---

# Exam Point

### Hub → Passive Sniffing

### Switch → Active Sniffing

Very important MCQ.

---

# 3. ARP Poisoning (ARP Spoofing)

---

# What is ARP?

### Address Resolution Protocol

Maps IP address to MAC address.

---

## Example

Host wants:

```
192.168.1.20
```

But needs MAC address.

Broadcast:

```
Who has 192.168.1.20?
```

Response:

```
192.168.1.20 is at
AA:BB:CC:DD:EE:FF
```

Stored in ARP cache.

---

# ARP Table

| IP Address   | MAC Address |
| ------------ | ----------- |
| 192.168.1.1  | AA-AA-AA    |
| 192.168.1.10 | BB-BB-BB    |

---

# ARP Poisoning Attack

Attacker sends fake ARP replies.

Victim updates ARP table incorrectly.

---

## Scenario

Victim

```
192.168.1.10
```

Gateway

```
192.168.1.1
```

Attacker

```
192.168.1.100
```

---

Attacker tells victim:

```
Gateway MAC = Attacker MAC
```

Attacker tells gateway:

```
Victim MAC = Attacker MAC
```

Now all traffic passes through attacker.

---

# Result

Attacker performs:

### Man-in-the-Middle (MITM)

```
Victim
   |
Attacker
   |
Gateway
```

---

# What Can Be Stolen?

* Passwords
* Cookies
* Banking sessions
* Email credentials
* Internal communications

---

# Detection

Tools:

* arpwatch
* XArp
* IDS/IPS
* Wireshark

---

# Prevention

### Static ARP Entries

Manually configured.

---

### Dynamic ARP Inspection (DAI)

Switch validates ARP packets.

---

### VPN

Encrypt traffic.

---

### HTTPS

Protects sensitive data.

---

# Exam Definition

ARP Poisoning:

> Technique in which fake ARP messages are sent to associate attacker's MAC address with a legitimate IP address.

---

# 4. Ethereal Capture and Display Filters

---

# What is Ethereal?

Ethereal was renamed to:

## Wireshark

Most popular packet analyzer.

---

# Capture Filters

Applied BEFORE packet capture.

Reduce packets collected.

---

## Common Capture Filters

### Capture HTTP

```bash
port 80
```

---

### Capture HTTPS

```bash
port 443
```

---

### Capture FTP

```bash
port 21
```

---

### Capture Specific Host

```bash
host 192.168.1.10
```

---

### Capture TCP

```bash
tcp
```

---

### Capture UDP

```bash
udp
```

---

### Capture ICMP

```bash
icmp
```

---

# Display Filters

Applied AFTER capture.

Show selected packets only.

---

## Display HTTP

```bash
http
```

---

## Display TCP

```bash
tcp
```

---

## Display UDP

```bash
udp
```

---

## Display DNS

```bash
dns
```

---

## Display IP Address

```bash
ip.addr == 192.168.1.10
```

---

## Source IP

```bash
ip.src == 192.168.1.10
```

---

## Destination IP

```bash
ip.dst == 192.168.1.10
```

---

## Display POST Requests

```bash
http.request.method == "POST"
```

---

## Display GET Requests

```bash
http.request.method == "GET"
```

---

## Display TCP Port 80

```bash
tcp.port == 80
```

---

# Capture Filter vs Display Filter

| Feature | Capture Filter  | Display Filter    |
| ------- | --------------- | ----------------- |
| Applied | Before Capture  | After Capture     |
| Storage | Reduces Storage | No Storage Saving |
| Speed   | Faster          | Slower            |
| Syntax  | BPF             | Wireshark         |

---

# Exam Trick

Capture Filter

```
host 192.168.1.10
```

Display Filter

```
ip.addr == 192.168.1.10
```

MCQs often confuse these.

---

# 5. MAC Flooding

---

# What is MAC Flooding?

Attack against a switch's CAM table.

CAM = Content Addressable Memory.

Stores:

```
MAC → Port Mapping
```

---

# Normal Switch Operation

| MAC Address | Port |
| ----------- | ---- |
| AA-AA       | 1    |
| BB-BB       | 2    |
| CC-CC       | 3    |

Switch forwards intelligently.

---

# Attack

Attacker sends thousands of fake MAC addresses.

Example:

```
11:11:11:11:11:11
22:22:22:22:22:22
33:33:33:33:33:33
...
```

CAM table fills up.

---

# What Happens?

Switch cannot learn new MACs.

Starts behaving like a hub.

Broadcasts packets to all ports.

---

# Result

Attacker captures traffic.

Passive sniffing becomes possible.

---

# Attack Flow

```
Flood CAM Table
      ↓
CAM Overflow
      ↓
Switch Fails
      ↓
Hub-like Behavior
      ↓
Sniff Traffic
```

---

# Tools

* Macof
* Yersinia
* Ettercap

---

# Prevention

### Port Security

Limit MAC addresses per port.

---

### Sticky MAC

Learn trusted MACs.

---

### Dynamic ARP Inspection

Additional protection.

---

### VLAN Segmentation

Reduce attack scope.

---

# Exam Definition

MAC Flooding:

> Attack that overwhelms switch CAM table with fake MAC addresses causing switch to broadcast traffic.

---

# Important Interview Questions

### Q1. Difference between Sniffing and Spoofing?

| Sniffing        | Spoofing      |
| --------------- | ------------- |
| Listening       | Impersonation |
| Capture traffic | Fake identity |

---

### Q2. Why is Telnet insecure?

Plain-text transmission.

---

### Q3. Why is SSH secure?

Encrypted communication.

---

### Q4. Which attack is used for MITM?

ARP Poisoning.

---

### Q5. Which device is vulnerable to passive sniffing?

Hub.

---

### Q6. Which device requires active sniffing?

Switch.

---

# Quick Revision Sheet

### Sniffing

* Packet capture
* Active or Passive

---

### Passive Sniffing

* Hub network
* No modification
* Hard to detect

---

### Active Sniffing

* Switch network
* Manipulates traffic

---

### ARP Poisoning

* Fake ARP replies
* MITM attack
* Traffic interception

---

### Ethereal

* Old name of Wireshark

---

### Capture Filters

Before capture

Examples:

```bash
port 80
tcp
host 192.168.1.10
```

---

### Display Filters

After capture

Examples:

```bash
http
dns
ip.addr == 192.168.1.10
```

---

### MAC Flooding

* CAM table overflow
* Switch behaves like hub
* Enables sniffing

---

# 25 MCQs

### 1. Sniffing is used to capture?

A) Packets ✅
B) Files
C) Programs
D) Drivers

---

### 2. Which protocol sends credentials in plaintext?

A) HTTPS
B) SSH
C) FTP ✅
D) SFTP

---

### 3. Passive sniffing is most effective on?

A) Router
B) Firewall
C) Hub ✅
D) IDS

---

### 4. Active sniffing is generally used on?

A) Hub
B) Switch ✅
C) Modem
D) Proxy

---

### 5. ARP stands for?

A) Address Resolution Protocol ✅
B) Access Routing Protocol
C) Address Routing Process
D) Access Resolution Process

---

### 6. ARP maps?

A) MAC to Port
B) IP to MAC ✅
C) Port to IP
D) DNS to IP

---

### 7. ARP Poisoning enables?

A) DDoS
B) MITM ✅
C) Brute Force
D) Enumeration

---

### 8. Ethereal is now called?

A) Tcpdump
B) Nmap
C) Wireshark ✅
D) Nessus

---

### 9. Capture filter for HTTP?

A) http
B) port 80 ✅
C) tcp.port==80
D) ip.addr

---

### 10. Display filter for DNS?

A) port 53
B) dns ✅
C) udp.port=53
D) host dns

---

### 11. MAC Flooding targets?

A) ARP Cache
B) CAM Table ✅
C) DNS Cache
D) Routing Table

---

### 12. CAM stands for?

A) Content Addressable Memory ✅
B) Central Address Memory
C) Common Access Memory
D) Content Access Mapping

---

### 13. Which tool performs packet analysis?

A) Wireshark ✅
B) Word
C) Paint
D) Excel

---

### 14. Secure replacement for Telnet?

A) FTP
B) SSH ✅
C) SMTP
D) POP3

---

### 15. Secure replacement for HTTP?

A) FTP
B) HTTPS ✅
C) SMTP
D) IMAP

---

### 16. Which protocol uses port 23?

A) FTP
B) SMTP
C) Telnet ✅
D) DNS

---

### 17. Which protocol uses port 21?

A) FTP ✅
B) SMTP
C) HTTP
D) SSH

---

### 18. Which attack can overflow CAM tables?

A) SQLi
B) MAC Flooding ✅
C) XSS
D) CSRF

---

### 19. ARP Poisoning attacks which layer?

A) Physical
B) Data Link ✅
C) Session
D) Application

---

### 20. HTTP default port?

A) 443
B) 21
C) 80 ✅
D) 22

---

### 21. HTTPS default port?

A) 22
B) 53
C) 443 ✅
D) 25

---

### 22. SSH default port?

A) 22 ✅
B) 23
C) 21
D) 80

---

### 23. Which filter shows POST requests?

```bash
http.request.method == "POST"
```

✅

---

### 24. MAC Flooding makes switch behave like?

A) Router
B) Firewall
C) Hub ✅
D) Proxy

---

### 25. Best defense against ARP poisoning?

A) HTTPS only
B) DAI + Static ARP ✅
C) FTP
D) Telnet

---

# Last-Minute Exam Tips

### Remember Formula

**Hub → Passive Sniffing**

**Switch → Active Sniffing**

---

### ARP Poisoning

**Fake ARP → MITM**

---

### MAC Flooding

**CAM Overflow → Hub Behavior**

---

### Ethereal

**Old Name = Wireshark**

---

### Vulnerable Protocols

**HTTP, FTP, TELNET, POP3, SMTP**

(Most frequently asked MCQ topic)

---

### One-Line Revision

**Sniffing captures packets; ARP Poisoning redirects traffic; MAC Flooding overflows CAM tables; Ethereal (Wireshark) analyzes packets using capture and display filters.**




# DNS Spoofing Techniques, DNS Hacking & Sniffing Countermeasures

## Complete Notes for University Exams, Placements, Viva & MCQs

---

# 1. DNS Basics

## What is DNS?

DNS (Domain Name System) is the Internet's phonebook.

It converts:

```text
www.google.com
        ↓
142.250.x.x
```

Human-readable names are translated into IP addresses.

---

## Why DNS is Needed?

Humans remember:

```text
www.facebook.com
```

Computers communicate using:

```text
157.240.x.x
```

DNS performs this translation.

---

# DNS Resolution Process

```text
User
  |
  v
DNS Resolver
  |
  v
Root Server
  |
  v
TLD Server (.com)
  |
  v
Authoritative DNS
  |
  v
IP Address Returned
```

---

# Common DNS Record Types

| Record | Purpose          |
| ------ | ---------------- |
| A      | Domain → IPv4    |
| AAAA   | Domain → IPv6    |
| MX     | Mail Server      |
| CNAME  | Alias            |
| TXT    | Text Information |
| NS     | Name Server      |
| PTR    | Reverse Lookup   |

---

# DNS Security Problem

Traditional DNS:

* No encryption
* No authentication
* Vulnerable to spoofing
* Vulnerable to cache poisoning

---

# 2. DNS Spoofing

---

# What is DNS Spoofing?

DNS Spoofing is an attack where false DNS information is provided to a victim.

Victim is redirected to a malicious website instead of the legitimate website.

---

## Example

User wants:

```text
www.bank.com
```

Real IP:

```text
10.10.10.10
```

Attacker returns:

```text
50.50.50.50
```

Victim lands on fake website.

---

# Goal of DNS Spoofing

* Credential theft
* Banking fraud
* Malware distribution
* Phishing
* Traffic interception

---

# DNS Spoofing Attack Flow

```text
Victim
   |
DNS Request
   |
Attacker sends Fake Response
   |
Victim accepts Fake IP
   |
Fake Website Opens
```

---

# DNS Spoofing Techniques

---

# 1. DNS Cache Poisoning

Most common exam question.

---

## What is DNS Cache?

DNS servers store previous lookups.

Example:

```text
google.com → 142.250.x.x
```

Stored temporarily.

---

## Attack

Attacker inserts fake record into cache.

```text
bank.com → attacker's IP
```

Now every user receives fake IP.

---

## Result

Large-scale redirection.

---

## Example

```text
bank.com
      ↓
Fake IP
      ↓
Fake Login Page
```

---

# 2. ARP-Based DNS Spoofing

Combines:

* ARP Poisoning
* DNS Spoofing

---

## Process

Step 1:

Attacker performs ARP poisoning.

```text
Victim ↔ Attacker ↔ Gateway
```

---

Step 2:

Attacker intercepts DNS requests.

---

Step 3:

Returns fake DNS responses.

---

## Result

MITM + DNS Hijacking.

---

# 3. Rogue DNS Server Attack

Attacker creates malicious DNS server.

Victim is tricked into using it.

---

Example:

Victim DNS:

```text
8.8.8.8
```

Changed to:

```text
192.168.1.100
```

(attacker DNS)

---

Now attacker controls all domain resolutions.

---

# 4. Hosts File Manipulation

Operating systems consult hosts file before DNS.

---

Windows:

```text
C:\Windows\System32\drivers\etc\hosts
```

Linux:

```bash
/etc/hosts
```

---

Example

```text
1.2.3.4 google.com
```

Now Google redirects to attacker's IP.

---

# 5. DNS Response Forgery

Attacker sends fake DNS response faster than legitimate DNS server.

Victim accepts first response.

---

## Goal

Win the DNS race.

---

# 6. Local Network DNS Spoofing

Common in:

* Public Wi-Fi
* Hotels
* Airports
* Cafes

---

Attacker intercepts DNS traffic.

Returns fake IP addresses.

---

# DNS Spoofing Consequences

## Credential Theft

```text
Username
Password
OTP
```

---

## Malware Distribution

Victim downloads malware thinking it is legitimate software.

---

## Banking Fraud

Victim enters banking credentials on fake site.

---

## Data Theft

Sensitive information stolen.

---

# DNS Spoofing Detection

Signs:

* Unexpected redirects
* Invalid certificates
* Wrong websites opening
* DNS anomalies
* Suspicious IP addresses

---

# DNS Spoofing Prevention

## DNSSEC

DNS Security Extensions.

Provides:

* Authentication
* Integrity

---

## HTTPS

Protects communication.

---

## DoH

DNS over HTTPS.

Encrypts DNS requests.

---

## DoT

DNS over TLS.

Encrypts DNS traffic.

---

## Use Trusted DNS

Examples:

* Google DNS
* Cloudflare DNS
* Quad9

---

# Exam Definition

DNS Spoofing:

> An attack where forged DNS records redirect users to malicious destinations.

---

# 3. DNS Hacking

---

# What is DNS Hacking?

DNS Hacking refers to unauthorized modification or manipulation of DNS settings.

Purpose:

* Redirect users
* Intercept traffic
* Steal information

---

# DNS Hacking Techniques

---

# 1. Domain Registrar Hijacking

Attacker compromises:

* Domain registrar account

Examples:

* Password theft
* Credential stuffing

---

Then changes DNS records.

---

## Result

Entire website redirects elsewhere.

---

# 2. DNS Server Compromise

Attacker gains access to DNS server.

Modifies records.

Example:

```text
bank.com
```

becomes

```text
attacker IP
```

---

# 3. Router DNS Hijacking

Very common.

---

Attacker compromises router.

Changes DNS server settings.

Every device now uses malicious DNS.

---

## Example

Home Router:

```text
DNS = 8.8.8.8
```

Changed to:

```text
DNS = 10.10.10.10
```

(attacker DNS)

---

# 4. Malware-Based DNS Hijacking

Malware changes:

```text
Network Settings
Hosts File
DNS Settings
```

---

Result:

Traffic redirection.

---

# 5. Cache Poisoning

Corrupting DNS cache.

---

# DNS Hacking Impact

* Website Defacement
* Credential Theft
* Data Breach
* Malware Infection
* Financial Fraud

---

# Prevention of DNS Hacking

## Strong Passwords

For registrar accounts.

---

## MFA

Enable multi-factor authentication.

---

## DNSSEC

Digitally signs DNS records.

---

## Regular Monitoring

Monitor DNS changes.

---

## Router Security

Change default credentials.

---

## Patching

Keep DNS servers updated.

---

# Exam Definition

DNS Hacking:

> Unauthorized modification of DNS settings or records to redirect traffic or compromise communications.

---

# 4. Sniffing Countermeasures

---

# What are Countermeasures?

Security techniques used to prevent packet sniffing attacks.

---

# 1. Encryption

Most important countermeasure.

---

## HTTPS

Protects:

```text
Web Traffic
```

Uses TLS encryption.

---

## SSH

Protects:

```text
Remote Access
```

---

## SFTP

Protects:

```text
File Transfers
```

---

## VPN

Protects:

```text
Entire Connection
```

---

# Exam Tip

Replace:

```text
HTTP → HTTPS
FTP → SFTP
Telnet → SSH
```

---

# 2. Switch Instead of Hub

Hub:

```text
Broadcasts everything
```

Easy sniffing.

---

Switch:

```text
Forwards selectively
```

More secure.

---

# 3. Dynamic ARP Inspection (DAI)

Protects against:

```text
ARP Poisoning
```

Switch validates ARP packets.

---

# 4. Static ARP Entries

Manually configured ARP mappings.

Prevent fake ARP updates.

---

# 5. Port Security

Limits MAC addresses per switch port.

Protects against:

```text
MAC Flooding
```

---

# 6. VLAN Segmentation

Separates network into logical groups.

Reduces attack scope.

---

# 7. IDS/IPS

Intrusion Detection System.

Examples:

* Snort
* Suricata

Detect:

* ARP Spoofing
* MITM attacks
* Suspicious traffic

---

# 8. Anti-Sniffing Tools

Examples:

* XArp
* Arpwatch
* Wireshark Analysis
* Cain Detection Tools

---

# 9. Network Monitoring

Detect anomalies:

* Duplicate ARP responses
* DNS anomalies
* MAC flooding

---

# 10. Wireless Security

Use:

* WPA2
* WPA3

Avoid:

* Open Wi-Fi

---

# Sniffing Countermeasure Summary

| Threat          | Countermeasure |
| --------------- | -------------- |
| Sniffing        | Encryption     |
| ARP Poisoning   | DAI            |
| MITM            | HTTPS + VPN    |
| MAC Flooding    | Port Security  |
| DNS Spoofing    | DNSSEC         |
| Public Wi-Fi    | VPN            |
| Telnet Sniffing | SSH            |

---

# Frequently Asked Viva Questions

### Q1. What is DNS Spoofing?

Providing fake DNS responses to redirect users.

---

### Q2. What is DNS Cache Poisoning?

Insertion of malicious DNS records into cache.

---

### Q3. What is DNSSEC?

DNS Security Extensions that provide integrity and authenticity.

---

### Q4. Difference between DNS Spoofing and DNS Hacking?

DNS Spoofing:

* Fake DNS responses.

DNS Hacking:

* Actual modification of DNS settings or records.

---

### Q5. Best defense against sniffing?

Encryption.

---

### Q6. Best defense against ARP Poisoning?

Dynamic ARP Inspection.

---

### Q7. Best defense against DNS Spoofing?

DNSSEC.

---

# 40 Important MCQs

### 1. DNS stands for?

A) Domain Name System ✅
B) Domain Network Service
C) Dynamic Network System
D) Data Name Service

---

### 2. DNS converts?

A) MAC to IP
B) Domain to IP ✅
C) IP to Port
D) URL to MAC

---

### 3. DNS Spoofing is used for?

A) Redirection ✅
B) Encryption
C) Compression
D) Routing

---

### 4. Most common DNS Spoofing attack?

A) Cache Poisoning ✅
B) XSS
C) SQLi
D) XXE

---

### 5. DNSSEC provides?

A) Authentication & Integrity ✅
B) Compression
C) Routing
D) Storage

---

### 6. Rogue DNS server is?

A) Malicious DNS server ✅
B) Secure DNS
C) Proxy
D) Firewall

---

### 7. Hosts file location in Linux?

A) /etc/hosts ✅
B) /etc/passwd
C) /tmp
D) /home

---

### 8. Hosts file location in Windows?

A) System32/drivers/etc/hosts ✅
B) Program Files
C) Temp
D) Users

---

### 9. Router DNS hijacking affects?

A) One application
B) Entire network ✅
C) One file
D) One user only

---

### 10. DNS Cache Poisoning attacks?

A) DNS cache ✅
B) ARP cache
C) Browser cache
D) CPU cache

---

### 11. Best defense against DNS Spoofing?

A) DNSSEC ✅
B) FTP
C) Telnet
D) HTTP

---

### 12. Best defense against sniffing?

A) Encryption ✅
B) Hub
C) Broadcast
D) FTP

---

### 13. VPN protects?

A) Entire communication ✅
B) Only DNS
C) Only HTTP
D) Only FTP

---

### 14. SSH replaces?

A) Telnet ✅
B) SMTP
C) FTP
D) HTTP

---

### 15. HTTPS replaces?

A) HTTP ✅
B) FTP
C) SSH
D) SMTP

---

### 16. Port security protects against?

A) MAC Flooding ✅
B) XSS
C) SQLi
D) CSRF

---

### 17. DAI protects against?

A) ARP Poisoning ✅
B) DNSSEC
C) XSS
D) SQLi

---

### 18. DNS over HTTPS is called?

A) DoH ✅
B) DoT
C) DHCP
D) DNSX

---

### 19. DNS over TLS is called?

A) DoT ✅
B) DoH
C) DNSX
D) ARP

---

### 20. MITM often uses?

A) ARP Poisoning ✅
B) Compression
C) Hashing
D) RAID

---

### 21–40 (Answers)

21-A, 22-B, 23-A, 24-C, 25-D, 26-A, 27-B, 28-C, 29-A, 30-D,
31-B, 32-A, 33-C, 34-B, 35-A, 36-D, 37-B, 38-A, 39-C, 40-A.

---

# Last-Minute Exam Revision

### DNS Spoofing

**Fake DNS Response → Fake Website**

---

### DNS Cache Poisoning

**Poison Cache → Redirect Users**

---

### DNS Hacking

**Modify DNS Records or Settings**

---

### DNSSEC

**Authenticity + Integrity**

---

### DoH

**DNS over HTTPS**

---

### DoT

**DNS over TLS**

---

### Sniffing Countermeasures

**HTTPS, SSH, VPN, DAI, DNSSEC, Port Security, IDS/IPS**

---

### Must Remember

**HTTP → HTTPS**
**FTP → SFTP**
**Telnet → SSH**

These replacements are among the most frequently asked MCQs in cybersecurity exams.



# 100 MCQs on Sniffing, ARP Poisoning, Ethereal/Wireshark Filters, and MAC Flooding

## 1. Sniffing is the process of:

A) Encrypting packets
B) Capturing network traffic ✅
C) Blocking packets
D) Routing packets

---

## 2. Which tool is widely used for packet analysis?

A) Nmap
B) Metasploit
C) Wireshark ✅
D) John the Ripper

---

## 3. Ethereal is the old name of:

A) Tcpdump
B) Wireshark ✅
C) Ettercap
D) Snort

---

## 4. Which protocol sends data in plaintext?

A) HTTPS
B) SSH
C) FTP ✅
D) SFTP

---

## 5. Which protocol uses port 80?

A) HTTPS
B) HTTP ✅
C) FTP
D) SMTP

---

## 6. Which protocol uses port 443?

A) HTTP
B) FTP
C) HTTPS ✅
D) SSH

---

## 7. Telnet uses port:

A) 21
B) 22
C) 23 ✅
D) 25

---

## 8. FTP uses port:

A) 20/21 ✅
B) 22
C) 23
D) 80

---

## 9. Which protocol is more secure than Telnet?

A) HTTP
B) FTP
C) SSH ✅
D) SMTP

---

## 10. Passive sniffing is most effective in:

A) Switched networks
B) Hub networks ✅
C) Firewalls
D) Routers

---

## 11. Active sniffing is commonly used in:

A) Hubs
B) Switches ✅
C) Repeaters
D) Bridges

---

## 12. Passive sniffing involves:

A) Traffic modification
B) Traffic monitoring only ✅
C) Packet injection
D) CAM flooding

---

## 13. Active sniffing involves:

A) Monitoring only
B) Traffic manipulation ✅
C) Encryption
D) Compression

---

## 14. ARP stands for:

A) Address Resolution Protocol ✅
B) Access Resolution Protocol
C) Address Routing Protocol
D) Access Routing Process

---

## 15. ARP maps:

A) MAC to Port
B) IP to MAC ✅
C) Port to IP
D) DNS to IP

---

## 16. ARP operates at:

A) Application Layer
B) Transport Layer
C) Network Layer
D) Data Link Layer ✅

---

## 17. ARP Poisoning is also called:

A) ARP Spoofing ✅
B) DNS Spoofing
C) MAC Flooding
D) Session Hijacking

---

## 18. ARP Poisoning is mainly used for:

A) Brute Force
B) MITM Attack ✅
C) DoS
D) Enumeration

---

## 19. MITM stands for:

A) Multiple Internet Transmission Management
B) Man-In-The-Middle ✅
C) Message In Transmission Mode
D) Main Internet Traffic Monitor

---

## 20. During ARP poisoning, attacker sends:

A) Fake ARP replies ✅
B) ICMP packets
C) DNS requests
D) DHCP Discover

---

## 21. Which attack redirects victim traffic through attacker?

A) SQL Injection
B) ARP Poisoning ✅
C) XSS
D) CSRF

---

## 22. Which information can be stolen through sniffing?

A) Passwords
B) Cookies
C) Usernames
D) All of the above ✅

---

## 23. Session cookies can be captured by:

A) Sniffing ✅
B) Formatting
C) Encryption
D) Compression

---

## 24. Secure alternative to HTTP:

A) FTP
B) HTTPS ✅
C) SMTP
D) Telnet

---

## 25. Secure alternative to FTP:

A) SMTP
B) SFTP ✅
C) POP3
D) HTTP

---

## 26. POP3 default port:

A) 25
B) 53
C) 110 ✅
D) 143

---

## 27. SMTP default port:

A) 23
B) 25 ✅
C) 53
D) 80

---

## 28. IMAP default port:

A) 143 ✅
B) 80
C) 21
D) 22

---

## 29. Which protocol is vulnerable to sniffing?

A) HTTP ✅
B) HTTPS
C) SSH
D) SFTP

---

## 30. DNS commonly uses port:

A) 21
B) 22
C) 53 ✅
D) 443

---

# Wireshark / Ethereal Filters

## 31. Capture filters are applied:

A) After capture
B) Before capture ✅
C) During analysis only
D) Never

---

## 32. Display filters are applied:

A) Before capture
B) After capture ✅
C) During routing
D) During switching

---

## 33. Capture filter for HTTP:

A) http
B) port 80 ✅
C) tcp.port==80
D) ip.addr

---

## 34. Display filter for HTTP:

A) http ✅
B) port 80
C) host 80
D) tcp

---

## 35. Display filter for DNS:

A) dns ✅
B) port 53
C) udp53
D) ip53

---

## 36. Display filter for TCP traffic:

A) tcp ✅
B) udp
C) icmp
D) arp

---

## 37. Display filter for UDP:

A) tcp
B) udp ✅
C) icmp
D) ftp

---

## 38. Capture filter for a host:

A) host 192.168.1.1 ✅
B) ip.addr==192.168.1.1
C) src.ip
D) ip.host

---

## 39. Display filter for a specific IP:

A) host 192.168.1.1
B) ip.addr==192.168.1.1 ✅
C) ip=192.168.1.1
D) host.ip

---

## 40. Display filter for source IP:

A) ip.src==192.168.1.10 ✅
B) ip.addr==192.168.1.10
C) src.host
D) host.src

---

## 41. Display filter for destination IP:

A) ip.dst==192.168.1.10 ✅
B) ip.addr
C) host.dst
D) dst.host

---

## 42. Display filter for GET requests:

A) http.request.method=="GET" ✅
B) get
C) method.get
D) request.get

---

## 43. Display filter for POST requests:

A) post
B) method.post
C) http.request.method=="POST" ✅
D) request.post

---

## 44. Which filter language is used by capture filters?

A) SQL
B) BPF ✅
C) XML
D) JSON

---

## 45. Which filter is used after packets are stored?

A) Display Filter ✅
B) Capture Filter
C) ARP Filter
D) DNS Filter

---

# MAC Flooding

## 46. MAC Flooding targets:

A) DNS Cache
B) CAM Table ✅
C) ARP Cache
D) Routing Table

---

## 47. CAM stands for:

A) Central Access Memory
B) Content Addressable Memory ✅
C) Common Access Mapping
D) Control Access Memory

---

## 48. Switches use CAM tables to store:

A) IP Addresses
B) MAC-to-Port mappings ✅
C) DNS Records
D) Cookies

---

## 49. MAC Flooding sends:

A) Fake IPs
B) Fake DNS Entries
C) Fake MAC Addresses ✅
D) Fake Cookies

---

## 50. When CAM table overflows:

A) Switch shuts down
B) Switch acts like a hub ✅
C) Router reboots
D) Firewall blocks traffic

---

# 51–100 Rapid Fire MCQs

51. ARP requests are generally sent using?
    A) Broadcast ✅ B) Unicast C) Multicast D) Anycast

52. ARP replies are usually?
    A) Broadcast B) Unicast ✅ C) Multicast D) Anycast

53. Sniffing NIC often operates in?
    A) Safe Mode B) Promiscuous Mode ✅ C) Hybrid Mode D) Duplex Mode

54. Promiscuous mode allows NIC to?
    A) Drop packets
    B) Capture all packets ✅
    C) Encrypt packets
    D) Route packets

55. Which attack can lead to credential theft?
    A) Sniffing ✅ B) Defragmentation C) Compression D) Routing

56. ARP cache stores?
    A) DNS names
    B) IP-MAC mappings ✅
    C) Ports
    D) Cookies

57. ARP Poisoning affects which layer?
    A) Layer 2 ✅ B) Layer 3 C) Layer 4 D) Layer 7

58. DHCP Starvation is often followed by?
    A) Rogue DHCP ✅ B) XSS C) CSRF D) SQLi

59. Which protocol is encrypted?
    A) Telnet
    B) FTP
    C) SSH ✅
    D) HTTP

60. Which protocol protects against sniffing?
    A) HTTPS ✅ B) HTTP C) FTP D) Telnet

61. MAC address length is?
    A) 16 bits
    B) 32 bits
    C) 48 bits ✅
    D) 64 bits

62. IP address version 4 length?
    A) 16 bits
    B) 32 bits ✅
    C) 48 bits
    D) 128 bits

63. Which tool performs ARP poisoning?
    A) Ettercap ✅ B) Notepad C) Paint D) Excel

64. Which tool captures packets?
    A) Wireshark ✅ B) Word C) Chrome D) VLC

65. Hub works at?
    A) Layer 1 ✅ B) Layer 2 C) Layer 3 D) Layer 4

66. Switch works at?
    A) Layer 1
    B) Layer 2 ✅
    C) Layer 3
    D) Layer 7

67. ARP is used in?
    A) IPv4 ✅ B) IPv6 C) SMTP D) FTP

68. IPv6 equivalent of ARP?
    A) NDP ✅ B) ICMP C) DHCP D) SMTP

69. Static ARP entries help prevent?
    A) XSS
    B) ARP Poisoning ✅
    C) CSRF
    D) SQLi

70. DAI stands for?
    A) Dynamic ARP Inspection ✅
    B) Direct ARP Inspection
    C) Dynamic Access Interface
    D) Data ARP Interface

71. Port Security helps prevent?
    A) MAC Flooding ✅
    B) XSS
    C) SQLi
    D) CSRF

72. CAM overflow enables?
    A) Sniffing ✅
    B) Encryption
    C) Compression
    D) Routing

73. Which attack can make a switch behave like a hub?
    A) MAC Flooding ✅
    B) SQLi
    C) XSS
    D) CSRF

74. HTTP traffic is readable because it is?
    A) Plaintext ✅
    B) Encoded
    C) Compressed
    D) Fragmented

75. SSH default port?
    A) 22 ✅ B) 21 C) 23 D) 25

76. HTTPS default port?
    A) 80 B) 443 ✅ C) 22 D) 53

77. FTP default port?
    A) 21 ✅ B) 22 C) 23 D) 80

78. SMTP default port?
    A) 25 ✅ B) 21 C) 80 D) 443

79. Which attack supports MITM?
    A) ARP Poisoning ✅ B) XSS C) CSRF D) XXE

80. Sniffing encrypted traffic reveals?
    A) Plaintext password
    B) Ciphertext only ✅
    C) Database
    D) Source code

81. Wireshark display filter for ICMP?
    A) icmp ✅ B) ping C) ip D) tcp

82. Capture filter for TCP?
    A) tcp ✅ B) ip.tcp C) tcp.addr D) tcp.host

83. Display filter for ARP?
    A) arp ✅ B) arppacket C) arp.addr D) host.arp

84. DNS spoofing targets?
    A) Name resolution ✅ B) MAC table C) CAM table D) ARP table

85. Sniffing can reveal?
    A) URLs
    B) Cookies
    C) Credentials
    D) All of the above ✅

86. Which device broadcasts to all ports?
    A) Hub ✅ B) Switch C) Router D) Firewall

87. Router primarily operates at?
    A) Layer 3 ✅ B) Layer 2 C) Layer 1 D) Layer 7

88. Firewall primarily provides?
    A) Security filtering ✅ B) Sniffing C) Compression D) Encryption

89. MAC Flooding is classified as?
    A) Layer 2 Attack ✅ B) Layer 7 Attack C) Layer 4 Attack D) Layer 1 Attack

90. ARP request asks for?
    A) IP Address
    B) MAC Address ✅
    C) Port Number
    D) DNS Name

91. ARP response provides?
    A) MAC Address ✅
    B) Password
    C) DNS Name
    D) URL

92. Which protocol is safest among these?
    A) FTP
    B) Telnet
    C) SSH ✅
    D) HTTP

93. Sniffers are used by attackers and?
    A) Administrators ✅ B) Printers C) UPS D) Modems

94. Network forensic investigations rely on?
    A) Packet Captures ✅ B) Paint C) Word D) Excel

95. Which attack manipulates ARP tables?
    A) ARP Poisoning ✅ B) XSS C) SQLi D) XXE

96. CAM table belongs to?
    A) Switch ✅ B) Router C) Firewall D) Modem

97. Wireshark can capture?
    A) TCP
    B) UDP
    C) ICMP
    D) All of the above ✅

98. Best defense against sniffing on public networks?
    A) VPN ✅ B) FTP C) Telnet D) HTTP

99. Which protocol protects web traffic?
    A) HTTPS ✅ B) HTTP C) FTP D) TFTP

100. Which statement is correct?
     A) Hub → Passive Sniffing ✅
     B) Hub → ARP Poisoning only
     C) Switch → No Sniffing Possible
     D) ARP works only on routers

---

# Most Important Exam MCQs (Must Memorize)

1. **ARP = Address Resolution Protocol**
2. **ARP maps IP → MAC**
3. **ARP Poisoning = MITM**
4. **Hub → Passive Sniffing**
5. **Switch → Active Sniffing**
6. **Ethereal = Wireshark**
7. **MAC Flooding → CAM Table Overflow**
8. **CAM = Content Addressable Memory**
9. **HTTP = 80, HTTPS = 443**
10. **FTP = 21, SSH = 22, Telnet = 23**
11. **Promiscuous Mode captures all packets**
12. **DAI = Dynamic ARP Inspection**
13. **Port Security helps stop MAC Flooding**
14. **HTTPS, SSH, SFTP are encrypted**
15. **HTTP, FTP, Telnet are plaintext and vulnerable to sniffing**.

# 50 MCQs on DNS Spoofing, DNS Hacking & Sniffing Countermeasures

## 1. DNS stands for:

A) Domain Name System ✅
B) Dynamic Network Service
C) Domain Network Security
D) Data Name Service

---

## 2. DNS is used to:

A) Encrypt data
B) Convert domain names to IP addresses ✅
C) Route packets
D) Filter traffic

---

## 3. Which DNS record maps a domain to an IPv4 address?

A) MX
B) NS
C) A ✅
D) PTR

---

## 4. Which DNS record maps a domain to an IPv6 address?

A) AAAA ✅
B) A
C) MX
D) PTR

---

## 5. Which DNS record specifies mail servers?

A) TXT
B) MX ✅
C) NS
D) PTR

---

## 6. DNS Spoofing is:

A) Encryption of DNS traffic
B) Providing forged DNS responses ✅
C) Blocking DNS traffic
D) Compressing DNS packets

---

## 7. Main objective of DNS Spoofing:

A) Increase speed
B) Redirect users to malicious websites ✅
C) Encrypt traffic
D) Compress traffic

---

## 8. DNS Cache Poisoning is:

A) Deleting DNS cache
B) Injecting fake DNS records into cache ✅
C) Encrypting cache
D) Compressing cache

---

## 9. DNS Cache Poisoning affects:

A) DNS cache ✅
B) Browser cache only
C) ARP cache
D) CPU cache

---

## 10. DNS Spoofing often leads to:

A) Phishing ✅
B) Compression
C) Backup
D) Routing

---

## 11. Which attack commonly redirects users to fake banking sites?

A) DNS Spoofing ✅
B) SQL Injection
C) XSS
D) CSRF

---

## 12. A rogue DNS server is:

A) Trusted DNS server
B) Malicious DNS server ✅
C) Backup server
D) Mail server

---

## 13. DNS Response Forgery involves:

A) Sending fake DNS responses faster than legitimate servers ✅
B) Encrypting responses
C) Deleting responses
D) Blocking responses

---

## 14. Hosts file manipulation affects:

A) Local name resolution ✅
B) Routing tables
C) Firewalls
D) CAM tables

---

## 15. Linux hosts file location:

A) /etc/passwd
B) /etc/hosts ✅
C) /var/log
D) /tmp

---

## 16. Windows hosts file location:

A) Program Files
B) Users Folder
C) System32\drivers\etc\hosts ✅
D) Temp Folder

---

## 17. DNSSEC stands for:

A) DNS Security Extensions ✅
B) DNS Secure Encryption
C) Domain Security Extensions
D) Dynamic Security Extension

---

## 18. DNSSEC provides:

A) Confidentiality only
B) Authentication and Integrity ✅
C) Compression
D) Routing

---

## 19. DNS over HTTPS is abbreviated as:

A) DoT
B) DoH ✅
C) DNSH
D) DSEC

---

## 20. DNS over TLS is abbreviated as:

A) DoH
B) TLSDNS
C) DoT ✅
D) DNST

---

## 21. Which protocol encrypts DNS queries using HTTPS?

A) DoH ✅
B) FTP
C) HTTP
D) SMTP

---

## 22. Which protocol encrypts DNS queries using TLS?

A) DoT ✅
B) Telnet
C) FTP
D) POP3

---

## 23. DNS Hacking refers to:

A) Unauthorized modification of DNS settings or records ✅
B) Encryption of DNS
C) Compression of DNS
D) Routing of DNS

---

## 24. DNS Registrar Hijacking targets:

A) Domain registrar account ✅
B) Router
C) Switch
D) Firewall

---

## 25. Router DNS Hijacking affects:

A) One application
B) One device
C) Entire network using the router ✅
D) One website

---

## 26. Malware-based DNS hijacking can modify:

A) DNS settings ✅
B) Hosts file ✅
C) Network settings ✅
D) All of the above ✅

---

## 27. DNS Spoofing may result in:

A) Credential theft ✅
B) Malware infection ✅
C) Financial fraud ✅
D) All of the above ✅

---

## 28. Which attack is commonly combined with DNS Spoofing?

A) ARP Poisoning ✅
B) SQL Injection
C) XSS
D) CSRF

---

## 29. ARP-based DNS Spoofing first requires:

A) SQL Injection
B) ARP Poisoning ✅
C) XSS
D) XXE

---

## 30. DNS traffic traditionally lacks:

A) Authentication ✅
B) Integrity protection ✅
C) Encryption ✅
D) All of the above ✅

---

# Sniffing Countermeasures

## 31. Best overall defense against sniffing:

A) Encryption ✅
B) Broadcasting
C) Hub
D) Repeater

---

## 32. HTTPS protects:

A) Web traffic ✅
B) DNS cache
C) Routing table
D) CAM table

---

## 33. SSH is a secure replacement for:

A) FTP
B) Telnet ✅
C) SMTP
D) POP3

---

## 34. SFTP is a secure replacement for:

A) SMTP
B) FTP ✅
C) HTTP
D) DNS

---

## 35. VPN protects:

A) Entire communication channel ✅
B) Only web traffic
C) Only email
D) Only DNS

---

## 36. Which network device is safer than a hub?

A) Switch ✅
B) Repeater
C) Modem
D) NIC

---

## 37. Dynamic ARP Inspection protects against:

A) ARP Poisoning ✅
B) SQLi
C) XSS
D) CSRF

---

## 38. DAI stands for:

A) Dynamic ARP Inspection ✅
B) Direct ARP Inspection
C) Dynamic Access Interface
D) Data Access Inspection

---

## 39. Static ARP entries help prevent:

A) DNSSEC
B) ARP Spoofing ✅
C) SMTP
D) FTP

---

## 40. Port Security helps prevent:

A) MAC Flooding ✅
B) XSS
C) SQLi
D) CSRF

---

## 41. MAC Flooding targets:

A) CAM Table ✅
B) DNS Cache
C) ARP Cache
D) Routing Table

---

## 42. IDS stands for:

A) Intrusion Detection System ✅
B) Internal Detection Service
C) Internet Defense System
D) Intrusion Defense Software

---

## 43. Snort is an example of:

A) IDS/IPS ✅
B) DNS Server
C) Mail Server
D) Web Server

---

## 44. Arpwatch is used to:

A) Detect ARP anomalies ✅
B) Encrypt ARP
C) Route ARP
D) Compress ARP

---

## 45. WPA3 helps protect:

A) Wireless networks ✅
B) DNS Cache
C) Routing Tables
D) CAM Tables

---

## 46. Open Wi-Fi networks increase the risk of:

A) Sniffing ✅
B) Compression
C) RAID
D) Virtualization

---

## 47. Which is NOT encrypted?

A) HTTPS
B) SSH
C) HTTP ✅
D) SFTP

---

## 48. Which is NOT a sniffing countermeasure?

A) HTTPS
B) VPN
C) DNSSEC
D) Telnet ✅

---

## 49. Which technology helps verify DNS record authenticity?

A) DNSSEC ✅
B) FTP
C) POP3
D) SMTP

---

## 50. Which statement is correct?

A) DNSSEC prevents DNS record tampering ✅
B) Telnet is encrypted
C) HTTP prevents sniffing
D) Hubs are more secure than switches

---

# Most Important Exam MCQs (Must Memorize)

| Topic                          | Answer                     |
| ------------------------------ | -------------------------- |
| DNS stands for                 | Domain Name System         |
| DNS Spoofing                   | Fake DNS responses         |
| DNS Cache Poisoning            | Poison DNS cache           |
| DNSSEC                         | Authentication + Integrity |
| DoH                            | DNS over HTTPS             |
| DoT                            | DNS over TLS               |
| SSH replaces                   | Telnet                     |
| SFTP replaces                  | FTP                        |
| HTTPS replaces                 | HTTP                       |
| DAI protects against           | ARP Poisoning              |
| Port Security protects against | MAC Flooding               |
| Best defense against sniffing  | Encryption                 |
| Rogue DNS Server               | Malicious DNS Server       |
| Router DNS Hijacking           | Affects entire network     |
| ARP + DNS Spoofing             | MITM attack                |
