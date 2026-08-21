# IPsec — Detailed Notes

## 1. What is IPsec?

**IPsec** stands for **Internet Protocol Security**.

IPsec is a group of protocols used to secure IP communication at the **Network Layer (Layer 3)**.

It can protect communication between:

- Host ↔ Host
- Host ↔ VPN Gateway
- VPN Gateway ↔ VPN Gateway
- Office ↔ Office
- User ↔ Corporate Network

### Simple Definition

> **IPsec is a Layer 3 security technology that protects IP packets using encryption, authentication, and integrity checking.**

A common use of IPsec is a **Site-to-Site VPN**.

```text
Office A
   ↓
VPN Gateway
   ↓
====== IPsec Tunnel ======
   ↓
VPN Gateway
   ↓
Office B
```

---

# 2. Why is IPsec Used?

The Internet is an untrusted network.

Without protection:

```text
Office A
   ↓
Internet
   ↓
Office B
```

An attacker on the path may try to:

- Read data
- Modify data
- Pretend to be another system
- Capture packets
- Replay old packets

IPsec adds security:

```text
Original Packet
      ↓
IPsec Protection
      ↓
Encrypted / Authenticated Packet
      ↓
Internet
      ↓
IPsec Verification
      ↓
Original Packet
```

---

# 3. Where Does IPsec Work in the OSI Model?

IPsec works mainly at:

> **Layer 3 — Network Layer**

This is important.

Because IPsec works at Layer 3, it can protect many upper-layer protocols.

For example:

```text
HTTP
HTTPS
SSH
FTP
RDP
Database Traffic
```

can all travel through an IPsec tunnel.

### Easy Idea

```text
Application Data
      ↓
TCP / UDP
      ↓
IP
      ↓
IPsec Protection
      ↓
Network
```

---

# 4. Main Security Services of IPsec

IPsec provides:

1. **Encryption**
2. **Authentication**
3. **Integrity**
4. **Anti-replay protection**
5. **Secure key negotiation through IKE**

Easy memory:

```text
IPsec
  ↓
Confidentiality
+
Authentication
+
Integrity
+
Anti-Replay
```

---

# 5. Encryption in IPsec

## What is Encryption?

Encryption converts readable data into unreadable data.

```text
Plaintext
   ↓
Encryption
   ↓
Ciphertext
```

Example:

```text
Original:
Username = admin

Encrypted:
X8#K29....
```

Only someone with the correct cryptographic key should be able to decrypt it.

### Security Goal

Encryption provides:

> **Confidentiality**

---

# 6. IPsec Encryption

In IPsec, encryption is mainly provided by:

> **ESP — Encapsulating Security Payload**

Example:

```text
Original Packet
      ↓
ESP Encryption
      ↓
Encrypted Packet
      ↓
Internet
```

An attacker capturing the packet cannot easily read the protected content.

---

# 7. Authentication in IPsec

**Authentication** confirms that the communicating party is legitimate.

It answers:

> **Who sent this packet?**

IPsec peers can authenticate using methods such as:

- Pre-Shared Key (PSK)
- Digital certificates
- Other supported authentication methods

Example:

```text
VPN Gateway A
      ↓
Authentication
      ↓
VPN Gateway B
      ↓
Identity Verified
```

---

# 8. Integrity in IPsec

**Integrity** ensures that data was not modified during transmission.

Example:

Original packet:

```text
Transfer = ₹1,000
```

Attacker changes it:

```text
Transfer = ₹10,000
```

Integrity checking helps detect that the packet was modified.

### Simple Definition

> **Integrity ensures that the received data is the same as the data that was originally sent.**

---

# 9. Anti-Replay Protection

IPsec can also protect against **replay attacks**.

A replay attack happens when an attacker captures a valid packet and sends it again later.

Example:

```text
Valid Packet
   ↓
Attacker captures it
   ↓
Attacker sends same packet again
```

IPsec uses sequence numbers and replay protection mechanisms to detect repeated old packets.

```text
Old / Replayed Packet
       ↓
IPsec
       ↓
Sequence Check
       ↓
Reject
```

---

# 10. Main IPsec Protocols

The two important IPsec protocols are:

1. **AH — Authentication Header**
2. **ESP — Encapsulating Security Payload**

And for negotiation:

3. **IKE — Internet Key Exchange**

Easy memory:

```text
AH
→ Authentication + Integrity

ESP
→ Encryption + Authentication + Integrity

IKE
→ Negotiates keys and security settings
```

---

# 11. AH — Authentication Header

**AH** stands for:

> **Authentication Header**

AH provides:

- Authentication
- Integrity
- Anti-replay protection

AH does **not provide encryption**.

### Simple Definition

> AH verifies that the packet is authentic and has not been modified, but it does not hide the packet contents.

---

# 12. AH Security Services

| Feature        | AH     |
| -------------- | ------ |
| Encryption     | ❌ No  |
| Authentication | ✅ Yes |
| Integrity      | ✅ Yes |
| Anti-Replay    | ✅ Yes |

### Easy Memory

```text
AH
→ Authenticate
→ Check Integrity
→ No Encryption
```

---

# 13. AH Example

Original data:

```text
Hello Veenayak
```

With AH:

```text
Hello Veenayak
+
Authentication / Integrity Information
```

The content itself remains readable.

So if someone captures it, the data is not encrypted by AH.

---

# 14. AH IP Protocol Number

AH uses IP protocol number:

```text
51
```

Important:

> AH does **not use a TCP or UDP port**.

It is its own IP protocol.

---

# 15. Limitation of AH

AH is not commonly preferred in modern VPN deployments because:

- It does not encrypt data.
- NAT can cause problems with AH because AH protects IP-header-related information that NAT changes.
- ESP can provide confidentiality as well as authentication/integrity.

Therefore ESP is much more commonly used.

---

# 16. ESP — Encapsulating Security Payload

**ESP** stands for:

> **Encapsulating Security Payload**

ESP is the most commonly used IPsec protocol.

It can provide:

- Encryption
- Authentication
- Integrity
- Anti-replay protection

### Simple Definition

> ESP protects IP traffic by encrypting the protected content and can also verify its authenticity and integrity.

---

# 17. ESP Security Services

| Feature        | ESP          |
| -------------- | ------------ |
| Encryption     | ✅ Yes       |
| Authentication | ✅ Supported |
| Integrity      | ✅ Supported |
| Anti-Replay    | ✅ Yes       |

### Easy Memory

```text
ESP
→ Encrypt
→ Authenticate
→ Integrity
```

---

# 18. ESP Example

Original packet:

```text
Username = admin
Password = secret
```

ESP:

```text
Original Packet
      ↓
Encryption
      ↓
X9@#K8L....
```

The protected content becomes unreadable to someone who does not have the key.

---

# 19. ESP IP Protocol Number

ESP uses IP protocol number:

```text
50
```

Like AH:

> ESP itself does not use a TCP or UDP port.

---

# 20. AH vs ESP

This is a very important interview question.

| Feature        | AH                    | ESP                            |
| -------------- | --------------------- | ------------------------------ |
| Full Form      | Authentication Header | Encapsulating Security Payload |
| Encryption     | No                    | Yes                            |
| Authentication | Yes                   | Supported                      |
| Integrity      | Yes                   | Supported                      |
| Anti-Replay    | Yes                   | Yes                            |
| IP Protocol    | 51                    | 50                             |
| NAT Friendly   | Poor                  | Better with NAT-T              |
| Commonly Used  | Less common           | Very common                    |

### Easy Memory

```text
AH
→ Authentication only, no confidentiality

ESP
→ Encryption + security protection
```

---

# 21. Which One is Commonly Used?

For modern IPsec VPNs:

> **ESP is normally preferred.**

Why?

Because ESP provides:

- Confidentiality through encryption
- Integrity
- Authentication
- Anti-replay protection

AH lacks encryption.

---

# 22. IPsec Modes

IPsec has two important modes:

1. **Transport Mode**
2. **Tunnel Mode**

These determine how much of the original IP packet is protected.

---

# 23. Transport Mode

In **Transport Mode**, IPsec protects mainly the **IP payload**.

The original IP header remains the outer header.

### Basic Structure

Before:

```text
[ Original IP Header ]
[ TCP/UDP Header ]
[ Data ]
```

With ESP transport mode:

```text
[ Original IP Header ]
[ ESP ]
[ Encrypted TCP/UDP + Data ]
```

### Key Point

> The original IP header remains visible for routing.

---

# 24. Transport Mode Use Case

Transport mode is commonly associated with:

> **Host-to-Host communication**

Example:

```text
Host A
  ↓
IPsec Transport Mode
  ↓
Host B
```

Both endpoints participate directly in IPsec.

---

# 25. Transport Mode Diagram

```text
Host A
192.168.1.10
      ↓
IPsec Protected Communication
      ↓
Host B
192.168.1.20
```

The original IP addresses remain the packet's routing addresses.

---

# 26. Tunnel Mode

In **Tunnel Mode**, the **entire original IP packet** is protected and encapsulated inside a new IP packet.

### Before

```text
[ Original IP Header ]
[ TCP/UDP Header ]
[ Data ]
```

### After

```text
[ New IP Header ]
[ ESP Header ]
[ Encrypted Original IP Header ]
[ Encrypted TCP/UDP Header ]
[ Encrypted Data ]
```

### Key Point

> A new IP header is added and the entire original packet is carried inside the tunnel.

---

# 27. Tunnel Mode Use Case

Tunnel mode is commonly used for:

> **Gateway-to-Gateway / Site-to-Site VPNs**

Example:

```text
Office A LAN
10.1.0.0/24
     ↓
VPN Gateway A
     ↓
===== IPsec Tunnel =====
     ↓
VPN Gateway B
     ↓
Office B LAN
10.2.0.0/24
```

---

# 28. Why Tunnel Mode is Good for Site-to-Site VPN

Consider an original packet:

```text
Source:
10.1.0.10

Destination:
10.2.0.20
```

These are private IP addresses.

The VPN gateways encapsulate this packet.

Across the Internet:

```text
Outer Source:
Public IP of Gateway A

Outer Destination:
Public IP of Gateway B
```

Inside the tunnel:

```text
Original Source:
10.1.0.10

Original Destination:
10.2.0.20
```

---

# 29. Tunnel Mode Packet Example

Original:

```text
[10.1.0.10 → 10.2.0.20]
[Application Data]
```

After IPsec tunnel encapsulation:

```text
[Public Gateway A → Public Gateway B]
[
   Encrypted:
   10.1.0.10 → 10.2.0.20
   Application Data
]
```

The Internet routes using the **outer public IP header**.

---

# 30. Transport Mode vs Tunnel Mode

| Transport Mode                              | Tunnel Mode                                    |
| ------------------------------------------- | ---------------------------------------------- |
| Protects mainly IP payload                  | Protects entire original IP packet             |
| Original IP header remains outer header     | New IP header is added                         |
| Less overhead                               | More overhead                                  |
| Host-to-host common                         | Gateway-to-gateway common                      |
| End hosts handle IPsec                      | VPN gateways often handle IPsec                |
| Original endpoints remain routing endpoints | Gateway public IPs are outer routing endpoints |

---

# 31. Easy Memory

```text
Transport Mode
→ Payload protected

Tunnel Mode
→ Whole original packet protected
```

And:

```text
Transport
→ Host ↔ Host

Tunnel
→ Gateway ↔ Gateway
```

---

# 32. What is IKE?

**IKE** stands for:

> **Internet Key Exchange**

IKE is used by IPsec peers to:

- Authenticate each other
- Agree on security algorithms
- Exchange/derive cryptographic keys
- Create Security Associations
- Rekey connections when needed

### Simple Definition

> **IKE automatically negotiates the keys and security settings needed to create an IPsec connection.**

---

# 33. Why is IKE Needed?

Imagine two VPN gateways:

```text
Gateway A
    ↔
Gateway B
```

Before they encrypt traffic, they must agree on:

- Which encryption algorithm?
- Which integrity method?
- Which keys?
- How long should keys be used?
- Who is the other gateway?
- Which IPsec parameters should be used?

IKE handles this negotiation.

---

# 34. IKE Flow

```text
VPN Gateway A
       ↓
      IKE
       ↓
Negotiate Algorithms
       ↓
Authenticate Peers
       ↓
Create Shared Keys
       ↓
Create Security Association
       ↓
IPsec ESP Tunnel Established
       ↓
Encrypted Data Transfer
```

---

# 35. IKE Authentication

IKE peers may authenticate using:

- Pre-Shared Key (PSK)
- Digital certificates
- Other supported authentication mechanisms

Example:

```text
Gateway A
   ↓
PSK / Certificate
   ↓
Gateway B
   ↓
Identity Verified
```

---

# 36. IKE and Diffie-Hellman

