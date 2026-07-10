# Session 3 & 5: Firewall Technologies, iptables, and Wireshark

**Session 3 (2T + 4L):** Packet Filtering, Screened Host Firewall, Stateful Inspection Firewall, Next-Gen Firewall (App Controls), iptables — Linux Firewall
**Session 5 (2T + 2L + 2SL):** Wireshark, Capture/Display Filters, Real-World Packet Capture Analysis

---

# Session 3: Firewall Technologies

## 1. Packet Filtering Firewall

The simplest firewall technique — inspects only packet headers and applies rules.

**Working:**
- Operates at OSI Layers 3 and 4
- Checks: Source/Destination IP, Source/Destination Port, Protocol (TCP/UDP/ICMP)
- Does **not** inspect payload

**Example Rule — Allow HTTP traffic:**
| Field | Value |
|---|---|
| Source | Any |
| Destination Port | 80 |
| Protocol | TCP |

| Advantages | Disadvantages |
|---|---|
| Fast and efficient | Stateless (no session tracking) |
| Low resource usage | Cannot detect application-layer attacks |
| Easy to configure | Vulnerable to IP spoofing |

---

## 2. Screened Host Firewall

A hybrid architecture combining a packet-filtering router and a bastion host.

**Architecture:**
```
Internet → Packet Filter Router → Bastion Host → Internal Network
```

**Components:**
- **Router:** Filters traffic at Layers 3/4
- **Bastion Host:** Hardened system exposed to the internet; performs application-level inspection

**Key Points:**
- Only the bastion host is directly exposed
- Internal network stays hidden

| Advantages | Disadvantages |
|---|---|
| Better security than packet filtering | Bastion host can become a bottleneck |
| Supports application-level filtering | More configuration overhead |
| Network isolation | |

---

## 3. Stateful Inspection Firewall

Also known as **dynamic packet filtering**.

**Working:**
- Maintains a **state table** of active connections
- Tracks TCP handshake (SYN, SYN-ACK, ACK), session state, and sequence numbers
- Allows only valid session traffic

**OSI Layers:** 3, 4, partially 5

**Example:**
- Outgoing request → allowed
- Incoming response → allowed only if a matching session exists

| Advantages | Disadvantages |
|---|---|
| More secure than stateless filtering | Higher memory and CPU usage |
| Detects abnormal packets | No deep payload inspection |

---

## 4. Next Generation Firewall (NGFW)

Advanced firewall with deep packet inspection and application awareness.

**Key Features:**
- Deep Packet Inspection (DPI)
- Intrusion Prevention System (IPS)
- Application identification (even on non-standard ports)
- User-based policies
- SSL/TLS inspection
- Threat intelligence integration

**Application Control Use Cases:**
- Block specific app features (e.g., chat within social media apps)
- Limit bandwidth usage
- Detect encrypted threats

| Advantages | Disadvantages |
|---|---|
| Granular control | Expensive |
| Multi-layer security | Requires ongoing signature updates |
| Supports Zero Trust | Can impact performance |

---

## 5. iptables (Linux Firewall)

`iptables` is a command-line firewall tool based on the **netfilter** framework in Linux.

**Chains:**
| Chain | Purpose |
|---|---|
| INPUT | Incoming traffic to the system |
| OUTPUT | Outgoing traffic |
| FORWARD | Routed traffic |

**Tables:**
| Table | Purpose |
|---|---|
| filter | Default packet filtering |
| nat | Network Address Translation |
| mangle | Packet modification |

**Example Rules:**

Block SSH:
```bash
iptables -A INPUT -p tcp --dport 22 -j DROP
```

Allow HTTP:
```bash
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

Default policies:
```bash
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
```

| Advantages | Disadvantages |
|---|---|
| Highly flexible | Complex syntax |
| Native to Linux | Hard to scale manually |
| Powerful rule control | Being replaced by nftables |

---

## Session 3 — Quick Comparison Table

| Firewall Type | OSI Layer | State Awareness | Payload Inspection | Cost |
|---|---|---|---|---|
| Packet Filtering | 3–4 | No | No | Low |
| Screened Host | 3–4 + App | Partial (via bastion) | Yes (bastion) | Medium |
| Stateful Inspection | 3–5 | Yes | No | Medium |
| NGFW | 3–7 | Yes | Yes (DPI) | High |

---

# Session 5: Wireshark and Traffic Analysis

## 1. What is Wireshark?

Wireshark is a network protocol analyzer used to capture and inspect packets in real time.

**Uses:**
- Network troubleshooting
- Security analysis
- Protocol learning
- Incident response

---

## 2. Types of Filters in Wireshark

### Capture Filters
- Applied **before** packet capture
- Uses BPF (Berkeley Packet Filter) syntax

**Examples:**
```
tcp port 80        → capture HTTP
host 192.168.1.1
port 443
```

### Display Filters
- Applied **after** capture
- More powerful and flexible

**Examples:**
```
ip.addr == 192.168.1.5
tcp.flags.syn == 1
http.request.method == "GET"
dns.qry.name == "example.com"
```

---

## 3. Real-World Packet Analysis

### HTTP Analysis
Filter: `http`
Look for: Request URI, Host, Response codes

### TCP Handshake
Filter: `tcp`

Steps:
```
1. SYN
2. SYN-ACK
3. ACK
```
Detect: retransmissions, packet loss, connection issues

### DNS Analysis
Filter: `dns`

Key Fields:
- `dns.qry.name`
- `dns.a` (resolved IP)

Use case: Detect DNS spoofing or malicious domains

### TLS/SSL Analysis
Filter: `tls`

Check: TLS version, certificates, cipher suites
Note: Cannot decrypt traffic without the keys

### ICMP Analysis
Filter: `icmp`

Used for: Ping, connectivity testing

---

## 4. Advanced Filtering

Combine filters using logical operators:
```
ip.src == 10.0.0.1 and tcp.port == 22
not dns
```

**Tips:**
- Use logical operators: `and`, `or`, `not`
- Save frequently used filters
- Apply color rules for quick visual triage

---

## 5. Wireshark Interface

| Pane | Description |
|---|---|
| Packet List | Summary of captured packets |
| Packet Details | Layer-wise protocol breakdown |
| Hex Dump | Raw byte-level data |
| Filter Bar | Apply display filters |
| Capture Options | Select capture interface |

---

## 6. Wireshark Use Cases

| Use Case | Description |
|---|---|
| Troubleshooting | Detect latency, packet drops |
| Security Monitoring | Detect scans, malware traffic |
| Pen Testing | Analyze exploits |
| Incident Response | Reconstruct attack timeline |

---

## Quick Revision — Key Points
- **Packet Filtering:** Layer 3/4, stateless, header-only checks
- **Screened Host:** Router + bastion host, bastion is the only exposed system
- **Stateful Inspection:** Tracks session/connection state via state table
- **NGFW:** DPI + IPS + app awareness + SSL inspection
- **iptables:** Chains (INPUT/OUTPUT/FORWARD) + Tables (filter/nat/mangle)
- **Wireshark Capture Filters:** BPF syntax, applied pre-capture
- **Wireshark Display Filters:** Applied post-capture, field-based (e.g., `ip.addr`, `tcp.flags.syn`)
