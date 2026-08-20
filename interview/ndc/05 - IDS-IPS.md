# IDS / IPS — Detailed Notes

## 1. What is IDS?

**IDS** stands for **Intrusion Detection System**.

An IDS monitors network or host activity and looks for suspicious or malicious behavior.

It mainly:

- Monitors traffic or system activity
- Detects suspicious behavior
- Generates alerts
- Helps security teams investigate attacks

### Simple Definition

> **An IDS detects suspicious activity and alerts the administrator, but it normally does not block the traffic automatically.**

### Basic Flow

```text
Traffic / System Activity
          ↓
         IDS
          ↓
   Analyze Activity
          ↓
 Suspicious Activity?
      /        \
    No          Yes
    ↓            ↓
 Continue      Generate Alert
```

---

# 2. What is IPS?

**IPS** stands for **Intrusion Prevention System**.

An IPS not only detects attacks, but can also take action to stop them.

It can:

- Detect malicious traffic
- Block packets
- Drop connections
- Reset sessions
- Block malicious IPs
- Generate alerts

### Simple Definition

> **An IPS detects malicious activity and automatically takes action to block or prevent it.**

### Basic Flow

```text
Incoming Traffic
       ↓
      IPS
       ↓
Analyze Traffic
       ↓
Malicious?
   /       \
 No        Yes
 ↓          ↓
Allow      Block
           +
          Alert
```

---

# 3. IDS vs IPS

This is one of the most important interview questions.

| IDS                                       | IPS                                       |
| ----------------------------------------- | ----------------------------------------- |
| Intrusion Detection System                | Intrusion Prevention System               |
| Detects attacks                           | Detects and prevents attacks              |
| Usually passive                           | Usually inline                            |
| Generates alerts                          | Generates alerts + blocks                 |
| Does not normally stop traffic            | Can stop malicious traffic                |
| Out-of-band                               | In the traffic path                       |
| Lower risk of blocking legitimate traffic | Can accidentally block legitimate traffic |
| Example: Snort in IDS mode                | Suricata in IPS mode                      |

### Easy Memory

```text
IDS
→ Detect

IPS
→ Detect + Prevent
```

### Interview-Ready Answer

> An IDS monitors activity and generates alerts when suspicious behavior is detected. An IPS is placed inline and can automatically block malicious traffic. IDS focuses on detection, while IPS focuses on detection and prevention.

---

# 4. Passive vs Inline Deployment

## Passive Deployment

A passive security device does not sit directly in the packet path.

It receives a copy of traffic.

Example:

```text
             ┌──── IDS
             │
Traffic ─────┼──── Server
             │
             └──── Traffic Copy
```

A switch may provide traffic using:

- SPAN / mirror port
- Network TAP

The IDS analyzes the copy.

### Important

If IDS detects an attack:

```text
Attack Traffic
      ↓
Server still receives it
      ↓
IDS generates alert
```

So the IDS normally does not directly block the packet.

---

# 5. Inline Deployment

An inline device sits directly in the network path.

Example:

```text
Internet
   ↓
IPS
   ↓
Server
```

All traffic must pass through the IPS.

If malicious traffic is found:

```text
Malicious Packet
      ↓
IPS
      ↓
DROP
```

### Inline Advantage

The IPS can stop the attack before it reaches the target.

### Inline Risk

If the IPS:

- Fails
- Is misconfigured
- Produces a false positive

it may block legitimate traffic.

---

# 6. Passive IDS vs Inline IPS

| Passive IDS                           | Inline IPS                     |
| ------------------------------------- | ------------------------------ |
| Receives copy of traffic              | Traffic passes through it      |
| Detects                               | Detects + blocks               |
| Does not normally affect traffic flow | Can affect traffic flow        |
| Safer for monitoring                  | Better for prevention          |
| No added forwarding delay             | May add small processing delay |
| Attack can still reach target         | Attack may be stopped          |

---

# 7. IDS / IPS Working Process

A typical process is:

```text
Traffic / Events
       ↓
Data Collection
       ↓
Analysis
       ↓
Compare Against Detection Logic
       ↓
Suspicious?
   /        \
 No         Yes
 ↓           ↓
Allow      Alert
             ↓
       IPS may Block
```

