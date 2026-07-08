# Web Application Security — Session 5 & 6 Notes

### Session 5 (4T+4L+4SL) — Theory
SAST and DAST Tools · Case Study on Web Application Frameworks · Using browser-jsguard Firefox Add-on to Detect Malicious and Suspicious Webpages

### Session 6 (2T) — Theory
Security Management Concepts & Principles · Human Side of Information Security · Threats to Information Systems · Threats and Attacks · Classification of Threats and Attacks

---

# SESSION 5

## 1. SAST and DAST Tools

SAST (Static Application Security Testing) and DAST (Dynamic Application Security Testing) are two complementary approaches to application security testing, used at different stages of the software development lifecycle (SDLC) to detect vulnerabilities from different perspectives.

### 1.1 SAST (Static Application Security Testing)

**Definition**: SAST is a **white-box testing** method that analyzes source code, bytecode, or binary code at rest, without executing the program. It works by scanning the codebase for patterns and structures that match known vulnerability signatures or insecure coding practices.

**Key Features**:
- Performed early in the SDLC — typically during development or code review phases.
- No execution required — analyzes code without running the application.
- Detects code-level vulnerabilities such as: input validation issues; buffer overflows; hardcoded secrets and credentials; SQL injection patterns in code; XSS vulnerabilities in source; insecure cryptographic implementations.
- Provides fast feedback to developers, often integrated directly into IDEs or CI/CD pipelines.
- Language-dependent — requires tools that support the specific programming languages used.

**Examples of SAST Tools**:
- **SonarQube** — open-source platform for continuous code quality and security inspection.
- **Fortify Static Code Analyzer** (Micro Focus/OpenText) — enterprise-grade SAST with deep language support.
- **Checkmarx** — commercial SAST with integration into DevOps workflows.
- **Veracode Static Analysis** — cloud-based SAST with automated scanning and reporting.
- **Semgrep, CodeQL, Bandit (Python), ESLint (with security plugins)** — other popular options.

**Advantages**:
- Early vulnerability detection — issues are found before deployment, reducing fix costs.
- 100% code coverage — can analyze the entire codebase quickly.
- Exact location of vulnerabilities — points to specific lines and files in the code.
- CI/CD integration — can be automated in pipelines for real-time feedback.
- Enforces secure coding practices — helps developers learn and avoid common mistakes.

**Limitations**:
- High false positive rate — may flag safe code as vulnerable due to lack of runtime context.
- Requires source code access — cannot test third-party binaries without source.
- Cannot detect runtime/environment issues — misses problems like server misconfigurations, authentication flaws, or issues that only appear under specific conditions.
- Language and framework limitations — may not fully understand complex frameworks, libraries, or API endpoints.

### 1.2 DAST (Dynamic Application Security Testing)

**Definition**: DAST is a **black-box testing** method that analyzes applications during execution to find security vulnerabilities. It interacts with the running application from the outside, simulating how an attacker would probe and exploit it.

**Key Features**:
- No code access required — tests the application from the outside in.
- Performed in staging or production-like environments — after deployment but before or during production use.
- Detects runtime vulnerabilities such as: Cross-Site Scripting (XSS); SQL Injection; Cross-Site Request Forgery (CSRF); broken authentication and session management; server misconfigurations; insecure direct object references.
- Language-independent — works regardless of the underlying programming language or framework.
- Simulates real-world attacks — sends HTTP requests and analyzes responses to identify exploitable issues.

**Examples of DAST Tools**:
- **OWASP ZAP (Zed Attack Proxy)** — free, open-source DAST tool widely used for web app security testing.
- **Burp Suite** — commercial tool with extensive features for web application security testing.
- **Acunetix** — automated DAST scanner with deep vulnerability detection.
- **AppScan** (HCL/AppScan) — enterprise DAST with compliance reporting.
- **Nessus Web Application Scanning, Qualys WAS** — other commercial options.

**Advantages**:
- Tests the actual deployed application — validates security in the real runtime environment.
- Effective at finding runtime vulnerabilities — catches issues SAST cannot, like server config problems or authentication flaws.
- No source code needed — can test third-party or compiled applications.
- Lower false positive rate — tests actual behavior, reducing theoretical issues.
- Identifies environment-specific issues — such as SSL/TLS misconfigurations, header issues, and permission problems.

**Limitations**:
- Cannot identify code-level or logic flaws — only sees the output, not the underlying code causing issues.
- Performed later in SDLC — vulnerabilities are found after development, making fixes more expensive.
- Limited coverage — may not test all application paths, especially under complex user conditions or behind authentication.
- Requires running environment — needs a deployed, accessible application to test.
- Can be slow — comprehensive scans of large applications take time.

### 1.3 SAST vs. DAST — Detailed Comparison

| Feature | SAST | DAST |
|---|---|---|
| Testing Approach | White-box (internal view) | Black-box (external view) |
| Code Access | Requires source code or binaries | No code access needed |
| Execution Required | No — analyzes code at rest | Yes — application must be running |
| Testing Phase in SDLC | Early — during development/code review | Late — after deployment, in staging/production |
| Vulnerabilities Detected | Code-level flaws (SQLi patterns, buffer overflows, hardcoded secrets) | Runtime vulnerabilities (XSS, SQLi, auth flaws, server misconfigs) |
| False Positives | Can be high (lacks runtime context) | Usually lower (tests actual behavior) |
| Language Dependency | Yes — tool must support the language | No — language independent |
| Integration | CI/CD pipelines, IDEs, code review tools | QA, staging, pre-production environments |
| Coverage | 100% of codebase | Only tested/crawled paths |
| Fix Cost | Lower — found early | Higher — found after deployment |
| Environment Visibility | None — cannot see runtime config | Full — sees server, network, and runtime behavior |

### 1.4 When to Use Each (and Both)

**Use SAST when**: you want to catch vulnerabilities early in development; you have access to source code; you need developer-friendly feedback integrated into IDEs or CI/CD; you want to enforce secure coding standards across the team.

**Use DAST when**: you want to test the deployed application in a realistic environment; you need to find runtime and configuration issues; you don't have source code access (third-party apps, compiled binaries); you want to simulate real attacker behavior.

**Best practice — use both together**: SAST and DAST are complementary, not mutually exclusive. SAST finds issues early in code, reducing the cost of fixes; DAST validates that the deployed application is secure in its runtime environment. Using both provides layered security — catching issues SAST misses (runtime) and DAST misses (code-level). Many organizations integrate SAST into their CI/CD pipelines for every commit, and run DAST scans in staging environments before production deployment.

### 1.5 Related Concepts

**IAST (Interactive Application Security Testing)**
- Combines SAST and DAST by instrumenting the application and analyzing code during runtime tests.
- Provides code-level visibility with runtime context, reducing false positives.
- Used during QA/testing phases with automated functional tests.

**RASP (Runtime Application Self-Protection)**
- Runs inside the application in production to detect and block attacks in real-time.
- Focuses on protection rather than testing.

**SCA (Software Composition Analysis)**
- Scans dependencies and libraries for known vulnerabilities (e.g., vulnerable npm packages, Java libraries).
- Often used alongside SAST/DAST for comprehensive application security.

### 1.6 Practical Workflow Example

```
Development Phase:
  → SAST integrated in CI/CD (e.g., SonarQube on every push)
  → Developers fix code-level issues immediately

Testing/Staging Phase:
  → DAST scans deployed application (e.g., OWASP ZAP, Burp Suite)
  → QA team validates runtime vulnerabilities

Pre-Production:
  → Both SAST and DAST reports reviewed
  → Critical issues must be resolved before deployment

Production:
  → RASP or WAF for ongoing protection (optional)
  → Periodic DAST scans for regression testing
```

### 1.7 Key Takeaways
- **SAST** = white-box, early, code-focused, high coverage, more false positives.
- **DAST** = black-box, late, runtime-focused, realistic, fewer false positives.
- **Both are essential** for a robust application security strategy.
- Integrate SAST into development workflows and DAST into testing/deployment workflows for maximum security.

---

## 2. Case Study: Web Application Frameworks

### 2.1 What Is a Web Application Framework?

A web framework provides a structure and reusable components to build web applications faster and more securely.

