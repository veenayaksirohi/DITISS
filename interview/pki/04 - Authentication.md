# 22. Authentication Fundamentals — Detailed Notes

## 1. What is Authentication?

**Authentication** is the process of proving that a user, device, or service is really who it claims to be.

Example:

```text
User claims:
"I am Alice"
      ↓
Authentication
      ↓
Password / Passkey / Certificate / Security Key
      ↓
Identity Verified
```

### Simple Definition

> **Authentication answers: “Who are you, and can you prove it?”**

The current NIST Digital Identity Guidelines are **SP 800-63-4**, published in 2025. They replaced SP 800-63-3 and cover identity proofing, authentication, authenticators, and federation. ([NIST][1])

---

## 2. Authentication Factors

NIST recognizes three traditional authentication-factor categories: **something you know, something you have, and something you are**. Using multiple instances of the same category does **not** create true MFA. For example, password + PIN is still knowledge + knowledge. ([NIST Pages][2])

| Factor                 | Meaning                             | Examples                                                       |
| ---------------------- | ----------------------------------- | -------------------------------------------------------------- |
| **Something You Know** | Information you remember            | Password, PIN                                                  |
| **Something You Have** | An authenticator/device you possess | Security key, smart card, phone containing a cryptographic key |
| **Something You Are**  | Biometric characteristic            | Fingerprint, face, iris                                        |

---

## 3. Something You Know

Examples:

```text
Password
PIN
Passphrase
Graphical pattern
```

The user must remember the secret.

Example:

```text
Username
   +
Password
   ↓
Authentication
```

### Weaknesses

Knowledge factors can be:

- Guessed
- Phished
- Reused
- Stolen in database breaches
- Shared accidentally

---

## 4. Something You Have

The user proves possession of a physical or cryptographic authenticator.

Examples:

- FIDO security key
- Smart card
- Phone containing a cryptographic credential
- Hardware token

```text
User
  +
Security Key
  ↓
Cryptographic Challenge
  ↓
Authentication
```

---

## 5. Something You Are

Uses biometric characteristics.

Examples:

- Fingerprint
- Face
- Iris

```text
Fingerprint
     ↓
Biometric Verification
     ↓
User Verification
```

### Important

Biometrics are often used to **unlock a cryptographic authenticator locally**, rather than being sent directly to a website.

FIDO specifically notes that biometric information used with FIDO authentication remains on the user's device. ([FIDO Alliance][3])

---

# 6. Single-Factor Authentication — SFA

**Single-Factor Authentication** uses only one authentication factor.

Example:

```text
Username
   +
Password
   ↓
Login
```

The username identifies the user.

The password is the only authentication factor.

### Another Example

```text
Password + PIN
```

This may look like two steps, but both are:

> Something you know.

Therefore it is still not true multi-factor authentication under the NIST factor model. ([NIST Pages][2])

---

# 7. Multi-Factor Authentication — MFA

**MFA** requires more than one **different authentication factor**.

Example:

```text
Password
Something You Know
       +
Security Key
Something You Have
       ↓
Authentication
```

Another:

```text
Phone containing cryptographic key
            +
Fingerprint to activate it
            ↓
MFA
```

### Simple Definition

> **MFA requires two or more different categories of authentication factors.**

---

# 8. Why MFA Improves Security

Suppose an attacker steals the user's password.

With password-only authentication:

```text
Password Stolen
      ↓
Attacker Logs In
```

With MFA:

```text
Password Stolen
      ↓
Second Factor Required
      ↓
Attacker Does Not Have Security Key
      ↓
Login Fails
```

MFA therefore reduces the damage caused by a compromised single credential.

### Important

Not all MFA methods are equally strong.

For example:

```text
Password + SMS OTP
```

is generally stronger than password alone, but both passwords and OTP-style mechanisms may still be phished.

FIDO authentication is specifically designed to provide **phishing-resistant** authentication. ([FIDO Alliance][3])

---

# 9. Strong Authentication

"Strong authentication" is a general security term rather than one specific protocol.

It usually means authentication that has strong resistance against:

- Credential theft
- Guessing
- Replay
- Phishing
- Impersonation

Strong approaches may combine:

```text
MFA
+
Cryptographic Authentication
+
Phishing Resistance
+
Replay Resistance
+
Secure Credential Storage
```

NIST's highest authentication assurance requirements include phishing-resistant authentication. ([NIST Pages][4])

---

# 10. Graphical Passwords

A **graphical password** uses images, patterns, points, or gestures instead of normal text.

Example:

```text
Image Grid
   ↓
Select:
Dog → Tree → Car
   ↓
Authentication
```

or:

```text
Draw Pattern:
● → ●
    ↓
    ●
```

Usually this is still:

> **Something You Know**

So graphical password + normal password is not automatically MFA.

---

# 11. Interview-Ready Answer — MFA

> **Multi-Factor Authentication requires two or more different authentication factors, such as something you know and something you have. For example, a password plus a FIDO security key is MFA. Using a password and PIN together is not true MFA because both are knowledge factors.**

---

# 23. SSO, OpenID, OAuth & OIDC

## 12. What is SSO?

**SSO** stands for:

> **Single Sign-On**

SSO allows a user to authenticate once and then access multiple applications without entering credentials separately for every application.

Example:

