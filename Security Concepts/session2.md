# Web Application Security — Session 2 Notes

### (Session 2: 2T+2L — Denial of Service | Buffer Overflows and Input Validation | Access Control)

---

## 1. Denial of Service (DoS)

### What is DoS?

A Denial of Service (DoS) attack is a malicious attempt to disrupt the normal functioning of a system, server, or network by overwhelming it with excessive traffic or exploiting vulnerabilities, making it unavailable to legitimate users.

### How DoS Works

- Attacker sends a large number of requests or malformed packets.
- Target system tries to respond to all requests.
- Resources such as CPU, memory, bandwidth, or connection tables get exhausted.
- Legitimate users cannot access the service.

**Example**: A web server that can handle 1000 requests/sec receives 100,000 fake requests/sec → service crash or slowdown.

### Types of DoS Attacks

**1. Volume-Based Attacks** — Focus: consume network bandwidth

- **UDP Flood**: Sends large volumes of UDP packets to random ports. Target replies with ICMP "Destination Unreachable," consuming bandwidth.
- **ICMP Flood (Ping Flood)**: Overloads target with ICMP Echo Requests.
- **Ping of Death**: Sends oversized or malformed packets causing buffer overflow (mostly mitigated in modern systems).
- _Effect_: Network congestion and bandwidth exhaustion.

**2. Protocol Attacks (State Exhaustion Attacks)** — Focus: exploit weaknesses in network protocols and exhaust server resources

- **SYN Flood**: Exploits the TCP 3-way handshake. Attacker sends SYN requests but never completes the handshake. Server keeps half-open connections until the connection table fills up.

  _A Connection Table (also called a State Table) is a data structure maintained by a stateful firewall, NAT device, or load balancer to keep track of all active network connections._

- **Smurf Attack**: Uses ICMP echo requests sent to broadcast addresses with a spoofed source IP (the victim). All hosts reply to the victim, creating an amplification effect.
- _Effect_: Exhausts server connection tables, firewall states, or load balancers.

**3. Application Layer Attacks (Layer 7)** — Focus: target specific applications (HTTP, DNS, etc.)

- **HTTP Flood**: Sends legitimate-looking HTTP GET/POST requests repeatedly. Hard to detect because traffic appears normal.
- **Slowloris**: Keeps connections open by sending partial HTTP requests slowly.
- _Effect_: High CPU and memory usage; web server crash or extreme slowdown.

### Distributed Denial of Service (DDoS)

**What is DDoS?**
A DDoS attack is a large-scale DoS attack where multiple compromised machines (a botnet) simultaneously attack a target.

**Botnet Concept**

- Devices infected with malware (bots/zombies).
- Controlled by an attacker via a Command & Control (C2) server.
- Example: Mirai botnet (IoT-based attacks).

**Why DDoS Is More Dangerous**

- Traffic comes from multiple IPs, making it difficult to block.
- High volume overwhelms even large infrastructures.
- Often uses reflection and amplification (DNS, NTP attacks).

### Consequences of DoS/DDoS

- Service downtime (websites, APIs, cloud services)
- Financial loss (especially for e-commerce platforms)
- Reputation damage
- SLA violations
- Loss of customer trust
- Resource exhaustion leading to system crashes

### Detection Indicators

- Sudden spike in traffic
- High number of half-open TCP connections
- Unusual traffic patterns (same requests repeatedly)
- Increased latency or timeout errors
- Logs showing repeated requests from similar IP ranges

### Mitigation Techniques

**1. Network-Level Protection**

- **Rate Limiting**: Limit the number of requests per IP.
- **Firewalls**: Filter malicious traffic based on rules.
- **Access Control Lists (ACLs)**: Block suspicious IP ranges.

**2. System-Level Protection**

- **SYN Cookies**: Prevent half-open connection exhaustion.
- **Increase backlog queue**: Improve TCP handling capacity.
- **Load balancing**: Distribute traffic across multiple servers.

**3. Application-Level Protection**

- **Web Application Firewall (WAF)**: Filters HTTP attacks.
- **CAPTCHA**: Prevents bots from sending automated requests.
- **Request validation**: Detects abnormal patterns.

**4. Cloud-Based Protection**

- **Content Delivery Networks (CDNs)**: Distribute traffic geographically.
- **Anti-DDoS Services**: Cloudflare, AWS Shield, Akamai.
- **Traffic scrubbing centers**: Clean malicious traffic before it reaches the server.

