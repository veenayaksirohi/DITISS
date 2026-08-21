# IDS / IPS — Detailed Notes

# 1. IDS & IPS Fundamentals

## 1.1 What is IDS?

**IDS** = **Intrusion Detection System**. It monitors network or host activity and looks for suspicious or malicious behavior — monitoring traffic/activity, detecting suspicious behavior, generating alerts, and helping security teams investigate.

> An IDS detects suspicious activity and alerts the administrator, but it normally does not block the traffic automatically.

```text
Traffic/System Activity → IDS → Analyze Activity → Suspicious? No → Continue | Yes → Generate Alert
```

## 1.2 What is IPS?

**IPS** = **Intrusion Prevention System**. It not only detects attacks but can take action to stop them — block packets, drop connections, reset sessions, block malicious IPs, and generate alerts.

> An IPS detects malicious activity and automatically takes action to block or prevent it.

```text
Incoming Traffic → IPS → Analyze → Malicious? No → Allow | Yes → Block + Alert
```

## 1.3 IDS vs IPS

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

```text
IDS → Detect
IPS → Detect + Prevent
```

> **Interview Answer:** An IDS monitors activity and generates alerts when suspicious behavior is detected. An IPS is placed inline and can automatically block malicious traffic. IDS focuses on detection, while IPS focuses on detection and prevention.

## 1.4 Passive vs Inline Deployment

**Passive** — the device does not sit directly in the packet path; it receives a copy of traffic via a SPAN/mirror port or network TAP.

```text
Traffic ─┬── Server
         └── Traffic Copy → IDS
```

If IDS detects an attack, the server still receives it — the IDS just generates an alert; it normally does not directly block the packet.

**Inline** — the device sits directly in the network path; all traffic passes through it.

```text
Internet → IPS → Server
Malicious Packet → IPS → DROP
```

**Advantage:** the IPS can stop the attack before it reaches the target.
**Risk:** if the IPS fails, is misconfigured, or produces a false positive, it may block legitimate traffic.

### Passive IDS vs Inline IPS

| Passive IDS                           | Inline IPS                     |
| ------------------------------------- | ------------------------------ |
| Receives copy of traffic              | Traffic passes through it      |
| Detects                               | Detects + blocks               |
| Does not normally affect traffic flow | Can affect traffic flow        |
| Safer for monitoring                  | Better for prevention          |
| No added forwarding delay             | May add small processing delay |
| Attack can still reach target         | Attack may be stopped          |

## 1.5 IDS / IPS Working Process

```text
Traffic/Events → Data Collection → Analysis → Compare Against Detection Logic → Suspicious?
  No → Allow      Yes → Alert → IPS may Block
```

Detection logic may use: signatures, rules, behavior, baselines, protocol analysis, threat intelligence.

---

# 2. Types of IDS/IPS

The two most important axes are **Network vs Host** and **Detection vs Prevention**:

```text
N = Network, H = Host, D = Detection, P = Prevention
NIDS = Network + Detection   NIPS = Network + Prevention
HIDS = Host + Detection      HIPS = Host + Prevention
```

## 2.1 NIDS — Network Intrusion Detection System

Monitors network traffic — looks at packets moving across a network.
| Tool | Notes |
|---|---|
| Snort | Rule-based open-source network IDS/IPS. In passive NIDS mode, it analyzes copied traffic and generates alerts without directly blocking packets. |
| Suricata | Open-source, multithreaded IDS/IPS and network security monitoring engine. In IDS mode, it inspects mirrored traffic and produces alerts/logs. |
| Zeek | Creates detailed logs about connections, protocols, files, and network behavior; complements signature-based NIDS tools. |

**Example:** `Attacker performs a port scan → Switch sends a traffic copy to NIDS → NIDS detects the scan and generates an alert.`

> A NIDS normally receives copied traffic through a SPAN port or network TAP — not being inline, it usually alerts but does not directly block the attack.

