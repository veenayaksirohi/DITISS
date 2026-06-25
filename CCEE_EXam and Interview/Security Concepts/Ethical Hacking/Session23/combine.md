# OWASP Top 10 Mobile Application Vulnerabilities & Attacks on Android Apps

## Complete Placement + University Exam Notes

---

# 1. Introduction to Mobile Application Security

Mobile applications store and process:

* Personal information
* Banking details
* Authentication tokens
* Location data
* Contacts
* Business information

A vulnerability in a mobile app can lead to:

* Data theft
* Account takeover
* Financial fraud
* Privacy violations
* Remote code execution

---

# Mobile Application Architecture

![Image](https://images.openai.com/static-rsc-4/CtQSQk9Gh8upNsbCx-8crvhn48biyti3uekiqR5_E8KcgyME_EtmiD4bxPxbe3V6gxyqECXlskVy_QlvVJvWWk8koBqyq9VgfUUxaTFSFdedgbhyQOezrXZ4mtjMGv8JfP5x7clOrJiBwXqzvvw0362aQVLhSljyF1KTr6m3C4uqzw6iR2Iqsn-GmUC6YlfQ?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/6kTHZLvX-j4jL9-2kK4YRjo3dH8s1iby0SvlZ0ELljvhpccQTYjrLqjVxmd69vshFloZCTT9M3UcTkKPceQIv7cyAO-VGC3LZD6Ca3vypz_rZ-i2kKLmY2MkiBsMcoLZa-2bpUgPv-NLCM8QNm_yzWRX3tk-2qqMRKEwAciumiRlCi_NosKmXZFOMAcum7KD?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/S0KuPhhYOtFA06sJ5eTwLrSzZiXr8GTGI-jtDMK8F5D1l3fXm2JV8FJzBnBAydQVqzY03sbiXFGz9ODd02d_hcnn0r8prkkA4H5B9kcvTIEQYcWQB0PFOzvmorJrmZk8EGXk3mNy8CrMiv3QUk3CsDgELJYNGXxEVM9Zc5segNPw0ME1yhYXQU9XTdvefgnx?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/JVIAhw6OQmVgLvAdrM5HRwTEtfk4Iqrd-62GBornRzLA8N2ZxBD9vQIS67T-07O05KxiYoCl3D8-PJz-vh-gcVD5lw7kh4t8u_MPkcqWR3xA_XUesImR5ri0P-sKOTgMS4_n7zk1qKr-ktsKSQZ6Fl7SvxOal6Ap7a0-zd7HKjYo5EPdejQTKPbQsP7oLKs2?purpose=fullsize)

Components:

1. Mobile Application
2. Mobile Operating System
3. Local Storage
4. Network Communication
5. Backend Server
6. APIs
7. Authentication Services

---

# OWASP Mobile Top 10

OWASP = Open Worldwide Application Security Project

The OWASP Mobile Top 10 identifies the most critical mobile application security risks.

---

# M1: Improper Credential Usage

## Definition

Occurs when applications improperly store or handle credentials.

Examples:

* Hardcoded passwords
* Hardcoded API keys
* Hardcoded tokens
* Credentials stored in plaintext

### Vulnerable Code Example

```java
String password = "admin123";
```

### Risks

* Credential theft
* Unauthorized access
* Account compromise

### Prevention

✔ Android Keystore

✔ Secure Credential Storage

✔ Environment Variables

✔ OAuth

---

# M2: Inadequate Supply Chain Security

## Definition

Security weaknesses in third-party libraries and dependencies.

### Causes

* Outdated libraries
* Vulnerable SDKs
* Malicious packages

### Example

Using:

```text
Log4j vulnerable version
```

or vulnerable ad SDK.

### Prevention

* Update dependencies regularly
* Software Composition Analysis
* Verify package integrity

---

# M3: Insecure Authentication/Authorization

## Definition

Weak authentication mechanisms.

### Examples

* Weak passwords
* Missing MFA
* Broken session management

### Impact

* Account takeover
* Privilege escalation

### Prevention

* Strong password policy
* MFA
* Token validation

---

# M4: Insufficient Input/Output Validation

## Definition

Application fails to validate user input.

### Examples

* SQL Injection
* Command Injection
* Path Traversal

### Example

```sql
SELECT * FROM users
WHERE id='$id'
```

### Prevention

* Input validation
* Prepared statements
* Output encoding

---

# M5: Insecure Communication

## Definition

Sensitive data transmitted insecurely.

### Examples

* HTTP instead of HTTPS
* Weak TLS
* Certificate validation bypass

### Impact

* MITM attacks
* Data interception

### Prevention

* HTTPS only
* TLS 1.2+
* Certificate pinning

---

# M6: Inadequate Privacy Controls

## Definition

Failure to protect user privacy.

### Examples

* Excessive permissions
* Data sharing without consent
* Tracking users

### Prevention

* Least privilege
* User consent
* Privacy policies

---

# M7: Insufficient Binary Protections

## Definition

Application code lacks protection against reverse engineering.

### Examples

* No obfuscation
* No anti-tampering
* No anti-debugging

### Risks

* APK modification
* Logic theft
* Key extraction

### Prevention

* ProGuard
* R8 Obfuscation
* Root detection

---

# M8: Security Misconfiguration

## Definition

Incorrect security settings.

### Examples

* Debug mode enabled
* Exported activities
* Open Firebase database

### Prevention

* Secure defaults
* Security reviews
* Hardening

---

# M9: Insecure Data Storage

## Definition

Sensitive data stored insecurely.

### Vulnerable Data

* Passwords
* Tokens
* Credit card details

### Common Locations

* Shared Preferences
* SQLite
* Log files
* External storage

### Prevention

* Encryption
* Android Keystore
* Avoid plaintext storage

---

# M10: Insufficient Cryptography

## Definition

Weak cryptographic implementation.

### Examples

Weak Algorithms:

* MD5
* SHA1
* DES
* RC4

### Strong Algorithms

* AES-256
* RSA-2048+
* SHA-256
* SHA-3

### Prevention

* Modern algorithms
* Proper key management

---

# Android Application Attack Surface

Attack surface includes:

### 1. APK File

Can be:

* Decompiled
* Modified
* Repackaged

### 2. Activities

Can expose functionality.

### 3. Services

Background processes.

### 4. Broadcast Receivers

Receive system messages.

### 5. Content Providers

Share application data.

### 6. Local Storage

Sensitive information leakage.

### 7. Network Traffic

Interception opportunities.

---

# Attacks on Android Applications

---

# 1. Reverse Engineering

## Definition

Analyzing APK to understand source code.

### Tools

* JADX
* Apktool
* dex2jar
* JD-GUI

### Process

```text
APK
 ↓
DEX
 ↓
Java Code
```

### Risks

* Secret extraction
* Business logic theft
* Vulnerability discovery

### Prevention

* Obfuscation
* R8
* ProGuard

---

# 2. APK Repackaging Attack

## Definition

Attacker modifies APK and redistributes it.

### Steps

1. Decompile APK
2. Inject malicious code
3. Rebuild APK
4. Sign APK
5. Distribute

### Impact

* Malware insertion
* Credential theft

### Prevention

* App signing verification
* Integrity checks

---

# 3. Malware Injection

## Types

### Trojan

Looks legitimate.

### Spyware

Steals information.

### Ransomware

Locks device data.

### Adware

Displays unwanted ads.

---

# 4. Rooting Attacks

## Rooting

Obtaining administrator privileges.

### Risks

* Security bypass
* App tampering

### Prevention

* Root detection
* Runtime checks

---

# 5. Man-in-the-Middle (MITM)

## Definition

Attacker intercepts communication.

### Example

```text
Victim
 ↓
Attacker
 ↓
Server
```

### Impact

* Data theft
* Session hijacking

### Prevention

* HTTPS
* Certificate pinning

---

# 6. SSL Pinning Bypass

## Definition

Bypassing certificate pinning.

### Tools

* Frida
* Objection
* Burp Suite

### Prevention

* Strong pinning
* Runtime integrity checks

---

# 7. Dynamic Analysis Attack

## Definition

Analyzing application while running.

### Tools

* Frida
* Xposed
* Objection

### Goals

* Hook functions
* Bypass authentication
* Extract secrets

---

# 8. Static Analysis Attack

## Definition

Analyzing code without execution.

### Tools

* JADX
* Apktool

### Goal

* Find secrets
* Discover vulnerabilities

---

# 9. Intent Hijacking

## Definition

Malicious application intercepts intents.

### Impact

* Data leakage
* Unauthorized actions

### Prevention

* Explicit intents
* Permission protection

---

# 10. Tapjacking

## Definition

User tricked into clicking hidden UI elements.

### Example

Invisible overlay over:

```text
Install Button
```

### Impact

* Unauthorized actions

### Prevention

* Filter obscured touches

---

# 11. Overlay Attacks

## Definition

Fake screen shown above genuine application.

### Examples

* Fake login screen
* Banking malware

### Prevention

* Detect overlays
* Accessibility checks

---

# 12. Session Hijacking

## Definition

Stealing session tokens.

### Methods

* MITM
* Malware
* Local storage theft

### Prevention

* Secure token storage
* Short-lived sessions

---

# 13. SQL Injection in Android Apps

Example:

```sql
' OR '1'='1
```

### Impact

* Database compromise

### Prevention

* Parameterized queries

---

# 14. Local Data Extraction

Attacker accesses:

* SQLite
* SharedPreferences
* Cache
* Logs

### Prevention

* Encryption

---

# 15. Debugging Attack

Tools:

* Android Studio Debugger
* GDB
* Frida

### Goal

* Observe runtime behavior

### Prevention

* Anti-debugging

---

# Android Security Mechanisms

## Sandbox

Each app runs in isolation.

---

## Permission Model

Examples:

```text
CAMERA
LOCATION
STORAGE
CONTACTS
```

---

## Application Signing

Ensures integrity.

---

## SELinux

Mandatory Access Control.

---

## Android Keystore

Secure key storage.

---

# Mobile Penetration Testing Methodology

## Step 1: Information Gathering

Collect:

* APK
* Package name
* Permissions

---

## Step 2: Static Analysis

Tools:

* APKTool
* JADX

---

## Step 3: Dynamic Analysis

Tools:

* Burp Suite
* Frida

---

## Step 4: Traffic Analysis

Check:

* HTTPS
* TLS
* APIs

---

## Step 5: Vulnerability Assessment

Identify:

* Storage issues
* Authentication flaws
* Crypto weaknesses

---

## Step 6: Reporting

Include:

* Risk
* Evidence
* Recommendation

---

# Android Security Testing Tools

| Tool       | Purpose                           |
| ---------- | --------------------------------- |
| APKTool    | Decompile APK                     |
| JADX       | Source code analysis              |
| Frida      | Runtime instrumentation           |
| Objection  | Mobile pentesting                 |
| MobSF      | Automated mobile security testing |
| Burp Suite | Proxy & interception              |
| Drozer     | Android assessment                |
| ADB        | Device interaction                |
| Wireshark  | Packet analysis                   |
| Genymotion | Emulator                          |

---

# Frequently Asked Exam Questions

### 2 Marks

1. What is APK?
2. What is Android Keystore?
3. Define reverse engineering.
4. What is MITM attack?
5. What is SSL pinning?
6. What is rooting?
7. What is Tapjacking?
8. What is Intent Hijacking?

---

### 5 Marks

1. Explain OWASP Mobile Top 10.
2. Explain Android architecture attack surface.
3. Explain MITM attack.
4. Explain reverse engineering process.
5. Explain APK repackaging attack.

---

### 10 Marks

1. Explain OWASP Mobile Top 10 in detail.
2. Discuss attacks on Android applications.
3. Explain mobile application penetration testing methodology.
4. Discuss Android security mechanisms.

---

# Important Points for Exams

### Remember

OWASP Mobile Top 10:

```text
M1 Improper Credential Usage
M2 Supply Chain Security
M3 Insecure Authentication
M4 Input Validation
M5 Insecure Communication
M6 Privacy Controls
M7 Binary Protections
M8 Misconfiguration
M9 Data Storage
M10 Cryptography
```

### Android Attack Keywords

```text
Reverse Engineering
APK Repackaging
Rooting
MITM
SSL Pinning Bypass
Tapjacking
Intent Hijacking
Overlay Attack
Session Hijacking
```

---

# Placement MCQs (Quick Revision)

### 1. Which tool is commonly used to decompile APKs?

A. Nmap
B. Burp
C. JADX
D. Wireshark

✅ Answer: C

---

### 2. Which OWASP category deals with plaintext credential storage?

A. M1
B. M5
C. M8
D. M10

✅ Answer: A

---

### 3. Which attack intercepts communication between client and server?

A. XSS
B. MITM
C. CSRF
D. SSRF

✅ Answer: B

---

### 4. Android secure key storage mechanism?

A. SQLite
B. SharedPreferences
C. Android Keystore
D. Cache

✅ Answer: C

---

### 5. Which tool performs runtime hooking?

A. Frida
B. Nmap
C. Hydra
D. John

✅ Answer: A

---

### 6. SSL Pinning primarily protects against?

A. SQL Injection
B. MITM
C. CSRF
D. XSS

✅ Answer: B

---

### 7. Which attack modifies APK and redistributes it?

A. MITM
B. Repackaging
C. Rooting
D. Phishing

✅ Answer: B

---

### 8. Which Android component shares data between applications?

A. Activity
B. Service
C. Content Provider
D. Fragment

✅ Answer: C

---

### 9. Which tool automates Android security testing?

A. MobSF
B. Nikto
C. Nessus
D. Aircrack

✅ Answer: A

---

### 10. Which vulnerability involves weak encryption?

A. M8
B. M9
C. M10
D. M2

✅ Answer: C

---

# Last-Minute Revision Sheet (1 Minute Before Exam)

```text
OWASP Mobile Top 10 = M1–M10

Most Common Android Attacks:
✓ Reverse Engineering
✓ APK Repackaging
✓ Malware Injection
✓ Rooting
✓ MITM
✓ SSL Pinning Bypass
✓ Intent Hijacking
✓ Tapjacking
✓ Overlay Attack
✓ Session Hijacking

Important Tools:
✓ APKTool
✓ JADX
✓ Frida
✓ Objection
✓ Burp Suite
✓ MobSF
✓ Drozer

Security Mechanisms:
✓ Sandbox
✓ Permissions
✓ Application Signing
✓ SELinux
✓ Android Keystore
```

This covers the complete theory typically asked in B.Tech/BCA/MCA Cyber Security, Mobile Security, Ethical Hacking, and Placement examinations.

# OWASP Mobile Security & Android Attacks – 100 MCQs

## 1. OWASP Mobile Security

### 1.

OWASP stands for:

A. Open Wireless App Security Project
B. Open Web Application Security Project
C. Open Worldwide Application Security Project
D. Online Web Application Security Program

✅ Answer: C

---

### 2.

Which OWASP Mobile category deals with hardcoded credentials?

A. M1
B. M4
C. M7
D. M10

✅ Answer: A

---

### 3.

Which vulnerability involves plaintext API keys in source code?

A. Improper Credential Usage
B. Insecure Communication
C. Security Misconfiguration
D. Insecure Data Storage

✅ Answer: A

---

### 4.

Using outdated third-party libraries is classified as:

A. M2
B. M5
C. M8
D. M10

✅ Answer: A

---

### 5.

Which OWASP category covers weak login mechanisms?

A. M3
B. M7
C. M8
D. M10

✅ Answer: A

---

### 6.

SQL Injection belongs to:

A. M1
B. M4
C. M6
D. M9

✅ Answer: B

---

### 7.

Using HTTP instead of HTTPS falls under:

A. M2
B. M5
C. M7
D. M8

✅ Answer: B

---

### 8.

Excessive permissions primarily indicate:

A. M6
B. M3
C. M4
D. M10

✅ Answer: A

---

### 9.

Lack of code obfuscation belongs to:

A. M5
B. M6
C. M7
D. M9

✅ Answer: C

---

### 10.

Debug mode enabled in production is:

A. M8
B. M9
C. M2
D. M10

✅ Answer: A

---

## 11–20

### 11.

Storing passwords in SharedPreferences without encryption is:

A. M1
B. M9
C. M7
D. M5

✅ Answer: B

### 12.

Using MD5 for password hashing is:

A. Strong Cryptography
B. Secure Design
C. Insufficient Cryptography
D. Authorization Failure

✅ Answer: C

### 13.

Which algorithm is considered weak?

A. AES-256
B. RSA-2048
C. SHA-256
D. MD5

✅ Answer: D

### 14.

Certificate pinning helps prevent:

A. XSS
B. CSRF
C. MITM
D. Buffer Overflow

✅ Answer: C

### 15.

Which OWASP Mobile category is related to privacy?

A. M6
B. M4
C. M8
D. M1

✅ Answer: A

### 16.

Storing tokens in plaintext is:

A. M7
B. M9
C. M2
D. M5

✅ Answer: B

### 17.

Android Keystore is used for:

A. Malware Detection
B. Key Management
C. Routing
D. Logging

✅ Answer: B

### 18.

Weak TLS configuration is:

A. M5
B. M8
C. M10
D. M1

✅ Answer: A

### 19.

Missing MFA may lead to:

A. Better Security
B. Authentication Failure
C. Faster Encryption
D. Secure Storage

✅ Answer: B

### 20.

Firebase database exposed publicly is:

A. M8
B. M6
C. M1
D. M7

✅ Answer: A

---

# Android Architecture & Components

### 21.

Android applications are distributed as:

A. EXE
B. APK
C. MSI
D. RPM

✅ Answer: B

### 22.

APK stands for:

A. Android Package Kit
B. Android Process Kit
C. Application Package Kernel
D. Android Permission Key

✅ Answer: A

### 23.

Which component provides UI?

A. Activity
B. Service
C. Broadcast Receiver
D. Content Provider

✅ Answer: A

### 24.

Background processing is handled by:

A. Activity
B. Service
C. Intent
D. Fragment

✅ Answer: B

### 25.

Content Provider is used for:

A. UI Creation
B. Data Sharing
C. Encryption
D. Debugging

✅ Answer: B

### 26.

Broadcast Receivers respond to:

A. Database Queries
B. System Events
C. Encryption Requests
D. APK Signing

✅ Answer: B

### 27.

Android apps run inside:

A. Hypervisor
B. Sandbox
C. Docker
D. Router

✅ Answer: B

### 28.

Each Android app generally has:

A. Same UID
B. Unique UID
C. No UID
D. Shared UID

✅ Answer: B

### 29.

SELinux provides:

A. Encryption
B. MAC Security
C. VPN Access
D. Authentication

✅ Answer: B

### 30.

Application signing ensures:

A. Integrity
B. Speed
C. Compression
D. Logging

✅ Answer: A

---

# Reverse Engineering

### 31.

Which tool decompiles APKs?

A. Nmap
B. Burp Suite
C. JADX
D. Hydra

✅ Answer: C

### 32.

APKTool primarily:

A. Scans Networks
B. Decompiles APKs
C. Cracks Passwords
D. Captures Packets

✅ Answer: B

### 33.

DEX stands for:

A. Dalvik Executable
B. Dynamic Extension
C. Digital Execution
D. Data Exchange

✅ Answer: A

### 34.

Reverse engineering aims to:

A. Encrypt Apps
B. Understand App Logic
C. Sign APKs
D. Update Android

✅ Answer: B

### 35.

Obfuscation helps prevent:

A. Reverse Engineering
B. Routing Attacks
C. DHCP Attacks
D. DNS Poisoning

✅ Answer: A

### 36.

R8 is used for:

A. Obfuscation
B. Scanning
C. Packet Capture
D. VPN Creation

✅ Answer: A

### 37.

ProGuard is mainly used for:

A. APK Obfuscation
B. Password Cracking
C. SQL Injection
D. Routing

✅ Answer: A

### 38.

Static analysis means:

A. Running App
B. Code Analysis Without Execution
C. Packet Sniffing
D. Routing

✅ Answer: B

### 39.

Which is static analysis tool?

A. Frida
B. Objection
C. JADX
D. Xposed

✅ Answer: C

### 40.

Hardcoded secrets are often found during:

A. Static Analysis
B. DHCP Attack
C. Routing
D. DNS Resolution

✅ Answer: A

---

# Dynamic Analysis

### 41.

Dynamic analysis means:

A. Runtime Analysis
B. Source Code Review
C. Network Design
D. Encryption

✅ Answer: A

### 42.

Frida is used for:

A. Runtime Hooking
B. Routing
C. Encryption
D. Firewalling

✅ Answer: A

### 43.

Objection is built on:

A. Nmap
B. Frida
C. Hydra
D. Nessus

✅ Answer: B

### 44.

Runtime instrumentation allows:

A. Function Hooking
B. Routing
C. Packet Forwarding
D. DHCP

✅ Answer: A

### 45.

Xposed Framework is used for:

A. Runtime Modification
B. DNS Lookup
C. VPN Creation
D. Encryption

✅ Answer: A

### 46.

Which tool intercepts mobile traffic?

A. Burp Suite
B. Hydra
C. Aircrack-ng
D. John

✅ Answer: A

### 47.

MobSF stands for:

A. Mobile Security Framework
B. Mobile Secure Firewall
C. Mobile Software Framework
D. Mobile Scan Function

✅ Answer: A

### 48.

ADB stands for:

A. Android Debug Bridge
B. Application Database Bridge
C. Android Dynamic Binary
D. App Data Block

✅ Answer: A

### 49.

Frida can:

A. Hook Functions
B. Encrypt Databases
C. Compile APKs
D. Route Packets

✅ Answer: A

### 50.

Dynamic analysis requires:

A. Execution
B. Compilation Only
C. Documentation
D. Routing

✅ Answer: A

---

# Android Attacks

### 51.

APK modification attack is:

A. Repackaging
B. MITM
C. DoS
D. XSS

✅ Answer: A

### 52.

Rooting provides:

A. User Access
B. Administrative Privileges
C. VPN Access
D. Encryption

✅ Answer: B

### 53.

MITM stands for:

A. Multiple Internet Transfer Method
B. Man In The Middle
C. Main Internal Transfer Mechanism
D. Mobile Internet Threat Model

✅ Answer: B

### 54.

Tapjacking is:

A. Overlay Click Attack
B. SQL Attack
C. Network Attack
D. Buffer Overflow

✅ Answer: A

### 55.

Intent Hijacking exploits:

A. Intents
B. Routing Tables
C. Databases
D. Cookies

✅ Answer: A

### 56.

Fake login screens are examples of:

A. Overlay Attack
B. DHCP Attack
C. ARP Attack
D. Smurf Attack

✅ Answer: A

### 57.

Banking malware often uses:

A. Overlay Attacks
B. DNS Lookup
C. Routing
D. VPN

✅ Answer: A

### 58.

Session hijacking targets:

A. Tokens
B. Routing Tables
C. MAC Addresses
D. DNS Records

✅ Answer: A

### 59.

SQL Injection targets:

A. Database Queries
B. Routing Protocols
C. VPNs
D. SSL Certificates

✅ Answer: A

### 60.

Malicious advertisements are associated with:

A. Adware
B. Trojan
C. Worm
D. Rootkit

✅ Answer: A

---

# Malware

### 61.

Spyware is designed to:

A. Monitor Users
B. Encrypt Files
C. Improve Security
D. Block Traffic

✅ Answer: A

### 62.

Ransomware primarily:

A. Locks Data
B. Monitors Traffic
C. Routes Packets
D. Updates OS

✅ Answer: A

### 63.

A Trojan:

A. Appears Legitimate
B. Encrypts Networks
C. Creates VPNs
D. Routes Traffic

✅ Answer: A

### 64.

Keyloggers are a form of:

A. Spyware
B. Firewall
C. IDS
D. Router

✅ Answer: A

### 65.

Malware injection often occurs through:

A. Repackaged Apps
B. VPN
C. Router Updates
D. DNS

✅ Answer: A

---

# Secure Storage & Cryptography

### 66.

Best place to store cryptographic keys?

A. External Storage
B. SharedPreferences
C. Android Keystore
D. Logs

✅ Answer: C

### 67.

AES is a:

A. Symmetric Algorithm
B. Asymmetric Algorithm
C. Hash Function
D. Protocol

✅ Answer: A

### 68.

RSA is:

A. Hash Function
B. Asymmetric Encryption
C. Compression Method
D. Routing Protocol

✅ Answer: B

### 69.

SHA-256 is:

A. Encryption Algorithm
B. Hash Function
C. Database
D. VPN

✅ Answer: B

### 70.

DES key length is:

A. 56-bit
B. 128-bit
C. 256-bit
D. 1024-bit

✅ Answer: A

---

# Mobile Security Tools

### 71.

Burp Suite is mainly used for:

A. Web Traffic Interception
B. Routing
C. Encryption
D. Compression

✅ Answer: A

### 72.

Wireshark captures:

A. Network Packets
B. APKs
C. Passwords Only
D. Tokens Only

✅ Answer: A

### 73.

Drozer is used for:

A. Android Security Assessment
B. VPN Setup
C. Routing
D. Database Backup

✅ Answer: A

### 74.

Genymotion is:

A. Emulator
B. Firewall
C. Router
D. IDS

✅ Answer: A

### 75.

ADB can:

A. Install APKs
B. Execute Shell Commands
C. Debug Devices
D. All of These

✅ Answer: D

---

# Mixed MCQs

### 76. Android uses ______ permissions model.

✅ Least Privilege

### 77. SSL Pinning prevents?

✅ MITM

### 78. Which attack steals session cookies?

✅ Session Hijacking

### 79. Root detection is a defense against?

✅ Rooting Attacks

### 80. Frida is mainly used in?

✅ Dynamic Analysis

### 81. APK files contain?

✅ Application Code & Resources

### 82. Android apps run in?

✅ Sandbox

### 83. Weak hashing algorithm?

✅ MD5

### 84. Secure hashing algorithm?

✅ SHA-256

### 85. Exported components may cause?

✅ Unauthorized Access

### 86. Intent Hijacking targets?

✅ Inter-App Communication

### 87. SQLite is?

✅ Embedded Database

### 88. Reverse engineering often starts with?

✅ APK Extraction

### 89. Certificate Pinning validates?

✅ Server Certificate

### 90. Runtime hooking modifies?

✅ Function Behavior

### 91. Mobile malware often steals?

✅ Credentials

### 92. Least secure storage?

✅ External Storage

### 93. Android Keystore stores?

✅ Cryptographic Keys

### 94. Burp Suite acts as?

✅ Proxy

### 95. Obfuscation reduces?

✅ Code Readability

### 96. MobSF supports?

✅ Static and Dynamic Analysis

### 97. Rooted devices increase?

✅ Attack Surface

### 98. Strong authentication includes?

✅ MFA

### 99. Sensitive data should be?

✅ Encrypted

### 100. Most common mobile attack category?

✅ Insecure Data Storage / Authentication Issues

---

# High-Probability Exam MCQs (Must Remember)

1. Android Keystore → Secure Key Storage
2. Frida → Runtime Hooking
3. JADX → APK Decompilation
4. Burp Suite → Traffic Interception
5. MobSF → Mobile Security Testing
6. SSL Pinning → MITM Protection
7. ProGuard/R8 → Obfuscation
8. Tapjacking → UI Overlay Click Attack
9. Intent Hijacking → Inter-App Communication Attack
10. M9 → Insecure Data Storage
11. M10 → Insufficient Cryptography
12. M5 → Insecure Communication
13. M1 → Improper Credential Usage
14. Content Provider → Data Sharing
15. Activity → User Interface
16. Service → Background Tasks
17. Broadcast Receiver → System Events
18. APK → Android Package Kit
19. SELinux → Mandatory Access Control
20. Sandbox → App Isolation

**Exam Tip:** Questions on **Android components (Activity, Service, Broadcast Receiver, Content Provider), Android Keystore, SSL Pinning, Frida, JADX, Burp Suite, OWASP Mobile Top 10 mappings, Tapjacking, Intent Hijacking, Reverse Engineering, and APK Repackaging** are asked very frequently in university and placement exams.
