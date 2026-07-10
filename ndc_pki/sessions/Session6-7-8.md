# Session 6, 7 & 8 — Linux Firewall/Proxy/UTM/Load Balancing & VPN

> **Session 6** (2T+2L+2SL): Linux Software Firewall (ClearOS, pfSense) · Nginx & Squid Reverse Proxy · UTM · Server Load Balancing
> **Session 7 & 8** (4T+8L): VPN Introduction · VPN Protocols/Characteristics · VPN Functions · Types of VPN · Secure VPN · Trusted VPN

---

## PART A — SESSION 6

## 1. Linux Software Firewalls

Linux software firewalls provide packet filtering, NAT, routing, and often VPN or proxy features on top of the base Linux networking stack (iptables/nftables).

Two platforms are relevant to this syllabus:

| Platform | Base OS | Nature |
|---|---|---|
| **ClearOS** | CentOS (Linux) | UTM-oriented distro |
| **pfSense** | FreeBSD (NOT Linux) | Firewall/router platform, studied alongside Linux firewalls due to GUI & enterprise features |

> ⚠️ **Exam Trap:** pfSense is FreeBSD-based, not Linux-based. Don't confuse it with a Linux distro — it's commonly grouped with Linux firewalls only because of shared use-cases and GUI-driven administration.

### 1.1 ClearOS
- CentOS-based distribution designed as a **UTM platform**.
- Web-based GUI for administration.
- Built-in support for: firewall, IDS/IPS, VPN, web proxy, email filtering, bandwidth management.

### 1.2 pfSense
- FreeBSD-based firewall/router platform.
- GUI-driven, enterprise-focused.
- Supports: stateful packet filtering, NAT, port forwarding, VPN, traffic shaping.
- Extensible via add-on packages: **Snort**, **Suricata**, **Squid**, **HAProxy**.

### 1.3 Common Firewall Features (both platforms)
```
┌─────────────────────────────────────────────┐
│              UTM/Firewall Core               │
├─────────────────────────────────────────────┤
│ Firewall Rules → allow/block traffic         │
│ NAT           → translate private IPs        │
│ IDS/IPS       → detect/block suspicious       │
│                 traffic                       │
│ VPN           → secure remote access         │
│ Web Proxy     → cache & control web traffic   │
│ Logging       → traffic trends & alerts       │
└─────────────────────────────────────────────┘
```

---

## 2. Reverse Proxy

A **reverse proxy** sits in front of backend servers, receives client requests on their behalf, and returns responses as if they came from the proxy itself — the client never talks to the backend directly.

### 2.1 How It Works
```
Client  ──request──▶  Reverse Proxy  ──forward──▶  Backend Server(s)
Client  ◀─response──  Reverse Proxy  ◀─response───  Backend Server(s)
```

1. Client sends request to the reverse proxy.
2. Proxy forwards the request to one or more backend servers.
3. Backend response returns to the proxy.
4. Proxy sends the response back to the client.

### 2.2 NGINX (Reverse Proxy)
- High-performance web server and reverse proxy.
- Common uses: SSL termination, caching, load balancing, application reverse proxying.
- Well suited to web apps and microservices.

**Example configuration:**
```nginx
server {
    listen 80;
    server_name app.example.com;
    location / {
        proxy_pass http://127.0.0.1:5000;
    }
}
```

### 2.3 Squid
- Traditionally a **forward proxy**, but can also run in reverse proxy mode.
- Primary strengths: web caching, content filtering, web acceleration.
- More proxy/caching-oriented than NGINX.

### 2.4 NGINX vs Squid

| Aspect | NGINX | Squid |
|---|---|---|
| Primary role | Reverse proxy / web server | Forward proxy (caching) |
| Best for | Application traffic, SSL termination, performance | Caching, content filtering, web proxy |
| Modern app reverse-proxying | ✅ More common choice | ❌ Less common |

> 💡 **Viva Point:** In practice, NGINX is the default choice for modern application reverse proxying; Squid remains relevant where caching/filtering is the primary goal.

---

## 3. UTM (Unified Threat Management)

**UTM** combines multiple security functions into a single platform, letting an organization manage security from one interface.

### 3.1 Typical UTM Components
- Firewall
- IDS/IPS
- VPN gateway
- Web content filtering
- Antivirus gateway
- Email security
- Logging and reporting

### 3.2 Benefits
- Centralized management
- Lower cost for small/medium organizations
- Easier maintenance and policy enforcement

### 3.3 Example UTM Products
- ClearOS
- pfSense (with packages)
- Sophos UTM
- FortiGate

---

## 4. Server Load Balancing

**Load balancing** distributes incoming requests across multiple servers to improve speed, availability, and fault tolerance.

### 4.1 Goals
- Better performance
- High availability
- Redundancy
- Scalability

### 4.2 Common Methods

| Method | Behavior |
|---|---|
| **Round Robin** | Sends requests evenly, in sequence |
| **Least Connections** | Sends to server with fewest active sessions |
| **IP Hash** | Same client IP always routed to same backend |
| **Health Checks** | Skips/avoids unhealthy servers |

### 4.3 Tools
- NGINX
- HAProxy
- pfSense
- AWS ELB
- Kubernetes Services

