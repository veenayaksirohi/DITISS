# Web Application Security — Session 9 & 10 Notes

### Session 9 (2T) — Theory
Types of Hacker Classes · Red Team, Blue Team, Grey Team · Ethical Hackers and Crackers · Goals of Attackers · Security, Functionality, and Ease of Use Triangle · Skills Required to Become an Ethical Hacker

### Session 10 (2T+3L) — Theory
Introduction to Ethical Hacking · Creating a Security Evaluation Plan · Types of Ethical Hacks · Footprinting and Social Engineering · Traceroute in Footprinting · Port Scanning, Network Scanning, and Vulnerability Scanning · Scanning Methodologies (SYN, Stealth, XMAS, etc.)

---

# SESSION 9

## 1. Types of Hacker Classes

Hackers are categorized based on intent, authorization, skill level, and motivation. Understanding these distinctions is important in cybersecurity for threat modeling and defense planning.

**Black Hat Hackers**
- Individuals who exploit systems without authorization for malicious purposes.
- Goals include financial gain, data theft, service disruption, or creating fear.
- Common activities: ransomware attacks, phishing campaigns, botnet creation, data breaches.
- Tools: custom malware, exploit kits, zero-day vulnerabilities.
- *Example*: a hacker deploying ransomware on a company's servers to demand payment.

**White Hat Hackers (Ethical Hackers)**
- Authorized professionals who legally test systems to identify and fix vulnerabilities.
- Work under contracts or bug bounty programs, following legal frameworks and ethical guidelines.
- Activities: penetration testing, vulnerability assessments, security audits.
- Tools: Nmap, Burp Suite, Metasploit, Wireshark.
- *Example*: a penetration tester identifying SQL injection flaws in a web application.

**Gray Hat Hackers**
- Operate between ethical and unethical boundaries.
- May hack systems without permission, but not for malicious purposes.
- Often disclose vulnerabilities to organizations, sometimes expecting recognition or reward.
- Legal risk exists even if intent is not harmful.
- *Example*: discovering a security flaw in a website and reporting it publicly without authorization.

**Script Kiddies**
- Beginners or unskilled individuals who rely on pre-built tools and scripts.
- Lack deep understanding of underlying systems or exploits; motivated by curiosity, recognition, or mischief.
- Can still cause damage due to misuse of powerful tools.
- *Example*: using a downloaded DDoS tool to attack a game server.

**Hacktivists**
- Hackers driven by political, ideological, or social causes.
- Aim to promote agendas or protest against organizations/governments.
- Activities: website defacement, data leaks, DDoS attacks.
- *Example*: leaking confidential government data to expose corruption.

**State-Sponsored Hackers**
- Highly skilled hackers backed by government agencies.
- Conduct cyber espionage, intelligence gathering, or cyber warfare.
- Targets include critical infrastructure, defense systems, and foreign governments.
- Use advanced persistent threats (APTs) and zero-day exploits.
- *Example*: attacks on power grids or surveillance of foreign diplomatic communications.

**Quick Concept Mapping**

| Type | Summary |
|---|---|
| Black Hat | Malicious attacker |
| White Hat | Ethical security tester |
| Gray Hat | Unauthorized but non-malicious |
| Script Kiddie | Low-skill tool user |
| Hacktivist | Ideology-driven attacker |
| State-Sponsored | Government-backed cyber warfare |

---

## 2. Red Team, Blue Team, and Grey (Purple) Team

These roles are used in cybersecurity operations and simulated attack-defense exercises.

**Red Team (Offensive Security)**
- Simulates real-world attackers to test system defenses; focuses on identifying vulnerabilities before malicious actors do.
- Techniques: penetration testing; social engineering (phishing, impersonation); exploit development.
- *Goal*: break into systems undetected and demonstrate impact.
- *Example*: attempting to gain access to a corporate network using phishing emails.

**Blue Team (Defensive Security)**
- Responsible for protecting systems against attacks; focuses on detection, prevention, and response.
- Key responsibilities: monitoring logs (SIEM tools like Splunk); intrusion detection/prevention (IDS/IPS); incident response and forensics; patch management and hardening.
- *Goal*: detect and stop attacks in real time.
- *Example*: detecting unusual login patterns and blocking suspicious IPs.

**Grey Team (Purple Team Concept)**
- Acts as a bridge between Red and Blue teams, focusing on collaboration and improvement rather than just competition.
- Activities: sharing attack insights with the Blue team; improving detection rules and defense strategies; running controlled simulations.
- *Goal*: enhance overall security posture through feedback loops.
- *Example*: after a Red Team attack, helping the Blue Team tune detection systems.

