# Hashing, MAC/HMAC, Password Security & Digital Signatures — Revision Notes

---

## PART 1: HASHING BASICS

### 1.1 What is a Hash Function?

**Definition:** A hash function takes input data of **any size** and produces a **fixed-size output**, called a **hash**, **hash value**, or **message digest**.

```
Input: Hello → Hash Function → Fixed-length Hash Value
```

> **Simple Definition:** Hashing converts data into a fixed-length digest. It is designed to be one-way (cannot be reversed back to original data).

### 1.2 Basic Hashing Flow

```
Original Data → Hash Function → Hash Value / Digest
```

Example:

```
File → SHA-256 → 256-bit Digest
```

- Even a tiny change in the input should give a very different hash.

### 1.3 Hashing is One-Way

```
Password → Hash Function → Hash
```

- You should **not** be able to reverse a hash back to the original password.
- This is different from **encryption**, which is reversible with a key.

### 1.4 Secure Hashing

A secure cryptographic hash function should make it **very hard** to:

- Recover the original input from the hash
- Find another input with the same hash
- Find two different inputs with the same hash

Modern secure families: **SHA-2, SHA-3**

---

## PART 2: IMPORTANT HASH PROPERTIES

| Property                       | Meaning                                                                       |
| ------------------------------ | ----------------------------------------------------------------------------- |
| **Deterministic**              | Same input always gives same hash (`Hash("hello")` = same result every time)  |
| **Fixed-Length Output**        | Input can be any size, but output size stays fixed (SHA-256 → always 256-bit) |
| **Preimage Resistance**        | Given a hash, it's hard to find the original input                            |
| **Second-Preimage Resistance** | Given message A, hard to find a different message B with the same hash        |
| **Collision Resistance**       | Hard to find **any** two different inputs with the same hash                  |
| **Avalanche Effect**           | Small input change → completely different hash output                         |

### Hash Collision

A collision = when `Input A ≠ Input B` but `Hash(A) = Hash(B)`.

- Since hash outputs are fixed-size but inputs are unlimited, collisions **must exist mathematically**.
- Goal: make finding a collision **computationally infeasible**.

### Why Collision Resistance Matters

Important for:

- Digital signatures
- Certificates
- Software integrity
- File verification

---

## PART 3: HASH ALGORITHMS

### 3.1 MD5

- **MD5 = Message Digest Algorithm 5**
- Output: **128-bit hash**
- **Not secure** — has serious, practical collision weaknesses.
- **Do not use** for: digital signatures, certificates, integrity checks, password storage.

> **Interview Point:** MD5 is obsolete for cryptographic security because practical collision attacks exist.

### 3.2 SHA Family

**SHA = Secure Hash Algorithm.** Includes SHA-1, SHA-2, SHA-3.

**SHA-1**

- Output: **160-bit hash**
- Was widely used, but **no longer secure** — practical collision attacks exist.
- Use SHA-2 or SHA-3 instead.

**SHA-2** (family): SHA-224, **SHA-256**, **SHA-384**, **SHA-512**

| Algorithm | Digest Size | Common Uses                                                                               |
| --------- | ----------- | ----------------------------------------------------------------------------------------- |
| SHA-256   | 256-bit     | File integrity, digital signatures, HMAC, certificates, software verification, blockchain |
| SHA-384   | 384-bit     | TLS, certificates, high-security digital signatures                                       |
| SHA-512   | 512-bit     | Digital signatures, HMAC, integrity verification                                          |

> **Important:** SHA-256 (and SHA family in general) is a hash function — it does **NOT encrypt data**.

### 3.3 MD5 vs SHA-1 vs SHA-2

| Algorithm | Digest Size | Current Status                         |
| --------- | ----------- | -------------------------------------- |
| MD5       | 128-bit     | Broken for collision security          |
| SHA-1     | 160-bit     | Deprecated for collision-sensitive use |
| SHA-256   | 256-bit     | Secure modern choice                   |
| SHA-384   | 384-bit     | Secure modern choice                   |
| SHA-512   | 512-bit     | Secure modern choice                   |

> **Easy Memory:** MD5 → Old and broken. SHA-1 → Old and deprecated. SHA-2 → Modern and widely used.

