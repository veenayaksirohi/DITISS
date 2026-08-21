# Wireshark & Traffic Analysis — Detailed Notes

## 1. What is Wireshark?

**Wireshark** is a network packet capture and packet analysis tool.

It allows us to capture network traffic from an interface and inspect packets in detail.

Wireshark can help analyze:

- TCP
- UDP
- DNS
- HTTP
- TLS
- ICMP
- ARP
- DHCP
- SSH-related connections
- Many other protocols

### Simple Definition

> **Wireshark is a graphical packet analyzer used to capture and inspect network traffic for troubleshooting, security analysis, and protocol study.**

Basic flow:

```text
Network Traffic
      ↓
Network Interface
      ↓
Wireshark Capture
      ↓
Packets
      ↓
Protocol Analysis
      ↓
Troubleshooting / Security Investigation
```

---

# 2. Why is Wireshark Used?

Wireshark is useful for:

- Finding network connectivity problems
- Checking whether packets reach a server
- Analyzing TCP connections
- Troubleshooting DNS
- Finding retransmissions
- Finding connection resets
- Detecting unusual network traffic
- Analyzing suspicious packets
- Learning network protocols
- Investigating security incidents

Example:

```text
User says:
"Website is very slow."

        ↓

Capture traffic using Wireshark

        ↓

Check:
DNS
TCP handshake
TLS handshake
Retransmissions
Server response
```

---

# 3. What is Packet Capture?

**Packet capture** means recording network packets that pass through a network interface.

For example:

```text
Laptop
   ↓
Network Interface
   ↓
Wireshark
   ↓
Capture Packets
```

A captured packet may contain information such as:

- Source MAC address
- Destination MAC address
- Source IP
- Destination IP
- Protocol
- Source port
- Destination port
- Flags
- Sequence numbers
- Payload

---

# 4. What is Packet Analysis?

**Packet analysis** means examining captured packets to understand what happened on the network.

Example:

Suppose:

```text
Client cannot reach Web Server
```

Packet analysis may show:

```text
Client → SYN → Server
```

but no:

```text
Server → SYN-ACK → Client
```

This tells us:

> The client sent the connection request, but no response returned.

Possible reasons:

- Firewall blocking
- Server down
- Port closed
- Routing problem
- Packet lost

---

# 5. Packet Capture vs Packet Analysis

| Packet Capture                | Packet Analysis                       |
| ----------------------------- | ------------------------------------- |
| Records packets               | Examines packets                      |
| First step                    | Investigation step                    |
| Collects network traffic      | Finds problems or suspicious behavior |
| Wireshark/tcpdump can capture | Wireshark is very good for analysis   |

---

# 6. Wireshark Interface Capture

Before capturing traffic, Wireshark asks which network interface should be monitored.

Examples:

- Ethernet
- Wi-Fi
- Loopback
- VPN interface
- Virtual machine interface

Example:

```text
PC
├── Ethernet
├── Wi-Fi
└── VPN

Choose Wi-Fi
     ↓
Only traffic visible on that interface is captured
```

### Important

> If you select the wrong interface, you may capture no useful traffic.

---

# 7. Wireshark Packet View

Wireshark normally shows packet information in three main sections.

### Packet List

Shows packets such as:

```text
No.  Time  Source  Destination  Protocol  Info
```

### Packet Details

Shows protocol layers:

```text
Ethernet
   ↓
IP
   ↓
TCP
   ↓
TLS / HTTP
```

### Packet Bytes

Shows the raw packet data in hexadecimal and ASCII form.

---

# 8. Protocol Layers in Wireshark

Example HTTPS packet:

```text
Ethernet
   ↓
IPv4
   ↓
TCP
   ↓
TLS
   ↓
Encrypted Application Data
```

Example DNS query:

```text
Ethernet
   ↓
IPv4
   ↓
UDP
   ↓
DNS
```

---

# 9. Capture Filter

A **Capture Filter** controls which packets Wireshark captures.

It is applied:

> **Before packets are stored.**

Example:

```text
All Network Traffic
       ↓
Capture Filter
       ↓
Only Matching Traffic Captured
```

