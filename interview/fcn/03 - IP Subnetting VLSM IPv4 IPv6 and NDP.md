---
title: "03 - IP Subnetting VLSM IPv4 IPv6 and NDP"
aliases:
  - "IP Addressing Subnetting VLSM and NDP"
  - "IPv4 & IPv6 Addressing, Subnetting, VLSM, and NDP"
  - "IPv4 IPv6 Subnetting VLSM NDP Notes"
tags:
  - computer-networks
  - ip-addressing
  - subnetting
  - ipv6
syllabus-topic:
  - 3
  - 7
---

# IPv4 & IPv6 Addressing, Subnetting, VLSM, and NDP

---

## 1. What Is an IP Address?

An **IP (Internet Protocol) address** is a unique number given to every device (computer, phone, router, server) on a network so it can send and receive data. It does two jobs:

1. **Identifies the device** — tells the network *who* this device is.
2. **Locates the device** — tells routers *where* to send packets so they reach it.

```
 IP Address = Network Portion + Host Portion
              (which network?)   (which device on it?)
```

- **IPv4** → 32 bits long, written as `192.168.1.10`
- **IPv6** → 128 bits long, written as `2001:db8::1`

### 1.1 How Traffic Gets Delivered: Unicast, Broadcast, Multicast, Anycast

Every packet on a network travels using one of four delivery styles:

| Type | Goes To | Works In | In Plain Words |
|------|---------|----------|-----------------|
| **Unicast** | One specific device | IPv4 & IPv6 | One sender, one receiver — normal web browsing traffic. |
| **Broadcast** | Every device on the local network | IPv4 only | One sender, everyone on the segment gets it (e.g. `255.255.255.255`). IPv6 has **no broadcast at all** — multicast does this job instead. |
| **Multicast** | Only devices that joined a group | IPv4 & IPv6 | One sender, only "subscribed" devices receive it. IPv4 range: `224.0.0.0–239.255.255.255`. IPv6 range: `ff00::/8`. |
| **Anycast** | The *nearest* device in a group | Mainly IPv6 (limited IPv4 use) | One sender, delivered to whichever member of the group is closest by routing distance. |

```
 Unicast    :  Sender ────────────────► Single Host

 Broadcast  :  Sender ─────┬──────────► Host A
   (IPv4)                   ├──────────► Host B     (ALL hosts on segment)
                             └──────────► Host C

 Multicast  :  Sender ─────┬──────────► Host A (joined group)
                             ├──────────► Host B (joined group)
                             └──────────► Host C (joined group)
                                          (Host D — not joined — gets nothing)

 Anycast    :  Sender ────────────────► Nearest of {Host A, Host B, Host C}
```

**One-liners to remember:**
- Unicast = 1 → 1
- Broadcast = 1 → everyone (IPv4 only)
- Multicast = 1 → subscribed group (both IPv4 & IPv6)
- Anycast = 1 → nearest member of a group (mostly IPv6)

---

## 2. IPv4 Address Classes

IPv4 addresses are split into **5 classes**, identified by the value of the **first octet**.

```
 Class A : 0xxxxxxx  ->  1   - 126   (N.H.H.H)
 Class B : 10xxxxxx  ->  128 - 191   (N.N.H.H)
 Class C : 110xxxxx  ->  192 - 223   (N.N.N.H)
 Class D : 1110xxxx  ->  224 - 239   (Multicast, no subnet mask)
 Class E : 1111xxxx  ->  240 - 255   (Experimental / research, no subnet mask)
```

> `127.x.x.x` is carved out of Class A and reserved for **loopback** testing.

| Class | First Octet Range | Default Mask | # Networks | # Hosts / Network | Format |
|-------|--------------------|---------------|------------|---------------------|--------|
| A | 1 – 126 | 255.0.0.0 | 126 (2⁷−2) | 16,777,214 (2²⁴−2) | N.H.H.H |
| B | 128 – 191 | 255.255.0.0 | 16,384 (2¹⁴) | 65,534 (2¹⁶−2) | N.N.H.H |
| C | 192 – 223 | 255.255.255.0 | 2,097,152 (2²¹) | 254 (2⁸−2) | N.N.N.H |
| D | 224 – 239 | — (Multicast) | — | — | — |
| E | 240 – 255 | — (Experimental) | — | — | — |

