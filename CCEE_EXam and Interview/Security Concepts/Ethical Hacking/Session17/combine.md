<!-- Theory & Lab:  Hacking Web Servers
 Web Application Vulnerabilities
 Web-Based Password Cracking Techniques
 Wireless Hacking
 WEP, WPA Authentication Mechanisms and Cracking Techniques
 Wireless Sniffers and Locating SSIDS, MAC spoofing
 Wireless hacking Techniques
 Methods used to secure Wireless Networks -->


# Ethical Hacking Notes – Web Servers, Web Applications, Password Cracking & Wireless Security

> These notes are for **education, cybersecurity awareness, defensive security, placements, university exams, and certifications**. They focus on understanding attacks and defenses rather than unauthorized exploitation.

---

# UNIT 1: HACKING WEB SERVERS

## What is a Web Server?

A web server is software/hardware that receives HTTP/HTTPS requests and serves web pages to users.

### Common Web Servers

| Web Server         | Developer              | Platform          |
| ------------------ | ---------------------- | ----------------- |
| Apache HTTP Server | Apache Foundation      | Linux/Windows     |
| Nginx              | Nginx Inc.             | Linux/Windows     |
| Microsoft IIS      | Microsoft              | Windows           |
| LiteSpeed          | LiteSpeed Technologies | Linux/Windows     |
| Tomcat             | Apache                 | Java Applications |

---

# Web Server Architecture

```text
Client Browser
      |
      v
Firewall
      |
      v
Web Server
      |
      v
Application Server
      |
      v
Database Server
```

---

# Web Server Attack Lifecycle

### 1. Information Gathering

Collect:

* Domain names
* Subdomains
* DNS records
* Technologies used
* Open ports

Examples:

* DNS Lookup
* Search Engines
* WHOIS
* Banner Grabbing

---

### 2. Footprinting

Identify:

* Operating System
* Web Server Version
* CMS
* Framework

Example:

```http
Server: Apache/2.4.58
```

---

### 3. Vulnerability Assessment

Look for:

* Misconfigurations
* Outdated software
* Weak authentication

---

### 4. Exploitation

Attackers may exploit:

* Weak passwords
* Unpatched vulnerabilities
* File upload flaws

---

### 5. Maintaining Access

Examples:

* Web Shells
* Backdoors
* Malicious accounts

---

### 6. Covering Tracks

* Delete logs
* Modify timestamps

---

# Common Web Server Vulnerabilities

## Misconfiguration

Examples:

* Directory Listing Enabled
* Default Credentials
* Exposed Backup Files

Example:

```text
backup.zip
database.sql
config.bak
```

---

## Unpatched Software

Outdated software may contain known vulnerabilities.

---

## Weak Authentication

Examples:

```text
admin/admin
root/root
123456
```

---

## Insecure File Upload

Uploading:

```text
.php
.jsp
.aspx
```

files may lead to remote code execution.

---

## Directory Traversal

Access files outside intended directory.

Example concept:

```text
../../../
```

Can expose:

* Configuration files
* Logs
* Source code

---

## Denial of Service (DoS)

Objective:

```text
Make service unavailable
```

---

# Web Server Hardening

## Security Measures

### Patch Management

Keep:

* OS
* Web Server
* CMS

updated.

---

### Disable Unnecessary Services

Remove:

* FTP
* Telnet
* Sample Applications

---

### Secure Configuration

Disable:

```text
Directory Listing
Server Signature
Version Disclosure
```

---

### HTTPS

Use:

* SSL/TLS Certificates

Benefits:

* Confidentiality
* Integrity
* Authentication

---

# Exam Tip

### CIA Triad

```text
Confidentiality
Integrity
Availability
```

Very important theory question.

---

# UNIT 2: WEB APPLICATION VULNERABILITIES

---

# What is a Web Application?

Software accessible through a browser.

Examples:

* Banking
* Shopping
* Social Media

---

# OWASP Top Risks

Remember:

```text
A01 Broken Access Control
A02 Cryptographic Failures
A03 Injection
A04 Insecure Design
A05 Security Misconfiguration
A06 Vulnerable Components
A07 Authentication Failures
A08 Software Integrity Failures
A09 Logging Failures
A10 SSRF
```

---

# SQL Injection (SQLi)

Occurs when user input becomes part of SQL query.

Impact:

* Data Theft
* Authentication Bypass
* Database Manipulation

---