Detection logic may use:

- Signatures
- Rules
- Behavior
- Baselines
- Protocol analysis
- Threat intelligence

---

# 8. Types of IDS

The two most important types are:

- **NIDS**
- **HIDS**

---

# 9. NIDS — Network Intrusion Detection System

**NIDS** stands for **Network Intrusion Detection System**.

It monitors network traffic.

It looks at packets moving across a network.

### Examples

- Snort
- Suricata in IDS mode

### NIDS Tool Examples

| Tool | Notes |
| ---- | ----- |
| Snort | A rule-based open-source network IDS/IPS. In passive NIDS mode, it analyzes copied traffic and generates alerts without directly blocking packets. |
| Suricata | An open-source, multithreaded IDS/IPS and network security monitoring engine. In IDS mode, it inspects mirrored traffic and produces alerts and logs. |
| Zeek | A network security monitoring tool that creates detailed logs about connections, protocols, files, and network behavior. It complements signature-based NIDS tools. |

### Simple NIDS Application Example

```text
Attacker performs a port scan
              ↓
Switch sends a traffic copy to NIDS
              ↓
NIDS detects the scan and generates an alert
```

> **Reading note:** A NIDS normally receives copied traffic through a SPAN port or network TAP. Because it is not inline, it usually alerts but does not directly block the attack.

### What NIDS Can Detect

- Port scans
- Suspicious TCP traffic
- Exploit attempts
- Malware communication
- ICMP floods
- Suspicious HTTP requests
- Network reconnaissance

### Architecture

```text
Internet
   ↓
Switch / TAP / Mirror Port
   ↓
NIDS
   ↓
Traffic Analysis
   ↓
Alert
```

---

# 10. HIDS — Host Intrusion Detection System

**HIDS** stands for **Host Intrusion Detection System**.

It runs on or monitors an individual host.

It looks at:

- System logs
- Authentication logs
- File changes
- Processes
- Registry changes
- User activity
- System integrity

### Examples

- OSSEC
- Wazuh

### HIDS Tool Examples

| Tool | Notes |
| ---- | ----- |
| OSSEC | An open-source host-based IDS that performs log analysis, file-integrity monitoring, rootkit detection, and alerting. |
| Wazuh | An open-source security platform based on OSSEC concepts. It provides host monitoring, log analysis, file-integrity monitoring, vulnerability detection, and centralized management. |
| Tripwire | Monitors critical files and configurations for unauthorized changes and reports integrity violations. |
| AIDE | A Linux file-integrity monitoring tool that compares the current filesystem state with a trusted baseline. |

### Simple HIDS Application Example

```text
Attacker modifies /etc/passwd
              ↓
HIDS detects the file-integrity change
              ↓
HIDS records the event and generates an alert
```

> **Reading note:** HIDS provides deep visibility into one host. Its agent can examine logs and file changes that a network sensor cannot see.

### Architecture

```text
Linux / Windows Host
        ↓
      HIDS Agent
        ↓
Logs / Files / Processes
        ↓
      Detection
        ↓
       Alert
```

---

# 11. NIDS vs HIDS

| NIDS                     | HIDS                          |
| ------------------------ | ----------------------------- |
| Monitors network traffic | Monitors individual host      |
| Looks at packets         | Looks at logs/files/processes |
| Deployed on network      | Installed on endpoint/server  |
| Detects network attacks  | Detects host-level attacks    |
| Example: Snort           | Example: OSSEC                |
| Can monitor many systems | Deep visibility into one host |

### Example

If an attacker scans ports:

```text
Attacker
  ↓
Port Scan
  ↓
NIDS detects it
```

If `/etc/passwd` changes unexpectedly:

```text
File Modified
    ↓
HIDS detects it
```

---

# 12. Scenario — NIDS or HIDS?

### Question

You want to detect suspicious traffic entering the network.

Use:

> **NIDS**

### Question

You want to detect unauthorized changes to `/etc/passwd`.

Use:

> **HIDS**

---

