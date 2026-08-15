# NIS & LDAP — Directory Services — Exam-Ready Notes
### CDAC DITISS — Networking / Linux OS & Security

---

# PART A — NIS (Network Information Service)

## 1. What is NIS?

**NIS = Network Information Service** — an older **client-server directory service** used mainly in Unix/Linux networks to keep common system information centralized instead of maintaining it separately on every machine.

**Without NIS:**
```text
Client1 → own users/groups
Client2 → own users/groups
Client3 → own users/groups
```

**With NIS:**
```text
        NIS Server
        ├── users
        ├── groups
        ├── hosts
        └── services
            ↑
      ┌─────┼─────┐
      ↓     ↓     ↓
   Client1 Client2 Client3
```

> **NIS provides centralized user and system information to multiple Unix/Linux clients.**

### What can NIS manage?
Central distribution of files like:
```text
/etc/passwd     → user accounts
/etc/shadow     → passwords
/etc/group      → groups
/etc/hosts      → hostnames
/etc/services   → network services
/etc/protocols  → network protocols
```
Instead of creating user `john` separately on 20 machines, his info is managed centrally.

---

## 2. Why is NIS also called YP?

NIS was originally called **Yellow Pages (YP)** — that's why many NIS commands/services still start with `yp`:
```text
ypbind
ypserv
ypcat
ypmatch
```
```text
NIS ≈ YP (old Unix terminology)
```

---

## 3. How NIS Works — Step by Step

Scenario: user `john` tries to log in.

| Step | What Happens |
|---|---|
| 1 | Client needs info about `john` |
| 2 | **`ypbind`** (client-side binding service) connects the client to an NIS server |
| 3 | NIS server receives the query |
| 4 | Server searches a **NIS map** (e.g. `passwd.byname`) |
| 5 | Server returns John's info: `john:x:1005:1005:John:/home/john:/bin/bash` |

```text
Client
  ↓
ypbind
  ↓
NIS Server
```
> **ypbind = NIS client-side binding service**

### Complete NIS Flow
```text
User tries: john
  ↓
Linux Client
  ↓
ypbind
  ↓
NIS Server
  ↓
Search map: passwd.byname
  ↓
Find john
  ↓
Return user information
  ↓
Client uses it
```

---

## 4. What is a NIS Map?

A **map** = a NIS database containing a particular type of information (like a table).

| Map | Purpose |
|---|---|
| `passwd.byname` | User info searchable by username |
| `passwd.byuid` | User info searchable by UID |
| `group.byname` | Group info by name |
| `hosts.byname` | Host info by name |
| `hosts.byaddr` | Host info by IP address |

```text
NIS Map = database/table
```

---

## 5. Security Limitations of NIS (Important!)

NIS was designed for **trusted internal Unix networks** — this is its biggest weakness.

| Limitation | Detail |
|---|---|
| **No encryption** | Data can be sniffed on the network — no built-in encrypted transport |
| **Weak authentication** | Relies on trusted hosts/network config rather than strong user/server authentication |
| **Weak password policy support** | No rich complexity/history/expiration policy features |
| **Vulnerable to spoofing** | Clients can't strongly verify they're talking to the genuine NIS server |
| **Predictable/discoverable services** | Relies on RPC, making services easy to discover on the local network |
| **Limited access control** | Designed to broadcast info broadly — fine-grained control is weak |

> **Exam trap:** NIS's core weakness isn't a single flaw — it's a **combination of design-era assumptions** (trusted internal network) that don't hold up in modern, hostile network environments.

---

## 6. NIS vs LDAP (Quick Preview)

| NIS | LDAP |
|---|---|
| Older | More modern |
| Mainly Unix-focused | Platform independent |
| Weak security | TLS/security integration |
| Simple data maps (flat) | Hierarchical directory |
| Limited scalability | Better scalability |

```text
NIS  → Old centralized directory (flat)
LDAP → Modern flexible directory protocol (hierarchical)
```

---

## 7. NIS — Quick Revision Table

