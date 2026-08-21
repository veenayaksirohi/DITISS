# Interview - Consolidated

## Security Fundamentals

### Interview Q&A

**Q: Can a system be secure but still violate privacy?** A: Yes. Example — a company may have excellent encryption and access control (secure), but still sell or misuse customer data without consent (privacy violation).
**Q: Can a system respect privacy but still be insecure?** A: Yes. Example — a company may have a strict privacy policy but use weak passwords or outdated software, allowing attackers to steal the very data it promised to protect.

---

### Interview Q&A

**Q: How is server hardening different from a firewall?** A: A firewall is _one_ preventive control (network-level). Server hardening is a broader, ongoing process that includes firewall configuration plus OS, account, application, file system, and logging hardening.
**Q: What's the first thing you'd check when hardening a new server?** A: Identify what's running by default — open ports, running services, default accounts — then disable/remove anything not explicitly required, following least privilege.
**Q: Name a few CIS Benchmark-style hardening checks for Linux.** A: Disable root SSH login, disable password authentication in favor of keys, enable a host firewall, ensure automatic security updates, restrict `cron`/`sudoers` access, and enable auditd logging.

---

### 19. Interview Scenario

##### Question

**A Linux server has SSH open to the Internet and attackers are continuously trying different passwords. How would you secure it?**

##### Answer Approach

```text
1. Check authentication logs
2. Identify repeated failed login attempts
3. Restrict SSH using firewall
4. Allow only trusted IPs if possible
5. Use SSH keys
6. Disable password login where practical
7. Configure Fail2ban
8. Use MFA if supported
9. Monitor using SIEM/IDS
```

This answer shows: Vulnerability understanding, Risk management, Countermeasure selection, Server hardening, Defence in depth.

---

## Firewalls

### 7. Scenario-Based Interview Questions — Basic Firewall Concepts

1. **Internal users should browse the Internet, but Internet users should not initiate connections inward. What firewall behavior helps?**
   Use a **stateful firewall** — it allows internal users to start connections and permits valid responses, while blocking unsolicited inbound connections.

2. **A firewall filters only by source/destination IP, protocol, and port, with no session memory. What kind of firewall is this?**
   **Stateless packet-filtering firewall.**

3. **How does a stateful firewall know a reply from a web server is legitimate?**
   It checks its **connection/state table** and confirms the packet belongs to an existing established session.

4. **A firewall rule says `ALLOW ANY ANY`. Why is this dangerous?**
   It allows unnecessary traffic and greatly increases the attack surface. Better: `Default Deny + Allow Required Services Only`.

5. **Only admin `192.168.1.50` should access SSH on a server. What rule would you use?**

```text
ALLOW: Source = 192.168.1.50, Destination = Server, Protocol = TCP, Port = 22
DROP other TCP 22 traffic
```

---

### 8. Common Interview Questions — Basic Firewall Concepts

- **What is a firewall?** > A security control that monitors and filters incoming and outgoing network traffic according to predefined rules.
- **What does a firewall check?** Source IP, Destination IP, Port, Protocol, Direction, Connection state; advanced firewalls may also inspect applications and content.
- **What is a firewall rule?** > Defines what traffic should be allowed or denied based on conditions such as IP address, port, protocol, direction, or connection state.
- **What is packet filtering?** > Checks packet header information (source/destination IP, ports, protocol) to decide whether traffic should be allowed or blocked.
- **What is a stateless firewall?** > Examines every packet independently and does not remember previous packets or sessions.
- **What is a stateful firewall?** > Tracks active connections and uses connection state along with firewall rules to decide whether packets should be allowed.

---

### 15. Scenario-Based Interview Questions — Advanced Firewall Concepts

1. **Employees need Microsoft Teams, but management wants to block YouTube — both use HTTPS 443. How?**
   A simple port-based firewall can't distinguish them. Use an **NGFW with application control**: `TCP 443 → NGFW → Identify Application → Teams ALLOW, YouTube BLOCK`.

2. **Firewall allows TCP 443, but users are using unwanted applications over HTTPS. What's the problem?**
   The firewall is relying mainly on ports. An NGFW provides application identification/control, URL filtering, DPI, IDS/IPS.

3. **A company wants employees' web requests checked centrally against URL policy before Internet access.**
   Use a **proxy firewall / forward proxy**: `Employee → Proxy → URL/Policy Check → Internet`.

