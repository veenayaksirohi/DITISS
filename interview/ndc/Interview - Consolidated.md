# Security Interview — Consolidated Revision Notes

---

# 1. Security Fundamentals

## 1.1 Security vs Privacy

These are **related but different** concepts.

- **Security** = protecting systems/data from unauthorized access (encryption, access control, etc.)
- **Privacy** = respecting how personal data is collected, used, and shared.

### Q&A

**Q: Can a system be secure but still violate privacy?**

> **Yes.** Example: A company may have excellent encryption and access control (secure) but still sell or misuse customer data without consent (privacy violation).

**Q: Can a system respect privacy but still be insecure?**

> **Yes.** Example: A company may have a strict privacy policy but use weak passwords or outdated software, letting attackers steal the very data it promised to protect.

> **Key takeaway:** Security and privacy are not the same — a system can have one without the other.

---

## 1.2 Server Hardening

### What is Server Hardening?

- **Definition:** An ongoing process of reducing a server's attack surface by securing its OS, accounts, applications, file system, and logging — not just the firewall.

**Q: How is server hardening different from a firewall?**

> A firewall is **one** preventive control (network-level). Server hardening is **broader** — it includes firewall config plus OS hardening, account hardening, application hardening, file system hardening, and logging hardening.

**Q: What's the first thing to check when hardening a new server?**

> Identify what's running by default — open ports, running services, default accounts — then disable/remove anything not explicitly required (**Principle of Least Privilege**).

**Q: Name a few CIS Benchmark-style hardening checks for Linux.**

- Disable root SSH login
- Disable password authentication → use SSH keys instead
- Enable a host firewall
- Enable automatic security updates
- Restrict `cron`/`sudoers` access
- Enable `auditd` logging

---

## 1.3 Interview Scenario: SSH Brute-Force Attack

**Question:** A Linux server has SSH open to the Internet and attackers are continuously trying different passwords. How would you secure it?

**Answer Approach (step-by-step):**

```
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

> This answer demonstrates: vulnerability understanding, risk management, countermeasure selection, server hardening, and **Defence in Depth**.

---

# 2. Firewalls

## 2.1 Firewall Basics

| Question                          | Answer                                                                                                                            |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **What is a firewall?**           | A security control that monitors and filters incoming and outgoing network traffic according to predefined rules.                 |
| **What does a firewall check?**   | Source IP, destination IP, port, protocol, direction, connection state; advanced firewalls also inspect applications and content. |
| **What is a firewall rule?**      | Defines what traffic should be allowed or denied, based on conditions like IP, port, protocol, direction, or connection state.    |
| **What is packet filtering?**     | Checking packet header info (source/destination IP, ports, protocol) to decide whether to allow or block traffic.                 |
| **What is a stateless firewall?** | Examines every packet independently — does **not** remember previous packets/sessions.                                            |
| **What is a stateful firewall?**  | Tracks active connections using a **state table** and uses connection state + rules to decide on packets.                         |

---

## 2.2 Scenario-Based Q&A — Basic Firewall Concepts

1. **Internal users should browse the Internet, but Internet users should not initiate connections inward. What firewall behavior helps?**

   > Use a **stateful firewall** — it lets internal users start connections and allows valid responses, while blocking unsolicited inbound connections.

2. **A firewall filters only by source/destination IP, protocol, and port, with no session memory. What kind of firewall is this?**

   > **Stateless packet-filtering firewall.**

3. **How does a stateful firewall know a reply from a web server is legitimate?**

   > It checks its **connection/state table** to confirm the packet belongs to an existing established session.

4. **A firewall rule says `ALLOW ANY ANY`. Why is this dangerous?**

   > It allows unnecessary traffic and greatly increases the attack surface. Better approach: `Default Deny + Allow Required Services Only`.

5. **Only admin `192.168.1.50` should access SSH on a server. What rule?**

```
ALLOW: Source = 192.168.1.50, Destination = Server, Protocol = TCP, Port = 22
DROP other TCP 22 traffic
```

---

## 2.3 Advanced Firewall Concepts

### 2.3.1 NGFW (Next-Generation Firewall)

- Goes beyond ports — can identify **applications** even on the same port (e.g. port 443).
- Provides: **application control**, **URL filtering**, **Deep Packet Inspection (DPI)**, and **IDS/IPS**.

### 2.3.2 Proxy Firewall

- Sits between users and the Internet, checking traffic **centrally** (e.g. against URL policy) before forwarding it.

```
Employee → Proxy → URL/Policy Check → Internet
```

### 2.3.3 Host Firewall vs Network Firewall

- **Host firewall** — runs on an individual machine (e.g. Windows Firewall).
- **Network firewall** — protects the whole network at a central point.
- Both should be used together for **Defence in Depth**.

### 2.3.4 Default Allow vs Default Deny

- **Default Allow** — allows everything except explicitly blocked traffic → riskier.
- **Default Deny** — blocks everything except explicitly allowed traffic → **safer / recommended**.

---

## 2.4 Scenario-Based Q&A — Advanced Firewall Concepts

1. **Employees need Microsoft Teams, but management wants to block YouTube — both use HTTPS 443. How?**

   > A simple port-based firewall can't tell them apart. Use an **NGFW with application control**:

   ```
   TCP 443 → NGFW → Identify Application → Teams ALLOW, YouTube BLOCK
   ```

2. **Firewall allows TCP 443, but users use unwanted apps over HTTPS. What's the problem?**

   > The firewall relies only on ports. An NGFW adds application identification/control, URL filtering, DPI, and IDS/IPS.

3. **Web requests must be checked centrally against URL policy before Internet access.**

   > Use a **proxy firewall / forward proxy**: `Employee → Proxy → URL/Policy Check → Internet`

4. **Two compromised PCs communicate inside the same LAN without passing the perimeter firewall. What helps?**

   > Use **host-based firewalls** on endpoints and consider **network segmentation**.

5. **A firewall permits all traffic except a few blocked ports — good design?**

   > No — this is **default allow** and risks accidental exposure. Safer: `Default Deny + Explicitly Allow Required Traffic`.

6. **Public web server: HTTPS for everyone, SSH only for admin.**

```
Inbound: ALLOW TCP 443 from ANY
         ALLOW TCP 22 from Admin IP
         DEFAULT DROP
