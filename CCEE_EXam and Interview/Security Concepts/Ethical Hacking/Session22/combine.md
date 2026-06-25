# Android Debug Bridge (ADB) & Penetration Testing Tools – Complete Notes

---

# Unit 1: Android Debug Bridge (ADB)

## Introduction

**Android Debug Bridge (ADB)** is a command-line utility included in the Android SDK Platform Tools that allows communication between a computer and an Android device.

ADB is mainly used by:

* Android Developers
* Mobile Security Testers
* Ethical Hackers
* System Administrators
* Mobile Forensic Investigators

ADB allows users to:

* Install applications
* Remove applications
* Access device shell
* Transfer files
* Debug applications
* Capture logs
* Test Android security

---

# Architecture of ADB

ADB follows a Client-Server Architecture.

### Components

### 1. ADB Client

Command issued by user.

Example:

```bash
adb devices
adb shell
```

---

### 2. ADB Server

Runs on computer.

Default Port:

```text
5037
```

Responsibilities:

* Manages communication
* Detects connected devices
* Handles requests

---

### 3. ADB Daemon (adbd)

Runs on Android Device.

Responsibilities:

* Receives commands
* Executes commands
* Sends output back

---

# Working of ADB

```text
User
 ↓
ADB Client
 ↓
ADB Server
 ↓
ADB Daemon (adbd)
 ↓
Android Device
```

---

# Requirements for ADB

## Enable Developer Options

Settings

```text
About Phone
↓
Tap Build Number 7 Times
```

---

## Enable USB Debugging

```text
Settings
↓
Developer Options
↓
USB Debugging
```

---

# Installing ADB

Download:

```text
Android SDK Platform Tools
```

Verify installation:

```bash
adb version
```

---

# Common ADB Commands

---

## Check Connected Devices

```bash
adb devices
```

Output:

```text
List of devices attached
123456 device
```

---

## Start ADB Server

```bash
adb start-server
```

---

## Stop ADB Server

```bash
adb kill-server
```

---

## Restart Server

```bash
adb restart-server
```

---

## Open Device Shell

```bash
adb shell
```

Linux-like terminal access.

---

## Get Device Information

```bash
adb shell getprop
```

---

## Device Model

```bash
adb shell getprop ro.product.model
```

---

## Android Version

```bash
adb shell getprop ro.build.version.release
```

---

## List Installed Packages

```bash
adb shell pm list packages
```

---

## Install APK

```bash
adb install app.apk
```

---

## Reinstall APK

```bash
adb install -r app.apk
```

---

## Uninstall Application

```bash
adb uninstall com.example.app
```

---

## Pull File from Device

```bash
adb pull /sdcard/file.txt
```

---

## Push File to Device

```bash
adb push file.txt /sdcard/
```

---

## Reboot Device

```bash
adb reboot
```

---

## Reboot Bootloader

```bash
adb reboot bootloader
```

---

## Screenshot Capture

```bash
adb shell screencap /sdcard/screen.png
```

---

## Screen Recording

```bash
adb shell screenrecord /sdcard/video.mp4
```

---

# Logcat

Used for log monitoring.

Command:

```bash
adb logcat
```

Shows:

* System Logs
* App Logs
* Crash Reports
* Debug Information

---

## Save Logs

```bash
adb logcat > logs.txt
```

---

# Port Forwarding

Used during penetration testing.

```bash
adb forward tcp:5555 tcp:5555
```

---

# Wireless ADB

Connect over network.

```bash
adb tcpip 5555
adb connect IP:5555
```

Example:

```bash
adb connect 192.168.1.10:5555
```

---

# ADB in Security Testing

Used for:

### Application Testing

```bash
adb install vulnerable.apk
```

---

### Data Extraction

```bash
adb pull
```

---

### Log Monitoring

```bash
adb logcat
```

---

### Backup Analysis

```bash
adb backup
```

---

### Permission Analysis

```bash
adb shell dumpsys package
```

---

# Risks of ADB

### Unauthorized Access

If USB debugging enabled.

---

### Data Theft

Attacker may:

```bash
adb pull
```

Extract files.

---

### Malware Installation

```bash
adb install malware.apk
```

---

### Root Access Abuse

Rooted phones become more vulnerable.

---

# ADB Security Best Practices

✔ Disable USB debugging when not needed

✔ Authorize trusted PCs only

✔ Use screen lock

✔ Keep device updated

✔ Disable Wireless ADB after use

