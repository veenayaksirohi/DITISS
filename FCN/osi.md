# Physical Layer — Short Notes

## 1. Bit Stream Coordination

- Converts data into raw bits (0s and 1s) for transmission
- **Analog** = continuous wave signals (DSL, modems)
- **Digital** = discrete voltage levels (modern networks)
- **Serial** = bits sent one at a time (WAN links)
- **Parallel** = multiple bits simultaneously (internal buses)

---

## 2. Mechanical & Electrical Specifications

- Defines **connector type** (RJ-45, LC, DB-9), pin count, cable type
- Defines **voltage levels** (0V = 0, +5V = 1), impedance
- Specifies what each pin does (Tx, Rx, Ground, Clock)

---

## 3. Encoding

- Converts bits into signals suitable for the medium
- Examples: **Manchester** (Ethernet), **4B/5B** (Fast Ethernet), **NRZ**, **AMI** (T1)
- Ensures clock synchronization and prevents long strings of same bit

---

## 4. Data Rate

- Defines **bits per second (bps)** transmission speed
- Higher data rate = wider bandwidth needed
- Examples: 10 Mbps (Ethernet), 100 Mbps (Fast Ethernet), 1 Gbps (GigE)

---

## 5. Synchronization

- **Synchronous** — shared clock, continuous stream (SONET, T1)
- **Asynchronous** — no shared clock, uses start/stop bits per character (RS-232, UART)

---

## 6. Line Configuration

- **Point-to-Point** — dedicated link between 2 devices (serial WAN, PPP)
- **Multipoint** — single shared link among multiple devices (bus, NBMA)

---

## 7. Physical Topology

| Topology | Key Point                                             |
| -------- | ----------------------------------------------------- |
| Mesh     | Every device connected to every other; most redundant |
| Star     | All connect to central switch; most common today      |
| Ring     | Each connects to two neighbours; one break = failure  |
| Bus      | Single shared cable; legacy (old Ethernet)            |

---

## 8. Transmission Mode

| Mode            | Direction                     | Example                |
| --------------- | ----------------------------- | ---------------------- |
| **Simplex**     | One-way only                  | TV broadcast, keyboard |
| **Half-Duplex** | Both ways, NOT simultaneously | Walkie-talkie, hub     |
| **Full-Duplex** | Both ways simultaneously      | Phone call, switch     |

---

# Physical Layer — Protocols & Devices

## Protocols / Standards

These standards define physical layer behaviour. _Source: shardeum_

| Protocol / Standard         | Description                                                                |
| --------------------------- | -------------------------------------------------------------------------- |
| **Ethernet (IEEE 802.3)**   | Defines wiring, signaling for wired LAN (10Base-T, 100Base-TX, 1000Base-T) |
| **Wi-Fi (IEEE 802.11)**     | Wireless physical layer — radio frequencies (2.4 GHz, 5 GHz)               |
| **Bluetooth (IEEE 802.15)** | Short-range wireless, 2.4 GHz radio                                        |
| **USB**                     | Serial physical interface for peripheral devices                           |
| **RS-232**                  | Serial communication standard (console cable, old modems)                  |
| **DSL**                     | Transmits digital data over telephone lines                                |
| **SONET / SDH**             | Fiber-optic transmission standards for WAN backbone                        |
| **V.35**                    | WAN serial interface standard (router ↔ CSU/DSU)                           |
| **DOCSIS**                  | Cable internet physical standard                                           |
| **T1 / E1**                 | Digital WAN transmission lines (1.544 / 2.048 Mbps)                        |

---

## Devices

Physical layer devices work only with **raw bits / signals** — they have no knowledge of MAC addresses, IP addresses, or data content. _Source: shardeum_

| Device                           | Layer     | Role                                                                                                              |
| -------------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------- |
| **Hub**                          | Layer 1   | Receives a bit signal on one port, **repeats it out all other ports** (broadcasts raw signal); no intelligence    |
| **Repeater**                     | Layer 1   | **Regenerates and amplifies** weakened signals to extend cable distance                                           |
| **Cables**                       | Layer 1   | Physical medium — UTP, STP, coaxial, fiber optic                                                                  |
| **Connectors**                   | Layer 1   | RJ-45, BNC, LC, SC, DB-9 — physical interface points                                                              |
| **NIC (Network Interface Card)** | Layer 1/2 | Converts digital bits to electrical/optical signals; has both L1 (signal) and L2 (MAC) functions                  |
| **Modem**                        | Layer 1   | **Modulates/demodulates** — converts digital bits ↔ analog signals for telephone lines                            |
| **CSU/DSU**                      | Layer 1   | **Channel Service Unit / Data Service Unit** — connects router (DTE) to WAN digital line (DCE); provides clocking |
| **Transceiver**                  | Layer 1   | Converts between different physical media (e.g., copper ↔ fiber)                                                  |

---

## Hub vs Repeater vs Switch (Common Confusion)

