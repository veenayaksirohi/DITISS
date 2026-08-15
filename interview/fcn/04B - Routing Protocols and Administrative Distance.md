---
title: "04B - Routing Protocols and Administrative Distance"
aliases:
  - "📡 Module 4: Routing — Complete Notes"
  - "Routing Complete Notes"
tags:
  - computer-networks
  - routing-protocols
  - administrative-distance
  - cisco
syllabus-topic:
  - 4
---

# 📡 Module 4: Routing — Complete Notes

---

## 4.1 Static Routing vs Dynamic Routing

### 🔹 Static Routing

* Routes are **manually configured** by the network administrator.
* Router does **not** automatically adapt to topology changes.
* No routing protocol overhead (no CPU/bandwidth used for updates).

**Command (Cisco):**
```
ip route <destination-network> <subnet-mask> <next-hop-ip>
```

**Advantages:**
* No CPU overhead — no calculations
* No bandwidth used between routers (no updates exchanged)
* More secure (no route advertisement to intercept)
* Predictable — admin has full control

**Disadvantages:**
* Not scalable for large networks
* Manual reconfiguration needed on topology change
* Prone to human error
* No automatic failover

### 🔹 Dynamic Routing

* Routers **automatically learn** and update routes using routing protocols.
* Adapts to topology changes (link failure, new network) automatically.

**Advantages:**
* Scalable for large/complex networks
* Automatic failover / self-healing
* Less administrative overhead

**Disadvantages:**
* Consumes CPU, memory, and bandwidth
* More complex to configure/troubleshoot initially
* Slight security risk (routes advertised, can be spoofed without auth)

### 🔹 Comparison Table

| Parameter          | Static Routing         | Dynamic Routing              |
| ------------------ | ----------------------- | ----------------------------- |
| Configuration       | Manual                 | Automatic                     |
| Scalability         | Poor (small networks)  | Good (large networks)         |
| CPU/Bandwidth Usage | None                   | Used for updates              |
| Adapts to Failure    | No                      | Yes (auto convergence)        |
| Security            | More secure             | Less secure (unless auth)     |
| Administrative Effort | High (manual updates) | Low (self-managing)           |
| Best For            | Small/stub networks     | Large/enterprise networks     |

✅ **Exam Trap:** Static routes have a default **Administrative Distance (AD) = 1** (better/more trusted than any dynamic protocol, so static always wins if configured for same destination).

---

## 4.2 Distance Vector vs Link State (RIP vs OSPF)

### 🔹 Distance Vector Routing (e.g., RIP)

* Each router shares its **entire routing table** with directly connected neighbors only.
* "**Routing by rumor**" — router trusts what neighbor says without seeing full topology.
* Uses **Bellman-Ford Algorithm**.
* Metric = **Hop Count**.
* Slower convergence, prone to routing loops (needs Split Horizon, Hold-down timers).

### 🔹 Link State Routing (e.g., OSPF)

* Each router builds a **complete map (topology) of the network** using Link State Advertisements (LSAs).
* Every router has **identical view** of the network (LSDB — Link State Database).
* Uses **Dijkstra's Algorithm (SPF – Shortest Path First)**.
* Metric = **Cost** (based on bandwidth).
* Faster convergence, more CPU/memory intensive.

### 🔹 Comparison Table

| Parameter            | Distance Vector (RIP)      | Link State (OSPF)               |
| --------------------- | --------------------------- | -------------------------------- |
| Info Shared            | Entire routing table        | Only link-state info (LSAs)      |
| Shared With            | Directly connected neighbors| All routers in area (flooded)    |
| Algorithm              | Bellman-Ford                 | Dijkstra (SPF)                   |
| Network View           | Partial ("routing by rumor")| Full topology map                |
| Convergence            | Slow                        | Fast                              |
| Metric                 | Hop Count                    | Cost (bandwidth-based)           |
| Loop Prevention        | Split Horizon, Hold-down     | Not needed (full topology known) |
| Resource Usage         | Low                          | High (CPU/Memory)                |
| Scalability            | Small networks only          | Large networks                   |

---

