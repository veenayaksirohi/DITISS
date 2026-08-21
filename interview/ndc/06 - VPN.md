# VPN — Detailed Notes

# 1. VPN Fundamentals

## 1.1 What is a VPN?

**VPN** = **Virtual Private Network**. It creates a secure logical connection between two systems or networks over another network, usually the Internet.

> A VPN creates a secure tunnel over an untrusted network so users or networks can communicate safely.

```text
User/Network A → VPN Gateway → ===== Secure VPN Tunnel ===== → VPN Gateway → Company Network/Network B
```

Commonly used for: remote employee access, connecting branch offices, protecting traffic over the Internet, accessing private company resources, encrypting communication, hiding private network traffic from intermediate networks.

## 1.2 Why is a VPN Needed?

The Internet is an **untrusted network**. Attackers on the path may try to read data, modify data, steal credentials, impersonate users, or intercept communication. A VPN adds security through:

```text
Encryption + Authentication + Integrity Protection + Tunneling
```

## 1.3 Main Security Functions

1. **Encryption** 2. **Tunneling** 3. **Authentication** 4. **Integrity protection**

## 1.4 Encryption

**Encryption** converts readable data (**Plaintext**) into an unreadable form (**Ciphertext**):

```text
Password = admin123 → Encryption → x8#kP2@9...
```

Someone intercepting the encrypted data should not be able to understand it without the required cryptographic keys.

**In a VPN:** without protection, `Employee → Internet → Company Server` may expose unprotected application traffic. With a VPN: `Employee → Encrypt Data → ===== VPN Tunnel ===== → Decrypt Data → Company Server`.

> VPN encryption's main purpose is to provide **Confidentiality**.

**Does it protect everything?** Only traffic sent **through the VPN tunnel**. With split tunneling, only `Corporate Traffic → VPN Tunnel` is protected, while other Internet traffic may go outside the tunnel — protection depends on the routing/policy used.

## 1.5 Tunneling & Encapsulation

**Tunneling** means placing one network packet inside another so it can travel across another network:

```text
Original Packet → Encapsulate → VPN Packet → Internet → Decapsulate → Original Packet
```

> Tunneling encapsulates private network traffic inside VPN packets so it can travel across another network such as the Internet.

**Example:** an internal packet `Source: 10.0.1.10 → Destination: 10.0.2.20` (private addresses) is encapsulated by the VPN gateway. The Internet routes only the **outer packet** (`Public Gateway A ↔ Public Gateway B`), while the private inner packet (`10.0.1.10 → 10.0.2.20`) travels hidden inside it.

## 1.6 Authentication

**Authentication** verifies identity — it answers "Who are you?" A VPN must confirm the connecting user or gateway is legitimate.
**Methods:** username/password, certificates, pre-shared keys, MFA, security tokens, directory/identity services.

```text
Employee → Username+Password → MFA → VPN Server → Authentication Successful → VPN Tunnel Created
```

**Why it matters:** encryption alone is not enough — if communication is encrypted but the VPN allows anybody to connect, an attacker could establish their own encrypted session. So:

```text
Encryption + Authentication = Secure VPN Communication
```

## 1.7 Integrity

**Integrity** ensures data was not changed while traveling, e.g. `Transfer ₹1,000` altered to `Transfer ₹10,000` by an attacker. VPN technologies use cryptographic integrity checks to detect such modification.

## 1.8 VPN Security Summary

| Function       | Purpose                                    |
| -------------- | ------------------------------------------ |
| Encryption     | Prevent unauthorized reading               |
| Authentication | Verify user/device/gateway identity        |
| Integrity      | Detect unauthorized changes                |
| Tunneling      | Carry private traffic over another network |

---

# 2. VPN Types by Connection (Remote Access vs Site-to-Site)

## 2.1 Remote Access VPN

Connects an individual user/device to an organization's private network. Example: an employee works from home:

```text
Employee Laptop → Internet → Remote Access VPN → Company Network
```

The employee can securely access internal websites, file servers, applications, management systems, and other authorized resources.

**Architecture:**

```text
Home Employee → VPN Client → Internet → VPN Gateway → Company LAN → Internal Servers
```

The user's device runs a **VPN Client**; the organization runs a **VPN Server/Gateway**.
**Use cases:** work from home, travelling employees, system administrators, vendors, contractors, support engineers.

## 2.2 Site-to-Site VPN

Connects two entire networks (`Network A ↔ Network B`) instead of one user. Example:

```text
Delhi Office 10.1.0.0/24 → VPN Gateway → ===== Internet ===== → VPN Gateway → Pune Office 10.2.0.0/24
```

Users usually do not manually start the VPN — the gateways handle it:

```text
PC in Delhi (10.1.0.10) → Delhi Gateway → Encrypted VPN Tunnel → Pune Gateway → Server (10.2.0.20)
```

To users, the remote network can behave like another reachable private network.
**Use cases:** branch office connectivity, data center connectivity, cloud-to-office connectivity, office-to-office connectivity, hybrid cloud networking.

## 2.3 Commercial (Third-Party) VPN Example

Unlike a company Remote Access VPN (client → own company gateway → own internal server), a **commercial VPN** (e.g. NordVPN, ExpressVPN-style providers) routes the client's traffic through the _provider's_ server before it reaches the public Internet destination — there is no private internal network at the far end, just NAT out to the open Internet.

```text
Client (192.168.1.10)
      ↓ Original packet: SRC 192.168.1.10 → DST 11.11.11.11 (destination server)
Commercial VPN encryption
      ↓ Outer packet: SRC 192.168.1.10 → DST 203.0.113.10 (VPN Server)
        [Encrypted inner packet: 192.168.1.10 → 11.11.11.11]
Home Router NAT
      ↓ Outer packet: 49.36.20.10 → 203.0.113.10
Internet
      ↓
Commercial VPN Server (203.0.113.10)
      ↓ Decrypt + Decapsulate
      ↓ Usually SNAT to VPN exit IP
      ↓ 203.0.113.10 → 11.11.11.11
Public Internet
      ↓
Destination Firewall (Public IP: 11.11.11.11)
      ↓ DNAT / Port Forwarding: 11.11.11.11 → 10.10.10.10
Private LAN
      ↓
Destination Server (10.10.10.10)
```

> Key difference from a company VPN: the **VPN server itself acts as the client's identity on the Internet** — it decrypts the tunnel and then re-sends the traffic (SNAT'd to its own public "exit IP") toward the real destination, rather than delivering it into a private company network. From the destination server's point of view, the traffic appears to come from the VPN provider's exit IP, not the original client.

## 2.4 Remote Access VPN vs Site-to-Site VPN

| Remote Access VPN              | Site-to-Site VPN                     |
| ------------------------------ | ------------------------------------ |
| Connects one user/device       | Connects two networks                |
| User normally runs VPN client  | VPN gateways establish tunnel        |
| Employee → Company             | Office → Office                      |
| Used for remote workers        | Used for branch connectivity         |
| Per-user authentication common | Gateway/device authentication common |

---

# 3. VPN Types by Traffic Routing (Full Tunnel vs Split Tunnel)

## 3.1 Full Tunnel VPN

All configured user traffic is sent through the VPN tunnel, commonly including Internet-bound traffic.

```text
Employee Laptop → All Traffic → VPN Tunnel → Company VPN Gateway ─┬→ Company LAN
                                                                    └→ Internet
```

**Advantages:** central security inspection, central web filtering, central logging, better policy enforcement, Internet traffic passes through corporate security tools, easier to apply consistent controls.
**Disadvantages:** more traffic through company network, more bandwidth required, higher VPN gateway load, may increase latency, Internet browsing may be slower.

## 3.2 Split Tunnel VPN

Only selected traffic goes through the VPN; other traffic goes directly to the Internet.

```text
Employee Laptop ─┬→ Company Network (through VPN)
                  └→ Internet (directly)
```

**Advantages:** less VPN bandwidth usage, lower load on corporate gateway, faster Internet access, better performance for normal web traffic.
**Disadvantages:** some Internet traffic bypasses corporate security controls, less centralized visibility, security policies harder to enforce, endpoint security becomes especially important.

## 3.3 Full Tunnel vs Split Tunnel

| Full Tunnel                        | Split Tunnel                                |
| ---------------------------------- | ------------------------------------------- |
| All configured traffic through VPN | Only selected traffic through VPN           |
| More secure central control        | Better performance                          |
| More VPN bandwidth                 | Less VPN bandwidth                          |
| More corporate visibility          | Less visibility for direct Internet traffic |
| Higher gateway load                | Lower gateway load                          |
| Stronger centralized filtering     | More reliance on endpoint controls          |

```text
Full Tunnel:  Laptop → VPN → Company Gateway ─┬→ LAN
                                                └→ Internet
Split Tunnel: Laptop → Routing ─┬→ Company LAN
                                  └→ Internet directly
```

---

# 4. VPN Types by Security Model

## 4.1 Secure VPN