# 13. NIPS — Network Intrusion Prevention System

**NIPS** stands for **Network Intrusion Prevention System**.

It monitors and blocks malicious activity at the **network level**.

It is normally placed inline.

### Flow

```text
Internet
   ↓
NIPS
   ↓
Inspect Packets
   ↓
Malicious?
 /      \
No      Yes
↓        ↓
Allow   Drop
```

### NIPS Can Protect

- Multiple servers
- Network segments
- DMZ
- Perimeter networks

### Examples

- Suricata in inline IPS mode
- Snort in inline IPS configuration

### NIPS Tool Examples

| Tool | Notes |
| ---- | ----- |
| Snort inline | Runs in the traffic path and can apply rules that drop or reject malicious packets instead of only generating alerts. |
| Suricata inline | Inspects live traffic inline and can drop packets or connections that match prevention rules. |
| Cisco Secure Firewall | Combines firewall capabilities with Snort-based intrusion-prevention inspection and blocking. |

### Simple NIPS Application Example

```text
Exploit packet travels toward a web server
                    ↓
             NIPS inspects it inline
                    ↓
        NIPS drops the packet and alerts
```

> **Reading note:** A NIPS must be inline to stop traffic directly. Careful rule tuning is important because a false positive can block legitimate communication.

---

# 14. HIPS — Host Intrusion Prevention System

**HIPS** stands for **Host Intrusion Prevention System**.

It protects an individual endpoint or server.

It can monitor and block suspicious host activity.

Examples of activity:

- Malicious process execution
- Unauthorized file modification
- Suspicious registry changes
- Exploit behavior
- Unauthorized application actions

### HIPS Tool Examples

| Tool | Notes |
| ---- | ----- |
| Trellix Host IPS | Provides host-based intrusion prevention, firewall policies, and protection against known and unknown attacks on endpoints. It was formerly known as McAfee Host Intrusion Prevention. |
| ESET HIPS | Monitors processes, files, registry entries, and application behavior. Administrators can create rules to allow, block, or ask about suspicious actions. |
| Comodo HIPS | Controls application behavior and alerts or blocks programs that attempt sensitive system changes. It is commonly associated with Comodo endpoint products. |
| Trend Micro Workload Security | Protects servers and cloud workloads with intrusion-prevention rules, application control, anti-malware, and integrity monitoring. It was previously known as Deep Security. |

### Simple HIPS Example

```text
Malicious program tries to change a protected system file
                         ↓
                 HIPS detects the action
                         ↓
                 Block + Generate Alert
```

> **Reading note:** HIPS products may be included as a feature inside a larger endpoint security, endpoint protection platform (EPP), or workload security product rather than being sold as a separate tool.

### Flow

```text
Host Activity
    ↓
   HIPS
    ↓
Suspicious?
 /       \
No       Yes
↓         ↓
Allow    Block
```

---

# 15. NIPS vs HIPS

Your term **"NIpS vs HIpS"** is correctly written as:

> **NIPS vs HIPS**

| NIPS                                | HIPS                             |
| ----------------------------------- | -------------------------------- |
| Network Intrusion Prevention System | Host Intrusion Prevention System |
| Protects network traffic            | Protects individual host         |
| Inline in network path              | Runs on endpoint/server          |
| Inspects packets                    | Inspects host behavior           |
| Can protect many systems            | Protects one host deeply         |
| Blocks malicious network traffic    | Blocks suspicious host activity  |
| Example: Suricata IPS               | Endpoint security/HIPS agent     |

### Easy Memory

```text
NIPS
→ Network protection

HIPS
→ Host protection
```

---

# 16. NIDS vs NIPS

| NIDS                    | NIPS                             |
| ----------------------- | -------------------------------- |
| Detects network attacks | Detects + blocks network attacks |
| Usually passive         | Usually inline                   |
| Generates alerts        | Generates alerts + prevention    |
| No direct blocking      | Can drop packets                 |
| Snort IDS mode          | Suricata IPS mode                |

---

# 17. HIDS vs HIPS

