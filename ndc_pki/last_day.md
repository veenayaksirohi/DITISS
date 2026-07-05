# Network Security & Authentication — Study Notes
### CDAC DITISS | Topics: ip6tables, VPN Tunneling, PKI Standards, FIPS 140-2, Authentication Protocols, Zero Trust

---

## 1. ip6tables

### Definition
`ip6tables` is the **IPv6 equivalent of iptables**. It configures the Linux kernel firewall (`netfilter`) specifically for IPv6 traffic.

| Tool | Protocol Filtered |
|---|---|
| `iptables` | IPv4 packets |
| `ip6tables` | IPv6 packets |

### Syntax Comparison

```bash
# IPv4 - block SSH
sudo iptables  -A INPUT -p tcp --dport 22 -j DROP

# IPv6 - block SSH
sudo ip6tables -A INPUT -p tcp --dport 22 -j DROP
```

> **Note:** Every chain, table, target, and match extension (`-A`, `-p`, `--dport`, `-j DROP`, etc.) works **identically** to iptables — only the protocol stack (IPv6) differs.

### ⚠️ Exam Trap
`iptables` rules do **NOT** automatically apply to IPv6 traffic. If a server has IPv6 enabled but only `iptables` rules configured, IPv6 traffic bypasses the firewall entirely — both `iptables` and `ip6tables` must be configured separately for full protection.

---

## 2. UTM (Unified Threat Management)

### Definition
UTM is an **all-in-one network security appliance/software** that consolidates multiple security functions into a single device, rather than deploying separate standalone devices.

### Why UTM is Needed
Without UTM, an organization needs **separate devices** for each function:

```
Firewall  |  Antivirus  |  IDS  |  IPS  |  VPN  |  Web Filtering  |  Email Security
```

With UTM → all combined into **one appliance**.

| Without UTM | With UTM |
|---|---|
| Multiple boxes, multiple vendors | Single box, single vendor |
| Complex management | Centralized management |
| Higher cost & maintenance | Lower cost, easier maintenance |
| Harder correlation of threats | Unified visibility |

### 💡 Why? (Interview Angle)
UTM trades **granular best-of-breed performance** for **simplicity and centralized management** — good for SMBs, but large enterprises often prefer dedicated best-in-class devices (NGFW + separate IPS) for performance and flexibility.

---

## 3. VPN Tunneling: Split Tunnel vs Full Tunnel

### 3.1 Split Tunnel

**Definition:** Only traffic destined for the company/internal network is routed through the VPN. All other (general internet) traffic goes **directly** to the internet.

```
                  Company Network
                         ^
                         |
                    VPN Tunnel
                         ^
                         |
                     Your Laptop
                    /            \
                   /              \
      Direct Internet          VPN Traffic
   (Google, YouTube)         (Office Server)
```

- Internal/company resources → VPN
- Normal browsing (Google, YouTube, etc.) → Direct Internet

### 3.2 Full Tunnel

**Definition:** **ALL** traffic (internal + general internet) is routed through the VPN server first, then out to its destination. Nothing bypasses the VPN.

```
               Internet
                   ^
                   |
             VPN Server
                   ^
                   |
          Encrypted VPN Tunnel
                   ^
                   |
              Your Laptop
```

### Comparison Table

| Feature | Split Tunnel | Full Tunnel |
|---|---|---|
| Internet traffic path | Direct (bypasses VPN) | Through VPN server |
| Bandwidth on VPN server | Lower (less load) | Higher (all traffic) |
| Security | Weaker (internet traffic unprotected/unmonitored) | Stronger (everything monitored/encrypted) |
| Speed for general browsing | Faster | Slower (extra hop) |
| Common use case | Remote employees needing fast local internet | High-security orgs, government, banks |

### ⚠️ Exam Trap
Split tunnel is a **security trade-off**: it improves performance but creates a risk because the same device can be simultaneously connected to the trusted VPN network AND the untrusted internet, potentially acting as a bridge for attackers (this is a common interview question on VPN risks).

---

## 4. Core Security Concepts

### 4.1 Vulnerability

**Definition:** A **weakness or flaw** in a system, network, software, or process that can be exploited by an attacker.

```
Vulnerability = Weakness
```

