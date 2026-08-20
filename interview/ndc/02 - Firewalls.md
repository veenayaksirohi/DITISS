# Firewalls — Detailed Notes

## 1. What is a Firewall?

A **Firewall** is a security system that monitors and controls network traffic based on predefined security rules.

It decides whether traffic should be:

- **Allowed**
- **Blocked**
- **Rejected**
- **Logged**

A firewall can protect:

- One computer
- One server
- One network
- An entire organization

### Simple Definition

> A firewall is a security barrier between a trusted network and an untrusted network.

Usually:

```text
Internet
   ↓
Firewall
   ↓
Internal Network
```

The Internet is generally treated as an **untrusted network**, while the internal company network is a **trusted network**.

---

# 2. Why is a Firewall Used?

A firewall is used to:

- Block unauthorized access
- Allow legitimate traffic
- Control incoming traffic
- Control outgoing traffic
- Restrict ports
- Restrict IP addresses
- Reduce attack surface
- Protect internal systems
- Prevent unwanted network connections
- Log suspicious traffic

### Example

Suppose a company has:

```text
Web Server       → Port 443
SSH Server       → Port 22
Database Server  → Port 3306
```

The firewall may allow:

```text
Internet → Web Server → TCP 443 → ALLOW
```

But block:

```text
Internet → Database → TCP 3306 → BLOCK
```

This reduces unnecessary exposure.

---

# 3. Where is a Firewall Used?

A firewall can be placed in different locations.

## Network Firewall

Placed between networks. It protects multiple systems.

```text
Internet
   ↓
Network Firewall
   ↓
Company LAN
```

Examples:

- pfSense
- Cisco Firewall
- Palo Alto
- FortiGate

## Host-Based Firewall

Installed directly on a computer or server.

```text
Internet
   ↓
Linux Server
   ↓
iptables / nftables
```

Examples:

- Windows Defender Firewall
- iptables
- nftables
- UFW
- firewalld

---

# 4. How Does a Firewall Work?

A firewall checks network packets against configured rules.

Basic process:

```text
Packet Arrives
     ↓
Firewall Reads Packet Information
     ↓
Checks Firewall Rules
     ↓
Match Found?
   /       \
 Yes       No
 ↓          ↓
Apply      Default
Action     Policy
```

The firewall may check:

- Source IP
- Destination IP
- Source port
- Destination port
- Protocol
- Direction
- Interface
- Connection state
- Application, in advanced firewalls

---

# 5. Example of Firewall Processing

Suppose this packet arrives:

```text
Source IP:      10.10.10.5
Destination IP: 192.168.1.10
Protocol:       TCP
Destination:    Port 22
```

Firewall rules:

```text
Rule 1:
Allow TCP 22 from 192.168.1.100

Rule 2:
Block TCP 22 from everyone else
```

The packet comes from `10.10.10.5`. It does not match Rule 1. It matches Rule 2.

Result:

```text
DROP
```

---

# 6. Firewall Rules

A **firewall rule** tells the firewall what traffic should be allowed or denied.

A rule normally contains:

```text
Source
Destination
Protocol
Port
Direction
Action
```

Example:

```text
Source:      192.168.1.50
Destination: 192.168.1.100
Protocol:    TCP
Port:        22
Action:      ALLOW
```

Meaning: Allow `192.168.1.50` to connect to SSH port 22 on `192.168.1.100`.

---

# 7. Main Parts of a Firewall Rule

## Source IP

Where the traffic comes from. Example: `192.168.1.10`

## Destination IP

Where the traffic is going. Example: `10.0.0.20`

## Protocol

Firewall may filter using protocols such as: TCP, UDP, ICMP

## Port

```text
22   → SSH
80   → HTTP
443  → HTTPS
3306 → MySQL
5432 → PostgreSQL
```

## Action

Common firewall actions:

### ACCEPT / ALLOW

Permit the packet.

```text
Packet → Firewall → ACCEPT → Destination
```

### DROP

Silently discard the packet. No response is normally sent.

```text
Packet → Firewall → DROP
```

### REJECT

Block the packet and usually notify the sender.

```text
Packet → Firewall → REJECT → Error Response
```

---

# 8. Firewall Rule Example

Suppose a web server has IP `192.168.10.20`. We want users to access only HTTPS.

Rules:

```text
ALLOW TCP 443 → 192.168.10.20
DROP TCP 80   → 192.168.10.20
DROP ALL OTHER UNNECESSARY TRAFFIC
```

This follows the principle: **Allow only what is required.**

---

# 9. Default Allow vs Default Deny (Basic Concept)

## Default Allow