| HIDS                  | HIPS                              |
| --------------------- | --------------------------------- |
| Detects host activity | Detects + prevents host activity  |
| Alert-focused         | Prevention-focused                |
| Logs/file integrity   | Can block suspicious host actions |
| Passive monitoring    | Active protection                 |

---

# 18. Signature-Based Detection

## Meaning

**Signature-based detection** looks for known attack patterns.

A signature is like a known fingerprint of an attack.

Examples:

- Known malware pattern
- Known exploit string
- Known command
- Known malicious packet structure

### Flow

```text
Traffic
   ↓
Compare With Signatures
   ↓
Signature Match?
 /        \
No        Yes
↓          ↓
Allow     Alert / Block
```

---

# 19. Signature-Based Example

Suppose a rule detects a known malicious HTTP request.

```text
HTTP Request
     ↓
Known Attack Pattern
     ↓
Signature Match
     ↓
Alert
```

### Advantages

- Fast
- Accurate for known attacks
- Usually fewer false positives
- Easy to understand

### Limitations

- Cannot easily detect unknown attacks
- Needs frequent signature updates
- May miss modified/obfuscated attacks
- Weak against some zero-day attacks

---

# 20. Anomaly-Based Detection

## Meaning

**Anomaly-based detection** looks for behavior that is different from normal behavior.

First, the system learns or defines what is normal.

This is called a:

> **Baseline**

Then it detects unusual behavior.

### Flow

```text
Normal Behavior
      ↓
Create Baseline
      ↓
New Activity
      ↓
Compare With Baseline
      ↓
Abnormal?
 /       \
No       Yes
↓         ↓
Normal   Alert
```

---

# 21. Anomaly-Based Example

Normal traffic:

```text
Employee:
10 login attempts per day
```

Suddenly:

```text
Employee:
500 login attempts in 5 minutes
```

This is abnormal.

An anomaly-based system may generate an alert.

---

# 22. Signature vs Anomaly Detection

| Signature-Based                 | Anomaly-Based                    |
| ------------------------------- | -------------------------------- |
| Looks for known attack patterns | Looks for unusual behavior       |
| Good for known attacks          | Good for unknown attacks         |
| Needs signatures                | Needs baseline                   |
| Usually fewer false positives   | May produce more false positives |
| May miss zero-days              | Can detect some zero-days        |
| Easy to explain                 | More complex                     |

### Easy Memory

```text
Signature
→ "Have I seen this attack before?"

Anomaly
→ "Is this behavior unusual?"
```

---

# 23. Hybrid Detection

Modern IDS/IPS systems may use both:

```text
Signature Detection
        +
Anomaly Detection
        ↓
Better Detection
```

This provides:

- Known attack detection
- Unknown behavior detection
- Better coverage

---

# 24. False Positive

A **False Positive** happens when the security system says:

> "Attack detected"

but there is actually **no attack**.

### Example

A legitimate administrator runs a network scan.

IDS detects it as malicious.

```text
Normal Admin Activity
        ↓
IDS
        ↓
Attack Alert
```

This is a false positive.

---

# 25. False Negative

A **False Negative** happens when:

> A real attack occurs, but the security system does not detect it.

Example:

```text
Real Attack
    ↓
IDS
    ↓
No Alert
```

This is more dangerous because the attacker may remain undetected.

---

# 26. True Positive and True Negative

For completeness:

| Result         | Meaning                                |
| -------------- | -------------------------------------- |
| True Positive  | Attack happened and system detected it |
| False Positive | No attack, but system alerted          |
| True Negative  | No attack and no alert                 |
| False Negative | Attack happened but system missed it   |

---

# 27. False Positive vs False Negative

| False Positive      | False Negative               |
| ------------------- | ---------------------------- |
| Wrong alert         | Missed attack                |
| No real attack      | Real attack exists           |
| Wastes analyst time | Security breach can continue |
| Usually annoying    | Usually more dangerous       |

### Easy Memory

```text
False Positive
→ False Alarm

False Negative
→ Missed Attack
```

---

# 28. Why False Positives Happen

Possible reasons:

- Rules too broad
- Threshold too low
- Normal traffic looks suspicious
- Poor tuning
- Incorrect baseline
- Legitimate scanning/testing

