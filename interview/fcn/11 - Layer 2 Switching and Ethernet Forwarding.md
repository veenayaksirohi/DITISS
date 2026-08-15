---
title: "Layer 2 Switching and Ethernet Forwarding"
aliases:
  - "Network Switching and Ethernet Forwarding"
  - "Switching Types, Ethernet Forwarding & Layer 2 Switching"
  - "Switching Types Ethernet Forwarding L2 Notes"
tags:
  - computer-networks
  - switching
  - ethernet
  - layer-2
---

# Switching Types, Ethernet Forwarding & Layer 2 Switching

This document covers three related but distinct layers of "switching":

- **Part A** — how data moves across an entire network (a WAN/network-layer concept)
- **Part B** — how one individual Ethernet switch decides *when* to start forwarding a frame
- **Part C** — how a Layer 2 switch actually learns addresses and forwards frames day-to-day (MAC table, flooding, collisions, duplex)

---

## 0. Full Forms / Abbreviations

| Abbreviation | Full Form |
|---------------|-----------|
| **VC / VCI** | Virtual Circuit / Virtual Circuit Identifier |
| **FCS** | Frame Check Sequence |
| **CRC** | Cyclic Redundancy Check |
| **CSMA/CD** | Carrier Sense Multiple Access with Collision Detection |
| **MAC** | Media Access Control (address) |
| **NIC** | Network Interface Card |

---

## PART A — Network Switching Types

These describe the fundamental ways data can travel through a network of intermediate nodes. This is general networking theory — separate from how an individual Ethernet switch behaves internally, which is covered in Part B.

## 1. Circuit Switching

A **dedicated physical path** is set up end-to-end **before** any data is sent. The whole session then uses that **same fixed path** — exactly like a traditional telephone call.

**Phases:**
```
1. Setup         — Call request and connection setup
2. Data Transfer  — Data flows continuously over the fixed path
3. Teardown       — Connection is released once transfer completes
```

```
  ┌────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌─────────────┐
  │ Source │════│ Switch A │════│ Switch B │════│ Switch C │════│ Destination │
  └────────┘    └──────────┘    └──────────┘    └──────────┘    └─────────────┘
                ══════════════════════════════════════════════════
                Dedicated path reserved for the ENTIRE call.
                No other traffic can use it — and it sits idle
                (wasting capacity) whenever no data is flowing.
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Low delay during transfer — the path is always ready and reserved | Wastes bandwidth whenever the path is idle but still reserved |

---

## 2. Message Switching

The **entire message** is treated as one unit. Each intermediate node **stores the whole message**, then forwards it onward once ready — a **"store-and-forward"** approach applied at the message level.

```
  ┌────────┐     ┌────────┐     ┌────────┐     ┌─────────────┐
  │ Source │─MSG→│ Node 1 │─MSG→│ Node 2 │─MSG→│ Destination │
  └────────┘     │ STORE  │     │ STORE  │     └─────────────┘
                 │   ↓    │     │   ↓    │
                 │FORWARD │     │FORWARD │
                 └────────┘     └────────┘
   The entire message must be stored at EACH node before it can be forwarded.
   This causes high delay — especially for large messages.
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Efficient for bursty traffic (no dedicated path needed) | High delay from storing full messages at every hop; rarely used today |

---

## 3. Packet Switching

The message is broken into smaller **packets** that travel independently or semi-independently through the network. There are two sub-types.

### 3.1 Datagram Switching (Connectionless)

Each packet is **routed independently** — there's no fixed path. Different packets from the same message may take **different routes**, and they're only reassembled at the receiver. Every packet must carry the **full source and destination address**, since each one is routed on its own.