---

## PART 4: HASHING vs ENCRYPTION

| Hashing                                  | Encryption               |
| ---------------------------------------- | ------------------------ |
| One-way                                  | Reversible with a key    |
| No decryption process                    | Can be decrypted         |
| Usually no secret key                    | Uses a key               |
| Used for integrity/password verification | Used for confidentiality |
| Output = digest                          | Output = ciphertext      |
| Example: SHA-256                         | Example: AES             |

> **Easy Memory:** Hashing → One-way. Encryption → Two-way with key.

### Uses of Hashing

- File integrity checking
- Digital signatures
- Password verification
- HMAC
- Certificates
- Software checksums
- Malware identification
- Data deduplication
- Data fingerprinting

**Integrity Check Example:**

```
Downloaded File → SHA-256 → Compare with Official Hash
Same? → Yes: Likely intact | No: File changed/corrupted
```

> **Interview-Ready Answer (Hashing):** Hashing is a one-way process that converts data of any size into a fixed-size digest. Cryptographic hashes are used for integrity checking, digital signatures, HMAC, and password verification. Modern systems use SHA-256, SHA-384, or SHA-512; MD5 and SHA-1 are not recommended for collision-sensitive security.

---

## PART 5: MAC (MESSAGE AUTHENTICATION CODE)

### 5.1 What is MAC?

**MAC = Message Authentication Code.** A small authentication value calculated from:

```
Message + Secret Key → MAC
```

Provides: **Integrity** + **Message Authentication**

> **Simple Definition:** A MAC proves a message was not changed and was created by someone who knows the shared secret key.

### 5.2 MAC Workflow

```
Sender: Message + Secret Key → MAC Algorithm → MAC  ------> sent to Receiver
Receiver: Message + Same Secret Key → MAC Algorithm → Calculated MAC
Compare MACs → If match: Message likely authentic and unchanged
```

**Example:** Alice and Bob share Secret Key `K`.

- Alice sends: Message `"Transfer ₹1000"` + MAC `ABC123...`
- Bob recalculates MAC using the same key `K`.
- If `Received MAC = Calculated MAC` → message passes verification.

### 5.3 Secret-Key Requirement

MAC needs a secret key shared between both parties → this is **symmetric-key authentication**.

### 5.4 What MAC Provides / Does NOT Provide

**Provides:**

- Integrity (detects tampering)
- Authentication (proves sender knew the key)

**Does NOT provide:**

- Confidentiality by itself
- Public verification
- Strong non-repudiation (because both parties know the same key — either one could have generated the MAC)

### 5.5 MAC Limitations

- Shared secret key must be distributed securely
- Anyone with the key can generate valid MACs
- No public verification
- No digital-signature-style non-repudiation

### 5.6 MAC vs Digital Signature

| MAC                        | Digital Signature                            |
| -------------------------- | -------------------------------------------- |
| Shared secret key          | Public/private key pair                      |
| Symmetric                  | Asymmetric                                   |
| Both sides can create MAC  | Only private-key holder signs                |
| Integrity + authentication | Integrity + authentication + non-repudiation |
| Private verification       | Public-key verification                      |
| Faster                     | Generally slower                             |

> **Easy Memory:** MAC → Shared secret. Digital Signature → Private key signs.

---

## PART 6: HMAC, CMAC, GMAC

### 6.1 What is HMAC?

**HMAC = Hash-based Message Authentication Code.** Combines:

```
Hash Function + Secret Key
```

Example: **HMAC-SHA256** = HMAC using SHA-256 internally.

### 6.2 HMAC Workflow

```
Sender: Message + Secret Key → HMAC Algorithm → Authentication Tag
Receiver: Message + Same Secret Key → HMAC → Compare Tags
```

### 6.3 HMAC-SHA256 / HMAC-SHA512

- **HMAC-SHA256** = HMAC construction + SHA-256. Provides integrity + authentication.
  - Common uses: API authentication, webhooks, network protocols, cloud APIs, token/signature systems.
- **HMAC-SHA512** = HMAC + SHA-512. Same purpose, different underlying hash algorithm.

### 6.4 SHA vs HMAC

