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
