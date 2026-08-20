# DMZ — Detailed Notes

## 1. What is a DMZ?

**DMZ** stands for **Demilitarized Zone**.

A DMZ is a **separate network area placed between the Internet and the internal private network**.

It is used for systems that must be reachable from the Internet, such as:

- Web servers
- Mail servers
- DNS servers
- Reverse proxies
- VPN gateways
- Public application gateways

The main idea is:

> Public-facing systems should not be placed directly inside the internal network.

### Basic Architecture

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Web Server
   ↓
Internal Firewall
   ↓
Internal Network
   ↓
Application / Database Servers
```

The DMZ works like a **buffer zone** between the Internet and the trusted internal network.

---

# 2. Why is a DMZ Used?

The main purpose of a DMZ is to **protect the internal network from Internet-facing systems**.

A public web server must accept requests from Internet users.

For example:

```text
Internet User
      ↓
   HTTPS 443
      ↓
Web Server
```

Because the web server is publicly reachable, it has a higher chance of being attacked.

If the web server is directly inside the internal network:

```text
Internet
   ↓
Web Server
   ↓
Internal Servers
   ↓
Database
```

then compromising the web server may give an attacker an easier path toward sensitive systems.

With a DMZ:

```text
Internet
   ↓
Firewall
   ↓
DMZ Web Server
   ↓
Restricted Firewall Rules
   ↓
Internal Network
```

the attacker's movement is restricted.

---

# 3. Main Goals of a DMZ

A DMZ provides several security benefits.

### Network Separation

It separates:

```text
Internet
   ↓
DMZ
   ↓
Internal Network
```

These become different security zones.

---

### Reduced Attack Surface

Only required public services are exposed.

For example:

```text
Web Server:
TCP 443 → Public

Database:
TCP 3306 → Private
```

The database does not need to be reachable from the Internet.

---

### Limits Attacker Movement

Suppose a web server is compromised.

Without proper segmentation:

```text
Attacker
   ↓
Web Server
   ↓
Database
   ↓
Internal Systems
```

With a DMZ:

```text
Attacker
   ↓
Compromised Web Server
   ↓
Firewall
   ↓
Restricted
```

The firewall can stop or limit further movement.

---

### Defence in Depth

A DMZ adds another security layer.

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Firewall
   ↓
Internal Network
```

If one system is compromised, other security controls still exist.

---

# 4. Where is a DMZ Placed?

A DMZ is normally placed:

> **Between the untrusted Internet and the trusted internal network.**

```text
Untrusted
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Firewall
   ↓
Trusted Internal Network
```

Security zones can be thought of as:

| Zone             | Trust Level                    |
| ---------------- | ------------------------------ |
| Internet         | Untrusted                      |
| DMZ              | Partially trusted / restricted |
| Internal Network | Trusted                        |
| Database Network | Highly restricted              |

A DMZ should **not be considered fully trusted**.

---

# 5. DMZ Using Two Firewalls

Your diagram represents a two-firewall design.

```text
Internet
   ↓
External Firewall
   ↓
DMZ
   ↓
Web Server
   ↓
Internal Firewall
   ↓
Application / Database Servers
```

### External Firewall

Controls:

```text
Internet → DMZ
```

Example:

```text
Allow HTTPS 443
Block unnecessary traffic
```

### Internal Firewall

Controls:

```text
DMZ → Internal Network
```

It should be more restrictive.

For example:

```text
Web Server → Application Server:5000
```

may be allowed.

But:

```text
Web Server → Database:ANY
```

should not be freely allowed.

---

# 6. DMZ Using One Firewall

A DMZ can also be created using one firewall with multiple interfaces.

Example:

```text
                 Internet
                    ↓
                 Firewall
              /      |      \
             /       |       \
           WAN      DMZ      LAN
                    |         |
                Web Server Internal Network
```

The firewall may have:

- WAN interface
- LAN interface
- DMZ interface

Each interface connects to a different network.

Example:

```text
WAN → Internet

DMZ → 192.168.20.0/24

LAN → 192.168.10.0/24
```

The firewall controls communication between these zones.

---

