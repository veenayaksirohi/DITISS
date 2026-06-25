# Session 1: Information Security Notes (Exam + MCQ Oriented)

---

# 1. Introduction to Information Security (InfoSec)

### Definition

Information Security (InfoSec) is the practice of protecting information and information systems from:

* Unauthorized Access
* Unauthorized Use
* Disclosure
* Modification
* Destruction
* Disruption

### Goal of Information Security

Protect information assets and ensure business continuity.

### Core Objectives (CIA Triad)

#### 1. Confidentiality

Ensures information is accessible only to authorized users.

**Examples:**

* Passwords
* Encryption
* Access Control

#### 2. Integrity

Ensures data remains accurate and unaltered.

**Examples:**

* Hashing
* Digital Signatures
* Checksums

#### 3. Availability

Ensures data and services are available when needed.

**Examples:**

* Backups
* Redundancy
* Disaster Recovery

---

## Additional Security Principles

### Authentication

Verifying identity.

Example:

* Username & Password
* OTP
* Biometrics

### Authorization

Determines what an authenticated user can access.

### Accountability

Tracking user actions through logs.

### Non-Repudiation

Prevents denial of actions performed.

Example:

* Digital Signature

---

# 2. Why Information Security?

Organizations depend heavily on digital data.

### Reasons

### 1. Protect Sensitive Information

* Customer Data
* Financial Data
* Medical Records

### 2. Prevent Cyber Attacks

* Malware
* Phishing
* Ransomware

### 3. Maintain Business Continuity

Security incidents can stop operations.

### 4. Legal Compliance

Organizations must follow regulations.

Examples:

* GDPR
* HIPAA
* PCI-DSS

### 5. Protect Reputation

A data breach damages customer trust.

---

## Importance of Information Security

| Aspect          | Importance             |
| --------------- | ---------------------- |
| Confidentiality | Protects privacy       |
| Integrity       | Ensures correctness    |
| Availability    | Keeps services running |
| Compliance      | Avoids legal penalties |
| Trust           | Maintains reputation   |

---

# 3. Security: The Money Factor Involved

Security is both a technical and financial issue.

---

## Cost of Security

### Direct Costs

* Firewalls
* Antivirus
* IDS/IPS
* Security Staff
* Training

### Indirect Costs

* Downtime
* Productivity Loss
* Reputation Damage

---

## Cost of Cyber Attacks

### Data Breach Costs

* Recovery Cost
* Legal Cost
* Compensation
* Reputation Loss

### Example

A ransomware attack may cause:

* Business shutdown
* Data loss
* Revenue loss
* Recovery expenses

---

## Return on Security Investment (ROSI)

Measures value gained from security controls.

### Formula

ROSI = (Risk Exposure Reduction − Cost of Security) / Cost of Security

---

## Security Budget Components

1. Hardware Security
2. Software Security
3. Employee Training
4. Incident Response
5. Compliance Audits

---

### Exam Point

**Question:** Why should companies invest in cybersecurity?

**Answer:**

* Prevent financial losses
* Protect sensitive information
* Maintain business continuity
* Meet compliance requirements
* Protect brand reputation

---

# 4. Internet Statistics from Security Perspective

The internet is growing rapidly, increasing security risks.

---

## Security Concerns

### Massive Number of Users

More users = Larger attack surface.

### Increase in Connected Devices

* Smartphones
* Laptops
* IoT Devices

### Cloud Adoption

Data stored online increases exposure.

### Remote Work

Introduces new security challenges.

---

## Common Internet Threats

### Malware

Malicious software designed to harm systems.

Examples:

* Virus
* Worm
* Trojan

### Phishing

Fraudulent attempts to steal credentials.

### Ransomware

Encrypts files and demands payment.

### DDoS Attack

Overwhelms servers with traffic.

### Data Breaches

Unauthorized access to confidential data.

---

## Security Trends

* Increasing cybercrime
* AI-powered attacks
* Cloud attacks
* Mobile attacks
* IoT vulnerabilities

---

### Exam Point

**Why do internet statistics matter to security professionals?**

Because they help:

* Identify threats
* Assess risks
* Develop security strategies
* Allocate resources effectively

---

# 5. Vulnerability, Threat and Risk

This is one of the MOST IMPORTANT EXAM TOPICS.

---

## Vulnerability

### Definition

A weakness in a system that can be exploited.

### Examples

* Weak Password
* Unpatched Software
* Misconfigured Firewall
* Open Ports

---

## Threat

### Definition

Anything capable of exploiting a vulnerability.

### Examples

* Hacker
* Malware
* Insider Attack
* Natural Disaster

---

## Risk

### Definition

Probability that a threat exploits a vulnerability causing damage.

### Formula

Risk = Threat × Vulnerability × Impact

---

## Easy Example

System:

* Weak Password

