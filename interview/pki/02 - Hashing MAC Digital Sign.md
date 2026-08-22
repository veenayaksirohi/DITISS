# 10. Hashing — Detailed Notes

## 1. What is a Hash Function?

A **hash function** takes input data of any size and produces a fixed-size output called a:

> **Hash**, **hash value**, or **message digest**

Example:

```text
Input:
Hello

      ↓
Hash Function

Output:
Fixed-length hash value
```

### Simple Definition

> **Hashing converts data into a fixed-length digest. It is designed to be one-way.**

---

## 2. Basic Hashing Flow

```text
Original Data
     ↓
Hash Function
     ↓
Hash Value / Digest
```

Example:

```text
File
 ↓
SHA-256
 ↓
256-bit Digest
```

If even one small part of the file changes, the hash should change significantly.

---

## 3. Hashing is One-Way

Hashing is not designed to be reversed.

```text
Password
   ↓
Hash Function
   ↓
Hash
```

You should not normally be able to do:

```text
Hash
 ↓
Reverse
 ↓
Original Password
```

This is different from encryption.

---

# 4. Secure Hashing

A **secure cryptographic hash function** should make it computationally difficult to:

- Recover the original input from the hash
- Find another input with the same hash
- Find two different inputs that produce the same hash

Modern secure hash families include:

- SHA-2
- SHA-3

---

# 5. Important Hash Properties

A secure hash function should have several properties.

## Deterministic

The same input always produces the same hash.

```text
Hash("hello")
=
Same result every time
```

---

## Fixed-Length Output

Input size may vary:

```text
1 byte
100 MB
10 GB
```

but the hash output size remains fixed for a given algorithm.

Example:

```text
SHA-256
→ Always 256-bit output
```

---

## Preimage Resistance

Given:

```text
Hash = H
```

it should be very difficult to find the original input.

### Easy Meaning

> Given a hash, finding the original message should be difficult.

---

## Second-Preimage Resistance

Given one message:

```text
Message A
```

it should be difficult to find another different message:

```text
Message B
```

such that:

```text
Hash(A) = Hash(B)
```

---

## Collision Resistance

It should be difficult to find **any two different inputs** that produce the same hash.

```text
Message A ≠ Message B

but

Hash(A) = Hash(B)
```

This is called a **collision**.

---

## Avalanche Effect

A very small input change should produce a very different hash.

Example:

```text
Input 1:
Hello

Input 2:
hello
```

The resulting hashes should look completely different.

---

# 6. What is a Hash Collision?

A collision happens when:

```text
Input A ≠ Input B
```

but:

```text
Hash(Input A)
=
Hash(Input B)
```

Because hash outputs have a fixed size while possible inputs are unlimited, collisions must mathematically exist.

The goal is:

> Make collisions computationally infeasible to find.

---

# 7. Collision Resistance

Collision resistance means:

> It should be extremely difficult to intentionally find two different inputs with the same hash.

This property is important for:

- Digital signatures
- Certificates
- Software integrity
- File verification

---

# 8. MD5

**MD5** stands for:

> **Message Digest Algorithm 5**

MD5 produces:

```text
128-bit hash
```

Example:

```text
Message
   ↓
MD5
   ↓
128-bit digest
```

---

# 9. Is MD5 Secure?

No.

MD5 has serious collision weaknesses.

Therefore, MD5 should not be used for modern security-sensitive purposes such as:

- Digital signatures
- Certificates
- Secure integrity verification
- Password storage

### Interview Point

> **MD5 is obsolete for cryptographic security because practical collision attacks exist.**

---

# 10. SHA Family

**SHA** stands for:

> **Secure Hash Algorithm**

The SHA family includes:

- SHA-1
- SHA-2
- SHA-3

---

# 11. SHA-1

SHA-1 produces:

```text
160-bit hash
```

It was widely used historically.

However:

> SHA-1 is no longer considered secure for collision-resistant cryptographic use.

Practical collision attacks have been demonstrated.

