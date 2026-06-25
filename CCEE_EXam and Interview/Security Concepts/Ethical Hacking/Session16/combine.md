# DoS, DDoS, Botnets, Spoofing & Session Hijacking – Complete Notes

---

# 1. Denial of Service (DoS) Attack

## Definition

A **Denial of Service (DoS)** attack attempts to make a system, server, application, or network unavailable to legitimate users by exhausting its resources.

### Goal

* Disrupt services
* Slow down systems
* Crash servers
* Prevent legitimate access

---

## Characteristics

| Feature             | Description                               |
| ------------------- | ----------------------------------------- |
| Single Source       | Usually launched from one machine         |
| Resource Exhaustion | CPU, RAM, bandwidth exhausted             |
| Service Disruption  | Website becomes unavailable               |
| Temporary Attack    | Stops when attacker stops sending traffic |

---

## Types of DoS Attacks

### 1. Volume-Based Attacks

Consume bandwidth.

Examples:

* UDP Flood
* ICMP Flood
* Smurf Attack

---

### 2. Protocol Attacks

Exploit protocol weaknesses.

Examples:

* SYN Flood
* Ping of Death
* Fragmentation Attacks

---

### 3. Application Layer Attacks

Target applications.

Examples:

* HTTP GET Flood
* HTTP POST Flood
* Slowloris

---

# 2. Distributed Denial of Service (DDoS)

## Definition

A **DDoS attack** uses multiple compromised systems to attack a target simultaneously.

---

## Difference Between DoS and DDoS

| DoS               | DDoS                |
| ----------------- | ------------------- |
| Single attacker   | Multiple attackers  |
| Easier to detect  | Difficult to detect |
| Less traffic      | Massive traffic     |
| Easier mitigation | Hard mitigation     |

---

## How DDoS Works

### Step 1

Attacker infects devices.

↓

### Step 2

Devices become zombies/bots.

↓

### Step 3

Bots join Botnet.

↓

### Step 4

Attacker sends command.

↓

### Step 5

All bots attack target.

↓

### Step 6

Server becomes unavailable.

---

## Effects

* Website crash
* Revenue loss
* Reputation damage
* Service interruption

---

# 3. BOTs and BOTNETs

## BOT

A BOT is a compromised device controlled remotely.

Examples:

* Computer
* Smartphone
* IoT Device
* CCTV Camera
* Router

---

## BOTNET

A collection of bots controlled by attacker.

### Structure

```
Attacker
    |
Command & Control Server
    |
------------------------
|     |      |        |
Bot1 Bot2  Bot3    Bot4
```

---

## Botnet Components

### 1. Botmaster

Controls botnet.

### 2. C&C Server

Command and Control server.

### 3. Bots

Compromised devices.

---

## Botnet Activities

* DDoS attacks
* Spam emails
* Malware distribution
* Cryptocurrency mining
* Credential theft

---

## Famous Botnets

### Mirai Botnet

Target:

* IoT devices

Impact:

* Massive DDoS attacks

---

### Zeus Botnet

Target:

* Banking credentials

---

### Emotet

Target:

* Malware delivery

---

# 4. Smurf Attack

## Definition

A Smurf Attack is an ICMP-based DDoS attack.

Attacker sends spoofed ICMP Echo Requests to a broadcast address.

---

## Working

### Step 1

Attacker spoofs victim IP.

```
Source IP = Victim
```

---

### Step 2

ICMP Echo Request sent to broadcast network.

```
192.168.1.255
```

---

### Step 3

All hosts reply.

---

### Step 4

Victim receives huge number of replies.

---

### Result

Bandwidth exhaustion.

---

## Diagram

```
Attacker
   |
Broadcast Network
   |
------------------
|  |  |  |  |  |
Hosts send replies
   |
 Victim
```

---

## Prevention

* Disable IP-directed broadcast
* Filter ICMP traffic
* Router ACLs
* Firewalls

---

# 5. SYN Flood Attack

## TCP Three-Way Handshake

Normal Connection

```
Client ------ SYN ------> Server

Client <---- SYN-ACK ---- Server

Client ------ ACK ------> Server
```

Connection established.

---

## SYN Flood

Attacker sends many SYN packets.

```
SYN
SYN
SYN
SYN
SYN
```

But never completes handshake.

---

## Result

Server stores half-open connections.

Queue becomes full.

Legitimate users cannot connect.

---

## Diagram

```
Attacker ---- SYN ----> Server

Server <--- SYN ACK ---

(No ACK returned)

Half-open connection remains.
```

