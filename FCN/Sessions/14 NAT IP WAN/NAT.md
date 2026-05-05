Here’s a **short, clean version** of your notes without losing anything important:

---

# 📘 NAT (Network Address Translation)

**Definition:**
Technique that maps **private IP → public IP** so local devices can access the internet.
Performed on a **router**.

**Flow:**

* Outgoing: `private IP → public IP`
* Incoming: `public IP → correct private IP` (via NAT table)

**Example:**

```
192.168.1.10 → Router → 49.207.45.12 → Internet
Internet → 49.207.45.12 → Router → 192.168.1.10
```

---

# 🔧 Types of NAT

## 1. Static NAT (1:1)

* Fixed mapping
* `192.168.1.5 ↔ 203.0.113.5`
* **Use:** Hosting servers

## 2. Dynamic NAT (Many:Many)

* Uses public IP pool
* Temporary mapping
* **Use:** Organizations with limited IPs

## 3. PAT / NAT Overload (Many:1)

* One public IP + different ports
* Example:

  ```
  192.168.1.10:1025 → 49.207.45.12:3001
  ```
* **Use:** Home routers (most common)

## 4. Port Forwarding

* Maps specific port → private IP
* Example:

  ```
  49.207.45.12:80 → 192.168.1.5:80
  ```
* **Use:** Web/game servers

---

# 🧠 Summary

| Type            | Mapping    | Use              |
| --------------- | ---------- | ---------------- |
| Static          | 1:1        | Servers          |
| Dynamic         | Many:Many  | Enterprises      |
| PAT             | Many:1     | Home networks    |
| Port Forwarding | Port-based | Hosting services |

---

