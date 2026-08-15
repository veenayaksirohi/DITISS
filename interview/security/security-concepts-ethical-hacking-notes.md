# Security Concepts (Application Security & Ethical Hacking) — CDAC DITISS Syllabus

## Topics, Interview Priority & Important Tools/Attacks

---

## 🔴 PRIORITY 1 — MUST KNOW (Most Asked in Interviews)

### 1. OWASP Top 10 (2021) ✅

- Broken Access Control, Cryptographic Failures, Injection, Insecure Design
- Security Misconfiguration, Vulnerable & Outdated Components
- Identification & Authentication Failures, Software/Data Integrity Failures
- Security Logging & Monitoring Failures, SSRF
- Difference from OWASP 2017 list (know the reshuffled categories)

### 2. SQL Injection & XSS ✅

- SQL Injection types: Error-based, Union-based, Blind (time-based/boolean-based)
- Authentication bypass via SQLi (`' OR '1'='1`)
- Cross-Site Scripting types: Reflected, Stored, DOM-based
- Injection in stored procedures
- Real-world case: Heartland Payment Systems breach

### 3. Ethical Hacking Phases ✅

- 5 Phases: Reconnaissance → Scanning → Gaining Access → Maintaining Access → Covering Tracks
- Footprinting & Social Engineering
- Types of hacking: Black hat, White hat, Grey hat
- Red Team vs Blue Team vs Purple Team
- Security, Functionality, Ease-of-Use Triangle

### 4. Scanning Techniques ✅

- Port Scanning vs Network Scanning vs Vulnerability Scanning
- Scan types: SYN (half-open), Stealth, XMAS, NULL, IDLE, FIN
- TCP Flags: SYN, ACK, FIN, RST, PSH, URG
- Banner Grabbing & OS Fingerprinting
- Tools: NMAP, WHOIS, Netcraft, Shodan, Google Dorks, Recon-Ng

### 5. Sniffing & MITM Attacks ✅

- Active vs Passive Sniffing
- ARP Poisoning — how it enables MITM
- MAC Flooding — CAM table overflow attack
- DNS Spoofing / DNS Hacking
- Sniffing countermeasures — encryption (TLS), static ARP, port security

### 6. DoS/DDoS & Session Hijacking ✅

- DoS vs DDoS — single source vs distributed/botnet
- Attack types: Smurf Attack, SYN Flooding, Ping of Death
- Botnets — how BOTs/BOTNETs work
- Session Hijacking — spoofing vs hijacking, steps involved, prevention
- Real-world case: Mirai Botnet attack on Dyn

### 7. Malware Types ✅

- Virus vs Worm vs Trojan — key differences (self-replication, host dependency)
- Trojan types: Reverse-connecting, Netcat Trojan
- Overt vs Covert channels
- Static vs Dynamic Malware Analysis
- Antivirus evasion techniques

### 8. SAST vs DAST ✅

- SAST (Static Application Security Testing) — analyzes source code, no execution needed
- DAST (Dynamic Application Security Testing) — tests running application, black-box approach
- Tools: Checkmarx, Fortify (SAST); OWASP ZAP, Burp Suite (DAST)
- When to use SAST vs DAST in SDLC (shift-left security)

---

## 🟠 PRIORITY 2 — IMPORTANT (Frequently Asked)

### 9. Burp Suite ✅

- Proxy — intercepting browser traffic
- Spider — crawling/mapping the attack surface
- Intruder — automated attack/fuzzing tool
- Repeater — manually resend & modify requests
- Scanner — automated vulnerability detection

### 10. Password Cracking ✅

- Online (Active/Passive) vs Offline attacks
- Dictionary attack vs Brute-force attack vs Rainbow Table attack
- Tools: John the Ripper, Hydra, Hashcat
- Windows password cracking, SMB Relay/MITM attacks
- Password cracking countermeasures — salting, hashing, account lockout policies

### 11. IDS/IPS & Honeypots ✅

- IDS (Intrusion Detection) vs IPS (Intrusion Prevention) — detect vs block
- Signature-based vs Anomaly-based detection
- Honeypots — decoy systems to study attacker behavior
- Tools: SNORT, NAGIOS
- DMZ (Demilitarized Zone) — isolating public-facing servers

### 12. Penetration Testing ✅

- Methodology (PTES): Pre-engagement → Recon → Scanning → Exploitation → Post-exploitation → Reporting
- Black box vs White box vs Grey box testing
- Metasploit Framework — exploitation framework basics
- Physical Security factors in a pentest scope

