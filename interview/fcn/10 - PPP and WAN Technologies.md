---
title: "10 - PPP and WAN Technologies"
aliases:
  - "10. PPP and WAN Technologies"
  - "PPP and WAN Technologies"
tags:
  - computer-networks
  - wan
  - ppp
  - interview-preparation
syllabus-topic:
  - 10
---

# 10. PPP and WAN Technologies

This section covers important WAN technologies used to connect devices, offices, branches, and remote users over long-distance networks.

Main topics:

- PPP
- PAP vs CHAP
- MLPPP
- PPPoE
- GRE tunneling
- MPLS vs traditional WAN
- VPN fundamentals

---

## 10.1 WAN Basics

### What is a WAN?

**WAN (Wide Area Network)** is a network that connects devices or networks over a large geographical area.

Examples:

- Connecting two company branches in different cities
- Connecting an office to a data center
- Connecting a home user to an ISP
- Connecting multiple corporate sites

Example:

```text
Office A
   |
   | WAN
   |
Internet / ISP
   |
   |
Office B
```

A WAN can use technologies such as:

- PPP
- MPLS
- VPN
- leased lines
- broadband
- Metro Ethernet

---

## 10.2 PPP — Point-to-Point Protocol

### What is PPP?

**PPP stands for Point-to-Point Protocol.**

It is a **Layer 2 protocol** used to create a direct communication link between two devices.

It was widely used on:

- Serial WAN links
- Dial-up connections
- Router-to-router links
- DSL connections through PPPoE

Example:

```text
Router A
   |
   | PPP
   |
Router B
```

---

### Main Functions of PPP

PPP provides:

- Link establishment
- Link configuration
- Authentication
- Error detection
- Support for multiple Layer 3 protocols
- Connection termination

Important components:

| Component | Full Form                                   | Purpose                          |
| --------- | ------------------------------------------- | -------------------------------- |
| LCP       | Link Control Protocol                       | Establishes and manages PPP link |
| PAP       | Password Authentication Protocol            | Basic authentication             |
| CHAP      | Challenge Handshake Authentication Protocol | More secure authentication       |
| NCP       | Network Control Protocol                    | Configures Layer 3 protocols     |

---

## 10.3 PPP Connection Process

PPP works approximately like this:

```text
Two Devices
     ↓
Physical Link Available
     ↓
LCP Negotiation
     ↓
Authentication
     ↓
PAP or CHAP
     ↓
NCP Configuration
     ↓
IP Communication
```

---

## 10.4 PAP — Password Authentication Protocol

### What is PAP?

**PAP is a simple PPP authentication method.**

The client sends:

- Username
- Password

to the authenticator.

PAP uses a **2-way handshake**.

```text
Client                       Server
  |                             |
  | Username + Password         |
  |---------------------------->|
  |                             |
  | Accept / Reject             |
  |<----------------------------|
```

---

### PAP Problem

The major weakness is that credentials are sent in a form that can be exposed if the traffic is intercepted.

Therefore:

> PAP provides weak authentication.

---

## 10.5 CHAP — Challenge Handshake Authentication Protocol

### What is CHAP?

**CHAP is a stronger PPP authentication protocol than PAP.**

Instead of directly sending the password, CHAP uses a:

```text
Challenge
   ↓
Response
   ↓
Verification
```

process.

CHAP uses a **3-way handshake**.

---

### CHAP Working

#### Step 1: Server sends a challenge

```text
Client                  Server
  |                        |
  |       Challenge        |
  |<-----------------------|
```

The challenge contains a changing/random value.

#### Step 2: Client calculates a response

The client combines information such as:

```text
Challenge
+
Shared Secret
+
Identifier
```

Then creates a hash response.

```text
Challenge + Secret
       ↓
      Hash
       ↓
    Response
```

#### Step 3: Server verifies it

```text
Client                  Server
  |                        |
  | Hash Response          |
  |----------------------->|
  |                        |
  | Success / Failure      |
  |<-----------------------|
```

The actual password is not sent across the connection.

---

## 10.6 PAP vs CHAP

