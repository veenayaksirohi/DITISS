---
title: "02 - TCP-IP Model"
aliases:
  - "TCP-IP Model and Transport Protocols"
  - "TCP/IP Model — Study Notes"
  - "TCP-IP Model"
  - "TCP vs UDP"
tags:
  - computer-networks
  - tcp-ip
  - transport-layer
syllabus-topic:
  - 2
---

# TCP/IP Model — Study Notes

> CDAC DITISS | Computer Networks | Interview-Oriented

---

## Table of Contents

- [[#1. TCP/IP Model — 4-Layer Overview]]
- [[#2. TCP vs UDP — Full Comparison]]
- [[#3. Why Video Streaming Uses UDP Instead of TCP]]
- [[#4. TCP Three-Way Handshake (Connection Setup)]]
- [[#5. TCP Four-Way Termination (Connection Teardown)]]
- [[#6. Quick Reference — Handshake vs Termination]]
- [[#7. TCP/IP in Action — Full Data Flow]]
- [[#8. Checksum — Error Detection]]
- [[#Related Notes]]

---

## 1. TCP/IP Model — 4-Layer Overview

The **TCP/IP model** (also called the **Internet Model** or **DoD model**) is the practical model used by the real internet. Unlike the 7-layer OSI model (a conceptual/teaching framework), the TCP/IP model is the **actual implementation** that networks run on today.

```
TCP/IP Model (4 Layers)        OSI Model (7 Layers)
┌──────────────────────┐       ┌───────────────────┐
│   Application        │ ←───► │  Application  (L7) │
│                      │       │  Presentation (L6) │
│                      │       │  Session      (L5) │
├──────────────────────┤       ├───────────────────┤
│   Transport          │ ←───► │  Transport    (L4) │
├──────────────────────┤       ├───────────────────┤
│   Internet           │ ←───► │  Network      (L3) │
├──────────────────────┤       ├───────────────────┤
│   Network Access     │ ←───► │  Data Link    (L2) │
│   (Link)             │       │  Physical     (L1) │
└──────────────────────┘       └───────────────────┘
```

### Layer-by-Layer Mapping

| TCP/IP Layer       | OSI Equivalent | Key Protocols                                      |
| ------------------ | -------------- | -------------------------------------------------- |
| **Application**    | L5 + L6 + L7   | HTTP, HTTPS, FTP, DNS, SMTP, SSH, DHCP, SNMP       |
| **Transport**      | L4             | TCP, UDP, SCTP                                     |
| **Internet**       | L3             | IP (IPv4, IPv6), ICMP, ARP, NAT, Routing Protocols |
| **Network Access** | L1 + L2        | Ethernet, Wi-Fi (802.11), MAC, ARP                 |

> **Why 4 layers instead of 7?**
> TCP/IP collapses OSI's upper three layers (Session, Presentation, Application) into a single **Application** layer — because in practice, most protocols handle all three concerns together (e.g., HTTP handles session management, formatting, and application logic in one protocol).
>
> Similarly, TCP/IP collapses OSI's Physical and Data Link layers into **Network Access** — because the physical medium and framing are tightly coupled in real hardware (e.g., Ethernet).

---

## 2. TCP vs UDP — Full Comparison

Both TCP and UDP are **Transport Layer (L4)** protocols that live in the **Transport** layer of both the TCP/IP and OSI models.

### Side-by-Side Comparison

| Feature                | TCP                                        | UDP                                               |
| ---------------------- | ------------------------------------------ | ------------------------------------------------- |
| **Full Name**          | Transmission Control Protocol              | User Datagram Protocol                            |
| **Connection Type**    | Connection-oriented (handshake required)   | Connectionless (no handshake)                     |
| **Reliability**        | Reliable — ACK + retransmission            | Unreliable — no ACK, no retransmit                |
| **Ordering**           | Guaranteed — sequence numbers used         | No ordering — datagrams arrive as they come       |
| **Flow Control**       | Yes — Sliding Window                       | No                                                |
| **Congestion Control** | Yes — slows sender if network is congested | No                                                |
| **Error Detection**    | Checksum + ACK + retransmit                | Checksum only (no recovery)                       |
| **Header Size**        | 20–60 bytes                                | 8 bytes (fixed)                                   |
| **Speed**              | Slower (due to overhead and handshake)     | Faster (no setup, no acknowledgement)             |
| **Data Unit**          | Segment (byte-stream oriented)             | Datagram (message-oriented)                       |
| **IP Protocol Number** | 6                                          | 17                                                |
| **Use Cases**          | HTTP, HTTPS, FTP, SSH, SMTP, Telnet        | DNS, DHCP, VoIP, SNMP, TFTP, Video Streaming, RIP |

---

### TCP Header (20–60 bytes)

```
┌──────────────────┬──────────────────┐
│   Source Port    │  Destination Port │  ← 16-bit each — identifies sending/receiving process
├──────────────────┴──────────────────┤
│           Sequence Number            │  ← 32-bit — byte position in stream; used for ordering
├─────────────────────────────────────┤
│         Acknowledgement Number       │  ← 32-bit — next expected byte from other side
├────────┬────────────────────────────┤
│  Flags │ URG  ACK  PSH  RST  SYN  FIN │  ← Control bits for handshake and connection state
├────────┴────────────────────────────┤
│            Window Size               │  ← Flow control — how much data receiver can accept
├─────────────────────────────────────┤
│    Checksum     │   Urgent Pointer   │  ← Error detection
└─────────────────────────────────────┘
```

---

### UDP Header (8 bytes — fixed)

```
┌──────────────────┬──────────────────┐
│   Source Port    │  Destination Port │  ← 16-bit each
├──────────────────┼──────────────────┤
│     Length       │    Checksum       │  ← Total length of UDP header + data; error detection
└──────────────────┴──────────────────┘
```

> **Interview Trap — Why is UDP's header only 8 bytes?**
> UDP has no sequence numbers, no ACK, no window size, no connection state. It provides the bare minimum needed to identify source/destination processes and detect corruption. Everything else is stripped out for speed.

---

### Use Cases — Choosing TCP vs UDP

| Scenario                       | Protocol | Reason                                                                |
| ------------------------------ | -------- | --------------------------------------------------------------------- |
| Loading a webpage (HTTP/HTTPS) | **TCP**  | Every byte must arrive correctly and in order                         |
| Sending an email (SMTP)        | **TCP**  | Email must be complete and intact                                     |
| File download (FTP)            | **TCP**  | A corrupt file is useless — reliability is critical                   |
| SSH remote login               | **TCP**  | Commands must arrive in exact order, reliably                         |
| DNS query                      | **UDP**  | Single small request/response — fast is better than reliable          |
| VoIP call                      | **UDP**  | Latency matters more than perfection; dropped packets acceptable      |
| Live video streaming           | **UDP**  | Real-time delivery required; stale retransmitted frames are useless   |
| DHCP                           | **UDP**  | Simple broadcast request/response; no connection needed               |
| SNMP (network monitoring)      | **UDP**  | Small messages, high frequency; speed > reliability                   |
| TFTP (simple file transfer)    | **UDP**  | Lightweight protocol for boot images; implements its own simple retry |

---

## 3. Why Video Streaming Uses UDP Instead of TCP

This is one of the most common interview questions on TCP vs UDP.

### The Core Problem with TCP for Streaming

TCP guarantees that **every byte arrives in order**. If segment 5 is lost:

```
Segments received: 1, 2, 3, 4, [MISSING 5], 6, 7, 8 ...
                                     ↑
              TCP STOPS here and waits for segment 5 to be retransmitted
              Segments 6, 7, 8... are buffered but NOT delivered to the app
              until 5 arrives — even though they already reached the receiver
```

This is called **Head-of-Line (HOL) Blocking** — a single lost packet freezes all delivery.

For video, this creates **visible freezing** — the player has frames 1–4 and frames 6–8, but it cannot display frame 6 until frame 5 is retransmitted and arrives. By the time frame 5 arrives, frame 6 is already late and causes a stutter.

---

### Why UDP Works Better for Video

```
Segments received: 1, 2, 3, 4, [MISSING 5], 6, 7, 8 ...
                                     ↑
              UDP delivers 6, 7, 8 immediately to the application
              Missing frame 5 → application simply skips it or interpolates
              Playback continues with minimal disruption
```

With video:

- A **missing frame** causes a brief visual artifact — barely noticeable to the human eye.
- A **delayed frame** causes freezing — very noticeable and annoying.
- UDP **skips the bad frame** and keeps playing; TCP **waits** for the bad frame, causing a freeze.

### Why Latency Matters More Than Reliability in Streaming

| Factor          | TCP                          | UDP                            |
| --------------- | ---------------------------- | ------------------------------ |
| Lost packet     | Retransmitted — arrives late | Skipped — stream continues     |
| Consequence     | Freezing / stutter           | Single corrupted/missing frame |
| User experience | **Worse**                    | **Better**                     |

> **Real-world note:** Modern streaming platforms (YouTube, Netflix, Zoom) often use **QUIC** (a protocol built on UDP by Google) which adds selective reliability on top of UDP — getting the best of both worlds. QUIC is the foundation of **HTTP/3**.

---

### Summary — TCP vs UDP for Streaming

```
TCP streaming:                     UDP streaming:
  Segment lost                       Segment lost
       ↓                                  ↓
  Wait for retransmit              Skip it, continue
       ↓                                  ↓
  All later frames stuck           Later frames delivered immediately
       ↓                                  ↓
  Video FREEZES ❌                 Single glitch, playback continues ✅
```

---

## 4. TCP Three-Way Handshake (Connection Setup)

The **3-way handshake** is TCP's mechanism for establishing a **reliable, bidirectional connection** before any data is sent.

### What it Achieves

- Synchronizes **sequence numbers** on both sides (so each side knows where the other's byte stream starts)
- Confirms both sides can **send and receive** (bidirectionality verified)
- Allocates resources (buffers, socket state) on both sides

### Handshake Steps

```
Client                              Server
  │                                   │
  │ ────── SYN (Seq=x) ─────────────► │   Step 1: Client initiates
  │                                   │          SYN flag set; Seq=x (random Initial Sequence Number)
  │                                   │          Server port must be LISTENING
  │                                   │
  │ ◄────── SYN-ACK (Seq=y, ACK=x+1) │   Step 2: Server acknowledges + sends its own SYN
  │                                   │          SYN + ACK flags both set
  │                                   │          ACK=x+1 means "I got your byte x, send x+1 next"
  │                                   │          Seq=y is server's own ISN
  │                                   │
  │ ────── ACK (ACK=y+1) ───────────► │   Step 3: Client acknowledges server's SYN
  │                                   │          ACK=y+1 means "I got your byte y, send y+1 next"
  │                                   │          Connection is now ESTABLISHED
  │ ═══════════════ DATA ═══════════► │   Data transfer begins
```

### Flag Details

| Step                          | Flags Set      | Meaning                                                          |
| ----------------------------- | -------------- | ---------------------------------------------------------------- |
| **SYN** (Client → Server)     | `SYN=1`        | "I want to connect; my starting sequence number is x"            |
| **SYN-ACK** (Server → Client) | `SYN=1, ACK=1` | "Agreed; my starting sequence number is y; I acknowledge your x" |
| **ACK** (Client → Server)     | `ACK=1`        | "I acknowledge your y; connection established"                   |

### ISN — Initial Sequence Number

- Both sides pick a **random Initial Sequence Number (ISN)** — not starting from 0.
- Random ISN prevents **TCP sequence prediction attacks** (a security measure).
- After the handshake, sequence numbers increment with each byte sent.

> **Interview Trap — Why 3 steps and not 2?**
> Two steps (SYN + SYN-ACK) would let the server confirm the client's ISN, but the client never gets a chance to confirm the **server's** ISN. A 3rd step (ACK) is required so the **server's ISN is also acknowledged**, making the connection truly bidirectional. Two steps would leave the server's sequence number unacknowledged.

---

## 5. TCP Four-Way Termination (Connection Teardown)

TCP uses a **4-way handshake** to close a connection. It requires 4 steps (not 3) because **both sides must independently close their half of the connection** — TCP is full-duplex, so each direction is closed separately.

### Why 4-Way (Not 3-Way)?

- After Client sends FIN — Client can no longer send, but can still **receive**.
- Server may still have data to send before it's ready to close its side.
- So Server sends **ACK immediately** (to acknowledge the FIN), but sends its own **FIN later** (when it's done sending).
- This creates 4 distinct steps instead of 3.

### Termination Steps

```
Client                              Server
  │                                   │
  │ ────── FIN (Seq=u) ─────────────► │   Step 1: Client signals "I'm done sending"
  │                                   │          FIN flag set; Client enters FIN-WAIT-1
  │                                   │
  │ ◄────── ACK (ACK=u+1) ─────────── │   Step 2: Server acknowledges Client's FIN
  │                                   │          Server can still SEND data here (half-close)
  │                                   │          Client enters FIN-WAIT-2
  │                                   │
  │ ◄────── FIN (Seq=v) ─────────────  │   Step 3: Server signals "I'm also done sending"
  │                                   │          Server enters LAST-ACK
  │                                   │
  │ ────── ACK (ACK=v+1) ───────────► │   Step 4: Client acknowledges Server's FIN
  │                                   │          Client enters TIME-WAIT; Server closes
  │                                   │
  ╳  (after TIME-WAIT expires)        ╳   Connection fully closed
```

### TCP Connection States During Termination

| Side   | State          | What's Happening                                               |
| ------ | -------------- | -------------------------------------------------------------- |
| Client | **FIN-WAIT-1** | Sent FIN; waiting for ACK                                      |
| Client | **FIN-WAIT-2** | Got ACK; waiting for Server's FIN                              |
| Server | **CLOSE-WAIT** | Got Client's FIN; still may be sending data                    |
| Server | **LAST-ACK**   | Sent FIN; waiting for final ACK                                |
| Client | **TIME-WAIT**  | Got Server's FIN; sent final ACK; waiting before fully closing |
| Both   | **CLOSED**     | Connection terminated                                          |

### TIME-WAIT State

After sending the final ACK, the Client waits in **TIME-WAIT** for **2 × MSL (Maximum Segment Lifetime)** — typically 60–120 seconds.

**Why TIME-WAIT exists:**

1. If the final ACK is lost, the Server will retransmit its FIN — the Client must be alive to respond again.
2. Ensures old delayed packets from the closed connection don't interfere with a new connection using the same port pair.

> **Interview Trap — What if the final ACK is lost?**
> The Server never receives the final ACK, so it retransmits its FIN. The Client is still in TIME-WAIT — it receives the retransmitted FIN and sends the ACK again. If the Client had already closed, the Server would be stuck in LAST-ACK forever. TIME-WAIT prevents this.

---

## 6. Quick Reference — Handshake vs Termination

| Aspect             | 3-Way Handshake        | 4-Way Termination              |
| ------------------ | ---------------------- | ------------------------------ |
| **Purpose**        | Establish connection   | Close connection               |
| **Steps**          | 3                      | 4                              |
| **Why not fewer?** | Need to sync both ISNs | Each side closes independently |
| **Key flags**      | SYN, SYN-ACK, ACK      | FIN, ACK, FIN, ACK             |
| **Initiator**      | Client (usually)       | Either side                    |
| **End state**      | ESTABLISHED            | CLOSED (after TIME-WAIT)       |

---

## 7. TCP/IP in Action — Full Data Flow

Putting it all together with the TCP/IP model:

```
Application Layer (HTTP request)
   │  "GET /index.html HTTP/1.1"
   │
Transport Layer (TCP Segment)
   │  + Src Port: 49200  Dst Port: 80
   │  + Seq No., ACK, Window Size, Checksum
   │
Internet Layer (IP Packet)
   │  + Src IP: 192.168.1.10   Dst IP: 8.8.8.8
   │  + TTL: 64   Protocol: 6 (TCP)
   │
Network Access Layer (Ethernet Frame)
   │  + Src MAC: AA:BB:CC:DD:EE:FF   Dst MAC: 11:22:33:44:55:66
   │  + CRC/FCS
   │
Physical → Bits → 010101010101010...
```

> **Key reminders:**
>
> - **IP addresses** — assigned at Internet Layer — don't change end-to-end.
> - **MAC addresses** — assigned at Network Access Layer — change at **every router hop**.
> - **Port numbers** — assigned at Transport Layer — identify the **application process**.
> - **TCP connection** must be established (3-way handshake) **before** any HTTP data is sent.

---

## 8. Checksum — Error Detection

### What is a Checksum?

A **checksum** is a calculated value added to data before transmission. It lets the receiver verify whether the data arrived intact or was corrupted in transit.

```
SENDER                              RECEIVER

Data: [1, 2, 3, 4]                 Receives: [1, 2, 3, 4] + Checksum: 10
Sum  = 1+2+3+4 = 10                Recalculates: 1+2+3+4 = 10
Send data + checksum (10) ──────►  Compares: 10 == 10 ✅ → Data is intact

                                   If data was corrupted: [1, 2, 9, 4]
                                   Recalculates: 1+2+9+4 = 16
                                   Compares: 16 ≠ 10 ❌ → Data corrupted → Discard
```

The receiver independently recalculates the checksum from the received data and compares it to the checksum that arrived with the packet. Match = intact. Mismatch = corrupted → discard.

---

### Where Checksums Appear in the OSI Model

| Layer              | Field                            | What it Protects                     |
| ------------------ | -------------------------------- | ------------------------------------ |
| **L2 — Data Link** | CRC / FCS (Frame Check Sequence) | The entire Ethernet frame            |
| **L3 — Network**   | IP Header Checksum               | The IP header only (not the payload) |
| **L4 — Transport** | TCP / UDP Checksum               | The TCP/UDP header + data            |

Each layer has its own checksum protecting its own PDU independently.

---

### What Happens When Checksum Fails?

The action taken depends on **which layer** detected the corruption.

#### Layer 2 — Ethernet (CRC/FCS fails)

```
Frame arrives → L2 checks CRC → Mismatch ❌
                    ↓
          Frame is SILENTLY DROPPED
          No notification to sender
          No retransmit at L2
                    ↓
     Upper layers (TCP) notice the missing segment
     and handle recovery themselves
```

#### Layer 4 — TCP (Checksum fails)

```
Segment arrives → TCP checks checksum → Mismatch ❌
                        ↓
              Segment is DROPPED (silently)
                        ↓
         Sender waits for ACK that never comes
                        ↓
              RTO (Retransmit Timeout) expires
                        ↓
              Sender RETRANSMITS the segment ✅
                        ↓
              Receiver gets clean copy → ACK sent
```

TCP recovers automatically — the application never knows it happened.

#### Layer 4 — UDP (Checksum fails)

```
Datagram arrives → UDP checks checksum → Mismatch ❌
                          ↓
                 Datagram is DROPPED
                          ↓
                    NOTHING happens.
                 No ACK, no retransmit,
                 no notification to sender.
                 Application never receives it.
```

This is why UDP is called **"fire and forget"** — it has no recovery mechanism.

---

### Summary — What Happens on Corruption

| Layer | Protocol           | On Corruption                 | Recovery                            |
| ----- | ------------------ | ----------------------------- | ----------------------------------- |
| L2    | Ethernet (CRC/FCS) | Frame silently dropped        | TCP (L4) handles it                 |
| L3    | IP Header Checksum | Packet dropped                | TCP (L4) handles it                 |
| L4    | TCP Checksum       | Segment dropped → RTO expires | Sender retransmits automatically ✅ |
| L4    | UDP Checksum       | Datagram dropped              | Nothing — gone forever ❌           |

---

### Key Points for Interviews

- Checksum **detects** errors only — it does **not correct** them. A corrupted PDU is simply discarded.
- **Recovery only happens at TCP (L4)** — every other layer just discards and moves on.
- The IP header checksum covers **only the IP header**, not the payload — that's why TCP/UDP have their own checksums covering the data.
- Checksums catch **transmission errors** (bit flips from electrical noise) — they are not security tools. They cannot detect intentional tampering. That requires cryptographic hashes (SHA-256, HMAC).

> **Interview Trap — Does UDP use a checksum?**
> Yes — UDP does have a checksum field in its 8-byte header. But it only **detects** corruption; it cannot **recover** from it. A corrupted UDP datagram is simply dropped with no follow-up. The checksum in UDP is also technically optional in IPv4 (though almost always used in practice), but mandatory in IPv6.

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[01A - OSI Model]]
- [[03 - IP Subnetting VLSM IPv4 IPv6 and NDP]]
- [[A1 - HTTP Evolution and TLS]]