So modern systems should prefer SHA-2 or SHA-3.

---

# 12. SHA-2

**SHA-2** is a family of secure hash algorithms.

Important members include:

- SHA-224
- SHA-256
- SHA-384
- SHA-512

For interviews, focus mainly on:

```text
SHA-256
SHA-384
SHA-512
```

---

# 13. SHA-256

SHA-256 produces a:

```text
256-bit hash
```

Common uses:

- File integrity
- Digital signatures
- HMAC
- Certificates
- Software verification
- Blockchain systems

### Important

SHA-256 is a hash function.

It does **not encrypt data**.

---

# 14. SHA-384

SHA-384 produces:

```text
384-bit hash
```

It belongs to SHA-2.

It provides a larger digest than SHA-256.

It is often used in:

- TLS
- Certificates
- Digital signatures
- High-security environments

---

# 15. SHA-512

SHA-512 produces:

```text
512-bit hash
```

It is also part of SHA-2.

Common uses include:

- Digital signatures
- HMAC
- Integrity verification

---

# 16. MD5 vs SHA-1 vs SHA-2

| Algorithm | Digest Size | Current Status                              |
| --------- | ----------: | ------------------------------------------- |
| MD5       |     128-bit | Broken for collision security               |
| SHA-1     |     160-bit | Deprecated for collision-sensitive security |
| SHA-256   |     256-bit | Secure modern choice                        |
| SHA-384   |     384-bit | Secure modern choice                        |
| SHA-512   |     512-bit | Secure modern choice                        |

### Easy Memory

```text
MD5
→ Old and broken

SHA-1
→ Old and deprecated

SHA-2
→ Modern and widely used
```

---

# 17. Hashing vs Encryption

Very important interview question.

| Hashing                                  | Encryption               |
| ---------------------------------------- | ------------------------ |
| One-way                                  | Reversible with key      |
| No decryption process                    | Can be decrypted         |
| Usually no secret key                    | Uses key                 |
| Used for integrity/password verification | Used for confidentiality |
| Output = digest                          | Output = ciphertext      |
| Example: SHA-256                         | Example: AES             |

### Easy Memory

```text
Hashing
→ One-way

Encryption
→ Two-way with key
```

---

# 18. Uses of Hashing

Hashing is used for:

- File integrity checking
- Digital signatures
- Password verification
- HMAC
- Certificates
- Software checksums
- Malware identification
- Deduplication
- Data fingerprinting

Example:

```text
Downloaded File
      ↓
SHA-256
      ↓
Compare with Official Hash
      ↓
Same?
 /       \
Yes       No
↓          ↓
Likely   File changed/
intact   corrupted
```

---

# 19. Interview-Ready Answer — Hashing

> **Hashing is a one-way process that converts data of any size into a fixed-size digest. Cryptographic hashes are used for integrity checking, digital signatures, HMAC, and password verification. Modern systems commonly use SHA-256, SHA-384, or SHA-512, while MD5 and SHA-1 are not recommended for collision-sensitive security.**

---

# 11. MAC & HMAC

## 20. What is MAC?

**MAC** stands for:

> **Message Authentication Code**

A MAC is a small authentication value calculated from:

```text
Message
+
Secret Key
```

It provides:

- Integrity
- Message authentication

---

# 21. Simple MAC Definition

> **A MAC proves that a message was not changed and was created by someone who knows the shared secret key.**

---

# 22. MAC Workflow

Sender and receiver share a secret key.

```text
Sender                         Receiver

Message                        Message
  +                              +
Secret Key                    Same Secret Key
  ↓                              ↓
MAC Algorithm                MAC Algorithm
  ↓                              ↓
MAC  ---------------------> Calculated MAC
                              ↓
                        Compare MACs
```

If both values match:

```text
Message likely authentic
and unchanged
```

---

# 23. MAC Example

Alice and Bob share:

```text
Secret Key = K
```

Alice sends:

```text
Message:
"Transfer ₹1000"

MAC:
ABC123...
```