**Key points:**
- "N" = network bits, "H" = host bits.
- Class D is for **multicast only** — it has no host/network split and no subnet mask.
- Class E is **reserved for research** — also no subnet mask.
- Class-based addressing (A/B/C/D/E) is largely historical today — real networks use **CIDR** (Section 4), which ignores class boundaries. Classes are still worth knowing for exams and for reading legacy documentation.

---

## 3. Subnetting

**Subnetting** means splitting one large network into smaller networks by "borrowing" bits from the host portion to extend the network portion.

**Default subnet masks (by class):**

| Class | Default Subnet Mask |
|-------|----------------------|
| A | 255.0.0.0 |
| B | 255.255.0.0 |
| C | 255.255.255.0 |

**Why subnet at all?**
- ✅ Cuts down broadcast traffic (smaller broadcast domains)
- ✅ Gets around the fixed host-count limits of a single classful network
- ✅ Lets you expose only part of a network for security/segmentation (e.g. a guest Wi-Fi subnet)

**Core formulas:**
```
Usable subnets = 2^(subnet bits)
Usable hosts   = 2^(host bits) − 2
Block size     = 256 − (subnet mask octet value)
```
> Older textbooks subtract 2 from the subnet count for an "all-zeros" and "all-ones" subnet. Modern routers (RFC 1878) allow both, so in practice **all 2ⁿ subnets are usable** — but some exam boards still test the old "−2" rule, so know both.

### 3.1 Class C Example — Mask 255.255.255.224 (/27)

```
 Last octet in binary: 1110 0000   (3 subnet bits, 5 host bits)
```
- Subnet bits = 3 → up to **8 subnets** (6 if using the older −2 convention)
- Host bits = 5 → 2⁵ − 2 = **30 usable hosts per subnet**
- Block size = 256 − 224 = **32**

| Subnet | Broadcast | Valid Host Range |
|--------|-----------|-------------------|
| 32  | 63  | 33–62 |
| 64  | 95  | 65–94 |
| 96  | 127 | 97–126 |
| 128 | 159 | 129–158 |
| 160 | 191 | 161–190 |
| 192 | 223 | 193–222 |

### 3.2 Class B Example — Mask 255.255.240.0 (/20)

- 4 bits borrowed → 2⁴ = **16 subnets** (14 under the old convention)
- 12 host bits → 2¹² − 2 = **4,094 hosts per subnet**
- Block size = 256 − 240 = **16**

| Subnet | First Host | Last Host | Broadcast |
|--------|-----------|-----------|-----------|
| .16.0 | .16.1 | .31.254 | .31.255 |
| .32.0 | .32.1 | .47.254 | .47.255 |
| .48.0 | .48.1 | .63.254 | .63.255 |
| .64.0 | .64.1 | .79.254 | .79.255 |

### 3.3 Class A Example — Mask 255.240.0.0 (/12)

- 4 bits borrowed → 2⁴ = **16 subnets** (14 under the old convention)
- 20 host bits → 2²⁰ − 2 = **1,048,574 hosts per subnet**
- Block size = 256 − 240 = **16**

```
First subnet:
  Subnet    : 10.0.0.0
  Broadcast : 10.15.255.255
  Hosts     : 10.0.0.1 - 10.15.255.254

Last subnet:
  Subnet    : 10.240.0.0
  Broadcast : 10.255.255.255
  Hosts     : 10.240.0.1 - 10.255.255.254
```

---

## 4. CIDR (Classless Inter-Domain Routing)

**CIDR** replaces the rigid Class A/B/C system with a simple **slash notation** (`/n`) that states exactly how many bits, counting from the left, form the network portion. This lets a network be *any* size, not just a class-sized one.