## 4.3 Administrative Distance (AD) Concept

### 🔹 What is AD?

* AD = a value that represents the **trustworthiness/reliability** of a routing information source.
* Range: **0 – 255**
* **Lower AD = More trusted = More preferred**
* Used when a router learns the **same destination network** from **more than one routing protocol/source** — the router picks the route from the source with the **lowest AD**.

📌 AD is used **before** the metric. Metric is only compared **within the same protocol**.

### 🔹 Default AD Table (Very Important — Memorize!)

| Route Source                     | Administrative Distance |
| --------------------------------- | ------------------------ |
| **Connected Interface**           | 0                         |
| **Static Route**                  | 1                         |
| **EIGRP (Summary Route)**         | 5                         |
| **eBGP (External BGP)**           | 20                        |
| **EIGRP (Internal)**              | 90                        |
| **OSPF**                          | 110                       |
| **IS-IS**                         | 115                       |
| **RIP**                           | 120                       |
| **EIGRP (External)**              | 170                       |
| **iBGP (Internal BGP)**           | 200                       |
| **Unknown / Unreachable**         | 255 (never used)          |

✅ **Memory Trick:**
**0 (Connected) → 1 (Static) → 5 (EIGRP Summary) → 20 (eBGP) → 90 (EIGRP) → 110 (OSPF) → 115 (IS-IS) → 120 (RIP) → 170 (EIGRP Ext) → 200 (iBGP)**

### 🔹 Example Scenario (Common Exam/Viva Question)

> If a router learns route to 192.168.1.0/24 via both OSPF (AD 110) and RIP (AD 120), which will it install in the routing table?

**Answer:** OSPF — because it has the **lower AD (110 < 120)**, regardless of hop count or cost.

---

## 4.4 IGP vs EGP

### 🔹 IGP (Interior Gateway Protocol)

* Used for routing **within a single Autonomous System (AS)**.
* Examples: **RIP, IGRP, EIGRP, OSPF, IS-IS**

### 🔹 EGP (Exterior Gateway Protocol)

* Used for routing **between different Autonomous Systems**.
* Example: **BGP** (the only EGP in practical/modern use)

### 🔹 Comparison Table

| Parameter        | IGP                              | EGP                        |
| ------------------ | ---------------------------------- | ----------------------------- |
| Full Form           | Interior Gateway Protocol          | Exterior Gateway Protocol    |
| Scope               | Within one AS                      | Between different AS         |
| Examples            | RIP, IGRP, EIGRP, OSPF, IS-IS      | BGP                            |
| Algorithm Type      | Distance Vector / Link State / Hybrid | Path Vector               |
| Convergence         | Fast to Medium                     | Slow (designed for stability) |
| Used By             | Enterprises, campus networks       | ISPs, Internet backbone       |
| Metric              | Hop count / Cost / Composite        | Path attributes (AS-Path, etc.)|

📌 **What is an Autonomous System (AS)?**
A group of networks/routers under a **single administrative control**, identified by a unique **AS Number (ASN)**, e.g., an ISP or large organization.

---

## 4.5 RIP (Routing Information Protocol)

### 🔹 RIP Basics

* **Full Form:** Routing Information Protocol
* **Type:** Distance Vector Routing Protocol (IGP)
* **Algorithm:** Bellman-Ford
* **Metric Used:** Hop Count
* **Maximum Hop Count:** 15 → **16 = Unreachable**
* **Administrative Distance:** 120
* **Transport Protocol:** UDP
* **Port Number:** 520
* **Update Type:** Broadcast (RIPv1) / Multicast (RIPv2)
* **Multicast Address (RIPv2):** 224.0.0.9

### 🔹 RIP Timers

| **Timer**            | **Value**   | **Meaning**                                     |
| ---------------------- | ------------ | ------------------------------------------------- |
| **Update Timer**       | 30 sec       | Sends routing updates every 30 seconds            |
| **Invalid Timer**      | 180 sec      | Route becomes invalid if no update received       |
| **Hold-down Timer**    | 180 sec      | Prevents accepting bad updates for that route      |
| **Flush Timer**        | 240 sec      | Route is removed from routing table                |