4. **Two compromised PCs communicate inside the same LAN without passing through the perimeter firewall. What helps?**
   Use **host-based firewalls** on the endpoints (`PC1 → Host Firewall on PC2 → PC2`) and consider network segmentation.

5. **A firewall permits all traffic except a few explicitly blocked ports — good design?**
   This is **default allow** and can lead to accidental exposure. Safer: `Default Deny + Explicitly Allow Required Traffic`.

6. **Public web server: HTTPS for everyone, SSH only for the admin.**

```text
Inbound: ALLOW TCP 443 from ANY, ALLOW TCP 22 from Admin IP, DEFAULT DROP
```

7. **A database server should only talk to the internal app server, not the open Internet.**

```text
ALLOW required internal traffic
DENY unnecessary outbound traffic
```

Reduces malware C2 / data-exfiltration opportunities.

8. **An employee opens an HTTPS site — why can the reply enter even though random inbound traffic is blocked?**
   Because a **stateful firewall** remembers the internal user initiated the connection: `Client starts HTTPS → state stored → Server Response matches ESTABLISHED → ALLOW`. Random unsolicited inbound traffic doesn't match the state table and can be blocked.

---

### 17. Most Important Interview Questions (Master List)

1. What is a firewall?
2. What does a firewall check?
3. What is a firewall rule?
4. What is packet filtering?
5. What is a stateless firewall?
6. What is a stateful firewall?
7. Why does a stateful firewall allow return traffic?
8. What is a connection/state table?
9. What is an NGFW?
10. Why do we need NGFW?
11. Traditional firewall vs NGFW?
12. What is application awareness?
13. What is application control?
14. What is Deep Packet Inspection?
15. How can an NGFW identify applications using the same port?
16. What is a proxy firewall?
17. How does a proxy firewall work?
18. Forward proxy vs firewall?
19. What is a host firewall?
20. What is a network firewall?
21. Host firewall vs network firewall?
22. Why use both network and host firewalls?
23. What is Default Allow?
24. What is Default Deny?
25. Which one is more secure?
26. What is an inbound firewall rule?
27. What is an outbound firewall rule?
28. Why should outbound traffic be filtered?

---

## DMZ

### 12. Scenario-Based Interview Questions

1. **A company has a public web application and a sensitive database. How would you design the network?**
   > I would place the public web server or reverse proxy in a DMZ because it needs Internet access. The database would remain in the internal protected network. I would allow only HTTPS from the Internet to the DMZ and only required application traffic from the DMZ toward the internal application server. The database would accept connections only from the required backend server. All other traffic would be denied using least-privilege firewall rules.

```text
Internet → HTTPS 443 → Firewall → DMZ Web Server → Required App Port → Internal Firewall → Backend Server → PostgreSQL 5432 → Database
```

2. **The DMZ web server gets compromised. What prevents the attacker from reaching the database?**
   Controls: internal firewall, network segmentation, default-deny rules, least privilege, no direct web-server-to-database access, IDS/IPS, host firewall, monitoring.

```text
Attacker → Compromised Web Server → Attempts Database Connection → Internal Firewall → No Allowed Rule → DROP
```

3. **Which ports would you expose from the Internet to a DMZ web server?**
   Only ports required by the service — for a normal HTTPS web application, `TCP 443 → ALLOW`, possibly `TCP 80 → ALLOW` if needed (commonly for redirecting to HTTPS). Unnecessary ports stay blocked.

4. **Should Internet users be allowed to connect directly to the database?**

   > Normally no. The database should remain on a private/internal network and accept connections only from authorized application servers. Direct Internet exposure increases the attack surface and risk of unauthorized access.

5. **Your firewall currently contains `DMZ → Internal: ALLOW ANY ANY`. What is wrong?**
   This gives the DMZ unrestricted access to the internal network — if a public DMZ server is compromised, an attacker could attempt to access many internal systems. Better: `DMZ Web Server → Specific Backend Server → Specific Required Port → ALLOW`, `Everything Else → DENY`.

6. **An administrator needs SSH access to a DMZ server. How would you configure it securely?**
   Instead of `Internet → SSH → DMZ Server, ALLOW ANY`, allow SSH only from a trusted administration source: `Source: 192.168.10.50, Destination: DMZ Web Server, Port: TCP 22, Action: ALLOW`, then deny other SSH traffic.

