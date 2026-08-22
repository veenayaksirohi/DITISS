# Cryptography Revision Notes (Simple Language)

---

## PART 1: SYMMETRIC KEY CRYPTOGRAPHY

### 1.1 What is Symmetric Key Cryptography?

**Definition:** Symmetric cryptography uses **one single secret key** for both encrypting and decrypting data. Both sides must have the same key.

```
Plaintext → Encrypt (Key K) → Ciphertext → Decrypt (Same Key K) → Plaintext
```

**Example:** Alice and Bob both already have key `K`.
```
Alice: Plaintext → Encrypt with K → Ciphertext → sent to → Bob: Decrypt with K → Plaintext
```

- If the key `K` is stolen, the attacker can read everything encrypted with it. So keeping the key safe is very important.

### 1.2 Main Security Goal

- Symmetric encryption mainly gives **Confidentiality** (keeps data secret from unauthorized people).
- Modern modes like **AES-GCM** also give **Integrity** and **Authentication** (this is called Authenticated Encryption).

### 1.3 Key Distribution Problem

**Problem:** How do Alice and Bob safely share the same secret key over an unsafe network like the Internet?

```
Alice → sends Key → Internet → Attacker steals key → Bob   (BAD! Compromised)
```

**Solutions:**
- Pre-shared keys
- Physical/manual exchange
- Key management systems
- Public-key cryptography
- Key exchange protocols (e.g., Diffie-Hellman)

```
Asymmetric Crypto → Securely set up Session Key → Symmetric Encryption → Encrypt bulk data
```
This mix of both is called **Hybrid Encryption** (see Part 2, Section 6).

### 1.4 Key Scalability Problem

If every pair of users needs a separate key, the number of keys grows very fast.

**Formula:** `Number of keys = n(n-1) / 2` (n = number of users)

| Users | Keys Needed |
|---|---|
| 4 | 6 |
| 100 | 4,950 |

Managing thousands of keys becomes hard.

### 1.5 Advantages & Disadvantages

| Advantages | Disadvantages |
|---|---|
| Fast and efficient (low CPU/memory) | Hard to distribute the key safely |
| Good for large data (files, VPN, disk, DB) | Key management gets complex at scale |
| Strong security with modern algorithms (AES) | If key is stolen, all data using it is at risk |
| | No built-in identity verification like signatures |

> **Interview-Ready Answer:** Symmetric encryption uses the same secret key for both encryption and decryption. It is fast, so it is used for bulk data like VPN traffic, disk encryption, and network sessions. Its biggest challenge is securely sharing and managing the key.

---

## PART 2: BLOCK CIPHER vs STREAM CIPHER

### 2.1 Block Cipher
- Encrypts data in **fixed-size blocks**.
- Example: AES uses **128-bit blocks**.
```
Plaintext: [Block1][Block2][Block3] → Encrypt → [Cipher1][Cipher2][Cipher3]
```
- Examples: **AES, DES, 3DES, IDEA**

### 2.2 Stream Cipher
- Encrypts data **continuously**, bit by bit or byte by byte.
```
Plaintext Stream + Key Stream → Encryption → Ciphertext Stream
```
- Modern example: **ChaCha20**
- Old/insecure example: **RC4**

### 2.3 Comparison Table

| Block Cipher | Stream Cipher |
|---|---|
| Encrypts fixed-size blocks | Encrypts continuous stream |
| Uses "modes of operation" | Uses a keystream |
| Good for files/storage/network | Good for streaming data |
| Example: AES | Example: ChaCha20 |
| Sometimes needs padding | Usually no padding needed |

### 2.4 Block Cipher Modes
- A block cipher needs a **mode of operation** to handle data bigger than one block.
- Common modes: **CBC, CTR, GCM**
- **AES-GCM** is very important — it is an **AEAD** (Authenticated Encryption with Associated Data) mode.
```
AES-GCM = Encryption + Integrity + Authentication (all together)
```

---

## PART 3: SYMMETRIC ALGORITHMS (DES, 3DES, AES, IDEA)

### 3.1 DES (Data Encryption Standard)
- Block size: **64 bits**
- Effective key size: **56 bits**
- **Insecure today** — 56-bit key can be brute-forced easily by modern computers. **Do not use.**

### 3.2 3DES (Triple DES)
- Runs DES three times: `Plaintext → DES → DES → DES → Ciphertext`
- Made to strengthen DES without replacing old systems immediately.
- **Limitations:** slower than AES, small 64-bit blocks, now considered **legacy/deprecated**.

