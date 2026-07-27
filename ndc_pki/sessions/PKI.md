# Public Key Infrastructure — Consolidated Exam Notes
### PGCP-ITISS | Sessions 1–15

---

## SESSION 1: Information Security & Security Attacks

### 1.1 Information Security — Overview

Information Security (InfoSec) protects information and information systems from unauthorized access, use, disclosure, disruption, modification, or destruction. It covers technical measures (encryption, firewalls) and organizational measures (policies, awareness) for data in digital and physical form.

Digitally stored, network-accessible data is generally MORE vulnerable than paper locked in a cabinet, since attackers can reach it remotely without physical access. Compromise of information can cause financial loss, legal liability, reputational damage, or (in safety-critical systems) loss of life.

### 1.2 CIA Triad — Core Objectives

```
                    ┌───────────────┐
                    │   CIA TRIAD   │
                    └───────┬───────┘
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
   CONFIDENTIALITY      INTEGRITY         AVAILABILITY
   Only authorized     Data stays        Accessible to
   users can access    accurate &        authorized users
   the data            unaltered         when needed
```

**Confidentiality**
- Info accessible only to authorized individuals.
- Loss = unauthorized reading/copying (breaches, eavesdropping).
- Critical for: medical records, financial data, research, corporate strategy.
- Mechanisms: access control, authentication, encryption, policy.

**Integrity**
- Info stays accurate, complete, unaltered except by authorized processes.
- Loss = unauthorized modification/deletion/injection (accidental or malicious).
- Critical for: EFT, air traffic control, accounting records.
- Mechanisms: checksums, hashing, digital signatures, change control.

**Availability**
- Info/systems accessible to authorized users in a timely, reliable manner.
- Loss = erasure/blocking → denial of service.
- Critical for: online inventory, airline booking, cloud services.
- Mechanisms: redundancy, backups, load balancing, incident response.

> **Exam Trap:** DoS attacks primarily hit **Availability**, not Confidentiality — a very common mix-up.

### 1.3 Supporting Concepts

| Concept | Meaning |
|---|---|
| Authentication | Verifying identity (password, smart card, biometrics) |
| Authorization | Deciding what an authenticated user may do |
| Non-repudiation | User cannot later deny performing an action (logs, digital signatures) |

### 1.4 Basic Terms

- **Asset** — any resource of value needing protection.
- **Threat** — potential cause of an unwanted incident (hacker, malware, insider).
- **Vulnerability** — weakness in design/implementation/configuration/process.
- **Attack** — concrete exploitation of a vulnerability by a threat, compromising C/I/A.

### 1.5 Classification of Security Attacks

```
                 SECURITY ATTACKS
                        │
          ┌─────────────┴─────────────┐
          ▼                           ▼
    ACTIVE ATTACKS               PASSIVE ATTACKS
    Alter/disrupt data        Observe/collect data
    (Integrity, Availability)  (Confidentiality)
```

### 1.6 Active Attacks (Detailed)

Active attacks involve data-stream manipulation or generation of false data, directly interfering with system behavior.

| Attack | Description |
|---|---|
| **Masquerade** | One entity impersonates another to gain unauthorized privileges — usually via stolen credentials or weak authentication. |
| **Modification of Messages** | Attacker alters, delays, or reorders a message. E.g., changing "Allow JOHN to view file X" → "Allow SMITH to view file X" — breaks integrity. |
| **Repudiation** | An entity denies performing an action, exploiting weak logging/authentication; logs may be tampered or forged. |
| **Replay** | A valid transmission is captured and resent later to trigger unauthorized operations; defeated by timestamps/nonces (freshness checks). |
| **Denial of Service (DoS)** | Prevents legitimate access to services/resources — disabling a network, flooding with bogus traffic, or suppressing messages to a target. |

### 1.7 Passive Attacks (Detailed)

Passive attacks do not usually consume resources or modify data — they focus on monitoring/intercepting communications (phone calls, emails, data streams).

| Attack | Description |
|---|---|
| **Release of Message Content** | Confidential message contents are intercepted and read by unauthorized parties — direct confidentiality violation. |
| **Traffic Analysis** | Even with encrypted messages, attacker observes communication patterns (who talks to whom, how often) to infer relationships/org structure. |

> **Viva Point:** Passive attacks are hard to *detect* (no data alteration) but easy to *prevent* (encryption). Active attacks are easy to *detect* but hard to *prevent*.

### 1.8 Common Practical Cyberattacks

| Attack | Description |
|---|---|
| Malware (Virus/Worm/Trojan) | Virus attaches to programs; worm self-propagates over networks; trojan disguises as legitimate software |
| Ransomware | Encrypts victim data, demands payment; targets availability + integrity, may threaten leaks |
| Phishing / Social Engineering | Deceptive emails/sites trick users into revealing credentials; exploits human psychology not technical flaws |
| Password Attacks | Brute force, dictionary attack, credential stuffing, keylogging |
| DoS / DDoS | DDoS uses a botnet (many compromised machines) to amplify traffic, harder to block |
| Man-in-the-Middle (MitM) | Secretly intercepts/modifies communication between two parties who believe they're talking directly |
| Injection (e.g., SQLi) | Untrusted input interpreted as code/query — manipulate DB to read/modify/delete data |

### 1.9 Attack ↔ CIA Mapping

| CIA Property | Threatened By |
|---|---|
| Confidentiality | Eavesdropping, release of message content, traffic analysis, data breaches, credential theft |
| Integrity | Message modification, injection attacks, file-altering malware, masquerade |
| Availability | DoS/DDoS, ransomware, destructive/wiping malware |

### 1.10 Basic Defensive Measures

- **Technical:** firewalls, IDS/IPS, antivirus, encryption, secure coding, authentication
- **Administrative:** security policies, training, incident response plans, risk assessment, compliance
- **Physical:** locks, CCTV, access badges, secured server locations

### Session 1 — Viva Q&A

**Q: Differentiate active and passive attacks.**
A: Active attacks alter/disrupt data and target integrity/availability (e.g., DoS, replay); passive attacks only observe/intercept data and target confidentiality (e.g., eavesdropping, traffic analysis).

**Q: What is non-repudiation?**
A: A security property ensuring a user cannot deny having performed an action — enforced via logs and digital signatures.

**Q: Give an example of a masquerade attack.**
A: Using stolen login credentials to impersonate a legitimate user and gain unauthorized system access.

---

## SESSION 2: Basic Encryption Concepts, File Encryption, Encryption Folders

### 2.1 Basic Encryption Concepts

Encryption converts readable data (**plaintext**) into unreadable form (**ciphertext**) using an algorithm + key. Only the holder of the correct decryption key can reverse it. Primary goal: protect **confidentiality** — even if data is stolen, it's unreadable without the key. Applied to:
- **Data at rest** (files, disks, databases)
- **Data in transit** (network traffic, emails, VPNs, HTTPS)

**Key building blocks:**

| Term | Meaning |
|---|---|
| Key | Secret bit-string used to scramble/unscramble data |
| Algorithm (cipher) | Mathematical function performing encryption/decryption (AES, RSA) |
| Strength | Depends on key length, algorithm design, implementation quality |

> **Exam Trap:** Strong algorithms can be undermined by weak passwords, poor key management, or buggy implementation — algorithm strength alone ≠ system security.

### 2.2 Types of Encryption (High Level)

```
        ┌────────────────────────────────────────────┐
        │              ENCRYPTION TYPES               │
        └────────────────────────────────────────────┘
                │              │              │
                ▼              ▼              ▼
          SYMMETRIC      ASYMMETRIC        HASHING
        Same key both   Public/Private   One-way digest
        encrypt/decrypt      keys        (no reversal)
        Fast, bulk data  Slow, key       Integrity only,
                        exchange/sign    not confidentiality
```

Real-world systems combine all three: symmetric for bulk data, asymmetric for key exchange/authentication, hashing for integrity verification.

### 2.3 File Encryption — Concept

File encryption applies an encryption algorithm to **individual files** so only authorized users/apps can open them. Stolen/copied encrypted files remain unreadable without the key. Useful for fine-grained control (specific sensitive files) vs full-disk encryption (everything).

**Typical workflow:**
1. User selects file → requests encryption via tool/OS feature.
2. System generates/uses a key, applies a symmetric cipher (commonly AES) to contents, stores metadata marking it encrypted.
3. Authorized user opens file → system transparently decrypts in memory after identity verification (OS login, certificate).
4. Unauthorized access attempt → file appears corrupted/inaccessible.

### 2.4 Windows EFS (Encrypting File System)

- Built-in NTFS feature to encrypt files/folders per user account.
- Uses standard crypto algorithms; keys tied to user certificates managed by Windows.
- Only the owning user account (+ configured recovery agents) can open EFS-encrypted files.
- Encrypted items show a **lock overlay** icon.

> **Exam Trap:** If a local account password is reset incorrectly and no EFS key backup exists, access to EFS-encrypted files can be **permanently lost**.

### 2.5 Encrypting Folders — GUI Method (Windows)

**Path:** Properties → Advanced → "Encrypt contents to secure data" (NTFS only)

**Steps (Folder):**
1. Right-click target folder → **Properties**
2. General tab → click **Advanced…**
3. Check **Encrypt contents to secure data** → OK
4. OK again → choose: apply to *this folder only* OR *folder, subfolders, and files*

Choosing "folder, subfolders and files" encrypts everything inside; any new file saved into the folder automatically inherits encryption.

**Steps (Single File):**
1. Right-click file → **Properties**
2. **Advanced…** → enable **Encrypt contents to secure data**
3. Confirm: encrypt file only, or also parent folder

> **Viva Point:** Encrypting both the file AND its parent folder is recommended — operations on an unencrypted parent directory can cause encrypted files to silently decrypt after modification.

### 2.6 Encrypting Folders — `cipher` Command (CLI)

`cipher` displays/changes NTFS encryption state. Run without parameters → shows `E` (encrypted) / `U` (unencrypted) status of items in current path.

**General syntax:**
```text
cipher [/e | /d | /c] [/s:<directory>] [/b] [/h] [pathname [...]]
cipher /k
cipher /r:<filename> [/smartcard]
cipher /u [/n]
cipher /w:<directory>
cipher /x[:efsfile] [filename]
cipher /y
```

**Key parameters:**

| Flag | Function |
|---|---|
| `/e` | Encrypt specified files/directories (dirs marked so future files auto-encrypt) |
| `/d` | Decrypt specified files/directories |
| `/s:<dir>` | Apply recursively to all subdirectories |
| `/c` | Show info about encrypted files |
| `/a` | Operate on files only |
| `/k` | Create new certificate/key |
| `/r` | Generate recovery agent key + certificate |
| `/x` | Backup EFS certificate and keys |
| `/w` | Wipe deleted (unused) data on a volume |

**Examples:**
```text
# Encrypt a single file
cipher /A /E filename

# Encrypt multiple files
cipher /A /E file1.txt file2.docx file3.pdf

# Decrypt a file
cipher /D filename

# Encrypt a directory (new files auto-encrypt)
cipher /E directoryPath

# Encrypt all files in a folder
cipher /E directoryPath*

# Encrypt folder + all subfolders recursively
cipher /E /S:directoryPath

# Encrypt existing files/subfolders too (recursive + all)
cipher /A /E /S:directoryPath
```
> For decryption, replace `/E` with `/D` in the same patterns.

**Operational notes:**
- Encrypting a folder with `/e` → new files created inside auto-encrypt for that user.
- Encrypt parent directory + files together to avoid unexpected decryption on modification.
- Admins should back up EFS recovery keys (`/r`, `/x`) to prevent permanent data loss.

### Session 2 — Quick Reference Card

| Task | GUI | CLI |
|---|---|---|
| Encrypt file/folder | Properties → Advanced → Encrypt contents to secure data | `cipher /e` |
| Decrypt | Uncheck same option | `cipher /d` |
| Recursive (subfolders) | Choose "folder, subfolders and files" | `cipher /e /s:<dir>` |
| Check status | Lock icon overlay | `cipher` (no args) |

---

## SESSION 3: Cryptographic Fundamentals, Ciphers, Protocols

### 3.1 Cryptographic Fundamentals

Cryptography transforms information for secure storage/transmission using mathematical algorithms and keys, providing: **Confidentiality, Integrity, Authentication, Non-repudiation.**

Modern cryptography relies on well-studied algorithms and strong keys, NOT secrecy of the algorithm itself — **Kerckhoffs's Principle**.

**Basic building blocks:**

| Term | Definition |
|---|---|
| Plaintext | Original readable data |
| Ciphertext | Encrypted, unreadable data |
| Key | Secret/public value used to encrypt/decrypt or sign/verify |
| Cipher | Mathematical function performing encryption/decryption |
| Hash function | One-way function → fixed-length digest, used for integrity (e.g. SHA-256) |

### 3.2 Symmetric vs Asymmetric Ciphers

```
              SYMMETRIC                        ASYMMETRIC
        ┌──────────────────┐           ┌──────────────────────┐
Sender  │  Plaintext        │   Key     │  Plaintext            │
   │    │  ──[Same Key]──▶  │  Pair:    │  ──[Public Key]──▶    │
   ▼    │  Ciphertext       │  Public + │  Ciphertext            │
Receiver│  ──[Same Key]──▶  │  Private  │  ──[Private Key]──▶   │
        │  Plaintext        │           │  Plaintext             │
        └──────────────────┘           └──────────────────────┘
        Fast, bulk data                Slow, key exchange/signatures
        Key distribution problem       Solves key distribution
```

**Symmetric Ciphers (Secret-Key)**
- One shared key for encrypt + decrypt.
- Fast, low computational cost → ideal for bulk data (files, disks, network throughput).
- Main challenge: **key distribution** (securely sharing the key over an insecure channel).
- Examples: DES (insecure now), 3DES/TDEA, **AES** (modern standard).
- Implemented as block ciphers (CBC, GCM modes) or stream ciphers.
- **AES**: 128-bit blocks, key sizes 128/192/256 bits. Used in Wi-Fi (WPA2/WPA3), VPNs, full-disk encryption, TLS bulk data.

**Asymmetric Ciphers (Public-Key)**
- Key pair: **public key** (shareable) + **private key** (secret).
- One key protects (encrypt/sign), the other removes protection (decrypt/verify).
- Solves key distribution — public key can be shared openly.
- Slower, more resource-intensive → used for small data (keys, digests), not bulk encryption.
- Examples: RSA, Diffie–Hellman, ECC, DSA/DSS.
- Rely on hard math problems: factoring large integers (RSA), discrete log problem (DH/ECC).
- **RSA**: key pair from large primes; public key encrypts/verifies, private key decrypts/signs; security = difficulty of factoring the modulus.

### 3.3 Symmetric vs Asymmetric — Comparison Table

