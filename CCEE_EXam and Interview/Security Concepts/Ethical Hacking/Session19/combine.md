# Physical Security & Penetration Testing Notes (Complete Exam Notes)

---

# UNIT 1: PHYSICAL SECURITY

## 1. Overview of Physical Security

### Definition

Physical Security is the protection of people, hardware, software, network devices, facilities, and organizational assets from physical actions and events that could cause damage, loss, theft, or disruption.

It is the first layer of security because if an attacker gains physical access, many logical security controls can be bypassed.

### Goals of Physical Security

1. Prevent unauthorized access
2. Protect personnel
3. Protect equipment and data
4. Ensure business continuity
5. Reduce theft and vandalism
6. Protect critical infrastructure

---

## Physical Security Triangle

### 1. Deterrence

Discourage attackers from attempting an attack.

Examples:

* Security guards
* Warning signs
* CCTV cameras
* Security lighting

### 2. Detection

Identify unauthorized activity.

Examples:

* Motion sensors
* Alarms
* CCTV monitoring
* Access logs

### 3. Delay

Slow down attackers.

Examples:

* Locks
* Fences
* Security doors
* Mantraps

### 4. Response

Take action after detection.

Examples:

* Security personnel
* Police notification
* Emergency procedures

---

# Components of Physical Security

## 1. Perimeter Security

Protects the outer boundary.

Examples:

* Fences
* Walls
* Gates
* Security guards

### Purpose

Prevent unauthorized entry.

---

## 2. Access Control

Controls who enters a facility.

Methods:

### Something You Know

* Password
* PIN

### Something You Have

* Access card
* Smart card

### Something You Are

* Fingerprint
* Iris scan
* Face recognition

---

## 3. Surveillance Systems

Monitor activities.

Examples:

* CCTV Cameras
* Video analytics
* Recording systems

Benefits:

* Monitoring
* Evidence collection
* Crime deterrence

---

## 4. Environmental Controls

Protect equipment from environmental damage.

Examples:

* Fire suppression systems
* Air conditioning
* Humidity control
* Water leak sensors

---

## 5. Security Personnel

Responsibilities:

* Monitor premises
* Verify identity
* Handle incidents
* Patrol facilities

---

# Need of Physical Security

Organizations invest in physical security because cyber security alone is insufficient.

---

## Reasons for Physical Security

### 1. Prevent Unauthorized Access

Protects:

* Servers
* Network devices
* Data centers

---

### 2. Protect Sensitive Information

Examples:

* Customer records
* Financial information
* Research data

---

### 3. Prevent Theft

Assets:

* Laptops
* Servers
* Storage devices

---

### 4. Ensure Business Continuity

Protects against:

* Natural disasters
* Sabotage
* Fire incidents

---

### 5. Compliance Requirements

Many regulations require physical security.

Examples:

* PCI-DSS
* HIPAA
* ISO 27001

---

### 6. Employee Safety

Protects employees from:

* Violence
* Theft
* Unauthorized visitors

---

# Threats to Physical Security

## Human Threats

### Insider Threats

Employees intentionally or accidentally causing damage.

Examples:

* Data theft
* Sabotage

---

### Social Engineering

Manipulating people.

Examples:

* Tailgating
* Impersonation

---

### Theft

Stealing:

* Devices
* Documents
* Equipment

---

## Environmental Threats

### Fire

Causes:

* Electrical faults
* Human negligence

Controls:

* Fire extinguishers
* Fire suppression systems

---

### Flood

Controls:

* Raised floors
* Water sensors

---

### Earthquake

Controls:

* Secure equipment racks
* Disaster planning

---

### Power Failure

Controls:

* UPS
* Generators

---

# Physical Access Attacks

---

## Tailgating

Unauthorized person follows authorized employee into restricted area.

### Prevention

* Security guards
* Turnstiles
* Awareness training

---

## Piggybacking

Authorized user intentionally allows another person to enter.

### Prevention

* Employee awareness
* Access policies

---

## Shoulder Surfing

Watching someone enter credentials.

### Prevention

* Privacy screens
* Awareness

---

## Dumpster Diving

Searching discarded materials.

### Prevention

* Shredding documents
* Secure disposal