7. **A web server needs database access. Should you allow `DMZ → Database ANY`?**
   No. Allow only a specific source + specific destination + specific port, e.g. `Backend Server → Database Server → TCP 5432`. This follows least privilege.

---

### 14. Most Important Interview Questions

1. What is a DMZ? 2. What does DMZ stand for? 3. Why is a DMZ used? 4. Where is a DMZ placed? 5. Which servers can be placed in a DMZ? 6. Why should a web server be placed in a DMZ? 7. Why should a database not normally be in a DMZ? 8. Why should a database not be directly Internet-facing? 9. What rules should exist from Internet → DMZ? 10. What rules should exist from DMZ → Internal? 11. What rules should exist from Internal → DMZ? 12. What happens if a DMZ server is compromised? 13. How does a DMZ reduce blast radius? 14. DMZ vs internal network? 15. DMZ vs firewall? 16. DMZ vs VLAN? 17. Can a DMZ be created using one firewall? 18. How does NAT work with a DMZ? 19. Why is `ALLOW ANY ANY` from DMZ to LAN dangerous? 20. How does DMZ support Defence in Depth?

---

### 15. Interview-Ready Answers

##### Full Definition

> A DMZ, or Demilitarized Zone, is a separate network segment placed between the Internet and the organization's internal network. Public-facing services such as web servers are placed in the DMZ so that if they are compromised, attackers do not get direct access to sensitive internal systems. Traffic between the Internet, DMZ, and internal network is controlled using strict firewall rules.

##### 30-Second Answer

> A DMZ is a separate network zone used for public-facing services such as web servers. It is placed between the Internet and the internal network. For example, I can allow Internet users to access the DMZ web server only on HTTPS port 443, while the internal database remains private. Communication from the DMZ to the internal network should follow least privilege and default-deny rules. This limits lateral movement if the public server is compromised.

---

## iptables

### 12. Scenario-Based Q&A

1. **Remote SSH into the server — which chain?** `INPUT` (the machine itself is the destination).
2. **Server connects out to google.com over HTTPS — which chain?** `OUTPUT` (traffic was generated locally).
3. **Server routes LAN↔Internet traffic — which chain?** `FORWARD`.
4. **A DROP rule for an IP isn't taking effect — what to check?** Correct table/chain, rule order, source/destination, protocol/port, packet counters, connection state, and especially an earlier `ACCEPT` rule that may be matching first.
5. **About to set INPUT's default policy to DROP over SSH — what first?** First add an explicit allow rule for your own trusted IP (`iptables -A INPUT -p tcp -s ADMIN_IP --dport 22 -j ACCEPT`), _then_ apply the DROP policy — otherwise you lock yourself out.
6. **Allow internal users out, block unsolicited inbound — how does conntrack help?** Traffic the internal host initiates gets tracked; replies arrive as `ESTABLISHED`. A rule allowing `ESTABLISHED,RELATED` lets replies through while new unsolicited inbound connections stay blocked.
7. **Forward public port 8080 to an internal server on port 80 — what's used?** The `nat` table with DNAT/port forwarding, typically on `PREROUTING` (see Part 2).

### 12. Scenario-Based Q&A

1. **Internal PCs need Internet access.** IP Forwarding + SNAT/PAT or MASQUERADE + FORWARD rules.
2. **Publish an internal web server (192.168.1.10:80) on public 203.0.113.10:80.** DNAT/port forwarding on PREROUTING, plus a FORWARD allow rule.
3. **Public :8080 must reach private service on :80.** Port forwarding via DNAT (ports can differ).
4. **Firewall has a fixed public IP — which source-NAT approach?** SNAT (IP is known/fixed).
5. **ISP changes the public IP dynamically — which NAT target?** MASQUERADE (auto-uses current interface IP).
6. **MASQUERADE configured but no Internet.** Check IP forwarding, client default gateway, FORWARD rules, outgoing interface, NAT rule, DNS, and routing.
7. **DNAT configured but server unreachable from outside.** Check: DNAT rule on PREROUTING, matching FORWARD rule, IP forwarding enabled, destination server is up and listening, no return-path NAT issues.
8. **100 office PCs share one public IPv4.** PAT / NAT Overload — ports distinguish the connections.
9. **How does the router know which internal host gets a reply?** Its NAT/connection-tracking table maps the public `IP:port` back to the original private `IP:port`.

---

### 10. Scenario-Based Q&A

