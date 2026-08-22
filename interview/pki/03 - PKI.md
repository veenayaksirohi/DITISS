# 14. PKI Fundamentals — Detailed Notes

## 1. What is PKI?

**PKI** stands for **Public Key Infrastructure**.

PKI is the complete system used to create, manage, distribute, validate, renew, and revoke **digital certificates and public/private keys**.

### Simple Definition

> **PKI is a framework of people, policies, processes, hardware, software, certificates, and cryptography used to establish trust between digital identities and public keys.**

ITU-T X.509 / ISO/IEC 9594-8 defines the framework for public-key certificates, certificate validation, certificate policies, revocation information, trust anchors, and related PKI entities. ([ITU][1])

### Basic PKI Idea

```text
Identity
   ↓
Public Key
   ↓
Digital Certificate
   ↓
Signed by Trusted CA
   ↓
Other Systems Can Verify
   ↓
Digital Trust
```

---

# 2. Why is PKI Needed?

Suppose Bob gives Alice a public key.

```text
Bob:
"This is my public key."
```

Alice has a problem:

> How does Alice know the public key really belongs to Bob?

An attacker could provide their own key and claim:

```text
Attacker:
"This is Bob's public key."
```

PKI solves this by using a trusted **Certificate Authority (CA)**.

```text
Bob's Identity
      +
Bob's Public Key
      ↓
Certificate Authority verifies
      ↓
CA signs certificate
      ↓
Certificate says:

"This public key belongs
to this subject."
```

The core idea of a certificate is therefore:

> **Bind an identity or name to a public key using a trusted digital signature.**

---

# 3. PKI = People + Processes + Technology

PKI is not just encryption software.

It contains three broad areas.

| Area           | Examples                                                      |
| -------------- | ------------------------------------------------------------- |
| **People**     | CA administrators, RA operators, certificate owners, auditors |
| **Processes**  | Identity checking, certificate issuance, renewal, revocation  |
| **Technology** | CA software, HSM, certificates, OCSP, CRL, key stores         |

### Easy Memory

```text
PKI
=
People
+
Policies & Processes
+
Technology
+
Cryptography
```

---

# 4. X.509 Authentication Framework

**X.509** is the major standard behind digital certificates.

The current ITU-T X.509 framework is aligned with **ISO/IEC 9594-8** and defines concepts such as:

- Public-key certificates
- Certificate Authorities
- Trust anchors
- Certificate validation
- Certificate policies
- Certificate revocation lists
- Certificate extensions

ITU describes X.509 as a framework for PKI and public-key certificates rather than simply a file format. ([ITU][1])

---

# 5. PKI Security Services

PKI can **support or enable** several security services.

## Authentication

Authentication answers:

> **Who are you?**

A certificate can bind:

```text
Identity
   ↕
Public Key
```

The user or server can then prove possession of the corresponding private key.

Example:

```text
HTTPS Server
    ↓
Certificate
    ↓
Public Key
    ↓
TLS proves control of private key
    ↓
Server authenticated
```

---

## Confidentiality

PKI can help establish keys used to protect confidential communication.

Example:

```text
Certificate / Public Key
        ↓
Authenticated Key Exchange
        ↓
Shared Session Key
        ↓
AES Encryption
```

### Important

> A certificate itself does not encrypt all traffic.

It helps establish trust in keys that are then used by protocols such as TLS, IPsec, S/MIME, etc.

---

## Integrity

Digital signatures can prove that data has not been modified.

```text
Message
   ↓
Hash
   ↓
Digital Signature
   ↓
Verify using Public Key
```

If the message changes, signature verification fails.

---

## Access Control

PKI can help applications make authorization decisions.

Example:

```text
Client Certificate
      ↓
Identity Verified
      ↓
Application Checks Role
      ↓
Allow / Deny
```

### Important Distinction

> PKI authenticates identities and keys. The application or authorization system normally makes the final access-control decision.

---

## Non-Repudiation

Digital signatures can provide evidence that a holder of a private key signed information.

PKI strengthens this by associating the public key with an identified certificate holder.

However:

> Cryptographic signatures support non-repudiation, but legal non-repudiation also depends on identity verification, private-key protection, policies, timestamps, audit evidence, and applicable law.

---

# 6. Main PKI Building Blocks

A PKI generally needs:

```text
Policies
   ↓
Identity Verification
   ↓
Key Generation
   ↓
Certificate Issuance
   ↓
Certificate Distribution
   ↓
Certificate Validation
   ↓
Key / Certificate Renewal
   ↓
Revocation
   ↓
Archival / Expiration
```

---

# 7. PKI Programs

A **PKI program** is the overall operational environment used to run the PKI.

It can include:

- CA software
- Certificate management applications
- Certificate enrollment portals
- OCSP services
- CRL publishing systems
- Hardware Security Modules
- Monitoring and auditing tools
- Certificate inventory systems

It also includes governance activities such as:

- Who may request certificates?
- Which certificates may be issued?
- How identities are verified?
- Who can revoke certificates?
- How CA keys are protected?

---

# 8. PKI Procedures

**PKI procedures** describe how PKI operations must be performed.

Examples:

```text
Certificate Request
      ↓
Identity Verification
      ↓
Approval
      ↓
Certificate Issuance
```

Other procedures include:

- Key generation
- Key backup where allowed
- Key recovery
- CA key ceremonies
- Revocation
- Certificate renewal
- Certificate destruction
- Incident handling

---

# 9. PKI Communication Protocols

PKI uses different protocols and formats.

Examples include:

| Protocol / Mechanism | Purpose                                |
| -------------------- | -------------------------------------- |
| PKCS #10             | Certificate request                    |
| OCSP                 | Check certificate status               |
| CRL distribution     | Distribute revocation lists            |
| HTTP/LDAP            | Publish/retrieve certificates or CRLs  |
| TLS                  | Certificate-based secure communication |
| RFC 3161 TSP         | Trusted timestamping                   |

RFC 5280 describes operational protocols for certificate and revocation-information delivery, while RFC 6960 defines OCSP. ([RFC Editor][2])

---

# 10. PKI Cryptographic Mechanisms

PKI commonly combines:

```text
Asymmetric Cryptography
→ RSA / ECC

Hashing
→ SHA-256 / SHA-384 etc.

Digital Signatures
→ Certificate signing

Symmetric Encryption
→ Session traffic

Key Agreement
→ ECDHE / DH
```

The important idea is:

> PKI manages trust in public keys; actual secure protocols combine several cryptographic mechanisms.

---

# 11. Key Lifecycle Management

Keys must be managed from creation until destruction.

```text
Generate
   ↓
Store
   ↓
Distribute Public Key
   ↓
Use
   ↓
Rotate / Renew
   ↓
Revoke if Compromised
   ↓
Archive if Required
   ↓
Destroy
```

Private keys require especially strong protection.

---

# 12. Certificate Policy — CP

**CP** stands for:

> **Certificate Policy**

A Certificate Policy describes the rules and requirements for certificates.

It answers:

> **WHAT rules must be followed?**

Examples:

- Identity verification requirements
- Certificate purposes
- Key sizes
- Allowed algorithms
- Revocation requirements
- Subscriber responsibilities

RFC 3647 describes a CP as a named set of rules describing the applicability of a certificate to a community or class of applications. ([RFC Editor][3])

---

# 13. Certification Practice Statement — CPS

**CPS** stands for:

> **Certification Practice Statement**

It explains how a CA actually operates.

It answers:

> **HOW does the CA meet the policy requirements?**

Examples:

- How identity verification occurs
- How CA private keys are protected
- How certificates are issued
- How revocation requests are handled
- How audits are conducted

RFC 3647 explains that CP specifies the requirements, while CPS describes how the CA implements those requirements; a CPS is generally more detailed. ([RFC Editor][3])

---

# 14. CP vs CPS

| CP                            | CPS                                   |
| ----------------------------- | ------------------------------------- |
| Certificate Policy            | Certification Practice Statement      |
| Defines **what** must be done | Defines **how** it is done            |
| Higher-level requirements     | Detailed operational procedures       |
| May apply across multiple CAs | Usually specific to a CA/organization |
| More general                  | More detailed                         |

### Easy Memory

```text
CP
→ WHAT?

CPS
→ HOW?
```

---

# 15. Interview-Ready Answer — PKI

> **PKI, or Public Key Infrastructure, is a framework of people, policies, procedures, hardware, software, digital certificates, and cryptographic mechanisms used to bind public keys to identities and manage certificate trust throughout their lifecycle.**

---

# 15. PKI Entities

## 16. Certificate Authority — CA

A **Certificate Authority** is the trusted entity that issues and digitally signs certificates.

NIST describes a CA as a trusted PKI entity that issues and revokes public-key certificates. ([NIST Computer Security Resource Center][4])

### CA Responsibilities

- Issue certificates
- Sign certificates
- Manage CA keys
- Revoke certificates
- Publish revocation information
- Follow CP/CPS
- Protect trust infrastructure

Flow:

```text
Certificate Applicant
       ↓
Identity Verified
       ↓
CA
       ↓
Signs Certificate
       ↓
Issued Certificate
```

---

# 17. Registration Authority — RA

**RA** stands for:

> **Registration Authority**

An RA performs identity-registration functions on behalf of a CA.

RFC 5280 describes an RA as an optional component to which a CA delegates certain certificate-management functions. ([RFC Editor][2])

Typical tasks:

- Verify applicant identity
- Check documents
- Approve/reject certificate requests
- Forward approved requests to CA

```text
User
 ↓
RA
 ↓
Identity Verification
 ↓
CA
 ↓
Certificate
```

### Easy Difference

```text
RA
→ Verifies applicant

CA
→ Signs and issues certificate
```

---

# 18. Digital Certificate

A digital certificate contains information such as:

```text
Subject Identity
+
Subject Public Key
+
Issuer
+
Validity Period
+
Extensions
+
CA Signature
```

It provides a signed binding between an identity and a public key.

---

# 19. Certificate Repository

A **Certificate Repository** stores and publishes certificate-related information.

RFC 5280 defines a repository as a system or distributed collection of systems used to store and distribute certificates and CRLs. ([RFC Editor][2])

It may contain:

- CA certificates
- Intermediate certificates
- CRLs
- Public certificates

---

# 20. Certificate Management System

A **Certificate Management System (CMS)** in the PKI-management sense manages certificate operations.

Typical features:

- Enrollment
- Approval
- Issuance
- Renewal
- Revocation
- Inventory
- Expiration monitoring
- Reporting

### Do not confuse

This use of **CMS** is different from:

> **Cryptographic Message Syntax (CMS)** defined in RFC 5652.

---

# 21. Certificate Revocation System

A revocation system tells relying parties when a certificate should no longer be trusted before its natural expiration.

Common mechanisms:

```text
CRL
+
OCSP
```

RFC 5280 requires CAs to indicate revocation status and recognizes mechanisms such as CRLs and OCSP. ([RFC Editor][2])

---

# 22. Private Key

The **private key** must remain secret.

It may be used for:

- Signing
- Decryption in applicable algorithms
- Authentication
- Key agreement operations

```text
Private Key
→ SECRET
```

If a CA private key is compromised:

> Certificates issued under that CA may become untrustworthy.

---

# 23. Public Key

The public key can normally be distributed.

It may be contained inside:

```text
X.509 Certificate
```

It is used for operations such as:

- Signature verification
- Encryption in some schemes
- Key agreement

---

# 24. Session Key

A **session key** is usually a temporary symmetric key used to encrypt a communication session.

Example:

```text
Certificate
   ↓
Authenticated Handshake
   ↓
Key Agreement
   ↓
Session Key
   ↓
AES Encryption
```

The session key is not normally stored permanently in the certificate.

---

# 25. Timestamp Authority — TSA

**TSA** stands for:

> **Time-Stamp Authority**

A TSA provides cryptographic evidence that particular data existed at a particular time.

RFC 3161 defines the Time-Stamp Protocol and describes a TSA as a trusted service that creates timestamp tokens based on a trustworthy time source. ([RFC Editor][5])

Example:

```text
Document Hash
     ↓
TSA
     ↓
Trusted Time
     ↓
Signed Timestamp Token
```

Useful for:

- Digitally signed documents
- Code signing
- Long-term signature evidence
- Legal/audit records

---

# 26. Client-Side Certificate Software

Client-side certificate software manages or uses certificates on an endpoint.

Examples:

- Browser certificate manager
- Operating-system certificate store
- Smart-card middleware
- VPN client
- Email signing software
- PKCS #11 client library

It may:

- Select certificates
- Access private keys
- Verify certificates
- Sign data
- Authenticate users

---

# 27. End User / End Entity

An **end entity** is the final user/device whose certificate is being used rather than a CA issuing other certificates.

