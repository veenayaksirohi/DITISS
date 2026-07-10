# Session 1–2: Introduction to Information Security, Risk Management & Firewalls

**Session 1 (2T + 3SL):** Introduction to InfoSec, Why InfoSec, Money Factor, Internet Statistics, Vulnerability/Threat/Risk, QoS
**Session 2 (2T + 4L):** Risk Management, Exposure, Countermeasure, Firewall, DMZ, Firewall Implementation Methods

---

## 1. Introduction to Information Security

Information Security (InfoSec) is the practice of protecting information systems and data from unauthorized access, use, disclosure, disruption, modification, or destruction.

**Core Objective — Protect the CIA Triad:**

| Property | Meaning | Example Control |
|---|---|---|
| Confidentiality | Prevent unauthorized access | Encryption, access control |
| Integrity | Ensure data isn't improperly altered | Hashing, checksums |
| Availability | Ensure systems/data are accessible when needed | Redundancy, QoS |

**Example — Banking system:**
- Only authorized users access accounts → Confidentiality
- Transactions are accurate → Integrity
- Services always available → Availability

---

## 2. Why Information Security?

InfoSec is essential due to increasing reliance on digital systems.

**Key Drivers:**
- **Digital Transformation** — more systems online → larger attack surface
- **Data Sensitivity** — financial, healthcare, personal data require protection
- **Compliance** — GDPR, HIPAA, PCI-DSS mandate security
- **Reputation** — breaches reduce customer trust and business value
- **Cybercrime Growth** — ransomware, APTs increasing in sophistication

---

## 3. Security: The Money Factor

Security has both cost implications and financial benefits.

**Cost of a Breach**
- Average global cost: ~$4.45 million (IBM, 2023)
- Includes: legal penalties, downtime, recovery, customer loss

**Investment in Security**
- Typically 5%–15% of IT budget
- Covers tools (firewalls, IDS/IPS, SIEM), training, staff

**ROI of Security**
- Prevents massive financial losses
- Improves resilience and investor confidence

**Example:** Spending $200K on security can prevent multi-million-dollar breach losses.

---

## 4. Internet Statistics — A Security Perspective

**Key Stats (2024):**
- 5.4+ billion internet users
- 90%+ businesses using cloud
- Millions of new malware samples yearly
- Phishing attacks up ~30%
- 20+ billion IoT devices connected

**Security Implications:**
- More users → more attack vectors
- Cloud adoption → shared responsibility risks
- IoT → expanded attack surface
- High data flow → need for monitoring and encryption

---

## 5. Vulnerability, Threat, and Risk

| Term | Definition | Example |
|---|---|---|
| Vulnerability | Weakness in a system | Unpatched OS, SQL injection flaw |
| Threat | Potential attacker or event | Hacker, malware |
| Risk | Likelihood of threat exploiting vulnerability × impact | Data breach of customer DB |

**Formula:**
```
Risk = Threat × Vulnerability × Impact
```

**Risk Reduction Strategy:**
- Reduce vulnerabilities → patching, updates
- Reduce threats → firewalls, IDS
- Reduce impact → backups, disaster recovery

---

## 6. QoS (Quality of Service)

QoS ensures reliable and prioritized network performance.

**Key Functions:**
- Traffic prioritization (e.g., VoIP over file downloads)
- Bandwidth management
- Delay and packet loss control

**Security Relevance:**
- Supports Availability (CIA triad)
- Mitigates DoS/DDoS impact by prioritizing legitimate traffic
- Helps detect abnormal traffic patterns

**Example:** During a DDoS attack, QoS ensures critical services (e.g., a banking app) still function.

---

## 7. Risk Management

A structured process to identify, assess, and control risks.

**Steps in Risk Management:**

```
1. Asset Identification      → Identify critical assets (data, servers)
2. Threat Identification     → Identify possible threats (malware, insiders)
3. Vulnerability Assessment  → Find weaknesses (misconfigurations)
4. Risk Analysis             → Qualitative (Low/Med/High) or Quantitative ($)
5. Risk Evaluation           → Decide acceptable risk level
6. Risk Treatment            → Avoid / Transfer / Mitigate / Accept
```

