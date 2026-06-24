# Firewall

A firewall is a network security device or software that monitors incoming and outgoing traffic and allows only authorized communication based on predefined rules.

## Firewall Architecture Classification

> **Exam Note:** Firewall placement determines the **security zones** created in a network.
> More tiers = more granular control but more complexity and cost.

---

## 1. Single-Tier Architecture

**Concept:** One firewall with 3 interfaces separates Internet, DMZ, and LAN.
The DMZ is carved out using a dedicated interface/VLAN on the same firewall.

**Scenario:** Public users access a webserver in the DMZ.
The webserver is reachable from the Internet but **isolated from the internal LAN**.
The single firewall enforces both Internet→DMZ and DMZ→LAN rules.

```
                        SINGLE-TIER FIREWALL ARCHITECTURE
                        ===================================

  ┌─────────────┐        ┌──────────────────────────────┐
  │             │        │       🔥 FIREWALL (1)         │
  │  INTERNET   │──────► │  eth0 (WAN)  │ Public IP     │
  │  (Untrusted)│        │──────────────────────────────│
  └─────────────┘        │  eth1 (DMZ)  │ 192.168.10.x │
                         │  eth2 (LAN)  │ 192.168.1.x  │
                         └──────┬───────┴───────┬───────┘
                                │               │
                    ┌───────────▼──────┐   ┌────▼──────────────────┐
                    │   🟡 DMZ ZONE    │   │   🟢 INTERNAL LAN     │
                    │  192.168.10.0/24 │   │   192.168.1.0/24      │
                    │                  │   │                        │
                    │  ┌────────────┐  │   │  ┌──────┐  ┌──────┐  │
                    │  │ Web Server │  │   │  │  PC  │  │  PC  │  │
                    │  │ :80 / :443 │  │   │  └──────┘  └──────┘  │
                    │  └─────┬──────┘  │   │                        │
                    │        │ DB query│   │  ┌──────────────────┐  │
                    │  ┌─────▼──────┐  │   │  │  Database Server │  │
                    │  │ Mail Server│  │◄──┼──│  MySQL :3306     │  │
                    │  └────────────┘  │   │  └──────────────────┘  │
                    └──────────────────┘   └────────────────────────┘

  TRAFFIC RULES:
  ─────────────
  Internet  ──►  DMZ  (port 80, 443)         ✅ ALLOW
  Internet  ──►  LAN  (any port)             ❌ DENY
  DMZ       ──►  LAN  (DB port 3306 only)    ✅ ALLOW (restricted)
  DMZ       ──►  LAN  (other ports)          ❌ DENY
  LAN       ──►  Internet (any)              ✅ ALLOW (via NAT)

  ⚠️  WEAKNESS: Single point of failure. If this firewall is
      compromised, BOTH DMZ and LAN are exposed.
```

---

## 2. Two-Tier Architecture

**Concept:** Two firewalls in series create **three distinct security zones**.
- Zone 1: Internet (Untrusted)
- Zone 2: DMZ (Semi-trusted — public-facing servers)
- Zone 3: LAN (Trusted — internal network)

**Scenario:** Internet users hit **FW1 (Outer Firewall)** which only permits traffic
to the DMZ. A **second firewall FW2 (Inner Firewall)** separates DMZ from LAN.
Even if the DMZ webserver is compromised, the attacker must still bypass FW2.