**Quick Concept Mapping**: Red Team → Attack · Blue Team → Defend · Grey/Purple Team → Improve both.

---

## 3. Ethical Hackers vs. Crackers

**Ethical Hackers**
- Professionals who legally and responsibly test systems for vulnerabilities.
- Always work with proper authorization (contracts, bug bounty programs).
- Follow ethical guidelines such as responsible disclosure.
- Focus on improving security posture, not exploiting it for personal gain.
- Typical roles: penetration tester, security analyst, red teamer.
- *Example*: conducting a vulnerability assessment on a company's network and reporting findings.

**Crackers**
- Malicious individuals who break into systems without permission.
- Intent is harmful: theft, destruction, or disruption.
- Often associated with illegal activities such as piracy, password cracking, or malware deployment.
- Do not follow any ethical or legal standards.
- *Example*: breaking into a database to steal user credentials and sell them on the dark web.

---

## 4. Goals of Attackers

Attack motivations vary based on target and intent:

- **Financial Gain** — stealing banking data, credit card details, deploying ransomware, cryptocurrency mining malware.
- **Espionage** — targeting government or corporate systems to extract confidential information, trade secrets, or defense data.
- **Disruption** — causing downtime using DoS/DDoS attacks, damaging infrastructure, or sabotaging services.
- **Reputation Damage** — website defacement, data leaks, exposing sensitive internal communications.
- **Political or Ideological Motives** — hacktivism campaigns aimed at influencing public opinion or disrupting opponents.
- **Thrill or Challenge** — attacks driven by curiosity, ego, or the desire to prove technical skills.

*Example*: a ransomware attack on a hospital combines financial gain (ransom demand) and disruption (service outage).

---

## 5. Security, Functionality, and Ease of Use Triangle

This model highlights the trade-off in system design among three key aspects:

- **Security** — protection against unauthorized access, data breaches, and attacks.
- **Functionality** — features and services offered to users.
- **Ease of Use** — user-friendliness and accessibility of the system.

**Trade-off Explanation**:
- Increasing security (e.g., multi-factor authentication, strict access control) may reduce ease of use.
- Enhancing functionality (more features, APIs) can introduce new vulnerabilities.
- Improving ease of use (simple passwords, fewer restrictions) can weaken security.

**Practical Example — a Banking App**:
- High security: MFA, biometric login → slightly less convenient.
- High usability: simple login → may risk weak authentication.
- Balance: biometric + OTP → acceptable usability with strong security.

The goal is to achieve an optimal balance based on system requirements and risk tolerance.

---

## 6. Skills Required to Become an Ethical Hacker

A strong ethical hacker combines deep technical knowledge with analytical and communication abilities.

**Technical Skills**:
- **Networking Knowledge** — TCP/IP model, subnetting, routing, DNS, HTTP/HTTPS, VPNs.
- **Operating Systems** — strong command over Linux (Kali, Ubuntu), Windows internals, basic Unix.
- **Programming and Scripting** — Python, Bash, PowerShell, basic C for exploit understanding.
- **Security Concepts** — cryptography, authentication, authorization, firewalls, IDS/IPS, zero trust models.
- **Vulnerability Assessment** — scanning and enumeration using tools like Nmap, OpenVAS, Nikto.
- **Penetration Testing** — exploiting vulnerabilities using frameworks like Metasploit, Burp Suite.
- **Web Security** — OWASP Top 10 (SQL injection, XSS, CSRF, etc.).

**Analytical and Practical Skills**:
- **Problem Solving** — thinking like an attacker to identify weak points.
- **Reverse Engineering Basics** — understanding binaries and malware behavior (intro level).
- **Social Engineering Awareness** — phishing, pretexting, human manipulation tactics.

**Soft Skills**:
- **Communication** — writing clear reports, explaining risks to non-technical stakeholders.
- **Documentation** — maintaining detailed logs of testing processes and findings.
- **Team Collaboration** — working with blue teams and developers.

**Legal and Ethical Awareness**:
- Knowledge of cybersecurity laws (IT Act, GDPR basics).
- Understanding scope and boundaries of testing.
- Following responsible disclosure policies.

---

# SESSION 10

## 1. Introduction to Ethical Hacking

