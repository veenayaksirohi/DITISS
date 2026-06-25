<!-- Theory:  Introduction to Ethical Hacking
 Creating a Security Evaluation Plan
 Types of Ethical Hacks
 Foot-printing and Social Engineering
 Understand How Traceroute Is Used in Foot-printing
 Define the Terms Port Scanning, Network Scanning and
VulnerabilityScanning
 Understand various Scanning Methodologies
 SYN, Stealth, XMAS, NULL, IDLE and FIN Scans -->

# Ethical Hacking & Scanning Methodologies – Complete Notes for Exams and Interviews

---

# 1. Introduction to Ethical Hacking

## What is Ethical Hacking?

Ethical hacking is the process of identifying vulnerabilities and security weaknesses in systems, networks, applications, or organizations with permission from the owner.

Ethical hackers use the same techniques as malicious hackers but for defensive purposes.

### Objective

* Find vulnerabilities
* Assess security posture
* Improve defenses
* Prevent cyber attacks

---

## Definition

> Ethical Hacking is the authorized attempt to gain unauthorized access to a computer system, application, or network to identify security weaknesses.

---

## Types of Hackers

| Type            | Description                                      |
| --------------- | ------------------------------------------------ |
| White Hat       | Ethical hackers with permission                  |
| Black Hat       | Malicious hackers                                |
| Grey Hat        | Hack without permission but not always malicious |
| Script Kiddie   | Uses pre-built tools                             |
| Hacktivist      | Political/social motives                         |
| State-Sponsored | Government-backed hackers                        |
| Cyber Terrorist | Creates fear/disruption                          |

---

# Phases of Ethical Hacking

## 1. Reconnaissance (Foot-printing)

Collect information about target.

## 2. Scanning

Identify live systems, ports and services.

## 3. Gaining Access

Exploit vulnerabilities.

## 4. Maintaining Access

Install backdoors/persistence.

## 5. Covering Tracks

Hide evidence of compromise.

---

# Ethical Hacking Methodology

```text
Reconnaissance
      ↓
Scanning
      ↓
Enumeration
      ↓
Vulnerability Assessment
      ↓
Exploitation
      ↓
Privilege Escalation
      ↓
Maintaining Access
      ↓
Reporting
```

---

# 2. Creating a Security Evaluation Plan

A Security Evaluation Plan defines how security testing will be performed.

---

## Components

### Scope Definition

Determine:

* IP addresses
* Domains
* Applications
* Wireless networks
* Physical locations

---

### Rules of Engagement (ROE)

Specifies:

* Allowed activities
* Restricted systems
* Testing schedule
* Contact information

---

### Asset Identification

Identify:

* Servers
* Routers
* Firewalls
* Applications
* Databases

---

### Threat Modeling

Determine:

* Possible attackers
* Attack vectors
* Risks

---

### Vulnerability Assessment

Tools:

* Nessus
* OpenVAS
* Qualys

---

### Penetration Testing

Validate vulnerabilities through exploitation.

---

### Reporting

Must include:

* Findings
* Risk level
* Proof of Concept
* Remediation

---

# Exam Point

### Security Evaluation Plan Sequence

```text
Scope
 ↓
Asset Identification
 ↓
Threat Modeling
 ↓
Scanning
 ↓
Testing
 ↓
Reporting
```

---

# 3. Types of Ethical Hacks

---

## 1. External Testing

Performed from outside organization.

Examples:

* Website
* Public IPs
* VPN gateways

---

## 2. Internal Testing

Performed inside network.

Assumes attacker already gained access.

---

## 3. Blind Testing

Tester knows very little information.

Simulates real attacker.

---

## 4. Double Blind Testing

Security team is unaware of testing.

Measures response capabilities.

---

## 5. Targeted Testing

Both parties know testing details.

---

## 6. Wireless Testing

Assess WiFi security.

Examples:

* WPA attacks
* Rogue AP detection

---

## 7. Web Application Testing

Examples:

* SQL Injection
* XSS
* CSRF

---

## 8. Mobile Application Testing

Android and iOS security assessment.

---

# 4. Foot-printing and Social Engineering

---

# Foot-printing

