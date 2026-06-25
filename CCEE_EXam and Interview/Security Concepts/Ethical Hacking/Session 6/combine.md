# Information Security Notes (Placement + University Exam Preparation)

# 1. Security Management Concepts & Principles

## What is Information Security?

Information Security (InfoSec) is the practice of protecting information and information systems from:

* Unauthorized access
* Disclosure
* Modification
* Destruction
* Disruption

### Goals of Information Security

The primary goal is to ensure:

### CIA Triad

CIA

| Principle       | Meaning                               | Example                     |
| --------------- | ------------------------------------- | --------------------------- |
| Confidentiality | Only authorized users can access data | Password-protected database |
| Integrity       | Data remains accurate and unaltered   | Hash verification           |
| Availability    | Systems/data available when needed    | Backup servers              |

```
Data Integrity = Data + source integrity
```

---

## Additional Security Principles
1. Authentication
2. Authorization
3. Accountability
4. Non-Repudiation
5. Privacy

| Sr. No. | Security Principle  | Description                                  | Examples                                       |
| ------- | ------------------- | -------------------------------------------- | ---------------------------------------------- |
| 1       | **Authentication**  | Verifies identity.                           | Password, OTP, Biometric                       |
| 2       | **Authorization**   | Determines what resources a user can access. | Student can view marks, Admin can modify marks |
| 3       | **Accountability**  | Actions can be traced back to a user.        | Audit logs                                     |
| 4       | **Non-Repudiation** | User cannot deny performing an action.       | Digital signatures                             |
| 5       | **Privacy**         | Protection of personal information.          | —                                              |

### AAA

| Sr. No. | Component                       | Description                                                                      | Examples                                       |
| ------- | ------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------- |
| 1       | **Authentication**              | Verifies the identity of a user, device, or system.                              | Password, OTP, Biometric                       |
| 2       | **Authorization**               | Determines what resources or actions an authenticated user is allowed to access. | Student can view marks, Admin can modify marks |
| 3       | **Accounting (Accountability)** | Records and tracks user activities for auditing and monitoring purposes.         | Audit logs, Login records, Activity tracking   |


# Security Management

Security Management involves:

1. Identifying assets
2. Identifying threats
3. Identifying vulnerabilities
4. Assessing risk
5. Implementing controls

---

## Key Terms

| Sr. No. | Term              | Description                                         | Examples                               |
| ------- | ----------------- | --------------------------------------------------- | -------------------------------------- |
| 1       | **Asset**         | Anything valuable.                                  | Data, Hardware, Software, Employees    |
| 2       | **Threat**        | Anything capable of causing harm.                   | Malware, Hacker, Fire                  |
| 3       | **Vulnerability** | Weakness that can be exploited.                     | Weak password, Unpatched software      |
| 4       | **Risk**          | Risk exists when a threat exploits a vulnerability. | Risk = Threat × Vulnerability × Impact |

---

## Security Controls
1. Administrative 
2. Technical 
3. Physical 

| Control Type       | Think Of                                                    |
| ------------------ | ----------------------------------------------------------- |
| **Administrative** | **Rules** (What people should do)                           |
| **Technical**      | **Technology** (What systems do)                            |
| **Physical**       | **Buildings & Equipment** (What protects assets physically) |

### Exam MCQ Tip

**Policy says what to do** → Administrative Control
**Firewall blocks traffic** → Technical Control
**CCTV records activity** → Physical Control

**Mnemonic:** **A-T-P = Administrative → Technical → Physical = Rules → Technology → Buildings**.

| **Control Type**            | **Definition**                                                                                       | **Purpose**                                             | **Examples**                                                                                                                                                |
| --------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Administrative Controls** | Policies, procedures, and management practices that guide employee behavior and security operations. | Reduce risk through rules, awareness, and governance.   | Security Policy, Acceptable Use Policy (AUP), Employee Security Training, Background Checks, Incident Response Plan, Risk Assessment, Access Control Policy |
| **Technical Controls**      | Security measures implemented using hardware, software, or firmware.                                 | Protect systems, networks, and data from cyber threats. | Firewall, Antivirus, IDS/IPS, Encryption, Multi-Factor Authentication (MFA), Access Control Lists (ACLs), VPN, SIEM                                         |
| **Physical Controls**       | Measures that physically protect people, facilities, and assets.                                     | Prevent unauthorized physical access, damage, or theft. | CCTV Cameras, Door Locks, Security Guards, Biometric Access Systems, Fences, Motion Sensors, Mantraps, Security Lighting                                    |





# Principles of Security