```
 192.168.1.0/24
              └── "/24" = first 24 bits = NETWORK part
                        = last 8 bits  = HOST part
                        = subnet mask 255.255.255.0
```

### 4.1 Why CIDR Matters

- ✅ No more wasted addresses (a Class C used to force exactly 254 hosts even if you only needed 10)
- ✅ Enables **route summarization** — many small networks advertised as one big block, shrinking routing tables
- ✅ Is the foundation that makes **VLSM** possible (Section 5)

### 4.2 Prefix Length ↔ Subnet Mask ↔ Hosts (IPv4 Quick Reference)

| CIDR (/n) | Subnet Mask | # Host Bits | Usable Hosts (2ⁿ−2) |
|-----------|--------------|-------------|------------------------|
| /24 | 255.255.255.0 | 8 | 254 |
| /25 | 255.255.255.128 | 7 | 126 |
| /26 | 255.255.255.192 | 6 | 62 |
| /27 | 255.255.255.224 | 5 | 30 |
| /28 | 255.255.255.240 | 4 | 14 |
| /29 | 255.255.255.248 | 3 | 6 |
| /30 | 255.255.255.252 | 2 | 2 (point-to-point links) |
| /32 | 255.255.255.255 | 0 | 1 (single host route) |

```
Formula:
  Usable Hosts = 2^(32 − n) − 2      where n = CIDR prefix length
```

### 4.3 Route Summarization (Supernetting)

CIDR also lets you go the *other* direction — combine several small networks into one larger advertised block:

```
 192.168.0.0/24  ─┐
 192.168.1.0/24   ├──►  Summarized as  192.168.0.0/22
 192.168.2.0/24   │      (covers .0.0 – .3.255, 1024 addresses)
 192.168.3.0/24  ─┘
```

- **Shorter prefix** (fewer network bits) → bigger block, more hosts, fewer routes to advertise.
- **Longer prefix** (more network bits) → smaller block, fewer hosts, more granular control.

### 4.4 CIDR in IPv6

Same `/n` idea, e.g. `2001:db8::/32`. IPv6 almost always standardizes on a **/64** network prefix, leaving the remaining 64 bits for the device's own identifier (see Section 7).

**One-liners:**
- CIDR = slash notation that states the network-bit count, replacing rigid classes.
- Shorter prefix = bigger block. Longer prefix = smaller block.
- CIDR supports both subnetting (splitting) and summarization (combining).

---

## 5. VLSM (Variable Length Subnet Mask)

**VLSM**, also called **classless addressing**, lets you use *different* mask lengths for different subnets carved from the same network — long masks (small blocks) for small departments, short masks (big blocks) for large ones. It requires a **classless routing protocol** (e.g. OSPF, EIGRP) to work, since those protocols carry the mask along with each route.

**Why use VLSM instead of one fixed subnet size for everyone?** Because department sizes vary. A fixed subnet size forces you to either waste addresses on small departments or run out of addresses for big ones. VLSM sizes each subnet to fit its actual need, minimizing waste.

**Golden rule: always allocate the largest requirement first**, then carve the remaining space for smaller ones.

### Worked Example — 192.168.1.0/24

**Requirements (sorted largest → smallest):**

| Department | Hosts Needed |
|------------|---------------|
| Sales | 100 |
| Purchase | 50 |
| Accounts | 25 |
| Management | 5 |

**Steps:**
1. Sort requirements from biggest to smallest.
2. Give the biggest requirement the smallest mask that still fits it (most hosts).
3. Move to the next unused block of address space and repeat for the next requirement.

| Dept | Network | Prefix | Mask | Usable Hosts |
|------|---------|--------|------|----------------|
| Sales | 192.168.1.0 | /25 | 255.255.255.128 | 126 |
| Purchase | 192.168.1.128 | /26 | 255.255.255.192 | 62 |
| Accounts | 192.168.1.192 | /27 | 255.255.255.224 | 30 |
| Management | 192.168.1.224 | /29 | 255.255.255.248 | 6 |

