# Information Security Notes for Placements, Exams & Interviews

---

# 1. Protecting Information System Security

## Definition

Information System Security (ISS) refers to protecting information systems from unauthorized access, modification, destruction, disclosure, or disruption.

An Information System consists of:

* Hardware
* Software
* Data
* Networks
* Users
* Procedures

---

## Security Goals (CIA Triad)
| Sr. No. | Principle       | Description                                                | Examples                                      |
| ------- | --------------- | ---------------------------------------------------------- | --------------------------------------------- |
| 1       | Confidentiality | Ensures information is accessible only to authorized users | Passwords, Encryption, Access Control         |
| 2       | Integrity       | Ensures data is accurate and unaltered                     | Hashing, Digital Signatures, Checksums        |
| 3       | Availability    | Ensures systems are available when needed                  | Backup Systems, Disaster Recovery, Redundancy |

---

## Additional Security Principles

| Sr. No. | Principle       | Description                                 | Examples / Methods                     |
| ------- | --------------- | ------------------------------------------- | -------------------------------------- |
| 1       | Authentication  | Verifying identity                          | Password, OTP, Biometrics, Smart Cards |
| 2       | Authorization   | Determines what resources a user can access | Access Control Policies                |
| 3       | Accountability  | Tracking user actions through logs          | Audit Logs, Monitoring                 |
| 4       | Non-Repudiation | Prevents denial of performed actions        | Digital Signatures                     |


---

## Common Threats

| Threat         | Description               |
| -------------- | ------------------------- |
| Malware        | Malicious software        |
| Virus          | Attaches to files         |
| Worm           | Self-replicating malware  |
| Trojan         | Appears legitimate        |
| Spyware        | Steals information        |
| Ransomware     | Encrypts files for ransom |
| Phishing       | Fake websites/emails      |
| Insider Threat | Authorized user misuse    |
| DoS/DDoS       | Service disruption        |
| SQL Injection  | Database attack           |
| XSS            | Client-side attack        |

---

## Security Controls
| Sr. No. | Control Type            | Description                    | Examples                                     |
| ------- | ----------------------- | ------------------------------ | -------------------------------------------- |
| 1       | Physical Controls       | Protect physical assets        | CCTV, Security Guards, Biometric Locks       |
| 2       | Technical Controls      | Implemented through technology | Firewall, Antivirus, IDS/IPS, Encryption     |
| 3       | Administrative Controls | Policies and procedures        | Security Policies, Employee Training, Audits |

---
## Access Control Models


| Model    | Memory Trick                |
| -------- | --------------------------- |
| **DAC**  | **D = Discretion of Owner** |
| **MAC**  | **M = Mandatory Rules**     |
| **RBAC** | **R = Role Based**          |


| Sr. No. | Access Control Model                   | Description                                                                                    | Who Decides Access?         | Advantages                                         | Disadvantages                                                     | Examples                                                                           |
| ------- | -------------------------------------- | ---------------------------------------------------------------------------------------------- | --------------------------- | -------------------------------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 1       | **DAC (Discretionary Access Control)** | Resource owner decides who can access a resource and what permissions they receive.            | Resource Owner              | Flexible, Easy to manage for small environments    | Less secure, Permissions can be misused or spread unintentionally | File owner granting read/write permissions to other users                          |
| 2       | **MAC (Mandatory Access Control)**     | Access is determined by security policies and classifications enforced by a central authority. | Central Authority / System  | Highly secure, Suitable for sensitive environments | Rigid, Complex administration                                     | Military systems with classifications such as Confidential, Secret, and Top Secret |
| 3       | **RBAC (Role-Based Access Control)**   | Access permissions are assigned based on a user's role within the organization.                | Organization based on Roles | Easy to manage, Scalable, Supports least privilege | Role design can become complex in large organizations             | HR, Manager, Administrator, Student, Faculty                                       |


---

## Information Security Best Practices

| Sr. No. | Information Security Best Practice      | Description                        |
| ------- | --------------------------------------- | ---------------------------------- |
| 1       | **Principle of Least Privilege (PoLP)** | Users receive minimum permissions. |
| 2       | **Defense in Depth**                    | Multiple security layers.          |
| 3       | **Zero Trust Model**                    | "Never Trust, Always Verify"       |
| 4       | **Security Awareness Training**         | Educating employees.               |


## Incident Response Process

1. Preparation
2. Detection
3. Containment
4. Eradication
5. Recovery
6. Lessons Learned