✅ **Memory Trick:** **30 — 180 — 180 — 240**

### 🔹 RIP Versions

| Version | Name      | Features                |
| --------- | --------- | -------------------------- |
| RIP v1    | Classful  | No subnet mask support     |
| RIP v2    | Classless | Supports VLSM, CIDR, Auth  |
| RIPng     | IPv6      | Used for IPv6 routing      |

### 🔹 RIP Loop Prevention Methods

1. **Hop Count Limit** — Max 15, 16 = unreachable
2. **Split Horizon** — Don't advertise a route back out the interface it was learned from
3. **Hold-down Timer** — Ignore new updates about a route for a period after it's marked invalid
4. **Triggered Updates** — Send an update immediately when a route changes (instead of waiting for timer)
5. **Route Poisoning** — Advertise a failed route with metric 16 (infinity) instead of just removing it

### 🔹 Very Important Exam Notes ⭐
* RIP is **Distance Vector Protocol**
* Uses **Bellman-Ford Algorithm**
* Metric = **Hop Count** — lowest hop count is preferred
* Max hops = **15**; **AD = 120**; **UDP Port = 520**
* Sends full-table updates every **30 sec**
* TTL exceeded → ICMP message sent

---

## 4.6 IGRP (Interior Gateway Routing Protocol) — Cisco Legacy

* **Full Form:** Interior Gateway Routing Protocol
* **Developer:** Cisco (proprietary, now **obsolete/deprecated** — replaced by EIGRP)
* **Type:** Distance Vector
* **Metric:** Composite (Bandwidth + Delay + Reliability + Load — configurable)
* **Max Hop Count:** 100 (default), up to 255
* **Administrative Distance:** 100
* **Update Timer:** 90 sec

📌 **Exam Note:** IGRP is Cisco-proprietary and largely **retired**; it's the historical predecessor to EIGRP. Mentioned mainly for legacy/theory questions — EIGRP is what's actually configured today.

| Parameter    | IGRP           | EIGRP                     |
| -------------- | ---------------- | ---------------------------- |
| Type            | Distance Vector | Hybrid (Advanced DV)         |
| Metric          | Composite        | Composite (same base formula)|
| AD              | 100               | 90 (Internal)                |
| Classless       | No (Classful)    | Yes                            |
| VLSM Support    | No                | Yes                            |
| Status          | Obsolete          | Actively used                 |

---

## 4.7 OSPF (Open Shortest Path First)

### 🔹 OSPF Basics

* **Full Form:** Open Shortest Path First
* **Type:** Link-State Routing Protocol (IGP)
* **Algorithm:** Dijkstra (SPF — Shortest Path First)
* **Metric Used:** Cost = **10⁸ / Bandwidth**
* **Administrative Distance:** 110
* **Transport Protocol:** IP Protocol Number **89**
* **Update Type:** Multicast, Triggered (not periodic)
* **Multicast Addresses:** 224.0.0.5 (All OSPF routers), 224.0.0.6 (DR/BDR)

### 🔹 OSPF Timers

| **Timer**            | **Default Value** | **Meaning**                                   |
| ---------------------- | -------------------- | ------------------------------------------------- |
| **Hello Timer**        | 10 sec               | Sends Hello packets to discover neighbors           |
| **Dead Timer**         | 40 sec               | Neighbor declared down if no Hello received         |
| **Wait Timer**         | 40 sec               | Waits for DR/BDR election                            |
| **Retransmit Timer**   | 5 sec                | Time between LSA retransmissions                     |

✅ **Memory Trick:** **10 — 40 — 40 — 5**

### 🔹 OSPF Packet Types (5 types)

| # | Packet Name | Purpose                    |
| --- | ------------- | ----------------------------- |
| 1   | Hello         | Discover neighbors             |
| 2   | DBD           | Database Description           |
| 3   | LSR           | Link State Request              |
| 4   | LSU           | Link State Update                |
| 5   | LSAck         | Link State Acknowledgment        |

✅ **Memory Trick:** Hello → DBD → LSR → LSU → LSAck