| Term | Meaning |
|---|---|
| NIS | Network Information Service |
| YP | Old name: Yellow Pages |
| Purpose | Centralized Unix/Linux account and system information |
| `ypbind` | Client connects to NIS server |
| Map | NIS database of information |
| `passwd.byname` | User info indexed by username |
| Main weakness | Poor modern security |
| Replacement | Commonly LDAP / other modern directory services |

**Exam definition:**
> **NIS is a client-server directory service used to centrally distribute user accounts, groups, host information, and other system data across Unix/Linux systems.**

---

# PART B — LDAP (Lightweight Directory Access Protocol)

## 8. What is LDAP?

**LDAP = Lightweight Directory Access Protocol** — a protocol to **store, search, and manage directory information** over a network.

Think of it as a **central company phonebook/database**:
```text
LDAP Server
   ├── Users
   ├── Groups
   ├── Computers
   ├── Printers
   └── Departments
```
Applications query this central directory instead of maintaining separate user lists.

### Why "Lightweight"?
LDAP came from the older, complex **X.500 DAP (Directory Access Protocol)**, which depended on the OSI networking stack. LDAP was designed to be simpler and work directly over **TCP/IP**.
```text
DAP  → Complex (OSI stack)
LDAP → Lightweight/simpler (TCP/IP)
```

### LDAP is a Protocol, Not Software
```text
LDAP → Protocol
OpenLDAP, Active Directory, 389 Directory Server → Software implementing it
```
Same relationship as:
```text
HTTP → protocol   |   Apache → software
LDAP → protocol   |   OpenLDAP → software
```

---

## 9. LDAP Ports

| Port | Purpose |
|---|---|
| **389** | LDAP |
| **636** | LDAPS (LDAP over TLS) |
| **3268** | Microsoft AD Global Catalog |

**Easy memory:**
```text
389 → LDAP
636 → Secure LDAP
```

---

## 10. Common LDAP Implementations

| Implementation | Notes |
|---|---|
| **OpenLDAP** | Open-source; main daemon = **`slapd`** |
| **Microsoft Active Directory** | Combines LDAP + Kerberos + DNS; widely used for enterprise identity |
| **FreeIPA** | Common in Linux/Red Hat environments; integrates LDAP + Kerberos + DNS + Certificate services |

```text
LDAP protocol → OpenLDAP software → slapd daemon
```

---

## 11. Main LDAP Use Cases

| Use Case | Example |
|---|---|
| **Centralized Authentication** | 100 servers + 500 employees all reference ONE LDAP directory instead of separate local accounts on each server |
| **Address Book** | Store Name, Email, Phone, Department — searchable by mail clients |
| **Network Resource Management** | Track printers, servers, computers, network devices |
| **SSO Infrastructure** | One central account usable across many applications (LDAP is part of, not the whole, SSO stack) |

```text
Without LDAP:
Server1 → own users | Server2 → own users | Server3 → own users

With LDAP:
           LDAP Server (Users + Groups)
                  ↑
         ┌────────┼────────┐
         ↓        ↓        ↓
      Server1  Server2  Server3
```

---

## 12. LDAP Structure — Directory Information Tree (DIT)

LDAP stores data in a **tree structure**, not tables (unlike SQL).

```text
company.com
│
├── People
│   ├── Alice
│   ├── Bob
│   └── John
│
├── Groups
│   ├── Developers
│   ├── Admins
│   └── HR
│
└── Devices
    ├── Printer1
    └── Server1
```
This tree is called the **DIT (Directory Information Tree)**.

### Naming Components

| Term | Full Name | Example |
|---|---|---|
| **DC** | Domain Component | `dc=company,dc=com` (from `company.com`) |
| **OU** | Organizational Unit | `ou=People`, `ou=Groups`, `ou=IT` |
| **CN** | Common Name | `cn=John Smith` |
| **DN** | Distinguished Name | Full unique path to an entry |

**Example Distinguished Name (DN):**
```text
cn=John Smith,ou=People,dc=company,dc=com
```
```text
cn=John Smith  → User/object
ou=People      → Organizational unit
dc=company,dc=com → Domain
```

### Full Example Tree
```text
dc=company,dc=com
│
├── ou=People
│   ├── cn=Alice
│   ├── cn=Bob
│   └── cn=John
│
├── ou=Groups
│   ├── cn=Admins
│   └── cn=Developers
│
└── ou=Devices
    ├── cn=Printer1
    └── cn=Server1
```