```text
User
  ↓
Login Once
  ↓
Identity Provider
  ↓
-------------------------
↓           ↓           ↓
Email      HR App      CRM
```

### Simple Definition

> **SSO allows one authentication session to provide access to multiple trusted applications.**

---

# 13. Why SSO is Used

Without SSO:

```text
App A → Login
App B → Login
App C → Login
App D → Login
```

With SSO:

```text
Authenticate Once
      ↓
Identity Provider
      ↓
App A
App B
App C
App D
```

Benefits:

- Fewer passwords
- Centralized authentication
- Easier account management
- Easier MFA enforcement
- Better user experience

Risk:

> If an SSO identity is compromised, multiple applications may be exposed.

Therefore strong authentication at the identity provider is important.

---

# 14. Identity Provider — IdP

An **Identity Provider** authenticates the user and provides identity information to applications.

Examples conceptually:

```text
User
 ↓
IdP
 ↓
Authenticate
 ↓
Identity Assertion / Token
```

The IdP might verify:

- Password
- MFA
- Passkey
- Smart card
- Certificate

---

# 15. Service Provider — SP

A **Service Provider** is the application the user wants to access.

In SAML terminology:

```text
IdP
→ Authenticates user

SP
→ Provides application/service
```

Example:

```text
Employee
   ↓
HR Application (SP)
   ↓
Redirect to IdP
   ↓
Authentication
   ↓
SAML Assertion
   ↓
HR Application
```

---

# 16. SAML

**SAML** stands for:

> **Security Assertion Markup Language**

SAML is an XML-based federation technology widely associated with enterprise SSO.

SAML assertions can contain information about:

- Authentication
- User attributes
- Authorization-related information

The OASIS SAML 2.0 specifications define XML assertions, protocols, bindings, profiles, metadata, and authentication context. ([OASIS Open][5])

---

# 17. SAML SSO Flow

```text
User
 ↓
Service Provider
 ↓
Not Logged In
 ↓
Redirect to Identity Provider
 ↓
User Authenticates
 ↓
IdP Creates Signed SAML Assertion
 ↓
Browser Sends Assertion to SP
 ↓
SP Verifies Assertion
 ↓
Session Created
```

### Easy Memory

```text
SAML
→ XML-based enterprise federation/SSO
```

---

# 18. Token-Based SSO

Instead of sharing passwords, modern federation commonly uses signed assertions or tokens.

Examples:

```text
SAML Assertion
```

or:

```text
OIDC ID Token
```

Concept:

```text
User
 ↓
Identity Provider
 ↓
Authentication
 ↓
Signed Token
 ↓
Application
 ↓
Verify Token
 ↓
Login
```

---

# 19. Authentication vs Authorization

This difference is extremely important.

## Authentication

> **Who are you?**

Example:

```text
Username + Passkey
→ Identity verified
```

## Authorization

> **What are you allowed to do?**

Example:

```text
User authenticated
       ↓
Role = Read Only
       ↓
Can view records
Cannot delete records
```

### Easy Memory

```text
Authentication
→ WHO?

Authorization
→ WHAT?
```

---

# 20. OAuth

**OAuth** is primarily an **authorization framework**.

It allows an application to obtain limited access to a protected resource without requiring the user to give that application their resource-server password.

RFC 6749 describes OAuth 2.0 as allowing a third-party application to obtain limited access to an HTTP service.

---

# 21. OAuth Example

Suppose a photo-printing application needs access to selected cloud photos.

Instead of giving the photo application your cloud password:

```text
User
 ↓
Cloud Authorization Server
 ↓
User Approves:
"Allow access to photos"
 ↓
Access Token
 ↓
Photo Application
 ↓
Cloud API
```

The application gets:

> **Access Token**

rather than the user's account password.

---

# 22. OAuth Roles — Simplified

```text
Resource Owner
→ User

Client
→ Application requesting access

Authorization Server
→ Issues tokens

Resource Server
→ API containing protected data
```

Flow:

```text
User
 ↓
Client Application
 ↓
Authorization Server
 ↓
Authorization
 ↓
Access Token
 ↓
Client
 ↓
Resource Server / API
```

---

# 23. Important OAuth Security Update

Current OAuth security best practice is documented in **RFC 9700**, published in 2025.

Among other recommendations, it strongly favors **Authorization Code + PKCE** and says public clients must use PKCE; authorization servers must support PKCE. It also advises against the older implicit flow for normal modern deployments. ([RFC Editor][6])

### Easy Interview Point

```text
Modern OAuth
→ Authorization Code
→ PKCE
```

---

# 24. OpenID Connect — OIDC

**OIDC** stands for:

> **OpenID Connect**

OIDC adds an **identity/authentication layer on top of OAuth 2.0**.

The OpenID Connect specification explicitly describes OIDC as an identity layer built on OAuth 2.0. ([OpenID Foundation][7])

OAuth provides:

```text
Access Token
→ Access to API
```

OIDC adds:

```text
ID Token
→ Information about authenticated user
```

---

# 25. OIDC Flow — Simplified

```text
User
 ↓
Application / Relying Party
 ↓
OpenID Provider
 ↓
User Authenticates
 ↓
ID Token
+
Often Access Token
 ↓
Application
```

The **ID Token** is normally a signed JWT containing identity claims.

Examples of claims may include:

```text
sub
iss
aud
exp
```

and possibly user profile information.

---

# 26. OAuth vs OIDC

| OAuth                          | OIDC                          |
| ------------------------------ | ----------------------------- |
| Authorization                  | Authentication/identity layer |
| Grants access to resources     | Proves user identity          |
| Access Token                   | ID Token + OAuth tokens       |
| Used for API access            | Used for login/federation     |
| Answers "What can app access?" | Answers "Who authenticated?"  |

### Important Interview Line

> **OAuth is for authorization; OIDC uses OAuth to provide authentication and identity.**

OpenID itself notes that OAuth alone does not standardize end-user authentication information, while OIDC adds that identity layer. ([OpenID Foundation][7])

---

# 27. OpenID vs OIDC

Older material may simply say **OpenID**.

Classic **OpenID 2.0** was an older authentication/federation protocol.

Modern systems commonly use:

> **OpenID Connect**

OpenID Connect uses OAuth 2.0, JSON, JWTs, and HTTPS/TLS; the OpenID Foundation explicitly distinguishes it from older OpenID 2.0. ([OpenID Foundation][8])

---

# 28. Traditional Login vs SSO/OIDC

## Traditional

```text
User
 ↓
Application
 ↓
Username + Password
 ↓
Application authenticates directly
```

## Federated/OIDC

```text
User
 ↓
Application
 ↓
Identity Provider
 ↓
Authentication
 ↓
ID Token
 ↓
Application trusts verified token
```

The application does not need to manage the user's main IdP password.

---

# 29. SAML vs OIDC

| SAML                            | OIDC                               |
| ------------------------------- | ---------------------------------- |
| XML based                       | JSON/JWT based                     |
| Enterprise federation           | Web/mobile/API-friendly federation |
| SAML assertion                  | ID Token                           |
| IdP + SP                        | OpenID Provider + Relying Party    |
| Older but still widely deployed | Common in modern applications      |

The OpenID Foundation describes SAML as an XML-based federation technology, while OIDC uses JSON/REST-style technologies. ([OpenID Foundation][9])

---

# 30. Interview-Ready Answer — OAuth vs OIDC

> **OAuth 2.0 is an authorization framework used to delegate access to protected resources using access tokens. OpenID Connect adds an authentication and identity layer on top of OAuth 2.0 and introduces an ID Token so an application can verify who the user is.**

---

# 24. Authentication Protocols

# 31. Kerberos

**Kerberos** is a network authentication protocol that uses **tickets and symmetric cryptography**.

It is widely associated with centralized enterprise authentication.

The central Kerberos service is the:

> **KDC — Key Distribution Center**

RFC 4120 defines the KDC as the service that supplies tickets and temporary session keys. ([RFC Editor][10])

---

# 32. Main Kerberos Components

```text
Client
KDC
 ├── Authentication Service
 └── Ticket-Granting Service
Application Server
```

Important concepts:

- KDC
- Ticket Granting Ticket — TGT
- Service Ticket
- Session keys

---

# 33. Kerberos Authentication Flow

Simplified flow:

```text
1. User Logs In
      ↓
2. Client contacts KDC
      ↓
3. KDC provides TGT
      ↓
4. Client wants File Server
      ↓
5. Client uses TGT to request Service Ticket
      ↓
6. KDC issues Service Ticket
      ↓
7. Client presents Service Ticket to File Server
      ↓
8. Server verifies ticket
      ↓
Access
```

Kerberos tickets contain information such as client identity, session-key material, timestamps, and other information protected for the relevant service. ([RFC Editor][10])

---

# 34. Why Kerberos Uses Tickets

Without Kerberos:

```text
Password
→ Sent to many services
```

With Kerberos:

```text
Authentication
      ↓
Tickets
      ↓
Services
```

The user's reusable password does not need to be presented directly to every application server.

---

# 35. Kerberos Interview Answer

> **Kerberos is a centralized network authentication protocol that uses a Key Distribution Center, tickets, and temporary session keys. A user first obtains a Ticket Granting Ticket and then uses it to request service tickets for individual services.**

---

# 36. RADIUS

**RADIUS** stands for:

> **Remote Authentication Dial-In User Service**

It is commonly used for centralized network access authentication.

Examples:

- Enterprise Wi-Fi
- VPN access
- Network Access Servers
- 802.1X environments

RFC 2865 defines RADIUS as carrying authentication, authorization, and configuration information between a Network Access Server and an authentication server. Its standard authentication port is UDP `1812`. ([RFC Editor][11])

---

# 37. RADIUS Flow

```text
User
 ↓
Wi-Fi AP / VPN Gateway / NAS
 ↓
RADIUS Access-Request
 ↓
RADIUS Server
 ↓
Access-Accept
or
Access-Reject
 ↓
NAS
 ↓
Allow / Deny User
```

---

# 38. TACACS+

**TACACS+** stands for:

> **Terminal Access Controller Access-Control System Plus**

It is mainly used for:

> **Network-device administration**

Examples:

```text
Router Login
Switch Login
Firewall Administrator Login
```

RFC 8907 describes TACACS+ as providing centralized device administration and separates:

```text
Authentication
Authorization
Accounting
```

into distinct protocol functions. ([RFC Editor][12])

---

# 39. TACACS+ Flow

