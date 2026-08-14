# DNS (Domain Name System) — Exam-Ready Notes

### CDAC DITISS — Networking / Linux OS & Security

---

## 1. What is DNS?

DNS translates **human-friendly domain names** into **IP addresses** that computers use to communicate.

```text
www.example.com  ──DNS──►  93.184.216.34
```

Without DNS, you'd have to remember IP addresses instead of names.

---

## 2. DNS Naming Hierarchy

DNS is structured like an **inverted tree**, read right-to-left.

```text
                 .
                 ↑
              Root

                com
                 ↑
                TLD

              example
                 ↑
        Domain (SLD)

                www
                 ↑
           Host / Subdomain
```

```text
.
└── com                  (TLD)
    └── example           (Second-Level Domain / SLD)
        └── www           (Host / Subdomain)
```

| Level                         | Name                                            | Example                               |
| ----------------------------- | ----------------------------------------------- | ------------------------------------- |
| **Root Domain**               | The dot `.` at the very end (usually invisible) | `example.com.`                        |
| **TLD (Top-Level Domain)**    | Highest level after root                        | `.com`, `.org`, `.net`, `.uk`, `.edu` |
| **SLD (Second-Level Domain)** | The registrable/main part                       | `google` in `google.com`              |
| **Subdomain**                 | Optional prefix under the domain                | `mail` in `mail.google.com`           |

> **Exam trap:** The root is technically represented by a trailing dot (`example.com.`) — it's usually hidden by browsers/apps, but it IS part of the formal DNS hierarchy and sits **above** the TLD.

**Full breakdown example — `www.example.com`:**

| Part           | Role   |
| -------------- | ------ |
| `.` (implicit) | Root   |
| `com`          | TLD    |
| `example`      | Domain |
| `www`          | Host   |

---

## 3. Types of TLD

| Type                   | Full Form        | Examples                                              | Notes                                                  |
| ---------------------- | ---------------- | ----------------------------------------------------- | ------------------------------------------------------ |
| **ccTLD**              | Country Code TLD | `.in` (India), `.uk` (UK), `.us` (USA), `.jp` (Japan) | Represents a specific country                          |
| **gTLD**               | Generic TLD      | `.com`, `.org`, `.net`, `.info`                       | Not tied to any country                                |
| **sTLD**               | Sponsored TLD    | Managed for specific communities/sectors              | Restricted registration purpose                        |
| **Infrastructure TLD** | —                | `.arpa`                                               | Used for internet infrastructure, e.g. **reverse DNS** |

---

## 4. Key DNS Terms

### 4.1 Subdomain

A domain created **under** another domain.

```text
mail.example.com
  ↑        ↑
subdomain  domain
```

`student.sunbeaminfo.com` → subdomain under `sunbeaminfo.com`.

> **Correction note:** "Anything between the host and TLD" is sometimes mis-typed as "TLS" in raw notes — it means **TLD** (Top-Level Domain), not TLS (Transport Layer Security). Don't confuse the two in exams.

### 4.2 Zone

A **DNS zone** is a portion of the DNS namespace managed by a particular organization/DNS server.

```text
sunbeaminfo.com  (zone)
       │
       ├── www
       ├── mail
       ├── ftp
       └── server1
```

### 4.2a Forward Zone vs Reverse Zone

DNS zones come in two directions, depending on which way the lookup goes.

**Forward Zone** — maps **Name → IP** (the normal, everyday lookup).

```text
www.example.com  ──►  192.168.1.10
```

- Contains records like `A`, `AAAA`, `CNAME`, `MX`, `NS`, `TXT`
- Used when a browser/app looks up a website or service name

**Reverse Zone** — maps **IP → Name** (the opposite direction).

```text
192.168.1.10  ──►  www.example.com
```

- Contains `PTR` records
- Uses the special **`.arpa`** infrastructure domain
- IPv4 reverse zones are named using the **reversed IP octets** + `.in-addr.arpa`

**Reverse zone naming example (IPv4):**

```text
IP address:         192.168.1.10
Octets reversed:     1.168.192
Reverse zone name:   1.168.192.in-addr.arpa
PTR record inside:   10 → www.example.com
```

| Feature             | Forward Zone                  | Reverse Zone                                                       |
| ------------------- | ----------------------------- | ------------------------------------------------------------------ |
| Direction           | Name → IP                     | IP → Name                                                          |
| Main record type    | `A` / `AAAA`                  | `PTR`                                                              |
| Special domain used | Normal domain (`example.com`) | `in-addr.arpa` (IPv4) / `ip6.arpa` (IPv6)                          |
| Typical use         | Website/service resolution    | Verifying sender identity (mail servers), logging, troubleshooting |
| Example zone        | `example.com`                 | `1.168.192.in-addr.arpa`                                           |