```
                              ┌──────┐
                   ┌──P1────→ │ SW-A │──P1──────────────────────────→ ┐
                   │          └──────┘                                 │
  ┌────────┐       │          ┌──────┐                       ┌─────────────┐
  │ Source │───────┤──P2────→ │ SW-B │──P2─────────────────→│ Destination │
  └────────┘       │          └──────┘                       └─────────────┘
                   │          ┌──────┐  ┌──────┐                      ↑
                   └──P3────→ │ SW-A │─→│ SW-B │──P3─────────────────┘
                              └──────┘  └──────┘

  ● Each packet carries the FULL source & destination address.
  ● Packets can arrive OUT OF ORDER (e.g. P3 might arrive before P1).
  ● Reassembly happens only at the Destination.
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Efficient, and resilient to link failures (packets simply reroute around a broken link) | Delay is unpredictable; out-of-order arrival is possible |

### 3.2 Virtual Circuit Switching (Connection-Oriented)

A **logical path** (the virtual circuit) is set up **before** data transfer begins. Every packet then follows that **same pre-decided route**, identified by a short **Virtual Circuit Identifier (VCI)** instead of carrying a full address in every packet.

**Phases:**
```
1. VC Establishment — A setup packet reserves the logical path
2. Data Transfer     — All packets follow the established VC
3. VC Teardown        — The logical connection is released
```

```
  Phase 1 – VC Establishment (logical path reserved):
  ┌────────┐   ┌────────┐   ┌────────┐   ┌────────┐   ┌─────────────┐
  │ Source │═══│ Node 1 │═══│ Node 2 │═══│ Node 3 │═══│ Destination │
  └────────┘   └────────┘   └────────┘   └────────┘   └─────────────┘
               ══════════════════════════════════════════════
                     Virtual Circuit VC1 (pre-established)
                     ● Only a VCI label travels in each packet header
                     ● No per-packet routing decision needed

  Phase 2 – Data Transfer (all packets follow VC1, arrive in order):
  [VC1, P1] ──→ ──→ ──→ ──→ ──→  In-order delivery ✅
  [VC1, P2] ──→ ──→ ──→ ──→ ──→
  [VC1, P3] ──→ ──→ ──→ ──→ ──→

  Phase 3 – VC Teardown: connection released, resources freed
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Low per-packet delay; delivery is guaranteed in order | Less resilient to link failure (the whole VC breaks); has setup overhead |

### 3.3 Quick Comparison — All Switching Types

| Type | Path | Addressing | Connection-Oriented? | Arrival Order |
|------|------|--------------|-------------------------|-----------------|
| **Circuit Switching** | Fixed, dedicated | None needed (path is pre-set) | Yes (end-to-end) | In order |
| **Message Switching** | Per message | Full address in the message | No | In order |
| **Datagram (Packet)** | Different per packet | Full address in every packet | No | May be out of order |
| **Virtual Circuit** | Same logical path | VCI only | Yes | In order |

**One-liners:**
- **Circuit switching** = dedicated path, wasteful if idle, low delay once set up — think phone calls.
- **Message switching** = store-and-forward at the whole-message level, high delay, largely obsolete.
- **Datagram switching** = no fixed path, out-of-order possible, resilient — classic IP routing behavior.
- **Virtual Circuit switching** = fixed logical path + VCI, in-order, low per-packet overhead — think MPLS, Frame Relay, ATM.

---

## PART B — Ethernet Forwarding Methods

Part A described how data moves *across a network*. Part B zooms into a single Ethernet switch and asks: once a frame starts arriving on a port, **when does the switch begin forwarding it out the other side?**

## 4. Store-and-Forward Switching

The switch receives the **entire frame** into its buffer **before** making any forwarding decision. It checks the **FCS (CRC)** for errors and **drops invalid frames**.

```
  ┌──────┐  Full Frame  ┌──────────────────────────────────────┐  Frame  ┌──────┐
  │ Host │─────────────→│         Switch Buffer                 │────────→│ Host │
  │  A   │              │ [1] Receive the entire frame          │         │  B   │
  └──────┘              │ [2] Recalculate FCS / CRC             │         └──────┘
                        │ [3] CRC OK?   → Forward ✅            │
                        │     CRC Fail? → Drop    ❌            │
                        └──────────────────────────────────────┘
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Most reliable — bad frames never leave the switch | Highest latency of all methods (has to wait for the whole frame) |

---

## 5. Cut-Through Switching

Forwarding **starts before the whole frame has arrived**. There are two variants.

### 5.1 Fast-Forward Switching

Starts forwarding **the instant the destination MAC address is read** — just the **first 6 bytes** of the frame. It does **not** check the FCS at all.

```
  ┌──────┐  Bytes 1–6 (Dst MAC)  ┌─────────────────────────────────┐  Forwarding!  ┌──────┐
  │ Host │──────────────────────→│ Switch reads Dst MAC (6 bytes)  │──────────────→│ Host │
  │  A   │                       │ and immediately starts          │               │  B   │
  └──────┘  Bytes 7–n ──────────→│ forwarding (rest of frame       │               └──────┘
            still arriving...    │ is still arriving)              │
                                 │ ❌ No FCS check — errors can      │
                                 │    pass straight through          │
                                 └─────────────────────────────────┘
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Lowest latency of all switching methods | Can forward corrupted frames — no error checking at all |