---

# 29. Why False Negatives Happen

Possible reasons:

- Missing signature
- Encrypted traffic
- New attack technique
- Rule disabled
- IDS positioned incorrectly
- Obfuscation/evasion
- Poor configuration

---

# 30. Snort

## What is Snort?

**Snort** is an open-source network intrusion detection and prevention system.

It can inspect network packets and detect suspicious traffic using rules.

Common use:

> **Snort as NIDS**

### Basic Flow

```text
Network Traffic
      ↓
     Snort
      ↓
Packet Inspection
      ↓
Rule Matching
      ↓
Alert
```

---

# 31. Snort in NIDS Mode

When Snort is used as a NIDS:

```text
Traffic Copy
   ↓
Snort
   ↓
Analyze Packets
   ↓
Rule Match
   ↓
Alert
```

Snort normally does not block traffic in passive NIDS mode.

It detects and reports.

---

# 32. Snort Rule Structure

Example:

```text
alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000001;)
```

Breakdown:

```text
alert
→ Action

tcp
→ Protocol

any
→ Source IP

any
→ Source Port

->
→ Direction

any
→ Destination IP

80
→ Destination Port

(msg:"HTTP Traffic"; sid:1000001;)
→ Rule Options
```

---

# 33. Main Parts of a Snort Rule

A Snort rule has two main parts:

```text
Rule Header
    +
Rule Options
```

### Rule Header

Contains:

- Action
- Protocol
- Source IP
- Source port
- Direction
- Destination IP
- Destination port

### Rule Options

Can include:

- Message
- Content
- SID
- Revision
- Other detection conditions

---

# 34. Snort Rule Actions

Common action:

### `alert`

Generate alert.

Example:

```text
alert tcp ...
```

Other actions depend on configuration, but for basic interview preparation, remember:

> `alert` is the most common rule action used in NIDS examples.

---

# 35. Snort Rule Example — ICMP

```text
alert icmp any any -> any any (msg:"ICMP Traffic Detected"; sid:1000002;)
```

Meaning:

> Generate an alert when ICMP traffic is detected.

---

# 36. Snort Rule Example — HTTP

```text
alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000003;)
```

Meaning:

> Generate an alert when TCP traffic reaches destination port 80.

---

# 37. SID in Snort

**SID** means:

> **Snort ID**

It uniquely identifies a rule.

Example:

```text
sid:1000001;
```

For custom/local rules, administrators commonly use their own SID ranges according to their environment and rule-management practice.

---

# 38. Snort Detection Flow

```text
Packet
  ↓
Packet Decoder
  ↓
Preprocessing / Inspection
  ↓
Detection Engine
  ↓
Rule Match?
 /       \
No       Yes
↓         ↓
Continue Alert
```

---

# 39. Suricata

## What is Suricata?

**Suricata** is an open-source IDS/IPS and network security monitoring engine.

It can operate as:

- IDS
- IPS

It analyzes network traffic using rules and protocol inspection.

---

# 40. Suricata in IDS Mode

In IDS mode:

```text
Traffic Copy
   ↓
Suricata
   ↓
Analyze
   ↓
Alert
```

It detects attacks but normally does not directly block them.

---

# 41. Suricata in IPS Mode

In IPS mode:

```text
Internet
   ↓
Suricata
   ↓
Inspect Packet
   ↓
Malicious?
 /       \
No       Yes
↓         ↓
Allow    Drop
```

The key difference is:

> **Traffic passes through Suricata when it operates inline as an IPS.**

---

# 42. Snort vs Suricata

| Snort                                        | Suricata                                              |
| -------------------------------------------- | ----------------------------------------------------- |
| IDS/IPS                                      | IDS/IPS                                               |
| Rule-based detection                         | Rule-based detection                                  |
| Network traffic inspection                   | Network traffic inspection                            |
| Very widely used                             | Very widely used                                      |
| Supports IDS and IPS modes                   | Supports IDS and IPS modes                            |
| Historically known for Snort rules           | Can use many Snort-compatible rule concepts           |
| Modern Snort versions support multithreading | Suricata is well known for multithreaded architecture |

