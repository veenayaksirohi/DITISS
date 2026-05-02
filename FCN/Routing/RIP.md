
---

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

Very commonly asked in exams.

---

# 📡 RIP Other Important Information (From Your Notes + Standard Exam Points)

## 🔹 RIP Basics

* **Full Form:** Routing Information Protocol
* **Type:** Distance Vector Routing Protocol
* **Metric Used:** **Hop Count**
* **Maximum Hop Count:** **15**
* **16 Hop Count:** **Unreachable**

📌 From your notes:

* If hop count reaches **16 → Packet discarded**
* **TTL exceeded → ICMP message sent**
---

## 🔹 RIP Loop Prevention Methods (From Your Notes)

Used to **prevent routing loops**.

### Methods:

1. **Hop Count Limit**

   * Max hops = **15**
   * **16 = Unreachable**

2. **Split Horizon**

   * Do not advertise route back to the same interface.

3. **Hold-down Timer**

   * Prevents incorrect route updates.

4. **Triggered Updates**

   * Send update immediately when route changes.


---

## 🔹 RIP Versions

| Version    | Name      | Features               |
| ---------- | --------- | ---------------------- |
| **RIP v1** | Classful  | No subnet mask support |
| **RIP v2** | Classless | Supports VLSM, CIDR    |
| **RIPng**  | IPv6      | Used for IPv6 routing  |

---

## 🔹 RIP Administrative Details

| Parameter                        | Value                                 |
| -------------------------------- | ------------------------------------- |
| **Administrative Distance (AD)** | **120**                               |
| **Transport Protocol**           | UDP                                   |
| **Port Number**                  | **520**                               |
| **Update Type**                  | Broadcast (RIPv1) / Multicast (RIPv2) |
| **Multicast Address (RIPv2)**    | **224.0.0.9**                         |

---

## 🔹 RIP Timers — Ultra Short Revision

**Update → 30 sec**
**Invalid → 180 sec**
**Hold-down → 180 sec**
**Flush → 240 sec**

---

## 🔹 Very Important Exam Notes ⭐

These are commonly asked:

* RIP is **Distance Vector Protocol**
* Uses **Bellman-Ford Algorithm**
* Metric = **Hop Count**
* **Max hops = 15**
* **AD = 120**
* **UDP Port = 520**
* Sends updates every **30 sec**

---

If you want, I can next create:

* 📄 **Ultra-Short RIP Revision Sheet (1 page)**
* 📊 **RIP vs OSPF vs EIGRP comparison**
* 🧠 **Memory tricks for routing protocols**

These are very useful for **networking exams and interviews**.