### 🔹 OSPF Areas

| Area          | Meaning                            |
| --------------- | -------------------------------------- |
| **Area 0**      | Backbone Area (Mandatory)              |
| **Area 1,2…**   | Regular Areas                          |
| **ABR**         | Area Border Router                      |
| **ASBR**        | Autonomous System Boundary Router       |

📌 **All areas must connect to Area 0.**

### 🔹 OSPF DR/BDR Election

**Purpose:** On broadcast/multi-access networks, DR & BDR reduce adjacency count, LSA flooding, and bandwidth/CPU usage. Other routers (DROTHERs) peer only with DR/BDR instead of full mesh.

**Election Rules (in order):**
1. **Highest Priority wins** (range 0–255) → DR; second-highest → BDR
2. **Tie-breaker:** Highest **Router ID** → DR; second-highest → BDR
3. **Priority = 0** → Router is ineligible, becomes DROTHER only
4. **Default priority = 1** for all interfaces → if unchanged, election goes purely by Router ID

### 🔹 OSPF Neighbor States (7 states — Common Exam Question)

1. **Down** — No Hello received yet
2. **Init** — Hello received, but own Router ID not seen in neighbor's Hello
3. **Two-Way** — Bidirectional communication confirmed
4. **ExStart** — Master/slave roles decided for DB exchange
5. **Exchange** — DBD packets exchanged (LSDB summaries)
6. **Loading** — Missing LSAs requested (LSR) and received (LSU)
7. **Full** — LSDBs fully synchronized; adjacency complete

✅ **Memory Trick:** Down → Init → 2-Way → ExStart → Exchange → Loading → Full

### 🔹 Very Important Exam Notes ⭐
* OSPF Hello = **10 sec**, Dead = **40 sec**
* Uses **Dijkstra Algorithm**
* Protocol Number = **89**
* Backbone area = **Area 0**
* Metric = **Cost**

---

## 4.8 EIGRP (Enhanced Interior Gateway Routing Protocol)

### 🔹 EIGRP Basics

* **Full Form:** Enhanced Interior Gateway Routing Protocol
* **Type:** **Hybrid** (Distance Vector + Link-State features)
* **Algorithm:** **DUAL (Diffusing Update Algorithm)**
* **Metric Used:** Composite Metric (Bandwidth + Delay by default)
* **Administrative Distance:** 90 (Internal), 170 (External)
* **Protocol Number:** 88
* **Transport Protocol:** IP
* **Update Type:** Multicast, Triggered (no periodic updates)
* **Multicast Address:** 224.0.0.10

### 🔹 EIGRP Metric Formula (Composite Metric)

```
Metric = 256 × (10⁷ / Bandwidth + Delay)
```

* Bandwidth = lowest bandwidth in the path
* Delay = sum of delays in the path
* Optional (rarely used): Load, Reliability

### 🔹 EIGRP Timers

| **Timer**        | **Default Value**       | **Meaning**                                     |
| ------------------- | -------------------------- | --------------------------------------------------- |
| **Hello Timer**     | 5 sec                       | Sends Hello packets to maintain neighbors             |
| **Hold Timer**      | 15 sec                      | Neighbor declared down if no Hello received           |
| **Update Timer**    | No periodic updates         | Sends updates only when changes occur (triggered)     |
| **Active Timer**    | 3 min (180 sec)              | Time allowed to find an alternative route              |

✅ **Memory Trick:** **5 — 15 — (Triggered) — 180**

### 🔹 EIGRP Tables (3 tables — Very Important)

| Table              | Purpose                     |
| -------------------- | -------------------------------- |
| **Neighbor Table**   | Stores neighbor routers            |
| **Topology Table**   | Stores all learned routes           |
| **Routing Table**    | Stores best routes                  |

### 🔹 EIGRP Terminologies

| Term                        | Meaning                          |
| ------------------------------ | ------------------------------------- |
| **Successor**                 | Best path to destination                |
| **Feasible Successor**        | Backup path                              |
| **Feasible Distance (FD)**    | Best metric to reach network             |
| **Reported Distance (RD)**    | Metric reported by neighbor              |

