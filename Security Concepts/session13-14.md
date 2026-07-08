# Session 13 (2T + 2L): Trojans

**Topics:** Wrapping | Trojan Construction Kits & Trojan Makers | Countermeasures to Prevent Trojans | Trojan-Evading Techniques | System File Verification

---

## 1. Wrapping (Malware Concealment Technique)

**Definition:** Wrapping is a malware obfuscation technique where malicious code is hidden inside a legitimate-looking executable to evade detection.

**Core Concept:** Instead of distributing malware directly, attackers embed it within a benign application (game, installer, utility). The victim executes the file thinking it is safe.

**Working Mechanism:**
1. Attacker takes a malicious payload (Trojan, RAT, etc.).
2. Payload is encrypted or compressed, then encapsulated inside a wrapper program.
3. When the wrapped file is executed:
   - The wrapper runs first.
   - It silently extracts/decrypts the hidden malware in memory or disk.
   - Executes the malicious payload without user awareness.

**Types of Wrapping:**
| Type | Description |
|---|---|
| Static Wrapping | Payload embedded and unpacked during execution |
| Dynamic Wrapping | Payload fetched/decrypted at runtime |
| Crypters/Packers | Tools like UPX or custom packers used for wrapping |

**Techniques Used Alongside Wrapping:**
- **Polymorphism** — changes code signature each time it spreads
- **Obfuscation** — makes code unreadable to analysts
- **Encryption** — hides payload from static analysis
- **Anti-debugging** — prevents reverse engineering

**Advantages for Attackers:**
- Evades signature-based antivirus detection
- Bypasses basic security scans
- Increases persistence and stealth

**Detection Challenges:**
- Malware only reveals itself at runtime (in-memory execution)
- Signature mismatch due to encryption/packing
- Legitimate wrapper disguises malicious intent

**Detection & Mitigation:**
- Behavior-based detection (EDR tools)
- Sandboxing and dynamic analysis
- Heuristic analysis
- Memory forensics (e.g., Volatility)
- Restrict execution of unknown binaries

**Example:** A cracked software installer contains a wrapped RAT. The software works normally, but in the background it opens a reverse shell to the attacker.

---

## 2. Trojan Construction Kits (TCKs) and Trojan Makers

**Definition:** Tools that automate the creation of Trojans, enabling even non-experts to generate malware.

**Purpose:**
- Simplify malware development
- Provide pre-built modules for attacks
- Allow customization without deep coding knowledge

**Key Features:**
- GUI-based interface (easy to use)
- **Payload configuration:** keyloggers, screen capture, file access
- **Persistence mechanisms:** registry autorun entries, scheduled tasks
- **Communication methods:** reverse shell, Command and Control (C2) servers
- Encryption and obfuscation options
- **Builder + Client model:** Builder creates malware; Client controls infected systems

**Components of a Trojan Kit:**
```
┌────────────────┐     ┌───────────────┐     ┌──────────────────┐
│    Builder     │ --> │  Payload       │ --> │  Networking       │
│ (generates the │     │  Modules       │     │  Module (TCP/     │
│  executable)   │     │ (keylog, RAT..)│     │  HTTP/DNS)         │
└────────────────┘     └───────────────┘     └──────────────────┘
        │                                              │
        v                                              v
┌────────────────┐                          ┌──────────────────┐
│ Crypter         │                          │  Control Panel    │
│ Integration     │                          │ (manage infected   │
│ (evade AV)      │                          │  systems)          │
└────────────────┘                          └──────────────────┘
```

**Types of Trojans Created:**
- Remote Access Trojans (RATs)
- Banking Trojans
- Spyware Trojans
- Backdoor Trojans
- Downloader Trojans

**Examples:** Sub7 (classic RAT builder), DarkComet, njRAT, Poison Ivy, and modern subscription-based variants sold on the dark web.

**Advantages for Attackers:**
- Low technical barrier to entry
- Rapid malware generation
- Customizable attacks
- Scalable for mass campaigns

**Risks & Impact:**
- Increase in script kiddie attacks
- Widespread malware distribution
- Harder attribution due to reuse of kits