Ethical hacking is the authorized and legal practice of testing computer systems, networks, or applications to identify security vulnerabilities before malicious attackers can exploit them. Ethical hackers simulate real-world attacks using the same tools and techniques as cybercriminals, but their goal is to improve security and protect assets.

### 1.1 Definition and Core Idea
- Ethical hacking involves bypassing security controls with permission to evaluate system strength.
- Also known as **penetration testing** or **white-hat hacking**.
- Conducted under a defined scope, rules of engagement, and legal agreement.
- Focus is on proactive defense, not reactive response.

### 1.2 Objectives of Ethical Hacking
- Identify vulnerabilities in systems, networks, and applications.
- Assess the impact of potential attacks.
- Strengthen security controls and reduce risk.
- Ensure compliance with security standards (ISO 27001, PCI-DSS, etc.).
- Protect sensitive data such as financial records, credentials, and personal information.

### 1.3 Key Principles
- **Authorization** — always performed with proper written permission.
- **Confidentiality** — sensitive findings must not be disclosed publicly.
- **Integrity** — testing should not harm systems or data.
- **Responsible Disclosure** — report vulnerabilities to the organization for fixing.
- **Non-malicious Intent** — no exploitation for personal gain.

### 1.4 Phases of Ethical Hacking (Hacking Lifecycle)

> The detailed mechanics of each phase — footprinting techniques, scanning methodologies, and specific tools — are covered in full in Sections 4 and 5 below. This is the high-level lifecycle overview.

1. **Reconnaissance (Information Gathering)** — collect information about the target (IP ranges, DNS records, employee details). Passive (no direct interaction) or Active (direct probing). Tools: WHOIS, nslookup, Maltego.
2. **Scanning and Enumeration** — identify live systems, open ports, services, and vulnerabilities. Tools: Nmap, Nessus, OpenVAS.
3. **Gaining Access (Exploitation)** — exploit vulnerabilities to enter the system. Techniques: SQL injection, password attacks, buffer overflow. Tools: Metasploit, Burp Suite.
4. **Maintaining Access** — ensure persistent access for further testing. Methods: backdoors, trojans (used ethically in controlled environments).
5. **Covering Tracks** (in real attacks) — ethical hackers usually document instead of hiding activity, but simulate attacker behavior to understand it.

### 1.5 Types of Ethical Hacking (by Target Area)
- **Network Hacking** — testing routers, switches, firewalls.
- **Web Application Hacking** — finding vulnerabilities in websites (OWASP Top 10).
- **System Hacking** — exploiting OS-level vulnerabilities.
- **Wireless Network Hacking** — testing Wi-Fi security (WPA/WPA2).
- **Social Engineering** — testing human vulnerabilities (phishing simulations).

### 1.6 Tools Used in Ethical Hacking
- **Reconnaissance**: Maltego, Recon-ng.
- **Scanning**: Nmap, Wireshark.
- **Exploitation**: Metasploit Framework.
- **Web Testing**: Burp Suite, OWASP ZAP.
- **Password Attacks**: Hydra, John the Ripper.

*Example*: an ethical hacker uses Nmap to scan a server, finds an open port running an outdated service, and then uses Metasploit to safely demonstrate how it could be exploited.

### 1.7 Importance of Ethical Hacking
- Prevents data breaches and cyberattacks.
- Protects organizational reputation and customer trust.
- Helps meet regulatory compliance.
- Reduces financial losses due to cyber incidents.
- Strengthens overall cybersecurity posture.

### 1.8 Real-World Scenario

A company hires an ethical hacker to test its web application. The hacker discovers an SQL injection vulnerability in the login form. Instead of exploiting it maliciously, they report it to the company, which then patches the issue before attackers can use it.

---

## 2. Creating a Security Evaluation Plan

A **Security Evaluation Plan (SEP)** is a formal document prepared before conducting ethical hacking or penetration testing. It defines how testing will be carried out in a controlled, legal, and structured manner, minimizing risk to business operations.

### 2.1 Purpose of the Plan
- Ensure all testing activities are authorized and within legal boundaries.
- Prevent accidental damage to systems or data.
- Clearly define responsibilities, expectations, and deliverables.
- Provide a systematic approach to identifying vulnerabilities.

### 2.2 Key Components

**Scope of Testing**
- Defines what systems, networks, and applications are included.
- Specifies targets such as IP ranges, domains, servers, APIs, or applications.
- Also defines out-of-scope assets to avoid unintended impact.
- *Example*: testing only web servers in a specific subnet, excluding production databases.