| Aspect | Symmetric | Asymmetric |
|---|---|---|
| Keys | One shared secret key | Public + private key pair |
| Speed | Fast | Slow |
| Use case | Bulk data encryption | Key exchange, digital signatures |
| Key management (n users) | O(n²) keys needed | O(n) keys needed |
| Examples | DES, 3DES, AES | RSA, DH, ECC |

> **Exam Trap:** Symmetric = O(n²) key pairs needed for n users to communicate securely pairwise; Asymmetric = O(n) — only one key pair per user. This scalability difference is a classic exam question.

HTTPS/TLS uses a **hybrid approach**: asymmetric for initial key exchange, symmetric for actual data transfer (best of both: security + speed).

### 3.4 Cryptographic Protocols — History & Usage

Protocols define rules/message flows for how crypto primitives are combined (handshakes, key exchange, authentication, encryption, integrity). Milestones: symmetric DES (1970s) → public-key crypto (mid-1970s: Diffie–Hellman, RSA) → standardized protocols SSL/TLS, IPsec, SSH (1990s onward).

Modern protocols also handle identity verification (PKI/certificates), cipher-suite negotiation, and key lifecycle management.

**Typical usage:** HTTPS/TLS (secure browsing), SSH (remote login), IPsec (VPN tunnels), WPA2/WPA3 (Wi-Fi), S/MIME/PGP (secure email).

A secure protocol typically provides:
- Mutual/server authentication (certificates, signatures)
- Secure key establishment (asymmetric algorithms + key exchange)
- Confidential data transfer (symmetric encryption, session keys)
- Integrity/authenticity (MACs or AEAD modes like AES-GCM)

### 3.5 Key Generation

| Type | Method |
|---|---|
| Symmetric | Random k-bit string (e.g. 128/256-bit for AES) via secure RNG — no special math structure needed, just unpredictability |
| Asymmetric | Requires special mathematical structure — large primes/modulus (RSA) or curve points (ECC); computationally expensive; parameters chosen for target security level (e.g. 2048-bit RSA, 256-bit ECC) |

Because asymmetric key generation is costly, protocols usually use it only to exchange/protect simpler **symmetric session keys**.

### 3.6 Ciphering a Message — Protocol Workflow

```
 SENDER                                          RECEIVER
   │                                                 │
   │ 1. KEY ESTABLISHMENT (DH / RSA / pre-shared)    │
   │◀──────────────── negotiate/exchange ───────────▶│
   │                                                 │
   │ 2. ENCRYPT plaintext with session key (AES)     │
   │    + generate MAC/auth tag                      │
   │                                                 │
   │ 3. TRANSMIT ciphertext + headers + nonce + tag  │
   │────────────────────────────────────────────────▶│
   │                                                 │
   │                          4. DECRYPT with session key
   │                             verify MAC/tag — reject if fails
```

**Steps:**
1. **Key Establishment** — parties agree keys via DH, RSA key transport, or pre-shared keys; TLS handshake negotiates cipher suite + derives session keys.
2. **Message Encryption** — sender uses symmetric cipher (AES) + session key to produce ciphertext; mode (GCM/CBC) may also generate a MAC.
3. **Transmission** — ciphertext + protocol headers/nonces/tags sent over network; attacker should not recover plaintext or forge valid ciphertext.
4. **Message Decryption** — receiver decrypts with same session key; verifies MAC/tag, rejects on failure.

Optionally, sender signs with private key; receiver verifies with sender's public key → adds authenticity + non-repudiation.

### 3.7 Hybrid Cryptosystems

- Asymmetric crypto: securely exchanges/derives a shared **session key**.
- Symmetric crypto: encrypts actual application data using that session key (performance).
- Used by TLS/HTTPS, SSH, IPsec.

### Session 3 — Viva Q&A

**Q: Why do we need asymmetric crypto if it's slower than symmetric?**
A: It solves the key-distribution problem — public keys can be shared openly, avoiding the O(n²) secret-sharing burden of symmetric-only systems. It's used for key exchange and signatures, not bulk data.

**Q: What is Kerckhoffs's Principle?**
A: Security should depend only on the secrecy of the key, not the secrecy of the algorithm — the algorithm can be public.

**Q: Why does TLS use a hybrid approach?**
A: To combine asymmetric crypto's secure key exchange/authentication with symmetric crypto's speed for bulk data encryption.

---

## SESSION 4: Symmetric & Asymmetric Key Encryption Algorithms

### 4.1 DES — Data Encryption Standard (Symmetric)

- Symmetric block cipher, NIST standard (FIPS 46), 64-bit blocks, **56-bit effective key**.
- Based on IBM's "Lucifer" algorithm; adopted in the 1970s.
- Structure: **Feistel network**, 16 rounds. Block split into two 32-bit halves; each round transforms only the right half.
- Flow: Initial Permutation (IP) → 16 Feistel rounds → Final Permutation (inverse IP) → 64-bit ciphertext.
- Round function: expand right half 32→48 bits (E) → XOR with 48-bit round subkey → 8 S-boxes (6→4 bits each) → permutation P.
- Subkeys: generated via PC-1/PC-2 permuted choices + key rotation schedule → 16 distinct 48-bit subkeys.

```
        64-bit Plaintext
              │
        Initial Permutation (IP)
              │
     ┌────────┴────────┐
     L0 (32b)      R0 (32b)
     │                  │
     │            [Round Function f + Subkey K1]
     │◀───────────XOR────┘
     └──────┐    │
      L1=R0 R1=L0⊕f(R0,K1)
            ...  (16 rounds total)
              │
        Final Permutation (IP⁻¹)
              │
        64-bit Ciphertext
```

- **Avalanche effect**: strong — 1 input bit change flips ~half the output bits (good confusion/diffusion).
- **Weakness**: 56-bit key space (2^56) is too small — broken by brute force via dedicated hardware/distributed computing. **Obsolete.**
- Replaced by 3DES (Triple-DES), then AES.

### 4.2 AES — Advanced Encryption Standard (Symmetric)

- Modern symmetric standard, replaced DES. **128-bit blocks**, key sizes **128/192/256 bits**.
- Used in: TLS/HTTPS, WPA2/WPA3, VPNs, disk/file encryption.
- Structure: **Substitution-Permutation Network** (NOT Feistel). Rounds: 10 (128-bit key), 12 (192-bit), 14 (256-bit).

**Each round (except last) = 4 operations:**

| Step | Function |
|---|---|
| SubBytes | Non-linear byte substitution via S-box → confusion |
| ShiftRows | Cyclic row shifts in state matrix → inter-byte diffusion |
| MixColumns | Mixes bytes within columns via finite-field arithmetic → more diffusion |
| AddRoundKey | XOR state with round key (from key schedule) |

```
Plaintext (128-bit block)
       │
  AddRoundKey (initial)
       │
  ┌─────────────────────┐
  │ SubBytes             │
  │ ShiftRows            │  × (Nr-1) rounds
  │ MixColumns            │
  │ AddRoundKey            │
  └─────────────────────┘
       │
  SubBytes → ShiftRows → AddRoundKey   (final round, no MixColumns)
       │
   Ciphertext
```

> **Exam Trap:** AES is a **substitution-permutation network**, DES is a **Feistel cipher** — commonly confused. Also: AES's last round skips MixColumns.

### 4.3 RC5 — Symmetric Block Cipher

- Designed by Ron Rivest (1994), simple and flexible/parameterized.
- Parameters **(w, r, b)**: word size *w* (e.g. 32 bits), rounds *r*, key length *b* bytes → many configurations possible.
- Operates on two *w*-bit words (block size = 2w).
- Uses only 3 simple operations: **modular addition, XOR, data-dependent rotations**.
- Data-dependent rotation amount depends on the data itself → resists some linear/differential attacks but complicates analysis.
- Key schedule expands user key into a subkey array used each round.

### 4.4 RSA — Asymmetric (Public-Key) Encryption

- Introduced 1977 (Rivest, Shamir, Adleman). Provides both **encryption** and **digital signatures**.