---

## Hardware Theft

Stealing equipment.

### Prevention

* Cable locks
* Locked rooms

---

# Factors Affecting Physical Security

---

## 1. Location

High-crime areas require stronger security.

Factors:

* Crime rate
* Political stability
* Natural disaster risk

---

## 2. Building Design

Security depends on:

* Number of entrances
* Visibility
* Emergency exits

---

## 3. Asset Value

Higher-value assets require greater protection.

Examples:

* Data centers
* Banking systems

---

## 4. Human Factors

Includes:

* Employee awareness
* Security culture
* Insider threats

---

## 5. Budget

Security controls depend on available resources.

---

## 6. Environmental Risks

Examples:

* Flood
* Fire
* Earthquake

---

## 7. Technology

Modern technologies improve security.

Examples:

* Biometrics
* Smart surveillance
* AI monitoring

---

# Data Center Physical Security

Important Exam Topic

---

## Security Layers

### Layer 1: Perimeter Security

* Fencing
* Guards

### Layer 2: Building Security

* Access cards
* Visitor logs

### Layer 3: Server Room Security

* Biometrics
* CCTV

### Layer 4: Rack Security

* Locked cabinets

---

# Physical Security Controls

| Control          | Purpose               |
| ---------------- | --------------------- |
| Fence            | Boundary protection   |
| CCTV             | Monitoring            |
| Biometric        | Identity verification |
| Security Guard   | Human monitoring      |
| Alarm            | Detection             |
| UPS              | Power backup          |
| Fire Suppression | Fire protection       |
| Access Card      | Controlled entry      |

---

# Penetration Testing Methodologies

---

## Definition

Penetration Testing (Pentesting) is a controlled security assessment that simulates real-world attacks to identify vulnerabilities.

Goal:
Find weaknesses before attackers do.

---

# Types of Penetration Testing

---

## Black Box Testing

Tester has no prior knowledge.

Simulates external attacker.

Advantages:

* Realistic

Disadvantages:

* Time consuming

---

## White Box Testing

Tester has full knowledge.

Includes:

* Source code
* Network diagrams

Advantages:

* Thorough testing

Disadvantages:

* Less realistic

---

## Gray Box Testing

Partial knowledge.

Most common method.

---

# Penetration Testing Methodology Phases

---

## Phase 1: Planning

Define:

* Scope
* Targets
* Objectives
* Rules of engagement

---

## Phase 2: Reconnaissance

Information gathering.

### Passive Recon

No direct interaction.

Examples:

* Google
* WHOIS
* Social media

### Active Recon

Direct interaction.

Examples:

* Nmap
* Ping sweep

---

## Phase 3: Scanning

Identify:

* Open ports
* Services
* Operating systems

Tools:

* Nmap
* Nessus

---

## Phase 4: Vulnerability Assessment

Find vulnerabilities.

Tools:

* Nessus
* OpenVAS
* Nikto

---

## Phase 5: Exploitation

Attempt controlled exploitation.

Tools:

* Metasploit
* Burp Suite

---

## Phase 6: Post Exploitation

Assess impact.

Examples:

* Privilege escalation
* Data access

---

## Phase 7: Reporting

Document findings.

Includes:

* Vulnerabilities
* Risk levels
* Remediation steps

---

# Popular Penetration Testing Frameworks

| Tool       | Purpose                  |
| ---------- | ------------------------ |
| Metasploit | Exploitation             |
| Nmap       | Scanning                 |
| Nessus     | Vulnerability Assessment |
| Burp Suite | Web Testing              |
| Nikto      | Web Scanner              |
| Wireshark  | Packet Analysis          |
| Hydra      | Password Auditing        |
| OpenVAS    | Vulnerability Scanner    |

---

# Metasploit Framework

## Definition

Metasploit is an open-source penetration testing framework used for vulnerability validation in authorized environments.

Developed by:
Rapid7

---

## Main Components

### Exploit

Code that targets a vulnerability.

---

### Payload

Code executed after successful exploitation.

Types:

#### Singles

Standalone payload.

#### Stagers

Create connection.

#### Stages

Provide advanced functionality.

---

### Auxiliary Modules

Used for:

* Scanning
* Enumeration
* Fuzzing

---

### Encoders

Help modify payload format.

---

### Post Modules

Used after access is obtained.

Examples:

* Information gathering
* Credential collection

---

# Metasploit Architecture

```text
msfconsole
    |
    |---- Exploits
    |---- Payloads
    |---- Auxiliary
    |---- Encoders
    |---- Post Modules
```

---

# Common Metasploit Commands

## Start Framework

```bash
msfconsole
```

---

## Search Exploit

```bash
search smb
```

---

## Use Module

```bash
use exploit/windows/smb/example
```

---

## Show Options

```bash
show options
```

---

## Set Target

```bash
set RHOSTS 192.168.1.10
```

---

## Set Payload

```bash
set payload windows/meterpreter/reverse_tcp
```

---

## Run Module

```bash
exploit
```

or

```bash
run
```

---

# Meterpreter Session

## What is Meterpreter?

Meterpreter is an advanced payload that runs in memory and provides interactive control of a compromised system during authorized testing.

### Advantages

* In-memory execution
* Flexible
* Interactive
* Extensible

---

## Useful Meterpreter Commands

```bash
sysinfo
```

System information.

```bash
getuid
```

Current user.

```bash
pwd
```

Current directory.

```bash
ls
```

List files.

```bash
ps
```

Running processes.

```bash
background
```

Move session to background.

```bash
sessions
```

View sessions.

---

# Penetration Testing Report Structure

1. Executive Summary
2. Scope
3. Methodology
4. Findings
5. Risk Rating
6. Screenshots
7. Remediation
8. Conclusion

---

# Important Exam Points

### Remember

Physical Security = First Line of Defense

---

### Access Control Factors

1. Something you know
2. Something you have
3. Something you are

---

### Physical Attacks

* Tailgating
* Piggybacking
* Shoulder Surfing
* Dumpster Diving

---

### Penetration Testing Phases

Planning → Reconnaissance → Scanning → Vulnerability Assessment → Exploitation → Post Exploitation → Reporting

---

### Types of Testing

| Type      | Knowledge |
| --------- | --------- |
| Black Box | None      |
| Gray Box  | Partial   |
| White Box | Full      |

---

# Exam Tips

### 2-Mark Questions

Memorize:

* Tailgating
* Piggybacking
* Dumpster Diving
* Meterpreter
* Reconnaissance

---

### 5-Mark Questions

Practice:

* Need of Physical Security
* Factors Affecting Physical Security
* Penetration Testing Methodology

---

### 10-Mark Questions

Prepare:

1. Explain Physical Security Controls.
2. Explain Penetration Testing Methodology with diagram.
3. Explain Metasploit Framework Architecture.
4. Explain Meterpreter Session.

---

# 30 Important MCQs

### 1. Physical security primarily protects?

A) Source code
B) Hardware and facilities
C) Database only
D) Internet

**Answer:** B

---

### 2. Tailgating means?

A) Password attack
B) Following an authorized person into a secure area
C) Port scanning
D) Sniffing

**Answer:** B

---

### 3. Which is biometric authentication?

A) PIN
B) Password
C) Fingerprint
D) Smart card

**Answer:** C

---

### 4. CCTV is used for?

A) Encryption
B) Surveillance
C) Routing
D) Coding

**Answer:** B

---

### 5. Dumpster diving targets?

A) Password manager
B) Discarded information
C) Firewall
D) Router

**Answer:** B

---

### 6. Reconnaissance is?

A) Reporting
B) Exploitation
C) Information Gathering
D) Cleanup

**Answer:** C

---

### 7. Black-box testing provides?

A) Full knowledge
B) Partial knowledge
C) No knowledge
D) Source code

**Answer:** C

---

### 8. White-box testing means?

A) Full knowledge
B) No knowledge
C) External testing
D) Anonymous testing

**Answer:** A

---

### 9. Metasploit is mainly used for?

A) Video editing
B) Exploitation and penetration testing
C) Accounting
D) Email

**Answer:** B

---

### 10. Meterpreter is a?

A) Firewall
B) Payload
C) IDS
D) Antivirus

**Answer:** B

---

### 11–30 Quick Answers

