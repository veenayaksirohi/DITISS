# Malware Security Notes (Complete Exam-Oriented Notes)

---

# 1. Introduction to Malware

## What is Malware?

**Malware (Malicious Software)** is any software intentionally designed to damage, disrupt, steal information, gain unauthorized access, or perform malicious activities on a computer, network, or device.

### Objectives of Malware

* Steal sensitive information
* Gain unauthorized access
* Disrupt operations
* Encrypt files for ransom
* Spy on users
* Create botnets
* Destroy data
* Spread to other systems

---

# Malware Life Cycle

```text
Development
      ↓
Delivery
      ↓
Execution
      ↓
Persistence
      ↓
Communication (C2)
      ↓
Payload Execution
      ↓
Cleanup/Evasion
```

---

# 2. Types of Malware

---

## 2.1 Virus

A virus is malware that attaches itself to legitimate files and requires user action to spread.

### Characteristics

* Requires host file
* Self-replicates
* Needs execution by user

### Types

### File Infector Virus

Infects executable files.

Example:

```text
.exe
.com
.dll
```

### Boot Sector Virus

Infects boot records.

Example:

```text
Stoned Virus
Michelangelo
```

### Macro Virus

Uses application macros.

Example:

```text
Word Documents
Excel Files
```

### Multipartite Virus

Infects both files and boot sectors.

---

## 2.2 Worm

A worm is self-replicating malware that spreads automatically across networks.

### Features

* No host file needed
* Uses network vulnerabilities
* Spreads rapidly

Examples:

* Morris Worm
* SQL Slammer
* Conficker
* WannaCry

---

## 2.3 Trojan Horse

A Trojan appears legitimate but performs malicious actions.

### Characteristics

* Does not self-replicate
* Tricks users
* Creates backdoors

Examples:

* Zeus
* Emotet
* TrickBot

### Types

| Type              | Function                   |
| ----------------- | -------------------------- |
| Banking Trojan    | Steals banking credentials |
| Backdoor Trojan   | Remote access              |
| Downloader Trojan | Downloads malware          |
| Spy Trojan        | Monitoring                 |

---

## 2.4 Ransomware

Encrypts files and demands payment.

### Working

```text
Infection
↓
Encryption
↓
Ransom Note
↓
Payment Demand
```

### Types

#### Crypto Ransomware

Encrypts files.

Example:

* WannaCry
* Locky

#### Locker Ransomware

Locks system access.

Example:

* Reveton

---

## 2.5 Spyware

Secretly monitors users.

### Activities

* Capture keystrokes
* Monitor browsing
* Steal credentials

Examples

* Pegasus
* CoolWebSearch

---

## 2.6 Keylogger

Records keyboard inputs.

### Types

#### Software Keylogger

Installed program.

#### Hardware Keylogger

Physical device.

---

## 2.7 Adware

Displays unwanted advertisements.

### Effects

* Popups
* Browser redirects
* Tracking users

---

## 2.8 Rootkit

Hides malware from detection.

### Types

| Type        | Description       |
| ----------- | ----------------- |
| User Mode   | Application level |
| Kernel Mode | OS kernel level   |
| Firmware    | BIOS/UEFI         |
| Bootkit     | Boot process      |

Examples

* ZeroAccess
* Necurs

---

## 2.9 Bot

Infected system controlled remotely.

### Botnet

Collection of bots.

Examples

* Mirai
* GameOver Zeus

---

## 2.10 Logic Bomb

Executes when specific condition is met.

Example

```text
Date Trigger
Employee Termination
Specific Event
```

---

## 2.11 Fileless Malware

Operates in memory.

### Features

* Uses PowerShell
* Uses WMI
* Difficult detection

Examples

* Kovter
* Poweliks

---

## 2.12 Cryptojacking Malware

Uses victim resources to mine cryptocurrency.

Examples

* CoinMiner
* Smominru

---

# 3. Malicious Code Families

---

## What is a Malware Family?

A group of malware variants sharing common code, behavior, or origin.

---

# Major Malware Families

---

## 3.1 Zeus Family