---

# 2. Security in Mobile and Wireless Computing
| Sr. No. | Concept                | Description                                                           | Examples / Technologies                          |
| ------- | ---------------------- | --------------------------------------------------------------------- | ------------------------------------------------ |
| 1       | **Mobile Computing**   | Computing using portable devices connected through wireless networks. | Smartphones, Tablets, Laptops                    |
| 2       | **Wireless Computing** | Communication without physical cables.                                | Wi-Fi, Bluetooth, NFC, Cellular Networks (4G/5G) |

---

## Mobile Security Threats

| Sr. No. | Mobile Security Threat    | Description                     | Example / Impact                                       |
| ------- | ------------------------- | ------------------------------- | ------------------------------------------------------ |
| 1       | **Device Theft**          | Loss of device can expose data. | Unauthorized access to personal or corporate data      |
| 2       | **Malware**               | Mobile-specific malware.        | Spyware, Trojans, Ransomware                           |
| 3       | **Insecure Applications** | Poorly coded applications.      | Security vulnerabilities, unauthorized data access     |
| 4       | **Rooting/Jailbreaking**  | Removes built-in security.      | Increased risk of malware and unauthorized access      |
| 5       | **Data Leakage**          | Sensitive information exposure. | Leakage of personal, financial, or organizational data |
| 6       | **Unsecured Wi-Fi**       | Man-in-the-Middle attacks.      | Data interception on public Wi-Fi networks             |

---

## Wireless Security Threats

| Sr. No. | Wireless Security Threat | Description                                  | Examples / Impact                                           |
| ------- | ------------------------ | -------------------------------------------- | ----------------------------------------------------------- |
| 1       | **Eavesdropping**        | Intercepting communication.                  | Capturing sensitive data transmitted over wireless networks |
| 2       | **Rogue Access Point**   | Fake Wi-Fi hotspot.                          | Users connect to attacker-controlled Wi-Fi                  |
| 3       | **Evil Twin Attack**     | Attacker impersonates legitimate Wi-Fi.      | Steals credentials and sensitive information                |
| 4       | **Session Hijacking**    | Stealing active sessions.                    | Unauthorized access to user accounts                        |
| 5       | **Bluetooth Attacks**    | Attacks targeting Bluetooth-enabled devices. | Bluejacking, Bluesnarfing, Bluebugging                      |

---
## Mobile Security Mechanisms

| Sr. No. | Mobile Security Measure            | Description                                    | Examples / Features                                   |
| ------- | ---------------------------------- | ---------------------------------------------- | ----------------------------------------------------- |
| 1       | **Device Encryption**              | Protects stored data.                          | Encrypts files, messages, and device storage          |
| 2       | **Strong Authentication**          | Verifies user identity before granting access. | PIN, Password, Fingerprint, Face Recognition          |
| 3       | **Mobile Device Management (MDM)** | Centralized device control.                    | Device monitoring, policy enforcement, app management |
| 4       | **VPN (Virtual Private Network)**  | Encrypts communication.                        | Secure remote access, protected internet traffic      |
| 5       | **Remote Wipe**                    | Erase data remotely.                           | Removes sensitive data from lost or stolen devices    |
---

## Wireless Security Protocols

| Protocol | Security Level |
| -------- | -------------- |
| WEP      | Weak           |
| WPA      | Better         |
| WPA2     | Strong         |
| WPA3     | Strongest      |

### Exam Point

WEP is vulnerable due to weak IV implementation.

---

# 3. Credit Card Frauds in Mobile and Wireless Computing

## Definition

Unauthorized use of credit/debit card information for financial gain.

---

| Sr. No. | Type of Credit Card Fraud        | Description                                |
| ------- | -------------------------------- | ------------------------------------------ |
| 1       | **Card Theft**                   | Physical stealing of cards.                |
| 2       | **Skimming**                     | Copying card data using a skimmer.         |
| 3       | **Phishing**                     | Fake websites collect card details.        |
| 4       | **Smishing**                     | SMS phishing.                              |
| 5       | **Vishing**                      | Voice phishing via calls.                  |
| 6       | **Card Not Present (CNP) Fraud** | Online transactions without physical card. |
| 7       | **SIM Swap Fraud**               | Attacker obtains victim's mobile number.   |
| 8       | **QR Code Fraud**                | Malicious payment QR codes.                |
| 9       | **Mobile Wallet Fraud**          | Compromising digital wallets.              |


---