11. Access card → Something you have ✔
12. Fingerprint → Biometrics ✔
13. UPS protects against → Power failure ✔
14. Fire suppression controls → Fire ✔
15. Nmap is used for → Scanning ✔
16. Nessus is → Vulnerability scanner ✔
17. Burp Suite → Web testing ✔
18. Auxiliary module → Scanning ✔
19. Post module → Post exploitation ✔
20. Reporting is final pentest phase ✔
21. CCTV provides evidence ✔
22. Security guards are deterrent controls ✔
23. Smart card is access control ✔
24. Flood is environmental threat ✔
25. Shoulder surfing observes credentials ✔
26. Piggybacking involves authorized assistance ✔
27. Gray-box testing has partial knowledge ✔
28. Reconnaissance occurs before scanning ✔
29. Exploitation follows vulnerability discovery ✔
30. Physical security supports business continuity ✔

---

# Last-Minute Revision (1-Minute Memory Sheet)

```text
Physical Security =
Deterrence + Detection + Delay + Response

Access Control =
Know + Have + Are

Attacks =
Tailgating
Piggybacking
Shoulder Surfing
Dumpster Diving

Pentest Phases =
Planning
Recon
Scanning
Vulnerability Assessment
Exploitation
Post Exploitation
Reporting

Testing Types =
Black Box
Gray Box
White Box

Metasploit =
Exploit + Payload + Auxiliary + Post

Meterpreter =
Advanced Payload
```

These notes cover the complete syllabus points for **Physical Security, Factors Affecting Physical Security, Penetration Testing Methodologies, and Metasploit/Meterpreter practical concepts** commonly asked in university, diploma, BCA, BSc Cyber Security, and ethical hacking examinations.


# Physical Security, Penetration Testing & Metasploit – 100 MCQs

## Physical Security MCQs (1–40)

### 1. Physical security is primarily concerned with protecting:

A) Software only
B) Hardware, people, and facilities
C) Internet traffic only
D) Databases only

**Answer:** B

---

### 2. Which is the first line of defense in information security?

A) Firewall
B) Antivirus
C) Physical Security
D) IDS

**Answer:** C

---

### 3. Which physical security principle discourages attackers?

A) Detection
B) Delay
C) Deterrence
D) Response

**Answer:** C

---

### 4. CCTV cameras mainly provide:

A) Encryption
B) Detection and Monitoring
C) Authentication
D) Routing

**Answer:** B

---

### 5. Which device controls entry into a secure facility?

A) Hub
B) Router
C) Access Control System
D) Switch

**Answer:** C

---

### 6. A fingerprint scanner represents:

A) Something you know
B) Something you have
C) Something you are
D) Something you own

**Answer:** C

---

### 7. A PIN is:

A) Something you know
B) Something you are
C) Something you have
D) Something you inherit

**Answer:** A

---

### 8. Smart cards belong to:

A) Something you know
B) Something you are
C) Something you have
D) None

**Answer:** C

---

### 9. Unauthorized entry by following an authorized person is:

A) Spoofing
B) Tailgating
C) Scanning
D) Phishing

**Answer:** B

---

### 10. Allowing another person to enter intentionally is:

A) Tailgating
B) Piggybacking
C) Shoulder Surfing
D) Spoofing

**Answer:** B

---

### 11. Observing someone's password entry is:

A) Brute Force
B) Tailgating
C) Shoulder Surfing
D) Enumeration

**Answer:** C

---

### 12. Searching discarded materials for information is:

A) Dumpster Diving
B) Tailgating
C) Footprinting
D) Sniffing

**Answer:** A

---

### 13. Security guards are an example of:

A) Administrative control
B) Physical control
C) Technical control
D) Logical control

**Answer:** B

---

### 14. Which is NOT a physical security control?

A) Fence
B) CCTV
C) Firewall
D) Security Guard

**Answer:** C

---

### 15. UPS stands for:

A) Universal Power Supply
B) Uninterrupted Power Source
C) Uninterruptible Power Supply
D) Unified Power System

**Answer:** C

---

### 16. UPS protects against:

A) Flooding
B) Fire
C) Power Failure
D) Theft

**Answer:** C

---

