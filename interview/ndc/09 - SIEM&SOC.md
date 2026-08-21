# SIEM & SOC — Detailed Notes

# 1. SIEM Basics

## 1.1 What is SIEM?

**SIEM** = **Security Information and Event Management**. It collects security logs from many systems, stores them centrally, analyzes them, correlates related events, and generates alerts when suspicious activity is found.

> **Simple Definition:** SIEM is a centralized security platform that collects and analyzes logs from multiple systems to detect suspicious activity and support incident investigation.

```text
Firewall Logs, IDS/IPS Logs, Auth Logs, System Logs, Web Logs, VPN Logs
      ↓
     SIEM → Collect + Normalize + Correlate → Detect Suspicious Activity → Alert → SOC Analyst
```

## 1.2 Why is SIEM Needed?

Every device (firewall, server, VPN, web server, IDS/IPS, application, OS) creates its own separate logs.
**Without SIEM:** an analyst must check each system individually — slow and easy to miss connections between events.
**With SIEM:** all logs flow into one place for central analysis:

```text
Firewall ─┐
Linux ────┤
VPN ──────┼→ SIEM → Central Analysis
IDS ──────┤
Web/Apps ─┘
```

## 1.3 Main Functions of SIEM

Log collection, log aggregation, log normalization, correlation, detection, alert generation, dashboards, search, incident investigation, reporting.

```text
Collect → Aggregate → Normalize → Correlate → Detect → Alert → Investigate
```

---

# 2. Log Handling: Collection, Aggregation, Normalization

## 2.1 Log Collection

**Log collection** means receiving security logs from different devices and applications — firewalls, routers, IDS/IPS, Linux/Windows servers, VPN gateways, web servers, applications, authentication systems.

```text
Firewall → Logs ─┐
Linux    → Logs ─┼→ SIEM
VPN      → Logs ─┘
```

> **Interview-Ready Answer:** Log collection is the process of gathering logs from different systems and sending them to a central SIEM platform.

## 2.2 Log Aggregation

**Log aggregation** means bringing logs from many different sources into one central location, so an analyst doesn't have to check every system separately.

```text
Server 1 Logs ─┐
Server 2 Logs ─┤
Firewall Logs ─┼→ Central SIEM
VPN Logs ──────┤
IDS Logs ──────┘
```

## 2.3 Log Normalization

Different systems write logs in different formats:

```text
Firewall: SRC=10.0.0.5 DST=192.168.1.10 ACTION=DENY
Linux:    Failed password for root from 10.0.0.5
VPN:      Login failure source_ip=10.0.0.5 user=admin
```

**Normalization** converts these into one common structure:

```text
Source IP: 10.0.0.5 | Destination: 192.168.1.10 | Event Type: Authentication Failure | Action: Denied
```

> **Simple Definition:** Normalization converts logs from different formats into a common format so they can be searched and correlated easily.

**Why it matters:** without it, the same field has different names everywhere (`SRC_IP`, `remote_host`, `source`, `client_ip`), making comparison hard. After normalization, one consistent field name (e.g. `Source IP`) makes searching, correlation, dashboards, and detection rules far more reliable.

---

# 3. Correlation & Detection

## 3.1 What is Correlation?

**Correlation** means connecting multiple related security events to identify a bigger attack pattern. A single event may look harmless, but several events together can reveal an attack.

> **Simple Definition:** Correlation combines related events from different systems to identify suspicious patterns that may not be obvious from one log alone.

**Example — attacker IP `203.0.113.50`:**

```text
Firewall: repeated connections to multiple ports
IDS:      port scan detected
Linux:    20 failed SSH logins
      ↓
SIEM Correlation (same source IP + port scan + repeated connections + failed logins)
      ↓
Possible Reconnaissance + Brute-Force Attack → High-priority alert
```

**Why it's powerful:** one failed SSH login alone may be normal, but `100 failed logins + port scan + firewall denies + same source IP` is far more suspicious — correlation adds **context** that a single log can't provide.

## 3.2 Detection

**Detection** means identifying suspicious activity using correlation rules, thresholds, known attack patterns, behavior patterns, threat indicators, or baselines.

```text
Normal: 2 failed logins        Abnormal: 100 failed logins in 1 minute → Possible brute-force attack
```

**Detection rule example:**

```text
Failed Login → Count attempts → More than 10 in 5 minutes? No → Ignore | Yes → Alert
```

---

# 4. Alerts & Dashboards

## 4.1 Alert Generation

When SIEM detects suspicious activity, it generates an **alert**, which may contain: source IP, destination IP, username, timestamp, event type, severity, related logs, and the detection rule name.

```text
ALERT — Type: SSH Brute Force | Source: 203.0.113.50 | Target: 192.168.1.20 | Failed Attempts: 50 | Severity: High
```

## 4.2 Event vs Alert

- **Event** — something that happened, e.g. one failed login.
- **Alert** — an event or group of events considered suspicious enough to need attention, e.g. 50 failed logins from the same IP within 2 minutes.

