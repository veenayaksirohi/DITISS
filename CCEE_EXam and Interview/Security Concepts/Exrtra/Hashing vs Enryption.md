![alt text](image.png)






## Table 1: Encryption Techniques

| Sr. No. | Encryption Type           | Description                                                        | Key Usage                | Examples                               | Common Uses                               |
| ------- | ------------------------- | ------------------------------------------------------------------ | ------------------------ | -------------------------------------- | ----------------------------------------- |
| 1       | **Symmetric Encryption**  | Uses the same key for encryption and decryption.                   | Single Shared Key        | AES, DES, 3DES, Blowfish, Twofish, RC4 | Disk encryption, VPNs, File encryption    |
| 2       | **Asymmetric Encryption** | Uses a public key for encryption and a private key for decryption. | Public Key + Private Key | RSA, ECC, ElGamal, Diffie-Hellman      | Digital signatures, SSL/TLS, Secure email |

---

## Table 2: Symmetric Encryption Algorithms

| Sr. No. | Algorithm                              | Key Size           | Status               | Features                          |
| ------- | -------------------------------------- | ------------------ | -------------------- | --------------------------------- |
| 1       | **AES (Advanced Encryption Standard)** | 128, 192, 256 bits | Secure (Recommended) | Fast, widely used worldwide       |
| 2       | **DES (Data Encryption Standard)**     | 56 bits            | Obsolete             | Vulnerable to brute-force attacks |
| 3       | **3DES (Triple DES)**                  | 168 bits           | Legacy               | More secure than DES but slower   |
| 4       | **Blowfish**                           | 32–448 bits        | Secure               | Fast and flexible key sizes       |
| 5       | **Twofish**                            | Up to 256 bits     | Secure               | Successor to Blowfish             |
| 6       | **RC4**                                | Variable           | Broken               | No longer recommended             |

---

## Table 3: Asymmetric Encryption Algorithms

| Sr. No. | Algorithm                             | Key Type           | Status | Features                                   |
| ------- | ------------------------------------- | ------------------ | ------ | ------------------------------------------ |
| 1       | **RSA**                               | Public/Private Key | Secure | Most widely used asymmetric algorithm      |
| 2       | **ECC (Elliptic Curve Cryptography)** | Public/Private Key | Secure | Strong security with smaller keys          |
| 3       | **ElGamal**                           | Public/Private Key | Secure | Used for encryption and signatures         |
| 4       | **Diffie-Hellman**                    | Key Exchange       | Secure | Secure key exchange over insecure channels |

---

## Table 4: Hashing Algorithms

| Sr. No. | Hash Algorithm | Output Size | Status               | Common Uses                                          |
| ------- | -------------- | ----------- | -------------------- | ---------------------------------------------------- |
| 1       | **SHA-256**    | 256 bits    | Secure               | Password hashing, Integrity verification, Blockchain |
| 2       | **SHA-512**    | 512 bits    | Secure               | Digital signatures, File integrity                   |
| 3       | **SHA-1**      | 160 bits    | Broken               | Legacy systems only                                  |
| 4       | **MD5**        | 128 bits    | Broken               | Checksums, Legacy applications                       |
| 5       | **bcrypt**     | Variable    | Secure               | Password storage                                     |
| 6       | **Argon2**     | Variable    | Secure (Recommended) | Modern password hashing                              |
| 7       | **PBKDF2**     | Variable    | Secure               | Password-based key derivation                        |

---

## Table 5: Encryption vs Hashing

| Feature      | Encryption                            | Hashing                                  |
| ------------ | ------------------------------------- | ---------------------------------------- |
| Purpose      | Protect confidentiality               | Verify integrity                         |
| Reversible   | Yes                                   | No                                       |
| Key Required | Yes                                   | No                                       |
| Output       | Ciphertext                            | Hash Value (Digest)                      |
| Examples     | AES, RSA, ECC                         | SHA-256, SHA-512, MD5                    |
| Uses         | Secure communication, Data protection | Password storage, Integrity verification |

---

## Table 6: Common Encryption Technologies