| Sr. No. | Security Principle       | Description                                                                       | Example                                                  |
| ------- | ------------------------ | --------------------------------------------------------------------------------- | -------------------------------------------------------- |
| 1       | **Least Privilege**      | Give only necessary permissions.                                                  | Student should not get admin rights.                     |
| 2       | **Separation of Duties** | Critical tasks divided among multiple people.                                     | One employee creates payment; another approves payment.  |
| 3       | **Defense in Depth**     | Multiple layers of security.                                                      | Internet → Firewall → IDS → Antivirus → System           |
| 4       | **Need to Know**         | Users access only information required for their work.                            | Employee can access only data needed for assigned tasks. |
| 5       | **Fail Secure**          | System should remain secure even after failure.                                   | Access is denied if authentication server fails.         |
| 6       | **Zero Trust**           | "Never Trust, Always Verify." Every request must be authenticated and authorized. | Users must verify identity before accessing resources.   |


# 2. Human Side of Information Security 
Humans are often considered the weakest link in security.

Studies show many attacks succeed because of human mistakes.

---

| Sr. No. | Human Error / Threat  | Description                                              | Examples                                                              |
| ------- | --------------------- | -------------------------------------------------------- | --------------------------------------------------------------------- |
| 1       | **Weak Passwords**    | Using easily guessable passwords.                        | 123456, password, admin                                               |
| 2       | **Password Reuse**    | Using the same password across multiple websites.        | Same password for email, banking, and social media accounts           |
| 3       | **Carelessness**      | Negligent user actions that compromise security.         | Clicking unknown links, Sharing credentials, Leaving systems unlocked |
| 4       | **Lack of Awareness** | Employees may not recognize security threats or attacks. | Falling for phishing emails, Ignoring security warnings               |
| 5       | **Insider Threats**   | Threats originating inside an organization.              | Malicious employees, Disgruntled staff, Privilege misuse              |


## Social Engineering

Psychological manipulation to obtain information.

Social Engineering is the psychological manipulation of people to trick them into revealing sensitive information, granting access, or performing actions that compromise security.


### Common Techniques

| Attack Type      | Description                                 | Example                                           |
| ---------------- | ------------------------------------------- | ------------------------------------------------- |
| Phishing         | Fake emails to steal information            | Fake bank login page                              |
| Spear Phishing   | Targeted phishing against a specific person | Email to a company manager                        |
| Whaling          | Phishing aimed at executives                | CEO receives fake legal notice                    |
| Vishing          | Voice phishing using phone calls            | Fake bank representative                          |
| Smishing         | SMS-based phishing                          | Fake OTP verification message                     |
| Pretexting       | Creating a fake scenario to gain trust      | Pretending to be HR or IT staff                   |
| Baiting          | Offering something attractive               | Infected USB labeled "Salary Data"                |
| Tailgating       | Following someone into a secure area        | Walking behind an employee through a secured door |
| Shoulder Surfing | Observing sensitive information             | Watching someone enter a password                 |
| Dumpster Diving  | Searching discarded materials               | Finding passwords in trash                        |


## Security Awareness Training

Should cover:

* Password safety
* Phishing detection
* Device security
* Data handling
* Incident reporting

---

# 3. Threats to Information Systems

## What is a Threat?

A potential danger that can exploit vulnerabilities and cause damage.

### Memory Trick

**N-H-E-T**

* **N** → Natural
* **H** → Human (intentional unintentianal)
* **E** → Environmental
* **T** → Technical

| Threat Category           | Subcategory                         | Examples                                         | Impact on Security                                        | CIA Triad Affected                                       |
| ------------------------- | ----------------------------------- | ------------------------------------------------ | --------------------------------------------------------- | -------------------------------------------------------- |
| **Natural Threats**       | Natural Disasters                   | Earthquake, Flood, Fire, Hurricane, Lightning    | Physical damage to systems, data loss, service disruption | **Availability (A)**                                     |
| **Human Threats**         | **Intentional**                     | Hacking, Malware, Theft, Espionage               | Unauthorized access, data theft, system compromise        | **Confidentiality (C), Integrity (I), Availability (A)** |
| **Human Threats**         | **Unintentional**                   | Mistakes, Misconfiguration, Accidental Deletion  | Data loss, security vulnerabilities, downtime             | **Integrity (I), Availability (A)**                      |
| **Environmental Threats** | Infrastructure/Environmental Issues | Power Failure, Temperature Issues, Water Leakage | Equipment damage, system shutdown, data corruption        | **Availability (A)**                                     |
| **Technical Threats**     | System/Technology Failures          | Software Bugs, Hardware Failure, Network Outage  | Service interruption, data loss, reduced availability     | **Availability (A), Integrity (I)**                      |



# 4. Threats and Attacks

## Attack

An attempt to exploit vulnerabilities.
Attcak of 2 Types active and Passive 