1. **Hundreds of failed logins from one IP — what do you do?** Check `auth.log`, identify the source IP, configure Fail2ban to ban it after N failures, and layer on SSH keys, firewall restrictions, and monitoring.
2. **Admin mistypes their password 5 times and gets blocked — what happened?** Fail2ban hit `maxretry` — a likely false positive; check status/logs, unban the trusted IP, and tune the jail if needed.
3. **How does Fail2ban know which IP to block?** It parses the source IP out of matching log lines (e.g. "Failed password from 203.0.113.50") and counts failures per IP.
4. **Attacker switches IP after being banned — then what?** The ban only applies to the detected IP; the new IP is treated separately, so pair Fail2ban with MFA, SSH keys, firewall restrictions, and SIEM monitoring.
5. **Service is running but nobody gets banned — what to check?** Correct jail enabled? Correct `logpath`? Failures actually appearing in the log? Filter matching? `maxretry`/`findtime` correct? Fail2ban reading the file? Firewall integration working? Is the IP in `ignoreip`? Useful: `fail2ban-client status[, sshd]`.
6. **IP is banned but SSH still accepts its connections — why?** Firewall action failed, wrong firewall backend/jail, rule not created, traffic using another path/interface, container/namespace issue, or a rule-order/policy conflict.
7. **Can Fail2ban fully stop brute-force attacks?** No — it reduces attempts from detected IPs but doesn't stop distributed attacks, slow attacks, or credential reuse. Use it as one layer of Defence in Depth.

**Best interview line:** Fail2ban detects from logs; the firewall performs the blocking.

---

### 10. Scenario-Based Q&A

1. **Company serves only India; most brute-force traffic is from elsewhere — what to do?** Use GeoIP blocking as one extra control, not the only one — pair with strong authentication, Fail2ban, IDS/IPS, rate limiting, and monitoring.
2. **A country is blocked but attacks still arrive "from India" — why?** Attackers can bypass GeoIP via VPNs, proxies, cloud servers, botnets, or compromised local systems — GeoIP reduces exposure but doesn't prove real location.
3. **An employee traveling abroad suddenly can't reach the company portal — why, and what's the fix?** A GeoIP rule is likely blocking their current country; provide secure VPN access, temporary approved access, or identity-based access with MFA — don't just disable all controls.
4. **Would you secure SSH with GeoIP alone?** No — combine GeoIP with a trusted-IP/VPN restriction, SSH keys, MFA, Fail2ban, and monitoring.
5. **Why can a GeoIP rule block the wrong user?** GeoIP databases aren't always accurate — IPs may belong to VPNs, cloud providers, mobile networks, or ISPs with changing allocations, so detected location may not match reality.
6. **All non-India traffic is blocked — is the network now secure?** No — an attacker can still operate from India, an Indian VPN/cloud server, or a compromised Indian device. Firewall rules, IDS/IPS, authentication, MFA, patching, monitoring, SIEM, and rate limiting are still needed.

## IDS / IPS

### 12. Scenario-Based Q&A (Interview Practice)

| #   | Scenario                                                      | Answer                                                                                       |
| --- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| 1   | Detect attacks but never auto-block                           | **IDS**                                                                                      |
| 2   | Auto-stop SQL exploit before reaching server                  | **IPS** (inline)                                                                             |
| 3   | Detect network port scanning                                  | **NIDS**                                                                                     |
| 4   | Detect unauthorized change to `/etc/passwd`                   | **HIDS**                                                                                     |
| 5   | Alert fired for an authorized scan                            | **False Positive**                                                                           |
| 6   | Real attack, but no alert generated                           | **False Negative**                                                                           |
| 7   | Alert triggered because a matching rule exists                | **Signature-based detection**                                                                |
| 8   | Sudden abnormal 20GB transfer at midnight, no known signature | **Anomaly-based detection**                                                                  |
| 9   | Block malicious packets before reaching 20 web servers        | **NIPS**                                                                                     |
| 9b  | Stop malicious process on one critical server                 | **HIPS**                                                                                     |
| 10  | Snort alerts but attack still reaches server                  | Snort is in **Passive NIDS mode**                                                            |
| 11  | Suricata detects and immediately drops packet                 | **IPS / Inline mode**                                                                        |
| 12  | IDS never sees traffic between two internal servers           | Check: SPAN/mirroring config, correct interface, sensor placement, rules enabled, encryption |
| 13  | Thousands of alerts for normal traffic                        | Likely **too many false positives** — tune rules/thresholds, build proper baseline           |
| 14  | Brand-new attack technique, no signature exists               | **Anomaly-based detection** has better chance                                                |