### 3.3 AES (Advanced Encryption Standard)
- The modern standard — replaced DES.
- **Key sizes:** 128, 192, or 256 bits (AES-128, AES-192, AES-256)
- **Block size:** always **128 bits** (does not change with key size)
- **Why popular:** strong, fast, hardware-accelerated, used everywhere (VPN, disk encryption, TLS, Wi-Fi, databases, cloud).

### 3.4 IDEA
- Key size: **128 bits**, Block size: **64 bits**
- Historically used in old PGP versions. Rarely used today; AES is preferred.

### 3.5 DES vs 3DES vs AES

| Feature | DES | 3DES | AES |
|---|---|---|---|
| Key | 56-bit effective | Larger than DES | 128/192/256-bit |
| Block Size | 64-bit | 64-bit | 128-bit |
| Speed | Legacy | Slow | Fast |
| Security | Insecure | Legacy | **Recommended** |
| Use Today | Avoid | Avoid for new systems | Widely used |

> **Interview-Ready Answer:** AES (Advanced Encryption Standard) is a modern symmetric block cipher with a 128-bit block size, supporting 128/192/256-bit keys. It is used everywhere — VPNs, disk encryption, TLS, and general data protection.

---

## PART 4: SYMMETRIC ENCRYPTION USE CASES

| Use Case | How Symmetric Crypto Helps |
|---|---|
| VPN Traffic | AES encrypts network traffic |
| Disk Encryption | Full disk encryption uses symmetric algorithms |
| File Encryption | AES encrypts files |
| Database Encryption | Protects stored sensitive data |
| TLS Session Data | Bulk data uses fast symmetric encryption after handshake |
| Wi-Fi Security | Symmetric crypto protects wireless traffic |

---

## PART 5: ASYMMETRIC (PUBLIC-KEY) CRYPTOGRAPHY

### 5.1 What is Asymmetric Cryptography?
- Uses **two related keys**: a **Public Key** and a **Private Key** (together called a **Key Pair**).

```
        Key Pair
       /        \
  Public Key   Private Key
```

- Public key can be shared with anyone.
- Private key must stay secret.
- With correct key sizes, it should be practically impossible to calculate the private key from the public key.

### 5.2 Public Key vs Private Key

| Public Key | Private Key |
|---|---|
| Can be freely shared | Must stay secret |
| Encrypts data / verifies signatures | Decrypts data / creates signatures |
| Example: Bob shares his public key | Example: Bob's private key stays hidden |

> If a private key gets stolen, that whole key pair becomes unsafe.

### 5.3 Public-Key Encryption Flow

Alice sends secret data to Bob (Bob has `Bob_Public` and `Bob_Private`):

```
Alice: Plaintext → Encrypt with Bob's PUBLIC Key → Ciphertext → Bob: Decrypt with his PRIVATE Key → Plaintext
```

**Rule:**
```
Public Key  → Encrypt
Private Key → Decrypt
```
(This applies to encryption-capable systems like RSA.)

### 5.4 Why This Solves Key Distribution
- Alice never needs Bob's private key — only his public key, which is meant to be public.
- This solves the symmetric key-sharing problem.

### 5.5 Advantages & Disadvantages

| Advantages | Disadvantages |
|---|---|
| Easy key distribution (public keys shared openly) | Much slower than symmetric encryption |
| Supports digital signatures (auth + integrity) | Needs larger keys for similar security |
| Better scalability than pairwise symmetric keys | Not efficient for bulk data |
| Enables secure key establishment | Usually used only to set up keys/identity, not bulk data |

---

## PART 6: HYBRID ENCRYPTION

Modern systems combine both symmetric and asymmetric methods:

```
Asymmetric Crypto → Authenticate / Set up Session Key
        ↓
Symmetric Session Key → AES → Encrypt Large Data
```

> **Best of both worlds:** Asymmetric for identity/key setup, Symmetric for fast bulk encryption.

---

## PART 7: ASYMMETRIC ALGORITHMS (RSA, ECC, DSA)

### 7.1 RSA
- Named after Rivest, Shamir, Adleman.
- Can do **both encryption AND digital signatures**.

```
Encryption: Public Key → Encrypt | Private Key → Decrypt
Signature:  Private Key → Sign   | Public Key → Verify
```

- Used in digital certificates, secure key transport, and PKI.
- Needs secure padding schemes and proper key sizes.

> **Interview Point:** RSA supports both encryption and digital signatures.

