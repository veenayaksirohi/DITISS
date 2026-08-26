---
title: "08 - Spanning Tree Protocol"
aliases:
  - "Spanning Tree Protocol (STP)"
  - "STP Spanning Tree Protocol Notes"
tags:
  - computer-networks
  - stp
  - switching
  - layer-2
syllabus-topic:
  - 8
---

# Spanning Tree Protocol (STP)

## Table of Contents

- [[#0. Full Forms / Abbreviations]]
- [[#1. Why STP Is Needed — The Layer 2 Loop Problem]]
- [[#2. What Is STP, In Plain Terms?]]
- [[#3. How Switches Discover Loops — BPDUs]]
- [[#4. Root Bridge Election]]
- [[#5. STP Timers & BPDU Types]]
- [[#6. Port Roles]]
- [[#7. STP Protocol Types (Variants)]]
- [[#8. Port States]]
- [[#9. Quick Revision — Key Facts]]
- [[#Related Notes]]

---

## 0. Full Forms / Abbreviations

| Abbreviation | Full Form |
|---------------|-----------|
| **STP** | Spanning Tree Protocol |
| **RSTP** | Rapid Spanning Tree Protocol |
| **MSTP** | Multiple Spanning Tree Protocol |
| **PVST+** | Per-VLAN Spanning Tree Plus |
| **RPVST+** | Rapid Per-VLAN Spanning Tree Plus |
| **BPDU** | Bridge Protocol Data Unit |
| **TCN (BPDU)** | Topology Change Notification (BPDU) |
| **BID** | Bridge ID |
| **RP** | Root Port |
| **DP** | Designated Port |
| **TTL** | Time To Live |
| **ARP** | Address Resolution Protocol |
| **MAC** | Media Access Control (address) |
| **VLAN** | Virtual Local Area Network |
| **IEEE** | Institute of Electrical and Electronics Engineers |

---

## 1. Why STP Is Needed — The Layer 2 Loop Problem

Real-world networks deliberately use **redundant links** between switches for fault tolerance (a backup path if one link fails). The problem: **Ethernet frames have no TTL** (unlike IP packets) — nothing stops a frame from circulating forever if a loop exists. Without a loop-prevention mechanism, three problems happen **simultaneously**:

| # | Problem | What Happens |
|---|---------|----------------|
| ① | **Broadcast Storm** | A single ARP request loops endlessly → CPU on all switches hits 100% → network collapses completely |
| ② | **MAC Table Instability (Flapping)** | The same source MAC appears to arrive from multiple ports in rapid succession → switches keep re-learning it → forwarding becomes unreliable |
| ③ | **Duplicate Frame Delivery** | The same unicast frame arrives at the destination multiple times → breaks upper-layer protocols like TCP |

### 1.1 Without STP — Loop Present

```
                     PC-A
                      |
                     SW1
                    /    \
                 Link1    Link2
                  /          \
                SW2 ─────── SW3
                     Link3
```

```
Step 1: PC-A sends a broadcast → SW1 floods it out BOTH Link1 and Link2.
Step 2: SW2 (via Link1) floods it onward via Link3.
        SW3 (via Link2) floods it back via Link3.
Step 3: Both switches receive the SAME broadcast again → and flood it again → infinite loop.

┌──────────────────────────────────────────────────┐
│   RESULT: BROADCAST STORM — network CRASHES       │
└──────────────────────────────────────────────────┘
```

### 1.2 With STP — Loop Broken

```
                     PC-A
                      |
                    SW1  ← Root Bridge (lowest Bridge ID)
                    /    \
              Link1(DP)   Link2(DP)
                 /               \
              SW2(RP) ──── SW3(RP)
                       Link3
                SW2 = Designated ✅   SW3 = Blocked ❌
```

```
┌──────────────────────────────────────────────────┐
│  Loop BROKEN — one port blocked, backup path      │
│  ready to activate automatically if SW2 fails     │
└──────────────────────────────────────────────────┘
```

### 1.3 Problem → STP Solution

| Problem Without STP | How STP Solves It |
|----------------------|---------------------|
| Broadcast storms crash the network | Blocks redundant ports to eliminate loops |
| MAC table instability / flapping | Stable topology → stable, predictable MAC learning |
| Duplicate frame delivery | Enforces a single forwarding path per network segment |
| Ethernet has no Layer-2 TTL | STP itself acts as the loop-prevention mechanism |

---

## 2. What Is STP, In Plain Terms?

- STP (**IEEE 802.1D**) was created to **prevent Layer 2 loops** while still keeping redundant physical links available as backups.
- STP ensures there is only **one logical (active) path** between any two points on the network, by intentionally **blocking** redundant paths that could otherwise cause a loop.
- A **blocked port** stops **user data** from entering or leaving it — but it still sends/receives **BPDU frames** (the control messages STP itself uses to detect and manage loops).
- The physical cabling/redundant paths still **exist** — they're just administratively/logically disabled. If the active path fails, STP **recalculates** and automatically unblocks the standby port to restore connectivity.

```
 Key idea:
   Physical topology  = has loops (redundant links, by design)
   Logical topology   = loop-free (STP blocks the redundant ports)
```

---

## 3. How Switches Discover Loops — BPDUs

- Switches discover the presence of loops (and each other) by sending **probes** into the network.
- These probes are called **BPDUs** — **Bridge Protocol Data Units**.
- Each BPDU carries specific information identifying the sending switch (its Bridge ID, path cost, etc. — see §4.2).
- Every switch **multicasts** BPDU probes **every 2 seconds** (the Hello Time, §5.1).
- **Loop detection logic:** if a switch ever receives **its own BPDU back**, that confirms a loop exists in the network.

BPDUs serve **two purposes**:
1. **Loop detection** — as above.
2. **Root Bridge election** — BPDUs carry the Bridge ID used to elect the Root Bridge (§4).

Once the Root Bridge is elected, every other switch calculates the **best (lowest-cost) path** to reach it, and **blocks** any redundant/extra links (based on port cost — see §6). Those blocked links become **active automatically** only if the currently active link or port fails.

---

## 4. Root Bridge Election

### 4.1 Bridge ID (BID)

Every switch has a **Bridge ID**, which is what gets compared during root bridge election.

**Classic 802.1D BID structure:**

```
┌──────────────────┬──────────────────────────────┐
│  Priority (2 B)   │   System ID / MAC Address (6B)│
└──────────────────┴──────────────────────────────┘
```

**Extended System ID (used in PVST+ / Rapid-PVST+, which run one STP instance per VLAN):**

```
 Priority field = Bridge Priority + VLAN ID
 Example: 32768 + 10 = 32778
```

### 4.2 Election Rule

```
 Root Bridge Election Rule:
   1. LOWEST Bridge ID (BID) wins.
   2. If there's a tie on Priority → LOWEST MAC address wins.
```

**Example — three switches with equal priority (32768):**

```
 32768.1111.1111.1111   ← Lowest MAC → becomes ROOT BRIDGE
 32768.2222.2222.2222
 32768.3333.3333.3333
```

Since all three share the same default priority (32768), the tie-breaker is the MAC address — `1111.1111.1111` is numerically lowest, so that switch wins the election and becomes the **Root Bridge**.

**BPDU (Bridge ID) contents used in the election:**
- Bridge Priority
- MAC Address of the switch

---

## 5. STP Timers & BPDU Types

### 5.1 Key STP Timers

| Timer | Default Value | Purpose |
|-------|-----------------|---------|
| **Hello Time** | 2 s | How often the Root Bridge sends BPDUs |
| **Max Age** | 20 s | How long a switch waits before assuming the Root Bridge is gone (BPDU not heard) |
| **Forward Delay** | 15 s | Time spent in the Listening state + time spent in the Learning state (15s each) |

> 💡 **Total 802.1D Convergence Time:**
> ```
> Max Age + (2 × Forward Delay) = 20 + (2 × 15) = 50 seconds
> ```

### 5.2 BPDU Types

| Type | Purpose |
|------|---------|
| **Configuration BPDU** | Carries the Root BID, path cost, sender's BID, port ID, and timers. Sent every 2 seconds (Hello Time), originated by the Root Bridge and relayed downstream |
| **TCN BPDU** (Topology Change Notification) | Sent when a port changes state (e.g., link up/down); triggers the rest of the network to update its topology info faster |

---

## 6. Port Roles

Once the Root Bridge is elected, every other ("non-root") switch assigns roles to its own ports:

| Port Role | Meaning |
|-----------|---------|
| **Root Port (RP)** | The port used to reach the Root Bridge via the lowest-cost path — exactly **one** per non-root switch |
| **Designated Port (DP)** | The forwarding port for a given network segment/link — exactly **one** per link (both ends of a link can't both be DP) |
| **Blocking / Non-Designated Port** | Neither root nor designated — kept in **blocking state** to prevent a loop; does not forward user data |

```
                  32768.1111.1111.1111  ← Root Bridge
                       DP        DP
                      /             \
        32768.2222.2222.2222   32768.3333.3333.3333
              (RP)                    (RP)
```

- **DP (Designated Port):** forwards traffic for its segment — the Root Bridge's ports are always DP.
- **RP (Root Port):** each non-root switch picks the port with the best path back to the Root as its Root Port.
- Any additional redundant port that is neither RP nor DP goes into **Blocking** state to eliminate the loop, but stays ready to take over if needed.

### 6.1 Final Simplified View — 5-Switch Example

A larger topology follows the exact same logic — every non-root switch has one Root Port, every link has one Designated Port, and any leftover redundant port is blocked:

```
                       SW1
                    [ROOT]
                   DP     DP
                  /         \
                RP           RP
               SW2           SW3
              DP              DP
             /                 \
           RP                   RP
          SW4 -------- DP ---- SW5
           |                    |
           |                    |
           +------ blocked -----+
```

**Reading this diagram:**
- **SW1** = Root Bridge → both its ports are **DP** (Root Bridge ports are always Designated).
- **SW2** and **SW3** each use their uplink to SW1 as their **Root Port (RP)** — best path to the Root.
- **SW2 → SW4** and **SW3 → SW5** each work the same way: SW2/SW3 side = **DP**, SW4/SW5 side = **RP**.
- **SW4 ↔ SW5** is a direct link between two non-root switches — one side becomes **DP** (forwarding), but since this link creates a **loop** back to the root via two paths, the extra connection between SW4 and SW5 (the bottom link shown) is put into **Blocking** state.
- Result: exactly **one loop-free active path** from every switch back to the Root, with the blocked link kept in reserve as an automatic backup.

---

## 7. STP Protocol Types (Variants)

| Protocol | Vendor | Instances | Convergence Time | Key Trait |
|----------|--------|-----------|--------------------|-----------|
| **802.1D STP** | IEEE | 1 tree for ALL VLANs | 30–50 s | Original STP; 5 port states |
| **802.1w RSTP** | IEEE | 1 tree for ALL VLANs | 1–6 s | 3 states; adds Alternate/Backup port roles |
| **802.1s MSTP** | IEEE | Grouped VLANs → instances | 1–6 s | Load-balances traffic per instance |
| **PVST+** | Cisco | 1 tree per VLAN (802.1D-based) | Slow | Per-VLAN root bridge election |
| **RPVST+** | Cisco | 1 tree per VLAN (802.1w-based) | Fast | Fastest convergence; highest resource usage |

**Same 3-switch topology, how each protocol treats it:**

```
  SW1 (Root) ─── SW2 ─── SW3   (identical physical topology for all variants below)

  802.1D / 802.1w  →  ONE tree covers ALL VLANs
  802.1s (MSTP)    →  Instance 1: VLANs 10, 20   |   Instance 2: VLAN 30
  PVST+ / RPVST+   →  A SEPARATE tree per VLAN (VLAN 10, VLAN 20, VLAN 30, ...)
```

**Exam tip:** MSTP groups multiple VLANs into a smaller number of instances (efficient), while PVST+/RPVST+ run a completely separate spanning tree per VLAN (more resource-intensive but allows finer per-VLAN load balancing).

---

## 8. Port States

### 8.1 802.1D — 5 States

```
Blocking → Listening → Learning → Forwarding
                                       ↳ (or) Disabled
```

| State | What Happens |
|-------|----------------|
| **Blocking** | Receives BPDUs only; does not forward data or learn MAC addresses |
| **Listening** | Processes BPDUs to determine port role; still no data forwarding, no MAC learning |
| **Learning** | Starts learning MAC addresses into the table; still no data forwarding yet |
| **Forwarding** | Fully operational — forwards data and learns MAC addresses |
| **Disabled** | Administratively shut down; not participating in STP at all |

### 8.2 802.1w RSTP — 3 States

```
Discarding → Learning → Forwarding
```

RSTP consolidates 802.1D's **Blocking + Listening + Disabled** into a single **Discarding** state, making convergence dramatically faster (1–6 seconds vs 30–50 seconds).

| 802.1D State | Maps To (RSTP) |
|---------------|------------------|
| Blocking | Discarding |
| Listening | Discarding |
| Disabled | Discarding |
| Learning | Learning |
| Forwarding | Forwarding |

---

## 9. Quick Revision — Key Facts

```
STP Purpose        : Prevent Layer-2 loops while keeping redundant links as backup
Discovery mechanism: BPDU (Bridge Protocol Data Unit), multicast every 2s (Hello Time)
Loop detection      : A switch receiving its OWN BPDU back = loop exists
Root Bridge election: LOWEST Bridge ID wins → tie broken by LOWEST MAC address
BID structure       : Priority (2 bytes) + MAC Address (6 bytes)
Extended System ID  : Priority + VLAN ID (used in PVST+/RPVST+)

Port Roles  : Root Port (best path to Root) | Designated Port (forwards, 1 per link)
              | Blocking/Non-Designated Port (loop prevention)

Timers      : Hello = 2s | Max Age = 20s | Forward Delay = 15s
Convergence : Max Age + (2 × Forward Delay) = 50s  (802.1D)

802.1D states (5): Blocking → Listening → Learning → Forwarding → (Disabled)
802.1w states (3): Discarding → Learning → Forwarding

802.1D  = original, slow (30-50s), 1 tree for all VLANs
802.1w  = RSTP, fast (1-6s), 1 tree for all VLANs
802.1s  = MSTP, fast, VLANs grouped into instances
PVST+   = Cisco, 1 tree per VLAN, based on 802.1D (slow)
RPVST+  = Cisco, 1 tree per VLAN, based on 802.1w (fastest, most resource-heavy)
```

---
*STP Reference Notes*

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[11 - Layer 2 Switching and Ethernet Forwarding]]
- [[05 - VLANs and Inter-VLAN Routing]]
