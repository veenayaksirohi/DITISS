# Incident Response, Threat Hunting & MITRE ATT&CK — Detailed Notes

# 1. Incident Response Basics

## 1.1 What is Incident Response?

**Incident Response (IR)** is the structured process an organization uses to detect, investigate, contain, remove, and recover from a cybersecurity incident.
Examples of incidents: malware infection, ransomware, compromised user account, data breach, unauthorized access, web server compromise, phishing attack, SSH brute-force, insider threat, DDoS attack.

> **Simple Definition:** Incident Response is the process of handling a security incident from preparation through recovery and lessons learned.

```text
Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned
```

## 1.2 Main Goals of Incident Response

Detect the incident quickly, limit the damage, protect important systems and data, remove the attacker/malware, restore normal operations, preserve evidence, find the root cause, and prevent recurrence.
A good IR process reduces: downtime, data loss, financial damage, attack spread, and business impact.

---

# 2. The Six IR Phases

## 2.1 Phase 1 — Preparation

Happens **before** an incident occurs — getting people, processes, and tools ready to respond quickly.
**Key activities:** create an Incident Response Plan, define roles/responsibilities, maintain contact lists, configure logging, deploy SIEM/IDS-IPS/EDR-antivirus, configure backups, patch systems, prepare forensic tools, run security training, define escalation procedures, create playbooks, test the plan.
**Example — ransomware attack:**

```text
With backup:    Ransomware → Server Encrypted → Clean Backup Available → System Restored
Without backup: Ransomware → No Backup → Long Downtime / Data Loss
```

> **Interview-Ready Answer:** Preparation means getting the organization ready before an incident occurs by creating response plans, defining responsibilities, enabling logging and monitoring, maintaining backups, deploying security tools, and training the response team.

## 2.2 Phase 2 — Identification

Determines whether a security incident has actually occurred. Sources: SIEM alerts, IDS/IPS alerts, firewall logs, authentication logs, EDR alerts, user reports, web server logs, VPN logs, threat intelligence.
**Key questions:** What happened? When? Which systems/accounts are involved? Where did it come from? Is it malicious? How severe is it?
**Example:** `Firewall: repeated SSH connections + Authentication: 50 failed logins + Successful root login → Possible Account Compromise` — this should be investigated as an incident.

```text
Alert → Check Evidence → Review Logs → Correlate Events → Real Incident?
   No → Close/Tune          Yes → Escalate → Containment
```

**Identification vs Triage:** Triage quickly asks "Is this alert important?" Identification confirms "Has a real incident occurred, and what is its scope?" — triage typically happens first, then feeds into identification.

## 2.3 Phase 3 — Containment

Stopping or limiting the attack so it can't cause more damage.

> **Simple Definition:** Containment limits the attack and prevents it from spreading (reduces the **blast radius**).
> Actions: isolate infected system, block attacker IP, disable compromised account, revoke VPN session, block malicious domain, remove system from network, disable vulnerable service, add firewall rule, segment affected network.

**Short-Term vs Long-Term Containment:**
| Short-Term Containment | Long-Term Containment |
|---|---|
| Immediate emergency action | More stable temporary protection |
| Stops active damage right now | Keeps business running safely until fixed |
| Block IP / disable account / disconnect server | Isolate network segment, restrict roles, move service to secure environment, add stronger monitoring |

```text
Short-Term → Stop it now.
Long-Term  → Keep it safely controlled until fixed.
```

> **Preserve evidence during containment** — logs, memory, disk images, network captures, malware samples, authentication history, running processes, timestamps. Immediately wiping a compromised machine may destroy evidence needed for investigation.

## 2.4 Phase 4 — Eradication

Completely removing the threat and fixing the root cause.

> **Simple Definition:** Eradication removes the attacker, malware, vulnerability, or other root cause from the environment.
> Actions: remove malware, delete malicious files, remove attacker accounts, reset compromised credentials, patch vulnerabilities, correct firewall rules, remove persistence mechanisms, update vulnerable software, rebuild compromised systems, fix insecure configuration.

**Root-Cause Analysis (RCA):** find the _real_ reason the incident was possible — don't stop at "the server was hacked."

```text
Server Compromised → Why? → Attacker used SSH → Why? → Password was stolen → Why? → No MFA was enabled
```