**Detects:** port scans, suspicious TCP traffic, exploit attempts, malware communication, ICMP floods, suspicious HTTP requests, network reconnaissance.

```text
Architecture: Internet → Switch/TAP/Mirror Port → NIDS → Traffic Analysis → Alert
```

## 2.2 HIDS — Host Intrusion Detection System

Runs on or monitors an individual host — looks at system logs, authentication logs, file changes, processes, registry changes, user activity, system integrity.
| Tool | Notes |
|---|---|
| OSSEC | Open-source host-based IDS: log analysis, file-integrity monitoring, rootkit detection, alerting. |
| Wazuh | Open-source security platform based on OSSEC concepts: host monitoring, log analysis, file-integrity monitoring, vulnerability detection, centralized management. |
| Tripwire | Monitors critical files/configurations for unauthorized changes and reports integrity violations. |
| AIDE | Linux file-integrity monitoring tool comparing current filesystem state to a trusted baseline. |

**Example:** `Attacker modifies /etc/passwd → HIDS detects the file-integrity change → records the event and generates an alert.`

> HIDS provides deep visibility into one host — its agent can examine logs and file changes that a network sensor cannot see.

```text
Architecture: Linux/Windows Host → HIDS Agent → Logs/Files/Processes → Detection → Alert
```

## 2.3 NIDS vs HIDS

| NIDS                     | HIDS                          |
| ------------------------ | ----------------------------- |
| Monitors network traffic | Monitors individual host      |
| Looks at packets         | Looks at logs/files/processes |
| Deployed on network      | Installed on endpoint/server  |
| Detects network attacks  | Detects host-level attacks    |
| Example: Snort           | Example: OSSEC                |
| Can monitor many systems | Deep visibility into one host |

```text
Port scan → NIDS detects it
/etc/passwd modified → HIDS detects it
```

**Scenario:** detect suspicious traffic entering the network → **NIDS**. Detect unauthorized changes to `/etc/passwd` → **HIDS**.

## 2.4 NIPS — Network Intrusion Prevention System

Monitors and blocks malicious activity at the **network level**; normally placed inline.

```text
Internet → NIPS → Inspect Packets → Malicious? No → Allow | Yes → Drop
```

Can protect multiple servers, network segments, DMZ, perimeter networks. Examples: Suricata/Snort in inline IPS mode.
| Tool | Notes |
|---|---|
| Snort inline | Runs in the traffic path; can apply rules that drop/reject malicious packets instead of only alerting. |
| Suricata inline | Inspects live traffic inline; can drop packets/connections matching prevention rules. |
| Cisco Secure Firewall | Combines firewall capabilities with Snort-based intrusion-prevention inspection and blocking. |

**Example:** `Exploit packet travels toward a web server → NIPS inspects it inline → NIPS drops the packet and alerts.`

> A NIPS must be inline to stop traffic directly; careful rule tuning is important because a false positive can block legitimate communication.

## 2.5 HIPS — Host Intrusion Prevention System

Protects an individual endpoint or server — can monitor and block malicious process execution, unauthorized file modification, suspicious registry changes, exploit behavior, unauthorized application actions.
| Tool | Notes |
|---|---|
| Trellix Host IPS | Host-based intrusion prevention, firewall policies, protection against known/unknown attacks. Formerly McAfee Host Intrusion Prevention. |
| ESET HIPS | Monitors processes, files, registry entries, application behavior; admins can create rules to allow/block/ask. |
| Comodo HIPS | Controls application behavior, alerts/blocks programs attempting sensitive system changes. |
| Trend Micro Workload Security | Protects servers/cloud workloads with IPS rules, application control, anti-malware, integrity monitoring. Previously Deep Security. |

**Example:** `Malicious program tries to change a protected system file → HIPS detects the action → Block + Generate Alert.`

> HIPS is often included as a feature inside a larger endpoint protection platform (EPP) or workload security product, rather than sold standalone.

```text
Host Activity → HIPS → Suspicious? No → Allow | Yes → Block
```

