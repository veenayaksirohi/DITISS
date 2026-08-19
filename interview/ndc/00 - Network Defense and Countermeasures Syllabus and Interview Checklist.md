---
title: "05 - Network Defense and Countermeasures Syllabus and Interview Checklist"
aliases:
  - "Network Defense & Countermeasures — CDAC DITISS Syllabus"
tags:
  - network-security
  - firewalls
  - vpn
  - ids-ips
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

# Network Defense & Countermeasures — Interview Checklist

Organized by **interview priority tier**; within each tier, topics are grouped by domain so related concepts stay together.

- **🔴 Priority 1 — Must Know:** Very commonly asked. Explain clearly with examples.
- **🟠 Priority 2 — Important:** Often asked as follow-up or practical questions.
- **🟡 Priority 3 — Good to Know:** Useful for deeper technical rounds and extra advantage.

> For every 🔴 Priority 1 topic, prepare four things: **What is it? → How does it work? → Why is it used? → One real/practical example.**

---

## Completion Checklist

- [ ] 🔴 Priority 1 — Must Know (13 domains)
- [ ] 🟠 Priority 2 — Important (8 domains)
- [ ] 🟡 Priority 3 — Good to Know (case studies, IOC/IOA, evasion, honeypots)

---

# 🔴 Priority 1 — Must Know

## Security Fundamentals

- [ ] Information Security — meaning and purpose
- [ ] CIA Triad — Confidentiality, Integrity, Availability
- [ ] Vulnerability — weakness in a system
- [ ] Threat — something that can exploit a weakness
- [ ] Risk — probability + impact of a threat
- [ ] Attack Vector — path used by attacker
- [ ] Attack Surface — total exposed points
- [ ] Exposure — how much a system is exposed
- [ ] Countermeasure — security control used against risk
- [ ] Risk Management — identify, assess, treat, monitor
- [ ] Security Control — preventive, detective, corrective
- [ ] Defence in Depth — multiple security layers
- [ ] Vulnerability vs Threat vs Risk — very common interview question

> **Must-know relationship:**
> `Threat + Vulnerability → Risk → Countermeasure`
> Example: `Open SSH port + weak password → brute-force risk → MFA + firewall + Fail2ban`

## Firewalls

- [ ] What is a Firewall, how it works, firewall rules
- [ ] Packet Filtering Firewall
- [ ] Stateful vs Stateless Firewall
- [ ] Next Generation Firewall (NGFW) vs Traditional Firewall
- [ ] Proxy Firewall
- [ ] Host Firewall vs Network Firewall
- [ ] Default Allow vs Default Deny
- [ ] Inbound vs Outbound rules

```text
Stateless: Packet → Check IP/Port/Protocol → Allow/Drop
Stateful:  Packet → Check connection state → Check rules → Allow/Drop
```

| Firewall Type       | Layer | Notes                           |
| ------------------- | ----- | ------------------------------- |
| Packet Filtering    | 3/4   | Stateless, fast, no context     |
| Stateful Inspection | 3/4   | Tracks connection state         |
| NGFW                | 7     | App-aware, IPS+DPI built in     |
| Proxy/Application   | 7     | Deep content inspection, slower |

## DMZ

- [ ] What is DMZ, why used, where placed
- [ ] Web server in DMZ; why DB shouldn't be directly exposed
- [ ] Firewall rules: Internet→DMZ, DMZ→Internal, Internal→DMZ

```text
Internet → Firewall → DMZ (Web Server) → Internal Network (DB/Servers)
```

## iptables

- [ ] Netfilter, Tables, Chains, Rules, Targets
- [ ] Rule processing order, Default policy
- [ ] ACCEPT / DROP / REJECT
- [ ] Connection tracking

| Chain   | Purpose                                               |
| ------- | ----------------------------------------------------- |
| INPUT   | Traffic destined for the local host                   |
| OUTPUT  | Traffic originating from the local host               |
| FORWARD | Traffic routed through the host (not destined for it) |

| Table    | Purpose                        |
| -------- | ------------------------------ |
| filter   | Packet filtering               |
| nat      | NAT and port forwarding        |
| mangle   | Packet modification            |
| raw      | Connection tracking exceptions |
| security | Security policies              |

## NAT, Port Forwarding & pfSense

- [ ] NAT, SNAT, DNAT, MASQUERADE
- [ ] Port forwarding, IP forwarding, Internet sharing