```text
Event → Raw activity
Alert → Suspicious activity requiring attention
```

## 4.3 SIEM Dashboards

A **dashboard** gives a visual summary of security status — number of alerts, high-severity incidents, top attacking IPs, failed login counts, firewall blocks, malware detections, VPN activity, traffic trends.

```text
Security Dashboard
High Alerts: 12 | Failed Logins: 450 | Blocked IPs: 28 | IDS Alerts: 70 | VPN Failures: 33 | Critical Incidents: 4
```

Dashboards help SOC analysts quickly understand overall security status.

## 4.4 Incident Investigation via SIEM

When an alert appears, an analyst investigates using SIEM's search capability:

```text
Alert: Multiple failed SSH logins → Search Source IP → Check Firewall Logs → Check IDS Alerts
→ Check VPN Logs → Check Authentication Logs → Understand Attack Timeline
```

SIEM helps build a complete picture from data that would otherwise be scattered across many systems.

---

# 5. Security Log Sources

**Security logs** are records of events generated by systems, applications, and security devices. They help answer: Who connected? From where? At what time? Was access successful? What service was used? Was traffic blocked? Was an attack detected?

| Log Source              | What It Shows                                                                                          | Useful For                                                                    |
| ----------------------- | ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| **Firewall Logs**       | Source/destination IP & port, protocol, allow/deny action, interface, timestamp                        | Port scan investigation, unauthorized connections, blocked traffic            |
| **IDS/IPS Logs**        | Attack signature, source/destination IP, severity, protocol, alert category, action taken (Alert/Drop) | Attack detection and prevention review                                        |
| **Authentication Logs** | Username, login success/failure, source IP, timestamp, auth method                                     | Brute-force detection, credential attacks, suspicious logins                  |
| **System Logs**         | OS/service events — service started/stopped, reboots, kernel/disk errors, user created                 | General system health and integrity                                           |
| **Application Logs**    | User actions, errors, login attempts, API requests, DB failures, permission errors                     | Business-context investigation network logs can't show                        |
| **Web Server Logs**     | Client IP, requested URL, HTTP method, status code, user agent, timestamp                              | Reconnaissance detection (e.g. repeated `/admin`, `/login`, `/.env` requests) |
| **VPN Logs**            | Connection attempts, login success/failure, username, source IP, assigned VPN IP, session duration     | Credential attack detection on remote access                                  |

**Correlation example across log sources — attacker IP `203.0.113.50`:**

```text
VPN: 20 failed login attempts
Firewall: same IP probing TCP 22, 443, 3389
IDS: port scanning alert
      ↓
SIEM: Same IP + VPN failures + port scan + firewall activity → Possible Reconnaissance and Credential Attack
```

---

# 6. SOC (Security Operations Center)

## 6.1 What is SOC?

**SOC** = **Security Operations Center** — a team or function responsible for continuously monitoring, detecting, investigating, and responding to security threats.

> **Simple Definition:** A SOC monitors security alerts and investigates and responds to cyber incidents.

## 6.2 SIEM vs SOC

| SIEM                              | SOC                                     |
| --------------------------------- | --------------------------------------- |
| A **technology/platform**         | A **security operations team/function** |
| Collects + analyzes security logs | Monitors + investigates + responds      |
| = **Tool**                        | = **People + Process + Tools**          |

## 6.3 How SIEM and SOC Work Together

```text
Security Devices → SIEM → Correlation/Detection → Alert → SOC Analyst → Investigation → Response
```

SIEM gives the SOC visibility; the SOC decides what action to take.

---

# 7. SOC Workflow

This is one of the most important interview flows:

```text
Alert → Triage → Investigation → Containment → Eradication → Recovery → Reporting
```

## 7.1 Alert

Generated by SIEM, IDS/IPS, EDR, firewall, antivirus, or a cloud security system, e.g. `SIEM Alert: Possible SSH Brute Force`. The SOC analyst receives it.

## 7.2 Triage

**Triage** is the quick initial review to decide: Is it real? How serious is it? Which systems are affected? Does it need immediate investigation?

> **Simple Definition:** Triage is the initial review and prioritization of a security alert.
> **Example:** Alert = `10 failed SSH logins`. Analyst checks: Is the source IP trusted? Was it an admin? Did a login later succeed? Is this a public server? Are there related alerts? → If activity is expected, it's a **False Positive**; if suspicious, **escalate to Investigation**.

## 7.3 Investigation

Deep analysis of the incident — checking firewall logs, authentication logs, IDS alerts, VPN logs, endpoint activity, web logs, and user activity.

```text
Brute-Force Alert → Check Source IP → Check Login Failures → Check Successful Login → Check Commands Executed → Check Other Hosts
```

Goal: understand what happened, when, how, which systems/accounts, and how far the attacker got.

## 7.4 Containment