> **Exam trap:** DN (Distinguished Name) is the **entire unique path** (e.g. `cn=John Smith,ou=People,dc=company,dc=com`), while CN is just **one component** of that path (`cn=John Smith`). Don't confuse DN with CN.

---

## 13. LDAP is Read-Heavy

LDAP is optimized mainly for **SEARCH / READ / LOOKUP** operations:
```text
"Who is john?"
"What is John's email?"
"Which groups does John belong to?"
```
Writes (create/delete/update) happen far less frequently than reads.

> **LDAP = Read-heavy and search-optimized**

---

## 14. LDAP vs SQL Database

| Feature | LDAP | SQL Database |
|---|---|---|
| Structure | Tree | Tables |
| Main use | Directory/lookups | General application data |
| Workload | Read-heavy | Read + write |
| Query | LDAP filters | SQL |
| Transactions | Limited | Strong ACID transactions |
| Authentication | Bind supported | Usually application-managed |
| Typical data | Users/groups/resources | Orders/payments/products |

> **LDAP is NOT meant to replace a normal SQL database** — they serve different purposes (directory lookups vs transactional application data).

---

## 15. Replication & Security

### Replication
```text
LDAP Server 1  ──replication──►  LDAP Server 2
```
Both maintain copies — benefits: high availability, better performance, backup/redundancy. Clients can use either server.

### Security
```text
LDAP  → protocol (unencrypted by default, port 389)
TLS   → protects communication
LDAPS → LDAP over encrypted connection (port 636)
```

---

## 16. LDAP Operations (like CRUD)

| LDAP Operation | Similar To | Meaning |
|---|---|---|
| **Bind** | Authentication | Connect and authenticate |
| **Search** | Read | Find entries |
| **Add** | Create | Create a new entry |
| **Modify** | Update | Change an existing entry |
| **Delete** | Delete | Remove an entry |
| **Compare** | Check | Check an attribute/value |
| **Unbind** | Disconnect | Close LDAP connection |

**Memory trick:**
```text
Bind   → Login
Search → Read
Add    → Create
Modify → Update
Delete → Remove
Unbind → Disconnect
```

### Bind Example
```text
Client → Bind request → LDAP Server → Check credentials → Authenticated
```
Example bind identity: `cn=Manager,dc=example,dc=com`

### Search Example
```bash
ldapsearch -x -b "dc=example,dc=com" "(uid=john)"
```
Possible result:
```text
dn: uid=john,ou=People,dc=example,dc=com
uid: john
cn: John
mail: john@example.com
```

### Add Example
```bash
ldapadd -x -D "cn=Manager,dc=example,dc=com" -W -f john.ldif
```

### Modify Example
```bash
ldapmodify -x -D "cn=Manager,dc=example,dc=com" -W -f changes.ldif
```
E.g. changing John's department: `IT → Security`

### Delete Example
```bash
ldapdelete -x -D "cn=Manager,dc=example,dc=com" -W "uid=john,ou=People,dc=example,dc=com"
```

---

## 17. LDAP Search Filters

Filters describe what to find.

| Filter | Meaning |
|---|---|
| `(uid=john)` | Find entry where UID is `john` |
| `(cn=John)` | Find common name John |
| `(mail=john@example.com)` | Find matching email |
| `(uid=j*)` | Wildcard — UID starts with `j` |
| `(&(objectClass=person)(uid=john))` | AND condition — both must match |

**AND filter breakdown:**
```text
(&(objectClass=person)(uid=john))
       ↓                  ↓
objectClass=person   AND   uid=john
```

---

## 18. LDAP Security — Authentication Methods

### Simple Authentication
```bash
ldapsearch -x -D "cn=Manager,dc=example,dc=com" -w password
```
`-x` = simple authentication.

> **Important:** Simple authentication should be protected using **TLS**, otherwise credentials aren't safe in transit. **Base64 encoding is NOT encryption** — it's just an encoding scheme, easily reversible.