| Device       | Layer | Understands                    | Behaviour                                            |
| ------------ | ----- | ------------------------------ | ---------------------------------------------------- |
| **Repeater** | L1    | Nothing — only signal strength | Regenerates signal on one port to another            |
| **Hub**      | L1    | Nothing — only bits            | Floods signal to **all ports** (multi-port repeater) |
| **Bridge**   | L2    | MAC addresses                  | Forwards frames between segments                     |
| **Switch**   | L2    | MAC addresses                  | Forwards frames to **specific port** only            |
| **Router**   | L3    | IP addresses                   | Routes packets between networks                      |

> 💡 **Key rule:** Physical layer devices are "dumb" — they only deal with **signals and bits**, never with addresses or data content. _Source: cloudns_

---

# Data Link Layer — OSI Layer 2

The **Data Link Layer** transforms the raw bit stream from the physical layer into a **reliable node-to-node (hop-to-hop) link**. It handles delivery of frames between two **directly connected** devices only — it cannot work across networks (that is the job of Layer 3). _Source: networkacademy_

---

## Hop-to-Hop Delivery (Key Concept)

This is the most important concept of Layer 2. _Source: networkacademy_

```
PC1 ──── R1 ──── R2 ──── PC2

Layer 3 (IP):   PC1 ───────────────────────► PC2  (end-to-end, never changes)
Layer 2 (MAC):  PC1→R1 | R1→R2 | R2→PC2         (hop-to-hop, changes at every router)
```

- The **IP packet stays the same** from source to destination
- The **Layer 2 frame is destroyed and rebuilt at every router hop**
- Each new frame uses the **MAC addresses of that specific link only** _Source: networkacademy_

> 💡 Think of it like a relay race — the baton (IP packet) stays the same, but each runner (frame) is different on each leg.

---

## Data Link Layer — Two Sublayers

Layer 2 is divided into two sublayers. _Source: en.wikipedia_

```
┌──────────────────────────────┐
│   LLC (Logical Link Control) │  ← Interface with Network Layer (Layer 3)
│      IEEE 802.2              │    Handles flow control, error notification
├──────────────────────────────┤
│   MAC (Media Access Control) │  ← Interface with Physical Layer (Layer 1)
│      IEEE 802.3 / 802.11     │    Handles framing, addressing, access control
└──────────────────────────────┘
```

---

## Functions of Data Link Layer

### 1. Framing

Divides the raw bit stream into manageable units called **frames**. Each frame has: _Source: geeksforgeeks_

- **Header** — Source MAC, Destination MAC, type/length field
- **Data (Payload)** — the IP packet from Layer 3
- **Trailer** — FCS (Frame Check Sequence) for error detection

```
┌────────┬──────────┬──────────┬──────────────┬─────┐
│Preamble│ Dest MAC │  Src MAC │  Data (IP pkt)│ FCS │
└────────┴──────────┴──────────┴──────────────┴─────┘
```

**Types of framing:**

- **Fixed size** — each frame is a fixed number of bytes (e.g., ATM cells = 53 bytes)
- **Variable size** — frames have delimiter flags to mark start/end (e.g., Ethernet, HDLC)

---

### 2. Physical Addressing (MAC Addressing)

Adds the **sender's and receiver's MAC addresses** to the frame header. _Source: scribd_

- **MAC address** = 48-bit (6-byte) hardware address burned into NIC
- Format: `AA:BB:CC:DD:EE:FF` (hexadecimal)
- **First 3 bytes** = OUI (Organizationally Unique Identifier — vendor)
- **Last 3 bytes** = Device-specific identifier
- MAC addresses are **only relevant on the local link** — replaced at every hop

---

### 3. Flow Control

Prevents a fast sender from **overwhelming a slow receiver**. _Source: rlacollege.edu_

- Receiver signals the sender to slow down or stop
- Two methods:
  - **Stop-and-Wait** — sender sends one frame, waits for ACK before sending next
  - **Sliding Window** — sender can send multiple frames before needing an ACK (more efficient)

---

### 4. Error Control

Detects (and sometimes corrects) **damaged, lost, or duplicate frames**. _Source: scribd_

| Mechanism            | How it Works                                                      |
| -------------------- | ----------------------------------------------------------------- |
| **FCS / CRC**        | Sender calculates checksum; receiver recalculates and compares    |
| **Parity Bit**       | Simple single-bit error detection                                 |
| **ACK + Retransmit** | Receiver sends ACK; sender retransmits if no ACK received in time |
| **Sequence Numbers** | Detects duplicate or out-of-order frames                          |

> CRC (Cyclic Redundancy Check) is the most common — used in Ethernet FCS trailer.

---

### 5. Access Control (MAC — Media Access Control)

When **multiple devices share the same medium**, access control prevents collisions. _Source: scribd_

| Method            | Used In                      | How it Works                                               |
| ----------------- | ---------------------------- | ---------------------------------------------------------- |
| **CSMA/CD**       | Wired Ethernet (half-duplex) | Listen before transmit; detect and recover from collisions |
| **CSMA/CA**       | Wi-Fi (802.11)               | Avoid collisions using random backoff before transmitting  |
| **Token Passing** | Token Ring                   | Only the device holding the token can transmit             |
| **TDMA**          | Cellular, WAN                | Fixed time slots assigned to each device                   |

---

## Protocols of Data Link Layer

