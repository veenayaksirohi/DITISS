<!--Theory: 
 Password-Cracking Countermeasures
 Active/Passive online Attacks
 Offline Attacks
 Keyloggers and other Spyware Technologies
 Trojans and Backdoors
 Overt and Covert Channels
 Types of Trojans
 Reverse-connecting Trojans
 Netcat Trojan
 Indications of a Trojan Attacks -->


# Password Cracking, Trojans, Spyware & Attack Techniques – Complete Notes

---

# 1. Password-Cracking Countermeasures

Password cracking is the process of recovering passwords using guessing, brute force, dictionary attacks, credential theft, or hash cracking.

## Password Security Principles

### Strong Password Characteristics

* Minimum 12–16 characters
* Uppercase and lowercase letters
* Numbers
* Special characters
* Not based on dictionary words
* Not reused across websites

Example:

❌ password123

❌ admin@123

✅ T!g3r#Sky$92Moon

---

## Countermeasures

### 1. Password Complexity Policy

Require:

* Uppercase
* Lowercase
* Numbers
* Special characters

Example:

P@ssW0rd#2026

---

### 2. Multi-Factor Authentication (MFA)

Uses:

* Password
* OTP
* Hardware Token
* Biometric

Even if password is stolen, attacker cannot login.

---

### 3. Account Lockout Policy

Example:

After 5 failed login attempts:

* Account locked for 15 minutes

Prevents brute force attacks.

---

### 4. Password Hashing

Passwords should never be stored in plaintext.

Store:

```text
Password → Hash Function → Hash Value
```

Algorithms:

* bcrypt
* scrypt
* Argon2
* PBKDF2

Avoid:

* MD5
* SHA1

---

### 5. Password Salting

Adds random data before hashing.

```text
Password + Salt → Hash
```

Protects against:

* Rainbow tables
* Precomputed attacks

---

### 6. Password Managers

Examples:

* Bitwarden
* KeePass
* 1Password

Generate and store strong passwords.

---

### 7. User Awareness Training

Educate users against:

* Phishing
* Fake login pages
* Social engineering

---

# 2. Active Online Attacks

Attacker directly interacts with target.

## Characteristics

* Generates traffic
* Detectable
* May modify systems

---

## Examples

### Brute Force Attack

Try all combinations.

```text
admin
admin1
admin12
admin123
```

---

### Dictionary Attack

Uses wordlists.

Example:

```text
password
welcome
india123
football
```

---

### Credential Stuffing

Uses leaked credentials from other websites.

---

### Password Spraying

Uses common password against many accounts.

Example:

```text
Password = Welcome123

user1
user2
user3
user4
```

---

### Online Guessing Attack

Repeated login attempts against live service.

---

# 3. Passive Online Attacks

Attacker only observes.

No direct interaction.

Hard to detect.

---

## Examples

### Packet Sniffing

Capturing network packets.

Tools:

* Wireshark
* tcpdump

---

### Traffic Analysis

Analyzing communication patterns.

---

### Shoulder Surfing

Watching user type password.

---

### Eavesdropping

Listening to communications.

---

# Active vs Passive Attack

| Feature           | Active      | Passive  |
| ----------------- | ----------- | -------- |
| Modifies Data     | Yes         | No       |
| Generates Traffic | Yes         | No       |
| Easy to Detect    | Yes         | No       |
| Example           | Brute Force | Sniffing |

---

# 4. Offline Attacks

Performed without interacting with target system.

Usually faster.

---

## How It Works

Attacker steals:

* Password hashes
* Password database

Then cracks locally.

---

## Examples

### Hash Cracking

Tools:

* Hashcat
* John the Ripper

---

### Dictionary Attack

Against stolen hashes.

---

### Rainbow Table Attack

Uses precomputed hashes.

Prevented by salting.

---

### GPU Cracking

Uses powerful GPUs.

Millions or billions of guesses per second.

---

# Online vs Offline Attack

