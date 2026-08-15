---
title: "Syllabus and Interview Checklist"
aliases:
  - "Computer Networks Syllabus and Interview Checklist"
  - "Computer Networks — CDAC DITISS Syllabus"
  - "CN Syllabus Topics Interview Priority"
tags:
  - computer-networks
  - syllabus
  - interview-preparation
  - moc
---

# Computer Networks — CDAC DITISS Syllabus

## Topics, Interview Priority & Important Ports/Protocols

---

## Completion Checklist

### Priority 1 — Must Know

- [x] 1. OSI Model — [[01 - OSI Model|Notes]]
- [x] 2. TCP/IP Model — [[02 - TCP-IP Model|Notes]]
- [x] 3. IP Subnetting & VLSM — [[03 - IP Subnetting VLSM IPv4 IPv6 and NDP|Notes]]
- [x] 4. Routing — [[04A - Network Routing Fundamentals|Fundamentals]] · [[04B - Routing Protocols and Administrative Distance|Protocols]]
- [x] 5. VLANs & Inter-VLAN Routing — [[05 - VLANs and Inter-VLAN Routing|Notes]]
- [x] 6. NAT (Network Address Translation) — [[06 - Network Address Translation|Notes]]
- [x] 7. IPv4 vs IPv6 — [[03 - IP Subnetting VLSM IPv4 IPv6 and NDP|Notes]]

### Priority 2 — Important

- [x] 8. Spanning Tree Protocol (STP) — [[08 - Spanning Tree Protocol|Notes]]
- [x] 9. Infrastructure Security — ACL, AAA — [[09 - Infrastructure Security ACL AAA and Port Security|Notes]]
- [ ] 10. PPP and WAN Technologies — Partial coverage only: [[01 - OSI Model|PPP/PPPoE]] · [[04A - Network Routing Fundamentals|WAN link references]]
- [x] 11. Layer 2 Switching — [[11 - Layer 2 Switching and Ethernet Forwarding|Notes]]
- [x] 12. Ethernet and Wireless (IEEE Standards) — Distributed coverage: [[11 - Layer 2 Switching and Ethernet Forwarding|Ethernet]] · [[01 - OSI Model|Wireless]]

### Priority 3 — Good to Know

- [x] 13. Router IOS and Management — [[13 - Router IOS and Management|Notes]]
- [ ] 14. SDN — Software Defined Networking — No dedicated note provided
- [ ] 15. OpenFlow and OpenDaylight — No dedicated note provided
- [ ] 16. Virtual Networking — No dedicated note provided
- [ ] 17. Advanced SDN / OpenDaylight Topics — No dedicated note provided

**Progress:** 12 of 17 topics complete (71%).

---

## 🔴 PRIORITY 1 — MUST KNOW (Most Asked in Interviews)

### 1. OSI Model ✅

- 7 Layers: Physical, Data Link, Network, Transport, Session, Presentation, Application
- Role of each layer with real-world examples
- PDU at each layer (Bits, Frames, Packets, Segments, Data)
- Encapsulation and De-encapsulation

### 2. TCP/IP Model ✅

- 4-layer model vs OSI 7-layer mapping
- TCP vs UDP — differences, use cases
- Why video streaming uses UDP instead of TCP
- Three-way handshake (SYN → SYN-ACK → ACK)
- Four-way termination (FIN → FIN-ACK → FIN → ACK)

### 3. IP Subnetting & VLSM ✅

- IPv4 address classes (A, B, C, D, E)
- Subnet mask, CIDR notation
- Variable Length Subnet Masking (VLSM)
- Network address, Broadcast address, Host range calculation
- Practice: 192.168.1.0/24, 10.0.0.0/8, 172.16.0.0/16

### 4. Routing ✅

- Static Routing vs Dynamic Routing
- Distance Vector (RIP) vs Link State (OSPF)
- Administrative Distance concept
- IGP vs EGP
- Protocols: RIP, IGRP, EIGRP, OSPF, BGP

### 5. VLANs & Inter-VLAN Routing ✅

- VLAN concept, benefits, port assignment
- VLAN tagging — IEEE 802.1Q
- Trunking — trunk ports vs access ports
- Inter-VLAN routing (Router-on-a-stick, Layer 3 switch)
- VTP modes: Server, Client, Transparent

### 6. NAT (Network Address Translation) ✅

- Static NAT, Dynamic NAT, PAT (Port Address Translation / NAT Overload)
- Private IP ranges (10.x, 172.16.x, 192.168.x)
- Why NAT is used — IPv4 exhaustion
- NAT table concept

### 7. IPv4 vs IPv6 ✅