Common root causes: missing patch, weak password, no MFA, firewall misconfiguration, publicly exposed database, excessive permissions, phishing, default credentials, vulnerable web app, poor network segmentation.

## 2.5 Phase 5 — Recovery

Restoring affected systems to normal operation after the threat is removed.
Activities: restore from clean backup, rebuild server, reconnect systems, restore applications, enable user accounts, test business functionality, verify security controls, monitor closely.

```text
Threat Removed → System Rebuilt/Restored → Security Validation → Reconnect to Network → Return to Production → Continuous Monitoring
```

**Recovery Validation** — confirming the system is really safe _before_ returning it to production. Check: malware removed? vulnerability patched? credentials reset? unauthorized accounts removed? firewall rules correct? services functioning? logs normal? IDS/EDR alerts stopped? backdoors removed? application working?

> **Important:** Don't return a system to production just because it "starts working" — you must also verify the security problem is actually fixed.

## 2.6 Phase 6 — Lessons Learned

After the incident closes, the team reviews what happened to improve future security.
**Key questions:** What happened? How did the attacker enter? Why did detection succeed/fail? Was response fast enough? Which controls worked/failed? What should improve? How can recurrence be prevented?
**Possible improvements:** update firewall rules, add SIEM detection, patch systems, enable MFA, improve backups/playbooks/employee awareness, add network segmentation, tune IDS rules, improve logging.

```text
Incident: SSH brute force → Lesson: SSH too widely exposed → Improvement: VPN + SSH keys + MFA + Fail2ban
```

## 2.7 Complete IR Flow — Easy Memory

```text
Preparation    → "Be ready."
Identification → "What happened?"
Containment    → "Stop the spread."
Eradication    → "Remove the cause."
Recovery       → "Restore safely."
Lessons Learned→ "Improve security."
```

---

# 3. Threat Hunting Basics

## 3.1 What is Threat Hunting?

**Threat Hunting** is the proactive search for hidden threats that may already exist inside an environment but haven't triggered a normal security alert.

> **Simple Definition:** Threat hunting is proactively searching through security data to find attackers or suspicious behavior that automated tools may have missed.

## 3.2 Why Threat Hunting is Needed

Security tools can miss attacks because: no known signature exists, the attack is new, the attacker behaves slowly, the attacker uses legitimate tools, a detection rule is missing, or the attacker hides their activity.

> Threat hunting asks: "What if an attacker is already inside and our tools haven't detected them?"

## 3.3 Proactive vs Reactive Security

| Proactive (Threat Hunting) | Reactive (Incident Response)     |
| -------------------------- | -------------------------------- |
| Search **before** an alert | Respond **after** an alert       |
| Hypothesis driven          | Alert/event driven               |
| Looks for hidden attackers | Handles a known suspicious event |

```text
Threat Hunting   → "Let's look for an attacker."
Incident Response → "An alert/incident happened. Handle it."
```

---

# 4. Threat Hunting Process

```text
Hypothesis → Collect Data → Search → Investigate → Validate → Create Detection → Respond
```

## 4.1 Step 1 — Create a Hypothesis

A **hypothesis** is an assumption about possible attacker behavior you want to test, e.g. _"An attacker may be using PowerShell to execute malicious commands on Windows endpoints"_ or _"An attacker may have obtained VPN credentials and is logging in from unusual locations."_

## 4.2 Step 2 — Collect Data

Sources: SIEM logs, EDR telemetry, firewall logs, authentication logs, DNS logs, VPN logs, web logs, process logs, network traffic, IDS alerts.

## 4.3 Step 3 — Search

Search the collected data for patterns matching the hypothesis.

## 4.4 Step 4 — Investigate

Ask: Is this normal user behavior? Which host/account is involved? Where did it originate? What happened before/after? Is another system involved?

## 4.5 Step 5 — Validate

Confirm whether the suspicious activity is actually malicious.

```text
Suspicious behavior → Authorized admin activity → Benign
Suspicious behavior → Malicious command → Threat Confirmed
```

## 4.6 Step 6 — Create Detection

If the hunt finds a real malicious pattern, turn it into an automated detection rule so it's caught automatically next time.
**Example:** Hunter finds `PowerShell + Encoded command + Connection to malicious IP` → creates rule: `IF encoded PowerShell AND suspicious outbound connection THEN generate alert`. This converts human knowledge into automated monitoring.