## Wireless Related Fraud Attacks

| Sr. No. | Payment Security Threat             | Description                          |
| ------- | ----------------------------------- | ------------------------------------ |
| 1       | **Rogue Wi-Fi**                     | Fake hotspot steals credentials.     |
| 2       | **Man-in-the-Middle (MITM) Attack** | Intercepts transaction data.         |
| 3       | **NFC Exploitation**                | Abuse of contactless payments.       |
| 4       | **Malware-Based Theft**             | Steals OTPs and banking credentials. |

---

## Prevention

### User Side

* Never share OTP
* Use secure websites
* Enable transaction alerts
* Use strong passwords
* Verify QR codes

### Organization Side

* Encryption
* Tokenization
* Multi-Factor Authentication
* Fraud Detection Systems

---

## Tokenization

Actual card number is replaced by a token.

Benefit:

* Reduces card data exposure.

---

# 4. Information Security Management (ISM)

## Definition

Systematic management of information security risks.

Goal:
Protect organizational assets.

---

## Objectives

* Confidentiality
* Integrity
* Availability
* Compliance
* Risk Reduction

---

## Information Security Management System (ISMS)

Framework for managing information security.

Most popular standard:

### ISO/IEC 27001

Provides requirements for ISMS.

---

## ISMS Components

| Sr. No. | ISMS Component          | Description                                 |
| ------- | ----------------------- | ------------------------------------------- |
| 1       | **Security Policy**     | Defines organization's security objectives. |
| 2       | **Risk Management**     | Identifying and managing risks.             |
| 3       | **Asset Management**    | Protecting valuable assets.                 |
| 4       | **Access Control**      | Managing user permissions.                  |
| 5       | **Incident Management** | Handling security incidents.                |
| 6       | **Business Continuity** | Maintaining operations during disruptions.  |

---

## Risk Management Process

| Sr. No. | Risk Management Step         | Description                                    | Examples                                              |
| ------- | ---------------------------- | ---------------------------------------------- | ----------------------------------------------------- |
| 1       | **Identify Assets**          | Identify valuable assets that need protection. | Servers, Databases, Employees                         |
| 2       | **Identify Threats**         | Identify potential threats to assets.          | Hackers, Malware, Natural Disasters                   |
| 3       | **Vulnerability Assessment** | Find weaknesses that can be exploited.         | Weak passwords, Unpatched software, Misconfigurations |
| 4       | **Risk Analysis**            | Evaluate risk based on likelihood and impact.  | Risk = Likelihood × Impact                            |
| 5       | **Risk Treatment**           | Decide how to handle identified risks.         | Avoid, Mitigate, Transfer, Accept                     |

---

## Security Governance

Provides strategic direction.

Includes:

* Policies
* Standards
* Procedures
* Guidelines

---

## Business Continuity Planning (BCP)

Ensures critical functions continue.

---

## Disaster Recovery Plan (DRP)

Restores IT systems after disaster.

---

### BCP vs DRP

| BCP                   | DRP             |
| --------------------- | --------------- |
| Business Continuation | System Recovery |
| Organization Focus    | IT Focus        |
| During Disaster       | After Disaster  |

---

# 5. Fundamentals of Information Security

## Information Security

Practice of protecting information from unauthorized access, disclosure, modification, or destruction.

---

## Security Terminologies

| Sr. No. | Term               | Description                                          | Examples                          |
| ------- | ------------------ | ---------------------------------------------------- | --------------------------------- |
| 1       | **Asset**          | Anything valuable.                                   | Data, Servers, Employees          |
| 2       | **Threat**         | Potential danger.                                    | Malware, Hacker, Fire             |
| 3       | **Vulnerability**  | Weakness in system.                                  | Weak password, Unpatched software |
| 4       | **Risk**           | Potential loss from threat exploiting vulnerability. | Data breach, Financial loss       |
| 5       | **Exploit**        | Method used to attack vulnerability.                 | SQL Injection, Buffer Overflow    |
| 6       | **Countermeasure** | Protection mechanism.                                | Firewall, Antivirus, Encryption   |


## Security Layers

| Sr. No. | Security Layer           | Description                                                            |
| ------- | ------------------------ | ---------------------------------------------------------------------- |
| 1       | **Physical Security**    | Protects physical assets and infrastructure.                           |
| 2       | **Network Security**     | Protects networks and communication channels.                          |
| 3       | **Application Security** | Protects applications from vulnerabilities and attacks.                |
| 4       | **Data Security**        | Protects data from unauthorized access, modification, or disclosure.   |
| 5       | **User Security**        | Protects users through awareness, authentication, and access controls. |

