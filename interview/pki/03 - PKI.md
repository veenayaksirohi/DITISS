# PKI (Public Key Infrastructure) — Revision Notes

---

## PART 1: PKI BASICS

### 1.1 What is PKI?

**PKI = Public Key Infrastructure.** It is the complete system used to **create, manage, distribute, validate, renew, and revoke** digital certificates and public/private keys.

> **Simple Definition:** PKI is a framework of people, policies, processes, hardware, software, certificates, and cryptography used to establish trust between digital identities and public keys.

- Defined by the **ITU-T X.509 / ISO/IEC 9594-8** standard, which covers public-key certificates, validation, policies, revocation info, and trust anchors.

**Basic PKI Idea:**

```
Identity → Public Key → Digital Certificate → Signed by Trusted CA
→ Other Systems Can Verify → Digital Trust
```

### 1.2 Why is PKI Needed?

**Problem:** If Bob just hands Alice a public key, how does Alice know it really belongs to Bob? An attacker could hand over their own key and lie about who it belongs to.

**PKI's Solution:** Use a trusted **Certificate Authority (CA)**.

```
Bob's Identity + Bob's Public Key → CA verifies → CA signs certificate
→ Certificate says: "This public key belongs to this subject."
```

> **Core Idea of a Certificate:** Bind an identity/name to a public key using a trusted digital signature.

### 1.3 PKI = People + Processes + Technology

PKI is **not just software**. It has three broad areas:

| Area           | Examples                                                      |
| -------------- | ------------------------------------------------------------- |
| **People**     | CA administrators, RA operators, certificate owners, auditors |
| **Processes**  | Identity checking, issuance, renewal, revocation              |
| **Technology** | CA software, HSM, certificates, OCSP, CRL, key stores         |

> **Easy Memory:** PKI = People + Policies & Processes + Technology + Cryptography

### 1.4 X.509 Authentication Framework

**X.509** is the major standard behind digital certificates (aligned with ISO/IEC 9594-8). It defines:

- Public-key certificates
- Certificate Authorities
- Trust anchors
- Certificate validation
- Certificate policies
- CRLs
- Certificate extensions

> X.509 is a **framework** for PKI and certificates — not just a simple file format.

---

## PART 2: PKI SECURITY SERVICES

PKI can **support/enable** several security services:

| Service             | Meaning                                                                                      | Example                                                                                           |
| ------------------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| **Authentication**  | "Who are you?" — binds identity to public key; holder proves control of matching private key | HTTPS server proves control of private key via TLS → server authenticated                         |
| **Confidentiality** | PKI helps establish keys used to protect data (doesn't encrypt everything itself)            | Certificate → Authenticated Key Exchange → Session Key → AES Encryption                           |
| **Integrity**       | Digital signatures prove data wasn't modified                                                | Message → Hash → Sign → Verify with Public Key                                                    |
| **Access Control**  | PKI verifies identity; the app makes the final allow/deny decision                           | Client Certificate → Identity Verified → App checks role → Allow/Deny                             |
| **Non-Repudiation** | Signatures give evidence the private-key holder signed something                             | Legal non-repudiation also needs identity checks, key protection, policy, timestamps, audit trail |

> **Important:** A certificate itself does not encrypt all traffic — it establishes trust in keys used by protocols like TLS, IPsec, S/MIME.
> **Important:** PKI authenticates identities/keys; the application decides final access control.

---

## PART 3: PKI BUILDING BLOCKS & LIFECYCLE

### 3.1 Main PKI Flow

```
Policies → Identity Verification → Key Generation → Certificate Issuance
→ Certificate Distribution → Certificate Validation → Renewal
→ Revocation → Archival / Expiration
```

### 3.2 PKI Program

The **overall operational environment** running the PKI. Includes:

- CA software, certificate management apps, enrollment portals
- OCSP services, CRL publishing systems
- HSMs, monitoring/auditing tools, certificate inventory systems
- Governance: who requests certs? who verifies identity? who revokes? how are CA keys protected?

### 3.3 PKI Procedures

Describe **how** operations must be performed:

```
Certificate Request → Identity Verification → Approval → Certificate Issuance
```

Also: key generation, key backup/recovery, CA key ceremonies, revocation, renewal, destruction, incident handling.

### 3.4 PKI Communication Protocols

| Protocol/Mechanism | Purpose                                |
| ------------------ | -------------------------------------- |
| PKCS #10           | Certificate request                    |
| OCSP               | Check certificate status               |
| CRL distribution   | Distribute revocation lists            |
| HTTP/LDAP          | Publish/retrieve certificates or CRLs  |
| TLS                | Certificate-based secure communication |
| RFC 3161 TSP       | Trusted timestamping                   |

- RFC 5280 → operational protocols for certificate/revocation delivery
- RFC 6960 → defines OCSP

### 3.5 PKI Cryptographic Mechanisms

```
Asymmetric Crypto → RSA / ECC
Hashing → SHA-256 / SHA-384
Digital Signatures → Certificate signing
Symmetric Encryption → Session traffic
Key Agreement → ECDHE / DH
```

> PKI manages trust in public keys; real secure protocols combine several cryptographic mechanisms together.

### 3.6 Key Lifecycle Management

```
Generate → Store → Distribute Public Key → Use → Rotate/Renew
→ Revoke if Compromised → Archive if Required → Destroy
```

- Private keys need especially strong protection.

---

## PART 4: CERTIFICATE POLICY (CP) & CERTIFICATION PRACTICE STATEMENT (CPS)

### 4.1 Certificate Policy — CP

Describes rules and requirements for certificates. Answers: **WHAT rules must be followed?**

Examples: identity verification requirements, certificate purposes, key sizes, allowed algorithms, revocation requirements, subscriber responsibilities.

- RFC 3647: CP is a named set of rules describing applicability of a certificate to a community/class of applications.

### 4.2 Certification Practice Statement — CPS

Explains **how** a CA actually operates. Answers: **HOW does the CA meet policy requirements?**

Examples: how identity is verified, how CA private keys are protected, how certs are issued, how revocation requests are handled, how audits are done.

- RFC 3647: CPS is generally more detailed than CP.

### 4.3 CP vs CPS

| CP                            | CPS                              |
| ----------------------------- | -------------------------------- |
| Certificate Policy            | Certification Practice Statement |
| Defines **WHAT** must be done | Defines **HOW** it is done       |
| Higher-level requirements     | Detailed operational procedures  |
| May apply across multiple CAs | Usually specific to one CA/org   |
| More general                  | More detailed                    |

> **Easy Memory:** CP → WHAT? CPS → HOW?

> **Interview-Ready Answer (CP vs CPS):** A Certificate Policy defines what security and operational requirements a PKI must follow. A Certification Practice Statement explains how a particular CA implements those requirements. CP is WHAT, CPS is HOW.

> **Interview-Ready Answer (PKI):** PKI is a framework of people, policies, procedures, hardware, software, digital certificates, and cryptographic mechanisms used to bind public keys to identities and manage certificate trust throughout their lifecycle.

---

## PART 5: PKI ENTITIES

### 5.1 Certificate Authority — CA

The **trusted entity** that issues and digitally signs certificates.

**CA Responsibilities:**

- Issue and sign certificates
- Manage CA keys
- Revoke certificates
- Publish revocation information
- Follow CP/CPS
- Protect the trust infrastructure

```
Certificate Applicant → Identity Verified → CA → Signs Certificate → Issued Certificate
```

### 5.2 Registration Authority — RA

Performs **identity registration** on behalf of a CA (an optional/delegated component).

**Tasks:** verify applicant identity, check documents, approve/reject requests, forward approved requests to CA.

```
User → RA → Identity Verification → CA → Certificate
```

> **Easy Difference:** RA → Verifies applicant. CA → Signs and issues certificate.

> **Interview-Ready Answer (CA vs RA):** The RA verifies the identity and details of a certificate applicant, while the CA signs and issues the certificate. In simple terms, RA verifies the applicant, and CA creates the trusted certificate.

### 5.3 Digital Certificate

Contains:

```
Subject Identity + Subject Public Key + Issuer + Validity Period + Extensions + CA Signature
```

Provides a **signed binding** between an identity and a public key.

### 5.4 Certificate Repository

Stores and publishes certificate-related information (CA certs, intermediate certs, CRLs, public certs).

### 5.5 Certificate Management System (CMS)

Manages certificate operations: enrollment, approval, issuance, renewal, revocation, inventory, expiration monitoring, reporting.

> **Note:** This "CMS" ≠ Cryptographic Message Syntax (CMS, RFC 5652) — different things with the same abbreviation.

### 5.6 Certificate Revocation System

Tells relying parties when a certificate should stop being trusted before natural expiration. Common mechanisms: **CRL + OCSP**.

### 5.7 Private Key

Must remain **secret**. Used for: signing, decryption (in applicable algorithms), authentication, key agreement.

> If a CA's private key is compromised, certificates issued under that CA may become untrustworthy.

### 5.8 Public Key

Can be distributed normally; typically contained inside an X.509 certificate. Used for: signature verification, encryption (in some schemes), key agreement.

### 5.9 Session Key

A **temporary symmetric key** used to encrypt a communication session.

```
Certificate → Authenticated Handshake → Key Agreement → Session Key → AES Encryption
```

Not stored permanently in the certificate.

### 5.10 Timestamp Authority — TSA

Provides cryptographic evidence that data existed at a particular time (RFC 3161 Time-Stamp Protocol).

```
Document Hash → TSA → Trusted Time → Signed Timestamp Token
```

Useful for: signed documents, code signing, long-term signature evidence, legal/audit records.

### 5.11 Client-Side Certificate Software

Manages/uses certificates on an endpoint. Examples: browser certificate manager, OS certificate store, smart-card middleware, VPN client, email signing software, PKCS #11 client library.
May: select certificates, access private keys, verify certificates, sign data, authenticate users.

### 5.12 End User / End Entity

The **final user/device** whose certificate is used (not a CA that issues other certificates).
Examples: person, website, server, router, VPN gateway, application.

### 5.13 HSM — Hardware Security Module

A specialized device that protects keys and performs sensitive crypto operations.
**Uses:** store CA private keys, generate keys, sign certificates, protect high-value signing keys.

```
CA Software → HSM → Private CA Key
(Key never needs to leave the protected device.)
```

### 5.14 Smart Card

Can contain a private key, certificate, and cryptographic processor.

```
User → Smart Card + PIN → Private-key operation → Digital Signature
```

Goal: keep private-key material inside protected hardware.

- **PKCS #11** defines a platform-independent interface for cryptographic tokens (HSMs, smart cards).

### 5.15 Key Store

Protected storage for private keys, certificates, and trusted CA certificates.
Examples: OS certificate store, Java KeyStore, PKCS #12 file, HSM, smart card.

---

## PART 6: CERTIFICATE AUTHORITY & CHAIN OF TRUST

### 6.1 What is a Chain of Trust?

Connects an end certificate to a trusted root:

```
Root CA (signs) → Intermediate CA (signs) → Server Certificate
```

A browser doesn't need to trust every website's cert directly — it needs to trust the **root** that anchors the certification path (RFC 5280 defines path validation; browsers maintain root stores).

### 6.2 Root CA

The **top trust anchor** in a hierarchical PKI. Its certificate is normally **self-signed**:

```
Issuer = Root CA
Subject = Root CA
```

> **Very Important:** A self-signature does **not** automatically create trust. The root is trusted because it's installed in a browser/OS root store or enterprise configuration — an external mechanism.

### 6.3 Self-Signed Root Certificate

```
Issuer = Subject
```

Signature verifies with the public key inside the same certificate. RFC 5280 notes self-signed certs can start certification paths.

### 6.4 Intermediate / Subordinate CA

A CA that is signed by another CA.

```
Root CA → Intermediate CA → Leaf Certificates
```

**Why use intermediates?**

- Root private key can stay offline
- Limits exposure
- Different intermediates for different purposes
- Easier revocation/replacement
- Better separation of duties

- Mozilla's root policy requires public CA hierarchies to use intermediates instead of having roots directly issue end-entity certificates.

### 6.5 End-Entity / Leaf Certificate

The final certificate — also called a leaf, subscriber, or end-entity certificate.

```
Root → Intermediate → www.example.com
```

RFC 5280: end-entity certificates are issued to subjects **not authorized to issue certificates**.

### 6.6 Certificate Chain Verification (Browser Flow)

```
Website Certificate → Check Signature → Intermediate Certificate
→ Check Intermediate Signature → Root CA → Is Root Trusted?
→ Check Validity → Check Hostname/SAN → Check Key Usage/EKU
→ Check Constraints → Check Revocation → Trusted / Not Trusted
```

This is the standardized Internet PKI certificate-path-validation model (RFC 5280).

### 6.7 Browser Trust Store

Browsers/OSes maintain sets of trusted CA roots.

```
Browser → Trusted Root Store → Root CA A, Root CA B, Root CA C, ...
```

If a chain can't reach a trusted root → **Certificate Warning**.

### 6.8 Trust Models

**Hierarchical Model** — Most common.

```
             Root CA
             /     \
       CA 1           CA 2
       /                \
     Users             Servers
```

Trust flows downward. **Advantages:** simple structure, easy path building, central control. (India's PKI, per CCA, is hierarchical: Root CA certifies CAs, which certify subscribers.)

**Mesh Model** — Multiple CAs cross-certify each other.

```
CA A ↔ CA B
 ↕       ↕
CA C ↔ CA D
```

No single global root needed. **Advantage:** independent orgs can cooperate. **Disadvantage:** more complex path discovery/policy mapping.

**Bridge CA Model** — Connects otherwise separate PKI domains.

```
PKI A ↔ Bridge CA ↔ PKI B
```

The Bridge CA cross-certifies with participating PKIs and helps interoperability; it normally **does not** act as a final trust anchor or issue regular end-user certificates (RFC 5217).

### 6.9 Hierarchy vs Mesh vs Bridge

| Model     | Main Idea                                 |
| --------- | ----------------------------------------- |
| Hierarchy | One root with subordinate CAs             |
| Mesh      | CAs cross-certify directly                |
| Bridge    | Separate PKIs connect through a Bridge CA |

> **Interview-Ready Answer (Chain of Trust):** A certificate chain normally starts with an end-entity certificate, continues through one or more intermediate CAs, and ends at a trusted root CA. The client verifies each certificate's signature, validity, constraints, intended usage, identity (SAN), and revocation status. The chain is trusted only if it reaches a trust anchor accepted by the client.

### 6.10 Proof of Possession — PoP

Proves an applicant **actually controls** the private key matching the public key being certified.

```
Applicant generates key pair → Signs CSR with Private Key
→ CA verifies signature using Public Key → Control of Private Key demonstrated
```

For PKCS #10 requests, the request is signed with the applicant's private key, and the CA verifies that signature before issuing.

---

## PART 7: CSR & CERTIFICATE ISSUANCE

### 7.1 Key Pair Generation

Subject generates:

```
Private Key + Public Key
```

> Private Key → Keep Secret. Public Key → Include in CSR.

### 7.2 What is a CSR?

**CSR = Certificate Signing Request.** Asks a CA to issue a certificate for a public key.

- Most common format: **PKCS #10** (defined in RFC 2986)

### 7.3 CSR Contents

A PKCS #10 CSR contains:

- Subject information
- Subject public key
- Optional attributes
- Signature algorithm
- Applicant's digital signature

### 7.4 CSR Signature Flow

```
CSR Information → Hash/Sign Process → Applicant Private Key → CSR Signature
```

CA verifies it using: **Applicant Public Key** — this proves control of the corresponding private key.

### 7.5 Complete Certificate Issuance Process

```
1. Generate Key Pair
2. Create CSR
3. Sign CSR with Private Key
4. Send CSR to CA/RA
5. Verify Identity/Domain/Organization
6. Verify CSR Signature
7. CA Builds Certificate
8. CA Signs Certificate
9. Certificate Issued
10. Install Certificate
11. Use Certificate
```

Per RFC 2986: the CA authenticates the requester, verifies the request signature, and (if valid) builds the X.509 certificate using subject info + public key + CA data (serial number, validity).

### 7.6 RA Identity Verification (Depends on Cert Type)

| Type                            | Verification                                     |
| ------------------------------- | ------------------------------------------------ |
| **DV (Domain Validated)**       | Verify control of domain                         |
| **OV (Organization Validated)** | Verify domain control + organization identity    |
| **Individual certificate**      | Verify person's identity + documents/credentials |

```
CSR → RA/Validation → Identity Confirmed? → No: Reject | Yes: CA Issue
```

### 7.7 CA Signing

CA signs certificate data using its **CA private key**:

```
Certificate Data → Hash → CA Private Key → CA Digital Signature
```

Relying party verifies this later using the **CA public key**.

### 7.8 Certificate Installation

```
Server → Install Leaf Certificate + Intermediate Certificate(s) + Private Key
```

> The certificate contains only the **public key**; the private key is stored separately and protected.

### 7.9 Certificate Publication

Certificates/revocation info may be published to a repository (RFC 5280 models this).

### 7.10 Renewal

```
Existing Certificate → Renew/Re-key → Validation as Required → New Certificate
```

May reuse the same key or (often preferably/required by policy) generate a **new key pair**.

### 7.11 Expiration

```
Not Before → Certificate Valid → Not After
```

After "Not After" → certificate is **expired**. Expiration alone does not require revocation.

> **Interview-Ready Answer (CSR):** A CSR (Certificate Signing Request), usually a PKCS #10 structure, is created after generating a key pair. It contains the subject's public key and identity information, and is signed with the corresponding private key. The CA verifies the request, validates it, then issues and signs the X.509 certificate.

---

## PART 8: X.509 DIGITAL CERTIFICATE STRUCTURE

### 8.1 X.509 v3

The main modern certificate version. Key improvement: support for **extensions** (per RFC 5280 for Internet PKI).

### 8.2 Main Certificate Structure

```
X.509 Certificate
├── Version
├── Serial Number
├── Signature Algorithm
├── Issuer
├── Validity
├── Subject
├── Subject Public Key Info
├── Extensions
└── Certificate Signature
```

### 8.3 Field-by-Field Explanation

| Field                              | Meaning                                                                             |
| ---------------------------------- | ----------------------------------------------------------------------------------- |
| **Version**                        | Certificate version (usually X.509 v3, for extension support)                       |
| **Serial Number**                  | Unique ID assigned by CA under that issuer; used for revocation, OCSP, tracking     |
| **Signature Algorithm**            | Algorithm CA used to sign (e.g., `sha256WithRSAEncryption` or ECDSA)                |
| **Issuer**                         | The CA that issued and signed the certificate                                       |
| **Validity**                       | Contains `Not Before` and `Not After` dates                                         |
| **Subject**                        | Entity associated with the certificate (organization, person, device, CA)           |
| **Subject Public Key Info (SPKI)** | Public-key algorithm + the public key itself. **Does NOT contain the private key.** |
| **Certificate Signature**          | CA's signature protecting integrity/authenticity of the whole certificate           |

If anyone modifies Subject, Public Key, SAN, or Validity → the **CA signature no longer verifies**.

### 8.4 Important Extensions

**Key Usage** — restricts basic cryptographic operations allowed for the key.
Examples: `digitalSignature`, `keyEncipherment`, `keyAgreement`, `keyCertSign`, `cRLSign`
(`keyCertSign` = used for verifying certificate signatures.)

**Extended Key Usage (EKU)** — more application-specific purposes.
Examples: `serverAuth`, `clientAuth`, `codeSigning`, `emailProtection`, `timeStamping`, `OCSPSigning`

**Basic Constraints** — tells whether a certificate can act as a CA.

```
CA: TRUE  → for a CA certificate
CA: FALSE → for a leaf certificate
```

Also may contain `pathLenConstraint` (limits depth of subordinate CA chains).

**Subject Alternative Name (SAN)** — alternative identities. For TLS:

```
DNS:www.example.com
DNS:example.com
```

Can include DNS names, email addresses, IP addresses, URIs.

**CRL Distribution Points** — tells clients where to get CRL info.

```
CRL Distribution Point: http://ca.example/crl.crl
```

**Authority Key Identifier (AKI)** — identifies the **issuer's key** used to sign the certificate (useful when a CA has multiple keys).

**Subject Key Identifier (SKI)** — identifies the **certificate subject's** public key.

> AKI/SKI help chain-building software match issuer and subject keys correctly.

---

## PART 9: CERTIFICATE TYPES

### 9.1 By Purpose

| Type                           | Used For                                                                                                                                       |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| **User Certificate**           | Identifies a person/user — client authentication, email signing, document signing, encryption                                                  |
| **Server/SSL-TLS Certificate** | Authenticates servers (e.g., https://example.com). Browser checks: chain, SAN/domain, validity, signature, trust anchor, constraints           |
| **Code-Signing Certificate**   | Signs applications, scripts, drivers, software — verifies publisher + checks integrity                                                         |
| **Self-Signed Certificate**    | Signed by its own key; common for root CAs, testing, internal environments. Not automatically trusted by browsers unless explicitly configured |

### 9.2 By Validation Level (TLS Certificates)

| Type                            | What is Mainly Validated                                                           |
| ------------------------------- | ---------------------------------------------------------------------------------- |
| **DV (Domain Validated)**       | Domain control only                                                                |
| **OV (Organization Validated)** | Domain control + organization identity                                             |
| **EV (Extended Validation)**    | Domain + more extensive organization verification (CA/Browser Forum EV Guidelines) |

> Current CA/B Forum Baseline Requirements actually define **four** subscriber-certificate types: **DV, IV, OV, EV**.

> **Important Interview Point:** DV, OV, and EV differ mainly in **identity-validation information**, not in the basic strength of TLS encryption.

### 9.3 Indian DSC (Digital Signature Certificate) Classes

Per the current Controller of Certifying Authorities (CCA), India:

| Class       | General Idea                                          |
| ----------- | ----------------------------------------------------- |
| **Class 1** | Identity verification, software key storage allowed   |
| **Class 2** | Higher key-storage assurance using validated hardware |
| **Class 3** | Stronger identity verification + validated hardware   |
| Also:       | Aadhaar e-KYC OTP, Aadhaar e-KYC Biometric            |

- Classes 2 & 3 require hardware cryptographic devices validated to **FIPS 140-2 Level 2** (per current India PKI material).

> **Note:** FIPS 140-2 has been **superseded by FIPS 140-3**. FIPS 140-2 testing ended in 2021; NIST states existing active 140-2 validations remain listed until **September 21, 2026** — after that, only FIPS 140-3 validations remain active.

---

## PART 10: CERTIFICATE FILE FORMATS

| Format                     | Type      | Description                                                                                                                                                                         |
| -------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **PEM**                    | Text      | Base64-encoded data wrapped with `-----BEGIN...-----`/`-----END...-----` labels (RFC 7468). May contain certificates, public keys, private keys, CSRs                               |
| **DER**                    | Binary    | Distinguished Encoding Rules — binary ASN.1 encoding of X.509 structures                                                                                                            |
| **PKCS #7 / .p7b**         | Container | Historically Cryptographic Message Syntax; modern CMS is RFC 5652. Commonly used to carry a certificate + intermediate certs + chain info. **Does not usually hold a private key.** |
| **PKCS #12 / .pfx / .p12** | Container | Portable, usually password-protected. Can hold: Private Key + Leaf Certificate + Intermediate Certificates (RFC 7292)                                                               |

### Easy Memory

```
PEM → Text
DER → Binary
P7B → Usually certificate chain
PFX/P12 → Certificate + Private Key + Chain
```

---

## PART 11: CERTIFICATE LIFECYCLE & REVOCATION

### 11.1 Certificate Lifecycle

```
Request → Validate → Issue → Install → Use → Renew/Re-key → Expire
                                                              (or Revoke Early)
```

### 11.2 Why Revoke a Certificate?

- Private key compromised
- CA key compromised
- Employee leaves organization
- Domain ownership changes
- Information becomes incorrect
- Certificate was mis-issued
- Certificate no longer authorized

(RFC 5280 specifically lists private-key compromise and subject/CA relationship changes as reasons for early revocation.)

### 11.3 CRL — Certificate Revocation List

A **signed list** of revoked certificates, published by the CA.

```
CA → Creates CRL → Serial Number A, B, C — Revoked → Publishes CRL
```

RFC 5280 defines a CRL as a time-stamped, signed list identifying revoked certificates.

**CRL Checking Flow:**

```
Certificate → Read Serial Number → Download CRL
→ Serial Number present? → Yes: Revoked | No: Not listed
```

### 11.4 OCSP — Online Certificate Status Protocol

Instead of downloading a full CRL, a client asks an OCSP responder about a **specific certificate**.

```
Client → "Status of certificate 123?" → OCSP Responder → Good / Revoked / Unknown
```

RFC 6960 defines OCSP to check status without needing a full CRL.

### 11.5 CRL vs OCSP

| CRL                                | OCSP                                     |
| ---------------------------------- | ---------------------------------------- |
| Downloads a full revocation list   | Queries status of a specific certificate |
| Contains many revoked certificates | Usually just one certificate's status    |
| Can be larger                      | Smaller individual response              |
| Periodically updated               | More near-real-time/online model         |
| Client retrieves the list          | Client queries the responder             |

> **Interview-Ready Answer (CRL vs OCSP):** CRL is a signed list of revoked certificates published periodically. OCSP lets a client ask an online responder about a specific certificate's status. OCSP is more targeted; CRL requires downloading the whole revocation list.

### 11.6 OCSP Stapling

**Normal OCSP:** Browser → CA OCSP Responder → Status

**With OCSP Stapling:**

```
Server → Gets OCSP Response from CA → Stores signed response temporarily
Browser connects → Server sends certificate + OCSP response together
```

Reduces client round trips and load on CA responders (RFC 6066 defines the TLS certificate-status request; RFC 6961 explains its benefits).

### 11.7 Renewal vs Expiration vs Revocation

| Action         | Meaning                                        |
| -------------- | ---------------------------------------------- |
| **Renewal**    | Get a new certificate before/around expiration |
| **Expiration** | Validity period naturally ends                 |
| **Revocation** | Certificate invalidated early                  |

> **Easy Memory:** Expiration → Time finished. Revocation → Trust ended early. Renewal → New certificate.

---

## PART 12: PKI STANDARDS (PKCS FAMILY)

**PKCS = Public-Key Cryptography Standards.** A family of standards covering RSA, password-based crypto, certificate requests, private-key formats, hardware-token interfaces, and key containers.

| Standard     | Main Purpose                                                                                                                                 |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **PKCS #1**  | RSA cryptography — key structure, encryption schemes (RSA-OAEP), signature schemes (RSA-PSS). Modern spec: RFC 8017                          |
| **PKCS #3**  | Historically defines Diffie-Hellman Key Agreement (1993 spec; modern protocols use newer DH/ECDH standards)                                  |
| **PKCS #5**  | Password-based cryptography — PBKDF2, password-based encryption. Modern spec: RFC 8018 (v2.1)                                                |
| **PKCS #7**  | Historically defines Cryptographic Message Syntax (signed data, enveloped data, certificate collections). Modern IETF version: CMS, RFC 5652 |
| **PKCS #8**  | Private-key information format (standardized private key container). RFC 5208 (v1.2), obsoleted by RFC 5958                                  |
| **PKCS #10** | Certificate Signing Request (CSR) syntax — subject, public key, attributes, signature algorithm, CSR signature. RFC 2986                     |
| **PKCS #11** | API for cryptographic tokens (HSM, smart card, USB token), called **Cryptoki**                                                               |
| **PKCS #12** | Portable container for private key + certificate + CA chain (`.p12`/`.pfx`), commonly password-protected. RFC 7292                           |

### Best Memory

```
#1  → RSA
#3  → DH
#5  → Password
#7  → Message / Cert bundle
#8  → Private key
#10 → CSR
#11 → HSM / Smart card API
#12 → PFX/P12
```

### PKCS #11 Flow

```
Application → PKCS #11 API (Cryptoki) → HSM / Smart Card → Private-Key Operation
```

---

## PART 13: FIPS & CMVP

### 13.1 What is FIPS?

**FIPS = Federal Information Processing Standards** — issued by **NIST** for U.S. federal government information-processing/security requirements.

### 13.2 FIPS 140-2 (Now Superseded)

Specified security requirements for **cryptographic modules**: module design, interfaces, authentication, physical security, key management, self-tests, operating environment, attack mitigation.

- Defined **4 increasing security levels**.
- **Now superseded by FIPS 140-3.**

**FIPS 140-2 Security Levels:**

| Level       | General Idea                                                                    |
| ----------- | ------------------------------------------------------------------------------- |
| **Level 1** | Basic cryptographic module security                                             |
| **Level 2** | Adds stronger physical/tamper-evident controls + role-based protection          |
| **Level 3** | Stronger physical protection + identity-based controls; stronger key protection |
| **Level 4** | Highest level — extensive physical/environmental protection                     |

> **Easy Memory:** Level 1 (Basic) → Level 2 (More protection) → Level 3 (Strong protection) → Level 4 (Highest protection)

### 13.3 FIPS 140-3 — Current Standard

Superseded FIPS 140-2. Published by NIST in 2019; also provides **4 increasing security levels**.

- As of August 2026: FIPS 140-2 validations may remain active through **September 21, 2026**. After that, only **FIPS 140-3** validations remain active on the CMVP list.

### 13.4 CMVP — Cryptographic Module Validation Program

Validates cryptographic modules against FIPS requirements.

```
Cryptographic Product → Accredited Testing Laboratory → FIPS Tests
→ Validation Review → CMVP Validation
```

Accredited labs perform conformance testing; modules receive ratings for applicable FIPS requirement areas.

---

## PART 14: COMPLETE PKI FLOWS (MASTER DIAGRAMS)

### 14.1 Complete Certificate Issuance & Verification Flow

```
User / Server
     ↓
Generate Key Pair
     ↓
Private Key ─────→ Keep Secret
     |
Public Key
     ↓
Create PKCS #10 CSR
     ↓
Sign CSR with Private Key
     ↓
RA / CA
     ↓
Verify Identity + Verify CSR Signature
     ↓
CA Signs Certificate
     ↓
X.509 Certificate Issued
     ↓
Certificate Installed
     ↓
Client Connects
     ↓
Build Certificate Chain
     ↓
Leaf → Intermediate CA → Root CA
     ↓
Root in Trust Store?
     ↓
Check: Signature, Validity, SAN, Key Usage/EKU, Constraints, Revocation
     ↓
Certificate Trusted
```

### 14.2 Certificate Revocation Flow

```
Certificate Issued
       ↓
Private Key Compromised
       ↓
Owner/Admin Requests Revocation
       ↓
CA Revokes Certificate
       ↓
Publishes: CRL and/or OCSP Status
       ↓
Client Checks Status
       ↓
Certificate Rejected
```

### 14.3 PKI Security Model — Best Memory Diagram

```
                         PKI
                          |
        --------------------------------------
        |                 |                  |
     PEOPLE            PROCESS            TECHNOLOGY
        |                 |                  |
 CA / RA / Users     CP / CPS /         X.509 / HSM /
                    Lifecycle /          CRL / OCSP /
                    Validation           PKCS
                          |
                     TRUST MODEL
                          |
                     Root CA
                        ↓
                 Intermediate CA
                        ↓
                   End Entity
```

---

## PART 15: QUICK REVISION TABLE

| Topic             | Easy Meaning                                     |
| ----------------- | ------------------------------------------------ |
| PKI               | System for managing certificate/public-key trust |
| X.509             | Certificate and PKI framework                    |
| CA                | Signs/issues/revokes certificates                |
| RA                | Verifies applicants                              |
| Root CA           | Trust anchor (self-signed)                       |
| Intermediate CA   | CA signed by another CA                          |
| Leaf Certificate  | Final user/server certificate                    |
| CSR               | Request for a certificate                        |
| PKCS #10          | CSR format                                       |
| PoP               | Proves ownership/control of private key          |
| HSM               | Hardware protection for keys                     |
| SAN               | Alternative identity/domain names                |
| Key Usage         | Basic allowed key operations                     |
| EKU               | Application-specific key uses                    |
| Basic Constraints | Identifies CA capability                         |
| AKI               | Identifies issuer key                            |
| SKI               | Identifies subject key                           |
| CRL               | Revoked certificate list                         |
| OCSP              | Online certificate status check                  |
| TSA               | Trusted timestamp provider                       |
| CP                | What must be done                                |
| CPS               | How it is done                                   |
| PEM               | Base64/text form                                 |
| DER               | Binary encoding                                  |
| P7B               | Common certificate-chain container               |
| PFX/P12           | Key + certificate container                      |
| FIPS 140          | Cryptographic-module security standard           |

---

## PART 16: MOST IMPORTANT INTERVIEW QUESTIONS

1. What is PKI, and why is it needed?
2. Why is PKI called "people + process + technology"?
3. What is X.509?
4. What security services can PKI support?
5. CA vs RA?
6. What is a digital certificate, and what does it contain?
7. What is a TSA? What is an HSM?
8. Why should CA keys be stored in HSMs?
9. Root CA vs Intermediate CA — why not let root issue end-user certs directly?
10. What is a self-signed certificate? Is it automatically trusted?
11. What is a chain of trust, and how does a browser verify it?
12. Hierarchical vs Mesh vs Bridge PKI models?
13. What is Proof of Possession (PoP)?
14. What is a CSR (PKCS #10), and what does it contain?
15. Which key signs the CSR? Which key signs the final certificate?
16. What is X.509 v3, and why do extensions matter?
17. Explain SAN, Key Usage, EKU, Basic Constraints, AKI, SKI.
18. DV vs OV vs EV certificates?
19. What are Indian DSC classes?
20. PEM vs DER? P7B vs PFX/P12?
21. What is a CRL? What is OCSP? CRL vs OCSP?
22. What is OCSP Stapling?
23. Renewal vs Expiration vs Revocation?
24. What is CP? What is CPS? CP vs CPS?
25. Explain PKCS #1 / #5 / #7 / #8 / #10 / #11 / #12.
26. What is FIPS 140-2 vs FIPS 140-3?
27. What is CMVP?

---

## PART 17: MASTER INTERVIEW-READY ANSWERS

> **PKI:** PKI is a framework of people, policies, procedures, hardware, software, digital certificates, and cryptographic mechanisms used to bind public keys to identities and manage certificate trust throughout their lifecycle.

> **CA vs RA:** The RA verifies the identity and details of a certificate applicant, while the CA signs and issues the certificate. RA verifies the applicant; CA creates the trusted certificate.

> **Chain of Trust:** A certificate chain starts with an end-entity certificate, goes through one or more intermediate CAs, and ends at a trusted root CA. The client verifies each certificate's signature, validity, constraints, intended usage, SAN, and revocation status. The chain is trusted only if it reaches a trust anchor the client already trusts.

> **CSR:** A CSR (usually PKCS #10) is created after generating a key pair. It contains the subject's public key and identity info, signed with the applicant's private key. The CA verifies the request, validates it, then issues and signs the X.509 certificate.

> **CRL vs OCSP:** CRL is a signed list of revoked certificates published periodically by a CA. OCSP lets a client ask an online responder for the status of one specific certificate. OCSP gives a more targeted, near-real-time check; CRL requires downloading the whole list.

> **CP vs CPS:** CP defines WHAT rules a PKI must follow. CPS explains HOW a specific CA implements those rules.

### Final Master Flow

```
PKI
 ↓
Identity + Public Key
 ↓
RA verifies identity
 ↓
CA signs certificate
 ↓
X.509 Certificate
 ↓
Root → Intermediate → Leaf
 ↓
Client validates chain
 ↓
CRL / OCSP checks status
 ↓
Trusted Identity
```

**Remember:**

```
Private Key   → Keep secret
Public Key    → Put in certificate
CSR           → Signed by applicant's private key
Certificate   → Signed by CA's private key
Root CA       → Trusted through the trust store
CRL / OCSP    → Revocation status
```

### Best Interview Line

> **PKI creates digital trust by binding identities to public keys through CA-signed X.509 certificates, then managing those certificates and keys through issuance, validation, renewal, revocation, and secure lifecycle controls.**