### 13. Cyber Law & Cyber Crimes

- Indian IT Act / IPC relevance to cybercrime (hacking, fraud, mischief)
- Legal aspects of open communication, international law basics
- Classification of cyber crimes

---

## 🟡 PRIORITY 3 — GOOD TO KNOW (Asked in Advanced Rounds)

### 14. Wireless Hacking

- WEP vs WPA vs WPA2/WPA3 — cracking techniques and weaknesses
- SSID discovery, MAC spoofing
- Wireless sniffers
- Securing wireless networks — best practices

### 15. Web Server & Backdoor Attacks

- Web server hacking — misconfig exploitation
- Web-based password cracking
- Backdoor devices, Linux backdoors
- Biometric spoofing basics

### 16. HTTP Tunneling & Proxy-based Attacks

- Use of proxy servers in attacks (anonymity, bypass filters)
- HTTP tunneling techniques
- IP Spoofing techniques

---

## 📱 MOBILE SECURITY

### 17. Android Security Fundamentals ✅

- Android Architecture layers: Linux Kernel → HAL → Native Libraries/ART → Java API Framework → Apps
- Android file structure & APK build process
- Android Security Model — app sandboxing, permissions
- Device Rooting — risks and how malware exploits rooted devices

### 18. Android Pentesting Tools ✅

- ADB (Android Debug Bridge) — device interaction, shell access
- Frida — dynamic instrumentation/hooking
- APKTool / JADX — decompiling APKs, reverse engineering
- MobSF — static & dynamic Android app analysis

### 19. OWASP Top 10 Mobile & Attack Vectors

- Insecure Data Storage, Improper Platform Usage, Insecure Communication
- Smishing (SMS phishing)
- Network-based attacks (MITM on mobile), Wireshark packet sniffing
- Real-world mobile malware: Joker, EventBot

---

## 🌐 INTERVIEW SPECIAL — QUICK REFERENCE TABLES

### 📌 OWASP Top 10 (2021) — Full List

| Rank | Category |
|---|---|
| A01 | Broken Access Control |
| A02 | Cryptographic Failures |
| A03 | Injection |
| A04 | Insecure Design |
| A05 | Security Misconfiguration |
| A06 | Vulnerable and Outdated Components |
| A07 | Identification and Authentication Failures |
| A08 | Software and Data Integrity Failures |
| A09 | Security Logging and Monitoring Failures |
| A10 | Server-Side Request Forgery (SSRF) |

---

### 📌 Scan Types — TCP Flag Behavior

| Scan Type | Flags Sent | Response on Open Port | Response on Closed Port |
|---|---|---|---|
| SYN (Half-open) | SYN | SYN-ACK | RST |
| Stealth | SYN, no final ACK | SYN-ACK (then RST) | RST |
| XMAS | FIN, PSH, URG | No response | RST |
| NULL | No flags set | No response | RST |
| FIN | FIN | No response | RST |
| IDLE | Uses zombie host IPID | Indirect (IPID analysis) | Indirect |

---

### 📌 Malware Types — Quick Reference

| Type | Self-Replicates | Needs Host File | Description |
|---|---|---|---|
| Virus | Yes | Yes | Attaches to files, spreads via execution |
| Worm | Yes | No | Spreads independently over network |
| Trojan | No | No (disguised) | Appears legit, opens backdoor |
| Ransomware | Varies | Varies | Encrypts data, demands payment |
| Spyware/Keylogger | No | No | Covertly monitors/steals data |

---

### 📌 SAST vs DAST — Comparison

| Feature | SAST | DAST |
|---|---|---|
| Approach | White-box (source code) | Black-box (running app) |
| Stage in SDLC | Early (dev/build) | Later (staging/production-like) |
| Finds | Code-level flaws (insecure functions) | Runtime issues (auth, config) |
| Tools | Checkmarx, Fortify, SonarQube | OWASP ZAP, Burp Suite |
| Needs source code | Yes | No |

---

### 📌 Password Attack Types — Quick Reference

| Attack Type | Description | Tool Example |
|---|---|---|
| Dictionary | Tries wordlist of common passwords | John the Ripper, Hydra |
| Brute-force | Tries all possible combinations | Hydra, Hashcat |
| Rainbow Table | Precomputed hash lookup | Hashcat, Ophcrack |
| Hybrid | Dictionary + variations (numbers/symbols) | John the Ripper |
| Phishing/Social Engineering | Tricks user into revealing password | N/A (human-targeted) |

