# Authentication, SSO, Zero Trust, TLS & Secure Email — Revision Notes

---

## PART 1: AUTHENTICATION FUNDAMENTALS

### 1.1 What is Authentication?

**Authentication** proves that a user, device, or service is really who it claims to be.

```
User claims: "I am Alice" → Authentication → Password/Passkey/Certificate/Security Key → Identity Verified
```

> **Simple Definition:** Authentication answers: "Who are you, and can you prove it?"

- Current standard: **NIST SP 800-63-4** (2025) — covers identity proofing, authentication, authenticators, and federation.

### 1.2 Authentication Factors

NIST recognizes **3 factor categories**. Using two instances of the **same** category is NOT true MFA (e.g., password + PIN = knowledge + knowledge).

| Factor                 | Meaning                             | Examples                                        |
| ---------------------- | ----------------------------------- | ----------------------------------------------- |
| **Something You Know** | Info you remember                   | Password, PIN, passphrase                       |
| **Something You Have** | An authenticator/device you possess | Security key, smart card, phone with crypto key |
| **Something You Are**  | Biometric characteristic            | Fingerprint, face, iris                         |

**Something You Know** — weaknesses: can be guessed, phished, reused, stolen in breaches, shared accidentally.

**Something You Have** — proves possession of a physical/cryptographic authenticator.

```
User + Security Key → Cryptographic Challenge → Authentication
```

**Something You Are** — biometrics.

```
Fingerprint → Biometric Verification → User Verification
```

> **Important:** Biometrics usually **unlock a local cryptographic authenticator** rather than being sent to a website. FIDO: biometric data stays on the user's device.

### 1.3 SFA vs MFA

**Single-Factor Authentication (SFA):** only one factor.

```
Username + Password → Login
```

Even "Password + PIN" is still **one factor type** (something you know) — NOT true MFA.

**Multi-Factor Authentication (MFA):** requires **2+ different** factor categories.

```
Password (Know) + Security Key (Have) → Authentication
Phone with crypto key (Have) + Fingerprint to unlock it (Are) → MFA
```

> **Simple Definition:** MFA requires two or more different categories of authentication factors.

### 1.4 Why MFA Improves Security

```
Password-only: Password Stolen → Attacker Logs In
MFA: Password Stolen → Second Factor Required → Attacker lacks Security Key → Login Fails
```

> **Important:** Not all MFA is equally strong. Password + SMS OTP is stronger than password alone, but both can still be phished. **FIDO is specifically phishing-resistant.**

### 1.5 Strong Authentication

A general term (not one protocol) meaning strong resistance against: credential theft, guessing, replay, phishing, impersonation.

Strong approaches combine: **MFA + Cryptographic Authentication + Phishing Resistance + Replay Resistance + Secure Credential Storage**. NIST's highest assurance level requires phishing-resistant authentication.

### 1.6 Graphical Passwords

Uses images/patterns/points/gestures instead of text.

```
Image Grid → Select: Dog → Tree → Car → Authentication
```

Still counts as **"Something You Know"** — so graphical password + normal password is NOT MFA.

> **Interview-Ready Answer (MFA):** MFA requires two or more different authentication factors — e.g., something you know and something you have. A password + FIDO security key is MFA. A password + PIN is not, since both are knowledge factors.

---

## PART 2: SSO, SAML, OAuth & OIDC

### 2.1 What is SSO?

**SSO = Single Sign-On.** Authenticate once, access multiple apps without separate logins.

```
User → Login Once → Identity Provider → Email | HR App | CRM (all accessible)
```

> **Simple Definition:** SSO allows one authentication session to provide access to multiple trusted applications.

**Without SSO:** login to App A, B, C, D separately.
**With SSO:**

```
Authenticate Once → Identity Provider → App A, App B, App C, App D
```

**Benefits:** fewer passwords, centralized authentication, easier account management, easier MFA enforcement, better UX.
**Risk:** If the SSO identity is compromised, multiple apps may be exposed → strong authentication at the IdP is critical.

### 2.2 Identity Provider (IdP) vs Service Provider (SP)

| IdP                                                  | SP                               |
| ---------------------------------------------------- | -------------------------------- |
| Authenticates the user                               | Provides the application/service |
| Verifies password/MFA/passkey/smart card/certificate | Relies on IdP for identity       |

