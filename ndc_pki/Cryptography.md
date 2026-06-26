# Cryptography

Cryptography is a method for securely storing and transferring data so that only authorized users can access, read, and process it.

## Data States

There are three states of data:

- Data at rest: stored on a disk, SSD, database, or cloud storage and not currently being accessed or moved.
- Data in transit: moving between systems over a network or another transfer path.
- Data in use: actively being read, modified, or processed in memory by a user or application.

## Core Terms

### Plaintext

Plaintext is the original readable data.

Example: `Hello123`

It is the input before encryption. After encryption, it becomes ciphertext.

### Access Control

Access control is a set of rules that decide who can access what.

It is used in systems to protect data and resources.

Examples:

- Login passwords
- User roles such as Admin and User
- File permissions

Goal:

- Only authorized users can access data.

### Encryption

Encryption is the process of converting plaintext into ciphertext to protect data from unauthorized access.

### Cryptanalysis

Cryptanalysis is the science of studying and breaking the security of encryption systems. Its goal is to recover plaintext or keys without authorization.

### Cryptology

Cryptology is the study of both cryptography and cryptanalysis.

### Encryption Algorithm

An encryption algorithm is a set of mathematical rules and operations applied in a specific sequence to transform plaintext into ciphertext.

### Cipher

A cipher is another name for a cryptographic algorithm used for encryption and decryption.

### Encipher and Decipher

- Encipher = encryption, converting plaintext into ciphertext.
- Decipher = decryption, converting ciphertext back into plaintext.

### Ciphertext

Ciphertext is the encrypted and unreadable form of plaintext.

Example: `X7@kP#9Lm!`

### ACK

ACK, or acknowledgment, is a message sent by the receiver to confirm that data has been successfully received.

It acts like a receipt in networking.

## Traditional / Classical Cryptography

Traditional cryptography mainly consists of two techniques:

- Substitution cipher
- Transposition cipher

### Substitution Cipher

A substitution cipher is a method of encryption in which units of plaintext are replaced with ciphertext according to a fixed system or rule.

#### Classification of Substitution Ciphers

##### Monoalphabetic Substitution Cipher

- Uses one substitution alphabet throughout the message.
- Each plaintext letter is always replaced by the same ciphertext letter.

Examples:

1. Atbash Cipher
   - Alphabet is reversed.
   - `A -> Z`, `B -> Y`, `C -> X`, and so on.
   - Example: `HELLO -> SVOOL`

2. Caesar Cipher
   - Each letter is shifted by a fixed number of positions.
   - Example: shift = 3
   - `A -> D`
   - `B -> E`
   - `C -> F`
   - Example: `HELLO -> KHOOR`

##### Polyalphabetic Substitution Cipher

A polyalphabetic substitution cipher uses multiple substitution alphabets instead of a single alphabet.

The same plaintext letter can be encrypted into different ciphertext letters at different positions. This makes it more secure than a monoalphabetic cipher.

#### Vigenere Cipher

The Vigenere cipher is the most famous polyalphabetic substitution cipher.

It uses a keyword to encrypt the plaintext. If the key is shorter than the plaintext, the key is repeated until it matches the plaintext length.

Example:

- Plaintext: `ATTACKATDAWN`
- Key: `LEMONLEMONLE`
- Ciphertext: `LXFOPVEFRNHR`

Note:

- During encryption, the plaintext and key must be of equal length.
- In the traditional Vigenere cipher, the key is repeated to achieve this.

#### Homophonic Substitution Cipher

A homophonic substitution cipher allows a single plaintext letter to be replaced by multiple possible ciphertext symbols.

It is designed to hide letter frequency patterns and make frequency analysis more difficult.

Example:

- `A -> X, O, G, K`
- `B -> V, L, H, N`
- `C -> P, Q, R, S`

Possible encryption:

- Plaintext: `CAB`
- Ciphertext: `PXV`

or

- Plaintext: `CAB`
- Ciphertext: `ROL`

### Transposition Cipher

A transposition cipher is an encryption method in which the positions of characters are rearranged without changing the characters themselves.

The plaintext letters remain the same, but their order is changed to create the ciphertext.

