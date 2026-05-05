In **FCN (Fundamentals of Computer Networks)**, NAT configuration is usually taught using **Cisco IOS commands**. Below are the standard configurations for each type of NAT with clear examples.

---

```
Quick Memory Trick (Exam Hack)
inside = private network
outside = internet
ACL = who gets NAT
pool = available public IPs
overload = many → one (PAT)
```

# ⚙️ 1. Static NAT Configuration (Cisco)

**Scenario:**

* Private IP: `192.168.1.10`
* Public IP: `200.1.1.10`

### 🔧 Commands

```bash
Router(config)# interface gig0/0
Router(config-if)# ip address 192.168.1.1 255.255.255.0
Router(config-if)# ip nat inside

Router(config)# interface gig0/1
Router(config-if)# ip address 200.1.1.1 255.255.255.0
Router(config-if)# ip nat outside

Router(config)# ip nat inside source static 192.168.1.10 200.1.1.10
```

---

# ⚙️ 2. Dynamic NAT Configuration

**Scenario:**

* Private network: `192.168.1.0/24`
* Public pool: `200.1.1.10 – 200.1.1.20`

### 🔧 Commands

```bash
Router(config)# access-list 1 permit 192.168.1.0 0.0.0.255

Router(config)# ip nat pool NAT_POOL 200.1.1.10 200.1.1.20 netmask 255.255.255.0

Router(config)# ip nat inside source list 1 pool NAT_POOL

Router(config)# interface gig0/0
Router(config-if)# ip nat inside

Router(config)# interface gig0/1
Router(config-if)# ip nat outside
```

---

# ⚙️ 3. PAT (NAT Overload) Configuration

**Scenario:**

* Many private IPs use one public IP

### 🔧 Commands

```bash
Router(config)# access-list 1 permit 192.168.1.0 0.0.0.255

Router(config)# interface gig0/1
Router(config-if)# ip address 200.1.1.1 255.255.255.0
Router(config-if)# ip nat outside

Router(config)# interface gig0/0
Router(config-if)# ip address 192.168.1.1 255.255.255.0
Router(config-if)# ip nat inside

Router(config)# ip nat inside source list 1 interface gig0/1 overload
```

---

# ⚙️ 4. Port Forwarding Configuration

**Scenario:**

* Public port 80 → Internal web server `192.168.1.10`

### 🔧 Commands

```bash
Router(config)# ip nat inside source static tcp 192.168.1.10 80 200.1.1.1 80
```

---

# 🔍 Verification Commands

After configuration, check NAT status:

```bash
Router# show ip nat translations
Router# show ip nat statistics
Router# show running-config
```

---

# 🧠 Key Points (Exam Tips)

* Always define:

  * `ip nat inside`
  * `ip nat outside`
* Use **ACL** to identify internal traffic.
* PAT uses `overload` keyword.
* Static NAT does NOT need ACL.

---


