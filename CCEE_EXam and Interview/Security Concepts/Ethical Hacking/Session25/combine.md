# Mobile Security Notes

# 1. Overview of Mobile Malware

# 2. Android App Analysis

These notes cover theory, interview questions, placement preparation, university exams, cybersecurity certifications, and practical concepts.

---

# 1. Overview of Mobile Malware

## What is Mobile Malware?

Mobile Malware refers to malicious software specifically designed to target smartphones, tablets, and other mobile devices.

Objectives:

* Steal sensitive data
* Spy on users
* Gain unauthorized access
* Generate revenue for attackers
* Damage systems
* Control devices remotely

---

# Evolution of Mobile Malware

### Early Stage

* SMS Trojans
* Premium-rate SMS fraud

### Modern Stage

* Banking Trojans
* Spyware
* Ransomware
* Cryptocurrency miners
* Mobile Botnets

---

# Why Mobile Devices Are Attractive Targets?

### Huge User Base

Billions of Android devices worldwide.

### Sensitive Information

* Banking apps
* UPI apps
* Passwords
* Emails
* Contacts
* Photos

### Always Connected

* Wi-Fi
* Mobile Data
* Bluetooth
* NFC

### Weak Security Awareness

Users often:

* Install apps from unknown sources
* Click malicious links
* Ignore permissions

---

# Mobile Malware Infection Vectors

## 1. Malicious Applications

Fake apps distributed through:

* Third-party stores
* Modified APKs
* Pirated apps

Example:

Fake WhatsApp APK

---

## 2. Phishing Links

Victims click links via:

* SMS
* Email
* Social Media
* Messaging apps

---

## 3. Drive-by Downloads

Malware automatically downloads when visiting malicious websites.

---

## 4. Malvertising

Malicious advertisements redirect users to malware.

---

## 5. Bluetooth Attacks

Attackers exploit Bluetooth vulnerabilities.

---

## 6. QR Code Attacks

Malicious QR codes redirect to:

* Fake websites
* Malware downloads

---

# Types of Mobile Malware

---

## 1. Trojan

Appears legitimate but performs malicious actions.

Examples:

* Banking Trojan
* Fake Antivirus

Characteristics:

* Data theft
* Credential stealing

---

## 2. Spyware

Secretly monitors user activity.

Can steal:

* SMS
* Calls
* Keystrokes
* Location

Examples:

* Pegasus
* FlexiSpy

---

## 3. Adware

Displays unwanted advertisements.

Effects:

* Device slowdown
* Battery drain

---

## 4. Ransomware

Locks device or encrypts files.

Demands ransom payment.

---

## 5. Worm

Self-replicating malware.

Spreads through:

* Bluetooth
* Network
* Messaging apps

---

## 6. Rootkit

Obtains privileged access.

Can:

* Hide malware
* Bypass detection

---

## 7. Bot Malware

Makes device part of a botnet.

Used for:

* DDoS attacks
* Spam campaigns

---

## 8. Banking Malware

Targets financial applications.

Steals:

* OTPs
* Credentials
* Banking sessions

Examples:

* Anubis
* Cerberus

---

## 9. Cryptojacking Malware

Uses device resources for cryptocurrency mining.

Symptoms:

* Overheating
* High CPU usage
* Battery drain

---

# Android Malware Architecture

Typical Components:

### Payload

Actual malicious code.

### Dropper

Installs malware.

### Command and Control (C2)

Remote attacker server.

### Persistence Mechanism

Ensures malware survives reboot.

### Data Exfiltration Module

Steals information.

---

# Common Malware Capabilities

## Information Theft

* Contacts
* SMS
* Photos
* Passwords

## Surveillance

* Microphone recording
* Camera access
* GPS tracking

## Financial Fraud

* OTP interception
* Banking app overlay attacks

## Remote Control

Attacker controls device remotely.

---

# Mobile Botnet Workflow

1. Infection
2. Registration with C2
3. Receive Commands
4. Execute Malicious Tasks
5. Send Results Back

---

# Indicators of Mobile Malware Infection

### Performance Issues

* Slow device

### Battery Drain

* Rapid discharge

### Excessive Data Usage