Bob calculates the MAC again using the same key.

```text
Received Message
      +
Secret Key K
      ↓
Calculate MAC
```

If:

```text
Received MAC
=
Calculated MAC
```

the message passes verification.

---

# 24. Secret-Key Requirement

A MAC requires a secret key shared between both parties.

```text
Alice
   ↕
Shared Secret Key
   ↕
Bob
```

This means MAC uses:

> **Symmetric-key authentication**

---

# 25. What Does MAC Provide?

MAC provides:

### Integrity

Detects message modification.

### Authentication

Shows that the sender knew the shared secret key.

---

# 26. What MAC Does Not Provide

A normal MAC does not provide:

- Confidentiality by itself
- Public verification
- Strong non-repudiation

Why?

Because both parties know the same secret key.

Either one could have generated the MAC.

---

# 27. MAC Limitations

Main limitations:

- Shared secret key must be distributed securely
- Anyone knowing the key can generate valid MACs
- Does not provide public verification
- Does not provide digital-signature-style non-repudiation

---

# 28. MAC vs Digital Signature

| MAC                        | Digital Signature                                    |
| -------------------------- | ---------------------------------------------------- |
| Shared secret key          | Public/private key pair                              |
| Symmetric                  | Asymmetric                                           |
| Both sides can create MAC  | Only private-key holder signs                        |
| Integrity + authentication | Integrity + authentication + non-repudiation concept |
| Private verification       | Public-key verification                              |
| Faster                     | Generally slower                                     |

### Easy Memory

```text
MAC
→ Shared secret

Digital Signature
→ Private key signs
```

---

# 29. What is HMAC?

**HMAC** stands for:

> **Hash-based Message Authentication Code**

HMAC combines:

```text
Hash Function
+
Secret Key
```

Example:

```text
HMAC-SHA256
```

means:

> HMAC using SHA-256 internally.

---

# 30. HMAC Workflow

```text
Message
   +
Secret Key
   ↓
HMAC Algorithm
   ↓
Authentication Tag
```

Receiver:

```text
Message
   +
Same Secret Key
   ↓
HMAC
   ↓
Compare Tags
```

---

# 31. HMAC-SHA256

HMAC-SHA256 uses:

```text
HMAC construction
+
SHA-256
```

It provides:

- Integrity
- Authentication

It is widely used in:

- API authentication
- Webhooks
- Network protocols
- Cloud APIs
- Token/signature systems

---

# 32. HMAC-SHA512

HMAC-SHA512 uses:

```text
HMAC
+
SHA-512
```

It also provides:

- Integrity
- Authentication

The main difference is the underlying hash algorithm.

---

# 33. SHA vs HMAC

This is very important.

### SHA

Uses:

```text
Message
   ↓
Hash
```

No secret key required.

Provides:

> Integrity fingerprint only.

### HMAC

Uses:

```text
Message
+
Secret Key
   ↓
HMAC
```

Provides:

- Integrity
- Authentication

---

# 34. SHA vs HMAC Table

| SHA                  | HMAC                                         |
| -------------------- | -------------------------------------------- |
| Hash function        | Authentication construction                  |
| No secret key        | Requires secret key                          |
| Integrity only       | Integrity + authentication                   |
| Anyone can calculate | Only key holders should calculate valid HMAC |
| Example: SHA-256     | Example: HMAC-SHA256                         |

### Easy Memory

```text
SHA
→ Hash only

HMAC
→ Hash + Secret Key
```

---

# 35. CMAC

**CMAC** stands for:

> **Cipher-based Message Authentication Code**

CMAC uses a block cipher instead of a hash function.

A common example:

```text
AES-CMAC
```

It provides:

- Integrity
- Authentication

Concept:

```text
Message
+
Secret Key
+
AES
   ↓
CMAC Tag
```

---

# 36. GMAC

**GMAC** stands for:

> **Galois Message Authentication Code**

GMAC is based on the authentication mechanism used in **GCM**.