| Protocol                  | Used For                            |
| ------------------------- | ----------------------------------- |
| **Ethernet (IEEE 802.3)** | Wired LAN — most common L2 protocol |
| **Wi-Fi (IEEE 802.11)**   | Wireless LAN                        |
| **PPP**                   | Point-to-point WAN serial links     |
| **HDLC**                  | Cisco default serial encapsulation  |
| **Frame Relay**           | Legacy WAN packet switching         |
| **ATM**                   | Fixed 53-byte cell WAN              |
| **ARP**                   | Resolves IP address → MAC address   |
| **STP (802.1D)**          | Prevents switching loops            |
| **VLAN (802.1Q)**         | Logical segmentation of L2 networks |
| **PPPoE**                 | PPP over Ethernet (DSL)             |

---

## Devices of Data Link Layer

| Device                           | Role                                                                                        |
| -------------------------------- | ------------------------------------------------------------------------------------------- |
| **Switch**                       | Forwards frames based on **MAC address table**; creates separate collision domains per port |
| **Bridge**                       | Connects two LAN segments; filters traffic based on MAC address                             |
| **NIC (Network Interface Card)** | Contains MAC address; handles L2 framing and signaling                                      |
| **Wireless Access Point (AP)**   | Bridges wireless (802.11) and wired (802.3) L2 networks                                     |

---

## Layer 2 Frame Flow — Full Picture

```
PC1 wants to send data to PC2 via R1 and R2:

Step 1: PC1 creates frame
        Src MAC = PC1_MAC, Dst MAC = R1_MAC (next hop)

Step 2: R1 receives frame
        → Strips L2 header/trailer
        → Makes routing decision (looks at IP)
        → Creates NEW frame: Src MAC = R1_MAC, Dst MAC = R2_MAC

Step 3: R2 receives frame
        → Strips L2 header/trailer
        → Creates NEW frame: Src MAC = R2_MAC, Dst MAC = PC2_MAC

Step 4: PC2 receives frame
        → Strips frame → passes IP packet up to Layer 3
```

> ⚠️ IP packet (Layer 3) = unchanged throughout | Frame (Layer 2) = recreated at every hop _Source: networkacademy_

---

# Network Layer — OSI Layer 3

The **Network Layer** is responsible for **source-to-destination (end-to-end) delivery** of packets across multiple networks. Unlike Layer 2 which only delivers between two directly connected devices, Layer 3 can route packets across many different networks to reach the final destination. _Source: geeksforgeeks_

---

## Source-to-Destination Delivery (Key Concept)

This is the defining role of Layer 3. _Source: networkacademy_

```
PC1 ──── R1 ──── R2 ──── R3 ──── PC2
(Network A)           (Network B)  (Network C)

Layer 2 (MAC): PC1→R1 | R1→R2 | R2→R3 | R3→PC2   (hop-by-hop, changes every hop)
Layer 3 (IP):  PC1 ──────────────────────────► PC2  (end-to-end, NEVER changes)
```

- **IP Source address** = always PC1's IP
- **IP Destination address** = always PC2's IP
- Layer 3 doesn't care about intermediate hops — it only cares about **final destination** _Source: scribd_

---

## Direct vs Indirect Delivery

| Type                  | When Used                                                                           | Example                     |
| --------------------- | ----------------------------------------------------------------------------------- | --------------------------- |
| **Direct Delivery**   | Source and destination on **same network** — no router needed                       | 192.168.1.10 → 192.168.1.20 |
| **Indirect Delivery** | Source and destination on **different networks** — goes through one or more routers | 192.168.1.10 → 10.0.0.5     |

_Source: nscpolteksby.ac_

---

## Functions of Network Layer

### 1. Logical Addressing

Physical (MAC) addresses only work **within the same network**. When a packet travels across multiple networks, a **universal logical address (IP address)** is needed. _Source: spu.edu_

- **IPv4** — 32-bit address (e.g., `192.168.1.10`) — written as 4 dotted decimals
- **IPv6** — 128-bit address (e.g., `2001:DB8::1`) — for future scalability
- Structure: **Network ID** + **Host ID**
  - Example: `192.168.1.10/24` → Network = `192.168.1.0`, Host = `.10`
- A **header** is added to every packet containing Source IP and Destination IP _Source: scribd_

**IPv4 Packet Header key fields:**

```
┌─────────┬────────────┬───────────┬─────┬──────────┬────────────┬───────────┐
│ Version │ Header Len │  TTL      │Proto│ Src IP   │  Dst IP    │  Data     │
│  (4)    │  (IHL)     │(prevents  │(TCP │          │            │(L4 segment│
│         │            │ loops)    │=6,  │          │            │  inside)  │
│         │            │           │UDP=17)         │            │           │
└─────────┴────────────┴───────────┴─────┴──────────┴────────────┴───────────┘
```

- **TTL (Time to Live)** — decremented by 1 at each router; when TTL = 0, packet is dropped → prevents infinite loops _Source: scribd_
- **Protocol** — identifies upper layer: TCP = 6, UDP = 17, ICMP = 1

---

### 2. Routing

When packets must travel across multiple networks, **routers determine the best path** to the destination. _Source: networkacademy_

- **Routing** = Path determination (control plane) — deciding which way to send
- **Forwarding** = Packet movement (data plane) — actually sending it out the right interface

**Routing methods:**