* Background communication

### Unknown Apps

* Unrecognized installations

### Pop-up Advertisements

* Frequent ads

### Device Heating

* High CPU utilization

---

# Mobile Malware Detection Methods

## Signature-Based Detection

Compares against known malware signatures.

Pros:

* Fast

Cons:

* Misses unknown malware

---

## Heuristic Detection

Detects suspicious behavior.

Pros:

* Finds variants

Cons:

* False positives

---

## Behavioral Analysis

Observes runtime activity.

Examples:

* SMS sending
* Network connections

---

## Machine Learning Detection

Uses AI models.

Detects:

* Unknown malware
* Zero-day threats

---

# Mobile Malware Prevention

## User Side

* Install apps only from official stores
* Update OS regularly
* Verify permissions
* Avoid rooting

---

## Enterprise Side

* Mobile Device Management (MDM)
* Endpoint Detection & Response (EDR)
* App Whitelisting

---

# Mobile Malware Lifecycle

1. Development
2. Distribution
3. Installation
4. Persistence
5. Command Execution
6. Data Theft
7. Cleanup

---

# Exam Important Points

✅ Trojan ≠ Virus

✅ Worm spreads automatically

✅ Spyware steals information

✅ Rootkit hides malware

✅ Banking Trojan steals OTPs

✅ Adware displays advertisements

✅ Ransomware encrypts files

---

# 2. Android App Analysis

---

# What is Android App Analysis?

Android App Analysis is the process of examining APK files to identify:

* Vulnerabilities
* Malware
* Sensitive data exposure
* Security weaknesses

---

# APK Structure

APK = Android Package Kit

Contains:

| Component           | Purpose                     |
| ------------------- | --------------------------- |
| AndroidManifest.xml | App configuration           |
| classes.dex         | Compiled Java/Kotlin code   |
| resources.arsc      | Resource table              |
| assets              | App assets                  |
| lib                 | Native libraries            |
| META-INF            | Certificates and signatures |

---

# Android Application Architecture

### Activities

User interface screens.

### Services

Background tasks.

### Broadcast Receivers

Respond to system events.

### Content Providers

Data sharing between apps.

---

# Android App Analysis Types

## 1. Static Analysis

Analyzing app without executing.

---

## 2. Dynamic Analysis

Analyzing app during execution.

---

## 3. Hybrid Analysis

Combination of both.

---

# Static Analysis

## Goal

Examine:

* Source code
* Manifest
* Permissions
* Secrets

without running application.

---

## Information Gathered

### Permissions

Examples:

* READ_SMS
* CAMERA
* INTERNET
* ACCESS_FINE_LOCATION

---

### Hardcoded Secrets

Look for:

* API Keys
* Tokens
* Passwords

---

### Exported Components

Check:

```xml
android:exported="true"
```

May expose functionality.

---

### Insecure Storage

Sensitive data stored in:

* SharedPreferences
* SQLite
* External Storage

---

# Static Analysis Tools

### APKTool

Decompiles APK.

### JADX

Converts DEX to Java.

### MobSF

Popular automated analysis framework.

### Dex2Jar

Converts DEX to JAR.

### Androguard

Reverse engineering framework.

---

# Dynamic Analysis

App executed inside:

* Emulator
* Real Device
* Sandbox

---

# Dynamic Analysis Goals

Observe:

* Network traffic
* File operations
* API calls
* Runtime behavior

---

# Dynamic Analysis Tools

### MobSF Dynamic Analyzer

Runtime monitoring.

### Frida

Runtime instrumentation.

### Burp Suite

Intercepts HTTP/HTTPS traffic.

### Wireshark

Packet analysis.

### Android Studio Emulator

Testing environment.

---

# Dynamic Analysis Process

### Step 1

Install APK.

### Step 2

Launch Application.

### Step 3

Monitor Behavior.

### Step 4

Capture Traffic.

### Step 5

Analyze Findings.

---

# Android Manifest Analysis

Manifest reveals:

### Package Name

Example:

```xml
com.example.app
```

### Permissions

```xml
READ_CONTACTS
READ_SMS
```

### Components

* Activities
* Services
* Receivers

### Exported Components

