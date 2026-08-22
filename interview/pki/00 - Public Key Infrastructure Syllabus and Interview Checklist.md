---
title: "09 - Public Key Infrastructure Syllabus and Interview Checklist"
aliases:
  - "Public Key Infrastructure — CDAC DITISS Syllabus"
tags:
  - pki
  - cryptography
  - tls
  - digital-signature
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

# Public Key Infrastructure — Interview Checklist

**Duration:** 60 hrs (30T + 20L + 10SL) | **CCEE Module**
**Courseware:** Cryptography & Network Security: Principles and Practices (Stallings)

---

## Completion Checklist

- [ ] Symmetric vs Asymmetric encryption
- [ ] Diffie-Hellman key exchange
- [ ] Secure hashing (SHA, HMAC)
- [ ] Digital Signature & Digital Certificate
- [ ] CA / Trust Model / Revocation
- [ ] PKCS standards, FIPS 140-2
- [ ] Aadhaar e-Sign, timestamping
- [ ] Strong authentication, SSO, OAuth/OpenID
- [ ] SSL/TLS, PGP/S-MIME
- [ ] IT Act, LDAP/AD, Blockchain intro

---

## 🔴 Priority 1 — Must Know

- [ ] Symmetric vs Asymmetric encryption — DES/AES/RC5 vs RSA/ECC
- [ ] Diffie-Hellman key exchange
- [ ] Hashing — SHA, HMAC, salting (vs encryption)
- [ ] Digital Signature vs Digital Certificate
- [ ] CA / Trust Model / Certificate issuance / Revocation (CRL, OCSP)
- [ ] SSL vs TLS, PGP vs S/MIME

## 🟠 Priority 2 — Important

- [ ] PKCS standards, FIPS 140-2
- [ ] MFA / SSO / OAuth vs OpenID vs traditional auth
- [ ] Hierarchical Trust Model (Root CA → Sub CA) — practical OpenSSL setup
- [ ] Aadhaar e-Sign ecosystem, timestamping services

## 🟡 Priority 3 — Good to Know

- [ ] FIDO Authentication, Zero Trust Architecture
- [ ] LDAP/Active Directory role in PKI
- [ ] Blockchain introduction
- [ ] IT Act relevance to digital signatures

---

## 📌 Interview Quick Reference

| Concept             | Key Point                                                                  |
| ------------------- | -------------------------------------------------------------------------- |
| Encryption          | Reversible, confidentiality                                                |
| Hashing             | One-way, integrity                                                         |
| Digital Signature   | Hash + private key encryption → authenticity + integrity + non-repudiation |
| Digital Certificate | Binds public key to identity, issued by CA                                 |
| CRL vs OCSP         | CRL = periodic list; OCSP = real-time status check                         |

## 📌 Practical Lab Reference (from syllabus)

- Root CA + Sub CA hierarchy built with OpenSSL (`rtca.pgditiss.local`, `sbca.pgditiss.local`)
- HTTPS website secured via Sub-CA-issued cert (`www.pgditiss.local`)
- Digital signing of Word/PDF documents using XCA-created certificates
- Digitally signing & encrypting email via Thunderbird/Outlook

---

## Related Notes

- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
- [[08 - Cyber Forensics Syllabus and Interview Checklist]]

## 6. Symmetric Key Cryptography

- Symmetric Key Model
- Key Distribution Problem
- Key Scalability
- Advantages / Disadvantages
- Block vs Stream Ciphers
- DES
- Triple DES
- AES
- IDEA
- Symmetric Encryption Use Cases

## 7. Asymmetric / Public-Key Cryptography

- Public Key
- Private Key
- Key Pair
- Advantages / Disadvantages
- RSA
- ECC
- DSA
- Public-Key Encryption
- Signing / Verification
- Asymmetric Encryption Use Cases
- Symmetric vs Asymmetric Comparison

## 8. Diffie-Hellman Key Exchange

- Diffie-Hellman
- Shared Secret
- Secure Key Agreement
- Why Diffie-Hellman Is Needed
- Diffie-Hellman vs Encryption
- Diffie-Hellman and MITM Risk
- Authenticated Key Exchange

## 9. Cryptographic Attacks & Implementation Issues

- Man-in-the-Middle (MITM)
- Brute-Force Attack
- Dictionary Attack
- Birthday Attack
- Side-Channel Attack
- Replay Attack
- Known Plaintext Attack
- Chosen Ciphertext Attack
- Weak / Deprecated Algorithms
- Weak Randomness
- Poor Key Management
- Implementation Flaws
- Protocol-Level Attacks
- Configuration Issues
- Common Cryptographic Mistakes

## 10. Hashing

- Hash Function
- Secure Hashing
- MD5
- SHA Family
- SHA-1
- SHA-2
- SHA-256
- SHA-384
- SHA-512
- Hash Properties
- Collision Resistance
- Hashing vs Encryption
- Uses of Hashing

## 11. MAC & HMAC

- Message Authentication Code (MAC)
- MAC Workflow
- Secret-Key Requirement
- Integrity + Authentication
- MAC Limitations
- MAC vs Digital Signature
- HMAC
- HMAC-SHA256
- HMAC-SHA512
- CMAC
- GMAC
- SHA vs HMAC

## 12. Password Security

- Password Database Breaches
- Password Hashing
- Salt
- Rainbow Table Attacks
- Effect of Missing Salt
- Secure Password Storage
- SHA / HMAC in Password Security

## 13. Digital Signatures