IKE commonly uses **Diffie-Hellman key exchange** to help establish shared cryptographic key material.

The important idea is:

```text
Gateway A
     +
Gateway B
     ↓
Key Exchange
     ↓
Shared Secret Material
```

The secret key itself does not simply need to be sent across the network in plaintext.

---

# 37. IKE Versions

The important versions are:

- **IKEv1**
- **IKEv2**

IKEv2 is the newer protocol and is generally preferred for modern deployments.

### IKEv2 Advantages

- Simpler negotiation
- Fewer message exchanges
- Better handling of connection changes
- Better support for modern VPN deployments
- Improved reliability compared with IKEv1

---

# 38. IKEv1 Phases — Interview Concept

Traditional IKEv1 is often explained using:

### Phase 1

Establish a secure management channel between the IPsec peers.

```text
Gateway A
   ↓
IKE Phase 1
   ↓
Authenticate Peers
   ↓
Secure IKE Channel
```

### Phase 2

Negotiate the actual IPsec security parameters used for protecting user traffic.

```text
Secure IKE Channel
       ↓
IKE Phase 2
       ↓
IPsec Security Association
       ↓
Protected Traffic
```

### Easy Memory

```text
Phase 1
→ Secure the negotiation channel

Phase 2
→ Negotiate IPsec data protection
```

For IKEv2, the exchanges are organized differently, so avoid saying IKEv2 literally uses IKEv1's Phase 1/Phase 2 model.

---

# 39. What is a Security Association (SA)?

A **Security Association (SA)** is a set of security parameters used to protect traffic.

It can contain information such as:

- Encryption algorithm
- Integrity algorithm
- Cryptographic keys
- Lifetime
- IPsec mode
- Security identifiers

### Simple Definition

> An SA defines how IPsec traffic should be protected.

---

# 40. SA Example

Conceptually:

```text
IPsec SA
  ↓
Encryption = AES
Integrity = SHA-2 family
Mode = Tunnel
Key = ...
Lifetime = ...
```

Both IPsec peers need compatible security parameters.

---

# 41. IPsec Negotiation Process

A simplified complete flow:

```text
Gateway A
    ↓
IKE Starts
    ↓
Negotiate Algorithms
    ↓
Authenticate Both Peers
    ↓
Establish Key Material
    ↓
Create Security Associations
    ↓
ESP Tunnel Created
    ↓
Encrypted Traffic Flows
```

---

# 42. IKE Ports

IKE commonly uses:

```text
UDP 500
```

When NAT Traversal is used:

```text
UDP 4500
```

Important interview ports:

| Technology  | Protocol / Port |
| ----------- | --------------- |
| IKE         | UDP 500         |
| IPsec NAT-T | UDP 4500        |
| ESP         | IP Protocol 50  |
| AH          | IP Protocol 51  |

---

# 43. What is NAT-T?

**NAT-T** stands for:

> **NAT Traversal**

NAT can cause problems for native IPsec traffic.

NAT-T allows IPsec ESP traffic to be carried inside UDP packets.

Commonly:

```text
UDP 4500
```

### Basic Flow

```text
ESP Traffic
    ↓
NAT-T
    ↓
UDP Encapsulation
    ↓
UDP 4500
    ↓
NAT Device
```

---

# 44. Why NAT-T is Needed

Suppose:

```text
VPN Client
Private IP
   ↓
NAT Router
   ↓
Internet
   ↓
VPN Gateway
```

The NAT router changes addresses.

NAT-T helps IPsec work through such NAT devices by encapsulating the protected traffic in UDP.

---

# 45. AH and NAT Problem

AH protects information related to the IP header.

But NAT changes:

```text
Source / Destination IP information
```

Therefore the integrity verification may fail.

Conceptually:

```text
Original Packet
    ↓
AH Integrity Calculation
    ↓
NAT modifies IP information
    ↓
Receiver calculates integrity
    ↓
Mismatch
```

That is one reason AH is difficult to use through NAT.

---

# 46. ESP and NAT-T

ESP combined with NAT-T works much better through NAT.

```text
Original Packet
      ↓
ESP Protection
      ↓
UDP Encapsulation
      ↓
UDP 4500
      ↓
NAT Router
      ↓
Internet
```

This is very common in real VPN environments.

---

# 47. Site-to-Site IPsec Example

Consider:

```text
Delhi Office:
192.168.1.0/24

Pune Office:
192.168.2.0/24
```

Architecture:

```text
Delhi LAN
192.168.1.0/24
      ↓
Delhi VPN Gateway
Public IP A
      ↓
===== IPsec ESP Tunnel =====
      ↓
Pune VPN Gateway
Public IP B
      ↓
Pune LAN
192.168.2.0/24
```

---

# 48. Packet Journey in Site-to-Site IPsec

Suppose:

```text
PC A:
192.168.1.10

Server B:
192.168.2.20
```

PC sends:

```text
192.168.1.10
     ↓
192.168.2.20
```

Gateway A receives the packet.

It applies tunnel mode:

```text
Original Packet
192.168.1.10 → 192.168.2.20
        ↓
Encrypt
        ↓
New Outer Header:
Gateway A Public IP → Gateway B Public IP
```

Internet transports the packet.

Gateway B:

```text
Receives packet
      ↓
Authenticates / Checks integrity
      ↓
Decrypts
      ↓
Removes outer header
      ↓
Original packet recovered
      ↓
192.168.2.20
```

---

# 49. Full IPsec Flow

```text
Private Host A
      ↓
Original IP Packet
      ↓
VPN Gateway A
      ↓
IKE Negotiates Keys / SA
      ↓
ESP Protects Packet
      ↓
Tunnel Mode Encapsulation
      ↓
===== Internet =====
      ↓
VPN Gateway B
      ↓
Verify Integrity / Authentication
      ↓
Decrypt
      ↓
Remove Tunnel Header
      ↓
Original Packet
      ↓
Private Host B
```

---

# 50. Common IPsec Encryption Algorithms

Depending on the implementation and policy, IPsec can use modern encryption algorithms such as:

- AES
- AES-GCM

Older algorithms such as DES or 3DES are considered legacy and should not be selected for modern secure deployments.

For interviews, the key idea is:

> Both sides must agree on compatible cryptographic algorithms.

---

# 51. Integrity Algorithms

IPsec can use cryptographic integrity mechanisms.

Modern configurations commonly use secure SHA-2-family algorithms or authenticated encryption such as AES-GCM where supported.

Avoid thinking of MD5 or SHA-1 as preferred modern choices.

---

# 52. IPsec and VPN

IPsec and VPN are related, but they are not exactly the same term.

### VPN

The overall private secure connection.

### IPsec

One technology used to build VPNs.

```text
VPN
  ↓
Can be implemented using:
IPsec
OpenVPN
SSL/TLS VPN
etc.
```

---

# 53. IPsec vs SSL/TLS VPN — Basic Idea

| IPsec VPN                  | SSL/TLS VPN                                 |
| -------------------------- | ------------------------------------------- |
| Works mainly at Layer 3    | Commonly uses TLS above the network layer   |
| Protects IP traffic        | Common for remote-access/application access |
| Common in site-to-site VPN | Common in remote-access solutions           |
| Often gateway-to-gateway   | Often client/browser/application based      |

You only need this basic distinction unless specifically asked.

---

# 54. IPsec Advantages

- Strong encryption
- Authentication
- Integrity protection
- Network-layer security
- Good for site-to-site VPNs
- Transparent to many applications
- Can protect many protocols
- Supports anti-replay protection

---

# 55. IPsec Limitations

- Configuration can be complex
- Both peers must agree on settings
- NAT may require NAT-T
- Incorrect routes can break communication
- Firewall ports/protocols must be allowed
- Cryptographic processing adds overhead
- Troubleshooting can be more complex than plain routing

---

# 56. Common IPsec Configuration Problems

Typical issues include:

- Wrong pre-shared key
- Encryption mismatch
- Integrity algorithm mismatch
- IKE version mismatch
- Incorrect local/remote subnets
- Firewall blocking UDP 500
- Firewall blocking UDP 4500
- ESP blocked
- Routing problem
- NAT problem
- Security Association not established
- Incorrect certificates
- Expired certificates

---

# 57. Scenario-Based Question 1 — Site-to-Site VPN

### Question

Two offices must securely communicate over the public Internet. Which IPsec mode would you use?

### Answer

> **Tunnel Mode**

because the VPN gateways need to protect and encapsulate the entire original IP packet.

```text
Office A
   ↓
Gateway A
   ↓
IPsec Tunnel Mode
   ↓
Gateway B
   ↓
Office B
```