---

## Types of Security

| Sr. No. | Type of Security         | Description                        |
| ------- | ------------------------ | ---------------------------------- |
| 1       | **Network Security**     | Protecting network infrastructure. |
| 2       | **Application Security** | Protecting software applications.  |
| 3       | **Endpoint Security**    | Protecting user devices.           |
| 4       | **Cloud Security**       | Protecting cloud resources.        |
| 5       | **Database Security**    | Protecting databases.              |


---

## Security Technologies
| Sr. No. | Security Technology                                  | Description                                               |
| ------- | ---------------------------------------------------- | --------------------------------------------------------- |
| 1       | **Firewall**                                         | Filters traffic.                                          |
| 2       | **IDS (Intrusion Detection System)**                 | Detects suspicious or malicious activities.               |
| 3       | **IPS (Intrusion Prevention System)**                | Prevents and blocks malicious activities.                 |
| 4       | **Antivirus**                                        | Detects malware.                                          |
| 5       | **SIEM (Security Information and Event Management)** | Collects, analyzes, and manages security events and logs. |

---

## Cryptography Basics

| Sr. No. | Term       | Description                        |
| ------- | ---------- | ---------------------------------- |
| 1       | Plaintext  | Original data                      |
| 2       | Ciphertext | Encrypted data                     |
| 3       | Encryption | Converting plaintext to ciphertext |
| 4       | Decryption | Recovering original data           |

---

## Types of Encryption

### Symmetric Encryption

| Sr. No. | Algorithm |
| ------- | --------- |
| 1       | AES       |
| 2       | DES       |
| 3       | 3DES      |

---

### Asymmetric Encryption

| Sr. No. | Algorithm |
| ------- | --------- |
| 1       | RSA       |
| 2       | ECC       |

---

## Hashing

| Sr. No. | Algorithm    |
| ------- | ------------ |
| 1       | SHA-256      |
| 2       | SHA-512      |
| 3       | MD5 (Broken) |

### Uses of Hashing

| Sr. No. | Use                    |
| ------- | ---------------------- |
| 1       | Password Storage       |
| 2       | Integrity Verification |

---

# Frequently Asked MCQs

### Q1. Which is NOT part of CIA Triad?

A. Confidentiality
B. Integrity
C. Availability
D. Authentication

✅ Answer: Authentication

---

### Q2. Which protocol is least secure?

A. WPA3
B. WPA2
C. WPA
D. WEP

✅ Answer: WEP

---

### Q3. Risk Formula?

A. Threat + Vulnerability
B. Asset + Threat
C. Likelihood × Impact
D. Threat × Asset

✅ Answer: Likelihood × Impact

---

### Q4. Which attack uses fake emails?

A. SQLi
B. Phishing
C. DoS
D. Sniffing

✅ Answer: Phishing

---

### Q5. Which control is a firewall?

A. Administrative
B. Physical
C. Technical
D. Legal

✅ Answer: Technical

---

### Q6. Which algorithm is asymmetric?

A. AES
B. DES
C. RSA
D. SHA-256

✅ Answer: RSA

---

### Q7. Which attack steals active sessions?

A. Session Hijacking
B. Worm
C. Trojan
D. Virus

✅ Answer: Session Hijacking

---

### Q8. Full form of ISMS?

A. Information Security Management System
B. Information System Management Security
C. Integrated Security Management System
D. Information Security Monitoring System

✅ Answer: Information Security Management System

---

# Placement & University Exam Tips

## Must Remember

### CIA Triad

C → Confidentiality
I → Integrity
A → Availability

---

### AAA Security Model

A → Authentication
A → Authorization
A → Accounting

---

### Risk Formula

Risk = Likelihood × Impact

---

### Security Controls

PAT

P → Physical
A → Administrative
T → Technical

---

### Incident Response

**PDCERL**

Preparation
Detection
Containment
Eradication
Recovery
Lessons Learned

---

### Wireless Security Order

WEP < WPA < WPA2 < WPA3

---

### Credit Card Fraud Keywords

* Skimming
* Phishing
* Smishing
* Vishing
* SIM Swap
* QR Fraud
* CNP Fraud

---

# Most Important 2-Mark Questions