| Feature             | Online | Offline      |
| ------------------- | ------ | ------------ |
| Needs Target Access | Yes    | No           |
| Speed               | Slow   | Fast         |
| Detectable          | Yes    | No           |
| Lockout Protection  | Works  | Doesn't Work |

---

# 5. Keyloggers and Spyware Technologies

## Keylogger

Records keystrokes.

Captures:

* Passwords
* Emails
* Banking credentials

---

## Types of Keyloggers

### Hardware Keylogger

Physical device between:

```text
Keyboard → Computer
```

Captures all keystrokes.

---

### Software Keylogger

Installed on OS.

Runs secretly.

---

### Kernel Keylogger

Runs in kernel mode.

Highly dangerous.

---

### Browser Keylogger

Captures browser activity.

---

## Spyware

Software that secretly monitors users.

Collects:

* Browsing history
* Passwords
* Screenshots
* Personal information

---

## Spyware Types

### Adware

Shows advertisements.

---

### Tracking Cookies

Track user behavior.

---

### Information Stealers

Steal:

* Passwords
* Banking data

---

### Screen Capturers

Take screenshots secretly.

---

# Symptoms of Spyware

* Slow system
* High CPU usage
* Pop-ups
* Browser redirects
* Unknown programs

---

# Prevention

* Antivirus
* Anti-spyware
* Software updates
* MFA
* Avoid suspicious downloads

---

# 6. Trojans and Backdoors

## Trojan Horse

Malware disguised as legitimate software.

Named after the ancient Trojan Horse.

---

## Characteristics

* Appears legitimate
* User installs it
* Creates unauthorized access

---

## Trojan Lifecycle

```text
Delivery
↓
Execution
↓
Installation
↓
Persistence
↓
Malicious Activity
```

---

## Backdoor

Secret method of bypassing authentication.

Allows attacker access.

---

## Backdoor Capabilities

* Remote control
* File access
* Data theft
* Command execution

---

# 7. Overt and Covert Channels

## Overt Channel

Legitimate communication path.

Examples:

* HTTP
* HTTPS
* FTP
* Email

---

## Covert Channel

Hidden communication channel.

Used to secretly transfer data.

---

## Types

### Storage Covert Channel

Stores hidden information.

Example:

* Hidden file attributes

---

### Timing Covert Channel

Encodes data through timing variations.

Example:

```text
1 second delay = 0
2 second delay = 1
```

---

# Overt vs Covert

| Feature    | Overt | Covert    |
| ---------- | ----- | --------- |
| Visible    | Yes   | Hidden    |
| Legitimate | Yes   | No        |
| Detection  | Easy  | Difficult |

---

# 8. Types of Trojans

---

## Remote Access Trojan (RAT)

Provides full remote control.

Examples historically include:

* DarkComet
* Poison Ivy

---

## Banking Trojan

Steals banking credentials.

---

## Downloader Trojan

Downloads more malware.

---

## Spy Trojan

Spies on user activities.

---

## Rootkit Trojan

Hides malware from system.

---

## DDoS Trojan

Used in botnets.

Launches attacks.

---

## Fake Antivirus Trojan

Pretends to be antivirus.

Shows fake alerts.

---

## Ransomware Trojan

Encrypts files.

Demands ransom.

---

## Game-Thief Trojan

Steals gaming credentials.

---

## Bot Trojan

Makes victim part of botnet.

---

# 9. Reverse-Connecting Trojans

Traditional Trojan:

```text
Victim ← Attacker connects
```

Blocked by NAT/firewalls.

---

## Reverse Trojan

Victim initiates connection.

```text
Victim → Attacker
```

Benefits attacker:

* Bypasses NAT
* Bypasses firewalls
* Easier remote control

---

## Process

```text
Trojan Installed
↓
Victim Connects To Attacker
↓
Attacker Gains Control
```

---

# Why Dangerous?

Most firewalls allow outbound connections.

Reverse Trojans exploit this.

---

# 10. Netcat Trojan

## What is Netcat?

Often called:

"The Swiss Army Knife of Networking"

Commonly used for:

* Debugging
* Port testing
* Network troubleshooting

