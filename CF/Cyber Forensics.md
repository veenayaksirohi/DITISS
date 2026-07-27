# Cyber Forensics — Complete Exam Notes (Sessions 1–10)

---

# SESSION 1: Introduction to Computer Forensics

## 1.1 What Is Computer Forensics

**Computer Forensics** (also called **Digital Forensics**) is the scientific process of finding, protecting, extracting, documenting, and interpreting digital evidence from computers and storage devices so it can be used in a legal or organizational investigation.

The word "forensic" means "relating to courts of law." So Computer Forensics essentially means **making computer evidence usable in court**.

⭐ **Important**: The goal is not just to *find* evidence — it is to find it in a way that keeps it **legally valid**. Nothing may be altered, and every step must be documented. This documentation trail is called the **Chain of Custody** (detailed in Session 2).

### Where Computer Forensics Is Applied
- Cybercrime investigations (e.g., tracing a hacker who stole credit card data)
- Internal corporate probes (e.g., an employee leaking confidential files)
- Civil litigation (e.g., a business dispute involving deleted emails)
- Incident response and breach recovery (e.g., recovering from ransomware)

💡 **Remember**: The two big questions forensics tries to answer are: **"What happened on this device?"** and **"Who is responsible?"**

## 1.2 Computer Crime vs Unauthorized Activities

These two terms are often confused but are legally very different.

- **Computer Crime**: any *illegal* act that involves a computer, network, or digital device as either the target or the tool of the crime.
- **Unauthorized Activity**: an action that breaks a company's security policy or acceptable-use rules but is **not necessarily illegal**.

| Aspect | Computer Crime | Unauthorized Activity |
|---|---|---|
| Definition | Illegal act involving computers/networks/digital devices | Violates security policy or acceptable use, not necessarily criminal |
| Example | Hacking into a bank's system to steal funds | Downloading pirated software at work |
| Legal Status | Punishable under cyber laws | May or may not be illegal; usually a policy violation |
| Intent | Usually malicious and planned | Can be due to negligence or lack of awareness |
| Impact | Legal, financial, reputational damage | Operational and disciplinary consequences |

⚠ **Exam Point**: Computer crime = **law** is broken. Unauthorized activity = **policy** is broken (law may or may not also be broken).

**Example**: An employee copying company files to a personal USB against policy = unauthorized activity. If that employee then *sells* those files to a competitor = computer crime (theft of trade secrets, punishable by law).

## 1.3 Cyber Laws

**Cyber Laws** are legal rules governing activities in the digital world — internet use, electronic communication, digital contracts, and computer-related crimes. They exist because pre-computer-era laws did not cover hacking, digital signatures, or online fraud.

Cyber laws generally regulate:
- Intellectual property rights (software, digital content, patents)
- Data privacy (protecting personal information)
- Digital contracts (making online agreements legally valid)
- Electronic signatures (making e-signatures as valid as handwritten ones)
- Cybercrimes (hacking, phishing, identity theft)

### 1.3.1 IT Act 2000 (India)

**IT Act 2000** = Information Technology Act, 2000 — India's primary law governing e-commerce, digital signatures, and cybercrimes. It has 94 sections across 13 chapters.

- **Information** → any data, physical or electronic
- **Technology** → computers, networks, digital systems
- **Act** → a law passed by Parliament

| Section | Offense | Penalty |
|---|---|---|
| Section 43 | Unauthorized access or damage to computer systems | Compensation to system owner |
| Section 66 | Hacking a computer system | Up to 3 years imprisonment or ₹5 lakh fine, or both |
| Section 66B/C/D | Fraud and identity theft | Up to 3 years imprisonment or ₹1 lakh fine, or both |
| Section 66E | Violation of privacy (transmitting private images) | Up to 3 years imprisonment or ₹2 lakh fine, or both |
| Section 66F | Cyber terrorism | Life imprisonment |
| Section 67 | Publishing obscene content online | Up to 5 years imprisonment or ₹10 lakh fine, or both |

⚠ **Exam Point (Correction)**: Section 66A (dealt with "offensive" online messages) was **struck down by the Supreme Court in 2015** (*Shreya Singhal v. Union of India*) as unconstitutional and vague. Do not cite Section 66A as active law.

### 1.3.2 Data Protection Laws
- **GDPR** (General Data Protection Regulation) — EU law giving people control over personal data.
- **HIPAA** (Health Insurance Portability and Accountability Act) — US law protecting medical/health data.
- **PDP Bill → DPDP Act 2023** (India) — the Personal Data Protection Bill has since been enacted as the **Digital Personal Data Protection Act, 2023**, India's actual current data-protection law (correction/update beyond the original draft-bill stage).

### 1.3.3 Cybercrime Laws
In India, cybercrime provisions largely sit **inside the IT Act 2000 itself** (Sections 43, 66, 70, etc.) rather than existing as a separate standalone "cybercrime law."

## 1.4 The Six Stages of the Computer Forensics Process

```
Identification -> Preservation -> Collection -> Examination -> Analysis -> Presentation
```

### 1. Identification
Identify all potential sources of digital evidence — hard drives, USBs, emails, cloud storage, phones, IoT devices.
- **Before**: Investigator receives the case brief.
- **During**: Physical/digital environment is surveyed to list every device that might hold evidence.
- **After**: A list of evidence sources is created with a plan to access each.
- **Why**: Evidence sources missed here can never be recovered later.

### 2. Preservation
Ensure evidence stays exactly as found, without alteration.
- **Before**: Original device isolated (often disconnected from networks to prevent remote wipe).
- **During**: A **bit-by-bit image** (exact copy) is created; investigators work on the copy, not the original.
- **After**: Original sealed/stored securely; copy is hashed (MD5/SHA-256) to prove it hasn't changed.
- **Why**: Courts require proof evidence was not tampered with.

⚠ **Exam Point**: "Imaging" = creating an exact forensic copy (captures deleted files, hidden partitions, metadata too) — not just copying visible files.

### 3. Collection
Data is acquired in a legally and technically sound way.
- **Before**: Legal authority confirmed (search warrant / company policy permission).
- **During**: A **write blocker** (prevents any write operation on original disk) is used while imaging, with tools like **FTK Imager**.
- **After**: Chain-of-custody documentation begins.
- **Why**: Without write blockers, even opening a file can change its "last accessed" timestamp.
- **Linux tools**: `dd`, `dc3dd`.

### 4. Examination
Filter the huge volume of collected data down to what's relevant.
- **Before**: Forensic image loaded into analysis software (Autopsy, EnCase).
- **During**: Search for deleted/hidden files, examine logs; keyword/file-type filters narrow millions of files to relevant ones.
- **After**: A shortlist of relevant artifacts is prepared.
- **Why**: Manual analysis of millions of files is impossible without filtering.
- **Note**: Deleting a file usually just removes its pointer in the file system table — actual data often remains until overwritten.

### 5. Analysis
Study filtered data to reconstruct the sequence of events.
- **During**: Link timestamps, user activity, and metadata into a timeline (e.g., "user logged in at 10 PM, copied files to USB at 10:15 PM, deleted logs at 10:20 PM").
- **Why**: Raw data alone proves nothing — analysis turns data into a coherent story.

### 6. Presentation
Document and communicate findings, often for a legal audience.
- **During**: A technical report is presented in court; investigator may testify as an **expert witness** (a professional qualified to explain technical findings to a judge/jury).
- **Why**: Even perfect analysis is useless if it can't be explained and defended under legal scrutiny.

💡 **Remember (Alternative Model)**: A UK-standard variant describes this as "Readiness, Evaluation, Collection, Analysis, Presentation, Review." Both cover the same ideas; the Identification→Preservation→Collection→Examination→Analysis→Presentation model is the more internationally taught version.

## 1.5 Need for a Computer Forensics Investigator

A **Computer Forensics Investigator** is a trained professional applying forensic science to digital devices. Needed because:
- Cybercrimes are rising rapidly
- Digital evidence is fragile (altered/lost through simple actions like opening a file)
- Legal compliance requirements
- Litigation support needs credible evidence
- Incident response — identifying root cause/scope of a breach
- Internal investigations — uncovering policy violations

### Skills Needed
- Deep knowledge of OS (Windows, Linux, macOS) and networking
- Familiarity with forensic tools (**EnCase**, **Autopsy**)
- Understanding of legal procedures — chain of custody, evidence admissibility

### Key Tools (Overview — expanded fully in Session 8)
| Tool | Notes |
|---|---|
| Autopsy | Open-source, GUI-based, built on Sleuth Kit; popular in academic settings |
| EnCase | Industry-standard commercial suite, heavily used in law enforcement |
| FTK Imager | Free tool for creating forensic disk images |
| Wireshark | Primarily a network tool, also used to analyze captured traffic for attack evidence |

⚠ **Exam Point**: EnCase and FTK are commercial-grade with courtroom credibility; Autopsy is open-source and popular in academic settings.

---

# SESSION 2: The Forensics Process, Response Planning & Chain of Custody

## 2.1 What Computer Forensics Involves — Five Core Activities
- **Discovering** digital evidence — finding where it exists
- **Investigating and analyzing** evidence — understanding what happened
- **Recovering deleted data** — retrieving removed/hidden files
- **Maintaining integrity** of the data — ensuring it's never altered
- **Preparing for legal presentation** — packaging findings for court