```
 192.168.1.0/24
 ├── 192.168.1.0/25    → Sales      (126 hosts)
 ├── 192.168.1.128/26  → Purchase   (62 hosts)
 ├── 192.168.1.192/27  → Accounts   (30 hosts)
 └── 192.168.1.224/29  → Management (6 hosts)
       └── 192.168.1.232 – 255 → still unused, kept for future growth
```

---

## 6. Wildcard Mask & Wildcard IP

A **wildcard mask** is the *inverse* of a subnet mask. It's used in **ACLs (Access Control Lists)** and **OSPF `network` statements**, and it flips the logic of a normal subnet mask:

```
 Subnet Mask   :  1 = network bit (must match)   0 = host bit (varies)
 Wildcard Mask :  0 = must match                  1 = don't care (any value OK)

 Wildcard Mask = 255.255.255.255 − Subnet Mask
```

### 6.1 Quick Reference

| CIDR (/n) | Subnet Mask | Wildcard Mask |
|-----------|--------------|----------------|
| /24 | 255.255.255.0 | 0.0.0.255 |
| /25 | 255.255.255.128 | 0.0.0.127 |
| /26 | 255.255.255.192 | 0.0.0.63 |
| /27 | 255.255.255.224 | 0.0.0.31 |
| /28 | 255.255.255.240 | 0.0.0.15 |
| /29 | 255.255.255.248 | 0.0.0.7 |
| /30 | 255.255.255.252 | 0.0.0.3 |
| /32 | 255.255.255.255 | 0.0.0.0 |
| /0 | 0.0.0.0 | 255.255.255.255 |

**Worked example:**
```
 Subnet Mask   :  255.255.255.  0   →  11111111.11111111.11111111.00000000
 Wildcard Mask :    0.  0.  0.255   →  00000000.00000000.00000000.11111111
                (each octet: 255 − subnet-octet = wildcard-octet)
```

### 6.2 Where Wildcard IPs Are Used

| Use Case | Example Syntax | Meaning |
|----------|------------------|---------|
| **ACL permit/deny** | `access-list 10 permit 192.168.1.0 0.0.0.255` | Matches any host `192.168.1.0`–`192.168.1.255` |
| **OSPF network statement** | `network 10.0.0.0 0.0.0.255 area 0` | Enables OSPF on interfaces in `10.0.0.0/24` |
| **Match a single host** | `access-list 10 permit 192.168.1.5 0.0.0.0` | Matches **only** `192.168.1.5` — every bit must match |
| **Match anything** | `access-list 10 permit 0.0.0.0 255.255.255.255` | Matches **any** address — shortcut keyword: `any` |

**One-liners:**
- Wildcard mask = inverse of subnet mask.
- `0` bit = must match exactly | `1` bit = don't care.
- All-`0.0.0.0` wildcard = match exactly one host.
- All-`255.255.255.255` wildcard = match every address.
- Wildcard masks configure **ACLs and OSPF**, not an interface's actual IP (that still uses a normal subnet mask).

---

## 7. IPv6 Addressing