```
Employee → HR Application (SP) → Redirect to IdP → Authentication
→ SAML Assertion → HR Application (access granted)
```

### 2.3 SAML

**SAML = Security Assertion Markup Language.** An **XML-based** federation technology used widely in enterprise SSO. Assertions can carry: authentication info, user attributes, authorization info. (OASIS SAML 2.0)

**SAML SSO Flow:**

```
User → Service Provider → Not Logged In → Redirect to Identity Provider
→ User Authenticates → IdP Creates Signed SAML Assertion
→ Browser Sends Assertion to SP → SP Verifies Assertion → Session Created
```

> **Easy Memory:** SAML → XML-based enterprise federation/SSO

### 2.4 Token-Based SSO

Modern federation uses signed assertions/tokens instead of sharing passwords (SAML Assertion or OIDC ID Token).

```
User → Identity Provider → Authentication → Signed Token → Application → Verify Token → Login
```

### 2.5 Authentication vs Authorization

| Authentication                         | Authorization                              |
| -------------------------------------- | ------------------------------------------ |
| **WHO are you?**                       | **WHAT are you allowed to do?**            |
| Username + Passkey → Identity verified | Role = Read Only → Can view, cannot delete |

> **Easy Memory:** Authentication → WHO? Authorization → WHAT?

### 2.6 OAuth

**OAuth 2.0** is primarily an **authorization framework** — lets an app get limited access to a protected resource WITHOUT the user giving that app their password (RFC 6749).

**Example:** A photo-printing app needs access to cloud photos.

```
User → Cloud Authorization Server → User Approves: "Allow access to photos"
→ Access Token → Photo Application → Cloud API
```

The app gets an **Access Token**, not the user's password.

**OAuth Roles:**

```
Resource Owner       → User
Client                → Application requesting access
Authorization Server  → Issues tokens
Resource Server       → API containing protected data
```

**Flow:**

```
User → Client Application → Authorization Server → Authorization
→ Access Token → Client → Resource Server / API
```

**Modern OAuth Security (RFC 9700, 2025):**

- Strongly favors **Authorization Code + PKCE**
- Public clients **must** use PKCE; authorization servers **must** support PKCE
- Advises against the older **implicit flow**

> **Easy Interview Point:** Modern OAuth → Authorization Code + PKCE

### 2.7 OpenID Connect (OIDC)

**OIDC = OpenID Connect.** Adds an **identity/authentication layer ON TOP of OAuth 2.0.**

```
OAuth  → Access Token → Access to API
OIDC   → ID Token → Information about the authenticated user
```

**OIDC Flow:**

```
User → Application/Relying Party → OpenID Provider → User Authenticates
→ ID Token (+ often Access Token) → Application
```

The **ID Token** is a signed **JWT** with identity claims: `sub`, `iss`, `aud`, `exp`, plus possibly profile info.

### 2.8 OAuth vs OIDC

| OAuth                      | OIDC                          |
| -------------------------- | ----------------------------- |
| Authorization              | Authentication/identity layer |
| Grants access to resources | Proves user identity          |
| Access Token               | ID Token + OAuth tokens       |
| Used for API access        | Used for login/federation     |
| "What can app access?"     | "Who authenticated?"          |

> **Important Interview Line:** OAuth is for authorization; OIDC uses OAuth to provide authentication and identity.

> **Interview-Ready Answer (OAuth vs OIDC):** OAuth 2.0 is an authorization framework used to delegate access to protected resources using access tokens. OpenID Connect adds an authentication/identity layer on top of OAuth 2.0, introducing an ID Token so an application can verify who the user is.

### 2.9 OpenID vs OIDC

- Classic **OpenID 2.0** = older authentication/federation protocol.
- **OpenID Connect** = modern successor — uses OAuth 2.0, JSON, JWTs, HTTPS/TLS.

### 2.10 Traditional Login vs Federated (OIDC) Login

| Traditional                                                 | Federated/OIDC                                                                         |
| ----------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| User → App → Username+Password → App authenticates directly | User → App → Identity Provider → Authentication → ID Token → App trusts verified token |

App doesn't need to manage the user's main IdP password.

### 2.11 SAML vs OIDC