### SASL (Simple Authentication and Security Layer)
Provides advanced authentication mechanisms beyond simple bind:
```text
GSSAPI    → Kerberos-based
DIGEST-MD5
EXTERNAL
```
```text
LDAP Client → SASL/Kerberos → LDAP Server
```

### TLS / LDAPS
```text
Client → Encrypted LDAP → LDAP Server
```
| Port | Use |
|---|---|
| 389 | LDAP / STARTTLS possible |
| 636 | LDAPS (implicit TLS) |

> **Exam trap:** Don't confuse Base64 with encryption. LDAP simple bind sends credentials Base64-*encoded* by default — this is trivially decodable, NOT secure, unless wrapped in TLS/LDAPS.

---

## 19. LDAP Password Storage

Common hash formats:
```text
{SSHA}
{SHA}
{CRYPT}
{MD5}
{CLEARTEXT}
```

Generate a password hash:
```bash
slappasswd -s password
```
```text
password → slappasswd → {SSHA}...
```

> **Key rule:** LDAP should store a **password hash**, never the original plain-text password.

---

## 20. LDAP Client Commands — Quick Reference

| Command | Purpose | Example |
|---|---|---|
| `ldapsearch` | Search the directory | `ldapsearch -x -b "dc=example,dc=com" "(uid=john)"` |
| `ldapadd` | Add a new entry | `ldapadd -x -D "cn=Manager" -W -f entry.ldif` |
| `ldapmodify` | Change an existing entry | `ldapmodify -x -D "cn=Manager" -W -f changes.ldif` |
| `ldapdelete` | Delete an entry | `ldapdelete -x -D "cn=Manager" -W "uid=john,ou=People"` |
| `ldappasswd` | Change LDAP password | `ldappasswd -x -D "uid=john" -W -S` (`-W`=bind password, `-S`=new password) |

---

## 21. SSSD (System Security Services Daemon)

**SSSD** helps a Linux client connect to centralized identity systems like LDAP.

```text
Linux Client → SSSD → LDAP Server → Users/Groups
```

Instead of manually creating `john`, `alice`, `bob` in local `/etc/passwd`, the Linux machine looks them up via SSSD → LDAP.

Main config file: `/etc/sssd/sssd.conf`

> **SSSD connects Linux authentication/user lookup to LDAP (or other identity providers).**

**Full stack:**
```text
LDAP     → Protocol
OpenLDAP → Software
slapd    → Server daemon
SSSD     → Common Linux client-side identity daemon
```

```text
Linux Client → SSSD → Network → slapd → LDAP Database
```

---

## 22. LDAP Schema

A **schema** defines what type of data is allowed in LDAP — rules for objects and attributes.

Example — a user entry may contain: `cn`, `sn`, `uid`, `mail`, `telephoneNumber`.

Schema defines:
```text
Which attributes exist?
Which are required vs optional?
What type of value can they contain?
```

### Common Schema Files
Location: `/etc/openldap/schema/`

| Schema File | Purpose |
|---|---|
| `core.ldif` | Basic LDAP objects |
| `cosine.ldif` | Common Internet/X.500 attributes |
| `inetorgperson.ldif` | User/person objects |
| `nis.ldif` | Unix/NIS attributes |
| `openldap.ldif` | OpenLDAP-specific definitions |

**Importing a schema:**
```bash
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
```
```text
cosine.ldif → ldapadd → LDAP configuration → Schema becomes available
```

---

## 23. LDIF (LDAP Data Interchange Format)

**LDIF** is a text format used to create, modify, export, and import LDAP entries.

Example:
```text
dn: uid=john,ou=People,dc=example,dc=com
objectClass: inetOrgPerson
uid: john
cn: John Smith
sn: Smith
mail: john@example.com
```

| Field | Meaning |
|---|---|
| `dn` | Unique location of the entry |
| `objectClass` | What type of object it is |
| `uid` / `cn` / `sn` / `mail` | Attributes |

**Adding LDIF data:**
```bash
ldapadd -x -D "cn=Manager,dc=example,dc=com" -W -f john.ldif
```
```text
john.ldif → ldapadd → LDAP server → John entry created
```

---

## 24. LDAP Utilities

