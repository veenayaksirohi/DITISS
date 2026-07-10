# Session 9 & 10 — Hybrid VPN, IPsec & IDS/IPS

> **Session 9** (2T+2L+3SL): Hybrid VPN · IPsec · Tunnel Mode/Transport Mode · IPv6 VPN · Split Tunnel
> **Session 10** (2T): Introduction to IDS and IPS · IDS/IPS · Types of Attacks · Security Events · Vulnerability/Design/Implementation · tcpdump

---

## PART A — SESSION 9

## 1. Hybrid VPN

A **Hybrid VPN** combines more than one VPN technology (e.g., IPsec, SSL VPN, GRE, MPLS) to meet different connectivity and security requirements within a single architecture.

### 1.1 Common Hybrid Patterns
- **SSL/OpenVPN** for remote users + **IPsec** for site-to-site connectivity between branch offices.
- **GRE tunnel inside IPsec** — GRE provides dynamic routing, IPsec provides encryption.
- **MPLS core with IPsec at the edge** — MPLS for backbone transport, IPsec for encryption at boundaries.

> 💡 **Example:** A company uses IPsec for permanent inter-office links and OpenVPN (SSL-based) for remote workers. Together this forms a Hybrid VPN architecture.

---

## 2. IPsec (Internet Protocol Security)

IPsec is a suite of protocols that operates at the **network layer** to secure IP communications by authenticating and encrypting each IP packet. It is widely used for VPNs — especially site-to-site tunnels between gateways, or host-to-host secure communication over untrusted networks.

### 2.1 Core Components

| Component | Function |
|---|---|
| **AH** (Authentication Header) | Integrity + origin authentication — **no confidentiality** |
| **ESP** (Encapsulating Security Payload) | Confidentiality (encryption) + integrity + optional authentication — most commonly used in VPNs |
| **IKE** (Internet Key Exchange) | Negotiates keys and Security Associations (SAs), typically in two phases (IKEv1/IKEv2) |

> ⚠️ **Exam Trap:** AH does **not** encrypt — it only authenticates. ESP is the one that provides confidentiality. Most modern VPNs use ESP.

---

## 3. Tunnel Mode vs Transport Mode

IPsec can operate in **Tunnel Mode** or **Transport Mode**, depending on whether whole networks or individual hosts are being protected.

### 3.1 Tunnel Mode
- Encrypts and encapsulates the **entire original IP packet** (including its header) inside a new IP packet with a new outer header.
- Default mode for most VPN devices.
- Used for **site-to-site VPNs** and **remote access VPNs**, and to hide internal IP addressing from the internet.

### 3.2 Transport Mode
- Only the **payload** (upper-layer data — TCP/UDP headers + application data) is encrypted; the original IP header remains visible for routing.
- Used for **host-to-host** encryption, or to secure other tunneling protocols (e.g., GRE) when those packets are themselves wrapped by IPsec.
- Lower overhead → better performance than tunnel mode.

### 3.3 Comparison Table

| Feature | Tunnel Mode | Transport Mode |
|---|---|---|
| What is encrypted? | Entire IP packet | Only payload + upper layers |
| Use case | Site-to-site VPN, Remote Access | End-to-end host communications |
| Header change | New IP header added | Retains original IP header |
| Protocol used | ESP or AH | ESP or AH |
| Overhead | Higher | Lower |
| Typical deployment | Gateway-to-gateway, client-to-gateway | Host-to-host, or securing another tunnel (e.g. GRE) |

```
Tunnel Mode:
[New IP Header][IPsec Header][Original IP Header][Payload]  ← whole original packet wrapped

Transport Mode:
[Original IP Header][IPsec Header][Payload]                 ← original header preserved
```

---

## 4. IPv6 VPN

As IPv6 adoption grows, VPN protocols have been extended to support IPv6 addressing and routing inside tunnels.