⭐ **Important**: The word **"admissible"** is key — evidence is only useful if a court will accept it, meaning the *process*, not just the finding, must be legally sound.

### Common Tools
| Tool | Purpose |
|---|---|
| EnCase | Commercial, industry-standard forensic suite |
| FTK (Forensic Toolkit) | Disk imaging and evidence analysis |
| Autopsy | Free, open-source GUI tool built on Sleuth Kit |
| Sleuth Kit | Command-line library underneath Autopsy |
| Volatility | Open-source memory forensics framework (Python), analyzes RAM dumps |

## 2.2 Preservation (Detailed)
Comes right after Identification. Purpose: evidence stays exactly as found, from discovery until court presentation.

**Steps**:
- Creating bit-by-bit images (captures deleted files, hidden partitions — not just visible files)
- Using write blockers (hardware/software that physically prevents write commands reaching original media)
- Hashing with **MD5** (Message Digest 5) or **SHA-256** (Secure Hash Algorithm, 256-bit) to generate a unique fingerprint — a single changed bit produces a completely different hash
- Ensuring no tampering throughout the investigation lifecycle

```
Original Device
      |
      | (Write Blocker attached)
      v
Bit-by-Bit Image Created
      |
      | Hash Generated (MD5/SHA-256)
      v
Image Stored & Sealed  --->  Hash Verified Again Later (must match)
```

⚠ **Exam Point**: If the hash of the evidence copy doesn't match the original hash later, the evidence is considered compromised and may be thrown out of court.

## 2.3 Identification (Detailed)
Figuring out where evidence might exist and what type is relevant.

**Involves identifying**:
- Potential evidence sources — computers, phones, servers, cloud accounts, IoT devices
- Relevant data types — logs, documents, emails, chat logs, deleted files
- Scope of the incident — how many systems/devices are involved
- Requires understanding file systems (NTFS, ext4), network paths, and user access levels

**Example**: In a phishing investigation — victim's email inbox, mail server logs, attacker's spoofed domain records.

## 2.4 Extraction
Pulling actual data out of identified and preserved evidence without changing it.

**Covers**: recovering deleted/hidden/encrypted files, accessing temp files, registry keys, memory dumps — without altering metadata (timestamps).

### Types of Extraction
| Type | Description | Example |
|---|---|---|
| Logical | File-level extraction | Pulling specific documents from a hard drive |
| Physical | Entire raw device, bit by bit | Imaging an entire smartphone's storage chip |
| Live | While the system is still running | Capturing RAM from a live server before shutdown |

⚠ **Exam Point**: Live extraction is risky but necessary — RAM contents disappear once power is cut, so investigators must capture volatile memory (running processes, encryption keys) before shutdown. Tools like **Volatility** analyze the resulting memory dumps.

## 2.5 Documentation
A detailed, written record of everything done during the investigation.

**Why it matters**:
- Creates a step-by-step record of actions, timing, and responsible parties
- Tracks tools used, evidence collected, hash values, observations
- Ensures legal admissibility through unbroken logs
- Supports final reports and courtroom testimony

💡 **Remember**: If it isn't documented, in court it is treated as if it didn't happen.

## 2.6 Interpretation
Turning raw extracted data into meaningful conclusions.

**Determines**:
- Timeline of events
- User actions and intentions (accidental vs deliberate)
- Data flow / compromise patterns
- Connections between devices, IPs, and accounts

⭐ **Important**: Results must be explained so non-technical people (judges, juries, managers) understand — raw timestamps and hex codes mean nothing without a clear narrative.

**Example**: "Attacker's IP 192.168.x.x logged into the admin panel at 2:14 AM, changed the password at 2:16 AM, downloaded the customer database at 2:20 AM."

## 2.7 Goals of Forensics Analysis

**Primary Goals** (tied to legal outcomes):
- Recovering and analyzing evidence
- Maintaining evidence integrity
- Attributing actions to individuals
- Assisting legal proceedings
- Providing intelligence for future prevention

**Secondary Goals** (organizational improvement):
- Supporting incident response
- Conducting internal investigations
- Assisting audits and identifying policy violations

## 2.8 Types of Cyber Forensics Techniques

| Technique | Description | Example Use Case |
|---|---|---|
| Disk Forensics | Analyzing hard drives/storage media | Recovering deleted files from a laptop |
| Network Forensics | Monitoring/analyzing network traffic | Wireshark tracing malware C2 communication |
| Memory Forensics | Analyzing volatile RAM data | Volatility finding hidden malicious processes |
| Mobile Forensics | Investigating phones/tablets | Extracting deleted WhatsApp messages |
| Cloud Forensics | Accessing cloud-stored data | Investigating unauthorized S3 bucket access |
| Database Forensics | Examining DBMS data | Tracing who modified financial records |
| Malware Forensics | Reverse-engineering malware | Studying ransomware's encryption method |

⚠ **Exam Point**: Memory forensics is critical for "fileless malware," which never writes to disk — disk forensics alone would completely miss it.

## 2.9 Cyber Forensics Procedures — 8-Step SOP

```
Preparation -> Detection -> Isolation -> Preservation -> Collection/Extraction
     -> Analysis/Interpretation -> Reporting -> Legal Support
```

1. **Preparation** — tools, policies, training set up in advance
2. **Detection of incident** — identifying something suspicious occurred
3. **Isolation of affected systems** — disconnecting to stop further damage
4. **Preservation of data** — imaging/hashing evidence before it changes
5. **Collection and extraction** — gathering and pulling out relevant data
6. **Analysis and interpretation** — building a narrative
7. **Reporting and documentation** — writing up findings
8. **Legal proceedings support** — expert testimony/evidence packages