For interviews, avoid saying:

> "Snort is only single-threaded."

That is an outdated oversimplification.

---

# 43. Snort vs Suricata — Easy Interview Answer

> Both Snort and Suricata are open-source network IDS/IPS tools. They inspect network traffic and use rules to detect attacks. Suricata is well known for its multithreaded architecture and detailed protocol inspection, while Snort is one of the most widely known rule-based IDS/IPS platforms.

---

# 44. IDS Sensor Placement

A NIDS sensor can be placed at important network points.

Examples:

```text
Internet
   ↓
Firewall
   ↓
NIDS Sensor
   ↓
DMZ
```

or:

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Internal Firewall
   ↓
NIDS
   ↓
Internal Network
```

Possible locations:

- Network perimeter
- DMZ
- Internal network
- Critical server segment
- Data center

---

# 45. Why Sensor Placement Matters

If IDS cannot see the traffic:

> It cannot analyze it.

Example:

```text
Traffic Path A
     ↓
IDS Sensor
     ↓
Visible
```

But:

```text
Traffic Path B
     ↓
Bypasses IDS
     ↓
Not Visible
```

So proper placement is critical.

---

# 46. IDS and Encrypted Traffic

Modern traffic often uses HTTPS/TLS.

Example:

```text
Client
  ↓
Encrypted HTTPS
  ↓
IDS
```

An IDS can still see information such as:

- Source IP
- Destination IP
- Ports
- Connection behavior
- Some TLS metadata

But it cannot normally see the encrypted application content unless traffic is decrypted at an authorized inspection point.

---

# 47. IDS/IPS and Defence in Depth

IDS/IPS should not be the only security control.

Use:

```text
Firewall
   +
IDS / IPS
   +
WAF
   +
Endpoint Security
   +
MFA
   +
Network Segmentation
   +
SIEM
```

This is:

> **Defence in Depth**

---

# 48. Scenario-Based Question 1 — IDS vs IPS

### Question

The company wants to detect malicious traffic, but management does not want any security tool to automatically block users.

### Answer

Use an:

> **IDS**

because it monitors and alerts without normally blocking traffic.

---

# 49. Scenario-Based Question 2 — IPS

### Question

The company wants SQL exploit traffic to be automatically stopped before reaching the internal server.

### Answer

Use an:

> **IPS**

placed inline.

---

# 50. Scenario-Based Question 3 — NIDS vs HIDS

### Question

You want to detect network port scanning.

### Answer

Use:

> **NIDS**

because port scanning is network traffic behavior.

---

# 51. Scenario-Based Question 4 — HIDS

### Question

You want to detect unauthorized modification of `/etc/passwd`.

### Answer

Use:

> **HIDS**

because file changes happen on the host.

---

# 52. Scenario-Based Question 5 — False Positive

### Question

Snort reports a port scan, but it was actually an authorized vulnerability scan.

### Answer

This is a:

> **False Positive**

because the system generated an attack alert for legitimate activity.

---

# 53. Scenario-Based Question 6 — False Negative

### Question

An attacker exploits a server but the IDS generates no alert.

### Answer

This is a:

> **False Negative**

This is usually more dangerous because a real attack was missed.

---

# 54. Scenario-Based Question 7 — Signature Detection

### Question

Your IDS detects a known exploit because a matching rule already exists.

### Answer

This is:

> **Signature-based detection**

---

# 55. Scenario-Based Question 8 — Anomaly Detection

### Question

A user normally transfers 10 MB per day but suddenly transfers 20 GB at midnight.

No known attack signature exists.

### Answer

Anomaly-based detection may identify this as suspicious because it differs from normal behavior.

---

# 56. Scenario-Based Question 9 — NIPS vs HIPS

### Question

You want to block malicious packets before they reach any of 20 web servers.

### Answer

Use:

> **NIPS**

because it can protect network traffic for multiple systems.

### Question

You want to stop malicious process execution on one critical server.

### Answer

Use:

> **HIPS**

because it protects the host itself.

---

# 57. Scenario-Based Question 10 — Snort Passive Mode

### Question

Snort detects an attack but the malicious packet still reaches the server. Why?

### Answer

Snort is likely running in:

> **Passive NIDS mode**

It receives a copy of traffic and generates alerts but is not inline to block it.

---

# 58. Scenario-Based Question 11 — Suricata IPS

### Question

Suricata detects malicious traffic and immediately drops the packet.

What mode is it operating in?

### Answer

> **IPS / inline mode**

---

# 59. Scenario-Based Question 12 — IDS Troubleshooting

### Question

An IDS is running, but it never detects traffic between two internal servers.

What would you check?

### Check

- Is the traffic passing near the IDS sensor?
- Is SPAN/mirroring configured?
- Correct network interface?
- Correct rules enabled?
- Packet capture working?
- Encrypted traffic?
- Rules/signatures updated?
- Sensor placement correct?

---

# 60. Scenario-Based Question 13 — Too Many Alerts

### Question

Your IDS generates thousands of alerts for normal business traffic. What is the problem?

### Answer

Likely:

> Too many false positives.

You should:

- Tune rules
- Adjust thresholds
- Disable irrelevant signatures
- Create proper baselines
- Whitelist known legitimate behavior carefully
- Prioritize high-severity alerts

---

# 61. Scenario-Based Question 14 — Zero-Day

### Question

An attacker uses a completely new technique with no existing signature.

Which detection method may have a better chance of finding it?

### Answer

> **Anomaly-based detection**

because it looks for unusual behavior, not only known signatures.

---

# 62. IDS / IPS Architecture Example

```text
               Internet
                  ↓
               Firewall
                  ↓
        ┌─────────────────┐
        │       IPS       │
        │  Inline Traffic │
        └────────┬────────┘
                 ↓
                DMZ
                 ↓
              Servers
                 ↓
            HIDS / HIPS
                 ↓
              SIEM