| SHA                  | HMAC                                       |
| -------------------- | ------------------------------------------ |
| Hash function        | Authentication construction                |
| No secret key        | Requires secret key                        |
| Integrity only       | Integrity + authentication                 |
| Anyone can calculate | Only key holders should compute valid HMAC |
| Example: SHA-256     | Example: HMAC-SHA256                       |

> **Easy Memory:** SHA → Hash only. HMAC → Hash + Secret Key.

### 6.5 CMAC

**CMAC = Cipher-based Message Authentication Code.** Uses a **block cipher** instead of a hash function.

- Example: **AES-CMAC**
- Provides integrity + authentication.

```
Message + Secret Key + AES → CMAC Tag
```

### 6.6 GMAC

**GMAC = Galois Message Authentication Code.** Based on the authentication mechanism used in **GCM**.

- Provides authentication and integrity **without** encrypting the message.

> **Important:** AES-GCM = Encryption + Authentication. GMAC = Authentication only.

### 6.7 HMAC vs CMAC vs GMAC

| Mechanism | Based On           | Provides                   |
| --------- | ------------------ | -------------------------- |
| HMAC      | Hash function      | Integrity + authentication |
| CMAC      | Block cipher       | Integrity + authentication |
| GMAC      | GCM authentication | Integrity + authentication |

> **Interview-Ready Answer (HMAC):** HMAC is a Message Authentication Code built using a cryptographic hash function and a secret key. It provides message integrity and authentication. HMAC-SHA256 uses SHA-256 together with a shared secret key.

---

## PART 7: PASSWORD SECURITY

### 7.1 Why Password Security Matters

Passwords are stored in databases. If a database is stolen:

```
Application Database → Attacker Breaches Database → Password Records Stolen
```

Poor storage = all accounts at risk.

### 7.2 What a Breach May Expose

- Usernames
- Email addresses
- Password hashes
- Salts
- Account data

Attackers may then try: dictionary attacks, brute-force attacks, credential stuffing, rainbow-table attacks (against badly stored hashes).

### 7.3 Never Store Passwords in Plaintext

**Bad:**

```
Username: alice
Password: Password123
```

If leaked → attacker knows the password instantly.

**Better:**

```
Password → Password Hashing Function → Stored Hash
```

### 7.4 Password Hashing & Login Flow

```
User enters password → Hash/Password KDF → Compare with stored value
Match? Yes → Allow | No → Deny
```

### 7.5 IMPORTANT: Plain SHA-256 is NOT Good for Password Storage

- Plain SHA-256 is **very fast** → attackers can try billions of guesses quickly.
- It is **not designed** specifically for password storage.

**Use dedicated password hashing/KDF algorithms instead:**

- **Argon2**
- **bcrypt**
- **scrypt**
- **PBKDF2**

These are **intentionally slow** to resist brute-force guessing.

### 7.6 What is a Salt?

A **salt** is a random value added to each password **before hashing**.

```
Password: hello123
Salt: X9F4A2
→ Password + Salt → Password Hash Function → Stored Hash
```

### 7.7 Why Salt is Needed

Without salt, identical passwords produce identical hashes:

```
User A: password123 → Same Hash
User B: password123 → Same Hash
```

Attacker instantly sees both users share the same password.

With different (unique) salts:

```
User A: password123 + SaltA → Hash A
User B: password123 + SaltB → Hash B
```

The stored hashes differ, even though the passwords are the same.

### 7.8 Salt Does Not Need to Be Secret

Salt is normally stored **alongside** the password hash (e.g., Username | Salt | Password Hash).
Its purpose is NOT secrecy — it is to:

- Make each password hash unique
- Defeat precomputed attacks
- Force attackers to crack each password separately

### 7.9 Rainbow Table Attack

A **Rainbow Table** = a precomputed set of password → hash mappings, used to reverse common hashes quickly.

```
password123 → Hash A
qwerty      → Hash B
admin       → Hash C
```

Attacker steals a hash database and looks up matches in the table.

**How Salt Defeats Rainbow Tables:**

```
Without salt: Password → Known Hash → Rainbow Table Lookup (fast)
With salt:    Password + Unique Salt → Different Hash → Precomputed table becomes useless
```

Attacker must now compute fresh for every unique salt.