```text
Network Administrator
       ↓
Router
       ↓
TACACS+ Server
       ↓
Authenticate User
       ↓
Authorize Command
       ↓
Record Accounting
```

Example:

```text
User may execute:
show running-config

But may not execute:
reload
```

This fine-grained command authorization is one reason TACACS+ is associated with network-device administration.

---

# 40. RADIUS vs TACACS+

| RADIUS                              | TACACS+                                             |
| ----------------------------------- | --------------------------------------------------- |
| Common for network access           | Common for device administration                    |
| Classic RADIUS uses UDP             | TACACS+ uses TCP                                    |
| Authentication/network access focus | Fine-grained device-command authorization           |
| Common with Wi-Fi/VPN/802.1X        | Common with routers/switches/firewalls              |
| AAA functions more tightly coupled  | Authentication, authorization, accounting separated |

### Current Security Correction

Older interview material often says:

> "TACACS+ encrypts the entire packet."

That is an oversimplification.

RFC 8907's original protection is classified as **obfuscation**, not strong encryption. A 2025 update, **RFC 9887**, defines **TACACS+ over TLS 1.3** and explicitly says new production deployments should use TLS-based authentication and encryption. ([RFC Editor][13])

---

# 41. FIDO and FIDO2

**FIDO** stands for:

> **Fast Identity Online**

FIDO authentication uses public-key cryptography to provide strong authentication without relying on a reusable password sent to a server.

**FIDO2** is made from:

```text
WebAuthn
+
CTAP
=
FIDO2
```

The FIDO Alliance explicitly defines FIDO2 as W3C WebAuthn plus FIDO Client-to-Authenticator Protocols. ([FIDO Alliance][3])

---

# 42. WebAuthn

**WebAuthn** is the browser/web API used by websites to create and use public-key credentials.

Concept:

```text
Website
   ↓
Browser WebAuthn API
   ↓
Authenticator
   ↓
Private-Key Signature
   ↓
Website verifies with public key
```

The current WebAuthn Level 3 specification was published as a W3C Candidate Recommendation Snapshot in May 2026 and defines scoped public-key credentials for strong web authentication. ([W3C][14])

---

# 43. CTAP

**CTAP** stands for:

> **Client to Authenticator Protocol**

It allows a platform/browser to communicate with an external or roaming authenticator.

Examples:

```text
USB Security Key
NFC Security Key
Phone
```

Flow:

```text
Browser
  ↓
CTAP
  ↓
Security Key
```

CTAP supports transports such as USB, NFC, and BLE. ([FIDO Alliance][15])

---

# 44. Passkeys

A **passkey** is a FIDO cryptographic credential used to replace passwords.

Instead of storing a reusable password on a website:

```text
Device:
Private Key

Website:
Public Key
```

At login:

```text
Website sends challenge
        ↓
Device signs challenge
        ↓
Website verifies signature
        ↓
Login
```

Passkeys can be:

- Synced between a user's devices
- Bound to one device/security key

FIDO describes passkeys as FIDO credentials based on public-key cryptography and designed to be phishing-resistant. ([FIDO Alliance][16])

---

# 45. Why Passkeys Resist Phishing

A passkey is scoped to the intended website/relying party.

Concept:

```text
Passkey for:
example.com

Attacker creates:
examp1e.com
```

The authenticator will not simply give the attacker the reusable secret.

Instead, authentication is cryptographically bound to the correct relying party.

FIDO explicitly identifies phishing resistance as a core security property of passkeys. ([FIDO Alliance][3])

---

# 46. Passwordless Authentication

**Passwordless authentication** removes the normal reusable password from the login process.

Examples:

- Passkeys
- FIDO security keys
- Smart cards/certificates in suitable systems

Example:

```text
User
 ↓
Device
 ↓
Fingerprint/PIN unlocks authenticator
 ↓
Private-Key Signature
 ↓
Server
 ↓
Authentication
```

---

# 47. Passwordless vs MFA

They are not exactly the same concept.

```text
Passwordless
→ No reusable password

MFA
→ Multiple authentication factors
```

A passkey may involve possession of the authenticator plus local user verification such as biometric or PIN when required by the relying party. ([FIDO Alliance][16])

---

# 48. Phishing-Resistant Authentication

Authentication is **phishing-resistant** when an attacker cannot simply trick the user into entering a reusable authentication secret into a fake site and replay it.

Good examples include appropriately deployed:

- FIDO2
- WebAuthn/passkeys
- Certain certificate-based cryptographic methods

FIDO is explicitly designed for phishing-resistant authentication. ([FIDO Alliance][17])

---

# 25. Zero Trust Architecture

## 49. What is Zero Trust?

**Zero Trust** is a security architecture that does not give implicit trust to a user or device simply because it is:

- Inside the corporate LAN
- Using a company device
- Connected through VPN
- Located in a particular office

NIST SP 800-207 says zero trust removes implicit trust based solely on physical/network location or asset ownership and instead focuses protection on users, assets, and resources. ([NIST][18])

### Simple Definition

> **Zero Trust means access must be explicitly verified and authorized instead of assuming that “inside the network = trusted.”**

---

# 50. "Never Trust, Always Verify"

This phrase is useful for remembering the idea:

```text
Request Access
      ↓
Do not trust automatically
      ↓
Verify Identity
      ↓
Verify Device
      ↓
Evaluate Context
      ↓
Authorize
      ↓
Grant Minimum Required Access
```

---

# 51. Traditional Perimeter vs Zero Trust

## Traditional Concept

```text
Internet
   ↓
Firewall
   ↓
Internal LAN
   ↓
Mostly Trusted
```

## Zero Trust Concept

```text
User / Device
      ↓
Identity?
Device Security?
Resource?
Risk?
Context?
      ↓
Policy Decision
      ↓
Allow / Deny
```

---

# 52. Continuous Verification

Traditional approach:

```text
Login Once
   ↓
Trusted for long period
```

Zero Trust moves toward:

```text
Login
 ↓
Evaluate
 ↓
Access Resource
 ↓
Re-evaluate as context changes
 ↓
Continue / Restrict / Revoke
```

Signals may include:

- User identity
- Device state
- Location
- Risk
- Session behavior
- Resource sensitivity

---

# 53. Least Privilege

**Least Privilege** means giving only the minimum access required.

Bad:

```text
Employee
→ Entire internal network
```

Better:

```text
Developer
→ Development systems only
```

or:

```text
Finance User
→ Finance Application
→ Required functions only
```

---

# 54. Per-Request / Per-Resource Authorization

Zero Trust does not mean:

```text
Authenticated once
→ Can reach everything
```

Instead:

```text
Request Resource A
   ↓
Policy Check
   ↓
Allow

Request Resource B
   ↓
New Policy Check
   ↓
Deny
```

NIST emphasizes granting access to specific enterprise resources rather than trusting broad network location. ([NIST][18])

---

# 55. Identity-Based Access

Policy may ask:

```text
Who is the user?
What role?
What privileges?
Was MFA used?
```

Example:

```text
Admin
+
Strong Authentication
→ Admin Portal

Normal User
→ Denied
```

---

# 56. Device-Based Access

Policy may consider:

- Managed or unmanaged device
- OS patch level
- EDR running?
- Device certificate?
- Device compliant?
- Compromised device?

Example:

```text
Correct User
     +
Compromised Laptop
     ↓
Access Denied
```

---

# 57. Context-Based Access

Context can include:

- Time
- Location
- Device
- Risk
- IP reputation
- User behavior
- Resource sensitivity

Example:

```text
Finance Admin
+
New unmanaged device
+
Unusual country
+
3 AM
      ↓
Higher Risk
      ↓
Require stronger authentication
or
Deny
```

---

# 58. Zero Trust Interview Answer

> **Zero Trust is a security architecture in which users and devices are not implicitly trusted because of their network location. Access decisions are based on verified identity, device state, context, resource sensitivity, and least privilege, and trust is continually re-evaluated.**

---

# 26. SSL, TLS & HTTPS

## 59. What is SSL?

**SSL** stands for:

> **Secure Sockets Layer**

SSL was the predecessor to TLS.

SSL 2.0 and SSL 3.0 are obsolete and insecure.

RFC 7568 explicitly prohibits SSL 3.0.

### Current Interview Correction

People often still say:

```text
"SSL certificate"
```

but modern HTTPS actually uses:

> **TLS certificates and TLS protocols**

---

# 60. What is TLS?

**TLS** stands for:

> **Transport Layer Security**

TLS creates a secure communication channel between endpoints.

It provides:

- Authentication
- Confidentiality
- Integrity

The current TLS 1.3 specification is **RFC 9846**, published in July 2026. It replaced the earlier TLS 1.3 RFC 8446. ([RFC Editor][19])

---

# 61. TLS Version Status

Important current interview note:

```text
SSL 2.0
→ Obsolete

SSL 3.0
→ Prohibited

TLS 1.0
→ Deprecated

TLS 1.1
→ Deprecated

TLS 1.3
→ Current modern protocol
```

TLS 1.0 and TLS 1.1 were formally deprecated by RFC 8996. ([RFC Editor][20])

---

# 62. SSL vs TLS

| SSL                   | TLS                            |
| --------------------- | ------------------------------ |
| Older protocol family | Successor to SSL               |
| Obsolete              | Modern secure-channel protocol |
| SSLv3 prohibited      | TLS 1.3 current                |
| Do not deploy         | Use supported modern TLS       |

### Easy Memory

```text
SSL
→ Old

TLS
→ Modern replacement
```

---

# 63. What is HTTPS?

**HTTPS** means:

> **HTTP over TLS**

Concept:

```text
HTTP
+
TLS
=
HTTPS
```

Typical port:

```text
TCP 443
```

HTTPS provides protection for HTTP traffic against:

- Eavesdropping
- Unauthorized modification
- Server impersonation when certificate verification is correct

---

# 64. DNS Before HTTPS

Suppose a user opens:

```text
https://www.example.com
```

The browser first needs an IP address.

```text
www.example.com
      ↓
DNS Resolution
      ↓
203.0.113.10
      ↓
Network Connection
      ↓
TLS Handshake
      ↓
HTTPS
```

So DNS/name resolution usually occurs before the browser can connect to the target IP.

---

# 65. TLS Handshake — Simplified

A modern TLS 1.3 handshake can be remembered like this:

```text
Client
  ↓
ClientHello
Supported algorithms
Key share
      ↓
Server
      ↓
ServerHello
Selected parameters
Key share
      ↓
Shared Key Material Established
      ↓
Server Certificate
CertificateVerify
Finished
      ↓
Client Verifies Certificate
      ↓
Client Finished
      ↓
Encrypted Application Traffic
```

TLS 1.3's handshake negotiates cryptographic parameters, authenticates the server, optionally authenticates the client, and establishes shared traffic-key material. ([RFC Editor][19])

---

# 66. Server Authentication

The server sends its certificate chain.

```text
Website
   ↓
Server Certificate
   ↓
Intermediate CA
   ↓
Trusted Root CA
```

The client verifies:

- CA signatures
- Trust chain
- Domain/hostname
- Validity
- Certificate usage
- Other applicable constraints

If verification succeeds:

```text
Server identity
→ Trusted according to PKI validation
```

---

# 67. Session Key Establishment

Asymmetric cryptography is relatively expensive.

TLS therefore establishes symmetric traffic keys.

Conceptually:

```text
TLS Handshake
      ↓
ECDHE / Key Agreement
      ↓
Shared Secret
      ↓
Derive Traffic Keys
      ↓
AES-GCM / ChaCha20-Poly1305
      ↓
Encrypted Data
```

TLS 1.3 uses AEAD algorithms for record protection and modern public-key-based key exchange provides forward secrecy. ([RFC Editor][19])

---

# 68. Why Symmetric Encryption is Used After Handshake

Asymmetric operations:

```text
Authentication
+
Key Establishment
```

Then:

```text
Symmetric Encryption
→ Fast bulk-data protection
```

So HTTPS combines cryptographic methods rather than encrypting every web packet directly with the server's RSA/ECC private key.

---

# 69. Website PKI

```text
Website
  ↓
X.509 Certificate
  ↓
Intermediate CA
  ↓
Root CA
  ↓
Browser Trust Store
```

The website certificate binds:

```text
Domain Name
+
Public Key
+
CA Signature
```

This lets the browser verify the server before trusting the TLS channel.

---

# 70. MITM Risk with Bad TLS Verification

Correct TLS:

```text
Browser
   ↓
Verify Certificate
   ↓
Real Website
```

Bad implementation:

```text
Browser
   ↓
"Ignore Certificate Errors"
   ↓
Attacker
   ↓
Fake Server Certificate
```

If certificate validation is disabled or bypassed, TLS can lose its server-authentication protection and become vulnerable to MITM.

---

# 71. Improper TLS Configuration

Common problems include:

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

---

# 72. Apache HTTPS

Apache HTTP Server uses:

> **mod_ssl**

for TLS.

A minimal example from the current Apache 2.4 documentation is:

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

Apache documents `SSLEngine`, `SSLCertificateFile`, and `SSLCertificateKeyFile` as the core directives for enabling HTTPS in a virtual host. ([Apache HTTP Server][21])

### Flow

```text
Client
 ↓
TCP 443
 ↓
Apache mod_ssl
 ↓
TLS Handshake
 ↓
Certificate
 ↓
Encrypted HTTP
```

---

# 73. HTTPS Troubleshooting Flow

```text
Website Not Opening
      ↓
DNS resolves?
      ↓
TCP connection succeeds?
      ↓
TLS handshake succeeds?
      ↓
Certificate valid?
      ↓
HTTP request succeeds?
```

This is an excellent interview troubleshooting sequence.

---

# 74. Interview-Ready Answer — TLS

> **TLS is the modern protocol used to create secure client-server channels. During the handshake, the client and server negotiate cryptographic parameters, authenticate the server using its certificate, establish shared traffic keys, and then use fast symmetric encryption for application data. HTTPS is HTTP running over TLS.**

---

# 27. Secure Email

## 75. Why Secure Email is Needed

Normal email can face threats such as:

- Eavesdropping
- Message modification
- Sender spoofing
- Data theft

Secure-email technologies can provide:

```text
Encryption
→ Confidentiality

Digital Signature
→ Integrity + Sender Authentication
```

---

# 76. PGP / OpenPGP

**PGP** means:

> **Pretty Good Privacy**

The standardized interoperable format is **OpenPGP**.

The current OpenPGP specification is **RFC 9580**, published in 2024. It supports public-key and symmetric encryption, digital signatures, compression, and key management. ([RFC Editor][22])

---

# 77. OpenPGP Encryption — Simplified

Suppose Alice sends encrypted email to Bob.

Bob has:

```text
Bob Public Key
Bob Private Key
```

Alice:

```text
Email
  ↓
Generate Symmetric Content Key
  ↓
Encrypt Email
  ↓
Protect Content Key for Bob
using Bob's Public Key
  ↓
Send
```

Bob:

```text
Bob Private Key
      ↓
Recover Content Key
      ↓
Decrypt Email
```

OpenPGP uses a hybrid cryptographic model combining public-key and symmetric cryptography. ([RFC Editor][22])

---

# 78. OpenPGP Digital Signature

Alice:

```text
Email
  ↓
Hash
  ↓
Alice Private Key
  ↓
Digital Signature
```

Bob:

```text
Email + Signature
       ↓
Alice Public Key
       ↓
Verify
```

This provides:

- Integrity
- Sender authentication

---

# 79. PGP Web of Trust

Traditional PGP/OpenPGP environments may use a:

> **Web of Trust**

Instead of relying entirely on one centralized CA, users can verify and certify other people's public keys.

Concept:

```text
Alice trusts Bob's key
Bob verifies Carol's key
Other users create trust relationships
```

### Important

OpenPGP key verification does not have to use only a Web of Trust; the key point for interviews is that PGP historically supports a **decentralized trust model**, unlike CA-centered S/MIME.

---

# 80. S/MIME

**S/MIME** stands for:

> **Secure/Multipurpose Internet Mail Extensions**

S/MIME uses:

- X.509 certificates
- PKI
- Public/private keys

S/MIME 4.0 is defined in RFC 8551. It supports digital signatures for authentication/integrity and encryption for confidentiality. ([RFC Editor][23])

---

# 81. S/MIME Trust Model

```text
Certificate Authority
       ↓
Issues User Certificate
       ↓
Alice
```

Recipient verifies:

```text
Alice's Certificate
      ↓
Intermediate CA
      ↓
Trusted Root CA
```

So S/MIME commonly uses:

> **CA-based hierarchical trust**

---

# 82. S/MIME Email Encryption

To encrypt email for Bob:

```text
Bob Certificate
      ↓
Bob Public Key
      ↓
Encrypt/protect message key
      ↓
Send Encrypted Email
```

Bob uses:

```text
Bob Private Key
```

to access the encrypted message.

---

# 83. S/MIME Digital Signature

Alice signs:

```text
Email
 ↓
Hash
 ↓
Alice Private Key
 ↓
Signature
```

Bob verifies using:

```text
Alice Certificate
      ↓
Alice Public Key
      ↓
Verify Signature
```

---

# 84. PGP vs S/MIME

| OpenPGP                                                       | S/MIME                            |
| ------------------------------------------------------------- | --------------------------------- |
| OpenPGP key model                                             | X.509 certificates                |
| Historically associated with Web of Trust/decentralized trust | CA-based PKI trust                |
| Encryption + signatures                                       | Encryption + signatures           |
| Often personal/technical-user oriented                        | Common in enterprise environments |
| Current standard RFC 9580                                     | S/MIME 4.0 RFC 8551               |

---

# 85. Email Encryption vs Digital Signature

## Encryption

```text
Recipient's Public Key
        ↓
Protect Message
        ↓
Recipient Private Key
        ↓
Decrypt
```

Purpose:

> **Confidentiality**

## Digital Signature

```text
Sender Private Key
       ↓
Sign
       ↓
Sender Public Key
       ↓
Verify
```

Purpose:

> **Integrity + Authentication**

---

# 86. Thunderbird

Thunderbird has built-in support for both:

- OpenPGP
- S/MIME

Mozilla's documentation states that Thunderbird has supported built-in OpenPGP and S/MIME since the Thunderbird 78 generation. ([Mozilla Support][24])

Example:

```text
Thunderbird
   ↓
OpenPGP Keys
or
S/MIME Certificates
   ↓
Encrypt / Sign Email
```

---

# 87. Outlook

Current Outlook versions support S/MIME encryption and digital signatures when properly configured with certificates and suitable accounts/policies.

Microsoft describes S/MIME in Outlook as providing:

- Email encryption
- Digital signatures

and explains that the recipient must possess the corresponding private key to decrypt a message. ([Microsoft Support][25])

---

# 88. Windows Mail — Current Note

Older course material may list **Windows Mail**.

However, Microsoft ended support for the Windows Mail, Calendar, and People applications on **December 31, 2024** and directs users toward the new Outlook for Windows. ([Microsoft Support][26])

So for current interview discussion:

```text
Windows Mail
→ Legacy / discontinued

Outlook
→ Current Microsoft mail client family
```

---

# 89. Complete Secure-Email Flow

```text
Alice
  ↓
Compose Email
  ↓
Sign with Alice Private Key
  ↓
Encrypt for Bob
using Bob Public Key
  ↓
Internet
  ↓
Bob
  ↓
Decrypt with Bob Private Key
  ↓
Verify Alice Signature
using Alice Public Key
```

Result:

```text
Encryption
→ Confidentiality

Signature
→ Integrity + Authentication
```

---

# 90. Most Important Interview Comparisons

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

# 91. Best Overall Authentication Flow

```text
User
 ↓
Authentication
 ↓
Password / Passkey / Certificate / MFA
 ↓
Identity Provider
 ↓
Identity Established
 ↓
Authorization Policy
 ↓
Least Privilege
 ↓
Application / Resource
```

---

# 92. Best SSO Memory Diagram

```text
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

---

# 93. Best Protocol Memory

```text
Kerberos
→ Tickets

RADIUS
→ Network access AAA

TACACS+
→ Network-device administration

SAML
→ XML SSO

OAuth
→ Authorization

OIDC
→ Authentication on OAuth

FIDO2
→ WebAuthn + CTAP

Passkey
→ Phishing-resistant public-key login
```

---

# 94. Best TLS Memory Flow

```text
Domain Name
    ↓
DNS
    ↓
Server IP
    ↓
TCP Connection
    ↓
TLS Handshake
    ↓
Certificate Verification
    ↓
Session Keys
    ↓
Symmetric Encryption
    ↓
