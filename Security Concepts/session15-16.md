# Session 15 (2T + 2L): Sniffing

**Topics:** Protocols Susceptible to Sniffing | Active & Passive Sniffing | ARP Poisoning | Ethereal (Wireshark) Capture & Display Filters | MAC Flooding | DNS Spoofing Techniques | DNS Hacking | Sniffing Countermeasures

---

## 1. Protocols Susceptible to Sniffing

Sniffing attacks exploit **plaintext communication protocols**, where data is transmitted without encryption. Attackers capturing packets can directly read sensitive information such as usernames, passwords, and session data.

**Why Plaintext Protocols Are Vulnerable:**
- No encryption → data readable in packet payload
- No integrity protection → data can be modified
- No authentication → attacker can impersonate endpoints

**Common Vulnerable Protocols:**

| Protocol | Weakness |
|---|---|
| **HTTP** | Data sent in clear text (URLs, cookies, credentials); login forms can expose username/password in Wireshark |
| **FTP** | Sends credentials in plaintext during authentication; easily captured via packet sniffers |
| **Telnet** | Remote login protocol with no encryption; all keystrokes (including passwords) visible |
| **POP3 / IMAP** | Without SSL/TLS (POP3: port 110, IMAP: port 143), emails and credentials exposed |
| **DNS** | Queries unencrypted (UDP port 53); can reveal browsing habits, internal network structure |
| **SNMP v1/v2** | Community strings (like passwords) sent in plaintext; vulnerable to enumeration and network mapping |

**Secure Alternatives (Mitigation):**

| Insecure | Secure Replacement |
|---|---|
| HTTP | HTTPS (TLS encryption) |
| FTP | FTPS / SFTP |
| Telnet | SSH |
| POP3/IMAP | POP3S / IMAPS |
| SNMP v1/v2 | SNMP v3 (authentication + encryption) |
| DNS | DoH (DNS over HTTPS), DoT (DNS over TLS) |

**Example (Real-world):** Using Wireshark, filtering `http` reveals full HTTP requests; filtering `ftp` shows `USER` and `PASS` fields clearly.

---

## 2. Active vs Passive Sniffing

Sniffing techniques depend on network architecture and attacker involvement.

### Passive Sniffing
- Attacker **only listens**, does not modify traffic
- Works in: **hub-based networks** (broadcast domain), **wireless networks** (monitor mode)
- No packet injection → hard to detect

**Characteristics:** Silent and stealthy; no impact on network performance; limited to visible traffic only.

**Example:** Capturing Wi-Fi packets using tcpdump or Wireshark in monitor mode.

### Active Sniffing
- Attacker **manipulates traffic** to capture packets
- Required in **switched networks** (where traffic is unicast)

**Techniques Used:**
- ARP Poisoning (most common)
- MAC Flooding (overflow switch CAM table)
- DHCP Spoofing
- DNS Spoofing

**Characteristics:** Requires packet injection; detectable (abnormal ARP traffic, latency); enables MITM attacks.

**Example:** Tools like `ettercap`, `dsniff`, `arpspoof`.

---

## 3. ARP Poisoning (ARP Spoofing)

ARP maps **IP address → MAC address** within a LAN.

**How ARP Works Normally:**
1. Host A wants to send a packet to Host B.
2. It broadcasts: *"Who has IP X.X.X.X?"*
3. Host B replies: *"I am X.X.X.X, MAC = AA:BB:CC"*
4. Entry stored in ARP cache.

**The Attack:** The attacker sends **fake ARP replies** to victims:
- Victim thinks: Attacker's MAC = Default Gateway IP
- Gateway thinks: Attacker's MAC = Victim IP

This creates a **Man-in-the-Middle (MITM)** position.

**Attack Flow:**
```
1. Attacker sends spoofed ARP replies to victim and gateway
2. Both update ARP tables with attacker's MAC
3. Traffic flows through attacker
4. Attacker sniffs data / modifies packets / drops packets (DoS)
```

**Visualization:**
```
Victim → Attacker → Gateway
   (instead of direct communication)
```

