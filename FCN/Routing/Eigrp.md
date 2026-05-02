Here is **EIGRP info in the same style as RIP and OSPF**, so your notes stay consistent.

---

# 📡 EIGRP Timers

## 🔹 Default EIGRP Timers

| **Timer**        | **Default Value**       | **Meaning**                                 |
| ---------------- | ----------------------- | ------------------------------------------- |
| **Hello Timer**  | **5 sec**               | Sends Hello packets to maintain neighbors   |
| **Hold Timer**   | **15 sec**              | Neighbor declared down if no Hello received |
| **Update Timer** | **No periodic updates** | Sends updates only when changes occur       |
| **Active Timer** | **3 min (180 sec)**     | Time allowed to find alternative route      |

✅ **Memory Trick:**
**5 — 15 — (Triggered) — 180**

Very important for exams.

---

# 📡 EIGRP Other Important Information

## 🔹 EIGRP Basics

* **Full Form:** Enhanced Interior Gateway Routing Protocol
* **Type:** **Hybrid Routing Protocol**
  (Distance Vector + Link-State features)
* **Metric Used:** **Composite Metric**
* **Algorithm Used:** **DUAL (Diffusing Update Algorithm)**

---

## 🔹 EIGRP Metric Formula (Composite Metric)

EIGRP metric mainly depends on **Bandwidth** and **Delay**.

Metric = 256 \times \left( \frac{10^7}{Bandwidth} + Delay \right)

Where:

* Bandwidth = Lowest bandwidth in path
* Delay = Sum of delays in path

📌 Default uses:

* **Bandwidth**
* **Delay**

Optional (rarely used):

* Load
* Reliability

---

## 🔹 EIGRP Administrative Details

| Parameter                        | Value              |
| -------------------------------- | ------------------ |
| **Administrative Distance (AD)** | **90 (Internal)**  |
|                                  | **170 (External)** |
| **Protocol Number**              | **88**             |
| **Transport Protocol**           | IP                 |
| **Update Type**                  | Multicast          |
| **Multicast Address**            | **224.0.0.10**     |

---

## 🔹 EIGRP Tables (Very Important)

EIGRP maintains **3 tables**.

| Table              | Purpose                   |
| ------------------ | ------------------------- |
| **Neighbor Table** | Stores neighbor routers   |
| **Topology Table** | Stores all learned routes |
| **Routing Table**  | Stores best routes        |

📌 Very common theory question.

---

## 🔹 EIGRP Terminologies

Important definitions.

| Term                       | Meaning                      |
| -------------------------- | ---------------------------- |
| **Successor**              | Best path to destination     |
| **Feasible Successor**     | Backup path                  |
| **Feasible Distance (FD)** | Best metric to reach network |
| **Reported Distance (RD)** | Metric reported by neighbor  |

---

## 🔹 EIGRP Packet Types

There are **5 EIGRP packet types**:

| Number | Packet Name    | Purpose                  |
| ------ | -------------- | ------------------------ |
| **1**  | Hello          | Discover neighbors       |
| **2**  | Update         | Send routing information |
| **3**  | Query          | Ask for alternate path   |
| **4**  | Reply          | Respond to Query         |
| **5**  | Acknowledgment | Confirm receipt          |

✅ **Memory Trick:**
**Hello → Update → Query → Reply → Ack**

---

## 🔹 EIGRP Features

Very important conceptually.

* Fast convergence
* Supports **VLSM and CIDR**
* Uses **Triggered Updates**
* Supports **Load Balancing**
* Supports **Unequal Cost Load Balancing** (unique feature)

📌 Unequal load balancing = **Major EIGRP advantage**

---

# 📡 EIGRP Ultra-Short Revision

* **Type:** Hybrid
* **Algorithm:** DUAL
* **Metric:** Bandwidth + Delay
* **AD:** 90 (Internal), 170 (External)
* **Protocol Number:** 88
* **Hello:** 5 sec
* **Hold:** 15 sec
* **Multicast:** 224.0.0.10

---

# 📡 RIP vs OSPF vs EIGRP Quick Comparison (Very Important)

| Feature   | RIP             | OSPF       | EIGRP          |
| --------- | --------------- | ---------- | -------------- |
| Type      | Distance Vector | Link-State | Hybrid         |
| Metric    | Hop Count       | Cost       | Composite      |
| AD        | 120             | 110        | 90             |
| Algorithm | Bellman-Ford    | Dijkstra   | DUAL           |
| Speed     | Slow            | Fast       | Very Fast      |
| Max Hop   | 15              | No limit   | No fixed limit |
| Updates   | Periodic        | Triggered  | Triggered      |

---

# ⭐ Most Asked EIGRP Exam Questions

Very commonly asked:

* EIGRP uses **DUAL Algorithm**
* **AD = 90 (Internal)**
* **Protocol Number = 88**
* **Hello Timer = 5 sec**
* **Hold Timer = 15 sec**
* Uses **Composite Metric**
* Supports **Unequal Load Balancing**

---

If you're building routing notes, the **next best topic** to complete your set is:

* **BGP (Border Gateway Protocol)**
* **DR vs BDR Election Rules**
* **Route Redistribution Basics**

I can create **BGP in the same structured style** next if you want.