```text
Internet → Public IP:80 → Firewall → DNAT → 192.168.1.10:80
```

- [ ] pfSense (lab-based — be ready to explain your config)
  - WAN/LAN/DMZ interfaces
  - Firewall rules, NAT, Routing, Port forwarding, VPN, Access control

## IDS / IPS

- [ ] IDS (passive, detects/alerts) vs IPS (inline, detects + blocks)
- [ ] Inline vs passive deployment
- [ ] Types of IDS: NIDS (Network — e.g., Snort, Suricata) vs HIDS (Host — e.g., OSSEC, Wazuh)

| NIDS             | HIDS                          |
| ---------------- | ----------------------------- |
| Network traffic  | Host activity                 |
| Monitors packets | Monitors logs/files/processes |
| Network sensor   | Installed on host             |
| Snort            | OSSEC                         |

- [ ] Signature-Based vs Anomaly-Based Detection

| Signature Based                | Anomaly Based                       |
| ------------------------------ | ----------------------------------- |
| Detects known patterns         | Detects unusual behavior            |
| Fast, low false positives      | Can detect unknown/zero-day attacks |
| Cannot easily detect zero-days | May have more false positives       |

- [ ] Snort — NIDS role, signature-based detection, packet inspection, sensors, rule structure

```text
alert tcp any any -> any 80 (msg:"HTTP Traffic"; sid:1000001;)
```

- [ ] Suricata — IDS mode vs IPS mode, signature rules, multi-threading advantage over Snort

## VPN

- [ ] Encryption, Authentication, Tunneling
- [ ] Remote Access VPN vs Site-to-Site VPN

```text
Office A → VPN Gateway === Encrypted Tunnel === VPN Gateway → Office B
```

| VPN               | Purpose                        |
| ----------------- | ------------------------------ |
| Remote Access VPN | User connects to organization  |
| Site-to-Site VPN  | Connects two networks          |
| Full Tunnel       | All traffic goes through VPN   |
| Split Tunnel      | Only selected traffic uses VPN |

## IPsec

- [ ] Encryption, Authentication, Integrity
- [ ] AH (Authentication Header) — auth + integrity, no encryption
- [ ] ESP (Encapsulating Security Payload) — encryption + auth + integrity

| Transport Mode             | Tunnel Mode                      |
| -------------------------- | -------------------------------- |
| Payload protected          | Entire original packet protected |
| Original IP header visible | New IP header added              |
| Host-to-host               | Common for VPN gateways          |

- [ ] OpenVPN (lab-based) — client/server model, TLS-based, certificates, remote access & site-to-site

## Wireshark & Traffic Analysis

- [ ] Packet capture and analysis
- [ ] Capture filter vs Display filter
- [ ] TCP handshake, DNS/HTTP/TLS/ICMP packets

| Capture Filter            | Display Filter            |
| ------------------------- | ------------------------- |
| Applied before capture    | Applied after capture     |
| Captures selected traffic | Displays selected packets |

```text
Display filter examples: tcp | http | dns | icmp | ip.addr == 192.168.1.10 | tcp.port == 443
```

- [ ] TCP Three-Way Handshake

```text
Client               Server
SYN ----------------->
     <---------------- SYN-ACK
ACK ----------------->
```

- [ ] tcpdump — vs Wireshark, interface capture, packet filtering, saving captures

```bash
tcpdump -i eth0
```

## DoS / DDoS

- [ ] DoS vs DDoS, Botnet, Resource exhaustion
- [ ] Volumetric, Protocol, Application-layer attacks

| DoS                | DDoS                         |
| ------------------ | ---------------------------- |
| Usually one source | Multiple distributed sources |
| Easier to block    | Harder to block              |
| Smaller scale      | Large-scale attack           |

- [ ] DDoS Mitigation
  - Layer 3/4: ACL, Firewall, SYN protection, rate limiting
  - Layer 7: WAF, CAPTCHA, request rate limiting, reverse proxy
  - CDN, traffic scrubbing, cloud DDoS protection

## Reverse Proxy & Fail2ban

- [ ] Reverse Proxy — Nginx: hides backend, SSL termination, load balancing, caching, request filtering

```text
Client → Nginx Reverse Proxy → [App 1, App 2]
```