**Detection & Defense:**
- Network monitoring (detect C2 traffic)
- IDS/IPS systems (Snort, Suricata)
- Endpoint protection (EDR/XDR)
- Threat intelligence feeds
- Blocking known malicious signatures and behaviors

**Example:** An attacker uses a RAT builder to create a Trojan with keylogging and webcam access, then sends it via phishing email disguised as a job-offer PDF executable.

---

## 3. Countermeasure Techniques to Prevent Trojans

**Definition:** Security practices and technologies used to detect, prevent, and mitigate Trojan infections in systems and networks.

| # | Countermeasure | Key Points |
|---|---|---|
| 1 | **Antivirus / Anti-malware** | Signature-based detection for known Trojans; heuristic analysis for unknown/modified malware; EDR/XDR for real-time monitoring; regular updates critical |
| 2 | **Application Whitelisting** | Only pre-approved apps allowed to execute; prevents unknown executables from running; tools: Windows AppLocker, SELinux policies |
| 3 | **Behavioral Analysis** | Monitors system/network behavior instead of relying only on signatures; flags unexpected outbound connections (C2), unauthorized file modifications, privilege escalation; common in SIEM/EDR |
| 4 | **System Hardening** | Reduce attack surface: disable unused services, close unnecessary ports, remove default credentials; apply least privilege; secure configs (SSH hardening, firewall rules) |
| 5 | **User Education & Awareness** | Users are often the weakest link; train to avoid suspicious attachments/links, verify software sources, recognize phishing |
| 6 | **Patch Management** | Regularly update OS, apps, firmware; fix known vulnerabilities; automate updates; critical against zero-day exploit chains |
| 7 | **Network Segmentation & Monitoring** | Divide network into segments (VLANs/subnets) to limit lateral movement; monitor traffic via IDS/IPS (Snort, Suricata) and NetFlow analysis |
| 8 | **Additional Measures** | Firewalls to restrict outbound connections; MFA; regular backups; log monitoring and incident response planning |

**Example:** In a corporate network, if a Trojan infects one machine, network segmentation prevents easy spread to servers, while IDS detects abnormal outbound traffic to a suspicious IP.

---

## 4. Trojan-Evading Techniques

**Definition:** Methods used by attackers to bypass detection mechanisms and maintain stealth within a system.

| Technique | Description |
|---|---|
| **Polymorphism** | Code structure/signature changes with each infection using varying encryption keys — defeats signature-based detection |
| **Code Obfuscation** | Alters readability without changing functionality: variable/function renaming, control flow manipulation, junk code insertion |
| **Rootkit Capabilities** | Hides malicious components at OS/kernel level (files, processes, registry entries); can intercept system calls |
| **Encrypted Payloads** | Payload stays encrypted until execution; decrypted only in memory at runtime, preventing static analysis |
| **Anti-Debugging** | Detects debugging tools (GDB, OllyDbg); alters behavior or terminates if analysis is detected (timing checks, breakpoint detection) |
| **Anti-VM / Anti-Sandbox** | Detects virtual environments (VMware, VirtualBox) via VM-specific drivers or limited hardware resources; avoids execution |
| **Packing & Compression** | Uses packers (e.g., UPX) to compress/encrypt code; unpacked during runtime |
| **Fileless Malware** | Operates entirely in memory using legitimate tools like PowerShell, WMI; leaves minimal/no disk traces |

**Advantages for Attackers:** High stealth and persistence; difficult to detect using traditional tools; enables long-term access to compromised systems.

**Detection Challenges:**
- Signature mismatch due to polymorphism
- No file artifacts in fileless malware
- Rootkits hide presence from OS-level tools

**Defensive Techniques Against Evasion:**
- Memory forensics (Volatility)
- Behavioral detection systems
- Sandboxing with advanced evasion detection
- Threat hunting and anomaly detection
- Kernel integrity monitoring

**Example:** A fileless Trojan uses PowerShell to download and execute a payload in memory. Since no file is written to disk, traditional antivirus fails, but behavioral analysis detects unusual PowerShell activity.

---

## 5. System File Verification