**5. Redundancy & High Availability**

- Multiple servers (horizontal scaling)
- Failover systems
- Geo-distribution of services

### Example Scenario (Practical Understanding)

Imagine an e-commerce website hosted on AWS:

- During a sale, attackers launch an HTTP flood.
- Server CPU spikes due to processing fake requests.
- Legitimate users face slow checkout or failure.

**Mitigation**: AWS Shield absorbs attack traffic; WAF blocks suspicious patterns; auto-scaling adds new instances to handle the load.

### Key Differences: DoS vs. DDoS

| Aspect             | DoS                    | DDoS                                              |
| ------------------ | ---------------------- | ------------------------------------------------- |
| Source             | Single attacker system | Multiple distributed systems (botnet)             |
| Detection/Blocking | Easier                 | Harder, due to distributed nature and high volume |

---

## 1a. DoS/DDoS Attack Tools

### Common Attack Tools (Used by Attackers)

**1. LOIC (Low Orbit Ion Cannon)**

- _Type_: Volumetric HTTP/UDP/TCP flood tool
- _Platform_: Windows
- _Features_: Open-source stress testing tool; can be used in "Hive Mode" (coordinated DDoS); sends massive HTTP/UDP/TCP requests
- _Use case_: Website takedowns, gaming server attacks

**2. HOIC (High Orbit Ion Cannon)**

- _Type_: Advanced version of LOIC
- _Features_: Supports plugins for custom attack patterns; can bypass simple mitigation; targets multiple URLs simultaneously

**3. Slowloris**

- _Type_: Application Layer (Layer 7)
- _Attack method_: Opens multiple HTTP connections; sends partial requests slowly; keeps connections open indefinitely
- _Effect_: Server thread pool exhaustion
- _Detection difficulty_: High (appears as legitimate slow connections)

**4. hping3 (Linux)**

- _Type_: Packet crafting tool
- _Features_: Custom TCP/UDP/ICMP packets; used for SYN flood and UDP flood testing
- _Command_: `hping3 --flood -p 80 target.com`
- _Use case_: Penetration testing, network stress testing

**5. Metasploit (DoS Modules)**

- _Type_: Penetration testing framework
- _Features_: Contains auxiliary DoS modules, e.g. `auxiliary/dos/tcp/synflood`
- _Use case_: Authorized security testing

**6. Xerxes**

- _Type_: HTTP flood tool
- _Features_: Multi-threaded; targets web servers; creates multiple HTTP connections

**7. DDoS Simulators (Testing Tools)**

- _Examples_: Nmap NSE scripts (`--script http-slowloris`), Apache Bench (`ab`), Siege (HTTP load testing)
- _Purpose_: Legitimate load testing (NOT for attacks)

### DoS/DDoS Prevention Techniques

**1. Network-Level Prevention**

_A. Rate Limiting_

```bash
# Using iptables
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
```

Tools: Nginx rate limiting (`limit_req_zone`), Apache `mod_qos`, firewall rules (iptables, pfSense)

_B. Firewall Configuration_

```bash
# Enable SYN cookies in Linux
sysctl -w net.ipv4.tcp_syncookies=1

# Block ICMP floods
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s --limit-burst 4 -j ACCEPT

# Drop invalid packets
iptables -A INPUT -m state --state INVALID -j DROP
```

_C. Access Control Lists (ACLs)_

- Block suspicious IP ranges
- Restrict traffic by geographic location (GeoIP blocking)
- Example (Cisco):

```
access-list 101 deny ip any host 192.168.1.100
access-list 101 permit ip any any
```

**2. System-Level Prevention**

_A. TCP Stack Hardening_

```bash
# Reduce SYN-ACK retries
sysctl -w net.ipv4.tcp_synack_retries=2

# Increase connection queue
sysctl -w net.ipv4.tcp_max_syn_backlog=2048

# Enable TCP timestamps
sysctl -w net.ipv4.tcp_timestamps=1
```

_B. Connection Limits_

```bash
# Limit concurrent connections per IP
iptables -A INPUT -p tcp --syn -m connlimit --connlimit-above 15 -j DROP
```

_C. Disable Unused Services_