### 4.1 IPv6-Compatible VPN Protocols
- **IPsec with IPv6** — fully supported.
- **OpenVPN** — supports IPv6 inside the tunnel and IPv6 VPN servers.
- **WireGuard** — fully supports IPv6 endpoints and routing.

### 4.2 Benefits
- **No NAT** — IPsec over IPv6 can operate without address translation, simplifying VPN routing.
- **Larger address space** — globally unique IPv6 prefixes can be allocated to sites/clients, improving scalability.
- **End-to-end communication is restored** (no NAT breaking direct addressing).

---

## 5. Split Tunnel vs Full Tunnel VPN

This decides **which traffic** is routed through the VPN tunnel vs sent directly over the regular internet connection.

### 5.1 Split Tunnel VPN
- Only specific traffic (e.g., internal/corporate resources) is routed through the VPN.
- All other traffic (e.g., general web browsing) uses the regular internet connection directly.
- **Pros:** Saves bandwidth, improves speed.
- **Cons:** Security risk — non-VPN traffic is unencrypted and potentially exposed.

### 5.2 Full Tunnel VPN
- **All** traffic (internal + external) is routed through the VPN tunnel and exits via the corporate/VPN gateway.
- **Pros:** Maximum security, especially on untrusted networks (e.g., public Wi-Fi).
- **Cons:** Increased latency, higher load on the VPN server.

### 5.3 Comparison Table

| Feature | Split Tunnel | Full Tunnel |
|---|---|---|
| Traffic routed | Only internal traffic | All traffic (internal + external) |
| Speed | Faster | Slower (everything via VPN) |
| Security | Less secure | More secure |
| Use case | Access intranet + local browsing | Secure remote access on untrusted networks |

---

## PART B — SESSION 10

## 6. Introduction to IDS and IPS

IDS and IPS monitor network or host activity to identify malicious or policy-violating behavior.

### 6.1 IDS (Intrusion Detection System)
- A **monitoring** system that detects suspicious activity or policy violations and logs/alerts administrators.
- **Passive** — does not block traffic, only observes and notifies.

### 6.2 IPS (Intrusion Prevention System)
- Builds on IDS by not just detecting but also **acting**:
  - Blocking malicious traffic
  - Resetting connections
  - Reconfiguring firewalls
- **Active** and typically deployed **inline** (directly in the traffic path).

### 6.3 Key Difference

| Feature | IDS | IPS |
|---|---|---|
| Nature | Passive | Active |
| Action | Alerts only | Alerts + Blocks |
| Placement | Often outside the inline path | Inline (directly in traffic path) |

```
IDS:  Traffic ──▶ [Network] ──▶ Destination
                     │
                     ▼ (copy/mirror)
                  [IDS] → Alert only

IPS:  Traffic ──▶ [IPS] ──▶ Destination     (inline — can block/drop)
```

---

## 7. Types of Attacks Detected by IDS/IPS

### 7.1 Network Attacks
- **DoS / DDoS** — Overwhelm target with traffic.
- **Port Scans** — Reconnaissance to find open ports.
- **Spoofing** — Fake source IP addresses.

### 7.2 Exploits
- **Buffer Overflow** — Overwriting memory.
- **SQL Injection** — Injecting malicious SQL commands.
- **Cross-Site Scripting (XSS)** — Injecting malicious scripts.

### 7.3 Malware
- Trojans, Worms, Ransomware, etc. — detectable via signatures or behavioral indicators.

### 7.4 Insider Threats
- Misuse of privileges by legitimate/authorized users, often spotted via anomaly and log analysis.

---

## 8. IDS Detection Techniques

| Technique | How It Works | Strength | Weakness |
|---|---|---|---|
| **Signature-Based** | Matches traffic against known attack patterns | Low false positives; accurate for known threats | Cannot detect unknown/zero-day threats |
| **Anomaly-Based** | Builds a baseline of "normal" activity and flags deviations | Can detect unknown/novel threats | Higher false positives |
| **Heuristic-Based** | Behavioral analysis + rule-based logic | More advanced detection | Less common, more complex |