RFC 5280 describes an end entity as a PKI certificate user or end-user system that is the subject of a certificate. ([RFC Editor][2])

Examples:

- Person
- Website
- Server
- Router
- VPN gateway
- Application

---

# 28. HSM

**HSM** stands for:

> **Hardware Security Module**

It is a specialized cryptographic device used to protect keys and perform sensitive operations.

Typical uses:

- Store CA private keys
- Generate keys
- Sign certificates
- Protect high-value signing keys

Concept:

```text
CA Software
    ↓
HSM
    ↓
Private CA Key

Key does not need to leave
the protected device.
```

---

# 29. Smart Card

A smart card can contain:

- Private key
- Certificate
- Cryptographic processor

Example:

```text
User
 ↓
Smart Card + PIN
 ↓
Private-key operation
 ↓
Digital Signature
```

The goal is to keep private-key material inside protected hardware.

PKCS #11 defines a platform-independent interface for cryptographic tokens such as HSMs and smart cards. ([oasis-open.org][6])

---

# 30. Key Store

A **key store** is a protected storage location for:

- Private keys
- Certificates
- Trusted CA certificates

Examples include:

- OS certificate store
- Java KeyStore
- PKCS #12 file
- HSM
- Smart card

---

# 16. Certificate Authority & Chain of Trust

## 31. What is a Chain of Trust?

A certificate chain connects an end certificate to a trusted root.

Typical hierarchy:

```text
Root CA
   ↓ signs
Intermediate CA
   ↓ signs
Server Certificate
```

The browser does not need to directly trust every website certificate.

It needs to trust the root that anchors the validated certification path.

RFC 5280 defines certification-path validation, and modern browser root stores contain selected trusted root CA certificates that serve as trust anchors. ([RFC Editor][2])

---

# 32. Root CA

The **Root CA** is the top trust anchor in a hierarchical PKI.

Its certificate is normally:

> **Self-signed**

```text
Root CA
Issuer  = Root CA
Subject = Root CA
```

A root is trusted because it is already installed/configured as a trust anchor—not merely because it signs itself.

### Very Important

> A self-signature does not magically create trust.

The root must be trusted through some external mechanism such as:

- Browser root store
- Operating-system trust store
- Enterprise configuration

---

# 33. Self-Signed Root Certificate

A self-signed certificate has:

```text
Issuer = Subject
```

and its signature verifies with the public key contained within the same certificate.

RFC 5280 notes that self-signed certificates can convey the public key used to begin certification paths. ([RFC Editor][2])

---

# 34. Intermediate / Subordinate CA

An **Intermediate CA** is signed by another CA.

Example:

```text
Root CA
   ↓
Intermediate CA
   ↓
Leaf Certificates
```

Why use intermediates?

- Root private key can remain offline
- Limits exposure
- Different intermediates can serve different purposes
- Easier revocation/replacement
- Better separation of duties

Mozilla's current root policy requires public CA hierarchies in its program to use intermediates rather than having included roots directly issue customer end-entity certificates. ([Mozilla][7])

---

# 35. End-Entity / Leaf Certificate

The final certificate is often called:

- Leaf certificate
- Subscriber certificate
- End-entity certificate

Example:

```text
Root
  ↓
Intermediate
  ↓
www.example.com
```

RFC 5280 defines end-entity certificates as certificates issued to subjects that are not authorized to issue certificates. ([RFC Editor][2])

---

# 36. Certificate Chain Verification

A simplified browser verification flow:

```text
Website Certificate
      ↓
Check Signature
      ↓
Intermediate Certificate
      ↓
Check Intermediate Signature
      ↓
Root CA
      ↓
Is Root Trusted?
      ↓
Check Validity
      ↓
Check Hostname / SAN
      ↓
Check Key Usage / EKU
      ↓
Check Constraints
      ↓
Check Revocation where applicable
      ↓
Trusted / Not Trusted
```

RFC 5280 provides the standardized Internet PKI certificate-path-validation model. ([RFC Editor][2])

---

# 37. Browser Trust Store

Browsers and operating systems maintain sets of trusted CA roots.

Mozilla states that Firefox includes X.509 root certificates with configured trust purposes; Chrome similarly maintains its Root Store and verifies site certificates against trusted CA roots. ([Mozilla][7])

Concept:

```text
Browser
   ↓
Trusted Root Store
   ↓
Root CA A
Root CA B
Root CA C
...
```

If a chain cannot reach a trusted root:

```text
Certificate Warning
```

---

# 38. Hierarchical Trust Model

The most common model is:

```text
             Root CA
             /     \
       CA 1           CA 2
       /                \
     Users             Servers
```

Trust flows downward from the root.

Advantages:

- Simple structure
- Easy path building
- Central control

India PKI, for example, is described by the CCA as hierarchical: the Root CA certifies CAs, which then certify subscribers. ([CCA][8])

---

# 39. Mesh Trust Model

In a mesh PKI, multiple CAs may cross-certify each other.

```text
CA A ↔ CA B
 ↕       ↕
CA C ↔ CA D
```

There may not be one single global root for all participants.

Advantages:

- Independent organizations can cooperate

Disadvantage:

- More complicated path discovery and policy mapping

NIST describes mesh architectures as more complex alternatives to simple hierarchies. ([NIST][9])

---

# 40. Bridge CA Model

A **Bridge CA** connects otherwise separate PKI domains.

```text
PKI A
  ↕
Bridge CA
  ↕
PKI B
```

The Bridge CA:

- Cross-certifies with participating PKIs
- Helps establish interoperability
- Normally does not act as the final trust anchor
- Normally does not issue normal end-user certificates

RFC 5217 describes the Bridge model as reducing the number of cross-certification relationships and specifically says a Bridge CA should not serve as the trust anchor of a participating PKI domain.

---

# 41. Hierarchy vs Mesh vs Bridge

| Model     | Main Idea                               |
| --------- | --------------------------------------- |
| Hierarchy | One root with subordinate CAs           |
| Mesh      | CAs cross-certify directly              |
| Bridge    | Separate PKIs connect through Bridge CA |

---

# 42. Proof of Possession — PoP

**Proof of Possession** proves that an applicant actually controls the private key corresponding to the public key being certified.

Example:

```text
Applicant generates:
Public Key + Private Key

Applicant signs CSR
with Private Key
      ↓
CA verifies signature
using Public Key
      ↓
Applicant has demonstrated
control of Private Key
```

