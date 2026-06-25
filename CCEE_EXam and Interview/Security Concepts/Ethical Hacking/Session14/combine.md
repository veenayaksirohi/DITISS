# Computer Viruses & Worms – Complete Notes for Exams, Placements, and Cyber Security

---

# 1. Introduction to Malware

**Malware (Malicious Software)** is any software designed to damage, disrupt, steal data, or gain unauthorized access to systems.

Common malware types:

| Malware    | Purpose                                        |
| ---------- | ---------------------------------------------- |
| Virus      | Infect files and spread through user action    |
| Worm       | Self-replicates across networks                |
| Trojan     | Disguised as legitimate software               |
| Ransomware | Encrypts files and demands payment             |
| Spyware    | Steals information                             |
| Rootkit    | Hides malicious activity                       |
| Adware     | Displays unwanted advertisements               |
| Bot        | Turns device into a remotely controlled zombie |

---

# 2. What is a Virus?

A **Computer Virus** is malicious code that attaches itself to a legitimate program or file and spreads when the infected file is executed.

### Characteristics

✔ Requires host file/program

✔ Needs human action to spread

✔ Replicates by infecting files

✔ Can corrupt or delete data

### Working of a Virus

1. Infection
2. Replication
3. Activation
4. Payload execution

Example:

```
Infected File → User Opens File
                     ↓
             Virus Executes
                     ↓
          Infects Other Files
```

---

# 3. What is a Worm?

A **Worm** is standalone malware that spreads automatically without needing a host file.

### Characteristics

✔ Self-replicating

✔ No user interaction required

✔ Uses network vulnerabilities

✔ Spreads rapidly

### Working

```
System A infected
       ↓
Scans Network
       ↓
Finds Vulnerable Systems
       ↓
Infects System B, C, D...
```

---

# 4. Virus vs Worm

| Feature              | Virus             | Worm                    |
| -------------------- | ----------------- | ----------------------- |
| Host File Needed     | Yes               | No                      |
| User Action Required | Yes               | Usually No              |
| Self Replication     | Limited           | Automatic               |
| Network Spread       | Slow              | Very Fast               |
| Infection Method     | Files & Programs  | Network Vulnerabilities |
| Resource Consumption | Moderate          | High                    |
| Example              | CIH, Michelangelo | Morris Worm, WannaCry   |

---

# 5. Difference Between Virus, Worm and Trojan

| Feature                         | Virus     | Worm         | Trojan       |
| ------------------------------- | --------- | ------------ | ------------ |
| Self Replicating                | Yes       | Yes          | No           |
| Host File                       | Required  | Not Required | Not Required |
| User Action                     | Required  | Not Required | Required     |
| Disguised as Legitimate Program | Sometimes | No           | Yes          |

---

# 6. Types of Viruses

---

## A. Boot Sector Virus

Infects Master Boot Record (MBR).

### Target

* Hard Disk
* USB Drive
* Boot Sector

### Example

Michelangelo Virus

### Symptoms

* Boot failure
* System crashes

---

## B. File Infector Virus

Attaches itself to executable files.

### Target

```
.exe
.com
.dll
```

### Example

Jerusalem Virus

---

## C. Macro Virus

Written using application macros.

### Target

* Word Documents
* Excel Files

### Example

Melissa Virus

---

## D. Multipartite Virus

Infects:

* Boot sector
* Files

Simultaneously.

Difficult to remove.

---

## E. Resident Virus

Loads into memory.

Remains active even after infected file closes.

### Example

CMJ Virus

---

## F. Non-Resident Virus

Acts immediately and exits.

### Process

```
Find Files
Infect Files
Exit
```

---

## G. Polymorphic Virus

Changes its code every infection.

Purpose:

Avoid antivirus detection.

### Characteristics

* Encryption
* Mutation Engine
* Different Signature

---

## H. Metamorphic Virus

Rewrites its entire code.

### Characteristics

* No fixed signature
* Extremely difficult to detect

---