If you capture only TCP port 443:

```text
Other Traffic → Not captured

TCP 443 → Captured
```

---

# 10. Why Use Capture Filters?

Capture filters are useful when:

- Network traffic is very large
- You only need one host
- You only need one protocol
- You only need a specific port
- You want a smaller capture file

Example:

Instead of capturing:

```text
100,000 packets
```

you may capture only:

```text
Traffic to/from 192.168.1.10
```

---

# 11. Capture Filter Examples

Wireshark capture filters use **BPF-style syntax**.

### Capture traffic from/to a host

```text
host 192.168.1.10
```

### TCP only

```text
tcp
```

### UDP only

```text
udp
```

### TCP port 443

```text
tcp port 443
```

### DNS port 53

```text
port 53
```

### Source host

```text
src host 192.168.1.10
```

### Destination host

```text
dst host 192.168.1.20
```

---

# 12. Display Filter

A **Display Filter** controls which packets are displayed from an already captured set of packets.

It is applied:

> **After capture.**

Example:

```text
Captured:
TCP
UDP
DNS
TLS
ICMP
HTTP

        ↓
Display Filter:
dns

        ↓
Only DNS packets shown
```

The other packets are still present in the capture file.

---

# 13. Why Use Display Filters?

Display filters help during analysis.

For example, you captured 50,000 packets.

You want only traffic involving:

```text
192.168.1.10
```

Use:

```text
ip.addr == 192.168.1.10
```

Now Wireshark only displays those matching packets.

---

# 14. Capture Filter vs Display Filter

This is a very important interview question.

| Capture Filter            | Display Filter                   |
| ------------------------- | -------------------------------- |
| Applied before capture    | Applied after capture            |
| Controls what is recorded | Controls what is displayed       |
| Reduces capture size      | Does not remove captured packets |
| Uses BPF syntax           | Uses Wireshark display syntax    |
| Example: `tcp port 443`   | Example: `tcp.port == 443`       |

### Easy Memory

```text
Capture Filter
→ Before capture

Display Filter
→ After capture
```

---

# 15. Important Difference in Syntax

This is important.

### Capture Filter

```text
tcp port 443
```

### Display Filter

```text
tcp.port == 443
```

They look similar but use different syntax.

Do not confuse them.

---

# 16. Common Wireshark Display Filters

## TCP

```text
tcp
```

Shows TCP packets.

---

## UDP

```text
udp
```

Shows UDP packets.

---

## DNS

```text
dns
```

Shows packets Wireshark recognizes as DNS.

---

## HTTP

```text
http
```

Shows plaintext HTTP traffic recognized by Wireshark.

---

## TLS

```text
tls
```

Shows TLS traffic.

---

## ICMP

```text
icmp
```

Shows IPv4 ICMP traffic.

For IPv6 ICMP:

```text
icmpv6
```

---

# 17. Filter by IP Address

```text
ip.addr == 192.168.1.10
```

Meaning:

> Show packets where `192.168.1.10` is either source or destination.

For source only:

```text
ip.src == 192.168.1.10
```

For destination only:

```text
ip.dst == 192.168.1.10
```

---

# 18. Filter by TCP Port

```text
tcp.port == 443
```

Meaning:

> Show TCP packets where source or destination port is 443.

Destination only:

```text
tcp.dstport == 443
```

Source only:

```text
tcp.srcport == 443
```

---

# 19. Combine Display Filters

You can combine conditions.

Example:

```text
ip.addr == 192.168.1.10 && tcp.port == 443
```

Meaning:

> Show TCP port 443 traffic involving `192.168.1.10`.

Another example:

```text
dns || icmp
```

Meaning:

> Show DNS or ICMP packets.

---

# 20. TCP Packets

**TCP** is a reliable, connection-oriented transport protocol.

Wireshark can show:

- SYN
- SYN-ACK
- ACK
- FIN
- RST
- Sequence numbers
- Acknowledgment numbers
- Window size
- Retransmissions

Example:

```text
Client
   ↓
TCP
   ↓
Server
```

---

# 21. TCP Three-Way Handshake

