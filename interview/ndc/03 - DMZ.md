# DMZ — Detailed Notes

# 1. What is a DMZ?

**DMZ** stands for **Demilitarized Zone** — a separate network area placed between the Internet and the internal private network.
Used for systems that must be reachable from the Internet: Web servers, Mail servers, DNS servers, Reverse proxies, VPN gateways, Public application gateways.

> Public-facing systems should not be placed directly inside the internal network.

### Basic Architecture

```text
Internet → Firewall → DMZ → Web Server → Internal Firewall → Internal Network → Application/Database Servers
```

The DMZ works like a **buffer zone** between the Internet and the trusted internal network.

---

# 2. Why is a DMZ Used?

The main purpose is to **protect the internal network from Internet-facing systems**. A public web server must accept requests from Internet users (`Internet User → HTTPS 443 → Web Server`), which makes it more attack-prone.
If placed directly inside the internal network (`Internet → Web Server → Internal Servers → Database`), compromising it gives an attacker an easier path to sensitive systems. With a DMZ (`Internet → Firewall → DMZ Web Server → Restricted Firewall Rules → Internal Network`), the attacker's movement is restricted.

### Main Goals

- **Network Separation** — Internet, DMZ, and Internal Network become different security zones.
- **Reduced Attack Surface** — only required public services are exposed, e.g. Web Server `TCP 443 → Public` while Database `TCP 3306 → Private`. The database does not need to be reachable from the Internet.
- **Limits Attacker Movement** — without segmentation, `Attacker → Web Server → Database → Internal Systems`. With a DMZ, `Attacker → Compromised Web Server → Firewall → Restricted`, so the firewall can stop or limit further movement. This reduces the **blast radius**.
- **Defence in Depth** — `Internet → Firewall → DMZ → Firewall → Internal Network`. If one system is compromised, other security controls still exist.

---

# 3. Where is a DMZ Placed?

Normally **between the untrusted Internet and the trusted internal network**:

```text
Internet (Untrusted) → Firewall → DMZ → Firewall → Internal Network (Trusted)
```

### Trust Zones

| Zone             | Trust Level                    |
| ---------------- | ------------------------------ |
| Internet         | Untrusted                      |
| DMZ              | Partially trusted / restricted |
| Internal Network | Trusted                        |
| Database Network | Highly restricted              |

A DMZ should **not be considered fully trusted** — and even the internal network should never be treated as perfectly safe. Security should still use authentication, authorization, host firewalls, monitoring, and network segmentation.

---

# 4. DMZ Architectures

## 4.1 Two-Firewall Design

```text
Internet → External Firewall → DMZ → Web Server → Internal Firewall → Application/Database Servers
```

**External Firewall** controls `Internet → DMZ`, e.g. `Allow HTTPS 443, Block unnecessary traffic`.
**Internal Firewall** controls `DMZ → Internal Network` and should be more restrictive — e.g. `Web Server → Application Server:5000` may be allowed, but `Web Server → Database:ANY` should not be freely allowed.

## 4.2 One-Firewall Design

A DMZ can also be created using one firewall with multiple interfaces (WAN, LAN, DMZ):

```text
Internet → Firewall ─┬─ WAN → Internet
                      ├─ DMZ → 192.168.20.0/24 → Web Server
                      └─ LAN → 192.168.10.0/24 → Internal Network
```

The firewall controls communication between these zones.

---

# 5. Web Server in the DMZ

A web server is the most common DMZ system since Internet users need to reach it directly.

```text
Internet User → TCP 443 → Firewall → DMZ → Web Server
```

Rule: `Source: Internet, Destination: DMZ Web Server, Protocol: TCP, Port: 443, Action: ALLOW`. Everything else may be blocked unless required.

### Why Put It There?

A public web server receives untrusted traffic — normal users, attackers, bots, scanners, malware. Placing it in a DMZ isolates it from employee PCs, domain controllers, internal applications, file servers, databases, and management systems.

---

# 6. Example: Three-Tier Application with DMZ