> **Exam trap:** A domain can have a working forward zone (`A` record) but **no** reverse zone configured (missing `PTR`) — this is common in practice and often causes mail servers to flag the sender as suspicious, since many mail servers perform a reverse-DNS check before accepting mail.

> **Practical/interview point — reverse lookup commands:**
>
> ```bash
> dig -x 192.168.1.10
> nslookup 192.168.1.10
> ```

### 4.3 Zone File

A file containing the actual DNS records for a zone.

```text
www    → 192.168.1.10
mail   → 192.168.1.20
ftp    → 192.168.1.30
```

> Zone file = the DNS "database" holding name→record mappings.

### 4.4 Name Server

A server running DNS software. It can store records, answer queries, cache data, and refer clients to other servers.

### 4.5 Authoritative Name Server

The **official source** of DNS records for a domain/zone — it answers from its own data, not by asking someone else.

```text
Resolver → Authoritative Server → "www.example.com = 192.168.1.10"
```

### 4.6 Host

A machine/service name inside a domain, e.g. `www`, `mail`, `ftp`, `server1`, `db`.

### 4.7 FQDN (Fully Qualified Domain Name)

The **complete** DNS name of a host.

```text
www.example.com
 ↑      ↑      ↑
host  domain  TLD
```

### 4.8 Registrar

A company through which a domain name is registered/reserved (e.g. registering `mycompany.com`). It communicates with the appropriate domain registry.

### 4.9 Resolver

The **client-side component** that performs DNS lookups on behalf of an application.

```text
Application → DNS Resolver → DNS Servers → IP Address
```

---

## 5. Resource Records (RR)

**RR = Resource Record** — one individual DNS entry.

```text
www.example.com  A  192.168.1.10
```

### RRset

Multiple records with the **same name AND same type** grouped together.

```text
example.com A 10.0.0.1
example.com A 10.0.0.2
example.com A 10.0.0.3
     └──────────────┘
        A-record RRset
```

DNS can return all of them — useful for simple load distribution.

### Parts of a Resource Record

| Field        | Meaning                                           | Example                    |
| ------------ | ------------------------------------------------- | -------------------------- |
| **NAME**     | The DNS name the record belongs to                | `www.example.com`          |
| **TYPE**     | Kind of record                                    | `A`, `AAAA`, `MX`, `CNAME` |
| **CLASS**    | Almost always `IN` (Internet)                     | `IN`                       |
| **TTL**      | Time To Live — how long caches may keep it        | `3600` (= 1 hour)          |
| **RDATA**    | The actual data/value of the record               | `192.168.1.10`             |
| **RDLENGTH** | Length of the RDATA field (protocol-level detail) | —                          |

**TTL caching flow:**

```text
Record received → Cached for TTL seconds → TTL expires → Query DNS again
```

---

## 6. Types of DNS Records

| Record    | Full Form          | Purpose                                                                | Example                                 |
| --------- | ------------------ | ---------------------------------------------------------------------- | --------------------------------------- |
| **A**     | Address            | Domain → IPv4                                                          | `www.example.com A 192.168.1.10`        |
| **AAAA**  | —                  | Domain → IPv6                                                          | `www.example.com AAAA 2001:db8::10`     |
| **CNAME** | Canonical Name     | Alias → real hostname                                                  | `www.example.com → example.com`         |
| **MX**    | Mail Exchange      | Which mail server handles domain's email                               | `example.com MX 10 mail1.example.com`   |
| **TXT**   | Text               | Domain verification, email security (SPF/DKIM etc.)                    | `example.com TXT "verification=abc123"` |
| **NS**    | Name Server        | Which DNS servers are authoritative for the domain                     | `example.com NS ns1.example.com`        |
| **PTR**   | Pointer            | Reverse DNS: IP → Domain                                               | `192.168.1.10 PTR www.example.com`      |
| **SOA**   | Start of Authority | Admin info for the zone (primary server, serial, refresh/retry/expiry) | —                                       |

### Record Memory Trick

```text
A     → IPv4
AAAA  → IPv6
CNAME → Alias
MX    → Mail server
TXT   → Text/verification
NS    → Name server
PTR   → IP → Name (reverse)
SOA   → Zone administration info
```