**NGINX load balancing example:**
```nginx
upstream backend {
    server app1.example.com;
    server app2.example.com;
}
server {
    location / {
        proxy_pass http://backend;
    }
}
```

---

## PART B — SESSION 7 & 8: VPN CONCEPTS

## 5. Introduction to VPN

A **VPN (Virtual Private Network)** creates an encrypted tunnel over an untrusted network (e.g., the internet), providing confidentiality, integrity, authentication, and remote access for users and organizations.

### 5.1 Main Purposes
- Secure remote access
- Protect data in transit
- Hide the user's public IP address
- Connect branch offices securely

```
┌────────┐     Encrypted Tunnel      ┌────────────┐
│ Client │ ═════════════════════════▶│ VPN Gateway │──▶ Internal Network
└────────┘   (over public internet)  └────────────┘
```

---

## 6. VPN Protocols & Characteristics

| Protocol | Notes |
|---|---|
| **PPTP** | Easy/fast to set up; **outdated and weak security** |
| **L2TP/IPSec** | Tunneling + strong encryption; common for site-to-site links |
| **IPSec** | Operates at IP layer; heavily used in enterprise/site-to-site VPNs |
| **SSL/TLS VPN** | HTTPS-style security; often allows browser-based access |
| **OpenVPN** | Open-source, flexible, uses SSL/TLS; widely used for remote access |
| **IKEv2/IPSec** | Stable, good for mobile devices; handles network changes/reconnects well |
| **WireGuard** | Modern, lightweight, strong cryptography, built into Linux kernel; known for high performance |

### 6.1 Key Characteristics to Compare Protocols By
- Encryption strength
- Speed
- Firewall traversal
- Stability
- Ease of deployment

> ⚠️ **Exam Trap:** PPTP = legacy/weak. WireGuard = modern/fastest. IKEv2 = best for mobile/roaming reconnects.

---

## 7. VPN Functions

| Function | Description |
|---|---|
| **Confidentiality** | Encrypts traffic |
| **Authentication** | Verifies user or peer identity |
| **Integrity** | Detects tampering |
| **Tunneling** | Encapsulates traffic inside another packet |
| **Anonymity** | Hides the real IP address |
| **Remote Access** | Allows secure offsite access |

> 💡 **Viva Point:** VPNs aren't just about privacy — in enterprises they also enable secure connectivity between offices and users.

---

## 8. Types of VPN

```
┌───────────────────┬─────────────────────────────────────┐
│ Remote Access VPN  │ Individual user ↔ office network     │
│ Site-to-Site VPN   │ Entire network ↔ entire network      │
│ Intranet VPN       │ Internal locations, same org         │
│ Extranet VPN       │ Org ↔ partner/supplier (policy-limited)│
└───────────────────┴─────────────────────────────────────┘
```

### 8.1 Remote Access VPN
- Used by an individual user.
- Common for work-from-home access.
- Example: employee connecting to office resources securely.

### 8.2 Site-to-Site VPN
- Connects entire networks (not individual users).
- Used between branches or data centers.
- Typically configured on routers or firewalls.

### 8.3 Intranet VPN
- Connects internal locations **within the same organization**.

### 8.4 Extranet VPN
- Connects an organization **with a partner or supplier** network.
- Access is limited by policy.

---

## 9. Secure VPN

A **Secure VPN** emphasizes strong encryption, strong authentication, and protection against leaks.

### 9.1 Common Features
- AES-256 encryption
- TLS/SSL authentication
- Perfect Forward Secrecy (PFS)
- DNS / WebRTC / IPv6 leak protection

### 9.2 Why It Matters
- Financial systems
- Healthcare data
- Intellectual property
- Corporate communications

### 9.3 Examples
- OpenVPN
- WireGuard
- IKEv2/IPSec

---

## 10. Trusted VPN

A **Trusted VPN** typically runs over a trusted carrier network (e.g., **MPLS**) rather than the public internet. Security comes from network isolation and trusted routing paths rather than cryptographic tunneling by default.

### 10.1 Main Idea
- Security via network trust and isolation.
- Common in telecom and enterprise backbone networks.

### 10.2 Secure VPN vs Trusted VPN

| Aspect | Secure VPN | Trusted VPN |
|---|---|---|
| Security source | Encryption over public internet | Private infrastructure / trusted routing |
| Typical use case | Internet-based remote access | Managed private WAN environments |
| Common protocols | OpenVPN, WireGuard, IKEv2 | MPLS-based private circuits |

---

## Exam Focus Points (Quick Recall)

- **ClearOS** = UTM-oriented Linux (CentOS-based); **pfSense** = FreeBSD-based firewall/router platform (not Linux).
- **NGINX** → strong for reverse proxying and load balancing.
- **Squid** → stronger in caching and proxy filtering than NGINX.
- **UTM** = multiple security services combined into one system.
- VPN protocols differ mainly by **security, speed, and use case**.
- **WireGuard** = modern, lightweight, high-performance, kernel-integrated protocol.
- **PPTP** = legacy, weak, avoid in production.
- Types of VPN: Remote Access, Site-to-Site, Intranet, Extranet.
- **Secure VPN** = encryption-based (public internet); **Trusted VPN** = isolation-based (private carrier network, e.g. MPLS).