Foot-printing is the process of gathering information about a target before attacking it.

It is the first phase of Ethical Hacking.

---

## Objectives

* Identify target systems
* Discover IP ranges
* Find employees
* Discover technologies

---

# Types of Foot-printing

---

## Passive Foot-printing

No direct interaction with target.

Examples:

* Google Search
* WHOIS
* LinkedIn
* Social Media

Hard to detect.

---

## Active Foot-printing

Direct interaction with target.

Examples:

* Ping
* Traceroute
* Port Scan

Can be detected.

---

# Information Gathered During Foot-printing

### Network Information

* IP addresses
* Subnets
* DNS records

### Employee Information

* Names
* Emails
* Phone numbers

### Technology Information

* OS
* Web server
* CMS

---

# Foot-printing Tools

| Tool         | Purpose                    |
| ------------ | -------------------------- |
| WHOIS        | Domain ownership           |
| nslookup     | DNS information            |
| dig          | DNS queries                |
| Traceroute   | Path discovery             |
| Maltego      | OSINT                      |
| Shodan       | Internet-connected devices |
| Google Dorks | Search engine intelligence |

---

# Social Engineering

Manipulating people to reveal sensitive information.

---

## Common Techniques

### Phishing

Fake emails.

### Spear Phishing

Targeted phishing.

### Whaling

Target executives.

### Vishing

Voice phishing.

### Smishing

SMS phishing.

### Shoulder Surfing

Observing credentials.

### Tailgating

Unauthorized physical entry.

### Baiting

Using infected USB drives.

### Pretexting

Creating fake scenario.

---

# Social Engineering Targets

* Passwords
* OTPs
* Credentials
* Financial data

---

# Exam Tip

People are often the weakest security link.

---

# 5. How Traceroute Is Used in Foot-printing

---

# What is Traceroute?

Traceroute identifies the path packets take from source to destination.

---

## Purpose

* Discover network path
* Identify routers
* Map infrastructure

---

# Working

Traceroute sends packets with increasing TTL values.

Example:

```text
TTL=1 → Router1
TTL=2 → Router2
TTL=3 → Router3
```

Each router decrements TTL by 1.

When TTL becomes 0:

```text
ICMP Time Exceeded
```

message is sent back.

---

# Information Obtained

* Router IPs
* ISP details
* Network topology
* Latency

---

# Linux Command

```bash
traceroute example.com
```

---

# Windows Command

```cmd
tracert example.com
```

---

# Exam Question

### Which protocol does traceroute primarily rely on?

Answer:

ICMP (Windows)

UDP/ICMP (Linux)

---

# 6. Port Scanning, Network Scanning & Vulnerability Scanning

---

# Port Scanning

Technique used to identify open ports and services.

---

## Why?

Discover:

* Running services
* Attack surface

---

## Common Ports

| Port | Service |
| ---- | ------- |
| 21   | FTP     |
| 22   | SSH     |
| 23   | Telnet  |
| 25   | SMTP    |
| 53   | DNS     |
| 80   | HTTP    |
| 110  | POP3    |
| 143  | IMAP    |
| 443  | HTTPS   |
| 3306 | MySQL   |

---

# Network Scanning

Finding live hosts in a network.

Examples:

```bash
nmap -sn 192.168.1.0/24
```

Purpose:

* Host discovery
* Network mapping

---

# Vulnerability Scanning

Automated process to identify weaknesses.

---

## Tools

* Nessus
* OpenVAS
* Qualys
* Nexpose

---

## Finds

* Missing patches
* Weak passwords
* Misconfigurations
* Known CVEs

---

# Difference

| Port Scan         | Network Scan   | Vulnerability Scan  |
| ----------------- | -------------- | ------------------- |
| Finds ports       | Finds hosts    | Finds weaknesses    |
| Service discovery | Host discovery | Security assessment |

---

# 7. Scanning Methodologies

---

# 1. Host Discovery

Identify live systems.

Methods:

* Ping Sweep
* ARP Scan

---

# 2. Port Scanning

Identify open ports.

---

# 3. Service Enumeration

Identify services.

Example:

```bash
nmap -sV
```

---

# 4. OS Fingerprinting