---

### 13. Interview-Ready Answers (Summary)

**IDS vs IPS:**

> IDS stands for Intrusion Detection System — it monitors traffic/host activity and alerts on suspicious behavior. IPS stands for Intrusion Prevention System — it's usually inline and can automatically block malicious traffic. In short: IDS detects, IPS detects and prevents.

**NIDS vs HIDS:**

> NIDS monitors network packets and detects network-based attacks like port scans. HIDS runs on a host and detects things like unauthorized file changes, suspicious processes, and failed logins.

**NIPS vs HIPS:**

> NIPS protects network traffic and blocks malicious packets before they reach systems. HIPS protects a single host and blocks suspicious activity on that host.

**Signature vs Anomaly:**

> Signature-based detection compares activity to known attack patterns — effective for known attacks. Anomaly-based detection compares activity to normal behavior and can catch unknown attacks, but may cause more false positives.

**False Positive vs False Negative:**

> A false positive is an alert with no real attack. A false negative is a real attack that goes undetected. False negatives are generally more dangerous.

---

## VPN

### 7. Scenario-Based Interview Questions

1. **An employee works from home and needs access to an internal company server. Which VPN?**
   **Remote Access VPN.**

```text
Employee → Internet → Remote Access VPN → Company Network
```

2. **Delhi and Pune offices need permanent secure connectivity. Which VPN?**
   **Site-to-Site VPN.**

```text
Delhi LAN → VPN Gateway → Encrypted Tunnel → VPN Gateway → Pune LAN
```

3. **Management wants all employee Internet traffic to pass through corporate firewall, web filter, IDS/IPS, and SIEM logging.**
   **Full Tunnel** — because all routed traffic goes through the VPN gateway.

4. **Employees should use the VPN only for internal company resources, while YouTube/normal browsing uses their home Internet directly.**
   **Split Tunnel.**

5. **The VPN gateway is overloaded because thousands of remote users send all Internet traffic through it. What might reduce the load?**
   A carefully designed **split-tunnel** configuration may reduce VPN bandwidth usage — but the organization must consider the security trade-off, since some traffic will bypass corporate inspection.

6. **A company uses a service-provider MPLS network to privately connect its offices, and the provider separates its traffic from other customers. What type of VPN concept is this?**
   **Trusted VPN.**

7. **Two offices communicate over the public Internet using IPsec encryption. What type?**
   **Secure VPN** — security is provided using cryptographic protection.

8. **A company uses MPLS between branches but also uses IPsec encryption over the MPLS network. What type?**
   **Hybrid VPN** — combines a Trusted Provider Network with cryptographic VPN security.

9. **The VPN shows "Connected", but the employee cannot access `10.0.0.20`. What would you check?**

```text
VPN Tunnel Established? → VPN IP Assigned? → Route to 10.0.0.20 Present? → Firewall Rule Allows Traffic?
→ Internal Routing Correct? → Return Route Present? → Server Host Firewall? → DNS, if using hostname?
```

10. **Attackers are repeatedly trying leaked employee passwords against the VPN gateway. What would you do?**
    Use multiple controls: MFA, strong password policy, rate limiting, account lockout where appropriate, SIEM monitoring, VPN gateway patching, disable compromised credentials, restrict access where possible.

---

### 9. Most Important Interview Questions

1. What is a VPN? 2. Why is a VPN used? 3. What is VPN encryption? 4. What is tunneling? 5. What is VPN authentication? 6. Why is integrity important in a VPN? 7. What is a Remote Access VPN? 8. What is a Site-to-Site VPN? 9. Remote Access vs Site-to-Site? 10. What is Full Tunnel? 11. What is Split Tunnel? 12. Full Tunnel vs Split Tunnel? 13. Which is generally easier for centralized security control? 14. Which uses less corporate VPN bandwidth? 15. What is a Secure VPN? 16. What is a Trusted VPN? 17. Secure VPN vs Trusted VPN? 18. What is a Hybrid VPN? 19. Give an example of Hybrid VPN. 20. Is a Trusted VPN always encrypted? 21. Can a VPN work without encryption? 22. Why should MFA be used with VPN? 23. What happens if VPN credentials are stolen? 24. How would you troubleshoot VPN connected but no access? 25. How does VPN fit into Defence in Depth?