| Method              | Description                                      | Example                                       |
| ------------------- | ------------------------------------------------ | --------------------------------------------- |
| **Static Routing**  | Manually configured by admin                     | `ip route 10.0.0.0 255.255.255.0 192.168.1.1` |
| **Dynamic Routing** | Routers automatically exchange and update routes | RIP, OSPF, EIGRP                              |
| **Default Routing** | Single catch-all route for unknown destinations  | `ip route 0.0.0.0 0.0.0.0 [next-hop]`         |

---

### 3. Packetizing

The network layer **encapsulates** the segment from Layer 4 into a packet by adding the IP header. _Source: geeksforgeeks_

```
Layer 4 segment → + IP Header = Layer 3 Packet
```

---

### 4. Fragmentation

If a packet is **larger than the MTU** (Maximum Transmission Unit) of the next network link, the router fragments it into smaller pieces. _Source: scribd_

- Default Ethernet MTU = **1500 bytes**
- Each fragment has same IP header with **Identification**, **Fragment Offset**, and **More Fragments (MF)** flag
- Reassembly happens only at the **final destination** (not intermediate routers)

---

## Layer 3 — Full Picture: Hop-by-Hop vs End-to-End

```
Source PC (192.168.1.10) → R1 → R2 → R3 → Destination PC (10.0.0.5)

At every router:
  ✅ IP Header (L3) is READ to make routing decision
  ✅ L2 frame is STRIPPED and REBUILT with new MAC addresses
  ❌ IP Source/Destination NEVER changes
  ❌ Transport (L4) data is NOT touched
```

---

## Protocols of Network Layer

| Protocol   | Purpose                                            |
| ---------- | -------------------------------------------------- |
| **IPv4**   | 32-bit logical addressing and packet delivery      |
| **IPv6**   | 128-bit next-generation IP                         |
| **ICMP**   | Error reporting and diagnostics (ping, traceroute) |
| **ICMPv6** | ICMP for IPv6 + Neighbour Discovery (NDP)          |
| **ARP**    | Resolves IP → MAC (technically L2/L3 boundary)     |
| **RIP**    | Distance vector routing protocol                   |
| **OSPF**   | Link-state routing protocol                        |
| **EIGRP**  | Advanced distance vector routing (Cisco)           |
| **BGP**    | Path vector — inter-AS routing (internet backbone) |
| **NAT**    | Translates private ↔ public IP addresses           |
| **IPSec**  | Encryption and authentication at network layer     |

---

## Devices of Network Layer

| Device                | Role                                                                                                 |
| --------------------- | ---------------------------------------------------------------------------------------------------- |
| **Router**            | Primary Layer 3 device — reads IP header, makes routing decisions, forwards packets between networks |
| **Layer 3 Switch**    | Switch with routing capability — routes between VLANs using SVIs (Switched Virtual Interfaces)       |
| **Multilayer Switch** | Same as L3 switch — can do both switching (L2) and routing (L3)                                      |
| **Firewall (L3)**     | Filters packets based on IP addresses and protocols                                                  |

---

## Layer Comparison — L1 vs L2 vs L3

| Feature       | L1 Physical          | L2 Data Link         | L3 Network                   |
| ------------- | -------------------- | -------------------- | ---------------------------- |
| Unit of data  | Bits                 | Frames               | Packets                      |
| Addressing    | None                 | MAC (48-bit)         | IP (32/128-bit)              |
| Scope         | Single cable         | Single network (hop) | Across networks (end-to-end) |
| Delivery type | Signal propagation   | Hop-to-hop           | Source-to-destination        |
| Devices       | Hub, Repeater        | Switch, Bridge       | Router, L3 Switch            |
| Protocols     | Ethernet PHY, RS-232 | Ethernet, PPP, HDLC  | IP, ICMP, RIP, OSPF          |

---

# Transport Layer — OSI Layer 4

The **Transport Layer** is responsible for **process-to-process (end-to-end) delivery of the entire message**. While Layer 3 delivers individual packets between hosts, Layer 4 ensures the **complete message** arrives correctly at the **right application process** on the destination host. _Source: studocu_

---

## Process-to-Process Delivery (Key Concept)

A **process** is an application program running on a host (e.g., Chrome browser, FTP client, web server). _Source: studocu_

```
Source Host                          Destination Host
┌──────────────┐                    ┌──────────────┐
│ Chrome :1050 │                    │ Apache :80   │
│ FTP    :1051 │                    │ FTP    :21   │
│ SSH    :1052 │                    │ SSH    :22   │
└──────┬───────┘                    └──────┬───────┘
       │ Layer 4 (Port numbers)            │
       └─────── Process-to-Process ────────┘
       │ Layer 3 (IP addresses)            │
       └─────── Host-to-Host ──────────────┘
       │ Layer 2 (MAC addresses)           │
       └─────── Hop-to-Hop ────────────────┘
```

- Layer 3 delivers to the **right host** (IP address)
- Layer 4 delivers to the **right application** on that host (Port number) _Source: studocu_

---

## Functions of Transport Layer

### 1. Port Addressing

Ensures the right application receives the data on a host running multiple processes simultaneously. _Source: studocu_