| Feature                | PAP                              | CHAP                                        |
| ---------------------- | -------------------------------- | ------------------------------------------- |
| Full Form              | Password Authentication Protocol | Challenge Handshake Authentication Protocol |
| Handshake              | 2-way                            | 3-way                                       |
| Password sent directly | Yes                              | No                                          |
| Challenge-response     | No                               | Yes                                         |
| Security               | Weak                             | Better                                      |
| Replay protection      | Weak                             | Better                                      |
| Reauthentication       | Usually no                       | Can be performed                            |
| Preferred              | No                               | Better than PAP                             |

#### Interview-ready answer

> PAP sends the username and password to the server and uses a two-way handshake. CHAP uses a three-way challenge-response process and does not transmit the actual password. Therefore, CHAP is more secure than PAP.

---

## 10.7 MLPPP — Multilink PPP

### What is MLPPP?

**MLPPP stands for Multilink Point-to-Point Protocol.**

It allows multiple physical PPP links to be combined into **one logical connection**.

This is called:

> **Link aggregation**

Example:

Suppose there are two WAN links:

```text
Link 1 = 2 Mbps
Link 2 = 2 Mbps
```

MLPPP can logically combine them:

```text
2 Mbps + 2 Mbps
      ↓
Logical MLPPP Bundle
      ↓
Approximately 4 Mbps total capacity
```

---

## 10.8 Why MLPPP is Needed

A single WAN link may not provide enough bandwidth.

Instead of replacing it with one larger circuit, multiple links can be combined.

Example:

```text
Router A                           Router B

   |------ PPP Link 1 ------------|
   |
   |------ PPP Link 2 ------------|
   |
   |------ PPP Link 3 ------------|
```

MLPPP combines them as:

```text
             MLPPP Bundle
Router A ====================== Router B
```

From a logical point of view, the multiple links behave like one connection.

---

## 10.9 MLPPP Working

Suppose Router A wants to send a large packet.

Instead of sending the complete packet over one link, MLPPP can divide it into smaller fragments.

Example:

```text
Original Packet
+-----------------------------+
|            DATA             |
+-----------------------------+

          ↓ Fragmentation

+---------+ +---------+ +---------+
| Frag 1  | | Frag 2  | | Frag 3  |
+---------+ +---------+ +---------+
```

Fragments can be transmitted across different links.

```text
Router A

Fragment 1 ───── Link 1 ──────►
Fragment 2 ───── Link 2 ──────► Router B
Fragment 3 ───── Link 3 ──────►
```

Router B then rebuilds them.

```text
Fragments
    ↓
Reassembly
    ↓
Original Packet
```

---

## 10.10 MLPPP Full Flow

```text
Application Data
      ↓
IP Packet
      ↓
MLPPP
      ↓
Packet Fragmentation
      ↓
+-----------------------------+
| Link 1 | Link 2 | Link 3    |
+-----------------------------+
      ↓
Remote Router
      ↓
Fragment Reassembly
      ↓
Original Packet
```

---

## 10.11 Benefits of MLPPP

#### 1. Increased Bandwidth

Multiple links provide more total capacity.

Example:

```text
Link 1 = 10 Mbps
Link 2 = 10 Mbps

Total logical capacity ≈ 20 Mbps
```

---

#### 2. Load Distribution

Traffic can be distributed across multiple physical links.

```text
Traffic
   ↓
MLPPP
  / \
 /   \
L1   L2
```

---

#### 3. Better Link Utilization

Instead of leaving one link overloaded and another underused, traffic can be spread over the bundle.

---

#### 4. Redundancy

If one link fails, the remaining links may continue carrying traffic.

Example:

```text
Before Failure

Link 1 ✓
Link 2 ✓
Link 3 ✓
```

If Link 2 fails:

```text
Link 1 ✓
Link 2 ✗
Link 3 ✓
```

Communication may continue with reduced bandwidth.

---

## 10.12 MLPPP Requirements

Normally, the links in an MLPPP bundle should terminate between the same two logical endpoints.

```text
Router A
  | \
  |  \
  |   \
  ↓    ↓
Multiple Links
  ↓    ↓
Router B
```

Both ends must support MLPPP.

---

## 10.13 MLPPP vs Normal PPP

| Feature                    | PPP                 | MLPPP             |
| -------------------------- | ------------------- | ----------------- |
| Number of links            | Usually one         | Multiple          |
| Logical connection         | One physical link   | Bundle of links   |
| Bandwidth                  | Limited to one link | Combined capacity |
| Fragmentation across links | No                  | Yes               |
| Redundancy                 | Limited             | Better            |
| Load sharing               | No                  | Yes               |