```bash
# Disable ICMP echo (ping)
sysctl -w net.ipv4.icmp_echo_ignore_all=1
```

**3. Application-Level Prevention**

_A. Web Application Firewall (WAF)_

- Tools: ModSecurity (Apache/Nginx), Cloudflare WAF, AWS WAF, F5 Advanced WAF
- Features: SQL injection protection, HTTP flood mitigation, bot detection, custom rule sets

_B. CAPTCHA Implementation_

- Prevents automated bot traffic
- Tools: Google reCAPTCHA, hCaptcha

_C. Application Hardening_

- Implement request throttling
- Use connection timeouts
- Validate input parameters
- Log suspicious activity

**4. Cloud-Based Protection**

_A. Content Delivery Networks (CDNs)_

- Examples: Cloudflare, Akamai, AWS CloudFront, Fastly
- Benefits: distributed traffic absorption, built-in DDoS mitigation, global edge network

_B. Cloud DDoS Services_

- **AWS Shield**: Standard (free) — basic L3/L4 protection; Advanced — L7 protection, 24/7 support
- **Cloudflare DDoS Protection**: always-on mitigation, automatic detection, free tier available
- **Google Cloud Armor**: edge security policy, IP reputation lists, rate-based rules
- **Azure DDoS Protection**: Basic (free), Standard (pay-per-usage)

_C. Traffic Scrubbing_

- How it works: traffic is routed through a scrubbing center, malicious packets are filtered, and clean traffic is forwarded to the origin.
- Providers: Radware, Imperva, Neusoft

**5. Infrastructure-Level Protection**

_A. Redundancy & Load Balancing_

- Deploy multiple servers
- Use load balancers (HAProxy, Nginx, F5 BIG-IP)
- Geographic distribution

_B. Auto-Scaling_

- AWS Auto Scaling Groups
- Kubernetes HPA (Horizontal Pod Autoscaler)
- Automatically adds resources during attacks

### Detection Tools

**1. Network Monitoring**

- Wireshark: packet analysis
- tcpdump: command-line traffic capture
- NetFlow: traffic statistics

**2. Attack Detection**

- Snort: IDS/IPS
- Suricata: high-performance IDS
- OSSEC: host-based intrusion detection

**3. DDoS-Specific Tools**

- FastNetMon: DDoS detection using NetFlow
- DDoS-Deflate: automated IP blocking
- fail2ban: log-based IP blocking

### Practical Commands (Linux)

Check for SYN flood:

```bash
netstat -n | grep :80 | wc -l
```

Block a single IP:

```bash
iptables -A INPUT -s ATTACKER_IP -j DROP
```

Block an IP range:

```bash
iptables -A INPUT -s 192.168.1.0/24 -j DROP
```

Monitor connections:

```bash
watch -n 1 'netstat -an | grep :80'
```

### Comparison Table: Prevention Methods

| Method        | Layer | Best For         | Cost      |
| ------------- | ----- | ---------------- | --------- |
| Rate Limiting | L4/L7 | Small attacks    | Free      |
| Firewalls     | L3/L4 | Protocol attacks | Free      |
| WAF           | L7    | HTTP floods      | Free/Paid |
| CDN           | L3/L7 | Volumetric       | Paid      |
| Cloud DDoS    | All   | Large attacks    | Paid      |
| Scrubbing     | All   | Enterprise       | High      |

### Best Practices Summary

1. Minimize attack surface (close unused ports)
2. Enable rate limiting at multiple layers
3. Use CDN/Cloud protection for public services
4. Monitor traffic patterns continuously
5. Implement failover systems
6. Test with legitimate load tools (not attack tools!)
7. Keep systems patched (software vulnerabilities)
8. Have an incident response plan ready

### CDAC Exam-Focused Notes

**Important commands**: iptables rules for DoS mitigation; sysctl TCP hardening; netstat for connection monitoring.
**Key tools to know**: Attacker tools — LOIC, Slowloris, hping3. Defender tools — Cloudflare, AWS Shield, WAF, fail2ban.

---

## 2. Buffer Overflows and Input Validation

### 2.1 Buffer Overflow

**What Is a Buffer Overflow?**
A buffer overflow occurs when a program writes more data to a memory buffer than it can hold, causing the excess data to overwrite adjacent memory locations.

This vulnerability can lead to:

- System crashes
- Arbitrary code execution
- Privilege escalation
- Data corruption