- **Port number** = 16-bit number (0 – 65535) identifying a specific process
- Combined with IP address → forms a **Socket**: `192.168.1.10:80`

| Port Range    | Type                  | Examples                                            |
| ------------- | --------------------- | --------------------------------------------------- |
| 0 – 1023      | **Well-known ports**  | HTTP=80, HTTPS=443, FTP=21, SSH=22, DNS=53, SMTP=25 |
| 1024 – 49151  | **Registered ports**  | MySQL=3306, RDP=3389                                |
| 49152 – 65535 | **Dynamic/Ephemeral** | Assigned temporarily to client processes            |

---

### 2. Segmentation and Reassembly

The transport layer **divides a large message** into smaller **segments**, each with a sequence number. _Source: studocu_

```
Message (large):  [AAAA BBBB CCCC DDDD]
                           ↓ Segmentation
Segment 1: [Seq=1 | AAAA]
Segment 2: [Seq=2 | BBBB]
Segment 3: [Seq=3 | CCCC]
Segment 4: [Seq=4 | DDDD]
                           ↓ Transmitted independently
Destination reassembles using Seq numbers → [AAAA BBBB CCCC DDDD]
```

Sequence numbers help the receiver: _Source: studocu_

- **Reassemble** out-of-order segments in correct order
- **Detect lost** segments (missing sequence number)
- **Detect duplicates** (same sequence number twice)

---

### 3. Connection Control

| Type                    | Description                                                                  | Protocol |
| ----------------------- | ---------------------------------------------------------------------------- | -------- |
| **Connection-Oriented** | Establishes a connection first, transfers data, then terminates; reliable    | TCP      |
| **Connectionless**      | No connection setup; each segment treated independently; fast but unreliable | UDP      |

**TCP 3-Way Handshake (Connection Setup):**

```
Client ──SYN──────────────────────► Server
Client ◄──────────────SYN-ACK───── Server
Client ──ACK──────────────────────► Server
           Connection Established
```

**TCP 4-Way Termination:**

```
Client ──FIN──────────────────────► Server
Client ◄──────────────ACK───────── Server
Client ◄──────────────FIN───────── Server
Client ──ACK──────────────────────► Server
```

---

### 4. Flow Control (End-to-End)

Prevents the sender from **overwhelming a slow receiver**. This is **end-to-end** (between source and destination processes), not hop-to-hop. _Source: studocu_

- **TCP Sliding Window** — receiver advertises how much buffer space is available (`Window Size`)
- Sender can only transmit up to the window size before needing ACK
- If receiver is slow → window shrinks → sender slows down
- If receiver is fast → window grows → sender speeds up

```
Sender:    Window size = 3 → can send 3 unacknowledged
Receiver: ACK 3, Window=2   → sender can now send only 2 more
```

_Source: baeldung_

---

### 5. Error Control (End-to-End)

Ensures **process-to-process** reliable delivery using: _Source: studocu_

- **Checksum** — detects corrupted segments
- **ACK (Acknowledgment)** — receiver confirms receipt of segments
- **Retransmission** — if no ACK received within timeout (RTO), sender retransmits
- **Sequence numbers** — detect lost, duplicate, or out-of-order segments

> ⚠️ Layer 4 error control is **end-to-end** (source process → destination process), unlike Layer 2 error control which is hop-to-hop.

---

## TCP vs UDP — Core Protocols

| Feature         | TCP                                   | UDP                              |
| --------------- | ------------------------------------- | -------------------------------- |
| Full Name       | Transmission Control Protocol         | User Datagram Protocol           |
| Connection      | Connection-oriented (3-way handshake) | Connectionless                   |
| Reliability     | Reliable (ACK + retransmit)           | Unreliable (no ACK)              |
| Ordering        | Sequence numbers — guaranteed order   | No ordering                      |
| Flow Control    | Yes (sliding window)                  | No                               |
| Error Control   | Yes (checksum + ACK)                  | Checksum only                    |
| Speed           | Slower (overhead)                     | **Faster** (no overhead)         |
| Header size     | 20–60 bytes                           | 8 bytes                          |
| Use case        | Web, email, file transfer             | DNS, VoIP, video streaming, DHCP |
| Protocol number | IP Protocol 6                         | IP Protocol 17                   |

---

## TCP Segment Header (Key Fields)

```
┌──────────────┬──────────────┐
│  Src Port    │  Dst Port    │  16-bit each
├──────────────┴──────────────┤
│        Sequence Number       │  32-bit — for ordering
├─────────────────────────────┤
│      Acknowledgment Number   │  32-bit — next expected byte
├──────┬──────────────────────┤
│ Flags│ SYN ACK FIN RST PSH  │  Control bits
├──────┴──────────────────────┤
│        Window Size           │  Flow control
├─────────────────────────────┤
│          Checksum            │  Error detection
└─────────────────────────────┘
```

## UDP Segment Header (Key Fields)

```
┌──────────────┬──────────────┐
│  Src Port    │  Dst Port    │  16-bit each
├──────────────┴──────────────┤
│  Length      │  Checksum    │
└─────────────────────────────┘
```

---

## Protocols of Transport Layer