- Address format differences (32-bit vs 128-bit)
- IPv6 address types: Unicast, Multicast, Anycast
- IPv6 adoption challenges
- Dual stack, tunneling, translation methods

---

## 🟠 PRIORITY 2 — IMPORTANT (Frequently Asked)

### 8. Spanning Tree Protocol (STP) ✅

- Loop problem in Layer 2 networks
- Root Bridge election — Bridge ID (Priority + MAC)
- Port States: Blocking, Listening, Learning, Forwarding, Disabled
- STP vs RSTP (Rapid STP) — convergence time difference
- Types: STP (802.1D), RSTP (802.1w), MSTP (802.1s), PVST+

### 9. Infrastructure Security — ACL, AAA ✅

- Standard ACL vs Extended ACL (numbered and named)
- ACL placement: Standard — close to destination; Extended — close to source
- Port security — violation modes: Protect, Restrict, Shutdown
- AAA: Authentication, Authorization, Accounting
- TACACS+ vs RADIUS — key differences

### 10. PPP, WAN Technologies

- PPP (Point-to-Point Protocol) — authentication: PAP vs CHAP
- MLPPP (Multilink PPP) — link aggregation over WAN
- PPPoE — DSL broadband authentication
- GRE Tunneling concept
- MPLS vs Traditional WAN
- VPN fundamentals — site-to-site, remote access

### 11. Layer 2 Switching ✅

- MAC address table, flooding, forwarding
- Cut-through vs Store-and-forward switching
- CSMA/CD concept (Ethernet)
- Half duplex vs Full duplex

### 12. Ethernet & Wireless (IEEE Standards) ✅

- UTP vs STP cables — categories (CAT5e, CAT6, CAT7)
- IEEE 802.3 (Ethernet), 802.11 (Wi-Fi), 802.1Q (VLAN)
- Wi-Fi frequency bands: 2.4 GHz vs 5 GHz
- Wireless security: WEP, WPA, WPA2, WPA3

---

## 🟡 PRIORITY 3 — GOOD TO KNOW (Asked in Advanced Rounds)

### 13. Router IOS & Management ✅

- Router boot sequence: POST → Bootstrap → IOS → Config
- IOS image storage: Flash, NVRAM, RAM, ROM
- Telnet vs SSH — security differences
- Configuration registers
- Debugging and logging importance

### 14. SDN — Software Defined Networking

- Traditional networking vs SDN
- Control Plane vs Data Plane separation
- SDN architecture: Application, Control, Infrastructure layers
- Use in cloud data centers, ISP automation
- Google's B4 SDN-based network

### 15. OpenFlow & OpenDaylight

- OpenFlow protocol — controller-switch communication
- OpenFlow message types: Hello, Features, Packet-in, Packet-out, Flow-mod
- OpenDaylight architecture — MD-SAL (Model-Driven Service Abstraction Layer)
- OpenDaylight clustering
- OpenVSwitch (OVS) concept
- Mininet — network emulation tool

### 16. Virtual Networking

- Virtual Switch vs Physical Switch
- Network Function Virtualization (NFV)
- NFV vs SDN relationship
- Use cases: NAC, Virtual Customer Edge, DC Optimization

### 17. Advanced SDN / OpenDaylight Topics

- Group Based Policy (GBP)
- Service Function Chaining (SFC)
- LISP Flow Mapping
- Virtual Tenant Networks (VTN)
- Multi-tenant isolation in data centers
- OVSDB Virtualization

---

## 🌐 INTERVIEW SPECIAL — IMPORTANT PORTS & PROTOCOLS

> **These are almost always asked in networking, DevSecOps, and security interviews.**

### 📌 Application Layer Protocols & Ports