```
                        TWO-TIER FIREWALL ARCHITECTURE
                        ================================

  ┌─────────────┐     ┌────────────┐     ┌───────────────────────────┐
  │             │     │ 🔥 FW1     │     │      🟡 DMZ ZONE          │
  │  INTERNET   │────►│  (Outer /  │────►│      192.168.10.0/24      │
  │  (Untrusted)│     │  Perimeter)│     │                           │
  └─────────────┘     └────────────┘     │  ┌────────────────────┐  │
                                         │  │   Web Server       │  │
         Allow: 80, 443 to DMZ only      │  │   Nginx :80/:443   │  │
         Block: All other traffic        │  └──────────┬─────────┘  │
                                         │             │             │
                                         │  ┌──────────▼─────────┐  │
                                         │  │   Reverse Proxy    │  │
                                         │  │   (Optional)       │  │
                                         │  └──────────┬─────────┘  │
                                         └─────────────┼────────────┘
                                                        │
                                               ┌────────▼───────┐
                                               │   🔥 FW2       │
                                               │   (Inner /     │
                                               │   Backend FW)  │
                                               └────────┬───────┘
                                                        │
                                         Allow: DB port 3306 from DMZ only
                                         Block: DMZ → LAN (other ports)
                                                        │
                                         ┌──────────────▼────────────────┐
                                         │       🟢 INTERNAL LAN         │
                                         │       10.0.0.0/8              │
                                         │                               │
                                         │  ┌──────┐    ┌────────────┐  │
                                         │  │  PC  │    │ App Server │  │
                                         │  └──────┘    └──────┬─────┘  │
                                         │                      │        │
                                         │            ┌─────────▼──────┐ │
                                         │            │ Database Server │ │
                                         │            │ MySQL :3306    │ │
                                         │            └────────────────┘ │
                                         │  ┌─────────────────────────┐  │
                                         │  │  Active Directory / DNS │  │
                                         │  └─────────────────────────┘  │
                                         └───────────────────────────────┘

  SECURITY ZONES:
  ───────────────
  Zone        │ Trust Level    │ Accessible From            │ Contains
  ────────────┼────────────────┼────────────────────────────┼──────────────────
  Internet    │ ❌ Untrusted   │ N/A                        │ Public users
  DMZ         │ ⚠️  Semi-trust │ Internet (port 80/443 only)│ Web, DNS, Proxy
  LAN         │ ✅ Trusted     │ LAN only (via FW2)         │ DB, App, PCs

  ✅ ADVANTAGE: Attacker must break TWO independent firewalls to reach LAN.
     Breach of DMZ does NOT automatically expose internal LAN.
```

---

## 3. N-Tier Architecture (Three-Tier Example)

**Concept:** Three or more firewalls create **multiple security zones** for
enterprise-grade segmentation. Each tier isolates one functional layer:
- Tier 1 (FW1): Internet → DMZ (Presentation Layer)
- Tier 2 (FW2): DMZ → App Zone (Application Layer)
- Tier 3 (FW3): App Zone → Data Zone (Data Layer)

**Scenario:** Used in banks, hospitals, e-commerce where the database must
be **completely isolated** from the Internet with multiple independent hops.