---

## Active Attacks
Attacker modifies system or data.

Examples:
| Sr. No. | Active Attack                            | Description                                                                    | Impact on Security                                 | CIA Triad Affected                                       |
| ------- | ---------------------------------------- | ------------------------------------------------------------------------------ | -------------------------------------------------- | -------------------------------------------------------- |
| **1**   | **DoS (Denial of Service)**              | Overwhelms system resources to make services unavailable                       | Service disruption and downtime                    | **Availability (A)**                                     |
| **2**   | **DDoS (Distributed Denial of Service)** | Multiple compromised systems attack a single target                            | Large-scale service outage                         | **Availability (A)**                                     |
| **3**   | **Malware Attack**                       | Malicious software such as Virus, Worm, Trojan, and Ransomware infects systems | Data theft, corruption, system compromise          | **Confidentiality (C), Integrity (I), Availability (A)** |
| **4**   | **SQL Injection**                        | Injecting malicious SQL queries into an application                            | Unauthorized access, data modification, data theft | **Confidentiality (C), Integrity (I)**                   |
| **5**   | **Man-in-the-Middle (MITM)**             | Attacker intercepts and possibly alters communication between parties          | Data theft, data manipulation                      | **Confidentiality (C), Integrity (I)**                   |
| **6**   | **Session Hijacking**                    | Stealing or taking over an active user session                                 | Unauthorized access to user accounts               | **Confidentiality (C), Integrity (I)**                   |

## Passive Attacks
Monitoring witho-ut altering data.
Examples:
| Sr. No. | Passive Attack       | Description                                             | Impact on Security                               | CIA Triad Affected      |
| ------- | -------------------- | ------------------------------------------------------- | ------------------------------------------------ | ----------------------- |
| **1**   | **Eavesdropping**    | Listening to communication without altering it          | Exposure of sensitive information                | **Confidentiality (C)** |
| **2**   | **Traffic Analysis** | Analyzing communication patterns, frequency, and timing | Reveals communication behavior and relationships | **Confidentiality (C)** |
| **3**   | **Packet Sniffing**  | Capturing and monitoring network packets in transit     | Disclosure of credentials and sensitive data     | **Confidentiality (C)** |

---

# Malware Types

| Malware Type     | Definition                                                                    | Key Characteristics                                                                            | Impact                                              | Examples                            |
| ---------------- | ----------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | --------------------------------------------------- | ----------------------------------- |
| **Virus**        | Malicious program that attaches itself to a host file or program.             | • Requires a host file<br>• Replicates itself<br>• Infects other files                         | File corruption, system slowdown, data loss         | CIH, Melissa, ILOVEYOU              |
| **Worm**         | Standalone malware that spreads automatically across networks.                | • Self-replicating<br>• No host file required<br>• Spreads over networks                       | Consumes bandwidth, spreads rapidly, causes outages | Conficker, SQL Slammer, Morris Worm |
| **Trojan Horse** | Malware disguised as legitimate software.                                     | • Appears legitimate<br>• Tricks users into installation<br>• Often creates backdoors          | Unauthorized access, data theft, system compromise  | Zeus, Emotet, TrickBot              |
| **Ransomware**   | Malware that encrypts files and demands payment for decryption.               | • Encrypts data<br>• Demands ransom<br>• May threaten data leaks                               | Data loss, business disruption, financial damage    | WannaCry, LockBit, Ryuk             |
| **Spyware**      | Malware that secretly monitors and collects user information.                 | • Stealthy operation<br>• Tracks user activity<br>• Steals sensitive data                      | Privacy violations, credential theft                | Pegasus, FinFisher, CoolWebSearch   |
| **Adware**       | Software that displays unwanted advertisements.                               | • Shows pop-ups and ads<br>• Tracks browsing habits<br>• Often bundled with free software      | Annoyance, reduced performance, privacy concerns    | Fireball, Gator                     |
| **Rootkit**      | Malware designed to hide malicious activities and maintain privileged access. | • Hides processes/files<br>• Evades detection<br>• Provides persistent access                  | Difficult to detect, full system compromise         | ZeroAccess, TDSS                    |
| **Botnet**       | A network of compromised devices controlled by an attacker.                   | • Remote command and control (C2)<br>• Large-scale attacks<br>• Uses infected devices ("bots") | DDoS attacks, spam campaigns, malware distribution  | Mirai, GameOver Zeus                |

### Exam Tips

| Malware    | Memory Trick                         |
| ---------- | ------------------------------------ |
| Virus      | **V = Victim file needed**           |
| Worm       | **W = Wanders through network**      |
| Trojan     | **T = Tricks user**                  |
| Ransomware | **R = Ransom for files**             |
| Spyware    | **S = Spies on user**                |
| Adware     | **A = Advertisements**               |
| Rootkit    | **R = Remains hidden (Root access)** |
| Botnet     | **B = Bots controlled remotely**     |