---

### 10. Interview-Ready Answers

**What is a VPN?**

> A VPN, or Virtual Private Network, creates a secure logical tunnel between a user or network and another network. It commonly uses encryption, authentication, integrity protection, and tunneling to protect communication over an untrusted network such as the Internet.

**Remote Access vs Site-to-Site:**

> Remote Access VPN connects an individual user or device to an organization's network, while Site-to-Site VPN connects two entire networks through VPN gateways.

**Full vs Split Tunnel:**

> In a Full Tunnel VPN, all configured user traffic is routed through the VPN gateway, which provides better centralized security control but uses more bandwidth. In Split Tunnel, only selected corporate traffic goes through the VPN while other Internet traffic goes directly through the user's ISP, which improves performance but reduces centralized visibility.

**Secure vs Trusted VPN:**

> A Secure VPN protects traffic using cryptography such as encryption and authentication, often over the public Internet. A Trusted VPN relies mainly on a service provider's private network and traffic isolation, such as an MPLS VPN, and may not provide end-to-end encryption by itself.

**Hybrid VPN:**

> A Hybrid VPN combines a trusted provider network with cryptographic VPN protection. For example, a company may use an MPLS network between branches and also run IPsec over it for encryption.

---

## IPsec

### 7. Scenario-Based Interview Questions

1. **Two offices need to securely communicate over the Internet — which mode?**
   **Tunnel Mode** — the gateways need to protect and encapsulate the entire original packet.

2. **You need confidentiality + authentication + integrity — AH or ESP?**
   **ESP** — AH does not encrypt data.

3. **Two hosts communicate directly via IPsec with no extra outer header needed — which mode?**
   **Transport Mode.**

4. **An IPsec tunnel won't establish — what would you check?**

```text
Gateways can reach each other? → UDP 500 allowed? → NAT present (check UDP 4500/NAT-T)?
→ Same IKE version? → PSK/certificate correct? → Encryption/integrity algorithms match? → Correct subnets?
```

5. **Tunnel shows UP, but users can't reach the remote network — what would you check?**
   Local/remote subnet definitions, routing table, firewall rules, NAT exemption, return route, host firewalls, traffic selectors.

6. **An IPsec client is behind a NAT router — what feature is needed?**
   **NAT-T**, commonly over UDP 4500.

7. **An attacker resends a previously captured valid IPsec packet — what stops it?**
   **Anti-Replay Protection**, using sequence numbers.

---

## Wireshark / tcpdump

### 7. Scenario-Based Interview Questions

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

### 9. Most Important Interview Questions

1. What is Wireshark? 2. What is packet capture? 3. What is packet analysis? 4. Why is Wireshark used? 5. What is a capture filter? 6. What is a display filter? 7. Capture filter vs display filter? 8. What syntax does a capture filter use? 9. What is `ip.addr == 192.168.1.10`? 10. What does `tcp.port == 443` show? 11. What is a TCP three-way handshake? 12. Explain SYN, SYN-ACK and ACK. 13. What does TCP RST mean? 14. What is TCP retransmission? 15. TCP vs UDP? 16. Does UDP use a handshake? 17. How would you analyze DNS? 18. What is an HTTP packet? 19. HTTP vs HTTPS in Wireshark? 20. Why can't Wireshark normally read HTTPS application data? 21. What is TLS? 22. What is ICMP? 23. How would you troubleshoot failed ping? 24. What is tcpdump? 25. tcpdump vs Wireshark? 26. How do you capture traffic on `eth0`? 27. How do you capture only port 443? 28. How do you save a `.pcap` file? 29. How do you read a `.pcap` file? 30. Why is tcpdump useful on headless servers?

---

### 10. Interview-Ready Answers

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

##### Best Flow to Remember for Web Troubleshooting

```text
User opens website → DNS Query/Response → TCP Handshake → TLS Handshake → HTTP(S) Communication → Check Delay/Retransmission/Errors
```

##### Key Filter Difference

```text
Before Capture: tcp port 443    → Capture Filter
After Capture:  tcp.port == 443 → Display Filter
```

> **Most important interview line:** Wireshark is best for detailed graphical packet analysis, while tcpdump is ideal for fast command-line packet capture, especially on remote or headless Linux servers.

