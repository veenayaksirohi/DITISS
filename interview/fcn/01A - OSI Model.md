---
title: "01A - OSI Model"
aliases:
  - "01 - OSI Model"
  - "OSI Model — Complete Study Notes"
  - "OSI Model Notes"
tags:
  - computer-networks
  - osi-model
  - networking-fundamentals
syllabus-topic:
  - 1
  - 10
  - 12
---

# OSI Model — Complete Study Notes
> CDAC DITISS | Computer Networks | Interview-Oriented

---

## Table of Contents
- [Layer 1 — Physical Layer](#layer-1--physical-layer)
- [Layer 2 — Data Link Layer](#layer-2--data-link-layer)
- [Layer 3 — Network Layer](#layer-3--network-layer)
- [Layer 4 — Transport Layer](#layer-4--transport-layer)
- [Layer 5 — Session Layer](#layer-5--session-layer)
- [Layer 6 — Presentation Layer](#layer-6--presentation-layer)
- [Layer 7 — Application Layer](#layer-7--application-layer)

---

## Layer 1 — Physical Layer

### 1. Role & Overview

- **Lowest OSI layer** — responsible for transmitting raw bits (0s and 1s) over a physical medium.
- Converts higher-layer units into electrical/optical/radio signals (**encoding/modulation**), and converts received signals back into bits (**decoding/demodulation**).
- Deals with mechanical, electrical, and functional details: connectors, cable types, voltage levels, timing (clocking), bit rates, line coding, and physical topology.

> **In short:** Layer 1 is actual connectivity — it defines the physical characteristics of the network and handles raw bit flow over the medium (copper, fibre, or radio).

---

### 2. Why Layer 1 is Called a "Dumb Layer"

- Does **not** understand frames, packets, addresses, ports, or application data — it only moves bits.
- Devices at this layer (hubs, repeaters, CSU/DSU) make **no forwarding decisions** based on MAC/IP and maintain no routing/forwarding tables.
- Performs signal transmission/regeneration **only** — no filtering, no addressing logic.

---

### 3. Cables & Connectors

#### Cable Types

| Cable | Description |
|-------|-------------|
| **UTP** (Unshielded Twisted Pair) | Common for Ethernet (Cat5e / Cat6); no shielding |
| **STP** (Shielded Twisted Pair) | Has foil/braid shielding to reduce EMI |
| **Coaxial (coax)** | Legacy use — 10BASE-2 / 10BASE-5 |
| **Fibre Optic** | Transmits light; immune to EMI; used for long distances / high bandwidth |

#### RJ45 / 8P8C Connector (Ethernet)
- Standard connector for twisted-pair Ethernet cabling.
- Uses wiring standards **T568A** or **T568B** (pinout order for 8 conductors).
- Poor crimping causes intermittent faults and signal reflections.

> **Interview Trap:** T568A and T568B differ only in the swap of pairs 2 and 3 (orange ↔ green). Crossover cables use T568A on one end and T568B on the other.

---

### 4. Bits, Voltage Signals & Encoding

- Bits are represented by changes in **voltage**, **light intensity**, or **radio waveform** on the medium.
- **Line encoding** maps bits → physical signal shapes:

| Encoding | How it Works |
|----------|-------------|
| **NRZ** (Non-Return to Zero) | Steady voltage for 0 and 1 — simple but prone to clock drift |
| **Manchester** | Signal transitions in the *middle* of each bit interval — helps with clock recovery |

- **Modulation** (for analogue carriers) and encoding together determine reliability and clock recovery at the receiver.

---

### 5. Communication Methods

#### Serial vs Parallel

| Method | Description | Use Case |
|--------|-------------|----------|
| **Serial** | Bits sent one after another over one wire/pair | Networking, long-distance |
| **Parallel** | Multiple bits sent simultaneously over multiple wires | Short distances — internal buses, legacy printer ports |

> **Parallel problem:** Signal skew (timing differences across wires) and EMI make parallel impractical over longer runs.

#### Asynchronous vs Synchronous Serial

| Type | Clock | Example |
|------|-------|---------|
| **Asynchronous** | No shared clock — each byte framed with start/stop bits | RS-232, old modems |
| **Synchronous** | Sender/receiver share a clock or embed it in the stream; continuous frames | Modern high-speed links |

#### Bandwidth vs Throughput

| Term | Definition |
|------|-----------|
| **Bandwidth** | Theoretical maximum capacity (Hz or bps) of the physical medium |
| **Throughput** | Actual data rate achieved after overheads, errors, retransmits, and protocol inefficiencies |

> **Key Point:** Throughput is always ≤ Bandwidth. Real-world throughput is significantly lower due to protocol overhead and noise.

---

### 6. Transmission Modes

| Mode | Direction | Example |
|------|-----------|---------|
| **Simplex** | One-way only | TV broadcast, keyboard |
| **Half-Duplex** | Both ways, but NOT simultaneously | Walkie-talkie, hub |
| **Full-Duplex** | Both ways simultaneously | Phone call, switch port |

---

### 7. Physical Topologies

| Topology | Key Characteristic |
|----------|--------------------|
| **Mesh** | Every device connected to every other; highest redundancy |
| **Star** | All devices connect to a central switch; most common today |
| **Ring** | Each device connects to two neighbours; one break = full failure |
| **Bus** | Single shared cable; legacy (old Ethernet 10BASE-2/5) |

---

### 8. Layer 1 Devices

> **Rule:** Physical layer devices are "dumb" — they deal only with signals and bits, never with addresses or data content.

| Device | Layer | Role |
|--------|-------|------|
| **Repeater** | L1 | 2-port device; copies a weakening signal bit-by-bit and retransmits at full strength; zero intelligence — only understands voltage levels; sole job is extending cable distance |
| **Hub** | L1 | Multi-port repeater; broadcasts incoming frame out of every other port regardless of destination; creates a single shared collision domain (half-duplex). **Active hub** — boosts/regenerates the signal. **Passive hub** — simply connects wires, no signal boosting |
| **Cables** | L1 | Physical medium — UTP, STP, coaxial, fibre optic |
| **Connectors** | L1 | RJ-45, BNC, LC, SC, DB-9 — physical interface points |
| **NIC** | L1/L2 | Converts digital bits to electrical/optical signals; has both L1 (signal) and L2 (MAC) functions |
| **Modem** | L1 | Modulates/demodulates — converts digital bits ↔ analogue signals for telephone lines |
| **CSU/DSU** | L1 | Channel Service Unit / Data Service Unit — connects router (DTE) to WAN digital line (DCE); provides clocking |
| **Transceiver** | L1 | Converts between different physical media (e.g., copper ↔ fibre) |

---

### 9. Layer 1 Protocols & Standards

| Protocol / Standard | Description |
|--------------------|-------------|
| **Ethernet (IEEE 802.3)** | Wiring & signaling for wired LAN (10Base-T, 100Base-TX, 1000Base-T) |
| **Wi-Fi (IEEE 802.11)** | Wireless physical layer — radio frequencies (2.4 GHz, 5 GHz) |
| **Bluetooth (IEEE 802.15)** | Short-range wireless, 2.4 GHz radio |
| **USB** | Serial physical interface for peripheral devices |
| **RS-232** | Serial communication standard (console cable, old modems) |
| **DSL** | Transmits digital data over telephone lines |
| **SONET / SDH** | Fibre-optic transmission standards for WAN backbone |
| **V.35** | WAN serial interface standard (router ↔ CSU/DSU) |
| **DOCSIS** | Cable internet physical standard |
| **T1 / E1** | Digital WAN transmission lines (1.544 / 2.048 Mbps) |

---

## Layer 2 — Data Link Layer

### 1. Role & Overview

- **Second lowest OSI layer** — transforms the raw bit stream from Layer 1 into a reliable **node-to-node (hop-to-hop)** link.
- Handles delivery of frames between **two directly connected devices only** — it cannot work across networks (that is Layer 3's job).
- Encapsulates data by adding a **Layer 2 header** (source + destination MAC) and a **Layer 2 trailer** (FCS) → the result is called a **frame**.
- Hides hardware complexities from upper layers, making network communication simpler for layers above.

> **In short:** Layer 2 is the medium provision layer — it defines how data is formatted for transmission over the physical medium and handles physical MAC addressing.

---

### 2. Hop-to-Hop Delivery (Most Important Concept)

```
PC1 ──── R1 ──── R2 ──── PC2

Layer 3 (IP):   PC1 ──────────────────────► PC2   (end-to-end, never changes)
Layer 2 (MAC):  PC1→R1  |  R1→R2  |  R2→PC2      (hop-to-hop, changes at every router)
```

- The **IP packet (Layer 3) stays the same** from source to destination — never modified.
- The **Layer 2 frame is destroyed and rebuilt at every router hop** — each new frame uses the MAC addresses of that specific link only.

> **Think of it like a relay race** — the baton (IP packet) stays the same, but each runner (frame) is different on each leg.

#### Full Frame Flow Example

```
Step 1: PC1 creates frame
        Src MAC = PC1_MAC,  Dst MAC = R1_MAC  (next hop only)

Step 2: R1 receives frame
        → Strips L2 header/trailer
        → Makes routing decision (looks at IP packet)
        → Creates NEW frame: Src MAC = R1_MAC,  Dst MAC = R2_MAC

Step 3: R2 receives frame
        → Strips L2 header/trailer
        → Creates NEW frame: Src MAC = R2_MAC,  Dst MAC = PC2_MAC

Step 4: PC2 receives frame
        → Strips frame → passes IP packet up to Layer 3
```

> ⚠️ **IP packet (Layer 3) = unchanged throughout | Frame (Layer 2) = recreated at every hop**

---

### 3. Two Sublayers of Layer 2

```
┌──────────────────────────────────┐
│   LLC  (Logical Link Control)    │  ← Interface with Network Layer (Layer 3)
│         IEEE 802.2               │    Flow control, error notification, multiplexing
├──────────────────────────────────┤
│   MAC  (Media Access Control)    │  ← Interface with Physical Layer (Layer 1)
│     IEEE 802.3 / 802.11          │    Framing, MAC addressing, medium access control
└──────────────────────────────────┘
```

| Sublayer | Full Name | Key Responsibilities |
|----------|-----------|----------------------|
| **LLC** | Logical Link Control | Interface between L2 and L3; flow control; error notification; multiplexing (allows IP, IPX, AppleTalk to share the same NIC) |
| **MAC** | Media Access Control | Controls access to physical medium; adds MAC addresses to frames; converts packets → frames for Physical Layer |

---

### 4. Frame Structure

```
┌──────────┬──────────┬──────────┬──────────┬───────────────┬─────┐
│ Preamble │ Dest MAC │  Src MAC │  Type/Len│  Data (IP pkt)│ FCS │
└──────────┴──────────┴──────────┴──────────┴───────────────┴─────┘
```

| Field | Purpose |
|-------|---------|
| **Preamble** | Synchronization — alerts receiver that a frame is coming |
| **Destination MAC** | Receiver's hardware address |
| **Source MAC** | Sender's hardware address |
| **Type / Length** | Identifies the upper-layer protocol (e.g., `0x0800` = IPv4) |
| **Payload** | The IP packet from Layer 3 |
| **FCS / CRC** | Error detection value — receiver recalculates and compares |

#### Frame Types
- **Fixed size** — each frame is a fixed number of bytes (e.g., ATM cells = 53 bytes always)
- **Variable size** — delimiter flags mark start/end (e.g., Ethernet, HDLC)

---

### 5. Functions of the Data Link Layer

#### 5.1 Framing
Divides the raw bit stream into manageable units called frames by adding headers and trailers around the Layer 3 packet.

#### 5.2 Physical Addressing (MAC Addressing)
- **MAC address** = 48-bit (6-byte) hardware address burned into the NIC.
- Format: `AA:BB:CC:DD:EE:FF` (hexadecimal, colon-separated)
- **First 3 bytes** = OUI (Organizationally Unique Identifier — vendor/manufacturer)
- **Last 3 bytes** = Device-specific identifier
- MAC addresses are **only relevant on the local link** — replaced at every router hop.

#### 5.3 Flow Control
Prevents a fast sender from overwhelming a slow receiver.

| Method | How it Works |
|--------|-------------|
| **Stop-and-Wait** | Sender sends one frame, waits for ACK before sending the next |
| **Sliding Window** | Sender can send multiple frames before needing an ACK (more efficient) |

#### 5.4 Error Control
Detects (and sometimes corrects) damaged, lost, or duplicate frames.

| Mechanism | How it Works |
|-----------|-------------|
| **FCS / CRC** | Sender calculates checksum; receiver recalculates and compares — most common (used in Ethernet) |
| **Parity Bit** | Simple single-bit error detection |
| **ACK + Retransmit** | Receiver sends ACK; sender retransmits if no ACK received in time |
| **Sequence Numbers** | Detects duplicate or out-of-order frames |

#### 5.5 Media Access Control
When multiple devices share the same medium, access control prevents collisions.

| Method | Used In | How it Works |
|--------|---------|-------------|
| **CSMA/CD** | Wired Ethernet (half-duplex) | Listen before transmit; detect and recover from collisions |
| **CSMA/CA** | Wi-Fi (IEEE 802.11) | Avoid collisions using random backoff before transmitting |
| **Token Passing** | Token Ring | Only the device holding the token can transmit |
| **TDMA** | Cellular, WAN | Fixed time slots assigned to each device |

---

### 6. Layer 2 Protocols

| Protocol | Used For |
|----------|---------|
| **Ethernet (IEEE 802.3)** | Wired LAN — most common L2 protocol |
| **Wi-Fi (IEEE 802.11)** | Wireless LAN |
| **PPP** | Point-to-point WAN serial links |
| **HDLC** | Cisco default serial encapsulation |
| **Frame Relay** | Legacy WAN packet switching |
| **ATM** | Fixed 53-byte cell WAN |
| **ARP** | Resolves IP address → MAC address *(sits at L2/L3 boundary — uses L3 IP addresses but operates at L2)* |
| **STP (802.1D)** | Prevents switching loops |
| **VLAN (802.1Q)** | Logical segmentation of L2 networks |
| **PPPoE** | PPP over Ethernet (DSL) |
| **SDLC** | Synchronous Data Link Control (IBM legacy) |
| **SLIP** | Serial Line Internet Protocol (old, replaced by PPP) |

---

### 7. Layer 2 Devices

| Device | Role |
|--------|------|
| **Switch** | Forwards frames based on MAC address table; creates separate collision domains per port; most important L2 device |
| **Bridge** | Connects two LAN segments; filters traffic based on MAC address; 2-port predecessor to the switch |
| **NIC** | Contains MAC address; handles L2 framing and signaling (also touches L1) |
| **Wireless AP** | Bridges wireless (802.11) and wired (802.3) L2 networks |

---

## Layer 3 — Network Layer

### 1. Role & Overview

- **Layer 3** of the OSI model — responsible for **logical addressing, routing, and packet delivery** across different networks.
- Unlike Layer 2 (which only delivers between two directly connected devices), Layer 3 can route packets across **many different networks** to reach the final destination.
- Connects different networks that use different physical media by using logical IP addresses instead of hardware MAC addresses.
- Adds a **Layer 3 header (IP header)** to the data — the result is called a **packet**.
- The next upper-layer protocol (TCP, UDP, SCTP) is identified inside the IP header.

> **In short:** Layer 3 is the logical addressing layer — it decides where packets go across networks and how they get there.

---

### 2. End-to-End Delivery (Most Important Concept)

```
PC1 ──── R1 ──── R2 ──── R3 ──── PC2
(Network A)           (Network B)  (Network C)

Layer 2 (MAC): PC1→R1 | R1→R2 | R2→R3 | R3→PC2   (hop-by-hop, changes every hop)
Layer 3 (IP):  PC1 ──────────────────────────► PC2  (end-to-end, NEVER changes)
```

- **IP Source address** = always PC1's IP — never changes
- **IP Destination address** = always PC2's IP — never changes
- Layer 3 doesn't care about intermediate hops — it only cares about the **final destination**

#### At Every Router
```
  ✅ IP Header (L3) is READ to make routing decision
  ✅ L2 frame is STRIPPED and REBUILT with new MAC addresses
  ❌ IP Source / Destination NEVER changes
  ❌ Transport (L4) data is NOT touched
```

#### Direct vs Indirect Delivery

| Type | When Used | Example |
|------|-----------|---------|
| **Direct Delivery** | Source and destination on the same network — no router needed | `192.168.1.10 → 192.168.1.20` |
| **Indirect Delivery** | Source and destination on different networks — goes through one or more routers | `192.168.1.10 → 10.0.0.5` |

---

### 3. Functions of the Network Layer

#### 3.1 Logical Addressing
Physical (MAC) addresses only work within the same network. When a packet travels across multiple networks, a universal logical address (IP address) is needed.

- **IPv4** — 32-bit address (e.g., `192.168.1.10`) — written as 4 dotted decimals
- **IPv6** — 128-bit address (e.g., `2001:DB8::1`) — next-generation, far larger address space
- Structure: **Network ID + Host ID**
  - Example: `192.168.1.10/24` → Network = `192.168.1.0`, Host = `.10`
- Every packet carries **Source IP** and **Destination IP** in its header

#### 3.2 Packetization
The network layer encapsulates the segment from Layer 4 into a packet by adding the IP header.
```
Layer 4 Segment  +  IP Header  =  Layer 3 Packet
```

#### 3.3 Routing
Determines the best path for packets to travel across multiple networks.

| Method | Description | Example |
|--------|-------------|---------|
| **Static Routing** | Manually configured by admin | `ip route 10.0.0.0 255.255.255.0 192.168.1.1` |
| **Dynamic Routing** | Routers automatically exchange and update routes | RIP, OSPF, EIGRP |
| **Default Routing** | Single catch-all route for unknown destinations | `ip route 0.0.0.0 0.0.0.0 [next-hop]` |

> **Routing vs Forwarding:**
> - **Routing** = Path determination (control plane) — deciding which way to send
> - **Forwarding** = Packet movement (data plane) — actually sending it out the right interface

#### 3.4 Fragmentation & Reassembly
If a packet is larger than the **MTU (Maximum Transmission Unit)** of the next link, the router splits it into smaller fragments.

- Default Ethernet MTU = **1500 bytes**
- Each fragment carries the same IP header with **Identification**, **Fragment Offset**, and **More Fragments (MF)** flag
- **Reassembly happens only at the final destination** — never at intermediate routers

```
Original Packet (too large)
        ↓
Fragment 1 | Fragment 2 | Fragment 3
        ↓
Reassembled at Destination
```

#### 3.5 NAT (Network Address Translation)
Converts private IP addresses ↔ public IP addresses — used in home routers to allow internet access.

| Type | Description |
|------|-------------|
| **Static NAT** | One private IP ↔ one public IP (fixed mapping) |
| **Dynamic NAT** | Pool of public IPs assigned dynamically |
| **PAT** (Port Address Translation) | Many private IPs share one public IP using port numbers (most common — used in home routers) |

---

### 4. IPv4 Packet Header

```
 0               1               2               3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
┌───────┬───────┬───────────────┬───────────────────────────────┐
│Version│  IHL  │  ToS / DSCP   │          Total Length          │
├───────┴───────┴───────────────┼───────────────────────────────┤
│         Identification         │Flags│    Fragment Offset       │
├───────────────────────────────┼─────┴──────┬──────────────────┤
│      TTL (decrements per hop) │  Protocol  │  Header Checksum  │
│      drop at 0 → no loops     │ TCP=6 UDP=17│                  │
│                               │  ICMP=1    │                  │
├───────────────────────────────┴────────────┴──────────────────┤
│                        Source IP Address                        │
├─────────────────────────────────────────────────────────────────┤
│                      Destination IP Address                     │
├─────────────────────────────────────────────────────────────────┤
│                    Options (if IHL > 5)          │   Padding   │
├─────────────────────────────────────────────────────────────────┤
│                         Payload (TCP/UDP Segment)               │
└─────────────────────────────────────────────────────────────────┘
```

| Field | Purpose |
|-------|---------|
| **Version** | IPv4 (4) or IPv6 (6) |
| **IHL** | Header Length — length of the IP header itself |
| **ToS / DSCP** | Type of Service — Quality of Service markings |
| **Total Length** | Total size of packet (header + payload) |
| **Identification** | Used to reassemble fragments belonging to the same original packet |
| **Flags / Fragment Offset** | Controls and tracks fragmentation |
| **TTL** | Time To Live — decremented by 1 at each router; dropped when TTL = 0 (prevents infinite loops) |
| **Protocol** | Identifies upper layer: TCP = 6, UDP = 17, ICMP = 1 |
| **Header Checksum** | Error detection for the IP header only |
| **Source IP** | Sender's IP address |
| **Destination IP** | Receiver's IP address |

---

### 5. Layer 3 Protocols

| Protocol | Purpose |
|----------|---------|
| **IPv4** | 32-bit logical addressing and packet delivery |
| **IPv6** | 128-bit next-generation IP |
| **ICMP** | Error reporting and diagnostics (ping, traceroute, destination unreachable, time exceeded) |
| **ICMPv6** | ICMP for IPv6 + Neighbour Discovery Protocol (NDP) |
| **ARP** | Resolves IP → MAC address *(L2/L3 boundary — listed here because it resolves L3 addresses, but frames are L2)* |
| **RARP** | Resolves MAC → IP (obsolete, replaced by DHCP) |
| **NAT** | Translates private ↔ public IP addresses |
| **IPSec** | Encryption and authentication at the network layer |
| **MPLS** | Uses labels instead of IP addresses for faster forwarding — used by ISPs for traffic engineering |
| **RIP** | Distance-vector routing protocol |
| **OSPF** | Link-state routing protocol |
| **EIGRP** | Advanced distance-vector routing (Cisco proprietary) |
| **BGP** | Path-vector — inter-AS routing (internet backbone) |

---

### 6. Routing Protocols

| Protocol | Type | Metric | Max Hops | Best For |
|----------|------|--------|----------|---------|
| **RIP** | Distance-Vector | Hop count | 15 | Small, simple networks |
| **OSPF** | Link-State | Cost (bandwidth-based) | Unlimited | Large enterprise networks |
| **EIGRP** | Advanced Distance-Vector (Cisco) | Bandwidth + Delay + Load + Reliability | Unlimited | Cisco-only environments |
| **BGP** | Path-Vector | AS path attributes | Unlimited | Internet backbone, ISP ↔ ISP |

> **Interview Trap — RIP max hops:**
> RIP has a maximum hop count of **15**. A hop count of 16 = unreachable. This makes RIP unsuitable for large networks.

> **Interview Trap — OSPF algorithm:**
> OSPF uses **Dijkstra's Shortest Path First (SPF)** algorithm. It builds a complete map of the network (LSDB) and calculates the shortest path to every destination.

---

### 7. Routing vs Flooding

| Feature | Routing | Flooding |
|---------|---------|---------|
| **Path Selection** | Best path chosen via routing table | All paths used simultaneously |
| **Efficiency** | Efficient | Very inefficient |
| **Bandwidth Usage** | Low | High |
| **Loop Prevention** | Routing algorithms (metrics, timers) | TTL or sequence numbers |
| **Example** | Router forwarding packets | ARP broadcast |

---

### 8. Layer 3 Devices

| Device | Role |
|--------|------|
| **Router** | Primary L3 device — reads IP header, makes routing decisions, forwards packets between networks |
| **Layer 3 Switch** | Switch with routing capability — routes between VLANs using SVIs (Switched Virtual Interfaces) |
| **Multilayer Switch** | Can perform both switching (L2) and routing (L3) |
| **Firewall (L3)** | Filters packets based on IP addresses and protocols |

---

## Layer 4 — Transport Layer

### 1. Role & Overview

- **Layer 4** of the OSI model — responsible for **process-to-process (end-to-end)** delivery of the entire message.
- While Layer 3 delivers individual packets between hosts, Layer 4 ensures the **complete message arrives correctly at the right application process** on the destination host.
- Establishes, maintains, and terminates end-to-end connections.
- Responsible for end-to-end **error recovery**, **flow control**, and **QoS**.
- Adds a **Layer 4 header** to the packet — the result is called a **segment**.
- Allows multiple application processes to share the same physical connection simultaneously using **port numbers**.

> **In short:** Layer 3 delivers to the right host (IP). Layer 4 delivers to the right application on that host (Port).

---

### 2. Process-to-Process Delivery (Most Important Concept)

A **process** is an application program running on a host (e.g., Chrome browser, FTP client, web server).

```
Source Host                          Destination Host
┌──────────────┐                    ┌──────────────┐
│ Chrome :1050 │                    │ Apache :80   │
│ FTP    :1051 │                    │ FTP    :21   │
│ SSH    :1052 │                    │ SSH    :22   │
└──────┬───────┘                    └──────┬───────┘
       ├─── Layer 4 — Port numbers ─────────┤
       │    Process-to-Process delivery    │
       ├─── Layer 3 — IP addresses ────────┤
       │    Host-to-Host delivery          │
       ├─── Layer 2 — MAC addresses ───────┤
       │    Hop-to-Hop delivery            │
       └───────────────────────────────────┘
```

---

### 3. Functions of the Transport Layer

#### 3.1 Port Addressing
Ensures the right application receives data on a host running multiple processes simultaneously.

- **Port number** = 16-bit number (0–65535) identifying a specific process
- Combined with IP address → forms a **Socket**: `192.168.1.10:80`

| Port Range | Type | Examples |
|------------|------|---------|
| **0 – 1023** | Well-known ports | HTTP=80, HTTPS=443, FTP=21, SSH=22, DNS=53, SMTP=25 |
| **1024 – 49151** | Registered ports | MySQL=3306, RDP=3389 |
| **49152 – 65535** | Dynamic / Ephemeral | Assigned temporarily to client processes |

#### 3.2 Segmentation & Reassembly
Divides a large message into smaller segments, each tagged with a sequence number.

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

Sequence numbers allow the receiver to:
- Reassemble **out-of-order** segments in the correct order
- Detect **lost** segments (missing sequence number)
- Detect **duplicates** (same sequence number twice)

#### 3.3 Connection Control

| Type | Description | Protocol |
|------|-------------|---------|
| **Connection-Oriented** | Establishes a connection first, transfers data, then terminates; reliable | TCP |
| **Connectionless** | No connection setup; each segment treated independently; fast but unreliable | UDP |

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

#### 3.4 Flow Control (End-to-End)
Prevents the sender from overwhelming a slow receiver — operates end-to-end between source and destination processes, not hop-to-hop.

- **TCP Sliding Window** — receiver advertises how much buffer space is available (**Window Size**)
- Sender can only transmit up to the window size before needing an ACK
- Receiver slow → window shrinks → sender slows down
- Receiver fast → window grows → sender speeds up

```
Sender:   Window size = 3 → can send 3 unacknowledged segments
Receiver: ACK 3, Window = 2 → sender can now only send 2 more
```

#### 3.5 Error Control (End-to-End)
Ensures reliable process-to-process delivery using:

| Mechanism | How it Works |
|-----------|-------------|
| **Checksum** | Detects corrupted segments |
| **ACK** | Receiver confirms receipt of segments |
| **Retransmission** | If no ACK received within timeout (RTO), sender retransmits |
| **Sequence Numbers** | Detect lost, duplicate, or out-of-order segments |

> ⚠️ **Layer 4 error control is end-to-end** (source process → destination process), unlike Layer 2 error control which is hop-to-hop only.

---

### 4. TCP vs UDP vs SCTP

| Feature | TCP | UDP | SCTP |
|---------|-----|-----|------|
| **Full Name** | Transmission Control Protocol | User Datagram Protocol | Stream Control Transmission Protocol |
| **Connection** | Connection-oriented (3-way handshake) | Connectionless | Connection-oriented (4-way handshake) |
| **Reliability** | Reliable — ACK + retransmit | Unreliable — no ACK | Reliable — selective ACK |
| **Ordering** | Guaranteed order (sequence numbers) | No ordering | Ordered and unordered transfer |
| **Flow Control** | Yes — sliding window | No | Yes |
| **Congestion Control** | Yes | No | Yes |
| **Header Size** | 20–60 bytes | 8 bytes | 12 bytes + chunks |
| **Speed** | Slower (overhead) | Faster (no overhead) | Moderate |
| **Security** | SSL / TLS | DTLS | Built-in (protects from SYN flooding) |
| **Data Unit** | Segment (byte-oriented, combines messages) | Datagram (message-oriented) | Chunk (preserves message boundary) |
| **Multihoming** | No | No | Yes |
| **Use Cases** | HTTP, HTTPS, FTP, SSH, SMTP, Telnet | DNS, DHCP, VoIP, SNMP, TFTP, RIP | Telephony signaling (SS7 over IP) |
| **IP Protocol No.** | 6 | 17 | 132 |

---

### 5. Segment Headers

#### TCP Header
```
┌──────────────┬──────────────┐
│  Src Port    │  Dst Port    │  ← 16-bit each
├──────────────┴──────────────┤
│        Sequence Number       │  ← 32-bit — for ordering & reassembly
├─────────────────────────────┤
│      Acknowledgment Number   │  ← 32-bit — next expected byte
├──────┬──────────────────────┤
│ Flags│ SYN  ACK  FIN  RST   │  ← Control bits
├──────┴──────────────────────┤
│        Window Size           │  ← Flow control
├─────────────────────────────┤
│          Checksum            │  ← Error detection
└─────────────────────────────┘
```

#### UDP Header
```
┌──────────────┬──────────────┐
│  Src Port    │  Dst Port    │  ← 16-bit each
├──────────────┴──────────────┤
│    Length    │   Checksum   │  ← Minimal overhead — only 8 bytes total
└─────────────────────────────┘
```

> **Interview Trap — Why is UDP's header only 8 bytes?**
> UDP has no sequence numbers, no ACK, no window size, no connection state — nothing for reliability. It is a bare-minimum header for speed.

---

### 6. Layer 4 Protocols

| Protocol | Type | Use Cases |
|----------|------|-----------|
| **TCP** | Connection-oriented | HTTP, HTTPS, FTP, SSH, SMTP, Telnet |
| **UDP** | Connectionless | DNS, DHCP, SNMP, VoIP, TFTP, RIP |
| **SCTP** | Connection-oriented + multihoming | Telephony signaling (SS7 over IP) |
| **DCCP** | Connectionless + congestion control | Streaming media |

---

### 7. Layer 4 Devices

> Transport Layer is implemented in **software** — it operates on end hosts, not in networking hardware.

| Device / Component | Role |
|--------------------|------|
| **Host OS (TCP/IP stack)** | Every OS (Windows, Linux, macOS) implements TCP/UDP in the kernel |
| **Stateful Firewall** | Inspects TCP/UDP port numbers and connection state to allow/block traffic |
| **Load Balancer** | Distributes incoming connections across servers based on L4 port/protocol |
| **Proxy Server** | Terminates and re-establishes TCP connections on behalf of clients |

---

## Layer 5 — Session Layer

### 1. Role & Overview

- **Layer 5** of the OSI model — the network's **dialog controller**.
- Responsible for **establishing, managing, synchronizing, and terminating** communication sessions between two application processes on different machines.
- Sits above the Transport Layer and uses its services to create meaningful, organized conversations.
- Handles **session multiplexing** — allows multiple transport layer services to share the same connection.
- May coordinate identity checks during session setup, but actual **authentication and authorization** are typically handled by application-layer protocols (L7) — not the session layer itself.
- Operates almost entirely in **software** — primarily used by application developers, not network engineers.
- Logging is also performed at this layer.

> **In short:** Layer 5 manages the conversation — who speaks when, how long, and how to recover if the link drops mid-transfer.

---

### 2. What is a Session?

A **session** is a logical, persistent connection between two application processes for the duration of their communication.

```
Browser (Client) ←──────── Session ────────► Web Server
                    (established, maintained,
                     synchronized, terminated)
```

- Multiple sessions can exist **simultaneously** between the same two hosts (e.g., multiple browser tabs open to the same server).
- A login to a computer for file transfer is a classic example of a session layer job.

---

### 3. Session Lifecycle

Every session goes through three phases:

```
1. ESTABLISHMENT → Negotiate parameters, authenticate, select duplex mode
        ↓
2. DATA TRANSFER → Dialog exchange with synchronization checkpoints
        ↓
3. TERMINATION  → Graceful session close after all data exchanged
```

---

### 4. Functions of the Session Layer

#### 4.1 Dialog Control
Controls the direction and turn-taking of communication between two systems.

| Mode | Description | Example |
|------|-------------|---------|
| **Half-Duplex** | Only one side speaks at a time; other must wait | Walkie-talkie, HTTP/1.0 |
| **Full-Duplex** | Both sides communicate simultaneously | Video call, HTTP/2 |

- Session layer **negotiates** which mode to use during session establishment.
- In half-duplex, it manages **tokens** — only the device holding the token can send.

#### 4.2 Synchronization (Checkpoints)
The most unique and important function of the Session Layer.

**Problem without checkpoints:**
```
Transferring a 1 GB file → network fails at 900 MB
→ Must restart from 0 bytes — entire transfer wasted
```

**Solution — Checkpoints:**
The session layer inserts **synchronization points** into the data stream at regular intervals.

```
[Data   0–100 MB] ── CHECKPOINT 1 ──
[Data 100–200 MB] ── CHECKPOINT 2 ──
[Data 200–300 MB] ── CHECKPOINT 3 ──
...
[Data 800–850 MB] ── CHECKPOINT 9 (in progress) ──  ← network fails here

→ Resume from CHECKPOINT 8 (800 MB) — only resend last 50 MB
```

| Sync Point Type | Description |
|----------------|-------------|
| **Major Sync Point** | Explicit boundary; all data up to this point is committed and acknowledged; cannot go back beyond this |
| **Minor Sync Point** | More frequent, finer-grained checkpoints within major points; allows fine-grained recovery without full retransmission |

#### 4.3 Session Management

| Function | Description |
|----------|-------------|
| **Authentication** | May coordinate identity checks during session setup; in practice, authentication is handled by L7 application protocols (e.g. HTTP Basic Auth, OAuth, LDAP) |
| **Authorization** | Permissions are determined by the application layer — L5 may pass session tokens but does not enforce access control itself |
| **Session ID** | Unique identifier assigned to each session |
| **Re-synchronization** | Restores session to last known good checkpoint after a failure |
| **Multiplexing** | Multiple transport layer services share the same underlying connection |

---

### 5. Session Layer in Context

```
Application (e.g., File Transfer)
         ↓
Session Layer — inserts checkpoints every X MB
         ↓
Transport Layer (TCP) — handles segment delivery
         ↓
Network Layer (IP) — handles routing
         ↓
...

Link fails mid-transfer:
  → TCP connection re-established     (Layer 4)
  → Session resumes from last checkpoint (Layer 5) ✅
  → No need to restart the entire file transfer
```

---

### 6. Layer 5 Protocols

| Protocol | Purpose |
|----------|---------|
| **RPC** (Remote Procedure Call) | Allows a program to execute procedures on a remote server as if local |
| **NetBIOS** | Session establishment for Windows file/printer sharing |
| **SIP** (Session Initiation Protocol) | Establishes and manages VoIP and video call sessions *(spans L5/L7 — session setup is L5, application signaling is L7)* |
| **RTCP** | Real-Time Control Protocol — monitors RTP media sessions |
| **PPTP** | Point-to-Point Tunneling Protocol — VPN session management |
| **L2TP** | Layer 2 Tunneling Protocol — VPN tunneling |
| **PAP** | Password Authentication Protocol — session-level authentication |
| **H.245** | Multimedia session control (video conferencing) |

---

### 7. Layer 5 Devices

> Session Layer operates entirely in **software** — no dedicated hardware devices exist at this layer.

| Device / Component | Role |
|--------------------|------|
| **Application Servers** | Create and maintain user sessions for web apps and databases |
| **Proxy Servers** | Manage sessions between clients and backend servers |
| **Stateful Firewalls** | Track and control active sessions; block unauthorized session establishment |
| **Session Border Controllers (SBC)** | Secure and manage VoIP/video call sessions |
| **VPN Gateways** | Establish and maintain encrypted VPN sessions (PPTP, L2TP) |

---

## Layer 6 — Presentation Layer

### 1. Role & Overview

- **Layer 6** of the OSI model — called the **"Translator"** or **"Syntax Layer"**.
- Ensures that data sent by the application layer of one system is **readable by the application layer of another system**, regardless of internal data formats.
- Handles **translation, encryption/decryption, and compression/decompression** — purely software, no dedicated hardware.
- Different systems (IBM mainframe, PC, mobile) may use completely different data representations — Layer 6 converts everything into a common format for the network.

> **In short:** Layer 6 is the translator — it converts data formats, encrypts/decrypts for security, and compresses/decompresses to save bandwidth.

---

### 2. Functions of the Presentation Layer

#### 2.1 Translation (Data Conversion)
Different systems use different data formats — the Presentation Layer converts between them using a common intermediate format.

| From | To | Example |
|------|----|---------|
| EBCDIC | ASCII | IBM mainframe → PC communication |
| ASCII | Unicode | Older system → modern multilingual |
| Big-endian | Little-endian | Different CPU architectures |
| JPEG/PNG | Internal bitmap | Image display on screen |

- Uses **ASN.1** (Abstract Syntax Notation One) as the common language for describing data structures.
- Handles **serialization** — converting complex objects (JSON, XML) into flat byte strings for transmission.
- String representations: **Pascal style** (length prefix) vs **C style** (null-terminated `\0`).

#### 2.2 Encryption & Decryption
Provides confidentiality by encoding data before transmission and decoding it at the destination.

```
Sender:   Plaintext → [Encryption] → Ciphertext ──► network
Receiver:                          Ciphertext → [Decryption] → Plaintext
```

- **SSL/TLS** is commonly taught at this layer for encryption/decryption functions. In practice, TLS runs on top of TCP (L4) and serves application protocols like HTTPS (L7) — it does not map cleanly to a single OSI layer.
- In the TCP/IP model, TLS is considered part of the Application layer.
- Protects against eavesdropping, unauthorized access, and replay attacks.

#### 2.3 Compression & Decompression
Reduces the size of data before transmission to save bandwidth.

| Type | Algorithms | Use |
|------|-----------|-----|
| **Lossless** | ZIP, GZIP, LZW | Text files, documents — no data lost |
| **Lossy (image)** | JPEG | Photos — some data discarded |
| **Lossy (video)** | MPEG, H.264 | Video streaming |
| **Lossy (audio)** | MP3, AAC | Music, voice |

> **Interview Trap — Lossy vs Lossless:**
> Lossy is acceptable for media (human perception can't detect small losses). Lossless is required for text and files — even a single bit flip corrupts data.

---

### 3. Layer 6 Protocols

| Protocol | Purpose |
|----------|---------|
| **SSL / TLS** | Encryption for web (HTTPS), email, VPN *(commonly placed at L6; in practice spans L4–L6 — uses L4 TCP, performs L6 encryption, serves L7 applications. TCP/IP model places it in the Application layer)* |
| **JPEG** | Image compression standard |
| **MPEG** | Video/audio compression |
| **GIF / PNG** | Image formats |
| **ASCII / EBCDIC / Unicode** | Character encoding standards |
| **XDR** (External Data Representation) | Sun Microsystems data format standard |
| **MIME** | Email attachment encoding (Base64) |
| **ASN.1** | Abstract data structure description language |

---

### 4. Layer 6 Devices

> Presentation Layer is **purely software** — no dedicated hardware exists at this layer.

| Component | Role |
|-----------|------|
| **Web browsers** | Handle SSL/TLS decryption, HTML/JSON parsing |
| **Media players** | Decompress JPEG, MPEG, MP3 |
| **Email clients** | Decode MIME-encoded attachments |
| **Encryption libraries** | OpenSSL, Bouncy Castle |

---

## Layer 7 — Application Layer

### 1. Role & Overview

- **Topmost layer** of the OSI model — provides a **network interface directly to the user's application**.
- Does **not** refer to the applications themselves (Chrome, Outlook) — but to the **protocols and services** that allow those applications to use the network.
- The application itself does **not** belong to this layer — only the protocols that enable network communication do.
- Closest layer to the end user — everything begins here before data travels down through the lower layers.

> **In short:** Layer 7 is the entry point where application data enters the OSI stack — it provides services like web browsing, email, file transfer, name resolution, and remote access.

---

### 2. Functions of the Application Layer

#### 2.1 Network Virtual Terminal (NVT)
Allows a user on one host to connect to a remote computer as if it were a local terminal.

```
Local PC ──── SSH / Telnet ────► Remote Server
(terminal emulator)              (as if sitting at the server)
```

- Creates a software emulation of a terminal at the remote machine.
- **Telnet** — unencrypted (port 23); **SSH** — encrypted (port 22).

#### 2.2 File Transfer, Access & Management (FTAM)
Allows users to access, transfer, and manage files on remote systems.

| Protocol | Description | Port |
|----------|-------------|------|
| **FTP** | Upload/download files | 21 (control), 20 (data) |
| **TFTP** | Simplified FTP — UDP, no authentication | 69 |
| **SFTP / SCP** | Secure file transfer over SSH | 22 |
| **NFS** | Network File System — mount remote directories | 2049 |
| **SMB / CIFS** | Windows file and printer sharing | 445 |

#### 2.3 Mail Services
Provides electronic messaging between users across networks.

| Protocol | Role | Port |
|----------|------|------|
| **SMTP** | Sends email | 25 / 587 |
| **POP3** | Downloads email to client (deletes from server) | 110 |
| **IMAP4** | Reads email on server (keeps on server) | 143 |
| **MIME** | Handles attachments and non-ASCII content in emails | — |

#### 2.4 Directory Services
Provides a lookup system for network resources — translating names to addresses.

| Protocol | Purpose |
|----------|---------|
| **DNS** | Resolves domain names → IP (e.g., `google.com → 142.250.80.14`) |
| **LDAP** | Access directory services — user authentication, Active Directory |
| **NIS** | Unix/Linux directory service |

#### 2.5 Other Application Layer Services

| Service | Protocol | Port |
|---------|----------|------|
| Web browsing | HTTP | 80 |
| Secure web | HTTPS | 443 |
| Remote admin | SSH | 22 |
| Remote terminal | Telnet | 23 |
| Network management | SNMP | 161 / 162 |
| Time synchronization | NTP | 123 |
| IP address assignment | DHCP | 67 / 68 |

---

### 3. Layer 7 Devices

| Device / Component | Role |
|--------------------|------|
| **End-user computers** | Run application layer protocols — browsers, email clients |
| **Web servers** | Serve HTTP/HTTPS content |
| **DNS servers** | Resolve domain names to IP addresses |
| **Mail servers** | Handle SMTP/POP3/IMAP |
| **DHCP servers** | Assign IP addresses dynamically |
| **Application Firewall (L7)** | Deep packet inspection at the application layer |
| **Load Balancer (L7)** | Routes requests based on URL, cookies, HTTP headers |

---

## OSI Model — Complete Reference

### Overview

```
Application (L7)  \
Presentation (L6)  ├──→  Data   (Layers 5–7 work with raw data — no individual headers added)
Session (L5)      /
                        ↓  + L4 header
Transport (L4)    →  Segment      (src/dst port, seq no., ACK, window size)
                        ↓  + L3 header
Network (L3)      →  Packet       (src/dst IP, TTL, protocol)
                        ↓  + L2 header + L2 trailer
Data Link (L2)    →  Frame        (src/dst MAC, FCS/CRC)
                        ↓
Physical (L1)     →  Bits         (0s and 1s as voltages / light / radio waves)
```

> **Note:** Layers 5, 6, and 7 do not each add a distinct header the way L2/L3/L4 do. These upper layers operate together within the application process — only L4 (segment), L3 (packet), and L2 (frame) produce distinct encapsulation headers. This is why the TCP/IP model collapses L5/L6/L7 into a single **Application layer**.

> **OSI vs TCP/IP:** The OSI model is a **conceptual/teaching framework** — it is not a strict implementation. Modern internet stacks follow the simpler **TCP/IP model** (4 layers: Network Access, Internet, Transport, Application), which does not implement each OSI layer as a separate protocol. OSI is used for **troubleshooting, teaching, and vendor-neutral discussion** — not as a blueprint for how networks are actually built.
>
> | OSI Layer | TCP/IP Layer |
> |-----------|-------------|
> | L7 Application + L6 Presentation + L5 Session | Application |
> | L4 Transport | Transport |
> | L3 Network | Internet |
> | L2 Data Link + L1 Physical | Network Access |

---

## Data Encapsulation & Decapsulation

### 1. Data Encapsulation (Sending Data)

**Encapsulation** is the process of adding headers and trailers to data as it moves **down** from the Application layer to the Physical layer before transmission. Each layer wraps the data from the layer above with its own control information.

```
┌─────────────────────────────────────────────────────────┐
│                         DATA                            │  ← L7 / L6 / L5
├────────────┬────────────────────────────────────────────┤
│  L4 Header │              DATA                          │  ← SEGMENT
├───────┬────┴────────────────────────────────────────────┤
│L3 Hdr │  L4 Header  │         DATA                     │  ← PACKET
├───┬───┴─────────────────────────────────────────────────┤──┐
│L2 │  L3 Hdr │  L4 Header  │     DATA                   │L2│  ← FRAME
│Hdr│         │             │                             │Tr│
└───┴─────────────────────────────────────────────────────┴──┘
                              ↓
                    0 1 0 1 0 1 0 1 0 1 ...                    ← BITS (L1)
```

---

#### Step 1 — Application / Presentation / Session Layers (Data)

User generates data. Before passing down, it may be:
- **Compressed** (Presentation — L6)
- **Encrypted** (Presentation — L6)
- **Formatted / Serialized** (Presentation — L6)
- **Session managed** (Session — L5)

```
┌──────────────────────────────────┐
│              DATA                │
└──────────────────────────────────┘
```

| Examples |
|---------|
| HTTP request from a browser |
| Email message body |
| File transfer data |

> **Data unit at this stage: DATA**

---

#### Step 2 — Transport Layer (Segment)

The Transport Layer adds a **TCP or UDP header** to the data.

```
┌─────────────────────────────────────────┐
│            TCP / UDP Header             │
├─────────────────────────────────────────┤
│  Source Port                            │  → identifies the sending application
│  Destination Port                       │  → identifies the receiving application
│  Sequence Number        (TCP only)      │  → ensures correct data order
│  Acknowledgement Number (TCP only)      │  → confirms received bytes
│  Flags                  (TCP only)      │  → SYN, ACK, FIN, RST
│  Window Size            (TCP only)      │  → flow control
│  Checksum                               │  → error detection
├─────────────────────────────────────────┤
│                  DATA                   │
└─────────────────────────────────────────┘
```

**Example values:**
```
Source Port:      49152   (ephemeral — client side)
Destination Port: 80      (HTTP server)
Sequence Number:  1001
```

> **Data unit at this stage: SEGMENT**

---

#### Step 3 — Network Layer (Packet)

The Network Layer adds an **IP header** to the segment.

```
┌─────────────────────────────────────────┐
│               IP Header                 │
├─────────────────────────────────────────┤
│  Version                                │  → IPv4 or IPv6
│  Header Length (IHL)                    │
│  TTL (Time To Live)                     │  → prevents infinite loops
│  Protocol                               │  → TCP=6, UDP=17, ICMP=1
│  Header Checksum                        │
│  Source IP Address                      │  → sender device IP
│  Destination IP Address                 │  → receiver device IP
├─────────────────────────────────────────┤
│               TCP Segment               │
└─────────────────────────────────────────┘
```

**Example values:**
```
Source IP:      192.168.1.10
Destination IP: 8.8.8.8
TTL:            64
Protocol:       6 (TCP)
```

> **Data unit at this stage: PACKET**

---

#### Step 4 — Data Link Layer (Frame)

The Data Link Layer wraps the packet with a **MAC header** and appends a **CRC/FCS trailer** for error detection.

```
┌──────────────┬──────────────┬────────┬──────────────────┬─────────────┐
│ Dest MAC     │ Source MAC   │  Type  │   IP Packet      │  CRC / FCS  │
│              │              │        │   (Payload)      │  (Trailer)  │
└──────────────┴──────────────┴────────┴──────────────────┴─────────────┘
```

| Field | Purpose |
|-------|---------|
| **Destination MAC** | Next device on the local network |
| **Source MAC** | Sender's hardware address |
| **Type** | Identifies payload protocol (e.g., `0x0800` = IPv4) |
| **CRC / FCS** | 32-bit error detection value |

**Example values:**
```
Source MAC:      00:1A:2B:3C:4D:5E
Destination MAC: 98:76:54:32:10:AA
CRC:             32-bit value
```

> **Data unit at this stage: FRAME**

---

#### Step 5 — Physical Layer (Bits)

The frame is converted into **binary bits** and transmitted over the physical medium.

```
010101010101011010101010101010110101010 ...
```

Transmitted through:
- Ethernet cable (electrical signal)
- Fibre optic (light pulses)
- Wi-Fi (radio waves)

> **Data unit at this stage: BITS**

---

### 2. Data Decapsulation (Receiving Data)

**Decapsulation** is the reverse process — headers and trailers are **stripped off** as data moves **up** the OSI layers at the receiving device.

```
Bits (L1)
    ↓  reconstruct frame
Frame (L2)  →  check & strip MAC header + CRC trailer
    ↓
Packet (L3)  →  check & strip IP header
    ↓
Segment (L4)  →  check & strip TCP/UDP header, reorder, reassemble
    ↓
Data (L5/L6/L7)  →  session managed, decrypted, decompressed, delivered
```

---

#### Step 1 — Physical Layer
Receives raw binary bits from the network medium and reconstructs the bit stream into a frame for Layer 2.
```
010101010101010 ...  →  reconstructed frame
```

---

#### Step 2 — Data Link Layer
```
┌──────────────────────────────────────────────────────┐
│  Checks:  Destination MAC  (is this frame for me?)   │
│           CRC / FCS        (is the frame corrupted?) │
├──────────────────────────────────────────────────────┤
│  If CRC fails → frame is DISCARDED (no retransmit    │
│                 at L2 — upper layers handle recovery) │
│  If CRC passes → strip MAC header + CRC trailer      │
│  Remaining data → IP Packet passed up to L3          │
└──────────────────────────────────────────────────────┘
```

---

#### Step 3 — Network Layer
```
┌──────────────────────────────────────────────────────┐
│  Checks:  Destination IP  (is this packet for me?)   │
│           TTL             (has it expired?)           │
│           Protocol        (TCP=6 / UDP=17 / ICMP=1)  │
│           Header Checksum (header intact?)            │
├──────────────────────────────────────────────────────┤
│  Strips IP header                                     │
│  Remaining data → TCP Segment passed up to L4        │
└──────────────────────────────────────────────────────┘
```

---

#### Step 4 — Transport Layer
```
┌──────────────────────────────────────────────────────┐
│  Checks:  Destination Port (which app gets this?)    │
│           Sequence Number  (order correct?)           │
│           Checksum         (segment corrupted?)       │
├──────────────────────────────────────────────────────┤
│  Reorders out-of-sequence segments                   │
│  Detects and requests retransmission of missing data  │
│  Strips TCP/UDP header                               │
│  Remaining → Original DATA passed up to L5          │
└──────────────────────────────────────────────────────┘
```

---

#### Step 5 — Session Layer
- Manages the active session.
- Applies synchronization checkpoints.
- Handles session re-synchronization if needed.

#### Step 6 — Presentation Layer
- **Decrypts** the data (e.g., TLS decryption).
- **Decompresses** the data (e.g., GZIP, JPEG decode).
- **Converts format** to the application's expected representation.

#### Step 7 — Application Layer
Final data is delivered to the correct application process.

```
Examples:
  → Browser renders and displays the webpage (HTTP response)
  → Email client displays the received message (IMAP/POP3)
  → File manager saves the downloaded file (FTP)
```

---

### Encapsulation vs Decapsulation — Side by Side

| Layer | Encapsulation (Sending) | PDU | Decapsulation (Receiving) |
|-------|------------------------|-----|--------------------------|
| **L7 / L6 / L5** | Generate, format, compress, encrypt data | Data | Deliver to app, decrypt, decompress |
| **L4 — Transport** | Add TCP/UDP header (ports, seq, checksum) | Segment | Check ports/seq, strip header, reassemble |
| **L3 — Network** | Add IP header (src/dst IP, TTL, protocol) | Packet | Check IP, strip header |
| **L2 — Data Link** | Add MAC header + CRC/FCS trailer | Frame | Check MAC + CRC, strip both |
| **L1 — Physical** | Convert frame → bits → transmit | Bits | Receive bits → reconstruct frame |

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[01B - OSI Layers Quick Reference]]
- [[02 - TCP-IP Model]]
- [[03 - IP Subnetting VLSM IPv4 IPv6 and NDP]]
- [[04A - Network Routing Fundamentals]]
- [[10 - PPP and WAN Technologies]]
- [[11 - Layer 2 Switching and Ethernet Forwarding]]
- [[A1 - HTTP Evolution and TLS]]