| Utility | Purpose |
|---|---|
| `slapcat` | Exports LDAP database to LDIF (backup/export) |
| `slapindex` | Rebuilds LDAP database indexes (faster searches) |
| `slappasswd` | Generates password hashes |
| `ldapvi` | Edit LDAP entries in a text-editor style interface |

```text
slapcat: LDAP database → slapcat → LDIF output
```

### GUI LDAP Tools
```text
Apache Directory Studio
phpLDAPadmin
LDAP Admin
LDAP Account Manager
```
Provide a graphical browse/manage experience instead of raw CLI commands.

---

## 25. NIS vs LDAP — Full Comparison

| Feature | NIS | LDAP |
|---|---|---|
| Architecture | Old directory service | Modern directory protocol |
| Data model | Flat maps | Hierarchical tree (DIT) |
| Security | Weak | TLS/SASL supported |
| Search | Simple key lookup | Advanced filters |
| Scalability | Limited | High |
| Schema | Fixed | Extensible |
| Modern usage | Legacy | Widely used |
| Typical structure | `passwd.byname` | DIT entries |
| Authentication | Basic | Bind/SASL etc. |

```text
NIS:                          LDAP:
passwd.byname                 dc=example,dc=com
group.byname                  ├── ou=People
hosts.byname                  │   ├── John
(flat maps)                   │   └── Alice
                               └── ou=Groups
```

**Easy memory:**
```text
NIS  → Older + flat
LDAP → Modern + hierarchical
```

---

## 26. Complete LDAP Login Example

```text
Username: john
Password: ****
        ↓
Linux Login
        ↓
SSSD
        ↓
LDAP Server (slapd)
        ↓
Search: (uid=john)
        ↓
John found
        ↓
Authentication
        ↓
Access granted
```

Instead of managing `john` separately on Server1, Server2, Server3, one LDAP directory serves all:
```text
            LDAP
           john
             ↑
      ┌──────┼──────┐
      ↓      ↓      ↓
   Server1 Server2 Server3
```

---

## 27. LDAP — Quick Revision Table

| Term | Meaning |
|---|---|
| LDAP | Lightweight Directory Access Protocol |
| Port 389 | LDAP |
| Port 636 | LDAPS |
| OpenLDAP | LDAP software implementation |
| `slapd` | OpenLDAP server daemon |
| SSSD | Linux client-side identity daemon connecting to LDAP |
| DIT | Directory Information Tree — the LDAP data structure |
| DN | Distinguished Name — full unique path of an entry |
| CN | Common Name — one component of a DN |
| OU | Organizational Unit |
| DC | Domain Component |
| LDIF | LDAP Data Interchange Format (text-based entry format) |
| Schema | Rules defining allowed attributes/object types |

**Exam definition:**
> **LDAP is an open, platform-independent protocol used to access and manage hierarchical directory information such as users, groups, devices, and network resources. It is optimized for read-heavy searches and is commonly used for centralized identity and authentication systems.**

---

## 28. Bonus Note — SSH Key Exchange (Correction)

> **Important correction:** SSH does **not** simply encrypt all session data directly using the server's public/private key pair.

Actual simplified flow:
```text
Client
  ↓
Connects to SSH Server
  ↓
Server proves identity using its host key
  ↓
Key exchange happens
  ↓
Both sides derive shared session keys
  ↓
Symmetric encryption protects the session
```
```text
Public/private key → Authentication/identity + key exchange
Session key         → Actual fast symmetric encryption of SSH traffic
```

Command:
```bash
ssh user@172.16.140.216
```

> **Exam trap:** Asymmetric (public/private) keys are used for identity verification and key exchange — NOT for encrypting the bulk of the session data. The actual traffic is protected using fast **symmetric** session keys derived during the handshake.

---

## 29. Final Memory Trick Summary

```text
LDAP operations:
Bind    → Login
Search  → Read
Add     → Create
Modify  → Update
Delete  → Remove
Unbind  → Disconnect

Stack:
OpenLDAP server                → slapd
Linux LDAP client integration  → SSSD
LDAP data file format          → LDIF
LDAP structure rules           → Schema
LDAP port                      → 389
LDAPS                          → 636
```

---

## 30. Viva / Interview Q&A