```
                        N-TIER FIREWALL ARCHITECTURE (3-TIER)
                        ======================================

  ┌────────────────────────────────────────────────────────────────────────┐
  │                          🌐 INTERNET (UNTRUSTED)                       │
  └─────────────────────────────────┬──────────────────────────────────────┘
                                    │  HTTP :80 / HTTPS :443
                                    ▼
                         ┌──────────────────────┐
                         │     🔥 FIREWALL 1    │
                         │  (Perimeter / Outer) │
                         │  Allow: 80,443 → DMZ │
                         │  Block: everything   │
                         └──────────┬───────────┘
                                    │
  ┌─────────────────────────────────▼────────────────────────────────────┐
  │                🟡 TIER 1 — DMZ / PRESENTATION ZONE                   │
  │                         192.168.10.0/24                              │
  │                                                                      │
  │   ┌─────────────┐    ┌─────────────┐    ┌──────────────────────┐   │
  │   │ Load Balancer│   │    WAF       │    │   Web Server 1 & 2   │   │
  │   │  (HAProxy)  │──►│(OWASP Filter)│──►│   Nginx :80/:443     │   │
  │   └─────────────┘    └─────────────┘    └──────────────────────┘   │
  │                                                                      │
  └─────────────────────────────────┬────────────────────────────────────┘
                                    │  App traffic :8080
                                    ▼
                         ┌──────────────────────┐
                         │     🔥 FIREWALL 2    │
                         │    (Mid / Internal)  │
                         │  Allow: 8080 from DMZ│
                         │  Block: DMZ → DB     │
                         └──────────┬───────────┘
                                    │
  ┌─────────────────────────────────▼────────────────────────────────────┐
  │                🟠 TIER 2 — APPLICATION ZONE                          │
  │                         10.10.0.0/24                                 │
  │                                                                      │
  │   ┌──────────────┐   ┌──────────────┐   ┌────────────────────────┐ │
  │   │ App Server 1 │   │ App Server 2 │   │   Cache / Queue        │ │
  │   │ Tomcat :8080 │   │ Django :8000 │   │  Redis  │  RabbitMQ   │ │
  │   └──────────────┘   └──────────────┘   └────────────────────────┘ │
  │                                                                      │
  └─────────────────────────────────┬────────────────────────────────────┘
                                    │  DB queries :3306 / :5432
                                    ▼
                         ┌──────────────────────┐
                         │     🔥 FIREWALL 3    │
                         │  (Inner / Data FW)   │
                         │  Allow: 3306 from App│
                         │  Block: DMZ & Internet│
                         └──────────┬───────────┘
                                    │
  ┌─────────────────────────────────▼────────────────────────────────────┐
  │                🔴 TIER 3 — DATA / SECURE ZONE                        │
  │                         10.20.0.0/24                                 │
  │                                                                      │
  │   ┌──────────────┐   ┌──────────────┐   ┌───────────────────────┐  │
  │   │ DB Primary   │──►│ DB Replica   │   │  Backup Server        │  │
  │   │ MySQL :3306  │   │ (Read-only)  │   │  (Encrypted)          │  │
  │   └──────────────┘   └──────────────┘   └───────────────────────┘  │
  │                                                                      │
  │   ┌──────────────────────────────────────────────────────────────┐  │
  │   │  🔑 Secret Vault (HashiCorp Vault) — Keys, Creds, Tokens    │  │
  │   └──────────────────────────────────────────────────────────────┘  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌──────────────────────────────────────────────────────────────────────┐
  │           🔵 MANAGEMENT ZONE — Out-of-Band (All Tiers)              │
  │                                                                      │
  │  ┌──────────────┐   ┌──────────────┐   ┌──────────────────────┐   │
  │  │  Jump Server │   │  SIEM System │   │   IDS / IPS          │   │
  │  │ (Bastion Host│   │ (Log Analysis│   │  (Snort/Suricata)    │   │
  │  │  SSH access) │   │  Splunk/ELK) │   │   Inline monitoring  │   │
  │  └──────────────┘   └──────────────┘   └──────────────────────┘   │
  └──────────────────────────────────────────────────────────────────────┘

  N-TIER REQUEST FLOW (Top to Bottom):
  ──────────────────────────────────────
  User (Internet)
    │
    ├─[1]─► FW1 checks: Is it port 80/443? → YES → forward to WAF
    │
    ├─[2]─► WAF scans for SQLi, XSS, OWASP Top 10 → Clean → Web Server
    │
    ├─[3]─► Web Server calls App Server → FW2 checks: port 8080? → ALLOW
    │
    ├─[4]─► App Server builds DB query → FW3 checks: port 3306? → ALLOW
    │
    └─[5]─► DB responds → App → Web → User  (reverse path)
```

---


## Types of Firewall

1. Hardware Firewall

A hardware firewall is a separate physical device that filters traffic between networks. It works independently from the computer it protects.

It is usually placed at the network level to protect many devices at once.

2. Software Firewall

A software firewall is a program installed on a computer or server that checks incoming and outgoing traffic.

It protects one device or a specific system.

Easy Difference:

| Type | Form | Protects | Example |
|---|---|---|---|
| Hardware firewall | Physical device | Whole network | Office firewall appliance |
| Software firewall | Program | One computer/server | Windows Defender Firewall |

## Filtering Technique

### 1. Packet Filtering Firewall

- Examines packet headers only.
- Makes decisions based on:
  - Source IP address
  - Destination IP address
  - Source port
  - Destination port
  - Protocol (TCP, UDP, ICMP, etc.)
- Operates up to the Transport Layer (Layer 4) of the OSI model.
- Does not inspect application data (payload).

OSI layers scanned:

- Layer 3 (Network)
- Layer 4 (Transport)

Example:

- Allow HTTP traffic on port 80 and block Telnet traffic on port 23.

### 2. Application Proxy Firewall (Application-Level Gateway)

- Acts as an intermediary between the client and the server.
- Inspects the entire packet, including the application data (payload).
- Can understand application protocols such as:
  - HTTP
  - HTTPS
  - FTP
  - SMTP
- Provides deeper security than packet filtering.

OSI layers scanned:

- Can inspect traffic up to the Application Layer (Layer 7).