**Containment** stops the incident from spreading further — e.g. block the malicious IP, isolate the compromised host, disable the user account, disconnect the system, block the malicious domain, revoke the VPN session.

> **Simple Definition:** Containment limits the attack and reduces the blast radius.

## 7.5 Eradication

**Eradication** removes the root cause — remove malware, delete attacker accounts, patch the vulnerability, change compromised passwords, remove malicious files, fix misconfiguration, close the exposed service.

## 7.6 Recovery

**Recovery** safely returns affected systems to normal — restore systems/backups, reconnect the network, re-enable accounts, verify applications, and monitor closely for recurring attack activity.

## 7.7 Reporting

Document what happened, attack source, timeline, affected systems, business impact, actions taken, root cause, lessons learned, and preventive recommendations.

## 7.8 Easy Memory

```text
Alert         → "What is this?"
Triage        → "Is it real and how bad?"
Investigation → "What happened?"
Containment   → "Stop it."
Eradication   → "Remove it."
Recovery      → "Restore safely."
Reporting     → "Document and improve."
```

## 7.9 Full Worked Example — SSH Brute-Force Incident

```text
1. Firewall logs: repeated TCP 22 connections from 203.0.113.50
2. IDS: possible SSH brute-force
3. Linux: 50 failed SSH logins
4. SIEM correlates Firewall + IDS + Linux → High-Severity Alert
5. SOC Triage: is IP trusted / is activity expected? → No
6. Investigation: check if any login succeeded, check commands, check related hosts
7. Containment: block attacker IP, disable compromised account if needed
8. Eradication: reset credentials, remove malware if present, fix SSH configuration
9. Recovery: restore normal access, monitor
10. Reporting: document timeline and recommendations
```

---

# 8. SIEM Operational Concepts

## 8.1 Time Synchronization (NTP)

If system clocks don't match, correlation becomes difficult — e.g. Firewall says "attack at 10:00," Linux says "login at 10:07," IDS says "scan at 09:55." Organizations use **NTP (Network Time Protocol)** to keep all systems' clocks synchronized so events line up correctly.

## 8.2 Log Retention

**Log retention** = how long logs are kept (e.g. 30 days, 90 days, 1 year). Depends on company policy, storage capacity, compliance requirements, and investigation needs.

## 8.3 SIEM vs IDS

| SIEM                               | IDS                                      |
| ---------------------------------- | ---------------------------------------- |
| Collects logs from many sources    | Monitors traffic/activity for attacks    |
| Correlates multiple events         | Detects suspicious activity at one point |
| Central visibility                 | Specific detection point                 |
| Supports investigation             | Generates security alerts                |
| Example: many log sources combined | Example: Snort                           |

They complement each other: `IDS Alert → SIEM → Correlation with other logs`.

## 8.4 SIEM vs Basic Log Management

Basic log management = `Collect → Store → Search`.
SIEM adds: `Security Detection + Correlation + Alerts + Incident Investigation`.

## 8.5 SIEM and Defence in Depth

SIEM is **not** a firewall and does not replace firewall, IDS/IPS, EDR, antivirus, authentication, or MFA. Instead, it sits above all of them, providing centralized visibility:

```text
Firewall ─┐
IDS ──────┤
EDR ──────┼→ SIEM → SOC
VPN ──────┤
Server/Web┘
```

## 8.6 Typical SIEM Architecture

```text
Security Devices → Log Forwarders/Agents → SIEM Collection → Normalization → Storage
→ Correlation Engine → Detection Rules → Alerts → Dashboards → SOC Analyst
```

## 8.7 Security Event Lifecycle

```text
Event Generated → Log Collected → Log Normalized → Event Correlated → Threat Detected
→ Alert Generated → SOC Triage → Investigation → Response
```

---




# 12. Quick Revision Table

| Topic           | Simple Meaning                                 |
| --------------- | ---------------------------------------------- |
| SIEM            | Central security log analysis platform         |
| Log Collection  | Receive logs from systems                      |
| Log Aggregation | Bring many logs into one place                 |
| Normalization   | Convert logs to common format                  |
| Correlation     | Connect related events                         |
| Detection       | Identify suspicious activity                   |
| Alert           | Security activity requiring attention          |
| Dashboard       | Visual security summary                        |
| SOC             | Security monitoring and response team/function |
| Triage          | Initial alert review                           |
| Investigation   | Deep incident analysis                         |
| Containment     | Stop attack from spreading                     |
| Eradication     | Remove threat/root cause                       |
| Recovery        | Restore systems safely                         |
| Reporting       | Document incident and lessons                  |

---

# 13. Best Flows to Remember

```text
SIEM Flow:
Security Logs → Collection → Aggregation → Normalization → Correlation → Detection → Alert → SOC

SOC Flow:
Alert → Triage → Investigation → Containment → Eradication → Recovery → Reporting
```

> **Most important interview line:** SIEM collects and correlates security data; the SOC uses that information to investigate and respond to incidents.