| SAML                      | OIDC                               |
| ------------------------- | ---------------------------------- |
| XML based                 | JSON/JWT based                     |
| Enterprise federation     | Web/mobile/API-friendly federation |
| SAML Assertion            | ID Token                           |
| IdP + SP                  | OpenID Provider + Relying Party    |
| Older but widely deployed | Common in modern applications      |

---

## PART 3: AUTHENTICATION PROTOCOLS

### 3.1 Kerberos

A network authentication protocol using **tickets and symmetric cryptography**. Central service = **KDC (Key Distribution Center)** — supplies tickets and session keys (RFC 4120).

**Main Components:**

```
Client
KDC ├── Authentication Service
    └── Ticket-Granting Service
Application Server
```

Key concepts: KDC, **TGT (Ticket Granting Ticket)**, Service Ticket, session keys.

**Kerberos Flow:**

```
1. User Logs In
2. Client contacts KDC
3. KDC provides TGT
4. Client wants File Server
5. Client uses TGT to request Service Ticket
6. KDC issues Service Ticket
7. Client presents Service Ticket to File Server
8. Server verifies ticket → Access
```

**Why tickets?** The user's reusable password doesn't need to be sent to every service.

```
Without Kerberos: Password → sent to many services (risky)
With Kerberos: Authentication → Tickets → Services
```

> **Interview-Ready Answer (Kerberos):** Kerberos is a centralized network authentication protocol using a Key Distribution Center, tickets, and temporary session keys. A user first obtains a Ticket Granting Ticket, then uses it to request service tickets for individual services.

### 3.2 RADIUS

**RADIUS = Remote Authentication Dial-In User Service.** Used for **centralized network access authentication**.

Common uses: enterprise Wi-Fi, VPN access, Network Access Servers (NAS), 802.1X. Carries authentication, authorization, and configuration info between NAS and auth server. Standard port: **UDP 1812** (RFC 2865).

**RADIUS Flow:**

```
User → Wi-Fi AP/VPN Gateway/NAS → RADIUS Access-Request → RADIUS Server
→ Access-Accept or Access-Reject → NAS → Allow/Deny User
```

### 3.3 TACACS+

**TACACS+ = Terminal Access Controller Access-Control System Plus.** Mainly for **network-device administration** (router/switch/firewall admin login).

Separates functions into distinct protocol pieces: **Authentication, Authorization, Accounting (AAA)** — RFC 8907.

**TACACS+ Flow:**

```
Network Administrator → Router → TACACS+ Server
→ Authenticate User → Authorize Command → Record Accounting
```

Example: User may run `show running-config` but NOT `reload` — fine-grained command authorization.

### 3.4 RADIUS vs TACACS+

| RADIUS                              | TACACS+                                                 |
| ----------------------------------- | ------------------------------------------------------- |
| Common for network access           | Common for device administration                        |
| Classic RADIUS uses UDP             | Uses TCP                                                |
| Authentication/network access focus | Fine-grained device-command authorization               |
| Common with Wi-Fi/VPN/802.1X        | Common with routers/switches/firewalls                  |
| AAA functions more tightly coupled  | Authentication, authorization, accounting kept separate |

> **Current Security Correction:** Older material claims "TACACS+ encrypts the entire packet" — this is an oversimplification. RFC 8907's original protection is only **obfuscation**, not strong encryption. A 2025 update, **RFC 9887**, defines **TACACS+ over TLS 1.3**, and new deployments should use TLS-based auth/encryption.

### 3.5 FIDO, FIDO2, WebAuthn, CTAP

**FIDO = Fast Identity Online.** Uses public-key cryptography for strong authentication WITHOUT a reusable password sent to the server.

**FIDO2 = WebAuthn + CTAP**

**WebAuthn** — browser/web API for creating and using public-key credentials.

```
Website → Browser WebAuthn API → Authenticator → Private-Key Signature
→ Website verifies with public key
```

(Current spec: WebAuthn Level 3, W3C Candidate Recommendation, 2026)

**CTAP = Client to Authenticator Protocol** — lets a platform/browser talk to an external/roaming authenticator (USB key, NFC key, phone). Supports USB, NFC, BLE transports.

```
Browser → CTAP → Security Key
```

### 3.6 Passkeys

A **passkey** is a FIDO cryptographic credential that replaces passwords.

```
Device: holds Private Key
Website: holds Public Key
```

**Login flow:**