### 🔹 EIGRP Packet Types (5 types)

| # | Packet Name     | Purpose                     |
| --- | ------------------ | --------------------------------- |
| 1   | Hello               | Discover neighbors                  |
| 2   | Update              | Send routing information              |
| 3   | Query               | Ask for alternate path                 |
| 4   | Reply               | Respond to Query                       |
| 5   | Acknowledgment      | Confirm receipt                        |

✅ **Memory Trick:** Hello → Update → Query → Reply → Ack

### 🔹 EIGRP Features
* Fast convergence
* Supports **VLSM and CIDR**
* Uses **Triggered Updates**
* Supports **Equal AND Unequal Cost Load Balancing** (unique advantage over RIP/OSPF)

### 🔹 Very Important Exam Notes ⭐
* EIGRP uses **DUAL Algorithm**
* **AD = 90 (Internal)**, 170 (External)
* **Protocol Number = 88**
* **Hello = 5 sec, Hold = 15 sec**
* Uses **Composite Metric**
* Only IGP that supports **Unequal Load Balancing**

---

## 4.9 BGP (Border Gateway Protocol)

### 🔹 BGP Basics

* **Full Form:** Border Gateway Protocol
* **Type:** **EGP (Exterior Gateway Protocol)** — connects Autonomous Systems
* **Algorithm Type:** **Path Vector** (not Distance Vector or pure Link-State)
* **Transport Protocol:** **TCP** (Port 179)
* **Administrative Distance:** 20 (eBGP), 200 (iBGP)
* **Convergence Speed:** Slow (designed for internet-scale stability, not speed)

### 🔹 Characteristics of BGP

* Provides communication **between two Autonomous Systems**
* Supports the **Next-Hop Paradigm**
* Path Information included in advertisements (destination + next-hop pair)
* **Policy-based routing** — admin can configure custom route policies
* Runs over **TCP** (reliable, connection-oriented)
* Conserves bandwidth (incremental updates only, not periodic full updates)
* Supports **CIDR**
* Supports **security** via authentication (MD5, TCP-AO)

### 🔹 Types of BGP

| Type     | Full Form               | Used Between                     |
| ---------- | -------------------------- | ------------------------------------- |
| **eBGP**   | External BGP                | Routers in **different** AS            |
| **iBGP**   | Internal BGP                 | Routers within the **same** AS         |

### 🔹 BGP Path Attributes (Elements) — Used for Best Path Selection

| Attribute                  | Meaning                                             |
| ----------------------------- | -------------------------------------------------------- |
| **Weight**                    | Cisco-proprietary; **higher** value preferred                |
| **Local Preference**          | Selects outbound path; **higher** value preferred            |
| **AS Path**                   | Shorter AS-Path length preferred                              |
| **Origin**                    | How the route was originated into BGP                         |
| **Next Hop**                  | IP address used as the next hop                                |
| **MED (Multi-Exit Discriminator)** | Suggests preferred entry point into AS; **lower** preferred |

### 🔹 BGP Functions (Peer-to-Peer)

1. **Peer Acquisition & Authentication** — TCP connection established, message exchange to agree on communication
2. **Reachability Exchange** — send positive/negative reachability info
3. **Verification** — confirm peers and connection are functioning correctly

### 🔹 BGP Route Information Management

| Function                | Description                                          |
| -------------------------- | ---------------------------------------------------------- |
| **Route Storage**          | Stores info on how to reach other networks                     |
| **Route Update**           | Determines when/how to update routes from peer info             |
| **Route Selection**        | Chooses best routes from database to each network                 |
| **Route Advertisement**    | Regularly tells peers what it knows about reachable networks       |

### 🔹 Why BGP Matters

* **Security:** Authenticates peer messages with passwords, filters unauthorized traffic
* **Scalability:** Manages massive route tables (entire internet)
* **Multihoming:** Allows connecting to multiple ISPs/networks simultaneously
* **Best Path Calculation:** Determines optimal path across AS boundaries

### 🔹 BGP vs OSPF Comparison