| Protocol | Type                                | Use                                 |
| -------- | ----------------------------------- | ----------------------------------- |
| **TCP**  | Connection-oriented                 | HTTP, HTTPS, FTP, SSH, SMTP, Telnet |
| **UDP**  | Connectionless                      | DNS, DHCP, SNMP, VoIP, TFTP, RIP    |
| **SCTP** | Connection-oriented                 | Telephony signaling (SS7 over IP)   |
| **DCCP** | Connectionless + congestion control | Streaming media                     |

---

## Devices of Transport Layer

Transport Layer is implemented in **software** — it operates on end hosts, not networking devices. _Source: en.wikipedia_

| Device/Component           | Role                                                               |
| -------------------------- | ------------------------------------------------------------------ |
| **Host OS (TCP/IP stack)** | Every OS (Windows, Linux, macOS) implements TCP/UDP in the kernel  |
| **Firewall (Stateful)**    | Inspects TCP/UDP port numbers to allow/block traffic               |
| **Load Balancer**          | Distributes connections across servers based on L4 port/protocol   |
| **Proxy Server**           | Terminates and re-establishes TCP connections on behalf of clients |

> 💡 Routers and switches do **not** process Layer 4 normally — they only look at L2/L3. Only firewalls, load balancers, and end hosts process Layer 4.

---

## Layer Comparison: L2 vs L3 vs L4

| Feature        | L2 Data Link   | L3 Network         | L4 Transport       |
| -------------- | -------------- | ------------------ | ------------------ |
| Unit           | Frame          | Packet             | Segment            |
| Addressing     | MAC address    | IP address         | Port number        |
| Delivery scope | Hop-to-hop     | Host-to-host       | Process-to-process |
| Reliability    | Per-link       | None (best effort) | End-to-end (TCP)   |
| Protocols      | Ethernet, PPP  | IP, ICMP, OSPF     | TCP, UDP           |
| Devices        | Switch, Bridge | Router, L3 Switch  | Host OS, Firewall  |

---

# Session Layer — OSI Layer 5

The **Session Layer** is the network's **dialog controller** — it establishes, manages, synchronizes, and terminates **communication sessions** between two application processes on different machines. It sits above the Transport Layer and uses its services to create meaningful, organized conversations. _Source: geeksforgeeks_

---

## What is a Session?

A **session** is a logical, persistent connection between two application processes for the duration of their communication. _Source: tutorialspoint_

```
Browser (Client) ←────── Session ───────► Web Server
                   (established, maintained,
                    synchronized, terminated)
```

Multiple sessions can exist simultaneously between the same two hosts (e.g., multiple browser tabs). _Source: networkwalks_

---

## Session Lifecycle

Every session goes through three phases: _Source: lightyear_

```
1. ESTABLISHMENT → Negotiate parameters, authenticate, select duplex mode
        ↓
2. DATA TRANSFER → Dialog exchange with synchronization checkpoints
        ↓
3. TERMINATION  → Graceful session close after all data exchanged
```

---

## Functions of Session Layer

### 1. Dialog Control

Controls the **direction and turn-taking** of communication between two systems. _Source: scribd_

| Mode            | Description                                     | Example                 |
| --------------- | ----------------------------------------------- | ----------------------- |
| **Half-Duplex** | Only one side speaks at a time; other must wait | Walkie-talkie, HTTP/1.0 |
| **Full-Duplex** | Both sides can communicate simultaneously       | Video call, HTTP/2      |

- Session layer **negotiates** which mode to use during session establishment _Source: studytonight_
- In half-duplex, it manages **tokens** — only the device holding the token can send _Source: en.wikipedia_

---

### 2. Synchronization (Checkpoints)

This is the most unique and important function of the Session Layer. _Source: jobexams_

**Problem without checkpoints:**

```
Transferring a 1 GB file → network fails at 900 MB
→ Must restart from 0 bytes — entire transfer wasted!
```

**Solution — Checkpoints:**
The session layer inserts **synchronization points (checkpoints)** into the data stream at regular intervals. _Source: scribd_

```
[Data 0–100MB] ──CHECKPOINT 1──
[Data 100–200MB] ──CHECKPOINT 2──
[Data 200–300MB] ──CHECKPOINT 3──
...
Network fails at 850 MB
→ Resume from CHECKPOINT 8 (800 MB) — only resend last 50 MB!
```

**Two types of synchronization points**: _Source: youtube_

- **Major Sync Point** — defines explicit boundary; all data up to this point is committed and acknowledged; cannot go back beyond this
- **Minor Sync Point** — more frequent, finer-grained checkpoints within major points; allows fine recovery without full retransmission

---

### 3. Session Management

Handles full session lifecycle: _Source: geeksforgeeks_

- **Authentication** — verifies identity before session begins (username/password)
- **Authorization** — confirms what the user is allowed to do
- **Session ID** — unique identifier for each session
- **Re-synchronization** — restores session to last known good checkpoint after failure _Source: tutorialspoint_

---

## Session Layer in Context

```
Application (e.g., File Transfer)
         ↓
Session Layer inserts checkpoints every X MB
         ↓
Transport Layer (TCP) handles segment delivery
         ↓
Network Layer (IP) handles routing
         ↓
...

If link fails:
  → TCP connection re-established (Layer 4)
  → Session resumes from last checkpoint (Layer 5) ✅
  → No need to restart the entire file transfer
```