**Risk Treatment Options:**

| Option | Description |
|---|---|
| Avoid | Eliminate risk by stopping the risky activity |
| Transfer | Insurance, outsourcing |
| Mitigate | Apply controls (firewalls, patches) |
| Accept | Accept low-level, tolerable risk |

---

## 8. Exposure

**Exposure** is the degree of potential damage/loss if a risk materializes.

**Example:** If a database is compromised → Exposure = financial loss + reputational damage.

---

## 9. Countermeasure

A **countermeasure** is a safeguard or defense mechanism that reduces risk by:
- Reducing vulnerabilities
- Blocking threats
- Minimizing impact

**Types of Controls:**

| Control Type | Example |
|---|---|
| Preventive | Firewall, Antivirus, ACLs |
| Detective | IDS, logs, SIEM |
| Corrective | Backups, patching, failover systems |
| Deterrent | Warning banners, policies |
| Compensating | Temporary workaround controls |

---

## 10. Firewall

A **firewall** is a security device or software that monitors and filters incoming/outgoing network traffic based on security rules. It acts as a barrier between trusted and untrusted networks.

**Key Functions:**
- Packet filtering
- Stateful inspection
- Proxy services
- Logging and alerting

**Types of Firewalls:**

| Type | Description |
|---|---|
| Packet Filtering | Filters packets based on IP, port, protocol |
| Stateful Inspection | Keeps track of connection state |
| Proxy Firewall | Acts as intermediary; inspects traffic at application layer |
| Next-Gen Firewall (NGFW) | Includes DPI, intrusion prevention, application awareness |

---

## 11. Demilitarized Zone (DMZ)

A **DMZ** is a buffer zone between an organization's internal network and the public internet. It hosts public-facing services (web, mail, DNS) and protects the internal network if those services are compromised.

**Benefits of DMZ:**
- Limits attacker access
- Segregates public servers from private network
- Allows granular access control

**Typical DMZ Configuration:**
```
                Internet
                   |
              [Firewall 1]
                   |
                 [DMZ]  --> Web Server, Mail Server, DNS Server
                   |
              [Firewall 2]
                   |
           Internal Network
           (Sensitive data)
```

---

## 12. Two Methods of Implementing Firewalls

### Method 1: Single Firewall with 3-Legged DMZ
One firewall with three interfaces:
- WAN (Internet)
- DMZ (public services)
- LAN (private network)

```
        Internet
           |
      [Firewall]
       /   |   \
    WAN   DMZ   LAN
          |
     Web/Mail Server
```

| Pros | Cons |
|---|---|
| Cost-effective, simple | Single point of failure, lower security |

### Method 2: Dual Firewall DMZ
Uses two separate firewalls:
- **Firewall 1:** between Internet and DMZ
- **Firewall 2:** between DMZ and Internal Network

| Pros | Cons |
|---|---|
| More secure (defense-in-depth) | Expensive, more complex |

---

## Summary Table

| Term | Description |
|---|---|
| Risk Management | Process to identify, evaluate, and control risks |
| Exposure | Degree of potential loss from a threat |
| Countermeasure | Any action that mitigates risk |
| Firewall | Filters traffic based on rules |
| DMZ | Isolated network segment for public-facing servers |
| Firewall Methods | Single (3-legged) DMZ vs Dual Firewall DMZ |

---

## Quick Revision — Key Formula & Concepts
- **InfoSec Goal:** Protect the CIA Triad (Confidentiality, Integrity, Availability)
- **Risk Formula:** `Risk = Threat × Vulnerability × Impact`
- **QoS:** Supports Availability; mitigates DoS/DDoS effects
- **Risk Management Flow:** Identify → Assess → Analyze → Evaluate → Treat
- **Firewall:** Traffic filtering device/software
- **DMZ:** Isolated zone for public-facing services
- **Firewall Deployment:** Single Firewall (3-legged) vs Dual Firewall (defense-in-depth)