Example:

- Block a specific website URL or detect malicious content inside an HTTP request.

## Firewall VPN / GRE





# iptables — Complete Study Notes

---

## 1. What is iptables?

- **iptables** is a **command-line utility** to configure and manage the **Linux kernel firewall**
- Works in two layers:

```
  ┌──────────────────────────────────────────────────────┐
  │              LINUX FIREWALL ARCHITECTURE             │
  │                                                      │
  │   USER SPACE          │    KERNEL SPACE              │
  │                        │                             │
  │   ┌──────────────┐     │    ┌─────────────────┐     │
  │   │  iptables    │◄────┼───►│   netfilter     │     │
  │   │ (user mode)  │     │    │  (kernel mode)  │     │
  │   └──────────────┘     │    └─────────────────┘     │
  │                        │                             │
  │  We interact here      │  We CANNOT interact         │
  │  (commands)            │  directly here              │
  └──────────────────────────────────────────────────────┘
```

> **Key Point:** We **cannot** interact directly with netfilter (kernel mode).
> We use **iptables (user mode)** which communicates with netfilter internally.

---

## 2. iptables Structure

```
  iptables
    │
    ├── Tables  (by default 5 tables)
    │     │
    │     ├── Chains  (each table has specific chains)
    │     │     │
    │     │     └── Rules  (each chain has ordered rules)
    │     │
```

### Hierarchy Rule:
```
  TABLE  ──contains──►  CHAINS  ──contains──►  RULES
```

---

## 3. The 5 Default Tables

```
  ┌─────────────┬──────────────────────────────────────────────────────┐
  │  Table Name │  Purpose                                             │
  ├─────────────┼──────────────────────────────────────────────────────┤
  │  filter     │  Packet filtering (ALLOW / DROP) — DEFAULT TABLE     │
  │  nat        │  Network Address Translation (SNAT, DNAT, Masquerade)│
  │  mangle     │  Packet header modification (TTL, TOS, QoS)         │
  │  raw        │  Connection tracking exemption (before conntrack)    │
  │  security   │  Mandatory Access Control (SELinux integration)      │
  └─────────────┴──────────────────────────────────────────────────────┘
```