---

## Legitimate Features

* Port listening
* Data transfer
* Banner grabbing

---

## Abuse by Attackers

Can be used to create unauthorized remote shells if misused.

Example concept:

```text
Victim System
↓
Remote Shell
↓
Attacker Access
```

This is why security teams monitor unauthorized Netcat usage.

---

# Detection of Netcat Abuse

* Unknown listening ports
* Suspicious processes
* Outbound connections
* IDS/IPS alerts

---

# Prevention

* Endpoint security
* Process monitoring
* Firewall restrictions
* Application whitelisting

---

# 11. Indications of Trojan Attacks

## System Indicators

### Slow Performance

CPU and RAM usage increase.

---

### Frequent Crashes

Applications crash unexpectedly.

---

### Unknown Processes

Strange running programs.

---

### Disabled Security Tools

Antivirus stops working.

---

### New Startup Entries

Unknown programs auto-start.

---

## Network Indicators

### Unusual Traffic

Unexpected outbound connections.

---

### High Bandwidth Usage

Malware communicating externally.

---

### Unknown Open Ports

Backdoor services running.

---

## User Indicators

### Pop-Ups

Unexpected advertisements.

---

### File Changes

Files modified or deleted.

---

### Unauthorized Activity

Messages sent without user knowledge.

---

# Exam Tips

### Remember

**Active Attack = Alter**

**Passive Attack = Observe**

---

**Online Attack = Against Live Service**

**Offline Attack = Against Stolen Hashes**

---

**Trojan = Disguised Malware**

---

**Backdoor = Hidden Access**

---

**Keylogger = Records Keys**

---

**Spyware = Collects Information**

---

**RAT = Full Remote Control**

---

**Reverse Trojan = Victim Connects To Attacker**

---

**Overt = Visible**

**Covert = Hidden**

---

# Important One-Line Definitions

### Trojan

Malware disguised as legitimate software.

### Backdoor

Secret access method bypassing authentication.

### Keylogger

Software or hardware that records keystrokes.

### Spyware

Software that secretly monitors user activities.

### Active Attack

Attack that alters systems or data.

### Passive Attack

Attack that only observes communications.

### Offline Attack

Password attack performed without interacting with target.

### Overt Channel

Legitimate communication path.

### Covert Channel

Hidden communication path.

---

# Frequently Asked Exam MCQs

### 1. Which attack is hardest to detect?

A. Brute Force
B. Dictionary Attack
C. Passive Attack
D. Password Spraying

✅ C

---

### 2. Which attack uses stolen password hashes?

A. Online Attack
B. Offline Attack
C. Phishing
D. Sniffing

✅ B

---

### 3. Which malware records keystrokes?

A. Worm
B. Trojan
C. Keylogger
D. Rootkit

✅ C

---

### 4. Which technique prevents rainbow table attacks?

A. Encryption
B. Salting
C. Compression
D. Encoding

✅ B

---

### 5. A Trojan disguised as useful software is called?

A. Spyware
B. Adware
C. Trojan Horse
D. Rootkit

✅ C

---

### 6. Reverse-connecting Trojans primarily help bypass?

A. Antivirus
B. NAT/Firewall Restrictions
C. BIOS
D. CPU

✅ B

---

### 7. Which is an example of a passive attack?

A. Brute Force
B. SQL Injection
C. Sniffing
D. Password Spraying

✅ C

---

### 8. Which Trojan gives complete remote control?

A. RAT
B. Spy Trojan
C. Banking Trojan
D. Downloader Trojan

✅ A

---

### 9. Covert channels are used for?

A. Printing documents
B. Hidden communication
C. Login authentication
D. Password hashing

✅ B

---

### 10. Which is NOT spyware?

A. Adware
B. Keylogger
C. RAT
D. Tracking Cookie

✅ C

---

# Last-Minute Revision Sheet (2 Marks)

