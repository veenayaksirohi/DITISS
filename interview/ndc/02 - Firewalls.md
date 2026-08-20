# Firewalls — Detailed Notes

# 1. Firewall Fundamentals

## 1.1 What is a Firewall?

A **Firewall** is a security system that monitors and controls network traffic based on predefined security rules. It decides whether traffic should be **Allowed**, **Blocked**, **Rejected**, or **Logged**.
A firewall can protect: one computer, one server, one network, or an entire organization.

> A firewall is a security barrier between a trusted network and an untrusted network.

```text
Internet (untrusted) → Firewall → Internal Network (trusted)
```

## 1.2 Why is a Firewall Used?

Block unauthorized access, allow legitimate traffic, control incoming/outgoing traffic, restrict ports/IPs, reduce attack surface, protect internal systems, prevent unwanted connections, log suspicious traffic.

### Example

```text
Web Server (443)      → Internet → ALLOW
Database Server (3306) → Internet → BLOCK
```

This reduces unnecessary exposure.

## 1.3 Where is a Firewall Used?

**Network Firewall** — placed between networks, protects multiple systems.

```text
Internet → Network Firewall → Company LAN
```

Examples: pfSense, Cisco Firewall, Palo Alto, FortiGate.

**Host-Based Firewall** — installed directly on a computer or server.

```text
Internet → Linux Server → iptables / nftables
```

Examples: Windows Defender Firewall, iptables, nftables, UFW, firewalld.

> Full comparison of Host vs Network Firewall is in Section 13.

## 1.4 How Does a Firewall Work?

```text
Packet Arrives → Firewall Reads Packet Info → Checks Rules → Match Found?
  Yes → Apply Action        No → Apply Default Policy
```

The firewall may check: Source IP, Destination IP, Source port, Destination port, Protocol, Direction, Interface, Connection state, and (in advanced firewalls) Application.

### Example

```text
Packet: Source 10.10.10.5 → Destination 192.168.1.10, TCP Port 22

Rule 1: Allow TCP 22 from 192.168.1.100
Rule 2: Block TCP 22 from everyone else

Result: No match on Rule 1 → matches Rule 2 → DROP
```

## 1.5 Firewall Rules

A **firewall rule** tells the firewall what traffic should be allowed or denied. A rule normally contains: Source, Destination, Protocol, Port, Direction, Action.

```text
Source: 192.168.1.50 → Destination: 192.168.1.100, Protocol: TCP, Port: 22, Action: ALLOW
```

Meaning: Allow `192.168.1.50` to connect to SSH port 22 on `192.168.1.100`.

### Main Parts of a Rule

- **Source IP** — where traffic comes from, e.g. `192.168.1.10`
- **Destination IP** — where traffic is going, e.g. `10.0.0.20`
- **Protocol** — TCP, UDP, ICMP, etc.
- **Port** — `22 SSH, 80 HTTP, 443 HTTPS, 3306 MySQL, 5432 PostgreSQL`
- **Action** — see below

### Firewall Actions

- **ACCEPT/ALLOW** — permit the packet: `Packet → Firewall → ACCEPT → Destination`
- **DROP** — silently discard the packet, no response sent: `Packet → Firewall → DROP`
- **REJECT** — block the packet and usually notify the sender: `Packet → Firewall → REJECT → Error Response`

### Rule Example

Web server `192.168.10.20`, only HTTPS should be reachable:

```text
ALLOW TCP 443 → 192.168.10.20
DROP  TCP 80  → 192.168.10.20
DROP  ALL OTHER UNNECESSARY TRAFFIC
```

This follows the principle: **Allow only what is required.**

## 1.6 Default Allow vs Default Deny

**Default Allow** — traffic is allowed unless specifically blocked.

```text
Default: ALLOW ALL
Rule: BLOCK 10.10.10.5
```

Less secure — if you forget to block a service (SSH, Database, RDP, Admin Panel), it may remain accessible, increasing the attack surface.