For a PKCS #10 request, the request information is signed with the applicant's private key, and the CA verifies that signature before issuing the certificate. ([RFC Editor][10])

---

# 17. CSR & Certificate Issuance

## 43. Key Pair Generation

The subject normally begins by generating:

```text
Private Key
+
Public Key
```

### Important

The private key should stay with the subject.

```text
Private Key
→ Keep Secret

Public Key
→ Include in CSR
```

---

# 44. What is CSR?

**CSR** stands for:

> **Certificate Signing Request**

A CSR asks a CA to issue a certificate for a public key.

The most common CSR format is:

> **PKCS #10**

RFC 2986 defines the PKCS #10 certification request structure. ([RFC Editor][10])

---

# 45. CSR Contents

A PKCS #10 CSR contains:

- Subject information
- Subject public key
- Optional attributes
- Signature algorithm
- Applicant's digital signature

RFC 2986 specifies that the request information includes a subject distinguished name, subject public key, and optional attributes, and that the request is signed using the subject's private key. ([RFC Editor][10])

---

# 46. CSR Signature

Flow:

```text
CSR Information
      ↓
Hash / Signature Process
      ↓
Applicant Private Key
      ↓
CSR Signature
```

The CA can verify it with:

```text
Applicant Public Key
```

This helps demonstrate control of the corresponding private key.

---

# 47. Complete Certificate Issuance Process

```text
1. Generate Key Pair
        ↓
2. Create CSR
        ↓
3. Sign CSR with Private Key
        ↓
4. Send CSR to CA / RA
        ↓
5. Verify Identity / Domain / Organization
        ↓
6. Verify CSR Signature
        ↓
7. CA Builds Certificate
        ↓
8. CA Signs Certificate
        ↓
9. Certificate Issued
        ↓
10. Install Certificate
        ↓
11. Use Certificate
```

RFC 2986 states that the CA authenticates the requesting entity, verifies the request signature, and, if valid, constructs the X.509 certificate using the subject information and public key plus CA-selected data such as serial number and validity. ([RFC Editor][10])

---

# 48. RA Identity Verification

The exact checks depend on certificate type and policy.

Examples:

### Website DV

Verify control of domain.

### OV

Verify:

- Domain control
- Organization identity

### Individual certificate

Verify:

- Person's identity
- Required documents/credentials

```text
CSR
 ↓
RA / Validation
 ↓
Identity Confirmed?
 /             \
No              Yes
↓                ↓
Reject          CA Issue
```

---

# 49. CA Signing

The CA signs certificate data using its:

> **CA private key**

```text
Certificate Data
      ↓
Hash
      ↓
CA Private Key
      ↓
CA Digital Signature
```

The relying party later verifies this signature using the CA public key.

---

# 50. Certificate Installation

Once issued:

```text
Server
  ↓
Install Leaf Certificate
  +
Intermediate Certificate(s)
  +
Private Key
```

### Important

The certificate contains the public key.

The private key is stored separately and must be protected.

---

# 51. Certificate Publication

Some certificates/revocation information may be published to a repository.

RFC 5280 explicitly models repositories for certificates and CRLs. ([RFC Editor][2])

---

# 52. Renewal

Before expiration:

```text
Existing Certificate
      ↓
Renew / Re-key
      ↓
Validation as Required
      ↓
New Certificate
```

Renewal may use:

- Same key in some environments
- New key pair—often preferable or required by policy

---

# 53. Expiration

A certificate has a validity period:

```text
Not Before
   ↓
Certificate Valid
   ↓
Not After
```

After `Not After`:

> Certificate is expired.

A certificate does not need to be revoked just because it reached its normal expiration.

---

# 18. X.509 Digital Certificates

## 54. X.509 v3

**X.509 version 3** is the main certificate version used in modern PKI.

Its important improvement is support for **extensions**.

RFC 5280 profiles X.509 v3 certificates for Internet PKI and defines their basic fields and standard extensions. ([RFC Editor][2])

---

# 55. Main X.509 Certificate Structure

```text
X.509 Certificate
│
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

RFC 5280 lists these basic fields and extension structures as part of the Internet X.509 profile. ([RFC Editor][2])

---

# 56. Version

Indicates certificate version.

Modern certificates commonly use:

```text
X.509 v3
```

because v3 supports extensions.

---

# 57. Serial Number

A CA assigns a serial number to uniquely identify a certificate under that issuer.

Used in:

- Revocation
- OCSP
- Certificate tracking

---

# 58. Signature Algorithm

Identifies the algorithm used by the CA to sign the certificate.

Example concept:

```text
sha256WithRSAEncryption
```

or an ECDSA signature scheme.

RFC 5280 specifies this field as identifying the CA's certificate-signing algorithm. ([RFC Editor][2])

---

# 59. Issuer

The **Issuer** identifies the CA that issued and signed the certificate.

```text
Issuer:
Example Intermediate CA
```

RFC 5280 defines the issuer as the entity that signed and issued the certificate. ([RFC Editor][2])

---

# 60. Validity

Contains:

```text
Not Before
Not After
```

Example:

```text
Not Before:
2026-01-01

Not After:
2027-01-01
```

---

# 61. Subject

Identifies the entity associated with the certificate.

Examples:

- Organization
- Person
- Device
- CA

---

# 62. Subject Public Key Info — SPKI

Contains:

```text
Public-Key Algorithm
+
Public Key
```

Example:

```text
Algorithm: RSA
Public Key: ....
```

The certificate does **not** contain the subject's private key.

---

# 63. Key Usage

**Key Usage** restricts the basic cryptographic operations permitted for the key.

Examples:

- `digitalSignature`
- `keyEncipherment`
- `keyAgreement`
- `keyCertSign`
- `cRLSign`

RFC 5280 states that Key Usage defines the purpose of the certified public key; for example, `keyCertSign` is used for certificate-signature verification. ([RFC Editor][2])

---

# 64. Extended Key Usage — EKU

EKU gives more application-specific purposes.

Examples:

```text
serverAuth
clientAuth
codeSigning
emailProtection
timeStamping
OCSPSigning
```

RFC 5280 defines these purposes and requires applications to respect EKU restrictions when they are present. ([RFC Editor][2])

---

# 65. Basic Constraints

Basic Constraints tells whether a certificate is allowed to act as a CA.

Example:

```text
CA: TRUE
```

for a CA certificate.

```text
CA: FALSE
```

for a leaf certificate.

It can also contain:

```text
pathLenConstraint
```

which restricts how deep subordinate CA chains may go.

RFC 5280 states that this extension identifies whether the subject is a CA and can constrain the maximum certification-path depth. ([RFC Editor][2])

---

# 66. Subject Alternative Name — SAN

SAN contains alternative identities.

For TLS, common values are:

```text
DNS:www.example.com
DNS:example.com
```

SAN can contain multiple name forms including:

- DNS names
- Email addresses
- IP addresses
- URIs

RFC 5280 defines these SAN forms. ([RFC Editor][2])

---

# 67. CRL Distribution Points

This extension tells clients where CRL information can be obtained.

Example:

```text
CRL Distribution Point:
http://ca.example/crl.crl
```

RFC 5280 defines this extension specifically for locating CRL information. ([RFC Editor][2])

---

# 68. Authority Key Identifier — AKI

**AKI** identifies the issuer's key used to sign the certificate.

Useful when a CA has multiple keys.

Concept:

```text
Certificate
   ↓