Example:

- Plaintext: `HELLO`
- Ciphertext: `LHOEL`

Substitution cipher changes the letters.

Transposition cipher changes the positions of the letters.

### Scytale Cipher

The Scytale cipher is one of the oldest known transposition ciphers.

It was used by the ancient Spartans for military communication.

A strip of parchment or leather is wrapped around a cylindrical rod, and the message is written across the wrapped strip. When the strip is unwrapped, the letters appear scrambled.

The receiver must use a rod of the same diameter to read the original message.

Key point:

- Scytale is a transposition cipher.
- Letters are rearranged, not replaced.

Example:

- Plaintext: `ATTACKATDAWN`

Written on Scytale Rod:

```text
A T T A
C K A T
D A W N
```

Reading by columns:

- Ciphertext: `ACDTKATWATAN`

===================================================================================================

# Modern Cryptography — Interview Notes

---

## 1. Symmetric Key Cryptography

The sender and receiver both hold **a copy of the same shared secret key**, which is used for both encryption and decryption.

### Key Formula

If **N** people want to communicate securely with each other using symmetric key cryptography, the total number of keys required is:

```
Total Keys = N(N-1) / 2
```

### Advantages

- **Faster** than asymmetric systems (uses simple operations like XOR, substitution, permutation)

### Disadvantages

- **Scalability and key management** — the number of keys grows rapidly with N (N(N-1)/2 problem)
- **Key distribution problem** — how do two parties securely share the key for the first time?
- **No identity binding** — if two parties share the same key, you cannot identify _who_ encrypted or decrypted the file
- **No authentication or non-repudiation** — either party can deny sending a message since both hold the same key

### Examples

| Algorithm | Notes                                                                      |
| --------- | -------------------------------------------------------------------------- |
| DES       | 56-bit key, deprecated (brute-forceable)                                   |
| 3DES      | Triple DES; stronger than DES but deprecated by NIST in 2023 (legacy only) |
| Blowfish  | Fast block cipher, variable key length                                     |
| Twofish   | AES finalist, 128/192/256-bit keys                                         |
| IDEA      | 128-bit key, used in older PGP versions                                    |
| RC4       | Stream cipher, now deprecated (weak)                                       |
| RC5       | Block cipher, variable block/key/round                                     |
| RC6       | AES finalist, based on RC5                                                 |
| AES       | **Current standard** — 128/192/256-bit key                                 |

---

## 2. Asymmetric Key Cryptography

### Core Properties

1. Uses **two mathematically linked keys**: a **public key** and a **private key**
2. Data encrypted with the **public key** can only be decrypted by the **corresponding private key** — keep the private key secret
3. Data encrypted with the **private key** can be verified (decrypted) by the **corresponding public key** — used in digital signatures
4. The two keys are a matched pair — a public key from one pair cannot decrypt what was encrypted by a different pair's private key

### Message Formats

| Format                  | Key Used to Encrypt       | Purpose                                  |
| ----------------------- | ------------------------- | ---------------------------------------- |
| **Secure Message**      | Receiver's **public key** | Confidentiality — only receiver can read |
| **Open/Signed Message** | Sender's **private key**  | Integrity + Authentication (signature)   |

> In digital signatures — the private key **signs** (encrypts the hash), and the public key **verifies** (decrypts the hash to confirm it matches).

### Advantages

- **Better key distribution** — public keys can be shared openly; no secret channel needed
- **Better scalability** — N users need only N key pairs (not N(N-1)/2 shared secrets)
- **Provides authentication and non-repudiation** — only the private key holder could have signed the message

### Disadvantages

- **Slower than symmetric** — involves complex mathematical operations (modular exponentiation, elliptic curve math)

### Examples

| Algorithm      | Notes                                                         |
| -------------- | ------------------------------------------------------------- |
| RSA            | Most widely used; based on factoring large prime products     |
| ECC            | Elliptic Curve Cryptography; smaller keys, same strength      |
| Diffie-Hellman | Key exchange protocol; not encryption — only key agreement    |
| ElGamal        | Based on discrete logarithm; used in PGP                      |
| DSA            | Digital Signature Algorithm; signing only, not encryption     |
| Knapsack       | Early public-key system; most variants broken, historical use |