| Port  | Protocol      | Transport | Description                                        |
| ----- | ------------- | --------- | -------------------------------------------------- |
| 20    | FTP Data      | TCP       | File Transfer — Data channel                       |
| 21    | FTP Control   | TCP       | File Transfer — Command channel                    |
| 22    | SSH           | TCP       | Secure Shell — encrypted remote login              |
| 23    | Telnet        | TCP       | Unencrypted remote login (insecure)                |
| 25    | SMTP          | TCP       | Send emails (Simple Mail Transfer Protocol)        |
| 53    | DNS           | TCP/UDP   | Domain Name System — name resolution               |
| 67    | DHCP Server   | UDP       | Dynamic Host Config — server port                  |
| 68    | DHCP Client   | UDP       | Dynamic Host Config — client port                  |
| 69    | TFTP          | UDP       | Trivial FTP — no auth, used in router IOS transfer |
| 80    | HTTP          | TCP       | Web traffic — unencrypted                          |
| 110   | POP3          | TCP       | Post Office Protocol v3 — receive emails           |
| 119   | NNTP          | TCP       | Network News Transfer Protocol                     |
| 123   | NTP           | UDP       | Network Time Protocol — time sync                  |
| 143   | IMAP          | TCP       | Internet Message Access Protocol — receive emails  |
| 161   | SNMP          | UDP       | Simple Network Management Protocol — monitoring    |
| 162   | SNMP Trap     | UDP       | SNMP alerts/notifications                          |
| 179   | BGP           | TCP       | Border Gateway Protocol — inter-AS routing         |
| 389   | LDAP          | TCP/UDP   | Lightweight Directory Access Protocol              |
| 443   | HTTPS         | TCP       | Secure web traffic (HTTP over TLS/SSL)             |
| 445   | SMB           | TCP       | Windows file sharing (Server Message Block)        |
| 465   | SMTPS         | TCP       | SMTP over SSL — secure email sending               |
| 500   | IKE/ISAKMP    | UDP       | IPSec VPN key exchange                             |
| 514   | Syslog        | UDP       | System logging                                     |
| 636   | LDAPS         | TCP       | LDAP over SSL                                      |
| 993   | IMAPS         | TCP       | IMAP over SSL                                      |
| 995   | POP3S         | TCP       | POP3 over SSL                                      |
| 1433  | MSSQL         | TCP       | Microsoft SQL Server                               |
| 1521  | Oracle DB     | TCP       | Oracle Database                                    |
| 3306  | MySQL         | TCP       | MySQL Database                                     |
| 3389  | RDP           | TCP       | Remote Desktop Protocol — Windows                  |
| 5432  | PostgreSQL    | TCP       | PostgreSQL Database                                |
| 5900  | VNC           | TCP       | Virtual Network Computing — remote GUI             |
| 6379  | Redis         | TCP       | Redis in-memory database                           |
| 8080  | HTTP-Alt      | TCP       | Alternative HTTP / proxy port                      |
| 8443  | HTTPS-Alt     | TCP       | Alternative HTTPS port                             |
| 9200  | Elasticsearch | TCP       | Elasticsearch REST API                             |
| 27017 | MongoDB       | TCP       | MongoDB Database                                   |

---

### 📌 Network Layer Protocols

| Protocol | Number | Description                                                   |
| -------- | ------ | ------------------------------------------------------------- |
| ICMP     | 1      | Internet Control Message Protocol — ping, traceroute          |
| IGMP     | 2      | Internet Group Management Protocol — multicast groups         |
| TCP      | 6      | Transmission Control Protocol — reliable, connection-oriented |
| UDP      | 17     | User Datagram Protocol — fast, connectionless                 |
| GRE      | 47     | Generic Routing Encapsulation — tunneling                     |
| ESP      | 50     | Encapsulating Security Payload — IPSec encryption             |
| AH       | 51     | Authentication Header — IPSec integrity                       |
| OSPF     | 89     | Open Shortest Path First — runs directly over IP              |

---

### 📌 Routing Protocols — Key Facts for Interview

| Protocol     | Type                  | Algorithm      | AD                     | Metric                 |
| ------------ | --------------------- | -------------- | ---------------------- | ---------------------- |
| RIP v1/v2    | IGP / Distance Vector | Bellman-Ford   | 120                    | Hop count (max 15)     |
| IGRP         | IGP / Distance Vector | Bellman-Ford   | 100                    | Bandwidth + Delay      |
| EIGRP        | IGP / Hybrid          | DUAL           | 90 (internal)          | Bandwidth + Delay      |
| OSPF         | IGP / Link State      | Dijkstra (SPF) | 110                    | Cost (bandwidth-based) |
| IS-IS        | IGP / Link State      | Dijkstra       | 115                    | Cost                   |
| BGP          | EGP / Path Vector     | Best Path      | 20 (eBGP) / 200 (iBGP) | AS Path, MED, etc.     |
| Static Route | —                     | —              | 1                      | —                      |
| Connected    | —                     | —              | 0                      | —                      |

---

### 📌 TACACS+ vs RADIUS — Interview Comparison

| Feature        | TACACS+              | RADIUS                            |
| -------------- | -------------------- | --------------------------------- |
| Transport      | TCP (port 49)        | UDP (1812 auth / 1813 accounting) |
| Encryption     | Full packet          | Password only                     |
| AAA separation | Yes (separate A,A,A) | No (combined)                     |
| Used for       | Device admin (Cisco) | Network access (VPN, Wi-Fi)       |
| Vendor         | Cisco proprietary    | Open standard (RFC)               |

