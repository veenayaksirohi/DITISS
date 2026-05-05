
---

# 🔐 1. What is Infrastructure Security?

Infrastructure security focuses on protecting the core components of a network, including:

1. Routers
2. Switches
3. Firewalls
4. Servers
5. and the data moving across them

The goal is to ensure:

1. Confidentiality (no unauthorized access)
2. Integrity (data isn’t altered)
3. Availability (systems stay up and running)

---

# 🧠 2. Key Ideas

## 2.1 Defense in Depth

Multiple layers of protection:

1. Firewalls + IDS/IPS
2. Access control + authentication
3. Network segmentation + encryption

👉 If one layer fails, others still protect the system.

---

# 🧩 3. The Three Security Planes

1. Control plane security → protect routing/switching logic
2. Data plane security → protect actual traffic
3. Management plane security → protect admin access

---

| Security Plane               | Description                                                        | Examples                                                                   | Threats                                                                              | Protections                                                                                                                                                            |
| ---------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔵 Control Plane Security    | This protects the brain of the network—how devices make decisions. | 1. Routing protocols (OSPF, BGP)<br>2. ARP tables<br>3. MAC address tables | 1. Route injection attacks<br>2. ARP spoofing<br>3. Control plane flooding           | 1. Routing protocol authentication<br>2. Control Plane Policing (CoPP)<br>3. Disable unused services                                                                   |
| 🟢 Data Plane Security       | This protects the actual traffic flow (user data).                 | —                                                                          | 1. Packet sniffing<br>2. DDoS attacks<br>3. Packet injection                         | 1. ACLs (Access Control Lists)<br>2. Encryption (IPsec, TLS)<br>3. Anti-DDoS mechanisms<br>4. Network segmentation (VLANs)                                             |
| 🟡 Management Plane Security | This protects how administrators access and control devices.       | —                                                                          | 1. Unauthorized admin access<br>2. Brute-force login attacks<br>3. Misconfigurations | 1. Use secure protocols (SSH instead of Telnet)<br>2. Strong authentication (MFA)<br>3. Role-Based Access Control (RBAC)<br>4. Logging and monitoring (Syslog, SNMPv3) |

# ⚠️ 7. Why This Matters

If infrastructure is compromised:

1. Attackers can reroute traffic
2. Intercept sensitive data
3. Shut down entire networks

👉 This is why infrastructure security is considered critical in enterprise and cloud environments

---

# 🚨 8. Common Threats

1. MAC flooding
2. ARP spoofing
3. DHCP attacks
4. Unauthorized access

---

# 🔴 9. MAC Flooding

### 9.1 What it is

An attacker floods a switch with fake MAC addresses until its MAC table is full.

### 9.2 What happens

The switch can’t learn new addresses → starts behaving like a hub → sends traffic to all ports → attacker can sniff data.

### 9.3 Mitigation

1. Port security (limit MAC addresses per port)
2. Sticky MAC binding
3. Shutdown or restrict suspicious ports

---

# 🔴 10. ARP Spoofing (ARP Poisoning)

### 10.1 What it is

Attacker sends fake ARP messages to link their MAC address with another device’s IP (like the gateway).

### 10.2 What happens

Traffic gets redirected through the attacker → enables Man-in-the-Middle attacks

### 10.3 Mitigation

1. Dynamic ARP Inspection (DAI)
2. Static ARP entries (in critical systems)
3. VLAN segmentation

---

# 🔴 11. DHCP Attacks

## 11.1 Two common types

### a) DHCP Starvation

#### What it is

Attacker sends many fake requests to exhaust the DHCP pool.

#### Result

Legitimate users can’t get IP addresses → denial of service

---

### b) Rogue DHCP Server

#### What it is

Attacker sets up a fake DHCP server.

#### Result

Users get wrong network settings → traffic redirected to attacker

---

### 11.2 Mitigation

1. DHCP Snooping
2. Port-based trust (only allow DHCP server on trusted ports)
3. Rate limiting DHCP requests

---

# 🔴 12. Unauthorized Access

### 12.1 What it is

Unapproved devices or users gain access to the network.

### 12.2 Examples

1. Plugging into an open switch port
2. Weak passwords on admin interfaces

### 12.3 Mitigation

1. 802.1X authentication
2. Strong passwords + MFA
3. Network Access Control (NAC)
4. Disable unused ports

---

# 🔑 13. Key Insight

All these attacks exploit one thing:

👉 Lack of validation in basic network protocols

Protocols like ARP and DHCP were designed for trusted environments—not modern hostile networks.

---

# 🛡️ 14. Protection Methods

1. Port security
2. ACLs
3. AAA (TACACS+/RADIUS)
4. Device hardening

---

# 🧱 15. Protection Methods (Summary)

## 15.1 Port Security

Restricts which devices can connect to a switch port (based on MAC addresses) → prevents unauthorized access and MAC flooding

## 15.2 ACLs (Access Control Lists)

Filter network traffic based on IP, protocol, or port → blocks unwanted or malicious traffic

## 15.3 AAA (Authentication, Authorization, Accounting)

Controls and monitors user access

1. Authentication: verifies identity
2. Authorization: defines permissions
3. Accounting: logs user activity

Uses protocols like TACACS+ and RADIUS

## 15.4 Device Hardening

Securing network devices by:

1. Disabling unused services/ports
2. Using strong passwords
3. Enabling secure management (SSH)

→ reduces attack surface

---

# 🔑 16. Key Idea

These methods enforce control, restrict access, and reduce vulnerabilities across network infrastructure.

---

# 📜 17. ACL (Access Control List)

