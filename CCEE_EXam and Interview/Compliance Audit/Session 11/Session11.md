```
Session 12: (2T)
Theory:• Centre for Internet Security (CIS) Critical Security Controls
• CIS Compliance
• CIS Controls
• CIS Benchmarks
```

# Session 12 Notes: CIS Critical Security Controls, CIS Compliance, CIS Controls & CIS Benchmarks

---

# 1. Introduction to CIS

**CIS (Center for Internet Security)** is a non-profit organization that develops globally recognized cybersecurity best practices.

**Purpose:**

* Improve cybersecurity posture
* Reduce cyber risks
* Provide standardized security guidelines
* Help organizations achieve compliance

### Key CIS Offerings

1. CIS Critical Security Controls (CIS Controls)
2. CIS Benchmarks
3. CIS Hardened Images
4. CIS SecureSuite
5. CIS Compliance Programs

---

# 2. CIS Critical Security Controls (CIS Controls)

## Definition

A prioritized set of cybersecurity best practices designed to defend organizations against common cyber attacks.

Current Version:

### CIS Controls Version 8

These controls help organizations:

✔ Prevent attacks
✔ Detect threats
✔ Respond to incidents
✔ Recover from breaches

---

# 3. Why CIS Controls are Important

### Benefits

* Risk Reduction
* Standardized Security
* Easier Compliance
* Better Visibility
* Improved Incident Response
* Cost Effective Security

---

# 4. CIS Controls v8 (18 Controls)

## Control 1: Inventory and Control of Enterprise Assets

Know all devices connected to the network.

Examples:

* Laptops
* Servers
* Mobile Devices
* IoT Devices

Exam Point:

> You cannot secure what you cannot identify.

---

## Control 2: Inventory and Control of Software Assets

Track all software installed.

Purpose:

* Remove unauthorized software
* Detect shadow IT

---

## Control 3: Data Protection

Protect sensitive data.

Examples:

* Encryption
* Data Classification
* Backup

---

## Control 4: Secure Configuration of Enterprise Assets and Software

Maintain secure system settings.

Examples:

* Disable unused services
* Change default passwords

---

## Control 5: Account Management

Manage user accounts securely.

Examples:

* Disable inactive accounts
* Role-based access

---

## Control 6: Access Control Management

Ensure only authorized access.

Examples:

* Least Privilege
* MFA

---

## Control 7: Continuous Vulnerability Management

Regularly identify vulnerabilities.

Tools:

* Nessus
* OpenVAS
* Qualys

---

## Control 8: Audit Log Management

Collect and monitor logs.

Examples:

* Windows Event Logs
* Linux Syslogs

---

## Control 9: Email and Web Browser Protections

Protect against phishing and malicious websites.

Examples:

* Spam Filtering
* URL Filtering

---

## Control 10: Malware Defenses

Prevent malware infections.

Examples:

* Antivirus
* EDR Solutions

---

## Control 11: Data Recovery

Ensure recovery after incidents.

Examples:

* Backups
* Disaster Recovery Plans

---

## Control 12: Network Infrastructure Management

Secure routers, switches, and firewalls.

Examples:

* Network Segmentation
* Secure Configurations

---

## Control 13: Network Monitoring and Defense

Detect malicious network activity.

Examples:

* IDS
* IPS
* SIEM

---

## Control 14: Security Awareness and Skills Training

Train employees against cyber threats.

Examples:

* Phishing Awareness
* Password Security

---

## Control 15: Service Provider Management

Manage third-party vendors.

Examples:

* Vendor Risk Assessments
* Security Contracts

---

## Control 16: Application Software Security

Develop secure applications.

Examples:

* SAST
* DAST
* Secure Coding

---

## Control 17: Incident Response Management

Prepare for security incidents.

Examples:

* IR Team
* Playbooks

---

## Control 18: Penetration Testing

Validate security controls through testing.

Examples:

* Internal Pentest
* External Pentest

---

# 5. CIS Implementation Groups (IG)

Organizations implement CIS Controls based on risk level.

---

## IG1 (Basic Cyber Hygiene)

Suitable for:

* Small Businesses
* Startups

Focus:

* Essential protections

---

## IG2 (Intermediate)

Suitable for:

* Medium Organizations

Focus:

* More advanced security controls

---

## IG3 (Advanced)

Suitable for:

* Large Enterprises
* Critical Infrastructure

Focus:

* Sophisticated threat protection

---

# 6. CIS Benchmarks

## Definition

CIS Benchmarks are secure configuration guidelines for systems and applications.

They provide hardening recommendations.

---

## Examples

### Operating Systems

* Windows Server
* Windows 11
* Ubuntu
* Red Hat Linux

### Cloud Platforms

* AWS
* Azure
* GCP

### Databases

* MySQL
* PostgreSQL
* Oracle

### Network Devices

* Cisco Routers
* Firewalls

---

# 7. Purpose of CIS Benchmarks

### Goals

* Reduce Attack Surface
* Remove Weak Configurations
* Improve Security
* Standardize Hardening

---