# Cross Site Scripting (XSS)

Injection of malicious JavaScript.

Types:

### Stored XSS

Stored permanently.

### Reflected XSS

Returned immediately.

### DOM XSS

Client-side execution.

Impact:

* Cookie Theft
* Session Hijacking

---

# Cross Site Request Forgery (CSRF)

Victim performs actions unknowingly.

Example:

```text
Transfer money
Change password
Delete account
```

Protection:

* CSRF Tokens
* SameSite Cookies

---

# Broken Authentication

Problems:

* Weak Passwords
* Credential Stuffing
* Session Mismanagement

---

# Session Hijacking

Attacker steals:

```text
Session ID
Cookie
Token
```

---

# File Inclusion

### Local File Inclusion (LFI)

Read local files.

### Remote File Inclusion (RFI)

Load remote resources.

---

# File Upload Vulnerabilities

Dangerous uploads:

```text
Executable scripts
Web shells
Malware
```

Protection:

* Extension validation
* MIME validation
* Antivirus scanning

---

# Server Side Request Forgery (SSRF)

Server accesses unintended resources.

Targets:

* Internal systems
* Cloud metadata services

---

# Security Controls

### Input Validation

Whitelist preferred.

### Output Encoding

Prevents XSS.

### Parameterized Queries

Prevents SQL Injection.

### Least Privilege

Users receive minimum permissions.

---

# Exam Tip

Difference:

| Vulnerability | Purpose             |
| ------------- | ------------------- |
| SQLi          | Attack database     |
| XSS           | Execute scripts     |
| CSRF          | Force victim action |

Very commonly asked.

---

# UNIT 3: WEB-BASED PASSWORD CRACKING TECHNIQUES

---

# Password Cracking

Process of discovering passwords.

---

# Why Passwords Get Cracked

Weak passwords:

```text
123456
password
qwerty
admin
```

---

# Password Attack Types

## Brute Force Attack

Try every possible combination.

Pros:

* Guaranteed eventually

Cons:

* Slow

---

## Dictionary Attack

Uses wordlists.

Examples:

```text
rockyou.txt
custom lists
```

---

## Hybrid Attack

Dictionary + modifications

Examples:

```text
password123
admin@123
```

---

## Credential Stuffing

Uses leaked credentials from other breaches.

---

## Password Spraying

Try common password against many users.

Example:

```text
Welcome123
Summer2025
```

---

# Password Storage

## Plain Text

Worst practice.

---

## Hashing

Examples:

| Algorithm | Secure? |
| --------- | ------- |
| MD5       | No      |
| SHA1      | No      |
| SHA256    | Better  |
| bcrypt    | Yes     |
| Argon2    | Best    |
| PBKDF2    | Good    |

---

# Salting

Random value added before hashing.

Example:

```text
Password + Salt
```

Benefits:

* Prevents rainbow table attacks.

---

# Defenses

### Strong Password Policy

Minimum:

```text
12+ characters
Uppercase
Lowercase
Numbers
Symbols
```

---

### Multi-Factor Authentication (MFA)

Something you:

* Know
* Have
* Are

---

### Account Lockout

Example:

```text
5 failed attempts
```

Lock account temporarily.

---

# UNIT 4: WIRELESS HACKING

---

# Wireless Network Basics

Wireless communication uses:

```text
Radio Frequency (RF)
```

instead of cables.

---

# Components

| Component    | Function                 |
| ------------ | ------------------------ |
| Access Point | Provides wireless access |
| Client       | Connects to network      |
| SSID         | Network Name             |
| Router       | Routes traffic           |

---

# Wireless Standards

| Standard           | Speed              |
| ------------------ | ------------------ |
| 802.11a            | 54 Mbps            |
| 802.11b            | 11 Mbps            |
| 802.11g            | 54 Mbps            |
| 802.11n            | 600 Mbps           |
| 802.11ac           | Multi-Gbps         |
| 802.11ax (Wi-Fi 6) | Faster & Efficient |

---

# Wireless Threats

* Eavesdropping
* Rogue AP
* Evil Twin
* MAC Spoofing
* Deauthentication Attacks
* Weak Encryption

---

# WEP, WPA AND WPA2/WPA3

## WEP (Wired Equivalent Privacy)

Oldest protocol.

Uses:

```text
RC4
```

Weakness:

* Easily broken.

Status:

❌ Obsolete

---

## WPA

Improved version.

Uses:

```text
TKIP
```

Still vulnerable.

---

## WPA2

Uses:

```text
AES-CCMP
```

Most widely deployed.

---

## WPA3

Latest standard.

Benefits:

* Stronger authentication
* Better protection against password guessing

---

# Comparison Table

| Feature     | WEP | WPA    | WPA2 | WPA3      |
| ----------- | --- | ------ | ---- | --------- |
| Encryption  | RC4 | TKIP   | AES  | AES       |
| Security    | Low | Medium | High | Very High |
| Recommended | No  | No     | Yes  | Best      |

---

# Authentication Mechanisms

## Open Authentication

No password.

---

## Shared Key Authentication

Uses shared secret.

---

## WPA/WPA2 Personal

Uses:

```text
Pre-Shared Key (PSK)
```

---

## WPA/WPA2 Enterprise

Uses:

```text
802.1X
RADIUS
```

Suitable for organizations.

---

# Wireless Sniffers

Used to monitor wireless traffic.

Examples:

* Wireshark
* Kismet
* Acrylic Wi-Fi

Functions:

* Capture packets
* Detect SSIDs
* Identify channels

---

# SSID

Service Set Identifier

Example:

```text
Home_WiFi
Office_Network
```

Can be:

* Broadcast
* Hidden

---

# Locating SSIDs

Methods:

* Beacon Frames
* Probe Requests
* Wireless Scanners

---

# MAC Spoofing

Changing device MAC address.

Purpose:

* Privacy
* Bypass MAC filtering

Defense:

* WPA2/WPA3
* Network Monitoring

---

# Wireless Hacking Techniques (Conceptual)

### Rogue Access Point

Unauthorized AP installed.

---

### Evil Twin

Fake AP impersonates legitimate network.

---

### Deauthentication Attack

Disconnect users from network.

---

### Packet Sniffing

Capturing wireless traffic.

---

### Man-in-the-Middle

Intercept communications.

---

### MAC Spoofing

Impersonate authorized devices.

---

# Methods Used To Secure Wireless Networks

## Use WPA3

Best protection.

---

## Use Strong Passwords

Example:

```text
Random 16+ characters
```

---

## Disable WEP

Never use WEP.

---

## Firmware Updates

Update:

* Routers
* Access Points

---

## Guest Networks

Separate guest traffic.

---

## Network Segmentation

Separate:

* Employees
* Guests
* IoT Devices

---

## VPN

Encrypt traffic.

---

## Disable WPS

Wi-Fi Protected Setup can be abused.

---

## Monitor Wireless Activity

Use:

* IDS
* IPS
* Logs

---

# IMPORTANT EXAM POINTS

## 1 Mark Questions

* What is SSID?
* Define WEP.
* Define WPA.
* What is XSS?
* What is SQL Injection?
* What is MAC Spoofing?
* What is Session Hijacking?
* What is CSRF?

---

## 2 Mark Questions

* Difference between WEP and WPA.
* Difference between SQLi and XSS.
* Types of XSS.
* What is Password Spraying?
* What is Salting?

---

## 5 Mark Questions

* Explain Web Server Attack Methodology.
* Explain OWASP vulnerabilities.
* Explain Wireless Security Protocols.
* Explain Password Cracking Techniques.
* Explain Session Hijacking.

---

## 10 Mark Questions

* Discuss Web Application Vulnerabilities and Countermeasures.
* Explain Wireless Hacking Techniques and Security Measures.
* Compare WEP, WPA, WPA2 and WPA3.
* Explain Web Server Hardening Techniques.

---

# Memory Tricks

### Wireless Security Order

```text
WEP → WPA → WPA2 → WPA3
```

Mnemonic:

**"Weak People Prefer Protection"**

(WEP → WPA → WPA2 → WPA3)

---

### OWASP Top 10

Mnemonic:

```text
BAC IDS AILS
```

(Broken Access Control, Cryptographic Failures, etc.)

---

# 30 Important MCQs

### 1. WEP primarily uses:

A) AES
B) RC4
C) DES
D) RSA

✅ Answer: B

---

### 2. WPA2 uses:

A) RC4
B) DES
C) AES
D) MD5

✅ Answer: C

---

### 3. SQL Injection targets:

A) Browser
B) Database
C) Router
D) DNS

✅ Answer: B

---

### 4. XSS primarily executes:

A) SQL
B) PHP
C) JavaScript
D) Python

✅ Answer: C