**Rules of Engagement (RoE)**
- Guidelines on how testing should be conducted.
- Defines allowed and restricted techniques.
- Specifies whether actions like social engineering, DoS testing, or password attacks are permitted.
- Includes escalation procedures if critical vulnerabilities are found.
- *Example*: no denial-of-service attacks allowed during business hours.

**Timeframes**
- Defines the testing schedule and duration, including start/end dates and testing windows (e.g., off-peak hours).
- Helps reduce disruption to normal operations.
- *Example*: testing allowed only between 10 PM and 4 AM.

**Reporting Requirements**
- Specifies how findings should be documented and communicated.
- Includes format of reports (technical + executive summary).
- Defines severity levels (Critical, High, Medium, Low).
- Includes timelines for reporting vulnerabilities.
- *Example*: critical vulnerabilities must be reported within 24 hours.

**Legal Authorization**
- Written permission (often called a "permission letter" or contract).
- Protects both the tester and organization legally.
- Clearly states that activities are authorized.

### 2.3 Importance of a Security Evaluation Plan
- Prevents legal issues and misunderstandings.
- Ensures safe and non-disruptive testing.
- Improves efficiency and clarity during assessment.
- Aligns testing with business objectives and risk tolerance.

---

## 3. Types of Ethical Hacks (Testing Approaches)

These approaches define how much knowledge the tester has before starting.

**Black Box Testing**
- Tester has no prior knowledge of the system.
- Simulates an external attacker (real-world scenario).
- Focuses on discovering vulnerabilities from scratch.
- Time-consuming but realistic.
- *Example*: testing a public website without any internal details.

**White Box Testing**
- Tester has complete knowledge of the system.
- Includes access to source code, architecture diagrams, credentials.
- Simulates insider threats or full security audits.
- More thorough and efficient.
- *Example*: reviewing application code for vulnerabilities like SQL injection.

**Gray Box Testing**
- Tester has partial knowledge of the system.
- Combines aspects of both black and white box testing.
- Balances realism and efficiency.
- Common in real-world penetration testing.
- *Example*: tester has user-level credentials but not admin access.

### 3.1 Practical Example

A company wants to test its internal web application:
1. Creates a Security Evaluation Plan defining scope (web app only).
2. Allows gray box testing with limited credentials.
3. Sets testing time during weekends.
4. Requires a detailed vulnerability report.

The ethical hacker follows this plan, identifies security flaws, and reports them without disrupting services.

---

## 4. Footprinting and Social Engineering

These are **reconnaissance techniques** used in the early stages of ethical hacking to gather information about a target before launching attacks.

### 4.1 Footprinting

Footprinting is the process of collecting as much information as possible about a target system, network, or organization using publicly available resources. It helps ethical hackers understand the target's infrastructure, identify potential entry points, and plan further testing.

**Objectives of Footprinting**:
- Identify IP addresses and domain names.
- Map network topology and infrastructure.
- Discover employee details and organizational structure.
- Find email addresses, phone numbers, and physical locations.
- Determine technologies used (OS, web servers, applications).

**Passive Footprinting**
- Collects information without directly interacting with the target; does not trigger intrusion detection systems (IDS).
- Methods: search engines (Google dorking); WHOIS lookup for domain registration details; social media and employee profiles; Archive.org for historical website data; job postings revealing technologies used.
- *Example*: using WHOIS to find domain owner information for a company.

**Active Footprinting**
- Involves direct interaction with the target systems; may trigger IDS or security alerts.
- Methods: ping sweeps to identify live hosts; DNS enumeration; traceroute to map network paths; port scanning (basic level).
- *Example*: running traceroute to discover intermediate routers between you and the target.

**Common Footprinting Tools**:
- **WHOIS** — domain registration information.
- **nslookup / dig** — DNS record queries (A, MX, NS records).
- **Maltego** — automated OSINT (Open Source Intelligence) gathering.
- **Google Dorks** — advanced search queries to find sensitive info.
- **Shodan** — search engine for internet-connected devices.

*Example*: an ethical hacker uses WHOIS to find that a company's domain is registered to a specific IP range, then uses nslookup to enumerate DNS records and identify mail servers.

### 4.2 Social Engineering

Social engineering is the art of manipulating people to reveal confidential information or perform actions that compromise security. It exploits human psychology rather than technical vulnerabilities.

**Why Social Engineering Works**:
- People tend to trust authority figures.
- Urgency or fear can override caution.
- Lack of security awareness training.
- Desire to be helpful or avoid conflict.

