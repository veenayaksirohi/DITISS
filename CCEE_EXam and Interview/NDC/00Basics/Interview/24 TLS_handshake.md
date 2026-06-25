# TLS Handshake (Transport Layer Security)

A **TLS Handshake** is the process by which a client (browser) and server securely establish a connection before exchanging encrypted data.

It ensures:

* 🔒 Confidentiality (Encryption)
* ✔️ Integrity (No data modification)
* 👤 Authentication (Verify server identity)
* 🔑 Secure Session Key Exchange

---

## Why is TLS Handshake Needed?

Before sending sensitive information (passwords, banking details, etc.), both parties must:

* Verify the server is legitimate.
* Agree on a cryptographic algorithm.
* Exchange or derive a shared secret key.
* Start encrypted communication.

---

# TLS Handshake Flow (TLS 1.3)

```text
Client                                  Server
   |                                       |
   | -------- ClientHello ----------------> |
   |                                       |
   | <------ ServerHello ------------------ |
   | <------ Certificate ------------------ |
   | <------ Finished --------------------- |
   |                                       |
   | -------- Finished -------------------> |
   |                                       |
   |======= Encrypted Communication =======|
```

---

# Step-by-Step Explanation

## Step 1: ClientHello

The client initiates the connection.

### Client sends:

* TLS version supported
* List of cipher suites
* Random number (Client Random)
* Supported key exchange algorithms
* Extensions (SNI, ALPN, etc.)

Example:

```text
ClientHello
TLS Version : 1.3
Cipher Suites:
   TLS_AES_256_GCM_SHA384
   TLS_CHACHA20_POLY1305_SHA256

Client Random
```

Purpose:

* Introduces itself.
* Tells the server what security options it supports.

---

## Step 2: ServerHello

The server responds.

Server sends:

* Selected TLS version
* Selected cipher suite
* Server Random
* Key exchange parameters (its ephemeral public key)

Example:

```text
ServerHello

TLS Version : TLS 1.3

Cipher:
TLS_AES_256_GCM_SHA384

Server Random
```

Purpose:

* Chooses the encryption algorithm.
* Begins key exchange.

---

## Step 3: Server Certificate

The server sends its certificate.

Contains:

* Server public key
* Domain name
* Issuing CA
* Validity period
* Digital signature

Example:

```text
Certificate

Issued To:
www.example.com

Issued By:
Let's Encrypt

Public Key
Digital Signature
```

Purpose:

* Proves the server's identity.
* Provides the public key needed for authentication.

---

## Step 4: Certificate Verification

The client verifies the certificate.

Checks:

* Trusted CA?
* Certificate expired?
* Domain name matches?
* Digital signature valid?
* Certificate revoked?

If everything is valid:

✔ Continue

Otherwise:

❌ Connection terminated.

---

## Step 5: Key Exchange

In TLS 1.3, the client and server typically use Elliptic Curve Diffie–Hellman.

Both sides exchange ephemeral public keys and independently compute the same shared secret.

```text
Client Public Key
        ↓

Server Public Key

↓

Shared Secret

↓

Session Key
```

The private keys never leave either device.

Purpose:

* Create a shared session key without transmitting it over the network.
* Provide **Perfect Forward Secrecy (PFS)**.

---

## Step 6: Finished Messages

Both client and server send encrypted **Finished** messages.

Purpose:

* Confirm handshake completed successfully.
* Verify both parties derived the same session keys.
* Detect any tampering during the handshake.

---

## Step 7: Secure Communication Begins

Now all application data is encrypted.

```text
Browser
     |
Encrypted Data
     |
Server
```

Uses the negotiated symmetric session key (for example, with Advanced Encryption Standard or ChaCha20-Poly1305).

---

# TLS 1.3 Handshake Summary

| Step | Client             | Server         | Purpose                                             |
| ---- | ------------------ | -------------- | --------------------------------------------------- |
| 1    | ClientHello        |                | Supported TLS versions, cipher suites, random value |
| 2    |                    | ServerHello    | Chooses TLS version and cipher suite                |
| 3    |                    | Certificate    | Proves server identity                              |
| 4    | Verify Certificate |                | Authenticates server                                |
| 5    | Key Exchange       | Key Exchange   | Derive shared session key                           |
| 6    | Finished           | Finished       | Confirm secure handshake                            |
| 7    | Encrypted Data     | Encrypted Data | Secure communication                                |