Traffic is allowed unless specifically blocked.

```text
Allow Everything
   ↓
Block Selected Traffic
```

This is generally less secure. If you forget to block a service (SSH, Database, RDP, Admin Panel), it may remain accessible, increasing the attack surface.

## Default Deny

Traffic is blocked unless explicitly allowed.

```text
Block Everything
   ↓
Allow Required Traffic
```

This is generally more secure and follows the principle of **least privilege**.

### Example

```text
Default Policy: DROP

Allow TCP 22 from Admin IP
Allow TCP 443 from Internet
```

Everything else stays blocked.

### Comparison Table

| Default Allow                        | Default Deny                      |
| ------------------------------------ | --------------------------------- |
| Everything allowed unless blocked    | Everything blocked unless allowed |
| Easier initially                     | More secure                       |
| Higher chance of accidental exposure | Lower attack surface              |
| Block bad traffic                    | Allow only required traffic       |
| Less restrictive                     | Least-privilege approach          |

### Interview Recommendation

For security-sensitive systems: **Default Deny is generally preferred.**

---

# 10. Rule Order

Firewall rules are usually processed in order (top to bottom, first match applies).

Example:

```text
Rule 1: ALLOW TCP 22 from ANY
Rule 2: DROP TCP 22 from 10.10.10.5
```

The packet from `10.10.10.5` may already match Rule 1 first, so Rule 2 may never be reached.

Correct order:

```text
Rule 1: DROP TCP 22 from 10.10.10.5
Rule 2: ALLOW TCP 22 from trusted network
```

### Important Interview Point

> Firewall rule order matters because many firewalls process rules from top to bottom and apply the first matching rule.

---

# 11. Inbound and Outbound Traffic (Basic Concept)

## Inbound Traffic

Traffic coming **into** a system/network.

```text
Internet → Server
```

Example: `Internet → HTTPS 443 → Web Server`

## Outbound Traffic

Traffic leaving a system/network.

```text
Server → Internet
```

Example: `Internal Server → DNS Server`

A firewall can control both inbound and outbound traffic. Detailed rules, examples, and the "perspective" nuance are covered in Section 36–43.

---

# 12. Packet Filtering Firewall

A **Packet Filtering Firewall** examines individual packets and makes decisions using packet header information.

It commonly checks:

- Source IP
- Destination IP
- Source port
- Destination port
- Protocol

```text
Packet
 ↓
Check:
Source IP
Destination IP
Port
Protocol
 ↓
Allow / Block
```

Packet filtering mainly works at:

- **Layer 3 — Network Layer**
- **Layer 4 — Transport Layer**

---

# 13. Packet Filtering Example

Rule:

```text
ALLOW TCP
Source: ANY
Destination: 192.168.1.10
Destination Port: 443
```

Packet:

```text
Source: 8.8.8.8
Destination: 192.168.1.10
Protocol: TCP
Port: 443
```

Result: `ALLOW`

Another packet with `Port: 22` and no matching allow rule → `DROP`

---

# 14. Advantages of Packet Filtering Firewall

- Fast
- Simple
- Low resource usage
- Easy to configure for basic traffic
- Good for IP/port-based filtering

---

# 15. Limitations of Packet Filtering Firewall

Traditional/simple packet filtering may not understand:

- Application behavior
- User identity
- Packet content
- Complete connection context

For example, `TCP 80 allowed` — the firewall may know it is TCP port 80, but may not deeply understand whether the HTTP request itself is malicious.

---

# 16. Stateless Firewall

A **Stateless Firewall** checks each packet independently. It does **not remember previous packets or connection state**.

```text
Packet 1 → Check Rule → Allow/Drop
Packet 2 → Check Rule → Allow/Drop
Packet 3 → Check Rule → Allow/Drop
```

Each packet is treated separately.

---

# 17. How Stateless Firewall Works

Suppose a client sends:

```text
Client → Server
TCP SYN
```

Stateless firewall checks: Source IP, Destination IP, Port, Protocol.

Then the server replies:

```text
Server → Client
SYN-ACK
```

The firewall again checks the reply as a completely separate packet. It does not automatically know that this SYN-ACK is part of the connection the client started.

---

# 18. Stateless Firewall Example

Rule: `ALLOW outgoing TCP 443`

The client sends `Client → Website:443` — Allowed.

But when the reply comes (`Website → Client`), a stateless firewall may require another explicit rule to allow the return traffic.

---

# 19. Advantages of Stateless Firewall

- Very fast
- Simple
- Low memory usage
- Useful for simple filtering
- Works well for basic ACL-style rules

---

# 20. Disadvantages of Stateless Firewall