### 7.2 ECC (Elliptic Curve Cryptography)
- A **family** of public-key techniques based on elliptic-curve math (not one single algorithm).
- **Advantage:** strong security with **much smaller keys** than RSA → less storage/bandwidth, efficient for mobile/embedded devices.

Key types:
```
ECDH  → Elliptic Curve Diffie-Hellman → Key agreement
ECDSA → Elliptic Curve Digital Signature Algorithm → Signatures
```

### 7.3 RSA vs ECC

| RSA | ECC |
|---|---|
| Older, widely deployed | Modern elliptic-curve approach |
| Needs larger keys | Needs smaller keys for same security |
| Encryption + signatures | Mainly key agreement + signatures |
| Widely supported | Efficient for modern/mobile systems |

> **Interview-Ready Answer:** ECC is a family of public-key techniques giving strong security with smaller keys than RSA. ECDH does key agreement; ECDSA does digital signatures.

### 7.4 DSA (Digital Signature Algorithm)
- Used **ONLY for digital signatures**, NOT for encryption.

```
Private Key → Create Signature → Message + Signature → Public Key → Verify
```

> **Can DSA encrypt data? No.** It only signs and verifies.

---

## PART 8: DIGITAL SIGNATURES

### 8.1 What is a Digital Signature?
Gives three things:
1. **Message integrity** (message not changed)
2. **Sender authentication** (proves who sent it)
3. Proof that the private-key owner actually signed it

```
Message → Hash → Sign with Private Key → Digital Signature
Receiver: Message + Signature → Verify with Public Key → Valid / Invalid
```

### 8.2 Signing vs Verification

| Signing | Verification |
|---|---|
| Done by the **sender** | Done by the **receiver** |
| Uses sender's **Private Key** | Uses sender's **Public Key** |

> **Interview-Ready Answer:** A digital signature is made using the sender's private key and checked using the sender's public key. It proves the message came from the private-key holder and wasn't changed.

### 8.3 Encryption vs Digital Signature

| Encryption (Confidentiality) | Digital Signature (Authentication + Integrity) |
|---|---|
| Receiver's Public Key encrypts | Sender's Private Key signs |
| Receiver's Private Key decrypts | Sender's Public Key verifies |
| Hides the message | Proves who sent it / wasn't changed |

---

## PART 9: SYMMETRIC vs ASYMMETRIC — FULL COMPARISON

| Feature | Symmetric | Asymmetric |
|---|---|---|
| Keys | One shared secret key | Public + private key |
| Speed | Fast | Slower |
| Key distribution | Difficult | Easier (public key shared openly) |
| Bulk data encryption | Excellent | Not preferred |
| Digital signatures | No | Yes |
| Scalability | Harder (pairwise keys) | Better for large systems |
| Algorithms | AES, DES, 3DES | RSA, ECC, DSA |
| Main use | Encrypting large data | Authentication, signatures, key setup |

### Alice-to-Bob Example
```
Symmetric:  Alice → shares secret K → Encrypted Data → Bob (needs SAME K)
Asymmetric: Alice → encrypts with Bob's Public Key → Bob decrypts with Private Key (no secret sent)
```

### Real-World Example — HTTPS
```
Browser → Server Certificate/Public Key → Authenticate Server + Set up Session Secret
        → Symmetric Session Encryption → HTTPS Data Transfer
```
> HTTPS does **not** encrypt every byte using public-key crypto. It uses public-key crypto for authentication/setup, then fast symmetric encryption for the actual data.

> **Interview-Ready Answer:** Symmetric crypto uses one key, is fast, but hard to distribute safely. Asymmetric crypto uses a public/private key pair, is slower, but great for signatures and secure key setup. Modern systems combine both (hybrid).

---

## PART 10: DIFFIE-HELLMAN (DH) KEY EXCHANGE

### 10.1 The Key-Sharing Problem (Recap)
Alice and Bob need the same symmetric key but can't send it directly over an unsafe network without risking interception.

### 10.2 What is Diffie-Hellman?

**Definition:** Diffie-Hellman is a **key-agreement method** that lets two parties create the **same shared secret** over an insecure network — **without sending the secret itself**.

```
Alice                      Bob
Private Value A            Private Value B
      ↓                          ↓
Public Value A             Public Value B
      ↓                          ↓
      └── Exchange Public Values ──┘
                 ↓
          DH Calculation
                 ↓
        Same Shared Secret
```