## 2.6 NIPS vs HIPS

| NIPS                                | HIPS                             |
| ----------------------------------- | -------------------------------- |
| Network Intrusion Prevention System | Host Intrusion Prevention System |
| Protects network traffic            | Protects individual host         |
| Inline in network path              | Runs on endpoint/server          |
| Inspects packets                    | Inspects host behavior           |
| Can protect many systems            | Protects one host deeply         |
| Blocks malicious network traffic    | Blocks suspicious host activity  |
| Example: Suricata IPS               | Endpoint security/HIPS agent     |

```text
NIPS → Network protection
HIPS → Host protection
```

## 2.7 NIDS vs NIPS

| NIDS                    | NIPS                             |
| ----------------------- | -------------------------------- |
| Detects network attacks | Detects + blocks network attacks |
| Usually passive         | Usually inline                   |
| Generates alerts        | Generates alerts + prevention    |
| No direct blocking      | Can drop packets                 |
| Snort IDS mode          | Suricata IPS mode                |

## 2.8 HIDS vs HIPS

| HIDS                  | HIPS                              |
| --------------------- | --------------------------------- |
| Detects host activity | Detects + prevents host activity  |
| Alert-focused         | Prevention-focused                |
| Logs/file integrity   | Can block suspicious host actions |
| Passive monitoring    | Active protection                 |

## 2.9 Quick Comparison — All Four

| Type | Location | Main Application Example                                                      | Blocks?     | Tool Example                                                            |
| ---- | -------- | ----------------------------------------------------------------------------- | ----------- | ----------------------------------------------------------------------- |
| NIDS | Network  | Monitors mirrored traffic, alerts on port scans/exploits/suspicious packets   | Normally No | Snort or Suricata in IDS mode                                           |
| NIPS | Network  | Inspects traffic inline, drops malicious packets before they reach the target | Yes         | Snort inline or Suricata inline                                         |
| HIDS | Host     | Monitors logs, file integrity, authentication events, processes               | Normally No | OSSEC or Wazuh                                                          |
| HIPS | Host     | Prevents malicious processes, exploits, or unauthorized changes               | Yes         | Trellix Host IPS, ESET HIPS, Comodo HIPS, Trend Micro Workload Security |

---

# 3. Detection Methods

## 3.1 Signature-Based Detection

Looks for known attack patterns — a signature is like a known fingerprint of an attack (known malware pattern, exploit string, command, malicious packet structure).

```text
Traffic → Compare With Signatures → Match? No → Allow | Yes → Alert/Block
```

**Example:** `HTTP Request → Known Attack Pattern → Signature Match → Alert`
**Advantages:** fast, accurate for known attacks, usually fewer false positives, easy to understand.
**Limitations:** cannot easily detect unknown attacks, needs frequent signature updates, may miss modified/obfuscated attacks, weak against some zero-days.

## 3.2 Anomaly-Based Detection

Looks for behavior different from normal behavior. The system first learns/defines what is normal — a **Baseline** — then detects unusual behavior.

```text
Normal Behavior → Create Baseline → New Activity → Compare With Baseline → Abnormal? No → Normal | Yes → Alert
```

**Example:** Normal — `10 login attempts/day`. Suddenly — `500 login attempts in 5 minutes` → abnormal → alert.

## 3.3 Signature vs Anomaly Detection

| Signature-Based                 | Anomaly-Based                    |
| ------------------------------- | -------------------------------- |
| Looks for known attack patterns | Looks for unusual behavior       |
| Good for known attacks          | Good for unknown attacks         |
| Needs signatures                | Needs baseline                   |
| Usually fewer false positives   | May produce more false positives |
| May miss zero-days              | Can detect some zero-days        |
| Easy to explain                 | More complex                     |

```text
Signature → "Have I seen this attack before?"
Anomaly   → "Is this behavior unusual?"
```

## 3.4 Hybrid Detection

Modern IDS/IPS systems may use both:

```text
Signature Detection + Anomaly Detection → Better Detection (known + unknown attack coverage)
```

---

# 4. Detection Accuracy: False Positive / False Negative

## 4.1 False Positive

The system says "Attack detected" but there is actually **no attack**.
**Example:** `Normal Admin Activity (legit scan) → IDS → Attack Alert` — this is a false positive.

## 4.2 False Negative

A real attack occurs, but the system does not detect it.
**Example:** `Real Attack → IDS → No Alert` — this is more dangerous because the attacker may remain undetected.

## 4.3 True/False Positive/Negative

| Result         | Meaning                                |
| -------------- | -------------------------------------- |
| True Positive  | Attack happened and system detected it |
| False Positive | No attack, but system alerted          |
| True Negative  | No attack and no alert                 |
| False Negative | Attack happened but system missed it   |

## 4.4 False Positive vs False Negative

| False Positive      | False Negative               |
| ------------------- | ---------------------------- |
| Wrong alert         | Missed attack                |
| No real attack      | Real attack exists           |
| Wastes analyst time | Security breach can continue |
| Usually annoying    | Usually more dangerous       |

```text
False Positive → False Alarm
False Negative → Missed Attack
```

## 4.5 Why False Positives Happen

Rules too broad, threshold too low, normal traffic looks suspicious, poor tuning, incorrect baseline, legitimate scanning/testing.

## 4.6 Why False Negatives Happen

Missing signature, encrypted traffic, new attack technique, rule disabled, IDS positioned incorrectly, obfuscation/evasion, poor configuration.

---

# 5. Snort

## 5.1 What is Snort?

Open-source network intrusion detection and prevention system. Inspects network packets and detects suspicious traffic using rules. Common use: **Snort as NIDS**.

```text
Network Traffic → Snort → Packet Inspection → Rule Matching → Alert
```

## 5.2 Snort in NIDS Mode

```text
Traffic Copy → Snort → Analyze Packets → Rule Match → Alert
```

Snort normally does not block traffic in passive NIDS mode — it detects and reports.

## 5.3 Snort Rule Structure

Example:

```text
alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000001;)
```

Breakdown: `alert` = Action, `tcp` = Protocol, `any` = Source IP, `any` = Source Port, `->` = Direction, `any` = Destination IP, `80` = Destination Port, `(msg:"HTTP Traffic"; sid:1000001;)` = Rule Options.

A Snort rule has two main parts:

- **Rule Header** — Action, Protocol, Source IP, Source port, Direction, Destination IP, Destination port
- **Rule Options** — Message, Content, SID, Revision, other detection conditions

## 5.4 Rule Actions

Most common: `alert` — generate an alert, e.g. `alert tcp ...`. For basic interview prep, remember `alert` is the most common rule action used in NIDS examples.

## 5.5 Rule Examples

```text
ICMP: alert icmp any any -> any any (msg:"ICMP Traffic Detected"; sid:1000002;)
→ Generate an alert when ICMP traffic is detected.

HTTP: alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000003;)
→ Generate an alert when TCP traffic reaches destination port 80.
```

## 5.6 SID in Snort

**SID** = **Snort ID** — uniquely identifies a rule, e.g. `sid:1000001;`. For custom/local rules, administrators commonly use their own SID ranges according to their environment and rule-management practice.

## 5.7 Snort Detection Flow

```text
Packet → Packet Decoder → Preprocessing/Inspection → Detection Engine → Rule Match? No → Continue | Yes → Alert
```

---

# 6. Suricata

## 6.1 What is Suricata?

Open-source IDS/IPS and network security monitoring engine. Can operate as IDS or IPS, analyzing network traffic using rules and protocol inspection.

## 6.2 Suricata in IDS Mode

```text
Traffic Copy → Suricata → Analyze → Alert
```

Detects attacks but normally does not directly block them.

## 6.3 Suricata in IPS Mode

```text
Internet → Suricata → Inspect Packet → Malicious? No → Allow | Yes → Drop
```