- Does not track sessions
- Does not understand connection state
- More rules may be required
- Less context for security decisions
- Return traffic may need separate rules

---

# 21. Stateful Firewall

A **Stateful Firewall** remembers active network connections. It maintains a **state table** (connection table) and can track states such as:

```text
NEW
ESTABLISHED
RELATED
INVALID
```

Basic process:

```text
Packet Arrives
     ↓
Check Firewall Rules
     ↓
Check Connection State
     ↓
Check State Table
     ↓
Allow / Drop
```

More complete flow:

```text
Packet Arrives
     ↓
Check State Table
     ↓
Existing / Related Connection?
    /                \
  Yes                No
   ↓                  ↓
Check Policy        Check New
   ↓                Connection Rule
   └──────────┬───────────┘
              ↓
         Allow / Drop
```

---

# 22. How Stateful Firewall Works

Suppose `Client → Web Server:443`. Client sends `SYN`. Firewall allows it and creates an entry:

```text
Client:50000 → Server:443
State = NEW
```

Server responds `SYN-ACK`. Firewall recognizes this packet belongs to an existing connection, so it allows it. When the TCP handshake completes:

```text
State = ESTABLISHED
```

---

# 23. Stateful Firewall Example

Client starts an HTTPS connection:

```text
192.168.1.10:50000
        ↓
     Firewall
        ↓
8.8.8.8:443
```

State table:

```text
Source:      192.168.1.10:50000
Destination: 8.8.8.8:443
Protocol:    TCP
State:       ESTABLISHED
```

When reply traffic comes (`8.8.8.8:443 → 192.168.1.10:50000`), firewall checks the table, sees the connection already exists, and the result is `ALLOW`.

---

# 24. Connection Tracking

**Connection tracking** means the firewall keeps information about active connections.

Example table:

| Source             | Destination  | Protocol | State       |
| ------------------ | ------------ | -------- | ----------- |
| 192.168.1.10:51000 | 8.8.8.8:443  | TCP      | ESTABLISHED |
| 192.168.1.20:52000 | 1.1.1.1:53   | UDP      | Tracked     |
| 192.168.1.30:53000 | 10.0.0.10:22 | TCP      | NEW         |

This allows the firewall to make better decisions.

---

# 25. Common Connection States

## NEW

A new connection is starting. Example: `Client → SYN → Server`

## ESTABLISHED

Connection already exists and data is already being exchanged. Example: `Client ↔ Server`

## RELATED

A new connection is related to an existing connection.

## INVALID

Packet cannot be associated correctly with a valid connection. It may be dropped.

---

# 26. Advantages of Stateful Firewall

- Tracks active sessions
- Better security decisions
- Automatically handles legitimate return traffic
- Requires fewer rules
- Detects unexpected packets better than simple stateless filtering

---

# 27. Disadvantages of Stateful Firewall

- Uses more memory
- Uses more CPU
- Maintains state tables
- Very large numbers of connections may consume resources
- More complex than stateless filtering

---

# 28. Stateful vs Stateless Firewall

This is a very important interview comparison.

| Feature                    | Stateless Firewall                 | Stateful Firewall                 |
| -------------------------- | ---------------------------------- | --------------------------------- |
| Tracks connection          | No                                 | Yes                               |
| Remembers previous packets | No                                 | Yes                               |
| Checks packet individually | Yes                                | Yes, plus connection state        |
| State table                | No                                 | Yes                               |
| Return traffic             | Needs explicit consideration/rules | Can recognize valid reply traffic |
| Resource usage             | Lower                              | Higher                            |
| Security context           | Less                               | More                              |
| Configuration              | Simple                             | More advanced                     |
| Example use                | Basic ACL/packet filtering         | Modern firewall/session filtering |

### Easy Memory Aid

```text
STATELESS
"What does this packet look like?"

STATEFUL
"What does this packet look like,
and does it belong to a valid connection?"
```

---

# 30. Real-Life Scenario — Stateful Firewall in Action

A user inside the company opens `https://example.com`. The connection is:

```text
192.168.1.20:51000
       ↓
Firewall
       ↓
93.184.216.34:443
```

### Stateful Firewall

The firewall allows outbound HTTPS and records:

```text
192.168.1.20:51000 ↔ 93.184.216.34:443
```

The web server sends the response. Firewall sees an `ESTABLISHED connection` and allows the reply.

But if an unknown Internet host suddenly sends `Unknown IP → 192.168.1.20:51000` with no matching connection state, the firewall can block it.

---

# 31. Scenario-Based Interview Questions (Basic Firewall Concepts)

## Scenario 1