#### Interview-ready answer

> MLPPP stands for Multilink PPP. It combines multiple PPP WAN links into one logical bundle. It increases available bandwidth and can distribute packet fragments over several links. If one member link fails, communication may continue using the remaining links with lower bandwidth.

---

## 10.14 MLPPP Example

Suppose a company has:

```text
Branch Office
    |
    | Link 1 = 2 Mbps
    | Link 2 = 2 Mbps
    |
Head Office
```

Without MLPPP:

```text
Each connection works separately.
```

With MLPPP:

```text
          2 Mbps
Branch ===========\
                  \
                   > MLPPP Bundle ≈ 4 Mbps
                  /
Branch ==========/
          2 Mbps
```

This gives more usable total bandwidth between the two routers.

---

## 10.15 PPPoE — Point-to-Point Protocol over Ethernet

### What is PPPoE?

**PPPoE stands for Point-to-Point Protocol over Ethernet.**

It allows PPP communication to run over an Ethernet network.

It has been widely used by ISPs for:

- DSL broadband
- Subscriber authentication
- User session management
- Accounting

---

## 10.16 Why PPPoE Exists

Normal Ethernet does not provide traditional PPP-style user authentication by itself.

ISPs wanted to use PPP features such as:

- Username/password authentication
- Session management
- Customer identification
- Accounting

while using Ethernet infrastructure.

So PPP was carried inside Ethernet.

```text
PPP
  ↓
PPPoE
  ↓
Ethernet
```

---

## 10.17 PPPoE Example

Suppose a home user has:

```text
PC / Router
     ↓
DSL Modem
     ↓
ISP
```

The router may have credentials such as:

```text
Username: customer123
Password: ********
```

These credentials are used to create the PPP session.

Flow:

```text
Home Router
     ↓
PPPoE Session
     ↓
DSL / Ethernet Access Network
     ↓
ISP Access Server
     ↓
Authentication
     ↓
Internet Access
```

---

## 10.18 PPPoE Phases

PPPoE mainly has two phases:

1. **Discovery phase**
2. **Session phase**

---

### Discovery Phase

The client searches for an available PPPoE server.

A simplified flow:

```text
Client
  |
  | PADI
  ↓
Access Concentrator
  |
  | PADO
  ↓
Client
  |
  | PADR
  ↓
Access Concentrator
  |
  | PADS
  ↓
Session Established
```

Common terms:

- **PADI** – PPPoE Active Discovery Initiation
- **PADO** – PPPoE Active Discovery Offer
- **PADR** – PPPoE Active Discovery Request
- **PADS** – PPPoE Active Discovery Session-confirmation

For many interviews, remembering the full message names is optional unless PPPoE is specifically asked in detail.

---

## 10.19 PPPoE Authentication

After the PPPoE session is created, PPP authentication can be used.

Example:

```text
PPPoE Session
    ↓
PPP
    ↓
PAP / CHAP
    ↓
Authentication
    ↓
Internet Access
```

---

## 10.20 Important PPPoE Ports / EtherTypes

PPPoE does not use normal TCP/UDP port numbers for its basic operation.

It uses Ethernet protocol identifiers:

| PPPoE Type | EtherType |
| ---------- | --------- |
| Discovery  | `0x8863`  |
| Session    | `0x8864`  |

---

## 10.21 PPP vs PPPoE

| Feature        | PPP                     | PPPoE                |
| -------------- | ----------------------- | -------------------- |
| Full Form      | Point-to-Point Protocol | PPP over Ethernet    |
| Layer          | Layer 2                 | Layer 2              |
| Used over      | Point-to-point links    | Ethernet             |
| Authentication | PAP/CHAP                | PAP/CHAP through PPP |
| Common Use     | Serial WAN              | DSL / ISP broadband  |

#### Interview-ready answer

> PPPoE stands for Point-to-Point Protocol over Ethernet. It allows ISPs to use PPP features such as authentication, session control, and accounting over Ethernet networks. It is commonly associated with DSL broadband connections.

---

## 10.22 GRE Tunneling

### What is GRE?

**GRE stands for Generic Routing Encapsulation.**