---

## Prevention

### SYN Cookies

Server delays resource allocation.

### Rate Limiting

Limit requests.

### Firewalls

Filter suspicious traffic.

### Load Balancers

Distribute traffic.

---

# 6. Spoofing vs Hijacking

| Spoofing         | Hijacking                      |
| ---------------- | ------------------------------ |
| Impersonation    | Taking over                    |
| Fake identity    | Existing session stolen        |
| Before access    | After access                   |
| Fake packets     | Session theft                  |
| Example: Fake IP | Example: Stolen session cookie |

---

## Spoofing Types

### IP Spoofing

Fake source IP.

---

### ARP Spoofing

Fake ARP responses.

---

### DNS Spoofing

Redirects users to malicious websites.

---

### Email Spoofing

Fake sender address.

---

# 7. Session Hijacking

## Definition

Session hijacking is taking control of a valid user session.

Attacker steals session identifier and impersonates victim.

---

## Session Example

User logs in.

Server creates:

```
Session ID = ABC123XYZ
```

Browser stores cookie.

```
Cookie:
SESSIONID=ABC123XYZ
```

If attacker steals it:

```
Attacker uses same cookie.
```

Server believes attacker is legitimate user.

---

# Types of Session Hijacking

---

## 1. Active Session Hijacking

Attacker actively takes over session.

Example:

* TCP Session Hijacking

---

## 2. Passive Session Hijacking

Attacker only monitors traffic.

Example:

* Packet sniffing

---

## 3. TCP Session Hijacking

Attacker predicts TCP sequence numbers.

Injects malicious packets.

---

## 4. Cookie Hijacking

Steals browser cookies.

Most common.

---

## 5. Cross-Site Scripting (XSS) Hijacking

Steals session cookies using JavaScript.

Example:

```html
<script>
document.cookie
</script>
```

---

## 6. Man-in-the-Middle (MITM)

Attacker sits between victim and server.

Captures session tokens.

---

# Steps of Session Hijacking

---

## Method 1: Packet Sniffing

### Step 1

Attacker joins same network.

### Step 2

Captures packets.

### Step 3

Finds session cookie.

### Step 4

Uses cookie.

### Step 5

Session compromised.

---

## Method 2: XSS-Based

### Step 1

Inject malicious script.

### Step 2

Victim loads page.

### Step 3

Cookie stolen.

### Step 4

Attacker reuses session.

---

## Method 3: MITM

### Step 1

Intercept traffic.

### Step 2

Capture session token.

### Step 3

Replay token.

### Step 4

Gain access.

---

# Session Hijacking Lifecycle

```
User Login
    |
Session Created
    |
Cookie Issued
    |
Cookie Stolen
    |
Attacker Reuses Cookie
    |
Account Access
```

---

# Prevention of Session Hijacking

---

## 1. HTTPS Everywhere

Encrypts traffic.

Prevents sniffing.

---

## 2. Secure Cookies

```
Secure Flag
```

Only transmitted over HTTPS.

---

## 3. HttpOnly Cookies

```
HttpOnly
```

Prevents JavaScript access.

Helps against XSS.

---

## 4. Session Timeout

Automatically expires session.

Example:

* 10 minutes inactivity

---

## 5. Session Regeneration

Generate new session after login.

---

## 6. Multi-Factor Authentication (MFA)

Additional verification.

---

## 7. Strong Random Session IDs

Difficult to predict.

---

## 8. XSS Protection

Input validation.

Output encoding.

Content Security Policy (CSP).

---

## 9. IDS/IPS

Detect suspicious activity.

---

## 10. VPN Usage

Protects public Wi-Fi users.

---

# Lab Concepts (Theory)

### Detect SYN Flood

Tools:

* Wireshark
* tcpdump

Indicators:

* Large number of SYN packets
* Few ACK packets

---

### Detect Smurf Attack

Indicators:

* High ICMP traffic
* Broadcast requests

---

### Detect Session Hijacking

Indicators:

* Same session from multiple IPs
* Sudden IP changes
* Unusual login locations

---

# Important Exam Points

### Remember

**DoS = One Attacker**

**DDoS = Many Attackers**

---

**BOT = Infected Device**

**BOTNET = Collection of Bots**

---

**Smurf Attack = ICMP + Broadcast**

---

**SYN Flood = Half-open TCP Connections**

---

**Spoofing = Fake Identity**

---

**Hijacking = Session Takeover**

---

**HTTPS helps prevent session theft.**

---