AKI
   ↓
Which issuer key signed me?
```

---

# 69. Subject Key Identifier — SKI

**SKI** identifies the certificate subject's public key.

Concept:

```text
Subject Public Key
      ↓
SKI
      ↓
Key Identifier
```

AKI/SKI help chain-building software match issuer and subject keys. RFC 5280 defines both standard extensions for this purpose. ([RFC Editor][11])

---

# 70. Certificate Signature

At the bottom of the certificate is the CA's signature.

```text
Certificate Data
      ↓
CA Signature
```

It protects the integrity and authenticity of the certificate contents.

If someone modifies:

```text
Subject
Public Key
SAN
Validity
```

the CA signature will no longer verify.

---

# 19. Certificate Types, Validation & Formats

## 71. User Certificate

Used to identify a person/user.

Possible uses:

- Client authentication
- Email signing
- Document signing
- Encryption

---

# 72. Server / SSL-TLS Certificate

Used to authenticate servers.

Example:

```text
https://example.com
```

The browser checks:

- Certificate chain
- SAN/domain
- Validity
- Signature
- Trust anchor
- Relevant constraints

---

# 73. Code-Signing Certificate

Used to sign:

- Applications
- Scripts
- Drivers
- Software packages

Purpose:

```text
Software
  ↓
Signature
  ↓
Verify Publisher
+
Check Integrity
```

---

# 74. Self-Signed Certificate

A self-signed certificate is signed using the same key associated with its own subject.

It is common for:

- Root CA certificates
- Testing
- Internal/private environments

### Important

A random self-signed server certificate is not automatically trusted by browsers.

Trust must be explicitly configured.

---

# 75. DV Certificate

**DV** stands for:

> **Domain Validated**

The CA verifies control of the domain.

Example:

```text
example.com
   ↓
Domain Control Validation
   ↓
DV Certificate
```

DV does not claim that a specific incorporated organization has been validated merely because domain control was established. The current CA/Browser Forum Baseline Requirements identify DV as one of the publicly trusted TLS subscriber certificate types. ([CA/Browser Forum][12])

---

# 76. OV Certificate

**OV** stands for:

> **Organization Validated**

It includes validated organization identity information in addition to domain control.

```text
Domain Control
     +
Organization Validation
     ↓
OV Certificate
```

CA/B Forum OIDs distinguish DV, OV, and other certificate profiles, with OV asserting organization identity. ([CA/Browser Forum][13])

---

# 77. EV Certificate

**EV** stands for:

> **Extended Validation**

EV follows additional identity-validation requirements defined by the CA/Browser Forum EV Guidelines. ([CA/Browser Forum][14])

Concept:

```text
Domain Validation
      +
Detailed Organization Verification
      +
EV Requirements
      ↓
EV Certificate
```

### Important Interview Point

> DV, OV, and EV differ mainly in **identity-validation information**, not in the basic strength of TLS encryption.

The current CA/B Forum Baseline Requirements actually define four subscriber-certificate types: **DV, IV, OV, and EV**. ([CA/Browser Forum][15])

---

# 78. DV vs OV vs EV

| Type | What is mainly validated?                       |
| ---- | ----------------------------------------------- |
| DV   | Domain control                                  |
| OV   | Domain + organization                           |
| EV   | Domain + more extensive organization validation |

---

# 79. Indian DSC Classes

The current Controller of Certifying Authorities (CCA), Government of India, lists:

- **Class 1**
- **Class 2**
- **Class 3**
- Aadhaar e-KYC OTP
- Aadhaar e-KYC Biometric

The CCA says Class 1 keys may be generated/stored in software, while Classes 2 and 3 require hardware cryptographic devices validated to FIPS 140-2 Level 2 under the current India PKI material. ([CCA][8])

### Simplified Interview View

| Class   | General Idea from current CCA page                               |
| ------- | ---------------------------------------------------------------- |
| Class 1 | Identity verification with software key storage allowed          |
| Class 2 | Higher key-storage assurance using validated hardware            |
| Class 3 | Stronger identity-verification requirements + validated hardware |

### Important Current Note

NIST has superseded **FIPS 140-2 with FIPS 140-3**. FIPS 140-2 validation testing ended in 2021, though NIST currently states existing active 140-2 module validations remain on its active list until **September 21, 2026**; from **September 22, 2026**, only FIPS 140-3 validations remain active. ([NIST Computer Security Resource Center][16])

---

# 80. PEM

**PEM** is a text representation.

Example structure:

```text
-----BEGIN CERTIFICATE-----
Base64 encoded data
-----END CERTIFICATE-----
```

PEM normally wraps binary ASN.1 data in Base64 text with BEGIN/END labels. RFC 7468 standardizes these widely deployed textual encodings. ([RFC Editor][17])

May contain:

- Certificates
- Public keys
- Private keys
- CSRs

depending on the label.

---

# 81. DER

**DER** stands for:

> **Distinguished Encoding Rules**

DER is a binary ASN.1 encoding.

```text
X.509 Structure
     ↓
DER
     ↓
Binary Data
```

Easy difference:

```text
DER
→ Binary