```text
Frontend → Backend → Database
```

Secure design:

```text
Internet → Firewall → DMZ → Web/Frontend Server → Internal Firewall → Application Server → Database Server
```

With specific ports controlled at every step:

```text
Internet → TCP 443 → Web Server → Required Backend Port → Application Server → TCP 5432 → PostgreSQL Database
```

---

# 7. Database Security

## 7.1 Why the Database Should Not Be Directly Exposed

Databases usually hold sensitive data: user information, password hashes, financial records, company/application data. They generally don't need direct Internet access.
Bad design: `Internet → MySQL 3306 → Database` or `Internet → PostgreSQL 5432 → Database` — this increases exposure.

## 7.2 Risks of Exposure

If publicly reachable (e.g. `0.0.0.0/0 → TCP 3306`), attackers can attempt password guessing, brute-force attacks, exploiting database vulnerabilities, using stolen credentials, scanning the service, and unauthorized data access.

## 7.3 Better Database Design

Instead of `Internet → Database`, use:

```text
Internet → Web Server → Application Server → Database
```

Restrict access to only the application server: `Only Application Server → TCP 5432 → Database`.
Rule: `Source: Application Server, Destination: Database Server, Port: 5432, Action: ALLOW`, then `Everyone Else → Database 5432 → DROP`.

## 7.4 Least Privilege Principle

Only systems that actually require database access should receive it:

```text
Web Server → Database:            DENY
Application Server → Database:    ALLOW TCP 5432
Internet → Database:              DENY
```

---

# 8. Firewall Rules for DMZ Traffic

## 8.1 Internet → DMZ Rules

Control traffic coming from the Internet to public-facing DMZ systems. Example — DMZ Web Server `192.168.20.10`, required services `HTTP TCP 80, HTTPS TCP 443`:
| Source | Destination | Port | Action |
|---|---|---:|---|
| Internet | Web Server | TCP 443 | ALLOW |
| Internet | Web Server | TCP 80 | ALLOW if needed |
| Internet | Web Server | TCP 22 | DENY |
| Internet | Database | TCP 3306 | DENY |
| Internet | Internal LAN | ANY | DENY |
A more secure deployment may redirect HTTP to HTTPS and mainly use TCP 443.

**Principle:** `Default Deny + Allow Only Required Services`, e.g. `ALLOW Internet → Web Server TCP 443` / `DROP Internet → DMZ ANY OTHER`. Never use `ALLOW Internet → DMZ ANY ANY` unless there is a very specific justified requirement.

## 8.2 DMZ → Internal Rules

Extremely important — a compromised DMZ server should **not** have unrestricted access to the internal network. Bad rule: `DMZ → Internal Network: ALLOW ANY ANY` — this can let an attacker move from the DMZ into internal systems.

Only required communication should be allowed, e.g. `DMZ Web Server → Application Server → TCP 5000`:

```text
Rule: Source DMZ Web Server, Destination Application Server, Port TCP 5000, Action ALLOW
Everything else: DMZ → Internal → DEFAULT DENY
```

Database access example: allow `DMZ Web Server → TCP 5000 → Backend Server → TCP 5432 → Database`, but block `DMZ Web Server → TCP 5432 → Database` directly — stronger segmentation.

Restricting this traffic matters because if the web server is compromised and DMZ access is unrestricted, the attack can spread (`Compromised Web Server → Internal PCs → Database → Domain Controller`). With restrictions, only the specifically allowed port reaches the app server and everything else is blocked — limiting the blast radius.

## 8.3 Internal → DMZ Rules

Internal systems may need DMZ access for administration, monitoring, log collection, updates, backups, and application communication — these connections should also be controlled.

Example — admin SSH access: instead of `Entire Internal Network → SSH 22 → DMZ Server`, use:
| Source | Destination | Port | Action |
|---|---|---:|---|
| Admin PC (192.168.10.50) | DMZ Web Server | TCP 22 | ALLOW |
| Other PCs | DMZ Web Server | TCP 22 | DENY |
Similarly, only the specific monitoring server should be allowed to reach the web server's monitoring port.

