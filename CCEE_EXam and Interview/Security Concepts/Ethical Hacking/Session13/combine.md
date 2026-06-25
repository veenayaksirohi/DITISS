# Trojans, Wrappers, Trojan Construction Kits, Countermeasures, Trojan Evasion & System File Verification

*(Ethical Hacking / Cyber Security Exam Notes)*

---

# 1. Wrapping

## Definition

Wrapping is the process of binding a malicious program (Trojan) with a legitimate application so that both execute together.

When a user runs the legitimate file, the malicious code executes silently in the background.

### Example

A hacker wraps:

* game.exe (legitimate)
* trojan.exe (malicious)

into:

* game_setup.exe

User installs the game and unknowingly installs the Trojan.

---

## How Wrapping Works

### Step 1

Select legitimate application.

### Step 2

Select malicious payload.

### Step 3

Use a wrapper tool.

### Step 4

Generate combined executable.

### Step 5

Victim executes file.

### Step 6

Both programs run.

---

## Wrapping Process

```text
Legitimate Program
        +
Malicious Program
        ↓
     Wrapper
        ↓
 Combined Executable
        ↓
 Victim Executes
        ↓
 Trojan Installed
```

---

## Risks of Wrapping

### Data Theft

Steals files and credentials.

### Remote Access

Attacker gains control.

### Persistence

Trojan survives reboot.

### Malware Delivery

Installs ransomware, spyware, etc.

---

## Detection Methods

* Antivirus
* Digital signature verification
* Hash verification
* Sandboxing
* Behavioral monitoring

---

# 2. Trojan Horse

## Definition

A Trojan Horse is malware disguised as legitimate software.

Unlike viruses, Trojans do not self-replicate.

They trick users into installing them.

---

## Characteristics

| Feature                          | Trojan |
| -------------------------------- | ------ |
| Self-replication                 | No     |
| User interaction required        | Yes    |
| Hidden malicious activity        | Yes    |
| Disguised as legitimate software | Yes    |

---

## Components of Trojan

### Client

Installed on victim system.

### Server

Controlled by attacker.

---

## Trojan Infection Cycle

```text
Delivery
   ↓
Execution
   ↓
Installation
   ↓
Persistence
   ↓
Communication
   ↓
Attack
```

---

# Types of Trojans

---

## 1. Remote Access Trojan (RAT)

Provides complete system control.

Examples:

* DarkComet
* njRAT
* Poison Ivy

Capabilities:

* Webcam access
* File management
* Keylogging
* Screen capture

---

## 2. Banking Trojan

Steals financial data.

Examples:

* Zeus
* Emotet
* TrickBot

---

## 3. Keylogger Trojan

Records keystrokes.

Captures:

* Passwords
* Banking credentials
* Emails

---

## 4. Backdoor Trojan

Creates hidden entry point.

Allows unauthorized access.

---

## 5. Rootkit Trojan

Hides itself from:

* User
* Antivirus
* Operating system

---

## 6. Spyware Trojan

Collects user information.

---

## 7. Downloader Trojan

Downloads additional malware.

---

## 8. DDoS Trojan

Uses infected systems for attacks.

---

# Trojan Construction Kit

## Definition

A Trojan Construction Kit is software used to create Trojans without advanced programming knowledge.

These kits provide graphical interfaces for building malware.

---

## Functions

### Payload Creation

Generate malicious code.

### Configuration

Configure:

* IP address
* Port number
* Persistence

### Encryption

Hide malware signatures.

### Packaging

Create executable files.

---

## Common Features

| Feature       | Purpose            |
| ------------- | ------------------ |
| GUI Builder   | Easy creation      |
| Persistence   | Survive reboot     |
| Keylogger     | Capture keystrokes |
| File Manager  | Access files       |
| Remote Shell  | Execute commands   |
| Webcam Access | Spy on users       |

---

## Ethical Hacking Perspective

Security professionals study Trojan builders to:

* Understand malware behavior
* Improve detection
* Develop defenses

---

# Trojan Makers

## Definition

Trojan Makers are tools that generate Trojans automatically.

They require minimal technical skills.

---

## Capabilities

### Generate Payloads

Creates malware executable.

### Customize Behavior

Set target features.

### Obfuscation

Hide malicious code.

### Encryption

Avoid signature detection.

