# IPsec — Notes (Lite)

# 1. What is IPsec?

**IPsec** = **Internet Protocol Security** — a group of protocols that secure IP communication at **Layer 3 (Network Layer)**. Protects Host↔Host, Host↔Gateway, Gateway↔Gateway, Office↔Office.

> IPsec is a Layer 3 security technology that protects IP packets using encryption, authentication, and integrity checking.

```text
Office A → VPN Gateway → ====== IPsec Tunnel ====== → VPN Gateway → Office B
```

Because it works at Layer 3, it transparently protects upper-layer traffic (HTTP, HTTPS, SSH, FTP, RDP, DB traffic, etc.) without those protocols needing to know about it.

## 1.1 Why & What It Provides

Without protection, an attacker on the path could read/modify data, impersonate a system, capture packets, or replay old ones. IPsec provides:

1. **Encryption** (Confidentiality) — Plaintext → Ciphertext, only the holder of the correct key can decrypt.
2. **Authentication** — confirms _who_ sent the packet (PSK, digital certificates).
3. **Integrity** — detects if data was modified in transit (e.g. `₹1,000` altered to `₹10,000`).
4. **Anti-Replay Protection** — sequence numbers reject a captured packet that's resent later.
5. **Secure key negotiation** — via **IKE**.

---

# 2. The Three IPsec Protocols

IPsec is called "a group of protocols" because it's built from three pieces that work together:

```text
AH  → Authentication Header          → proves the packet is authentic and untampered, but does NOT encrypt it
ESP → Encapsulating Security Payload → does everything AH does, PLUS encrypts the content
IKE → Internet Key Exchange          → the negotiation protocol that runs BEFORE AH/ESP, agreeing on keys & algorithms
```

> **One-line summary:** AH = "proof of authenticity, no privacy." ESP = "authenticity + privacy." IKE = "the handshake that sets everything up before AH/ESP can run."

## 2.1 AH vs ESP

| Feature        | AH (Authentication Header)                      | ESP (Encapsulating Security Payload) |
| -------------- | ----------------------------------------------- | ------------------------------------ |
| Encryption     | ❌ No                                           | ✅ Yes                               |
| Authentication | ✅ Yes                                          | ✅ Supported                         |
| Integrity      | ✅ Yes                                          | ✅ Supported                         |
| Anti-Replay    | ✅ Yes                                          | ✅ Yes                               |
| IP Protocol    | 51                                              | 50                                   |
| NAT Friendly   | Poor (protects IP-header info that NAT changes) | Better, with NAT-T                   |
| Commonly Used  | Less common                                     | **Very common — preferred choice**   |

> Both AH and ESP are IP protocols, **not** TCP/UDP ports.
> **Why ESP wins in practice:** it gives confidentiality _plus_ integrity/authentication/anti-replay, while AH lacks encryption entirely — so ESP is the default choice for modern IPsec VPNs.

## 2.2 IKE & Security Associations

**IKE** is how IPsec peers automatically negotiate the connection before ESP starts protecting traffic — authenticating each other, agreeing on algorithms, deriving keys, and creating a **Security Association (SA)**.

```text
IKE Starts → Negotiate Algorithms → Authenticate Peers (PSK/Certificate) → Diffie-Hellman Key Exchange
           → Create Security Association → ESP Tunnel Established → Encrypted Data Flows
```

A **Security Association (SA)** is the resulting set of parameters (encryption algorithm, integrity algorithm, keys, lifetime, mode) both peers agree to use.

**IKEv1 vs IKEv2:** IKEv1 traditionally uses two phases (**Phase 1** — secure the negotiation channel; **Phase 2** — negotiate IPsec data protection). **IKEv2** is newer, simpler, more reliable, and generally preferred — it doesn't map cleanly onto IKEv1's phase model.

## 2.3 NAT-T (NAT Traversal)

NAT changes source/destination IP info, which breaks AH's integrity check and complicates raw ESP. **NAT-T** solves this by wrapping ESP traffic inside UDP so it can pass through NAT devices.

```text
ESP Traffic → NAT-T → UDP Encapsulation (UDP 4500) → NAT Device → Internet
```

### Port / Protocol Reference

| Component | Protocol / Port |
| --------- | --------------- |
| IKE       | UDP 500         |
| NAT-T     | UDP 4500        |
| ESP       | IP Protocol 50  |
| AH        | IP Protocol 51  |

---

# 3. IPsec Modes: Transport vs Tunnel

| Transport Mode                                                     | Tunnel Mode                                                            |
| ------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| Protects mainly the IP **payload**; original IP header stays outer | Protects the **entire original IP packet**, wrapped in a new IP header |
| Less overhead                                                      | More overhead                                                          |
| Common for **Host ↔ Host**                                         | Common for **Gateway ↔ Gateway** (Site-to-Site VPN)                    |
| Endpoints handle IPsec directly                                    | VPN gateways handle IPsec                                              |

```text
Transport: [Original IP Header][ESP][Encrypted TCP/UDP + Data]      → routing addresses unchanged
Tunnel:    [New IP Header][ESP][Encrypted: Original IP Header + TCP/UDP + Data]  → new outer routing addresses
```

**Tunnel Mode example (Site-to-Site):** original packet `10.1.0.10 → 10.2.0.20` (private IPs) gets encapsulated so the Internet only sees the outer header `Gateway A Public IP → Gateway B Public IP`; the private inner addresses travel hidden inside.

---

# 4. Site-to-Site IPsec — Full Flow

```text
Private Host A (192.168.1.10) → Original Packet → VPN Gateway A
   → IKE negotiates keys/SA → ESP protects packet (Tunnel Mode encapsulation)
   → ===== Internet (outer header = Gateway A Public IP → Gateway B Public IP) =====
   → VPN Gateway B → Verify integrity/authentication → Decrypt → Remove tunnel header
   → Original Packet Recovered → Private Host B (192.168.2.20)
```

---

# 5. IPsec vs SSL/TLS VPN

| IPsec VPN                   | SSL/TLS VPN                                 |
| --------------------------- | ------------------------------------------- |
| Works mainly at Layer 3     | Uses TLS above the network layer            |
| Protects IP traffic broadly | Common for remote-access/application access |
| Common in site-to-site VPN  | Common in remote-access solutions           |
| Often gateway-to-gateway    | Often client/browser/application based      |

---

# 6. Advantages & Limitations

**Advantages:** strong encryption, authentication, integrity, network-layer transparency (protects many protocols automatically), well suited to site-to-site VPNs, anti-replay protection.

**Limitations:** configuration complexity (both peers must agree on settings), NAT may require NAT-T, firewall must allow the right ports/protocols (UDP 500, UDP 4500, ESP/AH), added cryptographic processing overhead, troubleshooting can be harder than plain routing.

---


# 9. One-Line Revision

```text
IPsec → Layer 3 security framework.
AH → Authentication + Integrity, No Encryption.
ESP → Encryption + Authentication/Integrity (commonly used).
Transport Mode → Protects payload; original IP header remains; host-to-host.
Tunnel Mode → Protects whole packet; new IP header added; gateway-to-gateway.
IKE → Negotiates peers, algorithms, keys, and SAs.
SA → Security parameters both peers agree to use.
NAT-T → Lets IPsec work through NAT via UDP 4500.
```

> **Best interview line:** IKE negotiates the tunnel, ESP protects the data, and Tunnel Mode is the common choice for site-to-site IPsec VPNs.