**Impact:** Credential theft; session hijacking; traffic manipulation; injection attacks.

**Detection Methods:**
- ARP table inconsistencies (`arp -a`)
- Multiple IPs mapped to same MAC
- IDS alerts (Snort rules)
- Unusual ARP traffic spikes

**Prevention Techniques:**
- Static ARP entries (for critical devices)
- Dynamic ARP Inspection (DAI) on switches
- Port security (limit MAC addresses)
- Use of encrypted protocols (HTTPS, SSH)
- VPNs to protect traffic

**Example (Hands-on):**
```
arpspoof -i eth0 -t victim_ip gateway_ip
```
This tricks the victim into routing traffic via the attacker.

---

## 4. Ethereal (Wireshark) Capture and Display Filters

Wireshark (formerly **Ethereal**) is the most widely used packet analysis tool for network troubleshooting and security analysis. It offers two filtering mechanisms that serve different purposes.

### Capture Filters
Applied **before** packet capture begins — determine which packets get saved to the capture buffer.
- Use **Berkeley Packet Filter (BPF)** syntax
- Reduce file size and improve performance on high-traffic networks
- Cannot be changed once capture starts (must restart capture to modify)

**Common Examples:**
- `host 192.168.1.1` — capture only traffic to/from this IP
- `port 80` — capture only HTTP traffic
- `tcp` / `udp` — capture only TCP or UDP packets
- `net 192.168.1.0/24` — capture traffic from a subnet

### Display Filters
Applied **after** capture — control what's shown on screen without deleting captured data.
- Use **Wireshark's own filter syntax** (more flexible than BPF)
- Can be changed anytime without losing captured packets
- Support logical operators (`&&`, `||`, `!`) and field-based matching

**Common Examples:**
- `ip.addr == 192.168.1.1` — show packets to/from this IP
- `tcp.port == 80` — show HTTP traffic
- `http.request.method == "POST"` — show only POST requests
- `dns` — show only DNS packets
- `tcp.flags.syn == 1 && tcp.flags.ack == 0` — show SYN packets (connection attempts)

**Key Difference:**

| Aspect | Capture Filter | Display Filter |
|---|---|---|
| Timing | Before capture | After capture |
| Syntax | BPF | Wireshark filter language |
| Flexibility | Limited | Highly flexible |
| Effect | Discards unmatched packets | Hides unmatched packets (still saved) |

---

## 5. MAC Flooding

MAC flooding is an **active sniffing technique** that exploits how switches manage their MAC address table (CAM table).

**How Switches Normally Work:**
- Switch maintains a **CAM (Content Addressable Memory) table** mapping MAC addresses to physical ports.
- Table has limited size (varies by switch model).
- Switch forwards frames only to the port matching the destination MAC.

**The Attack:**
1. Attacker sends thousands of frames with **fake, randomized source MAC addresses**.
2. CAM table fills up rapidly and reaches capacity.
3. Switch enters **fail-open mode**.
4. Switch behaves like a **hub**, broadcasting all traffic to every port.

**Impact:** Attacker can now sniff traffic meant for other devices — defeats the traffic isolation benefit of switches, enabling passive sniffing on an otherwise switched network.

**Tools Used:** `macof` (part of dsniff suite), `Yersinia`.

**Example Command:**
```
macof -i eth0
```
This generates massive random MAC-source frames on the specified interface.

---

## 6. DNS Spoofing Techniques

DNS spoofing (or **DNS cache poisoning**) manipulates DNS resolution to redirect users to attacker-controlled destinations.

**How It Works:**
1. Attacker injects a **forged DNS response** into a resolver's cache or intercepts a request.
2. Victim's DNS query for a legitimate domain (e.g., `bank.com`) returns a **malicious IP**.
3. Victim unknowingly connects to a fake site that may look identical to the original.

**Methods of Execution:**
- Compromising a DNS server directly and altering records
- Intercepting DNS queries on the network (via ARP poisoning + fake DNS responses)
- Birthday attack exploiting DNS transaction ID prediction