```
Website sends challenge → Device signs challenge → Website verifies signature → Login
```

Can be **synced** across devices or **bound** to one device/security key.

**Why passkeys resist phishing:**
A passkey is scoped to the exact relying party (website).

```
Passkey for: example.com
Attacker's fake site: examp1e.com → authenticator won't hand over the secret
```

FIDO names phishing resistance as a **core security property** of passkeys.

### 3.7 Passwordless Authentication

Removes the reusable password entirely. Examples: passkeys, FIDO security keys, certificate/smart-card systems.

```
User → Device → Fingerprint/PIN unlocks authenticator → Private-Key Signature → Server → Authentication
```

**Passwordless vs MFA — NOT the same thing:**

```
Passwordless → No reusable password
MFA          → Multiple authentication factors
```

A passkey can involve possession (the device) + local verification (biometric/PIN) — so it can be both passwordless AND multi-factor.

### 3.8 Phishing-Resistant Authentication

Authentication is phishing-resistant when an attacker **cannot** trick the user into typing a reusable secret into a fake site and reuse it. Good examples: FIDO2, WebAuthn/passkeys, certain certificate-based methods.

---

## PART 4: AUTHENTICATION PROTOCOLS SUMMARY TABLE

| Protocol              | Main Use                              | Key Feature                                      |
| --------------------- | ------------------------------------- | ------------------------------------------------ |
| Kerberos              | Enterprise network auth               | Tickets, KDC, symmetric crypto                   |
| RADIUS                | Network access (Wi-Fi/VPN/802.1X)     | UDP, AAA combined                                |
| TACACS+               | Network-device administration         | TCP, AAA separated, fine-grained command control |
| SAML                  | Enterprise SSO                        | XML assertions                                   |
| OAuth                 | Authorization (API access)            | Access Token                                     |
| OIDC                  | Authentication (identity)             | ID Token (JWT), built on OAuth                   |
| FIDO2 (WebAuthn+CTAP) | Passwordless/phishing-resistant login | Public-key cryptography                          |

---

## PART 5: ZERO TRUST ARCHITECTURE

### 5.1 What is Zero Trust?

A security architecture that gives **no implicit trust** to a user/device just because it's:

- Inside the corporate LAN
- Using a company device
- Connected via VPN
- In a particular office

(NIST SP 800-207)

> **Simple Definition:** Zero Trust means access must be explicitly verified and authorized, instead of assuming "inside the network = trusted."

### 5.2 "Never Trust, Always Verify"

```
Request Access → Do not trust automatically → Verify Identity → Verify Device
→ Evaluate Context → Authorize → Grant Minimum Required Access
```

### 5.3 Traditional Perimeter vs Zero Trust

**Traditional:**

```
Internet → Firewall → Internal LAN → Mostly Trusted
```

**Zero Trust:**

```
User/Device → Identity? Device Security? Resource? Risk? Context?
→ Policy Decision → Allow/Deny
```

### 5.4 Continuous Verification

| Traditional                            | Zero Trust                                                                            |
| -------------------------------------- | ------------------------------------------------------------------------------------- |
| Login Once → Trusted for a long period | Login → Evaluate → Access → Re-evaluate as context changes → Continue/Restrict/Revoke |

Signals: user identity, device state, location, risk, session behavior, resource sensitivity.

### 5.5 Least Privilege

Give only the **minimum access required**.

```
Bad:    Employee → Entire internal network
Better: Developer → Development systems only
        Finance User → Finance App → Required functions only
```

### 5.6 Per-Request / Per-Resource Authorization

Zero Trust ≠ "Authenticated once → can reach everything."

```
Request Resource A → Policy Check → Allow
Request Resource B → NEW Policy Check → Deny
```

### 5.7 Identity-, Device-, and Context-Based Access

**Identity-Based:**

```
Admin + Strong Authentication → Admin Portal
Normal User → Denied
```

**Device-Based:** considers managed/unmanaged status, OS patch level, EDR running, device certificate, compliance, compromise status.

```
Correct User + Compromised Laptop → Access Denied
```

**Context-Based:** time, location, device, risk, IP reputation, behavior, resource sensitivity.

```
Finance Admin + new unmanaged device + unusual country + 3 AM
→ Higher Risk → Require stronger auth OR Deny
```