## 4.7 Step 7 — Respond

If an active threat is confirmed, threat hunting flows directly into **Incident Response**:

```text
Threat Found → Contain System → Remove Threat → Recover
```

---

# 5. Indicators: IOC vs IOA

## 5.1 Indicators in Threat Hunting

Hunters search for indicators such as: suspicious IP address, malicious domain, file hash, unusual process, abnormal login, unexpected network connection, new user account, suspicious scheduled task, large data transfer.

## 5.2 IOC — Indicator of Compromise

Evidence that a system **may have already been compromised** — e.g. malicious IP, known malware hash, suspicious domain, malicious filename, attacker email address.

```text
Known Malicious IP 203.0.113.50 → Server connects to it → Possible compromise
```

## 5.3 IOA — Indicator of Attack

Focuses on **attacker behavior**, not just artifacts — e.g. `PowerShell → Downloads executable → Creates persistence`. This behavior may be suspicious even if the file hash has never been seen before.

## 5.4 IOC vs IOA

| IOC                           | IOA                                    |
| ----------------------------- | -------------------------------------- |
| Evidence of compromise        | Evidence of attacker behavior          |
| Often artifact based          | Behavior based                         |
| Malicious hash/IP/domain      | Suspicious process/activity            |
| Often useful after compromise | Can help detect attack **in progress** |

---

# 6. MITRE ATT&CK Basics

## 6.1 What is MITRE ATT&CK?

**MITRE ATT&CK** = **Adversarial Tactics, Techniques, and Common Knowledge**. It's a knowledge base describing real-world attacker behavior — helping teams understand what attackers are trying to achieve, which techniques they use, how attacks progress, and what detections are needed.

> **Simple Definition:** MITRE ATT&CK is a framework that organizes real attacker behaviors into tactics and techniques.

## 6.2 Why MITRE ATT&CK is Used

Useful for: threat hunting, SIEM detection creation, incident investigation, red-team exercises, detection gap analysis, mapping attacks, SOC training.

```text
Attack Activity → Map to MITRE ATT&CK → Understand Tactic → Identify Technique → Create Detection
```

## 6.3 Tactics, Techniques & Procedures (TTPs)

| Term          | Question     | Meaning                                |
| ------------- | ------------ | -------------------------------------- |
| **Tactic**    | Why?         | The attacker's objective               |
| **Technique** | How?         | The method used to achieve the tactic  |
| **Procedure** | Exactly how? | The specific real-world implementation |

**Example:**

```text
Tactic: Credential Access → Technique: OS Credential Dumping
Tactic: Initial Access → Technique: Phishing
Tactic: Execution → Technique: Command and Scripting Interpreter → Procedure: attacker uses PowerShell with a specific malicious command
```

```text
Tactic    → Why?
Technique → How?
Procedure → Exactly how in this attack?
```

Together, these are known as **TTPs**.

---

# 7. The 12 MITRE ATT&CK Tactics

| Tactic                       | Meaning                                                | Example                                                                                |
| ---------------------------- | ------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| **Initial Access**           | How the attacker first gets in                         | Phishing, exploiting a public-facing app, stolen credentials, external remote services |
| **Execution**                | Running malicious code/commands                        | PowerShell, shell commands, scripts, malicious binaries                                |
| **Persistence**              | Keeping access after reboot/logout/credential change   | Scheduled tasks, startup entries, new user account, malicious service                  |
| **Privilege Escalation**     | Gaining higher privileges                              | Normal User → Exploit/Misconfig → Administrator/Root                                   |
| **Defense Evasion**          | Avoiding security controls and detection               | Disable antivirus, delete logs, hide files, obfuscate commands                         |
| **Credential Access**        | Stealing usernames/passwords/hashes/tokens             | Password dumping, keylogging, browser credential theft                                 |
| **Discovery**                | Learning about the environment                         | Hosts, users, domain info, network config, running services, shares                    |
| **Lateral Movement**         | Moving from one compromised system to another          | Compromised PC → Server 1 → Server 2 → Database                                        |
| **Collection**               | Gathering data the attacker wants                      | Documents, DB records, emails, screenshots, credentials                                |
| **Command and Control (C2)** | Communication between attacker and compromised systems | Send commands, download malware, receive stolen data                                   |
| **Exfiltration**             | Stealing data out of the organization                  | Via HTTPS, cloud storage, DNS, email, file transfer                                    |
| **Impact**                   | Disrupting/damaging systems, data, or operations       | Ransomware encryption, data destruction, service shutdown, DDoS                        |