```
### Quick MCQ Point
**Which malware requires a host file to spread?** → **Virus**
**Which malware spreads automatically over networks?** → **Worm**
**Which malware disguises itself as legitimate software?** → **Trojan Horse**
**Which malware encrypts files and demands payment?** → **Ransomware**
**Which malware secretly collects user information?** → **Spyware**
**Which malware displays unwanted advertisements?** → **Adware**
**Which malware hides malicious activities?** → **Rootkit**
**Which malware consists of compromised devices controlled remotely?** → **Botnet**
```

# Network Attacks

| Sr. No. | Attack Type                              | Description                                                               | Key Characteristic        | Impact                                                           |
| ------- | ---------------------------------------- | ------------------------------------------------------------------------- | ------------------------- | ---------------------------------------------------------------- |
| 1       | **DoS (Denial of Service)**              | A single attacker floods a target with excessive traffic or requests.     | Single source attack      | Makes services unavailable to legitimate users                   |
| 2       | **DDoS (Distributed Denial of Service)** | Multiple compromised systems (botnet) attack a target simultaneously.     | Multiple attack sources   | Large-scale service disruption and downtime                      |
| 3       | **ARP Spoofing**                         | Attacker associates their own MAC address with the victim's IP address.   | Manipulates ARP tables    | Enables Man-in-the-Middle (MITM) attacks and packet interception |
| 4       | **DNS Spoofing**                         | Attacker provides a fake DNS response to redirect users.                  | Alters DNS resolution     | Redirects users to malicious websites                            |
| 5       | **IP Spoofing**                          | Attacker forges the source IP address in packets.                         | Hides attacker identity   | Used in DDoS, bypassing IP-based controls                        |
| 6       | **Brute Force Attack**                   | Tries every possible password combination until the correct one is found. | Exhaustive search         | Unauthorized account access                                      |
| 7       | **Dictionary Attack**                    | Uses a predefined list of common passwords and words.                     | Faster than brute force   | Compromises weak passwords                                       |
| 8       | **Credential Stuffing**                  | Uses leaked username-password pairs from previous breaches.               | Reuses stolen credentials | Account takeover on multiple services                            |

---

# 5. Classification of Threats and Attacks

# A. Based on Source

| Sr. No. | Threat Type          | Description                                        | Examples                                          |
| ------- | -------------------- | -------------------------------------------------- | ------------------------------------------------- |
| 1       | **Internal Threats** | Threats originating from within the organization.  | Employee theft, Insider attacks, Privilege misuse |
| 2       | **External Threats** | Threats originating from outside the organization. | Hackers, Competitors, Cybercriminals              |

---

# B. Based on Intent
| Sr. No. | Threat Type               | Description                                                              | Examples                                                |
| ------- | ------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------- |
| 1       | **Intentional Threats**   | Deliberate actions aimed at causing harm or gaining unauthorized access. | Hacking, Data theft, Malware attacks                    |
| 2       | **Unintentional Threats** | Accidental actions that compromise security.                             | Human error, Misconfiguration, Accidental data deletion |


# C. Based on Nature

| Sr. No. | Threat Type               | Description                                                   | Examples                                         |
| ------- | ------------------------- | ------------------------------------------------------------- | ------------------------------------------------ |
| 1       | **Natural Threats**       | Threats caused by natural disasters.                          | Earthquake, Flood, Fire, Tsunami                 |
| 2       | **Human Threats**         | Threats caused by human activities.                           | Insider attacks, Hackers, Sabotage               |
| 3       | **Environmental Threats** | Threats caused by environmental conditions affecting systems. | Power failure, Temperature rise, Humidity issues |


# D. Based on Impact

| Sr. No. | Attack Type      | Description                               | Security Property Affected   | Examples                                          |
| ------- | ---------------- | ----------------------------------------- | ---------------------------- | ------------------------------------------------- |
| 1       | **Interception** | Unauthorized access to information.       | **Confidentiality**          | Sniffing, Eavesdropping, Wiretapping              |
| 2       | **Modification** | Unauthorized alteration of data.          | **Integrity**                | Data tampering, Man-in-the-Middle (MITM)          |
| 3       | **Interruption** | Making resources or services unavailable. | **Availability**             | DoS, DDoS, System crashes                         |
| 4       | **Fabrication**  | Creation of fake or forged data.          | **Authenticity / Integrity** | Fake emails, Spoofed packets, Forged transactions |

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Summary Table