> Traffic passes through Suricata when it operates inline as an IPS.

---

# 7. Snort vs Suricata

| Snort                                        | Suricata                                    |
| -------------------------------------------- | ------------------------------------------- |
| IDS/IPS                                      | IDS/IPS                                     |
| Rule-based detection                         | Rule-based detection                        |
| Network traffic inspection                   | Network traffic inspection                  |
| Very widely used                             | Very widely used                            |
| Supports IDS and IPS modes                   | Supports IDS and IPS modes                  |
| Historically known for Snort rules           | Can use many Snort-compatible rule concepts |
| Modern Snort versions support multithreading | Well known for multithreaded architecture   |

> For interviews, avoid saying "Snort is only single-threaded" — that's an outdated oversimplification.

> **Interview Answer:** Both Snort and Suricata are open-source network IDS/IPS tools. They inspect network traffic and use rules to detect attacks. Suricata is well known for its multithreaded architecture and detailed protocol inspection, while Snort is one of the most widely known rule-based IDS/IPS platforms.

---

# 8. Deployment Considerations

## 8.1 IDS Sensor Placement

A NIDS sensor can be placed at important network points:

```text
Internet → Firewall → NIDS Sensor → DMZ
Internet → Firewall → DMZ → Internal Firewall → NIDS → Internal Network
```

Possible locations: network perimeter, DMZ, internal network, critical server segment, data center.
If the IDS cannot see the traffic, it cannot analyze it — traffic that bypasses the sensor is not visible to it, so proper placement is critical.

## 8.2 IDS and Encrypted Traffic

Modern traffic often uses HTTPS/TLS: `Client → Encrypted HTTPS → IDS`. An IDS can still see source/destination IP, ports, connection behavior, and some TLS metadata — but it cannot normally see the encrypted application content unless traffic is decrypted at an authorized inspection point.

## 8.3 IDS/IPS and Defence in Depth

IDS/IPS should not be the only security control:

```text
Firewall + IDS/IPS + WAF + Endpoint Security + MFA + Network Segmentation + SIEM
```

## 8.4 Architecture Example

```text
Internet → Firewall → IPS (Inline Traffic) → DMZ → Servers → HIDS/HIPS → SIEM
```

This combines network filtering, network prevention, host monitoring, and centralized correlation.

## 8.5 Security Event Flow

```text
Attack Traffic → IDS/IPS → Signature/Anomaly Detection → Alert Generated → SIEM → SOC Analyst → Investigation → Response
```

---

# 9. Scenario-Based Interview Questions

1. **The company wants to detect malicious traffic, but management does not want any tool to automatically block users.**
   Use an **IDS** — it monitors and alerts without normally blocking traffic.

2. **The company wants SQL exploit traffic automatically stopped before reaching the internal server.**
   Use an **IPS**, placed inline.

3. **You want to detect network port scanning.**
   Use **NIDS** — port scanning is network traffic behavior.

4. **You want to detect unauthorized modification of `/etc/passwd`.**
   Use **HIDS** — file changes happen on the host.

5. **Snort reports a port scan, but it was actually an authorized vulnerability scan.**
   This is a **False Positive** — the system generated an attack alert for legitimate activity.

6. **An attacker exploits a server but the IDS generates no alert.**
   This is a **False Negative** — usually more dangerous because a real attack was missed.

7. **Your IDS detects a known exploit because a matching rule already exists.**
   This is **Signature-based detection**.

8. **A user normally transfers 10 MB/day but suddenly transfers 20 GB at midnight, with no known attack signature.**
   **Anomaly-based detection** may identify this as suspicious because it differs from normal behavior.

9. **You want to block malicious packets before they reach any of 20 web servers.**
   Use **NIPS** — it can protect network traffic for multiple systems.
   **You want to stop malicious process execution on one critical server.**
   Use **HIPS** — it protects the host itself.