### 10.3 DH is Key Agreement, Not Encryption
DH does **not** encrypt the actual data. It only sets up a shared secret. Then AES (or similar) encrypts the real data.

```
Diffie-Hellman → Shared Secret → Derive Symmetric Key → AES Encryption → Encrypted Data
```

### 10.4 What Travels Over the Network?

| Sent Over Network | NOT Sent Over Network |
|---|---|
| Public DH values | Private values |
| | Shared secret |

### 10.5 Simple Analogy — Paint Mixing
- Public color: **Yellow**
- Alice's secret: **Red** → mixes to **Orange**
- Bob's secret: **Blue** → mixes to **Green**
- They exchange Orange ↔ Green.
- Alice adds Red to Green; Bob adds Blue to Orange.
- Both reach the **same final color** — this is the shared secret (analogy only, not real math).

### 10.6 Real Math Behind DH

Uses:
- Large prime `p`
- Generator `g`
- Alice's private number `a`, Bob's private number `b`

```
Alice Public = g^a mod p
Bob Public   = g^b mod p

Alice Shared Secret = (Bob Public)^a mod p
Bob Shared Secret   = (Alice Public)^b mod p

Both = g^(ab) mod p
```

**Tiny example (for learning only):**
```
p = 23, g = 5
Alice private a = 6 → A = 5^6 mod 23
Bob private b = 15 → B = 5^15 mod 23
Exchange A and B.
Alice computes B^6 mod 23; Bob computes A^15 mod 23 → same result.
```
(Real DH uses much larger numbers.)

### 10.7 Why Can't an Attacker Calculate the Secret?
Attacker sees `p`, `g`, and both public values — but not the private values.
Security relies on the **Discrete Logarithm Problem** (hard to reverse-calculate the private value from the public one), given properly chosen parameters.

### 10.8 Secure Key Agreement Concept
```
Alice's private value + Bob's private value → Shared Secret Created
```
This is different from just "creating a key and sending it" — both sides **contribute**.

### 10.9 Shared Secret → Encryption Key
The raw DH secret is not used directly. It goes through a **Key Derivation Function (KDF)**:
```
DH Shared Secret → KDF → Session Keys → Encryption/Integrity
```

### 10.10 Diffie-Hellman vs Encryption

| Diffie-Hellman | Encryption |
|---|---|
| Sets up shared secret | Protects data confidentiality |
| Key agreement mechanism | Data protection mechanism |
| Does not encrypt app data | Encrypts plaintext into ciphertext |
| Used during session setup | Used after keys are ready |
| Example: DH/ECDH | Example: AES |

> **Easy memory:** DH → Agree on the key. AES → Use the key to encrypt data.

### 10.11 MITM Risk with Basic (Unauthenticated) DH

Basic DH does **not prove identity**. An attacker (Eve) can sit in the middle:

```
Alice --------> Eve --------> Bob
```
Eve swaps in her own DH values, creating:
```
Alice ↔ Eve  = Secret 1
Eve ↔ Bob    = Secret 2
```
Eve can now decrypt, read/modify, and re-encrypt messages passing through — a **Man-in-the-Middle (MITM) attack**.

### 10.12 Fixing MITM — Authenticated Key Exchange
Combine DH with identity verification:
- Digital certificates
- Digital signatures
- Pre-shared keys (PSK)
- Public-key authentication

```
Diffie-Hellman + Authentication = Authenticated Key Exchange
```

### 10.13 DH in TLS
```
Client → TLS Handshake → Server Certificate → Authenticate Server
       → ECDHE Key Exchange → Shared Secret → Derive Session Keys → AES/ChaCha20 Encryption
```

### 10.14 DH in IPsec/VPN (via IKE)
```
VPN Gateway A → IKE → Diffie-Hellman → Shared Key Material → IPsec Security Association → ESP Encryption
```
DH does not carry the actual encrypted VPN data — ESP/AES does.

### 10.15 DHE — Ephemeral Diffie-Hellman
- **DHE = Diffie-Hellman Ephemeral** — temporary keys generated fresh for each session.
- Gives **Forward Secrecy**: even if the long-term key is later stolen, past session secrets stay safe (assuming ephemeral keys were properly discarded).

### 10.16 ECDH and ECDHE
- **ECDH** = Elliptic Curve Diffie-Hellman (key agreement using elliptic curves)
- **ECDHE** = Elliptic Curve Diffie-Hellman **Ephemeral** (temporary keys + forward secrecy)
- Benefits: smaller keys, better performance, strong security.

