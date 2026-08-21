# IDS / IPS — Simple Revision Notes

---

## 1. Basics: What is IDS and IPS?

### 1.1 IDS (Intrusion Detection System)

- **Definition:** A system that watches network or host activity and looks for suspicious behavior.
- It **only alerts** the admin. It does **not** normally block traffic.

**Flow:**

```
Traffic/Activity → IDS → Analyze → Suspicious?
      No → Continue
      Yes → Generate Alert
```

> **Interview Answer:** An IDS monitors traffic or host activity and generates alerts when it finds suspicious behavior. It usually does not block traffic on its own.

---

### 1.2 IPS (Intrusion Prevention System)

- **Definition:** A system that detects attacks **and** takes action to stop them.
- Actions: block packets, drop connections, reset sessions, block bad IPs, generate alerts.

**Flow:**

```
Incoming Traffic → IPS → Analyze → Malicious?
      No → Allow
      Yes → Block + Alert
```

> **Interview Answer:** An IPS detects malicious traffic and automatically blocks or prevents it, usually by sitting inline in the traffic path.

---

### 1.3 IDS vs IPS — Key Differences

| Point     | IDS                               | IPS                                  |
| --------- | --------------------------------- | ------------------------------------ |
| Full form | Intrusion Detection System        | Intrusion Prevention System          |
| Action    | Detects only                      | Detects + Prevents                   |
| Position  | Usually passive (out-of-band)     | Usually inline (in traffic path)     |
| Output    | Alerts only                       | Alerts + blocking                    |
| Risk      | Low risk of blocking good traffic | Can accidentally block legit traffic |
| Example   | Snort in IDS mode                 | Suricata in IPS mode                 |

> **Golden line:** IDS = Detect. IPS = Detect + Prevent.

---

## 2. Passive vs Inline Deployment

### 2.1 Passive Deployment (used by IDS)

- The device does **not** sit in the direct path of traffic.
- It receives a **copy** of traffic using a **SPAN/mirror port** or a **network TAP**.

```
Traffic ─┬── Server
         └── Copy of Traffic → IDS
```

- Even if IDS detects an attack, the real traffic still reaches the server (since it only sees a copy).

### 2.2 Inline Deployment (used by IPS)

- The device sits **directly** in the traffic path. All traffic passes through it.

```
Internet → IPS → Server
Malicious Packet → IPS → DROP
```

- **Advantage:** Can stop attacks before they reach the target.
- **Risk:** If it fails or misconfigures, it may block good (legitimate) traffic.

### 2.3 Passive IDS vs Inline IPS

| Passive IDS                   | Inline IPS                |
| ----------------------------- | ------------------------- |
| Gets a copy of traffic        | Traffic passes through it |
| Detects only                  | Detects + blocks          |
| Doesn't affect traffic flow   | Can affect traffic flow   |
| Safer for monitoring          | Better for prevention     |
| No delay added                | May add small delay       |
| Attack can still reach target | Attack may be stopped     |

---

## 3. IDS/IPS Working Process (General Flow)

```
Traffic/Events → Collect Data → Analyze → Compare with Detection Logic
      → Suspicious? No → Allow
      → Suspicious? Yes → Alert → (IPS may Block)
```

Detection logic can be based on: **signatures, rules, behavior, baselines, protocol analysis, threat intelligence.**

---

## 4. Types of IDS / IPS

There are **two main axes**:

1. **Where it works** → Network or Host
2. **What it does** → Detection or Prevention

```
NIDS = Network + Detection
NIPS = Network + Prevention
HIDS = Host + Detection
HIPS = Host + Prevention
```

---

### 4.1 NIDS — Network Intrusion Detection System

- Monitors **network traffic** (packets moving across the network).
- Gets traffic via SPAN port/TAP → analyzes it → alerts (does not block).

**Example:** Attacker does a port scan → Switch sends traffic copy to NIDS → NIDS detects scan → generates alert.

**Common Tools:**
| Tool | Notes |
|---|---|
| Snort | Rule-based open-source network IDS/IPS |
| Suricata | Multithreaded IDS/IPS, network monitoring engine |
| Zeek | Logs connections, protocols, files, network behavior |