- **128 bits** long (vs IPv4's 32 bits) — written as 8 groups of hex digits.
- Identifies a network interface and enables routing, exactly like IPv4 does, just with a vastly bigger address pool.
- **No broadcast in IPv6** — the all-nodes multicast group `ff02::1` covers most of that role, though protocol-specific multicast groups are preferred in practice.

### 7.1 IPv6 Address Types

| Type | Delivered To | Notes |
|------|----------------|-------|
| **Unicast** | One specific interface | Standard one-to-one delivery. |
| **Multicast** | All interfaces in a group | Replaces IPv4 broadcast; devices join a group to receive it. |
| **Anycast** | The nearest interface in a group | Same address *format* as unicast — the only difference is that the address is assigned to multiple devices, and routing sends traffic to whichever one is closest. A common real-world use is DNS root servers: many physical servers share one anycast address, and each client reaches the nearest one. |

### 7.2 Writing IPv6 Addresses

Full form — 8 groups of 4 hex digits ("hextets"), separated by `:`:
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

**Rule 1 — drop leading zeros** in each group (keep at least one digit):
```
2001:db8:85a3:0:0:8a2e:370:7334
```

**Rule 2 — replace ONE run of consecutive all-zero groups with `::`** (only once per address, to avoid ambiguity about how many groups it stands for):
```
2001:db8:85a3::8a2e:370:7334
```

**Special addresses:**

| Address | Meaning |
|---------|---------|
| `::1` | Loopback (full: `0:0:0:0:0:0:0:1`) |
| `::` | Unspecified address (full: `0:0:0:0:0:0:0:0`) |

### 7.3 Structure of an IPv6 Address: Network ID + Interface ID

A typical `/64` IPv6 address splits cleanly into two 64-bit halves:

```
 3A:2B1C : 0000:0000 : 0009:0101:0000:007C  /64
 └────┬───────────┘   └──────────┬─────────┘
   Network ID                Interface ID
  (first 64 bits)           (last 64 bits)
```

| Part | Bits | Also Called | Purpose |
|------|------|--------------|---------|
| **Network ID** | First 64 | Network Prefix, Subnet ID | Identifies *which network* — assigned by admin/ISP. |
| **Interface ID** | Last 64 | Host ID | Identifies *which specific device* on that network. |

The Interface ID can be set two ways:

| Method | Description |
|--------|--------------|
| **Manual** | Admin types the full 64-bit host part directly, e.g. `ipv6 address 3A:2B1C::1/64` |
| **EUI-64** | Auto-generated from the interface's 48-bit MAC address (see Section 8) |

**Same address, three equivalent forms:**

| Form | Address |
|------|---------|
| Full | `003A:2B1C:0000:0000:0009:0101:0000:007C /64` |
| Leading zeros dropped | `3A:2B1C:0:0:9:101:0:7C /64` |
| Zero-run compressed | `3A:2B1C::9:101:0:7C /64` |

> ⚠️ `::` can appear **only once per address** — using it twice makes it impossible to tell how many zero groups each one represents.

### 7.4 Configuring IPv6 (Cisco IOS)

```
Step 1 — Enable IPv6 routing globally:
    Router(config)# ipv6 unicast-routing

Step 2 — Enter the interface:
    Router(config)# interface g0/0

Step 3a — Auto-generate the host part via EUI-64:
    Router(config-if)# ipv6 address 3A:2B1C::/64 eui-64

Step 3b — OR manually assign a complete address:
    Router(config-if)# ipv6 address 3A:2B1C::1/64
```

| Command | Purpose |
|---------|---------|
| `ipv6 unicast-routing` | Enables IPv6 routing on the device |
| `interface g0/0` | Enters configuration mode for that interface |
| `ipv6 address <prefix>/64 eui-64` | Auto-generates the Interface ID from the MAC address |
| `ipv6 address <full-address>/64` | Manually assigns a complete IPv6 address |

---

## 8. EUI-64 (Extended Unique Identifier)

**EUI-64** automatically builds a 64-bit Interface ID (Section 7.3) out of a device's 48-bit MAC address, so no one has to type a host address by hand.

**Algorithm:**
```
1. Split the 48-bit MAC address into two 24-bit halves.
2. Insert FFFE in the middle  → 48 bits become 64 bits.
3. Flip the 7th bit of the first byte (the universal/local bit).
```

**Worked example** — MAC = `00:1A:2B:3C:4D:5E`

| Step | Value |
|------|-------|
| Original MAC | `00:1A:2B:3C:4D:5E` |
| Split into halves | `00:1A:2B` \| `3C:4D:5E` |
| Insert `FFFE` | `00:1A:2B:FF:FE:3C:4D:5E` |
| Flip 7th bit (`00` → `02`) | `02:1A:2B:FF:FE:3C:4D:5E` |

**Full address example** — prefix `3A:2B1C::/64` + this Interface ID:
```
3A:2B1C:02:1A:2B:FF:FE:3C:4D:5E
```

> This is exactly what the `eui-64` keyword does in `ipv6 address ... eui-64` (Section 7.4).

---

## 9. IPv6 Address Scopes: Link-Local, ULA, and Global Unicast

Every IPv6 device typically carries **up to three addresses at once**, each meant for a different scope of communication:

```
PC1
├── Link-local: FE80::10        → same LAN only
├── ULA:         FD12::10       → private organization-wide
└── Global (GUA): 2001:db8:1::10 → the whole Internet
```

### 9.1 Link-Local Address — `FE80::/10`

Used for communication **within the same local link only**. It is created automatically by every IPv6 interface and is essential for:
- Talking to the local router
- Neighbor Discovery (NDP — Section 11)
- Router Advertisements (RA) and SLAAC

```
PC1                         Router
FE80::10  ────────────────  FE80::1
             Same LAN
```

A link-local address **cannot be routed** past the local router — it never leaves the segment it was created on.

### 9.2 Site-Local Address — `FEC0::/10` (Deprecated)

An older private-addressing scheme, similar in intent to IPv4's private ranges, but it was **deprecated** because it caused routing ambiguity when organizations merged their networks. **It should not be used in new designs.**

### 9.3 Unique Local Address (ULA) — `FC00::/7`, Commonly Seen as `FD00::/8`

ULA is what **replaced** Site-Local as IPv6's version of a "private" address. Example: `FD12:3456:789A:1::10`.

| | IPv4 Private | IPv6 ULA |
|---|---|---|
| Range | 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 | `fc00::/7` (usually `fd00::/8`) |
| Routable on the public Internet? | ❌ No | ❌ No |
| Routable within an org/site? | ✅ Yes | ✅ Yes |
| Globally unique? | No — ranges can clash if networks merge | ✅ Yes — a randomly generated **Global ID** makes collisions very unlikely even after a merger |

```
 ULA structure:

 fd  XX:XXXX:XXXX  :  XXXX  :  Interface ID
 └┬┘ └─────┬──────┘    └┬──┘    └─────┬──────┘
 Prefix  Global ID    Subnet ID    Interface ID
 (7-8    (40 bits,     (16 bits)   (64 bits)
  bits)   random)
```

### 9.4 Global Unicast Address (GUA) — `2000::/3`

This is IPv6's equivalent of a public IPv4 address — used for direct, end-to-end communication with the Internet.

### 9.5 Summary Table

| Address Type | Range | Scope | Routable? |
|----------------|-------|--------|-----------|
| **Link-Local** | `FE80::/10` | Same link/LAN only | ❌ Not by routers |
| **Site-Local** *(deprecated)* | `FEC0::/10` | Old internal site | ❌ Deprecated, don't use |
| **ULA** | `FC00::/7` | Private organization/network | ✅ Within private networks only |
| **Global Unicast (GUA)** | `2000::/3` | Internet | ✅ Yes |

**One-liners:**
- Every IPv6 interface has a link-local address, even with no global address configured.
- Site-Local is dead — use ULA for private addressing instead.
- Neither Link-Local nor ULA is reachable from outside its own scope.

### 9.6 Full IPv6 Special Address Range Reference

Beyond the scopes above, a handful of other reserved ranges show up regularly in exams and configs:

| IPv6 Address / Range | Name | Purpose |
|-----------------------|------|---------|
| `::/128` | Unspecified | Means **no address** — used as a placeholder when an address isn't yet known (e.g. a host's source address before DHCPv6/SLAAC completes). |
| `::1/128` | Loopback | The device talking to itself — IPv6's equivalent of IPv4 `127.0.0.1`. |
| `FE80::/10` | Link-Local | Communication on the **same LAN/link** only (Section 9.1). |
| `FC00::/7` | Unique Local Address (ULA) | **Private/internal** IPv6 networks, not Internet-routable (Section 9.3). |
| `FF00::/8` | Multicast | One-to-many delivery — replaces IPv4 broadcast (Section 7.1). |
| `2000::/3` | Global Unicast | Public IPv6 addresses used on the Internet (Section 9.4). |
| `2001:db8::/32` | Documentation | Reserved specifically for use in examples, docs, and textbooks — never assigned to real devices, so it's safe to use in configs shown here. |
| `::ffff:0:0/96` | IPv4-mapped | Represents an IPv4 address inside an IPv6 packet/application, for dual-stack software that needs to handle both address families uniformly. |
| `100::/64` | Discard-Only | A "black hole" range — packets sent here are deliberately dropped, useful for testing or filtering. |
| `FE00::/9` | Reserved | Unassigned space held in reserve (part of what used to include the deprecated Site-Local range, Section 9.2). |