# 7. Web Server in the DMZ

A web server is a common example of a DMZ system because users on the Internet need to reach it.

Example:

```text
Internet User
     ↓
TCP 443
     ↓
Firewall
     ↓
DMZ
     ↓
Web Server
```

The firewall rule may be:

```text
Source: Internet
Destination: DMZ Web Server
Protocol: TCP
Port: 443
Action: ALLOW
```

Everything else may be blocked unless required.

---

# 8. Why Put a Web Server in the DMZ?

A public web server receives untrusted traffic from the Internet.

For example:

```text
Normal Users
Attackers
Bots
Scanners
Malware
        ↓
     Internet
        ↓
    Web Server
```

Because the server is exposed, putting it in a DMZ helps isolate it from:

- Employee PCs
- Domain controllers
- Internal applications
- File servers
- Databases
- Management systems

---

# 9. Example Three-Tier Application with DMZ

Consider:

```text
Frontend
Backend
Database
```

A secure design may look like:

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Web / Frontend Server
   ↓
Internal Firewall
   ↓
Application Server
   ↓
Database Server
```

Traffic should be controlled at every step.

Example:

```text
Internet
   ↓ TCP 443
Web Server
   ↓ Required Backend Port
Application Server
   ↓ TCP 5432
PostgreSQL Database
```

---

# 10. Why Should the Database Not Be Directly Exposed?

A database usually contains sensitive information.

Examples:

- User information
- Password hashes
- Financial records
- Company data
- Application data

It generally does **not need direct Internet access**.

Bad design:

```text
Internet
   ↓
MySQL 3306
   ↓
Database
```

or:

```text
Internet
   ↓
PostgreSQL 5432
   ↓
Database
```

This increases exposure.

---

# 11. Risks of Exposing a Database

If a database is publicly reachable, attackers can try:

- Password guessing
- Brute-force attacks
- Exploiting database vulnerabilities
- Using stolen credentials
- Scanning the database service
- Unauthorized data access

Example:

```text
Internet
   ↓
TCP 3306
   ↓
MySQL Server
```

If anyone can attempt a connection:

```text
0.0.0.0/0 → TCP 3306
```

the database has much greater exposure.

---

# 12. Better Database Design

Instead of:

```text
Internet → Database
```

use:

```text
Internet
   ↓
Web Server
   ↓
Application Server
   ↓
Database
```

And restrict database access:

```text
Only Application Server
        ↓
TCP 5432
        ↓
Database
```

Example firewall rule:

```text
Source:
Application Server

Destination:
Database Server

Port:
5432

Action:
ALLOW
```

Then:

```text
Everyone Else
   ↓
Database 5432
   ↓
DROP
```

---

# 13. Important Security Principle

The database should follow the principle of:

> **Least Privilege**

Only systems that actually require database access should receive it.

Example:

```text
Web Server → Database
DENY

Application Server → Database
ALLOW TCP 5432

Internet → Database
DENY
```

---

# 14. Internet → DMZ Firewall Rules

These rules control traffic coming from the Internet to public-facing DMZ systems.

### Example Web Server

Suppose:

```text
DMZ Web Server:
192.168.20.10
```

Required services:

```text
HTTP  → TCP 80
HTTPS → TCP 443
```

Possible rules:

| Source   | Destination  |     Port | Action          |
| -------- | ------------ | -------: | --------------- |
| Internet | Web Server   |  TCP 443 | ALLOW           |
| Internet | Web Server   |   TCP 80 | ALLOW if needed |
| Internet | Web Server   |   TCP 22 | DENY            |
| Internet | Database     | TCP 3306 | DENY            |
| Internet | Internal LAN |      ANY | DENY            |

A more secure web deployment may redirect HTTP to HTTPS and mainly use:

```text
TCP 443
```

---

# 15. Internet → DMZ Rule Principle

The principle should be:

```text
Default Deny
     +
Allow Only Required Services
```

For example:

```text
ALLOW Internet → Web Server TCP 443