PEM
→ Base64 text representation
```

---

# 82. PKCS #7 / `.p7b`

PKCS #7 historically defined a Cryptographic Message Syntax. Modern IETF CMS is specified in RFC 5652 and is its successor lineage. CMS can hold signed/encrypted content and certificate sets.

A `.p7b` file is commonly used to carry:

```text
Certificate
+
Intermediate Certificates
+
Chain information
```

It normally does not serve as the common container for a private key.

---

# 83. PKCS #12 — `.pfx` / `.p12`

PKCS #12 is a portable container format.

It can hold:

```text
Private Key
+
Leaf Certificate
+
Intermediate Certificates
```

and is commonly password protected.

RFC 7292 defines PKCS #12 / PFX structures for importing and exporting keys and related information. ([RFC Editor][18])

### Easy Memory

```text
PEM
→ Text

DER
→ Binary

P7B
→ Usually certificate chain

PFX/P12
→ Certificate + Private Key + Chain
```

---

# 20. Certificate Lifecycle & Revocation

## 84. Certificate Lifecycle

```text
Request
  ↓
Validate
  ↓
Issue
  ↓
Install
  ↓
Use
  ↓
Renew / Re-key
  ↓
Expire

or

Revoke Early
```

---

# 85. Why Revoke a Certificate?

A certificate may need revocation if:

- Private key compromised
- CA key compromised
- Employee leaves organization
- Domain ownership changes
- Information becomes incorrect
- Certificate was mis-issued
- Certificate no longer authorized

RFC 5280 specifically identifies private-key compromise and changes in the subject/CA relationship as examples requiring early revocation. ([RFC Editor][2])

---

# 86. CRL

**CRL** stands for:

> **Certificate Revocation List**

A CRL is a signed list of revoked certificates.

```text
CA
 ↓
Creates CRL
 ↓
Serial Number A — Revoked
Serial Number B — Revoked
Serial Number C — Revoked
 ↓
Publishes CRL
```

RFC 5280 defines a CRL as a time-stamped signed list identifying revoked certificates. ([RFC Editor][2])

---

# 87. CRL Checking

```text
Certificate
     ↓
Read Serial Number
     ↓
Download CRL
     ↓
Serial Number present?
   /          \
 Yes           No
 ↓              ↓
Revoked     Not listed
```

---

# 88. OCSP

**OCSP** stands for:

> **Online Certificate Status Protocol**

Instead of downloading a complete revocation list, a client asks an OCSP responder about a specific certificate.

```text
Client
  ↓
"Status of certificate 123?"
  ↓
OCSP Responder
  ↓
Good / Revoked / Unknown
```

RFC 6960 defines OCSP specifically as a way to determine the current status of a digital certificate without requiring a CRL.

---

# 89. CRL vs OCSP

| CRL                                | OCSP                                    |
| ---------------------------------- | --------------------------------------- |
| Downloads a revocation list        | Queries certificate status              |
| Contains many revoked certificates | Usually checks a particular certificate |
| Can be larger                      | Smaller individual response             |
| Periodically updated               | More online/near-current model          |
| Client retrieves list              | Client queries responder                |

---

# 90. OCSP Stapling

With normal OCSP:

```text
Browser
 ↓
CA OCSP Responder
 ↓
Status
```

With **OCSP Stapling**:

```text
Server
 ↓
Gets OCSP Response from CA
 ↓
Stores signed response temporarily

Browser connects
 ↓
Server sends certificate
+
OCSP response
```

This can reduce client round trips and load on CA responders. RFC 6066 defines the TLS certificate-status request mechanism commonly called OCSP stapling, and RFC 6961 describes its round-trip and load benefits. ([RFC Editor][19])

---

# 91. Renewal vs Expiration vs Revocation

| Action     | Meaning                                      |
| ---------- | -------------------------------------------- |
| Renewal    | Get new certificate before/around expiration |
| Expiration | Validity period naturally ends               |
| Revocation | Certificate invalidated early                |

### Easy Memory

```text
Expiration
→ Time finished

Revocation
→ Trust ended early

Renewal
→ New certificate
```

---

# 21. PKI Standards

## 92. What is PKCS?

**PKCS** stands for:

> **Public-Key Cryptography Standards**

The PKCS family contains several standards/specifications covering RSA, password-based cryptography, certificate requests, private-key formats, hardware-token interfaces, key containers, and other cryptographic structures.

---

# 93. PKCS #1

**PKCS #1** defines RSA cryptography.

It covers:

- RSA key structure
- RSA encryption schemes
- RSA signature schemes

Modern RFC:

> **RFC 8017**

It includes RSA-OAEP and RSA-PSS among its defined schemes. ([RFC Editor][20])

### Easy Memory

```text
PKCS #1
→ RSA
```

---

# 94. PKCS #3

PKCS #3 historically defines:

> **Diffie-Hellman Key Agreement**

```text
PKCS #3
→ DH Key Agreement
```

The historical PKCS #3 v1.4 specification dates to 1993; modern protocols generally use newer DH/ECDH standards and protocol-specific specifications rather than treating old PKCS #3 as the current general key-agreement standard. ([RFC Editor][21])

---

# 95. PKCS #5

**PKCS #5** covers password-based cryptography.

It includes concepts such as:

- Password-based key derivation
- PBKDF2
- Password-based encryption

RFC 8018 specifies PKCS #5 v2.1 and covers key derivation, encryption schemes, and message authentication schemes.

### Easy Memory

```text
PKCS #5
→ Password-Based Cryptography
```

---

# 96. PKCS #7

PKCS #7 historically defines a:

> **Cryptographic Message Syntax**

Used for things such as:

- Signed data
- Certificate collections
- Enveloped data

The modern IETF **CMS** standard is RFC 5652.

### Easy Memory

```text
PKCS #7
→ Signed/enveloped content
→ Certificate bundles
```

---

# 97. PKCS #8

PKCS #8 concerns:

> **Private-key information formats**

It provides a standardized container for private keys and associated information.

RFC 5208 published PKCS #8 v1.2; it was later obsoleted by RFC 5958, which defines updated asymmetric-key-package syntax while retaining compatibility concepts.

### Easy Memory

```text
PKCS #8
→ Private Key Format
```

---

# 98. PKCS #10

PKCS #10 defines:

> **Certificate Signing Request syntax**

```text
PKCS #10
→ CSR
```

RFC 2986 defines:

```text
Subject
+
Public Key
+
Attributes
+
Signature Algorithm
+
CSR Signature
```

([RFC Editor][10])

---

# 99. PKCS #11

PKCS #11 defines an API for cryptographic tokens.

Examples:

- HSM
- Smart card
- Cryptographic USB/token

The API is called:

> **Cryptoki**

OASIS describes PKCS #11 as a platform-independent API for devices that store cryptographic information and perform cryptographic functions. ([oasis-open.org][6])

### Flow

```text
Application
    ↓