---

## Protocols of Session Layer

| Protocol                              | Purpose                                                               |
| ------------------------------------- | --------------------------------------------------------------------- |
| **RPC (Remote Procedure Call)**       | Allows a program to execute procedures on a remote server as if local |
| **NetBIOS**                           | Session establishment for Windows file/printer sharing                |
| **PPTP**                              | Point-to-Point Tunneling Protocol — VPN session management            |
| **SIP (Session Initiation Protocol)** | Establishes/manages VoIP and video call sessions                      |
| **RTCP**                              | Real-Time Control Protocol — monitors RTP media sessions              |
| **L2TP**                              | Layer 2 Tunneling Protocol — VPN tunneling                            |
| **PAP**                               | Password Authentication Protocol — session-level authentication       |
| **H.245**                             | Multimedia session control (video conferencing)                       |

_Source: router-switch_

---

## Devices of Session Layer

The Session Layer operates in **software** — no dedicated hardware devices. _Source: lightyear_

| Device / Component                   | Role                                                                        |
| ------------------------------------ | --------------------------------------------------------------------------- |
| **Application Servers**              | Create and maintain user sessions for web apps, databases                   |
| **Proxy Servers**                    | Manage sessions between clients and backend servers                         |
| **Firewalls (Stateful)**             | Track and control active sessions; block unauthorized session establishment |
| **Session Border Controllers (SBC)** | Secure and manage VoIP/video call sessions                                  |
| **VPN Gateways**                     | Establish and maintain encrypted VPN sessions (PPTP, L2TP)                  |

---

## Layer Comparison: L4 vs L5 vs L6

| Feature      | L4 Transport       | L5 Session         | L6 Presentation         |
| ------------ | ------------------ | ------------------ | ----------------------- |
| Unit         | Segment            | Session data       | Encoded data            |
| Scope        | Process-to-process | Session management | Data formatting         |
| Key function | Reliable delivery  | Dialog + sync      | Encryption, compression |
| Addressing   | Port numbers       | Session IDs        | None                    |
| Protocols    | TCP, UDP           | SIP, RPC, NetBIOS  | SSL/TLS, JPEG, MPEG     |
| Devices      | Host OS, Firewall  | App server, SBC    | Host software           |

---

# Presentation Layer — OSI Layer 6

The Presentation Layer is called the **"Translator" or "Syntax Layer"** of the OSI model. It ensures that data sent by the application layer of one system is **readable by the application layer of another system**, regardless of internal data formats. _Source: en.wikipedia_

---

## Functions of Presentation Layer

### 1. Translation (Data Conversion)

Different systems use different data formats — the Presentation Layer converts between them using a **common intermediate format**. _Source: osi-model_

| From           | To                | Example                            |
| -------------- | ----------------- | ---------------------------------- |
| **EBCDIC**     | **ASCII**         | IBM mainframe → PC communication   |
| **ASCII**      | **Unicode**       | Older system → modern multilingual |
| **Big-endian** | **Little-endian** | Different CPU architectures        |
| **JPEG/PNG**   | Internal bitmap   | Image display                      |

- Uses **ASN.1 (Abstract Syntax Notation One)** as the common language for describing data structures _Source: tutorialspoint_
- Handles **serialization** — converting complex objects (like JSON, XML) into flat byte strings for transmission _Source: en.wikipedia_
- String representations: Pascal style (length prefix) vs C style (null-terminated `\0`) _Source: osi-model_

---

### 2. Encryption & Decryption

Provides **confidentiality** by encoding data before transmission and decoding it at the destination. _Source: tutorialspoint_

- **Encryption** at sender → data becomes unreadable during transit
- **Decryption** at receiver → restores original data
- Example: When you log into a banking website, the Presentation Layer **decrypts incoming data** using SSL/TLS _Source: osi-model_
- Protects against eavesdropping, unauthorized access, and replay attacks

---

### 3. Compression & Decompression

Reduces the **size of data** before transmission to save bandwidth. _Source: tutorialspoint_

- **Lossy compression** — some data lost; acceptable for media (JPEG images, MP3 audio)
- **Lossless compression** — no data lost; required for text/files (ZIP, GZIP)

| Type          | Algorithms     | Use                   |
| ------------- | -------------- | --------------------- |
| Lossless      | ZIP, GZIP, LZW | Text files, documents |
| Lossy (image) | JPEG           | Photos                |
| Lossy (video) | MPEG, H.264    | Video streaming       |
| Lossy (audio) | MP3, AAC       | Music, voice          |

---

## Protocols of Presentation Layer

| Protocol                               | Purpose                                |
| -------------------------------------- | -------------------------------------- |
| **SSL/TLS**                            | Encryption for web (HTTPS), email, VPN |
| **JPEG**                               | Image compression standard             |
| **MPEG**                               | Video/audio compression                |
| **GIF / PNG**                          | Image formats                          |
| **ASCII / EBCDIC / Unicode**           | Character encoding standards           |
| **XDR (External Data Representation)** | Sun Microsystems data format standard  |
| **MIME**                               | Email attachment encoding (Base64)     |

---

## Devices of Presentation Layer