---

# 58. Scenario-Based Question 2 — AH vs ESP

### Question

You need confidentiality, authentication, and integrity. Should you use AH or ESP?

### Answer

> **ESP**

because ESP supports encryption as well as integrity/authentication protection.

AH does not encrypt the data.

---

# 59. Scenario-Based Question 3 — Authentication but No Encryption

### Question

You want integrity and authentication but do not require confidentiality. Which IPsec protocol conceptually provides this?

### Answer

> **AH**

because AH provides authentication and integrity but no encryption.

However, ESP is much more commonly used in modern VPN deployments.

---

# 60. Scenario-Based Question 4 — Host-to-Host

### Question

Two individual hosts are communicating directly using IPsec and do not need an additional outer IP header.

Which mode may be used?

### Answer

> **Transport Mode**

---

# 61. Scenario-Based Question 5 — VPN Tunnel Does Not Establish

### Question

Two IPsec gateways cannot establish a VPN tunnel. What would you check?

### Troubleshooting Flow

```text
1. Can gateways reach each other?
        ↓
2. UDP 500 allowed?
        ↓
3. NAT present? Check UDP 4500/NAT-T
        ↓
4. Same IKE version?
        ↓
5. Authentication/PSK correct?
        ↓
6. Encryption algorithms match?
        ↓
7. Integrity parameters match?
        ↓
8. Local/remote subnets correct?
        ↓
9. Security Associations created?
```

---

# 62. Scenario-Based Question 6 — Tunnel Up but No Traffic

### Question

The IPsec tunnel shows **UP**, but users cannot access the remote network. What would you check?

### Answer

Check:

- Local subnet
- Remote subnet
- Routing table
- Firewall rules
- NAT exemption/policy if required
- Remote return route
- Host firewalls
- SA counters
- Correct traffic selectors

Flow:

```text
Tunnel UP
   ↓
Correct Route?
   ↓
Correct Firewall Rule?
   ↓
Correct Local/Remote Networks?
   ↓
Return Route?
   ↓
Host Firewall?
```

---

# 63. Scenario-Based Question 7 — NAT Device Between VPN Peers

### Question

An IPsec client is behind a NAT router. What feature may be required?

### Answer

> **NAT-T — NAT Traversal**

It commonly carries IPsec traffic using:

```text
UDP 4500
```

---

# 64. Scenario-Based Question 8 — IKE

### Question

Before ESP starts encrypting data, how do the VPN gateways agree on keys and security algorithms?

### Answer

Using:

> **IKE — Internet Key Exchange**

IKE authenticates the peers, negotiates cryptographic parameters, creates key material, and establishes Security Associations.

---

# 65. Scenario-Based Question 9 — Configuration Mismatch

### Question

Gateway A supports:

```text
AES-256
```

but Gateway B is configured for an incompatible encryption proposal.

What happens?

### Answer

The peers may fail to establish the required Security Association because they cannot agree on matching security parameters.

---

# 66. Scenario-Based Question 10 — Captured ESP Traffic

### Question

An attacker captures packets from an IPsec ESP tunnel. Can they directly read the application data?

### Answer

If ESP encryption is correctly configured, the protected payload should be encrypted and not directly readable without the required cryptographic keys.

---

# 67. Scenario-Based Question 11 — Replay Attack

### Question

An attacker captures a valid IPsec packet and sends it again later.

What IPsec feature helps?

### Answer

> **Anti-Replay Protection**

IPsec uses sequence information to detect and reject replayed packets.

---

# 68. Most Important Interview Questions

1. What is IPsec?
2. At which OSI layer does IPsec work?
3. Why is IPsec used?
4. What security services does IPsec provide?
5. What is encryption?
6. What is authentication?
7. What is integrity?
8. What is anti-replay protection?
9. What is AH?
10. What does AH provide?
11. Does AH provide encryption?
12. What is ESP?
13. What does ESP provide?
14. AH vs ESP?
15. Which is more commonly used?
16. What is Transport Mode?
17. What is Tunnel Mode?
18. Transport vs Tunnel Mode?
19. Which mode is common for site-to-site VPN?
20. Which mode is common for host-to-host?
21. What is IKE?
22. Why is IKE needed?
23. What is a Security Association?
24. What is Diffie-Hellman used for?
25. What is IKEv1?
26. What is IKEv2?
27. What is NAT-T?
28. Which port does IKE use?
29. Which port does NAT-T use?
30. What IP protocol does ESP use?
31. What IP protocol does AH use?
32. Why can AH have problems with NAT?
33. What would you check if an IPsec tunnel does not establish?
34. What would you check if the tunnel is UP but traffic does not pass?

