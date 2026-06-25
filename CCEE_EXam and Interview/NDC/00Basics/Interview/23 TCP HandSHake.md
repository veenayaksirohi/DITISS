# TCP Three-Way Handshake

The **TCP Three-Way Handshake** is the process used by the Transmission Control Protocol (TCP) to establish a **reliable connection** between a client and a server before data transmission begins.

---

## Why is the TCP Handshake Needed?

It ensures that:

* Both client and server are ready to communicate.
* Initial sequence numbers (ISNs) are synchronized.
* The connection is established reliably.
* Both sides agree on communication parameters.

---

## Three Steps of TCP Handshake

```text
Client                                 Server

   |                                      |
   | -------- SYN (Seq = x) ------------> |
   |                                      |
   | <---- SYN + ACK (Seq = y, Ack=x+1) --|
   |                                      |
   | -------- ACK (Ack = y+1) ----------> |
   |                                      |
 Connection Established
```

---

## Step 1: SYN (Synchronize)

The **client** sends a **SYN** packet to the server.

### Purpose

* Request a new connection.
* Send the client's Initial Sequence Number (ISN).

### Packet

```
SYN
Sequence Number = x
```

### Example

```
Client → Server

SYN
Seq = 1000
```

Meaning:

> "I want to connect. My first sequence number is 1000."

---

## Step 2: SYN + ACK

The **server** replies with **SYN + ACK**.

### Purpose

* Accept the client's request.
* Send the server's ISN.
* Acknowledge the client's SYN.

### Packet

```
SYN + ACK

Seq = y
Ack = x + 1
```

### Example

```
Server → Client

SYN + ACK

Seq = 5000
Ack = 1001
```

Meaning:

* "I accept your request."
* "My sequence number is 5000."
* "I received your sequence number (1000)."

---

## Step 3: ACK

The client sends the final ACK.

### Purpose

* Confirm receipt of the server's SYN.
* Complete connection establishment.

### Packet

```
ACK

Ack = y + 1
```

### Example

```
Client → Server

ACK

Ack = 5001
```

Meaning:

> "I received your sequence number."

Now the TCP connection is established.

---

# Sequence Number Example

| Step | Sender |  Seq |  Ack |
| ---- | ------ | ---: | ---: |
| 1    | Client | 1000 |    — |
| 2    | Server | 5000 | 1001 |
| 3    | Client | 1001 | 5001 |

---

# Handshake Flow Diagram

```text
Client                            Server

Closed                            Listen

   |                                 |
   |------ SYN --------------------->|
   |                                 |
   |<----- SYN + ACK ----------------|
   |                                 |
   |------ ACK --------------------->|
   |                                 |
Established                     Established
```

---

# TCP State Transition

| Client State | Server State |
| ------------ | ------------ |
| CLOSED       | LISTEN       |
| SYN_SENT     | LISTEN       |
| SYN_SENT     | SYN_RECEIVED |
| ESTABLISHED  | ESTABLISHED  |

---

# Packet Details

### First Packet

```
Flags : SYN
Seq   : x
Ack   : Not Valid
```

### Second Packet

```
Flags : SYN, ACK
Seq   : y
Ack   : x + 1
```

### Third Packet

```
Flags : ACK
Seq   : x + 1
Ack   : y + 1
```

---

# Why Three Steps?

1. Client requests a connection (**SYN**).
2. Server accepts and sends its own synchronization request (**SYN + ACK**).
3. Client confirms receipt (**ACK**).

This guarantees that **both sides know the other is ready** before exchanging application data.

---

# Advantages

* Reliable connection establishment.
* Synchronizes sequence numbers.
* Detects unreachable hosts or ports.
* Helps prevent transmission of stale or duplicate connection requests.

---

# Disadvantages

* Introduces a small connection setup delay.
* Consumes server resources during connection establishment.
* Can be abused in attacks such as a **SYN flood**, where many incomplete connection requests exhaust server resources.

---

# Easy Analogy

Imagine making a phone call:

1. **Client:** "Hello, can we talk?" (**SYN**)
2. **Server:** "Yes, I can hear you. Can you hear me?" (**SYN + ACK**)
3. **Client:** "Yes, I can hear you too." (**ACK**)

Now both people know the connection works and the conversation can begin.

---

# Exam Answer (5 Marks)

**TCP Three-Way Handshake** is the process used by TCP to establish a reliable connection before data transfer. It consists of three steps:

1. **SYN:** The client sends a SYN packet with its initial sequence number to request a connection.
2. **SYN + ACK:** The server acknowledges the client's SYN and sends its own SYN with its initial sequence number.
3. **ACK:** The client acknowledges the server's SYN, completing the connection.

After these three steps, the connection enters the **ESTABLISHED** state, and reliable data transmission can begin. This process synchronizes sequence numbers and ensures that both endpoints are ready to communicate.