It provides authentication and integrity without encrypting the message itself.

### Important

```text
AES-GCM
→ Encryption + Authentication

GMAC
→ Authentication only
```

---

# 37. HMAC vs CMAC vs GMAC

| Mechanism | Based On           | Provides                   |
| --------- | ------------------ | -------------------------- |
| HMAC      | Hash function      | Integrity + authentication |
| CMAC      | Block cipher       | Integrity + authentication |
| GMAC      | GCM authentication | Integrity + authentication |

Examples:

```text
HMAC-SHA256
AES-CMAC
GMAC
```

---

# 38. Interview-Ready Answer — HMAC

> **HMAC is a Message Authentication Code built using a cryptographic hash function and a secret key. It provides message integrity and authentication. For example, HMAC-SHA256 uses SHA-256 together with a shared secret key.**

---

# 12. Password Security

## 39. Why Password Security Matters

Passwords are often stored in databases.

If the database is stolen, attackers may try to recover user passwords.

Example:

```text
Application Database
       ↓
Attacker Breaches Database
       ↓
Password Records Stolen
```

If passwords are stored insecurely, all accounts may be compromised.

---

# 40. Password Database Breach

A breach may expose:

- Usernames
- Email addresses
- Password hashes
- Salts
- Account data

Attackers may then perform:

- Dictionary attacks
- Brute-force attacks
- Credential stuffing
- Rainbow-table attacks against badly stored hashes

---

# 41. Never Store Passwords in Plaintext

Bad:

```text
Username: alice
Password: Password123
```

If database leaks:

```text
Attacker immediately knows password
```

Better:

```text
Password
   ↓
Password Hashing Function
   ↓
Stored Hash
```

---

# 42. Password Hashing

Password hashing transforms a password into a stored value.

At login:

```text
User enters password
       ↓
Hash / Password KDF
       ↓
Compare with stored value
       ↓
Match?
 /       \
Yes       No
↓          ↓
Allow     Deny
```

---

# 43. Important: SHA-256 Alone is Not Good Password Storage

This is a major interview point.

Plain SHA-256 is:

- Very fast
- Easy for attackers to calculate billions of guesses
- Not designed specifically for password storage

For passwords, use dedicated password hashing/KDF algorithms such as:

- Argon2
- bcrypt
- scrypt
- PBKDF2

These are intentionally slower.

---

# 44. What is a Salt?

A **salt** is a random value added to each password before hashing.

Example:

```text
Password:
hello123

Salt:
X9F4A2
```

Then:

```text
Password + Salt
      ↓
Password Hash Function
      ↓
Stored Hash
```

---

# 45. Why Salt is Needed

Suppose two users have the same password:

```text
User A:
password123

User B:
password123
```

Without salt:

```text
Same Password
    ↓
Same Hash
```

An attacker can immediately see they use the same password.

With different salts:

```text
User A:
password123 + SaltA
→ Hash A

User B:
password123 + SaltB
→ Hash B
```

The stored hashes are different.

---

# 46. Salt Does Not Need to Be Secret

A salt is normally stored beside the password hash.

Example:

```text
Username
Salt
Password Hash
```

The purpose of salt is not secrecy.

Its purpose is:

- Make each password hash unique
- Defeat precomputed attacks
- Make attackers crack each password separately

---

# 47. Rainbow Table Attack

A **Rainbow Table** is a precomputed collection used to map common password hashes back to likely passwords.

Example concept:

```text
password123
→ Hash A

qwerty
→ Hash B

admin
→ Hash C
```

Attacker steals a database and searches the table for matching hashes.

---

# 48. How Salt Defeats Rainbow Tables

Without salt:

```text
Password
   ↓
Known Hash
   ↓
Rainbow Table Lookup
```

With random salt:

```text
Password + Unique Salt
        ↓
Different Hash
        ↓
Precomputed table becomes far less useful
```

The attacker must perform new computations for each salt.

---

# 49. Effect of Missing Salt

Without salt:

- Same passwords produce same hashes
- Rainbow tables become more useful
- Large-scale cracking becomes easier
- Attackers can identify users sharing passwords

Example:

```text
Alice → Password123 → Hash XYZ

Bob   → Password123 → Hash XYZ
```

Attacker immediately knows:

> Both accounts use the same password.

---

# 50. Secure Password Storage

Recommended conceptual flow:

```text
Password
   +
Unique Random Salt
   ↓
Argon2 / bcrypt / scrypt / PBKDF2
   ↓
Stored Password Hash
```

Database may contain:

```text
Username
Salt
Hash
Algorithm parameters
```

---

# 51. Password Verification

During login:

```text
Entered Password
      +
Stored Salt
      ↓
Same Password Hash Function
      ↓
Calculated Hash
      ↓
Compare Safely
      ↓
Match?
```

The original password does not need to be stored.

---

# 52. What is a Pepper?

A **pepper** is an additional secret value that can be used with password hashing.

Unlike a salt:

```text
Salt
→ Public/non-secret
→ Stored with hash
```

Pepper:

```text
Pepper
→ Secret
→ Stored separately
```

Example:

```text
Password
+
Salt
+
Secret Pepper
   ↓
Password Hashing
```

A pepper is an optional additional control.

---

# 53. Salt vs Pepper

| Salt                   | Pepper                      |
| ---------------------- | --------------------------- |
| Random per password    | Secret value                |
| Not secret             | Must remain secret          |
| Stored with hash       | Stored separately           |
| Defeats precomputation | Adds another secret barrier |

---

# 54. SHA in Password Security

SHA functions are cryptographic hashes, but:

> **Raw SHA-256 or SHA-512 should not normally be used alone for password storage.**

Why?

Because they are too fast.

Attackers benefit from fast password guessing.

Better:

```text
Argon2
bcrypt
scrypt
PBKDF2
```

---

# 55. HMAC in Password Security

HMAC is not normally a replacement for a password hashing algorithm.

However, HMAC can sometimes be used as part of a larger password-storage design, such as when using a secret **pepper**.

Conceptually:

```text
Password
+
Salt
+
Secret Server Key
      ↓
Secure Password Storage Design
```

But for interviews:

> Use a dedicated password hashing/KDF algorithm first.

---

# 56. Password Hash vs HMAC

| Password Hashing            | HMAC                   |
| --------------------------- | ---------------------- |
| Protects stored passwords   | Authenticates messages |
| Uses slow KDF               | Uses shared secret key |
| Salt required/recommended   | Secret key required    |
| Argon2/bcrypt/scrypt/PBKDF2 | HMAC-SHA256            |

---

# 57. Secure Password Storage Best Practices

Use:

- Argon2 where appropriate
- bcrypt
- scrypt
- PBKDF2
- Unique random salt per password
- Strong work factor/cost
- MFA
- Password managers
- Rate limiting
- Breached-password detection where appropriate

Avoid:

```text
Plaintext
MD5
SHA-1
Raw SHA-256
Raw SHA-512
Unsalted hashes
```

for password storage.

---

# 58. Interview-Ready Answer — Salt

> **A salt is a unique random value added to a password before hashing. It does not need to be secret. Its purpose is to ensure that identical passwords generate different stored hashes and to make rainbow-table and other precomputed attacks ineffective.**

---

# 59. Interview-Ready Answer — Secure Password Storage

> **Passwords should not be stored in plaintext or with fast hashes such as plain SHA-256. They should be processed using a dedicated password hashing function such as Argon2, bcrypt, scrypt, or PBKDF2 with a unique random salt and an appropriate cost factor.**

---

# 13. Digital Signatures

## 60. What is a Digital Signature?

A **digital signature** is a cryptographic mechanism used to prove:

- Message integrity
- Signer authentication
- Non-repudiation concept

It uses **asymmetric cryptography**.

### Simple Definition

> **A digital signature is created using a private key and verified using the matching public key.**

---