**Detects:** port scans, suspicious TCP traffic, exploit attempts, malware traffic, ICMP floods, suspicious HTTP requests, recon activity.

```
Internet → Switch/TAP/Mirror Port → NIDS → Analyze → Alert
```

---

### 4.2 HIDS — Host Intrusion Detection System

- Runs on **one host/system**.
- Looks at: system logs, auth logs, file changes, processes, registry, user activity.

**Example:** Attacker modifies `/etc/passwd` → HIDS detects file change → records + alerts.

**Common Tools:**
| Tool | Notes |
|---|---|
| OSSEC | Log analysis, file-integrity check, rootkit detection |
| Wazuh | Based on OSSEC; adds vulnerability detection, central mgmt |
| Tripwire | Detects unauthorized file/config changes |
| AIDE | Compares filesystem to a trusted baseline (Linux) |

```
Host → HIDS Agent → Logs/Files/Processes → Detection → Alert
```

---

### 4.3 NIDS vs HIDS

| NIDS                          | HIDS                          |
| ----------------------------- | ----------------------------- |
| Watches network traffic       | Watches one host              |
| Looks at packets              | Looks at logs/files/processes |
| Placed on the network         | Installed on the endpoint     |
| Detects network-level attacks | Detects host-level attacks    |
| Example: Snort                | Example: OSSEC                |
| Covers many systems at once   | Deep view into one system     |

**Quick scenario check:**

- Suspicious traffic entering network → **NIDS**
- Unauthorized change to `/etc/passwd` → **HIDS**

---

### 4.4 NIPS — Network Intrusion Prevention System

- Works at **network level**, placed **inline**.
- Can protect many servers, segments, DMZ at once.

```
Internet → NIPS → Inspect Packets → Malicious?
      No → Allow
      Yes → Drop
```

**Tools:**
| Tool | Notes |
|---|---|
| Snort (inline) | Can drop/reject malicious packets |
| Suricata (inline) | Inspects live traffic, drops bad packets |
| Cisco Secure Firewall | Firewall + Snort-based prevention |

**Example:** Exploit packet heads to web server → NIPS inspects inline → drops packet + alerts.

---

### 4.5 HIPS — Host Intrusion Prevention System

- Protects **one endpoint/server**.
- Can block: malicious processes, unauthorized file changes, registry changes, exploit behavior.

**Tools:**
| Tool | Notes |
|---|---|
| Trellix Host IPS | Host prevention + firewall (formerly McAfee) |
| ESET HIPS | Monitors processes/files/registry; allow/block/ask rules |
| Comodo HIPS | Controls app behavior, blocks risky changes |
| Trend Micro Workload Security | Server/cloud protection (formerly Deep Security) |

**Example:** Malicious program tries to change protected system file → HIPS blocks it + alerts.

> Note: HIPS is often a **feature inside** a bigger endpoint protection product, not always sold alone.

```
Host Activity → HIPS → Suspicious?
      No → Allow
      Yes → Block
```

---

### 4.6 NIPS vs HIPS

| NIPS                     | HIPS                          |
| ------------------------ | ----------------------------- |
| Protects network traffic | Protects one host             |
| Sits inline in network   | Runs on the endpoint          |
| Inspects packets         | Inspects host behavior        |
| Protects many systems    | Deep protection of one system |
| Example: Suricata IPS    | Example: Endpoint HIPS agent  |

---

### 4.7 NIDS vs NIPS

| NIDS            | NIPS                     |
| --------------- | ------------------------ |
| Detects attacks | Detects + blocks attacks |
| Passive         | Inline                   |
| Alerts only     | Alerts + prevention      |
| No blocking     | Can drop packets         |
| Snort IDS mode  | Suricata IPS mode        |

### 4.8 HIDS vs HIPS

| HIDS                       | HIPS                             |
| -------------------------- | -------------------------------- |
| Detects host activity      | Detects + prevents host activity |
| Alert-focused              | Prevention-focused               |
| Checks logs/file integrity | Can block bad host actions       |
| Passive monitoring         | Active protection                |