---

## 3. MAC — Message Authentication Code

> **Note on naming:** MAC has two meanings in IT:
>
> - **MAC (Cryptography)** = Message Authentication Code — covered here
> - **MAC (OS Security)** = Mandatory Access Control — a separate access-control topic

---

### What is a MAC?

A **Message Authentication Code** is a fixed-size cryptographic tag generated from a message and a **shared secret key**. It lets the receiver verify:

- **Authentication** — did this message come from a trusted sender (someone who holds the key)?
- **Integrity** — was the message modified in transit?

```
Message (M)  + (Symmetric) Secret Key (K)  -->  MAC Algorithm  -->  MAC Tag
```

---

### How it Works — Step by Step

#### Sender Side

```
+-------------+     +-----------+     +--------------+
|  Message M  |-->  |    MAC    |<--  |  Secret Key  |
+-------------+     | Algorithm |     |      K       |
                    +-----+-----+     +--------------+
                          |
                          v
                    +-----------+
                    |  MAC Tag  |  <- appended to message
                    +-----------+

Sender transmits:  [ Message M ]  +  [ MAC Tag ]
```

#### Receiver Side

```
Received:  [ Message M' ]  +  [ MAC Tag (received) ]

+--------------+     +-----------+     +--------------+
| Message M'   |-->  |    MAC    |<--  |  Secret Key  |
+--------------+     | Algorithm |     |      K       |
                     +-----+-----+     +--------------+
                           |
                           v
                   [ MAC Tag (computed) ]
                           |
                           v
          +----------------------------------+
          |  computed tag == received tag?   |
          +--------------+-------------------+
                 +--------+--------+
                YES                NO
                 |                 |
                 v                 v
          [OK] ACCEPT         [X] REJECT
      Message authentic       Message tampered
      and unmodified          or wrong sender
```

---

### Why is a Key Needed?

#### Without a key — a plain hash is NOT enough

```
Attacker intercepts:   [ Message M ]  +  [ Hash(M) ]

Attacker modifies:     [ Message M* ]
Attacker recomputes:   [ Hash(M*) ]     <- anyone can do this — no key required!

Receiver gets:         [ Message M* ]  +  [ Hash(M*) ]
Receiver checks:       Hash(M*) == Hash(M*)  -->  [OK] PASS  <- WRONG! Attacker fooled receiver
```

A plain hash provides **no authentication** — anyone can recompute it after modifying the message.

#### With a secret key — attacker is blocked

```
Attacker intercepts:   [ Message M ]  +  [ MAC(K, M) ]

Attacker modifies:     [ Message M* ]
Attacker tries:        MAC(?, M*)  <- attacker does NOT have key K
                                   <- cannot produce a valid tag

Receiver gets:         [ Message M* ]  +  [ invalid/guessed tag ]
Receiver checks:       MAC(K, M*) != received tag  -->  [X] REJECT  <- Attacker caught!
```

#### Summary Table

|                         | Hash only (no key) | MAC (with key)                |
| ----------------------- | ------------------ | ----------------------------- |
| Anyone can recompute?   | Yes                | No — needs secret key         |
| Detects tampering?      | No                 | Yes                           |
| Proves sender identity? | No                 | Yes (only key holder can tag) |
| Attacker can forge?     | Easily             | Computationally infeasible    |

> **The key is the proof of identity.** Only parties who hold K can produce a valid MAC tag. The key binds the tag to a specific group of trusted parties.

---

### MAC Limitations (Interview Trap)

| Property        | MAC                         | Digital Signature (Asymmetric)    |
| --------------- | --------------------------- | --------------------------------- |
| Authentication  | Yes (key holder only)       | Yes                               |
| Integrity       | Yes                         | Yes                               |
| Confidentiality | No                          | No (use encryption for this)      |
| Non-repudiation | No — both parties share key | Yes — only sender has private key |