| Attack          | CIA Impact               |
| --------------- | ------------------------ |
| Sniffing        | Confidentiality          |
| Phishing        | Confidentiality          |
| SQL Injection   | Integrity                |
| Malware         | Integrity                |
| DDoS            | Availability             |
| Ransomware      | Availability + Integrity |
| Data Tampering  | Integrity                |
| Password Attack | Confidentiality          |

---

# Important Exam Points

### Remember

CIA = Confidentiality + Integrity + Availability

AAA = Authentication + Authorization + Accounting

Risk = Threat × Vulnerability × Impact

---

### Common Exam Question

Difference between Threat and Vulnerability

| Threat           | Vulnerability      |
| ---------------- | ------------------ |
| Potential danger | Weakness           |
| Hacker           | Weak password      |
| Malware          | Unpatched software |

---

### Difference Between Attack and Threat

| Threat              | Attack               |
| ------------------- | -------------------- |
| Possibility of harm | Actual attempt       |
| Virus exists        | Virus infects system |

---

### Difference Between Virus and Worm

| Virus                | Worm             |
| -------------------- | ---------------- |
| Needs host file      | No host required |
| User action required | Self-spreading   |
| Slower spread        | Faster spread    |

---

# MCQs (Exam-Oriented)

### 1. Which principle ensures data is accessible when required?

A. Confidentiality
B. Integrity
C. Availability
D. Authentication

✅ Answer: C

---

### 2. Which attack targets human psychology?

A. SQL Injection
B. Social Engineering
C. DDoS
D. Buffer Overflow

✅ Answer: B

---

### 3. Which malware encrypts files and demands payment?

A. Worm
B. Virus
C. Ransomware
D. Adware

✅ Answer: C

---

### 4. Which principle means giving minimum permissions?

A. Need to Know
B. Least Privilege
C. Accountability
D. Privacy

✅ Answer: B

---

### 5. Which attack affects Availability?

A. Sniffing
B. DDoS
C. Phishing
D. Spoofing

✅ Answer: B

---

### 6. Which is a passive attack?

A. DDoS
B. SQL Injection
C. Sniffing
D. Malware

✅ Answer: C

---

### 7. Tailgating is a type of:

A. Malware
B. Social Engineering
C. DDoS
D. Worm

✅ Answer: B

---

### 8. What is the weakest link in information security?

A. Firewall
B. Router
C. Human Users
D. Antivirus

✅ Answer: C

---

### 9. Which security control is a firewall?

A. Administrative
B. Physical
C. Technical
D. Operational

✅ Answer: C

---

### 10. Which attack intercepts communication between two parties?

A. SQL Injection
B. MITM
C. DDoS
D. Virus

✅ Answer: B

---

# Placement Quick Revision (1 Minute)

✅ CIA = Confidentiality, Integrity, Availability

✅ AAA = Authentication, Authorization, Accounting

✅ Threat = Potential danger

✅ Vulnerability = Weakness

✅ Risk = Threat exploiting Vulnerability

✅ Virus → Needs host

✅ Worm → Self-spreading

✅ Trojan → Looks legitimate

✅ Ransomware → Encrypts data

✅ Phishing → Fake emails

✅ Vishing → Voice calls

✅ Smishing → SMS attacks

✅ DoS → Single attacker

✅ DDoS → Multiple attackers

✅ MITM → Intercepts communication

✅ Least Privilege + Defense in Depth + Zero Trust = Frequently Asked Concepts in exams and placements.




# 100 MCQs on Information Security

*(Security Management, Human Side of Security, Threats, Attacks, Classification of Threats & Attacks)*

---

## 1. The primary goal of Information Security is to protect:

A) Hardware only
B) Software only
C) Information and systems
D) Network cables

✅ Answer: C

---

## 2. Which of the following is NOT part of CIA Triad?

A) Confidentiality
B) Integrity
C) Availability
D) Authentication

✅ Answer: D

---

## 3. Confidentiality means:

A) Data is accurate
B) Data is available
C) Data is accessible only to authorized users
D) Data is encrypted

✅ Answer: C

---

## 4. Integrity ensures:

A) Authorized access only
B) Data remains accurate and unaltered
C) Data backup
D) Fast processing

✅ Answer: B

---

## 5. Availability means:

A) Data is hidden
B) Data is always encrypted
C) Systems are accessible when needed
D) Data cannot be modified

✅ Answer: C

---

## 6. Authentication is used to:

A) Grant permissions
B) Verify identity
C) Encrypt files
D) Detect malware

✅ Answer: B

---

## 7. Authorization determines:

A) Who the user is
B) What a user can access
C) Password complexity
D) Data integrity

✅ Answer: B

---

## 8. Non-repudiation prevents:

A) Malware attacks
B) Data loss
C) Denial of performed actions
D) DDoS attacks