Potential attack surface.

---

# Android Permission Categories

## Normal Permissions

Low-risk.

Example:

* INTERNET

---

## Dangerous Permissions

High-risk.

Examples:

* CAMERA
* RECORD_AUDIO
* READ_SMS

---

# Android Security Testing Checklist

## Storage Security

Check:

* SharedPreferences
* Databases
* Cache

---

## Communication Security

Check:

* HTTPS usage
* SSL Pinning

---

## Authentication

Check:

* Session handling
* Token storage

---

## Code Security

Check:

* Hardcoded credentials
* Obfuscation

---

# Reverse Engineering Workflow

1. Obtain APK
2. Decompile APK
3. Analyze Manifest
4. Review Code
5. Identify Secrets
6. Analyze APIs
7. Generate Report

---

# Android Malware Analysis Workflow

1. Hash APK
2. Static Analysis
3. Permission Review
4. Dynamic Analysis
5. Traffic Monitoring
6. Behavior Analysis
7. IOC Extraction

---

# Indicators of Malicious APK

### Excessive Permissions

Calculator requesting:

* SMS
* Contacts
* Microphone

---

### Obfuscated Code

Random class names:

```java
a.a.a.a()
```

---

### Suspicious Network Calls

Communication with unknown servers.

---

### Hidden Activities

Undocumented functionality.

---

# Mobile Forensics Artifacts

Important Sources:

* SMS database
* Call logs
* Browser history
* Installed apps
* SharedPreferences
* SQLite databases

---

# Frequently Asked Viva Questions

### What is APK?

Android Package Kit.

---

### What is classes.dex?

Compiled Dalvik bytecode.

---

### Difference Between Static and Dynamic Analysis?

Static:

* No execution

Dynamic:

* App executed

---

### What is MobSF?

Automated Mobile Security Framework.

---

### What is JADX?

DEX-to-Java decompiler.

---

### What is Frida?

Runtime instrumentation framework.

---

# MCQs (Exam-Oriented)

### 1. APK stands for?

A. Android Program Kit

B. Android Package Kit

C. Application Package Kernel

D. Android Packet Kit

✅ Answer: B

---

### 2. Which file contains Android permissions?

A. classes.dex

B. AndroidManifest.xml

C. assets

D. lib

✅ Answer: B

---

### 3. Which malware steals user information?

A. Worm

B. Spyware

C. Adware

D. Rootkit

✅ Answer: B

---

### 4. Which analysis runs the application?

A. Static

B. Passive

C. Dynamic

D. Signature

✅ Answer: C

---

### 5. Which tool converts APK to readable Java code?

A. Wireshark

B. Burp

C. JADX

D. Nessus

✅ Answer: C

---

### 6. Which malware encrypts files?

A. Trojan

B. Spyware

C. Ransomware

D. Adware

✅ Answer: C

---

### 7. Which permission is dangerous?

A. INTERNET

B. CAMERA

C. ACCESS_NETWORK_STATE

D. VIBRATE

✅ Answer: B

---

### 8. Which tool intercepts Android HTTP traffic?

A. Burp Suite

B. Nmap

C. Hydra

D. John

✅ Answer: A

---

# Last-Minute Revision Sheet (Very Important)

🔥 APK Components:

* AndroidManifest.xml
* classes.dex
* resources.arsc
* META-INF
* lib

🔥 Malware Types:

* Trojan
* Spyware
* Adware
* Worm
* Rootkit
* Ransomware
* Banking Trojan

🔥 Analysis Types:

* Static
* Dynamic
* Hybrid

🔥 Top Android Tools:

* APKTool
* JADX
* MobSF
* Frida
* Burp Suite
* Wireshark

🔥 Most Asked Exam Difference:

| Static Analysis   | Dynamic Analysis     |
| ----------------- | -------------------- |
| No Execution      | Executes App         |
| Faster            | Slower               |
| Safe              | Riskier              |
| Finds Code Issues | Finds Runtime Issues |
| Manifest Review   | Traffic Analysis     |

### Memory Trick

**"MAP-FBW"**

**M**obSF
**A**PKTool
**P**ermission Review
**F**rida
**B**urp Suite
**W**ireshark

