Here is **OSPF info in the same style as RIP**, so you can revise both easily.

---

# 📡 OSPF Timers

## 🔹 OSPF Default Timers

| **Timer**            | **Default Value** | **Meaning**                                 |
| -------------------- | ----------------- | ------------------------------------------- |
| **Hello Timer**      | **10 sec**        | Sends Hello packets to discover neighbors   |
| **Dead Timer**       | **40 sec**        | Neighbor declared down if no Hello received |
| **Wait Timer**       | **40 sec**        | Waits for DR/BDR election                   |
| **Retransmit Timer** | **5 sec**         | Time between LSA retransmissions            |

✅ **Memory Trick:**
**10 — 40 — 40 — 5**

Very common MCQ question.

---

# 📡 OSPF Other Important Information

## 🔹 OSPF Basics

* **Full Form:** Open Shortest Path First
* **Type:** **Link-State Routing Protocol**
* **Metric Used:** **Cost**
* **Algorithm Used:** **Dijkstra Algorithm (SPF — Shortest Path First)**

---

## 🔹 OSPF Metric (Cost Formula)

OSPF cost is based on **bandwidth**.

Cost = \frac{10^8}{Bandwidth}

Where:

* Bandwidth in **bits per second**
* Lower cost = Better path

Example:

* Fast Ethernet (100 Mbps) → Cost = **1**
* Gigabit Ethernet → Cost = **1** (usually manually adjusted)

---

## 🔹 OSPF Administrative Details

| Parameter                        | Value                            |
| -------------------------------- | -------------------------------- |
| **Administrative Distance (AD)** | **110**                          |
| **Transport Protocol**           | IP Protocol                      |
| **Protocol Number**              | **89**                           |
| **Update Type**                  | Multicast                        |
| **Multicast Address**            | **224.0.0.5** (All OSPF routers) |
| **DR/BDR Address**               | **224.0.0.6**                    |

---

## 🔹 OSPF Router Roles

OSPF uses special routers in multi-access networks.

| Role        | Meaning                  |
| ----------- | ------------------------ |
| **DR**      | Designated Router        |
| **BDR**     | Backup Designated Router |
| **DROther** | Other routers in network |

📌 Used to **reduce routing traffic**.

---

## 🔹 OSPF Packet Types (Very Important)

There are **5 OSPF packet types**:

| Number | Packet Name | Purpose                   |
| ------ | ----------- | ------------------------- |
| **1**  | Hello       | Discover neighbors        |
| **2**  | DBD         | Database Description      |
| **3**  | LSR         | Link State Request        |
| **4**  | LSU         | Link State Update         |
| **5**  | LSAck       | Link State Acknowledgment |

✅ **Memory Trick:**
**Hello → DBD → LSR → LSU → LSAck**

---

## 🔹 OSPF Areas (Very Important)

OSPF divides networks into **Areas**.

| Area          | Meaning                           |
| ------------- | --------------------------------- |
| **Area 0**    | Backbone Area (Mandatory)         |
| **Area 1,2…** | Regular Areas                     |
| **ABR**       | Area Border Router                |
| **ASBR**      | Autonomous System Boundary Router |

📌 **All areas must connect to Area 0**

---

## 🔹 OSPF Neighbor States (Important)

Common exam question.

1. Down
2. Init
3. Two-Way
4. ExStart
5. Exchange
6. Loading
7. Full

✅ **Memory Trick:**
**Down → Init → 2-Way → ExStart → Exchange → Loading → Full**

---

# 📡 OSPF Ultra-Short Revision

* **Type:** Link-State
* **Algorithm:** Dijkstra
* **Metric:** Cost
* **AD:** 110
* **Protocol Number:** 89
* **Hello:** 10 sec
* **Dead:** 40 sec
* **Multicast:** 224.0.0.5
* **Backbone Area:** Area 0

---

# 📡 RIP vs OSPF Quick Comparison (Very Useful)

| Feature      | RIP             | OSPF       |
| ------------ | --------------- | ---------- |
| Type         | Distance Vector | Link-State |
| Metric       | Hop Count       | Cost       |
| Max Hop      | 15              | No limit   |
| AD           | 120             | 110        |
| Algorithm    | Bellman-Ford    | Dijkstra   |
| Speed        | Slow            | Fast       |
| Network Size | Small           | Large      |

---

# ⭐ Most Asked OSPF Exam Questions

Very likely to appear:

* OSPF **Hello Timer = 10 sec**
* OSPF **Dead Timer = 40 sec**
* OSPF uses **Dijkstra Algorithm**
* OSPF **Protocol Number = 89**
* Backbone area = **Area 0**
* Metric = **Cost**

---

If you're making notes like your RIP page, next best topics to add are:

* **EIGRP Timers + Info**
* **BGP Basics**
* **DR/BDR Election Rules**

I can generate **EIGRP similar to RIP & OSPF** next if you want.