```

This combines:

- Network filtering
- Network prevention
- Host monitoring
- Centralized correlation

---

# 63. Security Event Flow

```text
Attack Traffic
     ↓
IDS / IPS
     ↓
Signature / Anomaly Detection
     ↓
Alert Generated
     ↓
SIEM
     ↓
SOC Analyst
     ↓
Investigation
     ↓
Response
```

---

# 64. Quick Comparison — All Four

| Type | Location | Main Application Example | Blocks? | Tool Example |
| ---- | -------- | ------------------------ | ------- | ------------ |
| NIDS | Network | Monitors mirrored network traffic and alerts on port scans, exploits, or suspicious packets | Normally No | Snort or Suricata in IDS mode |
| NIPS | Network | Inspects traffic inline and drops malicious packets before they reach the target | Yes | Snort inline or Suricata inline |
| HIDS | Host | Monitors system logs, file integrity, authentication events, and processes on a server or endpoint | Normally No | OSSEC or Wazuh |
| HIPS | Host | Prevents malicious processes, exploits, or unauthorized changes on an endpoint | Yes | Trellix Host IPS, ESET HIPS, Comodo HIPS, Trend Micro Workload Security |

### Application and Tool Examples

```text
NIDS
→ Application: Detect a port scan from a copy of network traffic.
→ Tools: Snort, Suricata.

NIPS
→ Application: Block exploit traffic before it reaches a web server.
→ Tools: Snort inline, Suricata inline.

HIDS
→ Application: Detect an unauthorized change to /etc/passwd.
→ Tools: OSSEC, Wazuh.

HIPS
→ Application: Stop a malicious process or exploit on an endpoint.
→ Tools: Trellix Host IPS, ESET HIPS, Comodo HIPS, and Trend Micro Workload Security.
```

### Easy Memory

```text
N = Network
H = Host

D = Detection
P = Prevention
```

So:

```text
NIDS
→ Network + Detection

NIPS
→ Network + Prevention

HIDS
→ Host + Detection