---

### 5. CSRF forces:

A) Database access
B) Victim actions
C) DNS poisoning
D) Port scanning

✅ Answer: B

---

### 6. Hidden network name is:

A) MAC
B) SSID
C) IP
D) DNS

✅ Answer: B

---

### 7. Strongest Wi-Fi security:

A) WEP
B) WPA
C) WPA2
D) WPA3

✅ Answer: D

---

### 8. Password salting prevents:

A) Brute force entirely
B) Rainbow tables
C) Firewalls
D) IDS

✅ Answer: B

---

### 9. Session hijacking targets:

A) Cookies
B) RAM
C) BIOS
D) DNS

✅ Answer: A

---

### 10. Rogue AP is:

A) Authorized AP
B) Unauthorized AP
C) Router
D) Firewall

✅ Answer: B

---

### 11–30 Important Answers

11. Directory Traversal → Access files outside web root
12. OWASP → Open Web Application Security Project
13. HTTPS uses → TLS
14. Deauthentication attack → Disconnect users
15. Credential stuffing → Reused credentials
16. WPA Enterprise uses → 802.1X
17. WPA Personal uses → PSK
18. MAC spoofing changes → MAC Address
19. Brute force tries → All combinations
20. Dictionary attack uses → Wordlists
21. SSRF targets → Internal resources
22. LFI → Local File Inclusion
23. RFI → Remote File Inclusion
24. AES is used in → WPA2/WPA3
25. RC4 is used in → WEP
26. Wireshark is → Packet Analyzer
27. Kismet is → Wireless Sniffer
28. CIA = Confidentiality, Integrity, Availability
29. MFA = Multi-Factor Authentication
30. Strongest password storage = Argon2

---

# Last-Minute Revision Sheet

```text
WEP → RC4 → Weak
WPA → TKIP
WPA2 → AES
WPA3 → Strongest

SQLi → Database
XSS → JavaScript
CSRF → Victim Action
SSRF → Server Requests

Brute Force → All combinations
Dictionary → Wordlist
Hybrid → Both

SSID → Wi-Fi Name
MAC Spoofing → Change MAC
Rogue AP → Unauthorized AP
Evil Twin → Fake AP

Argon2 > bcrypt > PBKDF2 > SHA256 > SHA1 > MD5
```

These are the most exam-oriented points and frequently asked university questions from this entire unit.


# 100 MCQs – Web Servers, Web Application Security, Password Cracking & Wireless Security

## Web Server Security (1–25)

### 1. What is the primary function of a web server?

A. Store passwords
B. Serve web pages to clients
C. Encrypt databases
D. Route packets

✅ Answer: B

---

### 2. Which protocol is primarily used by web servers?

A. FTP
B. SMTP
C. HTTP
D. SSH

✅ Answer: C

---

### 3. Which web server is developed by Microsoft?

A. Apache
B. IIS
C. Nginx
D. Tomcat

✅ Answer: B

---

### 4. Which web server is most common on Linux systems?

A. IIS
B. Apache
C. Exchange
D. SQL Server

✅ Answer: B

---

### 5. What is banner grabbing used for?

A. Encryption
B. Finding software information
C. Password generation
D. Authentication

✅ Answer: B

---

### 6. Which attack attempts to make a server unavailable?

A. SQL Injection
B. XSS
C. DoS
D. CSRF

✅ Answer: C

---

### 7. Directory listing can expose:

A. Source code
B. Files
C. Backups
D. All of the above

✅ Answer: D

---

### 8. Default credentials are an example of:

A. Strong security
B. Misconfiguration
C. Encryption
D. Hashing

✅ Answer: B

---

### 9. Which is a web server hardening technique?

A. Using default passwords
B. Installing unnecessary services
C. Regular patching
D. Disabling firewalls

✅ Answer: C

---

### 10. HTTPS provides:

A. Confidentiality
B. Integrity
C. Authentication
D. All of the above

✅ Answer: D

---

### 11. CIA stands for:

A. Confidentiality, Integrity, Availability
B. Communication, Integrity, Access
C. Confidentiality, Internet, Availability
D. Cyber, Integrity, Access

✅ Answer: A

---

### 12. Which is NOT a web server?

A. Apache
B. Nginx
C. IIS
D. Wireshark

✅ Answer: D

---

### 13. Footprinting helps identify:

A. Operating System
B. Server Software
C. Technologies
D. All of the above

✅ Answer: D

