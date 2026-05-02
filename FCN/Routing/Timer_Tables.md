| **Parameter**                    | **RIP**                      | **OSPF**                 | **EIGRP**                                  |
| -------------------------------- | ---------------------------- | ------------------------ | ------------------------------------------ |
| **Full Form**                    | Routing Information Protocol | Open Shortest Path First | Enhanced Interior Gateway Routing Protocol |
| **Type**                         | Distance Vector              | Link-State               | Hybrid                                     |
| **Administrative Distance (AD)** | 120                          | 110                      | 90 (Internal), 170 (External)              |
| **Metric**                       | Hop Count                    | Cost                     | Composite Metric                           |
| **Metric Based On**              | Number of hops               | Bandwidth                | Bandwidth + Delay                          |
| **Algorithm**                    | Bellman-Ford                 | Dijkstra (SPF)           | DUAL                                       |
| **Port Number + Type**           | UDP 520                      | Protocol 89 (IP)         | Protocol 88 (IP)                           |
| **Multicast Address**            | 224.0.0.9                    | 224.0.0.5                | 224.0.0.10                                 |
| **Maximum Hop Count**            | 15                           | No limit                 | No fixed limit                             |
| **Hop 16 Means**                 | Unreachable                  | Not applicable           | Not applicable                             |
| **Update Type**                  | Periodic                     | Triggered                | Triggered                                  |


# 📡 RIP Timers (Extracted from Your Image)

From the table in your notes:

| **Timer**           | **Value**   | **Meaning**                                   |
| ------------------- | ----------- | --------------------------------------------- |
| **Update Timer**    | **30 sec**  | Router sends routing updates every 30 seconds |
| **Invalid Timer**   | **180 sec** | Route becomes invalid if no update received   |
| **Hold-down Timer** | **180 sec** | Prevents accepting bad updates for that route |
| **Flush Timer**     | **240 sec** | Route is removed from routing table           |

✅ **Memory Trick:**
**30 — 180 — 180 — 240**

-------------------------------
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
--------------------------------
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

# 🎯 Interview-Level Key Differences

These are often asked verbally:

* **RIP** → Simple but **slow**
* **OSPF** → Structured and **scalable**
* **EIGRP** → Fast and **efficient**
* **OSPF uses Areas**
* **EIGRP supports Unequal Load Balancing**
* **RIP limited to 15 hops**