TCP normally establishes a connection using a **three-way handshake**.

```text
Client                          Server

   SYN ------------------------>

       <---------------- SYN-ACK

   ACK ------------------------>

Connection Established
```

### Step 1 — SYN

Client says:

> "I want to start a TCP connection."

```text
Client → SYN → Server
```

### Step 2 — SYN-ACK

Server says:

> "I received your request and I am ready."

```text
Server → SYN-ACK → Client
```

### Step 3 — ACK

Client confirms:

```text
Client → ACK → Server
```

Now the connection is established.

---

# 22. TCP Handshake in Wireshark

A TCP handshake may appear as:

```text
192.168.1.10 → 10.0.0.20   SYN
10.0.0.20 → 192.168.1.10   SYN, ACK
192.168.1.10 → 10.0.0.20   ACK
```

You can analyze:

- Whether server responded
- How long handshake took
- Whether a reset occurred
- Whether packets were retransmitted

---

# 23. Useful TCP Flag Filters

Show SYN packets:

```text
tcp.flags.syn == 1
```

Show reset packets:

```text
tcp.flags.reset == 1
```

A more specific initial SYN filter can use:

```text
tcp.flags.syn == 1 && tcp.flags.ack == 0
```

---

# 24. TCP RST

**RST** means **Reset**.

It immediately terminates or refuses a TCP connection.

Example:

```text
Client → SYN → Server
Server → RST → Client
```

This may mean:

- Port is closed
- Application rejected connection
- Connection was forcibly terminated

---

# 25. TCP FIN

**FIN** is used for normal TCP connection termination.

Example:

```text
Client → FIN
Server → ACK

Server → FIN
Client → ACK
```

This is a graceful connection close.

---

# 26. TCP Retransmission

TCP retransmits data when packets appear lost or are not acknowledged in time.

Wireshark may show:

```text
TCP Retransmission
```

A large number of retransmissions may indicate:

- Packet loss
- Congestion
- Wireless problems
- Bad network link
- Overloaded device

---

# 27. UDP Packets

**UDP** is connectionless.

Unlike TCP, UDP does not use a three-way handshake.

Flow:

```text
Client
   ↓ UDP packet
Server
```

There is no:

```text
SYN
SYN-ACK
ACK
```

before data transmission.

---

# 28. TCP vs UDP in Wireshark

| TCP                          | UDP                              |
| ---------------------------- | -------------------------------- |
| Connection-oriented          | Connectionless                   |
| Three-way handshake          | No handshake                     |
| Reliable delivery mechanisms | No delivery guarantee            |
| Retransmission               | No built-in retransmission       |
| Sequence numbers             | No TCP-style sequence numbers    |
| Example: HTTPS               | Example: traditional DNS queries |

---

# 29. DNS Packets

**DNS** converts domain names into IP addresses.

Example:

```text
www.example.com
       ↓
DNS
       ↓
93.184.216.34
```

Traditional DNS commonly uses:

```text
UDP 53
```

and can also use:

```text
TCP 53
```

for certain cases.

---

# 30. DNS Packet Flow

```text
Client
  ↓
DNS Query:
"What is the IP of example.com?"
  ↓
DNS Server
  ↓
DNS Response:
"93.184.216.34"
```

---

# 31. DNS Analysis with Wireshark

Display filter:

```text
dns
```

You can inspect:

- Query name
- Query type
- Response
- Returned IP
- Error codes
- Response time

Example:

```text
Query:
example.com

Type:
A

Response:
93.184.216.34
```

---

# 32. DNS Query Types

Common DNS records include:

| Type  | Purpose          |
| ----- | ---------------- |
| A     | IPv4 address     |
| AAAA  | IPv6 address     |
| MX    | Mail server      |
| NS    | Name server      |
| CNAME | Alias            |
| PTR   | Reverse DNS      |
| TXT   | Text information |

---

# 33. DNS Troubleshooting Example

Problem:

```text
Website cannot open
```

First check DNS.

```text
Client
   ↓
DNS Query
   ↓
Response?
```

If no DNS response appears:

Possible issue:

- DNS server unreachable
- Firewall blocking DNS
- Wrong DNS server
- DNS server down

---

# 34. Important Note About Encrypted DNS

Modern DNS may also use encrypted protocols such as:

- DNS over HTTPS (DoH)
- DNS over TLS (DoT)

So not every DNS request will necessarily appear as normal readable UDP/TCP port 53 traffic.

---

# 35. HTTP Packets

**HTTP** is used for web communication.

Traditional HTTP uses:

```text
TCP 80
```

Example:

```text
Client
   ↓
HTTP GET
   ↓
Web Server
```

Example request concept:

```text
GET /index.html
```

Server may respond:

```text
HTTP 200 OK
```

---

# 36. HTTP Display Filter

```text
http
```

This displays plaintext HTTP traffic recognized by Wireshark.

You can inspect:

- Request method
- URL/path
- Headers
- Status code
- Response
- Content, when unencrypted

---

# 37. Common HTTP Methods

- GET
- POST
- PUT
- DELETE
- HEAD
- OPTIONS
- PATCH

Example:

```text
GET /login
```

---

# 38. Common HTTP Status Codes

| Code | Meaning               |
| ---: | --------------------- |
|  200 | OK                    |
|  301 | Permanent redirect    |
|  302 | Temporary redirect    |
|  400 | Bad request           |
|  401 | Unauthorized          |
|  403 | Forbidden             |
|  404 | Not found             |
|  500 | Internal server error |
|  502 | Bad gateway           |
|  503 | Service unavailable   |

---

# 39. HTTP vs HTTPS in Wireshark

HTTP:

```text
Client
   ↓
HTTP
   ↓
Server
```

Content can usually be read directly.

HTTPS:

```text
Client
   ↓
TLS Encryption
   ↓
Server
```

Application content is encrypted.

So when browsing an HTTPS website, Wireshark commonly shows:

```text
TCP
TLS
Encrypted Application Data
```

instead of readable HTTP content.

---

# 40. TLS Packets

**TLS** stands for **Transport Layer Security**.

It provides encryption for protocols such as HTTPS.

Common HTTPS traffic uses:

```text
TCP 443
```

although modern HTTP/3 uses QUIC over UDP rather than traditional TCP+TLS.

---

# 41. TLS Traffic Flow

Simplified:

```text
Client
   ↓
TCP Connection
   ↓
TLS Handshake
   ↓
Encryption Keys Established
   ↓
Encrypted Application Data
```

---

# 42. TLS Analysis in Wireshark

Display filter:

```text
tls
```

You may see:

- Client Hello
- Server Hello
- Certificates
- TLS version
- Cipher suite
- Encrypted application data

Depending on TLS version and configuration, not all handshake details remain visible in the same way.

---

# 43. TLS Client Hello

The client begins TLS negotiation.

Conceptually:

```text
Client
   ↓
Client Hello
   ↓
Server
```

It contains information used to negotiate the secure connection, such as supported TLS options.

---

# 44. TLS Server Hello

The server responds:

```text
Server
   ↓
Server Hello
   ↓
Client
```

The connection then continues with the negotiated TLS process.

---

# 45. TLS Troubleshooting

If HTTPS is not working, examine:

```text
DNS
 ↓
TCP Handshake
 ↓
TLS Handshake
 ↓
Application Traffic
```

Example:

```text
DNS works
TCP works
TLS fails
```

This points toward a TLS/certificate/security negotiation issue rather than basic connectivity.

---

# 46. ICMP Packets

**ICMP** is used for network diagnostics and error reporting.

A common command:

```bash
ping 8.8.8.8
```

uses ICMP Echo messages for IPv4.

Flow:

```text
Host A
   ↓
ICMP Echo Request
   ↓
Host B
   ↓
ICMP Echo Reply
   ↓
Host A
```

---

# 47. ICMP in Wireshark

Display filter:

```text
icmp
```

You can see:

- Echo Request
- Echo Reply
- Destination Unreachable
- Time Exceeded

---

# 48. Ping Analysis Example

If you see:

```text
Echo Request
Echo Reply
```

basic IP communication works.

If you see:

```text
Echo Request
```

