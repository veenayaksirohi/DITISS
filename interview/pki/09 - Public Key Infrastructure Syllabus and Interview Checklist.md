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

| Concept | Key Point |
|---|---|
| Encryption | Reversible, confidentiality |
| Hashing | One-way, integrity |
| Digital Signature | Hash + private key encryption → authenticity + integrity + non-repudiation |
| Digital Certificate | Binds public key to identity, issued by CA |
| CRL vs OCSP | CRL = periodic list; OCSP = real-time status check |

## 📌 Practical Lab Reference (from syllabus)

- Root CA + Sub CA hierarchy built with OpenSSL (`rtca.pgditiss.local`, `sbca.pgditiss.local`)
- HTTPS website secured via Sub-CA-issued cert (`www.pgditiss.local`)
- Digital signing of Word/PDF documents using XCA-created certificates
- Digitally signing & encrypting email via Thunderbird/Outlook

---

## Related Notes
- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
- [[08 - Cyber Forensics Syllabus and Interview Checklist]]
