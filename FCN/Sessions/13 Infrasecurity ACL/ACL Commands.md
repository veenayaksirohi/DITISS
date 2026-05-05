# Acl Commands

Got it — I’ll keep your structure and **add clear meaning for each command**, so you can understand *what each line actually does* (this is what examiners often test).

---

# 🔹 1) Standard ACL Commands

(For **Standard ACL**)

### ✅ Create (Numbered)

```
access-list 1 permit 192.168.1.0 0.0.0.255
access-list 1 deny any
```

👉 **Meaning:**

* `access-list 1` → Using Standard ACL number (1–99)
* `permit 192.168.1.0 0.0.0.255` → Allow all hosts in this network
* `0.0.0.255` → Wildcard mask (means /24 network)
* `deny any` → Block all other traffic

---

### ✅ Apply to Interface

```
interface g0/0
 ip access-group 1 in
```

👉 **Meaning:**

* `interface g0/0` → Select interface
* `ip access-group 1 in` → Apply ACL 1 to incoming traffic

---

### ✅ Named Standard ACL

```
ip access-list standard ALLOW_LAN
 permit 192.168.1.0 0.0.0.255
 deny any
```

👉 **Meaning:**

* `ip access-list standard ALLOW_LAN` → Create named ACL
* Easier to identify than numbers
* Rules same as numbered ACL

---

# 🔹 2) Extended ACL Commands

(For **Extended ACL**)

### ✅ Create (Numbered)

```
access-list 100 permit tcp 192.168.1.0 0.0.0.255 any eq 80
access-list 100 deny ip any any
```

👉 **Meaning:**

* `100` → Extended ACL range
* `permit tcp` → Allow TCP traffic
* `192.168.1.0 0.0.0.255` → Source network
* `any` → Destination (anywhere)
* `eq 80` → Only HTTP traffic
* `deny ip any any` → Block everything else

---

### ✅ Apply

```
interface g0/1
 ip access-group 100 in
```

👉 **Meaning:**

* Apply ACL 100 to incoming traffic on interface

---

### ✅ Named Extended ACL

```
ip access-list extended WEB_FILTER
 permit tcp 192.168.1.0 0.0.0.255 any eq 80
 deny ip any any
```

👉 **Meaning:**

* Named ACL with full filtering (IP + protocol + port)

---

# 🔹 3) Dynamic ACL (Lock-and-Key)

```
access-list 101 permit tcp any host 192.168.1.10 eq 23

line vty 0 4
 login local
 autocommand access-enable host timeout 10
```

👉 **Meaning:**

* `access-list 101 permit tcp any host 192.168.1.10 eq 23`
  → Allow Telnet access to server (after authentication)

* `line vty 0 4` → Configure remote login lines

* `login local` → Use local username/password

* `autocommand access-enable` → Enable dynamic ACL after login

* `timeout 10` → Access allowed for 10 minutes

👉 🔑 **Concept:** User must log in first → then ACL opens temporarily

---

# 🔹 4) Reflexive ACL

```
ip access-list extended OUTBOUND
 permit tcp any any reflect MY_TRAFFIC
 permit udp any any reflect MY_TRAFFIC

ip access-list extended INBOUND
 evaluate MY_TRAFFIC
 deny ip any any
```

👉 **Meaning:**

* `reflect MY_TRAFFIC` → Track outgoing sessions
* `evaluate MY_TRAFFIC` → Allow only return traffic
* `deny ip any any` → Block all other incoming traffic

👉 🔁 **Concept:** Only responses to outgoing traffic are allowed back

---

### ✅ Apply

```
interface g0/0
 ip access-group OUTBOUND out
 ip access-group INBOUND in
```

👉 **Meaning:**

* OUTBOUND → applied on outgoing traffic
* INBOUND → controls incoming replies

---

# 🔹 5) Time-Based ACL

### ✅ Define Time

```
time-range OFFICE_HOURS
 periodic weekdays 9:00 to 17:00
```

👉 **Meaning:**

* Create time condition
* Active only Monday–Friday, 9 AM–5 PM

---

### ✅ ACL with Time

```
ip access-list extended BLOCK_SOCIAL
 deny tcp any any eq 80 time-range OFFICE_HOURS
 permit ip any any
```

👉 **Meaning:**

* Block HTTP traffic **only during office hours**
* Allow all other traffic

---

# 🔹 6) IPv6 ACL

```
ipv6 access-list IPV6_FILTER
 permit tcp any any eq 80
 deny ipv6 any any
```

👉 **Meaning:**

* IPv6 ACL definition
* Allow HTTP traffic
* Block everything else

---

### ✅ Apply

```
interface g0/0
 ipv6 traffic-filter IPV6_FILTER in
```

👉 **Meaning:**

* Apply IPv6 ACL to incoming traffic

---

# 🔹 7) Verification Commands

```
show access-lists
show ip access-lists
show running-config
```

👉 **Meaning:**

* `show access-lists` → Display all ACLs
* `show ip access-lists` → Show IPv4 ACLs
* `show running-config` → View full config

---

# 🔴 Important Logic (VERY IMPORTANT)

```
deny ip any any
```

👉 **Meaning:**

* Hidden rule at end of every ACL
* If no match → traffic is blocked

---

# 🧠 Final Understanding

* **Standard ACL** → Who (source only)
* **Extended ACL** → Who + Where + What
* **Dynamic ACL** → Login → Access
* **Reflexive ACL** → Request → Response only
* **Time-Based ACL** → Time controls access