**How Buffer Overflow Works**

Memory layout example:

```c
char buffer[10];
strcpy(buffer, "this string is way too long");
```

What happens:

- `buffer` can hold only 10 bytes (including the null terminator).
- `"this string is way too long"` is 28+ bytes.
- `strcpy` copies without checking size.
- Excess data overwrites adjacent memory (stack/heap).

Memory visualization:

```
Before Overflow:
[buffer: 10 bytes] [return address] [other data]

After Overflow:
[buffer: 10 bytes + overflow data...] [return address OVERWRITTEN] [crash/exploit]
```

### Types of Buffer Overflow

**1. Stack Buffer Overflow**

- _Location_: Stack memory
- _Target_: Return addresses, function pointers
- _Impact_: Code execution, crashes

**2. Heap Buffer Overflow**

- _Location_: Heap memory (dynamically allocated)
- _Target_: Function pointers, metadata
- _Impact_: Memory corruption, unpredictable behavior

**3. Integer Overflow**

- _Cause_: Arithmetic operations exceeding a variable's size
- Example:
  ```c
  int a = 2147483647;  // INT_MAX
  a = a + 1;           // Becomes -2147483648
  ```
- _Impact_: Logic errors, buffer miscalculations

### Exploitation Example

**Scenario**:

1. Attacker sends oversized input to a vulnerable program.
2. Input overwrites the return address on the stack.
3. Return address points to attacker's shellcode in memory.
4. When the function returns, the malicious code executes.

Simplified flow:

```
1. User Input → Buffer
2. Buffer Overflows → Overwrites Return Address
3. Return Address → Points to Shellcode
4. Shellcode Executes → Attacker Gains Control
```

### Real-World Impact

- **Morris Worm (1988)**: exploited a buffer overflow in `gets()`
- **Code Red (2001)**: IIS buffer overflow
- **Heartbleed (2014)**: OpenSSL buffer over-read
- **Modern exploits**: browser, OS, IoT device vulnerabilities

### 2.2 Prevention Techniques

**A. Secure Coding Practices**

_1. Bounds Checking_ — always verify buffer size before writing:

```c
// UNSAFE
strcpy(buffer, input);

// SAFE
if (strlen(input) < sizeof(buffer)) {
    strcpy(buffer, input);
}
```

_2. Use Safe Functions_

| Unsafe Function | Safe Alternative | Description           |
| --------------- | ---------------- | --------------------- |
| `strcpy()`      | `strncpy()`      | Limits copy size      |
| `sprintf()`     | `snprintf()`     | Limits output size    |
| `gets()`        | `fgets()`        | Reads with size limit |
| `scanf("%s")`   | `scanf("%9s")`   | Limits input length   |

Example:

```c
// UNSAFE
strcpy(buffer, user_input);

// SAFE
strncpy(buffer, user_input, sizeof(buffer) - 1);
buffer[sizeof(buffer) - 1] = '\0';  // Ensure null-termination
```

_3. Input Length Validation_

```c
if (strlen(input) > MAX_LENGTH) {
    // Reject input
    return ERROR;
}
```

**B. Compiler & OS Protections**

_1. Stack Canaries (StackGuard)_

- What: a random value placed before the return address.
- How: an overflow must overwrite the canary first.
- Detection: if the canary changes, the program terminates.

```
[buffer] [CANARY] [return address]
          ↑
    Overflow must pass through
```

_2. Address Space Layout Randomization (ASLR)_

- What: randomizes memory layout on each execution.
- Effect: attacker cannot predict addresses (stack, heap, libraries).
- Enable (Linux):
  ```bash
  sysctl -w kernel.randomize_va_space=2
  ```

_3. Data Execution Prevention (DEP) / NX Bit_

- What: marks stack/heap as non-executable.
- Effect: shellcode placed in a buffer cannot execute.
- Types: Hardware DEP (CPU NX bit), Software DEP (OS-level).

_4. Position Independent Executables (PIE)_

- What: executable code is loaded at random addresses.
- Effect: harder to predict function locations.

_5. Control Flow Integrity (CFI)_

- What: validates function call/return addresses.
- Effect: prevents return address hijacking.

**C. Modern Language Features**

_1. Use Safer Languages_