---

### 14. Which service should be disabled if not required?

A. Telnet
B. FTP
C. Sample Applications
D. All of the above

✅ Answer: D

---

### 15. Exposed backup files may contain:

A. Credentials
B. Source code
C. Database dumps
D. All of the above

✅ Answer: D

---

### 16. A web shell is commonly used to:

A. Maintain unauthorized access
B. Encrypt traffic
C. Block attacks
D. Compress files

✅ Answer: A

---

### 17. Which port is commonly used for HTTPS?

A. 21
B. 22
C. 80
D. 443

✅ Answer: D

---

### 18. Which port is commonly used for HTTP?

A. 80
B. 443
C. 25
D. 53

✅ Answer: A

---

### 19. Vulnerability assessment aims to:

A. Identify weaknesses
B. Encrypt data
C. Create backups
D. Remove logs

✅ Answer: A

---

### 20. Directory traversal may expose:

A. Sensitive files
B. Configuration files
C. Logs
D. All of the above

✅ Answer: D

---

### 21. What is a common target of web server attacks?

A. Misconfiguration
B. Weak passwords
C. Unpatched software
D. All of the above

✅ Answer: D

---

### 22. Nginx is primarily known as:

A. Web server
B. Antivirus
C. Firewall
D. IDS

✅ Answer: A

---

### 23. Tomcat is mainly used for:

A. Java applications
B. DNS services
C. Email services
D. VPN

✅ Answer: A

---

### 24. Which phase comes first?

A. Exploitation
B. Footprinting
C. Covering tracks
D. Maintaining access

✅ Answer: B

---

### 25. TLS is used with:

A. HTTP
B. HTTPS
C. FTP
D. SMTP

✅ Answer: B

---

# Web Application Vulnerabilities (26–55)

### 26. SQL Injection targets:

A. Browser
B. Database
C. Firewall
D. Router

✅ Answer: B

---

### 27. XSS primarily executes:

A. Java
B. JavaScript
C. Python
D. SQL

✅ Answer: B

---

### 28. Stored XSS is:

A. Temporary
B. Client-side only
C. Permanently stored
D. Network attack

✅ Answer: C

---

### 29. Reflected XSS occurs:

A. Immediately in response
B. Database only
C. DNS only
D. Server only

✅ Answer: A

---

### 30. DOM XSS occurs in:

A. Database
B. Browser
C. Firewall
D. Router

✅ Answer: B

---

### 31. CSRF stands for:

A. Cross Site Request Forgery
B. Client Side Resource Failure
C. Cyber Security Request Function
D. Cross Service Routing Function

✅ Answer: A

---

### 32. CSRF protection commonly uses:

A. Tokens
B. Cookies only
C. Firewalls
D. Antivirus

✅ Answer: A

---

### 33. Session hijacking targets:

A. Session IDs
B. RAM
C. CPU
D. BIOS

✅ Answer: A

---

### 34. LFI stands for:

A. Local File Inclusion
B. Large File Injection
C. Local Form Inclusion
D. Link File Inclusion

✅ Answer: A

---

### 35. RFI stands for:

A. Remote File Inclusion
B. Random File Injection
C. Remote Form Injection
D. Remote Firewall Inclusion

✅ Answer: A

---

### 36. SSRF stands for:

A. Server Side Request Forgery
B. Secure Side Request Format
C. Server Security Routing Function
D. Secure Server Request Firewall

✅ Answer: A

---

### 37. Parameterized queries help prevent:

A. SQL Injection
B. XSS
C. DoS
D. CSRF

✅ Answer: A

---

### 38. Which is an OWASP risk?

A. Broken Access Control
B. Cryptographic Failures
C. Injection
D. All of the above

✅ Answer: D

---

### 39. XSS can steal:

A. Cookies
B. Sessions
C. Tokens
D. All of the above

✅ Answer: D

---

### 40. Least privilege means:

A. Maximum permissions
B. Minimum required permissions
C. Guest access
D. Anonymous access

✅ Answer: B

---

### 41. Input validation should preferably use:

A. Blacklist
B. Whitelist
C. Both
D. None

✅ Answer: B

---

### 42. Broken authentication involves:

A. Weak passwords
B. Session issues
C. Poor login controls
D. All of the above

✅ Answer: D

---

### 43. SQL Injection belongs to:

A. Injection attacks
B. Network attacks
C. Physical attacks
D. Social engineering