Purpose:

* Banking credential theft

Features:

* Keylogging
* Form grabbing

---

## 3.2 Emotet Family

Originally banking Trojan.

Now:

* Malware distributor
* Spam campaigns

---

## 3.3 TrickBot Family

Capabilities:

* Credential theft
* Lateral movement
* Ransomware delivery

---

## 3.4 WannaCry Family

Type:

* Ransomware Worm

Uses:

* EternalBlue exploit

Impact:

* Global outbreak (2017)

---

## 3.5 Mirai Family

Targets:

* IoT Devices

Examples:

```text
Cameras
Routers
DVRs
```

Creates DDoS botnets.

---

## 3.6 Stuxnet Family

Target:

* Industrial Control Systems (ICS)

Features:

* PLC manipulation
* Nation-state malware

---

## 3.7 Pegasus Family

Type:

* Mobile spyware

Features:

* Surveillance
* Remote access

---

## 3.8 Conficker Family

Uses Windows vulnerabilities.

Features:

* Self propagation
* Botnet creation

---

## 3.9 LockBit Family

Modern ransomware.

Features:

* Double extortion
* Data theft

---

# Malware Family Classification

| Family    | Category       |
| --------- | -------------- |
| Zeus      | Banking Trojan |
| Emotet    | Trojan         |
| TrickBot  | Banking Trojan |
| WannaCry  | Ransomware     |
| Mirai     | Botnet         |
| Stuxnet   | Worm           |
| Pegasus   | Spyware        |
| Conficker | Worm           |
| LockBit   | Ransomware     |

---

# 4. Latest Trends in Malware

---

## 4.1 AI-Powered Malware

Uses Artificial Intelligence for:

* Better phishing
* Adaptive attacks
* Automated evasion

---

## 4.2 Fileless Malware Growth

Uses:

* PowerShell
* WMI
* Memory execution

Advantages:

* Difficult detection

---

## 4.3 Ransomware-as-a-Service (RaaS)

Cybercriminals rent ransomware.

Examples:

* LockBit
* BlackCat

---

## 4.4 Double Extortion

```text
Encrypt Data
+
Steal Data
```

Victims pay to:

* Recover files
* Prevent data leaks

---

## 4.5 Triple Extortion

```text
Encrypt
+
Steal
+
DDoS Attack
```

---

## 4.6 IoT Malware

Targets:

* Smart cameras
* Routers
* Smart TVs

Example:

* Mirai Variants

---

## 4.7 Mobile Malware

Targets:

* Android
* iOS

Methods:

* Fake Apps
* SMS malware
* Banking Trojans

---

## 4.8 Supply Chain Attacks

Compromises trusted software vendors.

Examples:

* SolarWinds
* 3CX Incident

---

## 4.9 Cloud Malware

Targets:

* AWS
* Azure
* Google Cloud

Objectives:

* Data theft
* Cryptomining

---

## 4.10 Living Off The Land (LotL)

Uses legitimate tools.

Examples:

```text
PowerShell
WMIC
PsExec
CertUtil
```

---

# 5. Malware Analysis

Malware analysis is the process of understanding malware behavior and functionality.

---

# Goals

* Determine functionality
* Identify indicators
* Develop detection rules
* Incident response

---

# Types of Malware Analysis

---

## 5.1 Static Analysis

Analyzing malware without execution.

### Methods

#### File Hashing

Algorithms:

* MD5
* SHA1
* SHA256

#### String Analysis

Extract strings:

```bash
strings malware.exe
```

#### Header Analysis

Examine:

* PE Header
* ELF Header

#### Signature Analysis

Compare with known malware.

### Advantages

* Safe
* Quick

### Disadvantages

* Obfuscation resistant

---

## 5.2 Dynamic Analysis

Executing malware in controlled environment.

### Tools

* VirtualBox
* VMware

### Observe

* Processes
* Registry changes
* File creation
* Network traffic

### Advantages

* Real behavior

### Disadvantages

* Risky

---

## 5.3 Hybrid Analysis

Combines:

```text
Static
+
Dynamic
```

Most effective approach.