> **Interview-Ready Answer (Zero Trust):** Zero Trust is a security architecture in which users and devices are not implicitly trusted because of their network location. Access decisions are based on verified identity, device state, context, resource sensitivity, and least privilege — and trust is continually re-evaluated.

---

## PART 6: SSL, TLS & HTTPS

### 6.1 SSL (Legacy)

**SSL = Secure Sockets Layer.** Predecessor to TLS.

- **SSL 2.0** → Obsolete
- **SSL 3.0** → **Prohibited** (RFC 7568)

> **Interview Correction:** People still say "SSL certificate," but modern HTTPS actually uses **TLS certificates and TLS protocols.**

### 6.2 TLS

**TLS = Transport Layer Security.** Creates a secure channel between endpoints, providing: **Authentication, Confidentiality, Integrity.**

- Current spec: **RFC 9846** (TLS 1.3, published July 2026), replacing the earlier RFC 8446.

### 6.3 TLS Version Status

| Version     | Status                      |
| ----------- | --------------------------- |
| SSL 2.0     | Obsolete                    |
| SSL 3.0     | Prohibited                  |
| TLS 1.0     | Deprecated (RFC 8996)       |
| TLS 1.1     | Deprecated (RFC 8996)       |
| **TLS 1.3** | **Current modern protocol** |

### 6.4 SSL vs TLS

| SSL                   | TLS                            |
| --------------------- | ------------------------------ |
| Older protocol family | Successor to SSL               |
| Obsolete              | Modern secure-channel protocol |
| SSLv3 prohibited      | TLS 1.3 current                |
| Do not deploy         | Use supported modern TLS       |

> **Easy Memory:** SSL → Old. TLS → Modern replacement.

### 6.5 What is HTTPS?

**HTTPS = HTTP over TLS.**

```
HTTP + TLS = HTTPS
```

Typical port: **TCP 443**. Protects against: eavesdropping, unauthorized modification, server impersonation (if cert verification is correct).

### 6.6 DNS Before HTTPS

```
https://www.example.com → DNS Resolution → 203.0.113.10
→ Network Connection → TLS Handshake → HTTPS
```

DNS resolution usually happens before the browser connects to the target IP.

### 6.7 TLS 1.3 Handshake (Simplified)

```
Client → ClientHello (supported algorithms + key share)
Server → ServerHello (selected parameters + key share)
→ Shared Key Material Established
→ Server Certificate, CertificateVerify, Finished
→ Client Verifies Certificate
→ Client Finished
→ Encrypted Application Traffic
```

Negotiates crypto parameters, authenticates the server (optionally the client), and establishes shared traffic-key material.

### 6.8 Server Authentication

```
Website → Server Certificate → Intermediate CA → Trusted Root CA
```

Client checks: CA signatures, trust chain, domain/hostname, validity, cert usage, other constraints.
If verification succeeds → **Server identity trusted** per PKI validation.

### 6.9 Session Key Establishment

Asymmetric crypto is expensive, so TLS establishes fast **symmetric traffic keys**.

```
TLS Handshake → ECDHE/Key Agreement → Shared Secret
→ Derive Traffic Keys → AES-GCM/ChaCha20-Poly1305 → Encrypted Data
```

TLS 1.3 uses **AEAD** for record protection; modern key exchange gives **forward secrecy**.

> **Why Symmetric After Handshake?** Asymmetric = authentication + key establishment (slow). Symmetric = fast bulk-data protection. HTTPS combines both rather than encrypting every packet with RSA/ECC directly.

### 6.10 Website PKI

```
Website → X.509 Certificate → Intermediate CA → Root CA → Browser Trust Store
```

Certificate binds: **Domain Name + Public Key + CA Signature.**

### 6.11 MITM Risk with Bad TLS Verification

| Correct TLS                                 | Bad Implementation                                                         |
| ------------------------------------------- | -------------------------------------------------------------------------- |
| Browser → Verify Certificate → Real Website | Browser → "Ignore Certificate Errors" → Attacker → Fake Server Certificate |

If certificate validation is disabled/bypassed, TLS loses its server-authentication protection → vulnerable to MITM.

### 6.12 Improper TLS Configuration — Common Problems

- SSL enabled
- TLS 1.0/1.1 enabled
- Weak algorithms
- Expired certificate
- Wrong hostname/SAN
- Incomplete certificate chain
- Private key exposed
- Certificate verification disabled
- Weak/randomly generated keys
- Insecure fallback/downgrade
- HTTP used where HTTPS is required