## I. Stealth Virus

Hides infection by intercepting system calls.

### Example

Shows clean file size even when infected.

---

## J. Overwriting Virus

Overwrites file contents.

Data usually lost permanently.

---

## K. Companion Virus

Creates malicious file with same name as legitimate program.

Example:

```
notepad.exe
notepad.com
```

OS executes malicious file first.

---

## L. Spacefiller Virus (Cavity Virus)

Inserts itself into unused portions of files.

Advantages:

* File size unchanged
* Harder detection

---

# 7. Famous Virus Examples

| Virus         | Year | Impact                  |
| ------------- | ---- | ----------------------- |
| Brain         | 1986 | First PC Virus          |
| Michelangelo  | 1992 | Boot Sector Damage      |
| Melissa       | 1999 | Email Spread            |
| CIH/Chernobyl | 1998 | BIOS Corruption         |
| ILOVEYOU      | 2000 | Massive Email Infection |

---

# 8. Famous Worm Examples

| Worm        | Year | Impact                 |
| ----------- | ---- | ---------------------- |
| Morris Worm | 1988 | Internet Congestion    |
| Code Red    | 2001 | Web Server Attacks     |
| SQL Slammer | 2003 | Massive Traffic        |
| Conficker   | 2008 | Millions Infected      |
| WannaCry    | 2017 | Global Ransomware Worm |

---

# 9. Antivirus

An Antivirus is software designed to:

* Detect
* Prevent
* Quarantine
* Remove Malware

Examples:

* Microsoft Defender
* Norton Antivirus
* McAfee
* Kaspersky
* Bitdefender

---

# 10. Antivirus Evasion Techniques

Attackers use various methods to avoid detection.

---

## A. Code Obfuscation

Makes code difficult to analyze.

Methods:

* Renaming variables
* Junk instructions
* Encryption

---

## B. Polymorphism

Virus changes appearance every infection.

```
Virus A
↓
Mutated Virus A1
↓
Mutated Virus A2
```

Signature changes.

---

## C. Metamorphism

Entire code rewritten.

Same functionality.

Different structure.

Hardest to detect.

---

## D. Packing

Malware compressed or encrypted.

Examples:

* UPX
* ASPack

Antivirus cannot easily inspect content.

---

## E. Encryption

Virus encrypts malicious payload.

Only decrypts during execution.

---

## F. Anti-Debugging

Detects debugger presence.

Techniques:

* IsDebuggerPresent()
* Timing checks

---

## G. Anti-VM Techniques

Detects:

* VMware
* VirtualBox
* Sandbox

Purpose:

Avoid malware analysis.

---

## H. Rootkit Techniques

Hides:

* Processes
* Files
* Registry entries

---

## I. Process Injection

Injects malicious code into legitimate process.

Example:

```
explorer.exe
svchost.exe
```

Appears legitimate.

---

## J. Fileless Malware

Operates in memory.

Uses:

* PowerShell
* WMI

Leaves little evidence on disk.

---

## K. Living Off The Land (LOTL)

Uses legitimate tools:

* PowerShell
* cmd
* WMIC

Hard to distinguish from normal activity.

---

# 11. Virus Detection Methods

---

## A. Signature-Based Detection

Most common method.

### Working

```
Known Virus Signature
         ↓
Compare with Files
         ↓
Match Found = Virus
```

### Advantages

* Fast
* Accurate

### Disadvantages

* Cannot detect unknown malware

---

## B. Heuristic Detection

Analyzes suspicious code patterns.

Example:

* Self-modifying code
* File overwrite attempts

### Advantage

Detects unknown threats.

### Disadvantage

False positives possible.

---

## C. Behavioral Detection

Monitors activities.

Examples:

* Registry modification
* Mass file encryption
* Process injection

---

## D. Anomaly Detection

Detects deviations from normal behavior.

Example:

```
Normal Traffic = 10 MB
Current Traffic = 500 MB
```

Alert generated.

---

## E. Sandboxing

Executes file in isolated environment.