Vulnerability:

* Weak Password

Threat:

* Hacker

Risk:

* Hacker gains unauthorized access

---

## Comparison Table

| Parameter | Vulnerability     | Threat                   | Risk                                      |
| --------- | ----------------- | ------------------------ | ----------------------------------------- |
| Meaning   | Weakness          | Potential danger         | Expected damage                           |
| Nature    | Internal weakness | External/Internal source | Result of threat exploiting vulnerability |
| Example   | Weak password     | Hacker                   | Account compromise                        |

---

## Relationship

```text
Vulnerability + Threat = Risk
```

OR

```text
Threat exploits Vulnerability → Risk occurs
```

---

### Real-Life Example

House:

* Open Door = Vulnerability
* Burglar = Threat
* Theft = Risk

---

### 5 Mark Answer

**Differentiate Vulnerability, Threat and Risk**

A vulnerability is a weakness in a system. A threat is anything capable of exploiting that weakness. Risk is the likelihood and impact of a threat exploiting a vulnerability. For example, a weak password is a vulnerability, a hacker is a threat, and unauthorized account access is the resulting risk.

---

# 6. QoS (Quality of Service)

### Definition

QoS is a network mechanism used to manage and prioritize traffic to ensure reliable performance.

---

## Purpose

* Reduce delay
* Reduce packet loss
* Improve bandwidth utilization
* Prioritize critical applications

---

## Why QoS is Needed?

Different applications require different network performance.

Examples:

| Application   | Requirement        |
| ------------- | ------------------ |
| Voice Calls   | Low Delay          |
| Video Calls   | High Bandwidth     |
| Email         | Less Sensitive     |
| File Transfer | Moderate Bandwidth |

---

## QoS Parameters

### 1. Bandwidth

Amount of data transferred per second.

Measured in:

* Mbps
* Gbps

---

### 2. Latency

Time taken for a packet to travel.

Lower latency is better.

---

### 3. Jitter

Variation in packet arrival time.

Lower jitter is better.

---

### 4. Packet Loss

Packets lost during transmission.

Should be minimal.

---

## QoS Techniques

### Traffic Classification

Identifying traffic types.

### Traffic Shaping

Controlling traffic flow.

### Queuing

Prioritizing important packets.

### Congestion Avoidance

Preventing network overload.

---

## Applications of QoS

* VoIP
* Video Conferencing
* Online Gaming
* Streaming Services

---

# Important MCQs

### Q1. Which principle ensures data is not modified?

A. Confidentiality
B. Integrity
C. Availability
D. Authentication

✅ Answer: B

---

### Q2. Which principle ensures authorized access only?

A. Confidentiality
B. Integrity
C. Availability
D. QoS

✅ Answer: A

---

### Q3. Weak password is an example of:

A. Threat
B. Risk
C. Vulnerability
D. Attack

✅ Answer: C

---

### Q4. Hacker is an example of:

A. Vulnerability
B. Threat
C. Risk
D. Control

✅ Answer: B

---

### Q5. Risk occurs when:

A. Threat exploits Vulnerability
B. Firewall is installed
C. Encryption is used
D. Authentication fails

✅ Answer: A

---

### Q6. Which QoS parameter measures packet arrival variation?

A. Latency
B. Jitter
C. Throughput
D. Availability

✅ Answer: B

---

### Q7. CIA stands for:

A. Confidentiality, Integrity, Availability
B. Confidentiality, Internet, Access
C. Control, Integrity, Authorization
D. Confidentiality, Identity, Access

✅ Answer: A

---

### Q8. Which attack encrypts files and demands money?

A. Trojan
B. Worm
C. Virus
D. Ransomware

✅ Answer: D

---

# Last Minute Exam Tips

### Remember

```text
CIA = Confidentiality + Integrity + Availability
```

```text
Vulnerability = Weakness
Threat = Danger
Risk = Damage Possibility
```

```text
Threat + Vulnerability = Risk
```

```text
Authentication = Who are you?
Authorization = What can you access?
```

```text
QoS = Bandwidth + Latency + Jitter + Packet Loss
```

---

# Most Important 5-Mark Questions

1. Explain CIA Triad.
2. Why Information Security is Important?
3. Explain Vulnerability, Threat and Risk with examples.
4. Discuss financial impact of cybersecurity incidents.
5. Explain QoS and its parameters.
6. Explain Authentication vs Authorization.
7. Discuss common Internet threats from security perspective.

**Exam Weightage Priority:**
⭐⭐⭐⭐⭐ Vulnerability–Threat–Risk
⭐⭐⭐⭐⭐ CIA Triad
⭐⭐⭐⭐ Security Importance
⭐⭐⭐⭐ QoS Parameters
⭐⭐⭐ Internet Security Statistics
⭐⭐⭐ Security Cost / Money Factor