* Password Salting → Prevents Rainbow Tables
* MFA → Best Password Protection
* Active Attack → Modifies Data
* Passive Attack → Observes Data
* Offline Attack → Cracks Stolen Hashes
* Keylogger → Records Keystrokes
* Spyware → Steals Information
* Trojan → Disguised Malware
* RAT → Remote Access Trojan
* Backdoor → Hidden Entry
* Reverse Trojan → Victim Initiates Connection
* Overt Channel → Legitimate Communication
* Covert Channel → Secret Communication
* Netcat → Networking Utility Often Misused for Unauthorized Remote Access
* Trojan Indicators → Unknown Processes, Open Ports, Slow System, High Network Traffic

These points cover the theory, university exams, viva questions, placement tests, and cybersecurity certification basics for this entire unit.


# 100 MCQs – Password Cracking, Spyware, Trojans, Backdoors & Attack Techniques

## 1. Password cracking is the process of:

A. Encrypting passwords
B. Recovering or guessing passwords
C. Deleting passwords
D. Hashing passwords

✅ Answer: B

---

## 2. Which attack tries every possible password combination?

A. Dictionary Attack
B. Brute Force Attack
C. Sniffing Attack
D. Phishing

✅ Answer: B

---

## 3. A dictionary attack uses:

A. Stolen cookies
B. Wordlists of common passwords
C. Malware
D. Encryption keys

✅ Answer: B

---

## 4. Password spraying uses:

A. Many passwords against one account
B. One common password against many accounts
C. SQL Injection
D. Keyloggers

✅ Answer: B

---

## 5. Credential stuffing relies on:

A. Rainbow tables
B. Leaked username-password pairs
C. Network sniffing
D. DDoS

✅ Answer: B

---

## 6. Which is the strongest password?

A. admin123
B. Password@1
C. T!g3r#Moon$92Sky
D. abc123

✅ Answer: C

---

## 7. MFA stands for:

A. Multi-Factor Authentication
B. Multiple Firewall Access
C. Managed File Authentication
D. Main Function Access

✅ Answer: A

---

## 8. Which is an authentication factor?

A. Password
B. OTP
C. Fingerprint
D. All of the above

✅ Answer: D

---

## 9. Account lockout policies primarily prevent:

A. SQL Injection
B. Brute Force Attacks
C. XSS
D. Sniffing

✅ Answer: B

---

## 10. Passwords should be stored as:

A. Plaintext
B. Encoded text
C. Hashes
D. Images

✅ Answer: C

---

# Active & Passive Attacks

## 11. Active attacks:

A. Only monitor traffic
B. Modify or disrupt systems
C. Are always legal
D. Never generate traffic

✅ B

---

## 12. Passive attacks:

A. Modify data
B. Destroy systems
C. Observe communications
D. Delete logs

✅ C

---

## 13. Which is an active attack?

A. Sniffing
B. Eavesdropping
C. Brute Force
D. Traffic Analysis

✅ C

---

## 14. Which is a passive attack?

A. Password Spraying
B. Sniffing
C. SQL Injection
D. DDoS

✅ B

---

## 15. Passive attacks are difficult to detect because:

A. They modify files
B. They generate high traffic
C. They only observe activity
D. They crash systems

✅ C

---

## 16. Eavesdropping means:

A. Listening to communications
B. Cracking passwords
C. Installing malware
D. Encrypting files

✅ A

---

## 17. Shoulder surfing is:

A. Watching a user enter credentials
B. Cracking hashes
C. Packet sniffing
D. DDoS

✅ A

---

## 18. Traffic analysis examines:

A. User passwords
B. Communication patterns
C. Encryption keys
D. BIOS settings

✅ B

---

## 19. Which attack directly interacts with the target?

A. Passive Attack
B. Active Attack
C. Sniffing
D. Monitoring

✅ B

---

## 20. Packet sniffing is usually:

A. Active
B. Passive
C. Physical
D. Wireless only

✅ B

---

# Offline Attacks

## 21. Offline attacks are performed:

A. Against a live login page
B. Without interacting with the target system
C. Through phishing
D. Through DDoS

✅ B

---

## 22. Offline attacks commonly target:

A. Password hashes
B. Firewalls
C. Routers
D. Printers

✅ A

---

## 23. Which tool is commonly used for password hash cracking?

A. Wireshark
B. Hashcat
C. Burp Suite
D. Nmap

✅ B

---

## 24. Another password cracking tool is:

A. Nessus
B. Metasploit
C. John the Ripper
D. Aircrack

✅ C

---

## 25. Offline attacks are generally:

A. Slower than online attacks
B. Faster than online attacks
C. Impossible
D. Easier to detect

✅ B

---

## 26. Which protection does NOT help against offline attacks?

A. Account Lockout
B. Strong Hashing
C. Salting
D. MFA

✅ A

---

## 27. Rainbow tables are used to:

A. Encrypt passwords
B. Crack password hashes
C. Capture packets
D. Scan ports

✅ B

---

## 28. Salting protects against:

A. SQL Injection
B. Rainbow Tables
C. XSS
D. DDoS

✅ B

---

## 29. GPU cracking increases:

A. Storage
B. Password cracking speed
C. Encryption strength
D. Firewall security

✅ B

---

## 30. Offline attacks require:

A. Password database or hashes
B. Admin rights only
C. Physical access only
D. BIOS access

✅ A

---

# Keyloggers & Spyware

## 31. A keylogger records:

A. Mouse movements only
B. Keystrokes
C. Packets
D. Images

✅ B

---

## 32. Hardware keyloggers are:

A. Software applications
B. Physical devices
C. Browsers
D. Drivers

✅ B

---

## 33. Software keyloggers operate:

A. Inside the operating system
B. Inside RAM only
C. In BIOS only
D. In routers

✅ A

---

## 34. Kernel keyloggers operate in:

A. User mode
B. Browser mode
C. Kernel mode
D. Safe mode

✅ C

---

## 35. Spyware is designed to:

A. Improve performance
B. Monitor users secretly
C. Encrypt files
D. Block websites

✅ B

---

## 36. Adware mainly:

A. Shows unwanted advertisements
B. Encrypts data
C. Creates users
D. Scans ports

✅ A

---

## 37. Tracking cookies are used to:

A. Track user behavior
B. Delete files
C. Encrypt traffic
D. Crack passwords

✅ A

---

## 38. Information stealers target:

A. Passwords and personal data
B. CPU performance
C. Printers
D. Firewalls

✅ A

---

## 39. Spyware symptoms include:

A. Slow system performance
B. Pop-ups
C. Browser redirects
D. All of the above

✅ D

---

## 40. Anti-spyware software helps:

A. Detect spyware
B. Create spyware
C. Spread malware
D. Encrypt disks

✅ A

---

# Trojans & Backdoors

## 41. A Trojan is:

A. Self-replicating malware
B. Malware disguised as legitimate software
C. Firewall software
D. Antivirus

✅ B

---

## 42. Trojans are named after:

A. Greek Mythology's Trojan Horse
B. Roman Empire
C. Linux Kernel
D. TCP/IP

✅ A

---

## 43. A backdoor provides:

A. Secret unauthorized access
B. Encryption
C. Backup storage
D. Firewall protection

✅ A

---

## 44. Which malware often creates backdoors?

A. Trojan
B. Cookie
C. Driver
D. BIOS

✅ A

---

## 45. Trojans usually require:

A. User execution
B. No interaction
C. Hardware installation only
D. Root access first

✅ A

---

## 46. Trojan lifecycle starts with:

A. Delivery
B. Encryption
C. Cracking
D. Logging

✅ A

---

## 47. Persistence means:

A. Malware remains active after reboot
B. Malware self-destructs
C. Password reset
D. Data backup

✅ A

---

## 48. Backdoors can allow:

A. File access
B. Remote control
C. Command execution
D. All of the above

✅ D

---

## 49. Which malware pretends to be useful software?

A. Worm
B. Trojan
C. Rootkit
D. Adware

✅ B

---

## 50. Trojans primarily rely on:

A. Social Engineering
B. Routing
C. DNS
D. Encryption

✅ A

---