1. Define Information Security.
2. Explain CIA Triad.
3. What is Authentication?
4. What is Authorization?
5. Define Risk.
6. What is Vulnerability?
7. What is ISMS?
8. What is Tokenization?
9. What is Rogue Access Point?
10. Difference between BCP and DRP.

---

# Most Important 5-Mark Questions

1. Explain CIA Triad with examples.
2. Discuss mobile security threats.
3. Explain wireless security protocols.
4. Describe credit card frauds in mobile computing.
5. Explain risk management process.
6. Explain security controls.
7. Discuss ISMS components.
8. Explain incident response lifecycle.

---

# One-Line Revision Sheet

* CIA = Confidentiality + Integrity + Availability
* AAA = Authentication + Authorization + Accounting
* Risk = Likelihood × Impact
* WEP is weakest Wi-Fi protocol
* WPA3 is strongest Wi-Fi protocol
* RSA = Asymmetric Encryption
* AES = Symmetric Encryption
* SHA-256 = Hashing
* ISMS = Information Security Management System
* BCP = Business Continuity Planning
* DRP = Disaster Recovery Plan
* Tokenization protects card data
* MFA greatly reduces account compromise
* Least Privilege is a core security principle
* Defense in Depth = Multiple security layers
* Zero Trust = Never Trust, Always Verify

These notes cover the theory, placement MCQs, university exams, viva questions, and interview points from all five topics.



# Information Security - 100 MCQs with Answers

## Fundamentals of Information Security

### 1.

Which of the following is NOT a component of the CIA Triad?

A) Confidentiality
B) Integrity
C) Availability
D) Authentication

✅ Answer: D

---

### 2.

Confidentiality means:

A) Data is accurate
B) Data is available
C) Data is accessible only to authorized users
D) Data is backed up

✅ Answer: C

---

### 3.

Integrity ensures:

A) Data secrecy
B) Data accuracy and completeness
C) Fast processing
D) User authentication

✅ Answer: B

---

### 4.

Availability refers to:

A) Encryption of data
B) Authorized access when required
C) Data backup only
D) Data ownership

✅ Answer: B

---

### 5.

A weakness in a system is called:

A) Threat
B) Risk
C) Vulnerability
D) Exploit

✅ Answer: C

---

### 6.

A potential danger to a system is called:

A) Threat
B) Asset
C) Vulnerability
D) Policy

✅ Answer: A

---

### 7.

Risk is:

A) Threat × Vulnerability Impact
B) Likelihood × Impact
C) Vulnerability × Asset
D) Asset × Policy

✅ Answer: B

---

### 8.

Which is an example of an asset?

A) Virus
B) Firewall
C) Database
D) Hacker

✅ Answer: C

---

### 9.

An exploit is:

A) Security policy
B) Attack method using a vulnerability
C) Backup mechanism
D) Authentication method

✅ Answer: B

---

### 10.

The process of verifying identity is:

A) Authorization
B) Accounting
C) Authentication
D) Auditing

✅ Answer: C

---

## Authentication and Access Control

### 11.

Authorization determines:

A) User identity
B) User permissions
C) Encryption key
D) Data ownership

✅ Answer: B

---

### 12.

AAA stands for:

A) Authentication, Authorization, Accounting
B) Authentication, Availability, Access
C) Authorization, Audit, Access
D) Access, Availability, Accounting

✅ Answer: A

---

### 13.

Role-Based Access Control is:

A) MAC
B) DAC
C) RBAC
D) ACL

✅ Answer: C

---

### 14.

In DAC, access decisions are made by:

A) Government
B) System owner
C) Network admin only
D) ISP

✅ Answer: B

---

### 15.

MAC stands for:

A) Mandatory Access Control
B) Manual Access Control
C) Managed Access Control
D) Multi Access Control

✅ Answer: A

---

### 16.

Principle of Least Privilege means:

A) Maximum access
B) Minimum required access
C) Guest access only
D) Administrator rights

✅ Answer: B

---

### 17.

Biometric authentication uses:

A) Passwords
B) Tokens
C) Physical characteristics
D) Captcha

✅ Answer: C

---

### 18.

Fingerprint authentication is:

A) Knowledge factor
B) Possession factor
C) Inherence factor
D) Token factor

✅ Answer: C

---

### 19.

OTP stands for:

A) One Time Password
B) Online Transaction Password
C) Open Transfer Protocol
D) One Transfer Process

✅ Answer: A

---

### 20.

MFA means:

A) Multi-Factor Authentication
B) Multiple Firewall Access
C) Managed File Access
D) Mobile Firewall Authentication