| Forward Proxy       | Reverse Proxy         |
| ------------------- | --------------------- |
| Represents client   | Represents server     |
| Hides clients       | Hides backend servers |
| Used by users       | Used by applications  |
| Squid commonly used | Nginx commonly used   |

- [ ] Fail2ban — reads logs, detects repeated failures, bans IP via firewall rules, SSH brute-force protection

```text
Failed Login → Log File → Fail2ban → Detect Threshold → Firewall Ban
```

## SIEM & SOC

- [ ] SIEM — log collection/aggregation/normalization, correlation, detection, alerts, dashboards, incident investigation
- [ ] SIEM Log Correlation

```text
Firewall: repeated connections from IP X
        +
IDS: port scan from IP X
        +
Linux: multiple failed SSH logins
        ↓
SIEM correlation → Possible brute-force / reconnaissance attack
```

- [ ] Security Logs — Firewall, IDS/IPS, system, authentication, application, web server, VPN logs
- [ ] SOC Workflow

```text
Alert → Triage → Investigation → Containment → Eradication → Recovery → Reporting
```

- [ ] Incident Response

```text
Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned
```

## Threat Hunting & MITRE ATT&CK

- [ ] Threat Hunting — proactive vs reactive security, hypothesis-driven, data collection, indicators
- [ ] MITRE ATT&CK — Tactics, Techniques, Procedures (TTPs)
  - Example tactics: Initial Access, Execution, Persistence, Privilege Escalation, Credential Access, Discovery, Lateral Movement, Exfiltration, Impact
- [ ] Attack Symptoms — high CPU/RAM/bandwidth, service outage, unexpected processes, failed logins, unusual connections, changed files, strange DNS traffic

---

# 🟠 Priority 2 — Important

## Security Concepts

- [ ] Security Events — Event → Alert → Incident (e.g., login failure = Event, 100 failures = Alert, confirmed compromise = Incident)
- [ ] QoS — Bandwidth, Latency, Jitter, Packet loss, Throughput
- [ ] Blast Radius — how much of the environment is affected if one component is compromised; segmentation reduces it
- [ ] Network Segmentation — separate zones (Public/DMZ/Internal/DB/Management) to limit attacker movement
- [ ] Three-Tier Architecture — Frontend → Backend/Application → Database; DB should not be directly Internet-exposed

```text
Frontend → Backend/Application → Database
```

## Firewalls & Filtering (Extended)

- [ ] Proxy Firewall — application-layer inspection, hides internal network, access control, content filtering
- [ ] Screened Host Firewall — screening router, bastion host, internal network, extra protection layer
- [ ] UTM (Unified Threat Management) — Firewall + Antivirus + VPN + IDS/IPS + web filtering + content filtering + anti-spam in one appliance
- [ ] UTM vs NGFW — UTM bundles many functions in one appliance; NGFW is app-aware with DPI, IDS/IPS, user awareness, advanced threat detection
- [ ] GeoIP Blocking — block traffic by geographic IP location (Xtables-addons); use cases: region restriction, fraud prevention
- [ ] IPv6 Firewall Rules — separate considerations from IPv4, `ip6tables`, ICMPv6 importance
- [ ] Xtables-Addons — extra match/target extensions for iptables (GeoIP is a common example)
- [ ] Linux Kernel Modules for Firewalling — Netfilter runs in-kernel, connection tracking modules, NAT modules
- [ ] Rate Limiting — restricts request/packet count, protects against brute force & DoS/DDoS; implemented in iptables, Nginx, WAF, application layer

## VPN Protocols (Extended)

- [ ] PPTP — older VPN protocol, weak security; legacy, generally avoided in secure modern deployments
- [ ] SSTP — Secure Socket Tunneling Protocol, uses TLS, common in Microsoft environments, TCP 443
- [ ] L2TP — Layer 2 Tunneling Protocol, usually combined with IPsec for security
- [ ] Windows RRAS — Routing and Remote Access Service (routing, VPN, remote access)
- [ ] Hybrid VPN — combines different VPN types/technologies depending on environment
- [ ] Trusted VPN (security from provider-controlled network) vs Secure VPN (security from cryptography)
- [ ] VPN Attacks — credential theft/reuse, weak passwords, outdated software, config mistakes, cert issues, brute-force
- [ ] VPN Misconfiguration — weak auth, open access, incorrect routes, over-permissive access, unpatched gateway, wrong split tunneling