**HttpOnly protects cookies from JavaScript.**

---

**Secure Cookie works only over HTTPS.**

---

# Quick Revision Table

| Attack            | Protocol |
| ----------------- | -------- |
| Smurf             | ICMP     |
| Ping Flood        | ICMP     |
| SYN Flood         | TCP      |
| HTTP Flood        | HTTP     |
| DNS Amplification | UDP      |
| Session Hijacking | HTTP/TCP |

---

# Memory Tricks

### Smurf Attack

**S = Spoofed IP**

**M = Many Hosts Reply**

**U = Unwanted Traffic**

**R = Replies Flood Victim**

**F = Flooding**

---

### SYN Flood

**SYN Sent**

**No ACK**

**Queue Full**

**Service Down**

---

### Session Hijacking

**Steal → Replay → Access**

---

# 30 MCQs

### 1. DoS attack is launched from:

A) Multiple devices
B) Single device
C) Router
D) Firewall

**Answer: B**

---

### 2. DDoS stands for:

A) Dynamic DOS
B) Distributed Denial of Service
C) Data DOS
D) Dual DOS

**Answer: B**

---

### 3. A compromised device is called:

A) Firewall
B) Router
C) Bot
D) IDS

**Answer: C**

---

### 4. Collection of bots is:

A) Worm
B) Trojan
C) Botnet
D) VPN

**Answer: C**

---

### 5. Smurf attack uses:

A) TCP
B) UDP
C) ICMP
D) FTP

**Answer: C**

---

### 6. SYN Flood exploits:

A) DNS
B) ARP
C) TCP Handshake
D) SMTP

**Answer: C**

---

### 7. TCP handshake contains:

A) SYN ACK ACK
B) SYN SYN ACK
C) ACK ACK SYN
D) FIN ACK ACK

**Answer: A**

---

### 8. SYN flood creates:

A) Closed connections
B) Half-open connections
C) VPN tunnels
D) ARP entries

**Answer: B**

---

### 9. IP Spoofing means:

A) Fake IP address
B) Fake DNS
C) Fake Cookie
D) Fake Password

**Answer: A**

---

### 10. Session hijacking steals:

A) MAC address
B) Session token
C) DNS record
D) Routing table

**Answer: B**

---

### 11-30 Important Answers

11. Cookie Hijacking → Session Cookie
12. HTTPS → Encrypts Traffic
13. HttpOnly → Protects Cookies
14. Secure Flag → HTTPS Only
15. MITM → Intercepts Communication
16. XSS → Cookie Theft
17. Mirai → IoT Botnet
18. Zeus → Banking Malware
19. SYN Cookie → Flood Protection
20. ICMP Echo → Ping
21. Broadcast Address → Smurf Attack
22. DDoS → Multiple Sources
23. IDS → Detection
24. IPS → Prevention
25. MFA → Additional Security
26. Session Timeout → Reduces Risk
27. TCP Hijacking → Sequence Numbers
28. Packet Sniffing → Passive Attack
29. Spoofing → Impersonation
30. Hijacking → Session Takeover

# Last-Minute Exam Formula Sheet

* **DoS = Single Source Attack**
* **DDoS = Multiple Sources Attack**
* **Botnet = Bots + C&C Server**
* **Smurf = ICMP + Broadcast + Spoofed IP**
* **SYN Flood = TCP Half-Open Connections**
* **Spoofing = Fake Identity**
* **Hijacking = Taking Over Existing Session**
* **HTTPS + Secure + HttpOnly + MFA = Best Protection Against Session Hijacking**

# 100 MCQs – DoS, DDoS, Botnets, Smurf Attack, SYN Flooding, Spoofing & Session Hijacking

## 1. Denial of Service (DoS)

### 1.

What is the primary goal of a DoS attack?

A. Data Encryption
B. Service Disruption
C. Data Compression
D. Authentication

**Answer: B**

---

### 2.

A DoS attack is generally launched from:

A. Multiple systems
B. Single system
C. Cloud server only
D. Router only

**Answer: B**

---

### 3.

Which resource is commonly exhausted during a DoS attack?

A. CPU
B. Memory
C. Bandwidth
D. All of the Above

**Answer: D**

---

### 4.

Which is NOT a DoS attack category?

A. Volume-Based
B. Protocol-Based
C. Application Layer
D. Encryption Layer

**Answer: D**

---

### 5.

A successful DoS attack causes:

A. Increased performance
B. Service unavailability
C. Better security
D. Data backup

**Answer: B**