**Your organization wants internal users to browse the Internet, but Internet users should not initiate connections to internal computers. What type of firewall behavior helps?**

Answer: Use a **stateful firewall**. It allows internal users to start connections and permits valid response traffic while blocking unsolicited inbound connections.

## Scenario 2

**A firewall allows packets only based on source IP, destination IP, protocol, and port. It does not remember sessions. What kind of firewall is this?**

Answer: **Stateless packet-filtering firewall.**

## Scenario 3

**A packet comes from a web server as a reply to a connection started by an internal user. How does a stateful firewall know it is legitimate?**

Answer: It checks its **connection/state table** and confirms the packet belongs to an existing established session.

## Scenario 4

**A firewall rule says `ALLOW ANY ANY`. Why is this dangerous?**

Because it allows unnecessary traffic and greatly increases the attack surface.

Better approach:

```text
Default Deny
     +
Allow Required Services Only
```

## Scenario 5

**Only the administrator at `192.168.1.50` should access SSH on a server. What firewall rule would you use?**

```text
ALLOW:
Source      = 192.168.1.50
Destination = Server
Protocol    = TCP
Port        = 22
```

Then: `DROP other TCP 22 traffic`

---

# 32. Common Interview Questions (Basic Firewall Concepts)

### What is a firewall?

> A firewall is a security control that monitors and filters incoming and outgoing network traffic according to predefined rules.

### What does a firewall check?

Usually: Source IP, Destination IP, Port, Protocol, Direction, Connection state. Advanced firewalls may also inspect applications and content.

### What is a firewall rule?

> A firewall rule defines what traffic should be allowed or denied based on conditions such as IP address, port, protocol, direction, or connection state.

### What is packet filtering?

> Packet filtering checks packet header information such as source IP, destination IP, ports, and protocol to decide whether traffic should be allowed or blocked.

### What is a stateless firewall?

> A stateless firewall examines every packet independently and does not remember previous packets or sessions.

### What is a stateful firewall?

> A stateful firewall tracks active connections and uses connection state along with firewall rules to decide whether packets should be allowed.

---

# Advanced Firewall Concepts — Detailed Notes

# 34. Next Generation Firewall (NGFW)

## Meaning

A **Next Generation Firewall (NGFW)** is an advanced firewall that does more than basic IP address, port, and protocol filtering.

A traditional firewall mainly checks: Source IP, Destination IP, Port, Protocol, Connection State.

An NGFW can also understand:

- Which application is being used
- Which user is generating traffic
- What type of content is inside the traffic
- Whether the traffic matches known attack patterns
- Whether malware or suspicious behavior is present

### Simple Definition

> An NGFW is an advanced firewall that combines traditional firewall functions with application awareness, deep packet inspection, and often IDS/IPS capabilities.

---

# 35. Why Do We Need NGFW?

Traditional firewalls mainly make decisions using `IP + Port + Protocol`. But modern applications do not always use fixed ports.

For example, YouTube, Facebook, Gmail, Google Drive, and WhatsApp Web may all use `TCP 443`.

A traditional firewall may only see "HTTPS traffic on port 443" and may not know which application is inside that HTTPS traffic. An NGFW can identify applications more accurately.

```text
Traffic → TCP 443
          ↓
         NGFW
          ↓
Identify Application
          ↓
YouTube
          ↓
Policy says BLOCK
          ↓
Blocked
```

---

# 36. Main Features of NGFW

## 36.1 Traditional Firewall Functions

An NGFW still provides: IP filtering, Port filtering, Protocol filtering, Stateful inspection, NAT, Firewall rules.

## 36.2 Application Awareness

An NGFW can identify applications.

```text
Port 443
   ↓
NGFW identifies:
YouTube
Google Drive
Facebook
Office 365
```

So instead of writing only `Block TCP 443`, you can create a rule like:

```text
Allow Office 365
Block YouTube
Allow Google Drive
```

without blocking all HTTPS traffic.

---

# 37. Application Control

**Application Control** means creating security policies based on the application instead of only the port.

```text
Employees:
Allow → Gmail
Allow → Microsoft Teams
Block → Torrent
Block → Gaming Applications
```

This gives much more control than a traditional firewall.

---

# 38. Deep Packet Inspection — DPI

## Meaning

**Deep Packet Inspection (DPI)** means inspecting more than just basic packet header information.

A normal packet-filtering firewall may inspect: Source IP, Destination IP, Source Port, Destination Port, Protocol.

DPI can inspect deeper information related to: Application traffic, Protocol behavior, Content patterns, Security signatures.

```text
Packet
  ↓
Header
  +
Payload / Application Information
  ↓
Deep Inspection
```