**Common Techniques**:
- **Phishing** — sending fraudulent emails appearing to be from legitimate sources to trick users into clicking malicious links or revealing credentials. *Example*: an email pretending to be from the IT department asking for a password reset.
- **Pretexting** — creating a fabricated scenario to obtain information, with the attacker pretending to be someone else (tech support, auditor, employee). *Example*: calling the helpdesk pretending to be an employee who forgot their password.
- **Baiting** — offering something enticing to lure victims. *Example*: leaving infected USB drives labeled "Salary Details" in public areas.
- **Quid Pro Quo** — offering a service or benefit in exchange for information. *Example*: pretending to be technical support offering to fix a problem in exchange for credentials.
- **Tailgating** — physically following authorized personnel into restricted areas. *Example*: walking behind an employee through a secure door without a badge.

**Defense Against Social Engineering**:
- Security awareness training for employees.
- Verification procedures for sensitive requests.
- Multi-factor authentication.
- Clear policies on information sharing.
- Regular phishing simulations.

### 4.3 Traceroute in Footprinting

Traceroute is a network diagnostic tool that maps the path packets take from source to destination. It reveals intermediate devices (routers, firewalls) and helps understand network topology.

**How Traceroute Works**:
- Uses the **TTL (Time To Live)** field in IP packets.
- Sends packets with incrementally increasing TTL values.
- Each router that receives a packet with TTL=0 sends back an ICMP "Time Exceeded" message.
- By analyzing these responses, traceroute identifies each hop along the path.
- Records response time (latency) for each hop.

**Command Syntax**:
- **Linux/Mac**: `traceroute <target_ip_or_domain>`
- **Windows**: `tracert <target_ip_or_domain>`

Example:
```bash
traceroute google.com
```
Output shows: hop number; IP address of each router; round-trip time (RTT) for packets.

**Uses in Footprinting**:
- **Network Mapping** — identifies routers and network structure between you and the target.
- **Geolocation** — can estimate physical location of intermediate hops.
- **Firewall Detection** — shows where packets are being blocked.
- **ISP Identification** — reveals which ISPs the target uses.
- **Latency Analysis** — identifies network bottlenecks.

**Example Output Interpretation**:
```
1  192.168.1.1  2ms  1ms  1ms     (Your local router)
2  10.0.0.1     5ms  4ms  6ms     (ISP gateway)
3  203.0.113.5  15ms 14ms 16ms    (Intermediate router)
4  * * *                         (Firewall blocking ICMP)
5  142.250.1.1  30ms 29ms 31ms    (Target server)
```

**Limitations**:
- Some routers block ICMP/traceroute packets (shown as `* * *`).
- May not show accurate paths in complex networks.
- Can be rate-limited by ISPs.

**Practical Footprinting Scenario**: an ethical hacker runs traceroute on a target domain, discovers the target uses a specific ISP, identifies a firewall at hop 4, maps the network path for further analysis, and uses this information to plan scanning and penetration testing.

### 4.4 Real-World Application

**Scenario**: testing a company's external security.
1. **Footprinting** — use WHOIS to find domain IP, nslookup for DNS records, Google search for employee info.
2. **Traceroute** — map network path to identify infrastructure.
3. **Social Engineering** — send phishing emails to test employee awareness.
4. **Result** — comprehensive understanding of the target's security posture.

---

## 5. Port Scanning, Network Scanning, and Vulnerability Scanning

Scanning is a critical phase in ethical hacking that follows footprinting. It involves actively probing systems and networks to identify live hosts, open ports, services, and vulnerabilities.

### 5.1 Port Scanning

Port scanning identifies open ports on a target system that can serve as entry points for attacks. Each port corresponds to a specific service or application.

**Purpose**: identify running services (HTTP, SSH, FTP, etc.); discover potential vulnerabilities associated with open ports; map the attack surface of a target.

**Common Tools**: **Nmap** (most popular port scanner); **Netcat** (versatile networking tool); **Masscan** (high-speed port scanner).

Example command:
```bash
nmap -sS 192.168.1.1
```
This performs a SYN scan on the target IP.

**Common Ports**: 21 (FTP); 22 (SSH); 23 (Telnet); 80 (HTTP); 443 (HTTPS); 3389 (RDP).

### 5.2 Network Scanning

Network scanning discovers active devices on a network and maps the network topology.

**Purpose**: identify live hosts (IP addresses); determine operating systems; discover network structure (subnets, gateways); find unauthorized devices.