> **Exam trap — MX priority:** Lower numeric value = **higher preference**.
>
> ```text
> 10 mail1.example.com   ← tried first
> 20 mail2.example.com   ← backup
> ```

> **Exam trap — PTR vs A:** A record = name→IP (forward lookup). PTR record = IP→name (**reverse** lookup). Reverse DNS commonly uses the `.arpa` infrastructure TLD.

---

## 7. Types of DNS Servers (4 Key Roles)

| Server                        | Role                                                                              |
| ----------------------------- | --------------------------------------------------------------------------------- |
| **Recursive Resolver**        | Works on behalf of the client; does all the searching and caches results          |
| **Root Name Server**          | Top of hierarchy; doesn't know the final IP — knows **where the TLD servers are** |
| **TLD Name Server**           | Knows the **authoritative server** for a given domain                             |
| **Authoritative Name Server** | Holds the **actual records**; gives the final answer                              |

```text
Client
  ↓
Recursive Resolver   (searches)
  ↓
Root Name Server      (knows TLD)
  ↓
TLD Name Server        (knows authoritative server)
  ↓
Authoritative Name Server  (knows final record/IP)
  ↓
IP Address
```

**One-line memory:**

```text
Resolver      → Searches
Root          → Knows TLD
TLD           → Knows authoritative server
Authoritative → Knows final record/IP
```

---

## 8. Complete DNS Resolution — Step by Step

User types `example.com` into a browser.

| Step                              | What Happens                                                                      |
| --------------------------------- | --------------------------------------------------------------------------------- |
| **1. User enters domain**         | Browser needs the IP before it can connect                                        |
| **2. Check caches**               | Browser Cache → OS Cache → Router Cache → Resolver Cache (in that order)          |
| **3. Query Root Server**          | If not cached: Resolver asks Root → Root replies "ask the `.com` TLD server"      |
| **4. Query TLD Server**           | Resolver asks `.com` TLD → TLD replies "ask `example.com`'s authoritative server" |
| **5. Query Authoritative Server** | Resolver asks the authoritative server directly for the record                    |
| **6. Response**                   | Authoritative server returns the record, e.g. `A = 93.184.216.34`                 |
| **7. Caching**                    | Resolver caches the answer for the record's TTL duration                          |
| **8. Deliver to browser**         | Resolver hands the IP back to the browser, which connects to the website          |

### Cache Check Order (Step 2 detail)

```text
Browser Cache
     ↓ (miss)
OS Cache
     ↓ (miss)
Router Cache
     ↓ (miss)
ISP / Recursive Resolver Cache
     ↓ (miss)
→ Proceed to full DNS resolution (Root → TLD → Authoritative)
```

### Full Resolution Diagram

```text
1. example.com typed
        ↓
2. Check caches (browser/OS/router/resolver) → not found
        ↓
3. Resolver → Root Server
              "com is here"
        ↓
4. Resolver → .com TLD Server
              "example.com's authoritative server is here"
        ↓
5. Resolver → Authoritative Server
              "What is example.com's IP?"
        ↓
6. Authoritative Server
              A = 93.184.216.34
        ↓
7. Resolver caches answer (per TTL)
        ↓
8. Resolver → Browser → 93.184.216.34 → Website loads
```

> **Important exam point:** The **Root server does NOT return the final IP**. It only refers the resolver to the correct TLD server. Similarly, the **TLD server does NOT return the final IP** either — it refers to the authoritative server. Only the **authoritative server** gives the actual record.

### Real-World Analogy

```text
You → Ask information desk → "Which city?"
    → Ask city office → "Which street?"
    → Ask street authority → "House number is 34"
```

```text
Client → Resolver → Root → TLD → Authoritative → IP
```

---

## 9. Quick Revision Tables

### DNS Terminology

| Term                 | Meaning                                      |
| -------------------- | -------------------------------------------- |
| Root Server          | Top of DNS hierarchy                         |
| TLD                  | `.com`, `.org`, `.in`, etc.                  |
| Subdomain            | Domain below another domain                  |
| Zone                 | Portion of DNS namespace managed together    |
| Forward Zone         | Maps Name → IP                               |
| Reverse Zone         | Maps IP → Name (uses `.arpa`, `PTR` records) |
| Zone File            | DNS records for a zone                       |
| Name Server          | Server providing DNS service                 |
| Authoritative Server | Official DNS server for a domain             |
| RR                   | Individual DNS record                        |
| RRset                | Group of same-name, same-type records        |
| Host                 | Machine/service name such as `www`           |
| FQDN                 | Full name such as `www.example.com`          |
| Registrar            | Company used to register domains             |
| Resolver             | Client component that performs DNS lookup    |