### 5.2 Fragment-Free Switching

An improved cut-through variant: the switch buffers the **first 64 bytes** before forwarding. Ethernet collisions produce fragments **shorter than 64 bytes** (called "runts"), so this catches and filters those out. It still does **not** perform a full FCS check.

```
  ┌──────┐  Frame  ┌───────────────────────────────────────────┐  Frame  ┌──────┐
  │ Host │────────→│ Switch buffers the first 64 bytes         │────────→│ Host │
  │  A   │         │ Is it a runt (< 64 bytes)?   → Drop ❌   │         │  B   │
  └──────┘         │ Not a runt?                   → Forward ✅│         └──────┘
                   │ (still no full FCS check beyond byte 64) │
                   └───────────────────────────────────────────┘
```

| ✅ Pros | ❌ Cons |
|---------|---------|
| Filters out collision fragments (runts) | Doesn't catch bit errors that occur beyond byte 64 |

### 5.3 What Exactly Is a "Runt" (Collision Fragment)?

A **runt** is a very small, incomplete frame left over on the wire after a **collision**.

**Why it happens:** On a **shared, half-duplex** segment (Section 8), two devices can start transmitting at nearly the same instant. When their signals meet on the wire, they collide and corrupt each other. As soon as a device's CSMA/CD logic (Section 7) detects this, it **immediately stops transmitting** that frame. What's left behind on the wire is a **partial, truncated frame** — not a real, usable one.

```
 Standard minimum Ethernet frame size = 64 bytes

 Device A starts sending a frame ────────────►
                                     ⚡ COLLISION with Device B's frame ⚡
 Device A ABORTS transmission immediately (CSMA/CD)
                                     │
                                     ▼
              What's left on the wire = a FRAGMENT, well under 64 bytes
              = a "runt"
```

**What makes a runt a runt:**
- **Size** — under the Ethernet minimum of **64 bytes** (often as small as ~40–60 bytes, depending on exactly when the collision hit).
- **Cause** — an aborted transmission from a collision, not a deliberately sent complete frame.
- **Validity** — meaningless, corrupted data; it's only part of a frame, so there's nothing usable in it.
- **Risk if forwarded** — a switch that doesn't check for runts wastes downstream bandwidth passing along garbage data.

**Why this is exactly why Fragment-Free checks 64 bytes:** a genuine collision fragment can only ever be shorter than 64 bytes — that's simply how fast CSMA/CD detects and aborts a transmission. So buffering the first 64 bytes before forwarding guarantees that anything shorter is, by definition, a runt — never a legitimate frame — and it's safe to drop.

- **Fast-Forward** (Section 5.1) skips this check entirely — since it starts forwarding after only 6 bytes, it can end up pushing runts onto the rest of the network.
- **Store-and-Forward** (Section 4) filters runts too, just as a side effect of waiting for and validating the complete frame anyway.

**One-liners:**
- Runt = collision fragment = a frame **shorter than the 64-byte Ethernet minimum**, caused by two devices transmitting at once and one aborting mid-frame.
- Runts only happen on **half-duplex/shared media** — they can't occur on collision-free full-duplex links.
- Fragment-Free switching buffers exactly 64 bytes because that's the guaranteed minimum size of any *legitimate* frame — which makes the runt check reliable at that exact cutoff.

### 5.4 Quick Comparison — Ethernet Forwarding Methods

| Method | Buffers | Error Check | Latency | Best For |
|--------|-----------|----------------|-----------|-----------|
| **Store-and-Forward** | Entire frame | Full FCS/CRC | Highest | Reliability |
| **Fast-Forward** | First 6 bytes (Dst MAC) | None | Lowest | Raw speed |
| **Fragment-Free** | First 64 bytes | Runt/collision check only | Medium–Low | Balance of speed and basic error filtering |