### 7.10 Effect of Missing Salt

- Same passwords → same hashes
- Rainbow tables become effective
- Large-scale cracking becomes easier
- Attacker can see which users share passwords

Example: Alice and Bob both use `Password123` → both get `Hash XYZ` → attacker knows they match.

### 7.11 Secure Password Storage Flow

```
Password + Unique Random Salt → Argon2/bcrypt/scrypt/PBKDF2 → Stored Password Hash
```

Database typically stores: Username, Salt, Hash, Algorithm parameters.

### 7.12 Password Verification (Login)

```
Entered Password + Stored Salt → Same Hash Function → Calculated Hash → Compare Safely → Match?
```

- The original plaintext password does **not** need to be stored anywhere.

### 7.13 What is a Pepper?

A **pepper** is an **additional secret value** used with password hashing.

| Salt                   | Pepper                                                 |
| ---------------------- | ------------------------------------------------------ |
| Random per password    | Secret value (often same across app)                   |
| Not secret             | Must remain secret                                     |
| Stored with the hash   | Stored separately (e.g., in app config/secret manager) |
| Defeats precomputation | Adds another secret barrier                            |

```
Password + Salt + Secret Pepper → Password Hashing
```

Pepper is optional, an extra layer of defense.

### 7.14 SHA / HMAC in Password Security

- **Raw SHA-256/SHA-512 alone should NOT be used** for password storage — too fast.
- **HMAC is not a replacement** for a password hashing algorithm, but it can be part of a larger design (e.g., using a secret pepper via HMAC).
- For interviews: **always prefer a dedicated password KDF first** (Argon2/bcrypt/scrypt/PBKDF2).

### 7.15 Password Hash vs HMAC

| Password Hashing            | HMAC                   |
| --------------------------- | ---------------------- |
| Protects stored passwords   | Authenticates messages |
| Uses slow KDF               | Uses shared secret key |
| Salt required/recommended   | Secret key required    |
| Argon2/bcrypt/scrypt/PBKDF2 | HMAC-SHA256            |

### 7.16 Secure Password Storage — Best Practices

**Do:**

- Use Argon2, bcrypt, scrypt, or PBKDF2
- Use a unique random salt per password
- Use a strong work factor/cost setting
- Add MFA
- Encourage password managers
- Apply rate limiting
- Use breached-password detection where possible

**Avoid:**

- Plaintext storage
- MD5
- SHA-1
- Raw SHA-256 / Raw SHA-512
- Unsalted hashes

> **Interview-Ready Answer (Salt):** A salt is a unique random value added to a password before hashing. It does not need to be secret. Its purpose is to make identical passwords produce different stored hashes and to make rainbow-table and other precomputed attacks ineffective.

> **Interview-Ready Answer (Secure Password Storage):** Passwords should not be stored in plaintext or with fast hashes like plain SHA-256. Use a dedicated password hashing function such as Argon2, bcrypt, scrypt, or PBKDF2, with a unique random salt and an appropriate cost factor.

---

## PART 8: DIGITAL SIGNATURES

### 8.1 What is a Digital Signature?

A cryptographic mechanism, using **asymmetric cryptography**, that proves:

- Message integrity
- Signer authentication
- Non-repudiation (evidence of who signed)

> **Simple Definition:** A digital signature is created using a private key and verified using the matching public key.

### 8.2 Main Security Goals

| Goal                | Meaning                                                 |
| ------------------- | ------------------------------------------------------- |
| **Integrity**       | Shows the message was not changed                       |
| **Authentication**  | Shows the signature was made by the private-key holder  |
| **Non-Repudiation** | Evidence that the private-key holder signed the message |

> Note: real legal non-repudiation also depends on key protection, identity verification, policies, certificate trust, and audit evidence — not just the math.

### 8.3 Hash-Then-Sign

Digital signatures don't sign the whole large message directly. Instead:

```
Message → Hash → Message Digest → Sign Digest with Private Key → Digital Signature
```

This process is called **Hash-then-Sign**.

### 8.4 Signature Creation (Example)

Alice signs a document:

```
Document → SHA-256 → Hash → Alice's Private Key → Signature
```

Alice sends: `Document + Digital Signature`