Determine operating system.

```bash
nmap -O
```

---

# 5. Vulnerability Scanning

Identify weaknesses.

---

# Nmap Scan Flow

```text
Host Discovery
      ↓
Port Scan
      ↓
Service Detection
      ↓
OS Detection
      ↓
Vulnerability Assessment
```

---

# 8. SYN Scan

## Name

Half Open Scan

## Nmap

```bash
nmap -sS target
```

---

## Process

```text
Attacker → SYN
Target → SYN/ACK
Attacker → RST
```

Connection never fully established.

---

## Advantages

* Fast
* Stealthier
* Most popular scan

---

# Open Port Response

```text
SYN → SYN/ACK
```

---

# Closed Port Response

```text
SYN → RST
```

---

# 9. Stealth Scan

Stealth scans attempt to avoid detection by IDS/IPS.

Examples:

* SYN Scan
* FIN Scan
* NULL Scan
* XMAS Scan

---

# Advantages

* Less logging
* Harder detection

---

# 10. XMAS Scan

## Nmap

```bash
nmap -sX target
```

---

## TCP Flags Set

```text
FIN + PSH + URG
```

Packet lights up like a Christmas tree.

---

## Response

Open Port:

```text
No Response
```

Closed Port:

```text
RST
```

---

# 11. NULL Scan

## Nmap

```bash
nmap -sN target
```

---

## TCP Flags

```text
No Flags Set
```

---

## Response

Open Port:

```text
No Response
```

Closed Port:

```text
RST
```

---

# 12. FIN Scan

## Nmap

```bash
nmap -sF target
```

---

## TCP Flag

```text
FIN
```

---

## Response

Open Port:

```text
No Response
```

Closed Port:

```text
RST
```

---

# 13. IDLE Scan

Most stealthy scan.

---

## Nmap

```bash
nmap -sI zombieIP target
```

---

## Concept

Uses a third-party system called Zombie.

---

## Benefits

* Hides attacker IP
* Highly stealthy

---

## Requirements

Zombie host must have predictable IP ID sequence.

---

# Scan Comparison Table

| Scan | Nmap Option | Open Port Response | Closed Port Response |
| ---- | ----------- | ------------------ | -------------------- |
| SYN  | -sS         | SYN/ACK            | RST                  |
| FIN  | -sF         | No Response        | RST                  |
| NULL | -sN         | No Response        | RST                  |
| XMAS | -sX         | No Response        | RST                  |
| IDLE | -sI         | Uses Zombie        | Uses Zombie          |

---

# Important Exam Points (Very Important)

### SYN Scan = Half Open Scan

### XMAS Scan Flags

```text
FIN + PSH + URG
```

### NULL Scan

```text
No TCP Flags
```

### FIN Scan

```text
FIN Flag Only
```

### IDLE Scan

```text
Uses Zombie Host
```

### Traceroute Uses

```text
TTL Field
```

### Foot-printing

```text
Information Gathering Phase
```

### Vulnerability Scan

```text
Finds Security Weaknesses
```

---

# 30 Important MCQs

### 1. Ethical hacking is performed with?

A. Permission ✔
B. Malware
C. Virus
D. Spyware

---

### 2. First phase of ethical hacking?

A. Exploitation
B. Scanning
C. Reconnaissance ✔
D. Reporting

---

### 3. Foot-printing belongs to?

A. Reconnaissance ✔
B. Exploitation
C. Persistence
D. Reporting

---

### 4. Passive foot-printing means?

A. No direct interaction ✔
B. Exploitation
C. Scanning
D. Hacking

---

### 5. WHOIS provides?

A. Domain ownership ✔
B. Passwords
C. Hashes
D. Malware

---

### 6. Traceroute primarily uses?

A. TTL ✔
B. MAC Address
C. Cookies
D. Sessions

---

### 7. Port 22 is?

A. HTTP
B. FTP
C. SSH ✔
D. SMTP

---

### 8. Port 443 is?

A. HTTPS ✔
B. FTP
C. DNS
D. Telnet

---

### 9. SYN Scan is also called?

A. Full Open
B. Half Open ✔
C. UDP Scan
D. NULL Scan

---