**Default Deny** — traffic is blocked unless explicitly allowed.

```text
Default Policy: DROP
Allow TCP 22 from Admin IP
Allow TCP 443 from Internet
```

More secure, follows **least privilege**.

### Worked Example (Default Deny)

Server requirements: HTTPS required; SSH admin-only; MySQL internal-only.

```text
ALLOW TCP 443 from ANY
ALLOW TCP 22   from 192.168.1.50
ALLOW TCP 3306 from 10.0.2.10
DEFAULT DROP
```

### Comparison Table

| Default Allow                        | Default Deny                      |
| ------------------------------------ | --------------------------------- |
| Everything allowed unless blocked    | Everything blocked unless allowed |
| Easier initially                     | More secure                       |
| Higher chance of accidental exposure | Lower attack surface              |
| Block bad traffic                    | Allow only required traffic       |
| Less restrictive                     | Least-privilege approach          |

> **Interview Recommendation:** For security-sensitive systems, **Default Deny is generally preferred.**

## 1.7 Rule Order

Firewall rules are usually processed top to bottom; the first match applies.

```text
Rule 1: ALLOW TCP 22 from ANY
Rule 2: DROP  TCP 22 from 10.10.10.5   ← never reached, Rule 1 already matched
```

Correct order:

```text
Rule 1: DROP  TCP 22 from 10.10.10.5
Rule 2: ALLOW TCP 22 from trusted network
```

> **Interview Point:** Firewall rule order matters because many firewalls process rules top to bottom and apply the first matching rule.

## 1.8 Inbound vs Outbound Traffic

**Inbound** — traffic coming **into** a system/network: `Internet → Server`. Example: `Internet → HTTPS 443 → Web Server`.
**Outbound** — traffic **leaving** a system/network: `Server → Internet`. Example: `Internal Server → DNS Server`.

### Why Control Outbound Traffic Too?

Some assume only inbound needs protection, but outbound filtering matters too. If malware infects a server and tries `Compromised Server → C2 Server`:

```text
Unrestricted outbound: Malware → Internet → Allowed
Controlled outbound:   Malware → Unknown Destination → Firewall → Blocked
```

### Rule Examples

Public web server `192.168.1.10` — HTTPS public, SSH admin-only:

```text
Inbound:
ALLOW TCP 443 from ANY
ALLOW TCP 22  from 192.168.1.50
DROP everything else
```

Database server — internal traffic only, no free Internet access:

```text
Outbound:
ALLOW required internal traffic
DENY unnecessary outbound traffic to Internet
```

This reduces malware command-and-control and data-exfiltration opportunities.

### Comparison Table

| Inbound                                        | Outbound                        |
| ---------------------------------------------- | ------------------------------- |
| Traffic entering system/network                | Traffic leaving system/network  |
| Protects against unwanted incoming connections | Controls external communication |
| Example: allow HTTPS 443                       | Example: allow DNS 53           |
| Internet → Server                              | Server → Internet               |

### Perspective Matters

Suppose `PC → Web Server`. For the **PC**: request = Outbound, response = Inbound. For the **Web Server**: request = Inbound, response = Outbound.

> Inbound/outbound is always relative to the device or firewall being discussed.

---

# 2. Packet Filtering Firewall

## 2.1 Meaning

A **Packet Filtering Firewall** examines individual packets and makes decisions using packet header information: Source IP, Destination IP, Source port, Destination port, Protocol.

```text
Packet → Check Source IP / Destination IP / Port / Protocol → Allow / Block
```

Works mainly at **Layer 3 (Network)** and **Layer 4 (Transport)**.

## 2.2 Example

```text
Rule: ALLOW TCP, Source ANY, Destination 192.168.1.10, Port 443
Packet: Source 8.8.8.8 → 192.168.1.10, TCP, Port 443 → ALLOW
Packet: same source, Port 22, no matching rule → DROP
```

## 2.3 Advantages

Fast, simple, low resource usage, easy to configure for basic traffic, good for IP/port-based filtering.

