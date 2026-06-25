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

``````````
modern cryptography 
``````````````

symmetric key cryptiography 

sender and recivers use two instance of the same keys for necry pion and description 

adv 
fast than asymmetric system

if n want to secure comminatin using the symmetric need
n(n-1)/2 keys 
"If N people want to communicate securely with each other using Symmetric Key Cryptography, the total number of keys required in the system is:"
N(N−1)2
2N(N−1)​

disadv
scaliblity and key managent 
first time key share
if 2 persion have the key , not able to identiy how encrypt or decript the file 
auth and non repudation not available 

explame

des
3des
blowfish 
twofish
idea
rc4,rcs,rc6
aes

`````````````````
asymmetric system 
`````````````````


1 two keys
2 1 public 2 pricate
3 encyotion from 1 public and description from coruponding privatae key , keep private key  secreate 
4 enctpted by one decryperted by the corresponding key 

In asymmetric cryptography, the public key encrypts the data, and only the corresponding private key can decrypt it. However, the reverse is also used in digital signatures — the private key signs (encrypts the hash), and the public key verifies (decrypts the hash).


secure message foramation 
when the message is encryotion with a public key of receivers(confidently) 

open message format 
encryption data with the sendes private key (ensure integrity )

adv 
better key distribution 
better scalablity 
can provide auth and non - repudation 

disadv
slow than symmetric 


example
rsa
ecc
diffehellman
el0garmal
dsa
knapsack


mac(message auth code )/(medetary acces control )


(medetary acces control ) mac



# MAC — Message Authentication Code (Cryptography)

> **Core idea:** A MAC is a short cryptographic tag generated from a message + a shared secret key. It lets the receiver verify that the message was sent by someone who holds the key and was not tampered with in transit.

---

## 1. What is a MAC?

A **Message Authentication Code** is a fixed-size tag/checksum generated from:

```
Message (M)  +  Secret Key (K)  →  MAC Algorithm  →  MAC Tag
```

It answers two questions at the receiver's end:
- **Did this message come from who I think it did?** (Authentication)
- **Was this message modified in transit?** (Integrity)

---

## 2. How it Works — Step by Step

### Sender Side
```
┌─────────────┐     ┌───────────┐     ┌──────────────┐
│  Message M  │──►  │    MAC    │◄──  │  Secret Key  │
└─────────────┘     │ Algorithm │     │      K       │
                    └─────┬─────┘     └──────────────┘
                          │
                          ▼
                    ┌───────────┐
                    │  MAC Tag  │  ← appended to message
                    └───────────┘

Sender transmits:  [ Message M ]  +  [ MAC Tag ]
```

### Receiver Side
```
Received:  [ Message M' ]  +  [ MAC Tag (received) ]

┌──────────────┐     ┌───────────┐     ┌──────────────┐
│ Message M'   │──►  │    MAC    │◄──  │  Secret Key  │
└──────────────┘     │ Algorithm │     │      K       │
                     └─────┬─────┘     └──────────────┘
                           │
                           ▼
                   [ MAC Tag (computed) ]
                           │
                           ▼
          ┌────────────────────────────────┐
          │  computed tag == received tag? │
          └────────────────┬───────────────┘
                 ┌─────────┴──────────┐
                YES                   NO
                 │                    │
                 ▼                    ▼
          ✅ ACCEPT               ❌ REJECT
      Message authentic         Message tampered
      and unmodified            or wrong sender
```

---

## 3. Why is a Key Needed?

This is the critical question. Why not just use a hash (like SHA-256) without a key?

### Without a key — hash alone is NOT enough

```
Attacker intercepts:   [ Message M ]  +  [ Hash(M) ]

Attacker modifies:     [ Message M* ]
Attacker recomputes:   [ Hash(M*) ]     ← anyone can do this!

Receiver gets:         [ Message M* ]  +  [ Hash(M*) ]
Receiver checks:       Hash(M*) == Hash(M*)  →  ✅ PASS  ← WRONG! Attacker fooled receiver
```

A plain hash gives **no authentication** — anyone can recompute it after modifying the message.

### With a secret key — attacker is blocked

```
Attacker intercepts:   [ Message M ]  +  [ MAC(K, M) ]

Attacker modifies:     [ Message M* ]
Attacker tries:        MAC(?, M*)  ← attacker does NOT have key K
                                   ← cannot produce a valid tag

Receiver gets:         [ Message M* ]  +  [ invalid/guessed tag ]
Receiver checks:       MAC(K, M*) ≠ received tag  →  ❌ REJECT  ← Attacker caught!
```