✅ Answer: A

---

### 44. Output encoding helps prevent:

A. XSS
B. SQLi
C. DoS
D. SSRF

✅ Answer: A

---

### 45. File upload vulnerabilities may lead to:

A. Code execution
B. Malware upload
C. Server compromise
D. All of the above

✅ Answer: D

---

### 46. Which vulnerability abuses trust of a logged-in user?

A. CSRF
B. SQLi
C. XSS
D. DoS

✅ Answer: A

---

### 47. Which attack directly targets database queries?

A. XSS
B. SQLi
C. CSRF
D. SSRF

✅ Answer: B

---

### 48. SSRF may access:

A. Internal systems
B. Cloud metadata
C. Internal APIs
D. All of the above

✅ Answer: D

---

### 49. OWASP stands for:

A. Open Web Application Security Project
B. Open Wireless Application Security Program
C. Online Web Application Security Project
D. Open Web Access Security Platform

✅ Answer: A

---

### 50. Which vulnerability executes scripts in victim browser?

A. SQLi
B. XSS
C. CSRF
D. LFI

✅ Answer: B

---

### 51. Which attack may read local files?

A. LFI
B. XSS
C. SQLi
D. CSRF

✅ Answer: A

---

### 52. Authentication failures relate to:

A. Login security
B. Routing
C. DNS
D. Encryption only

✅ Answer: A

---

### 53. Security misconfiguration is an OWASP category.

A. True
B. False

✅ Answer: A

---

### 54. Session IDs should be:

A. Predictable
B. Random
C. Sequential
D. Numeric only

✅ Answer: B

---

### 55. Which is NOT an OWASP category?

A. Injection
B. Broken Access Control
C. SQL Server
D. SSRF

✅ Answer: C

---

# Password Cracking (56–75)

### 56. Brute force attack tries:

A. Common passwords
B. Every combination
C. Dictionary only
D. Tokens only

✅ Answer: B

### 57. Dictionary attack uses:

A. Wordlists
B. Random packets
C. Encryption keys
D. Cookies

✅ Answer: A

### 58. Credential stuffing uses:

A. Stolen credentials
B. New passwords
C. Biometrics
D. Captchas

✅ Answer: A

### 59. Password spraying uses:

A. One password against many accounts
B. Many passwords on one account
C. Encryption
D. Hashing

✅ Answer: A

### 60. Strongest password hashing algorithm among these:

A. MD5
B. SHA1
C. bcrypt
D. Argon2

✅ Answer: D

### 61. MD5 is considered:

A. Secure
B. Broken
C. Quantum-safe
D. Recommended

✅ Answer: B

### 62. Salting helps prevent:

A. Rainbow table attacks
B. Firewalls
C. Routing
D. Scanning

✅ Answer: A

### 63. MFA stands for:

A. Multi-Factor Authentication
B. Multiple File Access
C. Managed Firewall Access
D. Manual Factor Authentication

✅ Answer: A

### 64. Account lockout helps prevent:

A. Brute-force attacks
B. Routing attacks
C. DoS
D. XSS

✅ Answer: A

### 65. Plain-text password storage is:

A. Secure
B. Insecure
C. Recommended
D. Encrypted

✅ Answer: B

### 66. bcrypt is a:

A. Hashing algorithm
B. Encryption protocol
C. Firewall
D. IDS

✅ Answer: A

### 67. SHA1 is:

A. Strongly recommended
B. Deprecated
C. MFA
D. Cipher suite

✅ Answer: B

### 68. Hybrid attack combines:

A. Dictionary + Modifications
B. XSS + SQLi
C. WEP + WPA
D. MFA + IDS

✅ Answer: A

### 69. Password complexity improves:

A. Security
B. Routing
C. DNS
D. Logging

✅ Answer: A

### 70. Which is strongest?

A. password
B. admin123
C. P@ssw0rd!
D. T7#kP!9@Lm$2Qz8

✅ Answer: D

### 71. Argon2 is designed for:

A. Password hashing
B. Routing
C. DNS
D. Email

✅ Answer: A

### 72. PBKDF2 is:

A. Password hashing algorithm
B. Web server
C. Browser
D. Firewall

✅ Answer: A

### 73. Password reuse increases risk of:

A. Credential stuffing
B. Routing
C. DNS poisoning
D. NAT

✅ Answer: A

### 74. Strong passwords should ideally be:

A. Short
B. Predictable
C. Long and complex
D. Username-based