## 2.4 Limitations

Traditional/simple packet filtering may not understand application behavior, user identity, packet content, or complete connection context. E.g. `TCP 80 allowed` — the firewall knows it's port 80, but may not deeply understand whether the HTTP request itself is malicious.

---

# 3. Stateless Firewall

## 3.1 Meaning

A **Stateless Firewall** checks each packet independently — it does **not remember previous packets or connection state**.

```text
Packet 1 → Check Rule → Allow/Drop
Packet 2 → Check Rule → Allow/Drop
```

Each packet is treated separately.

## 3.2 How It Works

Client sends `TCP SYN` → firewall checks Source IP, Destination IP, Port, Protocol. Server replies `SYN-ACK` → the firewall checks this reply as a **completely separate packet**; it does not automatically know it belongs to the connection the client started.

## 3.3 Example

Rule: `ALLOW outgoing TCP 443`. Client → Website:443 is allowed. But the reply (Website → Client) may need another explicit rule, since a stateless firewall doesn't recognize it as return traffic.

## 3.4 Advantages

Very fast, simple, low memory usage, useful for simple/basic ACL-style filtering.

## 3.5 Disadvantages

Doesn't track sessions or connection state, may need more rules, less security context, return traffic may need separate rules.

---

# 4. Stateful Firewall

## 4.1 Meaning

A **Stateful Firewall** remembers active network connections via a **state table**, tracking states such as `NEW`, `ESTABLISHED`, `RELATED`, `INVALID`.

```text
Packet Arrives → Check Rules → Check Connection State → Check State Table → Allow/Drop
```

Fuller flow:

```text
Packet Arrives → Check State Table → Existing/Related Connection?
  Yes → Check Policy         No → Check New-Connection Rule
              └──────────┬──────────┘
                    Allow / Drop
```

## 4.2 How It Works

`Client → Web Server:443`. Client sends `SYN` → firewall allows it and creates an entry `Client:50000 → Server:443, State = NEW`. Server responds `SYN-ACK` → recognized as belonging to the existing connection → allowed. On handshake completion: `State = ESTABLISHED`.

## 4.3 Example

```text
192.168.1.10:50000 → Firewall → 8.8.8.8:443
State table: Source 192.168.1.10:50000, Destination 8.8.8.8:443, Protocol TCP, State ESTABLISHED
```

Reply traffic (`8.8.8.8:443 → 192.168.1.10:50000`) matches the table → `ALLOW`.

## 4.4 Connection Tracking

The firewall keeps information about active connections:
| Source | Destination | Protocol | State |
|---|---|---|---|
| 192.168.1.10:51000 | 8.8.8.8:443 | TCP | ESTABLISHED |
| 192.168.1.20:52000 | 1.1.1.1:53 | UDP | Tracked |
| 192.168.1.30:53000 | 10.0.0.10:22 | TCP | NEW |

## 4.5 Common Connection States

- **NEW** — a connection is starting, e.g. `Client → SYN → Server`
- **ESTABLISHED** — connection exists and data is being exchanged
- **RELATED** — a new connection related to an existing one
- **INVALID** — packet cannot be associated with a valid connection; may be dropped

## 4.6 Advantages

Tracks active sessions, better security decisions, automatically handles legitimate return traffic, fewer rules required, detects unexpected packets better than simple filtering.

## 4.7 Disadvantages

More memory/CPU usage, maintains state tables, very large connection counts may consume resources, more complex than stateless filtering.

---

# 5. Stateful vs Stateless Firewall

| Feature                    | Stateless                  | Stateful                          |
| -------------------------- | -------------------------- | --------------------------------- |
| Tracks connection          | No                         | Yes                               |
| Remembers previous packets | No                         | Yes                               |
| Checks packet individually | Yes                        | Yes, plus connection state        |
| State table                | No                         | Yes                               |
| Return traffic             | Needs explicit rules       | Recognizes valid reply traffic    |
| Resource usage             | Lower                      | Higher                            |
| Security context           | Less                       | More                              |
| Configuration              | Simple                     | More advanced                     |
| Example use                | Basic ACL/packet filtering | Modern firewall/session filtering |