---

### 6.

Which attack targets server bandwidth?

A. Volume-Based Attack
B. SQL Injection
C. XSS
D. CSRF

**Answer: A**

---

### 7.

Application layer attacks target:

A. Routers
B. Firewalls
C. Applications
D. Switches

**Answer: C**

---

### 8.

Which is an example of an application layer attack?

A. HTTP Flood
B. SYN Flood
C. Smurf
D. ARP Spoofing

**Answer: A**

---

### 9.

Which attack focuses on exhausting server resources?

A. DoS
B. VPN
C. SSL
D. IDS

**Answer: A**

---

### 10.

DoS attacks mainly affect:

A. Availability
B. Confidentiality
C. Integrity
D. Non-repudiation

**Answer: A**

---

# 2. DDoS Attacks

### 11.

DDoS stands for:

A. Dynamic Denial of Service
B. Distributed Denial of Service
C. Digital Denial of Service
D. Distributed Data Service

**Answer: B**

---

### 12.

A DDoS attack originates from:

A. One machine
B. Multiple machines
C. One router
D. One switch

**Answer: B**

---

### 13.

Which attack is harder to mitigate?

A. DoS
B. DDoS
C. Ping
D. FTP

**Answer: B**

---

### 14.

DDoS attacks usually involve:

A. Firewalls
B. Botnets
C. VPNs
D. IDS

**Answer: B**

---

### 15.

A DDoS attack can cause:

A. Website outage
B. Financial loss
C. Reputation damage
D. All of the Above

**Answer: D**

---

### 16.

What controls a botnet?

A. Victim
B. ISP
C. Botmaster
D. Router

**Answer: C**

---

### 17.

DDoS attacks primarily target:

A. Availability
B. Integrity
C. Authentication
D. Authorization

**Answer: A**

---

### 18.

Which device can become a bot?

A. Computer
B. Router
C. IoT Device
D. All of the Above

**Answer: D**

---

### 19.

The command center of a botnet is called:

A. VPN
B. IDS
C. C&C Server
D. Gateway

**Answer: C**

---

### 20.

DDoS attacks generate:

A. Small traffic
B. Huge traffic
C. No traffic
D. Encrypted traffic only

**Answer: B**

---

# 3. Bots and Botnets

### 21.

A bot is:

A. Security tool
B. Compromised device
C. Firewall
D. Antivirus

**Answer: B**

---

### 22.

A botnet is:

A. Group of firewalls
B. Group of infected devices
C. Group of switches
D. Group of VPNs

**Answer: B**

---

### 23.

Mirai Botnet mainly targeted:

A. Databases
B. IoT Devices
C. Printers
D. Emails

**Answer: B**

---

### 24.

Zeus Botnet was famous for:

A. Banking credential theft
B. DNS attacks
C. ARP attacks
D. Spam filtering

**Answer: A**

---

### 25.

Bots are also known as:

A. Zombies
B. Switches
C. IDS
D. VPNs

**Answer: A**

---

### 26.

Which activity is performed by botnets?

A. DDoS
B. Spam
C. Malware Distribution
D. All of the Above

**Answer: D**

---

### 27.

Botnets are remotely controlled through:

A. DNS
B. C&C Server
C. FTP
D. SMTP

**Answer: B**

---

### 28.

A compromised IoT camera may become:

A. Firewall
B. Bot
C. IDS
D. Proxy

**Answer: B**

---

### 29.

The attacker controlling bots is called:

A. User
B. Administrator
C. Botmaster
D. Auditor

**Answer: C**

---

### 30.

Botnets increase attack:

A. Scalability
B. Detection
C. Encryption
D. Logging

**Answer: A**

---

# 4. Smurf Attack

### 31.

Smurf Attack is based on:

A. ICMP
B. FTP
C. SMTP
D. SSH

**Answer: A**

---

### 32.

Smurf Attack uses:

A. Echo Request
B. DNS Query
C. HTTP Request
D. SYN Packet

**Answer: A**

---

### 33.

The victim's IP address is:

A. Hidden
B. Spoofed
C. Encrypted
D. Deleted

**Answer: B**

---

### 34.

Smurf Attack exploits:

A. Broadcast addresses
B. Cookies
C. Sessions
D. DNS

**Answer: A**

---

### 35.

The attack floods the victim with:

A. SYN packets
B. ICMP replies
C. Cookies
D. DNS records

**Answer: B**

---

### 36.

Smurf Attack is categorized as:

A. Amplification Attack
B. XSS
C. CSRF
D. SQLi