| VPN Type      | Protocol    | Use Case                       |
| ------------- | ----------- | ------------------------------ |
| Site-to-Site  | IPsec       | Branch office connectivity     |
| Remote Access | OpenVPN/SSL | Individual user access         |
| Full Tunnel   | —           | All traffic routed via VPN     |
| Split Tunnel  | —           | Only corporate traffic via VPN |

## IDS Architecture (Extended)

- [ ] OSSEC — HIDS, host/log monitoring, file integrity monitoring, agent/server architecture
- [ ] IDS Architecture

```text
Network/Host → Sensor/Agent → IDS Manager → Database → Console/Dashboard
```

- [ ] IDS Sensors — Network Sensor (monitors packets) vs Host Sensor (monitors logs/processes/files/auth)
- [ ] IDS Agent — collects events, monitors host, sends logs, detects changes, communicates with manager
- [ ] IDS Manager — central management, receives alerts, stores/correlates events, manages agents & rules
- [ ] Intruder Types
  - Masquerader — unauthorized person posing as legitimate user
  - Misfeasor — legitimate user abusing privileges
  - Clandestine User — attacker with admin control hiding activity
- [ ] Traditional vs Distributed Attacks

```text
Traditional: Attacker → Victim
Distributed: Bot1, Bot2, Bot3 → Victim
```

## Reverse Proxy & Load Balancing (Extended)

- [ ] Load Balancer — high availability, scalability, health checks, LB vs reverse proxy
- [ ] Squid — forward proxy, caching, access control, URL filtering (can also act as reverse proxy)
- [ ] Nginx — web server, reverse proxy, load balancer, SSL termination, caching
- [ ] SSL/TLS Termination

```text
Client → HTTPS → Reverse Proxy → Decrypt TLS → HTTP/HTTPS → Backend
```

- Central certificate management, reduced backend TLS load, traffic inspection

- [ ] Server Farming — multiple servers for same service, load balancer distributes traffic, scalability/availability
- [ ] WAF vs Firewall

| Network Firewall  | WAF                           |
| ----------------- | ----------------------------- |
| Mainly L3/L4      | Mainly L7                     |
| IP and ports      | HTTP requests                 |
| Network attacks   | Web attacks (SQLi, XSS, etc.) |
| TCP/UDP filtering | Application-layer filtering   |

## Monitoring Tools

- [ ] ELK Stack — Elasticsearch (stores/searches logs), Logstash (collects/processes), Kibana (visualizes)

```text
Logs → Logstash → Elasticsearch → Kibana
```

- [ ] Syslog — standard logging mechanism, central log server, devices forward logs
- [ ] Nagios — infrastructure/host/service monitoring, CPU/RAM/Disk, availability, alerts

| Nagios                    | SIEM                |
| ------------------------- | ------------------- |
| Infrastructure monitoring | Security monitoring |
| CPU/RAM/Disk/availability | Security events     |
| Performance alerts        | Security alerts     |
| Operational monitoring    | Threat detection    |

- [ ] Nagios (health/availability) vs IDS (malicious activity detection)

---

# 🟡 Priority 3 — Good to Know

## Frameworks & Risk

- [ ] NIST Cybersecurity Framework — Govern, Identify, Protect, Detect, Respond, Recover
- [ ] OWASP Top 10 (risk perspective) — Broken Access Control, Cryptographic Failures, Injection, Insecure Design, Security Misconfiguration, Vulnerable Components, Authentication Failures, Software/Data Integrity Failures, Logging/Monitoring Failures, SSRF
  - Focus on how Firewall/WAF/IDS-IPS/SIEM/Reverse proxy help detect or reduce these
- [ ] Security Breach Case Studies — analysis process: attack vector → vulnerability → root cause → impact → countermeasure
- [ ] Financial Impact of incidents — loss, downtime, ransom, legal penalties, IR cost, customer loss
- [ ] Reputational Impact — loss of trust, churn, negative publicity

## Firewall & Automation

- [ ] Firewall Misconfiguration examples — `0.0.0.0/0 → DB Port`, `Allow Any → Any`
- [ ] Firewall Automation — Bash scripts to add/remove rules, block IPs, configure policies

## Packet & Protocol Analysis