### 10. SYN Scan Nmap option?

A. -sF
B. -sN
C. -sS ✔
D. -sX

---

### 11. FIN Scan uses which flag?

A. SYN
B. FIN ✔
C. ACK
D. URG

---

### 12. NULL Scan contains?

A. SYN
B. FIN
C. ACK
D. No Flags ✔

---

### 13. XMAS Scan flags?

A. SYN+ACK
B. FIN+PSH+URG ✔
C. ACK+FIN
D. RST

---

### 14. IDLE Scan uses?

A. Proxy
B. Zombie Host ✔
C. VPN
D. Firewall

---

### 15. Vulnerability scanners identify?

A. Weaknesses ✔
B. Employees
C. Routers
D. Domains

---

### 16. Nessus is a?

A. Vulnerability Scanner ✔

### 17. OpenVAS is a?

A. Vulnerability Scanner ✔

### 18. Qualys is used for?

A. Vulnerability Assessment ✔

### 19. Phishing uses?

A. Fake Emails ✔

### 20. Vishing uses?

A. Voice Calls ✔

### 21. Smishing uses?

A. SMS ✔

### 22. Tailgating is?

A. Physical Access Attack ✔

### 23. Spear Phishing is?

A. Targeted Phishing ✔

### 24. Whaling targets?

A. Executives ✔

### 25. Network Scanning finds?

A. Live Hosts ✔

### 26. Port Scanning finds?

A. Open Ports ✔

### 27. Tracert command belongs to?

A. Windows ✔

### 28. traceroute command belongs to?

A. Linux ✔

### 29. Most stealthy scan?

A. IDLE Scan ✔

### 30. Ethical hacker is called?

A. White Hat ✔

---

# Last-Minute Revision Sheet (1 Page)

```text
Foot-printing = Information Gathering

Traceroute = Uses TTL

Port Scan = Finds Open Ports

Network Scan = Finds Live Hosts

Vulnerability Scan = Finds Weaknesses

SYN Scan = Half Open (-sS)

FIN Scan = FIN Flag (-sF)

NULL Scan = No Flags (-sN)

XMAS Scan = FIN+PSH+URG (-sX)

IDLE Scan = Zombie Host (-sI)

Phishing = Email

Vishing = Voice

Smishing = SMS

Tailgating = Physical Access

Nessus/OpenVAS/Qualys = Vulnerability Scanners

Ethical Hacker = White Hat
```

These points alone cover a large portion of typical diploma, BCA, BSc CS, CEH, university, and placement MCQ questions on Ethical Hacking reconnaissance and scanning.


# Ethical Hacking, Foot-printing & Scanning Methodologies – 100 MCQs

## 1. Ethical hacking is performed with:

A) Malware
B) Permission ✅
C) Virus
D) Backdoor

---

## 2. Ethical hackers are also known as:

A) Black Hats
B) Grey Hats
C) White Hats ✅
D) Crackers

---

## 3. The first phase of ethical hacking is:

A) Exploitation
B) Scanning
C) Reconnaissance ✅
D) Reporting

---

## 4. Foot-printing belongs to:

A) Exploitation
B) Reconnaissance ✅
C) Enumeration
D) Persistence

---

## 5. Which hacker works without authorization and with malicious intent?

A) White Hat
B) Grey Hat
C) Black Hat ✅
D) Ethical Hacker

---

## 6. Gathering information without directly interacting with the target is:

A) Active Foot-printing
B) Passive Foot-printing ✅
C) Enumeration
D) Scanning

---

## 7. Which is an example of passive foot-printing?

A) Nmap Scan
B) Ping Sweep
C) WHOIS Lookup ✅
D) Port Scan

---

## 8. Which is an example of active foot-printing?

A) Google Search
B) LinkedIn Search
C) Port Scanning ✅
D) WHOIS

---

## 9. WHOIS is mainly used for:

A) Password Recovery
B) Domain Information ✅
C) Packet Analysis
D) Encryption

---

## 10. DNS stands for:

A) Domain Name System ✅
B) Dynamic Network Service
C) Domain Network Security
D) Digital Name Server

---

# Social Engineering

## 11. Social engineering primarily targets:

A) Hardware
B) People ✅
C) Firewalls
D) Routers

---

## 12. Phishing attacks are usually performed through:

A) Email ✅
B) Router
C) BIOS
D) Switch

---

## 13. Spear phishing targets:

A) Random Users
B) Specific Individuals ✅
C) Routers
D) Servers

---

## 14. Whaling attacks target:

A) Students
B) Network Admins
C) Executives ✅
D) Customers

---

## 15. Vishing refers to:

A) SMS Fraud
B) Voice Fraud ✅
C) Malware
D) Virus

---

## 16. Smishing uses:

A) Phone Calls
B) SMS Messages ✅
C) USB Devices
D) Routers

---

## 17. Tailgating is:

A) SQL Injection
B) Physical Access Attack ✅
C) Port Scan
D) DOS Attack

---

## 18. Shoulder surfing means:

A) Watching someone enter credentials ✅
B) Port Scanning
C) DNS Query
D) Network Mapping

---

## 19. Baiting commonly uses:

A) USB Drives ✅
B) Routers
C) Cookies
D) Switches

---

## 20. Pretexting involves:

A) Fake Scenario Creation ✅
B) Malware Injection
C) DDoS
D) Password Cracking

---

# Traceroute

## 21. Traceroute is used to:

A) Encrypt Data
B) Discover Packet Path ✅
C) Crack Passwords
D) Detect Malware

---

## 22. Traceroute works using:

A) TTL Values ✅
B) Cookies
C) Sessions
D) Hashes

---

## 23. TTL stands for:

A) Time To Live ✅
B) Total Transfer Limit
C) Temporary Time Loop
D) Transmission Test Level

---

## 24. Windows traceroute command:

A) trace
B) traceroute
C) tracert ✅
D) route

---

## 25. Linux traceroute command:

A) route
B) tracert
C) traceroute ✅
D) netstat

---

## 26. When TTL becomes zero:

A) SYN Sent
B) ACK Sent
C) ICMP Time Exceeded Generated ✅
D) Connection Closed

---

## 27. Traceroute helps identify:

A) Network Path ✅
B) Passwords
C) Encryption Keys
D) Sessions

---

## 28. Traceroute can reveal:

A) Routers Along Path ✅
B) User Passwords
C) Cookies
D) Source Code

---

## 29. Traceroute is mainly used during:

A) Foot-printing ✅
B) Exploitation
C) Persistence
D) Covering Tracks

---

## 30. Which protocol is commonly involved in traceroute?

A) FTP
B) ICMP ✅
C) SMTP
D) POP3

---

# Port Scanning

## 31. Port scanning identifies:

A) Open Ports ✅
B) Passwords
C) Files
D) Databases

---

## 32. Port 21 is used by:

A) SSH
B) FTP ✅
C) SMTP
D) DNS

---

## 33. Port 22 is:

A) HTTP
B) SSH ✅
C) DNS
D) HTTPS

---

## 34. Port 23 is:

A) SMTP
B) Telnet ✅
C) POP3
D) FTP

---

## 35. Port 25 is:

A) SMTP ✅
B) FTP
C) SSH
D) DNS

---

## 36. Port 53 is:

A) DNS ✅
B) HTTPS
C) SSH
D) POP3

---

## 37. Port 80 is:

A) HTTPS
B) HTTP ✅
C) DNS
D) SMTP

---

## 38. Port 110 is:

A) POP3 ✅
B) IMAP
C) FTP
D) SSH

---

## 39. Port 143 is:

A) SMTP
B) IMAP ✅
C) FTP
D) DNS

---

## 40. Port 443 is:

A) FTP
B) HTTPS ✅
C) SMTP
D) POP3

---

## 41. Port 3306 is commonly:

A) Oracle
B) PostgreSQL
C) MySQL ✅
D) MSSQL

---

## 42. Nmap is used for:

A) Scanning ✅
B) Encryption
C) Compression
D) Hashing

---

## 43. Open ports increase:

A) Security
B) Attack Surface ✅
C) Encryption
D) Compression

---

## 44. Closed ports typically respond with:

A) SYN
B) ACK
C) RST ✅
D) FIN

---