| Sr. No. | Technology    | Encryption Used       | Purpose                          |
| ------- | ------------- | --------------------- | -------------------------------- |
| 1       | **SSL/TLS**   | RSA, ECC, AES         | Secure web communication (HTTPS) |
| 2       | **VPN**       | AES, IPsec            | Secure network communication     |
| 3       | **BitLocker** | AES                   | Full disk encryption (Windows)   |
| 4       | **VeraCrypt** | AES, Twofish, Serpent | Disk and file encryption         |
| 5       | **PGP/GPG**   | RSA, ECC              | Email encryption                 |
| 6       | **WPA2/WPA3** | AES                   | Wi-Fi security                   |
| 7       | **SSH**       | RSA, ECC, AES         | Secure remote login              |
| 8       | **IPsec**     | AES, 3DES             | Secure IP communication          |

---

### Quick Exam Tips

| Topic                 | Key Point                                 |
| --------------------- | ----------------------------------------- |
| Symmetric Encryption  | Same key for encryption and decryption    |
| Asymmetric Encryption | Public key encrypts, private key decrypts |
| AES                   | Most commonly used symmetric algorithm    |
| RSA                   | Most commonly used asymmetric algorithm   |
| ECC                   | Smaller key, same security as RSA         |
| Hashing               | One-way function                          |
| SHA-256               | Secure hashing algorithm                  |
| MD5                   | Broken and not recommended                |
| Argon2                | Modern password hashing algorithm         |

### Most Important MCQs

* **AES** → Symmetric Encryption
* **RSA** → Asymmetric Encryption
* **ECC** → Asymmetric Encryption
* **SHA-256** → Hashing Algorithm
* **MD5** → Broken Hashing Algorithm
* **Encryption provides** → Confidentiality
* **Hashing provides** → Integrity
* **Digital Signatures provide** → Authentication, Integrity, Non-Repudiation
* **HTTPS uses** → SSL/TLS
* **WPA3 uses** → AES Encryption for Wi-Fi Security




# Hashing vs Encryption — Short Notes

## 1. Hashing

### Definition

Hashing converts data into a fixed-size value called a **hash** or **digest**.

### Features

* One-way process (cannot be reversed)
* No key required
* Same input → same hash
* Fast process
* Fixed-size output

### Main Purpose

* Data integrity
* Authentication
* Password verification

### Common Uses

* Password storage
* Digital signatures
* Blockchain
* File integrity checks

### Examples

* SHA-256
* SHA-3
* MD5
* bcrypt
* Argon2

### Advantages

* Very fast
* Secure for verification
* Small storage size

### Disadvantages

* Cannot recover original data
* Collision possible in weak algorithms

---

# 2. Encryption

### Definition

Encryption converts readable data (**plaintext**) into unreadable data (**ciphertext**) using a key.

### Features

* Two-way process
* Requires a key
* Data can be decrypted
* Usually slower than hashing
* Output size may vary

### Main Purpose

* Confidentiality
* Privacy
* Secure communication

### Common Uses

* HTTPS security
* VPNs
* Secure messaging
* File encryption

### Examples

* AES
* RSA
* DES
* 3DES
* ChaCha20

### Advantages

* Protects sensitive data
* Data can be recovered with the key

### Disadvantages

* Slower than hashing
* Requires key management

---

# 3. Difference Between Hashing and Encryption

| Aspect       | Hashing                 | Encryption           |
| ------------ | ----------------------- | -------------------- |
| Process Type | One-way                 | Two-way              |
| Reversible   | No                      | Yes                  |
| Key Required | No                      | Yes                  |
| Output       | Fixed-size hash         | Ciphertext           |
| Speed        | Faster                  | Slower               |
| Main Goal    | Integrity               | Confidentiality      |
| Storage      | Smaller                 | Larger               |
| Used For     | Passwords, verification | Secure communication |

---

# 4. Easy Memory Trick

* **Hashing = Verify**
* **Encryption = Hide**

---

# 5. Real-Life Example

### Hashing

A website stores your password as a hash.
When you log in, it hashes your entered password and compares both hashes.

### Encryption

When sending a message on apps like secure messengers, the message is encrypted so only the receiver can read it.