GRE is a tunneling protocol used to carry one network packet inside another IP packet.

Think of it as:

```text
Original Packet
      ↓
Put inside GRE packet
      ↓
Send across IP network
      ↓
Remove GRE header
      ↓
Original Packet recovered
```

---

## 10.23 What is Tunneling?

Tunneling means:

> Encapsulating one packet inside another packet so it can travel across another network.

Example:

```text
Original Packet

[IP Header][Data]

       ↓ GRE Encapsulation

[Outer IP][GRE][Original IP][Data]
```

---

## 10.24 GRE Tunnel Example

Suppose:

```text
Branch A LAN
10.1.0.0/16

Branch B LAN
10.2.0.0/16
```

The branches communicate across the Internet.

```text
10.1.0.0/16
     |
Router A
     |
     |======== GRE Tunnel ========|
     |                            |
  Internet                     Router B
                                  |
                              10.2.0.0/16
```

---

## 10.25 GRE Packet Structure

Simplified packet:

```text
+-------------------------+
| Outer IP Header         |
+-------------------------+
| GRE Header              |
+-------------------------+
| Original IP Header      |
+-------------------------+
| Original Data           |
+-------------------------+
```

---

## 10.26 GRE Source and Destination

The **outer IP header** contains the tunnel endpoint addresses.

Example:

```text
Router A Public IP = 203.0.113.10
Router B Public IP = 198.51.100.20
```

Outer packet:

```text
Source      = 203.0.113.10
Destination = 198.51.100.20
```

Inside it:

```text
Original Source      = 10.1.1.10
Original Destination = 10.2.1.20
```

---

## 10.27 Important Feature of GRE

GRE can carry different protocols through an IP network.

It can also support multicast traffic.

That makes it useful with routing protocols such as:

- OSPF
- EIGRP

in certain tunnel designs.

---

## 10.28 Does GRE Provide Encryption?

**No.**

This is very important.

GRE provides:

```text
Encapsulation ✓
Tunneling     ✓
Encryption    ✗
```

Therefore GRE by itself does **not provide confidentiality**.

An attacker capable of reading the tunnel traffic may still inspect the payload.

---

## 10.29 GRE + IPsec

To provide security, GRE has traditionally been combined with IPsec.

```text
Original Traffic
      ↓
GRE Tunnel
      ↓
IPsec Encryption
      ↓
Internet
```

So:

- GRE provides tunneling
- IPsec provides encryption, integrity, and authentication

Easy memory:

> **GRE creates the tunnel; IPsec secures the tunnel.**

---

## 10.30 GRE Advantages

- Simple tunneling
- Can carry various network protocols
- Supports multicast
- Useful for routing protocols across tunnels
- Can connect remote networks logically

---

## 10.31 GRE Limitations

- Does not provide encryption
- Adds additional headers
- Creates packet overhead
- Can cause MTU/fragmentation issues
- Requires separate security such as IPsec when confidentiality is needed

---

## 10.32 GRE Interview-Ready Answer

> GRE stands for Generic Routing Encapsulation. It creates a logical tunnel by encapsulating the original packet inside a GRE packet and then an outer IP packet. GRE itself does not provide encryption, so it is often combined with IPsec when secure communication is required.

---

## 10.33 MPLS — Multiprotocol Label Switching

### What is MPLS?

**MPLS stands for Multiprotocol Label Switching.**

It is a technology commonly used in service-provider networks to forward traffic using **labels**.

Instead of making every forwarding decision only from the destination IP address, an MPLS network can use a short label.

Simplified idea:

```text
IP Packet
   ↓
Add MPLS Label
   ↓
Provider Network
   ↓
Forward Using Label
   ↓
Remove Label
   ↓
Destination Network
```

---

## 10.34 Traditional IP Routing

In normal IP routing:

```text
Packet
  ↓
Router receives packet
  ↓
Check Destination IP
  ↓
Check Routing Table
  ↓
Find Next Hop
  ↓
Forward
```

This process happens across routers along the path.

---

## 10.35 MPLS Forwarding

With MPLS:

```text
Incoming Packet
      ↓
MPLS Label Added
      ↓
Label = 100
      ↓
Provider Router
      ↓
Forward Based on Label
```

Labels may change at each step.

Example:

```text
Label 100
    ↓
Label 250
    ↓
Label 70
    ↓
Destination
```

This process is called **label switching**.

---

## 10.36 MPLS Basic Devices

Important terminology:

#### PE Router

**Provider Edge Router**

It sits at the edge of the MPLS provider network and connects customers to the provider.

#### P Router

**Provider Router**

It works inside the MPLS core.

#### CE Router

**Customer Edge Router**

It belongs to or serves the customer network and connects to the provider.

Example:

```text
Branch A

LAN
 |
CE
 |
PE
 |
P ---- P
 |
PE
 |
CE
 |
LAN

Branch B
```

---

## 10.37 MPLS Flow

```text
Customer Site A
      |
      CE
      |
      PE
      |
      | Add MPLS Label
      ↓
   MPLS Core
      |
      P
      |
      P
      |
      PE
      |
      | Remove Label
      ↓
      CE
      |
Customer Site B
```

---

## 10.38 Benefits of MPLS

MPLS has historically been popular for enterprise WANs because it can provide:

- Predictable routing
- Traffic engineering
- Quality of Service
- Private provider-managed connectivity
- Support for many branches
- Good performance for voice and video

---

## 10.39 MPLS Does Not Automatically Mean Encryption

This is an important security point.

MPLS can provide traffic separation and private routing within a service provider network.

But:

> **MPLS itself does not automatically encrypt customer traffic.**

If encryption is required, technologies such as IPsec can be added.

---

## 10.40 Traditional WAN

A traditional enterprise WAN could use:

- Leased lines
- Serial links
- Frame Relay historically
- ATM historically
- MPLS services
- Dedicated provider circuits

Example:

```text
Office A
   |
Dedicated WAN
   |
Office B
```

A major limitation is that dedicated private WAN services can be expensive.

---

## 10.41 MPLS vs Traditional Dedicated WAN

| Feature               | MPLS                            | Traditional Dedicated Link       |
| --------------------- | ------------------------------- | -------------------------------- |
| Architecture          | Provider label-switched network | Direct/dedicated circuits        |
| Scalability           | High                            | More difficult as sites increase |
| QoS                   | Strong support                  | Depends on service               |
| Traffic engineering   | Strong                          | More limited                     |
| Provider managed      | Usually yes                     | Usually yes                      |
| Encryption by default | No                              | No                               |
| Cost                  | Can be high                     | Often high                       |
| Multi-site networking | Good                            | Can require many circuits        |

---

## 10.42 MPLS vs Internet VPN

This comparison is also important.

| Feature            | MPLS                             | Internet VPN                |
| ------------------ | -------------------------------- | --------------------------- |
| Underlying network | Service provider private network | Public Internet             |
| Encryption         | Not inherently                   | Commonly encrypted          |
| Cost               | Usually higher                   | Usually lower               |
| Performance        | More predictable                 | Depends on Internet         |
| QoS                | Better provider-level control    | Limited across Internet     |
| Deployment         | Provider dependent               | Easier                      |
| Security           | Traffic separation               | Encryption + authentication |

---

## 10.43 MPLS Interview-Ready Answer

> MPLS stands for Multiprotocol Label Switching. It is mainly used in provider networks to forward traffic using labels instead of relying only on destination IP lookups. MPLS is scalable and supports QoS and traffic engineering. However, MPLS does not inherently encrypt traffic.

---

## 10.44 VPN Fundamentals

### What is a VPN?

**VPN stands for Virtual Private Network.**

A VPN creates a secure logical connection across an untrusted network such as the Internet.

Its main purpose is to protect communication between two endpoints.

Example:

```text
User
 |
 | Encrypted VPN Tunnel
 |
Internet
 |
Company Network
```

---

## 10.45 Main Security Features of a VPN

A secure VPN usually provides:

#### Confidentiality

Traffic is encrypted.

```text
Readable Data
     ↓
Encryption
     ↓
Unreadable Ciphertext
```

#### Integrity

Detects whether data was modified during transmission.

#### Authentication

Verifies the identity of the VPN endpoints or users.

---

## 10.46 Site-to-Site VPN

A **site-to-site VPN** connects entire networks.

Example:

```text
Branch Office                         Head Office

10.1.0.0/16                          10.2.0.0/16
     |                                   |
 Router A                               Router B
     |                                   |
     |====== Encrypted VPN Tunnel =======|
                 Internet
```