### Memory Aid

```text
STATELESS → "What does this packet look like?"
STATEFUL  → "What does this packet look like, and does it belong to a valid connection?"
```

---

# 6. Real-Life Scenario — Stateful Firewall in Action

A user opens `https://example.com`: `192.168.1.20:51000 → Firewall → 93.184.216.34:443`.
The firewall allows outbound HTTPS and records `192.168.1.20:51000 ↔ 93.184.216.34:443`. When the server replies, the firewall sees an **ESTABLISHED** connection and allows it.
If an unknown Internet host suddenly sends `Unknown IP → 192.168.1.20:51000` with no matching state, the firewall can block it.

---

# 7. Scenario-Based Interview Questions — Basic Firewall Concepts

1. **Internal users should browse the Internet, but Internet users should not initiate connections inward. What firewall behavior helps?**
   Use a **stateful firewall** — it allows internal users to start connections and permits valid responses, while blocking unsolicited inbound connections.

2. **A firewall filters only by source/destination IP, protocol, and port, with no session memory. What kind of firewall is this?**
   **Stateless packet-filtering firewall.**

3. **How does a stateful firewall know a reply from a web server is legitimate?**
   It checks its **connection/state table** and confirms the packet belongs to an existing established session.

4. **A firewall rule says `ALLOW ANY ANY`. Why is this dangerous?**
   It allows unnecessary traffic and greatly increases the attack surface. Better: `Default Deny + Allow Required Services Only`.

5. **Only admin `192.168.1.50` should access SSH on a server. What rule would you use?**

```text
ALLOW: Source = 192.168.1.50, Destination = Server, Protocol = TCP, Port = 22
DROP other TCP 22 traffic
```

---

# 8. Common Interview Questions — Basic Firewall Concepts

- **What is a firewall?** > A security control that monitors and filters incoming and outgoing network traffic according to predefined rules.
- **What does a firewall check?** Source IP, Destination IP, Port, Protocol, Direction, Connection state; advanced firewalls may also inspect applications and content.
- **What is a firewall rule?** > Defines what traffic should be allowed or denied based on conditions such as IP address, port, protocol, direction, or connection state.
- **What is packet filtering?** > Checks packet header information (source/destination IP, ports, protocol) to decide whether traffic should be allowed or blocked.
- **What is a stateless firewall?** > Examines every packet independently and does not remember previous packets or sessions.
- **What is a stateful firewall?** > Tracks active connections and uses connection state along with firewall rules to decide whether packets should be allowed.

---

# 9. Next Generation Firewall (NGFW)

## 9.1 Meaning

An **NGFW** is an advanced firewall that does more than basic IP/port/protocol filtering. A traditional firewall mainly checks Source IP, Destination IP, Port, Protocol, Connection State. An NGFW can also understand which application is being used, which user is generating traffic, what type of content is inside the traffic, whether it matches known attack patterns, and whether malware/suspicious behavior is present.

> An NGFW is an advanced firewall that combines traditional firewall functions with application awareness, deep packet inspection, and often IDS/IPS capabilities.

## 9.2 Why NGFW Is Needed

Traditional firewalls mainly decide using `IP + Port + Protocol`, but modern applications don't always use fixed ports — YouTube, Facebook, Gmail, Google Drive, and WhatsApp Web may all use `TCP 443`. A traditional firewall may only see "HTTPS on 443" without knowing which application is inside. An NGFW can identify applications more accurately:

```text
Traffic (TCP 443) → NGFW → Identify Application → YouTube → Policy: BLOCK → Blocked
```

## 9.3 Main Features

**Traditional functions retained**: IP/Port/Protocol filtering, stateful inspection, NAT, firewall rules.
**Application Awareness** — can identify applications on the same port:

```text
Port 443 → NGFW identifies: YouTube, Google Drive, Facebook, Office 365
```

So instead of `Block TCP 443` you can write `Allow Office 365 / Block YouTube / Allow Google Drive` without blocking all HTTPS.

## 9.4 Application Control

Creating security policies based on the application instead of only the port:

```text
Allow → Gmail, Microsoft Teams
Block → Torrent, Gaming Applications
```

## 9.5 Deep Packet Inspection (DPI)

Inspecting more than basic packet headers. A normal packet-filtering firewall inspects Source/Destination IP, Source/Destination Port, Protocol. DPI additionally inspects application traffic, protocol behavior, content patterns, and security signatures.

```text
Packet → Header + Payload/Application Info → Deep Inspection
```

> Encrypted HTTPS traffic can't simply be read as plaintext; some organizations use controlled TLS inspection where legally and operationally appropriate.

## 9.6 IDS/IPS Integration

Many NGFWs include or integrate IDS (`Attack → IDS → Alert`) and IPS (`Attack → IPS → DROP`).

```text
Packet → Firewall Rules → Application Identification → IPS Inspection → Allow/Block
```

## 9.7 User-Based Policies

An NGFW may integrate with identity systems, e.g. `Allow Finance Users → Banking Website` / `Block Guest Users → Internal Applications`. Called **user-aware security policy**.

## 9.8 URL Filtering

Restricts access based on websites/categories (social media, gambling, malware, adult content, file sharing, shopping).

```text
Employee → Request malicious-site.example → NGFW URL Filter → Blocked
```

## 9.9 Malware / Threat Protection

May inspect traffic for known malware, exploit signatures, command-and-control communication, and suspicious downloads — often combined with Threat Intelligence + IPS + URL Filtering + Malware Analysis.

## 9.10 Example

```text
Employee tries BitTorrent.
Traditional Firewall: Traffic → TCP 443 → sees HTTPS → possibly ALLOW
NGFW: Traffic → TCP 443 → Application Inspection → App = BitTorrent → Policy = BLOCK → Blocked
```

## 9.11 Common NGFW Features & Vendors

Stateful firewall, application identification/control, DPI, IDS/IPS, URL filtering, user-based policies, NAT, VPN, threat intelligence integration, logging/reporting, malware/threat protection.
Vendors: Palo Alto Networks, Fortinet FortiGate, Cisco Secure Firewall, Check Point, Sophos Firewall.

## 9.12 Traditional Firewall vs NGFW

| Feature                    | Traditional Firewall | NGFW             |
| -------------------------- | -------------------- | ---------------- |
| IP/Port/Protocol Filtering | Yes                  | Yes              |
| Stateful Inspection        | Common               | Yes              |
| NAT                        | Yes                  | Yes              |
| Application Awareness      | Limited/No           | Yes              |
| Application Control        | Limited              | Yes              |
| Deep Packet Inspection     | Limited              | Yes              |
| IDS/IPS                    | Usually separate     | Often integrated |
| User-Based Rules           | Limited              | Common           |
| URL Filtering              | Usually separate     | Often integrated |
| Threat Intelligence        | Limited              | Common           |
| Advanced Threat Detection  | Limited              | Better support   |

### Easy Example

YouTube, Online Banking, and Microsoft Teams all use `TCP 443`.
**Traditional Firewall:** if 443 is allowed, all three → Allowed.
**NGFW:** `TCP 443 → NGFW → YouTube BLOCK, Banking ALLOW, Teams ALLOW`.

> **Interview Answer:** A traditional firewall mainly controls traffic using IP addresses, ports, protocols, and connection state. An NGFW adds application awareness, deep packet inspection, IDS/IPS, URL filtering, user-based policies, and threat intelligence.

---

# 10. Proxy Firewall

## 10.1 Meaning

A **Proxy Firewall** acts as an intermediary between a client and the destination server. The client does not directly communicate with the destination; the proxy creates a separate connection to the destination on the client's behalf.