| Parameter               | BGP                              | OSPF                        |
| -------------------------- | ----------------------------------- | -------------------------------- |
| Algorithm                  | Path Vector                          | Link-State                        |
| Convergence Speed          | Slow                                 | Fast                                |
| Scope                      | Inter-domain (between AS)             | Intra-domain (within AS)            |
| Routing Operation          | Between two AS                        | Inside an AS                         |
| Transport Protocol         | TCP                                   | IP (Protocol 89)                     |

### 🔹 Very Important Exam Notes ⭐
* BGP = **only EGP** in practical use
* Uses **Path Vector algorithm**
* Runs over **TCP port 179**
* eBGP AD = **20**, iBGP AD = **200**
* Best path selection uses **Weight → Local Preference → AS Path → Origin → MED → ...**

---

## 4.10 🎯 Master Comparison Table — RIP vs OSPF vs EIGRP vs BGP

| **Parameter**               | **RIP**                  | **OSPF**                 | **EIGRP**                     | **BGP**                    |
| --------------------------- | --------------------------- | --------------------------- | ---------------------------------- | ------------------------------ |
| **Category**                 | IGP                          | IGP                          | IGP                                  | EGP                              |
| **Type**                     | Distance Vector             | Link-State                  | Hybrid                              | Path Vector                     |
| **Algorithm**                | Bellman-Ford                | Dijkstra (SPF)               | DUAL                                | Path Vector (Best Path Selection)|
| **Metric**                   | Hop Count                    | Cost (Bandwidth)             | Composite (BW+Delay)                | Path Attributes (AS-Path etc.)  |
| **Max Hop Count**             | 15                            | No limit                     | No fixed limit                       | N/A                               |
| **Administrative Distance**   | 120                           | 110                            | 90 (Int) / 170 (Ext)                 | 20 (eBGP) / 200 (iBGP)            |
| **Transport**                 | UDP (Port 520)               | IP (Protocol 89)              | IP (Protocol 88)                      | TCP (Port 179)                    |
| **Update Type**               | Periodic (30 sec)             | Triggered                      | Triggered                             | Triggered (incremental)           |
| **Convergence Speed**         | Slow                          | Fast                            | Very Fast                             | Slow                               |
| **Load Balancing**            | Equal only                    | Equal only                      | Equal + Unequal                       | N/A (Policy-based)                 |
| **Network Size**              | Small                          | Large                            | Medium–Large                          | Internet-scale (between AS)       |
| **Area/Hierarchy Concept**    | No                              | Yes (Areas)                      | Partial (Autonomous Systems)          | Yes (AS-based)                     |

---

## ⭐ Quick Revision — All Protocols Ultra-Short

**RIP:** DV | Bellman-Ford | Hop Count | Max 15 | AD 120 | UDP 520 | 30 sec updates

**OSPF:** Link-State | Dijkstra | Cost | AD 110 | Protocol 89 | Hello 10/Dead 40 | Area 0 mandatory

**EIGRP:** Hybrid | DUAL | Composite (BW+Delay) | AD 90/170 | Protocol 88 | Hello 5/Hold 15 | Unequal LB unique

**BGP:** Path Vector | TCP 179 | AD 20(e)/200(i) | Inter-AS | Slow convergence | Policy-based

**AD Priority Order (lower = better):**
Connected(0) → Static(1) → EIGRP Summary(5) → eBGP(20) → EIGRP(90) → OSPF(110) → IS-IS(115) → RIP(120) → EIGRP Ext(170) → iBGP(200)

---

## 🎯 Interview-Level Key Differences

* **RIP** → Simple but **slow**
* **OSPF** → Structured and **scalable**, uses **Areas**
* **EIGRP** → Fast and **efficient**, supports **Unequal Load Balancing**
* **BGP** → Only protocol for **inter-AS/internet routing**, policy-driven, slow but stable
* **Static routing** → Best for small/stub networks, most secure, no overhead
* **Dynamic routing** → Best for large networks, self-healing, more overhead
* **AD decides between different protocols; Metric decides within the same protocol**

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[13 - Router IOS and Management]]
- [[04A - Network Routing Fundamentals]]