⚠ **Exam Point**: "Isolation" is a distinct step here (unlike Session 1's six-stage model) because stopping an ongoing attack is often more urgent than perfect preservation — investigators must balance speed with evidence integrity.

## 2.10 Preparation
Getting ready **before** any incident occurs, so response is fast and effective.

**Involves**: setting up a forensic lab (imaging software, write blockers, workstations), defining policies/procedures, ensuring legal authorization is pre-understood (warrants, consent forms), training staff, preparing checklists and secure evidence storage.

## 2.11 What to Do Before the Incident
- Establishing a cybersecurity framework (e.g., NIST Cybersecurity Framework)
- Defining roles and responsibilities in advance
- Implementing logging and monitoring systems (so evidence exists when needed)
- Performing risk assessments for likely attack scenarios
- Conducting regular training/awareness programs

**Example**: A company running AWS EC2 instances should enable CloudTrail logging in advance — without pre-enabled logging, there are no records to investigate after a breach.

## 2.12 Incident Response Plan (IRP)
A documented, step-by-step guide for handling security incidents.

**Details**: how to detect/respond/recover; key contacts and escalation paths; steps to isolate and preserve evidence; communication and containment guidelines; links with legal teams/law enforcement.

⭐ **Important**: Without a written plan, organizations waste critical time during an actual attack figuring out "who does what."

## 2.13 Incident Response Team (IRT)

| Role | Responsibility |
|---|---|
| Team Leader | Coordinates overall response, allocates resources |
| Forensic Analyst | Acquires and analyzes digital evidence |
| System Admin | Implements containment and recovery |
| Legal Advisor | Ensures compliance with laws/regulations |
| Communication Officer | Handles internal/external updates |

## 2.14 Detecting Incidents

**Methods**:
- **IDS** — Intrusion Detection Systems (monitor for suspicious patterns)
- **SIEM** — Security Information and Event Management (e.g., Splunk, AlienVault) — collects and correlates logs across an organization
- Unusual behavior analysis (e.g., login at 3 AM from a new country)
- System logs and alerts
- User-reported issues

**Common indicators**: unauthorized access attempts, system crashes, unusual network traffic, unexplained file integrity changes.

⚠ **Exam Point**: **SIEM** = **S**ecurity **I**nformation and **E**vent **M**anagement — "Security" = domain; "Information and Event Management" = collecting/organizing data about events to help security teams respond faster.

**Example**: Splunk flagging "50 failed SSH login attempts from a single IP within one minute" as a brute-force indicator, before an admin notices manually.

## 2.15 Chain of Custody

**Chain of Custody** is a chronological record proving exactly **who** handled a piece of evidence, **when**, **where**, and under **what circumstances** — from collection until presentation in court.

**Why critical**: Any gap or unexplained handling lets opposing lawyers argue the evidence was tampered with, risking dismissal.

**Must include**:
- Unique evidence IDs
- Dates, times, and signatures
- Location logs and access controls

```
Evidence Collected
      |
      v
Logged with Unique ID + Timestamp + Collector Signature
      |
      v
Transferred to Analyst (new log entry: date, time, signature)
      |
      v
Stored Securely (access-controlled location)
      |
      v
Presented in Court (full history available)
```

⚠ **Exam Point**: Chain of custody is often the single most contested part of a digital forensics case — technical accuracy matters little if the chain has broken links.

---

# SESSION 3: Evidence Handling, First Response & Duplication

## 3.1 Evidence Checkout Log
A written record tracking every time a piece of evidence is accessed — who took it, when, why, under what circumstances. (Like a library borrowing record, but with much higher legal stakes.)

**Why it exists**: accountability, chain-of-custody preservation, complete audit trail for court/internal review.

| Field | Purpose |
|---|---|
| Evidence ID | Uniquely identifies the exact item |
| Person checking out/in | Names the responsible individual |
| Date and time | Establishes exact custody timeline |
| Purpose | States why evidence was accessed (e.g., "imaging," "analysis") |
| Signatures | Confirms accountability and consent |

⭐ **Important**: Chain of custody is the *concept*; the Evidence Checkout Log is the *paperwork* that proves it in day-to-day practice.

## 3.2 Handling Evidence

**Key practices**:
- Using gloves (prevent physical contamination) and write blockers (prevent digital write commands)
- Labeling and sealing evidence (tamper-evident bags)
- Avoiding powering on devices without imaging (can change timestamps, trigger auto-updates)
- Documenting every interaction
- Hashing before and after transfer (confirms nothing changed during handoff)

⚠ **Exam Point**: Even plugging in a USB drive "just to check" can update file access timestamps — enough for a defense lawyer to challenge integrity.

💡 **Remember**: The golden rule — "when in doubt, don't touch it directly, work on a copy."

## 3.3 First Response
The very first reaction taken when an incident is discovered — before formal forensic tools arrive.

**The first responder must**:
1. Secure the scene
2. Avoid altering the state of devices
3. Photograph and document the scene
4. Prevent any tampering
5. Report to the Incident Response Team

```
Incident Discovered
        |
        v
  Secure the Scene
        |
        v
Photograph & Document (screen, cables, room layout)
        |
        v
  Prevent Tampering
        |
        v
Notify Incident Response Team
```

⭐ **The Golden Rule**: Do not power off, plug in, or alter systems unless absolutely necessary — powering off destroys volatile RAM evidence; plugging in unknown devices could trigger wiping or malware execution.

## 3.4 Formulate/Execute Response Strategy

### Formulation Phase
- Understanding incident scope
- Identifying involved systems
- Defining goals (containment first vs. evidence collection first)

### Execution Phase
- Isolating affected devices/networks
- Notifying stakeholders
- Starting preservation and imaging
- Deploying forensic tools (EnCase, FTK, Autopsy)

💡 **Remember**: A good strategy balances containment (stop the attack) vs preservation (keep evidence intact). Acting too fast destroys evidence; too slow lets damage spread.

## 3.5 Forensic Duplication
A **forensic duplicate/image** is an exact bit-by-bit copy of a storage device, so investigators analyze the copy, never the original.

**Created using**: FTK Imager, `dd` (Linux command-line disk-copying tool), Guymager (open-source, multi-threaded Linux imaging tool). Accompanied by MD5/SHA-256 hash values.

### Forensic Image Formats
| Format | Description | Trade-off |
|---|---|---|
| RAW (`.RAW`, via `dd`) | Pure bit-for-bit clone, no compression/metadata | Simple but uses full disk space; no built-in integrity tracking |
| E01 (Expert Witness Format) | Embeds case metadata, compresses, splits into hashed chunks | Industry standard for legal cases; compression is single-threaded/slower |
| AFF (Advanced Forensic Format, e.g., AFF4) | Open standard, multi-threaded compression and encryption | Best for large/fast modern drives (NVMe SSDs) and cloud environments |

⚠ **Exam Point**: Only the duplicate (image) is ever analyzed — the original is sealed and never touched again after imaging.

**Linux command example**: `dd if=/dev/sdb of=evidence.img bs=4M status=progress` — though Guymager is preferred in practice since it adds automatic hashing and logging.

## 3.6 Authenticate the Evidence
Proving evidence is genuinely original and unaltered since collection.

**Methods**: hashing before/after handling; chain-of-custody records; metadata verification (timestamps); forensic imaging logs.

⭐ **Important**: In court, forensic experts must testify personally about how evidence was preserved/verified — a report alone is often not enough.

## 3.7 Investigation
The core analytical phase — studying evidence to build conclusions.

**Involves**: analyzing logs, file systems, registry entries, emails, network traffic; recovering deleted files and reconstructing timelines; connecting evidence to actions/individuals; drawing conclusions from data, not assumptions.

⚠ **Exam Point**: All actions must be logged and **repeatable** — another qualified investigator following the same steps on the same evidence copy should reach the same result. This repeatability is what makes findings scientifically credible.

**Example**: A Windows registry investigation might reveal recently accessed USB serial numbers, proving a specific drive was connected at a certain time.

## 3.8 Common Mistakes
- Powering off a live system without memory capture (permanently loses RAM evidence)
- Failing to use write blockers
- Not hashing before/after acquisition
- Incomplete chain of custody
- Overwriting logs or temporary files
- Mishandling mobile/cloud evidence (remote wipe, auto-sync deleting local copies)

💡 **Remember**: Training and following SOPs are the main defenses against these mistakes.

## 3.9 Detection

**Methods**: SIEM tools (Splunk, ArcSight); alerts from IDS/IPS; unusual behavior; user reports; log file monitoring.

### IDS vs IPS
| Aspect | IDS | IPS |
|---|---|---|
| Full form | Intrusion Detection System | Intrusion Prevention System |
| Action | Passive — monitors and alerts only | Active — blocks malicious traffic in real time |
| Placement | Out-of-band (monitors a copy of traffic) | Inline (sits directly in traffic path) |
| Risk | No performance delay, but doesn't stop attacks | Slight latency, but actively prevents damage |

⚠ **Exam Point**: IDS = security camera (alerts you); IPS = security guard (actively stops the intruder).

💡 **Remember**: Early detection improves evidence quality — the sooner detected, the more volatile evidence (RAM, active connections) can be captured.

---

# SESSION 4: Initial Assessment & Hexadecimal Foundations

## 4.1 The Initial Assessment
The first analytical step right after an incident is reported, before full investigation begins. Determines nature/scope, potential impact, urgency, and type of response required.

### Key Activities
1. Verify the validity of the alert/report (real incident vs false alarm)
2. Identify affected systems, accounts, networks
3. Gather preliminary evidence (logs, recent activity)
4. Decide: security incident or false alarm?
5. Prioritize incident severity (low/medium/high/critical)

```
Alert Received
      |
      v
Verify Validity  ---> False Alarm? ---> Close, Document, Stop
      |
      v (Confirmed Real)
Identify Affected Systems -> Gather Preliminary Evidence
      |
      v
Assign Severity Level -> Decide Response Type (Contain/Investigate/Escalate)
```

⭐ **Important**: This step is a filter — prevents small issues from triggering a massive response while fast-tracking genuinely serious incidents.

## 4.2 Incident Notification Checklist
A standardized form for quick, consistent, complete incident reporting.

| Field | Example |
|---|---|
| Time/Date Detected | 2026-07-10 12:45 PM |
| Reporting Person | sysadmin@example.com |
| System/Asset Affected | Web Server (IP: 192.168.1.10) |
| Nature of Incident | Possible SQL Injection |
| Actions Taken | Access restricted, logs collected |
| Severity Level | High |
| Notified To | Incident Response Team, Management |

**Why it matters**: Consistency; no step missed even under pressure; faster triage/escalation; alignment with IR policy.

⚠ **Exam Point**: SQL Injection = a web attack inserting malicious database commands into input fields (like login forms) to manipulate/steal backend data.

## 4.3 Hexadecimal Notation
**Hexadecimal** = "base-16" number system using 16 unique symbols (vs the 10 digits of decimal).

```
0 1 2 3 4 5 6 7 8 9 A B C D E F
```
A=10, B=11, C=12, D=13, E=14, F=15.

**Why used**: Binary (0s/1s) is hard for humans to read; hex compresses binary into a shorter, more readable form — each hex digit represents exactly 4 binary bits.

⭐ **Important**: Two hex digits = 1 byte = 8 bits. This is why hex is the standard way to display raw binary data in forensic tools.

### Conversion Examples
| Conversion | Input | Output |
|---|---|---|
| Binary to Hex | 1111 1111 | FF |
| Decimal to Hex | 255 | FF |
| Hex to ASCII | 41 | A |

**Binary → Hex**: split binary into 4-bit groups ("nibbles"); convert each independently. `1111 1111` → first nibble `1111`=15=F, second nibble `1111`=15=F → `FF`.

**Hex → ASCII**: ASCII assigns a number to each character. Hex `41` = decimal 65 = character "A" in the ASCII table.

## 4.4 Practical Bits
A **bit** (binary digit) is the smallest unit of data — only 0 or 1. Raw evidence (disk sectors, memory, network packets) is fundamentally a sequence of bits.

**Where bit-level understanding is used**: analyzing disk sectors/memory/raw network traffic; investigating flags, permissions, opcodes (operation codes — bit patterns telling a CPU which instruction to execute); understanding file headers.

**Magic Number / File Signature example**: A file starting with hex bytes `0xFF D8` is a JPEG image — its unique fingerprint.

⚠ **Exam Point (Clarification)**: The full JPEG signature is typically `FF D8 FF E0` (or similar variants); `0xFF D8` alone is the minimum recognized starting marker.

## 4.5 Slight Diversion (Why Technical Skills Are Needed)
Stepping briefly away from legal/procedural topics to build the hex/bits technical foundation.

**Why necessary**: Legal procedures tell you *how* to handle evidence correctly; technical skill tells you *how to actually read* it. Without this foundation, an investigator cannot perform:
- **File carving** — recovering files from raw disk data by recognizing signatures, even with damaged/missing file system info
- **Data recovery** — reconstructing lost/deleted files
- **Malware behavior analysis** — reading raw bytes to understand what malware does

💡 **Remember**: Legal knowledge without technical skill = an investigator who follows rules but can't extract evidence. Technical skill without legal knowledge = findings thrown out of court.

## 4.6 Use of Hexadecimal in Digital Forensics

### Key Uses
1. **File Header Analysis** — identifies true file type even if the extension was deliberately changed (e.g., PNG files always start with `89 50 4E 47`)
2. **Memory Dump Analysis** — viewing raw memory regions in hex reveals malicious code/hidden processes
3. **Network Packet Analysis** — raw captured packets (e.g., Wireshark) appear in hex; decoding traces communication patterns
4. **Disk Sector Analysis** — recovering deleted/hidden files from raw sectors
5. **Data Carving** — extracting lost files purely by hex signature pattern, bypassing the file system index
6. **Malware Reverse Engineering** — understanding obfuscated/encoded payloads at the byte level

### Forensic Hex Tools
| Tool | Platform | Notes |
|---|---|---|
| HxD | Windows | Free, lightweight |
| Hex Fiend | macOS | Open-source |
| WinHex | Windows | Commercial; hashing, imaging, RAM inspection features |
| Autopsy | Windows/Linux | Full suite with built-in hex viewing |

⭐ **Important**: WinHex is a genuine all-in-one forensic tool — supports disk cloning, hashing, and direct RAM editing, not just a text viewer.

---

# SESSION 5: Encoding, Encryption, Hashing & Data Decay

## 5.1 Encoding vs Encryption

**Encoding** converts data from one format to another for compatibility. Not secure — anyone with the right tool can reverse it instantly.

**Encryption** transforms data into an unreadable form specifically to hide it from unauthorized people. Only reversible with a secret key.

| Aspect | Encoding | Encryption |
|---|---|---|
| Purpose | Convert data for compatibility | Hide data for confidentiality |
| Reversible? | Yes, no secret needed | Yes, only with the correct key |
| Examples | Base64, ASCII, Unicode | AES, RSA, DES |
| Use Case | Email attachments, URL transmission | Secure communications, data protection |

⚠ **Exam Point**: Encoding needs no secret key to reverse. Encryption absolutely requires a key.

💡 **Remember**: Encoding = "translate for compatibility." Encryption = "lock with a key."

## 5.2 The Hex Editor
A tool letting analysts view/edit raw binary content in hexadecimal form.

**Used for**: viewing/editing raw binary data; examining headers, metadata, anomalies; recovering hidden/deleted data; identifying embedded files.

| Tool | Platform |
|---|---|
| HxD | Windows |
| WinHex | Windows |
| Hex Fiend | macOS |
| 010 Editor | Windows/macOS/Linux |

**Common uses**: file signature verification, disk analysis, manual data carving, malware examination.

⭐ **Important**: 010 Editor supports "templates" — pre-built scripts that auto-parse complex formats (ZIP, EXE headers) and label byte regions, saving huge manual-analysis time.

## 5.3 Files (Forensic Relevance)
Files are the single most important evidence source — almost everything a user does leaves a file trace.

**Analyzed for**: metadata (creation date, author, GPS location), content, structure. Can contain hidden payloads, **steganography** (hiding secret data inside an innocent-looking file), or embedded malware.

### Analysis Techniques
- Header/Footer signature matching
- File carving (recovering files from raw disk data, no file-system dependency)
- Timestamp validation (inconsistent timestamps can indicate tampering)
- Comparison with known-good copies (via hash values)

**Example**: A vacation photo could have hidden data appended after its actual JPEG end-of-file marker — a hex editor reveals it.

## 5.4 Hashing
**Hashing** runs data of any size through a mathematical function to produce a fixed-length output (**hash value**/digest).

**Key characteristics**:
- One-way (cannot reverse a hash back into original data, unlike encryption)
- Used for integrity verification
- **Avalanche effect** — a 1-bit change in input causes a completely different output

### Common Hashing Algorithms
| Algorithm | Full Form | Output Length |
|---|---|---|
| MD5 | Message Digest 5 | 128-bit |
| SHA-1 | Secure Hash Algorithm 1 | 160-bit |
| SHA-256 | Secure Hash Algorithm 256-bit | 256-bit |
| SHA-3 | Secure Hash Algorithm 3 (based on Keccak) | 224–512 bits (configurable) |

**Uses**: file integrity checking; password storage (storing hash, not plaintext); digital signatures (core building block); forensic evidence verification (proving image = original).

⭐ **Important**: SHA-3 (Keccak, NIST competition winner 2012) uses a "sponge construction" instead of the older Merkle-Damgård structure, making it resistant to certain theoretical attacks that could affect SHA-2.

## 5.5 Hashing Download Links
Software/evidence sites publish hash values (MD5/SHA-256) alongside download links.

**Why**: verify integrity after download; ensure no tampering before download; prevent man-in-the-middle attacks (secretly intercepting/altering data in transit) or corruption.

**Forensic use**: analysts verify hashes of downloaded evidence/toolkits before using them, to confirm the tools themselves haven't been compromised.

**Linux example**: `sha256sum downloaded_file.iso` compared against the officially published hash before trusting a forensic tool ISO.

## 5.6 MD5 Hash Collisions
A **hash collision** = two different inputs produce the same hash output. MD5 is now cryptographically broken against deliberate collisions.

**Problems caused**: forging digital certificates/signatures; reduced trust in MD5 for cryptographic integrity.

**Flame Malware case**: Flame used a "chosen-prefix collision attack" against MD5 to forge a certificate that appeared legitimately signed by Microsoft. Since Windows Update still trusted MD5-signed certificates at the time, the forged certificate let Flame disguise itself as an official Windows Update and spread undetected.

⚠ **Exam Point**: Flame didn't hack Windows Update directly — it exploited MD5's cryptographic weakness, which Windows still trusted for certain legacy certificate types.

**Forensic response**: avoid MD5 for authentication/security-critical verification; prefer SHA-256 or higher.

## 5.7 Hash Collisions (General Concept)
Broader than the MD5 case — any hashing algorithm can theoretically produce a collision, though likelihood varies enormously.

**Why it matters**: undermines trust in data integrity; legal cases can be challenged if weak hashes are used; increases risk of malicious substitution.

**Collision-resistant algorithms (current standards)**: SHA-256, SHA-3.

⚠ **Exam Point**: "Collision-resistant" doesn't mean impossible — since inputs are infinite and outputs are fixed-length, collisions must theoretically exist (**pigeonhole principle**). It means finding one is currently computationally infeasible.

## 5.8 Bit Rot (Data Degradation)
**Bit rot / data decay** = gradual, unintended corruption of data on physical storage media over time, even if never touched.

**Causes**: aging storage media; radiation, magnetism, manufacturing defects; inadequate **ECC** (Error Correction Codes — extra data added to detect/auto-fix small errors).

**Impact in forensics**: file corruption; hash mismatches even without human interference; may require recovery efforts.

### Recovery Tools
| Tool | Purpose |
|---|---|
| TestDisk | Recovering lost partitions, repairing damaged file systems |
| ddrescue | Linux tool for copying data from a failing drive, skipping/retrying bad sectors |

**Prevention**: regular backups; ECC-enabled systems; periodic integrity verification with checksums/hashes.

⭐ **Important**: An unexplained hash mismatch caused purely by bit rot (not tampering) must be properly documented, or it could wrongly be mistaken for evidence tampering in court.

---

# SESSION 6: SOPs & Windows/DOS Crime Scene Processing

## 6.1 Standard Operating Procedures (SOPs)
**SOPs** are formally documented, step-by-step procedures defining exactly how forensic tasks must be performed, every time, regardless of who does the work.

- **Standard** → a fixed, agreed-upon benchmark
- **Operating** → how the actual work is carried out
- **Procedures** → the specific sequence of steps

**Why critical**: prevent contamination/loss of evidence; ensure repeatability of results; help pass legal scrutiny in court; guide even under high-stress, real-time incidents.

### Core Elements of a Forensic SOP
| Step | Description |
|---|---|
| Preparation | Ensure tools, team, legal authority, documentation ready |
| First Response | Secure the scene and systems |
| Preservation | Isolate system, create forensic images |
| Examination | Analyze systems with proper (non-invasive) tools |
| Documentation | Record everything (tools, hashes, timeline) |
| Reporting | Generate a formal report |
| Review | Internal review and continuous improvement |

```
Preparation -> First Response -> Preservation -> Examination
     -> Documentation -> Reporting -> Review -> (feeds back into Preparation)
```

⭐ **Important**: "Review" as a final step is a distinct addition here compared to Session 1's six-stage model — teams must learn from each case to improve their SOPs over time.

## 6.2 Processing Crime and Incident Scenes: Windows & DOS

### Before Touching the System
Regardless of OS, first actions must never alter anything:
- Photograph the system and environment
- Document all visible information (including what's on-screen)
- Record connected peripherals (USB drives, network cables, external disks)
- Note powered-on status, displayed time, background applications

⚠ **Exam Point**: This directly echoes the Session 3 "First Response" Golden Rule — do not alter anything before OS-specific action begins.

### Working with Powered-On Systems

| Step | Windows | DOS |
|---|---|---|
| Capture RAM | FTK Imager Lite, Belkasoft RAM Capturer | Not applicable — DOS has no protected/virtual memory to meaningfully "dump" |
| Get running processes | `tasklist`, `wmic`, Volatility (deeper) | Limited to TSR (Terminate-and-Stay-Resident) programs |
| Open ports/network info | `netstat`, `ipconfig`, TCPView | No networking (DOS has no built-in TCP/IP stack) |
| Dump registry | `reg save` | DOS has no registry |
| Screenshot current screen | Snipping Tool, nircmd | Physical camera only (no software screenshot capability) |

**TSR (Terminate-and-Stay-Resident) explained**:
- **Terminate** → the program technically ends its main execution
- **Stay** → instead of freeing memory back to the system
- **Resident** → it deliberately remains loaded in RAM

TSR programs were DOS's primitive way of simulating background tasks (DOS had no real multitasking). Examples: early antivirus scanners, pop-up utilities.

💡 **Remember**: In DOS forensics, "processes" barely exist as modern investigators understand them — the closest equivalent is checking loaded TSR programs.

### Shut Down or Not?
**Best practice**: Preserve live memory before powering down — RAM holds volatile evidence (malware, encryption keys, open connections) lost the instant power is cut.

**Key risk**: If a drive is encrypted with a key only held in RAM, powering off could make the entire disk permanently inaccessible.

**If forced to power off**:
1. Perform forensic imaging immediately (RAM and disk state first, if possible)
2. Avoid a normal shutdown — pull the power directly instead

⚠ **Exam Point (Why unplug, not shutdown?)**: A normal shutdown triggers OS cleanup processes that could overwrite/alter evidence (temp files, logs) in the final seconds. Pulling the plug freezes the system state as close as possible to how it was found.

```
Live System Found
       |
       v
  Capture RAM (if possible)
       |
       v
Decision: Must power off?
       |
   Yes v
Pull Power Directly (NOT normal shutdown)
       |
       v
Immediately Begin Forensic Imaging
```

### Imaging Disks (Preservation)
Use write blockers alongside trusted tools:
- FTK Imager
- Guymager
- `dd` — for DOS systems (which cannot run modern forensic software), investigators boot the target machine with a bootable forensic Linux OS (e.g., CAINE) and image the drive from there
- EnCase

### Examining Files

**Windows** — key locations:
- `C:\Users\` profiles
- AppData, Prefetch, Recent, Recycle Bin
- Windows Event Logs (`.evtx` files)
- Registry hives: **NTUSER.DAT** (per-user settings), **SAM** (Security Account Manager — local user accounts/password hashes), **SYSTEM** (services, drivers, hardware config)

⭐ **Important — Prefetch files**: Prefetch creates a `.pf` file every time a program runs, recording the executable name, run count, and up to eight last-execution timestamps. Prefetch answers the most common investigative question: **"Did this program actually run on this system?"**

**DOS** — key locations:
- `.BAT` files, `AUTOEXEC.BAT`, `CONFIG.SYS` (startup scripts)
- Custom scripts / resident programs (`.COM`, `.EXE`) — since DOS has almost no automatic logging

💡 **Remember**: `AUTOEXEC.BAT` is DOS's rough equivalent of Windows Registry "Run" keys — both are classic places to check for auto-starting programs.

### Special Considerations for DOS Systems
DOS still persists in legacy environments: industrial control systems (ICS), ATMs, legacy embedded hardware.

| Characteristic | Impact |
|---|---|
| No multitasking | No background logging |
| No registry | Fewer artifacts to examine |
| File system | FAT16/FAT32 (older, simpler than NTFS) |
| Log files | Very limited (not designed for security auditing) |

⚠ **Exam Point**: Because DOS offers few software-based artifacts, disk-level analysis becomes critical — investigators rely heavily on raw file carving and manual byte-level inspection (hex editor skills from Session 5).

### Reporting & Chain of Custody
Same documentation discipline applies regardless of OS: exact time of every interaction, every command/tool used, hashes of all collected evidence, proper Evidence Forms and Chain-of-Custody Logs.

### Tools for Windows and DOS Forensics
| Tool | Platform | Use |
|---|---|---|
| FTK Imager | Windows | Imaging, preview |
| Volatility | Windows memory | RAM analysis |
| Autopsy/Sleuth Kit | Cross-platform | File, metadata, timeline analysis |
| DOSBox + Disk Editors | DOS | Simulate/analyze DOS apps in a safe, isolated environment |
| WinHex | Both | Hex editing, forensic imaging |

**DOSBox**: An emulator recreating a DOS environment on a modern computer — used to safely run a suspicious `.EXE`/`.COM` from a DOS system in an isolated sandbox, without risking the evidence machine.

### Best Practices Summary
- Minimize interaction — don't alter anything unless absolutely necessary
- Always use write-blockers before touching any original storage device
- Clone first, analyze later — never analyze the original directly
- DOS: focus on disk-level evidence and manual log inspection
- Windows: prioritize registry hives, event logs, prefetch files, and RAM dump

---

# SESSION 7: Accreditation, Investigation Lifecycle & Privacy

## 7.1 Accreditation Standards in Cyber Forensics

### What Is Accreditation?
Formal recognition, given by an authorized independent body, confirming a forensic lab/investigator is competent per internationally accepted standards — third-party proof of competence, not just self-claimed.

### Why It Matters
- Ensures credibility of evidence in court
- Confirms chain of custody and data handling rules are followed
- Verifies tools/methods meet quality benchmarks
- Guarantees repeatability/reproducibility of findings
- Enables cross-border cooperation in investigations

⭐ **Important**: Accreditation turns "trust me, I'm a professional" into "here is documented proof my lab meets an internationally recognized bar."

### Common Accreditation Standards
| Standard | Description |
|---|---|
| ISO/IEC 17025 | For testing/calibration labs — technical competence and quality management |
| ISO/IEC 27037 | Guidelines for identification, collection, acquisition, and preservation of digital evidence |
| ISO/IEC 27042 | Guidelines for analysis and interpretation of digital evidence |
| NIST SP 800-101 | Guidelines on Mobile Device Forensics |
| SWGDE & SWGIT | Best practices for digital and multimedia evidence (US-based) |
| FISMA/NIST 800-53 | Security standards for federal information systems |

**Acronym breakdowns**:

**ISO/IEC** — International Organization for Standardization / International Electrotechnical Commission
- International → applies across countries
- Organization for Standardization → creates consistent technical benchmarks
- Electrotechnical Commission → partner body for electrical/electronic technology standards

⚠ **Exam Point**: ISO/IEC 27037 = front end (collect/preserve). ISO/IEC 27042 = back end (analyze/interpret). Remember: **27037 = collect, 27042 = analyze**.

**NIST** — National Institute of Standards and Technology
- National → the official US government standards body
- Institute of Standards and Technology → creates measurement/technology standards
- NIST SP 800-101 addresses mobile forensics specifically because phones store data very differently (flash memory wear-leveling, SIM data, app-specific storage)

**SWGDE / SWGIT** — Scientific Working Group on Digital Evidence / Scientific Working Group on Imaging Technology
- SWGDE → general digital evidence (computers, phones, networks)
- SWGIT → photographic/video evidence (CCTV footage, digital photos)

**FISMA** — Federal Information Security Management Act
- Federal → applies to US government agencies
- Information Security → protecting confidentiality, integrity, availability of data
- Management Act → a law requiring formal security management practices
- NIST SP 800-53 implements FISMA's requirements as a detailed technical control catalog

### Tool Accreditation
Tools themselves (EnCase, FTK, Autopsy) must also be validated:
- Tools must produce repeatable, verifiable results
- Labs maintain a tool validation repository documenting each tool version's tested accuracy

💡 **Remember**: A perfect procedure using a buggy, unverified tool still produces unreliable evidence.

## 7.2 Performing a Cyber Forensics Investigation — 9-Phase Lifecycle

This builds on Session 1's six-stage model and Session 2's eight-step procedure into the most detailed version.

| Phase | Description |
|---|---|
| 1. Preparation | Define scope, obtain legal authorization, prepare tools |
| 2. Identification | Identify affected systems, evidence sources |
| 3. Preservation | Write blockers, forensic images, chain of custody |
| 4. Collection | Collect logs, memory, drives, network packets |
| 5. Examination | Search for deleted files, malware, timestamps |
| 6. Analysis | Reconstruct timeline, detect attacker actions |
| 7. Documentation | Record every action, evidence logs, hashes, findings |
| 8. Reporting | Detailed formal report; screenshots, artifacts, tools used |
| 9. Presentation (in court) | Explain findings clearly and admissibly |

```
Preparation -> Identification -> Preservation -> Collection -> Examination
   -> Analysis -> Documentation -> Reporting -> Presentation (Court)
```

⚠ **Exam Point**: This 9-phase model merges Sessions 1–3 into one master framework. Unlike Session 1's model (which bundles documentation implicitly into "Presentation"), this version explicitly separates **Documentation** and **Reporting** as two distinct phases.

### Common Tools by Category
| Category | Tools |
|---|---|
| Disk & memory imaging | FTK Imager, dd, Magnet RAM Capture |
| Analysis | Autopsy, EnCase, X-Ways, Volatility |
| Network forensics | Wireshark, TCPDump |
| Log analysis | Splunk, ELK Stack |

- **Magnet RAM Capture** — free tool for capturing live RAM for later Volatility analysis
- **X-Ways Forensics** — lightweight, fast commercial suite, resource-efficient vs EnCase
- **TCPDump** — command-line packet capture (Linux/Unix); terminal sibling of Wireshark
- **ELK Stack** — **E**lasticsearch, **L**ogstash, **K**ibana — collects, searches, and visualizes large volumes of log data

## 7.3 Privacy and Cyber Forensics
Investigators must balance thorough investigation with the legal/ethical obligation to respect privacy.

### Key Privacy Concerns
- Right to privacy vs. need for investigation
- Handling **PII** (Personally Identifiable Information — name, address, national ID, biometric data, health records)
- Legal compliance with GDPR, HIPAA, IT Act, etc.
- Data minimization and consent-based access

⭐ **Important**: **Data minimization** — investigators shouldn't examine an entire device just because they have access; focus strictly on what's relevant to the case scope.

### Forensic Analyst's Responsibilities
- Avoid unnecessary exploration of private data
- Maintain confidentiality of all findings
- Never exceed the scope of authorization
- Anonymize/redact non-relevant PII in reports
- Securely store and dispose of sensitive evidence

⚠ **Exam Point**: Exceeding scope of authorization is one of the fastest ways evidence gets thrown out of court — even genuinely incriminating evidence may be ruled inadmissible if collected outside legal authorization boundaries.

### Legal Acts to Know
| Law | Region | Focus |
|---|---|---|
| GDPR | European Union | Consent, data protection, right to erasure |
| IT Act 2000 | India | Unauthorized access, identity theft, cybercrimes |
| HIPAA | United States | Protects medical records |
| Privacy Act | United States | Controls access to federal government agency data |

**GDPR** — General Data Protection Regulation
- General → applies broadly to essentially all personal data processing
- Data Protection → core purpose: safeguarding personal information
- Regulation → binding EU law, not a voluntary guideline

**Right to Erasure ("Right to be Forgotten")**: Individuals can request deletion of personal data under specific conditions (data no longer necessary, consent withdrawn). Not absolute — doesn't apply when data must be retained for legal obligations, freedom of expression, or ongoing legal claims.

⚠ **Exam Point (nuance)**: GDPR's Article 17(3)(e) "legal claims" exception generally allows investigators to retain evidence needed for an active legal case even if a deletion request is made mid-investigation — privacy rights do not automatically block a lawful, ongoing investigation.

**HIPAA** — Health Insurance Portability and Accountability Act
- Health Insurance → medical coverage/health data
- Portability → health insurance can move with a person across jobs
- Accountability → organizations held responsible for protecting patient data

💡 **Remember**: In a hospital database breach investigation, HIPAA compliance is just as important as the technical forensic process.

## 7.4 Quick Reference Summary
| Area | Importance |
|---|---|
| Accreditation | Ensures evidence is legally valid/reliable; people AND tools meet international standards |
| Investigation Process | Structured 9-phase model, preparation to courtroom presentation |
| Privacy | Balance investigation needs against privacy rights via data minimization and scope discipline |

---

# SESSION 8: Forensic Toolkit — Sysinternals, FTK, OSForensics, Hex Editors

## 8.1 Overview of Forensics Tools
Forensic tools make manual procedural concepts (imaging, hashing, chain of custody) actually executable. Five core jobs:
- Collect and preserve evidence
- Perform analysis on disk, memory, network data
- Recover deleted files
- Extract and visualize artifacts
- Maintain integrity with hashing and chain-of-custody features

### Categories of Forensic Tools
| Category | Examples |
|---|---|
| Disk Forensics | FTK, EnCase, Autopsy, OSF |
| Memory Forensics | Volatility, Rekall |
| Network Forensics | Wireshark, NetworkMiner |
| Registry Analysis | RegRipper, Registry Explorer |
| General System Utilities | Sysinternals Suite, NirSoft tools |
| Hex Editors | HxD, WinHex, 010 Editor |

⭐ **Important**: A real investigation almost never uses just one tool — a typical case moves through Sysinternals (live triage) → FTK Imager (capture) → Autopsy/FTK (deep analysis) → hex editor (manual verification).

## 8.2 Sysinternals Suite
**Developed by**: Microsoft, originally created by Mark Russinovich. A collection of small, powerful Windows utilities for diagnostics, troubleshooting, incident response, and live forensics — mostly portable single-executable tools requiring no installation.

| Tool | Function |
|---|---|
| Process Explorer | Detailed process view (more detail than Task Manager) |
| Autoruns | Shows startup programs, drivers, scheduled tasks |
| PsExec | Executes commands remotely on other Windows machines |
| TCPView | Lists all currently open network connections |
| Handle.exe | Shows which processes have which files currently open |
| RAMMap | Detailed, low-level memory usage breakdown |

**Why each matters**:
- **Process Explorer** — shows process tree, loaded DLLs, CPU/memory usage; can reveal malware disguised as a legitimate process name
- **Autoruns** — scans nearly every known autostart location in one view, far more thoroughly than manually checking the Startup folder
- **PsExec** — useful for running diagnostics across many machines remotely; also abused by attackers for lateral movement, so its presence in logs can itself be a red flag
- **TCPView** — maps which process is talking to which remote IP/port (links to network forensics)
- **Handle.exe** — reveals exactly which process is locking a file that's "in use"
- **RAMMap** — deeper memory breakdown than Task Manager, useful for spotting abnormal consumption patterns

**Forensics use cases**: investigating suspicious processes/malware; dumping a running process's memory; mapping network ports to processes; monitoring unauthorized startup programs; live system inspection without heavy tool installs.

💡 **Remember**: Sysinternals tools are ideal for **live forensics** — gathering info from a running system quickly, before the "Shut Down or Not?" decision (Session 6).

## 8.3 FTK (Forensic Toolkit)
**Developed by**: Originally AccessData; now owned and actively developed by **Exterro**, following Exterro's acquisition of AccessData. *(Correction: older material lists only AccessData — mentioning current Exterro ownership matters for exam accuracy.)*

A comprehensive, **GUI**-based (Graphical User Interface — buttons/windows instead of typed commands) forensic analysis tool used by law enforcement, corporate investigators, and auditors.

### Key Features
- Full disk and partition analysis
- File carving (recovering deleted files from raw data)
- Registry analysis
- Email parsing and indexing
- Timeline and hash analysis
- Custom keyword searching (across an entire disk image)
- Strong reporting features (court-ready formal reports)

**Forensics use cases**: disk analysis across NTFS, FAT32, exFAT; case management; recovering email attachments/artifacts/chat histories; file signature mismatch detection.

⚠ **Exam Point**: File signature mismatch detection automatically flags every renamed file across an entire disk image — huge time savings vs manual hex-editor inspection file by file.

## 8.4 FTK Imager
A separate, lightweight tool focused specifically on **imaging and previewing** evidence — distinct from the full FTK analysis suite.

⭐ **Important distinction**: **FTK Imager** creates and previews forensic images (Preservation/Collection stage). **Full FTK** analyzes those images in depth (Examination/Analysis stage). These are commonly confused but serve different investigation stages.

### Key Features
- Creates bit-by-bit images in multiple formats: E01, AFF, RAW
- Calculates/verifies hash values (MD5, SHA1)
- Previews contents without altering original media
- Extracts specific files/folders without imaging the entire disk
- Captures RAM dumps

**Forensics use cases**: creating forensically sound images; validating integrity via hash comparison; viewing deleted/hidden files inside an image; creating portable snapshots of USB/CD/HDD.

💡 **Remember**: FTK Imager is free — one of the most widely used tools in the field for that reason.

**Workflow example**: Investigator plugs a suspect's USB into a forensic workstation with a write blocker, opens FTK Imager, selects the physical drive, chooses E01 format, lets it run (auto-calculating MD5/SHA1), then hands the resulting image — never the original drive — to the analysis team for further work in full FTK or Autopsy.

## 8.5 OSForensics (OSF)
**Developed by**: PassMark Software. A feature-rich, all-in-one forensic suite favored for rapid, on-the-spot analysis.

### Key Features
- Search files by keyword, hash, or content
- Analyze browser history and email archives
- File system and registry viewer
- Password cracking
- Timeline visualization
- Disk imaging and drive cloning
- Hash set management

**Forensics use cases**: triage tool for rapid field analysis ("triage" = quickly assessing evidence on-site to decide what deserves deeper investigation); comprehensive artifact analysis for Windows; hash matching against **NSRL** (National Software Reference Library — a US government-maintained database of known file hashes, used to identify known malicious or known-legitimate files instantly); viewing/recovering deleted emails/system files.

⚠ **Exam Point**: NSRL matching works both ways — flags known malware/illegal-content hashes, AND rules out thousands of harmless standard OS files, dramatically reducing manual review load.

## 8.6 Hex Editors (HxD, WinHex, 010 Editor)
Let you view/edit binary files at the byte level, showing hex values and equivalent ASCII characters side by side.

| Tool | Notes |
|---|---|
| HxD | Free, lightweight, easy for quick binary inspection |
| WinHex | Professional; dedicated forensic functions (imaging, hashing) |
| 010 Editor | Advanced hex templates for parsing structured binary formats automatically |

**Forensics use cases**: examine headers/footers; detect file signature mismatches manually; recover partially deleted files; identify malicious binary content; read slack space and unallocated space manually.

⭐ **Important — Slack space vs Unallocated space**:
- **Slack space** = leftover unused space at the end of the last allocated cluster (files rarely fill a cluster exactly); old deleted data can remain here even after a new file overwrites the visible portion.
- **Unallocated space** = disk space the file system considers empty/available, but which may still contain full contents of previously deleted files until overwritten.

Hex editors let investigators manually browse these hidden zones that normal file browsing completely ignores.

## 8.7 Quick Reference: Tool Comparison
| Tool | Best For | Strength |
|---|---|---|
| Sysinternals | Live system analysis | Portable and powerful |
| FTK | Disk, email, registry analysis | Enterprise-grade |
| FTK Imager | Imaging & preview | Fast and free |
| OSF | All-in-one forensics | UI-rich, feature-packed |
| Hex Editors | Byte-level file analysis | Precision & control |

💡 **Remember**: Each tool occupies a specific niche in the investigation lifecycle (live triage → imaging → deep analysis → manual byte-level verification); real cases typically move through several tools in sequence.

---

# SESSION 9 & 10: Live Forensics, Linux Forensics & Mobile Forensics

## 9.1 Live Forensics (Active State Analysis)

### Definition
**Live forensics** = collecting volatile (temporary, easily-lost) data from a system that is still powered on and running, before it is shut down or altered.

### Why It Exists
On a powered-on system, certain evidence exists only while power is maintained: critical evidence in RAM; active encryption keys; running processes, open connections, and logs that vanish on shutdown.

### The Order of Volatility (RFC 3227)
**RFC 3227** (Request for Comments — the format used to publish official internet protocol standards) defines the correct evidence collection sequence, from most volatile to least volatile:

1. CPU registers and cache (changes constantly, disappears in nanoseconds)
2. Routing table, ARP cache, process table, kernel statistics, RAM
3. Temporary file systems
4. Disk
5. Remote logging and monitoring data
6. Physical configuration, network topology
7. Archival media (backups, offline storage)

⚠ **Exam Point**: This order exists because evidence must be collected starting with what disappears fastest — imaging the disk first while ignoring RAM would be a critical mistake, since RAM evidence could vanish during that time.

### Volatile Data Includes
RAM contents; running processes (`ps`, `tasklist`); network connections (`netstat`, `lsof`); loaded DLLs or kernel modules; clipboard contents; open files; system uptime/logged-in users; cache, ARP table (Address Resolution Protocol — maps IP addresses to physical hardware addresses), routing table.

### Tools Used in Live Forensics
| Platform | Tools |
|---|---|
| Windows | Sysinternals Suite, Volatility, DumpIt, FTK Imager (RAM capture), WinPMEM |
| Linux | dd, lsof, netstat, top, ps, LiME (Linux Memory Extractor), Volatility |
| Mac | OSX Collector, fs_usage, lsof, Instruments |

- **DumpIt** — simple, one-click Windows RAM imaging tool for emergency situations
- **WinPMEM** — open-source Windows memory acquisition tool, part of the Rekall/GRR forensic frameworks
- **LiME (Linux Memory Extractor)** — a Loadable Kernel Module (LKM) that captures Linux RAM contents forensically soundly; the Linux equivalent of FTK Imager's RAM capture
- **OSX Collector** — gathers a broad snapshot of Mac forensic artifacts in one run
- **fs_usage / Instruments** — Mac-native tools tracking file system activity and detailed process/system performance

### Considerations for Live Forensics
- Document every command and step
- Ensure chain of custody and hash all collected data
- Use write blockers for storage collection
- Avoid running unknown binaries on the suspect machine (risk of a trojanized/backdoored tool altering evidence or alerting an attacker)
- Perform memory acquisition first (Order of Volatility)

```
System Found Powered On
         |
         v
Capture Most Volatile First: CPU Registers/Cache
         |
         v
Capture RAM (Volatility/LiME/FTK Imager/DumpIt)
         |
         v
Capture Network State (netstat/ss), Running Processes (ps/tasklist)
         |
         v
Capture Temporary Files, then Disk Image
         |
         v
Capture Remote Logs, Configs, Archives (Least Volatile)
```

💡 **Remember**: Live forensics directly connects to Session 6's "Shut Down or Not?" decision — its entire purpose is to capture volatile evidence *before* that decision has to be made.

## 9.2 Linux Forensics (Artefact Collection & Analysis)

### Overview
Linux forensics involves collecting/analyzing evidence from Linux systems — especially important since Linux dominates server environments, cloud infrastructure, and embedded/IoT devices.

### Key Artefacts in Linux
| Artefact Type | Command/Location |
|---|---|
| Logs | `/var/log/`, `/var/log/auth.log`, `/var/log/syslog`, `journalctl` |
| Running Processes | `ps aux`, `top`, `/proc` |
| Scheduled Jobs | `crontab -l`, `/etc/cron.*` |
| User Activity | `.bash_history`, `~/.ssh/`, `w`, `last` |
| Network Activity | `netstat`, `ss`, `iptables -L` |
| Mounted Devices | `mount`, `lsblk`, `df -h` |
| Open Files | `lsof`, `/proc/<pid>/fd/` |
| Memory Analysis | LiME, `dd if=/dev/mem`, Volatility |
| Installed Software | `dpkg -l` (Debian/Ubuntu), `rpm -qa` (RedHat/CentOS) |
| System Time | `date`, `uptime` |

**What each artefact reveals**:
- `/var/log/auth.log` — every login attempt, sudo command, SSH connection; often the first place checked for unauthorized access
- `journalctl` — queries systemd's centralized logging (modern Linux distros like Ubuntu 16.04+), consolidating logs from many services
- `/proc` — a virtual file system exposing live kernel/process information as if it were regular files; how `ps` and `top` actually get their data
- `crontab -l` / `/etc/cron.*` — reveal scheduled tasks; attackers commonly plant cron jobs for persistence after reboot
- `.bash_history` — every command a user typed; valuable but easily deleted/edited by a careful attacker, so must be treated as potentially incomplete
- `~/.ssh/` — SSH keys and known-hosts records, revealing which remote systems a user connected to
- `w` and `last` — currently logged-in users and historical login sessions respectively

⚠ **Exam Point**: `/proc/<pid>/fd/` (fd = file descriptor) shows exactly which files a running process has open — the Linux equivalent of Sysinternals' Handle.exe (Session 8).

### Linux Forensic Tools
| Tool | Purpose |
|---|---|
| Autopsy and The Sleuth Kit | Offline disk analysis |
| Chkrootkit, rkhunter | Rootkit detection (rootkit = malware hiding its own presence deep within the OS) |
| Auditd | Audit logs for detailed system activity |
| Strace | Tracks system calls made by a running program |
| Volatility + LiME | Memory acquisition and analysis |

**Strace**: intercepts and records every system call (a request a program makes to the kernel, e.g., opening a file or making a network connection) a program makes while running — lets an investigator watch exactly what a suspicious program does, step by step, for malware behavior analysis (links to Session 5).

### Special Considerations for Linux
- Most Linux systems use journaling filesystems (ext4, XFS) — a journaling filesystem logs pending changes before committing them, which often makes deleted-file recovery easier than on simpler filesystems
- Manage permissions/mount options carefully during analysis — e.g., mounting with `noexec` (prevents accidentally executing a program from the drive) and `nosuid` (prevents privilege-escalation programs from running)
- Preserve metadata and use read-only mounts — mounting a suspect drive normally can update access timestamps, so investigators always mount with `ro` (read-only)

💡 **Remember**: `noexec`, `nosuid`, and `ro` together form a defensive combination — safely browsing an evidence drive without accidentally running malware or altering timestamps.

## 9.3 Introduction to Mobile Forensics

### What Is Mobile Forensics?
The science of recovering digital evidence specifically from mobile devices — a specialized branch because mobile devices store and protect data very differently from traditional computers.

### Scope of Mobile Forensics
Call logs; **SMS/MMS** (Short Message Service / Multimedia Messaging Service); contacts; images/videos; app data (WhatsApp, Telegram, Instagram, etc.); location data (GPS, cell tower logs); web browsing history; deleted data and system logs.

### Challenges in Mobile Forensics
- Rapid evolution of mobile OS (Android/iOS) — new versions frequently change security models, breaking older techniques
- Strong encryption — Full Disk Encryption; **Secure Enclave** (Apple's dedicated hardware chip storing encryption keys isolated from the main processor, making key extraction extremely difficult)
- Locked bootloaders — the bootloader controls what software runs at startup; a locked bootloader prevents installing custom forensic software
- App sandboxing — each app's data is isolated from other apps, limiting extraction without special permissions
- Cloud backups/syncing — data may exist only in the cloud, requiring separate cloud forensics techniques
- Multiple file systems: YAFFS2 (older Android), ext4 (modern Android), APFS (modern iOS)

⚠ **Exam Point**: Secure Enclave is a hardware-level protection, not just software encryption — this is why even law enforcement has historically struggled to unlock modern iPhones without the passcode.

### Tools Used in Mobile Forensics
| Tool | Platform | Description |
|---|---|---|
| Cellebrite UFED | Android/iOS | Industry-standard for mobile data extraction |
| Magnet AXIOM | Android/iOS | Deep mobile + cloud + app analysis |
| Oxygen Forensics Detective | Android/iOS | Logical and physical extraction |
| ADB | Android | Android Debug Bridge — command-line tool for basic device access |
| Elcomsoft Mobile Forensics | iOS | Bypassing passcodes and iCloud sync |
| iTunes Backup | iOS | Parsed for data when the device itself is inaccessible |

**ADB explained** — Android Debug Bridge:
- Android → Google's mobile operating system
- Debug → originally designed for developers to test/troubleshoot apps
- Bridge → connects a computer to an Android device to send commands and retrieve data

ADB requires USB debugging mode enabled beforehand — if the device is locked and USB debugging wasn't already enabled, ADB commands generally cannot retrieve data.

### Types of Extraction
| Type | Description |
|---|---|
| Logical | Extracts visible, accessible data only (contacts, SMS, app data) — no unallocated/deleted space |
| File System | Extracts the entire file system including metadata — captures more, including some deleted items within app databases |
| Physical | Full bit-by-bit clone of the storage chip — requires root/jailbreak access, or advanced hardware techniques (JTAG, chip-off) |

⭐ **Important — JTAG and Chip-off**:
- **JTAG** (Joint Test Action Group) — a hardware-level technique connecting to specific test access ports on the circuit board to extract data directly from the memory chip, bypassing the OS entirely
- **Chip-off** — an even more invasive technique; the memory chip is physically desoldered and removed, then read using specialized chip-reading hardware

⚠ **Exam Point**: Both JTAG and chip-off require specialized training and carry real risk of permanently damaging the device — chip-off is typically irreversible, used only when all other methods have failed.

```
Extraction Depth (Least to Most Invasive)
Logical  ->  File System  ->  Physical (root/jailbreak)  ->  JTAG  ->  Chip-off
(most accessible)                                                (most invasive, most complete)
```

### Mobile Forensics Best Practices
- Isolate the device — Airplane mode or a **Faraday bag** (a bag lined with conductive material blocking all incoming/outgoing wireless signals, preventing remote wipe or new data syncing)
- Avoid automatic OS updates (could overwrite evidence or patch the vulnerability a forensic tool relies on)
- Disable fingerprint/unlock if legally possible (reduces auto-lock/security-wipe risk)
- Document everything
- Extract data using proper, validated tools
- Always hash backups and images

💡 **Remember**: A Faraday bag is critical because a seized phone still connected to a network could be remotely wiped by the owner (or an accomplice) the moment they realize it's been seized.

## Quick Reference Summary (Sessions 9 & 10)
| Topic | Focus | Key Tools |
|---|---|---|
| Live Forensics | Volatile memory, active sessions | Volatility, FTK Imager, Sysinternals |
| Linux Forensics | Logs, processes, file systems | Autopsy, LiME, Sleuth Kit, bash logs |
| Mobile Forensics | Apps, call logs, cloud syncs | Cellebrite, Oxygen, Magnet AXIOM |

---

# MASTER QUICK REFERENCE CARD

## Forensic Process Models (Compare)
| Model | Steps | Source |
|---|---|---|
| Six-Stage Model | Identification → Preservation → Collection → Examination → Analysis → Presentation | Session 1 |
| 8-Step SOP | Preparation → Detection → Isolation → Preservation → Collection/Extraction → Analysis/Interpretation → Reporting → Legal Support | Session 2 |
| SOP Core Elements | Preparation → First Response → Preservation → Examination → Documentation → Reporting → Review | Session 6 |
| 9-Phase Investigation Lifecycle | Preparation → Identification → Preservation → Collection → Examination → Analysis → Documentation → Reporting → Presentation | Session 7 |

## Hashing Algorithms
| Algorithm | Output | Status |
|---|---|---|
| MD5 | 128-bit | Broken for security use (collision-prone); avoid for authentication |
| SHA-1 | 160-bit | Considered weak, being phased out |
| SHA-256 | 256-bit | Current standard, collision-resistant |
| SHA-3 | 224–512 bit | Newest, structurally different (sponge construction) |

## Core Legal/Standard References
| Term | Full Form | Purpose |
|---|---|---|
| IT Act 2000 | Information Technology Act, 2000 | India's cybercrime/e-commerce law |
| GDPR | General Data Protection Regulation | EU data privacy law |
| HIPAA | Health Insurance Portability and Accountability Act | US medical data privacy |
| DPDP Act 2023 | Digital Personal Data Protection Act | India's enacted data privacy law (successor to PDP Bill) |
| ISO/IEC 27037 | — | Evidence identification/collection/preservation guidelines |
| ISO/IEC 27042 | — | Evidence analysis/interpretation guidelines |
| RFC 3227 | Request for Comments 3227 | Defines the Order of Volatility |
| NIST SP 800-101 | — | Mobile device forensics guidelines |

## Order of Volatility (Most → Least Volatile)
1. CPU registers/cache
2. Routing table, ARP cache, process table, kernel stats, RAM
3. Temporary file systems
4. Disk
5. Remote logs/monitoring data
6. Physical configuration/network topology
7. Archival media

---

# VIVA / EXAM Q&A BANK

**Q1: What is the difference between Computer Crime and Unauthorized Activity?**
A: Computer Crime is an illegal act involving computers as target/tool, punishable under cyber laws. Unauthorized Activity violates internal policy but is not necessarily illegal.

**Q2: Why was Section 66A of the IT Act struck down?**
A: The Supreme Court struck it down in 2015 (*Shreya Singhal v. Union of India*) for being unconstitutional and vague.

**Q3: What is the difference between the Session 1 six-stage model and the Session 7 nine-phase model?**
A: The nine-phase model explicitly separates Documentation and Reporting as two distinct phases, while the six-stage model bundles documentation implicitly within Presentation.

**Q4: Why is a write blocker used during collection?**
A: It physically/digitally prevents any write command from reaching the original evidence, preserving its legal integrity (even opening a file can change access timestamps).

**Q5: What is Chain of Custody and why does it matter?**
A: A chronological record of who handled evidence, when, where, and why. Any gap allows a defense lawyer to argue tampering, risking evidence dismissal.

**Q6: What is the Order of Volatility and why does it matter?**
A: RFC 3227's sequence for evidence collection (most to least volatile: CPU registers → RAM → disk → archival media). It matters because volatile evidence disappears fastest, so it must be captured first.

**Q7: Why pull the plug instead of a normal shutdown on a live system that must be powered off?**
A: A normal shutdown runs OS cleanup processes that can overwrite/alter evidence in the final seconds. Pulling the plug freezes the system state as-is.

**Q8: What's the difference between FTK Imager and full FTK?**
A: FTK Imager creates/previews forensic images (Preservation/Collection stage). Full FTK analyzes those images in depth (Examination/Analysis stage).

**Q9: What is the difference between Encoding and Encryption?**
A: Encoding converts data for compatibility and needs no secret key to reverse (e.g., Base64). Encryption hides data for confidentiality and requires a secret key to reverse (e.g., AES).

**Q10: What is a hash collision, and why is MD5 considered broken?**
A: A hash collision is when two different inputs produce the same hash output. MD5 is broken because deliberate collisions can be engineered (e.g., the Flame malware forged a certificate using an MD5 collision).

**Q11: What is the difference between IDS and IPS?**
A: IDS passively monitors and alerts (out-of-band). IPS actively blocks malicious traffic in real time (inline), at the cost of slight latency.

**Q12: What is Bit Rot and why is it forensically significant?**
A: The gradual, unintended corruption of stored data over time. It can cause hash mismatches unrelated to tampering, which must be documented carefully or it could be mistaken for evidence tampering in court.

**Q13: What is the difference between ISO/IEC 27037 and 27042?**
A: 27037 covers collection/preservation (front end); 27042 covers analysis/interpretation (back end).

**Q14: Why is data minimization important in forensic investigations?**
A: Investigators must only examine data relevant to the case scope, respecting privacy rights; exceeding authorized scope risks evidence being ruled inadmissible.

**Q15: What is Prefetch and why is it valuable in Windows forensics?**
A: A `.pf` file created every time a program runs, recording the executable name, run count, and up to eight last-execution timestamps. It answers "Did this program actually run on this system?"

**Q16: What is the difference between Logical, File System, and Physical mobile extraction?**
A: Logical = visible/accessible data only. File System = entire file system including some deleted items in app databases. Physical = full bit-by-bit chip clone, requiring root/jailbreak or hardware techniques (JTAG, chip-off).

**Q17: Why is a Faraday bag used in mobile forensics?**
A: It blocks all wireless signals to the device, preventing remote wipe commands or new data syncing after seizure.

**Q18: What is the significance of the "Right to Erasure" exception under GDPR Article 17(3)(e) for forensic investigators?**
A: It allows investigators to retain evidence needed for an active legal case even if the data subject requests deletion — privacy rights do not automatically block a lawful, ongoing investigation.

**Q19: What is Slack Space vs Unallocated Space?**
A: Slack space is unused space at the end of the last allocated cluster of a file, which can still hold old deleted data. Unallocated space is disk space marked as free by the file system but which may still contain full contents of previously deleted files.

**Q20: Why is repeatability important in forensic investigation?**
A: Another qualified investigator following the same steps on the same evidence copy should reach the same result — this is what makes forensic findings scientifically credible in court.