```text
Client → Proxy Firewall → Internet Server
```

## 10.2 How It Works

Without proxy: `Client → example.com`. With proxy: `Client → Proxy Firewall → Checks Request → Creates New Connection → example.com`. The destination server may see the proxy's address rather than the client's direct connection.

## 10.3 Why It's Secure

Client and destination don't necessarily communicate directly — the proxy can inspect the application request, URL, headers, protocol behavior, content (where technically possible), user identity, and security policy.

## 10.4 Example

```text
Policy: Allow docs.company.com, Block social-media.example
Flow: Employee → Proxy → Check URL → Allowed? Yes → Forward | No → Block
```

## 10.5 Application-Level Proxy

Often operates at the **Application Layer** — HTTP proxy, FTP proxy, SMTP proxy — understanding the specific application protocol.

```text
HTTP Request → HTTP Proxy → Analyze Request → Forward / Block
```

## 10.6 Advantages and Disadvantages

**Advantages** — hides internal clients, application-level control, can inspect application requests, URL filtering, user authentication, logging, reduces direct exposure.
**Disadvantages** — more processing overhead, can add latency, more complex configuration, proxy support may be application/protocol specific.

## 10.7 Forward Proxy vs Proxy Firewall

A forward proxy represents clients: `Client → Forward Proxy → Internet`. Common purposes: Internet access control, URL filtering, caching, hiding internal client addresses, logging. Example tool: `Squid`.

---

# 11. Host Firewall

Runs directly on an individual computer or server and protects that particular host.

```text
Internet → Linux Server → iptables / nftables
Network  → Windows Server → Windows Defender Firewall
```

Examples: Linux (iptables, nftables, UFW, firewalld), Windows (Windows Defender Firewall).
Can control: incoming/outgoing connections, ports, protocols, source/destination IPs, and (depending on the firewall) local applications.

```text
Linux Server:
Allow TCP 22  from 192.168.1.50
Allow TCP 443 from ANY
Drop everything else
```

---

# 12. Network Firewall

Placed between networks and protects multiple devices, filtering traffic passing between networks rather than protecting only one machine.

```text
Internet → Network Firewall → Server 1 / Server 2 / PC
```

Common placements:

```text
Internet → Network Firewall → LAN
Internet → Firewall → DMZ → Internal Firewall → Internal Network
```

---

# 13. Host Firewall vs Network Firewall

| Feature                     | Host Firewall        | Network Firewall          |
| --------------------------- | -------------------- | ------------------------- |
| Installed on                | Individual device    | Between networks          |
| Protects                    | One host             | Multiple systems/network  |
| Traffic visibility          | Traffic to/from host | Traffic crossing firewall |
| Example                     | iptables             | pfSense                   |
| Local protection            | Strong               | Depends on traffic path   |
| Protects host from same LAN | Can                  | Not always                |
| Central management          | Depends              | Often centralized         |

### Example

`PC1 → PC2` on the same local network. If this traffic never passes through the network firewall, the perimeter firewall may not inspect it — but if PC2 has a host firewall, it can still block it: `PC1 → Host Firewall on PC2 → PC2 Application`.

### Why Use Both?

This is **Defence in Depth**:

```text
Internet → Network Firewall → Internal Network → Host Firewall → Server
```

If one layer fails, the other still provides protection.

---

# 14. Firewall Evolution

```text
Packet Filtering → Check IP/Port/Protocol
        ↓
Stateful Firewall → Track Connections
        ↓
Proxy Firewall → Application-Level Inspection
        ↓
NGFW → Application Awareness + DPI + IDS/IPS + User Awareness + Threat Intelligence
```

---

# 15. Scenario-Based Interview Questions — Advanced Firewall Concepts

1. **Employees need Microsoft Teams, but management wants to block YouTube — both use HTTPS 443. How?**
   A simple port-based firewall can't distinguish them. Use an **NGFW with application control**: `TCP 443 → NGFW → Identify Application → Teams ALLOW, YouTube BLOCK`.