Observes behavior safely.

---

## F. Integrity Checking

Checks whether files have changed.

Uses:

* Hashes
* Checksums

Example:

```
SHA256
MD5
```

---

## G. Cloud-Based Detection

File hashes uploaded to cloud database.

Advantages:

* Fast updates
* Real-time intelligence

---

## H. AI / Machine Learning Detection

Analyzes:

* Behavior
* Patterns
* Features

Can identify previously unseen malware.

---

# 12. Virus Life Cycle

### Stage 1: Dormant

Inactive.

### Stage 2: Propagation

Spreads to new systems.

### Stage 3: Triggering

Activation condition met.

### Stage 4: Execution

Payload delivered.

---

# 13. Symptoms of Virus Infection

### Performance Issues

* Slow computer
* High CPU usage

### System Problems

* Frequent crashes
* Blue Screen Errors

### File Issues

* Missing files
* Corrupted documents

### Network Indicators

* Unusual traffic
* Unknown connections

---

# 14. Prevention Techniques

### User Side

✔ Avoid suspicious downloads

✔ Use licensed software

✔ Update OS regularly

✔ Use strong passwords

✔ Enable firewall

✔ Backup data

✔ Scan USB devices

✔ Avoid unknown email attachments

---

# 15. Important Exam Comparison

| Virus             | Worm              |
| ----------------- | ----------------- |
| Requires Host     | No Host Required  |
| Needs User Action | Automatic Spread  |
| File Infection    | Network Infection |
| Slower            | Faster            |
| Local Spread      | Global Spread     |

---

# Exam Tips

### Remember

**Virus = Victim opens something**

**Worm = Works itself**

---

### Quick Memory Trick

**VIRUS**

V → Victim action needed

I → Infects files

R → Replicates

U → Uses host file

S → Spreads slowly

---

### Quick Memory Trick

**WORM**

W → Works automatically

O → Over network

R → Rapid spread

M → Multiple systems

---

# Frequently Asked MCQs

### 1. A virus requires ______ to spread.

A. Network only

B. Host file

C. Router

D. Firewall

✅ Answer: B

---

### 2. Which malware spreads without user interaction?

A. Trojan

B. Virus

C. Worm

D. Spyware

✅ Answer: C

---

### 3. Which virus changes its code on every infection?

A. Boot Virus

B. Macro Virus

C. Polymorphic Virus

D. Companion Virus

✅ Answer: C

---

### 4. Which malware infects Word documents?

A. Macro Virus

B. Worm

C. Rootkit

D. Spyware

✅ Answer: A

---

### 5. Signature-based detection cannot detect:

A. Known Virus

B. Existing Malware

C. New Unknown Malware

D. Old Malware

✅ Answer: C

---

### 6. Which virus infects MBR?

A. Macro Virus

B. Boot Sector Virus

C. Worm

D. Trojan

✅ Answer: B

---

### 7. Which detection method observes actual program behavior?

A. Signature

B. Behavioral

C. Static

D. Hash

✅ Answer: B

---

### 8. WannaCry is primarily known as a:

A. Trojan

B. Worm-based ransomware

C. Macro Virus

D. Rootkit

✅ Answer: B

---

### 9. Which technique hides malware inside legitimate processes?

A. Sandboxing

B. Process Injection

C. Hashing

D. Signature Matching

✅ Answer: B

---

### 10. Which virus rewrites its entire code?

A. Stealth

B. Resident

C. Metamorphic

D. Macro

✅ Answer: C

---

# Last-Minute Revision (2 Marks)

✔ Virus requires host file.

✔ Worm does not require host file.

✔ Polymorphic = changes signature.

✔ Metamorphic = rewrites code.

✔ Signature detection → known malware.

✔ Heuristic detection → suspicious patterns.

✔ Behavioral detection → monitors actions.

✔ Sandbox → isolated execution.

✔ Boot Virus infects MBR.

✔ Macro Virus infects Office documents.

✔ WannaCry = worm-based ransomware.