### Important

Encrypted HTTPS traffic cannot simply be read as plaintext by a firewall. Some organizations use controlled TLS inspection where legally and operationally appropriate.

---

# 39. IDS/IPS Integration in NGFW

Many NGFWs include or integrate IDS and IPS.

### IDS

Detects suspicious traffic.

```text
Attack → IDS → Alert
```

### IPS

Detects and blocks suspicious traffic.

```text
Attack → IPS → DROP
```

NGFW combined flow:

```text
Packet
  ↓
Firewall Rules
  ↓
Application Identification
  ↓
IPS Inspection
  ↓
Allow / Block
```

---

# 40. User-Based Policies

An NGFW may integrate with identity systems. Instead of `Allow 192.168.1.20`, you may configure:

```text
Allow Finance Users → Banking Website
Block Guest Users → Internal Applications
```

This is called **user-aware security policy**.

---

# 41. URL Filtering

An NGFW can also restrict access based on websites or categories, e.g.: Social media, Gambling, Malware, Adult content, File sharing, Shopping.

```text
Employee
   ↓
Request → malicious-site.example
   ↓
NGFW URL Filter
   ↓
Blocked
```

---

# 42. Malware / Threat Protection

Depending on the product and configuration, an NGFW may inspect traffic for: Known malware, Exploit signatures, Command-and-control communication, Suspicious downloads.

This is often combined with:

```text
Threat Intelligence
+
IPS
+
URL Filtering
+
Malware Analysis
```

---

# 43. NGFW Example

Suppose an employee tries to use BitTorrent.

Traditional firewall:

```text
Traffic → TCP 443
Firewall sees → HTTPS
Possibly ALLOW
```

NGFW:

```text
Traffic → TCP 443
      ↓
Application Inspection
      ↓
Application = BitTorrent
      ↓
Company Policy = BLOCK
      ↓
Blocked
```

---

# 44. Common NGFW Features

- Stateful firewall
- Application identification
- Application control
- Deep packet inspection
- IDS/IPS
- URL filtering
- User-based policies
- NAT
- VPN
- Threat intelligence integration
- Logging and reporting
- Malware/threat protection

Examples of NGFW vendors: Palo Alto Networks, Fortinet FortiGate, Cisco Secure Firewall, Check Point, Sophos Firewall.

---

# 45. Traditional Firewall vs NGFW

| Feature                   | Traditional Firewall | NGFW             |
| ------------------------- | -------------------- | ---------------- |
| IP Filtering              | Yes                  | Yes              |
| Port Filtering            | Yes                  | Yes              |
| Protocol Filtering        | Yes                  | Yes              |
| Stateful Inspection       | Common               | Yes              |
| NAT                       | Yes                  | Yes              |
| Application Awareness     | Limited/No           | Yes              |
| Application Control       | Limited              | Yes              |
| Deep Packet Inspection    | Limited              | Yes              |
| IDS/IPS                   | Usually separate     | Often integrated |
| User-Based Rules          | Limited              | Common           |
| URL Filtering             | Usually separate     | Often integrated |
| Threat Intelligence       | Limited              | Common           |
| Advanced Threat Detection | Limited              | Better support   |

### Easy Example

Suppose YouTube, Online Banking, and Microsoft Teams all use `TCP 443`.

**Traditional Firewall:** if 443 is allowed, all three (YouTube, Banking, Teams) → Allowed.

**NGFW:** can identify applications:

```text
TCP 443
   ↓
NGFW

YouTube → BLOCK
Banking → ALLOW
Teams → ALLOW
```

This is one of the main advantages of an NGFW.

### Interview Answer

> A traditional firewall mainly controls traffic using IP addresses, ports, protocols, and connection state. An NGFW adds advanced capabilities such as application awareness, deep packet inspection, IDS/IPS, URL filtering, user-based policies, and threat intelligence.

---

# 46. Proxy Firewall

## Meaning

A **Proxy Firewall** acts as an intermediary between a client and the destination server. The client does not directly communicate with the destination; the proxy creates another connection to the destination on behalf of the client.

```text
Client
   ↓
Proxy Firewall
   ↓
Internet Server
```

---

# 47. How Proxy Firewall Works

Suppose a user wants to access `example.com`.

Without proxy: `Client → example.com`

With proxy firewall:

```text
Client
   ↓
Proxy Firewall
   ↓
Checks Request
   ↓
Creates New Connection
   ↓
example.com
```

The server may see the proxy's address rather than the client's direct connection.

---

# 48. Why is a Proxy Firewall Secure?