## 45. Scanning a network for live hosts is:

A) Host Discovery ✅
B) Cracking
C) Spoofing
D) Encryption

---

# Vulnerability Scanning

## 46. Vulnerability scanning identifies:

A) Weaknesses ✅
B) Employees
C) Routers
D) Switches

---

## 47. Nessus is:

A) Vulnerability Scanner ✅
B) Firewall
C) IDS
D) Antivirus

---

## 48. OpenVAS is:

A) IDS
B) Vulnerability Scanner ✅
C) Proxy
D) Router

---

## 49. Qualys is:

A) Vulnerability Assessment Tool ✅
B) Firewall
C) DNS Server
D) SIEM

---

## 50. Missing patches are detected by:

A) Vulnerability Scanning ✅
B) Encryption
C) Routing
D) Compression

---

# Scanning Methodologies

## 51. Host Discovery is performed before:

A) Port Scanning ✅
B) Reporting
C) Exploitation
D) Covering Tracks

---

## 52. OS Detection identifies:

A) Operating System ✅
B) Password
C) MAC Address
D) Session

---

## 53. Service Enumeration identifies:

A) Running Services ✅
B) Passwords
C) Cookies
D) Hashes

---

## 54. Ping Sweep is used for:

A) Host Discovery ✅
B) Encryption
C) Hashing
D) Malware Analysis

---

## 55. Enumeration follows:

A) Scanning ✅
B) Reporting
C) Persistence
D) Cleanup

---

# SYN Scan

## 56. SYN Scan is called:

A) Full Open
B) Half Open Scan ✅
C) ACK Scan
D) UDP Scan

---

## 57. Nmap option for SYN Scan:

A) -sN
B) -sF
C) -sS ✅
D) -sX

---

## 58. SYN Scan sends:

A) SYN Packet ✅
B) ACK Packet
C) FIN Packet
D) URG Packet

---

## 59. Open port response during SYN scan:

A) FIN
B) SYN/ACK ✅
C) RST/ACK
D) URG

---

## 60. Scanner replies with:

A) RST ✅
B) SYN
C) FIN
D) URG

---

# FIN Scan

## 61. Nmap FIN Scan:

A) -sF ✅
B) -sS
C) -sN
D) -sX

---

## 62. FIN Scan sends:

A) FIN Flag ✅
B) SYN Flag
C) ACK Flag
D) URG Flag

---

## 63. Open port in FIN scan:

A) RST
B) No Response ✅
C) SYN/ACK
D) ACK

---

## 64. Closed port in FIN scan:

A) No Response
B) SYN
C) RST ✅
D) FIN

---

# NULL Scan

## 65. NULL Scan option:

A) -sN ✅
B) -sF
C) -sX
D) -sS

---

## 66. NULL Scan uses:

A) FIN Flag
B) SYN Flag
C) No Flags ✅
D) ACK Flag

---

## 67. Open port in NULL Scan:

A) No Response ✅
B) RST
C) ACK
D) SYN

---

## 68. Closed port in NULL Scan:

A) SYN
B) ACK
C) RST ✅
D) URG

---

# XMAS Scan

## 69. XMAS Scan option:

A) -sX ✅
B) -sN
C) -sS
D) -sF

---

## 70. XMAS Scan uses:

A) SYN+ACK
B) FIN+PSH+URG ✅
C) ACK+FIN
D) RST+ACK

---

## 71. Open port response:

A) No Response ✅
B) SYN
C) ACK
D) FIN

---

## 72. Closed port response:

A) SYN
B) RST ✅
C) FIN
D) ACK

---

# IDLE Scan

## 73. IDLE Scan option:

A) -sS
B) -sI ✅
C) -sF
D) -sX

---

## 74. IDLE Scan requires:

A) Zombie Host ✅
B) Proxy
C) VPN
D) Firewall

---

## 75. Main advantage of IDLE Scan:

A) Fastest
B) Hides Attacker IP ✅
C) Cheapest
D) Encrypts Traffic

---

## 76. IDLE Scan is considered:

A) Most Stealthy ✅
B) Most Noisy
C) Slowest
D) Simplest

---

# Security Evaluation Plan