### 17. Which is an environmental threat?

A) Flood
B) Hacker
C) Malware
D) Phishing

**Answer:** A

---

### 18. Fire suppression systems are used to:

A) Encrypt data
B) Control fire damage
C) Prevent malware
D) Monitor users

**Answer:** B

---

### 19. The outermost protection layer is:

A) Rack Security
B) Server Security
C) Perimeter Security
D) Database Security

**Answer:** C

---

### 20. A fence primarily provides:

A) Delay
B) Encryption
C) Routing
D) Authentication

**Answer:** A

---

### 21. Visitor logs help in:

A) Accounting
B) Access Monitoring
C) Coding
D) Routing

**Answer:** B

---

### 22. Biometrics improve:

A) Availability only
B) Authentication
C) Routing
D) Encryption

**Answer:** B

---

### 23. Security lighting helps:

A) Detection and Deterrence
B) Routing
C) Coding
D) Compression

**Answer:** A

---

### 24. Which attack is performed by insiders?

A) Insider Threat
B) DNS Attack
C) XSS
D) SQL Injection

**Answer:** A

---

### 25. The purpose of mantraps is:

A) Delay unauthorized access
B) Increase bandwidth
C) Improve encryption
D) Store logs

**Answer:** A

---

### 26. Data centers require:

A) Physical Security
B) No Security
C) Only Antivirus
D) Only Firewall

**Answer:** A

---

### 27. Which device records surveillance footage?

A) DVR/NVR
B) Router
C) Hub
D) Modem

**Answer:** A

---

### 28. Raised floors help protect from:

A) Malware
B) Flooding
C) Viruses
D) DDoS

**Answer:** B

---

### 29. Which factor affects physical security planning?

A) Asset Value
B) Location
C) Building Design
D) All of the Above

**Answer:** D

---

### 30. Security awareness training helps prevent:

A) Social Engineering
B) Floods
C) Fire
D) Earthquakes

**Answer:** A

---

### 31. Theft of servers impacts:

A) Confidentiality
B) Availability
C) Integrity
D) All of the Above

**Answer:** D

---

### 32. Security cameras act as:

A) Deterrent and Detective Control
B) Firewall
C) Router
D) Switch

**Answer:** A

---

### 33. Emergency exits are important for:

A) Safety
B) Routing
C) Encryption
D) Coding

**Answer:** A

---

### 34. Humidity control protects:

A) Hardware Equipment
B) Passwords
C) Databases
D) Websites

**Answer:** A

---

### 35. Political instability affects:

A) Physical Security Risk
B) Programming
C) Networking
D) Databases

**Answer:** A

---

### 36. A locked server rack provides:

A) Physical Protection
B) Encryption
C) Monitoring
D) Compression

**Answer:** A

---

### 37. Security alarms provide:

A) Detection
B) Routing
C) Switching
D) Coding

**Answer:** A

---

### 38. Access cards are used for:

A) Authentication and Authorization
B) Routing
C) Encryption
D) Monitoring

**Answer:** A

---

### 39. Which is NOT a physical threat?

A) Fire
B) Flood
C) Earthquake
D) SQL Injection

**Answer:** D

---

### 40. Physical security supports:

A) Business Continuity
B) Malware Creation
C) Routing
D) Coding

**Answer:** A

---

# Penetration Testing MCQs (41–75)

### 41. Penetration testing is:

A) Controlled attack simulation
B) Backup creation
C) Database design
D) Programming

**Answer:** A

---

### 42. The purpose of penetration testing is:

A) Find vulnerabilities
B) Create malware
C) Destroy systems
D) Increase traffic

**Answer:** A

---

### 43. Black-box testing means:

A) Full knowledge
B) No knowledge
C) Partial knowledge
D) Source code access

**Answer:** B

---

### 44. White-box testing means:

A) Full knowledge
B) No knowledge
C) Limited knowledge
D) No access

**Answer:** A

---

### 45. Gray-box testing means:

A) No knowledge
B) Full knowledge
C) Partial knowledge
D) Source code only

**Answer:** C

---

### 46. First phase of penetration testing:

A) Exploitation
B) Planning
C) Reporting
D) Post Exploitation

**Answer:** B