## 17.1 Key Points to Remember

1. ACLs are processed top to bottom
2. First match is applied
3. Implicit deny all at the end
4. Placement matters:

   * Standard → near destination
   * Extended → near source
---

## 17.2 Definition

ACLs are rules applied on routers/switches to permit or deny traffic.

An Access Control List (ACL) is a set of rules used in networking to control which traffic is allowed or denied on a device (like a router or switch). It acts like a filter that checks packets and decides whether they should pass or be blocked based on conditions such as IP address, protocol, or port number.

---

## 17.3 Uses

1. Enhancing network security
2. Controlling traffic flow
3. Filtering unwanted packets
4. Restricting access to resources

---

# 🔷 18. Types of ACL

## 18.1 Standard ACL

1. Filters traffic based only on source IP address only
2. Simpler and less flexible
3. Usually placed close to the destination

👉 Example use: Allow only a specific network to access a server

---

## 18.2 Extended ACL

1. More precise control
2. Usually placed close to the source

Filters based on:

1. Source IP
2. Destination IP
3. Protocol (TCP/UDP/ICMP)
4. Port numbers

---

## 18.3 IPv6 ACL

Same concept but for IPv6 addressing

---

## 18.4 Example

permit tcp 192.168.1.0 0.0.0.255 any eq 80
deny ip any any

👉 Meaning:

1. Allow HTTP traffic from network
2. Block everything else

---

# 📊 19. Standard vs Extended ACL

| Feature                  | Standard ACL                                  | Extended ACL                                               |
| ------------------------ | --------------------------------------------- | ---------------------------------------------------------- |
| Filtering Criteria       | Only Source IP address                        | Source IP, Destination IP, Protocol, Port                  |
| Level of Control         | Basic / Less flexible                         | Advanced / Highly flexible                                 |
| Placement Rule           | Close to Destination                          | Close to Source                                            |
| Why Placement Matters    | May block valid traffic if placed near source | Stops unwanted traffic early                               |
| Protocol Filtering       | ❌ Not possible                                | ✅ TCP, UDP, ICMP etc.                                      |
| Port Filtering           | ❌ Not possible                                | ✅ (e.g., HTTP – 80, HTTPS – 443)                           |
| Traffic Granularity      | Broad filtering                               | Fine-grained filtering                                     |
| ACL Number Range         | 1–99, 1300–1999                               | 100–199, 2000–2699                                         |
| Configuration Complexity | Simple                                        | More complex                                               |
| Performance Impact       | Lower processing                              | Slightly higher (more checks)                              |
| Use Case Example         | Allow one network to access server            | Allow HTTP but block FTP                                   |
| Typical Command Style    | access-list 1 permit 192.168.1.0 0.0.0.255    | access-list 100 permit tcp 192.168.1.0 0.0.0.255 any eq 80 |
| Default Behavior         | Implicit deny all                             | Implicit deny all                                          |
| Best Use Scenario        | Simple filtering needs                        | Security + traffic control                                 |
| IPv6 Support             | Limited / separate config                     | Fully supported with IPv6 ACLs                             |

---

# 🧠 20. Quick Memory Trick

1. Standard = Simple = Source only = Destination placement
2. Extended = Extra control = Source + Destination + Ports = Source placement

---

# 🎯 21. Traffic Granularity (in ACLs)

Traffic granularity means how detailed or precise your control over network traffic is.

| ACL Type     | Traffic Granularity  |
| ------------ | -------------------- |
| Standard ACL | Low (Coarse-grained) |
| Extended ACL | High (Fine-grained)  |

👉 Standard ACL → Like a guard who only checks who you are
👉 Extended ACL → Like a guard who checks who you are, where you’re going, and what you’re doing

---

# 🏷️ 22. Named ACL (Access Control List)

A Named ACL is just an Access Control List where you use a name instead of a number to identify it.

---

## 22.1 Example

access-list 100 permit ip any any
ip access-list extended BLOCK_WEB

---

## 22.2 Explanation

Numbered ACLs work fine, but they’re hard to manage in large networks. Named ACLs solve that by making configs readable and editable.

👉 Example names:

1. BLOCK_HTTP
2. ALLOW_OFFICE
3. SECURITY_POLICY

---

## 22.3 Types of Named ACL

1. Standard Named ACL
2. Extended Named ACL

---

## 22.4 Comparison

| Feature              | Named ACL | Numbered ACL  |
| -------------------- | --------- | ------------- |
| Identification       | Name      | Number        |
| Readability          | High      | Low           |
| Editing              | Easy      | Difficult     |
| Sequence Control     | Yes       | Limited       |
| Use in Real Networks | Preferred | Legacy/simple |

---

# 🔄 23. Advanced ACL Types

## 23.1 Dynamic ACL (Lock-and-Key)

1. Allows temporary access based on authentication
2. More secure but complex

---

## 23.2 Reflexive ACL

1. Allows return traffic for initiated sessions
2. Works somewhat like a basic firewall

---

## 23.3 Time-Based ACL

1. Applies rules based on time (e.g., only during office hours)

---

## 23.4 Comparison Table

| Feature         | Dynamic ACL          | Reflexive ACL             | Time-Based ACL       |
| --------------- | -------------------- | ------------------------- | -------------------- |
| Trigger         | User login           | Outgoing traffic          | Time                 |
| Security Type   | Authentication-based | Session-based             | Schedule-based       |
| Temporary Rules | Yes                  | Yes                       | No (time controlled) |
| Use Case        | Remote secure access | Allow return traffic only | Office policies      |
| Complexity      | High                 | Medium                    | Low                  |

---
