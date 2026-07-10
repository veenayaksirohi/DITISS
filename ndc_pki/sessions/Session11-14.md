# Session 11–14 — Network Defense & Countermeasures

> **Session 11 & 12** (4T+8L+3SL): Attacks – Traditional/Distributed · Intruder Types · Types of IDS · IPS Categories · Defense in Depth · IDS/IPS Analysis Scheme · Detection Methodologies · Principles of IDS · Threat Hunting
> **Session 13 & 14** (4T+2L+2SL): Symptoms of Attacks · Tiered Architecture · Sensors (Network/Host-based) · Denial of Service · DoS & DDoS Mitigation · Sensor Deployment · Agents · Functions of IDS Agents · IDS Manager

---

## PART A — SESSION 11 & 12

## 1. Attacks: Traditional vs Distributed

### 1.1 Traditional Attacks
- Launched from a **single system**.
- Easier to trace back to source.
- Examples: port scanning, password cracking, malware injection.

### 1.2 Distributed Attacks (DDoS)
- Multiple compromised systems (**botnet**) attack one target simultaneously.
- Harder to defend against due to scale — attribution and blocking become difficult across many sources.
- Examples: Distributed Denial of Service (DDoS), coordinated brute force, distributed scanning.
- Modern DDoS often combines **volumetric floods**, **protocol abuse**, and **application-layer floods** across globally distributed bots.

> ⚠️ **Exam Trap:** Traditional = single source, easy to trace. Distributed = botnet, hard to trace/block due to scale.

---

## 2. Types of Intruders

| Intruder Type | Description |
|---|---|
| **Masquerader** | Not authorized, but gains access using stolen/guessed credentials, posing as a legitimate user |
| **Misfeasor** | Legitimate user who abuses authorized privileges (e.g., accessing data beyond their role) |
| **Clandestine User** | Tries to avoid detection (e.g., installs backdoors, disables logs) |
| **External Attacker** | No internal access initially; must breach perimeter defenses (firewalls, VPNs) |
| **Insider Attacker** | Has authorized access, uses it maliciously — harder to detect since actions look "normal" |

> 💡 **Viva Point:** Insider threats require behavioral monitoring and strong access control, not just perimeter defenses.

---

## 3. Types of IDS

| IDS Type | Description |
|---|---|
| **NIDS** (Network IDS) | Monitors packets on a network segment; placed at gateways, DMZs, key internal links |
| **HIDS** (Host IDS) | Monitors a host's logs, processes, files, system calls |
| **WIDS** (Wireless IDS) | Detects rogue APs, unauthorized clients, wireless threats |
| **Application IDS** | Secures application-layer activity (e.g., detects SQL injection, XSS in HTTP requests) |
| **Hybrid IDS** | Combines NIDS + HIDS (sometimes WIDS) for broad, layered protection |

---

## 4. IPS Categories

| Category | Function |
|---|---|
| **NIPS** (Network-based IPS) | Deployed inline on network perimeter; extends firewall functionality with deep inspection |
| **HIPS** (Host-based IPS) | Installed on end devices, blocks local threats even if network controls are bypassed |
| **WIPS** (Wireless IPS) | Prevents wireless intrusions, can disconnect rogue APs/clients |
| **Network Behavior Analysis (NBA)** | Detects anomalies in traffic behavior/flow statistics (e.g., DDoS, internal scanning) |
| **Content-Based IPS** | Filters based on payload (e.g., AV signatures, pattern matching) — effective against known malware |

---

## 5. Defense in Depth (DiD)

A **multi-layered security approach** — if one control fails, another still protects the system. Goal: **no single point of failure**.

### 5.1 Layers
```
┌───────────────────────────────────┐
│ Physical      (locks, access)     │
├───────────────────────────────────┤
│ Network       (firewalls, IPS)    │
├───────────────────────────────────┤
│ Endpoint      (antivirus, HIDS)   │
├───────────────────────────────────┤
│ Application   (WAF, secure coding)│
├───────────────────────────────────┤
│ Data          (encryption)        │
├───────────────────────────────────┤
│ User          (training, awareness)│
└───────────────────────────────────┘
```
IDS/IPS is just **one component** in a broader DiD strategy that also includes architecture and process controls, aiming to deter, detect, delay, and respond at multiple stages.

---

## 6. IDS and IPS Analysis Scheme

A typical analysis pipeline has 5 stages:

1. **Data Collection** — Packet sniffing, system logs (sensors capture packets/logs/events).
2. **Preprocessing** — Filtering noise, normalizing data.
3. **Detection Engine** — Matches data against attack signatures or behavior anomalies.
4. **Alerting/Action** — Logs event, sends alert (IDS), or blocks traffic (IPS).
5. **Post-Analysis** — Correlation, investigation, rule tuning (often via SIEM).

```
Sensors ──▶ Preprocessing ──▶ Detection Engine ──▶ Alert/Block ──▶ Post-Analysis
```

---

## 7. Detection Methodologies

| Method | Description | Pros | Cons |
|---|---|---|---|
| **Signature-based** | Detects known attacks using patterns | Fast, accurate | Misses unknown/zero-day attacks |
| **Anomaly-based** | Learns normal behavior, flags deviations | Detects unknown threats | Higher false positives |
| **Heuristic/Behavioral** | Uses rules/AI to identify suspicious behavior | Adaptive | Complex, slower, needs tuning |
| **Hybrid** | Combines multiple methods | Best coverage | Higher resource use |

---

## 8. Principles of IDS

1. **Transparency** — Should not interfere with normal network operations or become a bottleneck.
2. **Timeliness** — Quick detection and alerting for effective response.
3. **Accuracy** — Balance between false positives and false negatives.
4. **Scalability** — Must work in large, distributed networks without losing visibility.
5. **Resilience** — Must withstand evasion tactics and DoS attempts against itself.
6. **Stealth** — Should ideally avoid detection/targeting by intruders.

---

## 9. Threat Hunting Model

A **proactive** search for threats that evade traditional tools — driven by hypotheses, telemetry data, and knowledge of attacker TTPs (e.g., via the **MITRE ATT&CK** framework).

### 9.1 Stages
1. **Trigger** — Alert, anomaly, or hypothesis starts the hunt.
2. **Investigation** — Querying logs, endpoint data for supporting/refuting evidence.
3. **Pattern Discovery** — Looking for Indicators of Compromise (IOCs) — suspicious domains, file hashes, process trees.
4. **Enrichment** — Adding threat intel context to refine picture and severity.
5. **Remediation** — Blocking, patching, or isolating assets based on findings.

### 9.2 Tools Used
SIEM, EDR, Threat Intelligence Feeds, MITRE ATT&CK Framework.

> 💡 **Viva Point:** Threat hunting is proactive (analyst-driven), unlike IDS/IPS which is reactive (alert-driven).

---

## PART B — SESSION 13 & 14

## 10. Symptoms of Attacks

Behavioral or system-level indicators that something is wrong:

| Symptom | Possible Cause |
|---|---|
| Slow network | Possible DDoS or exfiltration |
| Unusual traffic | Large data flows, odd protocols |
| Unauthorized access | Logs showing unknown logins |
| Sudden disk usage spike | Possible ransomware / cryptomining |
| Application crashes | Buffer overflows, exploit attempts |
| Reboots or hangs | Rootkits or low-level malware |
| Unexpected inbound connections | Could indicate backdoor or RAT |

---

## 11. Tiered IDS Architecture

*(Note: "Tired" in the syllabus is a typo for **Tiered**)*

Divides IDS functions into logical layers for scalability and easier maintenance:

```
┌─────────────────────────────────────┐
│ 3. Management Layer (IDS Manager)    │  ← Centralized control, alerts,
│                                       │    policies, correlation, reporting
├─────────────────────────────────────┤
│ 2. Analysis Layer (Agents)           │  ← Filters/interprets data,
│                                       │    applies detection rules
├─────────────────────────────────────┤
│ 1. Data Collection Layer (Sensors)   │  ← Collects packets, logs,
│                                       │    system calls
└─────────────────────────────────────┘
```
This modularity allows **scalability, load distribution, and easier maintenance**.

---

## 12. Sensors — Network vs Host-Based

| Sensor Type | Description |
|---|---|
| **Network-Based Sensor (NIDS)** | Captures packets, inspects traffic (via SPAN/TAP ports or inline) |
| **Host-Based Sensor (HIDS)** | Monitors logs, processes, file changes on individual machines |
| **Wireless Sensor** | Monitors wireless channels for rogue APs/unauthorized devices |
| **Application Sensor** | Tracks application-layer anomalies (e.g., web requests) |

Sensors are deployed at strategic points: **gateways, DMZs, endpoints**.

---

## 13. Denial of Service (DoS) & DDoS

A DoS attack aims to make a service **unavailable to legitimate users** by exhausting resources (bandwidth, CPU, memory, threads).