### 10.17 DH vs ECDH

| DH | ECDH |
|---|---|
| Traditional discrete-log math | Elliptic-curve math |
| Larger parameters | Smaller parameters |
| Key agreement | Key agreement |
| Ephemeral mode = DHE | Ephemeral mode = ECDHE |

### 10.18 Static DH vs Ephemeral DH

| Static DH | Ephemeral DH |
|---|---|
| Same long-term key reused | New key every session |
| No forward secrecy | Provides forward secrecy |

### 10.19 Advantages of DH
- Solves key-agreement problem
- Shared secret never directly sent
- Works over insecure networks
- Widely used in TLS, IPsec
- Supports forward secrecy (with ephemeral forms)

### 10.20 Limitations of DH
- Does not authenticate the peer by itself
- Vulnerable to MITM if unauthenticated
- Needs secure parameters
- Needs added authentication (certs/signatures/PSK)

### 10.21 Important Reminder
> Diffie-Hellman does **NOT** replace AES. DH sets up the key; AES encrypts the data.

### 10.22 DH Compared to Other Concepts

| DH vs Symmetric Encryption | DH vs Public-Key Encryption | DH vs Digital Signature |
|---|---|---|
| DH sets up secret; symmetric encrypts data | DH = both sides contribute; PK encryption = sender encrypts to receiver | DH creates a key; signatures verify authenticity |
| DH needs no pre-shared secret | PK encryption creates ciphertext directly | DH doesn't prove identity; signatures do |
| DH is slower setup; symmetric is fast bulk encryption | Example: ECDH vs RSA encryption | Example: ECDH vs ECDSA |

> **Interview-Ready Answer (DH):** Diffie-Hellman is a key-agreement protocol letting two parties create a shared secret over an insecure network without sending the secret itself. The secret is used to derive symmetric session keys (like AES keys).

> **Interview-Ready Answer (Why DH is needed):** Symmetric encryption needs both sides to share the same key, which is hard to distribute safely. DH solves this by letting both sides independently calculate the same secret using their own private values and the other's public value.

> **Interview-Ready Answer (MITM Risk):** Plain DH doesn't authenticate the parties, so an attacker can intercept and create separate secrets with each side (MITM). Fix: combine DH with certificates, signatures, or PSKs.

> **Interview-Ready Answer (ECDHE):** ECDHE = Elliptic Curve Diffie-Hellman Ephemeral. It uses temporary elliptic-curve keys to set up a shared secret and gives forward secrecy since each session uses fresh keys.

---

## PART 11: CRYPTOGRAPHIC ATTACKS & IMPLEMENTATION ISSUES

### 11.1 What is a Cryptographic Attack?
An attempt to break, bypass, or misuse a crypto system to:
- Discover a key
- Read encrypted data
- Modify protected data
- Impersonate a user
- Reuse captured messages
- Exploit weak algorithms/implementation/config

> **Key Point:** A strong algorithm can still be broken if implemented or configured badly.

### 11.2 Areas Attackers Target
```
Cryptographic System
      ↓
Key | Algorithm | Protocol | Code | Configuration
```
Examples: weak key → brute force; weak hash → birthday attack; bad auth → MITM; reused nonce → encryption failure; bad code → side-channel leak; old protocol → downgrade attack.

### 11.3 Man-in-the-Middle (MITM) Attack
Attacker secretly sits between two parties, can read/modify/relay/impersonate.

```
Normal: Alice ↔ Bob (direct, secure)
MITM:   Alice ↔ Attacker ↔ Bob
```
**With unauthenticated DH:** attacker sets up separate shared secrets with each side (see Part 10.11).

**Prevention:** digital certificates, digital signatures, certificate validation, PSKs, MFA, authenticated key exchange, TLS validation.

> **Key Point:** Encryption without authentication can still be vulnerable to MITM.

### 11.4 Brute-Force Attack
Tries **every possible** key/password until correct one is found.

- 8-bit key → only `2^8 = 256` possibilities (easy to crack)
- 128-bit key → `2^128` possibilities (extremely hard)

> **Key Point:** Larger, properly random keys resist brute force much better.

**Mitigation:** strong key sizes, strong passwords, MFA, rate limiting, account lockout, password hashing, KDFs, modern algorithms (AES-128/256 instead of DES).

### 11.5 Dictionary Attack
Tries **likely** passwords (common passwords, leaked lists, names, patterns) instead of all combinations — usually faster than brute force against weak passwords.

