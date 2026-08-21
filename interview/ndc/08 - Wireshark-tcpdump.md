# Wireshark & Traffic Analysis — Detailed Notes

# 1. Wireshark Basics

## 1.1 What is Wireshark?

**Wireshark** is a **graphical packet capture and packet analysis tool**. It captures network traffic from a network interface and lets you inspect each packet in detail.
It can analyze many protocols: TCP, UDP, DNS, HTTP, TLS, ICMP, ARP, DHCP, SSH-related connections, and more.

> **Simple Definition:** Wireshark is a graphical packet analyzer used to capture and inspect network traffic for troubleshooting, security analysis, and protocol study.

```text
Network Traffic → Network Interface → Wireshark Capture → Packets → Protocol Analysis → Troubleshooting / Security Investigation
```

## 1.2 Why is Wireshark Used?

Useful for: finding network connectivity problems, checking whether packets reach a server, analyzing TCP connections, troubleshooting DNS, finding retransmissions, finding connection resets, detecting unusual traffic.
**Example:** User says _"Website is very slow."_ → Capture traffic → Check DNS, TCP handshake, TLS handshake, retransmissions, server response.

## 1.3 Packet Capture vs Packet Analysis

- **Packet Capture** — recording network packets that pass through an interface. A captured packet may contain: source/destination MAC, source/destination IP, protocol, source/destination port, flags, sequence numbers, payload.
- **Packet Analysis** — examining captured packets to understand what happened. Example: `Client → SYN → Server`, but no `Server → SYN-ACK → Client` in the capture. This tells you the client sent the connection request but got no response — possibly due to a firewall blocking it, the server being down, the port being closed, a routing problem, or packet loss.

| Packet Capture                | Packet Analysis                       |
| ----------------------------- | ------------------------------------- |
| Records packets               | Examines packets                      |
| First step                    | Investigation step                    |
| Collects network traffic      | Finds problems or suspicious behavior |
| Wireshark/tcpdump can capture | Wireshark is very good for analysis   |

---

# 2. Capturing Traffic in Wireshark

## 2.1 Choosing an Interface

Before capturing, Wireshark asks which interface to monitor (Ethernet, Wi-Fi, Loopback, VPN, VM interface, etc.).

```text
PC ── Ethernet / Wi-Fi / VPN → choose the right one → only traffic visible on that interface is captured
```

> **Important:** If you select the wrong interface, you may capture no useful traffic.

## 2.2 The Wireshark Packet View

Wireshark shows packet information in three sections:

- **Packet List** — `No. | Time | Source | Destination | Protocol | Info`
- **Packet Details** — protocol layers, e.g. `Ethernet → IP → TCP → TLS/HTTP`
- **Packet Bytes** — raw packet data in hex and ASCII

## 2.3 Protocol Layers Example

```text
HTTPS packet: Ethernet → IPv4 → TCP → TLS → Encrypted Application Data
DNS query:    Ethernet → IPv4 → UDP → DNS
```

---

# 3. Capture Filter vs Display Filter

This is one of the most important interview topics.

## 3.1 Capture Filter

Controls **which packets Wireshark captures**, applied **before packets are stored**. Uses **BPF-style syntax**.

```text
All Network Traffic → Capture Filter → Only Matching Traffic Captured
```

**Useful when:** traffic volume is very large, you only need one host/protocol/port, or you want a smaller capture file.
**Examples:**
| Purpose | Capture Filter |
|---|---|
| TCP only | `tcp` |
| UDP only | `udp` |
| Specific host | `host 192.168.1.10` |
| Source host | `src host 192.168.1.10` |
| Destination host | `dst host 192.168.1.10` |
| Port 443 | `port 443` |
| TCP port 443 | `tcp port 443` |
| DNS port | `port 53` |

## 3.2 Display Filter

Controls **which already-captured packets are shown**, applied **after capture**. The other packets remain in the capture file, just hidden from view.

```text
Captured: TCP, UDP, DNS, TLS, ICMP, HTTP → Display Filter: dns → Only DNS packets shown
```

**Example:** You captured 50,000 packets and want only traffic for `192.168.1.10` → use `ip.addr == 192.168.1.10`.

## 3.3 Capture Filter vs Display Filter