---

## Risks

* Cybercrime
* Data theft
* Unauthorized access
* Botnet creation

---

# Countermeasure Techniques for Preventing Trojans

---

## 1. Install Antivirus

Use updated antivirus software.

Benefits:

* Signature detection
* Behavioral analysis
* Real-time protection

---

## 2. Update Operating System

Patch vulnerabilities regularly.

---

## 3. Firewall Protection

Blocks unauthorized connections.

---

## 4. Application Whitelisting

Only approved software can run.

---

## 5. Email Security

Avoid:

* Suspicious attachments
* Unknown links

---

## 6. Download Software Carefully

Only from trusted sources.

---

## 7. Least Privilege Principle

Users should not operate with administrator privileges.

---

## 8. Endpoint Detection and Response (EDR)

Detects:

* Malware behavior
* Lateral movement
* Suspicious activities

---

## 9. Security Awareness Training

Educate users about:

* Phishing
* Fake software
* Social engineering

---

## 10. Backup Strategy

Maintain regular backups.

---

# Indicators of Trojan Infection

### Slow Performance

CPU usage increases.

### Unknown Processes

Unexpected applications running.

### High Network Traffic

Suspicious outbound connections.

### Browser Changes

Homepage modifications.

### Disabled Security Software

Antivirus stops working.

---

# Trojan-Evading Techniques

## Definition

Trojan evasion techniques are methods malware uses to avoid detection.

---

## 1. Code Obfuscation

Makes code difficult to analyze.

Example:

```text
Original Code
↓
Obfuscated Code
```

---

## 2. Encryption

Payload encrypted until runtime.

---

## 3. Packing

Compresses executable.

Purpose:

* Change file signature
* Bypass detection

---

## 4. Polymorphism

Changes code structure while maintaining functionality.

Each copy looks different.

---

## 5. Metamorphism

Rewrites entire code.

No fixed signature remains.

---

## 6. Anti-Debugging

Detects debugging tools.

If debugger found:

```text
Exit Program
```

---

## 7. Anti-VM Techniques

Detects virtual machines.

Checks:

* VirtualBox
* VMware
* Hyper-V

---

## 8. Process Injection

Injects code into trusted processes.

Examples:

```text
explorer.exe
svchost.exe
```

---

## 9. Delayed Execution

Sleeps for long periods.

Avoids sandbox detection.

---

## 10. Living Off The Land (LOTL)

Uses legitimate system tools.

Examples:

* PowerShell
* WMI
* Certutil

---

# System File Verification

## Definition

System File Verification ensures critical operating system files have not been modified.

Used to detect:

* Trojans
* Rootkits
* Unauthorized changes

---

# Objectives

### Integrity Verification

Ensure files remain unchanged.

### Malware Detection

Detect infected files.

### Recovery

Restore damaged files.

---

# Verification Methods

---

## 1. Hash Verification

Calculate file hash.

Algorithms:

* MD5
* SHA-1
* SHA-256

Compare with known-good hash.

---

### Example

```text
Original Hash
=
Current Hash

System OK
```

If different:

```text
Possible Tampering
```

---

## 2. Digital Signature Verification

Checks software publisher authenticity.

Ensures:

* Integrity
* Authenticity

---

## 3. File Integrity Monitoring (FIM)

Monitors:

* File changes
* Deletions
* Modifications

Tools:

* Tripwire
* OSSEC

---

## 4. Windows System File Checker

Command:

```cmd
sfc /scannow
```

Purpose:

* Scan protected files
* Replace corrupted files

---

### Process

```text
Scan
 ↓
Verify
 ↓
Repair
```

---

## 5. DISM Tool