✅ Answer: A

---

## Malware and Attacks

### 21.

A virus requires:

A) Human action to spread
B) No host file
C) Internet only
D) Bluetooth

✅ Answer: A

---

### 22.

A worm:

A) Requires host file
B) Self-replicates automatically
C) Is harmless
D) Is encryption software

✅ Answer: B

---

### 23.

A Trojan Horse:

A) Self-replicates
B) Appears legitimate but is malicious
C) Is a firewall
D) Is antivirus software

✅ Answer: B

---

### 24.

Spyware is used to:

A) Encrypt files
B) Monitor user activity
C) Improve performance
D) Backup data

✅ Answer: B

---

### 25.

Ransomware:

A) Deletes logs
B) Encrypts files and demands payment
C) Steals CPU resources
D) Creates backups

✅ Answer: B

---

### 26.

Phishing attacks commonly use:

A) Fake emails
B) Firewalls
C) IDS
D) Routers

✅ Answer: A

---

### 27.

Smishing is phishing through:

A) Bluetooth
B) SMS
C) Wi-Fi
D) VPN

✅ Answer: B

---

### 28.

Vishing uses:

A) Voice calls
B) Video files
C) Viruses
D) VPN

✅ Answer: A

---

### 29.

SQL Injection targets:

A) Operating Systems
B) Databases
C) Routers
D) Printers

✅ Answer: B

---

### 30.

XSS stands for:

A) Cross Site Scripting
B) Cross Server Security
C) Extended Secure System
D) XML Security Service

✅ Answer: A

---

## Network Security

### 31.

A firewall is used to:

A) Encrypt data
B) Filter network traffic
C) Compress files
D) Backup systems

✅ Answer: B

---

### 32.

IDS stands for:

A) Intrusion Detection System
B) Internet Detection Service
C) Internal Data Security
D) Integrated Defense System

✅ Answer: A

---

### 33.

IPS stands for:

A) Intrusion Prevention System
B) Internet Protection Service
C) Internal Prevention System
D) Information Processing System

✅ Answer: A

---

### 34.

DDoS stands for:

A) Distributed Denial of Service
B) Data Denial Operating System
C) Dynamic Data Service
D) Distributed Data Operation

✅ Answer: A

---

### 35.

Packet sniffing is:

A) Network traffic capture
B) Data encryption
C) Data compression
D) Routing

✅ Answer: A

---

### 36.

VPN provides:

A) Data compression
B) Secure communication tunnel
C) Faster internet only
D) Authentication only

✅ Answer: B

---

### 37.

Network segmentation improves:

A) Security
B) Screen resolution
C) RAM usage
D) Printing

✅ Answer: A

---

### 38.

DoS attacks affect:

A) Confidentiality
B) Integrity
C) Availability
D) Authentication

✅ Answer: C

---

### 39.

A Man-in-the-Middle attack intercepts:

A) Network communication
B) Power supply
C) Operating systems
D) Databases only

✅ Answer: A

---

### 40.

Port scanning is used to:

A) Find open ports
B) Encrypt ports
C) Close services
D) Backup routers

✅ Answer: A

---

## Cryptography

### 41.

Encryption converts:

A) Ciphertext to plaintext
B) Plaintext to ciphertext
C) Hash to password
D) Token to password

✅ Answer: B

---

### 42.

Decryption converts:

A) Plaintext to ciphertext
B) Ciphertext to plaintext
C) Password to hash
D) Key to password

✅ Answer: B

---

### 43.

AES is:

A) Symmetric encryption
B) Asymmetric encryption
C) Hashing algorithm
D) Firewall

✅ Answer: A

---

### 44.

RSA is:

A) Hashing algorithm
B) Symmetric algorithm
C) Asymmetric algorithm
D) Compression algorithm

✅ Answer: C

---

### 45.

Which uses public and private keys?

A) AES
B) DES
C) RSA
D) MD5

✅ Answer: C

---

### 46.

Hashing is:

A) Two-way process
B) One-way process
C) Compression
D) Backup

✅ Answer: B

---

### 47.

SHA-256 is:

A) Encryption algorithm
B) Hashing algorithm
C) Firewall protocol
D) Access control model

✅ Answer: B

---

### 48.

MD5 is considered:

A) Strongly secure
B) Broken and vulnerable
C) Encryption standard
D) VPN protocol

✅ Answer: B

---

### 49.

Digital signatures provide:

A) Availability
B) Integrity and Non-Repudiation
C) Compression
D) Routing

✅ Answer: B

---

### 50.

A checksum is used for:

A) Integrity verification
B) Authentication
C) Encryption
D) Authorization

✅ Answer: A

---

## Mobile and Wireless Security

### 51.

WEP stands for:

A) Wired Equivalent Privacy
B) Wireless Encryption Protection
C) Wide Encryption Protocol
D) Wireless Extension Privacy

✅ Answer: A

---

### 52.

The weakest wireless protocol is:

A) WPA3
B) WPA2
C) WPA
D) WEP

✅ Answer: D

---

### 53.

The most secure Wi-Fi protocol is:

A) WEP
B) WPA
C) WPA2
D) WPA3

✅ Answer: D

---

### 54.

Bluejacking targets:

A) Wi-Fi
B) Bluetooth
C) NFC
D) GPS

✅ Answer: B

---

### 55.

Bluesnarfing involves:

A) Bluetooth data theft
B) Email theft
C) SQL Injection
D) Password hashing

✅ Answer: A

---

### 56.

An Evil Twin attack uses:

A) Fake Wi-Fi hotspot
B) Virus
C) Worm
D) Trojan

✅ Answer: A

---

### 57.

A Rogue Access Point is:

A) Authorized AP
B) Fake/Unauthorized AP
C) VPN server
D) DNS server

✅ Answer: B

---

### 58.

Rooting a smartphone:

A) Increases built-in security
B) Removes restrictions and may weaken security
C) Encrypts device
D) Creates backups

✅ Answer: B

---

### 59.

Jailbreaking is mainly associated with:

A) Android only
B) iOS devices
C) Routers
D) Databases

✅ Answer: B

---

### 60.

Remote wipe is used to:

A) Delete lost device data remotely
B) Backup files
C) Compress storage
D) Speed up CPU

✅ Answer: A

---

## Credit Card Frauds

### 61.

Card skimming steals:

A) Battery power
B) Card information
C) SIM cards
D) Password hashes

✅ Answer: B

---

### 62.

Card Not Present fraud occurs in:

A) ATM transactions
B) Online transactions
C) POS only
D) Offline transactions

✅ Answer: B

---

### 63.

SIM Swap fraud targets:

A) Mobile number ownership
B) Database records
C) Routers
D) Servers

✅ Answer: A

---

### 64.

OTP theft commonly occurs through:

A) Smishing malware
B) Firewall
C) Encryption
D) Hashing

✅ Answer: A

---

### 65.

Tokenization replaces:

A) Passwords with OTPs
B) Card data with tokens
C) Users with roles
D) Keys with hashes

✅ Answer: B

---

### 66.

QR Code fraud often uses:

A) Malicious payment links
B) Firewalls
C) VPNs
D) IDS

✅ Answer: A

---

### 67.

NFC stands for:

A) Near Field Communication
B) Network File Control
C) New Fast Connection
D) National File Center

✅ Answer: A

---

### 68.

Contactless payment mainly uses:

A) NFC
B) SMTP
C) FTP
D) POP3

✅ Answer: A

---

### 69.

A fake banking website is an example of:

A) Phishing
B) Worm
C) IDS
D) VPN

✅ Answer: A

---

### 70.

Transaction alerts help detect:

A) Unauthorized transactions
B) Malware signatures
C) Firewalls
D) VPN errors

✅ Answer: A

---

## Information Security Management

### 71.

ISMS stands for:

A) Information Security Management System
B) Information System Monitoring Service
C) Integrated Security Monitoring System
D) Internet Security Management Service

✅ Answer: A

---

### 72.

The primary goal of ISMS is:

A) Increase internet speed
B) Manage information security risks
C) Reduce storage space
D) Improve graphics

✅ Answer: B

---

### 73.

ISO 27001 focuses on:

A) Networking
B) ISMS
C) Programming
D) Cloud storage

✅ Answer: B

---

### 74.

Risk treatment options include:

A) Avoid
B) Mitigate
C) Transfer
D) All of the above

✅ Answer: D

---

### 75.

Business Continuity Planning ensures:

A) Business operations continue during disruptions
B) Encryption
C) Routing
D) Coding standards

✅ Answer: A

---

### 76.

Disaster Recovery Plan focuses on:

A) IT recovery
B) Employee hiring
C) Sales growth
D) Marketing

✅ Answer: A

---

### 77.

Asset identification is part of:

A) Risk Management
B) Routing
C) Encryption
D) Compression