| Capture Filter            | Display Filter                   |
| ------------------------- | -------------------------------- |
| Applied before capture    | Applied after capture            |
| Controls what is recorded | Controls what is displayed       |
| Reduces capture size      | Does not remove captured packets |
| Uses BPF syntax           | Uses Wireshark display syntax    |
| Example: `tcp port 443`   | Example: `tcp.port == 443`       |

```text
Capture Filter → Before capture
Display Filter → After capture
```

> **Watch out — same idea, different syntax:** Capture filter = `tcp port 443`. Display filter = `tcp.port == 443`. They look similar but are not interchangeable.

## 3.4 Common Display Filters

| Purpose                        | Display Filter                             |
| ------------------------------ | ------------------------------------------ |
| TCP                            | `tcp`                                      |
| UDP                            | `udp`                                      |
| DNS                            | `dns`                                      |
| HTTP (plaintext)               | `http`                                     |
| TLS                            | `tls`                                      |
| ICMP (IPv4)                    | `icmp`                                     |
| ICMP (IPv6)                    | `icmpv6`                                   |
| Specific IP (src or dst)       | `ip.addr == 192.168.1.10`                  |
| Source IP only                 | `ip.src == 192.168.1.10`                   |
| Destination IP only            | `ip.dst == 192.168.1.10`                   |
| TCP port 443 (src or dst)      | `tcp.port == 443`                          |
| TCP destination port only      | `tcp.dstport == 443`                       |
| TCP source port only           | `tcp.srcport == 443`                       |
| TCP RST packets                | `tcp.flags.reset == 1`                     |
| TCP SYN packets                | `tcp.flags.syn == 1`                       |
| Initial SYN only (not SYN-ACK) | `tcp.flags.syn == 1 && tcp.flags.ack == 0` |

**Combining filters:**

```text
ip.addr == 192.168.1.10 && tcp.port == 443   → TCP port 443 traffic involving that IP
dns || icmp                                   → DNS or ICMP packets
```

---

# 4. Protocol Analysis in Wireshark

## 4.1 TCP

**TCP** is reliable and connection-oriented. Wireshark shows SYN, SYN-ACK, ACK, FIN, RST, sequence/ack numbers, window size, and retransmissions.

```text
Client → SYN → Server
Client ← SYN-ACK ← Server
Client → ACK → Server        (Connection Established)
```

- **RST** — connection refused/terminated (port closed, app rejected, or forced close).
- **FIN** — normal graceful close (`FIN → ACK` each direction).
- **Retransmission** — TCP resends unacknowledged data; frequent retransmissions suggest packet loss, congestion, or a bad link.

## 4.2 TCP vs UDP

**UDP** is connectionless — no handshake, just `Client → UDP packet → Server`.

| TCP                                  | UDP                                      |
| ------------------------------------ | ---------------------------------------- |
| Connection-oriented, 3-way handshake | Connectionless, no handshake             |
| Reliable, retransmits lost data      | No delivery guarantee, no retransmission |
| Uses sequence numbers                | No sequence numbers                      |
| Example: HTTPS                       | Example: traditional DNS                 |

## 4.3 HTTP & HTTPS

**HTTP** (`TCP 80`): `Client → HTTP GET → Server → 200 OK`. Filter: `http`. Methods: GET, POST, PUT, DELETE, HEAD, OPTIONS, PATCH.
Key status codes: `200 OK, 301/302 Redirect, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 500/502/503 Server Errors`.
**HTTPS** = HTTP + TLS encryption — Wireshark shows `TCP → TLS → Encrypted Application Data` instead of readable content.

## 4.4 TLS

Encrypts protocols like HTTPS, usually over `TCP 443` (HTTP/3 uses QUIC/UDP instead). Filter: `tls`.

```text
Client → TCP Connection → TLS Handshake (Client Hello ↔ Server Hello, Certs) → Keys Established → Encrypted Data
```

**Troubleshooting order:** `DNS → TCP → TLS → Application`. If DNS/TCP work but TLS fails, suspect a certificate/negotiation issue, not basic connectivity.

## 4.5 ICMP

Used for diagnostics (e.g. `ping`). Filter: `icmp`.

```text
Host A → ICMP Echo Request → Host B → ICMP Echo Reply → Host A
```

