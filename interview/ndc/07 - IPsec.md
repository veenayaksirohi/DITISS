# IPsec — Notes (Lite)

# 1. What is IPsec?

**IPsec** = **Internet Protocol Security** — a group of protocols that secure IP communication at **Layer 3 (Network Layer)**. Protects Host↔Host, Host↔Gateway, Gateway↔Gateway, Office↔Office.

> IPsec is a Layer 3 security technology that protects IP packets using encryption, authentication, and integrity checking.

```text
Office A → VPN Gateway → ====== IPsec Tunnel ====== → VPN Gateway → Office B
```

Because it works at Layer 3, it transparently protects upper-layer traffic (HTTP, HTTPS, SSH, FTP, RDP, DB traffic, etc.) without those protocols needing to know about it.

# 2. Why & What It Provides

Without protection, an attacker on the path could read/modify data, impersonate a system, capture packets, or replay old ones. IPsec provides:

1. **Encryption** (Confidentiality) — Plaintext → Ciphertext, only the holder of the correct key can decrypt.
2. **Authentication** — confirms _who_ sent the packet (PSK, digital certificates).
3. **Integrity** — detects if data was modified in transit (e.g. `₹1,000` altered to `₹10,000`).
4. **Anti-Replay Protection** — sequence numbers reject a captured packet that's resent later.
5. **Secure key negotiation** — via **IKE**.

# 3. AH vs ESP

The two core IPsec protocols:

```text
AH  → Authentication + Integrity (no encryption)
ESP → Encryption + Authentication + Integrity
```

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

# 4. Transport Mode vs Tunnel Mode

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

# 5. IKE & Security Associations

**IKE (Internet Key Exchange)** is how IPsec peers automatically negotiate the connection before ESP starts protecting traffic — authenticating each other, agreeing on algorithms, deriving keys, and creating a **Security Association (SA)**.

```text
IKE Starts → Negotiate Algorithms → Authenticate Peers (PSK/Certificate) → Diffie-Hellman Key Exchange
           → Create Security Association → ESP Tunnel Established → Encrypted Data Flows
```

A **Security Association (SA)** is the resulting set of parameters (encryption algorithm, integrity algorithm, keys, lifetime, mode) both peers agree to use.
**IKEv1 vs IKEv2:** IKEv1 traditionally uses two phases (**Phase 1** — secure the negotiation channel; **Phase 2** — negotiate IPsec data protection). **IKEv2** is newer, simpler, more reliable, and generally preferred — it doesn't map cleanly onto IKEv1's phase model.

# 6. NAT-T (NAT Traversal)

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

# 7. Site-to-Site IPsec — Full Flow

```text
Private Host A (192.168.1.10) → Original Packet → VPN Gateway A
   → IKE negotiates keys/SA → ESP protects packet (Tunnel Mode encapsulation)
   → ===== Internet (outer header = Gateway A Public IP → Gateway B Public IP) =====
   → VPN Gateway B → Verify integrity/authentication → Decrypt → Remove tunnel header
   → Original Packet Recovered → Private Host B (192.168.2.20)
```

# 8. IPsec vs SSL/TLS VPN

| IPsec VPN                   | SSL/TLS VPN                                 |
| --------------------------- | ------------------------------------------- |
| Works mainly at Layer 3     | Uses TLS above the network layer            |
| Protects IP traffic broadly | Common for remote-access/application access |
| Common in site-to-site VPN  | Common in remote-access solutions           |
| Often gateway-to-gateway    | Often client/browser/application based      |

# 9. Advantages & Limitations

**Advantages:** strong encryption, authentication, integrity, network-layer transparency (protects many protocols automatically), well suited to site-to-site VPNs, anti-replay protection.
**Limitations:** configuration complexity (both peers must agree on settings), NAT may require NAT-T, firewall must allow the right ports/protocols (UDP 500, UDP 4500, ESP/AH), added cryptographic processing overhead, troubleshooting can be harder than plain routing.

# 10. Scenario-Based Interview Questions

1. **Two offices need to securely communicate over the Internet — which mode?**
   **Tunnel Mode** — the gateways need to protect and encapsulate the entire original packet.

2. **You need confidentiality + authentication + integrity — AH or ESP?**
   **ESP** — AH does not encrypt data.

3. **Two hosts communicate directly via IPsec with no extra outer header needed — which mode?**
   **Transport Mode.**

4. **An IPsec tunnel won't establish — what would you check?**

```text
Gateways can reach each other? → UDP 500 allowed? → NAT present (check UDP 4500/NAT-T)?
→ Same IKE version? → PSK/certificate correct? → Encryption/integrity algorithms match? → Correct subnets?
```

5. **Tunnel shows UP, but users can't reach the remote network — what would you check?**
   Local/remote subnet definitions, routing table, firewall rules, NAT exemption, return route, host firewalls, traffic selectors.

6. **An IPsec client is behind a NAT router — what feature is needed?**
   **NAT-T**, commonly over UDP 4500.

7. **An attacker resends a previously captured valid IPsec packet — what stops it?**
   **Anti-Replay Protection**, using sequence numbers.

> **Best interview line:** IKE negotiates the tunnel, ESP protects the data, and Tunnel Mode is the common choice for site-to-site IPsec VPNs.
