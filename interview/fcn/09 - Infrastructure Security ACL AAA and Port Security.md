---
title: "09 - Infrastructure Security ACL AAA and Port Security"
aliases:
  - "Port Security AAA and ACLs"
  - "Port Security, AAA & Access Control Lists (ACLs)"
  - "Port Security AAA ACL Notes"
tags:
  - computer-networks
  - port-security
  - aaa
  - access-control-lists
syllabus-topic:
  - 9
---

# Port Security, AAA & Access Control Lists (ACLs)

## Table of Contents

- [[#0. Full Forms / Abbreviations]]
- [[#0.1 Topics Covered in These Notes]]
- [[#PART A — Port Security]]
- [[#1. What Is Port Security?]]
- [[#2. Violation Modes]]
- [[#3. MAC Address Learning / Types of MAC Address Entries]]
- [[#4. Aging Timers]]
- [[#5. Port Security — Full Example Diagram]]
- [[#PART B — AAA Framework (Authentication, Authorization, Accounting)]]
- [[#6. What Is AAA?]]
- [[#7. RADIUS]]
- [[#8. TACACS+]]
- [[#9. RADIUS vs TACACS+]]
- [[#PART C — Access Control Lists (ACLs)]]
- [[#10. ACL Types]]
- [[#11. Quick Revision — Key Facts]]
- [[#Related Notes]]

---

## 0. Full Forms / Abbreviations

| Abbreviation | Full Form |
|---------------|-----------|
| **AAA** | Authentication, Authorization, Accounting |
| **RADIUS** | Remote Authentication Dial-In User Service |
| **TACACS+** | Terminal Access Controller Access-Control System Plus |
| **ACL** | Access Control List |
| **MAC** | Media Access Control (address) |
| **UDP** | User Datagram Protocol |
| **TCP** | Transmission Control Protocol |
| **VPN** | Virtual Private Network |
| **ISP** | Internet Service Provider |

---

## 0.1 Topics Covered in These Notes

| Topic | Covered In |
|-------|-------------|
| Standard ACL vs Extended ACL (numbered and named) | §10 |
| ACL placement — Standard close to destination, Extended close to source | §10.1 |
| Port Security — violation modes: Protect, Restrict, Shutdown | §2 |
| MAC Address Learning — Static, Dynamic, and why Sticky MAC is needed (with use case) | §3 |
| AAA — Authentication, Authorization, Accounting | §6 |
| TACACS+ vs RADIUS — key differences | §9 |

---

## PART A — Port Security

## 1. What Is Port Security?

**Port security** limits *which* MAC addresses are allowed to send traffic through a switch **access port** — preventing unauthorized devices (rogue laptops, rogue switches, MAC-spoofing attacks) from connecting to the network.

```
 Normal port          : any device can plug in and send traffic
 Port-security enabled : only APPROVED MAC address(es) can send traffic
                          everything else = VIOLATION
```

---

## 2. Violation Modes

When a port-security violation occurs (an unapproved MAC tries to send traffic, or the max MAC count is exceeded), the switch reacts based on the configured **violation mode**:

| Mode | Action | Logs? | Port Stays Up? |
|------|--------|-------|------------------|
| **Protect** | Drops violating frames silently | ❌ No | ✅ Yes |
| **Restrict** | Drops frames + logs the event + increments violation counter | ✅ Yes | ✅ Yes |
| **Shutdown** | **Err-disables the port; stops all traffic on that port (not just the violating frame).** Needs to be **manually re-enabled** by the administrator | ✅ Yes | ❌ No |

> ⚠️ **Default on Cisco IOS = Shutdown.**
> If you don't explicitly specify a violation mode, the port will be **err-disabled** on the very first violation.

**Severity ranking (mildest → harshest):**
```
 Protect  <  Restrict  <  Shutdown
 (silent)    (logged)     (port goes down completely)
```

**Recovering a Shutdown (err-disabled) port:**
```
 A Shutdown-mode violation requires manual intervention:
   Router(config-if)# shutdown
   Router(config-if)# no shutdown
 (or configure err-disable auto-recovery)
```

---

## 3. MAC Address Learning / Types of MAC Address Entries

A switch needs to know **which MAC address is allowed on which port**. There are three ways this gets configured:

### 3.1 Static MAC

**Static = the administrator manually tells the switch** exactly which MAC address is allowed on a port.

```
 Switch(config-if)# switchport port-security mac-address aabb.cc00.0100
```

- You type the MAC address in yourself.
- It's saved in the running-config right away (and survives reload automatically, since it's a normal config line).
- Best for: a small number of known, fixed devices (e.g., a server that never changes NICs).

### 3.2 Dynamic MAC

**Dynamic = the switch learns it automatically.** You don't configure anything.

```
 Switch(config-if)# switchport port-security
 (no mac-address specified → switch learns whatever connects first, up to the max)
```

- The switch watches incoming frames and learns the source MAC on its own.
- **Downside:** this learned entry is **NOT saved** anywhere — it's lost the moment the switch reloads, meaning it has to re-learn from scratch (and briefly allow whatever connects next) after every reboot.

### 3.3 Why Is Sticky MAC Needed?

Static and Dynamic each have a real drawback:

| Problem | Static MAC | Dynamic MAC |
|---------|-------------|----------------|
| Manual effort | ❌ You must type in every MAC address by hand — painful on a switch with dozens/hundreds of ports | ✅ No manual effort |
| Survives reload | ✅ Yes | ❌ No — has to re-learn after every reboot |

**Sticky MAC exists to get the best of both:** it **learns automatically** like Dynamic MAC (no manual typing), but **writes the learned MAC into the running-config** like Static MAC (so it can persist across reloads) — **provided** you save the config with `write memory`.

```
 Static  : ✅ persists     ❌ manual effort
 Dynamic : ✅ no effort    ❌ lost on reload
 Sticky  : ✅ no effort    ✅ persists (IF you save config)
           = "best of both worlds"
```

### 3.4 Sticky MAC — Use Case Scenario

**Scenario:** You're securing 40 access ports in an office, each connected to a known employee laptop that rarely changes. You want port security enabled, but typing 40 MAC addresses by hand is slow and error-prone, and you also don't want the switch to have to blindly re-learn (and briefly trust) a new device every time it reboots.

```
 Step 1: Enable sticky learning on each port:
   Switch(config-if)# switchport port-security mac-address sticky

 Step 2: Employee laptop connects → switch DYNAMICALLY learns its MAC
         → automatically converts it into a STICKY entry in running-config

 Step 3: Admin runs:
   Switch# write memory
         → sticky entries are now saved to startup-config

 Result: After a reboot, the switch already "remembers" every laptop's MAC —
         no re-learning window, no manual typing of 40 addresses.
```

**Why this matters in practice:**
- Saves the admin from manually configuring every single MAC address (unlike pure Static).
- Avoids the reload-vulnerability window where a Dynamic-only port would have to re-learn (and briefly trust) a new device after every switch reboot.
- Ideal for environments where devices are relatively fixed (offices, server rooms) but the sheer number of ports makes manual static configuration impractical.

### 3.5 Summary Table

| Type | How It's Learned | Survives Reload? |
|------|--------------------|---------------------|
| **Static MAC** | Manually configured by the admin | ✅ Yes, automatically |
| **Dynamic MAC** | Learned automatically from incoming traffic | ❌ No — lost on reload |
| **Sticky MAC** | Learned automatically (like dynamic) **but** automatically written into the running-config | ✅ Only if `write memory` (saved to startup-config) is run — otherwise lost on reload |

### 3.6 Sticky MAC — Step-by-Step Flow

```
  ┌──────────────────────┐   Frame (src: aabb.cc00.0100)   ┌────────────────────────────────┐
  │  PC (aabb.cc00.0100) │ ───────────────────────────────►│      Switch Port Fa0/1         │
  └──────────────────────┘                                  │                                │
                                                              │  ① Receives first frame        │
                                                              │  ② Learns MAC dynamically      │
                                                              │  ③ Sticky: saves to config ──► │
                                                              │     switchport port-security   │
                                                              │      mac-address sticky        │
                                                              │      aabb.cc00.0100            │
                                                              │  ④a write memory → survives ✅  │
                                                              │  ④b no write → lost on reload ❌│
                                                              └────────────────────────────────┘
```

**Key takeaway:** Sticky MAC gives you the *convenience* of dynamic learning with the *persistence* of static configuration — but only if you remember to save the config.

---

## 4. Aging Timers

Aging timers control **how long** a dynamically learned secure MAC address stays bound to a port. **By default, secure MACs never age out.**

| Type | Behaviour |
|------|-----------|
| **Absolute** | Timer starts the moment the MAC is learned; the MAC is removed when the timer expires — **even if the device is still actively sending traffic** |
| **Inactivity** | Timer **resets on every frame** received from that MAC; the MAC is only removed after a period of **no traffic** (idle time) |

> ℹ️ **Static MACs never age out.** Only **dynamic** and **sticky** MACs are subject to aging timers.

```
 Absolute timer  :  |---timer running---|  → MAC removed at expiry, REGARDLESS of activity
 Inactivity timer:  frame...frame...frame...[idle gap = timer]→ MAC removed only after idle period
```

---

## 5. Port Security — Full Example Diagram

```
            +--------------------------------------------------+
            |            Switch Access Port Fa0/1               |
            |  max: 2 | sticky | aging: 10 min inactivity        |
            +--------------------------------------------------+
                                |
  +------------------+         |     ✅ MAC-A → Allowed (sticky learned)
  |  PC (MAC-A)       |──────→ |     ✅ MAC-B → Allowed (sticky learned)
  +------------------+         |
                                |
  +------------------+         |     ❌ MAC-C → VIOLATION (max of 2 already reached)
  |  PC (MAC-C)       |──────→ |        Restrict mode → drop + log, port stays up
  +------------------+         |        Shutdown mode → port err-disabled
```

**Reading this example:**
- Port Fa0/1 is configured for a **max of 2** MAC addresses, using **sticky** learning, with a **10-minute inactivity** aging timer.
- MAC-A and MAC-B are learned first and allowed (sticky-learned, within the max of 2).
- MAC-C attempts to connect — but the port has already reached its max of 2 allowed MACs → **violation**.
- What happens next depends on the configured **violation mode** (§2): silently dropped (Protect), dropped+logged (Restrict), or the whole port goes down (Shutdown).

---

## PART B — AAA Framework (Authentication, Authorization, Accounting)

## 6. What Is AAA?

| Function | Question Answered | Examples |
|----------|---------------------|----------|
| **Authentication** | "**Who are you?**" | Username/password, certificates, tokens |
| **Authorization** | "**What can you do?**" | Exec-privilege level, which commands are allowed |
| **Accounting** | "**What did you do?**" | Session logs, command history, session duration |

```
 AAA Flow:
   1. Authentication → prove identity (login)
   2. Authorization   → determine permitted actions
   3. Accounting       → record what was actually done
```

AAA is implemented using one of two main protocols: **RADIUS** or **TACACS+**.

---

## 7. RADIUS

**RADIUS** = Remote Authentication Dial-In User Service. An **open standard**, client-server AAA protocol.

- **Transport:** UDP
- **Ports:** `1812` (Authentication) and `1813` (Accounting)
- **Key trait:** Authentication + Authorization are **combined** into a single exchange (not separated)

```
  ┌──────────────────────┐   Access-Request (UDP 1812)     ┌──────────────────────┐
  │   Network Device      │ ───────────────────────────────►│    RADIUS Server      │
  │  (Switch / Router)    │                                  │                      │
  │                        │ ◄── Access-Accept / Reject ─────│  Auth + Authz         │
  │  User logs in ────────►│    (combined in one exchange)   │  combined in one      │
  │                        │                                  │  response             │
  │                        │ ──── Accounting (UDP 1813) ─────►│                      │
  └──────────────────────┘                                  └──────────────────────┘
```

**Common use cases:** Wireless authentication, VPN access, ISP subscriber authentication.

---

## 8. TACACS+

**TACACS+** = Terminal Access Controller Access-Control System Plus. A **Cisco-enhanced/proprietary** AAA protocol.

- **Transport:** TCP
- **Port:** `49`
- **Key trait:** Authentication, Authorization, and Accounting are **fully separated** into three independent exchanges — enabling **per-command authorization**

```
  ┌──────────────────────┐  ① Auth Req (TCP 49)    ┌──────────────────────┐
  │   Network Device      │ ─────────────────────► │   TACACS+ Server      │
  │  (Router / Switch)    │ ◄──── Auth Response ────│                      │
  │                        │                          │  ① Authentication    │
  │                        │ ──② Authorization ─────►│  ② Authorization     │
  │                        │ ◄── Authz (per-cmd) ────│  ③ Accounting        │
  │                        │                          │  (all 3 separate)    │
  │                        │ ──③ Accounting ─────────►│  Entire pkt encrypted│
  └──────────────────────┘                          └──────────────────────┘
```

**Common use case:** Device administration (Cisco environments) — e.g., controlling exactly which CLI commands a network admin is allowed to run.

---

## 9. RADIUS vs TACACS+

| Feature | RADIUS | TACACS+ |
|---------|--------|---------|
| **Standard** | Open (RFC 2865) | Cisco proprietary |
| **Transport** | UDP | TCP |
| **Ports** | 1812 / 1813 | 49 |
| **Separates A/A/A?** | ❌ No (Auth + Authz combined) | ✅ Yes (all three fully separate) |
| **Per-command authorization** | ❌ Limited | ✅ Full support |
| **Encrypts packet body?** | ❌ Password only | ✅ Entire packet |
| **Common use** | Wireless, VPN, ISP | Device administration (Cisco) |

**Exam one-liners:**
- RADIUS = UDP, open standard, combines Auth+Authz, encrypts only the password.
- TACACS+ = TCP, Cisco proprietary, fully separates AAA, encrypts the entire packet, supports per-command control.
- Choose **TACACS+** for fine-grained device-administration control; choose **RADIUS** for general network access (Wi-Fi, VPN, ISP).

---

## PART C — Access Control Lists (ACLs)

## 10. ACL Types

| Type | Filters By | Number Range | Placement |
|------|-------------|----------------|-----------|
| **Standard ACL** | Source IP only | 1–99, 1300–1999 | Close to the **destination** |
| **Extended ACL** | Source/Destination IP, protocol, port | 100–199, 2000–2699 | Close to the **source** |
| **Named ACL** | Same filtering as Standard/Extended, but identified by name instead of number | N/A | Same placement rules as its Standard/Extended equivalent |

### 10.1 ACL Configuration Commands

#### A. Standard ACL (Numbered) — filters by source IP only

```
Step 1 — Create the ACL:
  Router(config)# access-list 10 permit 192.168.1.0 0.0.0.255
  Router(config)# access-list 10 deny any

Step 2 — Apply it to an interface (close to the DESTINATION):
  Router(config)# interface g0/1
  Router(config-if)# ip access-group 10 out
```

| Part | Meaning |
|------|---------|
| `access-list 10` | ACL number 10 → falls in the Standard range (1–99) |
| `permit 192.168.1.0 0.0.0.255` | Allow traffic **sourced from** the 192.168.1.0/24 network (wildcard mask — see earlier notes) |
| `ip access-group 10 out` | Apply ACL 10 to traffic **leaving** this interface |

#### B. Extended ACL (Numbered) — filters by source/dest IP, protocol, port

```
Step 1 — Create the ACL:
  Router(config)# access-list 110 permit tcp 192.168.1.0 0.0.0.255 host 10.0.0.5 eq 80
  Router(config)# access-list 110 deny ip any any

Step 2 — Apply it to an interface (close to the SOURCE):
  Router(config)# interface g0/0
  Router(config-if)# ip access-group 110 in
```

| Part | Meaning |
|------|---------|
| `access-list 110` | ACL number 110 → falls in the Extended range (100–199) |
| `permit tcp 192.168.1.0 0.0.0.255 host 10.0.0.5 eq 80` | Allow TCP traffic from 192.168.1.0/24 **to** host 10.0.0.5, destination **port 80** only |
| `ip access-group 110 in` | Apply ACL 110 to traffic **entering** this interface |

#### C. Named ACL — same logic, human-readable name instead of a number

```
Standard Named ACL:
  Router(config)# ip access-list standard BLOCK-SALES
  Router(config-std-nacl)# deny 192.168.10.0 0.0.0.255
  Router(config-std-nacl)# permit any

Extended Named ACL:
  Router(config)# ip access-list extended ALLOW-WEB
  Router(config-ext-nacl)# permit tcp any host 10.0.0.5 eq 443
  Router(config-ext-nacl)# deny ip any any

Apply (same as numbered):
  Router(config-if)# ip access-group BLOCK-SALES in
  Router(config-if)# ip access-group ALLOW-WEB in
```

**Exam one-liners:**
- Standard ACL syntax: `access-list <1-99> {permit|deny} <source-ip> <wildcard-mask>`
- Extended ACL syntax: `access-list <100-199> {permit|deny} <protocol> <source> <destination> [eq port]`
- `ip access-group <ACL> {in|out}` binds the ACL to an interface, in a specific direction.
- Named ACLs use `ip access-list {standard|extended} <name>` instead of a number, then enter a sub-mode to add `permit`/`deny` lines.

### 10.2 Why Placement Matters

```
 Standard ACL (source IP only) → place NEAR the DESTINATION
   Reason: it can only match source IP, so placing it near the source
   would block traffic from reaching OTHER destinations it shouldn't affect.

 Extended ACL (full 5-tuple match) → place NEAR the SOURCE
   Reason: it can match precisely what it needs to block, so it's safe
   (and more efficient) to stop unwanted traffic as early as possible.
```

```
        [Source Host] ──── [R1] ──── [R2] ──── [Destination Host]
                             ▲                        ▲
                     Extended ACL here          Standard ACL here
                    (stop bad traffic early)   (only IP known, so
                                                 filter right before
                                                 destination)
```

### 10.3 Implicit Deny

> ⚠️ **Implicit Deny:** Every ACL ends with an **invisible `deny any`** statement. If a packet doesn't match **any** configured rule, it is **automatically dropped**.

```
 ACL processing order:
   Rule 1 → match? → apply action, STOP
   Rule 2 → match? → apply action, STOP
   ...
   Rule N → match? → apply action, STOP
   [implicit deny any] → no match found anywhere → DROP
```

**Exam tip:** If you want to allow general traffic through an ACL, you must explicitly add a `permit` statement — otherwise the implicit deny silently blocks everything not explicitly permitted.

---

## 11. Quick Revision — Key Facts

```
PORT SECURITY
  Violation modes : Protect (silent drop) < Restrict (drop+log) < Shutdown (port down)
  Default mode     : Shutdown
  MAC types        : Static (manual, persists) | Dynamic (auto, lost on reload)
                      | Sticky (auto-learned, persists ONLY with write memory)
  Aging types       : Absolute (fixed timer, ignores activity)
                      | Inactivity (resets on traffic, removes only when idle)
  Static MACs       : NEVER age out

AAA
  Authentication  : Who are you?
  Authorization   : What can you do?
  Accounting      : What did you do?

  RADIUS   : UDP | ports 1812/1813 | open standard | Auth+Authz combined
             | encrypts password only | used for Wi-Fi/VPN/ISP
  TACACS+  : TCP | port 49 | Cisco proprietary | Auth/Authz/Accounting fully separate
             | encrypts entire packet | per-command authorization | device admin

ACLs
  Standard ACL : source IP only | 1-99, 1300-1999 | place near DESTINATION
  Extended ACL : src+dst IP, protocol, port | 100-199, 2000-2699 | place near SOURCE
  Named ACL    : same rules, uses a name instead of a number
  Implicit Deny: every ACL ends with a hidden "deny any" — unmatched traffic is dropped
```

---
*Port Security, AAA & ACL Reference Notes*

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[04A - Network Routing Fundamentals]]
- [[11 - Layer 2 Switching and Ethernet Forwarding]]
- [[05 - VLANs and Inter-VLAN Routing]]
- [[06 - Network Address Translation]]