✔ Morris Worm = first major Internet worm.


# Virus, Worm, Antivirus Evasion & Detection Methods – 100 MCQs

## 1. A computer virus is a type of:

A. Hardware
B. Malware
C. Firewall
D. Protocol

✅ Answer: B

---

## 2. A virus generally requires a ______ to spread.

A. Host file
B. Router
C. Switch
D. Firewall

✅ Answer: A

---

## 3. Which malware can spread without user intervention?

A. Virus
B. Worm
C. Trojan
D. Adware

✅ Answer: B

---

## 4. A worm primarily spreads through:

A. USB only
B. Email only
C. Network vulnerabilities
D. Printers only

✅ Answer: C

---

## 5. Which malware is self-replicating?

A. Virus
B. Worm
C. Both A and B
D. Trojan

✅ Answer: C

---

## 6. Which malware requires a host program?

A. Virus
B. Worm
C. Spyware
D. Rootkit

✅ Answer: A

---

## 7. Which malware does NOT require a host file?

A. Virus
B. Worm
C. Macro Virus
D. Boot Virus

✅ Answer: B

---

## 8. A virus usually spreads when:

A. File is executed
B. System is shut down
C. Monitor is turned on
D. Keyboard is disconnected

✅ Answer: A

---

## 9. Which malware often causes network congestion?

A. Worm
B. Adware
C. Cookie
D. Firewall

✅ Answer: A

---

## 10. The first widely known PC virus was:

A. Brain
B. Morris
C. Melissa
D. Slammer

✅ Answer: A

---

# Types of Viruses

## 11. A Boot Sector Virus infects:

A. RAM
B. BIOS only
C. Master Boot Record
D. Cache Memory

✅ Answer: C

---

## 12. Which virus infects executable files?

A. File Infector Virus
B. Macro Virus
C. Worm
D. Rootkit

✅ Answer: A

---

## 13. Macro viruses commonly infect:

A. PDFs
B. Office Documents
C. BIOS
D. Drivers

✅ Answer: B

---

## 14. Melissa is an example of:

A. Macro Virus
B. Worm
C. Trojan
D. Spyware

✅ Answer: A

---

## 15. Multipartite viruses infect:

A. Only RAM
B. Boot sector and files
C. Network cables
D. Browsers

✅ Answer: B

---

## 16. Resident viruses stay in:

A. CPU
B. Hard Disk only
C. Memory
D. Router

✅ Answer: C

---

## 17. Non-resident viruses:

A. Stay in memory continuously
B. Infect and exit
C. Encrypt disks
D. Create users

✅ Answer: B

---

## 18. Which virus changes its code to avoid detection?

A. Boot Virus
B. Macro Virus
C. Polymorphic Virus
D. Resident Virus

✅ Answer: C

---

## 19. Which virus rewrites its own code completely?

A. Stealth Virus
B. Metamorphic Virus
C. Macro Virus
D. Resident Virus

✅ Answer: B

---

## 20. A Stealth Virus attempts to:

A. Increase speed
B. Hide infection
C. Format disk
D. Upgrade OS

✅ Answer: B

---

## 21. Which virus overwrites file contents?

A. Overwriting Virus
B. Worm
C. Trojan
D. Spyware

✅ Answer: A

---

## 22. Companion viruses create:

A. Duplicate hardware
B. Fake companion files
C. Firewalls
D. VPNs

✅ Answer: B

---

## 23. A Cavity Virus is also called:

A. Worm Virus
B. Spacefiller Virus
C. Macro Virus
D. Script Virus

✅ Answer: B

---

## 24. Which virus does not increase file size significantly?

A. Spacefiller Virus
B. Worm
C. Trojan
D. Spyware

✅ Answer: A

---

## 25. Michelangelo is a:

A. Boot Sector Virus
B. Worm
C. Trojan
D. Spyware

✅ Answer: A

---

# Worms

## 26. Morris Worm appeared in:

A. 1978
B. 1988
C. 1998
D. 2008