2. **Firewall allows TCP 443, but users are using unwanted applications over HTTPS. What's the problem?**
   The firewall is relying mainly on ports. An NGFW provides application identification/control, URL filtering, DPI, IDS/IPS.

3. **A company wants employees' web requests checked centrally against URL policy before Internet access.**
   Use a **proxy firewall / forward proxy**: `Employee → Proxy → URL/Policy Check → Internet`.

4. **Two compromised PCs communicate inside the same LAN without passing through the perimeter firewall. What helps?**
   Use **host-based firewalls** on the endpoints (`PC1 → Host Firewall on PC2 → PC2`) and consider network segmentation.

5. **A firewall permits all traffic except a few explicitly blocked ports — good design?**
   This is **default allow** and can lead to accidental exposure. Safer: `Default Deny + Explicitly Allow Required Traffic`.

6. **Public web server: HTTPS for everyone, SSH only for the admin.**

```text
Inbound: ALLOW TCP 443 from ANY, ALLOW TCP 22 from Admin IP, DEFAULT DROP
```

7. **A database server should only talk to the internal app server, not the open Internet.**

```text
ALLOW required internal traffic
DENY unnecessary outbound traffic
```

Reduces malware C2 / data-exfiltration opportunities.

8. **An employee opens an HTTPS site — why can the reply enter even though random inbound traffic is blocked?**
   Because a **stateful firewall** remembers the internal user initiated the connection: `Client starts HTTPS → state stored → Server Response matches ESTABLISHED → ALLOW`. Random unsolicited inbound traffic doesn't match the state table and can be blocked.

---

# 16. Quick Revision Table — Advanced Concepts

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

# 17. Most Important Interview Questions (Master List)

1. What is a firewall? 2. What does a firewall check? 3. What is a firewall rule? 4. What is packet filtering? 5. What is a stateless firewall? 6. What is a stateful firewall? 7. Why does a stateful firewall allow return traffic? 8. What is a connection/state table? 9. What is an NGFW? 10. Why do we need NGFW? 11. Traditional firewall vs NGFW? 12. What is application awareness? 13. What is application control? 14. What is Deep Packet Inspection? 15. How can an NGFW identify applications using the same port? 16. What is a proxy firewall? 17. How does a proxy firewall work? 18. Forward proxy vs firewall? 19. What is a host firewall? 20. What is a network firewall? 21. Host firewall vs network firewall? 22. Why use both network and host firewalls? 23. What is Default Allow? 24. What is Default Deny? 25. Which one is more secure? 26. What is an inbound firewall rule? 27. What is an outbound firewall rule? 28. Why should outbound traffic be filtered?

---

# 18. One-Line Interview Revision (Master Summary)

```text
Firewall → Controls network traffic according to security rules.
Firewall Rule → Defines which traffic is allowed or blocked.
Packet Filtering → Checks IP, port and protocol.
Stateless Firewall → Checks every packet separately, does not remember connections.
Stateful Firewall → Tracks active connections, maintains a state table, recognizes legitimate return traffic.
NGFW → Traditional firewall + application awareness + advanced security inspection.
Traditional Firewall → Mainly checks IP, port, protocol and connection state.
Proxy Firewall → Acts as an intermediary between client and destination.
Host Firewall → Protects one computer/server.
Network Firewall → Protects traffic flowing between networks.
Default Allow → Everything allowed unless specifically blocked.
Default Deny → Everything blocked unless specifically allowed.
Inbound Rule → Controls traffic coming into a system/network.
Outbound Rule → Controls traffic leaving a system/network.
```

### Best Flow to Remember

```text
Traditional Firewall → IP + Port + Protocol + State
NGFW → Traditional Firewall Features + Application Awareness + DPI + IDS/IPS + User/URL Controls
```

```text
Stateless: Packet → Check IP/Port/Protocol → Check Rule → ALLOW/DROP
Stateful:  Packet → Check Connection State → Check State Table + Rules → ALLOW/DROP
```