Command:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
```

Repairs Windows image corruption.

---

## 6. Linux Verification

Commands:

```bash
rpm -V package
```

```bash
debsums
```

Verify package integrity.

---

# Difference Between Virus and Trojan

| Feature            | Virus      | Trojan       |
| ------------------ | ---------- | ------------ |
| Self-replication   | Yes        | No           |
| Requires host file | Yes        | No           |
| Disguised          | Usually No | Yes          |
| User tricked       | Sometimes  | Usually      |
| Main purpose       | Spread     | Access/Steal |

---

# Exam Important Points (Very Important)

### Trojan

* Disguised as legitimate software.
* Requires user execution.
* Does not self-replicate.

### RAT

* Full remote control.
* Webcam access.
* File management.

### Wrapping

* Combines legitimate file and Trojan.

### Trojan Kit

* Used to generate Trojans.

### Countermeasures

* Antivirus
* Firewall
* Updates
* User awareness

### Evasion Techniques

* Obfuscation
* Packing
* Polymorphism
* Anti-VM
* Anti-debugging

### Verification Tools

Windows:

```cmd
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
```

Linux:

```bash
rpm -V
debsums
```

---

# Quick Memory Tricks

### Trojan Characteristics

**D-H-R-P**

**D** → Disguised
**H** → Hidden actions
**R** → Remote control
**P** → Persistence

---

### Trojan Prevention

**U-F-A-B**

**U** → Update OS
**F** → Firewall
**A** → Antivirus
**B** → Backup

---

### Evasion Techniques

**O-P-P-M-A**

**O** → Obfuscation
**P** → Packing
**P** → Polymorphism
**M** → Metamorphism
**A** → Anti-debugging

---

# 50 Important MCQs

## 1.

A Trojan is:

A. Self-replicating malware
B. Worm
C. Malware disguised as legitimate software
D. Firewall

**Answer: C**

---

## 2.

Which malware provides remote control?

A. RAT
B. Worm
C. Antivirus
D. Proxy

**Answer: A**

---

## 3.

Wrapping combines:

A. Two antivirus programs
B. Legitimate file and malicious file
C. Two operating systems
D. Firewalls

**Answer: B**

---

## 4.

Trojans generally spread through:

A. User execution
B. Self-replication
C. Hardware failure
D. BIOS

**Answer: A**

---

## 5.

Which Trojan records keystrokes?

A. RAT
B. Keylogger Trojan
C. Worm
D. Adware

**Answer: B**

---

## 6.

Which Trojan steals banking credentials?

A. RAT
B. Banking Trojan
C. Worm
D. Spyware

**Answer: B**

---

## 7.

A Trojan Construction Kit is used to:

A. Remove malware
B. Create Trojans
C. Patch systems
D. Encrypt disks

**Answer: B**

---

## 8.

Which tool verifies Windows system files?

A. ping
B. tracert
C. sfc
D. arp

**Answer: C**

---

## 9.

What does SFC stand for?

A. Secure File Copy
B. System File Checker
C. System Firewall Control
D. Security File Configuration

**Answer: B**

---

## 10.

Command to scan Windows protected files?

```cmd
sfc /scannow
```

**Answer: sfc /scannow**

---

## 11.

Packing is mainly used to:

A. Compress and hide malware
B. Remove malware
C. Update Windows
D. Encrypt disks

**Answer: A**

---

## 12.

Polymorphic malware:

A. Changes code appearance
B. Deletes itself
C. Disables CPU
D. Formats disk

**Answer: A**

---

## 13.

Metamorphic malware:

A. Rewrites itself completely
B. Encrypts disks
C. Blocks firewall
D. Changes IP

**Answer: A**

---

## 14.

Anti-debugging detects:

A. Antivirus
B. Debuggers
C. Routers
D. Switches

**Answer: B**

---

## 15.

Anti-VM techniques target:

A. Virtual Machines
B. Routers
C. Firewalls
D. DNS

**Answer: A**

---

## 16.

A Backdoor Trojan primarily:

A. Creates unauthorized access
B. Deletes files
C. Encrypts disks
D. Compresses data

**Answer: A**

---

## 17.

Tripwire is used for:

A. File integrity monitoring
B. Routing
C. VPN
D. DNS

**Answer: A**

---

## 18.

Hash verification checks:

A. File integrity
B. RAM size
C. CPU speed
D. Network speed

**Answer: A**

---

## 19.

Which hash algorithm is stronger?

A. MD5
B. SHA-256
C. CRC
D. XOR

**Answer: B**

---

## 20.

Least privilege means:

A. Give minimum required permissions
B. Give admin rights to everyone
C. Disable accounts
D. Remove passwords

**Answer: A**

---

### Frequently Asked Exam Questions

1. Define Trojan Horse.
2. Explain wrapping with diagram.
3. Describe Trojan Construction Kit.
4. Differentiate Virus and Trojan.
5. Explain Trojan evasion techniques.
6. Explain countermeasures against Trojans.
7. What is System File Verification?
8. Explain SFC and DISM commands.
9. Discuss file integrity monitoring.
10. Explain polymorphic and metamorphic malware.

These are the highest-yield notes typically sufficient for university exams, viva, placements, and ethical hacking theory papers.

# 100 MCQs on Wrapping, Trojans, Trojan Construction Kits, Countermeasures, Trojan Evasion & System File Verification

## 1.

A Trojan Horse is:

A. A firewall
B. A worm
C. Malware disguised as legitimate software
D. An antivirus

**Answer: C**

---

## 2.

A Trojan primarily relies on:

A. Self-replication
B. User interaction
C. BIOS infection
D. Hardware failure

**Answer: B**

---

## 3.

Which malware does NOT self-replicate?

A. Virus
B. Worm
C. Trojan
D. Macro Virus

**Answer: C**

---

## 4.

Wrapping refers to:

A. Compressing files
B. Combining legitimate and malicious programs
C. Encrypting data
D. Creating backups

**Answer: B**

---

## 5.

The purpose of wrapping is to:

A. Improve performance
B. Trick users into executing malware
C. Patch software
D. Remove malware

**Answer: B**

---

## 6.

A wrapped file typically contains:

A. Only malware
B. Only legitimate software
C. Malware and legitimate software
D. Antivirus and malware

**Answer: C**

---

## 7.

A Trojan Construction Kit is used to:

A. Detect Trojans
B. Remove Trojans
C. Create Trojans
D. Encrypt Trojans

**Answer: C**

---

## 8.

A Trojan Construction Kit usually provides:

A. GUI interface
B. Hardware support
C. Routing services
D. DNS resolution

**Answer: A**

---

## 9.

Which Trojan provides remote control of a victim system?

A. Banking Trojan
B. RAT
C. Rootkit
D. Worm

**Answer: B**

---

## 10.

RAT stands for:

A. Remote Administration Tool/Trojan
B. Routing Access Terminal
C. Random Attack Tool
D. Remote Audit Tracker

**Answer: A**

---

## 11.

Which Trojan records keystrokes?

A. Spyware Trojan
B. Banking Trojan
C. Keylogger Trojan
D. RAT

**Answer: C**

---

## 12.

A Banking Trojan is mainly designed to steal:

A. Images
B. Financial credentials
C. Operating systems
D. Source code

**Answer: B**

---

## 13.

Which Trojan secretly collects user information?

A. Spyware Trojan
B. RAT
C. Virus
D. Worm

**Answer: A**

---

## 14.

A Downloader Trojan:

A. Deletes files
B. Downloads additional malware
C. Blocks traffic
D. Encrypts RAM

**Answer: B**

---

## 15.

A Backdoor Trojan is used to:

A. Improve security
B. Create unauthorized access
C. Encrypt files
D. Speed up systems

**Answer: B**

---

## 16.

A DDoS Trojan is commonly used for:

A. File recovery
B. Distributed attacks
C. Antivirus scanning
D. Backups

**Answer: B**

---

## 17.

A Rootkit Trojan mainly focuses on:

A. Data compression
B. Hiding malicious activity
C. Printing documents
D. Updating software

**Answer: B**

---

## 18.

Which Trojan can access webcams remotely?

A. RAT
B. Worm
C. Virus
D. Adware

**Answer: A**

---

## 19.

The client component of a Trojan is usually installed on:

A. Firewall
B. Victim machine
C. Router
D. IDS

**Answer: B**

---

## 20.

The attacker generally controls the:

A. Client
B. Victim OS
C. Server side
D. Router

**Answer: C**

---

# Trojan Construction Kits & Makers

## 21.

Trojan Makers are intended to:

A. Detect malware
B. Generate Trojans automatically
C. Patch systems
D. Encrypt databases

**Answer: B**

---

## 22.

Trojan Makers usually require:

A. Advanced coding skills
B. Hardware programming
C. Minimal technical knowledge
D. Kernel development

**Answer: C**

---

## 23.

A common feature of Trojan builders is:

A. Keylogging
B. Defragmentation
C. Disk partitioning
D. RAID management

**Answer: A**

---

## 24.

A Trojan builder often allows configuration of:

A. CPU speed
B. Port numbers
C. Monitor size
D. RAM slots

**Answer: B**

---

## 25.

Trojan builders commonly provide:

A. Persistence options
B. BIOS updates
C. Router firmware
D. DNS records

**Answer: A**

---

## 26.

The primary security concern of Trojan Makers is:

A. Malware creation
B. Hardware repair
C. Backup management
D. Cloud computing

**Answer: A**

---

## 27.

Trojan Construction Kits help attackers by:

A. Simplifying malware creation
B. Creating firewalls
C. Managing networks
D. Installing patches

**Answer: A**

---

## 28.

A Trojan builder GUI mainly improves:

A. Ease of use
B. CPU speed
C. Memory size
D. Network latency

**Answer: A**

---

## 29.

A common capability of RAT builders is:

A. Webcam control
B. CPU cooling
C. Printer management
D. Disk cloning

**Answer: A**

---

## 30.

Trojan builders frequently include:

A. Obfuscation features
B. Operating systems
C. Hypervisors
D. BIOS firmware

**Answer: A**

---

# Trojan Countermeasures

## 31.

The best first defense against Trojans is:

A. Antivirus software
B. Defragmentation
C. RAID
D. FTP

**Answer: A**

---

## 32.

Regular OS updates help prevent:

A. Exploitation of vulnerabilities
B. CPU overheating
C. Screen flickering
D. RAM failure

**Answer: A**

---

## 33.

Firewalls help by:

A. Blocking unauthorized connections
B. Encrypting hard drives
C. Updating Windows
D. Creating malware

**Answer: A**

---

## 34.

Application whitelisting allows:

A. Any software execution
B. Only approved software execution
C. Anonymous access
D. Port forwarding

**Answer: B**

---

## 35.

A suspicious email attachment should:

A. Be opened immediately
B. Be ignored or verified first
C. Be shared
D. Be executed as admin

**Answer: B**

---

## 36.

The Principle of Least Privilege means:

A. Maximum permissions
B. Minimum required permissions
C. No permissions
D. Guest access only

**Answer: B**

---

## 37.

EDR stands for:

A. Endpoint Detection and Response
B. External Data Routing
C. Encryption Data Recovery
D. Endpoint Domain Resolution

**Answer: A**

---

## 38.

Security awareness training helps defend against:

A. Social engineering
B. RAM failures
C. CPU overheating
D. Printer issues

**Answer: A**

---

## 39.

Downloading software from trusted sources reduces:

A. Trojan infection risk
B. CPU load
C. Disk space
D. RAM usage

**Answer: A**

---

## 40.

Maintaining backups helps recover from:

A. Malware incidents
B. DNS lookups
C. Routing failures
D. Screen damage

**Answer: A**

---

# Trojan Indicators

## 41.

An indicator of Trojan infection is:

A. Slow performance
B. Increased battery life
C. Faster CPU
D. Better graphics

**Answer: A**

---

## 42.

Unexpected outbound traffic may indicate:

A. Malware communication
B. Hardware upgrades
C. RAM optimization
D. Defragmentation

**Answer: A**

---

## 43.

Unknown running processes may suggest:

A. Trojan activity
B. Hardware stability
C. BIOS update
D. RAID creation

**Answer: A**

---

## 44.

A browser homepage changing unexpectedly can indicate:

A. Trojan infection
B. CPU cooling
C. RAM installation
D. OS updates

**Answer: A**

---

## 45.

Security software disabling itself may be caused by:

A. Malware
B. New RAM
C. UPS failure
D. SSD upgrade

**Answer: A**

---

# Trojan Evasion Techniques

## 46.

Code obfuscation aims to:

A. Make analysis difficult
B. Improve speed
C. Reduce storage
D. Increase RAM

**Answer: A**

---

## 47.

Malware encryption primarily helps:

A. Hide signatures
B. Increase bandwidth
C. Improve graphics
D. Increase battery life

**Answer: A**

---

## 48.

Packing malware mainly:

A. Compresses and hides code
B. Repairs files
C. Encrypts disks
D. Deletes logs

**Answer: A**

---

## 49.

Polymorphic malware:

A. Changes appearance while keeping functionality
B. Self-destructs
C. Repairs systems
D. Updates OS

**Answer: A**

---

## 50.

Metamorphic malware:

A. Completely rewrites itself
B. Compresses files
C. Removes antivirus
D. Installs patches

**Answer: A**

---

## 51.

Anti-debugging techniques detect:

A. Debuggers
B. Routers
C. Switches
D. Printers

**Answer: A**

---

## 52.

Anti-VM techniques attempt to detect:

A. Virtual environments
B. Firewalls
C. DNS servers
D. Routers

**Answer: A**

---

## 53.

VMware is an example of:

A. Virtualization platform
B. Antivirus
C. Firewall
D. IDS

**Answer: A**

---

## 54.

VirtualBox is commonly used for:

A. Virtual machines
B. Antivirus scanning
C. Routing
D. Firewalls

**Answer: A**

---

## 55.

Process injection hides malware by:

A. Running inside legitimate processes
B. Rebooting systems
C. Updating BIOS
D. Formatting disks

**Answer: A**

---

## 56.

Delayed execution helps malware avoid:

A. Sandbox detection
B. DNS resolution
C. Compression
D. Routing

**Answer: A**

---

## 57.

LOTL stands for:

A. Living Off The Land
B. Load Over Trusted Links
C. Local Object Transfer Layer
D. Logical Operation Tool List

**Answer: A**

---

## 58.

LOTL attacks use:

A. Legitimate system tools
B. Hardware devices
C. Routers only
D. BIOS only

**Answer: A**

---

## 59.

PowerShell is often abused in:

A. LOTL techniques
B. RAID setups
C. Printing
D. DNS

**Answer: A**

---

## 60.

Certutil is commonly abused for:

A. Living-off-the-land activities
B. Gaming
C. Video editing
D. Routing

**Answer: A**

---

# System File Verification

## 61.

System File Verification checks:

A. File integrity
B. Internet speed
C. Battery health
D. CPU temperature

**Answer: A**

---

## 62.

Hash verification helps detect:

A. File tampering
B. Network routing
C. Disk formatting
D. UPS failures

**Answer: A**

---

## 63.

MD5 is a:

A. Hash algorithm
B. Firewall
C. Trojan
D. Router

**Answer: A**

---

## 64.

SHA-256 is primarily used for:

A. Integrity verification
B. Routing
C. Printing
D. Compression

**Answer: A**

---

## 65.

If a file hash changes unexpectedly, it may indicate:

A. Modification or tampering
B. Hardware upgrade
C. Faster CPU
D. BIOS update

**Answer: A**

---

## 66.

Digital signatures help verify:

A. Authenticity and integrity
B. Screen size
C. RAM speed
D. CPU cores

**Answer: A**

---

## 67.

Tripwire is a:

A. File Integrity Monitoring tool
B. Firewall
C. Router
D. VPN

**Answer: A**

---

## 68.

FIM stands for:

A. File Integrity Monitoring
B. Fast Internet Management
C. Firewall Integrity Module
D. File Inspection Manager

**Answer: A**

---

## 69.

OSSEC is commonly used for:

A. Integrity monitoring
B. Gaming
C. Video editing
D. Printing

**Answer: A**

---

## 70.

Windows System File Checker command is:

A. sfc /scannow
B. ipconfig
C. netstat
D. arp

**Answer: A**

---

## 71.

SFC stands for:

A. System File Checker
B. Secure Firewall Controller
C. System Format Command
D. Service File Control

**Answer: A**

---

## 72.

The SFC utility scans:

A. Protected system files
B. Routers
C. Switches
D. DNS records

**Answer: A**

---

## 73.

DISM stands for:

A. Deployment Image Servicing and Management
B. Digital Internet Security Manager
C. Distributed Integrity Service Monitor
D. Device Integrity Scan Module

**Answer: A**

---

## 74.

DISM is used to:

A. Repair Windows images
B. Create Trojans
C. Configure routers
D. Manage printers

**Answer: A**

---

## 75.

The command to repair Windows image health is:

A. DISM /Online /Cleanup-Image /RestoreHealth
B. ping
C. tracert
D. route

**Answer: A**

---

# True Security Concepts

## 76.

Trojans are usually spread through:

A. Social engineering
B. CPU upgrades
C. BIOS flashing
D. RAM installation

**Answer: A**

---

## 77.

A Trojan can steal:

A. Credentials
B. Financial information
C. Files
D. All of the above

**Answer: D**

---

## 78.

The primary objective of a Banking Trojan is:

A. Financial theft
B. Gaming
C. Printing
D. Routing

**Answer: A**

---

## 79.

Which malware often establishes persistence?

A. Trojan
B. Monitor
C. UPS
D. Switch

**Answer: A**

---

## 80.

Persistence means malware:

A. Survives reboot
B. Deletes itself
C. Crashes system
D. Formats disk

**Answer: A**

---

## 81.

Which technique changes malware signature frequently?

A. Polymorphism
B. Formatting
C. Routing
D. DHCP

**Answer: A**

---

## 82.

Which technique rewrites malware code completely?

A. Metamorphism
B. Compression
C. Routing
D. VLAN

**Answer: A**

---

## 83.

Trojans often communicate with:

A. Command and Control servers
B. Printers
C. Monitors
D. UPS devices

**Answer: A**

---

## 84.

The best way to verify file integrity is:

A. Hash comparison
B. Renaming file
C. Rebooting system
D. Clearing cache

**Answer: A**

---

## 85.

A mismatch in hashes indicates:

A. Possible modification
B. Faster CPU
C. Better performance
D. Disk cleanup

**Answer: A**

---

## 86.

A Trojan disguised as a game is an example of:

A. Social engineering
B. Encryption
C. Routing
D. DHCP

**Answer: A**

---

## 87.

A wrapped executable usually executes:

A. Legitimate and malicious code
B. Only malware
C. Only legitimate code
D. Neither

**Answer: A**

---

## 88.

Which malware category often includes webcam spying?

A. RAT
B. Worm
C. Bootloader
D. Adware

**Answer: A**

---

## 89.

A keylogger mainly captures:

A. Keystrokes
B. Images
C. Videos
D. Packets only

**Answer: A**

---

## 90.

Which is a preventive measure against Trojans?

A. Antivirus updates
B. Ignoring patches
C. Disabling security tools
D. Running unknown files

**Answer: A**

---

## 91.

The strongest hash among these is:

A. MD5
B. SHA-1
C. SHA-256
D. CRC32

**Answer: C**

---

## 92.

Application whitelisting works by:

A. Allowing approved applications only
B. Allowing everything
C. Blocking OS updates
D. Blocking backups

**Answer: A**

---

## 93.

Which command verifies Linux RPM package integrity?

A. rpm -V
B. ping
C. netstat
D. route

**Answer: A**

---

## 94.

Which utility verifies Debian package integrity?

A. debsums
B. nslookup
C. arp
D. ssh

**Answer: A**

---

## 95.

Which malware often hides from antivirus tools?

A. Rootkit Trojan
B. Printer Driver
C. DNS Cache
D. DHCP Server

**Answer: A**

---

## 96.

Which security control helps detect unauthorized file changes?

A. File Integrity Monitoring
B. DHCP
C. NAT
D. VLAN

**Answer: A**

---

## 97.

Which technique makes malware analysis harder?

A. Obfuscation
B. Defragmentation
C. Partitioning
D. Compression only

**Answer: A**

---

## 98.

A Trojan usually gains entry through:

A. User execution
B. Self-replication
C. BIOS infection only
D. CPU overheating

**Answer: A**

---

## 99.

Which is NOT a Trojan type?

A. RAT
B. Banking Trojan
C. Keylogger Trojan
D. Router Trojan Protocol

**Answer: D**

---

## 100.

The primary goal of System File Verification is:

A. Detect unauthorized changes to system files
B. Increase CPU speed
C. Increase RAM capacity
D. Improve graphics performance

**Answer: A**

---

# Most Important Exam MCQs (Frequently Repeated)

1. Trojan vs Virus
2. Wrapping definition
3. RAT full form
4. Trojan Construction Kit purpose
5. Polymorphic vs Metamorphic malware
6. Anti-Debugging
7. Anti-VM techniques
8. Process Injection
9. SFC full form
10. `sfc /scannow`
11. DISM purpose
12. File Integrity Monitoring (FIM)
13. Tripwire
14. Hash Verification
15. Digital Signature Verification
16. Principle of Least Privilege
17. Application Whitelisting
18. Banking Trojan
19. Keylogger Trojan
20. Backdoor Trojan

These 20 questions alone commonly cover **40–50% of university/end-semester cyber security theory exams** on this unit.
