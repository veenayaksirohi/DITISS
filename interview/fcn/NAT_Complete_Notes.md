# 📡 Module 6: NAT (Network Address Translation) — Complete Notes

---

## 6.1 What is NAT?

**Network Address Translation (NAT)** is the process where a network device — usually a **router or firewall** — translates a **private IP address** into a **public IP address** (and vice versa) as traffic crosses the boundary between a private network and the outside network (typically the Internet).

* NAT is typically performed on a **border router/firewall** sitting between the inside (private) network and the outside (public) network.
* Assigns a **public address** to a computer (or group of computers) inside a private network.

---

## 6.2 Why NAT is Used — IPv4 Exhaustion

* IPv4 has only **~4.3 billion** addresses total — nowhere near enough for every device on Earth to have a unique public IP.
* NAT was introduced as a **short-term fix** to slow down the exhaustion of public IPv4 addresses (long-term fix = IPv6).

### 🔹 Main Reasons NAT is Used

| Reason                       | Explanation                                                                 |
| -------------------------------- | --------------------------------------------------------------------------------- |
| **IPv4 Address Conservation**    | Limits the number of public IPs an organization must purchase/use                   |
| **Economy**                      | Public IPs cost money (leased from ISP); NAT lets many private hosts share few public IPs |
| **Security**                     | Hides internal IP addressing scheme from the outside world (internal topology not exposed) |
| **Flexibility**                  | Internal network can be renumbered/restructured without affecting external-facing addresses |
| **Multihoming/ISP independence** | Internal addressing doesn't need to change even if ISP or public IP changes           |

📌 **Exam Trap:** NAT is fundamentally an **IPv4 exhaustion workaround** — it does NOT eliminate the need for public IPs, it just drastically **reduces how many are needed**.

---

## 6.3 Private IP Address Ranges (RFC 1918)

These ranges are **reserved for private/internal use only** — they are **not routable on the public Internet**. Any device using these must go through NAT to reach the internet.

| Class     | Private IP Range                    | Total Addresses      | CIDR              |
| ----------- | --------------------------------------- | ------------------------ | ---------------------- |
| **Class A** | **10.0.0.0 – 10.255.255.255**            | ~16.7 million             | `10.0.0.0/8`             |
| **Class B** | **172.16.0.0 – 172.31.255.255**          | ~1 million                | `172.16.0.0/12`          |
| **Class C** | **192.168.0.0 – 192.168.255.255**        | 65,536                    | `192.168.0.0/16`         |

✅ **Memory Trick:** **10.x.x.x → 172.16.x–172.31.x → 192.168.x.x**
(Class A = biggest range for large enterprises; Class C = smallest, most common in homes/small offices)

📌 **Exam Trap:** Common mistake — thinking **all** of `172.x.x.x` is private. Only **172.16.0.0 to 172.31.255.255** is private; e.g., `172.32.0.0` is a **public** address.

### 🔹 Other Special/Reserved Ranges (Bonus)

| Range                  | Purpose                            |
| ------------------------- | --------------------------------------- |
| `127.0.0.0/8`               | Loopback (localhost)                      |
| `169.254.0.0/16`            | APIPA (Automatic Private IP Addressing)    |

---

## 6.4 NAT Addressing Terminology (Very Important)

NAT uses **4 specific address terms**, based on the combination of **Inside/Outside** and **Local/Global**:

| Term                | Meaning                                                                                                    |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- |
| **Inside Local**       | The actual **private IP address** assigned to a host inside the enterprise network (the "real" internal address) |
| **Inside Global**      | The **public/translated IP address** that represents an inside host to the outside network (what the internet sees) |
| **Outside Global**     | The actual **real public IP address** of a host that resides outside the enterprise (e.g., a web server on the internet) |
| **Outside Local**      | The address used to represent an **outside host** as seen from **inside** the private network (rarely different from Outside Global unless doing NAT on both sides) |

### 🔹 Simple Way to Remember

* **"Inside"** = belongs to your private network
* **"Outside"** = belongs to the internet/external network
* **"Local"** = how the address appears **inside** the private network
* **"Global"** = how the address appears **outside**, on the public network

**Direction of Translation:**
* **Inside → Outside:** Source IP changes from **Inside Local → Inside Global**
* **Outside → Inside:** Destination IP changes from **Inside Global → Inside Local**