✔ Revoke USB debugging authorizations

---

# Important ADB Commands for Exams

| Command       | Purpose            |
| ------------- | ------------------ |
| adb devices   | List devices       |
| adb shell     | Open shell         |
| adb install   | Install APK        |
| adb uninstall | Remove APK         |
| adb push      | Copy to device     |
| adb pull      | Copy from device   |
| adb logcat    | View logs          |
| adb reboot    | Restart device     |
| adb backup    | Backup device      |
| adb connect   | Network connection |

---

# Unit 2: Penetration Testing Tools

---

# What is Penetration Testing?

Authorized attack simulation to identify vulnerabilities before attackers exploit them.

Goals:

* Identify vulnerabilities
* Assess risk
* Verify security controls
* Improve security posture

---

# Penetration Testing Phases

## 1. Reconnaissance

Information gathering.

---

## 2. Scanning

Identify:

* Ports
* Services
* Operating Systems

---

## 3. Vulnerability Assessment

Find weaknesses.

---

## 4. Exploitation

Attempt exploitation.

---

## 5. Post Exploitation

Privilege escalation.

---

## 6. Reporting

Document findings.

---

# Categories of Penetration Testing Tools

| Category         | Purpose                 |
| ---------------- | ----------------------- |
| Reconnaissance   | Information gathering   |
| Scanning         | Port/service discovery  |
| Exploitation     | Exploit vulnerabilities |
| Password Attacks | Credential testing      |
| Web Testing      | Web app security        |
| Wireless Testing | WiFi security           |
| Mobile Testing   | Android/iOS security    |
| Forensics        | Evidence collection     |

---

# Important Penetration Testing Tools

---

# 1. Nmap

(Network Mapper)

Purpose:

* Port Scanning
* Service Detection
* OS Detection

Example:

```bash
nmap 192.168.1.1
```

---

### Features

* TCP Scan
* UDP Scan
* NSE Scripts
* OS Fingerprinting

---

# 2. Wireshark

Packet Analyzer.

Captures:

* HTTP
* DNS
* FTP
* TCP
* UDP

Example Filters:

```text
tcp.port==80
http.request
dns
```

---

# 3. Metasploit Framework

Most popular exploitation framework.

Components:

* Exploits
* Payloads
* Encoders
* Auxiliary Modules

Start:

```bash
msfconsole
```

---

### Uses

* Exploitation
* Post Exploitation
* Privilege Escalation

---

# 4. Burp Suite

Web Application Testing Tool.

Functions:

* Intercept Requests
* Modify Requests
* Repeater
* Intruder
* Scanner

---

# 5. SQLmap

Automates SQL Injection testing.

Example:

```bash
sqlmap -u URL
```

---

### Capabilities

* Database Enumeration
* Data Extraction
* Password Hash Dumping

---

# 6. Nikto

Web Vulnerability Scanner.

Example:

```bash
nikto -h target.com
```

Finds:

* Dangerous Files
* Misconfigurations
* Outdated Software

---

# 7. OWASP ZAP

Open-source web testing tool.

Features:

* Spider
* Active Scan
* Passive Scan

---

# 8. Hydra

Password Testing Tool.

Protocols:

* SSH
* FTP
* HTTP
* RDP

Example:

```bash
hydra -l admin -P pass.txt ssh://target
```

---

# 9. John the Ripper

Password Cracker.

Example:

```bash
john hashes.txt
```

---

# 10. Aircrack-ng

Wireless Security Testing.

Functions:

* Packet Capture
* WPA Testing
* WEP Testing

---

# 11. Gobuster

Directory Discovery Tool.

Example:

```bash
gobuster dir -u URL -w wordlist.txt
```

---

# 12. Dirb

Directory Bruteforce Tool.

Example:

```bash
dirb http://target
```

---

# 13. FFUF

Fast Web Fuzzer.

Example:

```bash
ffuf -u http://target/FUZZ -w wordlist.txt
```

---

# 14. MobSF

Mobile Security Framework.

Used for:

* Android Testing
* iOS Testing
* APK Analysis

---

# 15. Apktool

Android reverse engineering.

Example:

```bash
apktool d app.apk
```

---

# Tool Selection Table

| Tool        | Category              |
| ----------- | --------------------- |
| Nmap        | Scanning              |
| Wireshark   | Packet Analysis       |
| Metasploit  | Exploitation          |
| Burp Suite  | Web Testing           |
| SQLmap      | SQL Injection         |
| Nikto       | Vulnerability Scanner |
| OWASP ZAP   | Web Security          |
| Hydra       | Password Testing      |
| John        | Password Cracking     |
| Aircrack-ng | Wireless Testing      |
| MobSF       | Mobile Security       |
| Apktool     | Android Analysis      |