PKCS #11 API
    ↓
HSM / Smart Card
    ↓
Private-Key Operation
```

---

# 100. PKCS #12

PKCS #12 provides a portable personal-information/key container.

Common extensions:

```text
.p12
.pfx
```

May contain:

```text
Private Key
+
Certificate
+
CA Chain
```

([RFC Editor][18])

---

# 101. PKCS Family Quick Table

| Standard | Main Purpose                              |
| -------- | ----------------------------------------- |
| PKCS #1  | RSA                                       |
| PKCS #3  | Historical DH key agreement               |
| PKCS #5  | Password-based cryptography               |
| PKCS #7  | Cryptographic messages / certificate sets |
| PKCS #8  | Private-key format                        |
| PKCS #10 | CSR                                       |
| PKCS #11 | HSM / token API                           |
| PKCS #12 | Private key + certificate container       |

### Best Memory

```text
#1  → RSA
#3  → DH
#5  → Password
#7  → Message / Cert bundle
#8  → Private key
#10 → CSR
#11 → HSM / Smart card API
#12 → PFX/P12
```

---

# 102. What is FIPS?

**FIPS** stands for:

> **Federal Information Processing Standards**

FIPS standards are issued by NIST for U.S. federal government information-processing/security requirements.

---

# 103. FIPS 140-2

**FIPS 140-2** specified security requirements for:

> **Cryptographic modules**

It covered areas such as:

- Cryptographic module design
- Interfaces
- Authentication
- Physical security
- Key management
- Self-tests
- Operating environment
- Attack mitigation

NIST states that FIPS 140-2 defined four increasing qualitative security levels, but it has been superseded by FIPS 140-3. ([NIST Computer Security Resource Center][16])

---

# 104. FIPS 140-2 Security Levels

A simplified interview view:

| Level       | General Idea                                                                                    |
| ----------- | ----------------------------------------------------------------------------------------------- |
| **Level 1** | Basic cryptographic module security                                                             |
| **Level 2** | Adds stronger physical/tamper-evident controls and role-based protection                        |
| **Level 3** | Stronger physical protection and identity-based controls; stronger protection of sensitive keys |
| **Level 4** | Highest level, with extensive physical/environmental protection                                 |

NIST describes Levels 1–4 as increasing levels, with Level 1 the lowest and Level 4 the highest. ([NIST Computer Security Resource Center][22])

### Easy Memory

```text
Level 1
Basic
   ↓
Level 2
More protection
   ↓
Level 3
Strong protection
   ↓
Level 4
Highest protection
```

---

# 105. FIPS 140-3 — Current Standard

This is important for current interviews.

**FIPS 140-3** superseded FIPS 140-2.

NIST published FIPS 140-3 in 2019 and states that it provides four increasing security levels for cryptographic modules. ([NIST Computer Security Resource Center][23])

As of August 2026, NIST says FIPS 140-2 validations may remain active through **September 21, 2026**, after which only FIPS 140-3 validations remain on the active CMVP list. ([NIST Computer Security Resource Center][24])

---

# 106. Cryptographic Module Validation Program — CMVP

**CMVP** stands for:

> **Cryptographic Module Validation Program**

It validates cryptographic modules against FIPS requirements.

Simplified process:

```text
Cryptographic Product
       ↓
Accredited Testing Laboratory
       ↓
FIPS Tests
       ↓
Validation Review
       ↓
CMVP Validation
```

NIST explains that accredited Cryptographic and Security Testing laboratories perform conformance testing and that modules receive ratings for applicable FIPS requirement areas. ([NIST Computer Security Resource Center][25])

---

# 107. Complete PKI Flow

This is the most important diagram for the whole chapter.

```text
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
Verify Identity
+
Verify CSR Signature
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
Leaf
 ↓
Intermediate CA
 ↓
Root CA
     ↓
Root in Trust Store?
     ↓
Check:
Signature
Validity
SAN
Key Usage / EKU
Constraints
Revocation
     ↓
Certificate Trusted
```

---

# 108. Certificate Revocation Flow

```text
Certificate Issued
       ↓
Private Key Compromised
       ↓
Owner / Admin Requests Revocation
       ↓
CA Revokes Certificate
       ↓
Publishes:
CRL and/or OCSP Status
       ↓
Client Checks Status
       ↓
Certificate Rejected
```

---

# 109. PKI Security Model — Best Memory Diagram

```text
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

# 110. Most Important Interview Questions

1. What is PKI?
2. Why is PKI needed?
3. Why is PKI called people + process + technology?
4. What is X.509?
5. What security services can PKI support?
6. What is a CA?
7. What is an RA?
8. CA vs RA?
9. What is a digital certificate?
10. What is a certificate repository?
11. What is a TSA?
12. What is an HSM?
13. Why should CA keys be stored in HSMs?
14. What is a root CA?
15. What is an intermediate CA?
16. Why shouldn't a root normally issue end-user certificates directly?
17. What is a self-signed certificate?
18. Is every self-signed certificate trusted?
19. What is a chain of trust?
20. How does a browser verify a certificate chain?
21. What is a trust store?
22. Hierarchical vs mesh PKI?
23. What is a Bridge CA?
24. What is proof of possession?
25. What is a CSR?
26. What is PKCS #10?
27. What does a CSR contain?
28. Which key signs the CSR?
29. Which key signs the final certificate?
30. What is X.509 v3?
31. What is SAN?
32. What is Key Usage?
33. What is EKU?
34. What is Basic Constraints?
35. What are AKI and SKI?
36. What are CRL Distribution Points?
37. What is DV?
38. What is OV?
39. What is EV?
40. DV vs OV vs EV?
41. What are Indian DSC classes?
42. PEM vs DER?
43. P7B vs PFX?
44. What is a CRL?
45. What is OCSP?
46. CRL vs OCSP?
47. What is OCSP Stapling?
48. Renewal vs revocation vs expiration?
49. What is CP?
50. What is CPS?
51. CP vs CPS?
52. Explain PKCS #1/#5/#7/#8/#10/#11/#12.
53. What is FIPS 140-2?
54. What is FIPS 140-3?
55. What is CMVP?

---

# 111. Interview-Ready Answer — CA vs RA

> **The Registration Authority verifies the identity and details of a certificate applicant, while the Certificate Authority signs and issues the certificate. In simple terms, the RA verifies the applicant and the CA creates the trusted certificate.**