### 8.5 Signature Verification (Example)

Bob receives `Document + Signature`.

```
Document → Hash → Digest A
Received Signature + Alice's Public Key → Signature Verification → Valid?
```

**Full Verification Flow:**

```
Received Document → Hash → Digest A
Received Signature + Alice Public Key → Signature Verification → Valid?
If Valid: Message unchanged AND signature matches Alice's public key
```

### 8.6 Key Roles

| Key             | Role     | Notes                                                                                         |
| --------------- | -------- | --------------------------------------------------------------------------------------------- |
| **Private Key** | Signs    | Must stay secret; if stolen, attacker can forge signatures                                    |
| **Public Key**  | Verifies | Can be shared openly; needs certificates/PKI to confirm it truly belongs to the claimed owner |

### 8.7 Digital Signature ≠ Encryption

- Signed message can still be **readable** (not hidden).
- Signature gives: Integrity, Authentication, Non-repudiation evidence.
- Encryption gives: Confidentiality.
- **Both can be combined:**

```
Message → Sign with Sender's Private Key → Encrypt for Receiver → Send
```

Result: Confidentiality + Integrity + Authentication together.

### 8.8 Digital Signature vs MAC

| Digital Signature            | MAC                            |
| ---------------------------- | ------------------------------ |
| Asymmetric                   | Symmetric                      |
| Private key signs            | Shared secret generates MAC    |
| Public key verifies          | Shared secret verifies         |
| Public verification possible | Only secret holders can verify |
| Supports non-repudiation     | No strong non-repudiation      |
| Slower                       | Faster                         |

> **Easy Memory:** Digital Signature → Private Key + Public Key. MAC → Shared Secret Key.

---

## PART 9: SIGNATURE ALGORITHMS

### 9.1 RSA Signatures

```
Message → Hash → RSA Signature (Private Key) → Signature
```

- Receiver verifies using the **Public Key**.
- Modern RSA signatures should use secure schemes like **RSA-PSS**, not raw RSA math.

### 9.2 DSA (Digital Signature Algorithm)

- Used **only** for signing/verification — **not encryption**.

```
Private Key → Sign
Public Key → Verify
```

### 9.3 ECDSA (Elliptic Curve Digital Signature Algorithm)

- Signature algorithm based on elliptic-curve cryptography.
- Advantages: smaller keys, good efficiency, strong security with proper curves, widely used in certificates and protocols.
- **Important requirement:** ECDSA needs a secure, unique random value during each signing. If this value is reused/predictable → the **private key can be exposed**. This is a well-known implementation risk.

### 9.4 EdDSA (Edwards-curve Digital Signature Algorithm)

- Modern signature family; examples: **Ed25519, Ed448**
- Advantages: fast, strong, reduces some implementation risks (like nonce reuse issues), good performance, widely used in modern systems.

### 9.5 ECDSA vs EdDSA

| ECDSA                              | EdDSA                                   |
| ---------------------------------- | --------------------------------------- |
| Elliptic-curve signature algorithm | Edwards-curve signature algorithm       |
| Common in PKI/TLS                  | Common in modern applications           |
| Sensitive to nonce mistakes        | Designed to avoid common nonce problems |
| Example curve: P-256               | Example: Ed25519                        |

### 9.6 RSA vs DSA vs ECDSA vs EdDSA

| Algorithm | Type           | Main Purpose            |
| --------- | -------------- | ----------------------- |
| RSA       | Public-key     | Encryption + Signatures |
| DSA       | Public-key     | Signatures only         |
| ECDSA     | Elliptic-curve | Signatures              |
| EdDSA     | Edwards-curve  | Signatures              |

---

## PART 10: DIGITAL SIGNATURE USE CASES & SCENARIOS

### 10.1 Common Use Cases

- Software signing
- Digital certificates
- PDF/document signing
- Code signing
- Email signing
- TLS certificates
- Package verification
- Firmware updates
- Secure boot

```
Software Package → Digital Signature → User verifies signature → Trusted publisher?
```

### 10.2 Scenario — Modified Software

```
Vendor signs: Software + Signature
Attacker modifies software
Verification of original signature → FAILS (hash changed)
```

### 10.3 Scenario — MAC vs Signature (When to Use Which)