---

# What Happens After the Handshake?

The client and server communicate using **symmetric encryption** because it is much faster than public-key cryptography.

```text
Handshake
      ↓
Shared Secret
      ↓
Session Key
      ↓
AES/ChaCha20 Encryption
      ↓
Secure Communication
```

---


**TLS Handshake** is the process used to establish a secure communication session between a client and a server. During the handshake, the client and server negotiate the TLS version and cipher suite, the server proves its identity using a digital certificate, they perform a secure key exchange (typically ECDHE) to derive a shared session key, exchange **Finished** messages to verify the handshake, and then use symmetric encryption to securely exchange application data.

---

# Key Points to Remember

* TLS handshake occurs **before** any encrypted data is sent.
* The **server certificate** authenticates the server.
* **ECDHE** is the standard key exchange mechanism in TLS 1.3.
* A **shared session key** is derived, not transmitted.
* **Symmetric encryption** (such as AES or ChaCha20-Poly1305) is used for the actual data transfer because it is much faster than asymmetric cryptography.
* TLS 1.3 is faster, more secure, and requires fewer round trips than TLS 1.2.  






# Diff Betn TCP and TLs HAndshake 

Yes. In **HTTPS**, **both the TCP handshake and the TLS handshake occur**, but they serve different purposes and happen in sequence.

# TCP Handshake vs TLS Handshake

| Feature        | TCP Handshake                           | TLS Handshake                                                                              |
| -------------- | --------------------------------------- | ------------------------------------------------------------------------------------------ |
| Purpose        | Establish a reliable network connection | Establish a secure encrypted connection                                                    |
| Layer          | Transport Layer (Layer 4)               | Between Transport and Application (often considered part of Layer 5–6 / Security over TCP) |
| Protocol       | TCP                                     | TLS                                                                                        |
| Encryption     | ❌ No                                    | ✅ Yes (after the handshake completes)                                                      |
| Authentication | ❌ No                                    | ✅ Verifies the server (and optionally the client)                                          |
| Key Exchange   | ❌ No                                    | ✅ Yes, derives session keys                                                                |
| Happens Before | Before TLS                              | After TCP                                                                                  |
| Used By        | HTTP, HTTPS, FTP, SMTP, SSH, etc.       | HTTPS, SMTPS, IMAPS, FTPS, etc.                                                            |

---

# TCP 3-Way Handshake

Purpose: **Create a reliable connection**.

```
Client                          Server

SYN ------------------------->

      <-------------------- SYN + ACK

ACK ------------------------->

TCP Connection Established
```

### What happens?

1. Client sends **SYN** (Synchronize)
2. Server replies **SYN-ACK**
3. Client sends **ACK**

Result:

* A reliable TCP connection is established.
* No encryption is used.

---

# TLS Handshake

Purpose: **Make the TCP connection secure**.

```
Client                          Server

ClientHello ------------------>

      <---------------- ServerHello
      <---------------- Certificate
      <---------------- Key Exchange

Finished --------------------->

      <---------------- Finished

Secure Session Established
```

### What happens?

* Negotiate TLS version
* Choose cipher suite
* Verify server certificate
* Perform key exchange (typically ECDHE)
* Derive shared session keys
* Start encrypted communication

---

# Order in HTTPS

When you open:

```
https://example.com
```

The sequence is:

```
1. DNS Lookup
        ↓
2. TCP 3-Way Handshake
        ↓
3. TLS Handshake
        ↓
4. HTTPS (Encrypted HTTP Request)
        ↓
5. HTTPS Response
        ↓
6. Connection Closed (TCP FIN/ACK)
```

---

# Visual Flow