✅ Answer: A

---

### 78.

Security policies are examples of:

A) Administrative controls
B) Technical controls
C) Physical controls
D) Encryption

✅ Answer: A

---

### 79.

CCTV is:

A) Technical control
B) Administrative control
C) Physical control
D) Encryption

✅ Answer: C

---

### 80.

Antivirus software is:

A) Physical control
B) Administrative control
C) Technical control
D) Legal control

✅ Answer: C

---

## Incident Response

### 81.

First phase of Incident Response:

A) Recovery
B) Preparation
C) Eradication
D) Containment

✅ Answer: B

---

### 82.

After detection comes:

A) Containment
B) Recovery
C) Auditing
D) Encryption

✅ Answer: A

---

### 83.

Removing malware is called:

A) Recovery
B) Eradication
C) Detection
D) Preparation

✅ Answer: B

---

### 84.

Restoring systems is part of:

A) Recovery
B) Detection
C) Prevention
D) Auditing

✅ Answer: A

---

### 85.

The final phase is:

A) Recovery
B) Lessons Learned
C) Detection
D) Preparation

✅ Answer: B

---

## Mixed Important MCQs

### 86.

Zero Trust means:

A) Trust everyone
B) Never Trust, Always Verify
C) No authentication needed
D) Public access

✅ Answer: B

---

### 87.

Defense in Depth means:

A) Single security layer
B) Multiple security layers
C) No security layers
D) Password only

✅ Answer: B

---

### 88.

A honeypot is used to:

A) Attract attackers for monitoring
B) Encrypt files
C) Backup systems
D) Manage databases

✅ Answer: A

---

### 89.

SIEM stands for:

A) Security Information and Event Management
B) Secure Internet Event Monitor
C) Security Interface Event Manager
D) System Internet Event Manager

✅ Answer: A

---

### 90.

Shoulder surfing is:

A) Physical observation attack
B) Malware attack
C) SQL Injection
D) XSS

✅ Answer: A

---

### 91.

Which attack targets user sessions?

A) Session Hijacking
B) Worm
C) Trojan
D) Virus

✅ Answer: A

---

### 92.

Which attack floods DHCP servers with requests?

A) DHCP Starvation
B) SQL Injection
C) XSS
D) CSRF

✅ Answer: A

---

### 93.

A Rogue DHCP server can:

A) Assign malicious network settings
B) Encrypt files
C) Backup routers
D) Patch systems

✅ Answer: A

---

### 94.

Data classification helps:

A) Determine security requirements
B) Increase bandwidth
C) Speed processors
D) Create backups

✅ Answer: A

---

### 95.

Which is NOT a factor of authentication?

A) Something you know
B) Something you have
C) Something you are
D) Something you download

✅ Answer: D

---

### 96.

Passwords belong to:

A) Possession factor
B) Knowledge factor
C) Inherence factor
D) Biometric factor

✅ Answer: B

---

### 97.

Smart cards are:

A) Knowledge factor
B) Possession factor
C) Inherence factor
D) Availability factor

✅ Answer: B

---

### 98.

Face Recognition is:

A) Knowledge factor
B) Possession factor
C) Inherence factor
D) Access factor

✅ Answer: C

---

### 99.

The strongest protection against phishing is:

A) User awareness + MFA
B) More RAM
C) Faster CPU
D) Compression

✅ Answer: A

---

### 100.

The core objective of Information Security is:

A) CIA Triad
B) Fast internet
C) Large storage
D) Better graphics

✅ Answer: A

# Exam-Focused Most Repeated Answers

* CIA → Confidentiality, Integrity, Availability
* AAA → Authentication, Authorization, Accounting
* Risk = Likelihood × Impact
* WEP = Weakest Wi-Fi security
* WPA3 = Strongest Wi-Fi security
* AES = Symmetric Encryption
* RSA = Asymmetric Encryption
* SHA-256 = Hashing Algorithm
* ISMS = Information Security Management System
* BCP = Business Continuity Plan
* DRP = Disaster Recovery Plan
* MFA = Multi-Factor Authentication
* PoLP = Principle of Least Privilege
* Zero Trust = Never Trust, Always Verify
* Defense in Depth = Multiple Security Layers
* Tokenization = Replacing card data with tokens
* Digital Signature = Integrity + Authentication + Non-Repudiation

These 100 MCQs cover the most common university exam, aptitude test, placement test, viva, and interview questions from the topics you listed.