✅ Answer: B

---

## 27. Code Red is a:

A. Worm
B. Firewall
C. Browser
D. Antivirus

✅ Answer: A

---

## 28. SQL Slammer targeted:

A. SQL Servers
B. Linux Kernels
C. Routers
D. Switches

✅ Answer: A

---

## 29. Conficker is:

A. Worm
B. Browser
C. Protocol
D. Driver

✅ Answer: A

---

## 30. WannaCry spread primarily as:

A. Boot Virus
B. Worm-based ransomware
C. Macro Virus
D. Trojan

✅ Answer: B

---

# Antivirus

## 31. Antivirus software is used to:

A. Create viruses
B. Detect malware
C. Damage files
D. Disable security

✅ Answer: B

---

## 32. Which is an antivirus?

A. FTP
B. Norton
C. SMTP
D. DHCP

✅ Answer: B

---

## 33. Which is an antivirus?

A. Bitdefender
B. Telnet
C. ICMP
D. SNMP

✅ Answer: A

---

## 34. Microsoft Defender is:

A. Antivirus
B. Worm
C. Trojan
D. Virus

✅ Answer: A

---

## 35. Antivirus primarily helps:

A. Detect malware
B. Increase CPU speed
C. Upgrade RAM
D. Format disks

✅ Answer: A

---

# Antivirus Evasion Techniques

## 36. Obfuscation means:

A. Code hiding/modification
B. Backup creation
C. File deletion
D. Encryption removal

✅ Answer: A

---

## 37. Polymorphic malware changes:

A. Hardware
B. Signature/code appearance
C. Monitor settings
D. BIOS version

✅ Answer: B

---

## 38. Metamorphic malware:

A. Rewrites itself completely
B. Stops replication
C. Deletes RAM
D. Installs antivirus

✅ Answer: A

---

## 39. Packing is used to:

A. Compress/Hide malware
B. Remove malware
C. Encrypt passwords only
D. Create backups

✅ Answer: A

---

## 40. UPX is a:

A. Network protocol
B. Packer
C. Firewall
D. Virus

✅ Answer: B

---

## 41. Malware encryption is used to:

A. Avoid detection
B. Improve graphics
C. Upgrade CPU
D. Increase storage

✅ Answer: A

---

## 42. Anti-debugging techniques detect:

A. Antivirus updates
B. Debuggers
C. Routers
D. Printers

✅ Answer: B

---

## 43. Anti-VM techniques target:

A. Virtual Machines
B. Hard Drives
C. Firewalls
D. Switches

✅ Answer: A

---

## 44. Rootkits primarily:

A. Hide malicious activity
B. Encrypt disks
C. Repair files
D. Backup data

✅ Answer: A

---

## 45. Process Injection means:

A. Injecting code into legitimate processes
B. Installing software
C. Updating OS
D. Formatting disk

✅ Answer: A

---

## 46. Fileless malware operates mainly in:

A. RAM
B. HDD only
C. SSD only
D. BIOS only

✅ Answer: A

---

## 47. PowerShell is often abused by:

A. Fileless Malware
B. Antivirus
C. Firewall
D. Switches

✅ Answer: A

---

## 48. LOTL stands for:

A. Living Off The Land
B. Loss Of Traffic Link
C. Layer Of Transport Logic
D. None

✅ Answer: A

---

## 49. LOTL attacks use:

A. Legitimate system tools
B. Physical cables
C. Hardware devices
D. Routers only

✅ Answer: A

---

## 50. Which technique makes malware analysis harder?

A. Obfuscation
B. Updating OS
C. Disk Cleanup
D. Backup

✅ Answer: A

---

# Virus Detection Methods

## 51. Signature-based detection relies on:

A. Known patterns
B. Guessing
C. Passwords
D. Routing tables

✅ Answer: A

---

## 52. Signature detection is best for:

A. Known malware
B. Unknown malware only
C. Hardware faults
D. Printer issues

✅ Answer: A

---