Even though internal is more trusted than DMZ, unrestricted traffic is still risky:

```text
Bad:    LAN → DMZ  ALLOW ANY ANY
Better: Admin Network → DMZ SSH | Monitoring Server → DMZ Monitoring Port | Internal Users → DMZ HTTPS | Other traffic → DENY
```

## 8.4 Return Traffic and Stateful Firewalls

When an Internet user connects to `Web Server:443`, the response travels back `Web Server → Internet User`. With a **stateful firewall**, the connection is remembered as `ESTABLISHED`, so response traffic can be allowed without creating broad outbound rules.

## 8.5 Full DMZ Traffic Example

```text
Internet → Firewall → DMZ Web Server → Internal Firewall → Backend → Database
```

| Source             | Destination  | Service           | Action |
| ------------------ | ------------ | ----------------- | ------ |
| Internet           | Web Server   | HTTPS 443         | ALLOW  |
| Internet           | Web Server   | SSH 22            | DENY   |
| Internet           | Internal LAN | ANY               | DENY   |
| Internet           | Database     | ANY               | DENY   |
| Web Server         | Backend      | Required app port | ALLOW  |
| Web Server         | Database     | ANY               | DENY   |
| DMZ                | Internal LAN | ANY unnecessary   | DENY   |
| Backend            | Database     | PostgreSQL 5432   | ALLOW  |
| Admin PC           | Web Server   | SSH 22            | ALLOW  |
| Other Internal PCs | Web Server   | SSH 22            | DENY   |

---

# 9. DMZ vs Related Concepts

## 9.1 DMZ vs Internal Network

| DMZ                                  | Internal Network                  |
| ------------------------------------ | --------------------------------- |
| Public-facing systems                | Private business systems          |
| More exposed                         | Less exposed                      |
| Lower trust                          | Higher trust                      |
| Strict communication to internal LAN | Contains sensitive services       |
| Web/DNS/mail/reverse proxy           | DB, AD, file server, employee PCs |

## 9.2 DMZ vs Firewall

Not the same thing. A **Firewall** is a security control that filters traffic (`Packet → Firewall Rules → Allow/Deny`). A **DMZ** is a network security zone (`Internet → Firewall → DMZ`). A firewall is normally used to control traffic entering and leaving the DMZ.

## 9.3 DMZ vs VLAN

A **VLAN** logically separates networks at the switching level. A **DMZ** is a security zone containing exposed services, and may be implemented using `VLAN + Firewall Rules`, e.g. `VLAN 10 → Internal LAN`, `VLAN 20 → DMZ`, with the firewall controlling traffic between them.

## 9.4 DMZ and NAT

Public-facing DMZ servers may use private IP addresses:

```text
Internet → Public IP 203.0.113.10:443 → Firewall/DNAT → DMZ Server 192.168.20.10:443
```

The DMZ server itself does not necessarily need a directly assigned public IP.

---

# 10. DMZ with Additional Security Layers

## 10.1 Reverse Proxy

Commonly placed in a DMZ:

```text
Internet → Firewall → DMZ → Nginx Reverse Proxy → Internal Application Servers
```

Benefits: internal servers are hidden, TLS can terminate at the reverse proxy, requests can be filtered, load balancing can be performed.

## 10.2 IDS/IPS

```text
Internet → Firewall → IDS/IPS → DMZ → Web Server
```

Helps detect port scanning, exploit attempts, suspicious connections, malicious traffic.

## 10.3 SIEM

```text
Firewall Logs + Web Server Logs + IDS Alerts → SIEM → Correlation/Alert
```

Example: Firewall sees many requests from IP X + IDS sees an exploit attempt from IP X + Web Server sees multiple errors from IP X → SIEM flags a possible attack.

## 10.4 Defence in Depth with DMZ

```text
Internet → Edge Firewall → IPS → DMZ → Reverse Proxy/Web Server → Internal Firewall → Application Server → Database Firewall/ACL → Database
```