# Overt & Covert Channels

## 51. Overt channels are:

A. Hidden channels
B. Legitimate communication channels
C. Illegal protocols
D. Malware

✅ B

---

## 52. HTTP is an example of:

A. Covert Channel
B. Overt Channel
C. Malware
D. Rootkit

✅ B

---

## 53. A covert channel is:

A. Secret communication path
B. Secure VPN
C. Firewall rule
D. Antivirus

✅ A

---

## 54. Storage covert channels hide data using:

A. Stored resources
B. TCP ports only
C. Passwords
D. DNS only

✅ A

---

## 55. Timing covert channels hide information through:

A. Encryption
B. Time delays
C. Compression
D. Hashing

✅ B

---

## 56. Covert channels are generally:

A. Easy to detect
B. Difficult to detect
C. Visible to users
D. Legitimate

✅ B

---

## 57. HTTPS is usually:

A. Overt Channel
B. Covert Channel
C. Malware
D. Trojan

✅ A

---

## 58. FTP is an example of:

A. Overt Communication
B. Spyware
C. RAT
D. Rootkit

✅ A

---

## 59. Covert channels may be used for:

A. Data Exfiltration
B. Password Storage
C. MFA
D. Backup

✅ A

---

## 60. Overt channels are:

A. Visible and legitimate
B. Hidden and malicious
C. Hardware only
D. Wireless only

✅ A

---

# Types of Trojans

## 61. RAT stands for:

A. Remote Access Trojan
B. Remote Admin Terminal
C. Rapid Attack Tool
D. Root Access Tool

✅ A

---

## 62. RATs provide:

A. Full remote control
B. Encryption only
C. Antivirus scanning
D. Packet filtering

✅ A

---

## 63. Banking Trojans target:

A. Banking credentials
B. Printers
C. Routers
D. BIOS

✅ A

---

## 64. Downloader Trojans:

A. Download additional malware
B. Remove malware
C. Encrypt traffic
D. Delete cookies

✅ A

---

## 65. Spy Trojans focus on:

A. Monitoring activities
B. Updating software
C. Routing traffic
D. Blocking websites

✅ A

---

## 66. Rootkit Trojans primarily:

A. Hide malware presence
B. Encrypt disks
C. Scan ports
D. Create backups

✅ A

---

## 67. DDoS Trojans participate in:

A. Botnet attacks
B. Encryption
C. Password hashing
D. MFA

✅ A

---

## 68. Fake antivirus Trojans:

A. Display false security alerts
B. Protect systems
C. Encrypt files
D. Update drivers

✅ A

---

## 69. Ransomware Trojans:

A. Encrypt victim files
B. Improve security
C. Monitor traffic
D. Compress files

✅ A

---

## 70. Bot Trojans make victims part of a:

A. VPN
B. Botnet
C. Firewall
D. Database

✅ B

---

# Reverse-Connecting Trojans

## 71. Reverse Trojans connect:

A. Attacker → Victim
B. Victim → Attacker
C. Router → ISP
D. Browser → DNS

✅ B

---

## 72. Reverse connections help bypass:

A. NAT and Firewalls
B. CPUs
C. RAM
D. SSDs

✅ A

---

## 73. Most firewalls allow:

A. Outbound traffic
B. Inbound malware
C. SQL Injection
D. BIOS updates

✅ A

---

## 74. Reverse shells are often associated with:

A. Reverse Trojans
B. Cookies
C. Hashing
D. MFA

✅ A

---

## 75. Reverse Trojans are dangerous because:

A. Victims initiate the connection
B. Passwords are strong
C. Firewalls stop them always
D. They cannot communicate

✅ A

---

# Netcat Trojan

## 76. Netcat is known as:

A. Swiss Army Knife of Networking
B. Trojan Horse
C. RAT Creator
D. Firewall

✅ A

---

## 77. Netcat can be used legitimately for:

A. Network troubleshooting
B. Port testing
C. Data transfer
D. All of the above

✅ D

---

## 78. Netcat abuse may create:

A. Remote shells
B. Password managers
C. MFA systems
D. VPNs

✅ A

---

## 79. Netcat can listen on:

A. Network ports
B. BIOS
C. RAM
D. GPU

✅ A

---

## 80. Security teams monitor Netcat because it can be:

A. Misused by attackers
B. Antivirus software
C. Encryption software
D. Backup software

✅ A

---

# Indications of Trojan Attacks

## 81. A common Trojan symptom is:

A. Faster system performance
B. Slow system performance
C. Increased storage space
D. Better security

✅ B

---

## 82. Unknown processes may indicate:

A. Trojan infection
B. Normal operation only
C. Strong passwords
D. MFA

✅ A

---

## 83. Frequent crashes may suggest:

A. Malware activity
B. Firewall updates
C. Password resets
D. MFA

✅ A

---

## 84. Disabled antivirus software may indicate:

A. Trojan attack
B. Normal operation
C. DNS issue
D. Browser issue

✅ A

---

## 85. Unknown startup entries are:

A. Potential malware indicators
B. Password hashes
C. Firewalls
D. Routers

✅ A

---

## 86. Unusual outbound traffic can indicate:

A. Malware communication
B. MFA
C. Encryption
D. Salting

✅ A

---

## 87. High bandwidth usage may suggest:

A. Data exfiltration
B. Password hashing
C. BIOS update
D. Screen saver

✅ A

---

## 88. Unknown open ports may indicate:

A. Backdoor services
B. Strong security
C. MFA
D. Encryption

✅ A

---

## 89. Unauthorized account activity may indicate:

A. Trojan compromise
B. Password complexity
C. Salting
D. Encryption

✅ A

---

## 90. Unexpected pop-ups are often associated with:

A. Malware infection
B. Hashing
C. MFA
D. VPN

✅ A

---

# Mixed Revision MCQs

## 91. Which attack only observes data?

A. Passive Attack
B. Active Attack
C. Brute Force
D. SQL Injection

✅ A

---

## 92. Which malware steals banking credentials?

A. Banking Trojan
B. Rootkit
C. Worm
D. Cookie

✅ A

---

## 93. Which defense protects against rainbow tables?

A. Salting
B. Cookies
C. Routing
D. FTP

✅ A

---

## 94. Which Trojan downloads other malware?

A. Downloader Trojan
B. Banking Trojan
C. Spy Trojan
D. RAT

✅ A

---

## 95. Which malware records keystrokes?

A. RAT
B. Keylogger
C. Rootkit
D. Worm

✅ B

---

## 96. Which channel hides communication?

A. Overt Channel
B. Covert Channel
C. HTTP
D. HTTPS

✅ B

---

## 97. Which Trojan gives remote control?

A. RAT
B. Cookie
C. Adware
D. Tracking Cookie

✅ A

---

## 98. Which attack commonly uses stolen hashes?

A. Offline Attack
B. DDoS
C. Phishing
D. Shoulder Surfing

✅ A

---

## 99. Which tool is used for password hash cracking?

A. Wireshark
B. Hashcat
C. Nmap
D. Burp Suite

✅ B

---

## 100. Which statement is correct?

A. Passive attacks modify data
B. Trojans are always visible
C. Reverse Trojans connect from victim to attacker
D. Salting weakens password security

✅ C

---

# Most Important Exam MCQs (Very Frequently Asked)

1. Difference between Active and Passive Attack
2. Online vs Offline Password Attack
3. Salting prevents ______ Attack → Rainbow Table
4. Trojan vs Worm
5. RAT Full Form → Remote Access Trojan
6. Backdoor Purpose → Unauthorized Access
7. Keylogger Function → Capture Keystrokes
8. Reverse Trojan Connection Direction → Victim → Attacker
9. Netcat Nickname → Swiss Army Knife of Networking
10. Strongest Password Protection → MFA + Strong Password + Salting + Hashing

These 100 MCQs cover nearly all university, diploma, B.Tech, BCA, MCA, cybersecurity fundamentals, CEH, and placement-level questions from this unit.