```

7. **A database server should only talk to the internal app server, not the open Internet.**

```
ALLOW required internal traffic
DENY unnecessary outbound traffic
```

> Reduces malware C2 (Command & Control) and data-exfiltration risk.

8. **An employee opens an HTTPS site — why can the reply enter even though random inbound traffic is blocked?**
   > A **stateful firewall** remembers the internal user initiated the connection:
   ```
   Client starts HTTPS → state stored → Server Response matches ESTABLISHED → ALLOW
   ```
   Unsolicited inbound traffic doesn't match the state table and gets blocked.

---

## 2.5 Firewall — Master Interview Question List

```
1. What is a firewall?
2. What does a firewall check?
3. What is a firewall rule?
4. What is packet filtering?
5. Stateless vs stateful firewall?
6. Why does a stateful firewall allow return traffic?
7. What is a connection/state table?
8. What is NGFW? Why is it needed?
9. Traditional firewall vs NGFW?
10. What is application awareness/control?
11. What is Deep Packet Inspection (DPI)?
12. How does NGFW identify apps on the same port?
13. What is a proxy firewall? How does it work?
14. Forward proxy vs firewall?
15. Host firewall vs network firewall? Why use both?
16. Default Allow vs Default Deny — which is more secure?
17. Inbound vs outbound firewall rule?
18. Why should outbound traffic be filtered?
```

---

# 3. DMZ (Demilitarized Zone)

## 3.1 What is a DMZ?

> A **DMZ** is a separate network segment placed **between the Internet and the internal network**. Public-facing services (e.g. web servers) go here, so if compromised, attackers don't get direct access to sensitive internal systems.

## 3.2 Scenario-Based Q&A

1. **A company has a public web app and a sensitive database. How do you design the network?**

```
Internet → HTTPS 443 → Firewall → DMZ Web Server → Required App Port
        → Internal Firewall → Backend Server → PostgreSQL 5432 → Database