**One-liners:**
- **Store-and-Forward** = safest, slowest — waits for the whole frame and runs a full CRC check.
- **Fast-Forward** = fastest, riskiest — forwards right after reading the destination MAC.
- **Fragment-Free** = middle ground — waits for 64 bytes to filter out runts, but skips the full CRC check.
- Most modern switches default to **Store-and-Forward**; cut-through variants show up mainly in very latency-sensitive environments (e.g. some data-center or high-frequency-trading switching).

---

## PART C — Layer 2 Switching Fundamentals

Part B explained *when* a switch starts forwarding a frame. Part C covers the bigger picture of day-to-day switch operation: how it learns where devices are, what it does when it doesn't know, and how the underlying link (half- vs full-duplex) affects all of it.

## 6. The MAC Address Table, Flooding & Forwarding

A Layer 2 switch builds and uses a **MAC address table** (also called a **CAM table** — Content Addressable Memory table) to decide where to send each frame.

### 6.1 How the Switch Learns (Building the MAC Table)

```
Step 1: A frame arrives on a port.
Step 2: The switch reads the frame's SOURCE MAC address.
Step 3: It records {Source MAC ↔ Incoming Port} in its MAC address table.
Step 4: That entry is then used for FUTURE frames destined to that MAC.
```

```
   Host A (MAC-A) ──frame──→ Switch Port Fa0/1
                              │
                              ▼
                     MAC table learns:
                     MAC-A  ↔  Fa0/1
```

### 6.2 The Forwarding Decision

```
 When a frame arrives, the switch checks its MAC table for the DESTINATION MAC:

   Is the destination MAC already in the table?
     ├── YES → Forward out that ONE specific port (efficient, unicast)
     └── NO  → Flood out ALL ports except the one the frame arrived on
```

### 6.3 Flooding

**Flooding** happens when the switch doesn't yet know which port leads to the destination MAC — so it sends a copy of the frame out **every port** except the one it came in on. The hope is that the real destination is out there somewhere and will eventually reply, letting the switch learn its actual port.

```
   Frame with an UNKNOWN destination MAC:

   Host A ──frame──→ Switch ──┬──→ Port 2 (flooded)
                               ├──→ Port 3 (flooded)
                               └──→ Port 4 (flooded)
                     (NOT sent back out Port 1 — the port it arrived on)
```

**Flooding also happens for:**
- **Broadcast frames** (destination `FFFF.FFFF.FFFF`) — always flooded to every port.
- **Multicast frames** — flooded unless multicast-aware filtering (e.g. IGMP snooping) is configured.
- **Unknown unicast** — as above, until the switch learns that MAC's real port.

### 6.4 A Full Example: Learn → Flood → Forward

```
 T1: Host A sends a frame to Host B (switch doesn't know Host B's port yet)
   → Switch learns Host A's MAC ↔ Port 1
   → Switch FLOODS the frame out every other port (Host B's real port is one of them)

 T2: Host B replies to Host A
   → Switch learns Host B's MAC ↔ Port 3
   → Switch already knows Host A is on Port 1 → FORWARDS directly, no flooding needed

 T3 onward: Switch now knows BOTH MACs
   → All further traffic between A and B is forwarded directly, port to port
```

**One-liners:**
- The MAC table maps **MAC address ↔ switch port**, learned from the **source MAC** of incoming frames.
- **Known destination MAC** → forward out that one port only.
- **Unknown destination MAC, broadcast, or unhandled multicast** → flood out every port except the source port.
- Flooding is a **fallback**, not the switch's normal behavior — it stops as soon as the destination's real port is learned.

---

## 7. CSMA/CD — Carrier Sense Multiple Access with Collision Detection

**CSMA/CD** is the access method traditionally used by Ethernet on **shared, half-duplex media** (old hub-based networks or coax Ethernet) to decide when a device may transmit, and to recover when two devices transmit at once (a **collision**).

### 7.1 How CSMA/CD Works, Step by Step

```
1. Carrier Sense  : Before transmitting, the device LISTENS to the wire.
                     Idle? → proceed. Busy? → wait.

2. Multiple Access : Many devices share the SAME medium and can all attempt
                     to transmit — there's no central controller granting turns.

3. Collision Detect: If two devices transmit at the SAME time, their signals
                     collide and corrupt on the wire. Both devices detect this.

4. Jam Signal       : The colliding devices send a jam signal so that
                     EVERY device on the segment knows a collision occurred.

5. Backoff & Retry  : Each device waits a RANDOM amount of time, then
                     retries — reducing the odds of an immediate repeat collision.
```

