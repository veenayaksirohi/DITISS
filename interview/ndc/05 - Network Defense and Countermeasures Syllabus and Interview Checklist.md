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

**Duration:** 90 hrs (30T + 40L + 20SL) | **CCEE Module**
**Courseware:** Cryptography & Network Security: Principles and Practices (Stallings)

---

## Completion Checklist

- [ ] Information Security fundamentals (Vulnerability/Threat/Risk)
- [ ] Firewalls — pfSense, iptables
- [ ] Wireshark
- [ ] Reverse proxy (Nginx/Squid), UTM, Load Balancing
- [ ] VPN — OpenVPN, IPsec, PPTP/SSTP
- [ ] IDS/IPS — Snort, Suricata, OSSEC
- [ ] DoS/DDoS mitigation
- [ ] SIEM & Log Analysis, Nagios

---

## 🔴 Priority 1 — Must Know

- [ ] Firewalls — packet filtering, stateful inspection, NGFW, DMZ
- [ ] iptables — rule processing, chains (INPUT/OUTPUT/FORWARD), targets (ACCEPT/DROP)
- [ ] VPN — types (Site-to-Site, Remote Access), IPsec (tunnel vs transport mode), SSL/TLS VPN
- [ ] IDS vs IPS — signature-based vs anomaly-based detection
- [ ] Snort, Suricata — NIDS/HIDS setup, rule writing basics

## 🟠 Priority 2 — Important

- [ ] pfSense, ClearOS — firewall/UTM configuration
- [ ] Reverse proxy (Nginx/Squid) vs load balancer — SSL termination, WAF role
- [ ] Wireshark — capture vs display filters, TLS/HTTP/Kerberos analysis
- [ ] DDoS mitigation — rate limiting, defense-in-depth, network vs application layer
- [ ] SIEM — log correlation, event triggering, Nagios monitoring

## 🟡 Priority 3 — Good to Know

- [ ] MITRE ATT&CK Framework, Threat Hunting model
- [ ] Fail2ban, GeoIP blocking, port forwarding via iptables
- [ ] ELK stack for threat hunting

---

## 📌 Interview Comparison Tables

| Firewall Type | Layer | Notes |
|---|---|---|
| Packet Filtering | 3/4 | Stateless, fast, no context |
| Stateful Inspection | 3/4 | Tracks connection state |
| NGFW | 7 | App-aware, IPS+DPI built in |
| Proxy/Application | 7 | Deep content inspection, slower |

| VPN Type | Protocol | Use Case |
|---|---|---|
| Site-to-Site | IPsec | Branch office connectivity |
| Remote Access | OpenVPN/SSL | Individual user access |
| Full Tunnel | — | All traffic routed via VPN |
| Split Tunnel | — | Only corporate traffic via VPN |

## 📌 iptables Default Chains

| Chain | Purpose |
|---|---|
| INPUT | Traffic destined for the local host |
| OUTPUT | Traffic originating from the local host |
| FORWARD | Traffic routed through the host (not destined for it) |

---

## Related Notes
- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
- [[06 - Compliance Audit Syllabus and Interview Checklist]]