```

> The web server (or reverse proxy) goes in the DMZ, the database stays internal. Only required traffic is allowed at each hop, using least-privilege firewall rules.

2. **The DMZ web server gets compromised. What prevents the attacker from reaching the database?**
   > Controls: internal firewall, network segmentation, default-deny rules, least privilege, no direct web-to-DB path, IDS/IPS, host firewall, monitoring.

```
Attacker → Compromised Web Server → Tries DB Connection → Internal Firewall → No Rule → DROP
```

3. **Which ports should be exposed from the Internet to a DMZ web server?**

   > Only what's required — `TCP 443 ALLOW`, possibly `TCP 80 ALLOW` (for HTTPS redirect). Everything else stays blocked.

4. **Should Internet users connect directly to the database?**

   > **No.** The database stays on a private/internal network, accepting connections only from authorized app servers.

5. **Firewall has `DMZ → Internal: ALLOW ANY ANY`. What's wrong?**

   > This gives the DMZ unrestricted internal access — dangerous if the DMZ server is compromised.
   > Better: `DMZ Web Server → Specific Backend Server → Specific Port → ALLOW`, everything else → `DENY`.

6. **Admin needs SSH access to a DMZ server. How to configure it securely?**

```
Source: 192.168.10.50 (trusted admin IP)
Destination: DMZ Web Server
Port: TCP 22
Action: ALLOW
(deny all other SSH traffic)
```

7. **A web server needs database access. Should you allow `DMZ → Database ANY`?**
   > **No.** Allow only specific source + destination + port, e.g. `Backend Server → Database Server → TCP 5432` (least privilege).

---

## 3.3 DMZ — Master Interview Question List

```
1. What is a DMZ?
2. What does DMZ stand for?
3. Why is a DMZ used?
4. Where is a DMZ placed?
5. Which servers go in a DMZ?
6. Why place a web server in a DMZ?
7. Why shouldn't a database be in a DMZ / Internet-facing?
8. What rules exist: Internet→DMZ, DMZ→Internal, Internal→DMZ?
9. What happens if a DMZ server is compromised?
10. How does DMZ reduce "blast radius"?
11. DMZ vs internal network? vs firewall? vs VLAN?
12. Can a DMZ be created with one firewall?
13. How does NAT work with a DMZ?
14. Why is `ALLOW ANY ANY` from DMZ to LAN dangerous?
15. How does DMZ support Defence in Depth?
```

## 3.4 DMZ — Interview-Ready Answers

**Full Definition:**

> A DMZ, or Demilitarized Zone, is a separate network segment placed between the Internet and the organization's internal network. Public-facing services such as web servers are placed in the DMZ so that if they are compromised, attackers do not get direct access to sensitive internal systems. Traffic between the Internet, DMZ, and internal network is controlled using strict firewall rules.

**30-Second Answer:**

> A DMZ is a separate network zone used for public-facing services such as web servers. It sits between the Internet and the internal network. For example, Internet users can access the DMZ web server only on HTTPS port 443, while the internal database stays private. DMZ-to-internal traffic follows least privilege and default-deny rules — limiting lateral movement if the public server is compromised.

---

# 4. iptables

## 4.1 Chain Basics

| Chain       | Used For                                                              |
| ----------- | --------------------------------------------------------------------- |
| **INPUT**   | Traffic destined **to** this machine (e.g. incoming SSH)              |
| **OUTPUT**  | Traffic **generated** by this machine (e.g. outgoing HTTPS request)   |
| **FORWARD** | Traffic **routed through** this machine (e.g. LAN ↔ Internet routing) |

## 4.2 Scenario Q&A — Chains & Basic Rules

1. **Remote SSH into the server — which chain?**

   > `INPUT` (this machine is the destination).

2. **Server connects out to google.com over HTTPS — which chain?**

   > `OUTPUT` (traffic generated locally).

3. **Server routes LAN↔Internet traffic — which chain?**

   > `FORWARD`.

4. **A DROP rule for an IP isn't taking effect — what to check?**

   > Correct table/chain, rule order, source/destination, protocol/port, packet counters, connection state — and especially an earlier `ACCEPT` rule matching first.

5. **About to set INPUT's default policy to DROP over SSH — what should you do first?**

   > Add an explicit allow rule for your trusted IP **first**:

   ```bash
   iptables -A INPUT -p tcp -s ADMIN_IP --dport 22 -j ACCEPT
   ```

   Then apply the DROP policy — otherwise you'll lock yourself out.

6. **Allow internal users out, block unsolicited inbound — how does conntrack help?**

   > Traffic the internal host initiates gets tracked; replies come back as `ESTABLISHED`. A rule allowing `ESTABLISHED,RELATED` lets replies through, while new unsolicited inbound traffic stays blocked.

7. **Forward public port 8080 to an internal server on port 80 — what's used?**
   > The **`nat` table** with **DNAT/port forwarding**, typically on the `PREROUTING` chain.

---

## 4.3 NAT (Network Address Translation) — Scenario Q&A

1. **Internal PCs need Internet access.**

   > IP Forwarding + SNAT/PAT or MASQUERADE + FORWARD rules.

2. **Publish an internal web server (192.168.1.10:80) on public 203.0.113.10:80.**

   > DNAT/port forwarding on `PREROUTING`, plus a FORWARD allow rule.

3. **Public :8080 must reach a private service on :80.**

   > Port forwarding via **DNAT** (ports can differ).

4. **Firewall has a fixed public IP — which source-NAT approach?**

   > **SNAT** (IP is known/fixed).

5. **ISP changes the public IP dynamically — which NAT target?**

   > **MASQUERADE** (auto-uses the current interface IP).

6. **MASQUERADE configured but no Internet.**

   > Check: IP forwarding, client default gateway, FORWARD rules, outgoing interface, NAT rule, DNS, routing.

7. **DNAT configured but server unreachable from outside.**

   > Check: DNAT rule on PREROUTING, matching FORWARD rule, IP forwarding enabled, destination server up/listening, no return-path NAT issues.

8. **100 office PCs share one public IPv4.**

   > **PAT / NAT Overload** — ports distinguish the connections.

9. **How does the router know which internal host gets a reply?**
   > Its **NAT/connection-tracking table** maps the public `IP:port` back to the original private `IP:port`.

---

## 4.4 Fail2ban — Scenario Q&A

1. **Hundreds of failed logins from one IP — what do you do?**

   > Check `auth.log`, identify the source IP, configure Fail2ban to ban it after N failures, and layer on SSH keys, firewall restrictions, and monitoring.

2. **Admin mistypes password 5 times and gets blocked — what happened?**

   > Fail2ban hit `maxretry` — likely a false positive. Check status/logs, unban the trusted IP, and tune the jail if needed.

3. **How does Fail2ban know which IP to block?**

   > It parses the source IP from matching log lines (e.g. "Failed password from 203.0.113.50") and counts failures per IP.

4. **Attacker switches IP after being banned — then what?**

   > The ban applies only to the detected IP; the new IP is treated separately. Pair Fail2ban with **MFA, SSH keys, firewall restrictions, SIEM monitoring**.

5. **Service is running but nobody gets banned — what to check?**

   > Correct jail enabled? Correct `logpath`? Failures actually in the log? Filter matching? `maxretry`/`findtime` correct? Firewall integration working? IP in `ignoreip`?
   > Useful command: `fail2ban-client status[, sshd]`

6. **IP is banned but SSH still accepts connections — why?**

   > Firewall action failed, wrong firewall backend/jail, rule not created, traffic using another path/interface, container/namespace issue, or rule-order/policy conflict.

7. **Can Fail2ban fully stop brute-force attacks?**
   > **No** — it reduces attempts from detected IPs but doesn't stop distributed attacks, slow attacks, or credential reuse. It's one layer of Defence in Depth.

> **Best interview line:** Fail2ban **detects** from logs; the **firewall performs the blocking**.

---

## 4.5 GeoIP Blocking — Scenario Q&A

1. **Company serves only India; most brute-force traffic is from elsewhere — what to do?**

   > Use GeoIP blocking as **one extra control**, not the only one — pair with strong authentication, Fail2ban, IDS/IPS, rate limiting, and monitoring.

2. **A country is blocked but attacks still arrive "from India" — why?**

   > Attackers can bypass GeoIP via VPNs, proxies, cloud servers, botnets, or compromised local systems. GeoIP reduces exposure but doesn't prove real location.

3. **An employee traveling abroad suddenly can't reach the company portal — why, and what's the fix?**

   > A GeoIP rule is likely blocking their current country. Fix: secure VPN access, temporary approved access, or identity-based access with MFA — don't disable all controls.

4. **Would you secure SSH with GeoIP alone?**

   > **No** — combine GeoIP with trusted-IP/VPN restriction, SSH keys, MFA, Fail2ban, and monitoring.

5. **Why can a GeoIP rule block the wrong user?**

   > GeoIP databases aren't always accurate — IPs may belong to VPNs, cloud providers, mobile networks, or ISPs with changing allocations.

6. **All non-India traffic is blocked — is the network now secure?**
   > **No** — an attacker can still operate from India, an Indian VPN/cloud server, or a compromised Indian device. Firewall rules, IDS/IPS, authentication, MFA, patching, monitoring, SIEM, and rate limiting are still needed.

---

# 5. IDS / IPS

## 5.1 Scenario-Based Q&A

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
| 14  | Brand-new attack technique, no signature exists               | **Anomaly-based detection** has a better chance                                              |

## 5.2 Interview-Ready Answers (Summary)

**IDS vs IPS:**

> IDS stands for Intrusion Detection System — monitors traffic/host activity and alerts on suspicious behavior. IPS stands for Intrusion Prevention System — usually inline and can automatically block malicious traffic. In short: IDS detects, IPS detects and prevents.

**NIDS vs HIDS:**

> NIDS monitors network packets and detects network-based attacks like port scans. HIDS runs on a host and detects unauthorized file changes, suspicious processes, and failed logins.

**NIPS vs HIPS:**

> NIPS protects network traffic and blocks malicious packets before they reach systems. HIPS protects a single host and blocks suspicious activity on that host.

**Signature vs Anomaly:**

> Signature-based detection compares activity to known attack patterns — effective for known attacks. Anomaly-based detection compares activity to normal behavior and can catch unknown attacks, but may cause more false positives.

**False Positive vs False Negative:**

> A false positive is an alert with no real attack. A false negative is a real attack that goes undetected. False negatives are generally more dangerous.

---

# 6. VPN (Virtual Private Network)

## 6.1 Scenario-Based Q&A

1. **An employee works from home and needs access to an internal company server. Which VPN?**
   > **Remote Access VPN.**

```
Employee → Internet → Remote Access VPN → Company Network
```

2. **Delhi and Pune offices need permanent secure connectivity. Which VPN?**
   > **Site-to-Site VPN.**

```
Delhi LAN → VPN Gateway → Encrypted Tunnel → VPN Gateway → Pune LAN
```

3. **Management wants all employee Internet traffic to pass through corporate firewall, web filter, IDS/IPS, and SIEM logging.**

   > **Full Tunnel** — all routed traffic goes through the VPN gateway.

4. **Employees should use VPN only for internal resources; YouTube/normal browsing uses home Internet directly.**

   > **Split Tunnel.**

5. **VPN gateway overloaded because thousands of remote users send all Internet traffic through it. What might reduce the load?**

   > A carefully designed **split-tunnel** config may reduce VPN bandwidth usage — but weigh the security trade-off, since some traffic bypasses corporate inspection.

6. **A company uses a service-provider MPLS network to privately connect offices, and the provider separates traffic from other customers.**

   > **Trusted VPN.**

7. **Two offices communicate over the public Internet using IPsec encryption.**

   > **Secure VPN** — security via cryptographic protection.

8. **A company uses MPLS between branches but also uses IPsec encryption over the MPLS network.**

   > **Hybrid VPN** — combines a Trusted Provider Network with cryptographic VPN security.

9. **VPN shows "Connected", but employee can't access `10.0.0.20`. What would you check?**

```
VPN Tunnel Established? → VPN IP Assigned? → Route to 10.0.0.20 Present?
→ Firewall Rule Allows Traffic? → Internal Routing Correct? → Return Route Present?
→ Server Host Firewall? → DNS, if using hostname?
```

10. **Attackers repeatedly try leaked employee passwords against the VPN gateway. What would you do?**
    > Use multiple controls: MFA, strong password policy, rate limiting, account lockout, SIEM monitoring, VPN gateway patching, disable compromised credentials, restrict access.

---

## 6.2 VPN Types — Comparison

| Type                  | Meaning                                                                                      |
| --------------------- | -------------------------------------------------------------------------------------------- |
| **Remote Access VPN** | Connects an individual user/device to the org's network                                      |
| **Site-to-Site VPN**  | Connects two entire networks via VPN gateways                                                |
| **Full Tunnel**       | All traffic routed through VPN gateway → better security control, more bandwidth used        |
| **Split Tunnel**      | Only corporate traffic via VPN, rest goes direct → better performance, less visibility       |
| **Secure VPN**        | Protected using cryptography (encryption/authentication), e.g. IPsec over Internet           |
| **Trusted VPN**       | Relies on a provider's private network/isolation (e.g. MPLS); may lack end-to-end encryption |
| **Hybrid VPN**        | Combines Trusted Provider Network + cryptographic VPN protection (e.g. IPsec over MPLS)      |

## 6.3 VPN — Master Interview Question List

```
1. What is a VPN? Why is it used?
2. What is VPN encryption? Tunneling? Authentication?
3. Why is integrity important in a VPN?
4. Remote Access vs Site-to-Site VPN?
5. Full Tunnel vs Split Tunnel? Which is easier for central security control? Which uses less bandwidth?
6. Secure VPN vs Trusted VPN? What is Hybrid VPN? Give an example.
7. Is a Trusted VPN always encrypted? Can a VPN work without encryption?
8. Why use MFA with VPN? What happens if VPN credentials are stolen?
9. How to troubleshoot "VPN connected but no access"?
10. How does VPN fit into Defence in Depth?
```

## 6.4 VPN — Interview-Ready Answers

**What is a VPN?**

> A VPN, or Virtual Private Network, creates a secure logical tunnel between a user or network and another network. It commonly uses encryption, authentication, integrity protection, and tunneling to protect communication over an untrusted network such as the Internet.

**Remote Access vs Site-to-Site:**

> Remote Access VPN connects an individual user or device to an organization's network, while Site-to-Site VPN connects two entire networks through VPN gateways.

**Full vs Split Tunnel:**

> In Full Tunnel VPN, all configured user traffic is routed through the VPN gateway — better centralized security control, but more bandwidth used. In Split Tunnel, only selected corporate traffic goes through the VPN while other Internet traffic goes directly via the user's ISP — improves performance but reduces centralized visibility.

**Secure vs Trusted VPN:**

> A Secure VPN protects traffic using cryptography (encryption/authentication), often over the public Internet. A Trusted VPN relies mainly on a provider's private network and traffic isolation (e.g. MPLS) and may not provide end-to-end encryption by itself.

**Hybrid VPN:**

> A Hybrid VPN combines a trusted provider network with cryptographic VPN protection. Example: a company uses MPLS between branches and also runs IPsec over it for encryption.

---

# 7. IPsec

## 7.1 Scenario-Based Q&A

1. **Two offices need to securely communicate over the Internet — which mode?**

   > **Tunnel Mode** — gateways need to protect and encapsulate the entire original packet.

2. **You need confidentiality + authentication + integrity — AH or ESP?**

   > **ESP** — AH does **not** encrypt data.

3. **Two hosts communicate directly via IPsec with no extra outer header needed — which mode?**

   > **Transport Mode.**

4. **An IPsec tunnel won't establish — what would you check?**

```
Gateways can reach each other? → UDP 500 allowed? → NAT present (check UDP 4500/NAT-T)?
→ Same IKE version? → PSK/certificate correct? → Encryption/integrity algorithms match? → Correct subnets?
```

5. **Tunnel shows UP, but users can't reach the remote network — what would you check?**

   > Local/remote subnet definitions, routing table, firewall rules, NAT exemption, return route, host firewalls, traffic selectors.

6. **An IPsec client is behind a NAT router — what feature is needed?**

   > **NAT-T** (NAT Traversal), commonly over UDP 4500.

7. **An attacker resends a previously captured valid IPsec packet — what stops it?**
   > **Anti-Replay Protection**, using sequence numbers.

## 7.2 Quick Reference

| Concept            | Meaning                                                 |
| ------------------ | ------------------------------------------------------- |
| **Tunnel Mode**    | Encapsulates entire original packet — used site-to-site |
| **Transport Mode** | Protects payload only, direct host-to-host              |
| **AH**             | Authentication + Integrity (no encryption)              |
| **ESP**            | Confidentiality + Authentication + Integrity            |
| **NAT-T**          | Lets IPsec work through NAT (UDP 4500)                  |
| **Anti-Replay**    | Uses sequence numbers to block resent packets           |

---

# 8. Wireshark / tcpdump

## 8.1 Scenario-Based Q&A

1. **A user says a website is slow — how would you analyze it?**

   > Check step by step: `DNS → TCP Handshake → TLS Handshake → Application Traffic → Retransmissions/Delays`. Look for slow DNS, slow SYN/SYN-ACK, TCP retransmissions, TLS negotiation delay, or slow server response.

2. **Client sends SYN to a server port but gets no SYN-ACK — why?**

   > Possible causes: firewall blocking traffic, server down, routing problem, packet lost, service unavailable. If the server replies with `RST` instead, the destination is reachable but actively refusing the connection.

3. **You capture a DNS Query but no DNS Response — what would you check?**

   > DNS server connectivity, firewall, routing, DNS service status, correct DNS server address.

4. **Ping fails — ICMP Echo Request sent but no reply — what would you check?**

   > Remote host status, firewall, routing, ICMP filtering.

5. **You've captured 100,000 packets and now want to see only DNS — capture or display filter?**

   > **Display filter** (`dns`) — capture already complete, so you filter what's shown.

6. **Before starting a capture, you only want TCP port 443 traffic — capture or display filter?**

   > **Capture filter** (`tcp port 443`) — set before capture to reduce what's recorded.

7. **A Linux server has no GUI. You want to capture traffic and analyze it later.**

```bash
tcpdump -i eth0 -w capture.pcap
```

Then open `capture.pcap` in Wireshark.

8. **You see repeated `SYN, SYN, SYN` with no SYN-ACK — what does this mean?**

   > The client is retransmitting its connection attempt. Possible causes: firewall silently dropping packets, routing issue, server unavailable, packet loss.

9. **You see `Client → SYN` followed by `Server → RST, ACK` — what does this mean?**

   > The server is reachable, but the destination TCP port is closed or the connection is actively refused.

10. **Wireshark captures TCP 443 traffic, but you can't read usernames/passwords — why?**

    > Because HTTPS uses TLS encryption. Wireshark can show connection metadata, TCP behavior, and TLS handshake info, but application content stays encrypted unless decryption keys are available.

11. **How do you find all traffic for one specific IP address?**

```
ip.addr == 192.168.1.10
```

Shows traffic where that IP is either source or destination.

12. **How do you find HTTPS (TCP) traffic on a specific port?**

```
tcp.port == 443
```

> Note: modern HTTP/3 may use QUIC over **UDP** 443, so a TCP-only filter would miss that traffic.

---

## 8.2 Capture Filter vs Display Filter

| Capture Filter                 | Display Filter                    |
| ------------------------------ | --------------------------------- |
| Applied **before** capture     | Applied **after** capture         |
| Decides what gets **recorded** | Decides what gets **shown**       |
| Syntax example: `tcp port 443` | Syntax example: `tcp.port == 443` |
| Uses BPF syntax                | Uses Wireshark's own syntax       |

```
Before Capture: tcp port 443    → Capture Filter
After Capture:  tcp.port == 443 → Display Filter
```

---

## 8.3 Wireshark vs tcpdump — Master Interview Question List

```
1. What is Wireshark? What is packet capture/analysis? Why is it used?
2. Capture filter vs display filter? Syntax used?
3. What is ip.addr == 192.168.1.10? What does tcp.port == 443 show?
4. What is a TCP three-way handshake (SYN, SYN-ACK, ACK)?
5. What does TCP RST mean? What is TCP retransmission?
6. TCP vs UDP? Does UDP use a handshake?
7. How would you analyze DNS? HTTP vs HTTPS in Wireshark?
8. Why can't Wireshark normally read HTTPS application data? What is TLS?
9. What is ICMP? How to troubleshoot failed ping?
10. What is tcpdump? tcpdump vs Wireshark?
11. How to capture on eth0? Capture only port 443? Save/read a .pcap file?
12. Why is tcpdump useful on headless servers?
```

## 8.4 Interview-Ready Answers

**What is Wireshark?**

> Wireshark is a graphical network packet analyzer used to capture and inspect packets. It helps troubleshoot network problems and analyze protocols such as TCP, UDP, DNS, HTTP, TLS, and ICMP.

**Capture Filter vs Display Filter?**

> A capture filter is applied before packet capture and determines which packets are recorded. A display filter is applied after capture and determines which captured packets are shown. For example, `tcp port 443` is a capture filter, while `tcp.port == 443` is a Wireshark display filter.

**TCP Handshake?**

> TCP establishes a connection using a three-way handshake. The client sends SYN, the server responds with SYN-ACK, and the client sends ACK. After these three steps, the TCP connection is established.

**What is tcpdump?**

> tcpdump is a command-line packet capture tool commonly used on Linux systems. It can capture packets from network interfaces, apply BPF filters, and save traffic to `.pcap` files for later analysis in tools such as Wireshark.

**tcpdump vs Wireshark?**

> tcpdump is lightweight and command-line based — ideal for servers and SSH troubleshooting. Wireshark provides a graphical interface and more convenient deep packet analysis. A common workflow: capture packets with tcpdump on a server, then analyze the `.pcap` file later in Wireshark.

### Best Flow for Web Troubleshooting

```
User opens website → DNS Query/Response → TCP Handshake → TLS Handshake → HTTP(S) Communication → Check Delay/Retransmission/Errors
```

> **Most important interview line:** Wireshark is best for detailed graphical packet analysis, while tcpdump is ideal for fast command-line packet capture, especially on remote or headless Linux servers.

---

# 9. SIEM / SOC

## 9.1 Scenario-Based Q&A

1. **Firewall sees repeated connections, IDS detects a port scan, and Linux reports failed SSH logins — all from the same IP. How can SIEM help?**

   > SIEM can **correlate** these events using source IP, timestamps, and related activity — instead of treating them separately, it identifies possible reconnaissance followed by a brute-force attack and raises a higher-priority alert.

2. **A SIEM generates a high-severity alert. What should a SOC analyst do first?**

   > Start with **triage** — check if the alert is real, its severity, source/destination, affected asset, related logs, and whether the activity is authorized. Then escalate to investigation if needed.

3. **A server is confirmed compromised. What is containment?**

   > Limiting further damage — e.g. isolate the server, block the malicious IP, disable the compromised account — to stop the attacker from spreading.

4. **You isolated a malware-infected system. Is the incident finished?**

   > **No** — containment alone isn't enough. You still need: **Eradication** (remove malware/root cause) → **Recovery** (restore safely) → **Reporting** (document the incident).

5. **SIEM receives firewall logs but no authentication logs. What problem does this cause?**

   > Incomplete visibility — SIEM sees connection attempts but can't tell if a login succeeded, which user was targeted, or whether credentials were compromised, reducing correlation quality.

6. **The SOC gets hundreds of alerts every minute. What problems can this cause?**

   > **Alert fatigue** — analysts get overwhelmed and may miss important incidents. Fix: tune detection rules, reduce false positives, prioritize high-severity alerts, correlate related events, remove duplicate/noisy alerts.

7. **A user logs in successfully from an unusual country immediately after many failed logins. What could SIEM detect?**
   > It can correlate `Multiple Failed Logins + Successful Login + Unusual Location → Possible Account Compromise`, prompting the SOC to investigate.

---

## 9.2 SIEM — Master Interview Question List

```
1. What is SIEM? What does it stand for? Why is it used?
2. What is log collection/aggregation/normalization? Why is normalization required?
3. What is correlation? Give an example.
4. How does SIEM detect and generate alerts? Event vs Alert?
5. What is a SIEM dashboard?
6. Which log sources are commonly sent to SIEM? What's in firewall logs? Auth logs? Why are VPN logs important?
7. What is SOC? SIEM vs SOC? Explain the SOC workflow.
8. Triage vs investigation? What is containment? Eradication? Containment vs eradication?
9. What is recovery? Why is reporting important?
10. What is alert fatigue? False positive vs false negative?
11. Why is time synchronization important in SIEM? What happens if important logs are missing?
12. SIEM vs IDS? SIEM vs simple log management? How does SIEM help incident response?
```

## 9.3 Interview-Ready Answers

**What is SIEM?**

> SIEM stands for Security Information and Event Management. It collects and aggregates logs from systems such as firewalls, IDS/IPS, servers, VPNs, and applications. It normalizes and correlates these events, detects suspicious patterns, generates alerts, provides dashboards, and helps SOC analysts investigate security incidents.

**What is Correlation?**

> Correlation means connecting related security events from different sources to identify a larger attack pattern. Example: if a firewall sees repeated connections, an IDS detects a port scan, and Linux records failed SSH logins from the same IP, a SIEM can correlate these and identify possible reconnaissance followed by brute-force activity.

**SIEM vs SOC?**

> SIEM is a technology used to collect, normalize, correlate, and analyze security logs. SOC is the security operations team or function that monitors alerts, investigates incidents, and responds to threats. In simple terms: **SIEM is a tool used by the SOC.**

**SOC Workflow?**

> A typical SOC workflow starts with an alert. The analyst performs triage to verify and prioritize it, then investigates the event. If a real incident is confirmed, the team contains the threat, eradicates the root cause, recovers the affected systems, and finally documents the incident and lessons learned.

### SOC Workflow Diagram

```
Alert → Triage → Investigation → Containment → Eradication → Recovery → Reporting/Lessons Learned
```

---

# 10. Incident Response, Threat Hunting & MITRE ATT&CK

## 10.1 Incident Response (IR) Phases

```
Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned
```

## 10.2 Scenario-Based Q&A

1. **A server is communicating with a known malicious IP. What would you do?**

   > Follow the IR process:
   > **Identify** (verify the malicious connection) → **Contain** (isolate server/block IP) → **Eradicate** (remove malware and root cause) → **Recover** (restore safely) → **Lessons Learned** (create detection, improve controls).

2. **A vulnerable server is under active attack, but the business can't shut it down permanently.**

   > **Short-term:** block attacker IP, isolate risky access.
   > **Long-term:** restrict service to trusted sources, move server to isolated network, deploy compensating firewall/WAF rules, increase monitoring — then prepare the permanent fix.

3. **You removed malware from a server. Is eradication complete?**

   > Not necessarily — you must find **how the malware entered**. If the root cause (e.g. unpatched vulnerability) isn't fixed, the attacker can compromise the server again.

4. **After removing malware, what should you check before putting the system back into production?**

   > **Recovery validation:** malware scan clean, vulnerability fixed, credentials reset, security settings validated, applications tested, logging/monitoring working, no suspicious activity remaining.

5. **No alert exists, but you suspect attackers are using stolen privileged accounts at night.**

   > Create a hypothesis (_"Privileged accounts may be used outside normal working hours"_) → collect authentication/VPN logs → search privileged logins → check time/source/host → investigate anomalies → validate → create a SIEM detection → respond if malicious.

6. **An attacker sends a phishing email, executes PowerShell, steals credentials, and moves to another server. Map it to ATT&CK.**

```
Phishing            → Initial Access
PowerShell          → Execution
Credential Theft    → Credential Access
Move to Other Server → Lateral Movement
```

7. **An attacker creates a scheduled task so malware restarts after every reboot.**

   > Maps to **Persistence** — the attacker is trying to maintain access.

8. **A compromised server periodically connects to an attacker-controlled server to receive commands.**

   > Maps to **Command and Control (C2)**.

9. **An attacker compresses company documents and uploads them to an external cloud server.**

```
Gather Documents        → Collection
Upload Outside Organization → Exfiltration
```

---

## 10.3 Key Definitions

| Term                              | Meaning                                                                 |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Short-term containment**        | Immediate emergency action (block IP, isolate server)                   |
| **Long-term containment**         | Safer temporary operation until a permanent fix is applied              |
| **Root-cause analysis**           | Finding the real underlying reason an incident occurred                 |
| **Threat Hunting**                | Proactive search for hidden threats without waiting for an alert        |
| **IOC** (Indicator of Compromise) | Evidence that an attack already happened (e.g. malicious hash, IP)      |
| **IOA** (Indicator of Attack)     | Evidence of attacker intent/behavior, often before compromise completes |
| **MITRE ATT&CK**                  | Knowledge base of real-world attacker tactics and techniques            |
| **Tactic**                        | The attacker's _goal_ (the "why")                                       |
| **Technique**                     | _How_ the attacker achieves that goal                                   |
| **TTPs**                          | Tactics, Techniques, and Procedures                                     |

---

## 10.4 IR / Threat Hunting / MITRE — Master Interview Question List

```
1. What is Incident Response? What are its phases?
2. What happens in Preparation? Identification? Containment?
3. Short-term vs long-term containment?
4. What is eradication? Containment vs eradication? What is root-cause analysis?
5. What is recovery? What is recovery validation? What happens in Lessons Learned?
6. What is threat hunting? Why is it proactive? Proactive vs reactive security?
7. What is a threat-hunting hypothesis? What data is used?
8. What is an IOC? What is an IOA? IOC vs IOA?
9. What happens after a hunt finds malicious behavior?
10. What is MITRE ATT&CK? What does ATT&CK stand for?
11. What is a tactic/technique/procedure? What are TTPs?
12. Name the 12 MITRE tactics. What is Lateral Movement? Command and Control? Exfiltration?
13. How is MITRE ATT&CK useful for SOC and threat hunting?
```

## 10.5 Interview-Ready Answers

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

# 11. Overall Quick Revision Summary

```
Security ≠ Privacy       → A system can be secure but still violate privacy, or vice versa
Server Hardening         → Broader than firewall: OS + accounts + apps + files + logs
Firewall                 → Filters traffic by rules (stateless = no memory, stateful = tracks sessions)
NGFW                     → App-aware firewall (DPI, app control, URL filtering)
DMZ                      → Buffer zone for public-facing services, protects internal network
iptables chains          → INPUT (to me), OUTPUT (from me), FORWARD (through me)
NAT types                → SNAT (fixed IP), MASQUERADE (dynamic IP), DNAT (port forwarding), PAT (many→one)
Fail2ban                 → Detects from logs, firewall does the blocking
GeoIP                    → One extra layer, not a full solution
IDS vs IPS               → IDS = Detect, IPS = Detect + Block
VPN types                → Remote Access, Site-to-Site, Full/Split Tunnel, Secure/Trusted/Hybrid
IPsec                     → Tunnel mode (site-to-site) vs Transport mode (host-to-host); AH (no encryption) vs ESP (encryption)
Wireshark vs tcpdump     → GUI deep analysis vs CLI capture (headless servers)
SIEM vs SOC              → SIEM = Tool, SOC = Team
IR Phases                → Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned
Threat Hunting           → Proactive, hypothesis-driven search for hidden threats
MITRE ATT&CK             → Tactics (why) + Techniques (how) = attacker playbook (TTPs)
```

---

# END OF NOTES — Good for Quick Revision, Exams & Interviews