### 6.13 Apache HTTPS (mod_ssl)

```apache
LoadModule ssl_module modules/mod_ssl.so
Listen 443

<VirtualHost *:443>
    ServerName www.example.com
    SSLEngine on
    SSLCertificateFile "/path/to/www.example.com.cert"
    SSLCertificateKeyFile "/path/to/www.example.com.key"
</VirtualHost>
```

Core directives: `SSLEngine`, `SSLCertificateFile`, `SSLCertificateKeyFile`.

```
Client → TCP 443 → Apache mod_ssl → TLS Handshake → Certificate → Encrypted HTTP
```

### 6.14 HTTPS Troubleshooting Flow (Interview-Useful)

```
Website Not Opening
   ↓ DNS resolves?
   ↓ TCP connection succeeds?
   ↓ TLS handshake succeeds?
   ↓ Certificate valid?
   ↓ HTTP request succeeds?
```

> **Interview-Ready Answer (TLS):** TLS is the modern protocol used to create secure client-server channels. During the handshake, client and server negotiate cryptographic parameters, authenticate the server via its certificate, establish shared traffic keys, then use fast symmetric encryption for application data. HTTPS is HTTP running over TLS.

---

## PART 7: SECURE EMAIL

### 7.1 Why Secure Email is Needed

Normal email risks: eavesdropping, message modification, sender spoofing, data theft.

Secure-email tech provides:

```
Encryption          → Confidentiality
Digital Signature   → Integrity + Sender Authentication
```

### 7.2 PGP / OpenPGP

**PGP = Pretty Good Privacy.** Standardized interoperable format: **OpenPGP**.
Current spec: **RFC 9580** (2024) — supports public-key/symmetric encryption, digital signatures, compression, key management.

**OpenPGP Encryption (Alice → Bob):**

```
Alice: Email → Generate Symmetric Content Key → Encrypt Email
→ Protect Content Key for Bob using Bob's Public Key → Send
Bob: Bob's Private Key → Recover Content Key → Decrypt Email
```

This is a **hybrid model** — public-key + symmetric crypto together.

**OpenPGP Digital Signature:**

```
Alice: Email → Hash → Sign with Alice's Private Key → Signature
Bob: Email + Signature → Verify with Alice's Public Key
```

Provides: Integrity + Sender Authentication.

**PGP Web of Trust:**
Instead of one centralized CA, users verify and certify each other's public keys.

```
Alice trusts Bob's key. Bob verifies Carol's key. (Chain of personal trust)
```

> **Key Point:** PGP historically supports a **decentralized trust model**, unlike CA-centered S/MIME. (Note: not the only verification method — just the classic default.)

### 7.3 S/MIME

**S/MIME = Secure/Multipurpose Internet Mail Extensions.** Uses **X.509 certificates + PKI + public/private keys**.
Current: **S/MIME 4.0** (RFC 8551) — digital signatures for auth/integrity, encryption for confidentiality.

**S/MIME Trust Model:**

```
Certificate Authority → Issues User Certificate → Alice
```

Recipient verifies: Alice's Certificate → Intermediate CA → Trusted Root CA.
→ **CA-based hierarchical trust**

**S/MIME Encryption (to Bob):**

```
Bob Certificate → Bob Public Key → Encrypt/protect message key → Send Encrypted Email
Bob: uses his Private Key to access the message
```

**S/MIME Digital Signature:**

```
Alice: Email → Hash → Sign with Private Key → Signature
Bob: verifies via Alice's Certificate → Alice's Public Key → Verify Signature
```

### 7.4 PGP vs S/MIME

| OpenPGP                                 | S/MIME                            |
| --------------------------------------- | --------------------------------- |
| OpenPGP key model                       | X.509 certificates                |
| Historically Web of Trust/decentralized | CA-based PKI trust                |
| Encryption + signatures                 | Encryption + signatures           |
| Often personal/technical-user oriented  | Common in enterprise environments |
| Current: RFC 9580                       | Current: S/MIME 4.0, RFC 8551     |

### 7.5 Email Encryption vs Digital Signature