Because the client and destination server do not necessarily communicate directly. The proxy can inspect: Application request, URL, Headers, Protocol behavior, Content (where technically possible), User identity, Security policy.

---

# 49. Proxy Firewall Example

Company policy:

```text
Allow:
docs.company.com

Block:
social-media.example
```

Flow:

```text
Employee
   ↓
Proxy
   ↓
Check URL
   ↓
Allowed?
  /   \
Yes   No
 ↓     ↓
Forward Block
```

---

# 50. Application-Level Proxy

A proxy firewall often operates at the **Application Layer**. Examples: HTTP proxy, FTP proxy, SMTP proxy. The proxy understands the specific application protocol.

```text
HTTP Request
    ↓
HTTP Proxy
    ↓
Analyze Request
    ↓
Forward / Block
```

---

# 51. Advantages and Disadvantages of Proxy Firewall

### Advantages

- Hides internal clients
- Application-level control
- Can inspect application requests
- URL filtering
- User authentication
- Logging
- Can reduce direct exposure

### Disadvantages

- More processing overhead
- Can add latency
- More complex configuration
- Proxy support may be application/protocol specific

---

# 52. Forward Proxy vs Proxy Firewall

A forward proxy represents clients.

```text
Client
   ↓
Forward Proxy
   ↓
Internet
```

Common purposes: Internet access control, URL filtering, Caching, Hide internal client addresses, Logging.

Example tool: `Squid`

---

# 53. Host Firewall

## Meaning

A **Host Firewall** runs directly on an individual computer or server and protects that particular host.

```text
Internet
   ↓
Linux Server
   ↓
iptables / nftables
```

or:

```text
Network
   ↓
Windows Server
   ↓
Windows Defender Firewall
```

### Examples

- Linux: iptables, nftables, UFW, firewalld
- Windows: Windows Defender Firewall

### What Can Host Firewall Control?

It can control: Incoming connections, Outgoing connections, Ports, Protocols, Source IPs, Destination IPs, Local applications (depending on firewall).

Example:

```text
Linux Server

Allow:
TCP 22 from 192.168.1.50

Allow:
TCP 443 from ANY

Drop:
Everything else
```

---

# 54. Network Firewall

## Meaning

A **Network Firewall** is placed between networks and protects multiple devices, filtering traffic passing between networks rather than protecting only one machine.

```text
             Internet
                ↓
         Network Firewall
                ↓
      ---------------------
      ↓         ↓         ↓
   Server 1  Server 2    PC
```

### Common Placement Locations

```text
Internet
   ↓
Network Firewall
   ↓
LAN
```

or:

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Internal Firewall
   ↓
Internal Network
```

---

# 55. Host Firewall vs Network Firewall

| Feature                     | Host Firewall        | Network Firewall          |
| --------------------------- | -------------------- | ------------------------- |
| Installed on                | Individual device    | Between networks          |
| Protects                    | One host             | Multiple systems/network  |
| Traffic visibility          | Traffic to/from host | Traffic crossing firewall |
| Example                     | iptables             | pfSense                   |
| Local protection            | Strong               | Depends on traffic path   |
| Protects host from same LAN | Can                  | Not always                |
| Central management          | Depends              | Often centralized         |

### Example — Host vs Network Firewall

Suppose `PC1 → PC2`, both on the same local network.

If this traffic does not pass through the network firewall (`PC1 ───→ PC2`), the perimeter firewall may not inspect it. But if PC2 has a host firewall (`PC1 → Host Firewall on PC2 → PC2 Application`), the host firewall can still block it.

### Why Use Both Host and Network Firewalls?

This is **Defence in Depth**.

```text
Internet
   ↓
Network Firewall
   ↓
Internal Network
   ↓
Host Firewall
   ↓
Server
```

If one layer fails, the other still provides protection.

---

# 56. Default Allow (Detailed)

## Meaning

**Default Allow** means traffic is allowed unless there is a specific rule to block it.

```text
Default:
ALLOW ALL

Rule:
BLOCK 10.10.10.5
```

Everything is allowed except traffic specifically denied.

### Problem with Default Allow

If you forget to block a service (SSH, Database, RDP, Admin Panel), it may remain accessible, increasing the attack surface.

---

# 57. Default Deny (Detailed)

## Meaning

**Default Deny** means traffic is blocked unless it is explicitly allowed.

```text
Default Policy:
DROP

Allow TCP 443
Allow SSH from Admin IP
```

Everything else stays blocked.

### Default Deny Example

Server requirements:

```text
HTTPS → Required
SSH → Admin only
MySQL → Internal only
```

Rules:

```text
ALLOW TCP 443 from ANY

ALLOW TCP 22 from 192.168.1.50