---

# Exam Tips

### Remember

ADB Architecture:

```text
Client
↓
Server
↓
Daemon
```

---

Metasploit Components:

```text
Exploit
Payload
Encoder
Auxiliary
```

---

Pen Testing Phases:

```text
Recon
Scanning
Assessment
Exploitation
Post Exploitation
Reporting
```

---

# Frequently Asked Viva Questions

### What is ADB?

Android Debug Bridge is a command-line tool used to communicate with Android devices.

---

### What port does ADB Server use?

```text
5037
```

---

### Which command lists devices?

```bash
adb devices
```

---

### What is Logcat?

Android logging system accessed via:

```bash
adb logcat
```

---

### What is Metasploit?

Framework used for vulnerability exploitation and security testing.

---

### What is Nmap?

Network scanning and enumeration tool.

---

### What is Burp Suite used for?

Web application penetration testing.

---

### What is SQLmap?

Automated SQL Injection testing tool.

---

# 30 Important MCQs

### 1. ADB stands for:

A) Android Data Backup
✅ B) Android Debug Bridge
C) Android Device Bridge
D) Android Database Bridge

---

### 2. Default ADB server port is:

A) 80
B) 443
✅ C) 5037
D) 3306

---

### 3. Command to list devices:

A) adb list
✅ B) adb devices
C) adb show
D) adb connect

---

### 4. Which component runs on Android device?

A) Client
B) Server
✅ C) adbd
D) SDK

---

### 5. Tool used for packet analysis:

A) Hydra
B) Nmap
✅ C) Wireshark
D) SQLmap

---

### 6. Metasploit is mainly used for:

✅ A) Exploitation
B) Coding
C) Logging
D) Encryption

---

### 7. Burp Suite is used for:

✅ A) Web Security Testing
B) WiFi Testing
C) Mobile Charging
D) Database Backup

---

### 8. SQLmap detects:

A) XSS
✅ B) SQL Injection
C) CSRF
D) SSRF

---

### 9. Hydra performs:

✅ A) Password Attacks
B) Packet Capture
C) Encryption
D) Logging

---

### 10. MobSF is used for:

✅ A) Mobile Security Testing
B) Wireless Testing
C) Routing
D) DNS Analysis

---

### 11-30 Quick Answers

11. Nmap → Port Scanning ✅
12. Nikto → Web Vulnerability Scanner ✅
13. John → Password Cracking ✅
14. FFUF → Fuzzing ✅
15. Gobuster → Directory Enumeration ✅
16. Aircrack-ng → WiFi Testing ✅
17. adb shell → Open Shell ✅
18. adb install → Install APK ✅
19. adb pull → Download File ✅
20. adb push → Upload File ✅
21. adb logcat → Logs ✅
22. adbd → Device Daemon ✅
23. USB Debugging → Required for ADB ✅
24. OWASP ZAP → Web Testing ✅
25. Apktool → APK Reverse Engineering ✅
26. Reconnaissance → First Pen Test Phase ✅
27. Reporting → Last Phase ✅
28. Port Forwarding → ADB Feature ✅
29. Wireless ADB → Network Debugging ✅
30. Metasploit Console → msfconsole ✅

---

# Last Minute Revision Sheet

### ADB

```text
adb devices
adb shell
adb install
adb uninstall
adb push
adb pull
adb logcat
adb reboot
adb connect
```

### ADB Architecture

```text
Client → Server → adbd
```

### Pen Testing Phases

```text
Recon
Scanning
Assessment
Exploitation
Post Exploitation
Reporting
```

### Most Important Tools

```text
Nmap
Wireshark
Metasploit
Burp Suite
SQLmap
Nikto
OWASP ZAP
Hydra
John
Aircrack-ng
MobSF
Apktool
FFUF
Gobuster
```

These are the highest-probability theory, viva, practical, and MCQ points typically asked in Cyber Security, Ethical Hacking, Mobile Security, and Penetration Testing exams.


# Android Debug Bridge (ADB) & Penetration Testing Tools – 100 MCQs

## ADB MCQs (1–50)

### 1. ADB stands for:

A) Android Data Backup
B) Android Device Bridge
✅ C) Android Debug Bridge
D) Android Database Bridge