✅ Answer: C

### 75. MFA requires:

A. One factor
B. Two or more factors
C. Password only
D. Biometrics only

✅ Answer: B

---

# Wireless Security (76–100)

### 76. SSID stands for:

A. Service Set Identifier
B. Secure Service Identifier
C. System Set ID
D. Service Security ID

✅ Answer: A

### 77. WEP uses:

A. AES
B. RC4
C. RSA
D. DES

✅ Answer: B

### 78. WPA uses:

A. TKIP
B. AES only
C. RC5
D. SHA256

✅ Answer: A

### 79. WPA2 primarily uses:

A. AES-CCMP
B. RC4
C. DES
D. MD5

✅ Answer: A

### 80. WPA3 is:

A. Weakest
B. Strongest
C. Same as WEP
D. Obsolete

✅ Answer: B

### 81. Wireless communication uses:

A. Fiber
B. Radio waves
C. Coaxial cable
D. Satellite only

✅ Answer: B

### 82. Access Point provides:

A. Wireless connectivity
B. Encryption only
C. DNS only
D. Logging only

✅ Answer: A

### 83. MAC spoofing changes:

A. IP Address
B. Domain Name
C. MAC Address
D. DNS

✅ Answer: C

### 84. Rogue Access Point is:

A. Authorized AP
B. Unauthorized AP
C. Router
D. Firewall

✅ Answer: B

### 85. Evil Twin is:

A. Fake AP
B. Firewall
C. IDS
D. VPN

✅ Answer: A

### 86. Deauthentication attack aims to:

A. Disconnect users
B. Encrypt traffic
C. Hash passwords
D. Route packets

✅ Answer: A

### 87. Wireshark is:

A. Packet Analyzer
B. Firewall
C. Web Server
D. Antivirus

✅ Answer: A

### 88. Kismet is:

A. Wireless Sniffer
B. Database
C. Router
D. Browser

✅ Answer: A

### 89. Hidden SSID means:

A. Not broadcast publicly
B. Encrypted
C. Deleted
D. Disabled

✅ Answer: A

### 90. WPA Enterprise commonly uses:

A. RADIUS
B. FTP
C. DNS
D. SMTP

✅ Answer: A

### 91. WPA Personal uses:

A. PSK
B. DNS
C. SMTP
D. FTP

✅ Answer: A

### 92. WPS stands for:

A. Wi-Fi Protected Setup
B. Wireless Protection Service
C. Web Protection System
D. Wireless Packet Security

✅ Answer: A

### 93. Which Wi-Fi security protocol should be avoided?

A. WPA3
B. WPA2
C. WPA
D. WEP

✅ Answer: D

### 94. 802.1X is used for:

A. Enterprise Authentication
B. DNS
C. NAT
D. HTTP

✅ Answer: A

### 95. Guest networks help:

A. Segregate users
B. Reduce security
C. Disable encryption
D. Increase attacks

✅ Answer: A

### 96. VPN primarily provides:

A. Encryption
B. MAC filtering
C. Routing only
D. DNS resolution

✅ Answer: A

### 97. Firmware updates improve:

A. Security
B. Stability
C. Bug fixes
D. All of the above

✅ Answer: D

### 98. Strong Wi-Fi passwords should be:

A. Short
B. Predictable
C. Complex
D. Dictionary words

✅ Answer: C

### 99. Best wireless security protocol today:

A. WEP
B. WPA
C. WPA2
D. WPA3

✅ Answer: D

### 100. Which provides the highest security?

A. WPA2-PSK
B. WPA3
C. Open Authentication
D. WEP

✅ Answer: B

---

# Most Important Exam MCQs (Repeated Frequently)

1. WEP uses → **RC4**
2. WPA uses → **TKIP**
3. WPA2 uses → **AES-CCMP**
4. WPA3 → **Strongest Wi-Fi Security**
5. SQL Injection → **Database Attack**
6. XSS → **JavaScript Execution**
7. CSRF → **Victim Performs Action**
8. SSRF → **Server Makes Request**
9. LFI → **Read Local Files**
10. Session Hijacking → **Steal Session ID**
11. Credential Stuffing → **Reuse Leaked Passwords**
12. Password Spraying → **One Password, Many Users**
13. MFA → **Multiple Authentication Factors**
14. Argon2 → **Best Password Hashing**
15. CIA → **Confidentiality, Integrity, Availability**