### 13.1 Types
- **Flood attacks** — ICMP, UDP, SYN flood.
- **Logic attacks** — Ping of death, Slowloris.
- **Application-layer attacks** — HTTP GET flood.

### 13.2 DDoS (Distributed DoS)
Same idea, but launched from **multiple sources (botnets)**, making it harder to block. Large-scale DDoS attacks frequently target websites, APIs, and DNS infrastructure.

---

## 14. DoS & DDoS Mitigation Techniques

| Mitigation | Description |
|---|---|
| **Rate Limiting** | Restricts number of requests from a source |
| **Geo/IP Filtering** | Blocks traffic from malicious regions/reputation lists |
| **Firewalls & IPS** | Drop suspicious packets |
| **Reverse Proxies/CDNs** | Absorb/buffer high traffic loads |
| **Scrubbing Centers** | Redirect traffic to third-party filters (high-capacity providers) |
| **Blackhole Routing** | Drops all packets for target under attack (last resort — sinkholes to null address) |
| **Anomaly Detection IDS** | Detects spikes in traffic volume or packet anomalies vs baseline |

---

## 15. Sensor Deployment Strategy

Effective deployment ensures visibility and coverage while avoiding blind spots and bottlenecks:

- **Perimeter** — Catch inbound/outbound traffic.
- **Core switches** — Detect internal lateral movement.
- **Critical hosts** — File/system/process monitoring on key servers/databases.
- **DMZ** — Monitor exposed/public-facing servers.
- **Wireless APs** — Prevent rogue access points.

> ⚠️ **Exam Trap:** Avoid bottlenecks — use mirror ports and **SPAN/TAP** methods for NIDS deployment.

---

## 16. Agents in IDS

Agents are software components responsible for processing, analyzing, or reacting to collected data.

| Agent Type | Role |
|---|---|
| **Sensor Agents** | Collect data from host or network |
| **Analyzer Agents** | Apply rules, detect patterns |
| **Alert Agents** | Notify central manager |
| **Response Agents** | Block/quarantine threats |
| **Communication Agents** | Relay data securely to manager |

---

## 17. Functions of IDS Agents

Core functions agents perform:
- Data collection & normalization
- Packet filtering
- Log parsing (Syslog, Windows Events)
- Rule matching (signatures or anomalies)
- Alert generation and forwarding
- Local response (quarantine, kill process)

> 💡 **Viva Point:** Distributed agents reduce load on the central system and increase detection granularity.

---

## 18. IDS Manager

The **IDS Manager** is the brain of the system. It:
- Receives alerts from agents
- Correlates and prioritizes events
- Stores logs
- Visualizes attack patterns
- Sends alerts (email, dashboard)
- Applies or updates policies

> 💡 **Example Tools:** Snort + Snorby, OSSEC, AlienVault — all use a central manager to orchestrate detection. Proper tuning and management are crucial for turning raw IDS data into actionable intelligence.

---

## Exam Focus Points (Quick Recall)

- **Traditional attack** = single source, traceable. **Distributed/DDoS** = botnet, hard to block.
- Intruder types: **Masquerader** (stolen creds) · **Misfeasor** (abuses own privilege) · **Clandestine** (hides presence) · **External** (breaches perimeter) · **Insider** (valid access, malicious use).
- IDS types: NIDS, HIDS, WIDS, Application IDS, Hybrid IDS.
- IPS categories: NIPS, HIPS, WIPS, NBA, Content-Based.
- **Defense in Depth** = layered controls, no single point of failure.
- IDS/IPS pipeline: Collection → Preprocessing → Detection → Alert/Action → Post-Analysis.
- Detection methods: Signature (fast, misses zero-day) vs Anomaly (catches unknown, more false positives) vs Heuristic vs Hybrid (best coverage).
- IDS principles: Transparency, Timeliness, Accuracy, Scalability, Resilience, Stealth.
- **Threat Hunting** = proactive, hypothesis-driven; stages: Trigger → Investigation → Pattern Discovery → Enrichment → Remediation.
- **Tiered IDS Architecture** = Sensors (collection) → Agents (analysis) → Manager (management).
- DoS = single-source resource exhaustion; DDoS = multi-source/botnet version.
- DoS/DDoS mitigation: rate limiting, geo/IP filtering, firewalls/IPS, CDNs, scrubbing centers, blackhole routing.
- Sensor deployment points: perimeter, core, critical hosts, DMZ, wireless APs — use SPAN/TAP for NIDS.
- IDS Manager = central brain: correlates alerts, stores logs, manages policy.