---

# 69. Interview-Ready Answer — What is IPsec?

> **IPsec, or Internet Protocol Security, is a Layer 3 security framework used to protect IP communication. It can provide encryption, authentication, integrity, and anti-replay protection. IPsec commonly uses ESP for protected data traffic and IKE for negotiating keys and Security Associations. It is widely used for site-to-site VPNs.**

---

# 70. Interview-Ready Answer — AH vs ESP

> **AH provides authentication, integrity, and anti-replay protection but does not provide encryption. ESP can provide encryption along with integrity, authentication, and anti-replay protection, so ESP is much more commonly used for modern IPsec VPNs.**

---

# 71. Interview-Ready Answer — Transport vs Tunnel Mode

> **Transport Mode protects mainly the payload of the original IP packet and keeps the original IP header as the outer header. It is commonly associated with host-to-host communication. Tunnel Mode protects and encapsulates the complete original IP packet and adds a new outer IP header, so it is commonly used for gateway-to-gateway site-to-site VPNs.**

---

# 72. Interview-Ready Answer — IKE

> **IKE stands for Internet Key Exchange. It is used to authenticate IPsec peers, negotiate encryption and integrity algorithms, establish cryptographic key material, and create Security Associations before protected IPsec traffic begins.**

---

# 73. Important Protocol / Port Table

| Component | Protocol / Port |
| --------- | --------------- |
| AH        | IP Protocol 51  |
| ESP       | IP Protocol 50  |
| IKE       | UDP 500         |
| NAT-T     | UDP 4500        |

### Important

AH and ESP are:

> **IP protocols, not TCP/UDP ports.**

---

# 74. Quick Revision Table

| Topic          | Simple Meaning                            |
| -------------- | ----------------------------------------- |
| IPsec          | Secures IP traffic at Layer 3             |
| Encryption     | Hides data                                |
| Authentication | Verifies identity/source                  |
| Integrity      | Detects modification                      |
| Anti-Replay    | Stops captured packets being reused       |
| AH             | Authentication + integrity, no encryption |
| ESP            | Encryption + integrity/authentication     |
| Transport Mode | Protects mainly payload                   |
| Tunnel Mode    | Protects complete original IP packet      |
| IKE            | Negotiates keys/security parameters       |
| SA             | Defines how IPsec traffic is protected    |
| NAT-T          | Helps IPsec pass through NAT              |
| IKE Port       | UDP 500                                   |
| NAT-T Port     | UDP 4500                                  |
| ESP Protocol   | 50                                        |
| AH Protocol    | 51                                        |

---

# 75. One-Line Revision

```text
IPsec
→ Layer 3 security framework.

Encryption
→ Provides confidentiality.

Authentication
→ Verifies the communicating peer.

Integrity
→ Detects data modification.

Anti-Replay
→ Rejects reused old packets.

AH
→ Authentication + Integrity + No Encryption.

ESP
→ Encryption + Authentication/Integrity.

Transport Mode
→ Protects mainly payload; original IP header remains.

Tunnel Mode
→ Protects whole original packet; new IP header added.

IKE
→ Negotiates peers, algorithms, keys and SAs.

SA
→ Defines security parameters for IPsec traffic.

NAT-T
→ Helps IPsec work through NAT using UDP 4500.
```

## Best Memory Diagram

```text
                         IPsec
                           |
          ---------------------------------
          |                               |
     Data Protection                 Key Management
          |                               |
     -------------                       IKE
     |           |                        |
    AH          ESP              Keys + Authentication
     |           |                        +
 Auth +       Encryption              Security
 Integrity    + Integrity            Associations
 No Encrypt   + Authentication
```

And:

```text
Transport Mode
Host A ================= Host B
        Payload Protected
```

```text
Tunnel Mode
LAN A → Gateway A ===== Gateway B → LAN B
          Whole Original Packet
             Protected
```

### Best interview memory line

> **IKE negotiates the tunnel, ESP protects the data, and Tunnel Mode is the common choice for site-to-site IPsec VPNs.**