- Digital Signature
- Integrity
- Authentication
- Non-repudiation
- Hash-then-Sign
- Private Key Signing
- Public Key Verification
- Signature Creation
- Signature Verification
- Digital Signature vs MAC
- RSA Signatures
- DSA
- ECDSA
- EdDSA

## 14. PKI Fundamentals

- Public Key Infrastructure (PKI)
- PKI Purpose
- PKI as People + Processes + Technology
- ISO / ITU-T X.509 Authentication Framework

### PKI Security Services

- Authentication
- Confidentiality
- Access Control
- Non-repudiation
- Integrity

### PKI Components

- PKI Programs
- PKI Procedures
- PKI Communication Protocols
- PKI Cryptographic Mechanisms
- Key Lifecycle Management

### PKI Security Policies

- Certificate Policy (CP)
- Certification Practice Statement (CPS)

## 15. PKI Entities

- Certificate Authority (CA)
- Registration Authority (RA)
- Digital Certificates
- Certificate Repository
- Certificate Management System
- Certificate Revocation System
- Private Key
- Public Key
- Session Key
- Timestamp Authority (TSA)
- Client-Side Certificate Software
- End Users / End Entities
- HSM
- Smart Card
- Key Stores

## 16. Certificate Authority & Chain of Trust

- Root CA
- Intermediate / Subordinate CA
- End-Entity Certificate
- Self-Signed Root Certificate
- Hierarchical Trust Model
- Mesh Trust Model
- Bridge CA Model
- Browser Trust Store
- Certificate Chain Verification
- Proof of Possession

## 17. CSR & Certificate Issuance Process

- Key Pair Generation
- Certificate Signing Request (CSR)
- PKCS #10
- CSR Contents
- CSR Signature
- Proof of Possession
- RA Identity Verification
- CA Signing
- Certificate Issuance
- Certificate Installation
- Certificate Publication
- Renewal
- Expiration

## 18. X.509 Digital Certificates

- X.509 Standard
- X.509 v3

### X.509 Certificate Fields

- Version
- Serial Number
- Signature Algorithm
- Issuer
- Validity
- Subject
- Subject Public Key Info
- Key Usage
- Extended Key Usage
- Basic Constraints
- Subject Alternative Name (SAN)
- CRL Distribution Points
- Authority Key Identifier
- Subject Key Identifier
- Certificate Signature

## 19. Certificate Types, Classes & Formats

### Certificate Types

- User Certificate
- Server / SSL-TLS Certificate
- Code Signing Certificate
- Self-Signed Certificate

### Certificate Validation Types

- DV
- OV
- EV

### Digital Signature Certificate Classes

- Indian DSC Classes

### Certificate / Key Formats

- PEM
- DER
- PKCS #7 / `.p7b`
- PKCS #12 / `.pfx` / `.p12`

## 20. Certificate Lifecycle & Revocation

- Certificate Lifecycle
- Revocation Reasons
- Certificate Revocation List (CRL)
- Online Certificate Status Protocol (OCSP)
- CRL vs OCSP
- OCSP Stapling
- Renewal
- Expiration
- Revocation Status Checking

## 21. PKI Standards

### PKCS Family

- PKCS #1
- PKCS #3
- PKCS #5
- PKCS #7
- PKCS #8
- PKCS #10
- PKCS #11
- PKCS #12

### FIPS

- FIPS 140-2
- FIPS 140-2 Security Levels
- Cryptographic Module Validation

## 22. Authentication Fundamentals

- Strong Authentication
- Single-Factor Authentication
- Multi-Factor Authentication

### Authentication Factors

- Something You Know
- Something You Have
- Something You Are

### Other Authentication Concepts

- Graphical Passwords
- MFA Security Impact

## 23. SSO, OpenID, OAuth & OIDC

- Single Sign-On (SSO)
- Identity Provider (IdP)
- Service Provider (SP)
- SAML
- Token-Based SSO
- OpenID
- OAuth
- OpenID Connect (OIDC)
- Authentication vs Authorization
- OpenID vs OAuth vs Traditional Authentication

## 24. Authentication Protocols

- Kerberos
- Key Distribution Center (KDC)
- Tickets
- RADIUS
- TACACS+
- RADIUS vs TACACS+
- FIDO / FIDO2
- WebAuthn
- CTAP
- Passkeys
- Passwordless Authentication
- Phishing-Resistant Authentication

## 25. Zero Trust Architecture

- Zero Trust
- Never Trust, Always Verify
- Continuous Verification
- Least Privilege
- Per-Request Authorization
- Identity-Based Access
- Device-Based Access
- Context-Based Access

## 26. SSL, TLS & HTTPS

- SSL
- TLS
- SSL vs TLS
- TLS Handshake
- Server Authentication
- Certificate Verification
- Session Key Establishment
- Symmetric Data Encryption
- HTTPS
- TLS Certificates
- Improper TLS Configuration
- MITM Risk
- Apache HTTPS
- DNS / Name Resolution
- Website PKI

## 27. Secure Email

- Email Security
- PGP
- S/MIME
- PGP Web of Trust
- S/MIME CA-Based Trust
- Email Encryption
- Email Digital Signature
- PGP vs S/MIME
- Thunderbird
- Windows Mail
- Outlook

## 28. Blockchain Fundamentals

- Blockchain
- Distributed Ledger
- Structure of a Block
- Hash Chaining
- Merkle Root
- Integrity / Immutability
- Public-Key Cryptography in Blockchain
- Consensus
- Proof of Work (PoW)
- Proof of Stake (PoS)
- Types of Blockchains