---

### 4.9 All Four Types — Quick Table

| Type     | Location | Main Job                                           | Blocks?     | Example Tool              |
| -------- | -------- | -------------------------------------------------- | ----------- | ------------------------- |
| **NIDS** | Network  | Watches mirrored traffic, alerts on scans/exploits | Normally No | Snort/Suricata (IDS mode) |
| **NIPS** | Network  | Inspects live traffic, drops malicious packets     | Yes         | Snort/Suricata (inline)   |
| **HIDS** | Host     | Watches logs, file integrity, auth events          | Normally No | OSSEC, Wazuh              |
| **HIPS** | Host     | Blocks malicious processes/changes                 | Yes         | Trellix, ESET, Comodo     |

**Memory diagram:**

```
              IDS / IPS
                 |
     -------------------------
     |                       |
  Network                  Host
     |                       |
 --------                --------
 |      |                |      |
NIDS   NIPS             HIDS   HIPS
Detect Prevent           Detect Prevent
```

---

## 5. OSSEC & IDS Architecture (Sensor / Agent / Manager)

### 5.1 OSSEC

- **Definition:** Open-source **Host-based IDS (HIDS)**.
- Monitors activity on servers/endpoints.

**Can monitor:**

- Authentication logs
- System logs
- File integrity
- Rootkit activity
- User activity
- Suspicious system changes

**Flow:**

```
Host/Server → OSSEC Agent → Collect Logs/File Changes → OSSEC Manager → Analyze → Alert
```

> **Interview Answer:** OSSEC is a host-based IDS that monitors logs, file integrity, and suspicious activity on endpoints, sending events to a central manager for analysis.

---

### 5.2 General IDS Architecture

Three common components: **Sensor, Agent, Manager**.

```
Network/Hosts → Sensor/Agent → IDS Manager → Analysis → Alert
```

---

### 5.3 IDS Sensor

- **Definition:** Monitors **network traffic**. Commonly used in NIDS.
- **Does:** Captures packets, inspects traffic, detects suspicious patterns, sends alerts to manager.

```
Internet → Switch → IDS Sensor → Traffic Analysis → Alert
```

> **Memory tip:** Sensor = Watches network traffic.

---

### 5.4 IDS Agent

- **Definition:** Runs on an **individual host**. Common in HIDS.
- **Monitors:** Logs, files, processes, authentication events, system changes.

```
Linux Server → IDS Agent → Logs/Files/Events → IDS Manager
```

> **Memory tip:** Agent = Watches a host.

---

### 5.5 IDS Manager

- **Definition:** Central component that receives data from sensors/agents.
- **Does:** Event collection, analysis, rule matching, alert generation, central management, reporting.

```
Agent 1 ─┐
Agent 2 ─┤
Sensor ──┼→ IDS Manager → Analysis → Alerts
Agent 3 ─┘
```

> **Memory tip:** Manager = Central analysis and control.

---

### 5.6 Sensor vs Agent vs Manager

| Component   | Purpose                                |
| ----------- | -------------------------------------- |
| **Sensor**  | Monitors network traffic               |
| **Agent**   | Monitors an individual host            |
| **Manager** | Collects and analyzes events centrally |

---

### 5.7 OSSEC Architecture Example

```
Server 1 → OSSEC Agent ─┐
Server 2 → OSSEC Agent ─┤
Server 3 → OSSEC Agent ─┼→ OSSEC Manager → Analyze Events → Alert
```

- OSSEC may also monitor the manager/local host itself, depending on configuration.

---

### 5.8 Quick Revision (OSSEC & Architecture)

```
OSSEC       → Host-based Intrusion Detection System
IDS Sensor  → Monitors network traffic
IDS Agent   → Monitors host activity
IDS Manager → Collects, analyzes, generates alerts
```

> **Best Interview Line:** In IDS architecture, sensors monitor network traffic, agents monitor individual hosts, and the manager centrally analyzes the collected events and generates alerts.

---

## 6. Detection Methods

### 6.1 Signature-Based Detection

- **Definition:** Looks for **known attack patterns** (a "signature" = fingerprint of a known attack).