## SIEM / SOC

### 9. Scenario-Based Interview Questions

1. **Firewall sees repeated connections, IDS detects a port scan, and Linux reports failed SSH logins — all from the same IP. How can SIEM help?**
   SIEM can correlate these events using source IP, timestamps, and related activity — instead of treating them as separate events, it identifies possible reconnaissance followed by a brute-force attack and raises a higher-priority alert.

2. **A SIEM generates a high-severity alert. What should a SOC analyst do first?**
   Start with **triage** — check whether the alert is real, its severity, source/destination, affected asset, related logs, and whether the activity is authorized. Then escalate to investigation if needed.

3. **A server is confirmed compromised. What is containment?**
   Limiting further damage — e.g. isolate the server, block the malicious IP, disable the compromised account — to stop the attacker from spreading.

4. **You isolated a malware-infected system. Is the incident finished?**
   No — containment alone isn't enough. You still need **Eradication** (remove malware/root cause) → **Recovery** (restore safely) → **Reporting** (document the incident).

5. **SIEM receives firewall logs but no authentication logs. What problem does this cause?**
   Incomplete visibility — SIEM can see connection attempts but can't determine whether a login succeeded, which user was targeted, or whether credentials were compromised, reducing correlation quality.

6. **The SOC gets hundreds of alerts every minute. What problems can this cause?**
   **Alert fatigue** — analysts become overwhelmed and may miss important incidents. Fix by tuning detection rules, reducing false positives, prioritizing high-severity alerts, correlating related events, and removing duplicate/noisy alerts.

7. **A user logs in successfully from an unusual country immediately after many failed logins. What could SIEM detect?**
   It can correlate `Multiple Failed Logins + Successful Login + Unusual Location → Possible Account Compromise`, prompting the SOC to investigate the session.

---

### 10. Most Important Interview Questions

1. What is SIEM? 2. What does SIEM stand for? 3. Why is SIEM used? 4. What is log collection? 5. What is log aggregation? 6. What is log normalization? 7. Why is normalization required? 8. What is correlation? 9. Explain SIEM correlation with an example. 10. What is detection in SIEM? 11. How does SIEM generate alerts? 12. Event vs Alert? 13. What is a SIEM dashboard? 14. Which log sources are commonly sent to SIEM? 15. What's in firewall logs? 16. What's in authentication logs? 17. Why are VPN logs important? 18. What is SOC? 19. SIEM vs SOC? 20. Explain the SOC workflow. 21. What is triage? 22. Triage vs investigation? 23. What is containment? 24. What is eradication? 25. Containment vs eradication? 26. What is recovery? 27. Why is reporting important? 28. What is alert fatigue? 29. What is a false positive? 30. What is a false negative? 31. Why is time synchronization important in SIEM? 32. What happens if important logs are missing? 33. SIEM vs IDS? 34. SIEM vs simple log management? 35. How does SIEM help incident response?

---

### 11. Interview-Ready Answers

**What is SIEM?**

> SIEM stands for Security Information and Event Management. It collects and aggregates logs from systems such as firewalls, IDS/IPS, servers, VPNs, and applications. It normalizes and correlates these events, detects suspicious patterns, generates alerts, provides dashboards, and helps SOC analysts investigate security incidents.

**What is Correlation?**

> Correlation means connecting related security events from different sources to identify a larger attack pattern. For example, if a firewall sees repeated connections, an IDS detects a port scan, and Linux records failed SSH logins from the same IP, a SIEM can correlate these events and identify possible reconnaissance followed by brute-force activity.

**SIEM vs SOC?**

> SIEM is a technology used to collect, normalize, correlate, and analyze security logs. SOC is the security operations team or function that monitors alerts, investigates incidents, and responds to threats. In simple terms, SIEM is a tool used by the SOC.

**SOC Workflow?**

> A typical SOC workflow starts with an alert. The analyst performs triage to verify and prioritize it, then investigates the event. If a real incident is confirmed, the team contains the threat, eradicates the root cause, recovers the affected systems, and finally documents the incident and lessons learned.

---

## Incident Response, Threat Hunting & MITRE ATT&CK

### 9. Scenario-Based Interview Questions

1. **A server is communicating with a known malicious IP. What would you do?**
   Follow the IR process: **Identify** (verify the malicious connection) → **Contain** (isolate server/block IP) → **Eradicate** (remove malware and root cause) → **Recover** (restore safely) → **Lessons Learned** (create detection, improve controls).

