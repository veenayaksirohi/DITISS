# Security Fundamentals

## 1. Information Security

### Meaning

**Information Security (InfoSec)** means protecting information and information systems from unauthorized access, modification, disclosure, destruction, or disruption.

Information can exist in many forms:

- Digital files
- Databases
- Emails
- Network traffic
- Paper documents
- Cloud storage
- Backup files

The main goal is to keep information **safe, accurate, and available**.

### Purpose of Information Security

Information Security protects data from:

- Unauthorized access
- Data theft
- Data modification
- Malware
- Ransomware
- Accidental deletion
- Insider threats
- Hardware failure
- Network attacks

### Example

Suppose a company stores customer banking information.

Security controls can include:

```text
Firewall
   ↓
Authentication
   ↓
Encryption
   ↓
Access Control
   ↓
Monitoring
   ↓
Backup
```

These controls protect customer information.

### Interview Definition

> Information Security is the practice of protecting information and systems from unauthorized access, disclosure, modification, destruction, or disruption while maintaining confidentiality, integrity, and availability.

---

# 2. CIA Triad

The **CIA Triad** is the foundation of Information Security.

```text
        CIA Triad
           |
  ---------------------
  |         |         |
Confidentiality Integrity Availability
```

CIA stands for:

- **C — Confidentiality**
- **I — Integrity**
- **A — Availability**

---

## 2.1 Confidentiality

### Meaning

Confidentiality means:

> Information should be accessible only to authorized users.

It prevents unauthorized people from seeing sensitive information.

### Examples

- Passwords
- Bank account information
- Medical records
- Company confidential documents

### Controls used for Confidentiality

- Encryption
- Authentication
- Access Control
- MFA
- VPN
- File permissions
- Network segmentation

### Example

Suppose only HR employees should access employee salary data.

```text
Normal Employee → Denied

HR Employee → Authentication → Allowed
```

This maintains **Confidentiality**.

---

## 2.2 Integrity

### Meaning

Integrity means:

> Data should remain accurate, complete, and unchanged unless an authorized person modifies it.

### Example

Suppose a bank transaction is:

```text
₹1,000
```

An attacker changes it to:

```text
₹10,000
```

The integrity of the information has been violated.

### Controls used for Integrity

- Hashing
- Digital signatures
- Checksums
- File integrity monitoring
- Access control
- Database permissions

### Example

```text
Original File
   ↓
Hash
   ↓
SHA-256 = ABC123...

File Modified
   ↓
New Hash
   ↓
SHA-256 = XYZ789...
```

Different hash indicates that the file was modified.

---

## 2.3 Availability

### Meaning

Availability means:

> Authorized users should be able to access systems and information whenever they need them.

### Threats to Availability

- DoS
- DDoS
- Hardware failure
- Power failure
- Ransomware
- Network failure
- Server failure

### Controls used for Availability

- Backups
- Load balancers
- Redundant servers
- UPS
- Disaster recovery
- High availability
- DDoS protection
- Monitoring

### Example

```text
User
 ↓
Load Balancer
 ↓
Server 1
Server 2
Server 3
```

If Server 1 fails, Server 2 or Server 3 can continue providing the service.

---

# CIA Triad Example

Suppose an online banking application is running.

| CIA Component   | Requirement                                  |
| --------------- | -------------------------------------------- |
| Confidentiality | Only the customer should see account details |
| Integrity       | Transaction amounts must not be modified     |
| Availability    | Banking service should remain accessible     |

---

# 3. Vulnerability

### Meaning

A **Vulnerability** is:

> A weakness in a system, application, network, configuration, or process that can be exploited.

A vulnerability itself is not an attack.

It is a **weakness that may allow an attack**.

### Examples

- Weak password
- Unpatched software
- Open unnecessary ports
- Misconfigured firewall
- Default credentials
- SQL injection vulnerability
- Incorrect file permissions
- Publicly exposed database

### Example

```text
SSH Server
   ↓
Password = admin123
```

Weak password = **Vulnerability**

An attacker may use brute force to exploit it.

---

# 4. Threat

### Meaning

A **Threat** is:

> Anything that has the potential to exploit a vulnerability and cause damage.

Threats can be:

- Human
- Technical
- Natural
- Accidental

### Examples

- Hacker
- Malware
- Ransomware
- Insider
- DDoS attack
- Fire
- Flood
- Power failure
- Accidental deletion

### Example

```text
Weak Password → Vulnerability

Attacker attempting brute force → Threat
```

---

# 5. Risk

### Meaning

**Risk** is:

> The possibility that a threat will exploit a vulnerability and cause damage.

A simple idea is:

```text
Risk = Likelihood × Impact
```

### Likelihood

How likely is the attack to happen?

Examples:

- Low
- Medium
- High

### Impact

How serious would the damage be?

Examples:

- Data loss
- Financial loss
- Downtime
- Reputation damage
- Legal penalties

### Example

Suppose:

```text
Database exposed to Internet
        +
Weak Password
        +
Sensitive Customer Data
```

The risk is high because:

- Exploitation is possible
- Impact would be serious

---

# 6. Vulnerability vs Threat vs Risk

This is a very common interview question.

| Term           | Meaning                             | Example           |
| -------------- | ----------------------------------- | ----------------- |
| Vulnerability  | Weakness                            | Weak SSH password |
| Threat         | Something that may exploit weakness | Hacker            |
| Risk           | Possible damage                     | Server compromise |
| Countermeasure | Protection                          | MFA + firewall    |

### Example

```text
Weak Password
     ↓
Vulnerability

Attacker
     ↓
Threat

Account Compromise
     ↓
Risk

MFA + Strong Password
     ↓
Countermeasure
```

### Interview Answer

> A vulnerability is a weakness, a threat is something that can exploit that weakness, and risk is the possible loss or damage that may happen if the threat successfully exploits the vulnerability.

---

# 7. Attack Vector

### Meaning

An **Attack Vector** is:

> The path or method an attacker uses to gain unauthorized access to a system.

It answers:

> **How did the attacker enter?**

### Common Attack Vectors

- Phishing email
- Weak passwords
- Exposed RDP
- Exposed SSH
- Vulnerable web application
- Malware attachment
- USB device
- VPN account
- Public cloud misconfiguration
- Social engineering

### Example

```text
Attacker
   ↓
Phishing Email
   ↓
Employee Clicks Link
   ↓
Credentials Stolen
   ↓
Company Account Compromised
```

Attack Vector:

**Phishing Email**

---

# 8. Attack Surface

### Meaning

The **Attack Surface** is:

> The total number of possible points where an attacker may try to enter or attack a system.

The larger the attack surface, the more opportunities attackers have.

### Examples

A server may have:

```text
SSH   → 22
HTTP  → 80
HTTPS → 443
RDP   → 3389
MySQL → 3306
```

If all are exposed to the Internet, the attack surface becomes larger.

### Attack Surface Can Include

- Open ports
- APIs
- Web applications
- User accounts
- Cloud services
- Network devices
- Remote access services
- Third-party applications
- Employees

### How to Reduce Attack Surface

- Close unnecessary ports
- Remove unused services
- Disable unused accounts
- Patch systems
- Network segmentation
- Use firewall rules
- Apply least privilege

### Example

Before:

```text
22
80
443
3306
3389
```

After hardening:

```text
443
```

Attack surface is reduced.

---

# 9. Attack Vector vs Attack Surface

| Attack Vector         | Attack Surface                    |
| --------------------- | --------------------------------- |
| Method used to attack | All possible attack points        |
| How attacker enters   | Where attacker could enter        |
| Example: Phishing     | Example: Email, VPN, SSH, Web App |

Example:

```text
Attack Surface:
Web App + SSH + VPN + Email

Attack Vector Used:
Phishing Email
```

---

# 10. Exposure

### Meaning

**Exposure** means:

> The extent to which a system, service, or asset is accessible or visible to potential threats.

### Example

A database configured as:

```text
0.0.0.0/0 → TCP 3306
```

means anyone on the Internet may attempt to connect to it.

This creates high **exposure**.

### Examples of Exposure

- Database publicly accessible
- RDP open to the Internet
- Public S3 bucket
- Sensitive file exposed through web server
- Admin panel available publicly

### Exposure vs Vulnerability

| Exposure                    | Vulnerability              |
| --------------------------- | -------------------------- |
| System is reachable/exposed | System contains weakness   |
| Example: SSH open publicly  | Example: Weak SSH password |

Together they can create serious risk.

---

# 11. Countermeasure

### Meaning

A **Countermeasure** is:

> A security control used to reduce, prevent, detect, or respond to a security risk.

### Examples

| Risk                  | Countermeasure                    |
| --------------------- | --------------------------------- |
| Weak password         | Strong password + MFA             |
| Open unnecessary port | Firewall                          |
| Malware               | Antivirus/EDR                     |
| DDoS                  | Rate limiting/CDN/DDoS protection |
| Data theft            | Encryption                        |
| File modification     | File integrity monitoring         |
| Brute force           | Fail2ban                          |

### Example

```text
Threat:
Brute Force

Vulnerability:
Weak Password

Risk:
Account Compromise

Countermeasure:
MFA + Strong Password + Fail2ban
```

---

# 12. Risk Management

### Meaning

**Risk Management** is:

> The process of identifying, analyzing, treating, and monitoring security risks.

Basic process:

```text
Identify
   ↓
Assess
   ↓
Prioritize
   ↓
Treat
   ↓
Monitor
```

---

## Step 1 — Identify Risk

Find:

- Assets
- Threats
- Vulnerabilities

Example:

```text
Asset → Database

Threat → Attacker

Vulnerability → Weak Password
```

---

## Step 2 — Assess Risk

Determine:

- Likelihood
- Impact

Example:

```text
Likelihood = High
Impact = Critical

Risk = Critical
```

---

## Step 3 — Prioritize Risk

Fix high-risk problems first.

Example:

```text
Critical → Fix immediately
High → Fix quickly
Medium → Plan remediation
Low → Monitor
```

---

## Step 4 — Treat Risk

There are four common approaches.

### Risk Mitigation

Reduce the risk.

Example:

```text
Weak Password
      ↓
Strong Password + MFA
```

### Risk Avoidance

Stop the risky activity.

Example:

A company stops using an insecure application.

### Risk Transfer

Transfer some financial responsibility.

Example:

Cyber insurance.

### Risk Acceptance

Accept the risk if the cost of fixing it is greater than the expected impact.

---

## Step 5 — Monitor Risk

Security risks change over time.

Monitor:

- New vulnerabilities
- New attacks
- Configuration changes
- Security logs
- Software updates

---

# 13. Security Control

### Meaning

A **Security Control** is:

> A measure used to protect systems, networks, data, and users.

Security controls are commonly classified as:

- Preventive
- Detective
- Corrective

---

## Preventive Controls

Prevent an attack from happening.

Examples:

- Firewall
- MFA
- Encryption
- Access control
- Strong passwords
- Network segmentation

```text
Attack
   ↓
Firewall
   ↓
Blocked
```

---

## Detective Controls

Detect security incidents.

Examples:

- IDS
- SIEM
- Logs
- CCTV
- File integrity monitoring
- Security monitoring

```text
Attack
   ↓
IDS
   ↓
Alert
```

---

## Corrective Controls

Reduce damage and restore systems after an incident.

Examples:

- Backup restoration
- Patch installation
- Malware removal
- Password reset
- Rebuilding compromised systems

```text
Attack
   ↓
System Compromised
   ↓
Restore Backup
```

---

# Security Controls Example

Suppose SSH brute force is happening.

### Preventive

- SSH keys
- MFA
- Firewall

### Detective

- Authentication logs
- IDS
- SIEM

### Corrective

- Block attacker IP
- Reset compromised account
- Patch/harden system

---

# 14. Defence in Depth

### Meaning

**Defence in Depth** means:

> Using multiple layers of security so that if one security control fails, other controls can still protect the system.

Never depend on only one security control.

### Example Architecture

```text
Internet
   ↓
Firewall
   ↓
IDS / IPS
   ↓
DMZ
   ↓
WAF
   ↓
Application
   ↓
Authentication + MFA
   ↓
Database Access Control
   ↓
SIEM Monitoring
```

An attacker must bypass multiple layers.

---

## Defence in Depth Example

Suppose an attacker steals a password.

Without defence in depth:

```text
Password Stolen
      ↓
Login Successful
      ↓
Full Access
```

With defence in depth:

```text
Password Stolen
      ↓
MFA
      ↓
Blocked
```

Even if MFA is bypassed:

```text
Network Segmentation
       ↓
Limited Access
```

Even if suspicious activity happens:

```text
SIEM / IDS
    ↓
Alert Generated
```

---

# 15. Why Defence in Depth is Important

No single security system is perfect.

For example:

- Firewall may miss application attacks.
- IDS may miss new attacks.
- Password may get stolen.
- Antivirus may miss new malware.

Therefore multiple security layers are used.

Example:

```text
Firewall
+
IDS/IPS
+
MFA
+
Endpoint Security
+
Network Segmentation
+
SIEM
+
Backups
```

---

# 16. Complete Relationship Between All Concepts

Consider this example:

### System

Linux server with SSH enabled.

### Vulnerability

```text
Weak Password
```

### Exposure

```text
SSH Port 22 open to Internet
```

### Threat

```text
Attacker
```

### Attack Surface

```text
SSH + Web Server + VPN
```

### Attack Vector

```text
SSH Brute Force
```

### Risk

```text
Unauthorized Server Access
```

### Countermeasures

```text
Strong Password
+
SSH Keys
+
MFA
+
Firewall
+
Fail2ban
```

### Detective Controls

```text
Authentication Logs
+
IDS
+
SIEM
```

### Defence in Depth

All the security controls working together.

---

# 17. Must-Know Relationship

```text
Asset
  ↓
Vulnerability
  +
Threat
  ↓
Risk
  ↓
Countermeasure
```

More complete version:

```text
Asset
 ↓
Vulnerability + Exposure
 ↓
Threat
 ↓
Attack Vector
 ↓
Attack
 ↓
Risk / Impact
 ↓
Security Controls
 ↓
Reduced Risk
```

---

# 18. Your SSH Example — Detailed

Original example:

```text
Open SSH port + weak password
          ↓
Brute-force risk
          ↓
MFA + Firewall + Fail2ban
```

Let's break it down.

### Asset

```text
Linux Server
```

### Exposure

```text
SSH Port 22 exposed to Internet
```

### Vulnerability

```text
Weak Password
```

### Threat

```text
External Attacker
```

### Attack Vector

```text
SSH Login
```

### Attack

```text
Brute Force
```

### Risk

```text
Unauthorized Access
```

### Possible Impact

- Data theft
- Malware installation
- Privilege escalation
- Server takeover
- Lateral movement

### Countermeasures

```text
Firewall Restriction
      +
SSH Key Authentication
      +
Strong Password
      +
MFA
      +
Fail2ban
      +
Monitoring
```

---

# 19. Interview Scenario

### Question

**A Linux server has SSH open to the Internet and attackers are continuously trying different passwords. How would you secure it?**

### Answer Approach

```text
1. Check authentication logs
2. Identify repeated failed login attempts
3. Restrict SSH using firewall
4. Allow only trusted IPs if possible
5. Use SSH keys
6. Disable password login where practical
7. Configure Fail2ban
8. Use MFA if supported
9. Monitor using SIEM/IDS
```

This answer shows:

- Vulnerability understanding
- Risk management
- Countermeasure selection
- Defence in depth

---

# 20. Quick Revision Table

| Topic                | Simple Meaning                    | Example                     |
| -------------------- | --------------------------------- | --------------------------- |
| Information Security | Protect information               | Protect customer database   |
| Confidentiality      | Prevent unauthorized viewing      | Encryption                  |
| Integrity            | Prevent unauthorized modification | Hashing                     |
| Availability         | Keep service accessible           | Load balancing              |
| Vulnerability        | Weakness                          | Weak password               |
| Threat               | Something that can cause harm     | Hacker                      |
| Risk                 | Possible damage                   | Server compromise           |
| Attack Vector        | Method/path used to attack        | Phishing                    |
| Attack Surface       | All possible attack points        | SSH + Web + VPN             |
| Exposure             | How accessible something is       | Public DB                   |
| Countermeasure       | Protection against risk           | Firewall                    |
| Risk Management      | Manage security risks             | Identify → Assess → Treat   |
| Preventive Control   | Stops attack                      | MFA                         |
| Detective Control    | Detects attack                    | IDS                         |
| Corrective Control   | Fixes/restores                    | Backup                      |
| Defence in Depth     | Multiple security layers          | Firewall + IDS + MFA + SIEM |

---

# 21. Most Important Interview Questions

1. What is Information Security?
2. What is CIA Triad?
3. Explain Confidentiality with an example.
4. Explain Integrity with an example.
5. Explain Availability with an example.
6. What is a vulnerability?
7. What is a threat?
8. What is risk?
9. Difference between vulnerability, threat, and risk?
10. What is an attack vector?
11. What is an attack surface?
12. Attack vector vs attack surface?
13. What is exposure?
14. Vulnerability vs exposure?
15. What is a countermeasure?
16. What is risk management?
17. Explain risk mitigation, avoidance, transfer, and acceptance.
18. What are preventive, detective, and corrective controls?
19. What is Defence in Depth?
20. Give a real example of Defence in Depth.

---

# 22. One-Line Interview Revision

```text
Information Security
→ Protecting information and systems.

CIA Triad
→ Confidentiality + Integrity + Availability.

Vulnerability
→ Weakness.

Threat
→ Something capable of exploiting a weakness.

Risk
→ Likelihood and impact of exploitation.

Attack Vector
→ Method used by attacker.

Attack Surface
→ All possible attack points.

Exposure
→ How reachable or visible an asset is.

Countermeasure
→ Security control that reduces risk.

Risk Management
→ Identify → Assess → Treat → Monitor.

Security Controls
→ Preventive → Detective → Corrective.

Defence in Depth
→ Multiple layers of security.
```

### Best relationship to remember

```text
Threat
  +
Vulnerability
  ↓
Risk
  ↓
Countermeasure
  ↓
Reduced Risk
```

For interviews, remember one complete example:

```text
Weak SSH Password
      ↓
Vulnerability

Attacker
      ↓
Threat

SSH Brute Force
      ↓
Attack Vector

Server Compromise
      ↓
Risk

Firewall + SSH Keys + MFA + Fail2ban + SIEM
      ↓
Countermeasures / Defence in Depth
```