✅ **Memory Trick:**
**Inside Local** = "my real private IP"
**Inside Global** = "how I look to the outside world"
**Outside Global** = "the real IP of the outside server"
**Outside Local** = "how the outside server looks to me" (usually same as Outside Global unless double NAT)

---

## 6.5 NAT Table Concept

The **NAT Table** (also called the **NAT Translation Table**) is a table maintained by the NAT router/firewall that keeps track of the **mappings between inside local and inside global addresses** (and ports, in PAT).

### 🔹 What the NAT Table Stores

* Inside Local IP (+ port, for PAT)
* Inside Global IP (+ port, for PAT)
* Outside Global IP (+ port, if applicable)
* Protocol (TCP/UDP)
* Idle timer (how long the entry stays before being removed if unused)

### 🔹 Example NAT Table (PAT/Overload)

| Inside Local           | Inside Global              | Outside Global      | Protocol |
| ------------------------- | ------------------------------ | ------------------------ | ---------- |
| 192.168.1.10:5001           | 203.0.113.5:10001                | 8.8.8.8:80                 | TCP        |
| 192.168.1.11:5002           | 203.0.113.5:10002                | 142.250.1.1:443             | TCP        |
| 192.168.1.12:5003           | 203.0.113.5:10003                | 93.184.216.34:80            | TCP        |

* When a return packet arrives at the router, it checks the NAT table to see **which inside host** the packet belongs to, based on the **destination port**, and forwards it accordingly.
* **Static NAT** entries → **permanent** in the table (manually configured, never age out).
* **Dynamic NAT / PAT** entries → **temporary**, stay in the table only as long as traffic flows; removed after an **idle timeout**.

---

## 6.6 Types of NAT

There are **4 main types**:

1. **Static NAT**
2. **Dynamic NAT**
3. **PAT (Port Address Translation) / NAT Overload**
4. **NAT64** (IPv6 ↔ IPv4 transition mechanism)

### 🔹 Quick Comparison Table

| Type                     | Mapping                | Public IPs Used         | Use Case                                  |
| --------------------------- | --------------------------- | ---------------------------- | ------------------------------------------- |
| **Static NAT**               | 1-to-1, permanent             | One public IP per private IP  | Server that must be reachable from outside     |
| **Dynamic NAT**               | Many-to-many (pool)            | Pool of public IPs             | Multiple hosts; pool can run out               |
| **PAT / NAT Overload**        | Many-to-1 (using ports)         | One public IP, many ports       | Homes, businesses (**most common** NAT type)     |
| **NAT64**                     | IPv6 ↔ IPv4                     | NAT64 prefix                    | IPv4-to-IPv6 migration/transition               |

---

## 6.7 Static NAT

* Defines a **one-to-one, permanent mapping** between one private (inside local) IP and one public (inside global) IP.
* Mapping includes **destination IP translation** in one direction and **source IP translation** in the reverse direction.
* **Manually configured** — does NOT age out or change automatically.
* **A public IP address must be allocated for every single private IP** that needs static NAT — no address pools involved.
* Allows connections to be **originated from either side** (inside → outside OR outside → inside) — this is important because it's the only NAT type that reliably supports **inbound connections initiated from the internet**.

### 🔹 Static NAT Diagram

```
  Static NAT:
  Inside: 192.168.1.10 ──→ Router ──→ Outside: 203.0.113.5
```

### 🔹 Use Case

* **Servers that must be reachable from the internet** — e.g., a web server, mail server, or any host that external users need to initiate connections to.

✅ **Exam Trap:** Static NAT does **NOT conserve IP addresses** — it's still 1-to-1 — its purpose is **reachability/accessibility**, not conservation.

---

## 6.8 Dynamic NAT

* Also creates a **one-to-one mapping** between inside local and inside global addresses, BUT the mapping is chosen **dynamically** from a **pool of available public IPs**, rather than being manually fixed.
* Router defines:
  * A **pool of possible inside global (public) addresses**
  * **Criteria** (via ACL) for which inside local addresses should be translated
* The dynamic entry stays in the NAT table **only as long as traffic is flowing occasionally** — it **ages out** after a period of inactivity.

### 🔹 Dynamic NAT Diagram

