# Security Audit — Comprehensive Notes

## Introduction

A security audit is a structured, evidence‑based examination of an organization's policies, processes, and technical controls to determine how well they protect information assets and meet legal/industry requirements.
It usually combines document review, interviews, and technical testing to identify gaps, recommend improvements, and support compliance with standards like ISO 27001, GDPR, HIPAA, PCI DSS, or SOC reports.


## Cyber Security Challenges for Organizations

- Rapidly evolving threats and zero‑day vulnerabilities (e.g., Log4Shell) make it hard for organizations to keep up with new attack techniques and required patches.
- Expanded attack surface due to cloud, IoT, remote work, and digital transformation increases the number of entry points an attacker can target.
- Shortage of skilled cybersecurity professionals and under‑utilization or poor integration of security tools weaken detection and response capabilities.
- Human‑factor issues such as phishing, social engineering, insider threats (malicious or accidental), and misconfigurations cause a large share of breaches.
- Compliance pressure and complex regulations (GDPR, HIPAA, PCI DSS, etc.) add overhead and require continuous monitoring and evidence of control effectiveness.

---

## Compliance Basics

- **Compliance** means meeting all applicable legal, regulatory, contractual, and standard‑based requirements (e.g., GDPR, HIPAA, ISO 27001, PCI DSS, SOC 2) related to data protection and information security.
- **GDPR** focuses on personal data protection and privacy rights of individuals in the EU/EEA (lawfulness, transparency, purpose limitation, data minimization, etc.).
- **HIPAA** defines privacy, security, and breach‑notification rules for protected health information in the US healthcare sector.
- **ISO 27001** describes how to establish and continually improve an Information Security Management System (ISMS) using a risk‑based approach and documented controls.
- Typical compliance steps: identify applicable laws/standards, map data and processes, define controls and policies, implement technical/organizational measures, monitor, audit, and document everything for evidence.

---

## Types of Security Audit

- **Internal audit** – performed by the organization's own staff (e.g., internal audit or security team) to check adherence to internal policies and prepare for external reviews.
- **External audit** – conducted by independent third‑party auditors; often required for certifications like ISO 27001, SOC 2, or regulatory attestations, and provides an objective opinion.
- **Compliance / regulatory audit** – verifies whether controls meet specific frameworks such as GDPR, HIPAA, PCI DSS, ISO 27001, or SOC 1/SOC 2.
- **Technical security audit / IT security audit** – deep review of networks, systems, applications, configurations, patching, access controls, and logging, often combined with vulnerability scanning or penetration testing.
- **Process / controls audit** – evaluates governance, risk‑management processes, and internal controls (e.g., change management, incident response, access management) against best practices.
- **Third‑party / vendor audit** – assesses suppliers, cloud providers, or partners to ensure their controls do not introduce excessive supply‑chain risk.

---

## Audit Decision Factors

Key factors that decide **whether, what, and how often** to audit:

- **Risk level and asset criticality** – high‑value or sensitive systems (payment, health data, customer PII) require more frequent and deeper audits.
- **Regulatory and contractual requirements** – laws or customers may mandate specific audits (e.g., annual ISO 27001 surveillance, PCI DSS assessments, SOC reports).
- **Threat environment and incident history** – recent breaches, new vulnerabilities, or increased threat activity push up audit priority.
- **Organizational changes** – major changes like cloud migration, new applications, mergers, or architecture redesign should trigger additional audits post‑change.
- **Available resources and maturity** – budget, skilled staff, and existing control maturity influence audit scope (full‑scope vs focused audits).
- **Recommended frequency** – many organizations run a full audit annually, lighter quarterly reviews, and targeted audits after significant changes.

---

## Security Audit Phases

Most frameworks describe **four main phases** of an internal or security audit:

1. **Planning**
   - Understand business processes, scope, risks, and applicable standards; define objectives, criteria, and audit plan (schedule, methods, sample sizes).
   - Communicate with stakeholders, confirm access to systems and documents, and agree on timelines and logistics.

2. **Fieldwork / Execution**
   - Perform interviews, document review, configuration checks, technical tests, and sampling to evaluate whether controls are designed and operating effectively.
   - Record observations and preliminary findings, discuss them with process owners during the audit to confirm accuracy and context.

3. **Reporting**
   - Consolidate findings, assign severity or risk ratings, and provide clear, evidence‑backed recommendations for corrective actions and improvements.
   - Deliver a written report and hold a closing meeting with management to agree on action plans and deadlines.

4. **Follow‑up**
   - Verify whether agreed corrective and preventive actions were implemented and effective, often via a follow‑up audit or targeted review.
   - Update risk assessments and the audit plan based on results and residual risk.

---

## Requirements of Internal Audit Team

- **Independence in structure** – internal audit should report functionally to top management, the board, or an audit committee, not to the operational managers whose areas they audit (no auditing your own work).
- **Objectivity and impartiality** – auditors must avoid conflicts of interest and maintain an unbiased, skeptical mindset throughout the engagement.
- **Competence** – knowledge of the relevant standard(s) (e.g., ISO 27001, ISO 19011), organizational processes, risks, and audit techniques (planning, sampling, interviewing, evidence collection).
- **Team composition** – an internal audit programme needs a designated lead auditor plus competent auditors with complementary skills (technical, process, and compliance).
- **Clear authority and charter** – a formal internal audit charter defines mandate, scope, responsibilities, and access rights for the audit function.
- **Continuous training** – auditors must keep up to date with evolving threats, technologies, and regulatory changes.

---

## Principles of Audits

ISO‑based guidance (e.g., ISO 19011) defines key **audit principles**:

- **Integrity** – auditors act honestly and ethically; integrity is the foundation of professionalism and trust.
- **Fair presentation** – obligation to report findings truthfully and accurately, including significant obstacles or unresolved disagreements.
- **Due professional care** – apply competence, diligence, and sound professional judgment in planning, performing, and reporting audits.
- **Confidentiality** – protect the security of information obtained during the audit; do not disclose sensitive data except where legally required.
- **Independence** – basis for impartiality and objectivity; auditors must be free from bias and undue influence.
- **Evidence‑based approach** – reach conclusions using verifiable, sufficient, and appropriate audit evidence, not assumptions or personal opinions.
- **Risk‑based approach** – focus audit priorities and depth where risks to objectives and information assets are highest.

---

## Auditor Personal Abilities

Effective auditors need a mix of **personal qualities** and **technical abilities**:

- **Integrity and ethical behavior** – honesty, strong moral principles, and willingness to report unfavorable truths.
- **Objectivity and independence** – ability to remain impartial and avoid conflicts of interest or bias in assessments.
- **Analytical and critical‑thinking skills** – capable of analyzing complex data, identifying patterns/anomalies, and determining root causes.
- **Attention to detail** – careful review of documents, logs, and configurations to detect subtle issues that may indicate control failures.
- **Communication skills** – clear written reports and effective verbal communication with technical and non‑technical stakeholders.
- **Professional skepticism** – questioning attitude, not accepting statements at face value, always seeking sufficient, appropriate evidence.
- **Time management and resilience** – ability to manage multiple audits, meet deadlines, and work under pressure.
- **Adaptability and continuous learning** – staying updated with standards, technologies, and threats, and adjusting audit techniques accordingly.

---

## Identity and Perimeter Audit

Focuses on verifying who is accessing systems, from where, and whether the authentication boundary (perimeter) is secure.

### a) Zero Trust Architecture

- Core principle: **never trust, always verify** — no user or device is trusted by default, even if they are inside the network perimeter.
- Every access request must be authenticated and authorized regardless of origin (internal or external).

### b) Continuous Authentication

- Authentication is not a one‑time event at login; users and devices are re‑verified continuously during a session.
- Behavioral signals (location, typing pattern, device health) can trigger re‑authentication if anomalies are detected.

### c) Multi‑Factor Authentication (MFA)

MFA requires two or more of the following factors:

| Factor                 | Examples                                                |
| ---------------------- | ------------------------------------------------------- |
| **Something you know** | Password, PIN, OTP                                      |
| **Something you have** | Smart card, PAN card, Aadhaar card, hardware token      |
| **Something you are**  | Fingerprint, retina scan, face recognition (biometrics) |
| **Somewhere you are**  | IP address geolocation, GPS location                    |

### d) Least Privilege Access

- Users and processes are granted only the **minimum permissions** required to perform their job — nothing more.
- Implemented using **RBAC (Role‑Based Access Control)**: permissions are assigned to roles, and users are assigned to roles based on their job function.
- Reduces the blast radius of a compromised account or insider threat.

---

## Visibility and Discovery Audit

Focuses on achieving full visibility of all devices and network (N/W) assets — you cannot protect what you cannot see.

- **Device discovery** – identify and inventory every device on the network, including shadow IT and unmanaged endpoints.
- **BYOD (Bring Your Own Device)** – devices outside the corporate perimeter must be assessed; unregistered or non-compliant BYOD devices should be blocked from accessing internal resources.
- **Endpoint exposure** – audit every exposed endpoint (URL + port) to ensure only required services are reachable and all others are closed or firewalled.

---

## DevSecOps and Configuration Audit

Integrates security checks into the software development and deployment pipeline so that issues are caught early, not after deployment.

### a) Continuous Configuration Audit

- Continuously evaluate software, tools, and infrastructure configurations for any unauthorized changes or accidental public exposure of critical data (e.g., S3 buckets, API keys, database ports left open).
- Automated tools scan for configuration drift against a known-good baseline and alert on deviations in real time.

### b) Vulnerability and Compliance Audit

- Software vulnerability checks must be performed at every stage of the pipeline:
  1. **Test / Develop** – static analysis (SAST), dependency scanning.
  2. **Integrate** – dynamic analysis (DAST), container image scanning.
  3. **Deploy** – final compliance gate before production release.
- Applicable compliance frameworks checked at each stage: **HIPAA**, **GDPR**, **DPDP (Digital Personal Data Protection Act)**.

### c) Zero Trust in CI/CD — Target Areas and Artifacts

| Target Area    | Artifact to Audit                                      |
| -------------- | ------------------------------------------------------ |
| Zero Trust     | Conditional access policy configuration                |
| Access control | Role-based, location-based, and MFA-enforced configs   |
| CI/CD pipeline | Pipeline scripts, secrets management, deployment gates |

- **Audit process for access control**: verify that every access control configuration enforces role-based access (RBAC), location-based restrictions, and MFA — not just at login but at each sensitive operation.
- **CI/CD security principle**: security must be proven and validated during development, not bolted on at deployment. The pipeline itself is the evidence of security assurance.

---

## Exam Question (Practice)

**Q:** A production server running critical financial workloads in a hybrid cloud environment needs to be audited. How would you identify unauthorized root-level access and monitor system calls to ensure security?

**Approach:**

- **Identify unauthorized root access** – review sudoers file, audit `/etc/passwd` and privilege escalation logs; check IAM roles and cloud console access logs for unexpected root/admin activity.
- **Monitor system calls** – use tools like `auditd` (Linux Audit Daemon) or cloud-native services (AWS CloudTrail, Azure Monitor) to log and alert on sensitive syscalls (e.g., `execve`, `open`, `ptrace`).
- **Ensure least privilege** – verify no service account or application runs as root unnecessarily; enforce RBAC and just-in-time (JIT) access for admin operations.
- **Continuous monitoring** – deploy a SIEM (e.g., Splunk, Azure Sentinel) to correlate events and detect anomalies in real time across the hybrid environment.

---

## 1. Introduction to Compliance Audit

### Definition of Audit

An **audit** is a systematic, independent, and documented process for obtaining audit evidence and evaluating it objectively to determine the extent to which audit criteria are fulfilled. It involves collecting and assessing evidence to measure whether an organization's systems, processes, and controls comply with defined standards, policies, or regulations. [sailpoint](https://www.sailpoint.com/identity-library/benefits-of-a-cybersecurity-audit)

### Information Security Audit

An **information security audit** is the process of examining and evaluating an organization's information systems, processes, controls, and practices to identify vulnerabilities, risks, and gaps in information security. It involves collecting evidence such as: [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)

- Audit logs
- Documents and policies
- Interviews with personnel
- Technical tests and scans

The audit measures compliance with standards like **ISO 27001**, **PCI DSS**, **HIPAA**, and **GDPR**. [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)

### Compliance Audit vs Security Audit

| Aspect        | Compliance Audit                                     | Security Audit                                       |
| ------------- | ---------------------------------------------------- | ---------------------------------------------------- |
| **Focus**     | Adherence to regulations, standards, and policies    | Identification of vulnerabilities and security gaps  |
| **Objective** | Verify compliance with external requirements         | Assess overall security posture                      |
| **Scope**     | Specific regulatory requirements (e.g., GDPR, HIPAA) | Entire IT infrastructure and security controls       |
| **Outcome**   | Compliance certification or violation report         | Vulnerability report and remediation recommendations |
| **Driver**    | External regulatory mandates                         | Internal risk management                             |