### Example Attack Mapped to ATT&CK Tactics

```text
Phishing Email → Initial Access
Malicious PowerShell → Execution
Scheduled Task → Persistence
Administrator Rights → Privilege Escalation
Password Dumping → Credential Access
Network Scanning → Discovery
Move to File Server → Lateral Movement
Collect Documents → Collection
Connect to C2 → Command and Control
Upload Data → Exfiltration
```

This full chain shows how MITRE ATT&CK maps attacker behavior across an entire intrusion, start to finish.

---

# 8. How It All Fits Together

## 8.1 Threat Hunting with MITRE ATT&CK

ATT&CK helps hunters create hypotheses:

```text
Tactic: Credential Access → Hypothesis: "An attacker may be attempting to dump credentials from privileged systems"
→ Hunt: search suspicious processes, security tool alerts, access to credential stores, unexpected privilege use
→ Investigate → Detection Rule
```

## 8.2 SIEM + Threat Hunting + MITRE ATT&CK

```text
MITRE ATT&CK (known attacker behavior) → Threat-Hunting Hypothesis → Search SIEM/EDR Data
→ Suspicious Behavior Found → Create Detection Rule → Future SIEM Alert
```

## 8.3 Incident Response vs Threat Hunting

| Incident Response                      | Threat Hunting                      |
| -------------------------------------- | ----------------------------------- |
| Usually reactive                       | Proactive                           |
| Begins with an incident/alert          | Begins with a hypothesis            |
| Handles a confirmed/suspected incident | Searches for hidden threats         |
| Containment is the priority            | Detection discovery is the priority |
| Removes active threats                 | Finds threats tools may have missed |

```text
Incident Response → Handle a known problem.
Threat Hunting     → Search for a hidden problem.
```

## 8.4 Threat Hunting vs SIEM Monitoring

```text
SIEM Monitoring: Detection Rule → Alert → SOC
Threat Hunting:  Hypothesis → Search Existing Data → Find Something Suspicious
```

Threat hunting often helps **create new SIEM detections** — the two feed each other.

---




# 12. Quick Revision

## 12.1 Incident Response

```text
Preparation     → Be ready before attack.
Identification  → Confirm what happened.
Containment     → Stop attack from spreading.
Eradication     → Remove attacker/root cause.
Recovery        → Restore systems safely.
Lessons Learned → Improve security after incident.
```

## 12.2 Threat Hunting

```text
Threat Hunting  → Proactively search for hidden threats.
Hypothesis      → What attacker behavior might exist?
Collect Data    → Logs, EDR, network, VPN, authentication.
Search          → Look for suspicious behavior.
Investigate     → Understand what happened.
Validate        → Confirm malicious or legitimate.
Create Detection→ Detect the behavior automatically next time.
Respond         → Contain/remove confirmed threat.
```

## 12.3 MITRE ATT&CK Tactics

| Tactic               | Easy Meaning                      |
| -------------------- | --------------------------------- |
| Initial Access       | Get inside                        |
| Execution            | Run code                          |
| Persistence          | Stay inside                       |
| Privilege Escalation | Gain higher permissions           |
| Defense Evasion      | Avoid detection                   |
| Credential Access    | Steal credentials                 |
| Discovery            | Learn the environment             |
| Lateral Movement     | Move to other systems             |
| Collection           | Gather target data                |
| Command and Control  | Communicate with compromised host |
| Exfiltration         | Steal data out                    |
| Impact               | Damage/disrupt systems            |

---

# 13. Best Memory Flows

```text
Incident Response:
Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned

Threat Hunting:
Hypothesis → Collect Data → Search → Investigate → Validate → Create Detection → Respond

MITRE ATT&CK:
Tactic → WHY the attacker is doing something
Technique → HOW the attacker does it
Procedure → EXACTLY HOW it was implemented in this specific attack
```

> **Most important interview connection:** Threat hunting uses attacker behavior, often mapped to MITRE ATT&CK, to proactively search for hidden threats. If a real compromise is found, the process moves into Incident Response: identify, contain, eradicate, recover, and learn from the incident.