```
Browser                                 Web Server

           TCP Handshake
--------------------------------------------------
SYN ------------------------------->
<--------------------------- SYN + ACK
ACK ------------------------------->

TCP Connection Ready

           TLS Handshake
--------------------------------------------------
ClientHello ------------------------>

<--------------------------- ServerHello
<--------------------------- Certificate
<--------------------------- Key Exchange

Finished --------------------------->

<--------------------------- Finished

Secure Connection Ready

           HTTPS Data
--------------------------------------------------
GET /index.html -------------------->

<--------------------------- HTML (Encrypted)
```



# Here's the **complete HTTPS connection flow** with the missing stages added directly into the arrow diagram.

```text
Browser (Client)                              Web Server

                DNS Resolution
---------------------------------------------------------------
example.com  ------------------------------->  DNS Server
                <---------------------------  Server IP Address


                TCP 3-Way Handshake
---------------------------------------------------------------
SYN  --------------------------------------->
                <---------------------------  SYN + ACK
ACK  --------------------------------------->

          TCP Connection Established


                TLS Handshake
---------------------------------------------------------------
ClientHello
(TLS version, Cipher Suites,
Client Random, Extensions) ------------------>

                <---------------------------  ServerHello
                                             (Chosen TLS Version,
                                              Cipher Suite,
                                              Server Random)

                <---------------------------  Certificate
                                             (Server Certificate)

                <---------------------------  Server Key Share
                                             (ECDHE Public Key)

                <---------------------------  Finished

Certificate Verification
Generate Shared Secret
Client Key Share (ECDHE Public Key)
Finished ------------------------------------>

          TLS Session Established
          Session Keys Derived


                HTTPS Communication
---------------------------------------------------------------
Encrypted HTTP Request
GET /index.html ----------------------------->

                <---------------------------  Encrypted HTTP Response
                                             HTTP/1.1 200 OK
                                             HTML/CSS/JS


                TCP Connection Termination
---------------------------------------------------------------
FIN  --------------------------------------->
                <---------------------------  ACK

                <---------------------------  FIN
ACK  --------------------------------------->

          TCP Connection Closed
```

### Flow Summary

```text
1. DNS Lookup
        ↓
2. TCP 3-Way Handshake
        ↓
3. TLS Handshake
   • ClientHello
   • ServerHello
   • Certificate
   • Key Share (ECDHE)
   • Certificate Verification
   • Shared Secret Generation
   • Finished (Server)
   • Finished (Client)
        ↓
4. Secure TLS Session Established
        ↓
5. Encrypted HTTPS Request
        ↓
6. Encrypted HTTPS Response
        ↓
7. TCP Connection Termination (FIN/ACK)
```

This is the complete sequence followed by a modern **HTTPS (TLS 1.3 over TCP)** connection.




---

# Why Are Both Needed?

### TCP provides:

* Reliable delivery
* Ordered packets
* Error checking
* Retransmission of lost packets

It **does not** provide:

* Encryption
* Authentication
* Confidentiality

### TLS provides:

* Encryption
* Authentication
* Integrity
* Secure session key establishment

It **depends on TCP** to reliably transport its handshake messages.

---

# Does HTTP Use TLS?

## HTTP

```
Browser
   │
HTTP
   │
TCP
   │
IP
```

* TCP handshake only
* No TLS
* Data is sent in plaintext

---

## HTTPS

```
Browser
   │
HTTP
   │
TLS
   │
TCP
   │
IP
```

* TCP handshake first
* TLS handshake second
* HTTP messages are then encrypted by TLS

---

# Memory Trick

* **TCP Handshake** = "Can we connect?"
* **TLS Handshake** = "Let's make the connection secure."
* **HTTP/HTTPS** = "Now let's exchange web data."

---

# Interview Answer (5 Marks)

In **HTTPS**, both the **TCP handshake** and the **TLS handshake** occur. First, the **TCP 3-way handshake** (SYN → SYN-ACK → ACK) establishes a reliable connection between the client and server. Once the TCP connection is established, the **TLS handshake** begins. During the TLS handshake, the client and server negotiate security parameters, the server presents its digital certificate for authentication, they perform a key exchange to derive shared session keys, and then start encrypted communication. Only after both handshakes are complete does the client send the encrypted HTTP request. Thus, **TCP provides reliable transport, while TLS provides security**.