> **Default Table = filter** (if you don't specify `-t tablename`, filter is used)

---

## 4. filter Table — Detailed (Most Important)

**Purpose:** To filter (allow or block) packets.

### 3 Chains in filter Table:

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                    PACKET FLOW IN LINUX                         │
  │                                                                 │
  │                        ┌──────────────┐                        │
  │                        │   INTERNET   │                        │
  │                        └──────┬───────┘                        │
  │                               │  Incoming packet               │
  │                               ▼                                │
  │                    ┌──────────────────────┐                    │
  │                    │   INPUT Chain        │                    │
  │                    │  Packets coming FROM │                    │
  │                    │  outside TO this     │                    │
  │                    │  machine             │                    │
  │                    └──────────┬───────────┘                    │
  │                               │                                │
  │          ┌────────────────────┼──────────────────────┐         │
  │          │                    │                      │         │
  │          ▼                    ▼                      ▼         │
  │  ┌───────────────┐  ┌────────────────┐   ┌──────────────────┐ │
  │  │ LOCAL PROCESS │  │ FORWARD Chain  │   │  OUTPUT Chain    │ │
  │  │  (This host)  │  │ Packets being  │   │  Packets FROM    │ │
  │  └───────────────┘  │ routed THROUGH │   │  this machine    │ │
  │                     │ this machine   │   │  going OUTSIDE   │ │
  │                     │ (2 NICs/router)│   └──────────────────┘ │
  │                     └────────────────┘                        │
  └─────────────────────────────────────────────────────────────────┘
```

| Chain | Direction | Use Case |
|-------|-----------|----------|
| **INPUT** | Outside → This machine | Protect this machine from inbound traffic |
| **OUTPUT** | This machine → Outside | Control outbound traffic from this machine |
| **FORWARD** | Outside → Through → Outside | Machine acting as a **router** (2 NICs) |

---

## 5. How Rules Work — Processing Logic

```
  ┌────────────────────────────────────────────────────────────────┐
  │                    RULE PROCESSING ORDER                       │
  │                                                                │
  │   Packet arrives                                               │
  │        │                                                       │
  │        ▼                                                       │
  │   ┌─────────┐   Match?   ┌────────────────┐                   │
  │   │ Rule 1  │ ─── YES ──►│ Apply TARGET   │ ← STOP here       │
  │   └─────────┘            │ (ACCEPT/DROP)  │   (no more rules) │
  │        │ NO              └────────────────┘                   │
  │        ▼                                                       │
  │   ┌─────────┐   Match?   ┌────────────────┐                   │
  │   │ Rule 2  │ ─── YES ──►│ Apply TARGET   │ ← STOP here       │
  │   └─────────┘            └────────────────┘                   │
  │        │ NO                                                    │
  │        ▼                                                       │
  │   ┌─────────┐   Match?                                         │
  │   │ Rule 3  │ ─── YES ──► ...                                 │
  │   └─────────┘                                                  │
  │        │ NO                                                    │
  │        ▼                                                       │
  │   ┌───────────────────────────────────────┐                   │
  │   │   DEFAULT POLICY executed             │                   │
  │   │   (when no rule matches OR no rules)  │                   │
  │   └───────────────────────────────────────┘                   │
  └────────────────────────────────────────────────────────────────┘
```

### Rules — Key Points:

- Rules are processed **in sequence** (top to bottom)
- If a rule **matches** → apply target → **remaining rules are NOT checked**
- **Rule sequence matters** — order of rules is critical
- **Default Policy** executes when:
  - No rules exist, OR
  - No rule matched the packet
- Default policy can be either **ALLOW** or **DENY**
- **By default in filter table → Default Policy = ALLOW (ACCEPT)**

---

## 6. Targets (Actions in iptables)

```
  ┌─────────────────────────────────────────────────────────────────┐
  │                      TARGETS / ACTIONS                          │
  │                                                                 │
  │   ACCEPT                           DROP                         │
  │   ──────                           ────                         │
  │   Packet is allowed                Packet is silently           │
  │   to pass through                  discarded (like a box)       │
  │                                                                 │
  │   Sender gets a response           Sender gets NO response      │
  │   (connection established)         (connection just times out)  │
  │                                                                 │
  │   ┌──────────────┐                 ┌──────────────┐            │
  │   │   ACCEPT     │                 │     DROP     │            │
  │   │  ✅ Allow    │                 │  ❌ Discard  │            │
  │   └──────────────┘                 └──────────────┘            │
  │                                                                 │
  │  > "it's like a box — in DROP, packets are trashed"            │
  └─────────────────────────────────────────────────────────────────┘
```

> **Note:** There is also a **REJECT** target — drops packet AND sends error back to sender.
> DROP = silent discard | REJECT = discard + notify sender

---

## 7. TCP Handshake & Connection State in iptables

```
  TCP 3-WAY HANDSHAKE vs iptables STATE
  ═══════════════════════════════════════

  Client                        Server
    │                              │
    │──── SYN ────────────────────►│   State: NEW
    │                              │
    │◄─── SYN + ACK ──────────────│   State: ESTABLISHED
    │                              │
    │──── ACK ────────────────────►│   State: ESTABLISHED
    │                              │
    │◄═══ DATA TRANSFER ══════════►│   State: ESTABLISHED
    │                              │

  iptables STATE module tracks:
  ─────────────────────────────
  NEW          = First packet of a new connection (SYN)
  ESTABLISHED  = Part of an already-open connection (SYN+ACK, ACK, data)
  RELATED      = Related to existing connection (e.g. FTP data channel)
  INVALID      = Packet does not match any known connection
```

---

## 8. iptables Commands — Syntax Reference

### General Syntax:
```
  sudo iptables  [TABLE]  COMMAND  CHAIN  [MATCH OPTIONS]  -j TARGET
```

---

### Commands Used in Notes:

#### List all rules
```bash
sudo iptables -L
```

#### Set Default Policy (Policy for a chain)
```bash
# Set FORWARD chain default policy to DROP
sudo iptables -P FORWARD DROP

# Set OUTPUT chain default policy to DROP
sudo iptables -P OUTPUT DROP
```
> `-P` = Policy  |  Note: `-p` in original notes is `-P` (capital P for policy)

#### Allow Loopback Interface (lo)
```bash
iptables -A INPUT -i lo -j ACCEPT
```
- `-A` = Append rule to chain
- `-i lo` = interface loopback (`lo` = loopback, full form: **loopback**)
- `-j` = Jump to target (ACCEPT/DROP)

> **Why allow loopback?** Loopback (127.0.0.1) is used for internal machine communication.
> Blocking it can break local services (DNS, databases, web servers on localhost).

#### Allow ESTABLISHED connections
```bash
iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
```
- `-m state` = use the **state module** (connection tracking)
- `--state ESTABLISHED` = match packets belonging to existing connections

#### Allow SSH from specific IP
```bash
iptables -A INPUT -p tcp -s 192.168.80.1 --dport ssh -j ACCEPT
```
- `-p tcp` = protocol TCP
- `-s 192.168.80.1` = source IP address (`-m` in original = should be `-s` for source)
- `--dport ssh` = destination port SSH (port 22)

> **Note:** `--dport ssh` = `--dport 22` (iptables resolves service names from `/etc/services`)

#### Flush (delete) all rules
```bash
iptables -F
```
- `-F` = Flush — **deletes ALL rules** in all chains (default policy remains)

---

## 9. Command Flag Quick Reference

```
  ┌────────────┬──────────────────────────────────────────────────────┐
  │  Flag      │  Meaning                                             │
  ├────────────┼──────────────────────────────────────────────────────┤
  │  -A        │  Append rule to end of chain                        │
  │  -I        │  Insert rule at top (or specific position)          │
  │  -D        │  Delete a specific rule                             │
  │  -P        │  Set default Policy for a chain                     │
  │  -F        │  Flush (delete all rules in chain)                  │
  │  -L        │  List all rules                                      │
  │  -L -v     │  List rules with packet/byte counters               │
  │  -L -n     │  List rules without DNS resolution (faster)         │
  │  -j        │  Jump to Target (ACCEPT, DROP, REJECT)              │
  │  -p        │  Protocol (tcp, udp, icmp)                          │
  │  -s        │  Source IP address                                   │
  │  -d        │  Destination IP address                              │
  │  -i        │  Input interface (e.g. eth0, lo)                    │
  │  -o        │  Output interface                                    │
  │  --dport   │  Destination port (used with -p tcp/udp)            │
  │  --sport   │  Source port                                         │
  │  -m state  │  Use state module for connection tracking           │
  │  -t        │  Specify table (filter/nat/mangle/raw/security)     │
  └────────────┴──────────────────────────────────────────────────────┘
```

---

## 10. Practical Rule-Set Example (Secure Server Setup)

```bash
# 1. Set default policies — deny everything
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

# 2. Allow loopback (internal machine communication)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# 3. Allow established/related connections (return traffic)
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 4. Allow SSH only from admin IP
sudo iptables -A INPUT -p tcp -s 192.168.80.1 --dport 22 -j ACCEPT

# 5. Allow HTTP and HTTPS from anywhere
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 6. Flush all rules (use when resetting)
sudo iptables -F
```

---

## 11. Key Exam Points 🎯

| Question | Answer |
|----------|--------|
| iptables user mode talks to? | netfilter (kernel mode) |
| Default table in iptables? | filter |
| How many default tables? | 5 (filter, nat, mangle, raw, security) |
| Chains in filter table? | INPUT, OUTPUT, FORWARD |
| FORWARD chain is used when? | Machine is acting as a router (2 NICs) |
| Rules are processed in? | Sequence (top to bottom) |
| What happens after a rule matches? | Remaining rules are NOT checked |
| Default policy in filter table? | ACCEPT (allow all) |
| DROP vs REJECT? | DROP = silent discard; REJECT = discard + sends error back |
| `-F` flag does what? | Flushes (deletes) all rules; default policy stays |
| Full form of `lo`? | loopback (127.0.0.1) |
| `-m state --state ESTABLISHED`? | Match packets of existing connections |
| `-j` flag means? | Jump to target (ACCEPT / DROP) |
| What happens to default policy when `iptables -F` runs? | **Default policy is NOT affected.** `-F` only flushes (deletes) all rules. The default policy (ACCEPT or DROP) remains unchanged. Example: if policy was DROP before `-F`, it stays DROP after `-F`. To reset policy use `-P CHAIN ACCEPT` separately. |