- C/C++: manual memory management → prone to overflow.
- Alternatives: Rust (memory safety without garbage collection), Java/Python (automatic bounds checking), C#/.NET (managed memory).

_2. Compiler Flags_

```bash
# GCC/Clang protections
gcc -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE program.c
```

### 2.3 Input Validation

**What Is Input Validation?**
Input validation ensures that user input meets expected criteria before processing.

**Goals**:

- Correct type (integer, string, etc.)
- Correct length (within buffer bounds)
- Safe characters (no dangerous symbols)
- Expected format (email, phone, etc.)

**Why It Matters**
Poor input validation leads to:

- Buffer overflows
- SQL injection
- Command injection
- Cross-site scripting (XSS)
- Path traversal
- Format string attacks

### Types of Input Validation

**1. Whitelisting (Allowlist)**

- Approach: define what is allowed.
- Example: only allow alphanumeric characters.
- Best practice: more secure than blacklisting.

```python
# Python example
import re

user_input = "test123"
if re.match(r'^[a-zA-Z0-9]+$', user_input):
    # Safe input
    pass
else:
    # Reject
    pass
```

**2. Blacklisting (Denylist)**

- Approach: define what is NOT allowed.
- Example: block `<`, `>`, `'`, `"`, `;`, `--`.
- Weakness: attackers can bypass it.

```python
# NOT recommended
dangerous_chars = ['<', '>', "'", '"', ';']
if any(char in user_input for char in dangerous_chars):
    # Reject
    pass
```

Why whitelisting is better: blacklists can miss new attack patterns, while whitelists are stricter by design.

### Common Validation Checks

**1. Type Check**

```c
// Ensure input is integer
if (scanf("%d", &num) != 1) {
    // Invalid input
}
```

**2. Length Check**

```c
if (strlen(input) > MAX_LEN) {
    // Too long, reject
}
```

**3. Range Check**

```c
if (age < 0 || age > 120) {
    // Invalid age
}
```

**4. Format Check**

```python
# Email validation
import re
email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
if re.match(email_pattern, email):
    # Valid format
    pass
```

**5. Character Set Check**

```c
// Only alphanumeric
for (int i = 0; i < strlen(input); i++) {
    if (!isalnum(input[i])) {
        // Invalid character
        return ERROR;
    }
}
```

### 2.4 Vulnerabilities Due to Poor Validation

**A. SQL Injection**

- Cause: unvalidated input in SQL queries.

```sql
query = "SELECT * FROM users WHERE username = '" + userInput + "'";
```

- Attack:
  ```
  Input: ' OR '1'='1
  Query: SELECT * FROM users WHERE username = '' OR '1'='1'
  ```
- Prevention: use prepared statements (parameterized queries), input sanitization, ORM frameworks.

**B. Command Injection**

- Cause: unvalidated input in system commands.

```python
os.system("ping " + user_input)
```

- Attack:
  ```
  Input: 127.0.0.1; rm -rf /
  Command: ping 127.0.0.1; rm -rf /
  ```
- Prevention: avoid shell commands with user input; use safe APIs (`subprocess.run()` with list args); strict whitelisting.

**C. Cross-Site Scripting (XSS)**

- Cause: unvalidated/unescaped input in web pages.

```xml
<div>Hello, {{userInput}}</div>
```

- Attack:
  ```
  Input: <script>alert('XSS')</script>
  ```
- Prevention: HTML encoding (`<` → `&lt;`), Content Security Policy (CSP), framework escaping (React, Angular auto-escape).

**D. Path Traversal**

- Cause: unvalidated file paths.

```python
file = open("uploads/" + user_input, "r")
```

- Attack:
  ```
  Input: ../../etc/passwd
  File: ../../etc/passwd
  ```
- Prevention: validate file names, use `os.path.basename()`, restrict to allowed directories.

### 2.5 Best Practices for Input Validation

1. **Validate early** — validate input at entry points (API, form, CLI); don't trust client-side validation alone.
2. **Use built-in sanitization** — web frameworks (Django, Flask, Express) have validators; libraries like OWASP ESAPI, validator.js.
3. **Apply encoding/escaping** — HTML: escape `<`, `>`, `&`, `"`, `'`; SQL: use parameterized queries; URL: encode special characters.
4. **Client-side + server-side validation** — client-side for quick feedback (UX); server-side for security (never trust the client).
5. **Principle of least privilege** — run programs with minimal permissions; limit damage if an exploit occurs.
6. **Logging & monitoring** — log rejected inputs; detect attack patterns.