Reply received → basic connectivity works. No reply → host down, firewall blocking, routing issue, or ICMP disabled.

---

# 6. tcpdump

## 6.1 What is tcpdump?

**tcpdump** is a **command-line** packet capture and analysis tool, widely used on Linux/Unix systems.

> **Simple Definition:** tcpdump is a command-line tool used to capture and inspect network packets from a network interface.

```bash
tcpdump -i eth0
```

Meaning: capture packets on interface `eth0`.

## 6.2 Why Use tcpdump?

Runs from terminal, no GUI required, good for remote Linux servers, lightweight, excellent over SSH, supports powerful capture filters, can save packets to `.pcap` files, which can later be opened in Wireshark.

## 6.3 Headless Server Troubleshooting

A **headless server** has no graphical desktop (e.g. a cloud Linux server, SSH terminal only) — Wireshark's GUI isn't practical there, so use tcpdump instead, then analyze the saved capture in Wireshark if needed.

## 6.4 Common tcpdump Commands

| Command                                          | Purpose                                    |
| ------------------------------------------------ | ------------------------------------------ |
| `tcpdump -D`                                     | List interfaces                            |
| `tcpdump -i eth0`                                | Capture on eth0                            |
| `tcpdump -i any`                                 | Capture all available interfaces           |
| `tcpdump -n -i eth0`                             | Don't resolve IPs to hostnames             |
| `tcpdump -nn -i eth0`                            | Also don't resolve ports to service names  |
| `tcpdump -i eth0 host 192.168.1.10`              | Capture traffic involving a host           |
| `tcpdump -i eth0 src host 192.168.1.10`          | Only traffic FROM that host                |
| `tcpdump -i eth0 dst host 192.168.1.10`          | Only traffic TO that host                  |
| `tcpdump -i eth0 tcp`                            | TCP traffic only                           |
| `tcpdump -i eth0 udp`                            | UDP traffic only                           |
| `tcpdump -i eth0 icmp`                           | ICMP traffic only (useful for ping issues) |
| `tcpdump -i eth0 port 22` / `443` / `53`         | Traffic on a specific port (SSH/HTTPS/DNS) |
| `tcpdump -i eth0 tcp port 443`                   | TCP traffic on port 443 only               |
| `tcpdump -i eth0 host 192.168.1.10 and port 443` | Combine conditions                         |
| `tcpdump -i eth0 -w capture.pcap`                | Save capture to a file                     |
| `tcpdump -r capture.pcap`                        | Read a saved capture file                  |
| `tcpdump -i eth0 -c 100`                         | Capture only 100 packets, then stop        |
| `tcpdump -i eth0 tcp port 443 -w https.pcap`     | Filter + save together                     |

**Typical workflow:**

```text
Linux Server → tcpdump → capture.pcap → Wireshark → Detailed Analysis
```

## 6.5 tcpdump vs Wireshark

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

```text
tcpdump → Capture from terminal
Wireshark → Deep graphical analysis
```

**Real-world combined workflow:** `Production Linux Server → tcpdump → Save capture.pcap → Open in Wireshark → Detailed Analysis`. Especially useful for servers without a GUI.

---

# 7. Scenario-Based Interview Questions

1. **A user says a website is slow — how would you analyze it?**
   Check step by step: `DNS → TCP Handshake → TLS Handshake → Application Traffic → Retransmissions/Delays`. Look for slow DNS response, slow SYN/SYN-ACK, TCP retransmissions, TLS negotiation delay, or slow server response.

2. **Client sends SYN to a server port but gets no SYN-ACK — why?**
   Possible causes: firewall blocking traffic, server down, routing problem, packet lost, service unavailable. If the server instead replies with `RST`, the destination is reachable but is actively refusing the connection (e.g. no service listening on that port).

3. **You capture a DNS Query but no DNS Response — what would you check?**
   DNS server connectivity, firewall, routing, DNS service status, correct DNS server address.

4. **Ping fails — ICMP Echo Request sent but no reply — what would you check?**
   Remote host status, firewall, routing, ICMP filtering.

5. **You've already captured 100,000 packets and now want to see only DNS — capture filter or display filter?**
   **Display filter** (`dns`) — the capture is already complete, so you filter what's shown, not what's recorded.