Individual computers normally do not need to create separate VPN connections.

The routers/firewalls handle the VPN.

---

### Site-to-Site VPN Use Case

A company has:

- Delhi office
- Mumbai office

Each location has its own LAN.

VPN gateways create a tunnel:

```text
Delhi LAN
   ↓
Delhi Firewall
   ↓
========================
   IPsec VPN Tunnel
========================
   ↓
Mumbai Firewall
   ↓
Mumbai LAN
```

---

## 10.47 Remote-Access VPN

A **remote-access VPN** connects one individual user to an organization's network.

Example:

```text
Employee Laptop
      |
      | VPN Client
      |
      | Encrypted Tunnel
      ↓
Internet
      ↓
Company VPN Gateway
      ↓
Internal Network
```

Common users:

- Work-from-home employees
- Traveling employees
- Administrators
- Contractors

---

## 10.48 Site-to-Site vs Remote-Access VPN

| Feature           | Site-to-Site VPN   | Remote-Access VPN          |
| ----------------- | ------------------ | -------------------------- |
| Connects          | Network to network | User/device to network     |
| Typical endpoints | Routers/firewalls  | VPN client and VPN gateway |
| User action       | Usually none       | User normally connects     |
| Example           | Branch ↔ HQ        | Laptop ↔ Office            |
| Common protocol   | IPsec              | IPsec or TLS-based VPN     |

---

## 10.49 VPN Communication Flow

Example remote-access VPN:

```text
Application
    ↓
Original Packet
    ↓
VPN Client
    ↓
Encrypt
    ↓
Encapsulate
    ↓
Public Internet
    ↓
VPN Server / Gateway
    ↓
Decrypt
    ↓
Original Packet
    ↓
Private Network
```

---

## 10.50 VPN Inner and Outer Packets

Suppose:

```text
Laptop Private IP = 192.168.1.10
VPN Server IP     = 203.0.113.10
Internal Server   = 10.10.10.20
```

Before VPN:

```text
Inner packet:

Source      = 192.168.1.10
Destination = 10.10.10.20
```

After VPN encapsulation:

```text
Outer packet:

Source      = User's public IP
Destination = 203.0.113.10
```

Inside the encrypted tunnel is the original traffic.

```text
[Outer IP]
     |
     +-- Encrypted [
          Inner IP
          TCP/UDP
          Data
        ]
```

---

## 10.51 Full Tunnel vs Split Tunnel

### Full Tunnel

All user Internet traffic goes through the VPN.

```text
Laptop
   |
   | All Traffic
   ↓
VPN Server
   |
   +---- Internal Network
   |
   +---- Internet
```

#### Advantages

- Central security inspection
- Central logging
- Easier policy enforcement

#### Disadvantages

- More VPN bandwidth required
- Can increase latency

---

### Split Tunnel

Only company-related traffic goes through the VPN.

Other Internet traffic goes directly to the Internet.

```text
                   Company Network
                        ↑
                        |
Laptop ---- VPN Tunnel--+
   |
   |
   +--------> Internet
        Direct
```

#### Advantages

- Lower VPN bandwidth usage
- Better Internet performance

#### Disadvantages

- Less centralized traffic control
- Can increase security risk if badly configured

---

## 10.52 GRE vs VPN

| Feature                  | GRE                                       | Secure VPN                  |
| ------------------------ | ----------------------------------------- | --------------------------- |
| Tunneling                | Yes                                       | Yes                         |
| Encryption               | No                                        | Usually yes                 |
| Authentication           | Limited/no inherent secure authentication | Yes                         |
| Integrity                | No strong inherent protection             | Usually yes                 |
| Main Purpose             | Encapsulation                             | Secure communication        |
| Safe alone over Internet | No                                        | Generally intended for this |

---

## 10.53 PPP, MLPPP, PPPoE, GRE, MPLS and VPN Comparison