### 2.6 Tools for Detection

**Static Analysis**

- Cppcheck: C/C++ code analysis
- SonarQube: multi-language
- Flawfinder: C vulnerabilities
- Bandit: Python security

**Dynamic Analysis**

- Valgrind: memory error detection
- AddressSanitizer (ASan): compile-time buffer overflow detection
- GDB: debugging crashes

**Fuzzing**

- AFL (American Fuzzy Lop): automated input testing
- libFuzzer: coverage-guided fuzzing

### 2.7 CDAC Exam-Focused Points

**Key commands/functions**:

| Unsafe        | Safe           |
| ------------- | -------------- |
| `strcpy()`    | `strncpy()`    |
| `gets()`      | `fgets()`      |
| `sprintf()`   | `snprintf()`   |
| `scanf("%s")` | `scanf("%9s")` |

**Important concepts**:

- Stack canaries: detect overflow before return
- ASLR: randomize memory addresses
- DEP/NX: prevent code execution in data regions
- Whitelist vs. blacklist: prefer whitelisting
- Input validation layers: client + server

---

## 3. Access Control

### What Is Access Control?

Access Control is a security mechanism that determines what authenticated users can do within a system, including:

- What resources they can access (files, databases, APIs)
- What operations they can perform (read, write, execute, delete, modify)
- Under what conditions access is granted (time, location, device)

**Access Control Flow**:

```
1. Authentication (Who are you?)
   ↓
2. Authorization (What can you do?)
   ↓
3. Access Decision (Grant/Deny)
   ↓
4. Audit/Logging (What did you do?)
```

### Types of Access Control Models

### 1. Discretionary Access Control (DAC)

**Definition**: Access decisions are made by the resource owner (the user who created/owns the file).

**Key Characteristics**:

- Owner-controlled: users decide who accesses their resources.
- Flexible: easy to grant/revoke access.
- Less secure: users may accidentally grant excessive permissions.

**Example: Linux File Permissions**

```bash
# View permissions
ls -l file.txt
-rwxrwxr-x 1 user group 4096 Jul 5 10:00 file.txt

# Permission breakdown:
# Owner: rwx (read, write, execute)
# Group: rwx (read, write, execute)
# Others: r-x (read, execute)

# Change permissions
chmod 755 file.txt  # Owner: rwx, Group: r-x, Others: r-x
chmod u+x file.txt  # Add execute for owner
chmod o-r file.txt  # Remove read for others
```

**DAC Matrix Example**:

| Resource  | User A | User B | User C |
| --------- | ------ | ------ | ------ |
| file1.txt | RWX    | R      | -      |
| file2.txt | R      | RW     | -      |
| file3.txt | -      | -      | RWX    |

**Advantages**: simple to implement; user-friendly; flexible for small teams.
**Disadvantages**: security depends on user decisions; difficult to enforce organizational policies; prone to misconfiguration.
**Use Cases**: personal computers, small organizations, collaborative environments.

### 2. Mandatory Access Control (MAC)

**Definition**: Access is enforced by the operating system based on security labels and clearance levels.

**Key Characteristics**:

- System-controlled: users cannot override.
- Label-based: resources and users have security labels.
- Strict: centralized policy enforcement.

**Example: Military Classification**

| Clearance Level | Examples                    |
| --------------- | --------------------------- |
| Top Secret      | Nuclear codes, intelligence |
| Secret          | Defense plans               |
| Confidential    | Internal documents          |
| Unclassified    | Public information          |

**Access Rules**:

- No Read Up: users cannot read data above their clearance.
- No Write Down: users cannot write data to lower levels.

**Bell-LaPadula Model (Confidentiality)**:

```
Top Secret
    ↑
Secret
    ↑
Confidential
    ↑
Unclassified

Read: Only same or lower level
Write: Only same or higher level
```

**Linux MAC Implementations**:

_SELinux (Security-Enhanced Linux)_:

```bash
# Check SELinux status
sestatus

# View security context
ls -Z /etc/passwd

# Set context
chcon -t httpd_sys_content_t /var/www/html
```

_AppArmor_:

```bash
# Check status
aa-status

# Enable profile
aa-enforce /usr/bin/apache2
```