| Situation                                                                       | Use                   |
| ------------------------------------------------------------------------------- | --------------------- |
| Two servers share a secret key, need fast message authentication                | **MAC / HMAC**        |
| Millions of users need to verify software authenticity without sharing a secret | **Digital Signature** |

### 10.4 Scenario — Password Database Leak

Database stores `SHA-256(password)` with **no salt**.
**Problem:** SHA-256 is fast; identical passwords → identical hashes; efficient dictionary attacks possible.
**Fix:**

```
Password + Unique Salt → Argon2/bcrypt/scrypt/PBKDF2
```

### 10.5 Scenario — HMAC API Authentication

```
Client + Server share Secret API Key
Client: Request + Secret Key → HMAC-SHA256 → sends tag
Server: recalculates HMAC
Match? → Request has integrity + sender likely knows the shared key
```

### 10.6 Scenario — Signed Document

```
Alice: Document → Hash → Sign with Alice's Private Key
Bob: Document + Signature → verify with Alice's Public Key
```

---

## PART 11: QUICK REVISION TABLE

| Topic             | Simple Meaning                                          |
| ----------------- | ------------------------------------------------------- |
| Hash Function     | One-way, fixed-length digest                            |
| MD5               | Old, collision-broken hash                              |
| SHA-1             | Deprecated for collision security                       |
| SHA-256           | 256-bit SHA-2 hash                                      |
| SHA-384           | 384-bit SHA-2 hash                                      |
| SHA-512           | 512-bit SHA-2 hash                                      |
| Collision         | Two different inputs → same hash                        |
| MAC               | Shared-key integrity + authentication                   |
| HMAC              | Hash + secret key                                       |
| HMAC-SHA256       | HMAC using SHA-256                                      |
| CMAC              | MAC based on block cipher                               |
| GMAC              | Authentication based on GCM                             |
| Salt              | Unique random value added to password (not secret)      |
| Pepper            | Additional secret value added to password (kept secret) |
| Rainbow Table     | Precomputed hash-cracking data                          |
| Digital Signature | Private key signs, public key verifies                  |
| RSA               | Encryption/signatures                                   |
| DSA               | Signatures only                                         |
| ECDSA             | Elliptic-curve signatures                               |
| EdDSA             | Modern Edwards-curve signatures                         |

---

## PART 12: BEST MEMORY DIAGRAMS

### Hashing

```
Data → SHA-256 → Hash
```

### HMAC

```
Data + Secret Key → HMAC-SHA256 → Integrity + Authentication
```

### Password Storage

```
Password + Unique Salt → Argon2/bcrypt/scrypt/PBKDF2 → Stored Password Hash
```

### Digital Signature — Signing

```
Message → Hash → Sign with Private Key → Signature
```

### Digital Signature — Verification

```
Message + Signature → Verify with Public Key → Valid / Invalid
```

---

## PART 13: MASTER INTERVIEW-READY ANSWERS

> **Hashing vs Encryption:** Hashing is a one-way process that creates a fixed-size digest and is mainly used for integrity/verification. Encryption is reversible using a cryptographic key and is mainly used for confidentiality.

> **SHA vs HMAC:** SHA is a hash function and needs no secret key — it gives a data fingerprint for integrity checking. HMAC combines a hash function with a secret key, giving both integrity and authentication.

> **MAC vs Digital Signature:** A MAC uses a shared secret key and provides integrity and authentication between parties that both know the secret. A digital signature uses a private key to sign and a public key to verify, enabling public verification and stronger non-repudiation.

> **Password Hashing:** Passwords should be stored using a slow, dedicated password hashing function such as Argon2, bcrypt, scrypt, or PBKDF2 with a unique random salt. Raw SHA-256 or SHA-512 alone should not be used — they are too fast and make brute-force attacks easier.

> **Digital Signature:** A digital signature is created by hashing a message and signing the digest with the sender's private key. The receiver verifies it using the sender's public key. It provides integrity, authentication, and evidence supporting non-repudiation.

### Final Master Line

> **Hashing gives a fingerprint, HMAC adds a secret key for authentication, password hashing uses slow salted functions, and digital signatures use a private key to sign and a public key to verify.**