| Encryption                                                                 | Digital Signature                                      |
| -------------------------------------------------------------------------- | ------------------------------------------------------ |
| Recipient's Public Key → Protect Message → Recipient Private Key → Decrypt | Sender Private Key → Sign → Sender Public Key → Verify |
| Purpose: **Confidentiality**                                               | Purpose: **Integrity + Authentication**                |

### 7.6 Email Clients Supporting Secure Email

**Thunderbird** — built-in support for both **OpenPGP** and **S/MIME** (since Thunderbird 78).

```
Thunderbird → OpenPGP Keys or S/MIME Certificates → Encrypt/Sign Email
```

**Outlook** — supports S/MIME encryption and digital signatures when configured with certificates. Recipient must possess the matching private key to decrypt.

**Windows Mail** — Legacy/discontinued (support ended **Dec 31, 2024**). Microsoft now points users to **Outlook for Windows**.

### 7.7 Complete Secure-Email Flow

```
Alice → Compose Email → Sign with Alice's Private Key
→ Encrypt for Bob using Bob's Public Key → Internet → Bob
→ Decrypt with Bob's Private Key → Verify Alice's Signature using Alice's Public Key
```

Result: **Encryption → Confidentiality. Signature → Integrity + Authentication.**

---

## PART 8: MASTER COMPARISON TABLE

| Topic                           | Main Difference                                           |
| ------------------------------- | --------------------------------------------------------- |
| Authentication vs Authorization | Who you are vs what you can do                            |
| SFA vs MFA                      | One factor vs multiple distinct factors                   |
| SAML vs OIDC                    | XML federation vs JSON/OAuth-based identity               |
| OAuth vs OIDC                   | Authorization vs authentication/identity                  |
| RADIUS vs TACACS+               | Network access vs device administration                   |
| WebAuthn vs CTAP                | Website/browser API vs client-authenticator communication |
| Password vs Passkey             | Shared secret vs public-key credential                    |
| SSL vs TLS                      | Obsolete predecessor vs modern protocol                   |
| HTTP vs HTTPS                   | Plain HTTP vs HTTP over TLS                               |
| PGP vs S/MIME                   | Decentralized/OpenPGP trust vs X.509 CA trust             |
| Email encryption vs signing     | Confidentiality vs integrity/authentication               |

---

## PART 9: BEST MEMORY DIAGRAMS

### Overall Authentication Flow

```
User → Authentication → Password/Passkey/Certificate/MFA
→ Identity Provider → Identity Established
→ Authorization Policy → Least Privilege → Application/Resource
```

### SSO Flow

```
                   USER
                     ↓
                    IdP
                     ↓
               Authentication
                     ↓
             Assertion / Token
                     ↓
        ---------------------------
        ↓             ↓           ↓
      App A         App B       App C
```

### Protocol Quick Memory

```
Kerberos  → Tickets
RADIUS    → Network access AAA
TACACS+   → Network-device administration
SAML      → XML SSO
OAuth     → Authorization
OIDC      → Authentication on OAuth
FIDO2     → WebAuthn + CTAP
Passkey   → Phishing-resistant public-key login
```

### TLS Memory Flow

```
Domain Name → DNS → Server IP → TCP Connection
→ TLS Handshake → Certificate Verification
→ Session Keys → Symmetric Encryption → HTTPS
```

---

## PART 10: FINAL INTERVIEW-READY SUMMARY

> **30-Second Summary:** Authentication verifies who a user is, while authorization decides what that user can access. Modern authentication uses MFA and increasingly phishing-resistant methods like FIDO2 and passkeys. SSO centralizes authentication through an identity provider — SAML for enterprise federation, OpenID Connect for modern OAuth-based authentication. Kerberos uses tickets, RADIUS is common for network access, TACACS+ is common for network-device administration. Zero Trust removes implicit network trust and applies identity, device, context, and least-privilege checks. TLS secures network communication and HTTPS is HTTP over TLS. OpenPGP and S/MIME provide encryption and digital signatures for secure email.

### Most Important Lines to Remember

```
Authentication = WHO are you?
Authorization  = WHAT can you do?

OAuth = Authorization
OIDC  = Authentication + Identity on OAuth

FIDO2 = WebAuthn + CTAP

Zero Trust = No implicit trust

HTTPS = HTTP + TLS

PGP/OpenPGP = Decentralized-style key trust
S/MIME      = CA / X.509 trust
```