✅ Answer: C

---

## 9. An audit log supports:

A) Availability
B) Confidentiality
C) Accountability
D) Encryption

✅ Answer: C

---

## 10. Which is an example of an asset?

A) Virus
B) Firewall
C) Customer Database
D) Vulnerability

✅ Answer: C

---

## 11. A weakness in a system is called:

A) Threat
B) Vulnerability
C) Risk
D) Attack

✅ Answer: B

---

## 12. Anything capable of causing harm is called:

A) Asset
B) Threat
C) Policy
D) Control

✅ Answer: B

---

## 13. Risk exists when:

A) Assets are encrypted
B) Threat exploits vulnerability
C) Passwords are changed
D) Firewalls are installed

✅ Answer: B

---

## 14. Security policies are examples of:

A) Physical controls
B) Technical controls
C) Administrative controls
D) Network controls

✅ Answer: C

---

## 15. Which is a technical control?

A) Security guard
B) CCTV
C) Firewall
D) Locked room

✅ Answer: C

---

## 16. CCTV is a:

A) Technical control
B) Administrative control
C) Physical control
D) Software control

✅ Answer: C

---

## 17. The principle of giving minimum permissions is:

A) Defense in Depth
B) Least Privilege
C) Need to Know
D) Availability

✅ Answer: B

---

## 18. Multiple security layers represent:

A) Authentication
B) Authorization
C) Defense in Depth
D) Accountability

✅ Answer: C

---

## 19. Zero Trust follows:

A) Trust Everyone
B) Trust Internal Users Only
C) Never Trust, Always Verify
D) Verify Once

✅ Answer: C

---

## 20. Separation of Duties helps prevent:

A) Hardware failure
B) Fraud and abuse
C) Encryption issues
D) DDoS attacks

✅ Answer: B

---

# Human Side of Security

## 21. The weakest link in security is often:

A) Firewall
B) Human Users
C) Antivirus
D) Router

✅ Answer: B

---

## 22. "123456" is an example of:

A) Strong password
B) Weak password
C) Encrypted password
D) OTP

✅ Answer: B

---

## 23. Using the same password on multiple websites is:

A) Recommended
B) Secure practice
C) Password Reuse
D) Encryption

✅ Answer: C

---

## 24. Social engineering primarily exploits:

A) Hardware flaws
B) Human psychology
C) Network topology
D) Databases

✅ Answer: B

---

## 25. Phishing commonly occurs through:

A) Email
B) Router
C) Printer
D) Switch

✅ Answer: A

---

## 26. Targeted phishing is called:

A) Smishing
B) Vishing
C) Spear Phishing
D) Baiting

✅ Answer: C

---

## 27. Attacks aimed at executives are:

A) Tailgating
B) Whaling
C) Sniffing
D) ARP Poisoning

✅ Answer: B

---

## 28. Voice phishing is:

A) Smishing
B) Vishing
C) Phishing
D) Spoofing

✅ Answer: B

---

## 29. SMS phishing is:

A) Vishing
B) Smishing
C) Whaling
D) Worming

✅ Answer: B

---

## 30. Following someone into a restricted area is:

A) Baiting
B) Tailgating
C) Spoofing
D) Sniffing

✅ Answer: B

---

## 31. A fake scenario created to steal information is:

A) Pretexting
B) Worming
C) DDoS
D) Spoofing

✅ Answer: A

---

## 32. A malicious insider acts:

A) Accidentally
B) Intentionally
C) Randomly
D) Indirectly

✅ Answer: B

---

## 33. Accidentally emailing confidential data is:

A) Malicious insider threat
B) Negligent insider threat
C) DDoS attack
D) Malware attack

✅ Answer: B

---

## 34. Security awareness training helps reduce:

A) Floods
B) Human errors
C) Earthquakes
D) Power outages

✅ Answer: B

---

## 35. Clicking unknown links may lead to:

A) Security improvement
B) Security compromise
C) Better encryption
D) Better authentication

✅ Answer: B

---

# Threats to Information Systems

## 36. Fire is classified as:

A) Natural threat
B) Human threat
C) Logical threat
D) Malware

✅ Answer: A

---

## 37. Flood is a:

A) Human threat
B) Environmental threat
C) Natural threat
D) Technical threat

✅ Answer: C

---

## 38. Earthquake is:

A) Natural threat
B) Malware
C) Technical threat
D) Insider threat

✅ Answer: A

---

## 39. Power failure is:

A) Human threat
B) Environmental threat
C) Social engineering
D) Malware

✅ Answer: B

---

## 40. Software bugs are:

A) Natural threats
B) Technical threats
C) Environmental threats
D) Physical threats