**Consequences:** Phishing (fake login pages harvesting credentials); malware distribution; traffic redirection for surveillance.

**Example Scenario:** A user types `facebook.com`, but due to a poisoned DNS cache, the browser resolves it to an attacker's IP hosting a fake login page.

---

## 7. DNS Hacking

Broader category covering various attacks against DNS infrastructure and protocol weaknesses.

**Common Attack Types:**

- **DNS Spoofing/Cache Poisoning** — redirects users via false records (see above).

- **DNS Amplification Attacks**
  - Attacker sends small DNS queries with **spoofed source IP** (victim's address).
  - DNS servers respond with large replies directed at the victim.
  - Used to amplify traffic volume in **DDoS attacks**.
  - Exploits the size difference between DNS query and response.

- **Zone Transfer Attacks**
  - Exploits misconfigured DNS servers allowing **AXFR (zone transfer) requests** from unauthorized sources.
  - Attacker retrieves the entire DNS zone file, revealing all subdomains, internal server names, and network structure (useful for reconnaissance).

**Example Command (Zone Transfer):**
```
dig axfr @dns-server domain.com
```
If misconfigured, this dumps the entire zone.

**Goal of DNS Hacking:** Disrupt name resolution (availability attacks); manipulate resolution (redirect users); gather reconnaissance data (zone transfers).

---

## 8. Sniffing Countermeasures

A layered defense strategy is required since sniffing exploits multiple weaknesses (protocol, switch, ARP, DNS).

**Encryption-Based Defenses:**
- **HTTPS** — encrypts web traffic (TLS)
- **SSH** — secure remote access, replaces Telnet
- **FTPS** — encrypted file transfer
- **VPNs** — encrypt all traffic between endpoints, protecting against network-level sniffing

**Network Configuration Defenses:**
- **Static ARP Entries** — manually map critical IP-MAC pairs to prevent ARP poisoning (best for servers, gateways)
- **Port Security** — limits number of MAC addresses learned per switch port, preventing MAC flooding
- **Dynamic ARP Inspection (DAI)** — validates ARP packets against DHCP snooping database
- **Network Segmentation** — VLANs isolate sensitive traffic, reducing attack surface and broadcast domains

**Detection Defenses:**
- **IDS/IPS** — monitors for abnormal ARP traffic (gratuitous ARP floods), MAC flooding patterns, suspicious DNS response anomalies

**DNS-Specific Defense:**
- **DNSSEC (DNS Security Extensions)** — adds cryptographic signatures to DNS records, allowing resolvers to verify authenticity of responses, preventing cache poisoning and spoofing

**Operational Defenses:**
- Regular patching of switches, routers, and DNS servers to fix known vulnerabilities
- Strong authentication/authorization — reduces impact even if traffic is captured (e.g., MFA prevents credential reuse)

**Quick Reference Table:**

| Threat | Countermeasure |
|---|---|
| Plaintext sniffing | HTTPS, SSH, FTPS, VPN |
| ARP poisoning | Static ARP, DAI |
| MAC flooding | Port security |
| DNS spoofing | DNSSEC |
| General detection | IDS/IPS |
| Unpatched exploits | Regular updates |

---
---

# Session 16 (2T + 2L): DoS/DDoS & Session Hijacking

**Topics:** Types of DoS Attacks | How DDoS Attacks Work | How Bots/Botnets Work | Smurf Attacks | SYN Flooding | Spoofing vs Hijacking | Types of Session Hijacking | Steps to Perform Session Hijacking | Prevention

---

## 1. Types of DoS Attacks

A **Denial of Service (DoS)** attack aims to make a system, network, or service unavailable to legitimate users by overwhelming it or exploiting weaknesses.

### 1. Flood Attacks
Overwhelm the target with massive traffic, exhausting bandwidth, CPU, or memory resources.

| Type | Mechanism |
|---|---|
| **SYN Flood** | Exploits TCP 3-way handshake; attacker sends many SYN packets with spoofed IPs; server allocates resources but never receives the final ACK, resulting in half-open connections exhausting server capacity. Flow: `SYN → SYN-ACK → (no ACK)` |
| **UDP Flood** | Sends large volumes of UDP packets to random ports; target responds with ICMP "port unreachable" messages, consuming bandwidth and CPU |
| **ICMP Flood (Ping Flood)** | Massive ICMP Echo Requests sent to target, overloading network bandwidth and processing |

**Impact:** Network congestion; high CPU/memory usage; service slowdown or crash.

### 2. Crash Attacks
Exploit **software vulnerabilities** to cause system failure.
- Use malformed or unexpected input packets targeting OS or application bugs.
- Examples: sending invalid TCP flag combinations; buffer overflow via malformed packets.
- **Impact:** System reboot or freeze; service termination.

### 3. Logic Attacks
Exploit **protocol design flaws or improper packet handling**.

| Attack | Description |
|---|---|
| **Ping of Death** | Sends oversized ICMP packets (> 65535 bytes), causing buffer overflow in older systems |
| **Teardrop Attack** | Sends fragmented packets with overlapping offsets; target cannot reassemble correctly → crash |

**Impact:** System instability; kernel crashes (in older/unpatched systems).

### 4. Amplification Attacks
Multiply attack traffic using third-party servers.

**Working Principle:** Attacker sends a small request with a **spoofed victim IP**; the third-party server sends a large response to the victim, amplifying traffic significantly.

**Common Types:** DNS Amplification (small query → large DNS response), NTP Amplification (uses `monlist` command on older NTP servers), SSDP Amplification.

**Amplification Factor:**
```
Amplification = Response Size / Request Size
```

**Impact:** Massive traffic surge; difficult to trace attacker (IP spoofing).

---

## 2. How DDoS Attacks Work

A **Distributed Denial of Service (DDoS)** attack is an advanced form of DoS where multiple systems attack a single target simultaneously.

**Architecture — Key Components:**
- Attacker (Master Controller)
- Botnet (Zombie Machines)
- Command and Control (C&C) Server
- Target (Victim Server)

**Step-by-Step Working:**
```
1. Infection      → Attacker spreads malware (trojans, worms); devices compromised (PCs, servers, IoT)
2. Botnet Formation → Infected devices connect to a C&C server (IRC, HTTP/HTTPS, or P2P)
3. Command Execution → Attacker sends commands via C&C; bots prepare to launch attack
4. Attack Launch   → All bots simultaneously send requests/traffic to victim (HTTP flood, SYN flood, UDP flood)
5. Resource Exhaustion → Bandwidth saturation, server resource depletion, application crash
```

**Why DDoS Is Hard to Defend:**
- Traffic comes from multiple IP addresses globally.
- Difficult to distinguish between legitimate and malicious users.
- Attack traffic mimics real user behavior (especially Layer 7 attacks).
- High scale (can reach Tbps-level attacks).

**Real-World Example — Mirai Botnet (2016):** Infected IoT devices (cameras, routers) and launched massive DDoS attacks on DNS provider Dyn, taking down services like Twitter, Netflix, and GitHub.

**Types of DDoS Based on Layer:**

| Category | Example | Target |
|---|---|---|
| Volume-Based Attacks | UDP flood | Bandwidth exhaustion |
| Protocol Attacks | SYN flood | Server resources |
| Application Layer Attacks (Layer 7) | HTTP GET/POST flood | Web server/application |

**Basic Mitigation Strategies:** Traffic filtering (ACLs, firewalls); rate limiting; load balancers; CDN (Cloudflare, Akamai); anti-DDoS services; Anycast routing; behavior-based detection.

---

## 3. How Bots and Botnets Work

### Bots
A **bot** (short for robot) is a compromised system infected with malware that allows remote control by an attacker.
- Can run silently in the background.
- Often part of large-scale coordinated attacks.
- Common infection vectors: phishing emails, malicious downloads, unpatched vulnerabilities.

### Botnets
A **botnet** is a network of multiple infected devices (bots) controlled centrally or in a distributed manner.

**Architecture Components:**
- **Botmaster (Attacker):** Controls the botnet
- **Bots (Zombies):** Infected machines executing commands
- **Command and Control (C&C):** Communication channel between attacker and bots

**Communication Models:**

| Model | Description |
|---|---|
| **Centralized** | Uses a single C&C server; protocols: IRC, HTTP/HTTPS; easy to manage but vulnerable to takedown |
| **Peer-to-Peer (P2P)** | No central server; bots communicate with each other; harder to detect and shut down |

**Botnet Lifecycle:**
```
1. Infection    → Malware spreads via phishing, exploit kits, or drive-by downloads
2. Propagation  → Bot scans and infects other systems
3. Connection   → Bot connects to C&C infrastructure
4. Execution    → Attacker sends commands to perform tasks
```

**Uses of Botnets:** DDoS attacks (most common); spam campaigns; credential theft/keylogging; cryptocurrency mining; data exfiltration.

**Example — Mirai Botnet:** Targeted IoT devices (default credentials) and created massive DDoS attacks using thousands of devices.

---

## 4. Smurf Attack

A **Smurf attack** is a type of **amplification-based ICMP flood attack**.

**Working Mechanism:**
1. Attacker sends an ICMP Echo Request (ping) to a **broadcast address**.
2. Source IP is **spoofed as the victim's IP**.
3. All devices in the network respond with an Echo Reply.
4. Victim receives a flood of replies.

**Amplification Effect:** If a network has *N* devices, one request generates *N* replies — the amplified traffic overloads the victim.

**Diagram Concept:**
```
Attacker → Broadcast Address → Multiple Hosts → Victim
```

**Impact:** Network congestion; bandwidth exhaustion; system slowdown or crash.

**Prevention Techniques:**
- Disable IP-directed broadcast on routers
- Configure systems to not respond to broadcast pings
- Use firewalls to filter ICMP traffic
- Implement ingress filtering to prevent IP spoofing

---

## 5. SYN Flooding

A **SYN flood** is a protocol-based DoS attack exploiting TCP connection establishment.

**TCP 3-Way Handshake:**
```
SYN → SYN-ACK → ACK
```

**Attack Process:**
1. Attacker sends a large number of **SYN requests**.
2. Server responds with **SYN-ACK**.
3. Attacker does **not send ACK**.
4. Server keeps the connection in a **half-open state**.

**Result:** Connection queue fills up; legitimate users cannot connect; server resources exhausted.

**Key Concept — Half-Open Connections:** Each incomplete handshake consumes memory and processing; the limited backlog queue is easily exhausted.

**Countermeasures:**

| Technique | Description |
|---|---|
| **SYN Cookies** | Do not allocate resources until handshake completes; encode connection info in SYN-ACK |
| **Connection Timeout Reduction** | Drop half-open connections faster |
| **Rate Limiting** | Limit number of SYN requests per IP |
| **Firewall Filtering** | Detect abnormal SYN patterns |
| **Load Balancers / Reverse Proxies** | Absorb attack traffic |

**Example (Detection in Wireshark):**
```
tcp.flags.syn == 1 && tcp.flags.ack == 0
```
Shows excessive SYN packets (possible attack indicator).

---

## 6. Spoofing vs Hijacking

Two distinct but related attack techniques used in network security.

### Spoofing
Spoofing is **impersonation**, where an attacker falsifies identity information.

**Types:** IP Spoofing (fake source IP), MAC Spoofing (fake MAC address), DNS Spoofing (fake DNS responses), Email Spoofing (forged sender address).

**Purpose:** Bypass authentication; launch anonymous attacks; redirect traffic.

### Hijacking
Hijacking is **taking over an active session** between two legitimate parties.

**Types:** Session Hijacking (stealing session cookies), TCP Hijacking (injecting malicious packets into a session), HTTP Session Hijacking (using stolen tokens to impersonate a user).

**Key Differences:**

| Aspect | Spoofing | Hijacking |
|---|---|---|
| Nature | Impersonation | Session takeover |
| Timing | Before/at connection setup | After session established |
| Goal | Trick system identity | Gain unauthorized control |
| Example | Fake IP in packets | Stealing login session cookie |

**Example Scenario:**
- **Spoofing:** Attacker sends a packet pretending to be a trusted server.
- **Hijacking:** Attacker steals a session cookie and logs in as the user without a password.

**Prevention:**
- **Spoofing Defense:** Ingress/egress filtering; authentication mechanisms; packet validation.
- **Hijacking Defense:** Use HTTPS (encrypted sessions); secure cookies (HttpOnly, Secure flags); session timeout; multi-factor authentication.

---

## 7. Types of Session Hijacking

Session hijacking involves **taking control of a valid user session** to gain unauthorized access without needing credentials.

| Type | Description | Impact |
|---|---|---|
| **Active Session Hijacking** | Attacker directly takes over the session and interacts with the server; disrupts/terminates the legitimate user's connection; sends packets to the server pretending to be the victim; often involves TCP sequence number prediction or injection | Full control over user session; ability to perform actions as the user |
| **Passive Session Hijacking** | Attacker only monitors the session without modifying it; captures session data (cookies, tokens); does not interfere with communication; hard to detect. Example: using Wireshark to capture session cookies over HTTP | Later reuse of session credentials; silent data theft |
| **Man-in-the-Middle (MITM) Attack** | Attacker positions themselves between client and server, intercepting all communication; can read and modify traffic; often achieved using ARP poisoning or DNS spoofing | Steal session tokens; modify requests/responses; inject malicious content |
| **Cross-Site Scripting (XSS)** | A web application vulnerability used to hijack sessions; attacker injects malicious JavaScript into a web page; script executes in victim's browser and steals session cookies (e.g., via `document.cookie`) | Attacker gains session token → impersonates user |

---

## 8. Steps to Perform Session Hijacking

Session hijacking is typically a **multi-stage process**:

1. **Session Identification** — Identify active sessions and their identifiers by monitoring traffic or analyzing cookies/URLs.

2. **Session Prediction** — Attempt to guess session IDs, possible if session tokens are weak or predictable / poorly randomized. Techniques: brute force, pattern analysis.

3. **Session Fixation** — Attacker sets a known session ID before login, tricking the victim into using that session. Example: sending a crafted URL with a session ID (`http://example.com/login?sessionid=12345`); victim logs in → attacker reuses the same session.

4. **Session Sniffing** — Capture session tokens via network sniffing; works if traffic is unencrypted (HTTP) or the network is compromised (MITM).

5. **Session Injection** — Attacker inserts malicious packets into an existing session, often used in TCP hijacking; results in commands executed as the legitimate user.

---

## 9. Prevention of Session Hijacking

Effective defense requires **secure session management + network protection**.

| # | Measure | Details |
|---|---|---|
| 1 | **Encrypted Communication** | Enforce HTTPS (TLS) for all sessions to prevent sniffing of cookies and tokens |
| 2 | **Strong Session Management** | Use long, random, unpredictable session IDs; avoid sequential or guessable tokens |
| 3 | **Cookie Security** | `HttpOnly` flag prevents JavaScript access to cookies (protects from XSS); `Secure` flag ensures cookies are sent only over HTTPS |
| 4 | **Session Timeout & Re-authentication** | Automatically expire sessions after inactivity; require re-login for sensitive actions |
| 5 | **Binding Session to Client Attributes** | Validate IP address and User-Agent; prevent reuse from different environments |
| 6 | **Protection Against XSS** | Input validation and sanitization; output encoding; Content Security Policy (CSP) |
| 7 | **Intrusion Detection Systems (IDS)** | Detect anomalies such as multiple session reuse, suspicious IP changes, unusual traffic patterns |
| 8 | **Additional Best Practices** | Regenerate session IDs after login; use MFA; avoid session IDs in URLs; implement secure logout (invalidate session on server) |

**Example (Real-world Scenario):** A user logs into a website over HTTP; an attacker captures the cookie using packet sniffing, then uses that cookie in a browser to gain access without a password.