```
Traffic → Compare With Signatures → Match?
      No → Allow
      Yes → Alert/Block
```

**Example:** HTTP request matches a known attack pattern → Alert.

**Pros:** Fast, accurate for known attacks, fewer false alarms, easy to understand.
**Cons:** Can't easily catch unknown/new attacks, needs frequent updates, may miss modified attacks.

---

### 6.2 Anomaly-Based Detection

- **Definition:** Looks for behavior that is **different from normal**.
- First builds a **Baseline** (what is "normal"), then flags anything unusual.

```
Normal Behavior → Build Baseline → New Activity → Compare
      Not Abnormal → Normal
      Abnormal → Alert
```

**Example:** Normal = 10 logins/day. Suddenly = 500 logins in 5 minutes → Abnormal → Alert.

---

### 6.3 Signature vs Anomaly Detection

| Signature-Based            | Anomaly-Based                |
| -------------------------- | ---------------------------- |
| Looks for known patterns   | Looks for unusual behavior   |
| Good for known attacks     | Good for unknown/new attacks |
| Needs a signature database | Needs a baseline             |
| Fewer false alarms         | More false alarms possible   |
| May miss zero-days         | Can catch some zero-days     |
| Easy to explain            | More complex                 |

**Memory line:**

- Signature → _"Have I seen this attack before?"_
- Anomaly → _"Is this behaviour unusual?"_

### 6.4 Hybrid Detection

- Modern systems often use **both methods together** for better coverage (known + unknown attacks).

---

## 7. Detection Accuracy: False Positive / False Negative

### 7.1 False Positive

- System says **"Attack!"** but there is actually **no attack**.
- Example: Legit admin vulnerability scan → IDS raises an attack alert (wrong alarm).

### 7.2 False Negative

- A **real attack happens**, but the system **misses it** (no alert).
- This is considered **more dangerous** because the attacker stays undetected.

### 7.3 True/False Table

| Result         | Meaning                             |
| -------------- | ----------------------------------- |
| True Positive  | Real attack + system detected it ✅ |
| False Positive | No attack, but system alerted ⚠️    |
| True Negative  | No attack, no alert ✅              |
| False Negative | Real attack, system missed it ❌    |

### 7.4 False Positive vs False Negative

| False Positive        | False Negative            |
| --------------------- | ------------------------- |
| Wrong alert           | Missed attack             |
| No real attack        | Real attack exists        |
| Wastes analyst's time | Can lead to a real breach |
| Annoying              | More dangerous            |

### 7.5 Why False Positives Happen

- Rules too broad, threshold too low, normal traffic looks odd, poor tuning, wrong baseline, legit scanning/testing.

### 7.6 Why False Negatives Happen

- Missing signature, encrypted traffic, brand-new attack technique, disabled rule, wrong IDS placement, attacker used evasion, bad configuration.

---

## 8. Snort

### 8.1 What is Snort?

- Open-source **network IDS/IPS**.
- Inspects packets and detects suspicious traffic using **rules**.
- Commonly used as a **NIDS**.

```
Network Traffic → Snort → Packet Inspection → Rule Matching → Alert
```

### 8.2 Snort in NIDS (Passive) Mode

```
Traffic Copy → Snort → Analyze → Rule Match → Alert
```

- In passive mode, Snort **does not block** — it only detects and reports.

### 8.3 Snort Rule Structure

**Example rule:**

```
alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000001;)
```

**Breakdown:**
| Part | Meaning |
|---|---|
| `alert` | Action |
| `tcp` | Protocol |
| `any` (1st) | Source IP |
| `any` (2nd) | Source Port |
| `->` | Direction |
| `any` (3rd) | Destination IP |
| `80` | Destination Port |
| `(msg:"..."; sid:...;)` | Rule Options |

A Snort rule has **two parts**:

1. **Rule Header** — action, protocol, source IP/port, direction, destination IP/port
2. **Rule Options** — message, content, SID, revision, other conditions

### 8.4 Rule Actions

- Most common action: **`alert`** — generates an alert (used heavily in NIDS examples).

### 8.5 More Rule Examples