> `FE00::/9` is a separate reserved block from `FE80::/10` and `FEC0::/10` (old Site-Local) — despite the similar-looking prefixes, the bit math places them in different, non-overlapping ranges. Don't assume nesting just because the hex looks similar.

### 9.7 Can a ULA-Only Device Reach the Internet?

**No — not directly.** Since ULA (`fc00::/7`) isn't routable on the public Internet, packets sourced from a ULA address get dropped as soon as they try to leave the private network. To actually reach the Internet, one of these is needed:

| Option | How It Works | NAT Needed? |
|--------|----------------|---------------|
| **Dual addressing** *(standard, recommended)* | Every device gets **both** a ULA (for internal traffic) and a GUA (for Internet traffic), typically via SLAAC or DHCPv6. Internet-bound packets simply use the GUA. | ❌ No |
| **NAT66 / NPTv6** *(uncommon)* | The edge router translates the ULA source prefix into a GUA prefix — conceptually similar to IPv4 NAT. Officially discouraged and rarely deployed in IPv6 networks. | ✅ Yes |

```
 Standard design — dual addressing, no NAT:

  PC ── fd12:3456:789a:1::10  (ULA — internal LAN traffic)
     └─ 2001:db8:1::10        (GUA — traffic to the Internet)

  Both addresses live on the SAME interface — no translation needed.
```