**Answer: A**

---

### 37.

The protocol used is:

A. UDP
B. ICMP
C. SMTP
D. FTP

**Answer: B**

---

### 38.

A prevention technique is:

A. Disable Directed Broadcast
B. Enable Telnet
C. Enable Anonymous FTP
D. Disable Firewall

**Answer: A**

---

### 39.

Smurf attack primarily consumes:

A. Bandwidth
B. Passwords
C. Cookies
D. RAM only

**Answer: A**

---

### 40.

Smurf attacks are usually:

A. DDoS-like
B. Encryption attacks
C. Authentication attacks
D. Access control attacks

**Answer: A**

---

# 5. SYN Flood

### 41.

SYN Flood targets:

A. TCP
B. UDP
C. ICMP
D. DNS

**Answer: A**

---

### 42.

TCP uses:

A. 2-way handshake
B. 3-way handshake
C. 4-way handshake
D. 5-way handshake

**Answer: B**

---

### 43.

First packet in TCP handshake:

A. ACK
B. FIN
C. SYN
D. RST

**Answer: C**

---

### 44.

Second packet:

A. ACK
B. SYN-ACK
C. FIN
D. RST

**Answer: B**

---

### 45.

Third packet:

A. ACK
B. SYN
C. FIN
D. RST

**Answer: A**

---

### 46.

In SYN Flood, attacker never sends:

A. SYN
B. ACK
C. SYN-ACK
D. FIN

**Answer: B**

---

### 47.

Result of SYN Flood:

A. Full-open connections
B. Half-open connections
C. VPN connection
D. DNS cache

**Answer: B**

---

### 48.

The server queue becomes:

A. Empty
B. Full
C. Secure
D. Encrypted

**Answer: B**

---

### 49.

SYN Cookies help prevent:

A. SQLi
B. SYN Flood
C. XSS
D. CSRF

**Answer: B**

---

### 50.

SYN Flood is a:

A. Protocol Attack
B. Password Attack
C. Malware Attack
D. DNS Attack

**Answer: A**

---

# 6. Spoofing

### 51.

Spoofing means:

A. Taking over session
B. Impersonating identity
C. Encrypting data
D. Hashing passwords

**Answer: B**

---

### 52.

IP Spoofing uses:

A. Fake IP
B. Fake Password
C. Fake DNS
D. Fake Cookie

**Answer: A**

---

### 53.

ARP Spoofing affects:

A. Network Layer
B. Data Link Layer
C. Application Layer
D. Session Layer

**Answer: B**

---

### 54.

DNS Spoofing redirects users to:

A. Legitimate websites
B. Malicious websites
C. VPNs
D. Firewalls

**Answer: B**

---

### 55.

Email Spoofing uses:

A. Fake sender address
B. Fake router
C. Fake switch
D. Fake firewall

**Answer: A**

---

### 56.

Spoofing is usually performed:

A. Before gaining access
B. After encryption
C. During backup
D. During updates

**Answer: A**

---

### 57.

Spoofing mainly focuses on:

A. Trust Exploitation
B. Compression
C. Encryption
D. Logging

**Answer: A**

---

### 58.

ARP Spoofing may enable:

A. MITM
B. VPN
C. IDS
D. Firewall

**Answer: A**

---

### 59.

Which is NOT spoofing?

A. DNS Spoofing
B. IP Spoofing
C. Cookie Hijacking
D. Email Spoofing

**Answer: C**

---

### 60.

Spoofing often precedes:

A. Hijacking
B. Backup
C. Compression
D. Hashing

**Answer: A**

---

# 7. Session Hijacking

### 61.

Session Hijacking means:

A. Taking over valid session
B. Encrypting session
C. Compressing session
D. Deleting session

**Answer: A**

---

### 62.

Most web sessions are identified using:

A. Session ID
B. MAC Address
C. DNS Record
D. IP only

**Answer: A**

---

### 63.

Session IDs are commonly stored in:

A. Cookies
B. BIOS
C. Firewall
D. Switch

**Answer: A**

---

### 64.

Cookie Hijacking steals:

A. Session Cookie
B. DNS Entry
C. ARP Table
D. Routing Table

**Answer: A**

---

### 65.

XSS can be used to:

A. Steal cookies
B. Encrypt data
C. Compress data
D. Update DNS

**Answer: A**

---

### 66.

MITM stands for:

A. Multiple Internet Traffic Manager
B. Man In The Middle
C. Main Internet Traffic Mode
D. Managed Internet Transfer Method

