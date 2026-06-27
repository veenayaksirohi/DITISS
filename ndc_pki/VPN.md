# VPN — Virtual Private Network

> **Topic:** CDAC DITISS — Network Security
> **Exam Tag:** VPN · Tunneling · IPSec · L2TP · SSTP · MPLS · OpenVPN

---

## Table of Contents

1. [What is VPN?](#1-what-is-vpn)
2. [Core Concepts — Tunnel & Encapsulation](#2-core-concepts--tunnel--encapsulation)
3. [Types of VPN](#3-types-of-vpn)
4. [Based on Network Architecture](#4-based-on-network-architecture)
5. [Based on Configuration / Implementation](#5-based-on-configuration--implementation)
6. [VPN Architecture Diagrams](#6-vpn-architecture-diagrams)
7. [Lab — OpenVPN Setup](#7-lab--openvpn-setup)
8. [OpenVPN Config File Explained](#8-openvpn-config-file-explained)
9. [Viva Q&A](#9-viva-qa)

---

## 1. What is VPN?

**VPN (Virtual Private Network)** connects one **trusted network** (or user) to another **trusted network** over an **untrusted public network** (the internet) securely.

```
[ Trusted Network A ]                    [ Trusted Network B ]
   Branch Office                              Main Office
        │                                          │
        │        Untrusted Public Network          │
        └──────────── INTERNET ────────────────────┘
                  (Encrypted VPN Tunnel)
```

| Property    | Meaning                                             |
| ----------- | --------------------------------------------------- |
| **Virtual** | No dedicated physical link — uses existing internet |
| **Private** | Traffic is encrypted and isolated from public view  |
| **Network** | Connects entire networks or individual clients      |

---

## 2. Core Concepts — Tunnel & Encapsulation

### 2.1 Tunnel

A **VPN tunnel** is a logical encrypted path created between two endpoints over the internet.

```
Sender                                        Receiver
  │                                               │
  │──── Encrypted Tunnel ────────────────────────▶│
  │     (data hidden from anyone in between)      │
```

- The tunnel hides the original data from ISPs, attackers, and anyone on the public network.
- Both endpoints must agree on the same **protocol, encryption, and authentication**.

---

### 2.2 Encapsulation

**Encapsulation** wraps the original packet inside another packet so it can be transmitted securely through the tunnel.

```
Original Packet:
┌─────────────┬──────────────────────┐
│  IP Header  │       Data           │
└─────────────┴──────────────────────┘

After VPN Encapsulation:
┌──────────────┬─────────────┬───────────────────────┐
│ Outer Header │ VPN Header  │ Encrypted Inner Packet │
│ (public IP)  │ (tunnel)    │ (original IP + data)   │
└──────────────┴─────────────┴───────────────────────┘
```

> The public network only sees the **outer header** (tunnel endpoints).
> The original source/destination IP and data are hidden inside.

---

## 3. Types of VPN

```
VPN Types
│
├── Based on Network Architecture
│       ├── Dial-up / Client / Remote-Access VPN
│       └── Site-to-Site VPN
│
└── Based on Configuration / Implementation
        ├── Trusted VPN
        │       ├── Layer 2 VPN  → ATM Circuit
        │       └── Layer 3 VPN  → MPLS + BGP
        │
        ├── Secure VPN
        │       ├── IPSec
        │       ├── L2TP
        │       └── SSTP
        │
        └── Hybrid VPN
                └── Trusted + Secure combined
```

---

## 4. Based on Network Architecture

### 4.1 Dial-up / Client / Remote-Access VPN

A **single remote user** (client) connects securely to the **main office network** over the internet.

```
Remote User (Home / Travel)
        │
        │  Internet (Untrusted)
        │
        ▼
[ Secure VPN Tunnel ]
        │
        ▼
  NAS — Network Access Server
  (Main Office Gateway)
        │
        ▼
  Internal Corporate Network
```

**Use case:** Work-from-home employees, travelling staff, remote IT support.

**How it works:**

1. User installs VPN client software
2. Client authenticates to the VPN gateway (NAS)
3. Encrypted tunnel is established
4. User gets an internal IP address — appears to be inside the office network

---

### 4.2 Site-to-Site VPN

Multiple **entire branch office networks** connect to the **main office** over the internet permanently.

```
Branch 1 (B1) ──┐
                 │
Branch 2 (B2) ──┼── Internet ──▶ Main Office (NAS)
                 │
Branch 3 (B3) ──┘
```

**Use case:** Connecting geographically distributed offices so they share one logical network.

**Difference from Remote-Access:**

|                 | Remote-Access VPN                     | Site-to-Site VPN        |
| --------------- | ------------------------------------- | ----------------------- |
| Who connects    | Individual user                       | Entire network / router |
| Client software | Required on each user's device        | Only on gateway routers |
| Tunnel duration | On-demand (user connects/disconnects) | Always-on / permanent   |
| Example         | WFH employee                          | Mumbai HQ ↔ Pune Branch |

---

## 5. Based on Configuration / Implementation

### 5.1 Trusted VPN

A VPN where the **service provider** guarantees that no one else uses the same path — the network path is trusted by contract/agreement, not by encryption.

> **Key point:** Trusted VPNs do **NOT necessarily encrypt** traffic.
> Trust comes from **network isolation**, not cryptography.

---

#### 5.1.1 Layer 2 VPN — ATM Circuit

| Property       | Detail                                                     |
| -------------- | ---------------------------------------------------------- |
| **Layer**      | OSI Layer 2 (Data Link)                                    |
| **Technology** | ATM (Asynchronous Transfer Mode)                           |
| **How**        | Dedicated virtual circuits are provisioned by the provider |
| **Encryption** | None — trust is in the dedicated circuit                   |
| **Use case**   | Older enterprise WAN links, telecom backbone               |

```
Office A ──── ATM Virtual Circuit ──── Office B
              (Provider Network)
              No shared path with others
```

---

#### 5.1.2 Layer 3 VPN — MPLS + BGP

| Property       | Detail                                                                         |
| -------------- | ------------------------------------------------------------------------------ |
| **Layer**      | OSI Layer 3 (Network)                                                          |
| **Technology** | MPLS (Multiprotocol Label Switching) + BGP                                     |
| **How**        | Provider assigns labels to packets; routes through label-switched paths (LSPs) |
| **Encryption** | None by default — isolated by labels                                           |
| **Use case**   | Enterprise WAN, ISP backbone, modern service provider VPNs                     |

```
Customer Site A                          Customer Site B
      │                                        │
      │    ┌─────────────────────────┐         │
      └───▶│   MPLS Provider Network │────────▶│
           │  Label: 100 (Customer X)│
           │  Label: 200 (Customer Y)│
           └─────────────────────────┘
```

**MPLS label switching:**

```
Packet enters MPLS network
       │
       ▼
Edge router adds LABEL (e.g., 100)
       │
       ▼
Core routers forward based on LABEL (not IP lookup)
       │
       ▼
Exit router removes label → delivers packet
```

> **BGP role:** BGP (Border Gateway Protocol) is used to exchange routing information between customer sites and the MPLS provider, ensuring correct label-based path selection.

---

### 5.2 Secure VPN

VPNs that use **cryptographic protocols** to ensure confidentiality, integrity, and authentication. These are the most commonly used VPNs today.

---

#### 5.2.1 IPSec — Internet Protocol Security

| Property         | Detail                                                            |
| ---------------- | ----------------------------------------------------------------- |
| **Layer**        | OSI Layer 3 (Network)                                             |
| **Protocols**    | AH (Authentication Header) + ESP (Encapsulating Security Payload) |
| **Modes**        | Transport Mode · Tunnel Mode                                      |
| **Key exchange** | IKE (Internet Key Exchange) — IKEv1 / IKEv2                       |
| **Use case**     | Site-to-site VPN, L3 secure tunnels                               |

**Two IPSec modes:**

```
Transport Mode:
┌───────────┬──────────────────────────────┐
│ IP Header │ IPSec Header │ Encrypted Data│
└───────────┴──────────────────────────────┘
  (original IP header preserved)

Tunnel Mode:
┌────────────────┬───────────────────────────────────────────┐
│ New IP Header  │ IPSec Header │ Encrypted [IP Header + Data]│
└────────────────┴───────────────────────────────────────────┘
  (entire original packet encrypted — used for VPNs)
```

---

#### 5.2.2 L2TP — Layer 2 Tunneling Protocol

| Property       | Detail                                            |
| -------------- | ------------------------------------------------- |
| **Layer**      | OSI Layer 2                                       |
| **Encryption** | None by itself — combined with IPSec (L2TP/IPSec) |
| **Port**       | UDP 1701                                          |
| **Origin**     | Combines Cisco L2F + Microsoft PPTP               |
| **Use case**   | Remote-access VPN, Windows/mobile VPN clients     |

```
L2TP alone    → Tunneling only, no encryption
L2TP + IPSec  → Tunneling + Encryption (most common deployment)
```

---

#### 5.2.3 SSTP — Secure Socket Tunneling Protocol (Microsoft)

| Property       | Detail                                                                           |
| -------------- | -------------------------------------------------------------------------------- |
| **Full name**  | Microsoft Secure Socket Tunneling Protocol                                       |
| **Layer**      | Application Layer (runs over HTTPS)                                              |
| **Port**       | TCP 443 (same as HTTPS)                                                          |
| **Encryption** | SSL/TLS                                                                          |
| **OS support** | Windows native (built-in VPN client)                                             |
| **Advantage**  | Works through firewalls that block other VPN ports (443 is almost never blocked) |
| **Use case**   | Remote-access for Windows users behind strict firewalls                          |

```
VPN Client ──── TCP 443 (HTTPS/TLS) ──── SSTP Server ──── Internal Network
               (looks like normal HTTPS to firewalls)
```

---

### 5.3 Hybrid VPN

Combines **Trusted VPN** + **Secure VPN** in the same deployment.

```
Corporate HQ
     │
     ├── MPLS (Trusted) ──── Branch Office A
     │   (high-speed, no encryption needed — private circuit)
     │
     └── IPSec (Secure) ──── Remote Worker
         (encrypted — over public internet)
```

**Use case:** Large enterprises that use MPLS for branch-to-branch (private circuits) but also need IPSec/SSL VPN for remote workers on the internet.

---

## 6. VPN Architecture Diagrams

### Remote-Access VPN

```
Home / Remote User
  [VPN Client]
        │
        │  Public Internet
        │  (Untrusted)
        ▼
  ┌─────────────────────┐
  │  NAS                │   ← Network Access Server / VPN Gateway
  │  (Main Office Edge) │
  └──────────┬──────────┘
             │
             ▼
   Internal Corporate Network
   (Servers, Printers, File Shares)
```

---

### Site-to-Site VPN

```
Branch 1 (B1)
[Router] ──────────────────────────┐
                                   │
Branch 2 (B2)                      ▼
[Router] ──────── Internet ──── [NAS / VPN Gateway]
                                   │
Branch 3 (B3)                      ▼
[Router] ──────────────────── Main Office Network
```

---

## 7. Lab — OpenVPN Setup

### Installation

```bash
apt install openvpn
```

---

### Server Side — Configuration File

```bash
vi /etc/openvpn/server.conf
```

Minimal server config for lab:

```conf
dev tun
proto udp
ifconfig 10.8.0.1 10.8.0.2
auth none
cipher none
verb 3
```

Start OpenVPN server:

```bash
openvpn --config /etc/openvpn/server.conf
```

---

### Client Side — Configuration File

```bash
vi /etc/openvpn/client.conf
```

Client config:

```conf
dev tun
proto udp
remote 192.168.80.130
ifconfig 10.8.0.2 10.8.0.1
auth none
cipher none
verb 3
```

Start OpenVPN client:

```bash
openvpn --config /etc/openvpn/client.conf
```

---

## 8. OpenVPN Config File Explained

| Directive                    | Side        | Meaning                                                             |
| ---------------------------- | ----------- | ------------------------------------------------------------------- |
| `dev tun`                    | Both        | Use TUN device (Layer 3 — routed IP tunnel). TAP = Layer 2 bridging |
| `proto udp`                  | Both        | Use UDP as transport protocol (faster, less overhead than TCP)      |
| `remote 192.168.80.130`      | Client only | IP address of the OpenVPN server to connect to                      |
| `ifconfig 10.8.0.1 10.8.0.2` | Server      | Assign virtual IPs: server=10.8.0.1, client=10.8.0.2                |
| `ifconfig 10.8.0.2 10.8.0.1` | Client      | Assign virtual IPs: client=10.8.0.2, server=10.8.0.1                |
| `auth none`                  | Both        | No HMAC authentication (lab only — never in production)             |
| `cipher none`                | Both        | No encryption (lab only — never in production)                      |
| `verb 3`                     | Both        | Verbosity level 3 — shows connection logs (0=silent, 9=max debug)   |

---

### TUN vs TAP

|                  | TUN                      | TAP                         |
| ---------------- | ------------------------ | --------------------------- |
| OSI Layer        | Layer 3 (Network)        | Layer 2 (Data Link)         |
| Packets          | IP packets               | Ethernet frames             |
| Use case         | Routed VPN (most common) | Bridged VPN (LAN extension) |
| Config directive | `dev tun`                | `dev tap`                   |

---

### Virtual IP Assignment Logic

```
Server config:   ifconfig 10.8.0.1 10.8.0.2
                          ─────────  ─────────
                          Server IP  Client IP

Client config:   ifconfig 10.8.0.2 10.8.0.1
                          ─────────  ─────────
                          Client IP  Server IP
```

After tunnel is up:

```
Client machine  ──── tun0: 10.8.0.2 ──── [VPN Tunnel] ──── tun0: 10.8.0.1  Server machine

ping 10.8.0.1   ← client can reach server via tunnel
ping 10.8.0.2   ← server can reach client via tunnel
```

Verify tunnel interface:

```bash
ip addr show tun0
ifconfig tun0
```

---

### Production vs Lab Config Comparison

| Setting       | Lab (insecure)   | Production (secure)                              |
| ------------- | ---------------- | ------------------------------------------------ |
| `cipher none` | ✓ used           | `cipher AES-256-GCM`                             |
| `auth none`   | ✓ used           | `auth SHA256`                                    |
| Certificates  | Not used         | `ca ca.crt`, `cert server.crt`, `key server.key` |
| TLS auth      | Not used         | `tls-auth ta.key 0`                              |
| Port          | Default 1194 UDP | Customizable                                     |

> **Lab note:** `auth none` and `cipher none` are used only for quick connectivity testing. Never use in any real deployment.

---

## 9. Viva Q&A

**Q1. What is a VPN?**
VPN connects a trusted network or client to another trusted network over an untrusted public network (internet) using tunneling and encryption.

---

**Q2. What is the difference between tunneling and encapsulation?**
Tunneling is the logical concept of creating a private path through a public network. Encapsulation is the technical mechanism — the original packet is wrapped inside a new packet with a public outer header, hiding the inner content from the public network.

---

**Q3. What is the difference between Trusted VPN and Secure VPN?**

|             | Trusted VPN                 | Secure VPN               |
| ----------- | --------------------------- | ------------------------ |
| Trust basis | Network isolation (circuit) | Cryptographic encryption |
| Encryption  | Not required                | Mandatory                |
| Examples    | MPLS, ATM                   | IPSec, L2TP, SSTP        |

---

**Q4. What is MPLS and why is it used in VPNs?**
MPLS (Multiprotocol Label Switching) forwards packets using short labels instead of IP routing table lookups. It creates isolated label-switched paths per customer, providing VPN-like separation without encryption. BGP is used to distribute routing information between customer sites.

---

**Q5. Why does L2TP need IPSec?**
L2TP only provides tunneling (encapsulation) — it has no built-in encryption or authentication. IPSec adds encryption (ESP) and authentication (AH/IKE). Together, L2TP/IPSec provides both tunneling and security.

---

**Q6. Why is SSTP better than other VPN protocols in restrictive environments?**
SSTP runs over TCP port 443 — the same port as HTTPS. Firewalls that block VPN ports (UDP 1194, UDP 1701) rarely block 443. So SSTP works even in hotels, airports, and corporate networks with strict filtering.

---

**Q7. What is the difference between TUN and TAP in OpenVPN?**
TUN operates at Layer 3 — it handles IP packets and is used for routed VPNs. TAP operates at Layer 2 — it handles Ethernet frames and is used for bridged VPNs where you need the remote client to appear on the same LAN segment.

---

**Q8. What does `verb 3` mean in OpenVPN config?**
It sets the verbosity/logging level to 3, which shows normal connection events. Range is 0 (silent) to 9 (maximum debug output).

---

**Q9. What is a NAS in VPN context?**
NAS (Network Access Server) is the VPN gateway at the main office. It terminates incoming VPN connections from remote users or branch offices and connects them to the internal network.

---

**Q10. What is a Hybrid VPN?**
A Hybrid VPN combines Trusted VPN (e.g., MPLS for branch offices — fast, private circuits) with Secure VPN (e.g., IPSec for remote workers over the internet). Used when different connectivity types are needed in the same organization.

---

## Quick Reference

```
VPN Classification
├── By Architecture
│     ├── Remote-Access (client → NAS → office)
│     └── Site-to-Site  (B1, B2, B3 → internet → main office NAS)
│
└── By Implementation
      ├── Trusted  → No encryption; isolated circuits
      │     ├── L2: ATM Circuit
      │     └── L3: MPLS + BGP
      │
      ├── Secure   → Encrypted tunnels
      │     ├── IPSec  (L3, AH+ESP, IKE, Tunnel/Transport mode)
      │     ├── L2TP   (L2, needs IPSec for encryption, UDP 1701)
      │     └── SSTP   (App layer, TLS, TCP 443, Microsoft)
      │
      └── Hybrid   → Trusted + Secure combined

OpenVPN Lab Commands
  Server: openvpn --config server.conf   (ifconfig 10.8.0.1 10.8.0.2)
  Client: openvpn --config client.conf   (remote <server-ip>, ifconfig 10.8.0.2 10.8.0.1)
  Check:  ifconfig tun0 / ip addr show tun0
```