This sequence matches a typical Android malware analysis workflow often asked in exams and interviews.

# Mobile Malware & Android App Analysis – 100 MCQs

## 1. What does APK stand for?

A) Android Program Kernel
B) Android Package Kit
C) Application Package Kit
D) Android Packet Kit

✅ Answer: B

---

## 2. Which file contains Android app permissions?

A) classes.dex
B) AndroidManifest.xml
C) resources.arsc
D) lib.so

✅ Answer: B

---

## 3. Which malware secretly monitors user activities?

A) Worm
B) Trojan
C) Spyware
D) Adware

✅ Answer: C

---

## 4. Which malware displays unwanted advertisements?

A) Adware
B) Spyware
C) Worm
D) Rootkit

✅ Answer: A

---

## 5. Which malware encrypts files and demands payment?

A) Trojan
B) Worm
C) Ransomware
D) Adware

✅ Answer: C

---

## 6. Which malware self-replicates?

A) Spyware
B) Worm
C) Trojan
D) Rootkit

✅ Answer: B

---

## 7. A Banking Trojan primarily targets:

A) Photos
B) Games
C) Banking Credentials
D) Contacts

✅ Answer: C

---

## 8. Which Android component represents UI screens?

A) Service
B) Activity
C) Receiver
D) Provider

✅ Answer: B

---

## 9. Which component performs background tasks?

A) Activity
B) Service
C) Manifest
D) Intent

✅ Answer: B

---

## 10. Which component responds to system events?

A) Service
B) Activity
C) Broadcast Receiver
D) APK

✅ Answer: C

---

## 11. What is Static Analysis?

A) Running app
B) Network monitoring
C) Analyzing without execution
D) Debugging

✅ Answer: C

---

## 12. What is Dynamic Analysis?

A) Source code review
B) Runtime analysis
C) APK signing
D) Manifest extraction

✅ Answer: B

---

## 13. Which tool decompiles APKs?

A) Wireshark
B) Burp
C) APKTool
D) Nessus

✅ Answer: C

---

## 14. Which tool converts DEX to Java code?

A) Nmap
B) JADX
C) Hydra
D) Metasploit

✅ Answer: B

---

## 15. MobSF stands for:

A) Mobile Security Framework
B) Mobile Security Framework Suite
C) Mobile Security Testing Framework
D) Mobile Scanner Framework

✅ Answer: C

---

## 16. classes.dex contains:

A) Images
B) Resources
C) Bytecode
D) Signatures

✅ Answer: C

---

## 17. META-INF contains:

A) Databases
B) Certificates
C) Activities
D) APIs

✅ Answer: B

---

## 18. Which permission allows camera access?

A) READ_SMS
B) INTERNET
C) CAMERA
D) LOCATION

✅ Answer: C

---

## 19. Which permission reads SMS messages?

A) READ_SMS
B) SEND_SMS
C) CAMERA
D) NFC

✅ Answer: A

---

## 20. Which permission accesses GPS?

A) INTERNET
B) ACCESS_FINE_LOCATION
C) READ_CONTACTS
D) VIBRATE

✅ Answer: B

---

# Malware Types

## 21. Pegasus is an example of:

A) Adware
B) Spyware
C) Worm
D) Rootkit

✅ Answer: B

---

## 22. Rootkits mainly:

A) Encrypt files
B) Hide malware
C) Display ads
D) Send spam

✅ Answer: B

---

## 23. Bot malware is mainly used for:

A) Gaming
B) DDoS attacks
C) Backups
D) Compression

✅ Answer: B

---

## 24. Cryptojacking malware consumes:

A) SMS
B) Contacts
C) CPU Resources
D) Bluetooth

✅ Answer: C

---

## 25. Malware installed through fake apps is usually:

A) Trojan
B) Firewall
C) IDS
D) Proxy

✅ Answer: A

---

## 26. Premium SMS fraud is associated with:

A) Mobile Malware
B) Antivirus
C) VPN
D) SSL

✅ Answer: A

---

## 27. Which malware intercepts OTPs?

A) Banking Trojan
B) Adware
C) Worm
D) Firewall

✅ Answer: A