10. **Snort detects an attack but the malicious packet still reaches the server. Why?**
    Snort is likely running in **Passive NIDS mode** — it receives a copy of traffic and generates alerts but is not inline to block it.

11. **Suricata detects malicious traffic and immediately drops the packet. What mode is it in?**
    **IPS / inline mode.**

12. **An IDS is running, but it never detects traffic between two internal servers. What would you check?**
    Is the traffic passing near the IDS sensor? Is SPAN/mirroring configured? Correct network interface? Correct rules enabled? Packet capture working? Encrypted traffic? Rules/signatures updated? Sensor placement correct?

13. **Your IDS generates thousands of alerts for normal business traffic. What is the problem?**
    Likely too many false positives. Tune rules, adjust thresholds, disable irrelevant signatures, create proper baselines, whitelist known legitimate behavior carefully, prioritize high-severity alerts.

14. **An attacker uses a completely new technique with no existing signature. Which detection method has a better chance of finding it?**
    **Anomaly-based detection** — it looks for unusual behavior, not only known signatures.

---

# 10. Quick Revision Table

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

# 11. Most Important Interview Questions

1. What is IDS? 2. What is IPS? 3. IDS vs IPS? 4. What is passive deployment? 5. What is inline deployment? 6. Why is an IDS usually passive? 7. Why is an IPS usually inline? 8. What is NIDS? 9. What is HIDS? 10. NIDS vs HIDS? 11. What is NIPS? 12. What is HIPS? 13. NIPS vs HIPS? 14. NIDS vs NIPS? 15. HIDS vs HIPS? 16. What is signature-based detection? 17. What is anomaly-based detection? 18. Signature vs anomaly? 19. What is a false positive? 20. What is a false negative? 21. Which is more dangerous: false positive or false negative? 22. What is Snort? 23. What is a Snort rule? 24. Explain Snort rule structure. 25. What is SID? 26. What is Suricata? 27. Suricata IDS vs IPS mode? 28. Snort vs Suricata? 29. Where should an IDS sensor be placed? 30. Why can encrypted traffic be difficult for IDS? 31. What happens if IPS produces a false positive? 32. How does IDS/IPS fit into Defence in Depth?

---

# 12. Interview-Ready Answers

**IDS vs IPS:**

> IDS stands for Intrusion Detection System. It monitors traffic or host activity and generates alerts when suspicious behavior is found. IPS stands for Intrusion Prevention System. It is normally deployed inline and can automatically block malicious traffic. In simple words, IDS detects, while IPS detects and prevents.

**NIDS vs HIDS:**

> NIDS monitors network packets and detects network-based attacks such as port scans or exploit traffic. HIDS runs on or monitors an individual host and detects activities such as unauthorized file changes, suspicious processes, and authentication failures.

**NIPS vs HIPS:**

> NIPS protects network traffic and can block malicious packets before they reach systems. HIPS protects an individual host and can block suspicious activity occurring on that host.

**Signature vs Anomaly:**

> Signature-based detection compares activity with known attack patterns, so it is effective for known attacks. Anomaly-based detection compares activity with normal behavior and can detect unusual or unknown attacks, but it can generate more false positives.

**False Positive vs False Negative:**

> A false positive is an alert generated when there is no real attack. A false negative is when a real attack happens but the security system fails to detect it. False negatives are generally more dangerous because the attack remains undetected.

---

# 13. One-Line Revision

```text
IDS → Detect + Alert.
IPS → Detect + Block.
Passive → Sees a copy of traffic.
Inline → Traffic passes through the device.
NIDS → Network detection.
HIDS → Host detection.
NIPS → Network prevention.
HIPS → Host prevention.
Signature → Known attack pattern.
Anomaly → Unusual behavior.
False Positive → False alarm.
False Negative → Missed attack.
Snort → Rule-based network IDS/IPS.
Suricata → Network IDS/IPS with inline prevention capability.
```

### Best Memory Diagram

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

> **IDS detects, IPS prevents; N means Network, H means Host.**