DROP Internet → DMZ ANY OTHER
```

Do not use:

```text
ALLOW Internet → DMZ ANY ANY
```

unless there is a very specific justified requirement.

---

# 16. DMZ → Internal Firewall Rules

These rules are extremely important.

A compromised DMZ server should **not have unrestricted access to the internal network**.

Bad rule:

```text
DMZ → Internal Network
ALLOW ANY ANY
```

This can allow an attacker to move from the DMZ into internal systems.

---

# 17. Secure DMZ → Internal Rules

Only required communication should be allowed.

Example:

```text
DMZ Web Server
      ↓
Application Server
      ↓
TCP 5000
```

Rule:

```text
Source:
DMZ Web Server

Destination:
Application Server

Port:
TCP 5000

Action:
ALLOW
```

Everything else:

```text
DMZ → Internal
DEFAULT DENY
```

---

# 18. Database Access Example

Suppose architecture is:

```text
Web Server
   ↓
Backend Server
   ↓
PostgreSQL
```

The firewall might allow:

```text
DMZ Web Server
     ↓ TCP 5000
Backend Server
```

and:

```text
Backend Server
     ↓ TCP 5432
Database
```

But block:

```text
DMZ Web Server
     ↓ TCP 5432
Database

DENY
```

This is stronger segmentation.

---

# 19. Why Restrict DMZ → Internal Traffic?

Imagine:

```text
Internet
   ↓
Web Server Vulnerability
   ↓
Web Server Compromised
```

If DMZ access is unrestricted:

```text
Compromised Web Server
        ↓
Internal PCs
        ↓
Database
        ↓
Domain Controller
```

The attack can spread.

With restrictions:

```text
Compromised Web Server
        ↓
Internal Firewall
        ↓
Only TCP 5000 to App Server allowed
        ↓
Other traffic blocked
```

The attacker's movement is much more limited.

This reduces the **blast radius**.

---

# 20. Internal → DMZ Firewall Rules

Internal systems may need to communicate with DMZ systems for:

- Administration
- Monitoring
- Log collection
- Updates
- Backups
- Application communication

These connections should also be controlled.

---

# 21. Example Internal → DMZ Rules

Suppose an administrator needs SSH access to the DMZ web server.

Instead of:

```text
Entire Internal Network
        ↓
SSH 22
        ↓
DMZ Server
```

use:

```text
Admin PC: 192.168.10.50
        ↓
TCP 22
        ↓
DMZ Web Server
```

Rule:

| Source    | Destination    |   Port | Action |
| --------- | -------------- | -----: | ------ |
| Admin PC  | DMZ Web Server | TCP 22 | ALLOW  |
| Other PCs | DMZ Web Server | TCP 22 | DENY   |

This follows least privilege.

---

# 22. Monitoring Traffic to DMZ

Suppose a monitoring server needs to check the web server.

```text
Monitoring Server
       ↓
Required Monitoring Port
       ↓
DMZ Web Server
```

Only that monitoring system should be allowed if possible.

---

# 23. Internal → DMZ Does Not Mean "Allow Everything"

Even though the internal network is more trusted than the DMZ, unrestricted traffic is still risky.

Bad:

```text
LAN → DMZ
ALLOW ANY ANY
```

Better:

```text
Admin Network → DMZ SSH
Monitoring Server → DMZ Monitoring Port
Internal Users → DMZ HTTPS

Other traffic → DENY
```

---

# 24. Return Traffic and Stateful Firewall

Suppose Internet user connects to:

```text
Web Server:443
```

The initial packet is:

```text
Internet
   ↓
TCP 443
   ↓
Web Server
```

The response travels:

```text
Web Server
   ↓
Internet User
```

With a **stateful firewall**, the firewall remembers the connection.

```text
Connection State:
ESTABLISHED
```

So response traffic can be allowed without creating broad outbound rules.

---

# 25. Full DMZ Traffic Example

Consider:

```text
Internet
   ↓
Firewall
   ↓
DMZ Web Server
   ↓
Internal Firewall
   ↓
Backend
   ↓