6. **Before starting a capture, you only want TCP port 443 traffic — capture filter or display filter?**
   **Capture filter** (`tcp port 443`) — set before capture to reduce what's actually recorded.

7. **A Linux server has no GUI. You want to capture traffic and analyze it later.**

```bash
tcpdump -i eth0 -w capture.pcap
```

Then open `capture.pcap` in Wireshark.

8. **You see repeated `SYN, SYN, SYN` with no SYN-ACK — what does this mean?**
   The client is retransmitting its connection attempt. Possible causes: firewall silently dropping packets, routing issue, server unavailable, packet loss.

9. **You see `Client → SYN` followed by `Server → RST, ACK` — what does this mean?**
   The server is reachable, but the destination TCP port is closed or the connection is actively refused.

10. **Wireshark captures TCP 443 traffic, but you can't read usernames/passwords in it — why?**
    Because HTTPS uses TLS encryption. Wireshark can still show connection metadata, TCP behavior, and TLS handshake information, but application content stays encrypted unless proper decryption keys are available.

11. **How do you find all traffic for one specific IP address?**

```text
ip.addr == 192.168.1.10
```

Shows traffic where that IP is either the source or the destination.

12. **How do you find HTTPS (TCP) traffic on a specific port?**

```text
tcp.port == 443
```

Note: modern HTTP/3 may use QUIC over UDP 443 instead, so a TCP-only filter would miss that traffic.

---

# 9. Most Important Interview Questions

1. What is Wireshark? 2. What is packet capture? 3. What is packet analysis? 4. Why is Wireshark used? 5. What is a capture filter? 6. What is a display filter? 7. Capture filter vs display filter? 8. What syntax does a capture filter use? 9. What is `ip.addr == 192.168.1.10`? 10. What does `tcp.port == 443` show? 11. What is a TCP three-way handshake? 12. Explain SYN, SYN-ACK and ACK. 13. What does TCP RST mean? 14. What is TCP retransmission? 15. TCP vs UDP? 16. Does UDP use a handshake? 17. How would you analyze DNS? 18. What is an HTTP packet? 19. HTTP vs HTTPS in Wireshark? 20. Why can't Wireshark normally read HTTPS application data? 21. What is TLS? 22. What is ICMP? 23. How would you troubleshoot failed ping? 24. What is tcpdump? 25. tcpdump vs Wireshark? 26. How do you capture traffic on `eth0`? 27. How do you capture only port 443? 28. How do you save a `.pcap` file? 29. How do you read a `.pcap` file? 30. Why is tcpdump useful on headless servers?

---

# 10. Interview-Ready Answers

**What is Wireshark?**

> Wireshark is a graphical network packet analyzer used to capture and inspect packets. It helps troubleshoot network problems and analyze protocols such as TCP, UDP, DNS, HTTP, TLS, and ICMP.

**Capture Filter vs Display Filter?**

> A capture filter is applied before packet capture and determines which packets are recorded. A display filter is applied after capture and determines which captured packets are shown. For example, `tcp port 443` is a capture filter, while `tcp.port == 443` is a Wireshark display filter.

**TCP Handshake?**

> TCP establishes a connection using a three-way handshake. The client sends SYN, the server responds with SYN-ACK, and the client sends ACK. After these three steps, the TCP connection is established.

**What is tcpdump?**

> tcpdump is a command-line packet capture tool commonly used on Linux systems. It can capture packets from network interfaces, apply BPF filters, and save traffic to `.pcap` files for later analysis in tools such as Wireshark.

**tcpdump vs Wireshark?**

> tcpdump is lightweight and command-line based, so it is ideal for servers and SSH troubleshooting. Wireshark provides a graphical interface and more convenient deep packet analysis. A common workflow is to capture packets with tcpdump on a server and analyze the `.pcap` file later in Wireshark.

---

### Best Flow to Remember for Web Troubleshooting

```text
User opens website → DNS Query/Response → TCP Handshake → TLS Handshake → HTTP(S) Communication → Check Delay/Retransmission/Errors
```

### Key Filter Difference

```text
Before Capture: tcp port 443    → Capture Filter
After Capture:  tcp.port == 443 → Display Filter
```

> **Most important interview line:** Wireshark is best for detailed graphical packet analysis, while tcpdump is ideal for fast command-line packet capture, especially on remote or headless Linux servers.