Additional controls: host firewall, MFA, patching, logging, SIEM, EDR, backups.

---

# 11. Common DMZ Mistakes

1. **Allow Any from DMZ to LAN** — `DMZ → LAN ALLOW ANY ANY`. Very risky.
2. **Database in DMZ** — `Internet → DMZ → Database`. Sensitive databases should generally be kept in a more protected network.
3. **Public SSH for Everyone** — `Internet → DMZ Web Server TCP 22, Source = ANY`. Better: allow only a trusted admin IP, or use a secure management path such as a bastion/VPN.
4. **No Monitoring** — a DMZ is exposed to the Internet and should be monitored via firewall logging, IDS/IPS, web logs, SIEM, system monitoring.
5. **No Patching** — putting a server in a DMZ doesn't make a vulnerable server safe; it still needs security updates, strong authentication, minimal services, secure configuration, and monitoring.

---

# 12. Scenario-Based Interview Questions

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

# 14. Most Important Interview Questions

1. What is a DMZ? 2. What does DMZ stand for? 3. Why is a DMZ used? 4. Where is a DMZ placed? 5. Which servers can be placed in a DMZ? 6. Why should a web server be placed in a DMZ? 7. Why should a database not normally be in a DMZ? 8. Why should a database not be directly Internet-facing? 9. What rules should exist from Internet → DMZ? 10. What rules should exist from DMZ → Internal? 11. What rules should exist from Internal → DMZ? 12. What happens if a DMZ server is compromised? 13. How does a DMZ reduce blast radius? 14. DMZ vs internal network? 15. DMZ vs firewall? 16. DMZ vs VLAN? 17. Can a DMZ be created using one firewall? 18. How does NAT work with a DMZ? 19. Why is `ALLOW ANY ANY` from DMZ to LAN dangerous? 20. How does DMZ support Defence in Depth?

---

# 15. Interview-Ready Answers

### Full Definition

> A DMZ, or Demilitarized Zone, is a separate network segment placed between the Internet and the organization's internal network. Public-facing services such as web servers are placed in the DMZ so that if they are compromised, attackers do not get direct access to sensitive internal systems. Traffic between the Internet, DMZ, and internal network is controlled using strict firewall rules.

### 30-Second Answer

> A DMZ is a separate network zone used for public-facing services such as web servers. It is placed between the Internet and the internal network. For example, I can allow Internet users to access the DMZ web server only on HTTPS port 443, while the internal database remains private. Communication from the DMZ to the internal network should follow least privilege and default-deny rules. This limits lateral movement if the public server is compromised.

---

# 16. Best Diagram to Remember

```text
                    INTERNET
                        ↓
                  External Firewall
                        ↓
                 ┌──────────────┐
                 │     DMZ      │
                 │  Web Server  │
                 │ Reverse Proxy│
                 └──────┬───────┘
                        ↓
                  Internal Firewall
                        ↓
                 Internal Network
                        ↓
                Application Server
                        ↓
                     Database
```

### Example Rules

```text
Internet → Web Server:443           ALLOW
Internet → Database                 DENY
DMZ Web Server → Required Backend Port  ALLOW
DMZ → Other Internal Systems        DENY
Backend → Database:5432             ALLOW
Admin PC → DMZ Server:22            ALLOW
```

---

# 17. One-Line Revision

```text
DMZ → Separate network between Internet and internal LAN.
Why DMZ? → Isolate public-facing servers from sensitive systems.
Web Server → Commonly placed in DMZ.
Database → Keep private and restrict access.
Internet → DMZ → Allow only required public ports.
DMZ → Internal → Very strict, least privilege.
Internal → DMZ → Allow only required admin/service traffic.
Main Principle → Default Deny + Least Privilege + Segmentation.
```

### Final Memory Flow

```text
Internet → Firewall → DMZ → Public Web Server → Strict Internal Firewall → Application Server → Private Database
```

**Main security idea:** even if the **public web server is compromised**, the **internal application and database systems should still remain protected**.