Database
```

Possible policy:

| Source             | Destination    | Service           | Action |
| ------------------ | -------------- | ----------------- | ------ |
| Internet           | Web Server     | HTTPS 443         | ALLOW  |
| Internet           | Web Server     | SSH 22            | DENY   |
| Internet           | Internal LAN   | ANY               | DENY   |
| Internet           | Database       | ANY               | DENY   |
| Web Server         | Backend        | Required app port | ALLOW  |
| Web Server         | Database       | ANY               | DENY   |
| DMZ                | Internal LAN   | ANY unnecessary   | DENY   |
| Backend            | Database       | PostgreSQL 5432   | ALLOW  |
| Admin PC           | Web Server     | SSH 22            | ALLOW  |
| Other Internal PCs | Web Server SSH | 22                | DENY   |

---

# 26. DMZ Trust Model

A simple way to remember:

```text
Internet
= Untrusted

DMZ
= Semi-trusted / Restricted

Internal Network
= Trusted

Database / Critical Network
= Highly Restricted
```

But even an internal network should never be treated as perfectly safe.

Security should still use:

- Authentication
- Authorization
- Host firewall
- Monitoring
- Network segmentation

---

# 27. DMZ vs Internal Network

| DMZ                                  | Internal Network                  |
| ------------------------------------ | --------------------------------- |
| Public-facing systems                | Private business systems          |
| More exposed                         | Less exposed                      |
| Lower trust                          | Higher trust                      |
| Strict communication to internal LAN | Contains sensitive services       |
| Web/DNS/mail/reverse proxy           | DB, AD, file server, employee PCs |

---

# 28. DMZ vs Firewall

These are not the same thing.

### Firewall

A firewall is a **security control**.

It filters traffic.

```text
Packet
   ↓
Firewall Rules
   ↓
Allow / Deny
```

### DMZ

A DMZ is a **network security zone**.

```text
Internet
   ↓
Firewall
   ↓
DMZ
```

A firewall is normally used to control traffic entering and leaving the DMZ.

---

# 29. DMZ vs VLAN

These terms are also different.

### VLAN

A VLAN logically separates networks at the switching level.

### DMZ

A DMZ is a security zone containing exposed services.

A DMZ may be implemented using:

```text
VLAN
+
Firewall Rules
```

Example:

```text
VLAN 10 → Internal LAN

VLAN 20 → DMZ

Firewall controls traffic between them
```

---

# 30. DMZ and NAT

Public-facing DMZ servers may use private IP addresses.

Example:

```text
Public IP:
203.0.113.10

        ↓ DNAT

DMZ Server:
192.168.20.10
```

Traffic:

```text
Internet
   ↓
203.0.113.10:443
   ↓
Firewall / DNAT
   ↓
192.168.20.10:443
```

The DMZ server itself does not necessarily need a directly assigned public IP.

---

# 31. DMZ with Reverse Proxy

A reverse proxy is also commonly placed in a DMZ.

Example:

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Nginx Reverse Proxy
   ↓
Internal Application Servers
```

Benefits:

- Internal servers are hidden
- TLS can terminate at reverse proxy
- Requests can be filtered
- Load balancing can be performed

---

# 32. DMZ with IDS/IPS

Security monitoring may be placed around the DMZ.

```text
Internet
   ↓
Firewall
   ↓
IDS / IPS
   ↓
DMZ
   ↓
Web Server
```

This helps detect:

- Port scanning
- Exploit attempts
- Suspicious connections
- Malicious traffic

---

# 33. DMZ with SIEM

Logs can be sent to a SIEM.

```text
Firewall Logs
      +
Web Server Logs
      +
IDS Alerts
      ↓
     SIEM
      ↓
Correlation / Alert
```

Example:

```text
Firewall:
Many requests from IP X

IDS:
Exploit attempt from IP X

Web Server:
Multiple errors from IP X

        ↓

SIEM:
Possible attack
```

---

# 34. Defence in Depth with DMZ

A strong design might look like:

```text
Internet
   ↓
Edge Firewall
   ↓
IPS
   ↓
DMZ
   ↓
Reverse Proxy / Web Server
   ↓
Internal Firewall
   ↓
Application Server
   ↓
Database Firewall / ACL
   ↓
Database
```