```
  Dynamic NAT:
  192.168.1.10 ──→ 203.0.113.5  ┐
  192.168.1.11 ──→ 203.0.113.6  ├── NAT Pool
  192.168.1.12 ──→ 203.0.113.7  ┘
```

### 🔹 Key Limitation

* If the **number of inside hosts needing translation exceeds the pool size**, some hosts will **fail to get a public IP** and be unable to reach the internet until an address frees up.

✅ **Exam Trap:** Dynamic NAT is still **1-to-1 at any given moment** — it just **automates address assignment** from a pool. It does NOT let multiple hosts share ONE IP simultaneously (that's PAT).

---

## 6.9 PAT (Port Address Translation) / NAT Overload

* Also called **NAT Overloading** or **NAPT (Network Address Port Translation)**.
* A modified form of Dynamic NAT where the **number of inside local addresses is greater than the number of inside global addresses**.
* Typically, **just ONE single public IP** provides internet access for **ALL inside hosts**.
* Distinguishes between multiple internal hosts sharing the same public IP by using **different source port numbers** for each translated connection.
* **The only NAT type that actually conserves IP addresses** — because many private hosts share just one public IP.
* **Most popular/common form of NAT** used today (homes, small businesses, most SOHO routers).

### 🔹 PAT Diagram

```
  PAT (NAT Overload):
  192.168.1.10 ──→ 203.0.113.5 : 10001  ┐
  192.168.1.11 ──→ 203.0.113.5 : 10002  ├── Same public IP, different ports
  192.168.1.12 ──→ 203.0.113.5 : 10003  ┘
```

### 🔹 Why PAT Works

* TCP/UDP has **65,536 possible port numbers** per IP address.
* By mapping each internal host's connection to a **unique port** on the single shared public IP, the router can track and correctly route return traffic back to the right internal host.

✅ **Exam Trap:** PAT = **Many-to-One** using **ports** to differentiate; this is what makes home routers work with just 1 public IP for an entire household of devices.

---

## 6.10 NAT Types — Full Side-by-Side Comparison

| Parameter               | Static NAT           | Dynamic NAT              | PAT / NAT Overload            |
| --------------------------- | ------------------------ | ----------------------------- | ---------------------------------- |
| Mapping Type                 | 1-to-1 (fixed)             | 1-to-1 (from pool)               | Many-to-1 (via ports)                |
| Public IP Requirement         | 1 per private IP             | Pool of public IPs                | Just 1 public IP (typically)          |
| Conserves IP Addresses?       | ❌ No                        | ⚠️ Partially                      | ✅ Yes (best conservation)              |
| Connection Origination        | Either direction              | Inside → Outside only              | Inside → Outside only                   |
| Table Entry                   | Permanent                     | Temporary (ages out)                | Temporary (ages out)                     |
| Common Use Case               | Public-facing servers          | Medium orgs with IP pool             | Homes, small/large businesses             |
| Popularity                    | Less common                    | Less common today                    | **Most widely used**                       |

---

## 6.11 NAT64

**NAT64** allows **IPv6-only hosts** to communicate with **IPv4-only servers**, by translating between IPv6 and IPv4 addresses at the network boundary. Works **alongside DNS64**.

### 🔹 How NAT64 Works (Step-by-Step)

1. An **IPv6-only host** queries **DNS64** for an IPv4-only domain (e.g., `example.com`).
2. DNS64 finds **only an IPv4 A record** (e.g., `93.184.216.34`). Since no AAAA (IPv6) record exists, DNS64 **synthesizes** one by embedding the IPv4 address into the **NAT64 prefix** (`64:ff9b::/96`):
   * Synthesized AAAA: `64:ff9b::5db8:d822`
3. The host sends an **IPv6 packet** to `64:ff9b::5db8:d822`.
4. The **NAT64 gateway** intercepts the packet, **extracts the embedded IPv4 destination** (`93.184.216.34`), translates **IPv6 → IPv4**, and forwards it to the real IPv4 server.
5. The **IPv4 server replies** → the NAT64 gateway translates **IPv4 → IPv6** → sends the reply back to the original IPv6 host.

### 🔹 NAT64 Flow Diagram

```
  IPv6 Host          NAT64 Gateway            IPv4 Server
  (2001:db8::1)      (64:ff9b::/96)         (93.184.216.34)
       │                    │                      │
       │── IPv6 packet ────→│                      │
       │  Dst: 64:ff9b::    │── IPv4 packet ──────→│
       │       5db8:d822    │  Dst: 93.184.216.34  │
       │                    │                      │
       │                    │←─ IPv4 reply ─────── │
       │←─ IPv6 reply ──────│                      │
       │  Src: 64:ff9b::    │                      │
       │       5db8:d822    │                      │
```

### 🔹 NAT64 vs Traditional NAT

| Feature            | Traditional NAT                 | NAT64                             |
| --------------------- | ------------------------------------ | -------------------------------------- |
| Translates             | Private IPv4 ↔ Public IPv4              | IPv6 ↔ IPv4                              |
| Purpose                | Address conservation                    | **Protocol transition**                    |
| Needs DNS?              | ❌ No                                    | ✅ Yes (**DNS64** required)                 |
| Direction               | IPv4 client → IPv4 server                | IPv6 client → IPv4 server                    |
| Use Case                | Home/office internet sharing              | IPv4-to-IPv6 migration                        |

### 🔹 NAT64 Key Terms

| Term                  | Meaning                                                              |
| ------------------------- | -------------------------------------------------------------------------- |
| **NAT64**                  | Translates between IPv6 and IPv4                                             |
| **DNS64**                  | Synthesizes AAAA records from existing IPv4 A records                          |
| **NAT64 Prefix**           | `64:ff9b::/96` — the last 32 bits of this prefix hold the embedded IPv4 address |
| **Stateful NAT64**          | **Many-to-one** mapping (like PAT) — many IPv6 hosts share one IPv4 address     |
| **Stateless NAT64**         | **One-to-one** mapping — requires a dedicated block of IPv4 addresses            |

✅ **Exam Trap:** NAT64 is fundamentally different in **purpose** from traditional NAT — traditional NAT conserves addresses **within the same protocol (IPv4↔IPv4)**; NAT64 exists purely to let **two different protocol versions (v6 and v4) talk to each other** during the IPv6 migration period.

---

## ⭐ Quick Revision — NAT Module

* **NAT** = translates private ↔ public IPs at the network boundary (router/firewall)
* **Why:** IPv4 exhaustion, address conservation, cost savings, hides internal topology (security)
* **Private ranges (RFC 1918):**
  * `10.0.0.0 – 10.255.255.255` (Class A)
  * `172.16.0.0 – 172.31.255.255` (Class B)
  * `192.168.0.0 – 192.168.255.255` (Class C)
* **4 Address Terms:** Inside Local (real private IP) / Inside Global (translated public IP) / Outside Global (real public IP of external host) / Outside Local (how external host looks from inside)
* **NAT Table:** tracks Local↔Global mappings (+ports for PAT); static = permanent, dynamic/PAT = ages out
* **Static NAT:** 1-to-1, permanent, manual, allows inbound connections — used for public-facing servers
* **Dynamic NAT:** 1-to-1 from a pool, automatic, pool can exhaust
* **PAT/Overload:** Many-to-1 using **ports**, only NAT type that truly **conserves IPs**, most common
* **NAT64:** IPv6 ↔ IPv4 translation for protocol transition, requires DNS64, prefix `64:ff9b::/96`

---

## 🎯 Most Likely Exam/Viva Questions

* Why was NAT introduced? → **IPv4 address exhaustion**
* Name the 3 private IP ranges → 10.x / 172.16–172.31.x / 192.168.x
* Difference between Inside Local and Inside Global? → Real private IP vs how it appears externally (translated)
* Which NAT type allows inbound connections from the internet? → **Static NAT**
* Which NAT type conserves the most IP addresses? → **PAT / NAT Overload**
* What differentiates hosts sharing the same public IP in PAT? → **Port numbers**
* What happens to a Dynamic NAT/PAT entry when traffic stops? → It **ages out / times out** from the NAT table
* What is NAT64 used for? → Allowing **IPv6-only hosts** to reach **IPv4-only servers**
* What is the NAT64 prefix? → `64:ff9b::/96`
* Difference between Stateful and Stateless NAT64? → Many-to-1 (like PAT) vs strict 1-to-1