```
 ULA-only LAN (no GUA assigned) — cannot reach the Internet:

  PC (fd12::10 ULA only) ──X──► Internet
                           │
                    dropped: ULA isn't
                    routable outside the
                    private network
```

This is why IPv6 is often described as "**NAT-free**" — the normal design gives every Internet-facing device its own GUA, so no translation is ever needed (contrast with IPv4 in Section 10). NAT66/NPTv6 exists only as a fallback for networks that insist on staying ULA-only.

> **Edge case:** it's technically possible for only *one* device on a LAN to hold a GUA, with everyone else staying ULA-only. In that setup, the ULA-only devices must funnel their Internet traffic through that one device acting as a gateway/proxy — conceptually similar to IPv4-style NAT/PAT. This is **not** the recommended design; IPv6's huge address space makes giving every device its own GUA cheap and simple, so that's the standard approach.

---

## 10. IPv6 Enhancements Over IPv4

| Function | IPv4 Approach | IPv6 Approach |
|----------|-----------------|-----------------|
| **Subnetting** | Manual subnetting required to divide networks | Vast 128-bit space mostly avoids complex subnetting; a simple hierarchical `/64` prefix is the norm |
| **Address Resolution** | **ARP** — maps IP→MAC using broadcast | **NDP** — resolves addresses, detects duplicates, and discovers routers, using multicast instead of broadcast |
| **Address Assignment** | **DHCP** — server assigns IPs | **SLAAC** — device self-configures from the advertised network prefix; **DHCPv6** available for stateful cases |
| **Network Booting** | **BOOTP** — bootstrap + IP assignment | Largely unnecessary — SLAAC (and DHCPv6 where needed) covers this |

**In short:** IPv6 folds ARP, DHCP, and BOOTP's responsibilities into more efficient, integrated mechanisms (NDP, SLAAC), and its enormous address space removes most of the pressure to subnet carefully.

---

## 11. NDP — Neighbor Discovery Protocol (IPv6)

NDP replaces ARP (and adds more capabilities), using **ICMPv6 multicast** instead of broadcast.