Additional controls:

- Host firewall
- MFA
- Patching
- Logging
- SIEM
- EDR
- Backups

This is **Defence in Depth**.

---

# 35. Common DMZ Mistakes

## Mistake 1 — Allow Any from DMZ to LAN

```text
DMZ → LAN
ALLOW ANY ANY
```

Very risky.

---

## Mistake 2 — Database in DMZ

```text
Internet
   ↓
DMZ
   ↓
Database
```

Sensitive databases should generally be kept in a more protected network.

---

## Mistake 3 — Public SSH for Everyone

```text
Internet → DMZ Web Server TCP 22
Source = ANY
```

Better:

```text
Trusted Admin IP → TCP 22
```

or use a secure management path such as a bastion/VPN where appropriate.

---

## Mistake 4 — No Monitoring

A DMZ is exposed to the Internet and should be monitored carefully.

Use:

- Firewall logging
- IDS/IPS
- Web logs
- SIEM
- System monitoring

---

## Mistake 5 — No Patching

Putting a server in a DMZ does not make a vulnerable server safe.

The DMZ server still needs:

- Security updates
- Strong authentication
- Minimal services
- Secure configuration
- Monitoring

---

# 36. Scenario-Based Interview Question 1

### Question

A company has a public web application and a sensitive database. How would you design the network?

### Interview-Ready Answer

> I would place the public web server or reverse proxy in a DMZ because it needs Internet access. The database would remain in the internal protected network. I would allow only HTTPS from the Internet to the DMZ and only required application traffic from the DMZ toward the internal application server. The database would accept connections only from the required backend server. All other traffic would be denied using least-privilege firewall rules.

Architecture:

```text
Internet
   ↓ HTTPS 443
Firewall
   ↓
DMZ Web Server
   ↓ Required App Port
Internal Firewall
   ↓
Backend Server
   ↓ PostgreSQL 5432
Database
```

---

# 37. Scenario-Based Interview Question 2

### Question

The DMZ web server gets compromised. What prevents the attacker from reaching the database?

### Answer

Controls include:

- Internal firewall
- Network segmentation
- Default-deny rules
- Least privilege
- No direct web-server-to-database access
- IDS/IPS
- Host firewall
- Monitoring

Flow:

```text
Attacker
   ↓
Compromised Web Server
   ↓
Attempts Database Connection
   ↓
Internal Firewall
   ↓
No Allowed Rule
   ↓
DROP
```

---

# 38. Scenario-Based Interview Question 3

### Question

Which ports would you expose from the Internet to a DMZ web server?

### Answer

Only ports required by the service.

For a normal HTTPS web application:

```text
TCP 443 → ALLOW
```

Possibly:

```text
TCP 80 → ALLOW
```

if HTTP is required, commonly for redirecting users to HTTPS.

Unnecessary ports should remain blocked.

---

# 39. Scenario-Based Interview Question 4

### Question

Should Internet users be allowed to connect directly to the database?

### Answer

> Normally no. The database should remain on a private/internal network and accept connections only from authorized application servers. Direct Internet exposure increases the attack surface and risk of unauthorized access.

---

# 40. Scenario-Based Interview Question 5

### Question

Your firewall currently contains:

```text
DMZ → Internal
ALLOW ANY ANY
```

What is wrong?

### Answer

This gives the DMZ unrestricted access to the internal network.

If a public DMZ server is compromised, an attacker could attempt to access many internal systems.

Better:

```text
DMZ Web Server
      ↓
Specific Backend Server
      ↓
Specific Required Port
      ↓
ALLOW

Everything Else
      ↓
DENY
```

---

# 41. Scenario-Based Interview Question 6

### Question

An administrator needs SSH access to a DMZ server. How would you configure it securely?

### Answer

Instead of:

```text
Internet → SSH → DMZ Server
ALLOW ANY
```

allow SSH only from a trusted administration source.

Example:

```text
Source:
192.168.10.50

Destination:
DMZ Web Server

Port:
TCP 22

Action:
ALLOW
```

Then deny other SSH traffic.

---

# 42. Scenario-Based Interview Question 7