✅ Answer: B

---

## 41. Hardware failure is:

A) Technical threat
B) Human threat
C) Social threat
D) Physical attack

✅ Answer: A

---

## 42. Data theft is generally:

A) Intentional threat
B) Natural threat
C) Environmental threat
D) Accidental threat

✅ Answer: A

---

## 43. Employee mistake is:

A) Intentional threat
B) Unintentional threat
C) Malware
D) DDoS

✅ Answer: B

---

## 44. Network outage is a:

A) Technical threat
B) Natural threat
C) Human threat
D) Insider threat

✅ Answer: A

---

## 45. Espionage refers to:

A) Spying for information
B) Malware removal
C) Data backup
D) Encryption

✅ Answer: A

---

# Threats and Attacks

## 46. An attack is:

A) Potential danger
B) Actual exploitation attempt
C) Security policy
D) Asset

✅ Answer: B

---

## 47. Passive attacks mainly involve:

A) Data modification
B) Data destruction
C) Monitoring activity
D) Encrypting files

✅ Answer: C

---

## 48. Active attacks involve:

A) Monitoring only
B) Data modification/disruption
C) Observation only
D) Logging

✅ Answer: B

---

## 49. Eavesdropping is:

A) Active attack
B) Passive attack
C) Malware
D) DDoS

✅ Answer: B

---

## 50. Packet sniffing is:

A) Passive attack
B) Active attack
C) Physical attack
D) Social engineering

✅ Answer: A

---

## 51. Traffic analysis is:

A) Active attack
B) Passive attack
C) Malware attack
D) Physical attack

✅ Answer: B

---

## 52. SQL Injection targets:

A) Databases
B) Routers
C) Switches
D) Firewalls

✅ Answer: A

---

## 53. MITM stands for:

A) Man in the Middle
B) Machine in the Machine
C) Multiple Internet Transfer Method
D) Malware in the Memory

✅ Answer: A

---

## 54. Session Hijacking involves:

A) Stealing active sessions
B) Encrypting files
C) Creating malware
D) Destroying hardware

✅ Answer: A

---

## 55. DoS stands for:

A) Denial of Service
B) Data of Security
C) Denial of Security
D) Data of Service

✅ Answer: A

---

## 56. DDoS uses:

A) Single system
B) Multiple systems
C) One router
D) One user

✅ Answer: B

---

# Malware

## 57. Malware that requires a host file:

A) Worm
B) Virus
C) Trojan
D) Spyware

✅ Answer: B

---

## 58. Malware that spreads automatically:

A) Virus
B) Worm
C) Trojan
D) Rootkit

✅ Answer: B

---

## 59. Malware disguised as legitimate software:

A) Worm
B) Trojan Horse
C) Virus
D) Botnet

✅ Answer: B

---

## 60. Malware that encrypts files:

A) Spyware
B) Adware
C) Ransomware
D) Rootkit

✅ Answer: C

---

## 61. Spyware primarily:

A) Displays ads
B) Steals information
C) Encrypts files
D) Deletes systems

✅ Answer: B

---

## 62. Adware primarily:

A) Steals passwords
B) Displays advertisements
C) Encrypts disks
D) Creates botnets

✅ Answer: B

---

## 63. Rootkit is used to:

A) Detect malware
B) Hide malicious activity
C) Encrypt files
D) Backup data

✅ Answer: B

---

## 64. A collection of infected devices is:

A) Worm
B) Trojan
C) Botnet
D) Virus

✅ Answer: C

---

## 65. WannaCry is:

A) Worm only
B) Trojan
C) Ransomware
D) Adware

✅ Answer: C

---

# Network Attacks

## 66. ARP Spoofing manipulates:

A) MAC-IP mapping
B) DNS records
C) Passwords
D) Cookies

✅ Answer: A

---

## 67. DNS Spoofing returns:

A) Genuine DNS results
B) Fake DNS responses
C) Encrypted DNS packets
D) No response

✅ Answer: B

---

## 68. IP Spoofing involves:

A) Fake MAC address
B) Fake IP address
C) Fake DNS response
D) Fake Password

✅ Answer: B

---

## 69. Brute-force attack tries:

A) Common passwords only
B) Every possible password
C) DNS entries
D) MAC addresses

✅ Answer: B

---

## 70. Dictionary attack uses:

A) Random strings
B) Password dictionaries
C) Encryption keys
D) Cookies

✅ Answer: B

---

## 71. Credential Stuffing uses:

A) AI-generated passwords
B) Leaked credentials
C) Hardware exploits
D) DNS poisoning

✅ Answer: B

---

# Classification of Threats

## 72. Threats originating inside an organization are:

A) External threats
B) Internal threats
C) Natural threats
D) Environmental threats