> **Interview trap:** MAC does NOT provide non-repudiation. Since both sender and receiver hold the same key, either party could have generated the tag — you cannot prove in court which one created it. For non-repudiation, you need an **asymmetric digital signature**.

---

### Common MAC Algorithms

| Algorithm   | Based on           | Notes                                                |
| ----------- | ------------------ | ---------------------------------------------------- |
| HMAC-SHA256 | Hash (SHA-256)     | Most widely used; used in JWT, TLS 1.2, API signing  |
| HMAC-SHA512 | Hash (SHA-512)     | Stronger variant of HMAC                             |
| CMAC        | Block cipher (AES) | Cipher-based MAC; used in some banking/IoT protocols |
| GMAC        | AES-GCM            | Used inside AES-GCM for authenticated encryption     |

> In practice, **HMAC-SHA256** is the default choice unless a specific protocol mandates otherwise.

---

## 4. Digital Signatures

### Definition

A **Digital Signature** is a cryptographic mechanism that uses **asymmetric key cryptography**
to bind a sender's identity to a message or document. It is the digital equivalent of a
handwritten signature or stamped seal — but far more secure, because it is mathematically
tied to both the **content of the message** and the **sender's private key**.

A digital signature guarantees three security properties:

| Property            | Meaning                                                                   |
| ------------------- | ------------------------------------------------------------------------- |
| **Integrity**       | The message was not altered after signing                                 |
| **Authentication**  | The message came from the claimed sender (only they hold the private key) |
| **Non-repudiation** | The sender cannot deny having signed — only their private key could sign  |

