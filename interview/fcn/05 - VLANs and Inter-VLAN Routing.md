---
title: "05 - VLANs and Inter-VLAN Routing"
aliases:
  - "📡 VLAN — Complete Notes"
  - "VLAN Complete Notes"
tags:
  - computer-networks
  - vlans
  - inter-vlan-routing
  - switching
syllabus-topic:
  - 5
---

# 📡 VLAN — Complete Notes

---

## Table of Contents

- [[#1. VLAN Concept]]
- [[#1.1 VLAN ID (VLAN Number) and VLAN Range]]
- [[#2. Benefits / Advantages of VLAN]]
- [[#3. VLAN Port Assignment / Connection Types]]
- [[#4. VLAN Tagging — IEEE 802.1Q]]
- [[#5. Inter-VLAN Routing]]
- [[#6. VTP (VLAN Trunk Protocol)]]
- [[#⭐ Quick Revision — VLAN Module]]
- [[#🎯 Most Likely Exam/Viva Questions]]
- [[#Related Notes]]

---

## 1. VLAN Concept

* **VLAN (Virtual Local Area Network)** = a **logical grouping** of networking devices, regardless of their physical location.
* Creating a VLAN **breaks one large broadcast domain into multiple smaller broadcast domains**.
* Think of a VLAN like a **subnet**: just as two different subnets cannot communicate without a router, **two different VLANs also require a router (or Layer 3 device) to communicate**.
* Devices in the same VLAN can communicate directly (Layer 2); devices in different VLANs need Layer 3 routing.

📌 **Exam Trap:** VLAN = Broadcast Domain = Subnet (conceptually mapped 1:1 in most designs).

🔑 **Key Point — Trunk Link:** A **trunk link carries traffic for multiple VLANs over a single physical connection** (one cable, many VLANs — each frame tagged with its VLAN ID so the far end can sort it back out). An **access link**, by contrast, carries traffic for **only one VLAN**.

---

## 1.1 VLAN ID (VLAN Number) and VLAN Range

Every VLAN is identified by a unique **VLAN ID** (a number) so switches can distinguish one VLAN's traffic from another's, especially over a trunk link.

### 🔹 VLAN ID Field

* Carried inside the **802.1Q tag** in the Ethernet frame (12-bit field).
* 12 bits → theoretical range = **0 – 4095** → but 0 and 4095 are reserved, so usable range = **1 – 4094**.

### 🔹 VLAN ID Ranges (Cisco Switches)

| Range           | Type                | Notes                                                              |
| ------------------ | ---------------------- | ----------------------------------------------------------------------- |
| **0**               | Reserved               | Not used (priority tagging only, no VLAN)                                |
| **1**               | Default VLAN            | Exists automatically on every switch; cannot be deleted or renamed; carries CDP, VTP, PAgP, STP traffic by default |
| **2 – 1001**        | **Normal Range**        | User-configurable VLANs; stored in `vlan.dat`; advertised via VTP        |
| **1002 – 1005**     | Reserved (legacy)        | Auto-created for legacy Token Ring / FDDI; cannot be deleted             |
| **1006 – 4094**     | **Extended Range**       | User-configurable; **NOT** advertised by VTP (in VTP versions 1 & 2); stored in running-config, not `vlan.dat` |
| **4095**            | Reserved                 | Used internally, not assignable                                          |

✅ **Memory Trick:** 
**1 = Default | 2–1001 = Normal | 1002–1005 = Legacy Reserved | 1006–4094 = Extended | 4095 = Reserved**

### 🔹 Normal Range vs Extended Range VLANs

| Parameter              | Normal Range VLAN        | Extended Range VLAN            |
| -------------------------- | ---------------------------- | ------------------------------------ |
| VLAN ID                    | 1 – 1001                      | 1006 – 4094                            |
| Stored In                  | `vlan.dat` (flash memory)      | `running-config` only                  |
| VTP Advertisement           | Yes (VTPv1/v2)                 | No (VTPv1/v2) — VTPv3 does support it   |
| Typical Use                 | Most enterprise deployments     | Service provider / very large networks   |

📌 **Exam Trap:** VLAN 1 is the **default VLAN** and also commonly the **native VLAN** — both can be changed except VLAN 1 itself can never be deleted.

---

## 2. Benefits / Advantages of VLAN

| Benefit                          | Explanation                                                       |
| ------------------------------------ | ---------------------------------------------------------------------- |
| **Solves broadcast problem**         | Limits broadcast traffic to within the VLAN only                        |
| **Reduces broadcast domain size**    | Smaller domains = less congestion, better performance                    |
| **Additional layer of security**     | Sensitive systems can be isolated into their own VLAN                    |
| **Easier device management**         | Devices grouped logically, easier to administer centrally                |
| **Logical grouping by function**     | Group by department/role instead of physical location (e.g., all HR PCs in one VLAN regardless of floor) |

✅ **Memory Trick:** **S-R-A-M-L** → Solve broadcast, Reduce domain, Add security, Manage easily, Logical grouping

---

## 3. VLAN Port Assignment / Connection Types

When configuring VLANs on a switch port, we must define the **connection type**. Switches support **two types** of VLAN connections:

1. **Access Link**
2. **Trunk Link**

### 🔹 Access Link

* Connects a switch port to an end device with a **standard Ethernet NIC**.
* Standard NICs only understand **IEEE 802.3 / Ethernet II** frames (no VLAN tag).
* An access port can be assigned to **only ONE VLAN** at a time.
* All devices connected via that access port belong to the **same broadcast domain (VLAN)**.

**Example:**
> 20 users connected to a hub → hub connected to a switch access port → all 20 users are in the **same VLAN**. To put 10 users in a different VLAN, you'd need a **separate hub** connected to a **different access port**.

### 🔹 Trunk Link

* Connects a switch port to a device **capable of understanding multiple VLANs** (usually **switch-to-switch** or **switch-to-router**).
* Allows VLAN information to be carried **across the network** — this is how a VLAN can "span" multiple switches.
* Requires the original Ethernet frame to be **modified** to carry VLAN membership information (**tagging**).

### 🔹 Access vs Trunk — Comparison Table

| Parameter              | Access Link                     | Trunk Link                            |
| -------------------------- | ------------------------------------ | ------------------------------------------ |
| Connects to                | End devices (PC, printer, standard NIC) | Switches, routers                         |
| VLANs Supported per Port    | Only 1 VLAN                           | Multiple VLANs                              |
| Frame Type                 | Standard Ethernet (untagged)          | Tagged (ISL / 802.1Q)                       |
| Purpose                    | Connect end-user devices               | Carry VLAN traffic between network devices  |
| Requires Tagging Protocol   | No                                     | Yes (Dot1q or ISL)                          |

---

## 4. VLAN Tagging — IEEE 802.1Q

### 🔹 What is Tagging?

* In trunking, a **separate logical connection** is created for each VLAN (instead of one physical connection per VLAN).
* The switch **adds the source port's VLAN identifier** to the Ethernet frame — this is called **tagging**.
* This tag tells the receiving switch **which VLAN the frame originated from**, allowing intelligent forwarding decisions based on **both** the destination MAC address **and** the source VLAN ID.
* Tagging is performed in **hardware** by **ASICs (Application-Specific Integrated Circuits)** for speed.

📌 Since the frame is modified, a **standard NIC will NOT understand tagged frames** and will typically **drop them**. Both ends of a trunk link **must support and be configured with the same trunking protocol**.

### 🔹 Trunking Protocols (2 types)

| Protocol   | Full Form                     | Vendor                   |
| ------------ | ---------------------------------- | ---------------------------- |
| **ISL**      | Inter-Switch Link                    | Cisco-**proprietary**        |
| **Dot1q**    | IEEE 802.1Q                          | **Open industry standard**    |

### 🔹 IEEE 802.1Q Details

* Industry-standard trunking protocol (works across vendors, unlike ISL).
* Inserts a **4-byte tag** into the Ethernet frame header, containing:
  * **TPID (Tag Protocol Identifier)** — identifies the frame as 802.1Q tagged
  * **VLAN ID (12 bits)** — supports VLAN IDs from **1 to 4094**
  * **Priority bits (3 bits)** — for QoS (CoS — Class of Service)
* **Native VLAN concept:** 802.1Q does **NOT tag** frames belonging to the **native VLAN** (default VLAN 1 unless changed) — these are sent **untagged** across the trunk.

✅ **Exam Trap:**
* ISL = Cisco proprietary, **tags all frames including native VLAN**, now largely obsolete.
* 802.1Q = Industry standard, **does NOT tag native VLAN traffic**, widely used today.

---

## 5. Inter-VLAN Routing

Since different VLANs are like different subnets, communication **between VLANs requires Layer 3 routing**. There are **three options**:

1. **Router with one physical interface per VLAN** (traditional method — typically NOT used; wastes physical ports)
2. **Router-on-a-Stick** (single router interface, VLAN trunk to switch)
3. **Layer 3 Switch** (Switched Virtual Interfaces — SVIs, most common in modern networks)

### 🔹 Option 1: One Router Interface per VLAN

* Requires a **dedicated physical router interface for each VLAN**.
* **Disadvantage:** Not scalable — limited by number of physical router ports; wasteful and expensive.

### 🔹 Option 2: Router-on-a-Stick

* A configuration that allows routing of traffic **between VLANs using a single physical router interface**.
* The router has **one physical interface**, but that interface is divided into multiple **logical sub-interfaces** — one per VLAN.
* Router connects to the switch via a **VLAN trunk** (802.1Q).
* Each subnet's hosts use the router's sub-interface IP (in that VLAN) as their **default gateway**.

**Configuration Steps (Cisco):**

```
! Step 1: Create a sub-interface for each VLAN
interface <type><number>.<subinterface-number>

! Step 2: Enable 802.1Q trunking and associate the sub-interface with a VLAN
encapsulation dot1q <vlan_id>

! Step 3: Assign IP address to the sub-interface
ip address <address> <mask>
```

**Example:**
```
interface fastethernet0/0.10
 encapsulation dot1q 10
 ip address 192.168.10.1 255.255.255.0

interface fastethernet0/0.20
 encapsulation dot1q 20
 ip address 192.168.20.1 255.255.255.0
```

✅ **Exam Trap:** Router-on-a-stick needs only **ONE physical interface** but **multiple logical sub-interfaces**, each tied to a VLAN via `encapsulation dot1q`.

### 🔹 Option 3: Layer 3 Switch (Preferred in Modern Networks)

* A switch capable of performing **both Layer 2 switching AND Layer 3 routing**.
* Uses **SVI (Switched Virtual Interface)** — a virtual interface representing a VLAN, assigned an IP address, acting as the default gateway for that VLAN.
* **Faster** than router-on-a-stick (hardware-based switching/routing, no trunk bottleneck).
* Most commonly used method in **enterprise networks today**.

**Basic Configuration Concept:**
```
interface vlan 10
 ip address 192.168.10.1 255.255.255.0
 no shutdown
```

### 🔹 Comparison of Inter-VLAN Routing Methods

| Method                       | Physical Interfaces Needed | Speed         | Scalability  | Common Usage           |
| -------------------------------- | ------------------------------ | ---------------- | --------------- | --------------------------- |
| One interface per VLAN            | Many (1 per VLAN)                | Fast (dedicated)   | Poor              | Rare / legacy                 |
| Router-on-a-Stick                 | 1 (with sub-interfaces)          | Slower (bottleneck at trunk) | Medium | Small/medium networks, labs   |
| Layer 3 Switch (SVI)              | 0 (virtual interfaces)            | Fastest (hardware-based) | Excellent | Modern enterprise networks    |

---

## 6. VTP (VLAN Trunk Protocol)

### 🔹 What is VTP?

* **VTP (VLAN Trunk Protocol)** reduces administrative overhead in a switched network.
* When a new VLAN is configured on **one VTP server**, that VLAN information is **automatically distributed to all switches** in the same VTP domain.
* Eliminates the need to **manually configure the same VLAN on every switch**.
* **VTP is Cisco-proprietary**, available mainly on Cisco Catalyst series switches.

### 🔹 VTP Features

* Advertises VLAN configuration information across the network
* Maintains **VLAN configuration consistency** throughout a common administrative domain
* Sends advertisements **only on trunk ports**

### 🔹 VTP Modes (3 Modes — Very Important)

| Mode              | Can Create/Modify/Delete VLANs? | Forwards VTP Advertisements? | Saves VLAN Info in NVRAM? |
| -------------------- | ---------------------------------- | -------------------------------- | -------------------------------- |
| **Server**            | ✅ Yes                               | ✅ Yes                             | ✅ Yes                             |
| **Client**            | ❌ No                                | ✅ Yes                             | ❌ No (learns from Server)         |
| **Transparent**       | ✅ Yes (local only, not advertised)  | ✅ Yes (forwards, doesn't process) | ✅ Yes (local database only)       |

**Details:**

* **Server Mode (default mode):**
  * Full control — can create, modify, and delete VLANs.
  * Advertises VLAN info to other switches in the domain.
  * Stores VLAN configuration in NVRAM (persists across reboot).

* **Client Mode:**
  * **Cannot** create/modify/delete VLANs locally.
  * Only **receives and forwards** VTP advertisements from servers.
  * Does **not** save VLAN info to NVRAM — relies on Server for updates on every boot.

* **Transparent Mode:**
  * Can create/modify/delete VLANs, but changes are **local only** — NOT advertised to other switches.
  * **Forwards** VTP advertisements it receives from other switches (acts as a pass-through) but does **not process/act on them**.
  * Saves its own VLAN configuration locally in NVRAM.

✅ **Memory Trick:** 
**Server = Full Control + Advertises**
**Client = No Control, Just Listens**
**Transparent = Local Control Only, Just Relays**

### 🔹 VTP Operation

* VTP advertisements are sent as **multicast frames**.
* VTP **servers and clients** synchronize using the **latest Configuration Revision Number** — higher revision number = more recent = gets adopted.
* Advertisements are sent **every 5 minutes**, or immediately when a change occurs (triggered).

⚠️ **Critical Danger (Common Real-World/Exam Scenario):**
If a **new switch with a higher VTP revision number** (even with wrong/empty VLAN data) is added to the domain, it can **overwrite the VLAN database** of the entire network — causing major outages!

### 🔹 VTP Configuration Guidelines

Configuration items required for VTP setup:

* **VTP Domain Name** — must match across all switches in the domain to communicate
* **VTP Mode** — Server mode is default
* **VTP Pruning** — restricts unnecessary VLAN traffic on trunk links where not needed (saves bandwidth)
* **VTP Password** — secures the domain from unauthorized VTP changes

### 🔹 Best Practice When Adding a New Switch to an Existing VTP Domain

To avoid accidentally overwriting the domain's VLAN database:

1. **Add the new switch in Client mode first** → allows it to safely learn/synchronize the latest VLAN information from the domain without risk of overwriting anything.
2. Once synced, **convert it to Server mode** if it needs to make changes.

**Alternative approach:**
1. Add all new configurations to the switch while it is in **Transparent mode** first.
2. Thoroughly **check/verify the configuration**.
3. Then **convert it to Server mode** — this prevents the switch from propagating incorrect/incomplete VLAN information to the rest of the domain during setup.

✅ **Exam Trap:** Never add a brand-new switch directly in **Server mode** with default settings blindly — the real danger is adding a switch that was **previously configured elsewhere** with a **higher revision number** — it can silently wipe out the domain's VLANs.

---

## ⭐ Quick Revision — VLAN Module

* VLAN = logical broadcast domain, needs a **router/L3 device** to talk between VLANs
* Benefits: **S-R-A-M-L** (Solve broadcast, Reduce domain, Add security, Manage easily, Logical grouping)
* **Access link** = 1 device, 1 VLAN, untagged, standard NIC
* **Trunk link** = multiple VLANs, tagged, switch-to-switch/router
* Trunk protocols: **ISL** (Cisco, tags native VLAN too) vs **802.1Q** (Standard, native VLAN untagged)
* Inter-VLAN routing: **Router-on-a-Stick** (1 interface, multiple sub-interfaces, `encapsulation dot1q`) OR **Layer 3 Switch** (SVI, faster, modern standard)
* VTP = Cisco-proprietary, auto-distributes VLAN config
* VTP modes: **Server** (full control + advertise) / **Client** (no control, listen only) / **Transparent** (local control, just relay)
* VTP uses **revision number** to determine latest config — **higher wins** (danger zone!)
* Safe practice: add new switches in **Client** or **Transparent** mode first, verify, then promote to **Server**

---

## 🎯 Most Likely Exam/Viva Questions

* What problem does VLAN solve? → **Broadcast domain size / broadcast storms**
* Difference between Access and Trunk ports? → 1 VLAN vs multiple VLANs
* What is tagging and why is it needed? → Identifies source VLAN of frame across trunk
* ISL vs 802.1Q? → Proprietary vs Standard; native VLAN tagging difference
* What is Router-on-a-Stick? → Single router interface + VLAN sub-interfaces via `dot1q` trunk
* What is an SVI? → Virtual Layer 3 interface for a VLAN on a Layer 3 switch
* 3 VTP modes and their differences? → Server / Client / Transparent (see table above)
* What determines which VTP update is accepted? → **Highest revision number**
* Why is VTP risky when adding new switches? → A switch with higher revision number can overwrite existing VLAN database

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[04A - Network Routing Fundamentals]]
- [[11 - Layer 2 Switching and Ethernet Forwarding]]
- [[08 - Spanning Tree Protocol]]
- [[09 - Infrastructure Security ACL AAA and Port Security]]