**Brute Force vs Dictionary:**

| Brute Force | Dictionary Attack |
|---|---|
| Tries everything | Tries likely/common values |
| Very broad, can be slow | Often faster, targeted |
| Covers full search space eventually | Depends on wordlist quality |

**Defense:** long unique passwords, MFA, password managers, rate limiting, lockout policies, slow hashing (Argon2, bcrypt, scrypt, PBKDF2). Never store plaintext passwords.

### 11.6 Birthday Attack
Targets **hash collisions**: finding two different inputs (`A ≠ B`) that give the **same hash** (`Hash(A) = Hash(B)`).

- Named after the Birthday Paradox: in a group of 23 people, there's already >50% chance two share a birthday.
- For an `n`-bit hash, a collision generally takes about `2^(n/2)` tries (not `2^n`).
- Example: 128-bit hash → collision security ≈ `2^64`.

**Mitigation:** use SHA-256/384/512/SHA-3. Avoid MD5, SHA-1 (both are collision-broken).

### 11.7 Side-Channel Attack
Attacks the **implementation**, not the math. Observes leaked information:
- Execution time (**Timing Attack**)
- Power consumption (**Power Analysis** — targets smart cards, embedded devices)
- CPU cache behavior (**Cache-Based Attack**)
- Electromagnetic signals / sound (rare cases)

> **Key Point:** Side-channel attacks target how the system runs, not the algorithm's math.

**Mitigation:** constant-time code, secure hardware, tested crypto libraries, avoid secret-dependent branches, cache-safe code, physical shielding.

### 11.8 Replay Attack
Attacker captures a valid message and **resends it later**.

```
Attacker captures: "Transfer ₹1000" → later replays same request → Server processes again (if undefended)
```
Also works on authentication tokens if reused without checks.

**Mitigation:** nonces, timestamps, sequence numbers, short-lived tokens, OTPs, challenge-response, anti-replay windows.

### 11.9 Known Plaintext Attack
Attacker knows **some plaintext AND its matching ciphertext**, and tries to use that to learn the key or break other messages.

**Mitigation:** modern algorithms, correct modes, unique nonces/IVs, authenticated encryption (AES-GCM, ChaCha20-Poly1305).

### 11.10 Chosen Ciphertext Attack (CCA)
Attacker **chooses ciphertexts**, sends them to the system, and studies the responses/errors to learn secrets.

Example: **Padding Oracle attack** — different error messages for "invalid padding" vs "invalid authentication" leak information.

**Mitigation:** authenticated encryption, secure padding, uniform error responses, tested libraries (AES-GCM, ChaCha20-Poly1305, RSA-OAEP).

### 11.11 Weak / Deprecated Algorithms
Algorithms once secure but now weak due to faster computers, better attacks, or small keys.

Examples: **DES, 3DES (for new systems), RC4, MD5 (collision), SHA-1 (collision)**.

> **Best Practice:** Always use current, standardized, modern algorithms.

### 11.12 Weak Randomness
Crypto depends on unpredictable random values (keys, nonces, IVs, tokens, salts). Predictable randomness = broken security.

**Bad example:** `Key = current time` → attacker can guess/narrow down the time and try few keys.

**Mitigation:** Use **CSPRNGs** (Cryptographically Secure Pseudo-Random Number Generators). Never use counters, timestamps alone, predictable `rand()`, usernames, or MAC addresses for keys.

### 11.13 Poor Key Management
Even strong encryption fails if keys are handled badly.

**Bad practices:**
- Hard-coded key in source code
- Same key used for years without rotation
- Key stored in plaintext file
- Private key shared by email
- Same key reused everywhere

**Key Lifecycle:**
```
Generate → Store Securely → Distribute Securely → Use → Rotate → Revoke if Compromised → Destroy Safely
```

**Good practice:** Use KMS (Key Management Service), HSM (Hardware Security Module), secret managers, key rotation, access controls, audit logs, separate keys by purpose.

### 11.14 Implementation Flaws
Algorithm can be mathematically strong but coded badly:
- Buffer overflow
- Wrong key handling
- Reused nonce/IV
- Bad padding validation
- Timing leaks
- Wrong certificate verification
- Memory exposure

**Nonce Reuse:** "Nonce" = Number Used Once. Reusing a nonce with the same key (e.g., in AES-GCM) can badly break security.

**IV Reuse:** Reusing the same IV with the same key can leak plaintext patterns or break the encryption mode.