### Why the key works — summary

| | Hash only (no key) | MAC (with key) |
|---|---|---|
| Anyone can recompute? | ✅ Yes — attacker can too | ❌ No — needs secret key |
| Detects tampering? | ❌ No | ✅ Yes |
| Proves sender identity? | ❌ No | ✅ Yes (key holder only) |
| Attacker can forge? | ✅ Easily | ❌ Computationally infeasible |

> **The key is the proof of identity.** Only parties who hold K can produce a valid MAC tag. The key binds the tag to a specific group of trusted parties.

---
# MAC — Message Authentication Code (Cryptography)

> **Core idea:** A MAC is a short cryptographic tag generated from a message + a shared secret key. It lets the receiver verify that the message was sent by someone who holds the key and was not tampered with in transit.

---

## 1. What is a MAC?

A **Message Authentication Code** is a fixed-size tag/checksum generated from:

```
Message (M)  +  Secret Key (K)  →  MAC Algorithm  →  MAC Tag
```

It answers two questions at the receiver's end:
- **Did this message come from who I think it did?** (Authentication)
- **Was this message modified in transit?** (Integrity)

---

## 2. How it Works — Step by Step

### Sender Side
```
┌─────────────┐     ┌───────────┐     ┌──────────────┐
│  Message M  │──►  │    MAC    │◄──  │  Secret Key  │
└─────────────┘     │ Algorithm │     │      K       │
                    └─────┬─────┘     └──────────────┘
                          │
                          ▼
                    ┌───────────┐
                    │  MAC Tag  │  ← appended to message
                    └───────────┘

Sender transmits:  [ Message M ]  +  [ MAC Tag ]
```

### Receiver Side
```
Received:  [ Message M' ]  +  [ MAC Tag (received) ]

┌──────────────┐     ┌───────────┐     ┌──────────────┐
│ Message M'   │──►  │    MAC    │◄──  │  Secret Key  │
└──────────────┘     │ Algorithm │     │      K       │
                     └─────┬─────┘     └──────────────┘
                           │
                           ▼
                   [ MAC Tag (computed) ]
                           │
                           ▼
          ┌────────────────────────────────┐
          │  computed tag == received tag? │
          └────────────────┬───────────────┘
                 ┌─────────┴──────────┐
                YES                   NO
                 │                    │
                 ▼                    ▼
          ✅ ACCEPT               ❌ REJECT
      Message authentic         Message tampered
      and unmodified            or wrong sender
```

---

## 3. Why is a Key Needed?

This is the critical question. Why not just use a hash (like SHA-256) without a key?

### Without a key — hash alone is NOT enough

```
Attacker intercepts:   [ Message M ]  +  [ Hash(M) ]

Attacker modifies:     [ Message M* ]
Attacker recomputes:   [ Hash(M*) ]     ← anyone can do this!

Receiver gets:         [ Message M* ]  +  [ Hash(M*) ]
Receiver checks:       Hash(M*) == Hash(M*)  →  ✅ PASS  ← WRONG! Attacker fooled receiver
```

A plain hash gives **no authentication** — anyone can recompute it after modifying the message.

### With a secret key — attacker is blocked

```
Attacker intercepts:   [ Message M ]  +  [ MAC(K, M) ]

Attacker modifies:     [ Message M* ]
Attacker tries:        MAC(?, M*)  ← attacker does NOT have key K
                                   ← cannot produce a valid tag

Receiver gets:         [ Message M* ]  +  [ invalid/guessed tag ]
Receiver checks:       MAC(K, M*) ≠ received tag  →  ❌ REJECT  ← Attacker caught!
```

### Why the key works — summary

| | Hash only (no key) | MAC (with key) |
|---|---|---|
| Anyone can recompute? | ✅ Yes — attacker can too | ❌ No — needs secret key |
| Detects tampering? | ❌ No | ✅ Yes |
| Proves sender identity? | ❌ No | ✅ Yes (key holder only) |
| Attacker can forge? | ✅ Easily | ❌ Computationally infeasible |

> **The key is the proof of identity.** Only parties who hold K can produce a valid MAC tag. The key binds the tag to a specific group of trusted parties.

---