---

## 5.4 Behavioral Analysis

Focuses on:

* Activities
* Indicators
* Persistence

---

# Malware Analysis Environment

---

## Sandbox

Isolated environment.

Examples:

* Cuckoo Sandbox
* Any.Run

---

## Virtual Machine

Examples:

* VMware
* VirtualBox

---

## Snapshot

Restore clean state after infection.

---

# Malware Analysis Tools

| Tool             | Purpose             |
| ---------------- | ------------------- |
| VirusTotal       | Malware lookup      |
| PEStudio         | Static analysis     |
| Process Monitor  | Activity monitoring |
| Process Explorer | Process analysis    |
| Wireshark        | Network traffic     |
| IDA Pro          | Reverse engineering |
| Ghidra           | Reverse engineering |
| x64dbg           | Debugging           |
| Cuckoo Sandbox   | Dynamic analysis    |
| Any.Run          | Online sandbox      |

---

# Malware Indicators of Compromise (IOC)

Examples:

### File Indicators

```text
Unknown EXE
DLL Files
```

### Network Indicators

```text
Suspicious IP
Domain Names
URLs
```

### Registry Indicators

```text
Run Keys
Startup Entries
```

### Process Indicators

```text
Unknown Process
Hidden Process
```

---

# Malware Detection Methods

## Signature-Based

Uses known signatures.

Example:

* Antivirus

---

## Heuristic-Based

Detects suspicious behavior.

---

## Behavior-Based

Monitors actions.

---

## AI/ML-Based

Uses machine learning.

---

# Malware Prevention

### User Awareness

* Avoid unknown links
* Verify attachments

### Patch Management

* Update systems regularly

### Endpoint Protection

* Antivirus
* EDR

### Least Privilege

* Restrict permissions

### Backup Strategy

* Offline backups

### Network Segmentation

* Limit spread

---

# Important Exam Points (Very Important)

### Virus vs Worm

| Virus                | Worm             |
| -------------------- | ---------------- |
| Needs host file      | Independent      |
| User action required | Automatic spread |
| Slower               | Faster           |

---

### Trojan vs Virus

| Trojan             | Virus            |
| ------------------ | ---------------- |
| Does not replicate | Replicates       |
| Disguised software | Attached to file |

---

### Static vs Dynamic Analysis

| Static       | Dynamic            |
| ------------ | ------------------ |
| No execution | Execution required |
| Safe         | Risky              |
| Fast         | Detailed           |

---

### Rootkit

**Purpose = Hide malware**

---

### Botnet

**Collection of infected systems controlled by attacker**

---

### Ransomware

**Encrypts files and demands ransom**

---

# Quick Revision Sheet (1-Minute Before Exam)

```text
Virus = Host dependent

Worm = Self spreading

Trojan = Fake software

Spyware = Monitoring

Adware = Advertisements

Rootkit = Hiding malware

Bot = Remote control

Ransomware = Encrypt files

Fileless Malware = Memory based

Mirai = IoT Botnet

Zeus = Banking Trojan

WannaCry = Ransomware Worm

Pegasus = Spyware

Stuxnet = ICS Malware

Static Analysis = No execution

Dynamic Analysis = Execute malware

Hybrid Analysis = Both methods

IOC = Indicator of Compromise

C2 = Command & Control
```

# 50 Important MCQs

### 1. Malware stands for?

A) Managed Software
B) Malicious Software ✅
C) Main Software
D) Machine Software

### 2. Which malware self-replicates without a host?

A) Trojan
B) Worm ✅
C) Rootkit
D) Spyware

### 3. Which malware hides itself?

A) Virus
B) Worm
C) Rootkit ✅
D) Adware

### 4. WannaCry is a?

A) Spyware
B) Adware
C) Ransomware ✅
D) Rootkit

### 5. Mirai primarily targets?

A) Databases
B) Mobile Apps
C) IoT Devices ✅
D) Browsers

### 6. Zeus is known as?

A) Worm
B) Banking Trojan ✅
C) Spyware
D) Rootkit

### 7. Static analysis means?