Presentation Layer is **purely software** — no dedicated hardware. _Source: jumpcloud_

| Component                | Role                                         |
| ------------------------ | -------------------------------------------- |
| **Web browsers**         | Handle SSL/TLS decryption, HTML/JSON parsing |
| **Media players**        | Decompress JPEG, MPEG, MP3                   |
| **Email clients**        | Decode MIME-encoded attachments              |
| **Encryption libraries** | OpenSSL, Bouncy Castle                       |

---

---

# Application Layer — OSI Layer 7

The **Application Layer** is the **topmost layer** of the OSI model — it provides a **network interface directly to the user's application**. It does not refer to the applications themselves (like Chrome or Outlook), but rather to the **protocols and services** that allow those applications to use the network. _Source: en.wikipedia_

---

## Functions of Application Layer

### 1. Network Virtual Terminal (NVT)

Allows a user on one host to connect to a **remote computer as if it were a local terminal**. _Source: cloudns_

- Creates a **software emulation of a terminal** at the remote machine
- The local keyboard input and remote screen output are transmitted over the network
- **Protocols:** Telnet (unencrypted), SSH (encrypted)

```
Local PC ──── SSH/Telnet ────► Remote Server
(terminal emulator)           (as if sitting at the server)
```

### 2. File Transfer, Access, and Management (FTAM)

Allows users to **access files on remote systems**, transfer files, and manage remote file systems. _Source: en.wikipedia_

- **FTP (File Transfer Protocol)** — upload/download files (port 21)
- **TFTP (Trivial FTP)** — simplified, uses UDP, no authentication (port 69)
- **SFTP / SCP** — secure file transfer over SSH
- **NFS** — Network File System (mount remote directories)
- **SMB/CIFS** — Windows file sharing

### 3. Mail Services

Provides **electronic messaging** between users across networks. _Source: cloudns_

- **SMTP (Simple Mail Transfer Protocol)** — sends email (port 25/587)
- **POP3 (Post Office Protocol v3)** — downloads email to client (port 110)
- **IMAP4 (Internet Message Access Protocol)** — reads email on server (port 143)
- **MIME** — handles attachments and non-ASCII content in emails

### 4. Directory Services

Provides a **lookup system** for network resources — translating human-readable names to addresses. _Source: en.wikipedia_

- **DNS (Domain Name System)** — resolves domain names → IP (e.g., `google.com` → `142.250.80.14`)
- **LDAP (Lightweight Directory Access Protocol)** — access directory services (user authentication, Active Directory)
- **NIS (Network Information Service)** — Unix/Linux directory service

### 5. Other Application Layer Services

| Service            | Protocol | Port    |
| ------------------ | -------- | ------- |
| Web browsing       | HTTP     | 80      |
| Secure web         | HTTPS    | 443     |
| Remote admin       | SSH      | 22      |
| Remote terminal    | Telnet   | 23      |
| Network management | SNMP     | 161/162 |
| Time sync          | NTP      | 123     |
| IP addressing      | DHCP     | 67/68   |

---

## Protocols of Application Layer

| Protocol               | Function                  |
| ---------------------- | ------------------------- |
| **HTTP / HTTPS**       | Web browsing              |
| **FTP / TFTP / SFTP**  | File transfer             |
| **SMTP / POP3 / IMAP** | Email                     |
| **DNS**                | Name resolution           |
| **DHCP**               | Dynamic IP assignment     |
| **Telnet / SSH**       | Remote terminal access    |
| **SNMP**               | Network device management |
| **NTP**                | Time synchronization      |
| **LDAP**               | Directory services        |
| **SIP**                | VoIP session setup        |

---

## Devices of Application Layer

| Device / Component             | Role                                                      |
| ------------------------------ | --------------------------------------------------------- |
| **End-user computers**         | Run application layer protocols (browsers, email clients) |
| **Web servers**                | Serve HTTP/HTTPS content                                  |
| **DNS servers**                | Resolve domain names                                      |
| **Mail servers**               | Handle SMTP/POP3/IMAP                                     |
| **DHCP servers**               | Assign IP addresses dynamically                           |
| **Application firewalls (L7)** | Deep packet inspection at application layer               |
| **Load balancers (L7)**        | Route requests based on URL, cookies, HTTP headers        |

---

## Complete OSI Model — Quick Summary

| Layer | Name         | PDU     | Protocols                  | Devices                 |
| ----- | ------------ | ------- | -------------------------- | ----------------------- |
| 7     | Application  | Data    | HTTP, FTP, DNS, SMTP, DHCP | Web server, DNS server  |
| 6     | Presentation | Data    | SSL/TLS, JPEG, MPEG, ASCII | Software only           |
| 5     | Session      | Data    | SIP, RPC, NetBIOS          | App server, SBC         |
| 4     | Transport    | Segment | TCP, UDP                   | Firewall, Load balancer |
| 3     | Network      | Packet  | IP, ICMP, OSPF, RIP        | Router, L3 Switch       |
| 2     | Data Link    | Frame   | Ethernet, PPP, HDLC        | Switch, Bridge          |
| 1     | Physical     | Bits    | RS-232, IEEE 802.3         | Hub, Repeater, Cable    |