HTTPS
```

---

# 95. Interview-Ready 30-Second Summary

> **Authentication verifies who a user is, while authorization decides what that user can access. Modern authentication uses MFA and increasingly phishing-resistant methods such as FIDO2 and passkeys. SSO centralizes authentication through an identity provider, with SAML commonly used in enterprise federation and OpenID Connect providing modern authentication on top of OAuth 2.0. Kerberos uses tickets, RADIUS is common for network access, and TACACS+ is common for network-device administration. Zero Trust removes implicit network trust and applies identity, device, context, and least-privilege checks. TLS secures network communication and HTTPS is HTTP over TLS, while OpenPGP and S/MIME provide encryption and digital signatures for secure email.**

### Most important lines to remember

```text
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

[1]: https://www.nist.gov/publications/nist-sp-800-63-4-digital-identity-guidelines?utm_source=chatgpt.com "NIST SP 800-63-4: Digital Identity Guidelines | NIST"
[2]: https://pages.nist.gov/800-63-4/sp800-63.html?utm_source=chatgpt.com "NIST Special Publication 800-63-4"
[3]: https://fidoalliance.org/specifications/?utm_source=chatgpt.com "FIDO User Authentication Specifications | FIDO Alliance"
[4]: https://pages.nist.gov/800-63-4/sp800-63b/authenticators/?utm_source=chatgpt.com "Authenticators"
[5]: https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.pdf?utm_source=chatgpt.com "The documents that define and support the SAML V2.0 OASIS Standard are shown in Figure 1. The lighter-colored boxes represent non-normative information."
[6]: https://www.rfc-editor.org/info/rfc9700/?utm_source=chatgpt.com "RFC 9700: Best Current Practice for OAuth 2.0 Security | RFC Editor"
[7]: https://openid.net/specs/openid-connect-core-1_0-final.html?utm_source=chatgpt.com "Final: OpenID Connect Core 1.0"
[8]: https://openid.net/wg/connect/?utm_source=chatgpt.com "AB/Connect Working Group - OpenID Foundation"
[9]: https://openid.net/foundation/how-connect-works/?utm_source=chatgpt.com "How OpenID Connect Works - OpenID Foundation"
[10]: https://www.rfc-editor.org/info/rfc4120/?utm_source=chatgpt.com "RFC 4120: The Kerberos Network Authentication Service (V5) | RFC Editor"
[11]: https://www.rfc-editor.org/info/rfc2865/?utm_source=chatgpt.com "RFC 2865: Remote Authentication Dial In User Service (RADIUS) | RFC Editor"
[12]: https://www.rfc-editor.org/info/rfc8907/?utm_source=chatgpt.com "RFC 8907: The Terminal Access Controller Access-Control System Plus (TACACS+) Protocol | RFC Editor"
[13]: https://www.rfc-editor.org/rfc/rfc9887.html?utm_source=chatgpt.com "RFC 9887: Terminal Access Controller Access-Control System Plus (TACACS+) over TLS 1.3"
[14]: https://www.w3.org/TR/webauthn-3/?utm_source=chatgpt.com "Web Authentication: An API for accessing Public Key Credentials - Level 3"
[15]: https://fidoalliance.org/specifications/download/?utm_source=chatgpt.com "FIDO Authentication Specifications | FIDO Alliance"
[16]: https://fidoalliance.org/passkeys/?utm_source=chatgpt.com "FIDO Passkeys: Passwordless Authentication | FIDO Alliance"
[17]: https://fidoalliance.org/specifications-overview/?utm_source=chatgpt.com "User Authentication Specifications | FIDO Alliance"
[18]: https://www.nist.gov/publications/zero-trust-architecture?utm_source=chatgpt.com "Zero Trust Architecture | NIST"
[19]: https://www.rfc-editor.org/info/rfc9846/?utm_source=chatgpt.com "RFC 9846: The Transport Layer Security (TLS) Protocol Version 1.3 | RFC Editor"
[20]: https://www.rfc-editor.org/info/rfc8996/?utm_source=chatgpt.com "RFC 8996: Deprecating TLS 1.0 and TLS 1.1 | RFC Editor"
[21]: https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html?utm_source=chatgpt.com "SSL/TLS Strong Encryption: How-To - Apache HTTP Server Version 2.4"
[22]: https://www.rfc-editor.org/rfc/rfc9580.html?utm_source=chatgpt.com "RFC 9580: OpenPGP"
[23]: https://www.rfc-editor.org/info/rfc8551/?utm_source=chatgpt.com "RFC 8551: Secure/Multipurpose Internet Mail Extensions (S/MIME) Version 4.0 Message Specification | RFC Editor"
[24]: https://support.mozilla.org/en-US/kb/openpgp-thunderbird-howto-and-faq?utm_source=chatgpt.com "OpenPGP in Thunderbird - HOWTO and FAQ | Thunderbird Help"
[25]: https://support.microsoft.com/en-us/Outlook/mail/set-up-outlook-to-use-s-mime-encryption?utm_source=chatgpt.com "Set up Outlook to use S/MIME encryption | Microsoft Support"
[26]: https://support.microsoft.com/en-US/Outlook/outlook-for-windows-the-future-of-mail-calendar-and-people-on-windows-11?utm_source=chatgpt.com "Outlook for Windows: The Future of Mail, Calendar, and People on Windows 11 | Microsoft Support"