A) Execute malware
B) Analyze without execution ✅
C) Network scan
D) Patch system

### 8. Which tool captures packets?

A) PEStudio
B) Wireshark ✅
C) Ghidra
D) VirusTotal

### 9. Botnet consists of?

A) Antivirus
B) Firewalls
C) Controlled infected machines ✅
D) Routers

### 10. C2 stands for?

A) Command and Control ✅
B) Connect and Create
C) Client and Controller
D) Command Chain

### 11–50 (Rapid Fire)

11. Pegasus → Spyware ✅
12. Stuxnet targeted ICS/SCADA ✅
13. Emotet started as Banking Trojan ✅
14. LockBit → Ransomware ✅
15. Keylogger records keystrokes ✅
16. Adware shows ads ✅
17. Fileless malware runs in memory ✅
18. VirusTotal checks malware reputation ✅
19. SHA256 is a hashing algorithm ✅
20. PE Header belongs to Windows executable ✅
21. Dynamic analysis executes malware ✅
22. Cuckoo is a sandbox ✅
23. Any.Run is malware analysis platform ✅
24. EternalBlue exploited SMB ✅
25. Worm spreads through networks ✅
26. Trojan disguises as legitimate software ✅
27. IOC means Indicator of Compromise ✅
28. Registry Run Keys provide persistence ✅
29. Double extortion includes data theft ✅
30. Triple extortion may include DDoS ✅
31. RaaS = Ransomware as a Service ✅
32. Cryptojacking mines cryptocurrency ✅
33. Conficker is a worm ✅
34. Mirai forms botnets ✅
35. Rootkit can operate in kernel mode ✅
36. Macro virus infects Office documents ✅
37. Boot sector virus targets MBR ✅
38. Ghidra is reverse engineering tool ✅
39. IDA Pro is disassembler ✅
40. x64dbg is debugger ✅
41. MD5 produces hash value ✅
42. Least privilege reduces malware impact ✅
43. Backups help against ransomware ✅
44. EDR means Endpoint Detection and Response ✅
45. Behavioral analysis studies actions ✅
46. Signature detection uses known patterns ✅
47. Heuristic detection uses suspicious behavior ✅
48. AI malware adapts attacks ✅
49. Supply chain attacks target trusted vendors ✅
50. SolarWinds is a supply-chain attack example ✅

---

# Exam Trick

Remember:

**"VWTRSARB"**

* **V** → Virus
* **W** → Worm
* **T** → Trojan
* **R** → Ransomware
* **S** → Spyware
* **A** → Adware
* **R** → Rootkit
* **B** → Bot

This covers the most frequently asked malware types in cybersecurity and penetration testing examinations.


# 100 MCQs on Malware (Exam-Oriented)

## Types of Malware

### 1. Malware stands for:

A) Managed Software
B) Malicious Software ✅
C) Main Software
D) Monitoring Software

### 2. Which malware requires a host file to spread?

A) Worm
B) Virus ✅
C) Bot
D) Spyware

### 3. Which malware spreads automatically over networks?

A) Virus
B) Trojan
C) Worm ✅
D) Adware

### 4. Which malware disguises itself as legitimate software?

A) Worm
B) Trojan ✅
C) Rootkit
D) Virus

### 5. Which malware encrypts files and demands payment?

A) Adware
B) Spyware
C) Ransomware ✅
D) Worm

### 6. Which malware records keystrokes?

A) Keylogger ✅
B) Adware
C) Worm
D) Virus

### 7. Spyware is mainly used to:

A) Encrypt files
B) Monitor users ✅
C) Display ads
D) Delete OS

### 8. Adware primarily:

A) Steals passwords
B) Displays unwanted advertisements ✅
C) Encrypts data
D) Creates botnets

### 9. Rootkits are designed to:

A) Show advertisements
B) Hide malicious activities ✅
C) Patch systems
D) Backup data

### 10. A bot is:

A) Antivirus
B) Controlled infected device ✅
C) Firewall
D) Router

---

## Virus and Worms

### 11. A boot sector virus infects:

A) RAM
B) MBR/Boot Record ✅
C) Browser
D) Registry

### 12. Macro viruses commonly infect:

A) PDFs
B) Office Documents ✅
C) Videos
D) Images

### 13. Multipartite viruses infect:

A) Only files
B) Only boot sector
C) Files and boot sector ✅
D) Registry only

### 14. The first major Internet worm was:

A) WannaCry
B) Zeus
C) Morris Worm ✅
D) Conficker

### 15. SQL Slammer is a:

A) Trojan
B) Worm ✅
C) Rootkit
D) Spyware

### 16. Worms differ from viruses because worms:

A) Need host files
B) Self-propagate independently ✅
C) Need user action
D) Cannot spread

### 17. Conficker is a:

A) Worm ✅
B) Trojan
C) Virus
D) Adware

### 18. WannaCry combined:

A) Virus + Adware
B) Worm + Ransomware ✅
C) Spyware + Bot
D) Trojan + Rootkit

### 19. Which malware spreads fastest?

A) Worm ✅
B) Trojan
C) Adware
D) Spyware

### 20. Virus replication generally requires:

A) User interaction ✅
B) Botnet
C) Firewall
D) Antivirus

---

## Trojan and Spyware

### 21. Zeus is known as:

A) Worm
B) Banking Trojan ✅
C) Rootkit
D) Virus

### 22. Emotet originally started as:

A) Spyware
B) Banking Trojan ✅
C) Virus
D) Adware

### 23. TrickBot is mainly:

A) Banking Trojan ✅
B) Worm
C) Rootkit
D) Virus

### 24. A backdoor Trojan allows:

A) Encryption
B) Unauthorized remote access ✅
C) Backup
D) Compression

### 25. Pegasus is:

A) Worm
B) Spyware ✅
C) Virus
D) Adware

### 26. Form grabbing is associated with:

A) Zeus Trojan ✅
B) Mirai
C) Conficker
D) Stuxnet

### 27. Trojan malware usually:

A) Self-replicates
B) Disguises itself as useful software ✅
C) Spreads through MBR
D) Encrypts boot sector

### 28. Downloader Trojans:

A) Download additional malware ✅
B) Encrypt data
C) Delete logs
D) Disable routers

### 29. Banking Trojans target:

A) Games
B) Banking credentials ✅
C) Images
D) Printers

### 30. Spyware's main objective:

A) Data collection ✅
B) Encryption
C) DDoS
D) Patching

---

## Ransomware

### 31. Which is a ransomware family?

A) LockBit ✅
B) Mirai
C) Zeus
D) Conficker

### 32. Crypto ransomware:

A) Displays ads
B) Encrypts files ✅
C) Hides processes
D) Mines cryptocurrency

### 33. Locker ransomware:

A) Encrypts files
B) Locks user access ✅
C) Creates botnets
D) Spreads worms

### 34. Double extortion means:

A) Two viruses
B) Encrypting and stealing data ✅
C) Two victims
D) Two attackers

### 35. Triple extortion may involve:

A) DDoS attacks ✅
B) Firewalls
C) VPNs
D) Antivirus

### 36. RaaS stands for:

A) Remote Access as Service
B) Ransomware as a Service ✅
C) Rootkit as Service
D) Registry as Service

### 37. WannaCry used:

A) EternalBlue exploit ✅
B) SQL Injection
C) XSS
D) CSRF

### 38. Offline backups help against:

A) Rootkits
B) Ransomware ✅
C) Adware
D) Worms

### 39. LockBit belongs to:

A) Spyware
B) Ransomware ✅
C) Virus
D) Worm

### 40. The primary goal of ransomware:

A) Financial gain ✅
B) Advertisement
C) Monitoring
D) Compression

---

## Rootkits, Bots and Botnets

### 41. Rootkits are dangerous because they:

A) Hide malware ✅
B) Encrypt files
C) Create backups
D) Update systems

### 42. Kernel rootkits operate:

A) User mode
B) Kernel level ✅
C) Browser level
D) Network level

### 43. Firmware rootkits infect:

A) BIOS/UEFI ✅
B) Browser
C) RAM only
D) DNS

### 44. Botnets consist of:

A) Firewalls
B) Controlled infected systems ✅
C) Routers
D) Antivirus

### 45. Mirai targeted:

A) Databases
B) IoT devices ✅
C) Mobile phones only
D) Browsers

### 46. Botnets are commonly used for:

A) DDoS attacks ✅
B) Patching
C) Logging
D) Compression

### 47. Command and Control is abbreviated as:

A) C&C ✅
B) C2P
C) D2D
D) P2P

### 48. A zombie computer is:

A) Dormant PC
B) Bot-controlled system ✅
C) Virtual machine
D) Server

### 49. Mirai primarily infected:

A) Smart devices ✅
B) Databases
C) Desktops only
D) Firewalls

### 50. Rootkits mainly assist:

A) Stealth and persistence ✅
B) Compression
C) Updating
D) Backup

---

## Malware Families

### 51. Stuxnet targeted:

A) Social media
B) Industrial Control Systems ✅
C) Browsers
D) Email

### 52. Zeus belongs to:

A) Banking Trojan ✅
B) Worm
C) Virus
D) Botnet

### 53. Emotet became famous for:

A) Malware distribution ✅
B) Encryption
C) Rootkits
D) Mining

### 54. Pegasus is:

A) Mobile spyware ✅
B) Worm
C) Virus
D) Adware

### 55. LockBit is:

A) Botnet
B) Ransomware ✅
C) Rootkit
D) Worm

### 56. TrickBot performs:

A) Credential theft ✅
B) Printing
C) Backup
D) Compression

### 57. Mirai creates:

A) Botnets ✅
B) Firewalls
C) Databases
D) VPNs

### 58. Stuxnet is considered:

A) Nation-state malware ✅
B) Adware
C) Browser hijacker
D) Macro virus

### 59. Conficker exploited:

A) Windows vulnerabilities ✅
B) SQL only
C) Linux only
D) DNS

### 60. WannaCry emerged in:

A) 2017 ✅
B) 2010
C) 2020
D) 2005

---

## Malware Analysis

### 61. Static analysis means:

A) Running malware
B) Studying without execution ✅
C) Network scanning
D) OS installation

### 62. Dynamic analysis involves:

A) Executing malware safely ✅
B) Reading documentation
C) Coding
D) Updating systems

### 63. Hybrid analysis combines:

A) Static and Dynamic analysis ✅
B) Antivirus and Firewall
C) IDS and IPS
D) VPN and Proxy

### 64. Which tool extracts readable strings?

A) strings ✅
B) ping
C) whois
D) netcat

### 65. SHA256 is:

A) Hash algorithm ✅
B) Encryption algorithm
C) Trojan
D) Worm

### 66. VirusTotal is used for:

A) Malware reputation checks ✅
B) Coding
C) Networking
D) Routing

### 67. PEStudio is mainly used for:

A) Static analysis ✅
B) Dynamic routing
C) Packet capture
D) DDoS

### 68. Wireshark analyzes:

A) Network traffic ✅
B) Registry
C) BIOS
D) Boot sector

### 69. Process Monitor monitors:

A) System activity ✅
B) Routing
C) DNS
D) Email

### 70. Ghidra is:

A) Reverse engineering tool ✅
B) Firewall
C) Proxy
D) IDS

---

## Malware Analysis Tools

### 71. IDA Pro is:

A) Disassembler ✅
B) Browser
C) Antivirus
D) Proxy

### 72. x64dbg is:

A) Debugger ✅
B) Firewall
C) Router
D) Proxy

### 73. Cuckoo Sandbox is used for:

A) Malware analysis ✅
B) Email
C) Backup
D) DNS

### 74. Any.Run is:

A) Online sandbox ✅
B) Firewall
C) Database
D) VPN

### 75. VMware is useful for:

A) Virtualized malware analysis ✅
B) Routing
C) DNS
D) Coding

### 76. VirtualBox is:

A) Virtual machine software ✅
B) Antivirus
C) Trojan
D) Worm

### 77. Snapshots help:

A) Restore clean state ✅
B) Encrypt files
C) Hide malware
D) Patch OS

### 78. Dynamic analysis reveals:

A) Actual behavior ✅
B) Source code only
C) Passwords only
D) Hashes only

### 79. Static analysis is:

A) Safer than dynamic analysis ✅
B) More dangerous
C) Impossible
D) Slower

### 80. Reverse engineering helps:

A) Understand malware code ✅
B) Encrypt files
C) Patch routers
D) Backup servers

---

## Latest Trends and Defense

### 81. Fileless malware primarily runs:

A) In memory ✅
B) In BIOS
C) In printers
D) In USB

### 82. Kovter is an example of:

A) Fileless malware ✅
B) Virus
C) Worm
D) Adware

### 83. Living-off-the-Land attacks use:

A) Legitimate system tools ✅
B) Worms only
C) Trojans only
D) Viruses only

### 84. PowerShell is often abused in:

A) Fileless attacks ✅
B) DNS attacks
C) ARP attacks
D) FTP attacks

### 85. Cryptojacking is:

A) Unauthorized cryptocurrency mining ✅
B) Encryption
C) Rootkit
D) DDoS

### 86. AI-powered malware may:

A) Improve evasion techniques ✅
B) Patch systems
C) Increase backups
D) Improve antivirus

### 87. Supply chain attacks compromise:

A) Trusted vendors/software ✅
B) Routers only
C) Databases only
D) Browsers only

### 88. SolarWinds incident is an example of:

A) Supply chain attack ✅
B) Worm
C) Virus
D) Adware

### 89. Cloud malware targets:

A) Cloud infrastructure ✅
B) Printers
C) BIOS only
D) USB only

### 90. IoT malware targets:

A) Smart devices ✅
B) Desktops only
C) Mainframes only
D) BIOS only

---

## Miscellaneous

### 91. IOC stands for:

A) Indicator of Compromise ✅
B) Internet Operating Center
C) Internal Operating Code
D) Input Output Control

### 92. Registry Run keys are often used for:

A) Persistence ✅
B) Encryption
C) Compression
D) Routing

### 93. Signature-based detection relies on:

A) Known patterns ✅
B) User behavior
C) AI only
D) DNS

### 94. Heuristic detection uses:

A) Suspicious characteristics ✅
B) Exact signatures only
C) Encryption
D) Compression

### 95. Behavior-based detection focuses on:

A) Malware actions ✅
B) File size
C) Filename
D) Extension

### 96. Least privilege helps:

A) Reduce malware impact ✅
B) Increase malware
C) Disable security
D) Spread worms

### 97. EDR stands for:

A) Endpoint Detection and Response ✅
B) Encryption Data Recovery
C) External Device Registry
D) Event Data Routing

### 98. Network segmentation helps:

A) Limit malware spread ✅
B) Increase attacks
C) Disable antivirus
D) Increase botnets

### 99. Patch management reduces:

A) Vulnerability exploitation ✅
B) Storage
C) CPU usage
D) RAM

### 100. The best malware defense strategy is:

A) Layered security (Defense in Depth) ✅
B) Antivirus only
C) Firewall only
D) Password only

---

# High-Frequency Exam Questions (Must Memorize)

1. Virus → Host dependent
2. Worm → Self-spreading
3. Trojan → Disguised software
4. Spyware → Monitoring
5. Rootkit → Hides malware
6. Botnet → Collection of bots
7. Zeus → Banking Trojan
8. Mirai → IoT Botnet
9. Pegasus → Spyware
10. Stuxnet → ICS Malware
11. WannaCry → Ransomware Worm
12. LockBit → Ransomware
13. Static Analysis → No execution
14. Dynamic Analysis → Execute malware
15. IOC → Indicator of Compromise
16. C2 → Command & Control
17. RaaS → Ransomware as a Service
18. EternalBlue → SMB exploit
19. Ghidra → Reverse Engineering
20. Wireshark → Packet Analysis

These 20 facts alone typically cover a large portion of malware-related university, CEH, Security+, and placement-test MCQs.