**Hard-Coded Keys:** Bad example: `APP_KEY = "123456789"` in code. Problems: anyone with source access gets the key; rotation is hard; may leak via Git. **Better:** retrieve keys from a Secret Manager/KMS.

### 11.15 Protocol-Level Attacks
A strong algorithm doesn't guarantee a strong protocol. Examples: MITM, replay, downgrade attack, padding oracle, authentication bypass, session hijacking.

**Downgrade Attack:** Forces two systems to use an older, weaker protocol/cipher.
```
Client supports TLS 1.3 & 1.2 → Attacker forces older, weaker protocol → Exposes known weaknesses
```
**Mitigation:** disable obsolete protocols/ciphers, enforce minimum secure versions, use downgrade protection, keep systems updated.

### 11.16 Configuration Issues
Even correct crypto code can fail due to bad settings:
- Weak cipher suites enabled
- Old TLS versions enabled
- Certificate validation disabled
- Short keys
- Default passwords
- Expired certificates
- Publicly readable private keys
- Weak DH parameters
- Insecure VPN settings

**Certificate Validation Mistake:**
```
Bad: Verify certificate = false → attacker can present fake certificate → MITM possible
Correct: Check trust chain → Check hostname → Check expiration → Check signature → Valid?
```

### 11.17 Top 10 Common Cryptographic Mistakes

| # | Mistake |
|---|---|
| 1 | Using old algorithms (DES, RC4, MD5, SHA-1) |
| 2 | Hard-coding keys in source code |
| 3 | Using weak passwords as keys without a KDF |
| 4 | Reusing nonces or IVs |
| 5 | Disabling certificate verification |
| 6 | Poor random number generation |
| 7 | Never rotating keys |
| 8 | Creating custom/"secret" crypto algorithms |
| 9 | Using encryption without authentication (not using AEAD) |
| 10 | Logging secrets (passwords, keys, tokens) |

### 11.18 Attack Target Summary Table

| Attack | Common Target |
|---|---|
| Brute Force | Keys/passwords |
| Dictionary Attack | Passwords |
| Birthday Attack | Hash collisions |
| MITM | Key exchange/authentication |
| Replay | Authentication/messages |
| Side Channel | Implementation |
| Known Plaintext | Encryption system |
| Chosen Ciphertext | Decryption behavior/response |

### 11.19 Attack vs Implementation Issue

| Cryptographic Attack (active) | Implementation Issue (weakness created) |
|---|---|
| MITM | Hard-coded key |
| Brute force | Weak key size |
| Replay | No nonce checking |
| Side channel | Timing leak |
| Chosen ciphertext | Detailed error leakage |

> Often, an attack becomes possible *because of* an implementation or configuration mistake.

### 11.20 Worked Examples

**Strong algorithm + bad implementation:**
```
AES-256 (strong) but key stored at /home/app/key.txt with "everyone can read" permission
→ Attacker just steals the key file → AES-256 strength doesn't matter
```

**HTTPS with bad cert validation:**
```
Client doesn't validate server certificate → Fake cert accepted → MITM possible
(even though TLS encryption itself is working)
```

**Replay attack in API:**
```
Attacker captures a valid "Transfer ₹1000" request+token → resends it
→ If server doesn't check nonce/timestamp/request ID, it may process again
```

**Password database attack:**
```
Bad: password → MD5 only
Attacker steals DB → uses dictionary + brute force + precomputed tables → cracks passwords
Better: Password → Unique Salt → Argon2/bcrypt/scrypt → Stored Hash
```

### 11.21 Scenario-Based Quick Answers

| Scenario | Attack/Issue |
|---|---|
| Attacker modifies messages between user and server | MITM |
| Attacker tries every possible key | Brute-force attack |
| Attacker tries "password", "admin123", etc. | Dictionary attack |
| Attacker finds two files with the same hash | Birthday/collision attack |
| Attacker measures CPU time to learn the key | Side-channel (timing) attack |
| Attacker resends a captured login message | Replay attack |
| Attacker knows plaintext and matching ciphertext | Known plaintext attack |
| Attacker repeatedly modifies ciphertext, watches errors | Chosen ciphertext attack (e.g., padding oracle) |
| Company still uses DES | Weak/deprecated algorithm |
| Keys generated from timestamps | Weak randomness |
| AES-256 key stored in GitHub source code | Poor key management |
| Server supports old TLS/weak ciphers | Cryptographic configuration weakness |