## 53. Signature-based detection struggles against:

A. Known viruses
B. New malware
C. Old malware
D. Macro viruses

✅ Answer: B

---

## 54. Heuristic detection looks for:

A. Suspicious behavior/code
B. IP addresses only
C. MAC addresses only
D. BIOS settings

✅ Answer: A

---

## 55. Heuristic detection may produce:

A. False Positives
B. False Routers
C. False Switches
D. False DNS

✅ Answer: A

---

## 56. Behavioral detection monitors:

A. Actions performed by programs
B. Hardware only
C. Monitor brightness
D. Keyboard speed

✅ Answer: A

---

## 57. Sandboxing executes files in:

A. Isolated environment
B. Production server
C. BIOS
D. Router

✅ Answer: A

---

## 58. Integrity checking commonly uses:

A. Hashes
B. Printers
C. Routers
D. Hubs

✅ Answer: A

---

## 59. SHA-256 is a:

A. Hash Function
B. Virus
C. Worm
D. Firewall

✅ Answer: A

---

## 60. MD5 is primarily used for:

A. Integrity Checking
B. Routing
C. DNS Resolution
D. Compression

✅ Answer: A

---

## 61. AI-based detection can identify:

A. Unknown malware patterns
B. Hardware failures only
C. Monitors only
D. Routers only

✅ Answer: A

---

## 62. Cloud-based detection relies on:

A. Cloud databases
B. CPUs
C. GPUs
D. Monitors

✅ Answer: A

---

## 63. Anomaly detection identifies:

A. Deviations from normal behavior
B. Monitor issues
C. Keyboard issues
D. Printer faults

✅ Answer: A

---

## 64. Which detection method watches runtime activity?

A. Behavioral Detection
B. Signature Detection
C. Manual Detection
D. Physical Detection

✅ Answer: A

---

## 65. Sandboxing is useful against:

A. Unknown malware
B. Printers
C. Routers
D. Switches

✅ Answer: A

---

# Mixed Questions

## 66. Virus + Worm = ?

A. Malware Types
B. Protocols
C. Databases
D. Firewalls

✅ Answer: A

---

## 67. Malware that hides itself:

A. Rootkit
B. DHCP
C. DNS
D. SMTP

✅ Answer: A

---

## 68. Malware disguised as legitimate software:

A. Trojan
B. Worm
C. Virus
D. Spyware

✅ Answer: A

---

## 69. Spyware is used to:

A. Gather information secretly
B. Improve performance
C. Backup files
D. Encrypt disks

✅ Answer: A

---

## 70. Ransomware primarily:

A. Encrypts files
B. Repairs files
C. Creates users
D. Deletes logs only

✅ Answer: A

---

## 71. Which spreads fastest?

A. Worm
B. Boot Virus
C. Macro Virus
D. Companion Virus

✅ Answer: A

---

## 72. Worms primarily exploit:

A. Network vulnerabilities
B. Keyboards
C. Monitors
D. Printers

✅ Answer: A

---

## 73. Virus lifecycle starts with:

A. Infection
B. Formatting
C. Backup
D. Routing

✅ Answer: A

---

## 74. Dormant phase means:

A. Inactive state
B. Active attack
C. Encryption
D. Deletion

✅ Answer: A

---

## 75. Trigger phase occurs when:

A. Activation condition is met
B. RAM fails
C. Disk is removed
D. Keyboard disconnects

✅ Answer: A

---

## 76. Payload execution is:

A. Final attack stage
B. First stage
C. Backup stage
D. Recovery stage

✅ Answer: A

---

## 77. Slow computer performance may indicate:

A. Malware Infection
B. Better security
C. More RAM
D. Faster CPU

✅ Answer: A

---

## 78. Unexpected network traffic can indicate:

A. Malware
B. Monitor failure
C. Keyboard issue
D. Mouse issue

✅ Answer: A

---

## 79. Frequent crashes may result from:

A. Virus Infection
B. Updated OS
C. Firewall
D. DNS