- [ ] Kerberos Packet Analysis — authentication protocol, tickets, common in AD, viewable in Wireshark
- [ ] TLS Packet Analysis — handshake, Client Hello, Server Hello, Certificate, session keys
- [ ] Suspicious Packet Patterns — SYN scan, excessive SYN, ICMP flood, sequential port connections, repeated failed connections, unusual DNS queries

## Detection & Deception

- [ ] Honeypot (decoy system) and Honeynet (network of honeypots)
- [ ] Distributed Honeynet — collect attack info, study attacker behavior, detect new techniques
- [ ] UAC — URL Analyzer and Classifier — analyze/categorize suspicious URLs
- [ ] IDS Evasion — fragmentation, encoding, obfuscation, encryption, protocol manipulation; mitigated by normalization, updated signatures, TLS visibility, endpoint monitoring, layered detection
- [ ] False Positive (alert with no real attack) vs False Negative (missed real attack — usually more dangerous)
- [ ] Security Event Severity — Informational, Low, Medium, High, Critical (based on impact, asset importance, threat, exploitability, confidence)

## Threat Intelligence

- [ ] Threat Intelligence — IP reputation, malicious domains, file hashes, IOCs, attack techniques
- [ ] IOC (Indicator of Compromise) — malicious IP/domain, suspicious hash, unexpected process, strange login
- [ ] IOA (Indicator of Attack) — focuses on attacker behavior

```text
PowerShell → downloads file → creates persistence → connects externally
```

- [ ] QoS Security Analysis — DDoS effect chain: Traffic↑ → Latency↑ → Packet Loss↑ → Service Quality↓

---

## 📌 Practical / Lab Topics — "What did you actually do in your lab?"

| Lab                  | Interview Importance | Prepare                     |
| -------------------- | -------------------- | --------------------------- |
| pfSense Installation | 🔴 High              | Interfaces, rules, NAT      |
| pfSense DMZ          | 🔴 High              | Architecture and rules      |
| iptables rules       | 🔴 Very High         | INPUT/OUTPUT/FORWARD        |
| iptables NAT         | 🔴 Very High         | SNAT/DNAT/MASQUERADE        |
| Port Forwarding      | 🔴 High              | DNAT                        |
| Fail2ban             | 🔴 High              | SSH brute-force protection  |
| Wireshark            | 🔴 Very High         | Filters and packet analysis |
| Nginx Reverse Proxy  | 🔴 High              | Backend routing             |
| Squid                | 🟠 Medium            | Proxy functionality         |
| OpenVPN              | 🔴 High              | Remote/site-to-site VPN     |
| pfSense Routing      | 🔴 High              | Two subnet communication    |
| PPTP/SSTP            | 🟠 Medium            | Basic concept               |
| Snort                | 🔴 Very High         | NIDS + rules                |
| OSSEC                | 🔴 High              | HIDS                        |
| Suricata             | 🔴 Very High         | IDS/IPS                     |
| ELK                  | 🔴 High              | Threat hunting/logs         |
| Syslog               | 🔴 High              | Centralized logs            |
| SIEM                 | 🔴 Very High         | Log correlation             |
| Nagios               | 🟠 High              | Infrastructure monitoring   |

---

## 📌 Recommended Study Order

```text
1. Vulnerability / Threat / Risk
2. Firewall
3. Stateless vs Stateful
4. DMZ
5. iptables
6. NAT / SNAT / DNAT / Port Forwarding
7. pfSense
8. IDS vs IPS
9. NIDS vs HIDS
10. Signature vs Anomaly Detection
11. Snort / Suricata / OSSEC
12. VPN
13. IPsec + AH + ESP
14. Tunnel vs Transport
15. Full Tunnel vs Split Tunnel
16. Wireshark / tcpdump
17. DoS / DDoS
18. DDoS Mitigation
19. Reverse Proxy / Nginx
20. Fail2ban
21. SIEM
22. Log Correlation
23. ELK
24. Threat Hunting
25. SOC / Incident Response
26. MITRE ATT&CK
27. Nagios
```

### Strongest-answer priority (fresher Network/Security/Cloud/Infra interview)

**Firewall → DMZ → iptables → NAT → pfSense → IDS/IPS → Snort → Suricata → OSSEC → VPN → IPsec → Wireshark → DoS/DDoS → SIEM → Log Correlation → Defence in Depth → Incident Response.**

---

## Related Notes

- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
- [[06 - Compliance Audit Syllabus and Interview Checklist]]
