# PKI — Public Key Infrastructure

> **Topic:** CDAC DITISS — Security Fundamentals
> **Exam Tag:** PKI · X.509 · Certificate Authority · Digital Certificates

---

## Table of Contents

1. [What is PKI?](#1-what-is-pki)
2. [PKI — ISO Authentication Framework](#2-pki--iso-authentication-framework)
3. [PKI Components (Consists of)](#3-pki-components-consists-of)
4. [What PKI Provides (Services)](#4-what-pki-provides-services)
5. [PKI Entities](#5-pki-entities)
6. [X.509 Standard](#6-x509-standard)
7. [X.509 Certificate Fields](#7-x509-certificate-fields)
8. [Types of Certificates](#8-types-of-certificates)
9. [Certificate Lifecycle](#9-certificate-lifecycle)
10. [Viva Q&A](#10-viva-qa)

---

## 1. What is PKI?

**PKI (Public Key Infrastructure)** is a complete framework of policies, procedures, hardware, software, and standards that manages the creation, distribution, storage, and revocation of **digital certificates**.

It is the backbone of trust on the internet — used in HTTPS, email signing, VPNs, code signing, and digital documents.

```
PKI = People + Processes + Technology
       that make Public Key Cryptography usable at scale
```

---

## 2. PKI — ISO Authentication Framework

PKI is defined under the **ISO Authentication Framework** (ITU-T X.509).

| Property           | Detail                                                 |
| ------------------ | ------------------------------------------------------ |
| Standard           | X.509 (ITU-T / ISO/IEC 9594-8)                         |
| Cryptography used  | Public Key Cryptography (Asymmetric)                   |
| Key algorithm      | RSA / ECC / DSA                                        |
| Certificate format | X.509 v3                                               |
| Purpose            | Provide a trusted way to bind identity to a public key |

> **Core idea:** Anyone can have a public key — but PKI proves that a specific public key actually belongs to a specific person, server, or organization.

---

## 3. PKI Components (Consists of)

PKI is not just software — it is a complete system made up of:

### 3.1 Programs

Software used to:

- Generate key pairs
- Create and sign certificates
- Validate and revoke certificates

Examples: XCA, OpenSSL, Microsoft CA, Let's Encrypt

---

### 3.2 Data Formats

Standardized file formats for certificates and keys:

| Format  | Extension              | Contents                           |
| ------- | ---------------------- | ---------------------------------- |
| PEM     | `.pem`, `.crt`, `.cer` | Base64-encoded certificate or key  |
| DER     | `.der`, `.cer`         | Binary-encoded certificate         |
| PKCS#12 | `.pfx`, `.p12`         | Certificate + Private Key + Chain  |
| PKCS#10 | `.csr`                 | Certificate Signing Request        |
| PKCS#7  | `.p7b`                 | Certificate chain (no private key) |

---

### 3.3 Procedures

Defined processes that govern:

- How certificates are issued
- How identities are verified before issuing
- How certificates are renewed and revoked
- How private keys are stored and protected

---

### 3.4 Communication Protocols

Protocols that use PKI:

| Protocol  | Use                                                             |
| --------- | --------------------------------------------------------------- |
| TLS / SSL | HTTPS secure web browsing                                       |
| S/MIME    | Secure email (signing + encryption)                             |
| IPSec     | VPN authentication                                              |
| SSH       | Secure remote login                                             |
| OCSP      | Online Certificate Status Protocol — real-time revocation check |
| LDAP      | Certificate repository access                                   |

---

### 3.5 Security Policies

Documents that define the rules of the PKI:

| Policy                                 | Purpose                                     |
| -------------------------------------- | ------------------------------------------- |
| CP (Certificate Policy)                | What the certificate can be used for        |
| CPS (Certification Practice Statement) | How the CA operates and issues certificates |

---

### 3.6 Public Key Cryptography Mechanisms

Core cryptographic operations PKI relies on:

| Mechanism           | Purpose                                            |
| ------------------- | -------------------------------------------------- |
| Key pair generation | Create public + private key pair                   |
| Digital signature   | Sign data with private key; verify with public key |
| Key encapsulation   | Encrypt symmetric key with public key              |
| Hash functions      | SHA-256, SHA-384 — ensure integrity                |

---

## 4. What PKI Provides (Services)

PKI provides **five core security services**:

### 4.1 Authentication

Proves identity using certificates.

**Example:**
When you visit `https://www.sbi.co.in`, your browser verifies the server's certificate to confirm it is actually SBI and not an attacker.

---

### 4.2 Confidentiality

Encrypts data so only the intended recipient can read it.

**Example:**
Your browser uses the server's **public key** (from its certificate) to encrypt a session key. Only the server's **private key** can decrypt it. All HTTPS traffic is then encrypted with that session key.

---

### 4.3 Access Control

Only entities with valid certificates are allowed access to a resource.

**Example:**
A VPN server only allows connections from clients whose certificates are signed by the company's internal CA. Employees without a valid cert are denied.

---

### 4.4 Non-Repudiation

Proves that a specific entity performed an action and cannot deny it later.

**Example:**
Tinku digitally signs a contract PDF using his private key. Even if Tinku later claims "I never signed that", the signature — verifiable only with his public key — proves he did.

---

### 4.5 Integrity

Ensures data has not been modified in transit or after signing.

**Example:**
A software vendor signs a `.exe` file. When you download and install it, Windows verifies the signature. If even one byte was changed (malware injection), the hash fails and Windows warns you.

---

## 5. PKI Entities

PKI is made up of the following entities:

### 5.1 Certificate Authority (CA)

The **trusted third party** that:

- Issues digital certificates
- Signs certificates with its private key
- Maintains the Certificate Revocation List (CRL)

```
Root CA
   └── Sub CA (Intermediate CA)
              └── End-user / Server certificates
```

**Examples:** DigiCert, Let's Encrypt, Comodo, VeriSign, internal corporate CAs

---

### 5.2 Registration Authority (RA)

An entity that:

- Handles **identity verification** on behalf of the CA
- Accepts and validates CSRs (Certificate Signing Requests)
- Forwards approved requests to the CA for signing

> RA does **not** sign certificates — that is the CA's job.
> RA is the "front desk"; CA is the "vault".

**Example:** A bank employee who verifies your ID before your digital certificate is issued by the bank's CA.

---

### 5.3 Certificates

The digital document that:

- Binds an **identity** to a **public key**
- Is signed by a CA
- Contains validity period, key usage, and subject details

---

### 5.4 Certificate Repository (Database)

A **publicly accessible directory** where:

- Issued certificates are stored
- Users/systems can look up a certificate to verify it

**Examples:**

- LDAP directory
- HTTP-based certificate store
- Windows Certificate Store (`certmgr.msc`)

---

### 5.5 Certificate Revocation System

A mechanism to **cancel** (revoke) certificates before their expiry date.

**Reasons for revocation:**

- Private key was compromised
- Employee left the organization
- Certificate was issued by mistake

**Two revocation methods:**

| Method | Full Form                          | How it works                                                    |
| ------ | ---------------------------------- | --------------------------------------------------------------- |
| CRL    | Certificate Revocation List        | CA publishes a list of revoked cert serial numbers periodically |
| OCSP   | Online Certificate Status Protocol | Real-time check — query CA to verify if cert is still valid     |

---

### 5.6 Keys

| Key             | Purpose                                                     |
| --------------- | ----------------------------------------------------------- |
| **Private Key** | Kept secret by owner; used to sign and decrypt              |
| **Public Key**  | Shared freely; used to verify and encrypt                   |
| **Session Key** | Temporary symmetric key (AES) used for bulk data encryption |

---

### 5.7 Timestamps

A **Timestamp Authority (TSA)** records the exact date and time a document was signed.

**Why it matters:**

- Proves a signature was created **before** a certificate expired
- Prevents backdating of signatures
- Required for long-term signature validity (e.g., legal contracts, code signing)

---

### 5.8 Client-Side Software

Software on the user's machine that:

- Manages certificates and keys
- Performs signature operations
- Validates certificate chains

**Examples:**

| Software                       | Use                                 |
| ------------------------------ | ----------------------------------- |
| Web browser (Chrome, Firefox)  | Validates HTTPS certificates        |
| Microsoft Word / Adobe Acrobat | Signs documents using certificates  |
| Email client (Outlook)         | S/MIME email signing                |
| `certmgr.msc`                  | Windows Certificate Store manager   |
| XCA / OpenSSL                  | Certificate creation and management |

---

### 5.9 Users

The **end entities** who:

- Are issued certificates
- Use certificates to authenticate, sign, and encrypt

**Examples:** Employees, servers, routers, IoT devices, code signing accounts

---

## 6. X.509 Standard

**X.509** is the ITU-T standard that defines the format of **public key certificates**.

- Defined in **RFC 5280**
- Currently at **version 3** (X.509 v3)
- Used in TLS, S/MIME, IPSec, code signing, document signing

```
X.509 v3 Certificate
├── Version
├── Serial Number
├── Signature Algorithm
├── Issuer
├── Validity (Not Before / Not After)
├── Subject
├── Subject Public Key Info
│       ├── Algorithm
│       └── Public Key
└── Extensions (v3 only)
        ├── Key Usage
        ├── Basic Constraints
        ├── Subject Alternative Name (SAN)
        └── CRL Distribution Points
```

---

## 7. X.509 Certificate Fields

| Field                              | Description                                  | Example                               |
| ---------------------------------- | -------------------------------------------- | ------------------------------------- |
| **Version**                        | X.509 version (v1, v2, v3)                   | `v3`                                  |
| **Serial Number**                  | Unique number assigned by CA to each cert    | `3A:F2:11:...`                        |
| **Signature Algorithm**            | Algorithm used by CA to sign the cert        | `sha256WithRSAEncryption`             |
| **Issuer**                         | CA that issued and signed this cert          | `CN=RootCA, O=ABC Pvt Ltd`            |
| **Validity — Not Before**          | Start date of certificate validity           | `2024-01-01`                          |
| **Validity — Not After**           | Expiry date of certificate                   | `2025-01-01`                          |
| **Subject**                        | Identity of the certificate owner            | `CN=Tinku, O=ABC, C=IN`               |
| **Subject Public Key Info**        | Owner's public key + algorithm               | `RSA 2048-bit public key`             |
| **Key Usage**                      | Allowed cryptographic operations             | `Digital Signature, Key Encipherment` |
| **Basic Constraints**              | Is this a CA cert? Can it sign others?       | `CA:TRUE` or `CA:FALSE`               |
| **Subject Alternative Name (SAN)** | Additional identities (domains, IPs, emails) | `DNS:www.abc.com`                     |
| **CRL Distribution Points**        | Where to download the revocation list        | `http://crl.abc.com/crl.crl`          |
| **Authority Key Identifier**       | Identifies which CA key signed this cert     | Key ID of issuing CA                  |
| **Subject Key Identifier**         | Identifies this cert's public key            | Hash of the public key                |
| **Certificate Signature**          | CA's digital signature over all above fields | Binary signature bytes                |

---

## 8. Types of Certificates

### 8.1 User Certificate

| Property               | Detail                                    |
| ---------------------- | ----------------------------------------- |
| **Issued to**          | Individual person (employee, customer)    |
| **Key Usage**          | Digital Signature, Email Encryption       |
| **Extended Key Usage** | Email Protection, Client Authentication   |
| **Signed by**          | Sub CA or Root CA                         |
| **Used for**           | Signing Word/PDF, S/MIME email, VPN login |

**Example subject:**

```
CN = Tinku
O  = ABC Pvt Ltd
OU = Employees
C  = IN
```

---

### 8.2 Server Certificate (SSL/TLS Certificate)

| Property               | Detail                                             |
| ---------------------- | -------------------------------------------------- |
| **Issued to**          | Web server, application server                     |
| **Key Usage**          | Key Encipherment, Digital Signature                |
| **Extended Key Usage** | Server Authentication (1.3.6.1.5.5.7.3.1)          |
| **SAN field**          | DNS names and IP addresses of the server           |
| **Signed by**          | Public CA (DigiCert, Let's Encrypt) or internal CA |
| **Used for**           | HTTPS, secure API endpoints, TLS for services      |

**Example subject:**

```
CN = www.abc.com
O  = ABC Pvt Ltd
SAN = DNS:www.abc.com, DNS:abc.com, IP:192.168.1.1
```

> **Note:** Modern TLS ignores the CN field for hostname validation — it uses **SAN** only.

---

### 8.3 Code Signing Certificate

| Property               | Detail                                               |
| ---------------------- | ---------------------------------------------------- |
| **Issued to**          | Software developer, organization                     |
| **Key Usage**          | Digital Signature                                    |
| **Extended Key Usage** | Code Signing (1.3.6.1.5.5.7.3.3)                     |
| **Signed by**          | Trusted public CA (DigiCert, Sectigo)                |
| **Used for**           | Signing `.exe`, `.dll`, `.apk`, `.jar`, `.ps1` files |

**How it works:**

```
Developer signs .exe with private key
         │
         ▼
User downloads .exe
         │
         ▼
Windows verifies signature using developer's public key (from cert)
         │
    ┌────┴────┐
    ▼         ▼
 Valid       Invalid / Unsigned
"Verified   "Unknown Publisher"
 Publisher"  (SmartScreen warning)
```

**Levels of code signing:**

| Type                        | Verification level               | SmartScreen trust           |
| --------------------------- | -------------------------------- | --------------------------- |
| OV (Organization Validated) | Company identity verified        | Builds reputation over time |
| EV (Extended Validation)    | Strict — hardware token required | Immediate SmartScreen trust |

---

### 8.4 Self-Signed Certificate

| Property               | Detail                                                         |
| ---------------------- | -------------------------------------------------------------- |
| **Issued by**          | The certificate owner itself                                   |
| **Issuer = Subject**   | Both fields are the same entity                                |
| **Signed by**          | Own private key (no external CA)                               |
| **Trusted by default** | No — must be manually imported into trust store                |
| **Used for**           | Internal labs, Root CA, development/testing, internal services |

**How it differs from CA-signed:**

```
CA-Signed Certificate:
  Subject: www.abc.com
  Issuer:  DigiCert Inc        ← Different (trusted CA)

Self-Signed Certificate:
  Subject: RootCA
  Issuer:  RootCA              ← Same entity
```

**When self-signed is valid / used:**

| Use Case                   | Reason                                   |
| -------------------------- | ---------------------------------------- |
| Root CA certificate        | No higher authority exists above Root CA |
| Internal dev/test HTTPS    | No need to pay for a public CA cert      |
| Lab environments (XCA lab) | Building PKI from scratch                |
| Internal services          | Only internal clients need to trust it   |

**Browser behaviour with self-signed certs:**

```
Browser sees self-signed cert → Not in trusted store
         │
         ▼
Shows: "Your connection is not private"
       NET::ERR_CERT_AUTHORITY_INVALID
         │
         ▼
Fix: Manually import the cert into browser/OS trust store
```

---

## 9. Certificate Lifecycle

```
Key Generation
      │
      ▼
CSR Creation (public key + identity)
      │
      ▼
CA Verifies Identity (via RA)
      │
      ▼
CA Signs Certificate
      │
      ▼
Certificate Issued and Stored in Repository
      │
      ▼
Certificate Used (HTTPS / Signing / Auth)
      │
      ▼
      ├── Expires naturally → Renew
      │
      └── Revoked early → Added to CRL / OCSP marks invalid
```

---

## 10. Viva Q&A

**Q1. What is PKI?**
PKI is a framework of programs, policies, procedures, data formats, protocols, and cryptographic mechanisms used to manage digital certificates and public key cryptography.

---

**Q2. What are the five services PKI provides?**
Authentication, Confidentiality, Access Control, Non-Repudiation, Integrity.

---

**Q3. What is the difference between CA and RA?**
CA (Certificate Authority) signs and issues certificates. RA (Registration Authority) verifies the applicant's identity and forwards approved requests to the CA. RA cannot sign certificates.

---

**Q4. What is X.509?**
X.509 is the ITU-T standard (RFC 5280) that defines the format of public key certificates. It is currently at version 3 and is used in TLS, S/MIME, IPSec, and PKI systems worldwide.

---

**Q5. What is the difference between CRL and OCSP?**

|           | CRL                    | OCSP                      |
| --------- | ---------------------- | ------------------------- |
| Type      | Periodic list download | Real-time query           |
| Speed     | Slower (cached)        | Faster (live)             |
| Bandwidth | Higher (full list)     | Lower (single cert check) |
| Latency   | Low (cached locally)   | Adds network round trip   |

---

**Q6. What is a self-signed certificate and when is it used?**
A self-signed certificate is signed by its own private key — the issuer and subject are the same. It is used for Root CAs (no authority above them), internal labs, and testing environments where public CA trust is not needed.

---

**Q7. What is the difference between a User Certificate and a Server Certificate?**

|           | User Certificate      | Server Certificate      |
| --------- | --------------------- | ----------------------- |
| Issued to | Person                | Server / Domain         |
| Key Usage | Digital Signature     | Key Encipherment        |
| EKU       | Client Auth, Email    | Server Auth             |
| Used for  | Sign docs, email, VPN | HTTPS, TLS              |
| SAN       | Email address         | DNS names, IP addresses |

---

**Q8. What is a Code Signing Certificate?**
A certificate with Extended Key Usage = Code Signing. Developers use their private key to sign software. Windows verifies the signature using the developer's public key to confirm the software is authentic and untampered.

---

**Q9. What does Basic Constraints CA:TRUE mean?**
It means the certificate belongs to a Certificate Authority and is allowed to sign other certificates. End-user certificates have CA:FALSE — they cannot issue certificates.

---

**Q10. Why is the SAN field important in server certificates?**
Modern browsers use the Subject Alternative Name (SAN) field — not the CN — for hostname validation. A server cert without a SAN will fail validation in Chrome, Firefox, and modern OS trust stores.

---

## Quick Reference

```
PKI Framework
├── Components: Programs · Data Formats · Procedures · Protocols · Policies · Crypto
├── Services:   Auth · Confidentiality · Access Control · Non-Repudiation · Integrity
├── Entities:   CA · RA · Certs · Repository · Revocation · Keys · TSA · Software · Users
└── Standard:   X.509 v3 (RFC 5280)

Certificate Types
├── User Cert        → Digital Signature · Client Auth · email
├── Server Cert      → Key Encipherment · Server Auth · SAN = domain/IP
├── Code Signing     → Digital Signature · Code Signing EKU
└── Self-Signed      → Issuer = Subject · Root CA · Labs · Internal use

Revocation
├── CRL  → Periodic list · Downloaded · Cached
└── OCSP → Real-time query · Single cert check
```