> **Interview-Ready Answer (Crypto Attacks Overview):** Cryptographic attacks try to break or bypass encryption, hashing, authentication, or key exchange. Examples: brute force, MITM, replay, birthday attacks, side-channel attacks, chosen-ciphertext attacks. Many real failures also come from weak algorithms, bad randomness, poor key management, wrong implementation, or bad configuration — not just broken math.

> **Interview-Ready Answer (MITM):** A MITM attack happens when an attacker secretly intercepts communication between two parties, possibly reading or changing messages while both sides think they're talking directly to each other. Reduced by authenticated key exchange, certificate validation, digital signatures, and correct TLS setup.

> **Interview-Ready Answer (Birthday Attack):** A birthday attack targets a hash function's collision resistance — finding two different inputs with the same hash. Due to the birthday paradox, an n-bit hash gives only about `2^(n/2)` resistance to generic collision attacks, not `2^n`.

> **Interview-Ready Answer (Replay Attack):** A replay attack is when an attacker captures a valid message/request and sends it again later. Prevented using nonces, timestamps, sequence numbers, one-time tokens, and anti-replay checks.

> **Interview-Ready Answer (Side-Channel):** A side-channel attack learns secrets by observing how a system behaves while doing crypto operations (time, power, cache) instead of attacking the algorithm's math directly.

> **Interview-Ready Answer (Poor Key Management):** Poor key management means insecure key generation, storage, distribution, reuse, rotation, or destruction. Even strong AES encryption fails if attackers can steal or guess the key.

---

## PART 12: MASTER QUICK-REVISION SUMMARY

```
SYMMETRIC ENCRYPTION
Same key encrypts and decrypts. Very fast. Main problem: key distribution.
Block Cipher  → fixed-size blocks (AES)
Stream Cipher → continuous stream (ChaCha20)
DES  → 56-bit key, insecure, obsolete
3DES → legacy, slow, 64-bit block
AES  → modern standard, 128/192/256-bit key, 128-bit block
IDEA → 128-bit key, historical

ASYMMETRIC CRYPTOGRAPHY
Public + private key pair instead of one shared key.
Public Key  → shareable, encrypts data / verifies signatures
Private Key → secret, decrypts data / creates signatures
RSA → encryption + signatures
ECC → efficient family (ECDH, ECDSA), smaller keys
DSA → signatures ONLY, no encryption
Digital Signature → private key signs, public key verifies
Hybrid Crypto → asymmetric sets up the key; symmetric encrypts the data

DIFFIE-HELLMAN
Key-agreement protocol — creates shared secret without sending it.
Vulnerable to MITM if NOT authenticated.
DHE/ECDHE → ephemeral versions → give Forward Secrecy.

CRYPTOGRAPHIC ATTACKS
MITM, Brute Force, Dictionary, Birthday, Side-Channel, Replay,
Known Plaintext, Chosen Ciphertext, Downgrade — plus weak algorithms,
weak randomness, poor key management, bad implementation/configuration.
```

### Best Memory Diagram — Symmetric vs Asymmetric
```
                 CRYPTOGRAPHY
                     |
        ----------------------------
        |                          |
    Symmetric                  Asymmetric
        |                          |
  One Shared Key             Public + Private
        |                          |
    Very Fast                   Slower
        |                          |
 Bulk Encryption        Signatures / Authentication
        |                    / Key Establishment
       AES                    RSA / ECC / DSA
```

### Best Memory Diagram — Diffie-Hellman
```
Alice Private A             Bob Private B
      ↓                           ↓
Public A                     Public B
      ↓                           ↓
      └──── Exchange ────────────┘
                 ↓
          Shared Secret
                 ↓
        Derive Session Key
                 ↓
              AES
                 ↓
        Encrypted Traffic

Unauthenticated DH → MITM Risk
Authenticated DH (Certs/Signatures/PSK) → Secure Key Agreement
```

### Final Master Interview Lines

> **Symmetric vs Asymmetric:** Symmetric crypto is fast but has a key-distribution problem; asymmetric crypto solves key-management and authentication problems but is slower — so modern systems combine both (hybrid encryption).

> **Diffie-Hellman:** DH solves the key-sharing problem but doesn't authenticate the other party by itself — so secure protocols combine DH with authentication (certificates/signatures/PSK) to stop MITM attacks.

> **Cryptographic Attacks:** Most crypto failures aren't just about breaking strong math — attackers often exploit weak keys, bad randomness, poor key management, protocol weaknesses, or implementation mistakes instead.