---

### 2. ADB is primarily used for:

A) Database management
B) Android communication and debugging
C) Antivirus scanning
D) Firewall configuration

✅ Answer: B

---

### 3. Which architecture does ADB follow?

A) Peer-to-Peer
B) Master-Slave
✅ C) Client-Server
D) Ring

---

### 4. ADB Server runs on:

A) Router
B) Android Device
✅ C) Computer
D) Cloud Server

---

### 5. adbd stands for:

A) Android Database Daemon
B) Android Device Driver
✅ C) Android Debug Bridge Daemon
D) Android Data Daemon

---

### 6. Default port used by ADB Server:

A) 80
B) 443
C) 8080
✅ D) 5037

---

### 7. Command to list connected devices:

A) adb list
✅ B) adb devices
C) adb show
D) adb connect

---

### 8. Command to start ADB server:

A) adb begin
B) adb init
✅ C) adb start-server
D) adb launch

---

### 9. Command to stop ADB server:

A) adb stop
B) adb terminate
✅ C) adb kill-server
D) adb shutdown

---

### 10. Command to access Android shell:

A) adb console
B) adb cmd
✅ C) adb shell
D) adb terminal

---

### 11. USB Debugging is enabled from:

A) Settings → WiFi
B) Settings → Security
✅ C) Developer Options
D) Play Store

---

### 12. Developer Options are enabled by tapping:

A) Device Name
B) Android Version
✅ C) Build Number
D) IMEI

---

### 13. Number of taps generally required:

A) 3
B) 5
✅ C) 7
D) 10

---

### 14. Command to install APK:

A) adb add
B) adb apk
✅ C) adb install
D) adb deploy

---

### 15. Command to reinstall APK:

A) adb install -f
✅ B) adb install -r
C) adb install -a
D) adb install -i

---

### 16. Command to uninstall application:

A) adb remove
B) adb delete
✅ C) adb uninstall
D) adb erase

---

### 17. Command to copy file from device:

A) adb push
✅ B) adb pull
C) adb copy
D) adb get

---

### 18. Command to send file to device:

A) adb upload
B) adb send
✅ C) adb push
D) adb put

---

### 19. Command to reboot device:

A) adb restart
✅ B) adb reboot
C) adb power
D) adb refresh

---

### 20. Command to reboot bootloader:

A) adb boot
B) adb restart bootloader
✅ C) adb reboot bootloader
D) adb loader

---

### 21. Which command shows logs?

A) adb logs
B) adb dump
✅ C) adb logcat
D) adb viewlog

---

### 22. Logcat is used for:

A) Encryption
B) Networking
✅ C) Viewing logs
D) APK signing

---

### 23. Command to list packages:

A) adb packages
✅ B) adb shell pm list packages
C) adb apps
D) adb list apps

---

### 24. Command to view properties:

A) adb prop
B) adb showprop
✅ C) adb shell getprop
D) adb sysprop

---

### 25. Wireless ADB commonly uses port:

A) 80
B) 21
C) 22
✅ D) 5555

---

### 26. Command for TCP mode:

A) adb tcp
✅ B) adb tcpip 5555
C) adb wireless
D) adb net

---

### 27. Command to connect wirelessly:

A) adb netconnect
B) adb join
✅ C) adb connect
D) adb wireless

---

### 28. Command to capture screenshot:

A) adb screenshot
B) adb shot
✅ C) adb shell screencap
D) adb screen

---

### 29. Command to record screen:

A) adb record
B) adb video
✅ C) adb shell screenrecord
D) adb capture

---

### 30. ADB is part of:

A) Linux Kernel
B) Java SDK
✅ C) Android SDK Platform Tools
D) Android Studio IDE

---

### 31. adbd runs on:

✅ A) Android Device
B) Computer
C) Router
D) Server

---

### 32. Which command helps obtain device model?

✅ A) adb shell getprop ro.product.model
B) adb model
C) adb info
D) adb version

---

### 33. Which command gives Android version?

✅ A) adb shell getprop ro.build.version.release
B) adb android
C) adb version
D) adb release

---

### 34. Unauthorized ADB access may lead to:

A) Faster charging
B) Better battery
✅ C) Data theft
D) Improved performance

---

### 35. USB debugging should:

A) Always remain enabled
✅ B) Be disabled when not required
C) Never be used
D) Be used only on rooted phones

---

### 36. ADB backup command is used for:

✅ A) Backup creation
B) Encryption
C) Recovery mode
D) Logging