# 8. CIS Benchmark Hardening Examples

## Windows

Disable:

* Guest Account
* SMBv1
* Unused Services

Enable:

* Firewall
* Logging
* Strong Password Policies

---

## Linux

Disable:

* Root SSH Login
* Unused Services

Enable:

* Auditd
* Firewall
* Secure Permissions

---

## Database

* Strong Authentication
* Encryption
* Logging
* Restrict Remote Access

---

# 9. CIS Compliance

## Definition

CIS Compliance means systems adhere to CIS Benchmarks and CIS Controls.

Organizations evaluate whether configurations meet CIS recommendations.

---

## Compliance Process

### Step 1

Identify assets

↓

### Step 2

Apply CIS Benchmarks

↓

### Step 3

Scan systems

↓

### Step 4

Identify gaps

↓

### Step 5

Remediate findings

↓

### Step 6

Generate compliance reports

---

# 10. CIS Compliance Tools

### CIS-CAT Pro Assessor

Official CIS Assessment Tool

Functions:

* Benchmark Scanning
* Compliance Reporting
* Gap Analysis

---

### Other Tools

* Lynis
* OpenSCAP
* Nessus
* Qualys
* OpenVAS

---

# 11. CIS Controls vs CIS Benchmarks

| CIS Controls       | CIS Benchmarks                      |
| ------------------ | ----------------------------------- |
| What to secure     | How to secure                       |
| Strategic          | Technical                           |
| 18 Controls        | Thousands of configuration settings |
| Security Program   | System Hardening                    |
| Organization Level | Device/Application Level            |

### Exam Trick

**Controls = What**

**Benchmarks = How**

---

# 12. CIS vs NIST

| CIS                   | NIST                |
| --------------------- | ------------------- |
| More Practical        | More Comprehensive  |
| Easier Implementation | More Documentation  |
| 18 Controls           | Multiple Frameworks |
| Operational Focus     | Governance Focus    |

---

# 13. Real World Example

Company wants secure Ubuntu Server.

Uses:

1. CIS Benchmark for Ubuntu
2. Disable Root Login
3. Enable Firewall
4. Enable Logging
5. Configure Password Policy

Result:

* CIS Compliant Server

---

# Important Exam Points

### Remember

**CIS = Center for Internet Security**

**Current CIS Controls = 18**

**Current Version = CIS Controls v8**

**Implementation Groups = IG1, IG2, IG3**

**Controls = What to Secure**

**Benchmarks = How to Secure**

**CIS-CAT = Official Assessment Tool**

**Goal of CIS Benchmarks = System Hardening**

---

# Frequently Asked MCQs

### Q1. CIS stands for?

A. Cyber Information Security
B. Center for Internet Security
C. Central Information Security
D. Cyber Infrastructure Security

✅ Answer: B

---

### Q2. How many CIS Controls are there in Version 8?

A. 10
B. 15
C. 18
D. 20

✅ Answer: C

---

### Q3. Which CIS Control focuses on vulnerability scanning?

A. Control 5
B. Control 7
C. Control 12
D. Control 16

✅ Answer: B

---

### Q4. CIS Benchmarks primarily provide:

A. Governance Policies
B. Secure Configuration Standards
C. Risk Assessments
D. Incident Response Plans

✅ Answer: B

---

### Q5. Which tool is developed by CIS for compliance assessment?

A. Nessus
B. OpenVAS
C. CIS-CAT
D. Splunk

✅ Answer: C

---

### Q6. Which Implementation Group is for small businesses?

A. IG1
B. IG2
C. IG3
D. IG4

✅ Answer: A

---

### Q7. CIS Benchmarks are mainly used for:

A. Hardening Systems
B. Monitoring Traffic
C. Coding Applications
D. Encryption

✅ Answer: A

---

### Q8. Which CIS Control deals with Incident Response?

A. Control 10
B. Control 12
C. Control 17
D. Control 18

✅ Answer: C

---

### Q9. Which control focuses on log collection?

A. Control 4
B. Control 8
C. Control 13
D. Control 15

✅ Answer: B

---

### Q10. Which CIS Control focuses on penetration testing?

A. Control 15
B. Control 16
C. Control 17
D. Control 18

✅ Answer: D

---

# Last-Minute Revision Sheet (1 Minute)

* CIS = Center for Internet Security
* CIS Controls v8 = 18 Controls
* IG1 = Basic
* IG2 = Intermediate
* IG3 = Advanced
* CIS Benchmarks = Secure Configuration Standards
* CIS-CAT = Compliance Assessment Tool
* Control 7 = Vulnerability Management
* Control 8 = Audit Log Management
* Control 17 = Incident Response
* Control 18 = Penetration Testing
* Controls = What to Secure
* Benchmarks = How to Secure
* Compliance = Following CIS Recommendations

### Memory Shortcut

**"Inventory, Software, Data, Config, Accounts, Access, Vulnerabilities, Logs, Email, Malware, Recovery, Network, Monitoring, Training, Vendors, Apps, Incident, Pentest"**

(1 → 18 CIS Controls in order) ✔