but no reply:

Possible reasons:

- Host unavailable
- Firewall blocking
- Routing problem
- ICMP disabled

---

# 49. Basic Website Traffic Analysis

Suppose a user opens:

```text
https://example.com
```

Typical flow:

```text
1. DNS Query
      ↓
2. DNS Response
      ↓
3. TCP SYN
      ↓
4. TCP SYN-ACK
      ↓
5. TCP ACK
      ↓
6. TLS Handshake
      ↓
7. Encrypted HTTPS Traffic
```

This flow is extremely useful in interviews.

---

# 50. Website Troubleshooting Flow

```text
Website Not Working
        ↓
DNS Working?
   /          \
 No           Yes
 ↓             ↓
Fix DNS    TCP handshake?
               ↓
          SYN-ACK received?
             /       \
           No         Yes
           ↓           ↓
    Network/Firewall   TLS works?
                          ↓
                     Application works?
```

---

# 51. Security Analysis with Wireshark

Wireshark can help find:

- Port scans
- Repeated connection attempts
- ICMP floods
- DNS anomalies
- Suspicious TCP resets
- Unexpected external connections
- Cleartext credentials in insecure protocols
- Abnormal traffic volume

But Wireshark is primarily an analysis tool, not an automatic attack-blocking system.

---

# 52. What is tcpdump?

**tcpdump** is a command-line packet capture and analysis tool.

It is widely used on Linux and Unix-like systems.

### Simple Definition

> **tcpdump is a command-line tool used to capture and inspect network packets from a network interface.**

Example:

```bash
tcpdump -i eth0
```

Meaning:

> Capture packets on interface `eth0`.

---

# 53. Why Use tcpdump?

tcpdump is useful because:

- It runs from terminal
- No GUI is required
- Good for remote Linux servers
- Lightweight
- Excellent for SSH sessions
- Supports powerful capture filters
- Can save packets into `.pcap` files
- Capture files can later be opened in Wireshark

---

# 54. Headless Server Troubleshooting

A **headless server** is a server without a graphical desktop.

Example:

```text
Cloud Linux Server
       ↓
SSH Terminal Only
```

Wireshark GUI may not be practical there.

Use:

```bash
tcpdump
```

Example:

```bash
tcpdump -i eth0
```

Then save the capture and analyze it later with Wireshark if needed.

---

# 55. List Interfaces with tcpdump

```bash
tcpdump -D
```

This lists interfaces available for packet capture.

Example:

```text
1.eth0
2.lo
3.any
```

---

# 56. Capture from an Interface

```bash
tcpdump -i eth0
```

Meaning:

```text
Listen on eth0
   ↓
Capture packets
   ↓
Display them in terminal
```

---

# 57. Capture All Interfaces

On supported systems:

```bash
tcpdump -i any
```

This is useful when you do not know which interface carries the traffic.

---

# 58. Avoid Name Resolution

Useful command:

```bash
tcpdump -n -i eth0
```

`-n` prevents tcpdump from converting IP addresses to hostnames.

This often makes output faster and clearer.

A commonly useful option is:

```bash
tcpdump -nn -i eth0
```

This also avoids converting port numbers to service names.

---

# 59. Capture a Specific Host

```bash
tcpdump -i eth0 host 192.168.1.10
```

Meaning:

> Capture traffic involving `192.168.1.10`.

---

# 60. Capture Source Host

```bash
tcpdump -i eth0 src host 192.168.1.10
```

Only packets coming from that host.

---

# 61. Capture Destination Host

```bash
tcpdump -i eth0 dst host 192.168.1.10
```

Only packets going to that host.

---

# 62. Capture TCP Traffic

```bash
tcpdump -i eth0 tcp
```

---

# 63. Capture UDP Traffic

```bash
tcpdump -i eth0 udp
```

---

# 64. Capture ICMP Traffic

```bash
tcpdump -i eth0 icmp
```

Very useful when troubleshooting ping.

---

# 65. Capture Specific Port

Example SSH:

```bash
tcpdump -i eth0 port 22
```

HTTPS:

```bash
tcpdump -i eth0 port 443
```