> ⚠️ **Exam Trap:** Signature-based = good against *known* attacks, blind to zero-days. Anomaly-based = can catch *unknown* attacks, but noisier (more false positives).

---

## 9. Types of IDS (by Deployment)

| Type | Description | Placement |
|---|---|---|
| **NIDS** (Network-based) | Monitors network traffic (e.g., Snort) | Deployed at network boundaries/gateways |
| **HIDS** (Host-based) | Monitors host system logs and behavior | Installed on individual systems |
| **Hybrid IDS** | Combines NIDS + HIDS | For layered visibility (network + host) |

---

## 10. Security Events

A **security event** is any observable occurrence in a system or network (e.g., login, connection attempt, configuration change). Not all security events are threats.

- A **security incident** is a series of related events representing an actual threat.
- IDS/IPS (and SIEM tools) help distinguish benign events from malicious ones.

### 10.1 Examples of Security Events
- Multiple failed login attempts
- Unexpected system reboots
- High CPU usage on idle servers
- Connections to known malicious IPs

---

## 11. Vulnerability, Design Flaws & Implementation Weaknesses

| Term | Definition | Notes |
|---|---|---|
| **Vulnerability** | A weakness in software/hardware that can be exploited to compromise a system | Often catalogued in vulnerability databases; mitigated via patches/config changes |
| **Design Flaw** | Architectural mistake (e.g., trusting unauthenticated input) | Harder to detect, often systemic — may require redesign, not just patching |
| **Implementation Bug** | Code-level flaw (e.g., improper input validation) | More common, generally patchable via software updates |

### 11.1 What IDS/IPS May Not Detect
- Encrypted payloads (if not configured properly)
- New attack types without updated signatures
- Malware using obfuscation techniques

> 💡 **Viva Point:** Proper design, frequent signature updates, and contextual threat intelligence all improve detection accuracy.

---

## 12. tcpdump Basics

**tcpdump** is a command-line packet capture tool commonly used on Unix/Linux systems to capture and inspect network traffic directly from interfaces. It works at a low level using libpcap/BPF filters, letting you capture specific protocols, ports, or hosts for later analysis — often alongside Wireshark or IDS tools.

### 12.1 Typical Uses
- Quick troubleshooting captures, e.g.:
  ```bash
  tcpdump -i eth0 port 80
  ```
  (captures HTTP traffic on interface eth0)
- Verifying firewall/VPN behavior at the packet level.
- Saving packet traces to `.pcap` files for offline analysis in Wireshark, incident response, or protocol study:
  ```bash
  tcpdump -i eth0 -w capture.pcap
  ```

---

## Exam Focus Points (Quick Recall)

- **AH** = integrity/authentication only; **ESP** = encryption + integrity (+ optional auth) — ESP is the common choice.
- **Tunnel Mode** = encrypts whole packet, new IP header, site-to-site/remote access. **Transport Mode** = encrypts payload only, original header kept, host-to-host.
- **IPv6 VPN** benefits: no NAT, larger address space, restored end-to-end connectivity.
- **Split Tunnel** = faster but less secure (only internal traffic via VPN). **Full Tunnel** = slower but more secure (all traffic via VPN).
- **IDS** = passive/detect-only. **IPS** = active/inline, can block.
- Detection techniques: **Signature** (known attacks, low false positives) vs **Anomaly** (unknown attacks, higher false positives) vs **Heuristic** (behavioral).
- **NIDS** = network-wide visibility; **HIDS** = per-host visibility; **Hybrid** = both.
- **Security event** ≠ **security incident** — an incident is a related set of events indicating an actual threat.
- **Vulnerability** (exploitable weakness) vs **Design Flaw** (architectural) vs **Implementation Bug** (code-level).
- **tcpdump** = CLI packet capture tool; pairs with Wireshark for deeper analysis.