### Question

A web server needs database access. Should you allow `DMZ → Database ANY`?

### Answer

No.

Allow only:

```text
Specific Source
+
Specific Destination
+
Specific Port
```

Example:

```text
Backend Server
   ↓
Database Server
   ↓
TCP 5432
```

This follows least privilege.

---

# 43. Quick Revision Table

| Topic           | Simple Meaning                                               |
| --------------- | ------------------------------------------------------------ |
| DMZ             | Separate security zone between Internet and internal network |
| Purpose         | Protect internal network from public-facing systems          |
| Internet        | Untrusted zone                                               |
| DMZ             | Restricted/semi-trusted zone                                 |
| Internal LAN    | More trusted network                                         |
| Web Server      | Common DMZ system                                            |
| Database        | Usually kept in private/internal network                     |
| Internet → DMZ  | Allow only required public services                          |
| DMZ → Internal  | Highly restricted                                            |
| Internal → DMZ  | Allow only required administration/services                  |
| Default Policy  | Prefer default deny                                          |
| Segmentation    | Separates security zones                                     |
| Least Privilege | Allow only required access                                   |

---

# 44. Most Important Interview Questions

1. What is a DMZ?
2. What does DMZ stand for?
3. Why is a DMZ used?
4. Where is a DMZ placed?
5. Which servers can be placed in a DMZ?
6. Why should a web server be placed in a DMZ?
7. Why should a database not normally be in a DMZ?
8. Why should a database not be directly Internet-facing?
9. What rules should exist from Internet → DMZ?
10. What rules should exist from DMZ → Internal?
11. What rules should exist from Internal → DMZ?
12. What happens if a DMZ server is compromised?
13. How does a DMZ reduce blast radius?
14. DMZ vs internal network?
15. DMZ vs firewall?
16. DMZ vs VLAN?
17. Can a DMZ be created using one firewall?
18. How does NAT work with a DMZ?
19. Why is `ALLOW ANY ANY` from DMZ to LAN dangerous?
20. How does DMZ support Defence in Depth?

---

# 45. Interview-Ready Definition

> **A DMZ, or Demilitarized Zone, is a separate network segment placed between the Internet and the organization's internal network. Public-facing services such as web servers are placed in the DMZ so that if they are compromised, attackers do not get direct access to sensitive internal systems. Traffic between the Internet, DMZ, and internal network is controlled using strict firewall rules.**

---

# 46. 30-Second Interview Answer

> A DMZ is a separate network zone used for public-facing services such as web servers. It is placed between the Internet and the internal network. For example, I can allow Internet users to access the DMZ web server only on HTTPS port 443, while the internal database remains private. Communication from the DMZ to the internal network should follow least privilege and default-deny rules. This limits lateral movement if the public server is compromised.

---

# 47. Best Diagram to Remember

```text
                    INTERNET
                        ↓
                  External Firewall
                        ↓
                 ┌──────────────┐
                 │     DMZ      │
                 │              │
                 │ Web Server   │
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
Internet → Web Server:443
ALLOW

Internet → Database
DENY

DMZ Web Server → Required Backend Port
ALLOW

DMZ → Other Internal Systems
DENY

Backend → Database:5432
ALLOW

Admin PC → DMZ Server:22
ALLOW
```

---

# 48. One-Line Revision

```text
DMZ
→ Separate network between Internet and internal LAN.

Why DMZ?
→ Isolate public-facing servers from sensitive systems.

Web Server
→ Commonly placed in DMZ.

Database
→ Keep private and restrict access.

Internet → DMZ
→ Allow only required public ports.

DMZ → Internal
→ Very strict, least privilege.

Internal → DMZ
→ Allow only required admin/service traffic.

Main Principle
→ Default Deny + Least Privilege + Segmentation.
```

## Final Memory Flow

```text
Internet
   ↓
Firewall
   ↓
DMZ
   ↓
Public Web Server
   ↓
Strict Internal Firewall
   ↓
Application Server
   ↓
Private Database
```

**Main security idea:** even if the **public web server is compromised**, the **internal application and database systems should still remain protected**.