# 61. Main Security Goals of Digital Signatures

A digital signature provides:

### Integrity

Shows that the message was not changed.

### Authentication

Shows that the signature was created by the holder of the private key.

### Non-Repudiation

Provides evidence that the private-key holder signed the message.

However, real legal non-repudiation also depends on:

- Key protection
- Identity verification
- Policies
- Certificate trust
- Audit evidence

---

# 62. Hash-Then-Sign

Digital signatures usually do not directly sign a large message byte-by-byte.

Instead:

```text
Message
   ↓
Hash
   ↓
Message Digest
   ↓
Sign Digest with Private Key
   ↓
Digital Signature
```

This is called:

> **Hash-then-Sign**

---

# 63. Signature Creation

Suppose Alice wants to sign a document.

```text
Document
   ↓
SHA-256
   ↓
Hash
   ↓
Alice's Private Key
   ↓
Signature
```

Alice sends:

```text
Document
+
Digital Signature
```

---

# 64. Signature Verification

Bob receives:

```text
Document
+
Signature
```

Bob:

```text
Document
   ↓
Hash
   ↓
Hash A
```

Then verifies the signature using:

```text
Alice's Public Key
```

The verification algorithm checks whether the signature is valid for that message and public key.

---

# 65. Complete Verification Flow

```text
Received Document
      ↓
Hash Document
      ↓
Digest A

Received Signature
      +
Alice Public Key
      ↓
Signature Verification
      ↓
Valid?
```

If valid:

```text
Message unchanged
+
Signature matches Alice's public key
```

---

# 66. Private Key Signing

The private key is used to create the signature.

```text
Private Key
    ↓
Sign
```

The private key must remain secret.

If stolen:

```text
Attacker
   ↓
Can create fraudulent signatures
```

So private-key protection is critical.

---

# 67. Public Key Verification

The public key is used to verify the signature.

```text
Public Key
    ↓
Verify
```

The public key can be distributed openly.

But users still need confidence that the public key really belongs to the expected person or organization.

That is where:

> Certificates and PKI

become important.

---

# 68. Digital Signature Does Not Encrypt the Message

Important:

```text
Digital Signature
≠ Encryption
```

A signed message can still be readable.

Signature provides:

```text
Integrity
Authentication
Non-repudiation evidence
```

Encryption provides:

```text
Confidentiality
```

You can use both together.

---

# 69. Encryption + Digital Signature

Example:

```text
Message
   ↓
Sign with Sender Private Key
   ↓
Encrypt for Receiver
   ↓
Send
```

This can provide:

- Confidentiality
- Integrity
- Authentication

---

# 70. Digital Signature vs MAC

| Digital Signature                | MAC                         |
| -------------------------------- | --------------------------- |
| Asymmetric                       | Symmetric                   |
| Private key signs                | Shared secret generates MAC |
| Public key verifies              | Shared secret verifies      |
| Public verification possible     | Only secret holders verify  |
| Supports non-repudiation concept | No strong non-repudiation   |
| Slower                           | Faster                      |

### Easy Memory

```text
Digital Signature
→ Private Key + Public Key

MAC
→ Shared Secret Key
```

---

# 71. RSA Signatures

RSA can be used for digital signatures.

Conceptually:

```text
Message
   ↓
Hash
   ↓
RSA Signature using Private Key
   ↓
Signature
```

Receiver verifies using:

```text
Public Key
```

Modern RSA signatures should use proper secure signature schemes such as:

> RSA-PSS

rather than treating RSA as a simple raw mathematical operation.

---

# 72. DSA

**DSA** stands for:

> **Digital Signature Algorithm**

DSA is designed for:

- Digital signing
- Signature verification

It is **not an encryption algorithm**.

### Flow

```text
Private Key
   ↓
Sign

Public Key
   ↓
Verify
```

---

# 73. ECDSA

**ECDSA** stands for:

> **Elliptic Curve Digital Signature Algorithm**

It is a digital-signature algorithm based on elliptic-curve cryptography.