**Key Generation (steps):**
1. Choose two large primes **p**, **q**.
2. Compute **n = p × q** (part of both keys).
3. Compute **φ(n) = (p−1)(q−1)** (Euler's totient).
4. Choose **e** such that 1 < e < φ(n) and gcd(e, φ(n)) = 1.
5. Compute **d** = modular inverse of e mod φ(n), i.e. d·e ≡ 1 (mod φ(n)) — via Extended Euclidean Algorithm.

- **Public key** = (e, n) — Private key = (d, n)

**Encryption / Decryption:**
- Encrypt: `c = m^e mod n` (using receiver's public key)
- Decrypt: `m = c^d mod n` (using receiver's private key)

- **Security**: relies on difficulty of **factoring** n = p×q. If n is factored → φ(n) recoverable → d derivable → key broken.
- Practical key sizes: **2048 bits or more** recommended to resist factoring attacks.

### 4.5 ECC — Elliptic Curve Cryptography (Asymmetric)

- Uses algebraic structure of **elliptic curves over finite fields**.
- Achieves RSA-equivalent (or better) security with **much smaller keys** → ideal for mobile/constrained devices, high performance.
- Curve equation: `y² = x³ + ax + b` over a finite field; points form a group under defined addition.
- Uses point addition + scalar multiplication for key operations.
- **Security basis**: Elliptic Curve Discrete Logarithm Problem (ECDLP) — finding scalar k such that Q = kP is computationally infeasible for suitable curves.
- **256-bit ECC ≈ 3072-bit RSA** in security strength → faster computation, smaller certificates, less bandwidth/storage.
- Common schemes: **ECDSA** (signatures), **ECDH** (key exchange) — used in modern TLS cipher suites.

### 4.6 Algorithm Comparison Table

| Algorithm | Type | Block/Key Size | Structure | Status |
|---|---|---|---|---|
| DES | Symmetric | 64-bit block, 56-bit key | Feistel, 16 rounds | Obsolete (broken by brute force) |
| 3DES | Symmetric | 64-bit block, up to 168-bit key | Feistel (3× DES) | Legacy, being phased out |
| AES | Symmetric | 128-bit block, 128/192/256-bit key | SPN, 10/12/14 rounds | Current standard |
| RC5 | Symmetric | Parameterized (w,r,b) | Add/XOR/rotate | Configurable, less common |
| RSA | Asymmetric | Typically 2048+ bit modulus | Factoring-based | Widely used (signatures, key transport) |
| ECC | Asymmetric | 256-bit ≈ RSA 3072-bit | ECDLP-based | Modern preferred (TLS, mobile, IoT, blockchain) |

### 4.7 PKI Context

In a PKI, asymmetric algorithms (RSA/ECC) issue certificates, perform digital signatures, and establish trust via CAs. Once trust/shared secret is established, symmetric algorithms (AES) handle efficient bulk data encryption — a hybrid cryptosystem.

### Session 4 — Viva Q&A

**Q: Why is DES considered insecure today?**
A: Its 56-bit key space (2^56 keys) is small enough to be brute-forced with modern/dedicated hardware.

**Q: Differentiate DES and AES structurally.**
A: DES uses a Feistel network (16 rounds, operates on half-blocks); AES uses a Substitution-Permutation Network (10/12/14 rounds depending on key size, operates on the full state each round).

**Q: Why prefer ECC over RSA?**
A: ECC achieves equivalent security with much smaller key sizes (256-bit ECC ≈ 3072-bit RSA), giving faster computation and lower bandwidth/storage overhead — important for mobile and constrained devices.

**Q: Explain RSA key generation briefly.**
A: Pick two large primes p, q → compute n = pq and φ(n) = (p−1)(q−1) → choose e coprime to φ(n) → compute d as e's modular inverse mod φ(n). Public key = (e,n), private key = (d,n).

---

## SESSION 5: Diffie-Hellman, Attacks Against Encryption, Cryptographic Issues

### 5.1 Diffie-Hellman (DH) Key Exchange

**Diffie-Hellman** is a protocol that lets two parties who have never met establish a **shared secret key** over an insecure channel — even with an eavesdropper listening to every message. Published in 1976 by **Whitfield Diffie** and **Martin Hellman**, it marked the birth of public-key cryptography and solved the classic **key distribution problem** (previously, secure communication required meeting in person or using a trusted courier to exchange keys).

> **Exam Trap:** DH does **not** encrypt messages. It only produces a shared secret, which is then used with a symmetric cipher like AES for actual data encryption.

**Building blocks:**

| Term | Meaning |
|---|---|
| Prime (p) | A large public prime number agreed on by both parties (2048+ bits in practice) |
| Primitive root (g) | A public "generator" value that, raised to different powers mod p, produces all values 1…p−1 in pseudo-random order — this randomness is what makes the private exponent hard to recover |
| Modular arithmetic (mod) | "Clock arithmetic" — `x mod p` is the remainder of x divided by p |

**Algorithm (worked example, small numbers for clarity — real systems use 2048-bit p):**

```
Public parameters (known to everyone, including an eavesdropper Eve):
   p = 23   g = 5

Alice                                              Bob
private a = 6                                      private b = 15
A = g^a mod p = 5^6 mod 23 = 8    ── A=8 ──▶
                                   ◀── B=19 ──      B = g^b mod p = 5^15 mod 23 = 19

Alice computes: S = B^a mod p = 19^6 mod 23  = 2
Bob computes:   S = A^b mod p = 8^15 mod 23  = 2
                         Shared Secret S = 2 (Eve cannot derive it)
```

**Why it works (proof):**
`S = B^a mod p = (g^b)^a mod p = g^(ab) mod p`
`S = A^b mod p = (g^a)^b mod p = g^(ab) mod p`
Since `ab = ba`, both sides land on the exact same value.

**Why Eve can't break it:** To recover a or b from the public values (p, g, A, B), Eve must solve the **Discrete Logarithm Problem** — finding the exponent when only the base and result are known in modular arithmetic. With small numbers this is trivial, but with a 2048-bit prime it is computationally infeasible with current technology.

**Where DH is used:** TLS/HTTPS handshakes, SSH key exchange, IPsec VPNs, and the Signal messaging protocol (via a variant called X3DH — Extended Triple DH).

```bash
# Linux/OpenSSL — generate and inspect DH parameters
openssl dhparam -out dh2048.pem 2048
openssl dhparam -text -in dh2048.pem -noout
```

**Key properties:**

| Property | Explanation |
|---|---|
| Key exchange only | Produces a shared secret; does not itself encrypt data |
| Public parameters | p and g need no protection |
| Private keys never transmitted | a and b stay local to each party |
| Perfect Forward Secrecy | Fresh keys per session — compromising one session's key doesn't expose past/future sessions |
| No built-in authentication | DH alone doesn't verify identity → vulnerable to MITM (see 5.2.1) unless combined with certificates/signatures |

### 5.2 Attacks Against Encryption

Even mathematically sound algorithms can be undermined by attacks on how they're used, implemented, or deployed.

#### 5.2.1 Man-in-the-Middle (MITM) Attack

**MITM** = **M**an-**i**n-**t**he-**M**iddle — an attacker secretly positions themselves between two parties who believe they're talking directly to each other, and can intercept, read, or alter every message.

**MITM against unauthenticated Diffie-Hellman:**

```
Alice                      Mallory (attacker)                    Bob
  │── A (Alice's key) ───▶│  intercepts A, sends her own M_A ──▶│
  │◀── M_B (fake) ─────────│  intercepts B, sends her own M_B ──▶│◀── B (Bob's key)
  │
Alice computes S1 = M_B^a mod p  (thinks she shares S with Bob)
Mallory computes BOTH  S1 = M_B^a mod p   and   S2 = M_A^b mod p
Bob computes S2 = M_A^b mod p    (thinks he shares S with Alice)

Mallory now decrypts Alice's traffic with S1, re-encrypts with S2 for Bob — and vice versa.
```

Both Alice and Bob believe they share a secret with each other, but each actually shares a separate secret with Mallory.

**Prevention:**
- **Digital certificates + PKI** — a trusted CA binds public keys to verified identities; each party validates the other's certificate (see Session 7/8)
- **Pre-shared keys (PSK)** — a secret agreed beforehand, used to authenticate the exchange
- **Out-of-band verification** — comparing key fingerprints via a separate channel (phone call, QR code)
- **Authenticated DH variants** — Station-to-Station (STS) protocol, SIGMA (SIGned-MAC) protocol — add digital signatures to verify identity

**Real-world example — HTTPS:** the server presents a CA-signed certificate; the browser verifies it *before* the DH key exchange proceeds, which is what prevents MITM on the modern web.

```bash
openssl s_client -connect www.example.com:443 -showcerts   # inspect the certificate chain
```

#### 5.2.2 Brute Force Attack

Systematically tries **every possible key** until one decrypts the ciphertext correctly.

| Key length | Keyspace | Time to exhaust @ 1 billion keys/sec |
|---|---|---|
| 56-bit (DES) | 2^56 ≈ 7.2×10^16 | ~2.3 years |
| 128-bit (AES-128) | 2^128 ≈ 3.4×10^38 | ~10^22 years |
| 256-bit (AES-256) | 2^256 ≈ 1.2×10^77 | ~10^61 years |

> **Exam Trap:** The universe is ~13.8 billion years old — AES-256 brute force is astronomically beyond that, which is why brute force only succeeds against **weak/short/predictable keys**, not against the algorithm itself (e.g., an 8-digit numeric Wi-Fi password has only 10^8 possibilities and can fall in minutes to tools like `hashcat`/`aircrack-ng`).

**Countermeasures:** long random keys (128+ bits), rate limiting, account lockout policies, strong password requirements (12–16+ mixed characters).

#### 5.2.3 Dictionary Attack

A smarter brute force that tries a **precompiled list of likely passwords** (e.g., `rockyou.txt`, 14 million entries) instead of every possible combination — millions of times faster against weak, human-chosen passwords.

```bash
hashcat -m 0 -a 0 hash.txt rockyou.txt
# -m 0 = MD5 hash type, -a 0 = dictionary attack mode
```

**Countermeasures:** strong unique passwords not found in dictionaries; **salting** (random data added before hashing so identical passwords don't produce identical hashes); **key stretching** (PBKDF2, bcrypt, Argon2 — deliberately slow hashing); multi-factor authentication (MFA).

```
# Linux /etc/shadow entry format:
username:$6$saltsalt$hashedpassword:18000:0:99999:7:::
   $6$ = SHA-512 with salt   $5$ = SHA-256 with salt   $1$ = MD5 (deprecated)
```

#### 5.2.4 Birthday Attack

Exploits the **Birthday Paradox**: in a room of just 23 people, there's already a ~50% chance two share a birthday — far sooner than intuition suggests (not 23/365). Applied to hashing, it means **finding any two inputs that collide** is far easier than finding an input matching one specific hash.

| Attack goal | Effort needed for an n-bit hash |
|---|---|
| Find a specific preimage | 2^n attempts |
| Find *any* collision (birthday attack) | 2^(n/2) attempts |

For MD5 (128-bit): brute-force preimage = 2^128, but a collision needs only ~2^64 — dramatically weaker.

> **Exam Trap:** This is why MD5 and SHA-1 are considered broken for security purposes — practical collisions have been demonstrated (e.g., a 2008 forged SSL certificate exploiting an MD5 collision; the "SHAttered" attack against SHA-1 in 2017).

**Countermeasures:** use longer-output, modern hash functions — SHA-256, SHA-3, BLAKE2 — never MD5/SHA-1 for security-critical work.

#### 5.2.5 Side-Channel Attacks

Attacks the **physical implementation**, not the mathematics, by exploiting information leaked incidentally during cryptographic operations.

| Type | What it measures |
|---|---|
| Timing attack | How long an operation takes — e.g., a password check that returns early on the first mismatched character leaks how many leading characters were correct |
| Power analysis | Power consumption during crypto operations (relevant to smart cards, IoT devices) |
| Electromagnetic (EM) analysis | EM radiation emitted during computation |
| Acoustic analysis | Sounds produced by the device (keyboard clicks, CPU coil whine) |
| Cache attack | CPU cache access patterns, used to infer which key bytes were touched during AES |

**Countermeasure example — constant-time comparison:**
```python
# Vulnerable: exits early on first mismatch, timing leaks info
def verify(input, stored):
    for i in range(len(input)):
        if input[i] != stored[i]:
            return False
    return True

# Secure: always takes the same time regardless of where the mismatch is
import hmac
def verify(input, stored):
    return hmac.compare_digest(input, stored)
```

Other countermeasures: power masking (adding noise), cache partitioning between processes, specialized shielded hardware, random timing delays.

#### 5.2.6 Replay Attack

Intercepting a **valid** message (e.g., an authentication token or transaction) and **resending it later** to trigger an unauthorized repeat action — the message itself is genuine and correctly authenticated, so it's accepted again.

```
Alice → Bob: "Transfer $100 to Charlie" [encrypted + authenticated]
Mallory intercepts and stores it.
Mallory later resends the identical message.
Bob accepts it again (it's valid!) → Charlie is paid twice.
```

**Real-world examples:** replaying a captured WPA2 4-way handshake to gain Wi-Fi access; reusing a captured API token; replaying a payment authorization.

**Countermeasures:** timestamps (reject old messages); **nonces** ("Number used ONCE" — a unique random value per message, tracked so it can't be reused); sequence numbers; short-lived tokens (e.g., a JWT with a 15-minute expiry); one-time passwords (OTP).

#### 5.2.7 Known Plaintext Attack

The attacker already knows **part of the plaintext** and its matching ciphertext, and uses this pairing to deduce the encryption key or break the cipher.

**Historical example:** WWII cryptanalysts partially broke the Enigma cipher because they knew certain messages predictably began with standard greetings or weather-report formats — this "known plaintext" helped recover the daily key settings.

Modern ciphers (AES, RSA) resist this in general, but it can still succeed against **weak custom encryption**, **misused modes** (e.g., ECB — see 5.3.1), or flawed protocol design.

**Countermeasures:** standardized strong algorithms (AES/RSA/ECC); avoid ECB mode; use randomized initialization vectors (IVs); rotate keys regularly.

#### 5.2.8 Chosen Ciphertext Attack

The attacker can submit **arbitrary ciphertexts** to a decryption system (an "oracle") and observe its responses (success, error, partial plaintext), gradually deducing the key or the target plaintext.

**Padding Oracle Attack** (a specific, well-known chosen-ciphertext attack): exploits how a system responds to invalid **padding** in CBC (Cipher Block Chaining) mode.
- **Real example — POODLE (2014):** exploited SSL 3.0's padding handling to decrypt HTTPS cookies bit-by-bit, leading to SSL 3.0 being deprecated industry-wide.

**Countermeasures:** authenticated encryption modes (AES-GCM, AES-CCM); proper padding validation (PKCS#7 implemented correctly); generic error messages that don't reveal *why* decryption failed; modern protocols (TLS 1.3 removed many vulnerable legacy features).

### 5.3 Cryptographic Issues

Strong algorithms can still be defeated by poor **implementation**, **configuration**, or **protocol design**.

#### 5.3.1 Weak / Deprecated Algorithms

| Algorithm | Issue | Status |
|---|---|---|
| MD5 (128-bit hash) | Practical collision attacks demonstrated | ❌ Broken — legacy only |
| SHA-1 (160-bit hash) | "SHAttered" collision attack (2017) | ❌ Deprecated |
| DES (56-bit key) | Key space too small — brute-forceable in hours | ❌ Broken/obsolete |
| 3DES (168-bit, ~112-bit effective) | Slow, weaker than AES; NIST deprecated it in 2023 | ⚠ Deprecated |
| RC4 (stream cipher) | Statistical biases allow key recovery; removed from TLS 1.3 | ❌ Broken |
| ECB mode (block cipher mode) | Deterministic — identical plaintext blocks always produce identical ciphertext blocks, leaking structural patterns | ⚠ Insecure for structured data |

> **Exam Trap:** ECB should never encrypt images, files, or databases — the classic textbook example is an image of a penguin whose outline remains clearly visible after "encryption" in ECB mode, because repeated color blocks map to repeated ciphertext blocks. CBC or GCM mode hides this by chaining/randomizing each block.

**Recommended replacements:**

| Purpose | Use instead | Key size |
|---|---|---|
| Symmetric encryption | AES | 128 or 256 bits |
| Hashing | SHA-256, SHA-3, BLAKE2 | 256+ bits |
| Asymmetric encryption | RSA, ECC | RSA 2048+, ECC 256+ |
| Key exchange | Diffie-Hellman, ECDH | DH 2048+, ECDH 256+ |
| Message authentication | HMAC-SHA256, Poly1305 | 256 bits |

#### 5.3.2 Implementation Flaws

| Flaw | Problem | Fix |
|---|---|---|
| Hardcoded keys | Key embedded directly in source code — visible to anyone with code access, can't be rotated without a redeploy, frequently leaked via public repos | Load from environment variables or a secrets manager (AWS Secrets Manager, HashiCorp Vault); never commit keys to version control |
| Weak random number generation (RNG) | Using a non-cryptographic RNG (e.g., Python's `random`) for key generation — output is predictable/reproducible | Use a cryptographically secure RNG: Python `secrets`, Node's `crypto.randomBytes()`, or Linux `/dev/urandom` |
| Key reuse | Same key used for multiple purposes (e.g., both encryption and authentication) — compromising one use compromises all | Derive separate keys per purpose from a master key (e.g., via SHA-256 with a purpose label) |
| No salt in password hashing | Identical passwords → identical hashes across all users → vulnerable to precomputed rainbow tables | Use a per-user random **salt** with a slow algorithm like bcrypt, scrypt, or Argon2 |

```bash
# Linux — check available entropy (source of randomness quality)
cat /proc/sys/kernel/random/entropy_avail
# Generate a cryptographically strong random key
head -c 32 /dev/urandom | base64
openssl rand -hex 16
```

#### 5.3.3 Protocol-Level Attacks

**Downgrade attack** — the attacker forces two parties to negotiate down to a weaker protocol version or cipher than they'd normally use.
```
Client offers: TLS 1.3, TLS 1.2, TLS 1.1
Attacker (in the middle) rewrites the offer to: "only TLS 1.0"
Server agrees to TLS 1.0 → attacker now exploits TLS 1.0's known weaknesses (BEAST, POODLE)
```
**Real example — FREAK (2015):** forced servers to use deliberately weak 512-bit "export-grade" RSA keys, letting attackers decrypt HTTPS traffic.
**Countermeasure:** enforce a minimum protocol version (TLS 1.2+), drop legacy cipher/algorithm support, prefer TLS 1.3 (which removed most downgrade vectors).

**Missing/disabled certificate validation** — code that skips certificate verification makes MITM trivial, since the attacker can present *any* certificate (even self-signed) and it will be accepted.
```python
# Vulnerable
requests.get('https://bank.com', verify=False)
# Secure — verification enabled (the default)
requests.get('https://bank.com', verify=True)
```

**Padding oracle attacks** and **timing attacks** are also protocol-level concerns — already covered in 5.2.8 and 5.2.5 respectively; both are mitigated by TLS 1.3 and constant-time/authenticated-encryption implementations.

#### 5.3.4 Configuration Issues

| Issue | Risk | Check / Fix |
|---|---|---|
| Weak ciphers still enabled on the server | Allows fallback to DES, 3DES, RC4, NULL (no encryption!), or export-grade ciphers | `nmap --script ssl-enum-ciphers -p 443 target.com`; configure only strong suites (e.g., ECDHE-*-AES*-GCM-SHA*) |
| Short keys | RSA < 2048 bits or ECC < 224 bits no longer resist modern factoring/computation | `openssl s_client -connect target.com:443 \| openssl x509 -text -noout \| grep "Public-Key"` |
| No HSTS | Site doesn't force HTTPS, so a user typing `http://` can be silently intercepted before any redirect happens | Add header: `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`; check with `curl -I https://target.com \| grep -i strict-transport` |
| Self-signed certificates in production | No independent identity verification — trivial for an attacker to forge; also trains users to click through browser warnings | Use a trusted CA (Let's Encrypt, DigiCert); for internal-only systems, run a private CA and distribute the root certificate to clients |

**HSTS** = **H**TTP **S**trict **T**ransport **S**ecurity — a response header telling browsers "always use HTTPS for this site, never plain HTTP again," which closes the window where an attacker could intercept the very first unencrypted request.

```
Without HSTS: http://bank.com → browser connects over HTTP → attacker intercepts before redirect
With HSTS:    http://bank.com → browser auto-upgrades to HTTPS internally → secure from the first request
```

```bash
sudo apt install certbot
sudo certbot certonly --nginx -d yourdomain.com   # obtain a free trusted certificate
sudo certbot renew                                # auto-renewal
```

### 5.4 Quick Reference — Session 5

| Topic | Key Point | Countermeasure |
|---|---|---|
| DH Key Exchange | Creates a shared secret; no built-in authentication | Combine with digital certificates/signatures |
| MITM | Intercepts and relays/alters both sides' traffic | PKI/certificates, PSK, out-of-band verification |
| Brute Force | Tries every possible key | 128+ bit keys, rate limiting, lockouts |
| Dictionary Attack | Tries common passwords/phrases | Strong unique passwords, salting, MFA |
| Birthday Attack | Exploits hash collisions (2^(n/2) effort) | SHA-256+, avoid MD5/SHA-1 |
| Side-Channel | Leaks via timing/power/EM/cache | Constant-time code, shielding, masking |
| Replay Attack | Resends a captured valid message | Nonces, timestamps, sequence numbers, short-lived tokens |
| Known Plaintext | Deduces key from known plaintext/ciphertext pairs | Strong standard algorithms, avoid ECB, use IVs |
| Chosen Ciphertext / Padding Oracle | Learns from a decryption oracle's responses | Authenticated encryption (GCM), generic errors |
| Weak Algorithms | MD5, SHA-1, DES, RC4, ECB | AES, SHA-256/SHA-3, GCM/CBC |
| Hardcoded Keys / Weak RNG | Predictable or exposed keys | Secrets manager, `secrets`/`/dev/urandom` |
| Downgrade Attack | Forces a weaker protocol version | Enforce TLS 1.2+, prefer TLS 1.3 |
| No HSTS | Allows first-request HTTP interception | `Strict-Transport-Security` header |

### Session 5 — Viva Q&A

**Q: Why is Diffie-Hellman vulnerable to MITM, and how is this fixed in practice?**
A: DH exchanges public values but never verifies *whose* values they are — an attacker can substitute their own public key for each party's, establishing a separate shared secret with each. This is fixed by binding public keys to verified identities via digital certificates/PKI (or authenticated variants like STS/SIGMA).

**Q: Differentiate a brute force attack from a dictionary attack.**
A: Brute force tries every possible key/combination in the keyspace; a dictionary attack tries only a curated list of likely/common passwords, making it far faster against weak human-chosen passwords but ineffective against long random keys.

**Q: Why is MD5 considered broken, and what should replace it?**
A: Practical collision attacks have been demonstrated (birthday-attack effort is only ~2^64 for MD5's 128-bit output, not 2^128), enabling forged certificates and files with matching hashes. Use SHA-256, SHA-3, or BLAKE2 instead.

**Q: What is a side-channel attack? Give two examples.**
A: An attack on the physical implementation of a cryptosystem rather than its mathematics — e.g., a timing attack (inferring secret data from how long an operation takes) and a power analysis attack (inferring key bits from a device's power consumption pattern).

**Q: Why should ECB mode never be used for structured data like images or databases?**
A: ECB encrypts each block independently, so identical plaintext blocks always produce identical ciphertext blocks — this preserves visible patterns/structure in the output, defeating the purpose of encryption.

**Q: What is the difference between a replay attack and a known plaintext attack?**
A: A replay attack reuses a captured *valid, still-encrypted* message to repeat an action — the attacker never needs to break the encryption. A known plaintext attack uses a known plaintext/ciphertext *pair* to try to derive the key itself.

**Q: What does HSTS protect against, and how?**
A: It protects against protocol-downgrade/interception on the very first request to a site — the `Strict-Transport-Security` header tells the browser to always use HTTPS for that domain going forward, so it never sends an unencrypted HTTP request that an attacker could intercept.

---

## SESSION 6: Secure Hashing Methods — SHA & HMAC

### 6.1 Secure Hashing — Basic Concepts

A cryptographic hash function takes arbitrary-length input → produces a fixed-length **hash/digest/fingerprint**. Designed so it's computationally infeasible to find collisions or reverse the digest to get the input.

**Key properties:**

| Property | Meaning |
|---|---|
| Preimage resistance | Given hash h, hard to find any m such that hash(m) = h |
| Second preimage resistance | Given m1, hard to find m2 ≠ m1 with same hash |
| Collision resistance | Hard to find any m1 ≠ m2 with hash(m1) = hash(m2) |

Used for: data integrity, digital signatures, password storage, message authentication.

### 6.2 SHA — Secure Hash Algorithm Family

NSA-designed, NIST-standardized (FIPS 180 series). Variable-length input → fixed-length digest.

| Variant | Output Size | Status |
|---|---|---|
| SHA-1 | 160-bit | Weak — broken by collision attacks, deprecated |
| SHA-2 (224/256/384/512) | 224–512-bit | Strong — widely used today (TLS, certs, signatures) |
| SHA-3 (Keccak-based) | Variable | Newer alternative construction |

### 6.3 SHA-1 — Working Steps

- Processes message in **512-bit blocks** → outputs **160-bit digest**.
- Internal state: 5× 32-bit registers (A, B, C, D, E). **80 rounds** per block.

```
Message
  │
  ├─▶ 1. PAD: append '1' bit + '0's until length ≡ 448 mod 512
  │
  ├─▶ 2. APPEND LENGTH: 64-bit original length field → total = multiple of 512 bits
  │
  ├─▶ 3. INITIALIZE buffer: A,B,C,D,E = fixed hex constants
  │
  ├─▶ 4. PROCESS each 512-bit block:
  │       16 words expanded → 80 words
  │       80 steps: round function f_t, constant K_t, left-rotate,
  │       modulo-2^32 addition of message words + state
  │
  └─▶ 5. OUTPUT: concatenate final A‖B‖C‖D‖E = 160-bit digest
```

> **Exam Trap:** SHA-1's 160-bit output and 80-round structure vs SHA-256's 256-bit output — know the numbers, they're frequently tested directly.

### 6.4 SHA-2 — Characteristics

| Variant | Digest Size |
|---|---|
| SHA-224 | 224-bit |
| SHA-256 | 256-bit (most common) |
| SHA-384 | 384-bit |
| SHA-512 | 512-bit |

Similar block-based compression structure to SHA-1 but different math functions, larger internal state (8× 32-bit or 64-bit registers), more rounds. Recommended for modern use (TLS, certificates, password hashing frameworks) due to collision resistance.

### 6.5 Uses of SHA

- **File integrity checks** — compare before/after hashes
- **Digital signatures** — hash the message, then sign the digest
- **Password storage** — store hashed (+ salted) passwords
- **Protocol security** — TLS, SSH, IPsec handshake integrity, key derivation

> **Viva Point:** SHA alone gives **integrity only** — anyone can compute a hash if they know the message. It provides no authentication. That's the gap HMAC fills.

### 6.6 HMAC — Hash-based Message Authentication Code

Combines a cryptographic hash (SHA-1/SHA-256) with a **secret key** to produce a MAC — provides both **integrity AND authentication**. Standardized in FIPS 198 / NIST SP 800-224.

**Formula:**
```
HMAC_K(m) = h( (K ⊕ opad) ‖ h( (K ⊕ ipad) ‖ m ) )
```
Where:
- h = hash function (e.g. SHA-256)
- K = secret key (padded/hashed to block size as needed)
- ipad, opad = fixed hash-dependent padding constants
- ⊕ = XOR, ‖ = concatenation

**Construction steps:**
```
1. Prepare block-sized key K
2. Inner input  = (K ⊕ ipad) ‖ message
3. Inner hash   = h(inner input)
4. Outer input  = (K ⊕ opad) ‖ inner hash
5. HMAC value   = h(outer input)
```

```
   K ⊕ ipad ─┐
   message  ─┴─▶ [ HASH ] ──▶ inner digest
                                   │
   K ⊕ opad ─────────────────────┤
                                   ▼
                              [ HASH ] ──▶ HMAC value
```

**Properties:**
- Inherits collision resistance/strength of underlying hash.
- Key mixed in twice (inner + outer) → resists attacks that plain "hash(key‖message)" is vulnerable to.
- Knowing the HMAC value does NOT reveal the key or allow forging HMACs for other messages.
- Supports truncation (using part of output) per NIST-specified parameters.
- Used in: IPsec, TLS, SSH, API authentication headers, token signing.

### 6.7 SHA vs HMAC

| | SHA (plain hash) | HMAC (keyed hash) |
|---|---|---|
| Input | Message only | Message + secret key |
| Computable by | Anyone | Only key holders |
| Provides | Integrity only | Integrity + Authentication |

> **Exam Trap:** "HMAC = hash + key" is the one-line answer examiners look for. Plain SHA has NO authentication property.

### Session 6 — Viva Q&A

**Q: Why is SHA-1 no longer recommended?**
A: It's vulnerable to practical collision attacks; SHA-2 (256-bit or higher) is preferred.

**Q: What does HMAC provide that plain hashing doesn't?**
A: Authentication — because only parties holding the secret key can generate or verify a valid HMAC, whereas anyone can compute a plain hash.

**Q: Draw/explain the HMAC construction.**
A: HMAC_K(m) = h((K⊕opad) ‖ h((K⊕ipad) ‖ m)) — key is XORed with inner/outer pad constants and mixed in twice around the message hash.

---

## SESSION 7: PKI Fundamentals, Digital Signature, Digital Certificate

### 7.1 PKI — Overview

Public Key Infrastructure (PKI): a framework of roles, policies, hardware, software, and procedures to create, manage, distribute, use, store, and revoke **digital certificates** and public-key pairs. Purpose: establish **trust** by binding identities to public keys.

PKI supports: **Encryption (confidentiality), Authentication (identity proof), Data Integrity, Non-repudiation.**
Underlies: HTTPS/TLS, VPNs, secure email, code signing, government/enterprise digital signatures (Indian DSCs).

### 7.2 PKI Components

| Component | Role |
|---|---|
| Certification Authority (CA) | Trusted entity — issues, signs, revokes certificates after verifying identity |
| Registration Authority (RA) | Performs identity verification for certificate requests on behalf of CA |
| Digital Certificates (X.509) | Electronic documents binding a subject's identity to a public key |
| Private Key Tokens/Key Stores | Secure storage — smart cards, HSMs, software keystores |
| Certificate Management System (CMS) | Handles storage, publication, renewal, revocation lists |

PKI also governs **key lifecycle management**: generation, distribution, rotation, expiration, destruction.

### 7.3 PKI Working — High-Level Flow

```
 USER                          RA                        CA
  │                            │                          │
  │ 1. Generate key pair       │                          │
  │    (public + private)      │                          │
  │                            │                          │
  │ 2. Send CSR (public key +  │                          │
  │    identity attributes) ──▶│                          │
  │                            │ 3. Verify identity ─────▶│
  │                            │                          │
  │                            │        4. CA signs & creates
  │                            │           certificate
  │◀──────────── 4. Signed certificate delivered ─────────│
  │                                                        │
  │ 5. Present cert to relying parties                     │
  │    → they verify using CA's public key + trust chain   │
```

This process prevents MitM attacks in public-key systems — an attacker can't swap in a fake public key without breaking certificate validation.

### 7.4 Digital Signature — Concept & Properties

A digital signature proves **origin (authentication)**, protects **integrity**, and provides **non-repudiation** for a document/message. Uses asymmetric crypto: signer's **private key** generates the signature; corresponding **public key** verifies it.

| Property | Meaning |
|---|---|
| Authentication | Confirms document signed by holder of a specific private key |
| Integrity | Any change to signed data → verification fails |
| Non-repudiation | Signer cannot deny signing (assuming private key control was maintained) |

> **Exam Trap:** A digital signature ≠ a scanned image of a handwritten signature. It's mathematically verifiable and cryptographically bound to keys/certificates.

### 7.5 Digital Signature — Creation & Verification

```
 SIGNER (Sender)                         RECEIVER
    │                                        │
    │ 1. Hash message M → h(M)               │
    │    (e.g. SHA-256)                      │
    │                                        │
    │ 2. Sign digest with                    │
    │    PRIVATE key → Signature S           │
    │                                        │
    │ 3. Send M + S (+ certificate) ────────▶│
    │                                        │
    │                          4. Hash received M → h(M)
    │                          5. Verify S against h(M)
    │                             using signer's PUBLIC key
    │                             (from certificate)
    │                          → PASS: unchanged & authentic
    │                          → FAIL: reject
```

**Creation (sender):**
1. Hash the message: `h(M)` via SHA-256 (any small change → different digest).
2. Sign the digest with private key → produces signature S.
3. Send M + S (+ certificate) to receiver.

**Verification (receiver):**
1. Recompute `h(M)` on the received message.
2. Use signer's public key (from certificate) to verify S matches h(M).
3. Pass → message unchanged, signed by the private-key holder.

This gives integrity + authenticity WITHOUT sharing any secret key between parties.

### 7.6 PKI-Based Digital Signatures — India Context

- Indian **Digital Signature Certificates (DSC)** electronically prove public-key ownership and legally sign documents (e-filing, e-tenders, contracts).
- DSC contains: subscriber info (name, org), public key, CA's digital signature → legally recognized digital identity.
- Certificate **classes** (1, 2, 3) offer varying identity-verification rigor per legal/regulatory need.

### 7.7 Digital Certificate — Concept

A digital certificate is a document attesting that a **public key belongs to a named entity** ("subject X owns public key Y"). Issued and signed by a CA, whose signature lets others trust the binding. Standard format: **X.509** (ITU-T), used in SSL/TLS, IPsec, S/MIME.

### 7.8 X.509 Certificate — Structure

| Field | Purpose |
|---|---|
| Version | v1/v2/v3 — format version |
| Serial number | Unique number assigned by issuer |
| Signature algorithm ID | e.g. SHA256withRSA |
| Issuer name | CA's Distinguished Name (DN) |
| Validity period | Not-Before / Not-After dates |
| Subject name | DN of the certificate owner |
| Subject public key info | Public key + algorithm parameters |
| Issuer/subject unique IDs | v2/v3 disambiguation |
| Extensions (v3) | KeyUsage, ExtendedKeyUsage, CertificatePolicies, SubjectAltName |
| Issuer's digital signature | Signs all above fields → authenticity + integrity |

> **Viva Point:** v3 extensions let a certificate specify exactly HOW the key may be used (signing, encryption, key agreement) — this is what enables things like TLS server certs vs code-signing certs to be technically distinguished.

### 7.9 Certificate Lifecycle & Trust Chains

- **Issuance** — CA signs after verification.
- **Publication** — stored in directories/databases for relying-party retrieval.
- **Validation** — clients check signature, validity period, revocation status (CRL/OCSP).
- **Revocation** — compromised/invalid certs added to CRL or flagged via OCSP.

**Trust chain:** End-entity cert → signed by Intermediate CA → signed by Root CA. Clients trust root CAs and validate the chain upward.

### 7.10 How It All Fits Together

- PKI manages key pairs + certificates, binding public keys correctly to identities.
- A **digital certificate** lets recipients trustworthily obtain a signer's public key + identity info.
- A **digital signature** uses the signer's private key (matching the certificate's public key) to protect documents; recipient verifies with the certificate's public key.

### Session 7 — Viva Q&A

**Q: What's the difference between a digital signature and a digital certificate?**
A: A digital signature is a cryptographic proof of authorship/integrity applied to a specific message using a private key. A digital certificate is a CA-issued document binding a public key to an identity — it's what lets others trust and obtain the public key needed to verify signatures.

**Q: Why hash before signing instead of signing the whole message?**
A: Hashing produces a small fixed-size digest, making the signing operation (asymmetric crypto is slow) fast and efficient regardless of message size, while still uniquely representing the content.

**Q: What are X.509 v3 extensions used for?**
A: To specify additional certificate attributes and constraints — e.g., allowed key usage, subject alternative names, certificate policies — giving flexibility beyond the basic identity+key binding.

---

## SESSION 8: CA, Trust Models, Certificate Issuance, Revocation, Types & Classes

### 8.1 Certification Authority (CA)

A CA is a trusted organization/server that issues, signs, manages, and revokes digital certificates, binding verified identities to public keys — acting as a **trusted third party**.

**Core CA responsibilities:** identity validation, certificate issuance/signing, publication, revocation management, renewal, protection of CA private keys.

CA types:
- **Public commercial CA** (web SSL, document signing)
- **Internal enterprise CA** (e.g. Microsoft AD CS)

Before issuing, CA verifies the applicant genuinely controls the domain/email/organizational identity — depth of verification varies by certificate type.

### 8.2 PKI Trust Models

A trust model defines how entities decide whether to trust a certificate and which CAs can vouch for whom.

```
 HIERARCHICAL (Single-Root)          MESH (Web-of-Trust)
                                     
        [Root CA]                    [CA1]◀──▶[CA2]
         /      \                       ▲  ✕    ▲
   [Int CA1]  [Int CA2]                 │  ✕    │
      │           │                  [CA3]◀──▶[CA4]
  [End-entity] [End-entity]         (all cross-certify pairwise)


 BRIDGE CA
                  [Bridge CA]
                 /      |     \
          [Org-CA-A] [Org-CA-B] [Org-CA-C]
              │           │           │
          [Entity]    [Entity]    [Entity]
```

**Hierarchical (Single-Root)**
- One Root CA signs Intermediate CAs, which issue end-entity certificates.
- Clients validate by building a chain up to a trusted root in their trust store.
- **Pros:** simple, scalable, centralized control — dominant model for public web PKI (browsers/OS embed roots).
- **Cons:** Root CA = single point of failure; if compromised, mass reissuance/redistribution needed.

**Mesh / Web-of-Trust**
- Multiple independent CAs **cross-certify** each other; any CA can vouch for another.
- Peer-oriented, federated, no central authority.
- **Cons:** complexity grows fast — each new CA needs cross-certification with every existing CA (≈ n² relationships); governance/chain-discovery harder.

**Bridge CA**
- A Bridge CA hub connects multiple hierarchical PKIs; each participating CA cross-certifies with the Bridge, not with each other directly.
- Enables cross-domain trust chains: *Entity → Org-CA → Bridge CA → Other-Org-CA → Entity*.
- Reduces cross-certificate count but creates a critical dependency on Bridge CA availability/security.

> **Exam Trap:** Mesh model complexity scales as O(n²) cross-certifications; Bridge CA reduces this by centralizing cross-certification through one hub — a common comparison question.

### 8.3 Certificate Issuance Process

```
Applicant                RA                       CA
   │                      │                        │
   │ 1. Generate keypair  │                        │
   │    + create CSR      │                        │
   │──────────────────────▶                        │
   │                      │ 2. Verify identity      │
   │                      │    (KYC, domain, docs)  │
   │                      │────────────────────────▶│
   │                      │                         │ 3. Approve →
   │                      │                         │    generate X.509 cert
   │                      │                         │ 4. CA signs with
   │                      │                         │    its private key
   │◀──────────────────── 5. Deliver signed cert ───│
   │                      │                         │
   │ 6. Install cert +    │                         │
   │    private key in    │                         │
   │    keystore/HSM      │                         │
```

**Steps:**
1. **Application/CSR Submission** — applicant generates key pair, creates a **Certificate Signing Request (CSR)** with public key + identity (CN, org, email); submits with KYC/business docs to CA/RA.
2. **Identity Verification (RA)** — RA validates identity per the CA's Certificate Policy (CP) / Certification Practice Statement (CPS): domain validation, email challenge, business license/PAN/Aadhaar checks (India), etc.
3. **Approval & Generation** — RA approves → CA's certificate management system generates the X.509 cert (public key, identity fields, validity, usage constraints).
4. **Signing & Publication** — CA signs with its private key → verifiable identity↔key binding; may publish to directories/logs (AIA, Certificate Transparency); delivers to applicant.
5. **Installation & Use** — holder installs cert + private key (web server, smart card, HSM, user profile); relying parties verify chain + revocation status during use (HTTPS, VPN, signing).

### 8.4 Certificate Revocation — CRL and OCSP

Certificates may need revoking before expiry (key compromise, identity change, policy termination).

**CRL (Certificate Revocation List)**
- Periodically published, **signed list** of revoked certificate serial numbers from the CA.
- Clients download from CRL Distribution Point URLs (cert extension) and check serial numbers.
- **Limitation:** can grow large; infrequent updates → delayed revocation awareness.

**OCSP (Online Certificate Status Protocol)**
- **Real-time** online status check — client queries an OCSP responder with a cert's serial number.
- Responder returns a signed status: **GOOD / REVOKED / UNKNOWN**.
- Faster, more bandwidth-efficient than downloading full CRLs.
- **OCSP Stapling**: server fetches a fresh OCSP response from the CA and "staples" it into the TLS handshake → reduces client-side latency and privacy leakage (client doesn't have to query the CA directly).

| | CRL | OCSP |
|---|---|---|
| Type | Periodic, downloaded list | Real-time query/response |
| Bandwidth | Higher (full list) | Lower (single query) |
| Timeliness | Can be stale | Real-time |
| Privacy | Better (no per-check query to CA) | Weaker unless stapled |

> **Viva Point:** OCSP stapling exists specifically to fix OCSP's privacy/latency weakness — the server, not the client, talks to the CA.

### 8.5 Types and Classes of Certificates

**Technical Types (usage-based):**

| Type | Purpose |
|---|---|
| Server (TLS/SSL) Certificate | Authenticates websites, enables HTTPS |
| Client/User Certificate | User authentication, S/MIME email, VPN access |
| Code Signing Certificate | Signs software/drivers/scripts to verify publisher + integrity |
| Document Signing Certificate | Legally signs PDFs/office docs (often via DSC tokens in India) |

Key usage / extended key usage extensions explicitly declare allowed operations (digitalSignature, keyEncipherment, codeSigning, etc.).

**Validation Levels — Web SSL (DV/OV/EV):**

| Level | Verification Depth | Notes |
|---|---|---|
| **DV** (Domain Validation) | Domain control only (DNS/HTTP challenge, email) | No org identity verified |
| **OV** (Organization Validation) | Domain + basic business info (registration, phone, address) | Org name shown in subject |
| **EV** (Extended Validation) | Rigorous legal existence + operational presence checks | Highest assurance; historically special browser UI |

**Indian DSC Classes:**

| Class | Use Case | Status |
|---|---|---|
| **Class 1** | Basic, non-commercial individual authentication; validates name/email only | Not valid for official document signing |
| **Class 2** | Previously used for income tax/GST/MCA filings; required PAN/Aadhaar/company docs | **Discontinued** for statutory filings per updated CCA guidelines |
| **Class 3** | Highest security/legal assurance; mandatory for most government e-filing, e-tendering, high-value transactions | **Current primary standard**; requires personal/video-based verification |

DSCs are also classified functionally as **Sign**, **Encrypt**, or **Sign & Encrypt**, by user type (individual/organization), with typical validity of 1–3 years.

> **Exam Trap:** Class 2 DSC is **deprecated/discontinued** for regulatory filings — a frequently updated fact examiners like to test to check if notes are current.

### Session 8 — Viva Q&A

**Q: Compare CRL and OCSP.**
A: CRL is a periodically published signed list of revoked certificate serials, checked by the client locally — can be large and stale. OCSP is a real-time query/response protocol giving immediate GOOD/REVOKED/UNKNOWN status, more bandwidth-efficient; OCSP stapling further improves latency and privacy.

**Q: Explain the Hierarchical trust model and its main weakness.**
A: A single Root CA signs Intermediate CAs which issue end-entity certificates; clients validate by chaining up to a trusted root. Weakness: the Root CA is a single point of failure — its compromise forces mass reissuance across the entire hierarchy.

**Q: Differentiate DV, OV, and EV certificates.**
A: DV only verifies domain control; OV additionally verifies basic organizational details; EV performs the most rigorous legal/operational identity checks, offering the highest assurance level.

**Q: Why was Class 2 DSC discontinued?**
A: Updated CCA (Controller of Certifying Authorities) guidelines in India phased it out in favor of Class 3, which mandates stronger identity verification for statutory/regulatory filings.

---

## SESSION 9: Aadhaar e-Sign and Time Stamping Services

### 9.1 Introduction to Aadhaar

**Aadhaar** is a 12-digit unique identity number issued by UIDAI to Indian residents, based on biometric + demographic data collected at enrollment. Widely used for **e-KYC (electronic Know Your Customer)** — online identity verification for banking, government services, telecom, digital signatures.

Aadhaar e-KYC provides identity/address proof electronically → paperless workflows (Digital India). PKI services like **e-Sign** leverage Aadhaar e-KYC to authenticate users before issuing short-lived digital signature certificates per signing transaction.

### 9.2 Aadhaar e-Sign — Concept & Legal Status

**Aadhaar e-Sign**: government-prescribed method to digitally sign electronic documents using Aadhaar e-KYC — **no physical USB token/smart card needed**.

- Legal/evidentiary value **equivalent to handwritten signatures** under the **IT Act, 2000**, when used via licensed CAs and e-Sign providers.
- Designed to scale to the entire population by eliminating in-person paper KYC and hardware token distribution.
- Infrastructure: **UIDAI + CCA (Controller of Certifying Authorities)**, implemented via **e-Sign Service Providers (ESPs)** and **Application Service Providers (ASPs)**.

### 9.3 e-Sign Platform (e-Hastakshar)

- **e-Sign (e-Hastakshar)**: Government-approved digital signature platform, integrated via API into service-delivery applications.
- Uses Aadhaar e-KYC to let citizens sign forms/documents anytime, anywhere (PC/laptop/mobile), in legally acceptable form.
- **CDAC** provides e-Sign under the name **e-Hastakshar** — one of the government-approved e-Sign platforms.
- CCA licenses/regulates CAs issuing short-validity DSCs used in e-Sign transactions, ensuring IT Act compliance.

**Key features:** e-KYC authentication (OTP/biometric), immediate key destruction after one-time use, full audit trails, privacy (signs document **hash** only, not full document).

### 9.4 Traditional DSC vs Aadhaar e-Sign

| | Traditional DSC | Aadhaar e-Sign |
|---|---|---|
| Medium | USB cryptographic token, long-validity cert | Short-validity, **one-time** DSC generated at signing moment |
| Issuance | Physical presence + paper KYC | Aadhaar e-KYC (OTP/biometric) — remote |
| Key storage | On user's token, user manages security/drivers | On HSM backend servers, deleted immediately after use |
| Scalability | Poor (doesn't scale to billions) | Excellent — no hardware distribution needed |
| Security | PKI-grade | PKI-grade, equally auditable & legally recognized |

> **Exam Trap:** Aadhaar e-Sign does NOT eliminate PKI — it still issues a real (short-lived) DSC and uses standard PKI signing; it just removes the hardware-token requirement.

### 9.5 Aadhaar e-Sign — Process Flow

```
 USER              ASP                    ESP                    UIDAI/CA
  │                 │                      │                        │
  │ 1. Fill form/   │                      │                        │
  │    upload doc ─▶│                      │                        │
  │                 │ 2. Show e-Sign option,│                       │
  │                 │    capture Aadhaar # +│                       │
  │                 │    consent            │                       │
  │                 │───────────────────────▶                       │
  │                 │                      │ 3. Aadhaar e-KYC       │
  │                 │                      │    (OTP/biometric) ───▶│
  │                 │                      │◀── e-KYC response ─────│
  │                 │                      │    (identity confirmed)│
  │                 │ 4. Send DOCUMENT HASH │                        │
  │                 │    (not full doc) ───▶│                        │
  │                 │                      │ 5. Generate short-lived│
  │                 │                      │    DSC + private key   │
  │                 │                      │    in HSM (one-time)   │
  │                 │                      │ 6. Sign hash w/ private│
  │                 │                      │    key → destroy key   │
  │                 │◀── PKCS#7 signature ──│                        │
  │                 │    + cert chain       │                        │
  │                 │ 7. Bind signature to  │                        │
  │                 │    document, store,   │                        │
  │◀── signed copy ─│    provide to user    │                        │
```

**Steps:**
1. **User Initiation via ASP** — user interacts with an Application Service Provider (bank, demat portal, govt site), fills form/uploads document; ASP captures Aadhaar number + consent.
2. **Authentication via Aadhaar e-KYC** — ASP → ESP → UIDAI e-KYC (OTP to registered mobile or biometric); UIDAI verifies and returns confirmation.
3. **Hashing & Short-Term DSC Issuance** — ASP sends only the **document hash** (privacy); on successful e-KYC, ESP/CA generates a short-lived DSC + private key in an HSM, valid for that transaction only.
4. **Signing & Response** — ESP signs the hash with the generated private key, returns a **PKCS#7 signature container** (signature + cert chain) to the ASP; keys destroyed immediately; audit logs maintained.
5. **Document Assembly & Storage** — ASP binds signature to the original document, stores it, delivers signed copies.

### 9.6 Use Cases of Aadhaar e-Sign

- **Financial services** — online account opening, loan applications, KYC forms
- **Demat/trading accounts** — mandatory e-Sign for digital onboarding (SEBI guidelines)
- **E-governance** — DigiLocker self-attestation, certificate applications (birth/caste/marriage), driving license/vehicle registration
- **Business/HR** — inter-department approvals, B2B contracts, vendor agreements

### 9.7 Time Stamping Services — Concept

A **time stamping service** cryptographically proves that specific data (document/hash/code) existed at a particular point in time. Implemented by a **Time Stamping Authority (TSA)** issuing signed timestamp tokens per **IETF RFC 3161**.

> **Viva Point:** A digital signature proves WHO signed and that content is unchanged; a timestamp additionally proves WHEN — critical for legal/regulatory/long-term validation, especially after a signing certificate later expires or is revoked.

### 9.8 Time Stamping Authority (TSA) — Function

A TSA:
- Receives **timestamp requests** containing a hash of the data.
- Associates a precise time (from secure NTP/UTC sources) with that hash.
- Produces a **timestamp response**: signed object binding data hash + time + TSA identity + policy info.
- Logs all operations for audit; monitors time sources to avoid drifted/unsynchronized timestamps.
- Supports RFC 3161 protocol, HSM key protection, ETSI/eIDAS compliance for qualified timestamps.

```
Signing App                         TSA
    │                                 │
    │ 1. Hash document                │
    │ 2. Send hash ──────────────────▶│
    │                                 │ 3. Bind hash + trusted time
    │                                 │    + TSA identity, sign it
    │◀──── 4. Timestamp token ────────│
    │                                 │
    │ 5. Embed token alongside        │
    │    digital signature in doc     │
```

### 9.9 Why Timestamping Matters

- **Proof of existence** — document/code existed at a specific time (IP protection, filing deadlines).
- **Signature validity after expiry/revocation** — proves the signature was applied while the cert was still valid, even if the cert is later revoked/expired.
- **Compliance/audit** — required in financial, healthcare, government sectors where signing time is legally significant.

Verification: client checks both the signature AND the timestamp token, confirming document content, signer identity, and signing time are all trustworthy and consistent.

### Session 9 — Viva Q&A

**Q: How does Aadhaar e-Sign differ from a traditional DSC on a USB token?**
A: Aadhaar e-Sign issues a short-validity, one-time DSC generated at the moment of signing via Aadhaar e-KYC (OTP/biometric), with keys held in an HSM and destroyed after use — no physical token or in-person KYC needed, unlike traditional DSCs.

**Q: Why does e-Sign only transmit the document hash, not the full document, to the ESP?**
A: To preserve privacy — the ESP only needs the hash to sign it; sending the full document would unnecessarily expose its contents to a third party.

**Q: What problem does a timestamp solve that a digital signature alone doesn't?**
A: It proves WHEN the data was signed/existed, allowing signature validity to be verified even after the signing certificate expires or is revoked later.

---

## SESSION 10: Public Key Cryptography Standards — PKCS & FIPS 140-2

### 10.1 PKCS — Overview

**PKCS (Public Key Cryptography Standards)**: a family of interoperable specifications for implementing public-key cryptography and PKI, originally developed by RSA Laboratories. Define formats for keys, certificates, messages, token interfaces, and requests → interoperability across products/platforms.

First published early 1990s; many later adopted/updated as IETF RFCs (PKCS#1 → RFC 3447/8017; PKCS#7 → CMS/S/MIME). Underpins: storing keys in files, CSR creation, signing/encrypting email, HSM/smart card interfacing.

### 10.2 Key PKCS Standards

| Standard | Name | Purpose |
|---|---|---|
| **PKCS #1** | RSA Cryptography Standard | Defines RSA key math/formats; padding schemes: RSAES-PKCS1-v1_5, RSAES-OAEP (encryption); RSASSA-PKCS1-v1_5, RSASSA-PSS (signatures). Essential for RSA key formats (ASN.1) and avoiding padding vulnerabilities (e.g. Bleichenbacher's attack) |
| **PKCS #3** | Diffie–Hellman Key Agreement | DH key exchange with public-key syntax — deriving shared secret over insecure channel |
| **PKCS #5** | Password-Based Encryption (PBE) | Password-based key derivation/encryption incl. **PBKDF2** — derives keys from passwords using salt + iteration count; protects private keys / PKCS#12 containers |
| **PKCS #7** | Cryptographic Message Syntax (CMS) | Syntax for signing/encrypting messages; basis for **S/MIME** and CMS (RFC 5652); supports signatures, enveloped/encrypted messages; used as response to PKCS#10 requests and container for cert chains/CRLs |
| **PKCS #8** | Private-Key Information Syntax | Standard portable ASN.1 syntax for storing private (± public) keys, encrypted or not. Used in PEM "BEGIN PRIVATE KEY" vs "BEGIN RSA PRIVATE KEY" formats |
| **PKCS #9** | Selected Attribute Types | Attribute types (email, challenge password, extended cert attributes) used with PKCS #6/7/8/10 |
| **PKCS #10** | Certification Request Standard | Structure of **CSRs** sent to CAs — subject's public key + DN + optional attributes + self-signature. This is your `.csr` file format |
| **PKCS #11** | Cryptographic Token Interface ("Cryptoki") | Standard **API** for interacting with smart cards/HSMs — key generation, encrypt/decrypt, signing, RNG — vendor-independent. Important when working with FIPS 140-2 compliant HSMs |
| **PKCS #12** | Personal Information Exchange (PFX) | Container format storing private keys + certs (password-protected); `.pfx`/`.p12` files; can hold multiple certs (user + intermediate + root); used for client auth, cert migration |
| **PKCS #15** | Cryptographic Token Information Format | How key/cert info is stored ON tokens, independent of API — lets apps discover available keys/certs on smart cards without vendor-specific knowledge |

> **Exam Trap:** Memorize the numbers → common exam ask: "list PKCS #1, #5, #7, #10, #11, #12 with one-line descriptions." These six are the most frequently tested.

**Why PKCS matters:** consistent data formats (keys, CSRs, messages, containers) → interoperability across vendors; defines key APIs/workflows (CSR via #10, CMS via #7, token interface via #11, key/cert bundles via #12); forms the foundation of modern PKI, S/MIME, TLS, code signing, secure key storage.

### 10.3 FIPS 140-2 — Overview

**FIPS 140-2**: U.S. Federal Information Processing Standard specifying **security requirements for cryptographic modules** protecting sensitive but unclassified information in government/regulated environments. Covers both technical and physical security of how crypto hardware/software modules are designed, implemented, tested.

Published 2001; later superseded by FIPS 140-3, but many modules/programs still reference FIPS 140-2 validated implementations.

### 10.4 Cryptographic Module & Validation Program

- **Cryptographic module**: set of hardware/software/firmware/hybrid components implementing crypto functions (encryption, hashing, key management).
- **CMVP (Cryptographic Module Validation Program)**: run by NIST (US) + CSE (Canada) — tests modules against FIPS 140-2, publishes validation certificates.
- Standard covers **11 security requirement areas**, each individually rated Level 1–4; overall rating derived from these, though specific area ratings (e.g. physical security) may matter more than the overall score depending on deployment.

### 10.5 FIPS 140-2 — Security Levels

```
 LEVEL 1              LEVEL 2                LEVEL 3                 LEVEL 4
 Basic Security       Tamper-Evidence        Tamper-Resistance        Environmental
 ─────────────        ─────────────          ──────────────          Protection
 Approved algos,      + tamper-evident        + tamper-RESISTANT      + detects/responds
 basic production-    seals/coatings          (epoxy encasement,      to environmental
 grade components,    + role-based auth       key zeroization         attacks (voltage,
 no physical          (user/operator          on compromise)          temperature, EM)
 security measures    roles)                  + identity-based auth   Highest assurance,
                                               on key entry/output     hostile environments
```

| Level | Focus | Typical Use |
|---|---|---|
| **1 — Basic** | Approved algorithms, basic components, no physical security | Software modules on general-purpose OS |
| **2 — Tamper-Evidence** | Physical tamper-evident features + role-based authentication | Entry-level hardware modules |
| **3 — Tamper-Resistance** | Resists tampering (epoxy, key zeroization on compromise), identity-based auth | **HSMs commonly target this level** |
| **4 — Environmental Protection** | Detects/responds to environmental attacks (voltage, temp, EM anomalies) | High-assurance/defense/critical infrastructure |

> **Viva Point:** HSMs typically target **FIPS 140-2 Level 3** — this specific fact is commonly asked.

### 10.6 FIPS 140-2 — 11 Security Requirement Areas

- Cryptographic module specification and interfaces
- Roles, services, and authentication
- Physical security
- Operational environment / software-firmware security
- Key management (generation, entry/output, storage, zeroization)
- Self-tests and error handling
- Design assurance (documentation, configuration management)
- Mitigation of other attacks (side-channel, etc.)

Modules must use approved algorithms (Annex A), approved RNGs (Annex C), approved key establishment mechanisms (Annex D).

### 10.7 PKCS ↔ FIPS 140-2 Relationship

- **PKCS** = formats, APIs, protocols for USING public-key crypto (RSA, DH, key stores, CSRs, message syntax).
- **FIPS 140-2** = security ASSURANCE requirements for the MODULES that implement these operations (libraries, HSMs, tokens).

| Example | Relationship |
|---|---|
| HSM exposing PKCS #11 API | May be FIPS 140-2 Level 3 validated — hardware/firmware meets government security requirements |
| Software implementing PKCS #1 RSA | Must use FIPS-approved algorithms/modes when operating in a FIPS environment |
| PKCS #12 files storing keys | Should be handled only by FIPS-validated modules for secure storage/password protection |

### Session 10 — Viva Q&A

**Q: What is the difference between PKCS #7 and PKCS #10?**
A: PKCS #10 defines the format of a Certificate Signing Request (CSR) sent TO a CA; PKCS #7 (CMS) defines the syntax for signed/encrypted messages and is often used as the format of the response FROM the CA (and for S/MIME).

**Q: What FIPS 140-2 level do HSMs typically target and why?**
A: Level 3 — it requires tamper-resistance (not just tamper-evidence) and identity-based authentication, appropriate for hardware devices protecting private keys.

**Q: Differentiate PKCS #11 and PKCS #12.**
A: PKCS #11 (Cryptoki) is an API for interacting with cryptographic tokens (HSMs/smart cards); PKCS #12 (PFX) is a file container format for storing private keys and certificates together, password-protected.

---

## SESSION 11: Strong Authentication, SFA/MFA, SSO, OpenID/OAuth, Graphical Passwords

### 11.1 Strong Authentication

**Strong authentication**: an identity-verification method robust enough to withstand realistic attacks. Usually involves **two or more independent factors** and often cryptographic protocols avoiding transmission of reusable secrets (like plain passwords).

**Three factor categories:**

| Factor | Examples |
|---|---|
| Something you **know** | Password, PIN, passphrase, security question answers |
| Something you **have** | Hardware token (YubiKey), smart card, mobile OTP app, SMS OTP (weaker) |
| Something you **are** | Fingerprint, face, iris, voice, behavioral traits (typing rhythm) |

Strong authentication often uses **challenge-response or public-key mechanisms** (FIDO/WebAuthn, PKI smart cards) so secrets aren't sent over the network — reduces credential theft/replay risk. Regulatory example: EU PSD2 "Strong Customer Authentication" legally requires ≥2 independent factors from different categories for high-risk operations (online payments).

### 11.2 Single-Factor vs Multi-Factor Authentication

```
   SFA                              MFA
┌──────────┐                  ┌───┐  ┌───┐  ┌───┐
│ Password │  ──▶ ACCESS       │Pwd│ +│OTP│ +│Bio│ ──▶ ACCESS
└──────────┘                  └───┘  └───┘  └───┘
 One layer                    Two+ INDEPENDENT layers
 Compromise = full breach     One factor compromised ≠ full breach
```

**SFA (Single-Factor Authentication)**
- Only one credential type — typically username + password.
- Simple, fast, but low security — compromise of the one factor (phishing, brute force, keylogging) = full access.
- Attack vectors: shoulder surfing, phishing pages, dictionary/brute-force, credential stuffing.

**MFA (Multi-Factor Authentication)**
- Two or more distinct factors (knowledge, possession, inherence, sometimes context).
- Even if one factor compromised, attacker still blocked by the others.
- Examples: password + OTP app; password + fingerprint; smart card + PIN + device-risk check.
- **2FA** = special case of MFA with exactly two factors (e.g. password + SMS OTP/app code).

> **Exam Trap:** SMS OTP as a "possession" factor is considered **weaker** than app-based OTP or hardware tokens due to SIM-swap risks — a nuance examiners like to probe.

### 11.3 Single Sign-On (SSO)

**SSO**: user logs in **once** and gains access to multiple applications/services without re-entering credentials. Relies on a central **Identity Provider (IdP)** authenticating the user, issuing tokens/assertions consumed by various **Service Providers (SPs)**.

**SSO Flow:**
```
  User                    SP (App)                   IdP
   │                         │                         │
   │ 1. Access app ─────────▶│                         │
   │                         │ 2. Redirect/auth req ──▶│
   │                         │                         │ 3. Authenticate
   │                         │                         │    (password, MFA)
   │                         │                         │    establish session
   │                         │◀── 4. Auth token/assertion (SAML/JWT) ──│
   │                         │ 5. Validate token,      │
   │                         │    grant access          │
   │◀── Access granted ──────│                         │
   │                         │                         │
   │ [User visits SP2 — reuses IdP session, no re-login]│
```

Tokens stored as browser cookies or passed via redirects, carrying identity claims (username, email, roles). Protocols: **SAML** (XML-based assertions), **OpenID Connect** (OAuth 2.0-based tokens), often combined with **OAuth** for authorization.

**Benefits:** reduced password fatigue → stronger credentials; improved productivity; fewer helpdesk password-reset tickets; stronger security (centralized auth, simplified MFA rollout, less password reuse); better visibility/control for IAM policy enforcement.

### 11.4 OpenID vs OAuth vs OpenID Connect

| | OpenID | OAuth | OpenID Connect (OIDC) |
|---|---|---|---|
| Purpose | **Authentication** (who you are) | **Authorization** (what you can access) | Authentication, built on OAuth 2.0 |
| Output | Identity assertion | Access token | ID token (JWT) + access token |
| Password exposure | Only to the IdP | Not shared with client app | Only to the IdP |

**OpenID (Authentication)**
- User authenticates once with a trusted IdP (e.g. Google); relying sites delegate authentication to it.
- Password given only to IdP — relying parties never see it.
- Relying Parties (RPs) receive identity assertions, trusted via IdP's signature.
- Has largely evolved into **OpenID Connect**.

**OAuth (Authorization)**
- NOT an authentication protocol — an **authorization framework**.
- Lets a user grant a third-party app **limited access** to their resources on a service (e.g. photo app accessing Facebook pictures) **without sharing credentials**.
- Resource server holds data; client (third-party app) wants access; user approves a **scope**; client receives an **access token** to present to the API.
- Assumes authentication happens elsewhere — focuses purely on token-based permissions.

**OpenID Connect (OIDC)**
- Combines OpenID's authentication concept with OAuth 2.0, using **ID tokens (JWTs)** to convey identity alongside OAuth access tokens.
- Widely used for SSO and social login ("Sign in with Google").

> **Exam Trap:** "OpenID/OIDC → authentication; OAuth → authorization." This one-line distinction is the single most commonly tested fact in this section.

### 11.5 Graphical Passwords

Authentication schemes where users select/draw/recognize images or visual patterns instead of (or with) text passwords — leverages human memory strength for images/spatial patterns.

```
        GRAPHICAL PASSWORDS
               │
      ┌────────┴────────┐
      ▼                  ▼
RECOGNITION-BASED    RECALL-BASED
Pick your images     Reproduce a drawn
from decoys          pattern/sequence
(Passfaces, icons)   (DAS, PassPoints,
                      grid patterns)
```

**Recognition-Based**
- User must recognize images chosen at registration, among decoys, at login.
- **Passfaces** — register by choosing human faces; login = identify own faces from grids of decoys.
- **Image portfolios** — select icons/pictures; login = pick own icons from larger sets.
- Reduces text-based attacks (dictionary/brute-force) but vulnerable to **shoulder surfing** if choices are visible.

**Recall-Based**
- User must reproduce a pattern/drawing created at registration.
- **DAS (Draw-A-Secret)** — draw a picture on a grid; login = redraw on same grid (converted to coordinate sequence).
- **Grid-based patterns** — like Android unlock patterns (connect dots in order).
- **PassPoints** — click specific points on a single image, in correct sequence.
- Large theoretical password space, but users often pick simple/predictable shapes, reducing effective security.

**Advantages:** exploit human image/spatial memory; more resistant to text-dictionaries and keyboard brute-force.
**Challenges:** usability vs security trade-off (predictable choices); shoulder-surfing vulnerability; custom UI implementation complexity.

### Session 11 — Viva Q&A

**Q: Why is MFA more secure than SFA?**
A: MFA requires two or more independent factors from different categories (know/have/are); compromising just one factor (e.g. a stolen password) is insufficient for access, unlike SFA where one compromised credential grants full entry.

**Q: What's the core distinction between OpenID and OAuth?**
A: OpenID (and OpenID Connect) handles authentication — proving who the user is; OAuth handles authorization — granting a third party limited, delegated access to resources without sharing credentials.

**Q: Name the two categories of graphical passwords with one example each.**
A: Recognition-based (e.g. Passfaces — identify your registered faces among decoys) and recall-based (e.g. DAS — redraw a secret pattern on a grid).

---

## SESSION 12: Authentication Protocols, FIDO Authentication, Zero Trust Architecture

### 12.1 Authentication Protocols — Overview

Define the exact sequence of messages/cryptographic operations used to prove identity between clients, servers, authentication services. Different protocols suit different environments (enterprise domains, network access, wireless, VPN, web apps).

### 12.2 Kerberos (Ticket-Based Authentication)

Avoids sending passwords over the network by using encrypted **tickets** issued by a **Key Distribution Center (KDC)**. In Active Directory, the KDC runs on domain controllers using symmetric crypto for time-limited tickets.

```
 CLIENT                         KDC                        SERVICE
   │                             │                             │
   │ 1. AS-REQ (identity) ──────▶│                             │
   │◀── AS-REP (TGT + session key,                             │
   │    encrypted with pwd hash) │                             │
   │                             │                             │
   │ 2. TGS-REQ (using TGT) ────▶│                             │
   │◀── TGS-REP (service ticket, │                             │
   │    encrypted w/ svc key)    │                             │
   │                             │                             │
   │ 3. AP-REQ (present service ticket) ───────────────────────▶│
   │◀───────────── AP-REP (mutual auth, optional) ──────────────│
```

**Flow:**
1. Client → KDC: **AS-REQ** with identity; KDC → **AS-REP**: **Ticket Granting Ticket (TGT)** + session key (encrypted with user's password hash).
2. Client uses TGT → **TGS-REQ**; KDC → **TGS-REP**: service ticket (encrypted with service account key).
3. Client presents service ticket to target service via **AP-REQ**; service validates, may respond **AP-REP** for mutual authentication.

**Security properties:** password never sent in cleartext; tickets time-limited; mutual authentication possible.
**Weaknesses:** depends on KDC secrets (KRBTGT hash) and time synchronization; compromise → "**Golden Ticket**" and "**Silver Ticket**" attacks.

### 12.3 RADIUS

**RADIUS**: centralized **AAA** (Authentication, Authorization, Accounting) for network access (VPN, Wi-Fi 802.1X, dial-up). Uses **UDP** (ports 1812/1813, legacy 1645/1646); clients (NAS) forward credentials to RADIUS server consulting AD/LDAP.

- Encrypts **only the password field** (shared secret + MD5) — other fields (username, attributes) in cleartext.
- Widely used for WPA2-Enterprise Wi-Fi, VPN gateways, ISP access.

### 12.4 TACACS+

Cisco's proprietary AAA protocol for **network device administration** (router/switch login). Runs over **TCP port 49**, encrypts the **entire packet body** (stronger than RADIUS).

| | RADIUS | TACACS+ |
|---|---|---|
| Transport | UDP | TCP (port 49) |
| Encryption | Password field only | Entire packet body |
| AAA handling | Combines auth + authz | Separates auth, authz, accounting |
| Typical use | End-user network access | Infrastructure device management (command-level control) |

> **Exam Trap:** RADIUS encrypts only the password; TACACS+ encrypts the whole packet — this is the #1 differentiator asked in exams.

### 12.5 FIDO Authentication — Passwordless, Phishing-Resistant

**FIDO (Fast IDentity Online)**: FIDO Alliance open standards enabling strong, phishing-resistant authentication using **public-key cryptography** instead of shared passwords. **FIDO2** (WebAuthn + CTAP) underpins modern **passkeys**.

| Component | Role |
|---|---|
| **WebAuthn** | Browser/platform API (JS interface) — creates/uses public-key credentials for users |
| **CTAP** (Client to Authenticator Protocol) | How browsers/OS talk to authenticators (hardware keys, TPMs, secure enclaves) over USB/NFC/BLE |

Each user+site pair has a unique key pair (**passkey**); private key stays on device/authenticator, server stores only the public key. Authentication = prove possession of private key (signed challenge-response) + local user verification (biometric/PIN) — private key/password never sent to server.

**Passkey Flow:**

```
 REGISTRATION                              LOGIN
 Server ──challenge──▶ Browser             Server ──fresh challenge──▶ Browser
 Browser ──▶ Authenticator                  Browser ──▶ Authenticator
   (user approves via biometric/PIN)          (authenticator signs challenge
 Authenticator generates keypair              after local user verification)
 Public key + attestation ──▶ Server        Signed response ──▶ Server
 Server stores public key                    Server verifies w/ stored public key
   (per user + relying party domain)           + validates origin/domain
```

**Security benefits:**
- **Phishing-resistant** — keys bound to specific domains; fake sites can't trigger valid signatures.
- **No shared secrets** — nothing to steal/reuse; private keys never leave the device.
- **Replay/credential-stuffing resistant** — fresh challenge + unique signature per site, every time.
- **User-friendly** — biometric/PIN login, no password memorization.

### 12.6 Zero Trust Architecture (ZTA)

**ZTA**: cybersecurity model assuming **no implicit trust** based on network location, device, or prior authentication — every access request continuously verified in context. Protects **resources** (data/services/apps), not static network segments. Formally defined in **NIST SP 800-207**.

**Core Principles (NIST SP 800-207 tenets):**
1. All resources are protected — data/services/assets treated as attack targets regardless of location.
2. No network location is inherently trusted — internal LAN ≠ automatically safer than internet.
3. Per-request, per-session access — every request evaluated on identity, device posture, context (not just one login).
4. Least-privilege access — minimum access needed, dynamically adapted.
5. Continuous monitoring and diagnostics — telemetry collected/analyzed in real time.
6. All access is logged and monitored — identity, device, resource, action recorded for forensics/compliance.
7. Policies are adaptive and data-driven — risk scores, behavior, threat intel feed access decisions.

```
         ┌──────────────────────────────────────┐
         │           ZTA CORE COMPONENTS          │
         └──────────────────────────────────────┘
User/Device ──▶ [Policy Enforcement Point (PEP)] ──▶ Resource
                         │      ▲
                request  │      │ decision
                         ▼      │
                 [Policy Engine (PE)]
                         │
                         ▼
              [Policy Administrator (PA)]
                (configures PEP per PE decision)

  Supporting infra: IdP, EDR, SIEM/telemetry, PKI, config mgmt
```

| Component | Role |
|---|---|
| **Policy Engine (PE)** | Decides whether access is granted — based on policy, identity, device posture, risk signals, telemetry |
| **Policy Administrator (PA)** | Translates PE decisions into commands (allow/deny/reauthenticate); configures enforcement points |
| **Policy Enforcement Point (PEP)** | Enforces decisions — gate between user and resource (reverse proxy, gateway, endpoint agent) |

**ZTA Deployment Models:**
- **Enhanced Identity Governance (EIG)** — identity-centric control at application level (IdPs, SSO, MFA).
- **Microsegmentation** — isolate workloads, enforce per-service policy (host agents/SDN), limit lateral movement.
- **Software-Defined Perimeter (SDP)** — authenticated overlay tunnels between users and resources; common for remote/private app access.

**Zero Trust vs Traditional Perimeter Security**

| | Traditional | Zero Trust |
|---|---|---|
| Trust basis | Location ("inside" = trusted) | Never trust by location |
| Authentication | One-time, at perimeter | Continuous, per-request |
| Network | Flat internal network | Microsegmented |
| Context | Limited | Identity- and device-aware |
| Logging | Periodic | Continuous telemetry, adaptive |

> **Viva Point:** Zero Trust doesn't replace firewalls/VPNs — it changes HOW access decisions are made and enforced, especially for cloud/remote-work scenarios.

### Session 12 — Viva Q&A

**Q: Differentiate RADIUS and TACACS+.**
A: RADIUS runs over UDP, encrypts only the password field, and combines authentication+authorization — used for end-user network access (Wi-Fi, VPN). TACACS+ runs over TCP port 49, encrypts the entire packet, and separates authentication/authorization/accounting — used for network device administration.

**Q: What makes FIDO2 phishing-resistant?**
A: Passkeys are cryptographically bound to a specific domain; a phishing site under a different domain cannot obtain a valid signature from the authenticator, unlike passwords which can be typed into any site.

**Q: State the core difference between Zero Trust and traditional perimeter security.**
A: Traditional security implicitly trusts users/devices once inside the network perimeter; Zero Trust trusts nothing by location and continuously verifies every access request based on identity, device posture, and context.

---

## SESSION 13: Securing Websites and Emails — SSL, TLS, PGP, S/MIME

### 13.1 SSL — Secure Sockets Layer

Encryption-based internet security protocol (Netscape, mid-1990s) providing privacy, authentication, data integrity for web communications — establishes an encrypted channel between client and server.

**SSL/TLS handshake negotiates:** protocol version, cipher suite, server identity (certificate + public key), symmetric session keys for bulk data.

> **Exam Trap:** SSL 3.0 is deprecated/insecure (POODLE attack); modern browsers use **TLS** exclusively, though people still colloquially say "SSL."

### 13.2 TLS — Transport Layer Security

Modern IETF-standardized successor to SSL — encryption, endpoint authentication, integrity, with improved security design and updated cipher suites.

**TLS Handshake (simplified, TLS 1.2):**

```
 CLIENT                                          SERVER
   │                                                │
   │ 1. ClientHello (TLS version, cipher suites) ──▶│
   │                                                │
   │◀── 2. ServerHello (chosen version/suite)       │
   │◀── Certificate (public key) ───────────────────│
   │                                                │
   │ 3. Key exchange:                                │
   │    RSA or (preferred) DH/ECDHE                  │
   │◀──────────── shared session key established ──▶│
   │                                                │
   │ 4. Finished (encrypted w/ session key) ────────▶│
   │◀── Finished (encrypted w/ session key) ─────────│
   │                                                │
   │═══════ Secure data transfer (AES + HMAC/GCM) ══│
```

1. **ClientHello** — client proposes TLS version + supported cipher suites.
2. **ServerHello** — server selects version/suite; sends its **certificate** (public key).
3. **Key exchange** — shared session key established via RSA or (preferably) DH/ECDHE; client may send encrypted premaster secret using server's public key.
4. **Finished messages** — both sides send messages encrypted with the new session key, confirming handshake integrity.

After handshake: **symmetric encryption** (AES) for performance; **MAC/AEAD modes** (HMAC, GCM) for integrity.

> **Exam Trap:** **TLS 1.3** streamlines the handshake (fewer round trips) and mandates modern algorithms, removing weak ciphers and legacy RSA key exchange entirely — a frequently tested TLS 1.2 vs 1.3 distinction.

### 13.3 HTTPS

HTTP running over TLS (historically SSL) — encrypted, authenticated web communication. Site has an SSL/TLS certificate from a CA; browser verifies it, then encrypts HTTP requests/responses via TLS.

**Benefits:** Confidentiality (data unreadable in transit), Integrity (tampering breaks MAC/signature checks), Authentication (certificates confirm legitimate site identity).

### 13.4 Email Security — PGP

**PGP (Pretty Good Privacy)** — Phil Zimmermann's encryption software/protocol providing confidentiality, integrity, authentication for emails/files. **Hybrid cryptographic approach**: symmetric encryption for message body + public-key crypto for key management.

```
 SENDER                                        RECEIVER
   │                                              │
   │ 1. Generate random SESSION KEY               │
   │ 2. Encrypt message with session key           │
   │    (symmetric: IDEA/CAST/3DES)                │
   │ 3. Encrypt session key with recipient's        │
   │    PUBLIC key (RSA/DH)                         │
   │ 4. Hash message, sign hash with own            │
   │    PRIVATE key (authentication)                │
   │ 5. Compress + Radix-64 (ASCII armor) ─────────▶│
   │                                              │
   │                          6. Decrypt session key
   │                             with own private key
   │                          7. Decrypt message with
   │                             session key
   │                          8. Verify signature with
   │                             sender's public key
```

**Key concepts:**
- **Hybrid encryption** — random session key encrypts message body (symmetric: IDEA, CAST, 3DES); session key itself encrypted with recipient's public key (RSA/DH) and attached.
- **Digital signatures** — sender hashes message (SHA-1/MD5), signs hash with private key (RSA/DSS).
- **Compression & Radix-64** — compress before encryption, convert to ASCII armor (radix-64) for email compatibility.
- **Key rings & Web of Trust** — users maintain public/private **key rings**; trust established by users signing each other's keys — **no centralized CA**, decentralized web of trust.

### 13.5 Email Security — S/MIME

**S/MIME (Secure/Multipurpose Internet Mail Extensions)** — IETF standard extending MIME with encryption + digital signatures for email using public-key crypto and **X.509 certificates**. Widely supported in enterprise clients (Outlook, Apple Mail, Thunderbird); integrates naturally with PKI.

**Core features:**
- **EnvelopedData** — encrypts content + session keys for one or more recipients (hybrid, similar to PGP).
- **SignedData** — attaches digital signature (hash + private key) for authentication/integrity.
- **Clear-signed data** — signed but NOT encrypted; readable + verifiable.
- **Signed and Enveloped data** — combinations of encrypt-then-sign or sign-then-encrypt per policy.

**Algorithms:** Hashing (SHA-1+), symmetric (3DES, RC2 legacy, AES modern), public-key (RSA, DH).

S/MIME relies on **X.509 v3 certs** issued by **CAs** — key management (registration, revocation, trust) centralized, suiting organizations.

### 13.6 PGP vs S/MIME — Comparison

| Aspect | PGP | S/MIME |
|---|---|---|
| Trust model | **Web of Trust** — user-driven, users sign each other's keys | **CA-based PKI** — centralized, hierarchical trust chains |
| Key management | User-managed key rings, manual distribution/import | CA-issued/stored/revoked, integrated with corporate directories |
| Target users | Individuals, activists, privacy-focused, cross-platform | Enterprises, regulatory compliance |
| Standards | OpenPGP (RFC 4880) — not originally standards-body-controlled | IETF standard, uses PKCS#7/CMS, X.509, existing PKI |

Both provide: **confidentiality, authentication, integrity, non-repudiation** when used correctly.

> **Exam Trap:** "PGP = Web of Trust (decentralized); S/MIME = CA-based PKI (centralized)" — this is the single most-tested PGP vs S/MIME fact.

### Session 13 — Viva Q&A

**Q: Why is TLS preferred over SSL today?**
A: SSL (especially 3.0) has known vulnerabilities like the POODLE attack and is deprecated; TLS is the IETF-standardized, actively maintained successor with stronger cipher suites and handshake design.

**Q: What is the fundamental trust-model difference between PGP and S/MIME?**
A: PGP uses a decentralized Web of Trust where users vouch for each other's keys; S/MIME uses a centralized CA-based PKI with hierarchical trust chains, making it more suited to enterprise deployment.

**Q: Name the four TLS handshake steps at a high level.**
A: ClientHello (propose version/ciphers) → ServerHello + Certificate (server selects and proves identity) → Key exchange (establish shared session key) → Finished messages (confirm handshake integrity, encrypted with the new session key).

---

## SESSION 14 & 15: IT Act, LDAP/Active Directory, Introduction to Blockchain

### 14.1 IT Act, 2000 — Overview

India's primary cyber law — legal framework for **electronic records, electronic signatures, e-commerce, and cybercrime regulation**. Enacted to support safe internet/digital communication/online business, aligned with the UNCITRAL Model Law on Electronic Commerce (1996).

**Key objectives:**
- Grant **legal recognition** to electronic records and digital/electronic signatures.
- Facilitate **e-commerce and e-governance** — digital contracts/payments valid like paper documents.
- Define/penalize **cyber offences** (hacking, identity theft, cyber terrorism, obscene content, privacy violations).
- Regulate intermediaries (ISPs, social media, platforms) and their responsibilities.

Applies across India, covering electronic data interchange and other electronic communication.

### 14.2 Legal Recognition of Electronic Records & Digital Signatures

- Electronic records usable as court evidence, subject to conditions on integrity/authenticity.
- **Digital signatures** (PKI-based, via CCA-licensed CAs) legally recognized for signing electronic documents (contracts, filings).
- Foundation for **Aadhaar e-Sign, DSC-based signatures, e-governance portals** (ties directly to Session 9).

### 14.3 Cyber Offences and Penalties — Key Sections

| Section | Offence | Penalty |
|---|---|---|
| **43** | Unauthorized access/damage to computer systems | Compensation to affected parties |
| **66** | Hacking / dishonest-fraudulent acts under §43 | Up to 3 years imprisonment or ₹5 lakh fine or both |
| **66B/C/D** | Theft of computer resources, identity theft, cheating by personation | Up to 3 years imprisonment + fines |
| **66E** | Privacy violation — capturing/publishing private-area images without consent | Up to 3 years or ₹2 lakh fine or both |
| **66F** | Cyber terrorism (threat to sovereignty/integrity/security) | Up to **imprisonment for life** |
| **67** | Publishing/transmitting obscene material electronically | Up to 5 years + ₹10 lakh fine (subsequent offences) |

Amended over time: **IT (Amendment) Act, 2008**; updated rules like **Intermediary Guidelines and Digital Media Ethics Code Rules, 2021** (increased platform accountability).

> **Exam Trap:** **Section 66A** (offensive electronic messages) was struck down as **unconstitutional** by the Supreme Court in **Shreya Singhal v. Union of India (2015)** on free-speech/vagueness grounds. This is one of the most frequently tested IT Act facts.

### 14.4 LDAP — Lightweight Directory Access Protocol

Open, standards-based protocol for accessing/managing directory services over TCP/IP. Used for **authentication, authorization, directory queries** in identity systems (OpenLDAP, Active Directory).

**LDAP allows clients to:**
- Connect over TCP — **port 389** (LDAP) or **636** (LDAPS, LDAP over TLS).
- Search entries via LDAP filters.
- Read/modify/add/delete directory entries.
- Perform **simple bind** (username/password) or **SASL binds** for authentication.

**Data model:**
- Entries organized in a hierarchical tree — **Directory Information Tree (DIT)**.
- Each entry has a **Distinguished Name (DN)** + attributes (`cn`, `uid`, `mail`, `objectClass`).
- Schemas define allowed object classes/attributes.

```
                    DIT (Directory Information Tree)
                              │
                    dc=example,dc=com
                         /         \
              ou=People            ou=Groups
               /      \                  \
     cn=Alice        cn=Bob          cn=Admins
    (uid, mail,     (uid, mail,      (member, ...)
     objectClass)    objectClass)
```

### 14.5 Active Directory — Basics and Relation to LDAP

**AD**: Microsoft's directory service for Windows domains — centralized authentication, authorization, management of users/computers/groups/resources.

**AD uses internally:** LDAP (directory queries), **Kerberos** (authentication), **DNS** (service location), **Group Policy** (configuration management).

**Key AD concepts:**

| Term | Meaning |
|---|---|
| Domain | Security boundary containing users, groups, computers, policies |
| Domain Controllers (DCs) | Servers hosting AD database + services (LDAP, Kerberos, DNS) |
| OUs (Organizational Units) | Logical containers for delegation + Group Policy |
| Forest & Trees | Forest = highest security boundary; trees = domains with contiguous namespace |
| Global Catalog | DC subset storing partial attributes of all objects, for fast forest-wide search |

**LDAP in AD:** AD exposes LDAP interface for standard directory operations (search/bind/modify) — user lookups (`uid`, `sAMAccountName`), group membership checks, config queries. DNS SRV records help clients locate LDAP/Kerberos endpoints.

**Kerberos in AD:** default authentication protocol — DCs act as **KDCs**. After Kerberos auth, LDAP operations use tickets instead of passwords — enables secure SSO across domain resources.

> **Viva Point:** LDAP is the **protocol**; Active Directory is the full **directory service** that uses LDAP + Kerberos + DNS + GPO together for enterprise identity/access control. Don't conflate the two.

### 14.6 Introduction to Blockchain — Core Concepts

**Blockchain**: distributed, append-only **ledger** recording transactions in a sequence of **blocks** linked by cryptographic hashes, shared across a network of nodes. Provides decentralized trust, tamper-resistant record-keeping, transparency — without a single central authority.

**Key properties:**
- **Decentralization** — ledger replicated across many nodes; changes require consensus.
- **Immutability** — altering past data is extremely difficult (hash linkage + consensus rules).
- **Transparency** — public blockchains: transactions visible to all participants.
- **Security** — cryptographic hashing + digital signatures protect integrity/authenticity.

### 14.7 Structure of a Block

```
        ┌─────────────────────────────────┐
        │           BLOCK HEADER           │
        │  • Version                       │
        │  • Timestamp                     │
        │  • Previous Block Hash ──────────┼──▶ links to prior block
        │  • Merkle Root                   │
        │  • Nonce (PoW mining)            │
        └─────────────────────────────────┘
        ┌─────────────────────────────────┐
        │           TRANSACTIONS           │
        │  tx1, tx2, tx3, ... (Merkle tree)│
        └─────────────────────────────────┘

  Block N-1 [hash: H1] ◀── Block N [prevHash: H1, hash: H2] ◀── Block N+1 [prevHash: H2]
```

| Field | Purpose |
|---|---|
| Block header | Metadata — version, timestamp, previous block hash, Merkle root |
| Previous hash | Hash of previous block's header — links blocks into a chain |
| Nonce | Value satisfying Proof-of-Work difficulty requirement |
| Merkle root | Combined hash summarizing all transactions in the block |
| Transactions | Individual operations (transfers, smart contract calls) |

Storing the **previous block's hash** means each block depends on ALL prior blocks — changing any transaction alters the Merkle root and block hash, breaking the chain (tamper-evidence).

### 14.8 Hashing and Cryptography in Blockchain

Relies heavily on cryptographic hash functions (SHA-256):
- **Deterministic** — same input → same output.
- **Preimage-resistant** — hard to find input from hash.
- **Collision-resistant** — hard to find two inputs with same hash.
- **Highly sensitive** — small input change → completely different hash (avalanche effect).

**Uses:** link blocks (previous-hash chaining); build Merkle trees for efficient transaction verification; secure data integrity (tampering immediately detectable). Transactions signed via public-key crypto (e.g. **ECDSA**) — only private-key holders can authorize actions/spending.

### 14.9 Consensus Mechanisms

| Mechanism | How it works | Trade-offs | Example |
|---|---|---|---|
| **Proof of Work (PoW)** | Miners compete to solve a computational puzzle (find nonce → hash below difficulty target); first solver broadcasts, others verify | Secure but energy-intensive | Bitcoin |
| **Proof of Stake (PoS)** | Validators selected based on staked cryptocurrency amount; propose/validate blocks, earn rewards | More energy-efficient, faster than PoW | Ethereum (current) |
| **Other** | Delegated PoS (DPoS), Proof of Authority (PoA), BFT variants | Used in permissioned/high-performance chains | Various enterprise chains |

Consensus ensures all honest nodes agree on ledger state even with faulty/malicious nodes present, and prevents **double-spending**.

### 14.10 Types of Blockchains

| Type | Access | Example |
|---|---|---|
| **Public (permissionless)** | Anyone can join, read, participate in consensus | Bitcoin, Ethereum |
| **Private (permissioned)** | Restricted access, enterprise internal/consortium use | Hyperledger Fabric |
| **Consortium** | Controlled by a group of organizations — mix of transparency + controlled membership | Multi-org enterprise networks |

Applications extend beyond cryptocurrency: **smart contracts, supply chain tracking, digital identity, secure logging/auditing**.

### Session 14 & 15 — Viva Q&A

**Q: Why was Section 66A of the IT Act struck down?**
A: The Supreme Court ruled it unconstitutional in Shreya Singhal v. Union of India (2015) due to vagueness and its chilling effect on free speech.

**Q: Explain the relationship between LDAP and Active Directory.**
A: LDAP is a protocol for directory access; Active Directory is a full directory service that uses LDAP (plus Kerberos for authentication, DNS for service location, and Group Policy for configuration) to provide centralized enterprise identity management.

**Q: How does a blockchain achieve tamper-evidence?**
A: Each block stores the cryptographic hash of the previous block's header; changing any transaction in an earlier block alters its Merkle root and hash, which breaks the chain link to all subsequent blocks — making tampering immediately detectable.

**Q: Compare Proof of Work and Proof of Stake.**
A: PoW requires miners to solve computational puzzles to add blocks (secure but energy-intensive, used by Bitcoin); PoS selects validators based on staked cryptocurrency instead of computation (more energy-efficient and faster, used by current Ethereum).

---

## Master Quick Reference Card

| Concept | One-Line Answer |
|---|---|
| CIA Triad | Confidentiality, Integrity, Availability |
| Active vs Passive attack | Active alters data (Integrity/Availability); Passive observes data (Confidentiality) |
| Symmetric vs Asymmetric | Same key vs key pair; fast/bulk vs slow/key-exchange |
| DES structure | Feistel network, 16 rounds, 56-bit key — obsolete |
| AES structure | SPN, 10/12/14 rounds, 128/192/256-bit key — current standard |
| RSA security | Difficulty of factoring n = p×q |
| ECC advantage | Smaller keys, same security (256-bit ECC ≈ 3072-bit RSA) |
| SHA | One-way hash — integrity only, no key |
| HMAC | Hash + secret key — integrity + authentication |
| PKI purpose | Bind identities to public keys via trusted CAs |
| Digital Signature | Hash message → sign digest with private key → verify with public key |
| X.509 | Standard certificate format binding subject + public key + CA signature |
| Trust Models | Hierarchical (single root, SPOF), Mesh (n² cross-certs), Bridge (hub reduces cross-certs) |
| CRL vs OCSP | Downloaded list (stale) vs real-time query (fast); OCSP stapling fixes OCSP privacy/latency |
| DV/OV/EV | Increasing identity-verification rigor for SSL certs |
| Indian DSC Classes | Class 1 (basic), Class 2 (discontinued), Class 3 (current standard) |
| Aadhaar e-Sign | Aadhaar e-KYC-authenticated, short-lived one-time DSC signing — no hardware token needed |
| Time Stamping | TSA (RFC 3161) proves WHEN data existed — extends signature validity past cert expiry |
| PKCS #1/#7/#10/#11/#12 | RSA formats / CMS (S-MIME) / CSR format / HSM-token API / key-cert container (.pfx) |
| FIPS 140-2 Levels | L1 basic → L2 tamper-evident → L3 tamper-resistant (HSMs) → L4 environmental |
| SFA vs MFA | One factor vs 2+ independent factors (know/have/are) |
| SSO | Login once via IdP, token/assertion reused across SPs (SAML/OIDC) |
| OpenID vs OAuth | OpenID = authentication; OAuth = authorization (delegated access) |
| Graphical Passwords | Recognition-based (Passfaces) vs Recall-based (DAS, PassPoints) |
| Kerberos | Ticket-based auth via KDC — password never sent in cleartext |
| RADIUS vs TACACS+ | RADIUS: UDP, encrypts password only; TACACS+: TCP/49, encrypts whole packet |
| FIDO2 | Passwordless, phishing-resistant, public-key based (WebAuthn + CTAP, passkeys) |
| Zero Trust | Never trust by location; continuous per-request verification (NIST SP 800-207) |
| SSL vs TLS | SSL deprecated (POODLE); TLS is the modern IETF standard, TLS 1.3 streamlined |
| PGP vs S/MIME | PGP = Web of Trust (decentralized); S/MIME = CA-based PKI (centralized) |
| IT Act Section 66A | Struck down as unconstitutional (Shreya Singhal v. UOI, 2015) |
| LDAP vs Active Directory | LDAP = protocol; AD = full directory service using LDAP+Kerberos+DNS+GPO |
| Blockchain | Hash-linked blocks, tamper-evident via Merkle root + previous-hash chaining |
| PoW vs PoS | PoW: computational puzzle (Bitcoin); PoS: stake-based validation (Ethereum) |