---

# 112. Interview-Ready Answer — Chain of Trust

> **A certificate chain normally starts with an end-entity certificate, continues through one or more intermediate CAs, and ends at a trusted root CA. The client verifies each certificate's signature, validity, constraints, intended usage, identity such as SAN, and applicable revocation information. The chain is trusted only if it reaches a trust anchor accepted by the client.**

---

# 113. Interview-Ready Answer — CSR

> **A CSR, or Certificate Signing Request, is usually a PKCS #10 structure created after generating a key pair. It contains the subject's public key and identity-related information and is signed using the corresponding private key. The CA verifies the request and, after performing the required validation, issues and signs the X.509 certificate.**

---

# 114. Interview-Ready Answer — CRL vs OCSP

> **CRL is a signed list of revoked certificates published periodically by a CA or CRL issuer. OCSP lets a client ask an online responder for the status of a particular certificate. OCSP can provide a more targeted status check, while CRL requires downloading revocation-list information.**

---

# 115. Interview-Ready Answer — CP vs CPS

> **A Certificate Policy defines what security and operational requirements a PKI must follow. A Certification Practice Statement explains how a particular CA implements those requirements. In short, CP is WHAT and CPS is HOW.**

---

# 116. Quick Revision Table

| Topic             | Easy Meaning                                     |
| ----------------- | ------------------------------------------------ |
| PKI               | System for managing certificate/public-key trust |
| X.509             | Certificate and PKI framework                    |
| CA                | Signs/issues/revokes certificates                |
| RA                | Verifies applicants                              |
| Root CA           | Trust anchor                                     |
| Intermediate CA   | CA signed by another CA                          |
| Leaf Certificate  | Final user/server certificate                    |
| CSR               | Request for certificate                          |
| PKCS #10          | CSR format                                       |
| PoP               | Prove ownership/control of private key           |
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

# 117. Final Memory Flow

```text
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

And remember:

```text
Private Key
→ Keep secret

Public Key
→ Put in certificate

CSR
→ Signed by applicant private key

Certificate
→ Signed by CA private key

Root CA
→ Trusted through trust store

CRL / OCSP
→ Revocation status
```

### Best interview line

> **PKI creates digital trust by binding identities to public keys through CA-signed X.509 certificates and then managing those certificates and keys through issuance, validation, renewal, revocation, and secure lifecycle controls.**

[1]: https://www.itu.int/itu-t/recommendations/rec.aspx?rec=X.509&utm_source=chatgpt.com "ITU-T Recommendation database"
[2]: https://www.rfc-editor.org/rfc/rfc5280.html "www.rfc-editor.org"
[3]: https://www.rfc-editor.org/info/rfc3647/?utm_source=chatgpt.com "RFC 3647: Internet X.509 Public Key Infrastructure Certificate Policy and Certification Practices Framework | RFC Editor"
[4]: https://csrc.nist.gov/glossary/term/certification_authority?utm_source=chatgpt.com "certification authority - Glossary | CSRC"
[5]: https://www.rfc-editor.org/info/rfc3161/?utm_source=chatgpt.com "RFC 3161: Internet X.509 Public Key Infrastructure Time-Stamp Protocol (TSP) | RFC Editor"
[6]: https://www.oasis-open.org/standard/pkcs-11-specification-version-3-1-2/?utm_source=chatgpt.com "PKCS #11 Specification Version 3.1 - OASIS Open"
[7]: https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/policy/?utm_source=chatgpt.com "Mozilla Root Store Policy — Mozilla"
[8]: https://cca.gov.in/classes_of_certificates.html "Classes of certificates | CCA"
[9]: https://www.nist.gov/publications/public-key-infrastructures-safisfy-security-goals?utm_source=chatgpt.com "Public Key Infrastructures That Safisfy Security Goals | NIST"
[10]: https://www.rfc-editor.org/rfc/rfc2986.html "www.rfc-editor.org"
[11]: https://www.rfc-editor.org/info/rfc2459/?utm_source=chatgpt.com "RFC 2459: Internet X.509 Public Key Infrastructure Certificate and CRL Profile | RFC Editor"
[12]: https://cabforum.org/working-groups/server/baseline-requirements/requirements/ "Latest Baseline Requirements | CA/Browser Forum"
[13]: https://cabforum.org/resources/object-registry/?utm_source=chatgpt.com "Object Registry | CA/Browser Forum"
[14]: https://cabforum.org/working-groups/server/extended-validation/guidelines/?utm_source=chatgpt.com "Latest Extended Validation Guidelines | CA/Browser Forum"
[15]: https://cabforum.org/working-groups/server/baseline-requirements/requirements/?utm_source=chatgpt.com "Latest Baseline Requirements | CA/Browser Forum"
[16]: https://csrc.nist.gov/pubs/fips/140-2/upd2/final "FIPS 140-2, Security Requirements for Cryptographic Modules | CSRC"
[17]: https://www.rfc-editor.org/info/rfc7468/?utm_source=chatgpt.com "RFC 7468: Textual Encodings of PKIX, PKCS, and CMS Structures | RFC Editor"
[18]: https://www.rfc-editor.org/rfc/rfc7292.html "www.rfc-editor.org"
[19]: https://www.rfc-editor.org/info/rfc6066/?utm_source=chatgpt.com "RFC 6066: Transport Layer Security (TLS) Extensions: Extension Definitions | RFC Editor"
[20]: https://www.rfc-editor.org/info/rfc8017/?utm_source=chatgpt.com "RFC 8017: PKCS #1: RSA Cryptography Specifications Version 2.2 | RFC Editor"
[21]: https://www.rfc-editor.org/info/rfc2786/?utm_source=chatgpt.com "RFC 2786: Diffie-Helman USM Key Management Information Base and Textual Convention | RFC Editor"
[22]: https://csrc.nist.gov/glossary/term/fips_140_security_level?utm_source=chatgpt.com "FIPS 140 security level - Glossary | CSRC"
[23]: https://csrc.nist.gov/pubs/fips/140-3/final "FIPS 140-3, Security Requirements for Cryptographic Modules | CSRC"
[24]: https://csrc.nist.gov/Projects/cryptographic-module-validation-program/FAQs?utm_source=chatgpt.com "Cryptographic Module Validation Program | CSRC"
[25]: https://csrc.nist.gov/projects/cryptographic-module-validation-program/fips-140-2?utm_source=chatgpt.com "Cryptographic Module Validation Program | CSRC"