```
  Device A ──┐
             │  both sense an idle wire, both transmit at the same time
  Device B ──┘
             ▼
        ⚡ COLLISION on the shared wire ⚡
             │
             ▼
     Jam signal sent → every device is notified
             │
             ▼
     A and B each start a random backoff timer
             │
             ▼
     Each retries after its own random delay
```

### 7.2 When Is CSMA/CD Actually Used?

- It matters on **half-duplex** links, where collisions are physically possible (Section 8).
- It's **not needed on full-duplex** links (standard on modern switched Ethernet) — since sending and receiving use separate paths, **collisions can't happen**, so CSMA/CD is effectively irrelevant there.

**One-liners:**
- CSMA/CD = Carrier Sense (listen first) + Multiple Access (shared medium) + Collision Detection (detect and recover from simultaneous transmissions).
- Collision-handling sequence: **sense → transmit → detect collision → jam signal → random backoff → retry**.
- Mostly a **legacy** concept today — largely irrelevant on modern full-duplex switched networks, but still an important exam topic.

---

## 8. Half-Duplex vs Full-Duplex

| Feature | Half-Duplex | Full-Duplex |
|---------|--------------|----------------|
| **Data flow** | One direction at a time (send *or* receive) | Both directions at once (send *and* receive) |
| **Collisions possible?** | ✅ Yes | ❌ No |
| **CSMA/CD needed?** | ✅ Yes | ❌ No |
| **Typical use today** | Legacy hubs, some wireless links | Standard for modern switched Ethernet (switch-to-host, switch-to-switch) |
| **Throughput** | Lower — shared channel, contention overhead | Higher — dedicated send/receive paths, no contention |

```
 Half-Duplex:                       Full-Duplex:

  A ──send──→                        A ──send──→
  A ←─recv───  (not at the same      A ←─recv───   (send & recv happen
                time)                               SIMULTANEOUSLY, on
                                                     separate wire pairs)
```

**Why modern networks run full-duplex:**
- A switch (unlike an old hub) gives each device its **own dedicated collision domain** per port.
- With a direct switch-to-host link and no shared medium, a collision **can't physically happen** — so both ends can safely send and receive at the same time.

**One-liners:**
- **Half-duplex** = one direction at a time, collisions possible, needs CSMA/CD.
- **Full-duplex** = both directions at once, no collisions, CSMA/CD not needed.
- Modern switched links (switch ↔ host, switch ↔ switch) run **full-duplex** by default.
- A **duplex mismatch** (one side set to half, the other to full) is a classic real-world cause of poor performance and errors on a link.

---

## 9. Quick Revision Sheet

```
SWITCHING TYPES (network-wide, Part A)
  Circuit Switching  : dedicated path, reserved end-to-end, wastes idle bandwidth
  Message Switching  : store-and-forward whole message, high delay, obsolete
  Datagram Switching : connectionless, no fixed path, packets may arrive out of order
  Virtual Circuit     : connection-oriented, fixed logical path, VCI-based, in order

ETHERNET FORWARDING METHODS (switch-internal, Part B)
  Store-and-Forward : buffers WHOLE frame, full CRC check, safest, slowest
  Fast-Forward       : buffers only 6 bytes (Dst MAC), no check, fastest, riskiest
  Fragment-Free       : buffers 64 bytes, filters runts only, balanced

MAC TABLE / FLOODING / FORWARDING (Part C)
  MAC table learns   : source MAC ↔ incoming port
  Known destination  : forward out that one port
  Unknown/broadcast   : flood out all ports except the source port

CSMA/CD (Part C)
  Steps  : Carrier Sense → transmit → Collision Detect → Jam Signal → Random Backoff → Retry
  Needed only on: Half-Duplex links (shared medium, collisions possible)

DUPLEX (Part C)
  Half-Duplex : one direction at a time, collisions possible, needs CSMA/CD
  Full-Duplex : both directions at once, no collisions, CSMA/CD not needed
  Modern switched Ethernet = Full-Duplex by default
```

---
*Switching Types, Ethernet Forwarding & Layer 2 Switching — Reference Notes*

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[01 - OSI Model]]
- [[08 - Spanning Tree Protocol]]
- [[05 - VLANs and Inter-VLAN Routing]]
- [[09 - Infrastructure Security ACL AAA and Port Security]]