✅ Answer: A

---

## 80. Corrupted files can be caused by:

A. Viruses
B. Routers
C. Switches
D. DNS

✅ Answer: A

---

## 81. Which malware may hide registry entries?

A. Rootkit
B. DHCP
C. ARP
D. DNS

✅ Answer: A

---

## 82. Which malware often remains memory-resident?

A. Resident Virus
B. Macro Virus
C. Companion Virus
D. Boot Virus

✅ Answer: A

---

## 83. A virus that infects Office documents is:

A. Macro Virus
B. Worm
C. Trojan
D. Rootkit

✅ Answer: A

---

## 84. A boot sector virus targets:

A. Startup process
B. Browser cache
C. DNS server
D. Firewall

✅ Answer: A

---

## 85. Which malware uses mutation engines?

A. Polymorphic Virus
B. Boot Virus
C. Worm
D. Spyware

✅ Answer: A

---

## 86. Which malware can evade signature detection effectively?

A. Metamorphic Virus
B. Basic Virus
C. Macro Virus
D. Boot Virus

✅ Answer: A

---

## 87. Which technique checks file modification?

A. Integrity Checking
B. Routing
C. Fragmentation
D. Partitioning

✅ Answer: A

---

## 88. SHA-256 is stronger than:

A. MD5
B. RAM
C. BIOS
D. FTP

✅ Answer: A

---

## 89. Which malware hides in unused file spaces?

A. Spacefiller Virus
B. Worm
C. Trojan
D. Rootkit

✅ Answer: A

---

## 90. Which virus type attempts to conceal its presence?

A. Stealth Virus
B. Macro Virus
C. Boot Virus
D. Worm

✅ Answer: A

---

## 91. Antivirus updates mainly provide:

A. New signatures
B. RAM
C. CPU cores
D. Storage

✅ Answer: A

---

## 92. Which is NOT a virus type?

A. Worm
B. Macro Virus
C. Boot Virus
D. Polymorphic Virus

✅ Answer: A

---

## 93. Which malware spreads most rapidly over networks?

A. Worm
B. Boot Virus
C. Macro Virus
D. Companion Virus

✅ Answer: A

---

## 94. Malware running entirely in memory is:

A. Fileless Malware
B. Boot Virus
C. Macro Virus
D. Worm

✅ Answer: A

---

## 95. Which method is proactive against unknown threats?

A. Heuristic Detection
B. Signature Detection
C. Manual Detection
D. None

✅ Answer: A

---

## 96. Which malware can create botnets?

A. Worm
B. Malware in general
C. Both A and B
D. None

✅ Answer: C

---

## 97. Which malware commonly spreads through email attachments?

A. Macro Virus
B. DHCP
C. ARP
D. ICMP

✅ Answer: A

---

## 98. WannaCry exploited:

A. Network vulnerability
B. Keyboard
C. BIOS battery
D. Monitor cable

✅ Answer: A

---

## 99. Which malware category includes Virus, Worm, and Trojan?

A. Malware
B. Hardware
C. Firmware
D. Middleware

✅ Answer: A

---

## 100. Which statement is correct?

A. Virus needs a host file

B. Worm does not need a host file

C. Worm spreads automatically

D. All of the above

✅ Answer: D

---

# Most Important Exam MCQs (Repeated Frequently)

1. Virus requires → **Host File**
2. Worm spreads → **Automatically**
3. Melissa → **Macro Virus**
4. Michelangelo → **Boot Sector Virus**
5. Morris → **Worm**
6. WannaCry → **Worm-based Ransomware**
7. Polymorphic → **Changes Signature**
8. Metamorphic → **Rewrites Code**
9. Signature Detection → **Known Malware**
10. Heuristic Detection → **Unknown Malware**
11. Sandbox → **Isolated Environment**
12. Rootkit → **Hides Malware**
13. Fileless Malware → **Runs in Memory**
14. UPX → **Packer**
15. SHA-256 → **Integrity Checking / Hashing**