**Advantages**: highly secure; centralized control; prevents privilege escalation.
**Disadvantages**: complex configuration; requires expert administration; less flexible.
**Use Cases**: military/government systems, high-security environments, compliance-driven industries.

### 3. Role-Based Access Control (RBAC)

**Definition**: Permissions are assigned to roles, and users are assigned to roles.

**Key Characteristics**:

- Role-centric: not user-specific.
- Scalable: easy to manage large user bases.
- Policy-driven: based on job functions.

**RBAC Model**:

```
Users → Roles → Permissions → Resources
  ↓       ↓          ↓           ↓
Alice  Admin    Read/Write   Database
Bob    Editor   Read/Write   Documents
Carol  Viewer   Read         Reports
```

**Example**:

| Role     | Permissions         | Resources  |
| -------- | ------------------- | ---------- |
| Admin    | Read, Write, Delete | All        |
| Manager  | Read, Write         | Department |
| Employee | Read                | Own files  |
| Guest    | Read                | Public     |

**Implementation Example (SQL)**:

```sql
-- Create roles
CREATE ROLE admin;
CREATE ROLE editor;
CREATE ROLE viewer;

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO admin;
GRANT SELECT, INSERT, UPDATE ON articles TO editor;
GRANT SELECT ON reports TO viewer;

-- Assign roles to users
GRANT admin TO alice;
GRANT editor TO bob;
GRANT viewer TO carol;
```

**Advantages**: easy to manage; reduces administrative overhead; clear separation of duties; audit-friendly.
**Disadvantages**: role explosion (too many roles); inflexible for dynamic scenarios; requires careful role design.
**Use Cases**: enterprise applications, cloud services (AWS IAM, Azure RBAC), database management.

### 4. Attribute-Based Access Control (ABAC)

**Definition**: Access decisions are based on attributes of:

- **User** (role, department, clearance)
- **Resource** (type, sensitivity, owner)
- **Environment** (time, location, device)
- **Action** (read, write, delete)

**Key Characteristics**:

- Dynamic: context-aware decisions.
- Flexible: fine-grained control.
- Policy-driven: complex rules possible.

**Example Policy**:

```
IF user.department == "Finance"
   AND resource.type == "Invoice"
   AND environment.time BETWEEN 09:00-18:00
   AND environment.location == "Office Network"
THEN ALLOW read, write
ELSE DENY
```

This rule only grants a Finance department user access to invoice resources, and only during office hours from within the office network — combining user, resource, environment, and action attributes into a single access decision.

**Real-World Example**:
A hospital records system grants access to a patient file only if:

- **User attribute**: the requester's role is "Doctor" and their department is "Cardiology"
- **Resource attribute**: the file is tagged as a "Cardiology" record
- **Environment attribute**: the request comes during working hours (9 AM–6 PM) from a hospital-network device
- **Action attribute**: the requested action is "Read," not "Delete"

If a cardiologist tries to access the same file from home at midnight, access is denied — even though their role would normally qualify — because the environment attributes (time, location) don't satisfy the policy.

**Advantages**: highly flexible; context-aware; scales well; supports complex policies.
**Disadvantages**: complex to implement; performance overhead; requires policy management.
**Use Cases**: cloud environments, microservices, multi-tenant applications, IoT systems.

### Comparison Table: Access Control Models

| Feature     | DAC      | MAC      | RBAC       | ABAC                |
| ----------- | -------- | -------- | ---------- | ------------------- |
| Control     | Owner    | System   | Roles      | Attributes          |
| Flexibility | High     | Low      | Medium     | Very High           |
| Security    | Low      | High     | Medium     | High                |
| Complexity  | Low      | High     | Medium     | High                |
| Use Case    | Personal | Military | Enterprise | Cloud/Microservices |

### Common Access Control Vulnerabilities

**Broken Access Control**: users accessing things they shouldn't.

- Examples: forced browsing (guessing URLs); insecure IDOR (Insecure Direct Object Reference).

**Horizontal Privilege Escalation**: accessing peer-level resources (e.g., another user's account info).

**Vertical Privilege Escalation**: gaining higher-level access (e.g., a regular user becomes admin).

### Mitigation Techniques

- Implement server-side authorization checks.
- Follow the Principle of Least Privilege (PoLP).
- Use centralized access control logic.
- Log and monitor access control failures.