### DNS Server Roles

| Component            | What it knows/does                           |
| -------------------- | -------------------------------------------- |
| Recursive Resolver   | Searches on behalf of client, caches results |
| Root Server          | Knows TLD servers                            |
| TLD Server           | Knows authoritative servers                  |
| Authoritative Server | Gives final DNS record                       |

---

## 10. Viva / Interview Q&A

**Q1. What is the difference between a domain, a subdomain, and a host?**
A: A domain is the registrable name (e.g. `example.com`). A subdomain is a name created under that domain (e.g. `mail.example.com`). A host is a specific machine/service label inside the domain (often the same as the subdomain label, e.g. `www`, `mail`, `ftp`).

**Q2. Why doesn't the Root DNS server return the final IP address directly?**
A: The Root server only knows which TLD servers exist; it delegates the query to the appropriate TLD server, which in turn delegates to the authoritative server. This delegation model is what makes DNS scalable/distributed.

**Q3. What's the difference between a Recursive Resolver and an Authoritative Server?**
A: The recursive resolver does the searching on behalf of the client (walking Root → TLD → Authoritative). The authoritative server holds the actual, official records and gives the final answer.

**Q4. What does TTL control, and what happens when it expires?**
A: TTL (Time To Live) controls how long a resolver/cache may keep a DNS record before re-querying. Once TTL expires, the cached entry is discarded and a fresh DNS lookup is required.

**Q5. What's the difference between an A record and a PTR record?**
A: A record maps a domain name → IPv4 address (forward lookup). PTR record maps an IP address → domain name (reverse lookup).

**Q6. What is an SOA record used for?**
A: It stores administrative information about a DNS zone — primary/master server, admin contact, serial number, and refresh/retry/expiry timing values used for zone transfers between DNS servers.

**Q7. What is the purpose of a CNAME record?**
A: It creates an alias, pointing one hostname to another canonical (real) hostname, rather than directly to an IP address.

**Q8. How does DNS achieve load distribution using resource records?**
A: Multiple `A` records with the same name (an RRset) can point to different IPs; DNS servers can return them in different orders (round-robin), spreading traffic across multiple servers.

**Q9. What's the difference between a ccTLD and a gTLD?**
A: ccTLD (country code TLD) is tied to a specific country, e.g. `.in`, `.uk`. gTLD (generic TLD) is not country-specific, e.g. `.com`, `.org`, `.net`.

**Q10. Where does caching happen during DNS resolution?**
A: At multiple layers — browser cache, OS cache, router cache, and the recursive resolver's cache — checked in that order before a full Root→TLD→Authoritative lookup is performed.

**Q11. What class value is almost always used in DNS records, and what does it mean?**
A: `IN`, meaning "Internet" — it's a legacy field from when DNS supported multiple network classes, but in practice only `IN` is used today.

**Q12. What is MX priority and how is it interpreted?**
A: A numeric preference value on MX records — the **lower** the number, the **higher** the priority (tried first). Used to define primary and backup mail servers.

**Q13. What is the difference between a forward zone and a reverse zone?**
A: A forward zone resolves a domain name to an IP address (name → IP), using records like A/AAAA. A reverse zone resolves an IP address back to a domain name (IP → name), using PTR records under the special `.in-addr.arpa` (IPv4) or `.ip6.arpa` (IPv6) domain.

**Q14. Why is reverse DNS (PTR) important for mail servers?**
A: Many receiving mail servers perform a reverse-DNS check on the sending server's IP as part of spam/anti-abuse filtering. If there's no valid PTR record matching the sending domain, the email may be flagged as suspicious or rejected.

---

### Summary Cheat-Sheet (30-second revision)

```text
Hierarchy:   Root(.) → TLD(.com) → Domain(example) → Host(www)
Resolution:  Client → Resolver → Root → TLD → Authoritative → IP
Records:     A=IPv4 | AAAA=IPv6 | CNAME=Alias | MX=Mail | TXT=Text
             NS=NameServer | PTR=Reverse | SOA=Zone Admin
Zones:       Forward = Name→IP | Reverse = IP→Name (in-addr.arpa, PTR)
Key rule:    Root & TLD only REFER — only Authoritative gives the final answer
TTL:         Controls how long a record stays cached before re-query
```