**Answer: B**

---

### 67.

MITM attacks can capture:

A. Session Tokens
B. CPU
C. RAM
D. BIOS

**Answer: A**

---

### 68.

Passive Hijacking involves:

A. Monitoring traffic
B. Deleting sessions
C. Crashing server
D. Encrypting cookies

**Answer: A**

---

### 69.

Active Hijacking involves:

A. Taking over session
B. Monitoring only
C. Logging only
D. Encrypting only

**Answer: A**

---

### 70.

TCP Hijacking exploits:

A. Sequence Numbers
B. Password Length
C. DNS Records
D. MAC Address

**Answer: A**

---

# 8. Prevention

### 71.

HTTPS protects against:

A. Sniffing
B. Flooding
C. Routing
D. Compression

**Answer: A**

---

### 72.

Secure Cookie ensures:

A. HTTPS Transmission
B. Faster Browsing
C. More RAM
D. Less CPU

**Answer: A**

---

### 73.

HttpOnly protects cookies from:

A. JavaScript
B. Firewall
C. Router
D. IDS

**Answer: A**

---

### 74.

MFA stands for:

A. Multiple Firewall Access
B. Multi-Factor Authentication
C. Managed File Access
D. Manual Firewall Authentication

**Answer: B**

---

### 75.

Session Timeout helps by:

A. Reducing attack window
B. Increasing attack window
C. Disabling login
D. Creating cookies

**Answer: A**

---

### 76.

Session Regeneration occurs:

A. After login
B. Before boot
C. During shutdown
D. During formatting

**Answer: A**

---

### 77.

Strong session IDs should be:

A. Predictable
B. Random
C. Short
D. Sequential

**Answer: B**

---

### 78.

IDS stands for:

A. Intrusion Detection System
B. Internet Defense Server
C. Internal Data Security
D. Integrated Data Storage

**Answer: A**

---

### 79.

IPS stands for:

A. Intrusion Prevention System
B. Internet Protection Service
C. Internal Packet Server
D. Internet Packet Security

**Answer: A**

---

### 80.

VPN primarily provides:

A. Secure Communication
B. SYN Flood
C. Smurf Attack
D. ARP Spoofing

**Answer: A**

---

# Mixed Important MCQs

### 81. Which attack uses broadcast amplification?

**A. Smurf Attack**

### 82. Which attack exploits TCP handshake?

**B. SYN Flood**

### 83. Which protocol does Ping use?

**C. ICMP**

### 84. Which attack steals session tokens?

**D. Session Hijacking**

### 85. Mirai mainly targeted?

**A. IoT Devices**

### 86. Zeus targeted?

**B. Banking Credentials**

### 87. Which flag protects cookie from JavaScript?

**C. HttpOnly**

### 88. Which flag restricts cookie to HTTPS?

**D. Secure**

### 89. DDoS affects which CIA property?

**A. Availability**

### 90. Spoofing means?

**B. Impersonation**

### 91. Hijacking means?

**C. Taking Over Existing Session**

### 92. Half-open connections indicate?

**D. SYN Flood**

### 93. Collection of bots?

**A. Botnet**

### 94. Botnet controller?

**B. Botmaster**

### 95. Session ID should be?

**C. Random**

### 96. XSS commonly leads to?

**D. Cookie Theft**

### 97. Sniffing is associated with?

**A. Passive Hijacking**

### 98. MITM can lead to?

**B. Session Hijacking**

### 99. Best protection for web sessions?

**C. HTTPS**

### 100. Most common web hijacking method?

**D. Cookie Hijacking**

---

# Most Important Exam Questions (Repeated Frequently)

1. Difference between DoS and DDoS.
2. Explain Bot and Botnet architecture.
3. Explain Smurf Attack with diagram.
4. Explain SYN Flood attack using TCP handshake.
5. Difference between Spoofing and Hijacking.
6. Types of Session Hijacking.
7. Explain Cookie Hijacking.
8. Explain MITM attack.
9. Prevention of Session Hijacking.
10. Explain Secure and HttpOnly cookie flags.

### 1-Day Revision Keywords

**DoS → Single Source**

**DDoS → Multiple Sources**

**Bot → Infected Device**

**Botnet → Collection of Bots**

**Smurf → ICMP + Broadcast + Spoofed IP**

**SYN Flood → TCP Half-Open Connections**

**Spoofing → Fake Identity**

**Hijacking → Session Takeover**

**HTTPS + Secure + HttpOnly + MFA = Protection**