**Techniques**: **Ping Sweep** (sends ICMP echo requests to multiple IPs); **ARP Scanning** (identifies devices on the local network using ARP requests); **SNMP Scanning** (queries SNMP-enabled devices for information).

Example command:
```bash
nmap -sn 192.168.1.0/24
```
This performs a ping sweep on the entire subnet.

### 5.3 Vulnerability Scanning

Vulnerability scanning automatically detects security weaknesses in systems, networks, or applications.

**Purpose**: identify known vulnerabilities (CVEs); check for missing patches; detect misconfigurations; prioritize remediation efforts.

**Common Tools**: **OpenVAS** (open-source vulnerability scanner); **Nessus** (commercial vulnerability scanner); **Qualys** (cloud-based scanning platform); **Nikto** (web server vulnerability scanner).

*Example*: running OpenVAS on a network to find systems with outdated software or unpatched vulnerabilities.

### 5.4 Scanning Methodologies

**Active Scanning**
- Directly interacts with the target system, sending packets to probe ports, services, or vulnerabilities.
- More accurate but more easily detected by IDS/firewalls.
- Examples: port scanning, vulnerability scanning, ping sweeps.

**Passive Scanning**
- Observes network traffic without direct interaction; does not send packets to the target.
- Harder to detect but less comprehensive.
- Methods: sniffing network traffic (Wireshark); analyzing logs; monitoring DNS queries.

**Stealth Scanning**
- Designed to avoid detection by firewalls or IDS.
- Uses techniques like incomplete connections or fragmented packets.
- Slower but reduces the risk of being logged.
- Examples: SYN scan, FIN scan, NULL scan.

### 5.5 Common Scan Types

**SYN Scan (Half-Open Scan)**
- Sends a SYN packet to initiate the TCP handshake; if the target responds with SYN-ACK, the port is open.
- The scanner sends RST to terminate the connection without completing the handshake.
- *Advantages*: fast, less likely to be logged.
- Nmap command: `nmap -sS <target>`

**Stealth Scan** — a general term for scans designed to evade detection, often using partial connections or unusual flag combinations. Includes SYN, FIN, NULL, and XMAS scans.

**XMAS Scan**
- Sends packets with **FIN, URG, and PSH** flags set (like "decorating a Christmas tree").
- If the port is closed, the target responds with RST; if open, the target may ignore the packet.
- *Use*: works on some systems to identify open/closed ports.
- Nmap command: `nmap -sX <target>`

**NULL Scan**
- Sends packets with **no flags set**.
- Closed ports respond with RST; open ports may not respond.
- Effective on some Unix-like systems.
- Nmap command: `nmap -sN <target>`

**IDLE Scan (Zombie Scan)**
- Uses a third-party "zombie" host to send packets, hiding the attacker's real IP address.
- Exploits idle hosts to perform blind scanning.
- Advanced technique, harder to trace.
- Nmap command: `nmap -sI <zombie_host> <target>`

**FIN Scan**
- Sends packets with **only the FIN flag** set.
- Similar to NULL scan in behavior; closed ports respond with RST, open ports may not respond.
- Nmap command: `nmap -sF <target>`

### 5.6 Scan Type Comparison Table

| Scan Type | Flags Used | Detection Risk | Effectiveness | Use Case |
|---|---|---|---|---|
| SYN | SYN | Low | High | General port scanning |
| XMAS | FIN, URG, PSH | Low | Medium (system-dependent) | Stealthy scanning |
| NULL | None | Low | Medium (Unix systems) | Avoiding detection |
| FIN | FIN | Low | Medium | Probing without full scan |
| IDLE | Via zombie host | Very Low | High (complex setup) | Hiding attacker identity |

### 5.7 Practical Example

An ethical hacker performs scanning on a target network:
1. **Network Scan**: `nmap -sn 192.168.1.0/24` → finds 10 live hosts.
2. **Port Scan**: `nmap -sS 192.168.1.5` → discovers open ports 22 (SSH), 80 (HTTP).
3. **Vulnerability Scan**: runs OpenVAS on the target → finds outdated Apache version with a known exploit.
4. **Stealth Scan**: uses `nmap -sF` to avoid IDS detection during testing.

### 5.8 Defense Against Scanning
- **Firewalls** — block unauthorized scan attempts.
- **IDS/IPS** — detect and alert on scanning activity.
- **Port Filtering** — close unnecessary ports.
- **Rate Limiting** — slow down scanning attempts.
- **Network Segmentation** — limit lateral movement.