Both are essential: compliance audits ensure you meet legal requirements, while security audits protect against actual threats. [qualysec](https://qualysec.com/cyber-security-compliance-audit-a-comprehensive-overview/)

### Audit Objectives

The main objectives of an audit include:

1. **Identify vulnerabilities** and weaknesses in systems
2. **Verify compliance** with legal/regulatory obligations
3. **Assess control effectiveness** for protecting assets
4. **Reduce risk** of data breaches and cyberattacks
5. **Improve security maturity** and organizational performance
6. **Provide assurance** to stakeholders and regulators [sailpoint](https://www.sailpoint.com/identity-library/benefits-of-a-cybersecurity-audit)

### Benefits of Compliance Audit

- **Protects assets** from threats compromising confidentiality, integrity, and availability [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
- **Ensures regulatory compliance** with GDPR, HIPAA, PCI DSS, ISO 27001 [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
- **Reduces data breach risk** and cyberattack probability [sailpoint](https://www.sailpoint.com/identity-library/benefits-of-a-cybersecurity-audit)
- **Improves reputation** by demonstrating proactive security approach [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
- **Identifies network loopholes** and security endpoints [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Reveals patch management gaps** and prioritizes risk responses [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Assesses workforce cybersecurity education** and training effectiveness [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Importance in Organizations

- **Third line of defense**: After technical controls (first) and governance (second) [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Critical for digital transformation**: Cloud optimization and business growth create new vulnerabilities [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Data breach prevention**: 36 billion records exposed in US data breaches (first half of 2020) [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **43% of enterprises failed compliance audits** in the last 12 months, highlighting widespread challenges [secquest.co](https://www.secquest.co.uk/news/what-is-a-compliance-audit)
- Builds **customer confidence** for business transactions [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- Enables **cybersecurity maturity assessment** for partners and vendors [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

---

## 2. Cyber Security Challenges for Organizations

### Cyber Threat Landscape

The cyber threat landscape is continuously evolving with:

- **Increasing sophistication** of attacks (bot attacks, ransomware variants)
- **Growing attack endpoints** from hardware/software additions [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Cloud security risks** from digital transformation
- **External attacker tactics** evolving daily
- **36 billion records** exposed through breaches (US, first half 2020) [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Insider Threats

**Insider threats** come from employees, contractors, or partners with authorized access:

- **Accidental**: Human errors, misconfigurations, falling for phishing
- **Malicious**: Data theft, sabotage, selling access to attackers
- **8,319 COVID-19 themed cyber/phishing threats** reported (March 2020) vs. 1,448 (February 2020) [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Workforce education gaps**: Many employees lack understanding of phishing and hacker tactics [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Remote work risks**: Increased vulnerability from employees working from home [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Malware and Ransomware

- **Malware types**: Trojans, worms, spyware, rootkits, fileless malware
- **Ransomware**: Encrypts data and demands payment for decryption
- **Bot attack risks** from software downloads [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Fileless malware**: Operates without leaving files on disk
- **Supply chain malware**: Compromises third-party software

### Data Breaches

**Data breach characteristics**:

- **Exposure scale**: 36 billion records exposed (US, H1 2020) [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Types**: Unauthorized access, theft, accidental disclosure
- **Sensitive data**: Personal information, financial data, intellectual property
- **Consequences**: Financial loss, regulatory penalties, reputation damage
- **Common causes**: Network loopholes, unpatched systems, insider threats [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Cloud Security Challenges

**Cloud-specific risks**:

- **Data portability issues**: Moving data between cloud providers
- **Shared responsibility model**: Confusion about who secures what
- **Misconfigured security settings**: Default insecure configurations
- **Insufficient access controls**: Over-permissive permissions
- **Data portability**: Difficulty extracting data from cloud platforms
- **System interconnection risks**: API vulnerabilities, integration points [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **New security endpoints** from cloud services expansion [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Third-Party Risks

**Third-party vulnerabilities**:

- **Software downloads**: Hundreds/thousands of employees downloading software unchecked [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Supply chain attacks**: Compromised vendor software or services
- **Vendor security gaps**: Poor security practices by partners
- **Increased complexity**: Adding hardware/software solutions creates new endpoints [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Difficulty tracking**: Impossible to monitor all software downloads by employees [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Regulatory Challenges

**Compliance difficulties**:

- **Varying regulations**: Different scopes by business model, industry, and timeframe [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Complex requirements**: Tough to understand without legal team [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **New regulatory bindings**: Continuous emergence of new compliance standards [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Industry-specific rules**: GDPR (EU), HIPAA (healthcare), PCI DSS (payments), ISO 27001 [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
- **43% failure rate** in compliance audits indicates widespread compliance challenges [secquest.co](https://www.secquest.co.uk/news/what-is-a-compliance-audit)
- **Enforcement penalties**: Costly compliance violations and data breach fines

---

## 3. Compliance Basics

### Compliance Definition

**Compliance** is the state of being in accordance with legal/regulatory obligations and internal policies/standards for information security. It involves: [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)

- Implementing appropriate measures (policies, procedures, guidelines, controls)
- Maintaining compliance with defined standards
- Ensuring adherence to requirements continuously

### Regulatory Compliance

**Regulatory compliance** means adhering to:

- **Government mandates**: Laws enacted by legislative bodies
- **Industry standards**: Voluntary frameworks (ISO, NIST)
- **Sector-specific regulations**: HIPAA (healthcare), PCI DSS (payments), GDPR (data privacy)
- **Regional requirements**: Different rules by operating location [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Legal Requirements

Key legal requirements include:

- **GDPR** (General Data Protection Regulation): EU data privacy
- **HIPAA** (Health Insurance Portability): US healthcare data
- **PCI DSS** (Payment Card Industry): Credit card security
- **ISO 27001**: Information security management
- **NIST Cybersecurity Framework**: Critical infrastructure security [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
- Country-specific laws (e.g., India's IT Act, Digital Personal Data Protection Act)

### Policies and Standards

**Organizational policies**:

- **Data security policies**: Company-specific data protection rules
- **Centralized cybersecurity policies**: Unified security framework [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Access control policies**: Who can access what resources
- **Incident response policies**: How to handle security incidents
- **Password policies**: Authentication requirements

**Standards** provide frameworks:

- ISO 27001, NIST CSF, CIS Controls, OWASP

### Governance, Risk and Compliance (GRC)

**GRC** is an integrated approach:

- **Governance**: Security checks on overall strategy and decision-making [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Risk**: Identifying, assessing, and prioritizing cybersecurity risks [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Compliance**: Ensuring adherence to regulations and standards

**GRC components**:

1. Security governance framework
2. Risk assessment and management
3. Compliance monitoring and reporting
4. Policy development and enforcement
5. Continuous improvement

### Compliance Lifecycle

The **compliance lifecycle** includes six key steps: [swimlane](https://swimlane.com/blog/cyber-security-compliance-audit/)

1. **Identify**: Determine applicable regulations and requirements
2. **Assess**: Evaluate current compliance status and gaps
3. **Plan**: Develop remediation strategies and timelines
4. **Implement**: Deploy controls, policies, and procedures
5. **Monitor**: Continuous compliance monitoring and auditing
6. **Report**: Document compliance status to stakeholders

**Ongoing activities**:

- Regular audits (internal/external)
- Policy updates
- Control testing
- Training and awareness
- Incident response testing

---

## 4. Types of Security Audit

### Internal Audit

**Internal audits** are performed by:

- Organization's own audit team
- Internal security personnel
- Employees with audit responsibilities

**Characteristics**:

- **Cost-effective**: No external fees
- **Familiarity**: Team knows organization's systems
- **Continuous**: Can be performed regularly
- **Limitation**: Less independent, potential bias [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### External Audit

**External audits** are conducted by:

- Independent third-party auditors
- External certification bodies
- Regulatory agency inspectors

**Characteristics**:

- **Independence**: Unbiased assessment
- **Expertise**: Specialized audit knowledge
- **Credibility**: Results accepted by regulators
- **Cost**: Higher due to external fees [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Technical Audit

**Technical audits** focus on:

- **IT infrastructure**: Hardware, software, networks
- **Technical controls**: Firewalls, encryption, access controls
- **Configuration reviews**: System settings and parameters
- **Vulnerability scanning**: Automated security testing
- **Log analysis**: Audit trail examination

**Tools used**: Nmap, OpenVAS, Wireshark, vulnerability scanners

### Compliance Audit

**Compliance audits** verify:

- Adherence to **regulatory requirements** (GDPR, HIPAA, PCI DSS)
- Compliance with **industry standards** (ISO 27001)
- Adherence to **internal policies** and procedures
- **Documentation review**: Policies, procedures, evidence

**Purpose**: Certification, regulatory approval, violation prevention [prescientsecurity](https://prescientsecurity.com/resources/blogs/what-is-a-compliance-audit)

### Operational Audit

**Operational audits** assess:

- **Business processes**: Workflow efficiency and security
- **Human factors**: Employee practices and behaviors
- **Procedural compliance**: Following established procedures
- **Resource management**: Proper use of security resources
- **Workforce education**: IT staff understanding of cyber threats [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

**Focus**: How security controls operate in practice

### Vulnerability Assessment

**Vulnerability assessments** involve:

- **Systematic scanning**: Automated vulnerability detection
- **Identification**: Finding security weaknesses
- **Classification**: Categorizing vulnerabilities by severity
- **Prioritization**: Weight-defined risk scores [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Reporting**: Detailed vulnerability documentation

**Tools**: OpenVAS, Nessus, Qualys, Nmap
**Output**: Vulnerability list with remediation recommendations [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)

### Penetration Testing

**Penetration testing** (pen testing) includes:

- **Active attacking**: Simulating real attacker tactics
- **Exploitation**: Attempting to exploit found vulnerabilities
- **Objective**: Determine if vulnerabilities can be compromised
- **Scope**: Black box (no knowledge), gray box (partial), white box (full knowledge)
- **Types**: Network, application, social engineering, physical

**Difference from vulnerability assessment**: Pen testing attempts exploitation; vulnerability assessment only identifies

**Output**: Proof of exploitation, security gaps, remediation priority [dataguard](https://www.dataguard.com/cyber-security/audit/)

---

## 5. Audit Decision Factors

### Risk Assessment

**Risk assessment** determines audit scope and priority:

- **Identify risks**: Threats, vulnerabilities, impacts
- **Assess likelihood**: Probability of risk occurrence
- **Calculate risk score**: Weight-defined scores [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Prioritize**: Focus on highest-risk areas first [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Risk matrix**: Visual representation of risk levels

**Risk assessment components**:

1. Asset identification
2. Threat identification
3. Vulnerability analysis
4. Impact assessment
5. Likelihood estimation
6. Risk calculation

### Business Impact

**Business impact analysis** considers:

- **Financial consequences**: Direct costs, fines, compensation
- **Operational disruption**: Service downtime, productivity loss
- **Reputation damage**: Customer trust, brand value
- **Legal consequences**: Litigation, regulatory penalties
- **Strategic impact**: Competitive advantage loss

**Impact levels**:

- **Critical**: Business cannot operate
- **High**: Significant operational impact
- **Medium**: Moderate disruption
- **Low**: Minimal impact

### Regulatory Requirements

**Regulatory factors** influencing audit decisions:

- **Mandatory requirements**: Laws requiring specific audits
- **Industry-specific rules**: Healthcare (HIPAA), Finance (PCI DSS)
- **Geographic requirements**: Different rules by location [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
- **Compliance deadlines**: When audit must be completed
- **Penalty severity**: Cost of non-compliance

**Regulatory drivers**:

- GDPR: Annual compliance audits required
- HIPAA: Risk analysis every 12 months
- PCI DSS: Annual PCI audit for merchants
- ISO 27001: Annual certification audits

### Asset Criticality

**Asset criticality** determines audit focus:

- **Critical assets**: Systems essential for business operations
- **High-value assets**: Contain sensitive data (PII, financial)
- **Medium-criticality**: Important but not essential
- **Low-criticality**: Non-essential systems

**Criticality factors**:

1. **Business function**: How essential for operations
2. **Data sensitivity**: Type of information stored
3. **Recovery time**: Time acceptable for restoration
4. **Dependencies**: Other systems depending on it
5. **Regulatory impact**: Legal requirements for asset

**Prioritization**: Audit critical assets more frequently and thoroughly

### Budget and Resources

**Resource constraints** affecting audit decisions:

| Factor                 | Consideration                        |
| ---------------------- | ------------------------------------ |
| **Budget**             | Available funds for audit activities |
| **Staff availability** | Number of qualified auditors         |
| **Technical tools**    | Audit software and scanning tools    |
| **Time constraints**   | Deadline for audit completion        |
| **External expertise** | Need for third-party auditors        |

**Budget considerations**:

- Internal audit: Lower cost (staff time only)
- External audit: Higher cost (professional fees)
- Tool costs: Vulnerability scanners, penetration testing tools
- Training costs: Auditor certification and skills development

**Resource optimization**:

- Prioritize high-risk areas first
- Use automated tools for efficiency
- Combine audit types (compliance + security)
- Schedule audits during low-activity periods
- Leverage existing documentation

**Decision framework**:

1. Assess regulatory requirements (mandatory vs. optional)
2. Evaluate asset criticality and business impact
3. Conduct risk assessment for priority areas
4. Match audit scope to available budget/resources
5. Plan audit timeline within constraints

---

## Key Takeaways

1. **Compliance audits** verify regulatory adherence; **security audits** identify vulnerabilities—both are essential [qualysec](https://qualysec.com/cyber-security-compliance-audit-a-comprehensive-overview/)
2. **43% of enterprises failed compliance audits** recently, indicating widespread challenges [secquest.co](https://www.secquest.co.uk/news/what-is-a-compliance-audit)
3. **Insider threats** and **unpatched systems** are major vulnerability sources [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
4. **GRC integration** ensures comprehensive security management [studocu](https://www.studocu.com/en-us/document/american-intercontinental-university/specialized-network-administration/information-security-auditing-and-compliance/59879503)
5. **Audit decision factors** (risk, impact, regulations, criticality, resources) determine audit scope and priority [cai](https://www.cai.io/resources/articles/five-secrets-a-cybersecurity-audit-can-reveal)
6. **Vulnerability assessments** identify weaknesses; **penetration testing** attempts exploitation [dataguard](https://www.dataguard.com/cyber-security/audit/)
7. **Compliance lifecycle** is continuous: Identify → Assess → Plan → Implement → Monitor → Report [swimlane](https://swimlane.com/blog/cyber-security-compliance-audit/)

---

## 6. Security Audit Phases

### Planning

**Planning** is the foundational phase that determines audit success:

- **Define audit objectives**: What the audit aims to achieve
- **Identify applicable regulations/standards**: GDPR, HIPAA, ISO 27001, PCI DSS
- **Assign audit team**: Roles, responsibilities, and lead auditor
- **Develop audit plan**: Timeline, milestones, and deliverables
- **Obtain management authorization**: Formal approval and mandate
- **Review previous audit findings**: Use past reports to guide current focus
- **Identify stakeholders**: Who will receive the audit report

**Planning outputs**:

1. Audit charter (formal authorization)
2. Audit plan document
3. Resource allocation plan
4. Preliminary risk assessment

---

### Scoping

**Scoping** defines the boundaries and depth of the audit:

- **Define audit boundaries**: Which systems, networks, departments are included
- **Exclude out-of-scope systems**: Clearly state what is NOT audited
- **Identify assets under review**: Servers, endpoints, databases, cloud systems
- **Set testing limits**: What types of tests are allowed (non-destructive only, etc.)
- **Define regulatory focus**: Which specific compliance frameworks apply
- **Agree on timeframes**: When testing can occur (business hours vs. off-hours)

**Scope document includes**:

- IP ranges and network segments
- Applications and databases
- Physical locations
- Personnel and departments
- Third-party systems

---

### Information Gathering

**Information gathering** (reconnaissance phase) collects data about the target environment:

| Method                   | Description                                                    |
| ------------------------ | -------------------------------------------------------------- |
| **Document review**      | Policies, procedures, network diagrams, previous audit reports |
| **System inventory**     | Hardware/software asset lists                                  |
| **Interviews**           | Talking to IT staff, management, end users                     |
| **Network scanning**     | Tools like Nmap to map network topology                        |
| **Log review**           | Examining system/access/security logs                          |
| **Configuration review** | Checking firewall, router, server settings                     |

**Types of information collected**:

- Organizational structure and responsibilities
- Existing security controls
- Previous vulnerabilities and incidents
- Network architecture and data flows
- Access control mechanisms

---

### Testing

**Testing** is the active phase where evidence is collected through technical examination:

**Types of tests performed**:

1. **Vulnerability scanning**: Automated tools (Nessus, OpenVAS) scan for known weaknesses
2. **Penetration testing**: Attempting exploitation of vulnerabilities
3. **Configuration auditing**: Reviewing system/device settings against benchmarks (CIS)
4. **Access control testing**: Verifying user permissions and role assignments
5. **Log analysis**: Reviewing logs for anomalies and unauthorized activity
6. **Social engineering tests**: Phishing simulations, physical access attempts
7. **Password testing**: Auditing password policies and credential strength

**Testing principles**:

- Obtain written authorization before testing
- Document all testing activities and timestamps
- Minimize disruption to production systems
- Use controlled test environments where possible

---

### Reporting

**Reporting** translates findings into actionable documentation:

**Report structure**:

1. **Executive summary**: High-level overview for management (non-technical)
2. **Scope and methodology**: What was tested and how
3. **Findings**: Detailed list of discovered issues with severity ratings
4. **Risk ratings**: Critical, High, Medium, Low classifications
5. **Evidence**: Screenshots, logs, scan outputs supporting findings
6. **Recommendations**: Specific remediation steps for each finding
7. **Conclusion**: Overall security posture assessment

**Severity classification** (CVSS-based):

- **Critical (9.0–10.0)**: Immediate action required
- **High (7.0–8.9)**: Action within 30 days
- **Medium (4.0–6.9)**: Action within 90 days
- **Low (0.1–3.9)**: Action during next maintenance cycle

---

### Follow-up Activities

**Follow-up** ensures findings lead to real improvements:

- **Remediation tracking**: Monitor progress on fixing identified issues
- **Re-testing**: Verify that fixes are effective (closure testing)
- **Management review**: Present findings to senior leadership
- **Policy updates**: Revise policies based on audit findings
- **Training**: Address human/process gaps through awareness programs
- **Next audit planning**: Use current findings to shape the next audit cycle
- **Compliance reporting**: Submit results to regulatory bodies if required

---

## 7. Internal Audit Team Requirements

### Auditor Skills

A qualified security auditor must possess:

- **Technical competency**: Understanding of IT systems, networks, and security tools
- **Analytical ability**: Capacity to interpret complex technical and business data
- **Risk management knowledge**: Ability to assess and prioritize risks
- **Regulatory knowledge**: Familiarity with GDPR, HIPAA, PCI DSS, ISO 27001
- **Documentation skills**: Writing clear, accurate, evidence-based reports
- **Project management**: Ability to plan, execute, and deliver audits on schedule

---

### Technical Knowledge

**Core technical areas** required:

1. **Networking**: TCP/IP, routing, VLANs, firewalls, IDS/IPS
2. **Operating systems**: Windows Server, Linux administration
3. **Security tools**: Nmap, Wireshark, Nessus, OpenVAS, Metasploit
4. **Cryptography**: Encryption standards, PKI, certificate management
5. **Cloud platforms**: AWS, Azure, GCP security configurations
6. **Application security**: OWASP Top 10, web application vulnerabilities
7. **Database security**: SQL, access controls, audit logging

**Certifications that validate technical knowledge**:

- CISA (Certified Information Systems Auditor)
- CISSP (Certified Information Systems Security Professional)
- CEH (Certified Ethical Hacker)
- CompTIA Security+

---

### Independence

**Independence** is a cornerstone of valid auditing:

- **Organizational independence**: Auditors should not report to departments they audit
- **Financial independence**: No financial interest in audit outcomes
- **Relationship independence**: No close personal ties to auditees
- **Reporting line**: Internal auditors should report directly to the audit committee or board
- **Functional separation**: Audit team is separate from IT operations

**Independence threats**:

- Self-review threat (auditing your own work)
- Familiarity threat (too close to auditee)
- Advocacy threat (defending the organization being audited)

---

### Objectivity

**Objectivity** ensures unbiased, fair assessments:

- **Evidence-based decisions**: Conclusions based on facts, not assumptions
- **Balanced reporting**: Report both strengths and weaknesses
- **No predetermined outcomes**: Audit without expectation of specific results
- **Professional skepticism**: Question information presented by auditees
- **Consistency**: Apply same standards across all audited areas
- **Peer review**: Have findings reviewed by another auditor before submission

---

### Team Structure

A well-structured internal audit team includes:

| Role                            | Responsibility                                    |
| ------------------------------- | ------------------------------------------------- |
| **Chief Audit Executive (CAE)** | Strategic direction and board reporting           |
| **Audit Manager**               | Planning, supervision, and stakeholder management |
| **Lead Auditor**                | Fieldwork coordination and quality control        |
| **Technical Auditor**           | Vulnerability scanning and technical testing      |
| **Compliance Analyst**          | Regulatory requirement verification               |
| **Junior Auditor**              | Documentation, evidence collection, support tasks |

**Ideal team characteristics**:

- Mix of technical and non-technical skills
- Diversity of experience (internal + external backgrounds)
- Continuous professional development (CPD) commitment
- Rotation policy to maintain independence

---

## 8. Principles of Auditing

### Integrity

**Integrity** is the foundation of professional auditing:

- **Honesty**: Auditors must be truthful and transparent in all communications
- **Accuracy**: Report only what evidence supports
- **Courage**: Willingness to report unfavorable findings to management
- **Diligence**: Thorough and careful execution of audit activities
- **Professional ethics**: Adherence to a code of conduct (ISACA, IIA)
- **No conflicts**: Disclose and avoid conflicts of interest

---

### Confidentiality

**Confidentiality** protects sensitive audit information:

- **Data protection**: All audit findings, evidence, and working papers are confidential
- **Need-to-know basis**: Only share findings with authorized stakeholders
- **Secure storage**: Audit documentation stored securely (encrypted, access-controlled)
- **Third-party restrictions**: Don't share organizational data with outside parties
- **Post-audit retention**: Maintain confidentiality even after audit completion
- **Non-disclosure agreements**: Auditors may sign NDAs before accessing sensitive systems

---

### Independence

**Independence** (as a principle, beyond just team structure):

- **Mental independence**: Free thinking without influence from management
- **Structural independence**: Organizational separation from audited functions
- **External validation**: External auditors provide highest independence
- **ISO 19011 definition**: "Freedom from bias and conflicts of interest"
- **Benefits**: Increases credibility and trustworthiness of audit results

---

### Evidence-Based Approach

**Evidence-based auditing** requires:

- **Sufficient evidence**: Enough information to support conclusions
- **Relevant evidence**: Directly related to the audit objective
- **Reliable evidence**: From credible, verifiable sources
- **Types of evidence**:
  1. Physical evidence (hardware, printouts)
  2. Documentary evidence (logs, policies, records)
  3. Testimonial evidence (interviews, statements)
  4. Analytical evidence (comparisons, calculations)
- **Evidence chain**: Maintain clear linkage between evidence and findings

---

### Fair Presentation

**Fair presentation** ensures audit results are accurate and balanced:

- **Complete reporting**: Include all significant findings, both positive and negative
- **Accurate description**: Describe findings precisely without exaggeration
- **Context inclusion**: Provide context for findings (e.g., resource constraints)
- **Balanced tone**: Professional, neutral language throughout
- **No selective reporting**: Cannot omit inconvenient findings
- **Proportionate language**: Severity ratings accurately reflect actual risk
- **ISO 19011 guidance**: Findings must faithfully represent audit evidence

---

## 9. Auditor Personal Abilities

### Communication Skills

**Effective communication** is critical for auditors:

- **Verbal communication**: Clearly explain findings to technical and non-technical audiences
- **Active listening**: Understand auditee responses during interviews
- **Presentation skills**: Deliver audit results to management and board
- **Adaptability**: Adjust communication style for different audiences
- **Diplomacy**: Deliver critical findings professionally without being confrontational
- **Written clarity**: Produce reports that are unambiguous and actionable

**Communication challenges**:

- Technical jargon vs. management language
- Cross-cultural communication in multinational audits
- Delivering negative findings without creating defensiveness

---

### Analytical Thinking

**Analytical skills** enable auditors to:

- **Identify patterns**: Spot trends in logs, data, and behavior
- **Root cause analysis**: Determine underlying causes, not just symptoms
- **Risk analysis**: Evaluate potential impact and likelihood of threats
- **Critical evaluation**: Question assumptions and validate data
- **Data interpretation**: Make sense of vulnerability scan outputs and metrics
- **Logical reasoning**: Build coherent arguments supported by evidence

**Analytical frameworks used**:

- Risk matrices
- SWOT analysis
- Gap analysis (current vs. required state)
- CVSS scoring interpretation

---

### Observation Skills

**Observation** is a key evidence-gathering technique:

- **Physical observation**: Inspecting server rooms, workstations, physical access controls
- **Procedural observation**: Watching how staff perform tasks (are policies followed?)
- **Behavioral observation**: Noting employee security behaviors (clean desk, screen locking)
- **Environmental observation**: Physical security, CCTV, badge readers
- **System observation**: Live monitoring of user activity on test systems
- **Documentation review**: Spotting inconsistencies in records

**What auditors observe**:

- Are passwords written on sticky notes?
- Are server room doors locked?
- Are employees following data disposal procedures?
- Are visitor logs maintained and verified?

---

### Interview Techniques

**Interviews** provide testimonial evidence:

**Types of interviews**:

1. **Structured**: Pre-defined questions, consistent across all auditees
2. **Semi-structured**: Core questions with flexibility for follow-up
3. **Unstructured**: Open-ended, exploratory conversations

**Best practices**:

- Prepare questions in advance linked to audit objectives
- Create a comfortable, non-threatening environment
- Use open-ended questions ("Tell me about your backup process...")
- Avoid leading questions that suggest expected answers
- Document responses contemporaneously
- Verify verbal claims with documentary evidence
- Thank and follow up with interviewees

**Common interview subjects**:

- IT administrators (technical controls)
- HR managers (personnel security)
- Business managers (policy adherence)
- End users (security awareness)

---

### Report Writing

**Report writing** is the primary deliverable of an audit:

**Characteristics of a good audit report**:

- **Clear**: Understandable by the intended audience
- **Concise**: No unnecessary detail or repetition
- **Complete**: Covers all significant findings
- **Constructive**: Provides actionable recommendations
- **Accurate**: Every claim supported by evidence
- **Timely**: Delivered within agreed timeframes

**Report writing principles**:

1. Use plain language for executive sections
2. Use technical detail for technical recommendations
3. Reference specific evidence for each finding
4. Include risk ratings consistently
5. Prioritize findings by severity
6. Use visuals (charts, tables) to clarify data
7. Proofread for spelling and factual accuracy

---

## 10. Security Evaluation

### Purpose of Evaluation

**Security evaluation** assesses the effectiveness of security controls and programs:

- **Measure security posture**: Current level of protection vs. required level
- **Identify improvement areas**: Where security investments are needed
- **Demonstrate compliance**: Prove regulatory requirements are met
- **Risk quantification**: Translate security risks into business terms
- **Justify investment**: Provide evidence for security budget requests
- **Benchmark progress**: Compare security posture over time
- **Stakeholder assurance**: Give confidence to customers, partners, regulators

**Evaluation vs. Audit**:

- Audit verifies compliance with standards
- Evaluation measures _effectiveness_ of security controls in practice

---

### Evaluation Criteria

**Evaluation criteria** define what "good security" looks like:

| Criterion           | Description                              |
| ------------------- | ---------------------------------------- |
| **Confidentiality** | Data accessible only to authorized users |
| **Integrity**       | Data not altered without authorization   |
| **Availability**    | Systems operational when needed          |
| **Accountability**  | Actions traceable to individuals         |
| **Non-repudiation** | Actions cannot be denied                 |
| **Authenticity**    | Identity of users/systems verified       |

**Standards as criteria**:

- **ISO 27001**: 114 controls across 14 domains
- **NIST CSF**: Identify, Protect, Detect, Respond, Recover
- **CIS Controls**: 18 critical security controls
- **PCI DSS**: 12 requirements for payment card security

---

### Security Metrics

**Security metrics** quantify the security posture:

**Types of metrics**:

1. **Operational metrics**: Day-to-day security performance
   - Number of vulnerabilities detected/patched
   - Mean Time to Detect (MTTD)
   - Mean Time to Respond (MTTR)
2. **Compliance metrics**: Regulatory adherence
   - Percentage of controls compliant
   - Number of policy violations
   - Audit pass/fail rates
3. **Risk metrics**: Risk quantification
   - Number of critical vulnerabilities open
   - Risk score by system/department
4. **Incident metrics**: Security events
   - Number of incidents per month
   - Incident severity distribution
   - Recurrence rate

**Good metrics are SMART**:

- **S**pecific, **M**easurable, **A**chievable, **R**elevant, **T**ime-bound

---

### Evaluation Models

**Evaluation models** provide structured frameworks for measuring security:

**1. NIST Cybersecurity Framework (CSF)**

- Five functions: **Identify → Protect → Detect → Respond → Recover**
- Four maturity tiers: Partial → Risk Informed → Repeatable → Adaptive
- Used to evaluate organizational cybersecurity maturity

**2. Capability Maturity Model Integration (CMMI)**

- Five levels: Initial → Managed → Defined → Quantitatively Managed → Optimizing
- Assesses process maturity of security practices

**3. ISO 27001 / ISMS Evaluation**

- Plan-Do-Check-Act (PDCA) cycle
- Evaluates Information Security Management System effectiveness
- Requires internal and external certification audits

**4. OWASP Security Evaluation (for applications)**

- Evaluates web application security
- Based on OWASP Top 10 vulnerability categories

**5. Red Team / Blue Team Evaluation**

- **Red Team**: Offensive evaluation (simulates attackers)
- **Blue Team**: Defensive evaluation (detects and responds)
- **Purple Team**: Combined evaluation for improvement

**6. Common Criteria (ISO/IEC 15408)**

- International standard for IT security product evaluation
- Defines **EAL (Evaluation Assurance Levels)** from EAL1 (lowest) to EAL7 (highest)
- Used for evaluating hardware/software security products

---

## Quick Revision Summary

| Topic              | Key Point                                                       |
| ------------------ | --------------------------------------------------------------- |
| Audit Phases       | Plan → Scope → Gather → Test → Report → Follow-up               |
| Auditor Skills     | Technical, analytical, communication, regulatory knowledge      |
| Independence       | Structural + mental freedom from bias                           |
| Core Principles    | Integrity, Confidentiality, Independence, Evidence-based, Fair  |
| Personal Abilities | Communication, Analysis, Observation, Interview, Report Writing |
| Evaluation Purpose | Measure effectiveness, benchmark progress, justify investment   |
| Security Metrics   | MTTD, MTTR, compliance %, vulnerability counts                  |
| Evaluation Models  | NIST CSF, CMMI, ISO 27001, Common Criteria, Red/Blue Team       |

# Comprehensive Notes: Evaluation Process to NIST Framework

---

## 11. Evaluation Process

### Scope Definition

**Scope definition** establishes the boundaries of the evaluation:

- **Target of Evaluation (TOE)**: The specific IT product, system, or component being evaluated
- **Evaluation boundaries**: Clearly define what is included and excluded
- **Security objectives**: State what security properties the TOE must satisfy
- **Environmental assumptions**: Define the operational environment where the TOE will be used
- **Interfaces and dependencies**: Identify connections with external systems
- **Evaluation depth**: Determine level of rigor (functional testing vs. formal verification)

**Scope document captures**:

1. TOE description (hardware, software, firmware)
2. Security functions under evaluation
3. Interfaces (user, admin, external)
4. Physical and logical boundaries
5. Intended use environment

---

### Evidence Collection

**Evidence collection** gathers data to support evaluation conclusions:

**Types of evidence**:

| Evidence Type              | Examples                                                            |
| -------------------------- | ------------------------------------------------------------------- |
| **Design documentation**   | Architecture specs, functional specs, high-level design             |
| **Source code**            | For higher EAL levels requiring code analysis                       |
| **Test documentation**     | Test plans, test procedures, test results                           |
| **Configuration records**  | System configuration guides, operational procedures                 |
| **Vulnerability analysis** | Developer's vulnerability assessment, known vulnerability databases |
| **Delivery documentation** | How the product is securely delivered to users                      |

**Evidence collection principles**:

- Collect from multiple sources to corroborate findings
- Maintain chain of custody for all evidence
- Timestamp all collected data
- Verify authenticity of documentation
- Cross-reference developer claims with actual system behavior

---

### Analysis

**Analysis** interprets collected evidence to reach conclusions:

- **Functional analysis**: Does the TOE perform its claimed security functions?
- **Vulnerability analysis**: Are there exploitable weaknesses in the TOE?
- **Consistency check**: Do different pieces of evidence agree with each other?
- **Completeness check**: Is all required evidence present?
- **Coverage analysis**: Do tests cover all claimed security functions?
- **Depth analysis**: Is testing sufficiently thorough for the assurance level?
- **Penetration testing**: Attempt to exploit potential vulnerabilities

**Analysis techniques**:

1. Document review and cross-referencing
2. Automated vulnerability scanning
3. Manual code review (at higher EALs)
4. Independent testing by evaluator
5. Comparison against evaluation criteria

---

### Reporting

**Evaluation reporting** communicates the evaluation outcome:

- **Evaluation Technical Report (ETR)**: Detailed record of all evaluation activities and findings
- **Certification/Validation Report**: Official result issued by certification body
- **Non-compliance findings**: Issues that must be resolved before certification
- **Assurance level achieved**: Which EAL was successfully met
- **Residual vulnerabilities**: Known issues accepted within the security scope
- **Recommendations**: Guidance for secure deployment and operation

**Report components**:

1. TOE description and evaluated configuration
2. Evaluation methodology applied
3. Evidence examined
4. Tests performed and results
5. Vulnerabilities found and assessed
6. Evaluator verdict (pass/fail per assurance component)

---

## 12. Evaluation Phases

### Preparation

**Preparation** sets up the evaluation for success:

- **Contract establishment**: Formal agreement between developer, sponsor, and evaluation facility
- **Security Target (ST) review**: Evaluators review the developer's security claims document
- **Evaluation plan development**: Schedule, resource allocation, evaluation approach
- **Tool preparation**: Set up evaluation tools, test environments, and lab
- **Background research**: Understand TOE type, purpose, and security domain
- **Preliminary document review**: Initial check that required evidence is present

**Key documents prepared**:

- Evaluation plan
- Security Target (ST)
- Protection Profile (PP) if applicable
- Initial evidence checklist

---

### Assessment

**Assessment** is the core evaluation work:

- **Security Target evaluation**: Verify ST is complete, consistent, and technically sound
- **Development evidence assessment**: Evaluate design documents, architecture, implementation
- **Testing phase**:
  - Review developer test plans and procedures
  - Verify developer test results
  - Conduct independent evaluator testing
  - Perform penetration testing (at higher EALs)
- **Guidance evaluation**: Assess user/admin documentation for completeness and accuracy
- **Lifecycle assessment**: Review development environment, tools, CM system, delivery process

**Assessment activities by level**:

- Lower EALs: Focus on functional testing
- Middle EALs: Add structural analysis and independent testing
- Higher EALs: Include formal methods and exhaustive analysis

---

### Verification

**Verification** confirms assessment findings are accurate and complete:

- **Independent verification**: Separate evaluator reviews assessment conclusions
- **Evidence re-examination**: Spot-check key evidence used in assessment
- **Test reproduction**: Attempt to reproduce developer test results independently
- **Consistency verification**: Check that all evaluation work products are consistent
- **Coverage verification**: Confirm all security functions have been assessed
- **Penetration testing verification**: Verify exploitability assessments are correct
- **Oversight by Certification Body**: National certification authority reviews ETR

---

### Reporting

**Final reporting phase** formalizes the evaluation outcome:

- **Evaluation Technical Report (ETR)**: Submitted by evaluation facility to certification body
- **Certification body review**: Independent review of the ETR
- **Certificate issuance**: If evaluation passes, certificate is issued
- **Published in Common Criteria portal**: Result publicly listed on commoncriteriaportal.org
- **Maintenance provisions**: How the certificate is maintained as product updates
- **Assurance continuity**: Tracking changes between certified versions

---

## 13. Assurance Levels (7 Evaluation Levels)

The **Evaluation Assurance Levels (EAL1–EAL7)** are defined under the **Common Criteria (ISO/IEC 15408)** standard. Higher EALs require more rigorous evaluation but do not necessarily mean more security features — they mean **greater confidence** that the claimed security functions work as intended.

---

### EAL1 – Functionally Tested

- **Assurance**: Lowest level of assurance
- **Testing**: Independent functional testing of security functions
- **Documentation**: Basic documentation of the TOE
- **Use case**: Low-risk environments; when some confidence is needed without developer cooperation
- **Key activities**: Security Target review, functional testing, independent test coverage
- **Example**: Simple consumer software products

---

### EAL2 – Structurally Tested

- **Assurance**: Low-to-medium assurance
- **Testing**: Developer testing + independent evaluator testing based on high-level design
- **Documentation**: High-level design (HLD), test plans, vulnerability assessment
- **Use case**: When developer cooperation is available; legacy systems with limited documentation
- **Addition over EAL1**: High-level design analysis, developer vulnerability analysis
- **Example**: Commercial off-the-shelf (COTS) products

---

### EAL3 – Methodically Tested and Checked

- **Assurance**: Medium assurance
- **Testing**: White-box testing; evaluator independently tests based on HLD + security functions
- **Documentation**: Detailed test plans, coverage analysis, configuration management
- **Use case**: Products designed with security from the start
- **Addition over EAL2**: Development environment controls, lifecycle support, more thorough testing
- **Example**: Smart cards, access control systems

---

### EAL4 – Methodically Designed, Tested and Reviewed

- **Assurance**: Medium-to-high assurance — **most common commercial EAL**
- **Testing**: Full independent testing, low-level design (LLD) analysis
- **Documentation**: Low-level design, subset of implementation (source code review)
- **Use case**: Commercial products where cost-effective maximum assurance is needed
- **Addition over EAL3**: Low-level design, implementation representation, greater vulnerability analysis
- **Example**: Operating systems (Windows, many Linux distros), firewalls, security appliances
- **Notable**: Maximum level practically achievable without major re-engineering

---

### EAL5 – Semi-formally Designed and Tested

- **Assurance**: High assurance
- **Testing**: Semi-formal design representation, thorough vulnerability analysis
- **Documentation**: Complete implementation (full source code), semi-formal architectural description
- **Use case**: High-security products where strict development methodology is followed
- **Addition over EAL4**: Semi-formal design, modular architecture, covert channel analysis
- **Example**: Military systems, high-security databases, critical infrastructure

---

### EAL6 – Semi-formally Verified Design and Tested

- **Assurance**: Very high assurance
- **Testing**: Systematic vulnerability analysis, penetration testing against high attack potential
- **Documentation**: Semi-formal verification of design, structured architectural representation
- **Use case**: High-risk environments requiring significant protection against sophisticated attacks
- **Addition over EAL5**: Semi-formal correspondence proofs, structured TOE development
- **Example**: Security kernels, cryptographic modules for classified environments

---

### EAL7 – Formally Verified Design and Tested

- **Assurance**: Highest level; extremely rigorous
- **Testing**: Formal mathematical proof of security properties, comprehensive testing
- **Documentation**: Formal model of security policy, formal correspondence proofs
- **Use case**: Extremely high-risk environments; practically used only for most critical security systems
- **Addition over EAL6**: Formal verification using mathematical proofs, formal correspondence at all levels
- **Example**: Cryptographic processors for top-secret systems, security kernels of highest-assurance OS
- **Limitation**: Extremely expensive and time-consuming; rarely used commercially

---

### EAL Summary Table

| EAL  | Name                   | Key Addition             | Typical Use                |
| ---- | ---------------------- | ------------------------ | -------------------------- |
| EAL1 | Functionally Tested    | Independent testing      | Low-risk consumer products |
| EAL2 | Structurally Tested    | HLD + developer testing  | Legacy/COTS products       |
| EAL3 | Methodically Tested    | CM, full testing         | Security-aware products    |
| EAL4 | Methodically Designed  | LLD + source subset      | **Most common commercial** |
| EAL5 | Semi-formally Designed | Full source, semi-formal | Military, high-security    |
| EAL6 | Semi-formally Verified | Semi-formal proofs       | Critical infrastructure    |
| EAL7 | Formally Verified      | Mathematical proofs      | Top-secret, ultra-critical |

---

## 14. Evaluation Methodology

### Common Criteria (CC)

**Common Criteria (ISO/IEC 15408)** is the international standard for IT security evaluation:

**Three-part structure**:

1. **Part 1 – Introduction and General Model**: Concepts, evaluation context, Protection Profiles
2. **Part 2 – Security Functional Requirements (SFR)**: Catalogue of security functions (access control, cryptography, audit, etc.)
3. **Part 3 – Security Assurance Requirements (SAR)**: Defines EAL levels and assurance components

**Key CC concepts**:

- **Target of Evaluation (TOE)**: Product or system being evaluated
- **Security Target (ST)**: Developer's document specifying TOE security claims
- **Protection Profile (PP)**: Implementation-independent set of security requirements for a class of products
- **TOE Security Functions (TSF)**: The security-enforcing functions of the product
- **TOE Security Policy (TSP)**: Rules governing security-relevant behavior

**CC evaluation process**:

1. Developer creates Security Target
2. Evaluation Facility (ITSEF) evaluates product
3. National Certification Body oversees and certifies
4. Result published on Common Criteria Portal

**Common Criteria Recognition Arrangement (CCRA)**:

- 31 member nations mutually recognize CC certificates
- Includes USA, UK, Germany, Japan, Australia, India
- Certificates valid across all member nations (up to EAL4)

---

### Assurance Requirements

**Security Assurance Requirements (SARs)** define what evidence and activities are needed:

**Assurance Classes** (from CC Part 3):

| Class Code | Assurance Class               | What It Covers                  |
| ---------- | ----------------------------- | ------------------------------- |
| **APE**    | Protection Profile Evaluation | Validity of PP                  |
| **ASE**    | Security Target Evaluation    | Validity of ST                  |
| **ADV**    | Development                   | Design documentation quality    |
| **AGD**    | Guidance Documents            | User/admin documentation        |
| **ALC**    | Life Cycle Support            | CM, delivery, tools             |
| **ATE**    | Tests                         | Developer and evaluator testing |
| **AVA**    | Vulnerability Assessment      | Resistance to attack            |

**Assurance components**: Each class contains **families**, each family contains **components** (specific requirements). Higher EALs demand more components per class.

---

### Evaluation Techniques

**Evaluation techniques** used by evaluators:

1. **Examination**: Review documentation for correctness and completeness
   - Document inspection
   - Consistency checks across different levels of design
   - Comparison with evaluation criteria

2. **Testing**:
   - **Functional testing**: Verify security functions work as claimed
   - **Independent testing**: Evaluator creates and runs own tests
   - **Penetration testing**: Attack-based testing to find exploitable flaws

3. **Sampling**: At higher EALs, exhaustive testing is replaced with evidence-based sampling

4. **Vulnerability analysis**:
   - **Public vulnerability search**: Check CVE databases for known issues
   - **Developer vulnerability analysis review**: Assess developer's own analysis
   - **Penetration testing depth**: Based on attack potential at target EAL

5. **Formal methods** (EAL5–7):
   - Mathematical proofs of security properties
   - Model checking
   - Theorem proving

---

## 15. NIST Framework

### NIST Overview

The **National Institute of Standards and Technology (NIST)** is a US federal agency that develops technology standards and guidelines:

- Founded in 1901 as part of the US Department of Commerce
- Publishes **Special Publications (SP)** series for cybersecurity guidance
- Key publications:
  - **NIST SP 800-53**: Security and Privacy Controls for Federal Systems
  - **NIST SP 800-37**: Risk Management Framework (RMF)
  - **NIST SP 800-171**: Protecting Controlled Unclassified Information
  - **NIST CSF**: Voluntary cybersecurity framework (2014, updated 2024 as CSF 2.0)
- NIST standards are widely adopted globally, not just in the US

---

### NIST Cybersecurity Framework (CSF)

The **NIST CSF** was created by Executive Order 13636 (2013) and published in 2014:

- **Purpose**: Voluntary framework to help organizations manage cybersecurity risk
- **Audience**: Private sector, critical infrastructure, government agencies
- **CSF 2.0** released in 2024 — added a 6th function: **Govern**
- **Structure**: Three components — Core, Profiles, and Implementation Tiers
- **Approach**: Risk-based, outcome-focused, flexible across industries
- **Key benefit**: Common language for cybersecurity across different sectors

---

### Core Functions

The NIST CSF Core is organized into **5 functions** (6 in CSF 2.0 with "Govern") that represent the lifecycle of cybersecurity risk management:

---

#### Identify (ID)

**Purpose**: Develop organizational understanding to manage cybersecurity risk to systems, assets, data, and capabilities.

**Key activities**:

- **Asset Management**: Inventory all hardware, software, data, and personnel
- **Business Environment**: Understand the organization's role in critical infrastructure
- **Governance**: Establish policies, procedures, and roles for cybersecurity
- **Risk Assessment**: Identify, analyze, and prioritize risks
- **Risk Management Strategy**: Define risk tolerance and response priorities
- **Supply Chain Risk Management**: Identify risks from third-party suppliers

**Why it matters**: You cannot protect what you don't know you have. This is the foundation of all other functions.

**Example controls**:

- Maintain hardware and software asset inventory
- Document data flows and information classification
- Conduct regular risk assessments

---

#### Protect (PR)

**Purpose**: Develop and implement appropriate safeguards to ensure delivery of critical infrastructure services.

**Key categories**:

- **Access Control (PR.AC)**: Manage access to assets and systems (MFA, least privilege)
- **Awareness and Training (PR.AT)**: Security awareness for all staff; specialized training for security roles
- **Data Security (PR.DS)**: Protect data at rest and in transit (encryption, data loss prevention)
- **Information Protection Processes (PR.IP)**: Security policies, configuration management, backup
- **Maintenance (PR.MA)**: Perform and log all maintenance activities
- **Protective Technology (PR.PT)**: Technical security solutions (firewalls, IDS/IPS, SIEM)

**Example controls**:

- Implement multi-factor authentication
- Encrypt sensitive data using AES-256
- Regular patching and vulnerability remediation
- Security awareness training for all employees

---

#### Detect (DE)

**Purpose**: Develop and implement appropriate activities to identify the occurrence of a cybersecurity event.

**Key categories**:

- **Anomalies and Events (DE.AE)**: Detect anomalous activity and understand potential impact
- **Security Continuous Monitoring (DE.CM)**: Monitor information systems and assets for attacks
- **Detection Processes (DE.DP)**: Maintain and test detection processes for awareness

**Key tools**:

- SIEM (Security Information and Event Management)
- IDS/IPS (Intrusion Detection/Prevention Systems)
- Log analysis and correlation
- Network traffic analysis
- File integrity monitoring

**Example controls**:

- Deploy SIEM with 24/7 monitoring
- Establish baseline network behavior; alert on deviations
- Monitor user accounts for suspicious activity

---

#### Respond (RS)

**Purpose**: Develop and implement appropriate activities to take action regarding a detected cybersecurity incident.

**Key categories**:

- **Response Planning (RS.RP)**: Execute and maintain incident response plan
- **Communications (RS.CO)**: Coordinate with internal/external stakeholders
- **Analysis (RS.AN)**: Analyze incidents to understand impact and attack vectors
- **Mitigation (RS.MI)**: Contain incidents and mitigate effects
- **Improvements (RS.IM)**: Incorporate lessons learned into response plans

**Incident response lifecycle**:

1. Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned

**Example controls**:

- Documented and tested incident response plan
- Define communication procedures for breaches (including regulatory notification)
- Conduct post-incident reviews (after-action reports)

---

#### Recover (RC)

**Purpose**: Develop and implement appropriate activities to maintain resilience and restore any capabilities or services impaired by a cybersecurity incident.

**Key categories**:

- **Recovery Planning (RC.RP)**: Execute and maintain recovery plans
- **Improvements (RC.IM)**: Incorporate lessons into future recovery planning
- **Communications (RC.CO)**: Coordinate restoration activities; manage reputation

**Key concepts**:

- **RTO (Recovery Time Objective)**: Maximum acceptable downtime
- **RPO (Recovery Point Objective)**: Maximum acceptable data loss
- **Business Continuity Planning (BCP)**: Maintaining operations during disruption
- **Disaster Recovery (DR)**: Restoring IT systems after an incident

**Example controls**:

- Tested backup and restore procedures
- Documented disaster recovery playbooks
- Clear communication plan for customers and media during recovery

---

### Framework Profiles

A **Framework Profile** represents the alignment of the CSF Core with the organization's requirements, risk tolerance, and resources:

- **Current Profile**: Describes the cybersecurity outcomes currently being achieved
- **Target Profile**: Describes the desired cybersecurity outcomes
- **Gap Analysis**: Comparing current to target profile identifies priorities and improvement areas

**How profiles are used**:

1. Identify your current security state (Current Profile)
2. Define your desired security state (Target Profile)
3. Gap between the two = **improvement roadmap**
4. Prioritize gaps based on risk and business impact
5. Allocate budget and resources to close highest-priority gaps

**Benefits of profiles**:

- Customizable to any industry or organization size
- Enables communication between technical teams and management
- Supports regulatory compliance mapping (HIPAA, PCI DSS, GDPR)

---

### Implementation Tiers

**Implementation Tiers** describe the degree of sophistication in an organization's cybersecurity risk management practices:

| Tier       | Name              | Description                                                                                |
| ---------- | ----------------- | ------------------------------------------------------------------------------------------ |
| **Tier 1** | **Partial**       | Cybersecurity risk management is ad hoc; limited awareness of risk; no formal policies     |
| **Tier 2** | **Risk Informed** | Risk practices approved by management but not organization-wide; some awareness of threats |
| **Tier 3** | **Repeatable**    | Formal, documented policies; regularly updated; organization-wide risk management          |
| **Tier 4** | **Adaptive**      | Proactive; continuously improving; threat intelligence integrated; culture of security     |

**Important note**: Tiers are **not maturity levels** — organizations don't need to reach Tier 4. The goal is to reach the tier that meets business needs and risk tolerance.

**Tier progression example**:

- A startup might operate at Tier 1–2 initially
- A bank should operate at Tier 3–4
- Government agencies with critical infrastructure aim for Tier 4

---

### NIST CSF Summary

```
┌─────────────────────────────────────────────────────────┐
│                    NIST CSF CORE                        │
├──────────┬──────────┬──────────┬──────────┬─────────────┤
│ IDENTIFY │ PROTECT  │  DETECT  │ RESPOND  │   RECOVER   │
│  (ID)    │  (PR)    │  (DE)    │  (RS)    │    (RC)     │
│          │          │          │          │             │
│ Know     │ Safeguard│ Find     │ Act on   │ Restore     │
│ assets & │ critical │ security │ detected │ capabilities│
│ risks    │ services │ events   │ events   │ & services  │
└──────────┴──────────┴──────────┴──────────┴─────────────┘
         ↑                                         ↑
    FRAMEWORK PROFILES: Current → Gap → Target Profile
    IMPLEMENTATION TIERS: Tier 1 (Ad hoc) → Tier 4 (Adaptive)
```

---

## Master Quick Revision

| Topic                | Key Point                                       |
| -------------------- | ----------------------------------------------- |
| Evaluation Process   | Scope → Evidence → Analysis → Report            |
| Evaluation Phases    | Prepare → Assess → Verify → Report              |
| EAL1                 | Functionally tested; lowest assurance           |
| EAL4                 | Most common commercial; LLD + source subset     |
| EAL7                 | Formal mathematical proofs; highest assurance   |
| Common Criteria      | ISO/IEC 15408; TOE, ST, PP concepts             |
| SARs                 | ADV, AGD, ALC, ATE, AVA assurance classes       |
| NIST CSF             | Identify → Protect → Detect → Respond → Recover |
| CSF Profiles         | Current Profile + Target Profile = Gap Analysis |
| Implementation Tiers | Tier 1 (Partial) to Tier 4 (Adaptive)           |

# Comprehensive Notes: GDPR, ISO 27000, SOX/SOC, COBIT & HIPAA

---

## 16. GDPR (General Data Protection Regulation)

### GDPR Overview

The **General Data Protection Regulation (GDPR)** is a landmark EU privacy law that came into effect on **May 25, 2018**, replacing the 1995 Data Protection Directive. It governs how organizations collect, process, store, and share personal data of EU/EEA residents — and crucially, it applies to **any organization worldwide** that processes data of EU residents, regardless of where the organization is based. GDPR is enforced by national **Data Protection Authorities (DPAs)** in each EU member state. [gdpr](https://www.gdpr.org/regulation/remedies-liability-and-penalties.html)

**Key facts**:

- Enacted by EU Parliament in 2016; enforceable from May 2018
- Applies to all 27 EU member states + EEA countries
- Applies extraterritorially — affects companies worldwide
- GDPR fines totaled **€1.2 billion in 2024** alone [infosecurity-magazine](https://www.infosecurity-magazine.com/news/gdpr-fines-total-2024/)
- Top 2024 fine: **€310 million against LinkedIn** for improper data use in advertising [infosecurity-magazine](https://www.infosecurity-magazine.com/news/gdpr-fines-total-2024/)

---

### Personal Data

**Personal data** = any information relating to an identified or identifiable natural person (data subject):

- **Direct identifiers**: Name, national ID number, email address, phone number
- **Indirect identifiers**: Location data, IP address, cookie identifiers
- **Combined data**: Data that, when combined, identifies an individual
- **Online identifiers**: Device IDs, browsing history, social media handles

**Important**: The data doesn't have to identify someone alone — it just needs to make them **identifiable**.

---

### Sensitive Personal Data

**Special category data** (Article 9) requires extra protection and explicit consent:

1. Racial or ethnic origin
2. Political opinions
3. Religious or philosophical beliefs
4. Trade union membership
5. Genetic data
6. Biometric data (when used for identification)
7. Health data
8. Sex life or sexual orientation

**Processing of sensitive data is prohibited** unless specific legal grounds apply (explicit consent, employment law, vital interests, etc.). [gdpr](https://www.gdpr.org/regulation/remedies-liability-and-penalties.html)

---

### Data Subject Rights

GDPR grants individuals **8 fundamental rights** over their personal data: [gdpr](https://www.gdpr.org/regulation/remedies-liability-and-penalties.html)

| Right                                       | Description                                  |
| ------------------------------------------- | -------------------------------------------- |
| **Right to Information**                    | Know how and why data is collected           |
| **Right to Access**                         | Obtain a copy of your personal data          |
| **Right to Rectification**                  | Correct inaccurate or incomplete data        |
| **Right to Erasure**                        | Request deletion ("Right to be Forgotten")   |
| **Right to Restrict Processing**            | Limit how your data is used                  |
| **Right to Data Portability**               | Receive data in machine-readable format      |
| **Right to Object**                         | Object to processing for marketing/profiling |
| **Right against Automated Decision-Making** | Not be subject to fully automated decisions  |

---

### Important Rights (Detailed)

#### Right to Access (Article 15)

- Individuals can request a **copy of all personal data** held about them
- Organization must respond within **30 days** (extendable to 3 months for complex requests)
- Response must include: what data is held, why it's processed, who it's shared with, retention period
- First copy must be provided **free of charge**

#### Right to Rectification (Article 16)

- Individuals can request **correction of inaccurate data** without undue delay
- Includes right to have **incomplete data completed**
- Organization must notify all third parties to whom data was disclosed of the correction
- Must respond within **30 days**

#### Right to Erasure — Right to be Forgotten (Article 17)

- Individuals can request **deletion of their personal data** when:
  - Data is no longer necessary for its original purpose
  - Consent has been withdrawn
  - Individual objects to processing and no overriding legitimate interest exists
  - Data was unlawfully processed
  - Data must be erased to comply with legal obligation
- **Exceptions**: Freedom of expression, legal claims, public interest, archiving/research purposes
- Must also notify third parties who received the data

#### Right to Data Portability (Article 20)

- Individuals can **receive their data in a structured, commonly used, machine-readable format** (e.g., CSV, JSON)
- Can request data be **transmitted directly to another controller** (data porting)
- Applies only to data processed by **consent or contract** and processed **automatically**
- Organizations must fulfill within **30 days**

---

### Consent

**Consent** under GDPR must be: [gdpr](https://www.gdpr.org/regulation/remedies-liability-and-penalties.html)

- **Freely given**: No coercion or bundled consent
- **Specific**: For a defined, clear purpose
- **Informed**: Individual must know who is collecting data and why
- **Unambiguous**: Clear affirmative action (pre-ticked boxes = NOT valid)
- **Withdrawable**: Must be as easy to withdraw as to give

**Special rule for children**: Parental consent required for those under 16 (or lower age set by member states, minimum 13).

---

### Data Controller

A **Data Controller** is the entity that:

- Determines the **purposes and means** of processing personal data
- Bears primary responsibility for GDPR compliance
- Must implement appropriate technical and organizational measures
- Must appoint DPO if required
- Must conduct Data Protection Impact Assessments (DPIA)
- Examples: A hospital, bank, e-commerce company collecting customer data

---

### Data Processor

A **Data Processor** is the entity that:

- Processes personal data **on behalf of the controller**
- Acts only on controller's instructions
- Must have a **Data Processing Agreement (DPA)** with the controller
- Has direct GDPR obligations (security, breach notification within 72 hours to controller)
- Examples: Cloud providers (AWS, Azure), payroll processors, email marketing services

---

### Data Protection Officer (DPO)

A **DPO** is **mandatory** when: [gdpr](https://www.gdpr.org/regulation/remedies-liability-and-penalties.html)

- The organization is a **public authority**
- Core activities involve **large-scale systematic monitoring** of individuals
- Core activities involve **large-scale processing of sensitive data**

**DPO responsibilities**:

1. Advising on GDPR compliance
2. Monitoring data protection activities
3. Conducting DPIAs
4. Acting as contact point for Data Protection Authorities
5. Training staff on data protection

**Key rule**: DPO must be **independent** and cannot be dismissed or penalized for performing duties.

---

### GDPR Compliance Steps

1. **Data Audit**: Inventory all personal data — what is collected, where it's stored, how it's processed
2. **Legal Basis**: Identify lawful basis for each processing activity (consent, contract, legal obligation, etc.)
3. **Privacy Policy**: Update to be transparent, plain-language, and complete
4. **Data Subject Rights**: Implement processes to handle access, erasure, portability requests within 30 days
5. **Consent Mechanisms**: Implement valid consent collection (no pre-ticked boxes)
6. **DPA Agreements**: Sign Data Processing Agreements with all processors
7. **Appoint DPO**: If required under GDPR criteria
8. **Breach Response Plan**: Establish a 72-hour breach notification process to supervisory authority
9. **DPIA**: Conduct Data Protection Impact Assessments for high-risk processing
10. **Staff Training**: Regular GDPR awareness training for all employees

---

### GDPR Penalties

**Two-tier fine structure**: [gdpr-info](https://gdpr-info.eu/issues/fines-penalties/)

| Tier                        | Violation Type                                                                       | Maximum Fine                                                          |
| --------------------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| **Lower Tier** (Art. 83(4)) | Technical violations: DPO issues, certification bodies, monitoring bodies            | €10 million **or** 2% of global annual turnover (whichever is higher) |
| **Upper Tier** (Art. 83(5)) | Core violations: data subject rights, consent, international transfers, lawful basis | **€20 million or 4% of global annual turnover** (whichever is higher) |

**Real-world examples**: [infosecurity-magazine](https://www.infosecurity-magazine.com/news/gdpr-fines-total-2024/)

- **LinkedIn (2024)**: €310 million — improper use of data in advertising
- **Uber (2024)**: €290 million — storing driver data in US without safeguards
- **Meta (2024)**: €251 million — 2018 Facebook data breach
- **Meta (2023)**: €1.2 billion — largest ever fine, EU-US data transfers

---

## 17. ISO 27000 Series

### ISO 27000 Family

The **ISO/IEC 27000 family** is a series of international standards for **information security management**: [iso](https://www.iso.org/standard/75652.html)

| Standard      | Title                                | Purpose                         |
| ------------- | ------------------------------------ | ------------------------------- |
| **ISO 27000** | Overview and vocabulary              | Definitions and glossary        |
| **ISO 27001** | ISMS Requirements                    | Certifiable management standard |
| **ISO 27002** | Code of Practice                     | Security controls guidance      |
| **ISO 27003** | Implementation Guidance              | How to implement ISO 27001      |
| **ISO 27004** | Monitoring and Measurement           | ISMS performance metrics        |
| **ISO 27005** | Information Security Risk Management | Risk assessment methodology     |
| **ISO 27017** | Cloud Security Controls              | Cloud-specific controls         |
| **ISO 27018** | Cloud Privacy                        | PII protection in public cloud  |

---

### ISO 27001

**ISO 27001** is the **flagship standard** — the only one in the family you can get certified against: [iso](https://www.iso.org/standard/75652.html)

- Full name: ISO/IEC 27001:2022 (latest version)
- Specifies **requirements** for establishing, implementing, maintaining, and continuously improving an ISMS
- Based on the **PDCA cycle** (Plan-Do-Check-Act)
- Applicable to **any organization**, regardless of size or industry
- Requires **internal audits** and **management review**
- Certification by accredited third-party certification bodies
- Requires **Statement of Applicability (SoA)**: document declaring which controls apply
- **ISO 27001:2022** has **93 controls** in **4 domains** (Annex A) [certpro](https://certpro.com/iso-270012022-domains-and-controls/)

**ISO 27001:2022 Annex A — 4 Domains**:

1. **Organizational controls** (37 controls): Policies, risk management, supplier security
2. **People controls** (8 controls): Screening, training, disciplinary process
3. **Physical controls** (14 controls): Physical access, equipment security, clear desk
4. **Technological controls** (34 controls): Authentication, encryption, logging, monitoring

---

### ISO 27002

**ISO 27002** provides **detailed guidance and best practices** for implementing the controls listed in ISO 27001 Annex A: [iso](https://www.iso.org/standard/75652.html)

- Not certifiable — it is a **supplementary reference**
- ISO 27002:2022 contains the same 93 controls as ISO 27001:2022 Annex A but with **full implementation guidance**
- Each control has: Control statement, Purpose, Guidance, and Other information
- Used by security professionals to understand **how** to implement each control

---

### ISO 27005

**ISO 27005** focuses specifically on **information security risk management**: [cdn2.hubspot](https://cdn2.hubspot.net/hubfs/308986/Documents/PwC_AT&C%20Information%20Security%20webinar%20presentation%206%20June%202017.pdf)

- Provides guidelines for information security risk assessment and treatment
- Supports ISO 27001's risk management requirements
- Follows a continuous **risk management process**:
  1. Context establishment
  2. Risk identification
  3. Risk analysis
  4. Risk evaluation
  5. Risk treatment
  6. Risk acceptance
  7. Risk monitoring and review

---

### ISMS (Information Security Management System)

An **ISMS** is a systematic approach to managing information security covering people, processes, and IT systems: [cdn2.hubspot](https://cdn2.hubspot.net/hubfs/308986/Documents/PwC_AT&C%20Information%20Security%20webinar%20presentation%206%20June%202017.pdf)

- **Not just technology**: Includes policies, procedures, roles, training, and governance
- **Risk-driven**: Designed around the organization's specific risk profile
- **Scope**: Can cover entire organization or specific business units
- **Continuous**: Requires ongoing monitoring, measurement, and improvement

**ISMS components**:

1. Information security policy
2. Risk assessment methodology
3. Statement of Applicability (SoA)
4. Risk treatment plan
5. Security objectives and metrics
6. Training and awareness program
7. Incident management process
8. Internal audit program
9. Management review process

---

### PDCA Cycle

The **Plan-Do-Check-Act (PDCA) cycle** drives continuous improvement in the ISMS: [cdn2.hubspot](https://cdn2.hubspot.net/hubfs/308986/Documents/PwC_AT&C%20Information%20Security%20webinar%20presentation%206%20June%202017.pdf)

```
┌──────────────────────────────────────────────────────┐
│                     PDCA CYCLE                       │
├─────────────┬────────────┬───────────┬───────────────┤
│    PLAN     │    DO      │   CHECK   │     ACT       │
├─────────────┼────────────┼───────────┼───────────────┤
│ Establish   │ Implement  │ Monitor   │ Maintain and  │
│ ISMS policy │ and operate│ and review│ improve ISMS  │
│ objectives  │ the ISMS   │ the ISMS  │               │
│ Risk assess.│ Controls   │ Audits    │ Corrective    │
│ Risk treat. │ Training   │ Metrics   │ actions       │
└─────────────┴────────────┴───────────┴───────────────┘
```

---

### ISO 27001:2005 Domains (Original 11 Domains)

The **older ISO 27001:2005** version organized controls into **11 domains** (114 controls) — still widely referenced in exams: [cdn2.hubspot](https://cdn2.hubspot.net/hubfs/308986/Documents/PwC_AT&C%20Information%20Security%20webinar%20presentation%206%20June%202017.pdf)

| #   | Domain                                       | Focus                                                      |
| --- | -------------------------------------------- | ---------------------------------------------------------- |
| 1   | **Security Policy**                          | Management direction and support for security              |
| 2   | **Organization of Information Security**     | Internal organization, governance, third parties           |
| 3   | **Asset Management**                         | Inventory, ownership, classification of assets             |
| 4   | **Human Resource Security**                  | Pre-employment, during, and post-employment security       |
| 5   | **Physical and Environmental Security**      | Physical access controls, equipment protection             |
| 6   | **Communications & Operations Management**   | Operating procedures, network security, malware protection |
| 7   | **Access Control**                           | User access management, passwords, remote access           |
| 8   | **System Development & Maintenance**         | Security in SDLC, cryptography, patch management           |
| 9   | **Information Security Incident Management** | Incident reporting, response, lessons learned              |
| 10  | **Business Continuity Management**           | BCM planning, disaster recovery                            |
| 11  | **Compliance**                               | Legal, regulatory, and policy compliance                   |

---

## 18. SOX and SOC Reports

### SOX (Sarbanes-Oxley Act)

#### Purpose

The **Sarbanes-Oxley Act (SOX)** is a **US federal law** enacted in 2002 in response to major financial scandals (Enron, WorldCom): [ibm](https://www.ibm.com/think/topics/sox-compliance)

- Protects investors from **fraudulent financial reporting** by corporations
- Applies to all **US publicly traded companies** and their subsidiaries
- Enforced by the **Securities and Exchange Commission (SEC)**
- Created the **Public Company Accounting Oversight Board (PCAOB)**
- Goal: Ensure accuracy, integrity, and transparency of financial statements

---

#### Financial Controls

SOX requires companies to: [ibm](https://www.ibm.com/think/topics/sox-compliance)

- Maintain **accurate financial records** with an adequate internal control structure
- **CEO and CFO** must personally certify accuracy of financial reports (criminal liability if false)
- Establish **Audit Committees** composed of independent board members
- Prohibit **loans to executives**
- Protect **whistleblowers** who report financial fraud
- **Document retention**: 7-year retention of financial records and audit workpapers

**Key SOX sections**:

- **Section 302**: CEO/CFO certification of financial statements
- **Section 404**: Management assessment of internal controls (most important for IT)
- **Section 409**: Real-time disclosure of material changes
- **Section 802**: Criminal penalties for altering/destroying records

---

#### IT Controls

**SOX Section 404** requires assessment of **IT General Controls (ITGC)** that affect financial reporting: [ibm](https://www.ibm.com/think/topics/sox-compliance)

| ITGC Category           | Examples                                                       |
| ----------------------- | -------------------------------------------------------------- |
| **Access Controls**     | User access to financial systems, privileged access management |
| **Change Management**   | Controls over changes to financial applications                |
| **Computer Operations** | Backup, job scheduling, incident management                    |
| **System Development**  | SDLC controls, testing procedures                              |
| **Data Integrity**      | Ensuring financial data is accurate and complete               |

**IT Application Controls (ITAC)**:

- Input controls (validation of financial data entry)
- Processing controls (calculations are correct)
- Output controls (reports are accurate)

---

#### SOX Compliance

**SOX compliance process**:

1. Identify financial processes and IT systems that support them
2. Document and test internal controls (manual and automated)
3. Identify and remediate control deficiencies
4. Management assessment of control effectiveness
5. **External auditor** attests to management's assessment
6. Submit reports to SEC annually

**Control deficiency classifications**:

- **Control Deficiency**: Minor weakness
- **Significant Deficiency**: Noteworthy weakness requiring attention
- **Material Weakness**: Severe weakness — could result in material misstatement

---

### SOC Reports

**SOC (System and Organization Controls)** reports are attestation reports produced by auditors evaluating service organization controls: [logicgate](https://www.logicgate.com/blog/a-comparison-of-soc-and-sox-compliance/)

#### SOC 1

- **Focus**: Internal controls over **Financial Reporting (ICFR)**
- **Standard**: SSAE 18 (Statement on Standards for Attestation Engagements)
- **Audience**: User entities and their financial auditors — **restricted use**
- **Use case**: Payroll processors, data centers processing financial transactions
- **Types**:
  - **Type I**: Controls are suitably designed at a point in time
  - **Type II**: Controls operate effectively over a period (6–12 months)

#### SOC 2

- **Focus**: Security, availability, processing integrity, confidentiality, privacy controls [kirkpatrickprice](https://kirkpatrickprice.com/video/soc-1-vs-soc-2-vs-soc-3/)
- **Standard**: AICPA Trust Services Criteria
- **Audience**: Restricted to customers and prospects — **not public**
- **Use case**: SaaS companies, cloud providers, IT managed services
- **Most important for cybersecurity compliance**
- Types: Type I (design) and Type II (operating effectiveness over time)

#### SOC 3

- **Focus**: Same as SOC 2 (Trust Services Criteria) but simplified
- **Audience**: **General public** — can be freely distributed and published on website [kirkpatrickprice](https://kirkpatrickprice.com/video/soc-1-vs-soc-2-vs-soc-3/)
- **Use case**: Marketing trust to general customers; does not contain detailed control descriptions
- **Limitation**: Does not provide detailed evidence of controls like SOC 2

---

### SOC 2 Trust Principles

The **5 Trust Services Criteria** for SOC 2: [logicgate](https://www.logicgate.com/blog/a-comparison-of-soc-and-sox-compliance/)

| Principle                | Description                                                               |
| ------------------------ | ------------------------------------------------------------------------- |
| **Security**             | System is protected against unauthorized access (mandatory for all SOC 2) |
| **Availability**         | System is available for operation as committed                            |
| **Processing Integrity** | System processing is complete, valid, accurate, and timely                |
| **Confidentiality**      | Information designated as confidential is protected                       |
| **Privacy**              | Personal information is collected, used, and retained per privacy notice  |

**Note**: **Security** is the only **mandatory** criterion — organizations choose which additional criteria apply to their services.

---

## 19. COBIT Framework

### COBIT Overview

**COBIT (Control Objectives for Information and Related Technologies)** is an IT governance and management framework developed by **ISACA**: [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)

- Current version: **COBIT 2019** (updated from COBIT 5)
- Purpose: Help organizations govern and manage IT to meet business objectives
- Provides a **comprehensive set of governance and management objectives** for IT
- Applicable to organizations of all sizes and industries
- Supports compliance with SOX, GDPR, ISO 27001, and other regulations
- **37 total processes** (COBIT 5) across 5 domains [scribd](https://www.scribd.com/document/376424352/The-COBIT-5-Processes-Are-Split-Into-Governance-and-Management)

---

### Governance vs Management

**Critical distinction in COBIT**: [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)

| Aspect             | Governance (EDM)                          | Management (APO, BAI, DSS, MEA)         |
| ------------------ | ----------------------------------------- | --------------------------------------- |
| **Question**       | Are we doing the right things?            | Are we doing them well?                 |
| **Responsibility** | Board of Directors / Executive Leadership | Management / IT Department              |
| **Focus**          | Direction, evaluation, oversight          | Planning, building, running, monitoring |
| **COBIT Domain**   | EDM only                                  | APO + BAI + DSS + MEA                   |
| **Activities**     | Set policies, evaluate performance        | Execute plans, deliver services         |

---

### COBIT Domains

#### EDM — Evaluate, Direct and Monitor

- **Strategic layer** of COBIT; the governance domain [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)
- Ensures IT aligns with **overall business objectives**
- Sets direction for IT investments, resources, and risks
- **5 processes** in COBIT 5:
  - EDM01: Ensure Governance Framework Setting and Maintenance
  - EDM02: Ensure Benefits Delivery
  - EDM03: Ensure Risk Optimization
  - EDM04: Ensure Resource Optimization
  - EDM05: Ensure Stakeholder Transparency

#### APO — Align, Plan and Organize

- Translates **strategic direction into operational plans** [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)
- Covers IT planning, organizational structure, resource management
- **13 processes** in COBIT 5 including:
  - APO01: Manage the IT Management Framework
  - APO02: Manage Strategy
  - APO07: Manage Human Resources
  - APO12: Manage Risk
  - APO13: Manage Security

#### BAI — Build, Acquire and Implement

- Covers **acquisition and implementation** of IT solutions [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)
- Ensures IT solutions meet business needs and deliver expected benefits
- **10 processes** in COBIT 5 including:
  - BAI02: Manage Requirements Definition
  - BAI06: Manage Changes
  - BAI09: Manage Assets
  - BAI10: Manage Configuration

#### DSS — Deliver, Service and Support

- Focuses on **delivery and support of IT services** to end users [scribd](https://www.scribd.com/document/376424352/The-COBIT-5-Processes-Are-Split-Into-Governance-and-Management)
- Covers execution of IT systems and support processes
- **6 processes** in COBIT 5 including:
  - DSS01: Manage Operations
  - DSS02: Manage Service Requests and Incidents
  - DSS03: Manage Problems
  - DSS04: Manage Continuity
  - DSS05: Manage Security Services
  - DSS06: Manage Business Process Controls

#### MEA — Monitor, Evaluate and Assess

- Measures and monitors **IT performance against objectives** [scribd](https://www.scribd.com/document/376424352/The-COBIT-5-Processes-Are-Split-Into-Governance-and-Management)
- Ensures IT delivers value and complies with regulations
- **3 processes** in COBIT 5:
  - MEA01: Monitor, Evaluate and Assess Performance and Conformance
  - MEA02: Monitor, Evaluate and Assess the System of Internal Control
  - MEA03: Monitor, Evaluate and Assess Compliance with External Requirements

---

### COBIT Components

**COBIT 2019 design factors** include: [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)

1. Enterprise strategy
2. Enterprise goals
3. Risk profile
4. IT-related issues
5. Threat landscape
6. Compliance requirements
7. Role of IT
8. IT sourcing model

**COBIT Components**:

- **Processes**: Governance and management objectives
- **Organizational structures**: Decision-making bodies
- **Policies and procedures**: Written guidelines
- **Information flows**: Data supporting governance
- **Culture, ethics, behavior**: People factors
- **Services, infrastructure, applications**: IT enablers
- **People, skills, competencies**: Human resources

---

### COBIT Principles

**COBIT 2019 Core Principles**: [multimatics.co](https://multimatics.co.id/insight/aug/it-governance-professionals-must-know-the-cobit-2019-domains)

1. **Provide stakeholder value**: Governance exists to create value for stakeholders
2. **Holistic approach**: IT governance requires multiple components working together
3. **Dynamic governance system**: Governance must adapt to changes
4. **Separate governance from management**: Clear distinction between the two
5. **Tailored to enterprise needs**: Framework must be customized
6. **End-to-end governance system**: Covers entire enterprise, not just IT

---

### COBIT vs ITIL

| Aspect                | COBIT                                          | ITIL                                             |
| --------------------- | ---------------------------------------------- | ------------------------------------------------ |
| **Primary focus**     | IT Governance and Management                   | IT Service Management (ITSM)                     |
| **Question answered** | Are we doing the right things correctly?       | How do we deliver and manage IT services?        |
| **Scope**             | Enterprise-wide governance                     | Service delivery lifecycle                       |
| **Developed by**      | ISACA                                          | Axelos (UK Cabinet Office)                       |
| **Strength**          | Governance, compliance, control objectives     | Service operations, incident/change management   |
| **Relationship**      | Governance framework                           | Operational execution framework                  |
| **Use together**      | COBIT defines what governance goals are needed | ITIL provides how to implement service processes |
| **Audience**          | CIOs, auditors, compliance teams               | IT operations and service desk teams             |

**Key insight**: COBIT and ITIL **complement each other** — COBIT provides the governance what, ITIL provides the operational how. [scribd](https://www.scribd.com/document/376424352/The-COBIT-5-Processes-Are-Split-Into-Governance-and-Management)

---

## 20. HIPAA

### HIPAA Overview

The **Health Insurance Portability and Accountability Act (HIPAA)** is a **US federal law** enacted in **1996**: [ncbi.nlm.nih](https://www.ncbi.nlm.nih.gov/books/NBK500019/)

- Protects the **privacy and security of health information**
- Applies to **Covered Entities** (healthcare providers, health plans, clearinghouses) and **Business Associates**
- Enforced by the **Office for Civil Rights (OCR)** under the US Department of Health and Human Services (HHS)
- Applies to **electronic, paper, and oral** health information
- Violations can result in civil and criminal penalties

---

### Protected Health Information (PHI)

**PHI** is any individually identifiable health information that relates to: [ncbi.nlm.nih](https://www.ncbi.nlm.nih.gov/books/NBK500019/)

- An individual's **past, present, or future physical or mental health** condition
- **Provision of healthcare** to an individual
- **Past, present, or future payment** for the provision of healthcare

**18 PHI identifiers** (per HIPAA safe harbor method):

1. Name
2. Geographic data (smaller than state)
3. Dates (except year) related to an individual
4. Phone numbers
5. Fax numbers
6. Email addresses
7. Social Security numbers
8. Medical record numbers
9. Health plan beneficiary numbers
10. Account numbers
11. Certificate/license numbers
12. VINs / serial numbers
13. Device identifiers
14. Web URLs
15. IP addresses
16. Biometric identifiers (fingerprints, voiceprints)
17. Full-face photos
18. Any other unique identifying number or code

**ePHI** = Electronic PHI (stored or transmitted electronically) — governed specifically by the Security Rule.

---

### HIPAA Titles

| Title         | Name                                              | Purpose                                                            |
| ------------- | ------------------------------------------------- | ------------------------------------------------------------------ |
| **Title I**   | Health Insurance Reform                           | Protects health insurance coverage during job changes              |
| **Title II**  | Administrative Simplification                     | Establishes privacy/security standards (**most important for IT**) |
| **Title III** | Tax-Related Health Provisions                     | Medical savings accounts                                           |
| **Title IV**  | Application and Enforcement of Group Health Plans | Group health plan requirements                                     |
| **Title V**   | Revenue Offset Provisions                         | Company-owned life insurance                                       |

**Title II** contains the Privacy Rule, Security Rule, and Breach Notification Rule — the core of HIPAA compliance for healthcare IT. [ncbi.nlm.nih](https://www.ncbi.nlm.nih.gov/books/NBK500019/)

---

### Privacy Rule

The **HIPAA Privacy Rule** establishes national standards for protecting PHI: [ncbi.nlm.nih](https://www.ncbi.nlm.nih.gov/books/NBK500019/)

- Regulates **use and disclosure** of PHI by covered entities
- Gives patients **rights over their health information**
- Allows PHI use for treatment, payment, and healthcare operations **without consent**
- Requires **authorization** for other uses (marketing, research, etc.)
- Requires covered entities to:
  - Provide patients with a **Notice of Privacy Practices (NPP)**
  - Track disclosures of PHI
  - Document privacy policies and procedures
  - Appoint a **Privacy Officer**
  - Train workforce on privacy policies

**Permitted disclosures without authorization**:

- Treatment, payment, healthcare operations
- Public health activities
- Law enforcement (limited)
- Court orders / subpoenas
- National security

---

### Security Rule

The **HIPAA Security Rule** protects **electronic PHI (ePHI)** specifically: [cms](https://www.cms.gov/files/document/mln909001-hipaa-basics-providers-privacy-security-breach-notification-rules.pdf)

- Requires covered entities to ensure **confidentiality, integrity, and availability** of all ePHI
- Three types of safeguards required:

| Safeguard Type     | Examples                                                                      |
| ------------------ | ----------------------------------------------------------------------------- |
| **Administrative** | Risk analysis, workforce training, security policies, sanction policy         |
| **Physical**       | Facility access controls, workstation use policy, device disposal             |
| **Technical**      | Access controls, audit logs, encryption, automatic logoff, integrity controls |

**Required vs. Addressable**:

- **Required**: Must implement exactly as specified
- **Addressable**: Implement if reasonable and appropriate, or document why an alternative was chosen

---

### Breach Notification Rule

The **Breach Notification Rule** requires notification when unsecured PHI is compromised: [ama-assn](https://www.ama-assn.org/practice-management/hipaa/hipaa-breach-notification-rule)

**Notification requirements**:

1. **Individual notice**: Written notification within **60 days** of discovery
2. **HHS notification**: Within 60 days (if >500 individuals: immediate; <500: annual report)
3. **Media notice**: If breach affects **500+ residents** of a state — notify prominent media outlet

**Notice must include**: [niu](https://www.niu.edu/doit/about/policies/hipaa-breach-notification-rule.shtml)

- Description of the breach
- Types of PHI involved
- Steps individuals should take to protect themselves
- What the covered entity is doing to investigate and mitigate
- Contact information

**Breach exclusions** (notification NOT required): [niu](https://www.niu.edu/doit/about/policies/hipaa-breach-notification-rule.shtml)

- Unintentional access in good faith within scope of work
- Inadvertent disclosure between authorized employees
- PHI cannot reasonably be retained by the unauthorized person
- **Encrypted PHI**: If properly encrypted, breach notification is not required [niu](https://www.niu.edu/doit/about/policies/hipaa-breach-notification-rule.shtml)

---

### Enforcement Rule

The **HIPAA Enforcement Rule** establishes penalties for violations: [ncbi.nlm.nih](https://www.ncbi.nlm.nih.gov/books/NBK500019/)

| Violation Category              | Per Violation   | Annual Maximum |
| ------------------------------- | --------------- | -------------- |
| Did not know                    | $100–$50,000    | $1.5 million   |
| Reasonable cause                | $1,000–$50,000  | $1.5 million   |
| Willful neglect — corrected     | $10,000–$50,000 | $1.5 million   |
| Willful neglect — not corrected | $50,000+        | $1.5 million   |

**Criminal penalties** (for intentional violations):

- Up to **1 year imprisonment** for knowingly obtaining PHI
- Up to **5 years** if obtained under false pretenses
- Up to **10 years** if obtained for commercial advantage or malicious harm

---

## Master Quick Revision

| Framework     | Key Purpose                  | Key Rule/Number                                  |
| ------------- | ---------------------------- | ------------------------------------------------ |
| **GDPR**      | EU data privacy              | €20M or 4% turnover fine; 8 data subject rights  |
| **ISO 27001** | ISMS certification           | PDCA; 93 controls (2022); 11 domains (2005)      |
| **ISO 27002** | Controls guidance            | Supplements 27001; not certifiable               |
| **SOX**       | Financial fraud prevention   | Section 404 IT controls; CEO/CFO certification   |
| **SOC 1**     | Financial reporting controls | Restricted use; SSAE 18                          |
| **SOC 2**     | Data security trust          | 5 Trust Principles; restricted use               |
| **SOC 3**     | Public trust report          | Same as SOC 2 but publicly shareable             |
| **COBIT**     | IT governance                | 5 domains: EDM, APO, BAI, DSS, MEA               |
| **HIPAA**     | Healthcare data privacy      | 60-day breach notification; 3 safeguard types    |
| **PHI**       | Health identifiers           | 18 identifiers; ePHI encrypted = no notification |

# Comprehensive Notes: PCI DSS, CIS Controls, SSE-CMM, IT Act 2000 & DPDP Act 2023

---

## 21. PCI DSS

### PCI DSS Overview

The **Payment Card Industry Data Security Standard (PCI DSS)** is a set of security standards designed to ensure that **all companies that accept, process, store, or transmit credit card information** maintain a secure environment. It is mandated by the **PCI Security Standards Council (PCI SSC)**, founded in 2006 by American Express, Discover, JCB International, MasterCard, and Visa. The current version is **PCI DSS v4.0.1**, which became fully effective on **March 31, 2025**. [optro](https://optro.ai/blog/pci-dss-requirements)

---

### History

| Year           | Milestone                                                                                        |
| -------------- | ------------------------------------------------------------------------------------------------ |
| **Pre-2004**   | Each card brand had its own security program (Visa CISP, Mastercard SDP)                         |
| **2004**       | PCI DSS v1.0 released as unified standard                                                        |
| **2006**       | PCI SSC formally established                                                                     |
| **2010**       | PCI DSS v2.0                                                                                     |
| **2013**       | PCI DSS v3.0                                                                                     |
| **2018**       | PCI DSS v3.2.1                                                                                   |
| **2022**       | PCI DSS v4.0 published                                                                           |
| **March 2025** | PCI DSS v4.0 fully effective; v3.2.1 retired [optro](https://optro.ai/blog/pci-dss-requirements) |

---

### Cardholder Data

**Cardholder Data (CHD)** consists of: [pcisecuritystandards](https://www.pcisecuritystandards.org/pdfs/pci_ssc_quick_guide.pdf)

| Data Element                 | Storage Permitted? | Protection Required? |
| ---------------------------- | ------------------ | -------------------- |
| Primary Account Number (PAN) | Yes (if masked)    | Yes                  |
| Cardholder Name              | Yes                | Yes                  |
| Service Code                 | Yes                | Yes                  |
| Expiration Date              | Yes                | Yes                  |
| Full Magnetic Strip Data     | **No**             | N/A                  |
| CAV2/CVC2/CVV2/CID           | **No**             | N/A                  |
| PIN/PIN Block                | **No**             | N/A                  |

**Key rule**: **Sensitive Authentication Data (SAD)** — magnetic strip, CVV, and PIN — must **never be stored** after authorization, even if encrypted.

**Cardholder Data Environment (CDE)**: The network of systems, people, and processes that store, process, or transmit cardholder data.

---

### PCI Compliance

**Compliance validation** methods: [pcisecuritystandards](https://www.pcisecuritystandards.org/pdfs/pci_ssc_quick_guide.pdf)

- **Report on Compliance (ROC)**: Full audit by Qualified Security Assessor (QSA) — required for Level 1 merchants
- **Self-Assessment Questionnaire (SAQ)**: Self-reported compliance checklist for smaller merchants
- **Attestation of Compliance (AOC)**: Document certifying SAQ or ROC completion

**Consequences of non-compliance**:

- Fines from card brands: $5,000–$100,000 per month
- Increased transaction fees
- Loss of ability to process card payments
- Mandatory forensic investigation after breach
- Reputational damage and customer loss

---

### 12 PCI DSS Requirements

PCI DSS organizes 12 requirements into **6 goals**: [oligo](https://www.oligo.security/academy/12-pci-dss-requirements-explained-and-whats-new-in-pci-v4-0)

#### Goal 1: Build and Maintain a Secure Network

**Requirement 1 – Firewall Configuration**

- Install and maintain a **firewall/router configuration** to protect the CDE
- Restrict all inbound and outbound traffic to only what is necessary
- Prohibit direct public access between the internet and CDE
- Review firewall rules every 6 months
- Document business justification for all allowed services

**Requirement 2 – Do Not Use Vendor-Supplied Defaults**

- Change ALL vendor-supplied default passwords before installation
- Remove or disable unnecessary default accounts
- Develop configuration standards for all system components
- Enable only necessary services, protocols, and ports
- Applies to: routers, firewalls, servers, POS systems, databases

---

#### Goal 2: Protect Cardholder Data

**Requirement 3 – Protect Stored Cardholder Data**

- Keep cardholder data storage to an absolute minimum
- Do not store Sensitive Authentication Data after authorization
- Mask PAN when displayed (only first 6 and last 4 digits visible): e.g., 1234 56XX XXXX 3456
- Render PAN unreadable anywhere it is stored (encryption, truncation, hashing, tokenization)
- Implement a data retention and disposal policy

**Requirement 4 – Encrypt Data Transmission**

- Encrypt PAN during transmission over open, public networks (internet, wireless)
- Use strong cryptography: **TLS 1.2+ or TLS 1.3**
- Never send unprotected PANs by end-user messaging technologies (email, IM, SMS)
- Maintain an inventory of trusted keys/certificates

---

#### Goal 3: Maintain a Vulnerability Management Program

**Requirement 5 – Anti-virus / Anti-malware**

- Deploy anti-malware solutions on all systems commonly affected by malware
- Ensure anti-malware is current, actively running, and generating audit logs
- Cannot be disabled or altered by users unless specifically authorized
- PCI DSS v4.0: Extended to ALL system components, not just Windows systems [sisa](https://sisa.ai/resource/cyberpedia/pci-dss-4-0-checklist-12-most-important-requirements-explained)

**Requirement 6 – Develop and Maintain Secure Systems**

- Protect all system components from known vulnerabilities by installing security patches
- Critical patches: deploy within **1 month** of release
- Establish a security vulnerability management process
- Develop web applications using secure development standards
- Use **web application firewall (WAF)** for public-facing web applications
- Address OWASP Top 10 vulnerabilities

---

#### Goal 4: Implement Strong Access Control Measures

**Requirement 7 – Restrict Access to Cardholder Data by Need-to-Know**

- Limit access to system components and cardholder data to only those whose job requires it
- Implement an **access control system** with "deny all" unless specifically allowed
- Document access privileges with business justification
- Review user access rights at least every 6 months

**Requirement 8 – Assign a Unique ID to Each Person with Computer Access**

- Assign a unique ID for all users before allowing access to CDE
- **No shared or generic IDs** for users or administrators
- Implement **Multi-Factor Authentication (MFA)** for all access to the CDE (v4.0)
- Manage passwords: minimum 12 characters (PCI DSS v4.0), complexity requirements
- Lock accounts after not more than **10 failed attempts**; minimum **30-minute lockout**

**Requirement 9 – Restrict Physical Access to Cardholder Data**

- Use appropriate physical security for all areas containing cardholder data
- Implement visitor controls: badges, visitor logs, escort policy
- Secure physical media containing CHD: locked storage, secure disposal
- Protect point-of-sale (POS) devices from tampering
- Inspect POS devices periodically for skimming devices

---

#### Goal 5: Regularly Monitor and Test Networks

**Requirement 10 – Track and Monitor All Access to Network Resources and Cardholder Data**

- Implement audit trails to link access to individual users
- Log events: user access, privileged actions, invalid access attempts, use of audit trails
- Retain audit logs for at least **12 months** (at least 3 months immediately available)
- Use **SIEM** or centralized log management
- Review logs daily for anomalies
- Synchronize all system clocks (**NTP**)

**Requirement 11 – Regularly Test Security Systems and Processes**

- Test for presence of wireless access points quarterly
- Run **internal and external vulnerability scans** at least quarterly and after significant changes
- Use **Approved Scanning Vendor (ASV)** for external scans
- Perform **penetration testing** at least annually and after major changes
- Implement **intrusion detection/prevention systems (IDS/IPS)**
- Use **File Integrity Monitoring (FIM)** for critical files

---

#### Goal 6: Maintain an Information Security Policy

**Requirement 12 – Maintain a Policy that Addresses Information Security for All Personnel**

- Establish, publish, maintain, and distribute a security policy
- Review policy at least annually and when environment changes
- Implement a **risk assessment process** at least annually
- Develop **usage policies** for all critical technologies
- Security awareness training for all staff
- Manage service providers: maintain list, have written agreements, monitor compliance
- Implement an **incident response plan**; test at least annually

---

### PCI Compliance Levels

Merchant compliance levels are based on **annual transaction volume**: [pcisecuritystandards](https://www.pcisecuritystandards.org/pdfs/pci_ssc_quick_guide.pdf)

| Level       | Criteria                                                                | Validation Requirement                         |
| ----------- | ----------------------------------------------------------------------- | ---------------------------------------------- |
| **Level 1** | >6 million transactions/year OR any merchant that has suffered a breach | Annual **ROC** by QSA + quarterly scans by ASV |
| **Level 2** | 1–6 million transactions/year                                           | Annual **SAQ** + quarterly scans by ASV        |
| **Level 3** | 20,000–1 million e-commerce transactions/year                           | Annual **SAQ** + quarterly scans by ASV        |
| **Level 4** | <20,000 e-commerce OR up to 1 million other transactions/year           | Annual **SAQ** recommended + quarterly scans   |

---

## 22. CIS Controls

### CIS Overview

The **Center for Internet Security (CIS) Controls** (formerly SANS Top 20) are a **prioritized set of cybersecurity best practices** designed to stop the most prevalent and dangerous cyber attacks: [cisecurity](https://www.cisecurity.org/controls/v8)

- Developed by cybersecurity experts and community contributors worldwide
- Free and publicly available from CIS website
- Current version: **CIS Controls v8.1** (2024 update to v8 released in 2021)
- **18 Controls** organized into **153 Safeguards** [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)
- Mapped to major frameworks: NIST CSF, ISO 27001, HIPAA, PCI DSS, GDPR

---

### CIS Compliance

**Implementation Groups (IGs)** allow organizations to prioritize controls based on size and risk: [cisecurity](https://www.cisecurity.org/controls/v8)

| Group   | Target Organization                                                          | Controls Focus                                         |
| ------- | ---------------------------------------------------------------------------- | ------------------------------------------------------ |
| **IG1** | Small/medium businesses with limited IT/security expertise                   | 56 foundational Safeguards — "essential cyber hygiene" |
| **IG2** | Organizations with some security staff, managing sensitive data              | IG1 + 74 additional Safeguards                         |
| **IG3** | Large enterprises with dedicated security teams facing sophisticated attacks | All 153 Safeguards                                     |

**Key principle**: **IG1 represents the minimum standard** of information security for all organizations.

---

### CIS Controls v8 (All 18 Controls)

| #   | Control                                        | Description                                     |
| --- | ---------------------------------------------- | ----------------------------------------------- |
| 1   | **Inventory and Control of Enterprise Assets** | Know all hardware connected to your network     |
| 2   | **Inventory and Control of Software Assets**   | Know all software installed and authorized      |
| 3   | **Data Protection**                            | Classify, handle, and dispose of data securely  |
| 4   | **Secure Configuration**                       | Harden OS, applications, network devices        |
| 5   | **Account Management**                         | Manage user, admin, and service accounts        |
| 6   | **Access Control Management**                  | Manage credentials and access privileges        |
| 7   | **Continuous Vulnerability Management**        | Continuously scan and remediate vulnerabilities |
| 8   | **Audit Log Management**                       | Collect, retain, and analyze audit logs         |
| 9   | **Email and Web Browser Protections**          | Protect against phishing and malicious sites    |
| 10  | **Malware Defenses**                           | Prevent malware installation and execution      |
| 11  | **Data Recovery**                              | Backup and restore critical enterprise data     |
| 12  | **Network Infrastructure Management**          | Secure network devices and architecture         |
| 13  | **Network Monitoring and Defense**             | Monitor network for attacks and anomalies       |
| 14  | **Security Awareness and Skills Training**     | Train all staff on cybersecurity                |
| 15  | **Service Provider Management**                | Evaluate and manage third-party security        |
| 16  | **Application Software Security**              | Secure SDLC and vulnerability remediation       |
| 17  | **Incident Response Management**               | Establish and test IR capability                |
| 18  | **Penetration Testing**                        | Simulate attacks to find exploitable weaknesses |

---

### Important CIS Controls (Detailed)

**CIS Control 1 – Asset Management**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Actively inventory all hardware assets: endpoints, servers, network devices, IoT
- Detect unauthorized assets and remove or remediate them
- Track assets across physical, virtual, remote, and cloud environments
- **Principle**: You cannot protect what you don't know you have

**CIS Control 6 – Access Control**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Assign and manage authorization for all user, admin, and service accounts
- Enforce least privilege access
- Remove or disable accounts when no longer needed
- Implement MFA for all administrative access

**CIS Control 7 – Vulnerability Management**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Continuously scan for vulnerabilities on all enterprise assets
- Remediate vulnerabilities based on risk severity and business impact
- Monitor public/private threat intelligence sources
- Track remediation through to closure

**CIS Control 8 – Audit Log Management**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Collect logs from all enterprise assets
- Alert on anomalous events detected in logs
- Review and retain logs to support incident investigation
- Use SIEM for centralized log correlation

**CIS Control 10 – Malware Defense**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Prevent installation and execution of malware on enterprise assets
- Deploy anti-malware software on all devices
- Use application allowlisting where appropriate
- Enable automatic updates for malware signatures

**CIS Control 17 – Incident Response**: [cisecurity](https://www.cisecurity.org/controls/cis-controls-list)

- Establish IR policies, plans, procedures, and defined roles
- Conduct incident response training and exercises
- Communicate effectively during and after incidents
- Incorporate lessons learned from incidents

---

### CIS Benchmarks

**CIS Benchmarks** are configuration guidelines for specific technologies: [cisecurity](https://www.cisecurity.org/insights/white-papers/guide-to-asset-classes-cis-critical-security-controls-v8-1)

- Available for OS (Windows, Linux, macOS), cloud (AWS, Azure, GCP), databases, browsers
- Two profile levels:
  - **Level 1**: Basic security, minimal performance impact — suitable for most environments
  - **Level 2**: Defense in depth, may impact performance — high-security environments
- Basis for **hardening** systems before deployment
- Used in compliance assessments and vulnerability audits

---

## 23. SSE-CMM

### History

The **Systems Security Engineering Capability Maturity Model (SSE-CMM)** was developed in the **mid-1990s** by a consortium of security engineers, sponsored by the **US National Security Agency (NSA)**: [csrc.nist](https://csrc.nist.rip/nissc/1998/proceedings/tutorB5.pdf)

- Based on the Software Engineering CMM (SW-CMM) developed by Carnegie Mellon
- SSE-CMM v2.0 published in 1999
- Standardized as **ISO/IEC 21827** in 2002 and updated in 2008
- Purpose: advance security engineering as a **defined, mature, and measurable discipline**
- Developed to address the lack of standard metrics for security engineering process quality

---

### Need for SSE-CMM

SSE-CMM was needed because: [csrc.nist](https://csrc.nist.gov/files/pubs/conference/2000/10/19/proceedings-of-the-23rd-nissc-2000/final/docs/papers/916slide.pdf)

- Security engineering lacked standardized, measurable practices
- Organizations needed a way to **evaluate and improve** security engineering processes
- Buyers of security products/services needed a **way to assess provider capability**
- Security practices were ad hoc and inconsistent across projects
- Needed a model that integrated security engineering into overall systems engineering

---

### Security Engineering

**SSE-CMM defines 22 Process Areas** in 3 categories: [scribd](https://www.scribd.com/document/404640024/SSE-CMM)

**Project/Organizational Processes (11 areas)**:

- Plan security aspects of work
- Assess risk
- Monitor security performance
- Manage quality
- Build organizational security capability

**Engineering Processes (11 Security-Specific areas)** including:

- **Assess Threat**: Identify and characterize threats to the system
- **Assess Vulnerability**: Identify and characterize exploitable weaknesses
- **Assess Impact**: Assess harm to the organization from security failures
- **Coordinate Security**: Coordinate with stakeholders to ensure consistent security
- **Provide Security Input**: Provide guidance on security aspects of design/development
- **Verify and Validate Security**: Confirm security mechanisms work as intended
- **Monitor Security Posture**: Identify and monitor security-relevant events

---

### Capability Maturity Model

**SSE-CMM maturity** is measured using 6 levels (0–5): [complianceforge](https://complianceforge.com/what-is-a-cmm-level/)

| Level       | Name                      | Description                                                         |
| ----------- | ------------------------- | ------------------------------------------------------------------- |
| **Level 0** | Not Performed             | Process is not executed; no evidence it occurs                      |
| **Level 1** | Performed Informally      | Base practices are performed but ad hoc; no planning or tracking    |
| **Level 2** | Planned and Tracked       | Process is planned, performed according to plan, tracked            |
| **Level 3** | Well Defined              | Process uses defined, documented, and standardized procedures       |
| **Level 4** | Quantitatively Controlled | Process is measured with quantitative techniques; quality goals set |
| **Level 5** | Continuously Improving    | Focus on continuous process improvement and optimization            |

---

### Maturity Levels (Detailed)

**Level 1 – Performed Informally (Initial)**:

- Security engineering activities happen but are not standardized
- Success depends on individual skill and effort, not process
- Results are unpredictable; cannot be consistently repeated
- No formal planning, tracking, or verification of security activities

**Level 2 – Planned and Tracked**:

- Security activities are formally planned before execution
- Actual performance is tracked against the plan
- Corrective actions taken when performance deviates from plan
- Requirements managed and changes controlled at project level

**Level 3 – Well Defined**:

- Standard security engineering processes defined across the organization
- All projects use adapted versions of the organizational standard process
- Training programs ensure staff can perform defined processes
- Process assets (templates, tools, lessons learned) collected and shared

**Level 4 – Quantitatively Controlled**:

- Quantitative quality goals established for security processes
- Detailed measures collected and analyzed statistically
- Process performance is predictable within quantitative bounds
- Variation in process performance understood and managed using data

**Level 5 – Continuously Improving**:

- Organization identifies weaknesses and proactively improves processes
- Innovative practices piloted and incorporated if effective
- Defect prevention through root cause analysis
- Entire organization focused on continuous security engineering improvement

---

## 24. IT Act 2000 / ITAA 2008

### Overview

The **Information Technology Act, 2000 (IT Act 2000)** is India's primary legislation governing electronic commerce, digital transactions, and cyber crimes: [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Enacted on **October 17, 2000**
- Based on the **UNCITRAL Model Law on Electronic Commerce (1996)**
- Significantly amended by the **IT Amendment Act 2008 (ITAA 2008)**, effective **October 27, 2009**
- Administered by the **Ministry of Electronics and Information Technology (MeitY)**
- Established **Cyber Appellate Tribunal** and **IT Security Adjudicating Officers**

---

### Electronic Records

The IT Act gives **legal recognition** to electronic records: [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Electronic records have the same legal validity as paper records
- Information stored in magnetic/optical media qualifies as an electronic record
- Electronic records are admissible as evidence in courts
- Retention of electronic records satisfies legal record-keeping requirements if original format and authenticity are maintained

---

### Digital Signatures

IT Act 2000 provided legal recognition for **digital signatures**: [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Digital signatures are legally equivalent to handwritten signatures
- Based on **asymmetric cryptography** (public/private key pair)
- Must be granted by a **Certifying Authority (CA)** licensed by the Controller of Certifying Authorities (CCA)
- ITAA 2008 introduced **electronic signatures** (broader term including biometrics, etc.)
- Used for: filing income tax, MCA filings, e-tendering, e-contracts

---

### Important Sections

#### Section 43 — Unauthorized Access / Damage to Computer Systems

- Applies to any person who **without permission** accesses, damages, disrupts, or uses a computer system
- **Civil remedy** — compensation payable to affected person
- Acts covered:
  - Accessing a computer without authorization
  - Downloading, copying, or extracting data
  - Introducing viruses or malware
  - Disrupting or denying access
  - Charging services to another person's account
  - Damaging a computer or computer network

#### Section 66 — Computer Related Offences (ITAA 2008) [police.py.gov](<https://police.py.gov.in/Information%20Technology%20Act%202000%20-%202008%20(amendment).pdf>)

- **Criminal version** of Section 43 offenses
- If any person **dishonestly or fraudulently** commits any act under Section 43:
- **Punishment**: Imprisonment up to **3 years** OR fine up to **₹5 lakhs**, or both
- Applies to hacking, unauthorized access, data theft, introducing viruses

#### Section 66C — Identity Theft [police.py.gov](<https://police.py.gov.in/Information%20Technology%20Act%202000%20-%202008%20(amendment).pdf>)

- Dishonest or fraudulent use of another person's **electronic signature, password, or unique identification feature**
- **Punishment**: Imprisonment up to **3 years** + fine up to **₹1 lakh**
- Examples: Using someone else's net banking credentials, stealing OTP

#### Section 66D — Cheating by Personation Using Computer Resource [police.py.gov](<https://police.py.gov.in/Information%20Technology%20Act%202000%20-%202008%20(amendment).pdf>)

- Cheating by **impersonating** using computer resources or communication devices
- **Punishment**: Imprisonment up to **3 years** + fine up to **₹1 lakh**
- Examples: Phishing attacks, creating fake websites to deceive users, vishing

#### Section 67 — Publishing Obscene Material in Electronic Form [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Publishing or transmitting **obscene material** in electronic form
- **Punishment** (first conviction): Imprisonment up to **3 years** + fine up to **₹5 lakhs**
- **Subsequent conviction**: Imprisonment up to **5 years** + fine up to **₹10 lakhs**
- Section 67A: Sexually explicit content — up to 5 years
- Section 67B: Child pornography — up to 7 years

#### Section 69 — Interception/Monitoring/Decryption of Information [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Empowers **government agencies** to intercept, monitor, or decrypt any information through any computer resource
- Applicable for: national security, sovereignty, defense, public order, investigation of offenses
- Can direct any subscriber/intermediary to decrypt/provide access
- **Failure to comply** is punishable with imprisonment up to **7 years**

#### Section 72 — Breach of Confidentiality and Privacy [indiacode.nic](https://www.indiacode.nic.in/bitstream/123456789/13116/1/it_act_2000_updated.pdf)

- Applies to persons who have **secured access to electronic records in the course of official duty** (e.g., regulators, adjudicating officers)
- Disclosing such information to any other person **without consent** is an offense
- **Punishment**: Imprisonment up to **2 years** OR fine up to **₹1 lakh**, or both

---

### Amendments in 2008 (ITAA 2008)

Key changes introduced by the IT Amendment Act 2008: [police.py.gov](<https://police.py.gov.in/Information%20Technology%20Act%202000%20-%202008%20(amendment).pdf>)

| Change                     | Details                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------ |
| **New offenses added**     | Identity theft (66C), cheating by personation (66D), cyber terrorism (66F), violation of privacy (66E) |
| **Section 66 revised**     | Now covers all computer-related offenses with criminal penalties                                       |
| **Intermediary liability** | Section 79 safe harbor — intermediaries not liable if they act promptly on notice                      |
| **Data protection**        | Section 43A — companies with sensitive personal data must implement reasonable security practices      |
| **Cyber terrorism**        | Section 66F — up to life imprisonment                                                                  |
| **CERT-In empowered**      | Section 70B established CERT-In as national agency for cyber incident response                         |
| **Blocking powers**        | Section 69A — government can block public access to information                                        |

---

## 25. Digital Personal Data Protection (DPDP) Act 2023

### Overview

India's **Digital Personal Data Protection Act 2023** is the country's first comprehensive data protection law, signed on **August 11, 2023**: [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

- Applies to **digital personal data** processed within India
- Also applies to processing **outside India** if related to goods/services offered to Indian residents (extraterritorial)
- Replaces the IT Act 2000's data protection provisions
- Establishes the **Data Protection Board of India** for enforcement
- Unlike GDPR, does NOT distinguish between normal and sensitive personal data — all personal data is equally protected [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

---

### Data Principal

**Data Principal** = the individual whose personal data is being processed: [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

- Equivalent to GDPR's "data subject"
- Has rights over their personal data
- For children (under 18): parent/guardian acts as Data Principal
- Has **duties** too — cannot provide false information, impersonate others, or make frivolous complaints (violation: up to ₹10,000 fine) [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

---

### Data Fiduciary

**Data Fiduciary** = entity that determines the **purpose and means** of processing personal data: [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

- Equivalent to GDPR's "data controller"
- Bears primary compliance obligations under DPDP Act
- Must implement **reasonable security safeguards**
- Must appoint **grievance officer** accessible to Data Principals
- Must notify Data Principals and the Board in case of **data breach**

**Significant Data Fiduciary (SDF)**: Designated by government based on:

- Volume and sensitivity of data processed
- Risk to national security or public order
- Additional obligations: must appoint DPO in India + independent data auditor + conduct DPIA [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

---

### Data Processor

**Data Processor** = entity that processes data **on behalf of the Data Fiduciary**: [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

- Equivalent to GDPR's "data processor"
- Must process only as directed by the Fiduciary
- Must assist Fiduciary in meeting compliance obligations
- Subject to contractual obligations from Fiduciary

---

### Consent

**Consent** under DPDP Act must be: [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

- **Free**: Without coercion or undue influence
- **Specific**: For a specific, clearly stated purpose
- **Informed**: After providing a privacy notice in clear, plain language
- **Unconditional**: Not contingent on accepting other terms
- **Unambiguous**: Clear affirmative action

**Consent Manager**: A registered intermediary that enables Data Principals to **give, manage, review, and withdraw consent** across multiple Fiduciaries from a single platform. [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

**Legitimate Use (No Consent Needed) for**:

- State and its instrumentalities for public functions
- Medical emergencies / health threats
- Employment purposes
- Public interest functions (courts, disaster management)

---

### Rights of Individuals (Data Principals)

1. **Right to Access Information**: Know what data is held, purpose, and names of other Data Fiduciaries it's shared with
2. **Right to Correction**: Request correction of inaccurate, incomplete, or outdated personal data
3. **Right to Erasure**: Request deletion of personal data when no longer necessary for the purpose consented to
4. **Right to Grievance Redressal**: Lodge complaints with the Data Fiduciary; if unsatisfied, escalate to **Data Protection Board**
5. **Right to Nominate**: Nominate another person to exercise rights in case of death or incapacity

---

### Obligations of Organizations (Data Fiduciaries)

1. **Purpose Limitation**: Collect only what is necessary; use only for stated purpose
2. **Data Minimization**: Collect minimum data required for the purpose
3. **Storage Limitation**: Retain data only as long as necessary; then **erase or anonymize**
4. **Security**: Implement **reasonable technical and organizational security safeguards**
5. **Breach Notification**: Notify Data Protection Board and affected individuals upon breach
6. **Accuracy**: Ensure data is accurate and up to date
7. **Children's Data**: Obtain **verifiable parental consent** before processing data of children; no behavioral monitoring or targeted advertising toward children
8. **Grievance Mechanism**: Establish an accessible grievance redressal system
9. **Privacy Notice**: Provide clear notice before collecting data

---

### Penalties [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

| Violation                                                              | Maximum Penalty |
| ---------------------------------------------------------------------- | --------------- |
| Failure to implement security safeguards leading to data breach        | **₹250 Crores** |
| Failure to notify Board/Data Principals of a breach                    | **₹200 Crores** |
| Failure to fulfill Data Principal rights (access, correction, erasure) | **₹200 Crores** |
| Non-compliance with children's data obligations                        | **₹200 Crores** |
| Non-compliance by Significant Data Fiduciary                           | **₹150 Crores** |
| Any other violation (residual category)                                | **₹50 Crores**  |
| Data Principal duties violation                                        | **₹10,000**     |

**Enforcement mechanism**: **Data Protection Board of India** — investigates complaints, conducts inquiries, and imposes penalties. [complinity](https://complinity.com/blog/compliance/compliances-and-penalties-under-the-digital-personal-data-protection-dpdp-act-2023/)

---

### Data Protection Board

The **Data Protection Board of India**: [en.wikipedia](https://en.wikipedia.org/wiki/Digital_Personal_Data_Protection_Act,_2023)

- Established by the Central Government under the DPDP Act
- **Quasi-judicial body** with powers of a civil court
- Adjudicates complaints from Data Principals
- Investigates data breaches and non-compliance
- Can impose penalties up to ₹250 crores
- Appeals go to the **Telecom Disputes Settlement and Appellate Tribunal (TDSAT)**
- Operates **digitally**: complaints filed electronically, hearings may be virtual

---

## Master Quick Revision Table

| Framework           | Type                      | Key Numbers                                                                 |
| ------------------- | ------------------------- | --------------------------------------------------------------------------- |
| **PCI DSS v4.0**    | Payment security          | 12 requirements; 4 compliance levels; 6 months firewall review              |
| **CIS Controls v8** | Security best practices   | 18 controls; 153 safeguards; 3 implementation groups                        |
| **SSE-CMM**         | Security process maturity | 6 levels (0–5); 22 process areas; ISO/IEC 21827                             |
| **IT Act 2000**     | Indian cyber law          | S.43 (damage), S.66 (criminal), S.66C (identity theft), S.69 (interception) |
| **ITAA 2008**       | IT Act amendment          | Added S.66C, 66D, 66E, 66F; S.43A for data protection                       |
| **DPDP Act 2023**   | Indian data protection    | Data Principal rights; ₹250 Cr max penalty; Data Protection Board           |