**Definition:** A security technique that ensures the integrity of critical system files by comparing them against trusted, known-good versions — helping detect unauthorized modifications caused by Trojans or other malware.

**Purpose:**
- Detect file tampering or unauthorized changes
- Identify Trojan infections that modify system binaries
- Maintain OS stability and trust
- Enable quick restoration of corrupted files

**Core Concept (File Integrity Checking):**
- Each system file has a known baseline (original version).
- A hash value (e.g., MD5, SHA-256) is calculated for the file.
- The current file hash is compared with the baseline hash.
- Mismatch → possible tampering or infection.

**Working Mechanism:**
```
Baseline Creation → Scanning → Comparison → Action Taken
```
1. **Baseline Creation** — trusted database of original system files (OS vendor / admin-defined), including cryptographic hashes and metadata.
2. **Scanning Process** — tool scans critical directories (`/bin`, `/usr`, `C:\Windows\System32`) and computes current hash values.
3. **Comparison** — current hashes compared with stored baseline hashes; differences flagged as anomalies.
4. **Action Taken** — alert generated; file may be restored from cache, replaced from original installation source, or quarantined for analysis.

**Common Tools:**

| Platform | Tools |
|---|---|
| Windows | System File Checker (`sfc /scannow`) — scans/repairs corrupted files automatically; DISM — repairs the Windows image used by SFC |
| Linux/Unix | AIDE (Advanced Intrusion Detection Environment), Tripwire, RPM/Yum verification (`rpm -V`) |
| Third-Party | OSSEC (HIDS with file integrity monitoring), Samhain |

**Indicators of Trojan Infection:**
- Unexpected modification of system binaries
- Changes in file size, hash, or timestamps
- Presence of unknown or unsigned files
- Replacement of legitimate files with malicious ones (Trojanized binaries)

**Advantages:**
- Early detection of stealthy malware
- Effective against rootkits modifying system files
- Works even if malware hides from standard antivirus
- Provides forensic evidence of compromise

**Limitations:**
- Cannot detect fileless malware (no disk changes)
- Requires a clean baseline; if baseline is compromised, detection fails
- Frequent updates can generate false positives
- Performance overhead during scans

**Best Practices:**
- Maintain a secure, offline baseline database
- Schedule regular automated scans
- Combine with behavioral monitoring, log analysis, network security tools
- Restrict access to critical system directories
- Use cryptographically strong hashes (SHA-256) instead of weaker ones (MD5)

**Example:** A Trojan replaces a legitimate system utility (e.g., `netstat`) with a modified version that hides attacker connections. System File Verification detects a hash mismatch in the binary, flags it, and restores the original file from a trusted source.

---
---

# Session 14 (2T + 2L): Viruses & Worms

**Topics:** Virus vs Worm | Types of Viruses | Antivirus Evasion Techniques | Virus Detection Methods

---

## 1. Difference Between a Virus and a Worm

**Definitions:**
- **Virus:** A malicious program that attaches itself to a legitimate file or program and requires user action to spread.
- **Worm:** A standalone malware that self-replicates and spreads automatically across systems and networks.

| Aspect | Virus | Worm |
|---|---|---|
| **Spreading Mechanism** | Requires a host file (`.exe`, `.doc`); spreads when the infected file is executed | Does not require a host file; spreads independently via network vulnerabilities, email, or shared resources |
| **User Interaction** | Needs user action (opening file, running program) | No user interaction required after initial execution |
| **Activation** | Activated when the host file is executed | Automatically activates and begins replication |
| **Propagation Speed** | Slower — depends on user actions | Very fast — spreads across networks |
| **Impact** | Primarily affects local system files; can corrupt, delete, or modify data | Focuses on network-level spread; consumes bandwidth, causes congestion/outages |
| **Payload** | Often carries destructive payloads (data deletion, corruption) | Primarily designed for spreading, but may carry payloads like backdoors or ransomware |

**Examples:**
- **Virus:** A malicious `.exe` attached to an email that infects the system when opened.
- **Worm:** WannaCry, which spread automatically using the SMB vulnerability across networks.

---

## 2. Types of Viruses

**Definition:** Viruses are classified based on behavior, infection method, and target.