ALLOW TCP 3306 from 10.0.2.10

DEFAULT DROP
```

This follows the principle of **least privilege**. (See Section 9 for the Default Allow vs Default Deny comparison table.)

---

# 58. Inbound Traffic (Detailed)

## Meaning

**Inbound traffic** is traffic coming **into** a device or network.

```text
Internet
   ↓
Web Server
```

Request: `User → Web Server:443` — this is inbound traffic from the server's perspective.

### Inbound Rule

An inbound rule controls connections coming into the system.

Example: `ALLOW inbound TCP 443` means:

```text
Internet
   ↓
TCP 443
   ↓
Web Server
```

Allowed.

### Inbound Rule Example

Server `192.168.1.10`. Requirements: HTTPS available publicly; SSH only from admin.

```text
Inbound:

ALLOW TCP 443 from ANY

ALLOW TCP 22 from 192.168.1.50

DROP everything else
```

---

# 59. Outbound Traffic (Detailed)

## Meaning

**Outbound traffic** is traffic generated by the local system/network going outside.

```text
Internal Server
     ↓
Internet
```

Examples: `Server → DNS Server`, `Server → Software Repository`, `Server → API`, `Server → Email Server`.

### Outbound Rule

An outbound rule controls traffic leaving the system. Example: `ALLOW outbound TCP 443` means the server may initiate HTTPS connections.

### Why Control Outbound Traffic?

Some people think only inbound traffic needs protection, but outbound filtering is also important.

Suppose malware infects a server and tries: `Compromised Server → Attacker Command-and-Control Server`.

If outbound traffic is unrestricted: `Malware → Internet → Allowed`.

With controlled outbound rules: `Malware → Unknown Destination → Firewall → Blocked`.

---

# 60. Inbound vs Outbound Rules

| Inbound                                        | Outbound                        |
| ---------------------------------------------- | ------------------------------- |
| Traffic entering system/network                | Traffic leaving system/network  |
| Protects against unwanted incoming connections | Controls external communication |
| Example: allow HTTPS 443                       | Example: allow DNS 53           |
| Internet → Server                              | Server → Internet               |

### Inbound/Outbound Depends on Perspective

This is important. Suppose `PC → Web Server`.

For the PC: Request = Outbound, Response = Inbound.

For the Web Server: Request = Inbound, Response = Outbound.

So inbound/outbound is always relative to the device or firewall being discussed.

---

# 61. Complete Firewall Evolution

You can remember firewalls like this:

```text
Packet Filtering
       ↓
Check IP / Port / Protocol
       ↓
Stateful Firewall
       ↓
Track Connections
       ↓
Proxy Firewall
       ↓
Application-Level Inspection
       ↓
NGFW
       ↓
Application Awareness
+ DPI
+ IDS/IPS
+ User Awareness
+ Threat Intelligence
```

---

# 62. Scenario-Based Interview Questions (Advanced Firewall Concepts)

## Scenario 1 — NGFW

**Question:** Employees need Microsoft Teams, but management wants to block YouTube. Both use HTTPS port 443. How can you do this?

**Answer:** A simple port-based firewall cannot easily distinguish them because both can use 443. Use an **NGFW with application control**:

```text
TCP 443
  ↓
NGFW
  ↓
Identify Application
  ↓
Teams   → ALLOW
YouTube → BLOCK
```

## Scenario 2 — Traditional vs NGFW

**Question:** Your firewall allows TCP 443, but users are using unwanted applications over HTTPS. What is the problem?

**Answer:** The firewall is relying mainly on ports. An NGFW can provide: Application identification, Application control, URL filtering, DPI, IDS/IPS.

## Scenario 3 — Proxy Firewall

**Question:** A company wants employees' web requests to pass through a central system where URLs can be checked before Internet access.

**Answer:** Use a **proxy firewall / forward proxy**.

```text
Employee
   ↓
Proxy
   ↓
URL / Policy Check
   ↓
Internet
```

## Scenario 4 — Host vs Network Firewall

**Question:** Two compromised PCs are communicating inside the same LAN without passing through the perimeter firewall. What additional control can help?

**Answer:** Use **host-based firewalls** on the endpoints.

```text
PC1
 ↓
Host Firewall on PC2
 ↓
PC2
```

Also consider network segmentation.

## Scenario 5 — Default Allow vs Deny

**Question:** A company firewall permits all traffic except a few explicitly blocked ports. Is this a good security design?

**Answer:** It is a **default allow** approach and can lead to accidental exposure. A safer model is usually: `Default Deny + Explicitly Allow Required Traffic`.

## Scenario 6 — Inbound Rule

**Question:** You have a public web server. Users must access HTTPS, but SSH should be available only to the administrator.

**Rules:**

```text
Inbound:

ALLOW TCP 443 from ANY

ALLOW TCP 22 from Admin IP

DEFAULT DROP
```

## Scenario 7 — Outbound Rule

**Question:** A database server only needs to communicate with an internal application server. It should not connect freely to the Internet.

**Solution:** Restrict outbound traffic:

```text
Database
   ↓
ALLOW required internal traffic

Internet
   ↓
DENY unnecessary outbound traffic
```

This can reduce malware command-and-control or data-exfiltration opportunities.

## Scenario 8 — Stateful Firewall

**Question:** An internal employee opens an HTTPS website. Why can the website's reply enter even though random inbound Internet traffic is blocked?

**Answer:** Because a **stateful firewall** remembers that the internal user initiated the connection.

```text
Internal Client
     ↓
Starts HTTPS Connection
     ↓
Firewall stores connection state
     ↓
Server Response
     ↓
Matches ESTABLISHED connection
     ↓
ALLOW
```

Random unsolicited inbound traffic does not match the state table and can be blocked.

---

# 63. Quick Revision Table — Advanced Concepts

| Topic                | Simple Meaning                                               |
| -------------------- | ------------------------------------------------------------ |
| NGFW                 | Advanced firewall with app awareness and security inspection |
| Application Control  | Allow/block specific applications                            |
| DPI                  | Deeper inspection of traffic                                 |
| Traditional Firewall | Mainly IP, port, protocol and state-based filtering          |
| Proxy Firewall       | Intermediary between client and destination                  |
| Host Firewall        | Protects one individual device                               |
| Network Firewall     | Protects traffic between networks                            |
| Default Allow        | Allow unless blocked                                         |
| Default Deny         | Block unless explicitly allowed                              |
| Inbound Rule         | Controls traffic entering                                    |
| Outbound Rule        | Controls traffic leaving                                     |
| Stateless            | Doesn't remember connections                                 |
| Stateful             | Tracks connection state                                      |

---

# 64. Most Important Interview Questions (Master List)

1. What is a firewall?
2. What does a firewall check?
3. What is a firewall rule?
4. What is packet filtering?
5. What is a stateless firewall?
6. What is a stateful firewall?
7. Why does a stateful firewall allow return traffic?
8. What is a connection/state table?
9. What is an NGFW?
10. Why do we need NGFW?
11. Traditional firewall vs NGFW?
12. What is application awareness?
13. What is application control?
14. What is Deep Packet Inspection?
15. How can an NGFW identify applications using the same port?
16. What is a proxy firewall?
17. How does a proxy firewall work?
18. Forward proxy vs firewall?
19. What is a host firewall?
20. What is a network firewall?
21. Host firewall vs network firewall?
22. Why use both network and host firewalls?
23. What is Default Allow?
24. What is Default Deny?
25. Which one is more secure?
26. What is an inbound firewall rule?
27. What is an outbound firewall rule?
28. Why should outbound traffic be filtered?

---

# 65. One-Line Interview Revision (Master Summary)

```text
Firewall
→ Controls network traffic according to security rules.

Firewall Rule
→ Defines which traffic is allowed or blocked.

Packet Filtering
→ Checks IP, port and protocol.

Stateless Firewall
→ Checks every packet separately, does not remember connections.

Stateful Firewall
→ Tracks active connections, maintains a state table,
   recognizes legitimate return traffic.

NGFW
→ Traditional firewall + application awareness + advanced security inspection.

Traditional Firewall
→ Mainly checks IP, port, protocol and connection state.

Proxy Firewall
→ Acts as an intermediary between client and destination.

Host Firewall
→ Protects one computer/server.

Network Firewall
→ Protects traffic flowing between networks.

Default Allow
→ Everything allowed unless specifically blocked.

Default Deny
→ Everything blocked unless specifically allowed.

Inbound Rule
→ Controls traffic coming into a system/network.

Outbound Rule
→ Controls traffic leaving a system/network.
```

## Best Flow to Remember

```text
Traditional Firewall
     ↓
IP + Port + Protocol + State

NGFW
     ↓
Traditional Firewall Features
     +
Application Awareness
     +
DPI
     +
IDS/IPS
     +
User / URL Controls
```

And:

```text
Stateless:
Packet
  ↓
Check IP / Port / Protocol
  ↓
Check Rule
  ↓
ALLOW / DROP
```

```text
Stateful:
Packet
  ↓
Check Connection State
  ↓
Check State Table + Rules
  ↓
ALLOW / DROP
```