## 77. First step in security evaluation:

A) Scope Definition ✅
B) Exploitation
C) Reporting
D) Enumeration

---

## 78. ROE stands for:

A) Rules of Engagement ✅
B) Routing of Ethernet
C) Record of Events
D) Remote Operations Engine

---

## 79. Asset Identification identifies:

A) Systems and Resources ✅
B) Passwords
C) Cookies
D) Hashes

---

## 80. Threat Modeling identifies:

A) Risks and Attackers ✅
B) Ports
C) Domains
D) Sessions

---

# Mixed Questions

## 81. Shodan is used for:

A) Finding Internet Devices ✅
B) Hashing
C) Encryption
D) Coding

---

## 82. Maltego is:

A) OSINT Tool ✅
B) Firewall
C) IDS
D) Antivirus

---

## 83. Google Dorking is used for:

A) Information Gathering ✅
B) Encryption
C) Hashing
D) Routing

---

## 84. Ethical hackers must:

A) Obtain Authorization ✅
B) Ignore Rules
C) Hide Reports
D) Delete Logs

---

## 85. Internal testing simulates:

A) Insider Threats ✅
B) Internet Users
C) Customers
D) Vendors

---

## 86. External testing is performed:

A) From Outside Network ✅
B) Inside Database
C) Inside Router
D) Inside Firewall

---

## 87. Blind testing means:

A) Little Prior Knowledge ✅
B) No Scan
C) No Permission
D) No Report

---

## 88. Double-blind testing means:

A) Security Team Unaware ✅
B) Hacker Unaware
C) No Tools
D) No Scope

---

## 89. Targeted testing means:

A) Both Sides Know Testing ✅
B) Secret Testing
C) Internal Only
D) External Only

---

## 90. Wireless testing evaluates:

A) Wi-Fi Security ✅
B) Databases
C) Routers Only
D) Printers

---

## 91. Web application testing often checks:

A) SQL Injection ✅
B) Hardware Failure
C) Power Supply
D) BIOS

---

## 92. XSS stands for:

A) Cross Site Scripting ✅
B) Extended Server Scan
C) XML Security Service
D) Cross Server Session

---

## 93. CSRF stands for:

A) Cross Site Request Forgery ✅
B) Client Security Router Framework
C) Common Server Response Function
D) None

---

## 94. Attack surface refers to:

A) Potential Entry Points ✅
B) Router Size
C) Screen Resolution
D) CPU Usage

---

## 95. Enumeration comes after:

A) Scanning ✅
B) Reporting
C) Covering Tracks
D) Cleanup

---

## 96. Ethical hacking aims to:

A) Improve Security ✅
B) Destroy Systems
C) Spread Malware
D) Steal Data

---

## 97. Reconnaissance is also called:

A) Information Gathering ✅
B) Exploitation
C) Reporting
D) Cracking

---

## 98. Vulnerability assessment helps:

A) Discover Weaknesses ✅
B) Create Malware
C) Encrypt Files
D) Delete Logs

---

## 99. The final deliverable of a penetration test is:

A) Report ✅
B) Malware
C) Backdoor
D) Shell

---

## 100. Which scan is most commonly used by ethical hackers?

A) SYN Scan ✅
B) XMAS Scan
C) NULL Scan
D) FIN Scan

---

# Most Important Exam Questions (Must Remember)

1. Ethical Hacker = White Hat
2. Foot-printing = Information Gathering
3. Traceroute uses TTL
4. SYN Scan = Half Open Scan
5. SYN Scan = `-sS`
6. FIN Scan = `-sF`
7. NULL Scan = `-sN`
8. XMAS Scan = `-sX`
9. IDLE Scan = `-sI`
10. IDLE Scan uses Zombie Host
11. XMAS = FIN + PSH + URG
12. NULL = No Flags
13. Port 21 = FTP
14. Port 22 = SSH
15. Port 23 = Telnet
16. Port 25 = SMTP
17. Port 53 = DNS
18. Port 80 = HTTP
19. Port 443 = HTTPS
20. Nessus/OpenVAS/Qualys = Vulnerability Scanners

These 20 points alone typically cover 15–25 marks in university and placement MCQ exams.