✅ Answer: B

---

## 73. Hackers from outside are:

A) Internal threats
B) External threats
C) Environmental threats
D) Physical controls

✅ Answer: B

---

## 74. Human error is:

A) Intentional threat
B) Unintentional threat
C) Natural threat
D) Environmental threat

✅ Answer: B

---

## 75. Flood belongs to:

A) Technical threat
B) Natural threat
C) Insider threat
D) Social threat

✅ Answer: B

---

## 76. Hacking is:

A) Intentional threat
B) Environmental threat
C) Natural threat
D) Unintentional threat

✅ Answer: A

---

## 77. Data tampering affects:

A) Availability
B) Integrity
C) Confidentiality
D) Privacy

✅ Answer: B

---

## 78. Sniffing affects:

A) Integrity
B) Availability
C) Confidentiality
D) Authentication

✅ Answer: C

---

## 79. DDoS mainly affects:

A) Confidentiality
B) Integrity
C) Availability
D) Privacy

✅ Answer: C

---

## 80. Fabrication means:

A) Destroying data
B) Creating fake data
C) Encrypting data
D) Monitoring traffic

✅ Answer: B

---

# Mixed Questions

## 81. Which is NOT malware?

A) Virus
B) Worm
C) Firewall
D) Trojan

✅ Answer: C

---

## 82. Which attack is social engineering?

A) Tailgating
B) DDoS
C) SQL Injection
D) ARP Spoofing

✅ Answer: A

---

## 83. Which principle restricts information access?

A) Need to Know
B) DDoS
C) Integrity
D) Availability

✅ Answer: A

---

## 84. Which attack steals communication data?

A) Sniffing
B) Antivirus
C) Encryption
D) Backup

✅ Answer: A

---

## 85. Which malware records user activity?

A) Spyware
B) Firewall
C) IDS
D) Router

✅ Answer: A

---

## 86. Passwords help provide:

A) Authentication
B) Availability
C) Physical security
D) Data backup

✅ Answer: A

---

## 87. Firewall primarily protects:

A) Network traffic
B) Hard disk only
C) Monitor
D) Printer

✅ Answer: A

---

## 88. IDS stands for:

A) Intrusion Detection System
B) Internet Data Service
C) Internal Data Security
D) Intrusion Data Service

✅ Answer: A

---

## 89. Security guards are:

A) Technical controls
B) Physical controls
C) Administrative controls
D) Logical controls

✅ Answer: B

---

## 90. Employee training is:

A) Technical control
B) Administrative control
C) Physical control
D) Environmental control

✅ Answer: B

---

## 91. Least Privilege reduces:

A) Unauthorized access
B) Internet speed
C) CPU performance
D) Storage

✅ Answer: A

---

## 92. Which attack uses fake websites?

A) Phishing
B) Worm
C) DDoS
D) Rootkit

✅ Answer: A

---

## 93. Which attack can intercept login credentials?

A) MITM
B) Antivirus
C) Backup
D) Firewall

✅ Answer: A

---

## 94. Which security objective prevents unauthorized disclosure?

A) Integrity
B) Availability
C) Confidentiality
D) Accountability

✅ Answer: C

---

## 95. Which objective ensures data correctness?

A) Integrity
B) Availability
C) Confidentiality
D) Privacy

✅ Answer: A

---

## 96. Which objective ensures service access?

A) Integrity
B) Availability
C) Confidentiality
D) Authentication

✅ Answer: B

---

## 97. Which malware creates hidden access?

A) Trojan
B) Antivirus
C) Backup Tool
D) Firewall

✅ Answer: A

---

## 98. Which attack is passive?

A) SQL Injection
B) Sniffing
C) DDoS
D) Ransomware

✅ Answer: B

---

## 99. Which attack is active?

A) Traffic Analysis
B) Eavesdropping
C) DDoS
D) Sniffing

✅ Answer: C

---

## 100. The best summary of information security is:

A) Protecting information from threats while maintaining CIA
B) Installing antivirus only
C) Using strong passwords only
D) Blocking all internet access

✅ Answer: A

---

# Most Important MCQs for Exams (Frequently Asked)

⭐ CIA Triad

⭐ Least Privilege

⭐ Defense in Depth

⭐ Zero Trust

⭐ Phishing vs Spear Phishing vs Whaling

⭐ Virus vs Worm vs Trojan

⭐ DoS vs DDoS

⭐ Threat vs Vulnerability vs Risk

⭐ Active vs Passive Attacks

⭐ Internal vs External Threats

⭐ Administrative vs Technical vs Physical Controls

⭐ Confidentiality vs Integrity vs Availability

These topics alone account for a large portion of university and placement aptitude/security MCQs.