| Type | Description |
|---|---|
| **File Infector Virus** | Attaches to executable files (`.exe`, `.com`); activates on execution and spreads by infecting other executables |
| **Boot Sector Virus** | Infects the boot sector or Master Boot Record (MBR); loads before the OS starts; spreads via infected USB drives/disks |
| **Macro Virus** | Targets macro-enabled applications (MS Word, Excel), written in macro languages like VBA; spreads through infected documents |
| **Polymorphic Virus** | Changes its code/signature with each infection using encryption and variable keys; hard for signature-based AV to detect |
| **Resident Virus** | Resides in system memory (RAM); intercepts system operations; infects files as they're opened, copied, or executed |
| **Multipartite Virus** | Infects multiple areas (boot sector + executable files) simultaneously via multiple vectors; hard to remove completely |
| **Stealth Virus** | Hides its presence by intercepting system calls, showing clean versions of infected files to antivirus tools |

**Key Characteristics of Viruses:**
- Require a host file
- Depend on user interaction
- Can modify or destroy data
- Often use stealth and obfuscation techniques

**Example:** A macro virus embedded in a Word document runs when the file is opened, infects other documents, and spreads via email attachments.

---

## 3. Antivirus Evasion Techniques

**Definition:** Methods used by viruses to bypass detection mechanisms and remain undetected within a system.

| Technique | Description |
|---|---|
| **Polymorphism** | Virus changes its code signature with each infection using different encryption keys — defeats signature-based detection |
| **Encryption** | Virus body encrypted to hide content; a small decryption routine runs first at runtime, preventing static analysis |
| **Code Obfuscation** | Makes code complex/unreadable without altering functionality (junk code, control flow changes, renaming); slows reverse engineering |
| **Rootkits** | Hide malware presence at OS/kernel level by manipulating system calls to conceal files, processes, registry entries |
| **Packing** | Compresses/encrypts executable using packers (e.g., UPX); actual malicious code unpacked at runtime, evading signature scanning |
| **Anti-Debugging** | Detects debugging tools (GDB, OllyDbg); may terminate or alter behavior if detected (breakpoint detection, timing checks) |
| **Anti-VM / Anti-Sandbox** | Detects virtual environments (VMware, VirtualBox) via system artifacts (drivers, CPU cores, MAC address); avoids execution |
| **Metamorphism** | Virus completely rewrites its own code each time it spreads — no consistent signature remains; more advanced than polymorphism |

**Impact of Evasion Techniques:**
- Reduces effectiveness of traditional antivirus
- Increases persistence and stealth
- Enables long-term system compromise

**Example:** A polymorphic virus encrypts itself differently each time it infects a file, so antivirus cannot match a fixed signature, allowing it to spread undetected.

---

## 4. Virus Detection Methods

**Definition:** Techniques used by security systems to identify and analyze malicious software.

| Method | Description | Trade-off |
|---|---|---|
| **Signature-based Detection** | Compares files against a database of known virus signatures | Fast and accurate for known threats; ineffective against new/zero-day viruses |
| **Heuristic Analysis** | Examines code structure and behavior patterns (e.g., self-modifying code) | Can identify unknown threats; may produce false positives |
| **Behavioral Detection** | Monitors real-time program activity — unauthorized file changes, registry modifications, unexpected network connections | Common in EDR solutions |
| **Sandboxing** | Executes suspicious files in an isolated environment to observe behavior | Effective against unknown malware; can be bypassed by anti-VM techniques |
| **Integrity Checking** | Uses hash functions (e.g., SHA-256) to verify file integrity | Useful for identifying infected system files |
| **Cloud-based Detection** | Offloads analysis to cloud servers using threat intelligence databases and ML models | Provides real-time updates and faster detection of new threats |

**Comparison Insight:**
- Signature-based = fast but limited to known threats
- Heuristic + Behavioral = better for unknown malware
- Sandboxing = deep analysis but resource-intensive
- Cloud-based = scalable and continuously updated

**Example:** A suspicious executable is uploaded to a cloud-based antivirus system, analyzed using machine learning and sandboxing, and identified as malware even though no prior signature exists.