DNS:

```bash
tcpdump -i eth0 port 53
```

---

# 66. Capture TCP Port 443

```bash
tcpdump -i eth0 tcp port 443
```

This captures only TCP traffic involving port 443.

---

# 67. Combine tcpdump Filters

Example:

```bash
tcpdump -i eth0 host 192.168.1.10 and port 443
```

Meaning:

> Capture traffic involving `192.168.1.10` and port 443.

Another:

```bash
tcpdump -i eth0 tcp and port 22
```

---

# 68. Save Packet Capture

Use:

```bash
tcpdump -i eth0 -w capture.pcap
```

`-w` means:

> Write packets to a file.

File:

```text
capture.pcap
```

can later be opened in Wireshark.

Flow:

```text
Linux Server
   ↓
tcpdump
   ↓
capture.pcap
   ↓
Wireshark
   ↓
Detailed Analysis
```

---

# 69. Read a Saved Capture

```bash
tcpdump -r capture.pcap
```

`-r` means:

> Read packets from a capture file.

---

# 70. Capture Limited Number of Packets

```bash
tcpdump -i eth0 -c 100
```

This captures:

```text
100 packets
```

then exits.

---

# 71. Save Only Relevant Traffic

Example:

```bash
tcpdump -i eth0 tcp port 443 -w https.pcap
```

This captures TCP port 443 traffic and writes it to:

```text
https.pcap
```

---

# 72. tcpdump vs Wireshark

Very important interview question.

| tcpdump                        | Wireshark                            |
| ------------------------------ | ------------------------------------ |
| Command-line tool              | GUI-based packet analyzer            |
| Very lightweight               | More feature-rich visually           |
| Good for servers               | Good for desktop analysis            |
| Excellent over SSH             | Best with graphical environment      |
| Captures packets               | Captures + deep interactive analysis |
| Uses BPF capture filters       | Supports capture + display filters   |
| Saves `.pcap` files            | Opens and analyzes `.pcap` files     |
| Good for quick troubleshooting | Good for detailed investigation      |

### Easy Memory

```text
tcpdump
→ Capture from terminal

Wireshark
→ Deep graphical analysis
```

---

# 73. Using tcpdump and Wireshark Together

A common real-world workflow:

```text
Production Linux Server
       ↓
tcpdump
       ↓
Save capture.pcap
       ↓
Open capture.pcap in Wireshark
       ↓
Detailed Analysis
```

This is especially useful for servers without a GUI.

---

# 74. Scenario 1 — Website is Slow

### Question

A user says a website is slow. How would you analyze it using Wireshark?

### Answer

Check the communication step by step:

```text
DNS
 ↓
TCP Handshake
 ↓
TLS Handshake
 ↓
Application Traffic
 ↓
Retransmissions / Delays
```

Look for:

- Slow DNS response
- Slow SYN/SYN-ACK
- TCP retransmissions
- TLS negotiation delay
- Slow server response

---

# 75. Scenario 2 — Server Port Not Reachable

Client attempts:

```text
Client → SYN → Server:443
```

but there is no SYN-ACK.

Possible causes:

- Firewall blocking traffic
- Server down
- Routing problem
- Packet lost
- Service unavailable

If server sends:

```text
RST
```

this often indicates that the destination is reachable but the TCP connection is being refused, such as when no service is listening on that port.

---

# 76. Scenario 3 — DNS Problem

You capture:

```text
DNS Query
```

but no:

```text
DNS Response
```

Check:

- DNS server connectivity
- Firewall
- Routing
- DNS service
- Correct DNS server address

---

# 77. Scenario 4 — Ping Fails

Capture:

```text
ICMP Echo Request
```

but no reply.

Check:

- Remote host
- Firewall
- Routing
- ICMP filtering

---

# 78. Scenario 5 — Capture Filter or Display Filter?

### Question

You have already captured 100,000 packets and now want to show only DNS packets.

Use:

```text
Display Filter:
dns
```

because capture is already complete.

---

# 79. Scenario 6 — Reduce Capture Size

### Question

Before starting a capture, you only want traffic on TCP port 443.

Use:

```text
Capture Filter:
tcp port 443
```

---

# 80. Scenario 7 — Production Linux Server

### Question

A Linux server has no GUI. You want to capture traffic and analyze it later.

Use:

```bash
tcpdump -i eth0 -w capture.pcap
```

Then open:

```text
capture.pcap
```

in Wireshark.

---

# 81. Scenario 8 — TCP Connection Failure

You see:

```text
SYN
SYN
SYN
```

but no SYN-ACK.

This means the client is retransmitting its connection attempt.

Possible causes:

- Firewall silently dropping
- Routing issue
- Server unavailable
- Packet loss

---

# 82. Scenario 9 — TCP Port Closed

You see:

```text
Client → SYN
Server → RST, ACK
```

This commonly indicates:

> The server is reachable, but the destination TCP port is closed or the connection is actively refused.

---

# 83. Scenario 10 — HTTPS Traffic Not Readable

### Question

Wireshark captures TCP 443 traffic, but you cannot read usernames/passwords.

### Answer

Because HTTPS uses TLS encryption.

Wireshark can analyze:

- Connection metadata
- TCP behavior
- TLS handshake information

but application content is encrypted unless appropriate decryption information is available.

---

# 84. Scenario 11 — Find Traffic for One System

Use display filter:

```text
ip.addr == 192.168.1.10
```

This shows traffic where the IP is either:

- Source
- Destination

---

# 85. Scenario 12 — Find HTTPS TCP Traffic

Display filter:

```text
tcp.port == 443
```

For traditional HTTPS over TCP, this is useful.

However, modern HTTP/3 traffic may use QUIC over UDP 443, so a TCP-only filter would not show that traffic.

---

# 86. Common Troubleshooting Method

A useful sequence is:

```text
Physical Connectivity
       ↓
IP Address
       ↓
ARP / Neighbor Discovery
       ↓
Routing
       ↓
DNS
       ↓
TCP / UDP
       ↓
TLS
       ↓
Application
```

Packet capture helps identify exactly where communication stops.

---

# 87. Wireshark Quick Display Filter Table

| Purpose        | Display Filter            |
| -------------- | ------------------------- |
| TCP            | `tcp`                     |
| UDP            | `udp`                     |
| DNS            | `dns`                     |
| HTTP           | `http`                    |
| TLS            | `tls`                     |
| ICMP           | `icmp`                    |
| IPv6 ICMP      | `icmpv6`                  |
| Specific IP    | `ip.addr == 192.168.1.10` |
| Source IP      | `ip.src == 192.168.1.10`  |
| Destination IP | `ip.dst == 192.168.1.10`  |
| TCP port 443   | `tcp.port == 443`         |
| TCP reset      | `tcp.flags.reset == 1`    |
| SYN            | `tcp.flags.syn == 1`      |

---

# 88. Wireshark Capture Filter Table

| Purpose          | Capture Filter          |
| ---------------- | ----------------------- |
| TCP              | `tcp`                   |
| UDP              | `udp`                   |
| Specific host    | `host 192.168.1.10`     |
| Source host      | `src host 192.168.1.10` |
| Destination host | `dst host 192.168.1.10` |
| Port 443         | `port 443`              |
| TCP 443          | `tcp port 443`          |
| DNS port         | `port 53`               |

---

# 89. tcpdump Command Quick Revision

| Command                             | Purpose                                 |
| ----------------------------------- | --------------------------------------- |
| `tcpdump -D`                        | List interfaces                         |
| `tcpdump -i eth0`                   | Capture eth0                            |
| `tcpdump -i any`                    | Capture all available interfaces        |
| `tcpdump -nn -i eth0`               | Capture without name/service resolution |
| `tcpdump -i eth0 tcp`               | TCP traffic                             |
| `tcpdump -i eth0 udp`               | UDP traffic                             |
| `tcpdump -i eth0 icmp`              | ICMP traffic                            |
| `tcpdump -i eth0 port 53`           | DNS-port traffic                        |
| `tcpdump -i eth0 host 192.168.1.10` | Specific host                           |
| `tcpdump -i eth0 -c 100`            | Capture 100 packets                     |
| `tcpdump -i eth0 -w file.pcap`      | Save capture                            |
| `tcpdump -r file.pcap`              | Read capture                            |