---

### 📌 STP Port States — Quick Reference

| State      | Duration           | Action                                    |
| ---------- | ------------------ | ----------------------------------------- |
| Blocking   | Indefinite         | No forwarding, no learning, listens BPDUs |
| Listening  | 15 sec (FWD delay) | No forwarding, no learning                |
| Learning   | 15 sec (FWD delay) | No forwarding, learns MACs                |
| Forwarding | Indefinite         | Forwards frames, learns MACs              |
| Disabled   | Admin down         | Not participating in STP                  |

---

### 📌 NAT Types — Quick Reference

| Type               | Description                             | Use case                |
| ------------------ | --------------------------------------- | ----------------------- |
| Static NAT         | 1 private ↔ 1 public (fixed)            | Servers behind firewall |
| Dynamic NAT        | Pool of public IPs assigned dynamically | Medium enterprises      |
| PAT / NAT Overload | Many private → 1 public (port-based)    | Home router, ISP        |

---

### 📌 Private IP Address Ranges (RFC 1918)

| Class | Range                         | Default Subnet |
| ----- | ----------------------------- | -------------- |
| A     | 10.0.0.0 – 10.255.255.255     | /8             |
| B     | 172.16.0.0 – 172.31.255.255   | /12            |
| C     | 192.168.0.0 – 192.168.255.255 | /16            |

---

### 📌 OSI Layer — Protocol Mapping (Interview Favourite)

| OSI Layer | Layer Name   | Protocols / Technologies               |
| --------- | ------------ | -------------------------------------- |
| 7         | Application  | HTTP, HTTPS, FTP, SSH, DNS, SMTP, SNMP |
| 6         | Presentation | SSL/TLS, JPEG, MPEG, ASCII             |
| 5         | Session      | NetBIOS, RPC, PPTP                     |
| 4         | Transport    | TCP, UDP                               |
| 3         | Network      | IP, ICMP, OSPF, BGP, ARP               |
| 2         | Data Link    | Ethernet, 802.1Q, STP, PPP, HDLC       |
| 1         | Physical     | Cables, Hubs, Repeaters, NIC           |

---

## 📋 QUICK SYLLABUS TOPIC LIST (All Sessions)

| Session | Topics                                                       |
| ------- | ------------------------------------------------------------ |
| 1–2     | Internetworking, OSI Model, Ethernet, Wireless (IEEE 802.11) |
| 3       | Internet Protocol, TCP/IP Model, TCP vs UDP                  |
| 4–5     | IP Subnetting, VLSM                                          |
| 6       | Router IOS, Security Device Manager, Subnetting practice     |
| 7       | Managing Internetworking Router, Telnet, SSH, Debugging      |
| 8       | Static Routing, Dynamic Routing, Routing Protocols           |
| 9–10    | Implementing RIP, IGRP, EIGRP, OSPF                          |
| 11      | Layer 2 Switching, STP, STP types, Priority                  |
| 12      | VLANs, Inter-VLAN Routing, VTP                               |
| 13      | Infrastructure Security, ACL, TACACS+, RADIUS                |
| 14      | NAT, IPv6, WAN Technologies                                  |
| 15      | PPP, MLPPP, PPPoE, GRE, BGP basics                           |
| 16      | SDN Introduction, Architecture, Control vs Data Plane        |
| 17      | Virtual Networking, NFV, Use Cases                           |
| 18      | OpenFlow, OpenDaylight Architecture                          |
| 19      | OpenDaylight Advanced, OVS, Mininet, L2Switch                |
| 20      | AAA + ODL, OVSDB, Group Policy, SFC, LISP, VTN               |

---

_CDAC DITISS — PGCP-ITISS | Fundamentals of Computer Networks | Feb 2026_
_Total: 40T + 40L + 40SL = 120 hrs_

---

## Related Notes

- [[Index|Computer Networks Index]]
- [[01 - OSI Model]]
- [[02 - TCP-IP Model]]
- [[03 - IP Subnetting VLSM IPv4 IPv6 and NDP]]
- [[04A - Network Routing Fundamentals]]
- [[04B - Routing Protocols and Administrative Distance]]
- [[05 - VLANs and Inter-VLAN Routing]]
- [[06 - Network Address Translation]]
- [[08 - Spanning Tree Protocol]]
- [[09 - Infrastructure Security ACL AAA and Port Security]]
- [[11 - Layer 2 Switching and Ethernet Forwarding]]
- [[13 - Router IOS and Management]]
- [[A1 - HTTP Evolution and TLS]]