---

### 47. Reconnaissance means:

A) Reporting
B) Information Gathering
C) Exploitation
D) Cleanup

**Answer:** B

---

### 48. Passive reconnaissance involves:

A) No direct interaction
B) Direct scanning
C) Exploitation
D) Malware

**Answer:** A

---

### 49. Active reconnaissance involves:

A) Social Media Only
B) Direct Interaction
C) Reporting
D) Documentation

**Answer:** B

---

### 50. Open ports are identified during:

A) Scanning
B) Reporting
C) Cleanup
D) Documentation

**Answer:** A

---

### 51. Vulnerability assessment identifies:

A) Weaknesses
B) Employees
C) Routers
D) Policies

**Answer:** A

---

### 52. Exploitation occurs:

A) Before Scanning
B) After Vulnerability Discovery
C) Before Reconnaissance
D) Before Planning

**Answer:** B

---

### 53. Post-exploitation determines:

A) Impact of Compromise
B) Port Status
C) Cable Length
D) Hardware Type

**Answer:** A

---

### 54. Final phase of pentesting:

A) Reporting
B) Scanning
C) Recon
D) Enumeration

**Answer:** A

---

### 55. Nmap is mainly used for:

A) Scanning
B) Editing
C) Accounting
D) Coding

**Answer:** A

---

### 56. Nessus is:

A) Vulnerability Scanner
B) Firewall
C) IDS
D) Antivirus

**Answer:** A

---

### 57. OpenVAS is:

A) Vulnerability Scanner
B) Router
C) Browser
D) Switch

**Answer:** A

---

### 58. Burp Suite is used for:

A) Web Security Testing
B) Routing
C) Monitoring Temperature
D) Accounting

**Answer:** A

---

### 59. Nikto scans:

A) Web Servers
B) Databases
C) Routers
D) Switches

**Answer:** A

---

### 60. Hydra is used for:

A) Password Auditing
B) Routing
C) Logging
D) Imaging

**Answer:** A

---

### 61. Information gathering is also called:

A) Reconnaissance
B) Enumeration
C) Exploitation
D) Reporting

**Answer:** A

---

### 62. Which testing simulates a real external attacker?

A) White Box
B) Black Box
C) Gray Box
D) Internal

**Answer:** B

---

### 63. Rules of Engagement are defined during:

A) Planning
B) Exploitation
C) Reporting
D) Scanning

**Answer:** A

---

### 64. Scope defines:

A) Boundaries of Testing
B) Encryption Method
C) Password Policy
D) Programming Language

**Answer:** A

---

### 65. Risk ratings appear in:

A) Report
B) Recon
C) Scanning
D) Enumeration

**Answer:** A

---

### 66. Ethical hackers require:

A) Authorization
B) Malware
C) Anonymous Access
D) VPN Only

**Answer:** A

---

### 67. Unauthorized pentesting may be considered:

A) Illegal
B) Ethical
C) Recommended
D) Mandatory

**Answer:** A

---

### 68. Internal pentests assess:

A) Internal Security
B) Weather Conditions
C) Power Supply
D) CCTV

**Answer:** A

---

### 69. External pentests assess:

A) Internet-facing Systems
B) UPS Systems
C) Air Conditioning
D) Security Guards

**Answer:** A

---

### 70. Enumeration follows:

A) Reconnaissance
B) Reporting
C) Cleanup
D) Backup

**Answer:** A

---

### 71. Pentesting helps:

A) Improve Security Posture
B) Create Malware
C) Increase Spam
D) Remove Policies

**Answer:** A

---

### 72. A vulnerability is:

A) Weakness
B) Password
C) Cable
D) Router

**Answer:** A

---

### 73. An exploit takes advantage of:

A) Vulnerability
B) Firewall
C) Router
D) UPS

**Answer:** A

---

### 74. Evidence collection is important for:

A) Reporting
B) Coding
C) Routing
D) Switching

**Answer:** A

---

### 75. Remediation recommendations are found in:

A) Pentest Report
B) Recon
C) Enumeration
D) Scan Results Only

**Answer:** A

---

# Metasploit Framework MCQs (76–100)

### 76. Metasploit is a:

A) Penetration Testing Framework
B) Firewall
C) Browser
D) Antivirus

**Answer:** A

---

### 77. Metasploit was developed by:

A) Microsoft
B) Rapid7
C) Cisco
D) Oracle

**Answer:** B

---

### 78. Main Metasploit interface:

A) msfconsole
B) cmd
C) bash
D) powershell

**Answer:** A

---

### 79. An exploit is:

A) Code targeting a vulnerability
B) Password
C) Log file
D) Firewall

**Answer:** A

---

### 80. Payload executes:

A) After Successful Exploitation
B) Before Recon
C) Before Scanning
D) Before Enumeration

**Answer:** A

---

### 81. Meterpreter is:

A) Advanced Payload
B) IDS
C) Firewall
D) Antivirus

**Answer:** A

---

### 82. Meterpreter runs:

A) In Memory
B) On Disk Only
C) BIOS
D) CMOS

**Answer:** A

---

### 83. Auxiliary modules are used for:

A) Scanning and Enumeration
B) Encryption
C) Coding
D) Compression

**Answer:** A

---

### 84. Post modules are used:

A) After Exploitation
B) Before Recon
C) During Planning
D) During Scanning

**Answer:** A

---

### 85. Encoders are associated with:

A) Payload Modification
B) Routing
C) Switching
D) Logging

**Answer:** A

---

### 86. Command to search modules:

A) search
B) ls
C) pwd
D) mkdir

**Answer:** A

---

### 87. Command to display options:

A) show options
B) help options
C) get options
D) list

**Answer:** A

---

### 88. Command to select a module:

A) use
B) cd
C) ls
D) pwd

**Answer:** A

---

### 89. Command to execute module:

A) run/exploit
B) ls
C) dir
D) cat

**Answer:** A

---

### 90. RHOSTS refers to:

A) Target Host
B) Local Host
C) Router
D) Domain

**Answer:** A

---

### 91. Which payload is commonly used with Meterpreter?

A) reverse_tcp
B) ftp
C) smtp
D) dns

**Answer:** A

---

### 92. sysinfo command displays:

A) System Information
B) Passwords
C) Routing Table
D) Firewall Rules

**Answer:** A

---

### 93. getuid command displays:

A) Current User
B) Password
C) MAC Address
D) Gateway

**Answer:** A

---

### 94. ps command lists:

A) Running Processes
B) Files
C) Users
D) Services

**Answer:** A

---

### 95. sessions command shows:

A) Active Sessions
B) Open Ports
C) Firewall Rules
D) Databases

**Answer:** A

---

### 96. background command:

A) Sends Session to Background
B) Deletes Session
C) Creates Session
D) Closes Framework

**Answer:** A

---

### 97. Meterpreter is preferred because:

A) Memory-based Operation
B) Larger Size
C) Uses More Disk
D) Slower

**Answer:** A

---

### 98. Metasploit modules are stored in:

A) Framework Database
B) BIOS
C) Registry
D) Router

**Answer:** A

---

### 99. Post-exploitation may include:

A) Privilege Escalation Assessment
B) Coding
C) Accounting
D) Backup

**Answer:** A

---

### 100. Metasploit is primarily used by:

A) Authorized Security Professionals
B) Accountants
C) Designers
D) Gamers

**Answer:** A

---

# Most Important Exam MCQs (Frequently Asked)

1. Tailgating → Following authorized user.
2. Piggybacking → Authorized user allows entry.
3. Dumpster Diving → Searching discarded information.
4. Physical Security = First line of defense.
5. Black Box = No knowledge.
6. White Box = Full knowledge.
7. Gray Box = Partial knowledge.
8. Reconnaissance = Information Gathering.
9. Nmap = Scanning.
10. Nessus = Vulnerability Scanner.
11. Metasploit = Penetration Testing Framework.
12. Meterpreter = Advanced Payload.
13. UPS = Uninterruptible Power Supply.
14. CCTV = Surveillance.
15. Biometrics = Something You Are.
16. PIN = Something You Know.
17. Smart Card = Something You Have.
18. Final Pentest Phase = Reporting.
19. Exploit targets a vulnerability.
20. Rapid7 develops Metasploit.