---

### 37. Port forwarding command:

✅ A) adb forward
B) adb route
C) adb redirect
D) adb tunnel

---

### 38. ADB communication occurs through:

A) FTP
B) SMTP
C) DNS
✅ D) Client-Server mechanism

---

### 39. Which is NOT an ADB component?

A) Client
B) Server
C) adbd
✅ D) Compiler

---

### 40. ADB can:

A) Install APK
B) Uninstall APK
C) Transfer Files
✅ D) All of these

---

### 41-50 Quick Answers

41. ADB daemon name → adbd ✅
42. USB Debugging required → Yes ✅
43. ADB is command line tool → Yes ✅
44. Wireless debugging possible → Yes ✅
45. adb pull downloads file → Yes ✅
46. adb push uploads file → Yes ✅
47. adb logcat views logs → Yes ✅
48. adb reboot restarts device → Yes ✅
49. adb devices lists devices → Yes ✅
50. adb shell opens terminal → Yes ✅

---

# Penetration Testing Tools MCQs (51–100)

### 51. Penetration Testing is:

A) Unauthorized hacking
✅ B) Authorized security testing
C) Malware analysis
D) Data backup

---

### 52. First phase of penetration testing:

A) Scanning
B) Exploitation
✅ C) Reconnaissance
D) Reporting

---

### 53. Last phase:

A) Exploitation
B) Assessment
C) Enumeration
✅ D) Reporting

---

### 54. Nmap is used for:

A) Password cracking
✅ B) Network scanning
C) Logging
D) Encryption

---

### 55. Nmap stands for:

✅ A) Network Mapper
B) Network Monitor
C) Node Mapper
D) Network Marker

---

### 56. Wireshark is:

A) Vulnerability scanner
B) Password cracker
✅ C) Packet analyzer
D) Exploit framework

---

### 57. Metasploit is:

A) IDS
B) Firewall
✅ C) Exploitation framework
D) Proxy

---

### 58. Metasploit starts using:

A) metasploit
B) msf
✅ C) msfconsole
D) startmsf

---

### 59. Burp Suite is mainly used for:

A) Wireless attacks
✅ B) Web Application Testing
C) Mobile Forensics
D) Password Storage

---

### 60. SQLmap automates:

A) XSS
✅ B) SQL Injection
C) CSRF
D) SSRF

---

### 61. Nikto is:

A) Packet sniffer
✅ B) Web vulnerability scanner
C) Password cracker
D) Proxy

---

### 62. OWASP ZAP is:

A) Antivirus
✅ B) Web Security Testing Tool
C) Wireless Tool
D) SIEM

---

### 63. Hydra is used for:

A) Packet Analysis
B) Port Scanning
✅ C) Password Attacks
D) Malware Creation

---

### 64. John the Ripper is:

A) Scanner
B) Sniffer
✅ C) Password Cracker
D) Proxy

---

### 65. Aircrack-ng is used for:

A) Android Testing
B) SQL Testing
✅ C) Wireless Security Testing
D) Reverse Engineering

---

### 66. Gobuster performs:

A) Packet Capture
B) SQL Injection
✅ C) Directory Enumeration
D) Encryption

---

### 67. FFUF stands for:

✅ A) Fuzz Faster U Fool
B) Fast File Utility Framework
C) Fuzz Utility Finder
D) Fast URL Filter

---

### 68. Apktool is used for:

A) WiFi testing
✅ B) APK Reverse Engineering
C) Port scanning
D) Packet analysis

---

### 69. MobSF stands for:

✅ A) Mobile Security Framework
B) Mobile Scanning Framework
C) Mobile Safe Framework
D) Mobile Security Firewall

---

### 70. Which tool captures network packets?

A) Nmap
B) Hydra
✅ C) Wireshark
D) Gobuster

---

### 71. Which tool uses payloads?

A) Wireshark
B) Nmap
✅ C) Metasploit
D) Hydra

---

### 72. Which Burp feature repeats requests?

A) Proxy
✅ B) Repeater
C) Scanner
D) Decoder

---

### 73. Which Burp feature performs brute force?

A) Proxy
B) Repeater
✅ C) Intruder
D) Comparer

---

### 74. SQLmap primarily targets:

A) DNS
B) FTP
✅ C) Databases
D) SSH

---

### 75. Aircrack-ng attacks:

A) FTP
B) SSH
✅ C) WiFi Networks
D) SMTP

---

### 76. Hydra supports:

A) SSH
B) FTP
C) HTTP
✅ D) All of these

---

### 77. Which tool helps discover hidden directories?

A) Wireshark
B) John
✅ C) Gobuster
D) Aircrack

---

### 78. FFUF is mainly:

A) Sniffer
✅ B) Fuzzer
C) Firewall
D) Proxy

---

### 79. Metasploit component used to exploit vulnerability:

✅ A) Exploit
B) Payload
C) Auxiliary
D) Encoder

---

### 80. Component providing access after exploitation:

A) Exploit
✅ B) Payload
C) Auxiliary
D) Module

---

### 81. Reconnaissance means:

✅ A) Information Gathering
B) Exploitation
C) Reporting
D) Logging

---

### 82. Scanning identifies:

A) Passwords
✅ B) Open Ports
C) Hashes
D) Logs

---

### 83. Vulnerability assessment identifies:

A) Routers
B) Cables
✅ C) Weaknesses
D) Drivers

---

### 84. Exploitation phase attempts:

A) Reporting
B) Documentation
✅ C) Attack Simulation
D) Logging

---

### 85. Post-exploitation often involves:

A) Printing
B) Documentation
✅ C) Privilege Escalation
D) Installation

---

### 86. OWASP stands for:

✅ A) Open Worldwide Application Security Project
B) Open Web Security Project
C) Online Web Security Program
D) Open Wireless Security Project

---

### 87. Which tool is open-source alternative to Burp?

A) Hydra
B) John
✅ C) OWASP ZAP
D) Aircrack

---

### 88. Which tool is used for mobile application security testing?

A) Nmap
B) Wireshark
✅ C) MobSF
D) Hydra

---

### 89. Which tool can enumerate databases?

A) Nmap
B) Gobuster
✅ C) SQLmap
D) Wireshark

---

### 90. Which tool uses wordlists for fuzzing?

A) Wireshark
✅ B) FFUF
C) Metasploit
D) Aircrack

---

### 91. Nmap can perform:

A) Port Scan
B) Service Detection
C) OS Detection
✅ D) All of these

---

### 92. Wireshark filter for HTTP:

A) tcp
B) udp
✅ C) http
D) arp

---

### 93. Common Hydra attack type:

✅ A) Brute Force
B) Packet Capture
C) Encryption
D) Backup

---

### 94. Metasploit auxiliary modules are used for:

A) Games
✅ B) Scanning and Support Tasks
C) Password Storage
D) Browsing

---

### 95. Directory brute forcing tool:

A) Wireshark
B) John
✅ C) Dirb
D) Aircrack

---

### 96. Which tool helps analyze APK source?

A) Gobuster
B) Hydra
✅ C) Apktool
D) Nmap

---

### 97. Wireless security tool suite:

A) SQLmap
B) Nikto
✅ C) Aircrack-ng
D) Burp

---

### 98. Burp Suite proxy is used to:

A) Encrypt packets
✅ B) Intercept traffic
C) Crack passwords
D) Scan ports

---

### 99. Most popular exploitation framework:

A) Nmap
B) Burp
✅ C) Metasploit
D) Wireshark

---

### 100. Which combination is correct?

A) Wireshark → Password Cracking
B) Hydra → Packet Capture
C) SQLmap → Wireless Testing
✅ D) Nmap → Port Scanning

---

# Ultra-Important Exam MCQs (Must Memorize)

| Question          | Answer                  |
| ----------------- | ----------------------- |
| ADB Full Form     | Android Debug Bridge    |
| ADB Port          | 5037                    |
| Wireless ADB Port | 5555                    |
| adb shell         | Open Device Shell       |
| adb devices       | List Devices            |
| Nmap              | Port Scanning           |
| Wireshark         | Packet Analysis         |
| Metasploit        | Exploitation            |
| Burp Suite        | Web Testing             |
| SQLmap            | SQL Injection           |
| Hydra             | Password Attacks        |
| John the Ripper   | Password Cracking       |
| Aircrack-ng       | WiFi Testing            |
| MobSF             | Mobile Security         |
| Apktool           | APK Reverse Engineering |
| Reconnaissance    | First Phase             |
| Reporting         | Last Phase              |
| msfconsole        | Start Metasploit        |
| FFUF              | Fuzzing                 |
| Gobuster          | Directory Enumeration   |

**Expected exam score if these 100 MCQs are mastered: 80–95% of typical university/unit-test questions on ADB and Penetration Testing Tools.**