---

# 90. Most Important Interview Questions

1. What is Wireshark?
2. What is packet capture?
3. What is packet analysis?
4. Why is Wireshark used?
5. What is a capture filter?
6. What is a display filter?
7. Capture filter vs display filter?
8. What syntax does a capture filter use?
9. What is `ip.addr == 192.168.1.10`?
10. What does `tcp.port == 443` show?
11. What is a TCP three-way handshake?
12. Explain SYN, SYN-ACK and ACK.
13. What does TCP RST mean?
14. What is TCP retransmission?
15. TCP vs UDP?
16. Does UDP use a handshake?
17. How would you analyze DNS?
18. What is an HTTP packet?
19. HTTP vs HTTPS in Wireshark?
20. Why can't Wireshark normally read HTTPS application data?
21. What is TLS?
22. What is ICMP?
23. How would you troubleshoot failed ping?
24. What is tcpdump?
25. tcpdump vs Wireshark?
26. How do you capture traffic on `eth0`?
27. How do you capture only port 443?
28. How do you save a `.pcap` file?
29. How do you read a `.pcap` file?
30. Why is tcpdump useful on headless servers?

---

# 91. Interview-Ready Answer — What is Wireshark?

> **Wireshark is a graphical network packet analyzer used to capture and inspect packets. It helps troubleshoot network problems and analyze protocols such as TCP, UDP, DNS, HTTP, TLS, and ICMP.**

---

# 92. Interview-Ready Answer — Capture vs Display Filter

> **A capture filter is applied before packet capture and determines which packets are recorded. A display filter is applied after capture and determines which captured packets are shown. For example, `tcp port 443` is a capture filter, while `tcp.port == 443` is a Wireshark display filter.**

---

# 93. Interview-Ready Answer — TCP Handshake

> **TCP establishes a connection using a three-way handshake. The client sends SYN, the server responds with SYN-ACK, and the client sends ACK. After these three steps, the TCP connection is established.**

```text
Client                   Server

SYN -------------------->

    <-------------- SYN-ACK

ACK -------------------->

Connection Established
```

---

# 94. Interview-Ready Answer — tcpdump

> **tcpdump is a command-line packet capture tool commonly used on Linux systems. It can capture packets from network interfaces, apply BPF filters, and save traffic to `.pcap` files for later analysis in tools such as Wireshark.**

---

# 95. Interview-Ready Answer — tcpdump vs Wireshark

> **tcpdump is lightweight and command-line based, so it is ideal for servers and SSH troubleshooting. Wireshark provides a graphical interface and more convenient deep packet analysis. A common workflow is to capture packets with tcpdump on a server and analyze the `.pcap` file later in Wireshark.**

---

# 96. Quick Revision

```text
Wireshark
→ GUI packet capture and analysis tool.

Packet Capture
→ Record network packets.

Packet Analysis
→ Examine packets to find problems or attacks.

Capture Filter
→ Applied before capture.

Display Filter
→ Applied after capture.

TCP
→ Connection-oriented, uses handshake.

UDP
→ Connectionless, no handshake.

DNS
→ Resolves names to IP addresses.

HTTP
→ Plain web communication.

TLS
→ Encrypts communication such as HTTPS.

ICMP
→ Diagnostics and network error reporting.

tcpdump
→ Command-line packet capture tool.

PCAP
→ Packet capture file.
```

## Best Flow to Remember for Web Troubleshooting

```text
User opens website
      ↓
DNS Query / Response
      ↓
TCP Handshake
      ↓
TLS Handshake
      ↓
HTTP(S) Communication
      ↓
Check Delay / Retransmission / Errors
```

And the key filter difference:

```text
Before Capture:
tcp port 443
→ Capture Filter

After Capture:
tcp.port == 443
→ Display Filter
```

### Most important interview line

> **Wireshark is best for detailed graphical packet analysis, while tcpdump is ideal for fast command-line packet capture, especially on remote or headless Linux servers.**