Uses cryptographic security to protect data over an untrusted network such as the Internet — commonly providing encryption, authentication, integrity, and secure tunneling.

> A Secure VPN protects data using cryptography while it travels over an untrusted network.
> Technologies: IPsec, OpenVPN, SSL/TLS-based VPN solutions.

```text
Private Network A → VPN Gateway → Encrypt → ===== Public Internet ===== → Decrypt → VPN Gateway → Private Network B
```

The public Internet does not need to be trusted because the VPN itself provides cryptographic protection.
**Example:** Without VPN, `Office A → Internet → Office B` is unprotected. With a Secure VPN: `Office A → Encrypt → ===== Encrypted Tunnel ===== → Decrypt → Office B`.

## 4.2 Trusted VPN

Relies mainly on a service provider's controlled private network to keep customer traffic separated from other customers — the network itself is trusted to provide isolation. Traditional examples: MPLS VPNs, carrier/private WAN services.

> A Trusted VPN relies on the service provider's private network and traffic separation rather than depending only on end-to-end encryption.
> **Example:** `Delhi Branch → Provider Private Network → Pune Branch`, where the provider keeps Company A's traffic logically isolated from Company B's traffic.
> **Is it always encrypted?** Not necessarily — an important interview point. A trusted provider VPN may offer traffic isolation, private routing, and service-level guarantees, but not automatically strong end-to-end encryption. Additional encryption can be added if stronger confidentiality is needed.

## 4.3 Secure VPN vs Trusted VPN

| Secure VPN                                    | Trusted VPN                                                 |
| --------------------------------------------- | ----------------------------------------------------------- |
| Relies on cryptography                        | Relies on provider-controlled network                       |
| Encryption is important                       | Encryption may not be inherent                              |
| Can use public Internet                       | Often uses provider private WAN                             |
| IPsec/OpenVPN are examples                    | MPLS VPN is a common example                                |
| Security comes from encryption/authentication | Security comes mainly from traffic isolation/provider trust |

## 4.4 Hybrid VPN

Combines a **trusted provider network** with **cryptographic VPN protection** — e.g. a company uses MPLS between branches but also runs IPsec encryption over that MPLS network:

```text
Hybrid VPN = Trusted Provider Network + Cryptographic VPN Security
```

---

# 5. Two Independent Axes: Connection Type vs Traffic Routing

These describe different things and are not competing terms.

```text
Remote Access / Site-to-Site → "Who or what is connected?"
Remote Access → User ↔ Network        Site-to-Site → Network ↔ Network

Full / Split Tunnel → "Which traffic goes through the tunnel?"
Full → All configured traffic         Split → Selected traffic
```

An employee can have `Remote Access VPN + Full Tunnel` or `Remote Access VPN + Split Tunnel` — these describe different parts of the VPN design and combine independently.

---

# 6. VPN Security in Practice

## 6.1 VPN Does Not Automatically Mean Anonymous

A VPN provides secure connectivity — it does **not** automatically mean complete anonymity, malware protection, no tracking, no authentication risk, or no endpoint compromise. A VPN mainly protects communication according to its design.

## 6.2 VPN and Defence in Depth

VPN should be one layer among many:

```text
Remote User → VPN → MFA → Firewall → Network Segmentation → Internal Application → SIEM Monitoring
```

## 6.3 VPN Security Risks

Weak passwords, stolen credentials, credential reuse, missing MFA, unpatched VPN gateway, incorrect firewall rules, over-permissive access, misconfigured split tunneling, weak cryptographic configuration, compromised endpoint.

## 6.4 VPN Misconfiguration Example

Bad: `VPN User → Connected → Access to Entire Internal Network`.
Better: `VPN User → Authentication + MFA → Role-Based Access → Only Required Servers`.
This follows **Least Privilege**.

---




# 11. Best Memory Diagram

```text
                         VPN
                          |
        --------------------------------------
        |                                    |
   Connection Type                      Traffic Routing
        |                                    |
  -----------------                    -----------------
  |               |                    |               |
Remote Access   Site-to-Site        Full Tunnel    Split Tunnel
  |               |                    |               |
User→Network   Network→Network       All via VPN    Selected via VPN
```

```text
Secure VPN → Encryption / Authentication / Integrity
Trusted VPN → Provider-controlled private network
Hybrid VPN → Trusted VPN + Secure VPN protection
```

> **Most important interview line:** Remote Access vs Site-to-Site tells you _who_ is connected, while Full Tunnel vs Split Tunnel tells you _which traffic_ goes through the VPN.