| Technology | Main Purpose                         | Encryption            | Common Use                                |
| ---------- | ------------------------------------ | --------------------- | ----------------------------------------- |
| PPP        | Point-to-point Layer 2 communication | No                    | Serial links                              |
| PAP        | PPP authentication                   | No                    | Older authentication                      |
| CHAP       | Challenge-response authentication    | No traffic encryption | PPP authentication                        |
| MLPPP      | Combine multiple PPP links           | No                    | WAN link aggregation                      |
| PPPoE      | PPP over Ethernet                    | No by itself          | DSL broadband                             |
| GRE        | Tunneling                            | No                    | Connect networks / carry routed protocols |
| MPLS       | Label-based provider forwarding      | No by itself          | Enterprise/service-provider WAN           |
| VPN        | Secure tunnel                        | Yes, normally         | Site-to-site / remote access              |

---

## 10.54 Complete WAN Technology Overview

```text
                    WAN Technologies
                           |
      +--------------------+--------------------+
      |                    |                    |
     PPP                  MPLS                 VPN
      |                    |                    |
      |                    |                    |
  +---+---+          Label Switching      Secure Tunnel
  |       |                                  |
 PAP     CHAP                          +------+------+
  |       |                            |             |
Weak    Better                   Site-to-Site   Remote Access
Auth     Auth


PPP
 |
 +---- MLPPP
 |       |
 |       +---- Multiple PPP links
 |              ↓
 |          One logical bundle
 |
 +---- PPPoE
         |
         +---- PPP over Ethernet
                ↓
            DSL / ISP


GRE
 |
 +---- Encapsulation / Tunneling
 |
 +---- No encryption
 |
 +---- Can be combined with IPsec
```

---

## 10.55 Common Interview Questions

#### What is MLPPP?

> MLPPP stands for Multilink PPP. It combines multiple PPP links into one logical WAN connection. It provides higher total bandwidth and can distribute traffic fragments across the member links.

#### Why is MLPPP used?

> MLPPP is used to aggregate multiple WAN links to increase bandwidth, improve link utilization, and provide some redundancy if one link fails.

#### What is PPPoE?

> PPPoE means Point-to-Point Protocol over Ethernet. It allows PPP authentication and session management to work over Ethernet and has been commonly used by DSL broadband providers.

#### What is GRE?

> GRE is a tunneling protocol that encapsulates one packet inside another IP packet. It provides tunneling but not encryption, so it can be combined with IPsec when secure communication is required.

#### Does GRE encrypt data?

> No. GRE only provides encapsulation. It does not provide confidentiality by itself.

#### What is MPLS?

> MPLS is a provider-network technology that forwards traffic using labels. It supports scalable WAN connectivity, traffic engineering, and QoS.

#### Does MPLS encrypt traffic?

> No. MPLS provides traffic separation and controlled forwarding, but it does not inherently encrypt the traffic.

#### What is a site-to-site VPN?

> A site-to-site VPN creates an encrypted tunnel between two networks, such as a branch office and headquarters.

#### What is a remote-access VPN?

> A remote-access VPN securely connects an individual user's device to an organization's network through the Internet.

---

## 10.56 Quick Revision Sheet

```text
PPP
→ Layer 2 point-to-point protocol
→ LCP establishes link
→ PAP / CHAP authenticate
→ NCP configures network protocol

PAP
→ 2-way handshake
→ Sends username/password
→ Weak

CHAP
→ 3-way handshake
→ Challenge-response
→ Password not directly transmitted
→ Better than PAP

MLPPP
→ Multilink PPP
→ Combines multiple PPP links
→ Link aggregation
→ More bandwidth
→ Can survive one link failure with reduced capacity

PPPoE
→ PPP over Ethernet
→ Common with DSL
→ Authentication/session management for ISP customers

GRE
→ Generic Routing Encapsulation
→ Creates logical tunnel
→ No encryption
→ Often paired with IPsec

MPLS
→ Multiprotocol Label Switching
→ Label-based forwarding
→ Provider WAN
→ QoS and traffic engineering
→ No inherent encryption

VPN
→ Virtual Private Network
→ Secure encrypted tunnel
→ Site-to-site = network to network
→ Remote access = user to network
```

### Most important exam point

```text
PPP       → Point-to-point communication
MLPPP     → Multiple PPP links combined
PPPoE     → PPP carried over Ethernet
GRE       → Tunneling without encryption
MPLS      → Label-based WAN forwarding
VPN       → Secure encrypted tunnel
```

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[01A - OSI Model]]
- [[04A - Network Routing Fundamentals]]