**Common Web Frameworks**:
- Django (Python)
- Ruby on Rails (Ruby)
- Laravel (PHP)
- ASP.NET (C#)
- Spring Boot (Java)
- Express.js (Node.js)

**Security Features Typically Provided**:
- Input validation and sanitation
- Built-in user authentication and authorization
- ORM (Object-Relational Mapping) to prevent SQL injection
- CSRF and XSS protection
- Secure session and cookie management

### 2.2 Case Study: Django Framework

**Strengths**:
- Middleware for security (XSS, CSRF, Clickjacking protection)
- Secure password storage (PBKDF2 hashing by default)
- Form validation and data sanitization

**Common Pitfalls**:
- Misconfigured settings (e.g., `DEBUG=True` in production)
- Over-reliance on built-in features without understanding
- Lack of custom access control checks in views

**Lessons Learned**:
- Developers must review and configure security settings manually.
- Frameworks provide tools, but secure usage is the developer's responsibility.

---

## 3. Using browser-jsguard Firefox Add-On

### 3.1 Overview

**browser-jsguard** is a Firefox extension designed to detect and alert users about **malicious or suspicious JavaScript behavior** in real-time while browsing.

It focuses on **client-side security**, monitoring how websites execute JavaScript and flagging activities that deviate from safe, expected behavior. This tool is particularly useful for security researchers, penetration testers, and analysts who need to manually inspect suspicious websites or perform threat hunting without relying solely on server-side or network-level defenses.

### 3.2 What browser-jsguard Detects

- **Malicious JavaScript behavior** — scripts that attempt to exploit browser vulnerabilities, steal data, or perform unauthorized actions.
- **Suspicious web activity**, such as: phishing attempts (fake login pages, credential harvesting scripts); hidden or obfuscated scripts that execute without user awareness; scripts that redirect users to malicious domains.
- **Unexpected iframe or popup generation** — commonly used in clickjacking attacks, drive-by-download attempts, and malicious ad injections (malvertising).
- **Obfuscated or encoded script injections** — scripts that use encoding (e.g., Base64, hex) to hide their true purpose.
- **Crypto-miners embedded in websites** — scripts that silently use your CPU/GPU to mine cryptocurrency without consent.

### 3.3 Key Features

**1. Real-Time Detection Based on Heuristic Patterns**
- Uses heuristic analysis to identify suspicious script behavior, not just known signatures.
- Monitors script execution patterns that match known malicious techniques, such as dynamic code evaluation (`eval()`, `setTimeout()` with strings, `Function()` constructor), DOM manipulation for hidden elements, and unauthorized network requests to suspicious domains.

**2. User Warnings for Suspicious JavaScript**
- Displays pop-up warnings or notifications when a website attempts to execute suspicious code.
- Allows users to block or allow the script based on the warning.
- Helps users make informed decisions when visiting potentially unsafe sites.

**3. Behavior Logging and Script Call Tracking**
- Logs browser behaviors and script calls that deviate from safe baselines.
- Provides a detailed log of which scripts were executed, what actions they attempted (e.g., creating iframes, sending requests), and timestamps/URLs associated with the activity.
- Useful for forensic analysis or understanding how a malicious site operates.

**4. Lightweight and Focused**
- Designed to be lightweight, minimizing performance impact on the browser.
- Focuses specifically on JavaScript-based threats, not general malware or network attacks.

### 3.4 Use Cases

**1. Detecting Crypto-Miners Embedded in Websites**
- Crypto-mining scripts (e.g., Coinhive, others) silently consume system resources to mine cryptocurrency.
- browser-jsguard can detect high-frequency script execution patterns typical of miners, connections to known mining pool domains, and hidden canvas or WebAssembly-based mining scripts.

**2. Identifying Drive-by-Download Attempts**
- Drive-by downloads occur when a website automatically triggers a file download without user consent, often exploiting browser vulnerabilities.
- browser-jsguard can flag scripts that attempt to initiate downloads from unknown sources, and hidden iframe injections that serve malicious payloads.

**3. Monitoring Web Pages for Obfuscated or Encoded Script Injections**
- Attackers often obfuscate malicious scripts using encoding to evade detection.
- browser-jsguard can detect heavily encoded JavaScript (e.g., multiple layers of `atob()`, `unescape()`) and scripts that dynamically generate and execute code.

**4. Manual Security Testing and Threat Hunting**
- Security analysts can use browser-jsguard to safely browse suspicious websites and observe script behavior, collect evidence of malicious activity for reports or incident response, and identify patterns used by attackers for broader threat intelligence.

**5. Protecting Against Phishing and Social Engineering**
- Phishing sites often use JavaScript to capture keystrokes, redirect users after entering credentials, or spoof legitimate login pages.
- browser-jsguard can alert users to these behaviors before they fall victim.

### 3.5 How It Helps

- **Adds an additional layer of client-side protection** — complements traditional security measures (antivirus, firewalls, WAFs) by focusing on browser-based threats; provides real-time visibility into what scripts are doing on a page, not just what the page looks like.
- **Useful in manual testing or browsing of suspicious sites** — security researchers and penetration testers often need to visit potentially malicious sites to analyze them; browser-jsguard acts as a safety net, alerting users to dangerous behavior before harm occurs.
- **Assists security analysts during threat hunting or forensics** — the logging and alerting features provide actionable data for incident response investigations, malware analysis, and understanding attacker techniques and tools (TTPs).

### 3.6 Limitations

**1. Not a Replacement for Server-Side or Network-Level Protection**
- browser-jsguard only protects the client-side (browser). It cannot prevent server-side vulnerabilities (e.g., SQL injection, RCE), block malicious network traffic before it reaches the browser, or replace firewalls, WAFs, or endpoint protection.

**2. May Produce False Alerts on Legitimate Websites**
- Some legitimate websites use complex JavaScript for analytics, ads, or dynamic content, which can trigger false positives — e.g., heavy use of `eval()` for legitimate purposes, dynamic iframe loading for ads or third-party widgets, obfuscated scripts for anti-tampering or licensing.

**3. Needs Regular Updates to Adapt to New Attack Signatures**
- Attackers constantly evolve their techniques, so the tool's heuristic patterns and signatures must be updated regularly. Outdated versions may miss new types of malicious scripts or produce more false positives.

**4. Limited to Firefox Browser**
- As a Firefox add-on, it does not protect users on Chrome, Edge, Safari, or other browsers. Users who primarily use other browsers will need alternative tools.

**5. Cannot Prevent All Types of Attacks**
- Some attacks may bypass client-side detection, such as zero-day exploits that haven't been signatured, attacks that leverage browser vulnerabilities directly (not just JavaScript), and social engineering that doesn't rely on malicious scripts.

### 3.7 Best Practices for Using browser-jsguard

1. **Use in combination with other tools** — pair with ad-blockers (uBlock Origin), script blockers (NoScript), and antivirus software for layered protection.
2. **Review logs regularly** — check the behavior logs to understand what scripts are running and why alerts were triggered.
3. **Keep the extension updated** — ensure you're using the latest version to benefit from updated detection patterns.
4. **Configure sensitivity settings** — adjust detection thresholds to reduce false positives on trusted sites while maintaining security on unknown sites.
5. **Use in a safe browsing environment** — for threat hunting, consider using browser-jsguard in a VM or isolated environment to minimize risk.

### 3.8 Summary Table

| Topic | Key Takeaway |
|---|---|
| SAST | Scans code for security issues before execution. Best for early detection in SDLC. |
| DAST | Scans running applications for vulnerabilities. Best for detecting runtime and environment-specific issues. |
| Web Framework Security | Use built-in security features (e.g., CSP, XSS protection) responsibly and avoid misconfiguration. |
| browser-jsguard | A proactive Firefox add-on for spotting client-side malicious JavaScript activities in real-time, useful for manual testing and threat hunting. |

### 3.9 Key Takeaways
- **browser-jsguard** provides real-time, client-side protection against malicious JavaScript and suspicious web activity.
- It is especially useful for security researchers, analysts, and cautious users who need visibility into script behavior.
- While it adds a valuable layer of defense, it should be used alongside other security tools and practices, not as a standalone solution.
- Understanding its limitations (false positives, Firefox-only, client-side only) helps set realistic expectations for its use.

---

# SESSION 6

## 1. Security Management Concepts & Principles

### 1.1 Confidentiality, Integrity, and Availability (CIA Triad)

The CIA Triad is the foundational model of information security, representing the three core objectives that all security measures aim to protect.

**Confidentiality**
- *Definition*: ensures that data is only accessible to those with proper authorization, and is protected from unauthorized access or disclosure.
- *Key concepts*: prevents unauthorized users from viewing sensitive information; applies to data at rest (stored), in transit (being transmitted), and in use (being processed); breaches include data leaks, unauthorized access, and eavesdropping.
- *Controls and mechanisms*: **Encryption** (AES, TLS/SSL); **Access Control** (RBAC, DAC, MAC); **Authentication** (passwords, MFA, biometrics); **Data Classification** (public, internal, confidential, top secret); **Physical Security** (locks, secure facilities, surveillance).
- *Examples*: encrypting customer credit card data in a database; requiring MFA to access corporate email; using HTTPS to secure web traffic.

**Integrity**
- *Definition*: assures that data has not been altered in an unauthorized manner and remains accurate, complete, and trustworthy.
- *Key concepts*: protects against unauthorized modification, deletion, or insertion of data; ensures data is reliable and authentic; violations include tampering, corruption, and man-in-the-middle attacks.
- *Controls and mechanisms*: **Hashing** (SHA-256, MD5); **Digital Signatures**; **Checksums**; **Version Control**; **Audit Logs**; **Access Controls**.
- *Examples*: using digital signatures to verify software updates haven't been tampered with; implementing database constraints to prevent invalid data entry; logging all changes to financial records for accountability.

**Availability**
- *Definition*: ensures that information and systems are accessible when needed by authorized users.
- *Key concepts*: systems, applications, and data must be operational and reachable during expected times; impacted by hardware failures, network outages, DDoS attacks, and natural disasters; often measured by uptime percentages (e.g., 99.9%).
- *Controls and mechanisms*: **Redundancy**; **Backups and Disaster Recovery**; **Load Balancing**; **DDoS Protection**; **Maintenance and Patching**; **Fault Tolerance**.
- *Examples*: hosting a website across multiple geographic regions to ensure uptime; implementing automatic failover to a backup server if the primary fails; using a CDN to serve content during traffic spikes.

**CIA Triad — Visual Summary**

| Principle | Goal | Threats | Example Controls |
|---|---|---|---|
| Confidentiality | Prevent unauthorized access | Data breaches, eavesdropping, insider threats | Encryption, access control, MFA |
| Integrity | Prevent unauthorized modification | Tampering, corruption, MITM attacks | Hashing, digital signatures, audit logs |
| Availability | Ensure timely access | DDoS, hardware failure, disasters | Redundancy, backups, load balancing |

### 1.2 Security Governance

**Security Governance** refers to the strategic alignment of information security with business objectives, ensuring that security efforts support organizational goals while managing risk effectively. It encompasses the frameworks, structures, processes, and accountability mechanisms that guide how security is managed at an organizational level.

**Key Components**:
1. **Strategic Alignment** — security initiatives must align with business goals and priorities; security should enable business objectives, not hinder them. *Example*: a financial institution prioritizes data protection to maintain customer trust and comply with regulations.
2. **Risk Management** — identifying, assessing, and treating risks to information assets; ensures security investments are proportional to risk levels; involves continuous monitoring and updating of risk profiles.
3. **Policy Enforcement** — establishing and enforcing security policies, standards, and procedures; ensures consistent security practices across the organization; includes compliance monitoring and violation handling.
4. **Compliance and Accountability** — ensures adherence to laws, regulations, and industry standards (GDPR, HIPAA, PCI-DSS, ISO 27001); defines roles and responsibilities (CISO, security team, data owners); establishes audit trails and reporting mechanisms.
5. **Performance Measurement** — uses metrics and KPIs to measure the effectiveness of security programs (number of incidents, time to detect/respond, compliance audit results); enables continuous improvement.

**Benefits**: clear accountability; informed decision-making; regulatory compliance; improved security posture; stakeholder confidence.

### 1.3 Security Policies, Standards, Procedures, and Guidelines

These four elements form a hierarchical framework that defines how security is implemented and enforced within an organization.

**Policy**
- *Definition*: a high-level statement outlining the organization's security goals, expectations, and commitment.
- *Characteristics*: broad and strategic; approved by senior management (CEO, CISO); applies to the entire organization; rarely changes, reviewed periodically.
- *Examples*: Information Security Policy ("All employees must protect company data from unauthorized access"); Acceptable Use Policy (AUP); Data Classification Policy.
- *Purpose*: sets the tone from the top for security culture; provides the foundation for standards, procedures, and guidelines; demonstrates management commitment.

**Standard**
- *Definition*: mandatory controls and requirements derived from policies, specifying what must be done to meet security objectives.
- *Characteristics*: more specific and technical than policies; mandatory; often technology- or process-specific; updated more frequently than policies.
- *Examples*: Password Standard (minimum 12 characters, complexity requirements); Encryption Standard (TLS 1.2+ for data in transit); Access Control Standard (RBAC required for all systems).
- *Purpose*: translates high-level policies into actionable requirements; ensures consistency; provides a baseline for compliance audits.

**Procedure**
- *Definition*: step-by-step instructions that describe how to perform specific tasks to meet standards and policies.
- *Characteristics*: highly detailed and operational; mandatory; written for specific roles or teams; frequently updated.
- *Examples*: Incident Response Procedure (detect/verify → contain → eradicate → recover → document lessons learned); User Account Creation Procedure; Backup Procedure.
- *Purpose*: ensures tasks are performed consistently and correctly; reduces errors and deviations; useful for training new staff and auditing compliance.

**Guideline**
- *Definition*: recommendations and best practices that are not mandatory but provide helpful guidance.
- *Characteristics*: non-mandatory; flexible and adaptable; often based on industry best practices; helps users make informed security decisions.
- *Examples*: Password Guideline (consider using a password manager); Secure Coding Guideline (validate all user inputs); Remote Work Guideline (use a VPN on public networks).
- *Purpose*: provides flexibility where strict rules aren't necessary; encourages security awareness without rigid enforcement; helps users understand *why* practices are recommended.

**Hierarchy Summary**

| Element | Level | Mandatory? | Audience | Example |
|---|---|---|---|---|
| Policy | Strategic/High-level | Yes (organization-wide) | All employees, management | "All data must be protected from unauthorized access." |
| Standard | Tactical/Mid-level | Yes (specific controls) | IT, security teams, developers | "Passwords must be at least 12 characters with complexity." |
| Procedure | Operational/Detailed | Yes (step-by-step) | Specific roles (admins, devs) | "Steps to create a user account in Active Directory." |
| Guideline | Advisory/Best Practice | No (recommended) | All users, developers | "Consider using a password manager for better security." |

### 1.4 Risk Management

Risk Management is the systematic process of identifying, assessing, and treating risks to an organization's information assets and systems, ensuring that security efforts are focused on the most critical risks and resources are allocated efficiently.

**Key Terms**:
- **Asset** — anything of value to the organization (data, systems, hardware, people).
- **Threat** — a potential cause of harm (hackers, malware, natural disasters).
- **Vulnerability** — a weakness that can be exploited by a threat (unpatched software, weak passwords).
- **Risk** — the likelihood of a threat exploiting a vulnerability and the impact if it does.
- **Control** — a measure to reduce risk (firewall, encryption, training).

**Risk Assessment** — the process of identifying assets, threats, vulnerabilities, and controls to understand the organization's risk profile:
1. **Asset Identification** — catalog all information assets; classify by criticality and sensitivity.
2. **Threat Identification** — internal (employees, contractors, insiders), external (hackers, competitors, nation-states), environmental (natural disasters, power outages).
3. **Vulnerability Identification** — unpatched software, weak authentication, misconfigured firewalls, lack of employee training.
4. **Risk Analysis** — evaluate likelihood and impact of each risk; methods: **Qualitative** (Low/Medium/High scales) or **Quantitative** (numerical values, financial impact).
5. **Risk Prioritization** — rank risks by severity (likelihood × impact); focus resources on high-priority risks first.

**Risk Treatment** — selecting and implementing options to modify risk to an acceptable level:
1. **Risk Acceptance** — acknowledging the risk and choosing not to act; used when the risk is low or mitigation costs exceed potential loss. *Example*: accepting a minor low-impact software bug.
2. **Risk Avoidance** — eliminating the risk entirely by removing the vulnerable asset or activity. *Example*: discontinuing an outdated, unsupported application.
3. **Risk Mitigation (Reduction)** — reducing likelihood or impact through controls (Preventive: firewall, encryption, access control; Detective: IDS, SIEM, audit logs; Corrective: backups, incident response, disaster recovery). *Example*: implementing MFA.
4. **Risk Transfer (Sharing)** — shifting the risk to a third party (insurance, outsourcing); doesn't eliminate the risk but reduces financial/operational impact. *Example*: purchasing cybersecurity insurance; outsourcing to an MSSP.

**Risk Management Process Flow**:
```
1. Identify Assets → 2. Identify Threats → 3. Identify Vulnerabilities
       ↓
4. Analyze Risks (Likelihood × Impact)
       ↓
5. Prioritize Risks (High, Medium, Low)
       ↓
6. Select Treatment Strategy (Accept, Avoid, Mitigate, Transfer)
       ↓
7. Implement Controls
       ↓
8. Monitor and Review (Continuous)
```

**Risk Register Example**

| Risk ID | Asset | Threat | Vulnerability | Likelihood | Impact | Risk Level | Treatment |
|---|---|---|---|---|---|---|---|
| R001 | Customer Database | Data Breach | Unencrypted data at rest | High | High | High | Mitigate (Encrypt data) |
| R002 | Web Server | DDoS Attack | No DDoS protection | Medium | High | High | Transfer (DDoS protection service) |
| R003 | Employee Laptops | Malware Infection | No endpoint protection | High | Medium | Medium | Mitigate (Deploy antivirus) |
| R004 | Legacy Application | Exploitation | Unpatched software | Low | Low | Low | Accept (Monitor only) |

### 1.5 Key Takeaways
- **CIA Triad** is the foundation of all security efforts — confidentiality, integrity, and availability must be balanced.
- **Security Governance** ensures security aligns with business goals and is managed effectively at the organizational level.
- **Policies, Standards, Procedures, and Guidelines** form a hierarchy that translates high-level security goals into actionable steps.
- **Risk Management** is a continuous process of identifying, assessing, and treating risks to protect organizational assets.
- The four risk treatment options (**Accept, Avoid, Mitigate, Transfer**) provide flexibility in how organizations respond to different types of risks.

---

## 2. Human Side of Information Security

### 2.1 Social Engineering

**Social Engineering** is the practice of exploiting human psychology rather than technical vulnerabilities to gain unauthorized access to systems, data, or physical locations. It is one of the most effective attack methods because it targets the weakest link in security: people.

**Why Social Engineering Works**:
- **Trust** — people naturally want to help others or comply with authority.
- **Fear** — threats of account suspension, legal action, or financial loss prompt quick, unthinking responses.
- **Urgency** — creating time pressure prevents victims from verifying requests.
- **Curiosity** — promises of rewards, prizes, or interesting content lure users into traps.
- **Authority** — people tend to comply with requests from perceived authority figures.

**Common Types**:

**1. Phishing** — sending fraudulent communications (usually emails) that appear to come from a trusted source to trick recipients into revealing sensitive information or clicking malicious links.
- *Characteristics*: emails impersonating banks, colleagues, or well-known companies; urgent language; malicious attachments; fake login pages.
- *Variants*: **Spear Phishing** (targeted at specific individuals/organizations); **Whaling** (targeted at high-value individuals like CEOs/CFOs); **Smishing** (via SMS/text); **Vishing** (via voice calls).
- *Example*: an employee receives an email appearing to be from their bank ("Your account has been compromised. Click here immediately to reset your password.") leading to a fake login page.

**2. Baiting** — offering something desirable or enticing to lure victims into a trap.
- *Characteristics*: physical baiting (infected USB drives labeled "Confidential" left in public areas); digital baiting (free downloads containing malware); exploits curiosity or greed.
- *Example*: an attacker leaves USB drives labeled "Q4 Bonus List" in a company parking lot; an employee plugs one in, unknowingly installing malware.

**3. Pretexting** — creating a fabricated scenario to engage a victim and extract information or gain access.
- *Characteristics*: attacker impersonates someone trustworthy (IT support, vendor, auditor); builds rapport before making requests; often via phone calls or in-person interactions; more sophisticated than phishing.
- *Example*: an attacker calls pretending to be from IT, requesting login credentials for a "security audit."

**4. Tailgating (Piggybacking)** — gaining physical access to a restricted area by following someone who has authorized access.
- *Characteristics*: attacker waits near a secure entrance and follows an employee through a door; may carry boxes or pretend to be a delivery person; exploits politeness.
- *Example*: an attacker carrying a box labeled "IT Equipment" asks an employee to hold the door.

**Other Techniques**: **Quid Pro Quo** (offering a service in exchange for information); **Impersonation** (pretending to be a trusted individual); **Honey Traps** (using romantic/personal relationships to extract information); **Scareware** (fake security warnings tricking users into installing malware or paying for fake services).

**Defenses**: security awareness training; verification procedures (verify requests through a separate channel); MFA; email filtering and anti-phishing tools; physical security controls (badge readers, guards, visitor logs); a culture of skepticism.

### 2.2 Security Awareness Training

**Security Awareness Training** is a structured educational program designed to teach employees and users about security best practices, emerging threats, and their role in protecting organizational assets. It is one of the most effective defenses against social engineering and insider threats.

**Objectives**: educate users on common threats (phishing, malware, social engineering); promote secure behaviors (strong passwords, MFA, safe browsing); encourage reporting of suspicious activities without fear of punishment; ensure compliance with regulatory requirements (GDPR, HIPAA, PCI-DSS); reduce human error, the leading cause of security incidents.

**Key Components of Effective Training**:
1. **Regular and Ongoing Training** — security threats evolve rapidly, so one-time training is insufficient; conduct quarterly/annual refreshers and include new-hire onboarding.
2. **Engaging Content** — real-world examples and case studies; interactive elements (quizzes, simulations, gamification); accessible, non-technical language.
3. **Phishing Simulations** — send fake phishing emails to test employee awareness; track click rates and report rates; provide immediate feedback to users who fail.
4. **Role-Based Training** — tailor content to specific roles (Developers: secure coding, OWASP Top 10; HR: sensitive employee data; Finance: wire transfer fraud, invoice scams; Executives: spear phishing, whaling).
5. **Reporting Mechanisms** — easy ways to report suspicious emails/activities (e.g., "Report Phishing" button); prompt acknowledgment and investigation; a no-blame culture.

**Topics Covered**: phishing and social engineering; password security; safe browsing; email security; data handling; physical security; incident reporting; remote work security; compliance requirements.

**Measuring Effectiveness**: phishing simulation metrics (click rates, report rates, repeat offenders); incident reports; reduction in successful attacks over time; quiz scores; employee feedback surveys.

**Best Practices**: leadership support and participation; mandatory completion for all employees; keep content current; use multiple formats (videos, quizzes, live sessions, posters); reward good behavior (reporting incidents, early completion).

### 2.3 Insider Threats

**Insider Threats** are security risks that originate from within the organization, typically from employees, contractors, or business partners who have authorized access to systems and data. They are often harder to detect and can be more damaging than external attacks because insiders already have legitimate access.

**1. Malicious Insiders** — individuals who intentionally misuse their access to harm the organization.
- *Motivations*: financial gain; revenge (disgruntled employees); espionage (working for competitors/nation-states); ideology (whistleblowing, activism).
- *Behaviors*: exfiltrating sensitive data; sabotaging systems; installing malware/backdoors; sharing credentials with unauthorized parties.
- *Example*: a departing employee copies the customer database to a personal USB drive intending to sell it to a competitor.

**2. Negligent Insiders** — individuals who unintentionally cause security incidents through carelessness or lack of awareness.
- *Common mistakes*: falling for phishing emails; sending sensitive data to the wrong recipient; losing devices with confidential information; weak passwords or credential sharing; misconfiguring systems (public cloud buckets).
- *Example*: an employee accidentally emails a spreadsheet of customer credit card numbers to an external recipient.

**3. Compromised Insiders** — insiders whose credentials or devices have been taken over by external attackers.
- *Scenarios*: credentials stolen via phishing/malware; devices infected with RATs; attackers using insider accounts for lateral movement.
- *Example*: an attacker phishes an employee's login credentials and uses them to access the corporate network as a legitimate user.

**Why Insider Threats Are Dangerous**: legitimate access; less scrutiny/monitoring; knowledge of internal systems; malicious activity can blend in with normal behavior; high financial/operational/reputational impact.

**Indicators**: unusual access patterns (off-hours, outside job scope); large data transfers; policy violations; behavioral changes (disgruntlement, discussing resignation, financial trouble); unauthorized devices; attempts to bypass security (disabling antivirus, using anonymization tools).

**Defenses**: least privilege access; User Behavior Analytics (UBA); Data Loss Prevention (DLP); regular access reviews; strict exit procedures (revoke access immediately); security awareness training; logging and monitoring; a culture of trust and reporting.

### 2.4 User Behavior Analytics (UBA)

**User Behavior Analytics (UBA)**, also known as User and Entity Behavior Analytics (UEBA), is a security technology that detects abnormal user behavior to identify potential threats, including insider threats and compromised accounts. It uses machine learning and statistical analysis to establish baselines of normal behavior and flag deviations.

**How UBA Works**:
1. **Baseline Establishment** — learns normal behavior patterns per user over time (login times/locations, systems/applications accessed, data access patterns, volume of data accessed/transferred, devices and IPs used).
2. **Anomaly Detection** — detects deviations from normal behavior (e.g., login at 3 AM from a foreign country; accessing data never touched before; unusually large downloads; multiple failed logins followed by success).
3. **Risk Scoring** — each anomaly gets a risk score based on severity and context; multiple low-risk anomalies can combine into a high-risk pattern, triggering alerts.
4. **Correlation and Context** — correlates events across multiple data sources (logs, network traffic, endpoint data); adds context to reduce false positives.

**Use Cases**: detecting insider threats; identifying compromised accounts (logins from unexpected locations, access patterns that don't match the legitimate user); privileged account monitoring; data exfiltration detection (large uploads to personal cloud storage, bulk downloads); compliance and auditing.

**Benefits**: early detection; strong insider threat visibility; reduced false positives (with ML tuning); automated, continuous monitoring; forensic value for incident investigation.

**Limitations and Challenges**: privacy concerns from extensive monitoring; false positives from legitimate behavior changes (new projects, travel); requires a baseline period (weeks to months); complexity requiring skilled analysts; needs integration with existing tools (SIEM, IAM, DLP).

**UBA vs. Traditional Security Tools**

| Feature | Traditional Security Tools | UBA/UEBA |
|---|---|---|
| Focus | Known threats, signatures, rules | Unknown threats, behavioral anomalies |
| Detection Method | Signature-based, rule-based | Machine learning, statistical analysis |
| Insider Threat Detection | Limited | Strong |
| False Positives | Can be high | Lower (with proper tuning) |
| Baseline Required | No | Yes |
| Data Sources | Logs, network traffic | Logs, network, endpoints, IAM, DLP |

### 2.5 Key Takeaways
- **Social Engineering** exploits human psychology — phishing, baiting, pretexting, and tailgating are common techniques that target trust, fear, and curiosity.
- **Security Awareness Training** is essential for educating users, promoting secure behaviors, and creating a culture of vigilance and reporting.
- **Insider Threats** (malicious, negligent, or compromised) are among the most dangerous risks because insiders already have legitimate access and knowledge of systems.
- **User Behavior Analytics (UBA)** uses machine learning to detect abnormal behavior, making it one of the most effective tools for identifying insider threats and compromised accounts.
- A layered approach combining training, technology, policies, and monitoring is necessary to address the human side of information security effectively.

---

## 3. Threats to Information Systems

Threats to information systems are potential events or actions that can compromise the confidentiality, integrity, or availability of data, systems, or infrastructure. Threats are typically categorized into four main types: **Natural**, **Technical**, **Human**, and **Physical**.

### 3.1 Natural Threats

Environmental or disaster-related events that can damage or destroy information systems infrastructure, leading to data loss, downtime, and business disruption. These threats are unpredictable and largely beyond human control, but their impact can be mitigated through proper planning.

**Floods** — water damage to servers/equipment; electrical shorts and corrosion; disrupted power/connectivity. *Vulnerable assets*: data centers in flood-prone areas, basements/ground-floor server rooms. *Mitigation*: elevated/flood-resistant locations, water detection sensors and drainage, offsite backups, raised equipment.

**Earthquakes** — structural damage; destroyed servers/racks; power outages; fire hazards. *Vulnerable assets*: data centers in seismic zones, older buildings, improperly mounted equipment. *Mitigation*: earthquake-resistant design, seismic racks, geographic redundancy, regular structural inspections.

**Fires** — destruction of hardware/storage media; smoke damage; power/network outages; long-term disruption. *Vulnerable assets*: rooms with inadequate fire suppression, outdated wiring, flammable materials nearby. *Mitigation*: fire detection/suppression systems (FM-200, inert gas), fire-resistant materials, fire drills and training, offsite backups.

**Other natural threats**: **Thunderstorms/lightning** — power surges (mitigate with surge protectors, UPS, lightning rods); **Tornadoes/hurricanes** — structural damage, flooding, prolonged outages (mitigate with reinforced facilities, redundancy, generators); **Extreme temperatures** — overheating/freezing (mitigate with HVAC, temperature monitoring); **Power outages** — shutdowns, corruption, hardware damage (mitigate with UPS, generators, redundant supplies).

**Natural Threat Risk Assessment**

| Threat | Likelihood | Impact | Mitigation Priority |
|---|---|---|---|
| Flood | Medium (location-dependent) | High | High |
| Earthquake | Low–Medium (region-dependent) | High | Medium–High |
| Fire | Medium | High | High |
| Power Outage | High | Medium | High |
| Extreme Weather | Medium (location-dependent) | Medium–High | Medium |

**Best Practices**: Disaster Recovery Planning (DRP); Business Continuity Planning (BCP); geographic redundancy; regular, tested, offsite backups; environmental monitoring (temperature, humidity, water, smoke, seismic); insurance coverage.

### 3.2 Technical Threats

Software, network, or system-based attacks that exploit vulnerabilities in technology to compromise information systems — among the most common and damaging threats organizations face.

**1. Malware** — malicious software designed to infect, damage, or gain unauthorized access to systems.
- **Viruses**: attach to legitimate programs, spread when executed, corrupt/delete data.
- **Worms**: self-replicating, spread across networks without user interaction (e.g., WannaCry, 2017).
- **Trojans**: disguised as legitimate software, create backdoors.
- **Ransomware**: encrypts files and demands payment (WannaCry, NotPetya, Ryuk, LockBit).
- **Spyware**: secretly monitors activity, captures keystrokes/credentials.
- **Adware**: displays unwanted ads, can redirect to malicious sites.
- **Rootkits**: hide malware presence by modifying system files; extremely hard to detect.
- **Botnets**: networks of infected devices used for DDoS, spam, credential stuffing.
- *Mitigation*: antivirus/anti-malware, prompt patching, application whitelisting, email filtering, user education on safe downloading/browsing.

**2. DDoS Attacks** — overwhelm a target with massive traffic from multiple sources using botnets.
- **Volumetric**: UDP floods, ICMP floods, DNS amplification.
- **Protocol**: SYN floods, Ping of Death, Smurf attacks.
- **Application Layer**: HTTP floods, Slowloris.
- *Mitigation*: DDoS protection services (Cloudflare, Akamai, AWS Shield), rate limiting and traffic filtering, load balancers, redundant infrastructure, incident response plans.

**3. Exploits and Vulnerabilities** — attacks exploiting known or unknown vulnerabilities in software, hardware, or configurations (zero-days, unpatched software, misconfigurations). Common vulnerability classes: SQLi, XSS, RCE, privilege escalation, buffer overflows. *Mitigation*: prompt patching, regular vulnerability assessments/pentesting, secure coding practices, firewalls/WAFs/IDS/IPS, defense-in-depth.

**4. Man-in-the-Middle (MitM) Attacks** — intercepting and potentially altering communications between two parties without their knowledge. Common scenarios: unsecured Wi-Fi, compromised routers, ARP spoofing. Attacks include eavesdropping, session hijacking, SSL/TLS stripping. *Mitigation*: encryption (HTTPS, TLS, VPN), certificate pinning, avoiding untrusted public Wi-Fi, network segmentation and monitoring.

**5. Advanced Persistent Threats (APTs)** — sophisticated, long-term attacks typically by nation-states or organized cybercriminal groups, targeting specific organizations with multiple attack vectors and maintaining persistent access over months/years. *Mitigation*: advanced threat detection (UEBA, SIEM, threat intel), regular assessments/audits, strong access controls and segmentation, incident response capabilities.

**Technical Threat Summary**

| Threat | Description | Impact | Primary Mitigation |
|---|---|---|---|
| Malware | Viruses, worms, ransomware, spyware | Data loss, system compromise, encryption | Antivirus, patching, user education |
| DDoS | Traffic floods from botnets | Service unavailability, downtime | DDoS protection, rate limiting |
| Exploits | Vulnerability-based attacks | Unauthorized access, data breach | Patching, vulnerability scanning |
| MitM | Intercepted communications | Credential theft, data exposure | Encryption, VPN, secure protocols |
| APT | Long-term targeted attacks | Data theft, espionage, sabotage | Advanced detection, access controls |

### 3.3 Human Threats

Intentional malicious actions by people aimed at compromising information systems through technical or non-technical means — often the most dangerous because humans can adapt and exploit trust in ways automated tools cannot.

**1. Hackers** — individuals/groups attempting unauthorized access.
- **Black Hat**: malicious actors — data theft, ransomware, fraud, sabotage.
- **Grey Hat**: operate in a legal/ethical grey area, may expose vulnerabilities without permission.
- **White Hat**: ethical hackers hired to test and improve security.
- **Script Kiddies**: low-skill attackers using pre-written tools, motivated by curiosity/notoriety.
- **Nation-State Actors**: government-sponsored, target critical infrastructure and IP.
- *Common methods*: phishing/social engineering, exploiting vulnerabilities, brute force, SQLi/web app attacks, credential stuffing.
- *Mitigation*: strong access controls and MFA, regular assessments/pentesting, IDS/IPS, user education, incident response capabilities.

**2. Insiders** — see Section 2.3 above (malicious, negligent, compromised insiders).

**3. Social Engineers** — attackers exploiting human psychology (phishing, pretexting, baiting, tailgating, quid pro quo) — see Section 2.1 above.

**Human Threat Summary**

| Threat | Description | Motivation | Primary Mitigation |
|---|---|---|---|
| Hackers | Unauthorized access attempts | Financial gain, espionage, disruption | Access controls, MFA, monitoring |
| Insiders | Authorized users misusing access | Revenge, profit, negligence, compromise | Least privilege, UBA, DLP, training |
| Social Engineers | Psychological manipulation | Credential theft, fraud, access | Awareness training, verification, reporting |

### 3.4 Physical Threats

Risks involving direct physical access, theft, or damage to information systems hardware, facilities, or infrastructure, leading to data loss, system compromise, and business disruption.

**1. Theft of Hardware** — unauthorized removal of physical devices containing data or providing access. *Vulnerable assets*: laptops/mobile devices, servers/networking equipment, backup media, POS terminals/ATMs. *Impact*: data breach, financial loss, operational disruption, reputational damage. *Mitigation*: physical access controls, full disk encryption, asset tracking, clear device-handling policies, remote wipe capability, secure offsite backups.

**2. Unauthorized Physical Access** — gaining entry to restricted areas (server rooms, network closets, executive offices, R&D labs). *Risks*: direct system access, hardware tampering (keyloggers, implants, network taps), data theft, sabotage. *Common methods*: tailgating, impersonation, social engineering, lock picking/bypass. *Mitigation*: multi-factor physical access controls (badge + PIN + biometric), security guards and visitor management, CCTV, clear visitor policies and escorts, regular access audits, training staff to challenge unknown individuals.

**3. Environmental Damage** — physical damage from environmental factors within facilities (water leaks, power surges, dust/debris, magnetic interference). *Mitigation*: environmental monitoring (temperature, humidity, water), raised floors and cable management, surge protectors/PDUs, regular inspections, climate-controlled environments.

**4. Vandalism and Sabotage** — intentional destruction of physical infrastructure by disgruntled (former) employees, activists, competitors, or criminal organizations. *Impact*: system destruction, prolonged downtime, financial/reputational damage. *Mitigation*: robust physical security (fences, barriers, reinforced doors), 24/7 monitoring/surveillance, incident response plans, geographic redundancy.

**Physical Threat Summary**

| Threat | Description | Impact | Primary Mitigation |
|---|---|---|---|
| Hardware Theft | Unauthorized removal of devices | Data breach, financial loss, downtime | Encryption, access controls, tracking |
| Unauthorized Access | Entry to restricted areas | System compromise, tampering, theft | Multi-factor access, guards, surveillance |
| Environmental Damage | Water, power, dust damage | Equipment failure, data loss | Environmental monitoring, maintenance |
| Vandalism/Sabotage | Intentional destruction | System destruction, prolonged downtime | Physical security, redundancy, monitoring |

### 3.5 Comprehensive Threat Summary

| Category | Examples | Primary Controls |
|---|---|---|
| Natural | Floods, earthquakes, fires, power outages | DRP/BCP, backups, geographic redundancy, environmental monitoring |
| Technical | Malware, DDoS, exploits, MitM, APTs | Antivirus, patching, firewalls, encryption, IDS/IPS |
| Human | Hackers, insiders, social engineers | Access controls, MFA, UBA, training, DLP |
| Physical | Theft, unauthorized access, vandalism | Physical security, encryption, surveillance, access controls |

### 3.6 Key Takeaways
- **Natural Threats** are unpredictable environmental events — focus on disaster recovery, backups, and geographic redundancy to mitigate impact.
- **Technical Threats** exploit software and network vulnerabilities — implement patching, antivirus, firewalls, and encryption as primary defenses.
- **Human Threats** leverage psychology and insider access — address through training, access controls, monitoring, and a strong security culture.
- **Physical Threats** involve direct access to hardware and facilities — protect with physical security controls, encryption, and surveillance.
- A layered defense-in-depth strategy addressing all four threat categories is essential for comprehensive information security.
- Risk assessments should identify which threats are most relevant to your organization based on location, industry, and assets.

---

## 4. Threats and Attacks

### 4.1 Active vs. Passive Attacks

Attacks are broadly categorized into **active** and **passive** based on whether they modify/disrupt data or simply observe/monitor communications.

**Active Attacks** — modify, disrupt, or destroy data or systems. The attacker actively interacts with the target to cause harm or gain unauthorized access.
- *Characteristics*: alter data or system behavior; often detectable (leaves traces); high impact; goal is to disrupt operations, steal/modify data, or gain control.
- *Examples*: **DoS/DDoS** (overwhelm with traffic — detect via traffic spikes/resource exhaustion); **MITM** (intercept/alter communications — detect via certificate warnings, unusual network behavior); **SQL Injection** (manipulate DB queries — detect via unusual queries/errors); **XSS** (inject scripts — detect via unexpected script execution); **Malware infections** (modify/encrypt files — detect via AV alerts, file changes); **Replay attacks** (retransmit valid data — detect via timestamp/sequence validation); **Masquerading/Spoofing** (pretend to be legitimate — detect via auth logs, IP/MAC anomalies).

**Passive Attacks** — eavesdrop, monitor, or observe data without modifying it. The attacker remains undetected while gathering information.
- *Characteristics*: no data modification; difficult to detect (no trace); focused on confidentiality; goal is intelligence gathering.
- *Examples*: **Network/packet sniffing** (capture traffic — prevent via encryption/TLS/VPN); **Keylogging** (record keystrokes — prevent via anti-keylogger software, MFA); **Traffic analysis** (infer info from patterns — prevent via traffic padding, encryption); **Eavesdropping** (listen to private communications — prevent via encryption); **Shoulder surfing** (observe screens/keyboards — prevent via privacy screens); **Dumpster diving** (search physical trash — prevent via secure document disposal/shredding).

**Active vs. Passive — Comparison**

| Feature | Active Attacks | Passive Attacks |
|---|---|---|
| Data Modification | Yes — modifies, disrupts, or destroys | No — only observes or monitors |
| Detectability | Easier to detect (leaves traces) | Very difficult to detect |
| Impact | High — immediate damage/disruption | Medium — information theft for future use |
| Goal | Disrupt, modify, or gain control | Gather intelligence or credentials |
| Examples | DoS, MITM, SQL Injection, XSS, Malware | Sniffing, Keylogging, Traffic Analysis, Eavesdropping |
| Primary Security Concern | Integrity and Availability | Confidentiality |
| Prevention | Firewalls, IDS/IPS, access controls | Encryption, secure protocols, awareness |

### 4.2 Common Attacks

**1. Phishing** — a social engineering attack sending fraudulent communications appearing to come from a trusted source to trick recipients into revealing sensitive information, clicking malicious links, or downloading infected attachments.
- *How it works*: craft deceptive message → create urgency/fear → include malicious link/attachment → victim acts → attacker gains access.
- *Types*: Email phishing (mass, generic); Spear phishing (targeted, personalized); Whaling (targets executives); Smishing (SMS); Vishing (voice calls); Clone phishing (copies a legitimate email); Business Email Compromise/BEC (impersonates executives/vendors for wire transfers).
- *Indicators*: urgent/threatening language; generic greetings; suspicious sender addresses; mismatched hover links; spelling/grammar errors; unexpected attachments; requests for sensitive info.
- *Real-world impact*: the majority of cyberattacks begin with a phishing email; average cost runs into the millions once downtime, response, and reputational damage are included.
- *Prevention*: security awareness training; email filtering; MFA; link/attachment scanning; DMARC/SPF/DKIM; encouraging reporting; simulated phishing tests.

**2. SQL Injection (SQLi)** — a code injection attack where attackers insert malicious SQL code into input fields or URLs to manipulate database queries.
- *How it works*: application builds SQL queries from unvalidated user input → attacker submits malicious input containing SQL commands → database executes the injected code → attacker gains unauthorized access.
- *Example*: input `admin' OR '1'='1` for username turns `SELECT * FROM users WHERE username = 'admin' OR '1'='1' AND password = 'anything'` into an always-true condition, returning all users.
- *Types*: **In-Band (Classic)** — Error-based (uses DB error messages) and Union-based (combines results via `UNION`); **Inferential (Blind)** — Boolean-based and Time-based; **Out-of-Band** — exfiltrates via a different channel (DNS, HTTP).
- *Impact*: unauthorized data access; data modification/deletion; authentication bypass; remote code execution; compliance violations.
- *Real-world examples*: Equifax (2017) — 147 million records exposed; Heartland Payment Systems (2008) — 130 million cards compromised; Sony Pictures (2011).
- *Prevention*: parameterized queries/prepared statements; input validation (allowlists); parameterized stored procedures; WAFs; least privilege for DB accounts; generic error handling; regular security testing; ORM frameworks.
  ```python
  # Vulnerable
  query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"

  # Secure
  query = "SELECT * FROM users WHERE username = ? AND password = ?"
  cursor.execute(query, (username, password))
  ```

**3. Cross-Site Scripting (XSS)** — a web vulnerability where attackers inject malicious scripts (usually JavaScript) into web pages viewed by other users, allowing them to steal session cookies, credentials, or perform actions on the victim's behalf.
- *How it works*: application accepts unvalidated/unencoded user input → attacker submits a malicious script → the script is stored or reflected and served to other users → the victim's browser executes it in the trusted site's context.
- *Types*: **Stored (Persistent)** — permanently stored on the server, affects every viewer; **Reflected (Non-Persistent)** — reflected off the server in a URL/error message, requires a crafted link; **DOM-Based** — vulnerability in client-side JS manipulating the DOM.
- *Impact*: session hijacking; credential theft; defacement; malware distribution; keylogging; phishing; unauthorized actions.
- *Real-world examples*: Twitter (2010) — "Rainbow Turtle" XSS worm; Yahoo (2016) — cookies stolen from 450,000+ accounts; British Airways (2018) — 380,000 customers' payment details stolen.
- *Prevention*: output encoding; input validation; Content Security Policy (CSP); HttpOnly cookies; secure frameworks (React, Angular, Vue) that auto-escape; WAFs; regular testing; avoiding dangerous functions (`innerHTML`, `document.write()`, `eval()`).
  ```javascript
  // Vulnerable
  element.innerHTML = userInput;

  // Secure
  element.textContent = userInput;
  ```

**4. Man-in-the-Middle (MITM) Attacks** — an attack where an attacker secretly intercepts and potentially alters communications between two parties who believe they are directly communicating.
- *How it works*: attacker positions between two parties → intercepts communications undetected → can read/modify/inject data → may impersonate both parties.
- *Scenarios*: unsecured Wi-Fi (rogue hotspots); ARP spoofing/poisoning; DNS spoofing; SSL/TLS stripping; session hijacking; email hijacking (used in BEC).
- *Impact*: credential theft; financial fraud; data breach; identity theft; malware distribution; eavesdropping/espionage.
- *Real-world examples*: Equifax (2017) — MITM techniques used during the breach; RSA Security (2011); countless public Wi-Fi credential-theft incidents.
- *Prevention*: encryption (HTTPS/TLS); VPNs; certificate pinning; strong authentication (MFA); secure Wi-Fi (WPA3, avoiding public networks for sensitive activity); network monitoring; HSTS; DNSSEC; user awareness.

**Common Attacks Summary**

| Attack | Type | Target | Primary Impact | Key Prevention |
|---|---|---|---|---|
| Phishing | Social Engineering | Users | Credential theft, malware | Training, MFA, email filtering |
| SQL Injection | Active | Databases | Data breach, unauthorized access | Parameterized queries, WAF |
| XSS | Active | Web applications | Session hijacking, credential theft | Output encoding, CSP, frameworks |
| MITM | Active/Passive | Communications | Data interception, credential theft | Encryption, VPN, secure protocols |

### 4.3 Key Takeaways
- **Active Attacks** modify or disrupt data (DoS, MITM, SQLi, XSS) — focus on integrity and availability.
- **Passive Attacks** observe without modifying (sniffing, keylogging) — focus on confidentiality.
- **Phishing** is the #1 attack vector — user training and MFA are critical defenses.
- **SQL Injection** exploits poor input validation — use parameterized queries and input sanitization.
- **XSS** allows script injection — implement output encoding, CSP, and secure frameworks.
- **MITM Attacks** intercept communications — use encryption (HTTPS, VPN) and secure protocols.
- A layered defense strategy combining technical controls, user awareness, and secure coding practices is essential.

---

## 5. Classification of Threats and Attacks

Classifying threats and attacks helps organizations understand, prioritize, and defend against different types of security risks. Threats can be categorized by **source**, **motivation**, **target**, and **technique**.

### 5.1 Classification by Source

**Internal Threats** — originate from within the organization, from individuals with authorized access (current/former employees, contractors, business partners, vendors).
- **Malicious insiders**: disgruntled employees, those joining competitors, financially motivated, ideologically motivated (whistleblowers/activists).
- **Negligent insiders**: accidental incidents from lack of awareness or careless behavior.
- **Compromised insiders**: legitimate accounts taken over by external attackers.
- *Why dangerous*: legitimate access; system knowledge; less scrutiny; blends with normal behavior; high impact. Insiders are involved in a majority of breaches, and detection often takes weeks to months.

**External Threats** — originate from outside the organization, from actors without authorized access (individual hackers, organized cybercriminal groups, nation-states, competitors, hacktivists, terrorist organizations).
- **Cybercriminals** — financially motivated; ransomware, fraud, data theft, blackmail.
- **Nation-State Actors** — espionage, sabotage, political influence; APTs, zero-days, supply chain attacks.
- **Hacktivists** — political/social causes; DDoS, defacement, data leaks (e.g., Anonymous, LulzSec).
- **Competitors** — business advantage, IP theft; corporate espionage, insider recruitment.
- **Terrorist Organizations** — disruption, fear, ideological goals; attacks on critical infrastructure.

**Internal vs. External — Comparison**

| Feature | Internal Threats | External Threats |
|---|---|---|
| Source | Employees, contractors, partners | Hackers, criminals, nation-states |
| Access | Authorized (legitimate) | Unauthorized (must gain access) |
| Detection Difficulty | High (blends with normal activity) | Medium (can be detected by perimeter defenses) |
| Knowledge | High (knows systems and data) | Variable (may need to reconnoiter) |
| Motivation | Revenge, profit, negligence, ideology | Profit, espionage, politics, disruption |
| Primary Defenses | UBA, DLP, least privilege, training | Firewalls, IDS/IPS, WAF, patching |

### 5.2 Classification by Motivation

**Financial Gain (Cybercrime)** — the most common driver of cyberattacks today. *Who*: cybercriminals, organized crime groups, individual hackers. *Attack types*: ransomware, data theft, fraud, cryptojacking, credential theft, Business Email Compromise (BEC). *Examples*: WannaCry (2017); Maze ransomware (2019–2020); Colonial Pipeline (2021).

**Political Reasons (Hacktivism, Cyberterrorism)** — motivated by political, ideological, or social causes rather than profit.
- **Hacktivism**: activist hackers/groups (Anonymous, LulzSec) using DDoS, defacement, data leaks, and doxing to disrupt or expose targets.
- **Cyberterrorism**: terrorist/state-sponsored groups attacking critical infrastructure, financial systems, or conducting psychological operations. *Examples*: Ukraine Power Grid attacks (2015, 2016); Stuxnet (2010); NotPetya (2017).

**Espionage (Corporate or Nation-State Spying)** — stealing sensitive information for competitive or strategic advantage.
- **Corporate Espionage**: competitors, hired hackers, insider recruits targeting IP, customer lists, M&A plans, R&D data. *Example*: Uber vs. Waymo (2017).
- **Nation-State Espionage**: government-sponsored hackers (APT10, APT29, Lazarus Group) targeting government agencies, critical infrastructure, tech companies, research institutions, using APTs, supply chain attacks, zero-days, and spear phishing. *Examples*: SolarWinds (2020); Equifax (2017).

**Other Motivations**: **Revenge** (disgruntled employees/former partners — sabotage, leaks); **Curiosity/Challenge** (script kiddies, hobbyists — learning/notoriety); **Ideology** (whistleblowers, activists — leaks, protests); **Disruption/Chaos** (trolls, competitors — DDoS, misinformation).

**Motivation Summary**

| Motivation | Primary Actors | Common Methods | Typical Targets |
|---|---|---|---|
| Financial Gain | Cybercriminals, organized crime | Ransomware, fraud, data theft | Businesses, individuals, financial institutions |
| Political | Hacktivists, terrorists | DDoS, defacement, leaks | Governments, corporations, controversial organizations |
| Espionage | Nation-states, competitors | APTs, spear phishing, supply chain | Defense, tech, research, critical infrastructure |
| Revenge | Disgruntled employees | Sabotage, data theft, leaks | Former employers, specific individuals |
| Curiosity | Script kiddies, hobbyists | Exploits, defacement | Any vulnerable system |

### 5.3 Classification by Target

**Network-Based Attacks** — target network infrastructure, protocols, and communications (routers, switches, firewalls, TCP/IP, DNS, BGP, Wi-Fi, VPN). Attack types: DoS/DDoS; MITM; DNS attacks (spoofing, amplification, tunneling); routing attacks (BGP hijacking); wireless attacks (evil twin, WEP/WPA cracking, packet sniffing); IP spoofing.

**Application-Based Attacks** — target software applications, web applications, and APIs (web apps, mobile apps, desktop software, APIs, databases). Attack types: SQLi; XSS; CSRF; RCE (e.g., Log4Shell); file upload vulnerabilities; API attacks (broken authentication, excessive data exposure, rate-limit bypass); session management attacks (hijacking, fixation).

**User-Based Attacks** — target individuals directly rather than systems (employees, customers, general public, high-value individuals). Attack types: phishing (spear, whaling, smishing, vishing); social engineering (pretexting, baiting, tailgating, quid pro quo); credential stuffing; password attacks (brute force, dictionary, spraying).

**Target Summary**

| Target | Examples | Common Attacks | Primary Defenses |
|---|---|---|---|
| Network | Routers, switches, protocols | DDoS, MITM, DNS attacks | Firewalls, IDS/IPS, segmentation |
| Application | Web apps, APIs, databases | SQLi, XSS, RCE, CSRF | WAF, secure coding, input validation |
| User | Employees, customers | Phishing, social engineering | Training, MFA, awareness |

### 5.4 Classification by Technique

**Social Engineering** — exploiting human psychology (trust, fear, urgency, authority, curiosity) via phishing, pretexting, baiting, tailgating, quid pro quo, and impersonation. (Detailed in Section 2.1 above.)

**Malware** — malicious software designed to infect, damage, or gain unauthorized access: viruses, worms, trojans, ransomware, spyware, adware, rootkits, botnets. (Detailed in Section 3.2 above.)

**Brute Force Attacks** — attempting to guess passwords or encryption keys by trying combinations.
- **Simple brute force**: trying all character combinations (exponential time with password length).
- **Dictionary attacks**: trying common passwords/variations from wordlists.
- **Hybrid brute force**: combining dictionary words with variations.
- **Credential stuffing**: using stolen credentials from one breach against other accounts (works because of password reuse).
- **Password spraying**: trying one common password against many accounts to avoid lockouts.

**Backdoors** — hidden methods to bypass normal authentication and gain unauthorized access.
- **Malicious backdoors**: installed by attackers post-compromise (web shells, RATs, hardcoded credentials) to maintain persistent access.
- **Development backdoors**: intentionally left by developers for debugging, later forgotten or exploited.
- **Hardware backdoors**: physical devices or firmware modifications (extremely hard to detect).
- **Cryptographic backdoors**: intentional weaknesses in encryption algorithms (controversial "lawful access" debates).
- *Common examples*: web shells (China Chopper, Weevely); RATs; hardcoded credentials; supply chain backdoors.

**Other Common Techniques**: **Exploit-based attacks** (zero-days, unpatched vulnerabilities); **Reconnaissance** (port scanning, OS fingerprinting, OSINT); **Privilege escalation** (vertical: user→admin; horizontal: user→peer user); **Lateral movement** (moving through the network to reach valuable targets); **Data exfiltration** (encrypted channels, DNS tunneling, cloud storage).

**Technique Summary**

| Technique | Description | Common Examples | Primary Defenses |
|---|---|---|---|
| Social Engineering | Manipulate human psychology | Phishing, pretexting, baiting | Training, awareness, verification |
| Malware | Malicious software | Viruses, ransomware, trojans | Antivirus, patching, user education |
| Brute Force | Guess passwords/keys | Dictionary, credential stuffing | MFA, account lockouts, strong passwords |
| Backdoors | Hidden access methods | Web shells, RATs, hardcoded creds | Code reviews, monitoring, least privilege |

### 5.5 Comprehensive Classification Summary

**By Source**: Internal (employees, contractors — authorized access, hard to detect) vs. External (hackers, criminals — unauthorized access, perimeter defenses help).

**By Motivation**: Financial (ransomware, fraud — cybercriminals) · Political (hacktivism, DDoS — activists, terrorists) · Espionage (APTs, data theft — nation-states, competitors).

**By Target**: Network (infrastructure — DDoS, MITM — firewalls, IDS) · Application (software, APIs — SQLi, XSS, RCE — WAF, secure coding) · User (individuals — phishing, social engineering — training, MFA).

**By Technique**: Social Engineering (manipulate humans — phishing, pretexting — training, awareness) · Malware (malicious software — ransomware, trojans — antivirus, patching) · Brute Force (guess passwords — dictionary, spraying — MFA, lockouts) · Backdoors (hidden access — web shells, RATs — monitoring, audits).

### 5.6 Key Takeaways
- **By Source**: internal threats (insiders) are often more dangerous than external threats due to legitimate access and system knowledge.
- **By Motivation**: financial gain drives most attacks (ransomware, fraud), but political and espionage motivations are equally damaging.
- **By Target**: network, application, and user-based attacks require different defenses — a layered security approach is essential.
- **By Technique**: social engineering, malware, brute force, and backdoors are common techniques — understanding them helps implement appropriate controls.
- **Defense Strategy**: combine technical controls (firewalls, WAFs, antivirus), user awareness (training, MFA), and processes (incident response, access reviews) for comprehensive protection.