2. **A vulnerable server is under active attack, but the business can't shut it down permanently.**
   **Short-term:** block the attacker IP, isolate risky access. **Long-term:** restrict the service to trusted sources, move the server to an isolated network, deploy compensating firewall/WAF rules, increase monitoring — then prepare the permanent fix.

3. **You removed malware from a server. Is eradication complete?**
   Not necessarily — you must find **how the malware entered**. If the root cause (e.g. an unpatched web vulnerability) isn't fixed, the attacker can simply compromise the server again.

4. **After removing malware, what should you check before putting the system back into production?**
   Recovery validation: malware scan clean, vulnerability fixed, credentials reset, security settings validated, applications tested, logging/monitoring working, no suspicious activity remaining.

5. **No alert exists, but you suspect attackers are using stolen privileged accounts at night.**
   Create a hypothesis (_"Privileged accounts may be used outside normal working hours"_) → collect authentication/VPN logs → search privileged logins → check time/source/host → investigate anomalies → validate → create a SIEM detection → respond if malicious.

6. **An attacker sends a phishing email, executes PowerShell, steals credentials, and moves to another server. Map it to ATT&CK.**
   `Phishing → Initial Access` | `PowerShell → Execution` | `Credential Theft → Credential Access` | `Move to Other Server → Lateral Movement`.

7. **An attacker creates a scheduled task so malware restarts after every reboot.**
   Maps to **Persistence** — the attacker is trying to maintain access.

8. **A compromised server periodically connects to an attacker-controlled server to receive commands.**
   Maps to **Command and Control (C2)**.

9. **An attacker compresses company documents and uploads them to an external cloud server.**
   `Gather Documents → Collection` then `Upload Outside Organization → Exfiltration`.

---

### 10. Most Important Interview Questions

1. What is Incident Response? 2. What are the phases of IR? 3. What happens in Preparation? 4. What happens during Identification? 5. What is containment? 6. Short-term vs long-term containment? 7. What is eradication? 8. Containment vs eradication? 9. What is root-cause analysis? 10. What is recovery? 11. What is recovery validation? 12. What happens during Lessons Learned? 13. What is threat hunting? 14. Why is threat hunting proactive? 15. Proactive vs reactive security? 16. What is a threat-hunting hypothesis? 17. What data is used for threat hunting? 18. What is an IOC? 19. What is an IOA? 20. IOC vs IOA? 21. What happens after a hunt finds malicious behavior? 22. What is MITRE ATT&CK? 23. What does ATT&CK stand for? 24. What is a tactic/technique/procedure? 25. What are TTPs? 26. Name the 12 MITRE tactics. 27. What is Lateral Movement? 28. What is Command and Control? 29. What is Exfiltration? 30. How is MITRE ATT&CK useful for SOC and threat hunting?

---

### 11. Interview-Ready Answers

**Incident Response?**

> Incident Response is a structured process for handling cybersecurity incidents. It starts with preparation, followed by identification, containment, eradication, recovery, and lessons learned. The goal is to limit damage, remove the threat, restore systems safely, find the root cause, and prevent recurrence.

**Short-Term vs Long-Term Containment?**

> Short-term containment is an immediate emergency action, such as blocking an attacker IP or isolating a compromised server. Long-term containment provides safer temporary operation until a permanent fix can be implemented, such as moving the system to an isolated network or applying compensating firewall controls.

**Root-Cause Analysis?**

> Root-cause analysis identifies the real reason an incident occurred. For example, malware may be the visible problem, but the actual root cause could be an unpatched vulnerability, stolen credentials, or a firewall misconfiguration. Fixing the root cause prevents the attacker from using the same path again.

**Threat Hunting?**

> Threat hunting is a proactive security process in which analysts create a hypothesis and search logs, endpoint data, and network activity for hidden threats that may not have generated an alert. If malicious behavior is found, the team investigates it, creates new detection logic, and responds to the threat.

**MITRE ATT&CK?**

> MITRE ATT&CK is a knowledge base of real-world adversary behavior. It organizes attacker actions into tactics, which describe why the attacker acts, and techniques, which describe how the attacker achieves those objectives. Security teams use it for threat hunting, detection engineering, incident investigation, and identifying gaps in security controls.

---