Advantages include:

- Smaller keys
- Good efficiency
- Strong security with proper curves
- Common use in certificates and modern protocols

---

# 74. Important ECDSA Requirement

ECDSA requires a secure random/unique value during signing.

If this value is reused or predictable, the private key may be exposed.

This is a famous implementation issue.

So:

> Good randomness and correct implementation are critical.

---

# 75. EdDSA

**EdDSA** stands for:

> **Edwards-curve Digital Signature Algorithm**

It is a modern digital-signature family.

Common examples:

- Ed25519
- Ed448

Advantages:

- Fast
- Strong
- Designed to reduce some implementation risks
- Good performance
- Widely used in modern systems

---

# 76. ECDSA vs EdDSA

| ECDSA                              | EdDSA                                                   |
| ---------------------------------- | ------------------------------------------------------- |
| Elliptic-curve signature algorithm | Edwards-curve signature algorithm                       |
| Common in PKI/TLS                  | Common in modern applications                           |
| Sensitive to nonce mistakes        | Designed to avoid some common nonce-generation problems |
| Example curves: P-256              | Example: Ed25519                                        |

---

# 77. RSA vs DSA vs ECDSA vs EdDSA

| Algorithm | Type           | Main Purpose            |
| --------- | -------------- | ----------------------- |
| RSA       | Public-key     | Encryption + signatures |
| DSA       | Public-key     | Signatures              |
| ECDSA     | Elliptic-curve | Signatures              |
| EdDSA     | Edwards-curve  | Signatures              |

---

# 78. Digital Signature Use Cases

Digital signatures are used in:

- Software signing
- Digital certificates
- PDF/document signing
- Code signing
- Email signing
- TLS certificates
- Package verification
- Firmware updates
- Secure boot

Example:

```text
Software Package
      ↓
Digital Signature
      ↓
User verifies signature
      ↓
Trusted publisher?
```

---

# 79. Scenario — Modified Software

A vendor signs software.

```text
Software
   +
Signature
```

An attacker modifies the software.

Now:

```text
Original Signature
      ↓
Verification
      ↓
Fails
```

because the message hash changed.

---

# 80. Scenario — MAC vs Signature

Two servers share a secret key and need fast message authentication.

Use:

> **MAC / HMAC**

A software company wants millions of users to verify software authenticity without sharing a secret.

Use:

> **Digital Signature**

---

# 81. Scenario — Password Database Leak

Database contains:

```text
SHA-256(password)
```

with no salt.

Problem:

- SHA-256 is very fast
- Same passwords create same hashes
- Attackers can perform efficient dictionary attacks

Better:

```text
Password
+
Unique Salt
   ↓
Argon2 / bcrypt / scrypt / PBKDF2
```

---

# 82. Scenario — HMAC API Authentication

Client and server share:

```text
Secret API Key
```

Client computes:

```text
Request
+
Secret Key
   ↓
HMAC-SHA256
```

Server calculates the same HMAC.

If they match:

```text
Request has integrity
+
Sender likely knows the shared key
```

---

# 83. Scenario — Signed Document

Alice wants Bob to verify a document came from her.

Alice:

```text
Document
   ↓
Hash
   ↓
Sign with Alice Private Key
```

Bob:

```text
Document + Signature
       ↓
Alice Public Key
       ↓
Verify
```

---

# 84. Most Important Interview Questions