HIPS
→ Host + Prevention
```

---

# 65. Quick Revision Table

| Topic           | Simple Meaning                |
| --------------- | ----------------------------- |
| IDS             | Detects attacks and alerts    |
| IPS             | Detects and blocks attacks    |
| Passive         | Monitors copy of traffic      |
| Inline          | Sits directly in traffic path |
| NIDS            | Detects network attacks       |
| HIDS            | Detects host-level attacks    |
| NIPS            | Prevents network attacks      |
| HIPS            | Prevents host-level attacks   |
| Signature-Based | Detect known attack patterns  |
| Anomaly-Based   | Detect unusual behavior       |
| False Positive  | False alarm                   |
| False Negative  | Missed real attack            |
| Snort           | Network IDS/IPS using rules   |
| Suricata        | Network IDS/IPS engine        |
| SID             | Snort rule identifier         |

---

# 66. Most Important Interview Questions

1. What is IDS?
2. What is IPS?
3. IDS vs IPS?
4. What is passive deployment?
5. What is inline deployment?
6. Why is an IDS usually passive?
7. Why is an IPS usually inline?
8. What is NIDS?
9. What is HIDS?
10. NIDS vs HIDS?
11. What is NIPS?
12. What is HIPS?
13. NIPS vs HIPS?
14. NIDS vs NIPS?
15. HIDS vs HIPS?
16. What is signature-based detection?
17. What is anomaly-based detection?
18. Signature vs anomaly?
19. What is a false positive?
20. What is a false negative?
21. Which is more dangerous: false positive or false negative?
22. What is Snort?
23. What is a Snort rule?
24. Explain Snort rule structure.
25. What is SID?
26. What is Suricata?
27. Suricata IDS vs IPS mode?
28. Snort vs Suricata?
29. Where should an IDS sensor be placed?
30. Why can encrypted traffic be difficult for IDS?
31. What happens if IPS produces a false positive?
32. How does IDS/IPS fit into Defence in Depth?

---

# 67. Interview-Ready Answer — IDS vs IPS

> **IDS stands for Intrusion Detection System. It monitors traffic or host activity and generates alerts when suspicious behavior is found. IPS stands for Intrusion Prevention System. It is normally deployed inline and can automatically block malicious traffic. In simple words, IDS detects, while IPS detects and prevents.**

---

# 68. Interview-Ready Answer — NIDS vs HIDS

> **NIDS monitors network packets and detects network-based attacks such as port scans or exploit traffic. HIDS runs on or monitors an individual host and detects activities such as unauthorized file changes, suspicious processes, and authentication failures.**

---

# 69. Interview-Ready Answer — NIPS vs HIPS

> **NIPS protects network traffic and can block malicious packets before they reach systems. HIPS protects an individual host and can block suspicious activity occurring on that host.**

---

# 70. Interview-Ready Answer — Signature vs Anomaly

> **Signature-based detection compares activity with known attack patterns, so it is effective for known attacks. Anomaly-based detection compares activity with normal behavior and can detect unusual or unknown attacks, but it can generate more false positives.**

---

# 71. Interview-Ready Answer — False Positive vs False Negative

> **A false positive is an alert generated when there is no real attack. A false negative is when a real attack happens but the security system fails to detect it. False negatives are generally more dangerous because the attack remains undetected.**

---

# 72. One-Line Revision

```text
IDS
→ Detect + Alert.

IPS
→ Detect + Block.

Passive
→ Sees a copy of traffic.

Inline
→ Traffic passes through the device.

NIDS
→ Network detection.

HIDS
→ Host detection.

NIPS
→ Network prevention.

HIPS
→ Host prevention.

Signature
→ Known attack pattern.

Anomaly
→ Unusual behavior.

False Positive
→ False alarm.

False Negative
→ Missed attack.

Snort
→ Rule-based network IDS/IPS.

Suricata
→ Network IDS/IPS with inline prevention capability.
```

## Best Memory Diagram

```text
                  IDS / IPS
                     |
       --------------------------------
       |                              |
     Network                         Host
       |                              |
   ----------                     ----------
   |        |                     |        |
 NIDS     NIPS                  HIDS      HIPS
   |        |                     |        |
Detect   Prevent                Detect   Prevent
```

And the most important line to remember:

> **IDS detects, IPS prevents; N means Network, H means Host.**