```
ICMP: alert icmp any any -> any any (msg:"ICMP Traffic Detected"; sid:1000002;)
→ Alerts when ICMP traffic is seen.

HTTP: alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000003;)
→ Alerts when TCP traffic hits port 80.
```

### 8.6 SID (Snort ID)

- **SID = Snort ID** — uniquely identifies each rule (e.g. `sid:1000001;`).
- Admins usually pick their own SID ranges for **custom/local rules**.

### 8.7 Snort Detection Flow

```
Packet → Packet Decoder → Preprocessing → Detection Engine → Rule Match?
      No → Continue
      Yes → Alert
```

---

## 9. Suricata

### 9.1 What is Suricata?

- Open-source **IDS/IPS and network security monitoring engine**.
- Can run in **IDS mode** or **IPS mode**.
- Uses rules + protocol inspection.

### 9.2 Suricata — IDS Mode (Passive)

```
Traffic Copy → Suricata → Analyze → Alert
```

- Detects but normally does **not block** traffic.

### 9.3 Suricata — IPS Mode (Inline)

```
Internet → Suricata → Inspect Packet → Malicious?
      No → Allow
      Yes → Drop
```

- Traffic actually **passes through** Suricata in this mode.

---

## 10. Snort vs Suricata

| Snort                                  | Suricata                            |
| -------------------------------------- | ----------------------------------- |
| Supports IDS/IPS                       | Supports IDS/IPS                    |
| Rule-based detection                   | Rule-based detection                |
| Inspects network traffic               | Inspects network traffic            |
| Very widely used                       | Very widely used                    |
| Modern versions support multithreading | Well known for multithreaded design |

> ⚠️ **Interview tip:** Don't say "Snort is only single-threaded" — that's outdated. Modern Snort supports multithreading too.

> **Interview Answer:** Both Snort and Suricata are open-source network IDS/IPS tools that use rules to inspect traffic and detect attacks. Suricata is especially known for its multithreaded architecture and deep protocol inspection, while Snort is one of the most widely used rule-based IDS/IPS platforms.

---

## 11. Deployment Considerations

### 11.1 IDS Sensor Placement

- Common spots: network perimeter, DMZ, internal network, critical server segment, data center.

```
Internet → Firewall → NIDS Sensor → DMZ
Internet → Firewall → DMZ → Internal Firewall → NIDS → Internal Network
```

> ⚠️ **Key Point:** If the IDS cannot **see** the traffic, it cannot analyze it. Traffic that bypasses the sensor is invisible to it — so correct placement matters a lot.

### 11.2 IDS and Encrypted Traffic

- Modern traffic often uses **HTTPS/TLS**.
- An IDS can still see: source/destination IP, ports, connection behavior, some TLS metadata.
- It **cannot** normally see the actual encrypted content unless traffic is decrypted at an authorized inspection point.

### 11.3 Defence in Depth

- IDS/IPS should **never be the only** security control.

```
Firewall + IDS/IPS + WAF + Endpoint Security + MFA + Network Segmentation + SIEM
```

### 11.4 Sample Architecture

```
Internet → Firewall → IPS (inline) → DMZ → Servers → HIDS/HIPS → SIEM
```

- Combines: network filtering + network prevention + host monitoring + central correlation (SIEM).

### 11.5 Security Event Flow

```
Attack Traffic → IDS/IPS → Signature/Anomaly Detection → Alert → SIEM → SOC Analyst → Investigation → Response
```

---



## 14. One-Line Super Quick Revision

```
IDS      → Detect + Alert
IPS      → Detect + Block
Passive  → Sees a COPY of traffic
Inline   → Traffic passes THROUGH the device
NIDS     → Network detection
HIDS     → Host detection
NIPS     → Network prevention
HIPS     → Host prevention
Signature → Known attack pattern
Anomaly   → Unusual behavior
False Positive → False alarm
False Negative → Missed attack
Snort     → Rule-based network IDS/IPS
Suricata  → Network IDS/IPS, strong in inline/multithreaded mode
```

---

---

# END OF NOTES — Good for Quick Revision, Exams & Interviews