---

### 📌 IDS vs IPS

| Feature | IDS | IPS |
|---|---|---|
| Action | Detects & alerts | Detects & blocks |
| Placement | Out-of-band (monitors copy of traffic) | Inline (in traffic path) |
| Example Tool | SNORT (IDS mode) | SNORT (IPS mode), Firewalls |
| Risk | False positives = noise | False positives = blocked legit traffic |

---

### 📌 Wireless Security — WEP vs WPA vs WPA2 vs WPA3

| Standard | Encryption | Key Weakness |
|---|---|---|
| WEP | RC4 | Easily cracked (weak IV) |
| WPA | TKIP | Improved but still vulnerable |
| WPA2 | AES-CCMP | Vulnerable to KRACK attack |
| WPA3 | SAE (Simultaneous Auth of Equals) | Current standard, most secure |

---

### 📌 Ethical Hacking — 5 Phases

| Phase | Description | Example Tools |
|---|---|---|
| Reconnaissance | Passive/active info gathering | WHOIS, Google Dorks, Shodan |
| Scanning | Identify live hosts, open ports, services | NMAP, Nessus |
| Gaining Access | Exploit vulnerabilities | Metasploit, SQLi, XSS |
| Maintaining Access | Install backdoors/persistence | Trojans, rootkits |
| Covering Tracks | Erase logs, hide presence | Log editing, steganography |

---

### 📌 Android Security — Key Tools

| Tool | Purpose |
|---|---|
| ADB | Device shell access, app install/debug |
| Frida | Dynamic instrumentation, hooking functions |
| APKTool | Decompile/recompile APK resources |
| JADX | Decompile APK to readable Java source |
| MobSF | Automated static + dynamic app analysis |
| Burp Suite | Intercept mobile app API traffic |

---

### 📌 OWASP Top 10 Mobile — Common Categories

| Category | Description |
|---|---|
| Insecure Data Storage | Sensitive data stored unencrypted on device |
| Improper Platform Usage | Misuse of platform features/permissions |
| Insecure Communication | Data sent without TLS/weak encryption |
| Insecure Authentication | Weak session/login handling |
| Insufficient Cryptography | Weak/broken crypto implementation |
| Reverse Engineering | Lack of code obfuscation, easy decompilation |

---

## 📋 QUICK SYLLABUS TOPIC LIST (All Sessions)

| Session | Topics |
|---|---|
| 1 | OWASP Top 10, Injection, XSS |
| 2 | DoS, Buffer Overflows, Access Control |
| 3 | Web App Security Risks, Threat Modelling, Burp Suite |
| 4 | Data Extraction, Advanced Exploitation, HTTP Methods |
| 5 | SAST/DAST Tools, Web App Framework Case Study |
| 6–9 | Security Management, Threats, Cyber Crimes, Hacker Classes |
| 10 | Footprinting, Social Engineering, Scanning Methodologies |
| 11 | TCP Flags, Banner Grabbing, Enumeration, Password Cracking |
| 12 | Password Countermeasures, Trojans, Backdoors, Keyloggers |
| 13 | Trojan Construction, Countermeasures |
| 14 | Virus vs Worm, Antivirus Evasion |
| 15 | Sniffing, ARP Poisoning, MAC Flooding, DNS Spoofing |
| 16 | DoS/DDoS, Botnets, Session Hijacking |
| 17 | Web Server Hacking, Wireless Hacking (WEP/WPA) |
| 18 | Backdoors, Linux Hacking, IDS/IPS/Honeypots |
| 19 | Physical Security, Penetration Testing (Metasploit) |
| 20 | Malware Reverse Engineering, Static/Dynamic Analysis |
| 21 | Android Architecture, File Structure, Security Model, Rooting |
| 22 | Android Debug Bridge, Pentesting Tools |
| 23 | OWASP Mobile Top 10, Reverse Engineering, Smishing |
| 24 | Web/Network Attacks on Android, MITM, Phishing |
| 25 | Mobile Malware, Android App Analysis (MobSF) |

---

*CDAC DITISS — PGCP-ITISS | Security Concepts (App Security + Ethical Hacking + Mobile Security) | Feb 2026*
*Total: 60T + 50L + 10SL = 120 hrs*