| Message | Direction | Purpose |
|---------|-----------|---------|
| **RS** (Router Solicitation) | Host → `ff02::2` (all-routers) | "Is there a router here?" |
| **RA** (Router Advertisement) | Router → `ff02::1` (all-nodes) | "I'm here — here's the network prefix and gateway." |
| **NS** (Neighbor Solicitation) | Host → solicited-node multicast | Resolves an IPv6 address to a MAC address; also used for Duplicate Address Detection (DAD). |
| **NA** (Neighbor Advertisement) | Host/Router → unicast reply | Answers an NS with the requested MAC address. |

```
 Address Resolution Flow (NDP):

  Host A                                   Host B
    │  NS (Who has IPv6-B? Tell IPv6-A)       │
    │ ──────────► solicited-node multicast ──►│
    │                                          │
    │  NA (IPv6-B is-at MAC-B)                 │
    │ ◄──────────────── unicast ───────────────│
```

**DAD (Duplicate Address Detection):** before a host starts using a new IPv6 address, it sends an **NS** targeting its own tentative address. If it gets an **NA** back, that address is already in use elsewhere — it must not be used.

---

## 12. IPv4 vs IPv6 — Side-by-Side Comparison

| Feature | IPv4 | IPv6 |
|---|---|---|
| Size | 32-bit | 128-bit |
| Format | `192.168.1.10` | `2001:db8::1` |
| Total addresses | ~4.3 billion | ~3.4 × 10³⁸ |
| Auto-config | DHCP only | SLAAC or DHCPv6 |
| Address resolution | ARP (broadcast) | NDP (multicast) |
| Loopback | 127.0.0.1 | ::1 |
| Private / local addressing | RFC 1918 ranges | Unique Local Address, `fc00::/7` |
| Link-local | 169.254.x.x (APIPA) | `fe80::/10` (mandatory on every interface) |
| NAT needed? | ✅ Usually yes | ❌ Rarely — only if a network stays ULA-only with no GUA (Section 9.6) |

**IPv6 adoption challenges:** legacy hardware/software that doesn't support it, the added complexity of running dual stack, routing-table growth, a skills gap among network staff, and migration cost.

**Transition mechanisms:**
- **Dual Stack** — a device runs IPv4 and IPv6 side by side.
- **Tunneling** — IPv6 packets are wrapped inside IPv4 packets (e.g. 6to4, Teredo) to cross IPv4-only infrastructure.
- **Translation** — a device converts between IPv4 and IPv6 directly (e.g. NAT64) for interoperability.

---

## 13. Quick Revision Sheet

```
Class A : /8   default mask 255.0.0.0     → 126 nets   / 16.7M hosts
Class B : /16  default mask 255.255.0.0   → 16384 nets / 65534 hosts
Class C : /24  default mask 255.255.255.0 → 2M nets     / 254 hosts

VLSM rule    : allocate the LARGEST requirement first
IPv6 size    : 128 bits = 8 hextets
IPv6 "::"    : only ONE zero-compression allowed per address
IPv6 split   : /64 network part + /64 interface ID (host part)

EUI-64       : MAC (48-bit) → insert FFFE + flip 7th bit → 64-bit interface ID
Anycast      : same address on multiple interfaces, routed to the NEAREST one
Link-Local   : FE80::/10  (mandatory, auto-config, single-segment only)
Site-Local   : FEC0::/10  (deprecated — do not use)
ULA (private): fc00::/7, usually fd00::/8 — IPv6's "private" address, not Internet-routable
Global (GUA) : 2000::/3 — used for actual Internet communication

IPv6 replaces: ARP → NDP  |  DHCP → SLAAC/DHCPv6  |  BOOTP → SLAAC (not needed)

NDP addresses: ff02::1 (all-nodes) / ff02::2 (all-routers)
Resolution    : IPv4 uses ARP (broadcast) | IPv6 uses NDP (multicast)
```

---
*FCN PG-DITISS – IACSD Reference Notes*

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[01 - OSI Model]]
- [[02 - TCP-IP Model]]
- [[04A - Network Routing Fundamentals]]
- [[06 - Network Address Translation]]