1. What is hashing?
2. Is hashing reversible?
3. What are the properties of a secure hash?
4. What is preimage resistance?
5. What is collision resistance?
6. What is MD5?
7. Why is MD5 insecure?
8. What is SHA?
9. SHA-1 vs SHA-2?
10. What is SHA-256?
11. Hashing vs encryption?
12. What is MAC?
13. What does MAC provide?
14. Why does MAC require a secret key?
15. MAC vs digital signature?
16. What is HMAC?
17. What is HMAC-SHA256?
18. SHA vs HMAC?
19. What is CMAC?
20. What is GMAC?
21. Why should passwords be hashed?
22. What is a salt?
23. Does a salt need to be secret?
24. What is a rainbow-table attack?
25. Why are unsalted hashes dangerous?
26. Why is SHA-256 alone bad for password storage?
27. Which algorithms should be used for password storage?
28. What is a digital signature?
29. What does a digital signature provide?
30. What is hash-then-sign?
31. Which key signs?
32. Which key verifies?
33. Digital signature vs encryption?
34. Digital signature vs MAC?
35. What is RSA signature?
36. What is DSA?
37. What is ECDSA?
38. What is EdDSA?
39. Why is private-key protection important?
40. How are digital signatures used in code signing?

---

# 85. Interview-Ready Answer — Hashing vs Encryption

> **Hashing is a one-way process that creates a fixed-size digest and is mainly used for integrity and verification. Encryption is reversible using a cryptographic key and is mainly used to provide confidentiality.**

---

# 86. Interview-Ready Answer — SHA vs HMAC

> **SHA is a hash function and does not require a secret key. It provides a data fingerprint for integrity checking. HMAC combines a hash function with a secret key, so it provides both integrity and authentication.**

---

# 87. Interview-Ready Answer — MAC vs Digital Signature

> **A MAC uses a shared secret key and provides integrity and authentication between parties that know the secret. A digital signature uses a private key for signing and a public key for verification, allowing public verification and stronger non-repudiation properties.**

---

# 88. Interview-Ready Answer — Password Hashing

> **Passwords should be stored using a slow, dedicated password hashing function such as Argon2, bcrypt, scrypt, or PBKDF2 with a unique random salt. Raw SHA-256 or SHA-512 should not normally be used alone because they are too fast and make brute-force attacks easier.**

---

# 89. Interview-Ready Answer — Digital Signature

> **A digital signature is created by hashing a message and signing the result with the sender's private key. The receiver verifies it using the sender's public key. It provides integrity, authentication, and evidence supporting non-repudiation.**

---

# 90. Quick Revision Table

| Topic             | Simple Meaning                         |
| ----------------- | -------------------------------------- |
| Hash Function     | One-way fixed-length digest            |
| MD5               | Old, collision-broken hash             |
| SHA-1             | Deprecated for collision security      |
| SHA-256           | 256-bit SHA-2 hash                     |
| SHA-384           | 384-bit SHA-2 hash                     |
| SHA-512           | 512-bit SHA-2 hash                     |
| Collision         | Two different inputs → same hash       |
| MAC               | Shared-key integrity + authentication  |
| HMAC              | Hash + secret key                      |
| HMAC-SHA256       | HMAC using SHA-256                     |
| CMAC              | MAC based on block cipher              |
| GMAC              | Authentication based on GCM            |
| Salt              | Unique random value added to password  |
| Rainbow Table     | Precomputed hash-cracking data         |
| Digital Signature | Private key signs, public key verifies |
| RSA               | Encryption/signatures                  |
| DSA               | Signatures only                        |
| ECDSA             | Elliptic-curve signatures              |
| EdDSA             | Modern Edwards-curve signatures        |

---

# 91. Best Memory Diagrams

## Hashing

```text
Data
 ↓
SHA-256
 ↓
Hash
```

## HMAC

```text
Data
+
Secret Key
 ↓
HMAC-SHA256
 ↓
Integrity + Authentication
```

## Password Storage

```text
Password
+
Unique Salt
 ↓
Argon2 / bcrypt / scrypt / PBKDF2
 ↓
Stored Password Hash
```

## Digital Signature

```text
SIGNING

Message
  ↓
Hash
  ↓
Private Key
  ↓
Signature
```

```text
VERIFICATION

Message + Signature
       ↓
Public Key
       ↓
Valid / Invalid
```

### Best interview memory line

> **Hashing provides a fingerprint, HMAC adds a secret key for authentication, password hashing uses slow salted functions, and digital signatures use a private key to sign and a public key to verify.**