> A digital signature does **NOT** provide confidentiality — it does not encrypt the message.
> To also achieve confidentiality, encrypt the document separately (e.g. with the receiver's public key).

---

> A **digital signature** provides **Integrity + Authentication + Non-repudiation**
> using **asymmetric cryptography** (private key signs, public key verifies).

### Roles

| Label | Role            |
| ----- | --------------- |
| A     | Sender          |
| B     | Attacker / MITM |
| C     | Receiver        |

---

### Step 1 — Key Setup

```
A generates an asymmetric key pair:

  +----------------+       +-----------------+
  |  Private Key   |       |   Public Key    |
  |  (A keeps it)  |       |  (sent to C     |
  |                |       |   openly / PKI) |
  +----------------+       +-----------------+
```

> **A keeps the private key secret. The public key is shared with C (and anyone else).**

---

### Step 2 — Sender Side (Creating the Digital Signature)

```
+------------------+
|   Document M     |
+--------+---------+
         |
         v
+------------------+
|    Hash(M)       |  <- e.g. SHA-256 of the document
+--------+---------+
         |
         v  Encrypt with A's PRIVATE KEY
+----------------------+
|  Digital Signature   |  <- Encrypted hash
+----------------------+
         |
         v
Sender transmits:  [ Document M ]  +  [ Digital Signature ]
```

---

### Step 3 — Receiver Side (Verifying the Signature)

```
Received:  [ Document M' ]  +  [ Digital Signature ]

Step 1 — Extract & decrypt signature using A's PUBLIC KEY:
  Digital Signature  -->  Decrypt(Public Key)  -->  Hash_original

Step 2 — Compute hash of received document:
  Document M'  -->  Hash(M')  -->  Hash_computed

Step 3 — Compare:
  +---------------------------------------+
  |  Hash_original  ==  Hash_computed?    |
  +--------------+------------------------+
         +-------+--------+
        YES               NO
         |                |
         v                v
   [OK] VALID         [X] INVALID
   Signature OK       Tampered or wrong sender
```

---

### Step 4 — What Can Attacker B Do?

| Action by B                          | Result                                           |
| ------------------------------------ | ------------------------------------------------ |
| Read the document in transit         | Yes — document is NOT encrypted by default       |
| Modify the document (M --> M\*)      | Detected — Hash(M\*) != Hash_original --> REJECT |
| Forge a new valid signature          | No — B does not have A's private key             |
| Replace signature with own signature | Detected — C verifies only with A's public key   |

> **Key insight:** B can _read_ the document (signatures provide no confidentiality).
> B _cannot_ tamper undetected — any change to M invalidates the signature.
> For confidentiality, encrypt the document separately (e.g. with C's public key).

---

### Digital Signature vs MAC — Interview Trap

| Property        | MAC (Symmetric Key)             | Digital Signature (Asymmetric)         |
| --------------- | ------------------------------- | -------------------------------------- |
| Key used        | Shared secret key               | Private key signs, public key verifies |
| Authentication  | Yes (key holder only)           | Yes                                    |
| Integrity       | Yes                             | Yes                                    |
| Non-repudiation | No — both parties hold same key | Yes — only sender has private key      |
| Confidentiality | No                              | No                                     |
| Speed           | Fast                            | Slow                                   |

> **Non-repudiation only comes from digital signatures — not from MAC.**
> In MAC, both sender and receiver hold the same key — either could have generated the tag,
> making it unprovable in court who actually sent the message.

---

### Common Digital Signature Algorithms

| Algorithm | Notes                                              |
| --------- | -------------------------------------------------- |
| RSA       | Sign with private key, verify with public key      |
| DSA       | Signing only (no encryption); FIPS standard        |
| ECDSA     | ECC-based DSA; smaller keys, faster, same strength |
| EdDSA     | Modern ECC variant (Ed25519); used in SSH, TLS 1.3 |

---

## 5. Certificate Authority (CA)

### Definition

A **Certificate Authority (CA)** is a trusted third-party entity that **issues, signs, and manages
digital certificates**. A digital certificate binds a **public key** to an **identity** (person,
server, or organization), allowing others to trust that the public key genuinely belongs to
that identity.

> Without a CA, anyone could generate a key pair and claim to be anyone else.
> The CA's signature on the certificate is the proof of identity.

---

### Self-Signed Certificate

> **Rule:** If the **Issuer** and the **Subject** fields in a certificate are the **same entity**,
> the certificate is **self-signed**.

```
Certificate Fields:
  Issuer  : CN=MyCA
  Subject : CN=MyCA       <-- same as Issuer --> Self-Signed
```

- The CA signs its own certificate using its own private key
- There is no higher authority to verify it — trust is established by **pre-installing it
  in the OS/browser trust store**
- Only the **Root CA** is self-signed; all other certificates are signed by a CA above them

---

### CA Hierarchy (Chain of Trust)

```
                    +---------------------------+
                    |         ROOT CA           |
                    |  Certificate: Self-Signed |
                    |  (Issuer == Subject)      |
                    |  Pre-installed in OS /    |
                    |  Browser trust store      |
                    +-------------+-------------+
                                  |
                   signs the Sub CA's certificate
                                  |
                    +-------------v-------------+
                    |         SUB CA            |
                    |  Private Key              |
                    |  CSR (sent to Root CA)    |
                    |  Certificate (signed by   |
                    |  Root CA)                 |
                    +-------------+-------------+
                                  |
                   signs the Web server's certificate
                                  |
                    +-------------v-------------+
                    |       WEB SERVER          |
                    |  Private Key              |
                    |  CSR (sent to Sub CA)     |
                    |  Certificate (signed by   |
                    |  Sub CA) e.g. www.site.com|
                    +---------------------------+
```

---

### What is a CSR?

A **Certificate Signing Request (CSR)** is a file generated by the entity that wants a certificate.
It contains:

| Field             | Contents                                    |
| ----------------- | ------------------------------------------- |
| Public Key        | The applicant's public key                  |
| Identity Info     | Domain name, organization, country, etc.    |
| Digital Signature | Signed with the applicant's own private key |

> The CA verifies the CSR, then issues a signed certificate binding the public key to the identity.
> **The private key never leaves the applicant — only the CSR is sent.**

#### Why is the CSR signed with the applicant's own private key? — Proof of Possession

When you send a CSR to the CA, you are claiming:

> _"This is my public key — please issue me a certificate for it."_

But the CA needs to verify you **actually own the private key** that matches the public key
inside the CSR. Anyone could copy someone else's public key and paste it into a CSR.

So the CSR itself is signed with your private key. The CA then checks:

```
CA checks:  can this CSR's signature be verified with the public key inside it?
                          |
               +----------+----------+
              YES                    NO
               |                     |
   You own the private key       Reject CSR --
   that matches the public key   public/private
   inside the CSR --> proceed    keys don't match
```

If the signature verifies --> you mathematically proved you hold the private key
that pairs with the public key in the CSR — **without ever sending the private key**.

> **Analogy:**
> You tell a bank: _"My name is X, here is my ID."_
> Bank says: _"Sign this paper to prove the ID is actually yours."_
> You sign it. Bank verifies the signature matches the ID --> confirmed.
> The CSR signature works the same way — proof that the public key in the request
> genuinely belongs to you.

---

### Step-by-Step: How Each Level Gets Its Certificate

#### Root CA

```
1. Root CA generates its own key pair (Private Key + Public Key)
2. Root CA creates a self-signed certificate
   (signs it with its own private key — no one above it to ask)
3. This certificate is pre-installed in OS / browsers as a trusted anchor
```

#### Sub CA

```
1. Sub CA generates its own key pair (Private Key + Public Key)
2. Sub CA creates a CSR and sends it to Root CA
3. Root CA verifies the CSR and signs the Sub CA certificate
   (using Root CA's private key)
4. Sub CA now holds: Private Key + Certificate (signed by Root CA)
```

#### Web Server (End Entity)

```
1. Web server generates its own key pair (Private Key + Public Key)
2. Web server creates a CSR and sends it to Sub CA
3. Sub CA verifies the CSR and signs the Web certificate
   (using Sub CA's private key)
4. Web server now holds: Private Key + Certificate (signed by Sub CA)
```

---

### Chain of Trust — How a Browser Verifies www.example.com

```
Browser receives:   [ www.example.com certificate ]
                              |
                              v
          Signed by Sub CA --> verify with Sub CA's public key
                              |
                              v
          Sub CA cert signed by Root CA --> verify with Root CA's public key
                              |
                              v
          Root CA cert is self-signed --> already trusted (pre-installed)
                              |
                              v
                      [OK] TRUSTED
```

> If any signature in the chain fails to verify, the browser shows a certificate warning.

---

### Key Terms — Quick Reference

| Term             | Meaning                                                              |
| ---------------- | -------------------------------------------------------------------- |
| CA               | Certificate Authority — issues and signs certificates                |
| Root CA          | Top-level CA; self-signed; pre-trusted by OS/browser                 |
| Sub CA           | Intermediate CA; signed by Root CA; signs end-entity certificates    |
| End Entity       | Web server, email, device — the final certificate holder             |
| CSR              | Certificate Signing Request — sent to CA to request a certificate    |
| Self-Signed Cert | Issuer == Subject; no external CA; used for Root CA or internal labs |
| Chain of Trust   | The path from end-entity cert up through Sub CA to Root CA           |
| Trust Store      | OS/browser list of pre-trusted Root CA certificates                  |

---

### Interview Trap

> **Q: Why is the Root CA certificate self-signed?**
> A: Because there is no authority above the Root CA to sign its certificate.
> Trust starts somewhere — the Root CA is that starting point. Its certificate is
> pre-installed in operating systems and browsers as an unconditional trust anchor.

> **Q: Does the web server's private key ever leave the server?**
> A: No. Only the CSR (containing the public key + identity info) is sent to the CA.
> The private key is generated locally and never transmitted.

---

## Quick Comparison: Symmetric vs Asymmetric

| Property            | Symmetric                         | Asymmetric                             |
| ------------------- | --------------------------------- | -------------------------------------- |
| Keys                | Same key for encrypt + decrypt    | Public key encrypts, private decrypts  |
| Speed               | Fast                              | Slow                                   |
| Key count (N users) | N(N-1)/2 shared keys              | N key pairs only                       |
| Key distribution    | Hard (needs secure channel first) | Easy (public key shared openly)        |
| Authentication      | Not possible                      | Yes (digital signatures)               |
| Non-repudiation     | Not possible                      | Yes                                    |
| Use case            | Bulk data encryption              | Key exchange, signatures, certificates |
| Examples            | AES, DES, Blowfish                | RSA, ECC, DSA                          |