**Q1. What is the core difference between NIS and LDAP?**
A: NIS uses flat "maps" (simple key-value databases like `passwd.byname`) and is Unix-focused with weak security. LDAP uses a hierarchical tree structure (DIT), is platform-independent, and supports modern security (TLS/SASL).

**Q2. Why is NIS considered insecure by modern standards?**
A: It transmits data without strong encryption, relies on trusted-host authentication rather than strong credential verification, is vulnerable to server spoofing, and its RPC-based services are easily discoverable on a local network.

**Q3. What is `ypbind` and what does it do?**
A: The client-side NIS binding service — it connects/binds a Linux client to an available NIS server so the client can query NIS maps.

**Q4. What is the difference between DN and CN in LDAP?**
A: DN (Distinguished Name) is the full, unique path identifying an entry in the directory tree (e.g. `cn=John Smith,ou=People,dc=company,dc=com`). CN (Common Name) is just one attribute/component within that path.

**Q5. Why is LDAP described as "read-heavy"?**
A: Because LDAP directories are queried (search/read/lookup) far more frequently than they are modified (create/update/delete) — it's optimized for fast, frequent searches rather than transactional writes.

**Q6. What's the difference between LDAP and a SQL database?**
A: LDAP is tree-structured, read-optimized, and used for directory-style lookups (users/groups/resources) with limited transaction support. SQL databases are table-structured, support full read+write workloads with strong ACID transactions, and are used for general application data.

**Q7. What is the Bind operation in LDAP?**
A: It's how a client connects to and authenticates with the LDAP server — analogous to a login operation.

**Q8. Is Base64 encoding the same as encryption? Why does this matter for LDAP?**
A: No — Base64 is just an encoding scheme, trivially reversible, NOT encryption. LDAP's simple authentication (`-x`) sends credentials Base64-encoded by default, so it must be protected with TLS/LDAPS to actually secure credentials in transit.

**Q9. What role does SSSD play in LDAP-based Linux authentication?**
A: SSSD is the daemon on the Linux client side that connects local authentication and user/group lookups to a remote identity provider like LDAP, so users don't need to be manually created in local `/etc/passwd`.

**Q10. What is LDIF used for?**
A: LDIF (LDAP Data Interchange Format) is the standard text format for representing LDAP entries — used to create, modify, import, and export directory data.

**Q11. What is the purpose of an LDAP schema?**
A: It defines the rules for what attributes and object classes are allowed in the directory — which attributes exist, which are required vs optional, and what data types they can hold.

**Q12. What does `slapcat` do, and why is it useful?**
A: It exports the entire LDAP database into LDIF format — commonly used for backups or migrating directory data.

**Q13. Give an example of an LDAP AND filter and explain it.**
A: `(&(objectClass=person)(uid=john))` — this matches entries where objectClass is "person" AND uid is "john"; both conditions must be true.

**Q14. Why did many organizations migrate from NIS to LDAP?**
A: LDAP offers stronger security (TLS/SASL), a more scalable hierarchical data model, extensible schemas, cross-platform support (not just Unix), and advanced search capabilities — addressing NIS's core weaknesses.

**Q15. Are SSH sessions encrypted using the server's public/private key pair directly?**
A: No — the public/private key pair is used for server identity verification and key exchange. The actual bulk session data is encrypted using a symmetric session key derived during that handshake, which is much faster than asymmetric encryption for ongoing traffic.

---

### Summary Cheat-Sheet (30-second revision)

```text
NIS:   Old, flat maps (passwd.byname), ypbind, weak security, Unix-only
LDAP:  Modern, tree (DIT: dc/ou/cn), port 389/636, TLS/SASL, cross-platform

LDAP ops:   Bind=login | Search=read | Add=create | Modify=update | Delete=remove
Structure:  DN=full path | CN=common name | OU=org unit | DC=domain component
Software:   OpenLDAP → slapd (server) | SSSD (Linux client integration)
Data:       LDIF = text format for entries | Schema = rules for attributes
Security:   389=LDAP(plain) | 636=LDAPS(TLS) | Base64 ≠ encryption
Tools:      ldapsearch/ldapadd/ldapmodify/ldapdelete | slapcat/slapindex/slappasswd
```