---

## 28. Malware communicating with attacker servers uses:

A) DNS
B) C2 Server
C) VPN
D) IDS

✅ Answer: B

---

## 29. Malware persistence means:

A) Uninstalling itself
B) Surviving reboots
C) Updating Android
D) Rooting

✅ Answer: B

---

## 30. A dropper's purpose is:

A) Display Ads
B) Install Malware
C) Encrypt Data
D) Capture Packets

✅ Answer: B

---

# Android Architecture

## 31. Content Provider is used for:

A) UI
B) Background Tasks
C) Data Sharing
D) Notifications

✅ Answer: C

---

## 32. Android apps are packaged as:

A) IPA
B) APK
C) MSI
D) EXE

✅ Answer: B

---

## 33. Dalvik bytecode is stored in:

A) classes.dex
B) manifest
C) assets
D) META-INF

✅ Answer: A

---

## 34. Resources are stored in:

A) resources.arsc
B) dex
C) lib
D) manifest

✅ Answer: A

---

## 35. Native libraries are stored in:

A) META-INF
B) assets
C) lib
D) dex

✅ Answer: C

---

## 36. AndroidManifest.xml defines:

A) Images
B) Components & Permissions
C) Databases
D) Logs

✅ Answer: B

---

## 37. Exported components increase:

A) Battery
B) Attack Surface
C) CPU
D) RAM

✅ Answer: B

---

## 38. Obfuscation makes code:

A) Easier to read
B) Harder to analyze
C) Faster
D) Smaller

✅ Answer: B

---

## 39. Reverse engineering is:

A) Malware creation
B) Studying application internals
C) Patching OS
D) Updating APK

✅ Answer: B

---

## 40. Hardcoded API keys are:

A) Good Practice
B) Security Risk
C) Required
D) Encrypted

✅ Answer: B

---

# Dynamic Analysis

## 41. Frida is used for:

A) Runtime Instrumentation
B) Routing
C) Scanning
D) Encryption

✅ Answer: A

---

## 42. Burp Suite mainly analyzes:

A) Traffic
B) CPU
C) Memory
D) GPS

✅ Answer: A

---

## 43. Wireshark is:

A) Password Manager
B) Packet Analyzer
C) Browser
D) Compiler

✅ Answer: B

---

## 44. Dynamic Analysis observes:

A) Runtime Behavior
B) APK Structure
C) Manifest Only
D) Source Code Only

✅ Answer: A

---

## 45. Emulator-based testing helps:

A) Execute Apps Safely
B) Root Phones
C) Compile APKs
D) Encrypt Traffic

✅ Answer: A

---

## 46. SSL Pinning protects:

A) Local Storage
B) Network Communications
C) Contacts
D) Bluetooth

✅ Answer: B

---

## 47. Runtime API monitoring is part of:

A) Dynamic Analysis
B) Static Analysis
C) Signing
D) Packaging

✅ Answer: A

---

## 48. Traffic interception commonly uses:

A) Burp Suite
B) Word
C) Excel
D) PowerPoint

✅ Answer: A

---

## 49. APK installation occurs before:

A) Dynamic Analysis
B) Deletion
C) Encryption
D) Backup

✅ Answer: A

---

## 50. Network behavior is analyzed during:

A) Dynamic Analysis
B) Static Analysis
C) Coding
D) Signing

✅ Answer: A

---

# Detection & Defense

## 51. Signature-based detection relies on:

A) Known Patterns
B) AI
C) GPS
D) Bluetooth

✅ Answer: A

---

## 52. Heuristic detection identifies:

A) Suspicious Behavior
B) Images
C) Fonts
D) APK Icons

✅ Answer: A

---

## 53. Behavioral analysis focuses on:

A) Runtime Activities
B) Logos
C) Colors
D) APK Size

✅ Answer: A

---

## 54. Machine Learning helps detect:

A) Zero-day Malware
B) Images
C) Fonts
D) Battery

✅ Answer: A

---

## 55. MDM stands for:

A) Mobile Device Management
B) Mobile Data Mining
C) Malware Detection Method
D) Mobile Dynamic Module

✅ Answer: A

---

## 56. Rooting Android may:

A) Improve Security
B) Reduce Security
C) Encrypt Apps
D) Remove Permissions

✅ Answer: B

---

## 57. Official app stores are:

A) Safer
B) More Dangerous
C) Untrusted
D) Malware Sources

✅ Answer: A

---

## 58. Updating OS helps:

A) Patch Vulnerabilities
B) Install Malware
C) Increase Ads
D) Reduce Encryption

✅ Answer: A

---

## 59. Excessive permissions are:

A) Normal
B) Warning Sign
C) Required
D) Recommended

✅ Answer: B

---

## 60. Unknown APK sources are:

A) Trusted
B) Risky
C) Encrypted
D) Secure

✅ Answer: B

---

# Forensics & Analysis

## 61. SharedPreferences may store:

A) Settings
B) Videos
C) APKs
D) Firmware

✅ Answer: A

## 62. SQLite is used for?

A) Database Storage
B) Networking
C) Routing
D) Encryption

✅ Answer: A

## 63. Mobile forensic artifact:

A) SMS Logs
B) Wallpaper
C) Fonts
D) Widgets

✅ Answer: A

## 64. Call logs are:

A) Forensic Evidence
B) Antivirus
C) Malware
D) APK

✅ Answer: A

## 65. Browser history may reveal:

A) User Activity
B) CPU Usage
C) RAM Usage
D) APK Signature

✅ Answer: A

---

# Quick MCQs 66–100

66. Android malware mainly targets? → Sensitive Data ✅

67. QR-code attacks may lead to? → Malicious Websites ✅

68. Bluetooth vulnerabilities can enable? → Malware Spread ✅

69. Fake Antivirus is usually? → Trojan ✅

70. Malware hiding techniques use? → Rootkits ✅

71. OTP theft mainly affects? → Banking Apps ✅

72. Excessive battery drain indicates? → Possible Malware ✅

73. Unexpected data usage suggests? → Background Communication ✅

74. APKTool is used for? → APK Decompilation ✅

75. Frida works during? → Runtime Execution ✅

76. Dynamic analysis needs? → Execution ✅

77. Static analysis is safer because? → No Execution ✅

78. Malware command server is? → C2 Server ✅

79. Malware stealing contacts performs? → Data Exfiltration ✅

80. Spyware may access? → Microphone ✅

81. Ransomware objective? → Extortion ✅

82. Worm spreads? → Automatically ✅

83. Android dangerous permission? → RECORD_AUDIO ✅

84. Burp Suite intercepts? → HTTP/HTTPS Traffic ✅

85. Decompiled Java code can be viewed using? → JADX ✅

86. Android package identifier is? → Package Name ✅

87. Malware behavior analysis uses? → Sandbox/Emulator ✅

88. Android apps can contain native code in? → lib Folder ✅

89. Certificate information is in? → META-INF ✅

90. Obfuscated code appears? → Difficult to Read ✅

91. Malware analysts examine? → Permissions ✅

92. Malware analysts inspect? → Network Calls ✅

93. Suspicious calculator app requesting SMS permission is? → Red Flag ✅

94. MobSF supports? → Static & Dynamic Analysis ✅

95. APK stands for? → Android Package Kit ✅

96. Dynamic analysis can reveal? → Runtime Network Traffic ✅

97. Hardcoded credentials are? → Vulnerability ✅

98. Android security testing checks? → Storage Security ✅

99. SSL Pinning improves? → Communication Security ✅

100. Best malware analysis approach? → Hybrid Analysis ✅

# High-Probability Exam Questions

⭐ APK Components
⭐ AndroidManifest.xml
⭐ Activity vs Service
⭐ Static vs Dynamic Analysis
⭐ MobSF, JADX, APKTool, Frida
⭐ Spyware, Trojan, Worm, Rootkit, Ransomware
⭐ Banking Trojan Features
⭐ Dangerous Permissions
⭐ C2 Server
⭐ Data Exfiltration
⭐ Android Malware Lifecycle
⭐ Mobile Forensics Artifacts

These 100 MCQs cover nearly all university, viva, internal exam, placement, and cybersecurity certification questions from Mobile Malware and Android App Analysis.