Related terms (viva favorite — don't confuse these):

| Term | Meaning |
|---|---|
| **Vulnerability** | A weakness that *could* be exploited |
| **Threat** | A potential danger that could exploit a vulnerability |
| **Risk** | Probability × Impact of a threat exploiting a vulnerability |
| **Exploit** | The actual tool/technique used to take advantage of a vulnerability |

### 4.2 CIA Triad

The foundation of Information Security.

```
                CIA Triad

            Confidentiality
                 /\
                /  \
               /    \
    Integrity -------- Availability
```

| Letter | Meaning | Ensures... |
|---|---|---|
| **C** | Confidentiality | Only authorized users can access data |
| **I** | Integrity | Data is accurate and unaltered |
| **A** | Availability | Data/services are accessible when needed |

### ⚠️ Exam Trap
Attacks map directly to CIA violations — a common exam/viva question:
- **DoS/DDoS attack** → violates **Availability**
- **Data tampering (MITM)** → violates **Integrity**
- **Data breach/eavesdropping** → violates **Confidentiality**

### 4.3 Honeypot

**Definition:** A **decoy system** designed to look like a real server, deployed intentionally to attract and trap attackers.

**Purpose:**
- Detect attackers
- Study attacker behavior (TTPs)
- Collect threat intelligence
- Divert attackers away from real production systems

### 💡 Why? (Interview Angle)
Instead of only *defending* real servers, honeypots flip the model — deploy fake, valuable-looking targets. Any interaction with a honeypot is by definition suspicious (no legitimate user has a reason to touch it), making detection very high-confidence with low false positives.

---

## 5. Diffie–Hellman (DH) Key Exchange Algorithm

### Definition
DH is a **key exchange algorithm** — it allows two parties to derive the **same shared secret key** over an insecure channel **without ever transmitting the key itself**.

> ⚠️ **Diffie–Hellman does NOT encrypt data.** It only generates a shared secret. That secret is then used by a symmetric algorithm like **AES** for actual encryption.

### Worked Example

| Step | Action | Value |
|---|---|---|
| 1 | Public numbers agreed | P = 23, G = 5 |
| 2 | Private keys chosen | Alice: a = 4, Bob: b = 3 |
| 3 | Public values computed | Alice: x = 5⁴ mod 23 = 4 <br> Bob: y = 5³ mod 23 = 10 |
| 4 | Exchange public values | Alice sends x=4, Bob sends y=10 |
| 5 | Compute shared secret | Alice: kₐ = y^a mod p = 10⁴ mod 23 = 18 <br> Bob: k_b = x^b mod p = 4³ mod 23 = 18 |
| 6 | Result | **Shared Secret = 18** |

### Why It Works
Both sides land on the same value because of modular exponentiation's commutative property:
```
(g^a mod p)^b mod p  =  (g^b mod p)^a mod p  =  g^(ab) mod p
```

### ⚠️ Exam Trap
DH is vulnerable to **Man-in-the-Middle (MITM)** attacks because it provides **no authentication** of the two parties by itself — this is why real protocols combine DH with digital signatures/certificates (e.g., **DHE/ECDHE in TLS**).

---

## 6. OCSP (Online Certificate Status Protocol)

### Definition
OCSP is a protocol used to check in **real-time** whether a digital certificate is still **valid** or has been **revoked**, by querying the issuing CA directly (rather than downloading a full CRL — Certificate Revocation List).

### Flow

```
        1. HTTPS Request
User ----------------------------> Website

        2. Certificate
Website -------------------------> Browser

        3. OCSP Query
Browser -------------------------> OCSP Server

        4. Status Response
OCSP Server ---------------------> Browser
        (Good / Revoked / Unknown)

        5. Decision
Good    ---> Secure Connection Established
Revoked ---> Connection Blocked
```

### Step-by-Step
1. **User visits website** → website sends its SSL/TLS certificate.
2. **Browser extracts** the certificate serial number + issuing CA info.
3. **Browser queries the CA's OCSP responder**: *"Is certificate #12345 still valid?"*
4. **OCSP server checks its database**, returns one of:
   - `Good`
   - `Revoked`
   - `Unknown`
5. **Browser decides**: Good → proceed with HTTPS; Revoked → block connection.

### OCSP vs CRL (common viva comparison)

| Feature | OCSP | CRL (Certificate Revocation List) |
|---|---|---|
| Method | Real-time query (single certificate) | Downloads entire revocation list |
| Speed | Faster | Slower (large file) |
| Bandwidth | Low | High |
| Privacy | CA can see which sites you visit | No per-query tracking |

---

## 7. PKCS Standards (Public-Key Cryptography Standards)

### Definition
A set of cryptographic standards, originally by **RSA Laboratories**, that define **standard formats** for keys, certificates, signatures, and encrypted data — so different vendors' software can interoperate.

### 💡 Why? (Interview Angle)
Without PKCS, Software A's certificate format might be unreadable by Software B. PKCS is the "universal file format" layer of PKI.

### PKCS #1 — RSA Cryptography Standard
Defines the RSA algorithm itself:
- RSA public/private key format
- RSA encryption
- RSA digital signatures
- Padding schemes

```
Message → RSA Encryption (PKCS #1) → Encrypted Message
```
**Used in:** HTTPS, SSH, digital signatures.

### PKCS #3 — Diffie–Hellman Key Agreement
Defines the format/parameters for DH key exchange (P, G, public parameters).
**Used for:** secure key exchange without transmitting the key.

### PKCS #10 — Certificate Signing Request (CSR)
Defines the **format of a CSR**, sent to a CA to request a certificate.

**CSR contains:**
- Public key
- Organization name, domain, country, state, locality
- Digital signature (proves ownership of the private key)

**Process:**
```
Step 1: Generate key pair (Private Key + Public Key)
Step 2: Create CSR = Public Key + Org Details + Digital Signature
Step 3: Send CSR to CA
Step 4: CA verifies and issues the certificate
```
**File extensions:** `.csr`, `.pem`

### PKCS #12 — Personal Information Exchange
Defines a **single, password-protected file** that bundles:
- Private key
- Public key
- Digital certificate
- Intermediate CA certificate(s)
- Root CA certificate

Instead of managing separate files (`server.key`, `server.crt`, `ca.crt`), everything is bundled into one `.p12`/`.pfx` file.

**File extensions:** `.p12`, `.pfx`

**Uses:** importing certs into browsers, installing SSL/TLS certs, exporting certs, VPN authentication, email encryption.

### Comparison Table

| Standard | Purpose | Used For |
|---|---|---|
| **PKCS #1** | RSA cryptography | RSA encryption & digital signatures |
| **PKCS #3** | Diffie–Hellman | Secure key exchange |
| **PKCS #10** | Certificate Signing Request | Requesting a cert from a CA |
| **PKCS #12** | Secure key/cert storage | Exporting/importing certs + private keys |

### 🎯 Memory Trick
```
#1  → RSA
#3  → Diffie–Hellman
#10 → Certificate Request (CSR)
#12 → P12/PFX Certificate File (bundle)
```

---

## 8. FIPS 140-2 (Federal Information Processing Standard)

### Definition
A **U.S. government security standard** specifying security requirements for **cryptographic modules** (hardware/software/firmware performing encryption, decryption, signing, key generation, key storage).

### 💡 Why It's Needed
Government, banking, defense, and healthcare organizations need **assurance and validation** that cryptographic products actually meet a rigorous security bar — FIPS 140-2 provides formal testing/certification.

### Examples of Cryptographic Modules
HSM, smart card, USB encryption device, VPN appliance, crypto software library.

### FIPS 140-2 Security Levels

| Level | Protection | Requirements | Example |
|---|---|---|---|
| **1** | Basic | Approved algorithms only, no physical tamper protection | Software encryption on a PC |
| **2** | Tamper-Evident | Tamper-evident seals/coatings, role-based auth | Network appliance with security seals |
| **3** | Tamper-Resistant | Identity-based auth; tamper attempts erase keys | Hardware Security Module (HSM) |
| **4** | Highest | Detects environmental attacks (temp/voltage); auto-destroys keys on tamper | Military/govt systems |

### ⚠️ Exam Trap
Note the document title says "FIPS 140-2 (DES)" — be careful, **FIPS 140-2 is NOT the DES standard itself**; it's the *validation framework* for cryptographic modules in general (which historically included DES/3DES-era algorithms as approved algorithms, now superseded by AES). Don't conflate the two in an exam answer.

---

## 9. Authentication & Authorization Protocols

### 9.1 MFA (Multi-Factor Authentication)

**Definition:** Requires **two or more** independent authentication factors to verify identity.

| Factor Type | Examples |
|---|---|
| **Something you know** | Password, PIN, security question |
| **Something you have** | Mobile phone, OTP, smart card, hardware key |
| **Something you are** | Fingerprint, face recognition, iris scan, voice |

**Example flow (bank login):**
```
User → Username + Password → OTP sent to mobile → Login Success
```

### 9.2 SSO (Single Sign-On)

**Definition:** Log in **once** → gain access to **multiple applications** without re-authenticating.

**Without SSO:**
```
Email → Login
HR Portal → Login
Payroll → Login
CRM → Login
(4 separate logins)
```

**With SSO:**
```
          Login Once
               |
        Identity Provider
               |
   ------------------------------------
   |         |          |             |
 Email      HR       Payroll         CRM
```

### 9.3 OAuth (Delegated Authorization)

**Definition:** An **authorization** framework — lets one application access another application's resources **on a user's behalf**, without ever sharing the user's password.

> ⚠️ **OAuth = Authorization, NOT Authentication.** (Classic viva trap — see OIDC below for the authentication piece.)

**Real-life example:** Canva wants to import your Google Drive files.
```
Canva → redirects to Google → Google asks "Allow Canva to view Drive files?"
→ User clicks Allow → Google issues an Access Token to Canva
→ Canva never sees your Google password
```

**Flow:**
```
User → Login with Google → Google Login Page → User enters password
→ Google → issues Access Token → Application
```

### 9.4 OpenID Connect (OIDC)

**Definition:** An **authentication** protocol built **on top of OAuth 2.0**. While OAuth grants access to resources, OIDC verifies **who the user is**.

**Example:** "Sign in with Google" → Google tells the app:
```
This is Rahul
Email: rahul@gmail.com
Verified: Yes
```

**Flow:**
```
User → Login with Google → Google Login → Identity Verified → ID Token → Application
```

The **ID Token** contains: User ID, Email, Name, Login time.

### ⚠️ Exam Trap — OAuth vs OIDC (very commonly asked)

| | OAuth 2.0 | OpenID Connect (OIDC) |
|---|---|---|
| Purpose | Authorization (access to resources) | Authentication (verify identity) |
| Question answered | "Can this app access X?" | "Who is this user?" |
| Token issued | Access Token | ID Token (+ Access Token) |
| Built on | — | Built on top of OAuth 2.0 |

---

## 10. FIDO Protocol (Fast Identity Online)

### Definition
A set of authentication standards (by the **FIDO Alliance**) enabling **passwordless** or **strong MFA** login using **public-key cryptography**, replacing weak/reused/phishable passwords.

### Why FIDO is Needed
Traditional password problems: weak passwords, reuse, phishing, theft, brute-force. FIDO solves this by never transmitting a secret over the network — only cryptographic proofs.

### How It Works

**Registration:**
```
Your Device
   |
Generate Key Pair
   |
Private Key (Secret — never leaves device)
Public Key ---------------------------> Website (stored there)
```

**Login:**
```
Website
   |
Random Challenge
   |
Your Device
   |
User Verification (Fingerprint / Face / PIN / Security Key Touch)
   |
Sign Challenge with Private Key
   |
Digital Signature ---------------------> Website
   |
Website verifies with stored Public Key
   |
Login Success
```

### FIDO Standards

| Standard | Description |
|---|---|
| **U2F** (Universal 2nd Factor) | Older — used as a **second** factor alongside a password |
| **FIDO2** | Modern — supports full **passwordless** login, biometrics, PIN, security keys |

**FIDO2 = WebAuthn + CTAP**

| Component | Role |
|---|---|
| **WebAuthn** | Web Authentication API — lets websites/browsers talk to FIDO authenticators |
| **CTAP** | Client to Authenticator Protocol — lets the OS/browser talk to the physical authenticator device (e.g., USB key) |

### Types of FIDO Authenticators

| Type | Description | Examples |
|---|---|---|
| **Platform Authenticator** | Built into the device, no external hardware | Windows Hello, Apple Face ID/Touch ID, Android Fingerprint |
| **Roaming Authenticator** | External device, portable across machines | USB security key, NFC key, Bluetooth key |

### Google Titan Security Key
A **FIDO-certified hardware key** by Google implementing this exact model:

**Registration:**
```
Google Account → Insert Titan Key → Generate Key Pair
→ Public Key stored in Google account, Private Key stays inside Titan
```

**Login:**
```
Username → Insert Titan Key → Touch Button
→ Titan signs Google's challenge → Google verifies signature → Login Success
```

**Why secure:** The private key **never leaves the physical device** — even a stolen password is useless without the physical key in hand (phishing-resistant).

---

## 11. Zero Trust Architecture (ZTA)

### Core Principle
> **"Never Trust, Always Verify."**

No user, device, or application is automatically trusted — **even if already inside the corporate network**. Every access request must be authenticated, authorized, and verified.

### Traditional Model vs Zero Trust

**Traditional ("Castle-and-Moat"):**
```
Internet → Firewall → Company Network → Trusted Users
```
Once inside the perimeter, a user (or attacker) is trusted and can move freely (lateral movement risk).

**Zero Trust:**
```
User → Authenticate → Authorize → Verify Device → Check Policies → Grant Limited Access
```
Every request is checked — even from an employee already inside the network.

### End-to-End Flow Example (Employee Accessing a Database)

```
               User
                 |
          Login Request
                 |
        Identity Verification (Username/Password)
                 |
         MFA Verification (OTP)
                 |
        Device Health Check (AV, OS updated, disk encrypted?)
                 |
        Policy Verification (role, time, location rules)
                 |
      Least Privilege Access Granted
                 |
          Requested Resource
```

**Example policy check:** *Only HR employees* AND *office hours* AND *company laptop* → access continues only if ALL conditions met.

### 5 Core Components

| Component | Description |
|---|---|
| **1. Identity Verification** | Password, MFA, biometrics |
| **2. Device Verification** | Antivirus status, OS patch level, disk encryption, device trust |
| **3. Least Privilege Access** | User gets ONLY the permissions needed (e.g., Accountant → Accounting software only, NOT HR files) |
| **4. Micro-Segmentation** | Network divided into small isolated zones (HR / Finance / IT / Sales) so a breach in one zone can't spread |
| **5. Continuous Monitoring** | Ongoing checks on user activity, device status, login location/time, behavior — access can be revoked mid-session if suspicious |

### ⚠️ Exam Trap
Zero Trust is **not a single product** — it's an **architectural philosophy/model** implemented using a combination of MFA, micro-segmentation, IAM, endpoint security, and continuous monitoring tools. Don't answer "what is Zero Trust" by naming a single vendor tool.

---

## 12. Quick Reference Card

| Concept | One-Line Summary |
|---|---|
| ip6tables | iptables for IPv6 |
| UTM | All security functions bundled into one appliance |
| Split Tunnel | Only internal traffic via VPN, rest direct |
| Full Tunnel | ALL traffic via VPN |
| Vulnerability | A weakness that can be exploited |
| CIA Triad | Confidentiality, Integrity, Availability |
| Honeypot | Decoy system to trap/study attackers |
| Diffie–Hellman | Generates a shared secret key (no encryption itself) |
| OCSP | Real-time certificate revocation check |
| PKCS #1/#3/#10/#12 | RSA / DH params / CSR / Bundled cert+key file |
| FIPS 140-2 | Govt validation standard for crypto modules (4 levels) |
| MFA | 2+ factors: know / have / are |
| SSO | Login once, access many apps |
| OAuth | Delegated **authorization** (access token) |
| OIDC | **Authentication** on top of OAuth (ID token) |
| FIDO/FIDO2 | Passwordless auth via public-key crypto (WebAuthn + CTAP) |
| Zero Trust | Never trust, always verify — even inside the network |

---

## 13. Viva / Interview Q&A

**Q1: Does Diffie–Hellman encrypt your data?**
No — it only establishes a shared secret key. Actual data encryption is done separately (e.g., by AES) using that key.

**Q2: What's the key difference between OAuth and OpenID Connect?**
OAuth handles **authorization** (what an app can access); OIDC, built on top of OAuth, handles **authentication** (who the user is) and returns an ID Token.

**Q3: Why is split tunneling considered a security risk?**
Because the same device is simultaneously connected to the trusted internal network (via VPN) and the untrusted public internet, it can act as a bridge for attackers to reach internal resources.

**Q4: What's the real difference between OCSP and CRL?**
OCSP does a real-time, single-certificate lookup against the CA (fast, low bandwidth); CRL requires downloading the CA's entire revocation list (slower, more bandwidth, but no per-query CA visibility into your browsing).

**Q5: How does FIDO prevent phishing?**
The private key never leaves the user's device and is never transmitted. Even if a user is tricked into visiting a fake site, the authenticator won't sign the challenge for the wrong domain — there's no password to steal.

**Q6: What does "least privilege" mean in Zero Trust?**
A user/device is granted only the minimum access necessary to perform their role — nothing more — limiting the blast radius if credentials are compromised.

**Q7: Which PKCS format bundles a private key AND certificate together in one password-protected file?**
PKCS #12 (`.p12` / `.pfx`).

**Q8: At what FIPS 140-2 level does a device automatically destroy keys under physical tampering?**
Level 3 (tamper attempts erase keys) and more comprehensively Level 4 (also detects environmental attacks like temperature/voltage tampering, with automatic key destruction).

---

*Note: The source notes ended with a "blockchain" heading with no content — flag this topic if you need it covered; happy to add a full blockchain section on request.*