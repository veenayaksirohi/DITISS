# Mail Services — Exam-Ready Notes
### CDAC DITISS — Networking / Linux OS & Security

---

## 1. What is a Mail Service?

A **mail service** is a system used to **send, receive, store, and manage** email. It works through three layers:

```text
Mail Client → Mail Server → Mail Protocols
```

| Category | Examples |
|---|---|
| Mail Clients | Thunderbird, Outlook, Apple Mail, `mail` command |
| Mail Server Software | Postfix, Dovecot, Sendmail, Procmail |

---

## 2. Main Mail Components — Quick Overview

| Component | Purpose |
|---|---|
| **SMTP** | Send email |
| **IMAP** | Read/sync email from server |
| **POP3** | Download email |
| **Postfix** | SMTP mail server / MTA |
| **Dovecot** | IMAP/POP3 server |
| **Maildir** | Stores emails as files |
| **Procmail** | Filters/delivers emails |
| **Sendmail** | Mail transfer server |
| **Thunderbird/Outlook/Apple Mail** | Mail clients |

**Easy memory:**
```text
Postfix  → SEND/TRANSFER
Dovecot  → READ/ACCESS
Maildir  → STORE
SMTP     → SEND
IMAP     → SYNC/READ
POP3     → DOWNLOAD
```

**Overall flow to remember:**
```text
Client → SMTP → Postfix → Mailbox/Maildir → Dovecot → IMAP/POP3 → Client
```

---

## 3. Postfix, Dovecot, Sendmail, Procmail

| Software | Role | Protocol Used |
|---|---|---|
| **Postfix** | Mail transfer server — sends/receives mail between servers | SMTP |
| **Dovecot** | Lets users read/access mail stored on the server | IMAP / POP3 |
| **Sendmail** | Another mail transfer agent (older, Postfix is a modern alternative) | SMTP |
| **Procmail** | Mail filtering/delivery — sorts mail into folders based on rules | — |

```text
Postfix = SMTP mail server (MTA)
Dovecot = IMAP/POP3 server
```

**Procmail example flow:**
```text
Incoming mail → Procmail → Check rules → Move to correct folder
  Boss email  → Work folder
  Newsletter  → Newsletter folder
  Spam        → Spam folder
```

---

## 4. Email Protocols — SMTP, IMAP, POP3

### 4.1 SMTP (Simple Mail Transfer Protocol)
**Job: Sending email.**

```text
Mail Client → SMTP → Mail Server → SMTP → Other Mail Server
```

| Port | Purpose |
|---|---|
| **25** | Server-to-server SMTP relay |
| **587** | Mail submission (client → server) |
| **465** | SMTP over implicit TLS |

> **Easy memory:** SMTP = **S**end **M**ail

### 4.2 IMAP (Internet Message Access Protocol)
**Job: Read/manage mail while it mainly stays on the server.**

```text
Mail Server → Laptop, Phone, Tablet (all see same mailbox)
```
Reading a message on one device marks it read on all devices — this is **synchronization**.

| Port | Purpose |
|---|---|
| **143** | IMAP |
| **993** | IMAPS (IMAP over implicit TLS) |

### 4.3 POP3 (Post Office Protocol v3)
**Job: Download email from server to client.**

```text
Mail Server → Download → Laptop
```
Traditionally designed around **one main device** — depending on client settings, mail may be deleted from the server after download.

| Port | Purpose |
|---|---|
| **110** | POP3 |
| **995** | POP3 over TLS (POP3S) |

### IMAP vs POP3

| Feature | IMAP | POP3 |
|---|---|---|
| Mail location | Mainly stays on server | Downloaded to client |
| Multi-device sync | ✅ Yes | ❌ Not designed for it |
| Best for | Phone + laptop + webmail | One main device |
| Port | 143 / 993 | 110 / 995 |

### SMTP vs POP3 vs IMAP (Full Comparison)

| Feature | SMTP | POP3 | IMAP |
|---|---|---|---|
| Purpose | Send mail | Download mail | Read/sync mail |
| Direction | Push | Pull | Pull/sync |
| Server-side role | Transfer/queue | Simple retrieval | Mailbox management |
| Folders | N/A | Very limited | Multiple folders |
| Message flags | N/A | Limited | Yes (Seen, Replied, Flagged, Deleted) |
| Partial fetch | N/A | Limited | Yes |
| Server-side search | N/A | No/rudimentary | Yes |
| Multiple devices | N/A | Less suitable | Excellent |
| Typical secure port | 587/465 | 995 | 993 |

**Easiest possible summary:**
```text
SMTP → SEND
POP3 → DOWNLOAD
IMAP → SYNC
```

> **Exam trap:** SMTP does **NOT** define how mail is stored or read. It only handles sending/transferring. Storage (Maildir/mbox) and reading (IMAP/POP3) are entirely separate concerns handled by different software.

---

## 5. Mail Storage — Maildir vs mbox

Mail storage format = **how emails are saved on disk** after the server receives them.

### mbox
All emails stored in **ONE big file**.
```text
/var/mail/bob
    ↓
[Mail1][Mail2][Mail3][Mail4]
```
Because many emails share one file, **locking** is required when multiple processes access it.

### Maildir
Every email stored as a **separate file**.
```text
/home/bob/Maildir/
├── new/   → New/unread messages
├── cur/   → Already processed/seen messages
└── tmp/   → Temporary files during delivery
```
```text
Maildir/new/
├── mail001
├── mail002
└── mail003
```

### mbox vs Maildir — Comparison

| Feature | mbox | Maildir |
|---|---|---|
| Storage | All emails in one file | One file per email |
| Locking | Required | Usually not required |
| NFS usage | Poorer | Better |
| Backup | Whole mailbox | Individual messages |
| Delete message | Can require rewriting mailbox | Delete one file |
| Corruption risk | One damaged file may affect many emails | Usually affects one message |
| Performance (many messages) | Can become slower | Usually easier to manage |

**Easy memory:**
```text
mbox    → ONE mailbox file
Maildir → ONE file per MAIL
```

### Maildir Filename Flags

Filename example:
```text
1234567890.12345_0.hostname,S=1024,W=2048:2,S
```
You don't need to memorize the full format — just the **flags** at the end:

| Flag | Meaning |
|---|---|
| `D` | Draft |
| `F` | Flagged / Starred |
| `P` | Passed / Forwarded |
| `R` | Replied |
| `S` | Seen / Read |
| `T` | Trashed |

Example: `:2,S` means the email has been **Seen/Read**.

> **Practical flow:** `Postfix receives email → stored in Maildir → Dovecot reads Maildir → Thunderbird displays email.`

---

## 6. Email Message Structure

An email has **three main parts**:
```text
Email
├── Headers / Envelope info
├── Body
└── Attachments
```

### Important Header Fields

| Field | Meaning |
|---|---|
| `From` | Who sent the email |
| `To` | Main recipient |
| `Cc` | Carbon Copy — visible extra recipients |
| `Bcc` | Blind Carbon Copy — hidden from other recipients |
| `Subject` | Short description of email |
| `Date` | When email was sent |
| Attachments | Files sent with the email |

### Cc vs Bcc Example
```text
To  : Bob
Cc  : Carol
Bcc : David
```
Bob and Carol can see: `Bob, Carol` (each other). **Neither can see David** — David is hidden.

```text
Cc  → visible recipients
Bcc → hidden recipients
```

### Raw Email Format (RFC 5322)
```text
From: Alice <alice@gmail.com>
To: Bob <bob@company.com>
Subject: Meeting tomorrow
Date: Mon, 13 Apr 2026 10:30:00

Hi Bob,
Let's meet tomorrow.
```
```text
Headers
   ↓
Blank line   ← separates headers from body
   ↓
Body
```

---

## 7. Mail System Architecture — MUA, MSA, MTA, MDA

These are the **four core components** of any email system.

| Component | Full Name | Role | Examples |
|---|---|---|---|
| **MUA** | Mail User Agent | Application the user interacts with (write/read/reply/forward/attach) | Thunderbird, Outlook, Evolution, Mutt, mail, mailx |
| **MSA** | Mail Submission Agent | Accepts outgoing mail from the MUA; checks auth, size, spam | Postfix (port 587) |
| **MTA** | Mail Transfer Agent | Transfers mail **between mail servers** using SMTP | Postfix, Exim, Sendmail |
| **MDA** | Mail Delivery Agent (a.k.a. LDA — Local Delivery Agent) | Delivers received mail into the **correct local mailbox** | Dovecot, Procmail, Cyrus IMAP, fetchmail, getmail, fdm |

### Easy Memory
```text
MUA → User writes/reads mail
MSA → Accepts mail from user
MTA → Transfers mail between servers
MDA → Delivers mail into mailbox
```

**Simple flow sequence:**
```text
MUA → MSA → MTA → MTA → MDA → Mailbox → MUA
```

**With real software:**
```text
Thunderbird → Postfix → Postfix → Dovecot/mailbox → Outlook
```

---

## 8. Complete Email Flow — Step by Step

Scenario: `alice@gmail.com` sends mail to `bob@company.com`.

| Step | What Happens | Component |
|---|---|---|
| 1 | Alice composes email in her client | MUA (Thunderbird/Gmail) |
| 2 | Client submits mail via SMTP (port 587); checks auth, size, spam | MSA |
| 3 | MSA hands off to MTA, which adds headers (`Received`, `Message-ID`) | MTA |
| 4 | MTA looks up `company.com`'s **MX record** via DNS to find the mail server | DNS MX lookup |
| 5 | Alice's MTA connects to Bob's MTA via SMTP (port 25) and transfers the message | Server-to-server SMTP |
| 6 | Bob's server checks: does Bob exist? spam/antivirus/filtering? | MDA |
| 7 | Message is written to disk (mbox or Maildir) | Mailbox storage |
| 8 | Bob opens his MUA, connects via IMAPS (port 993) through Dovecot, and reads the mail | MUA + Dovecot |

### Full Diagram
```text
Alice
  ↓
Thunderbird (MUA)
  ↓ SMTP :587
Postfix (MSA)
  ↓
Postfix (MTA)
  ↓ DNS MX lookup
mail.company.com
  ↓ SMTP :25
Bob's Postfix (MTA)
  ↓
MDA
  ↓
Mailbox (mbox / Maildir)
  ↓
Dovecot
  ↓ IMAP :993
Outlook (MUA)
  ↓
Bob
```

### DNS MX Lookup Detail
```text
bob@company.com
      ↓
Extract domain: company.com
      ↓
Query DNS for MX record
      ↓
company.com  MX  10 mail.company.com
      ↓
Resolve mail.company.com → IP (A/AAAA record)
      ↓
20.5.6.7
```

> **Exam trap:** MX record points to a *hostname*, not directly an IP — the resolver must then look up that hostname's A/AAAA record separately to get the actual IP.

---

## 9. Special Scenarios

### Scenario A — Both Users on Same Server
If `alice@company.com` sends to `bob@company.com`, both are on the same domain. The MTA recognizes Bob is a **local user** and skips the external DNS MX lookup and internet SMTP hop entirely — goes straight to MDA → mailbox.

### Scenario B — Recipient is Offline
Bob's laptop is off when Alice sends the mail. No problem — the server **stores** the email in Bob's mailbox. When Bob comes online, Outlook connects via IMAP and the email appears.
> **Key point:** The recipient does NOT need to be online at send time.

### Scenario C — Greylisting (Anti-Spam Technique)
When an unfamiliar sender first tries to deliver, the receiving server may reply:
```text
450 Temporary failure — try again later
```
Legitimate mail servers retry automatically after some time; many spam systems don't retry correctly, so this filters some spam.
```text
First attempt → 450 Try later → Few minutes later → Retry → Accepted
```

### Scenario D — Bounce Mail (DSN)
If `bob@company.com` doesn't exist, the server responds:
```text
550 No such user
```
The sending system generates a **DSN (Delivery Status Notification)**, commonly called a **bounce message**, informing Alice the delivery failed.
```text
Alice → Send → bob@company.com ❌ → 550 No such user → Bounce/DSN → Alice
```

---

## 10. SMTP Commands & Responses

### Example SMTP Conversation
```text
Client: EHLO mail.example.com
Server: 250 OK

Client: MAIL FROM:<alice@example.com>
Server: 250 OK

Client: RCPT TO:<bob@company.com>
Server: 250 OK

Client: DATA
Server: 354 Start mail input

Client: Subject: Hello
        Hi Bob, How are you?
        .

Server: 250 Message accepted
Client: QUIT
```

### SMTP Commands

| Command | Purpose |
|---|---|
| `HELO` | Starts a basic SMTP session |
| `EHLO` | Extended/modern version of HELO — server tells client what extensions it supports (STARTTLS, AUTH, SIZE) |
| `MAIL FROM` | Specifies the sender |
| `RCPT TO` | Specifies recipient (can be repeated for multiple recipients) |
| `DATA` | Starts the actual message content; ends with a single `.` on its own line |
| `RSET` | Cancels current transaction without closing connection |
| `VRFY` | Attempts to verify a user (often disabled for security/privacy) |
| `EXPN` | Attempts to expand a mailing list (also commonly disabled) |
| `NOOP` | Does nothing — used to keep/check connection alive |
| `QUIT` | Ends the SMTP session |

### SMTP Response Codes

| Code Range | Meaning | Example |
|---|---|---|
| **2xx** | Success | `250 OK` — command/message accepted |
| **3xx** | More info required | `354 Start mail input` — occurs after `DATA` |
| **4xx** | Temporary failure — sender should retry | `450 Mailbox busy` |
| **5xx** | Permanent failure — retrying won't help | `550 No such user` |

**Easy memory:**
```text
2xx → Success
3xx → Continue / more data
4xx → Temporary failure (retry)
5xx → Permanent failure (don't retry)
```

> **Exam trap:** Don't confuse 4xx and 5xx — 4xx means "try again later" (transient), 5xx means "this will never work, stop retrying" (permanent). Greylisting deliberately uses 450 (4xx) to trigger legitimate retries.

---

## 11. POP3 Commands

### Example POP3 Session
```text
Client: USER bob
Server: +OK

Client: PASS password
Server: +OK

Client: STAT
Server: +OK 3 4500

Client: LIST
Server: message list

Client: RETR 1
Server: sends message 1

Client: DELE 1
Server: marks message for deletion

Client: QUIT
```

### POP3 Commands

| Command | Purpose |
|---|---|
| `USER` | Specifies username |
| `PASS` | Sends password |
| `STAT` | Shows mailbox summary (message count, total size) |
| `LIST` | Lists messages and sizes |
| `RETR` | Retrieves/downloads a specific message |
| `DELE` | Marks a message for deletion (actual deletion committed on successful `QUIT`) |
| `RSET` | Undoes deletion marks made during the current session |
| `UIDL` | Returns unique IDs for messages |
| `QUIT` | Ends the session |

> **Exam trap:** `DELE` only *marks* a message for deletion — the deletion is only finalized when the session ends successfully with `QUIT`. If the connection drops before `QUIT`, the message is NOT deleted (or `RSET` can undo the mark before quitting).

### POP3 Limitations
- Mainly works around a single `INBOX` — no rich server-side folder management like IMAP
- Limited message flags (no Seen/Replied/Flagged model like IMAP)
- No rich server-side search — it's primarily a download protocol

---

## 12. SMTP Ports — Detailed

| Port | Name | Encryption | Common Use |
|---|---|---|---|
| **25** | SMTP | STARTTLS may be used | Mail server → Mail server (relay) |
| **587** | Submission | STARTTLS commonly used | Mail client → Mail server |
| **465** | SMTPS | Implicit TLS | Secure mail submission |

**Easy memory:**
```text
25  → Server to Server
587 → Client sends mail
465 → SMTP with implicit TLS
```

---

## 13. FOSS SMTP/Mail Implementations

| Protocol | Software Implementations |
|---|---|
| SMTP | Postfix, Exim, Sendmail, OpenSMTPD |
| IMAP/POP3 | Dovecot |

```text
Protocol → SMTP
Software:
├── Postfix
├── Exim
├── Sendmail
└── OpenSMTPD
```

---

## 14. When to Use What

| Protocol | Best When |
|---|---|
| **SMTP** | Sending application notifications, relaying mail between servers, sending user email, building mail transfer infrastructure |
| **POP3** | Simple mailbox download is enough; mainly one client/device used; server-side management not needed |
| **IMAP** | Using phone + laptop + webmail together; want server-side folders, flags, read/unread sync, and remote mailbox management |

---

## 15. Modern Common Mail Stack (Full Picture)

```text
Alice's MUA
    ↓
SMTP :587  (Submission)
    ↓
Postfix (MSA)
    ↓
SMTP :25  (Server-to-server relay, STARTTLS)
    ↓
Bob's Postfix (MTA)
    ↓
Mailbox (mbox / Maildir)
    ↓
Dovecot
    ↓
IMAP :993  (IMAPS)
    ↓
Bob's MUA
```

---

## 16. Quick Revision Table

| Thing | Remember |
|---|---|
| SMTP | Send mail |
| Postfix | SMTP server/MTA |
| Port 25 | Server → Server |
| Port 587 | Client → Mail server |
| Port 465 | SMTP with implicit TLS |
| POP3 | Download mail |
| Port 110 | POP3 |
| Port 995 | Secure POP3 |
| IMAP | Synchronize/manage mail |
| Port 143 | IMAP |
| Port 993 | Secure IMAP |
| Dovecot | IMAP/POP3 server |
| MUA | User's mail application |
| MSA | Accepts mail from user |
| MTA | Transfers mail between servers |
| MDA/LDA | Delivers mail into local mailbox |
| mbox | ONE file for all mail |
| Maildir | ONE file per mail |

**Most important exam line:**
> **SMTP sends email, POP3 downloads email, and IMAP synchronizes and manages email on the server.**

---

## 17. Viva / Interview Q&A

**Q1. What is the difference between MTA, MSA, and MDA?**
A: MSA accepts outgoing mail from the user's MUA (checks auth/size/spam) and hands it to the MTA. MTA transfers mail between mail servers over SMTP. MDA delivers received mail into the correct local mailbox on the receiving server.

**Q2. Why does SMTP use different ports for submission (587) vs relay (25)?**
A: Port 587 is used for authenticated client-to-server mail submission (requiring login), while port 25 is used for unauthenticated server-to-server relay. Separating them lets ISPs block port 25 from home connections (to reduce spam) while still allowing legitimate authenticated submission via 587.

**Q3. What's the fundamental difference between IMAP and POP3?**
A: IMAP keeps mail primarily on the server and synchronizes state (read/unread, folders, flags) across multiple devices. POP3 downloads mail to a single client, often removing it from the server, and has no rich folder/flag management.

**Q4. Why doesn't SMTP handle mail storage or reading?**
A: SMTP's sole responsibility is to transfer/send mail between systems. Storage format (mbox/Maildir) and retrieval (IMAP/POP3) are handled by entirely separate protocols/software — this separation of concerns is by design.

**Q5. What is an MX record and why is it needed?**
A: An MX (Mail Exchange) DNS record specifies which mail server(s) handle email for a domain. The sending MTA queries DNS for the recipient domain's MX record to find where to deliver the message, then resolves that hostname to an IP via A/AAAA record.

**Q6. Explain the difference between a 4xx and 5xx SMTP response code.**
A: 4xx is a temporary failure — the sender should retry later (e.g. greylisting's 450). 5xx is a permanent failure — retrying the same request will not succeed (e.g. 550 "no such user").

**Q7. What is greylisting and how does it reduce spam?**
A: A technique where the receiving server temporarily rejects mail from an unfamiliar sender with a 450 response. Legitimate mail servers automatically retry after a delay and succeed; many spam systems don't implement proper retry logic and give up, filtering them out.

**Q8. What happens when a recipient's mail server is contacted but the recipient doesn't exist?**
A: The server responds with a 550 "No such user" (permanent failure), and the sending system generates a DSN (Delivery Status Notification), commonly known as a bounce message, back to the original sender.

**Q9. What's the difference between mbox and Maildir storage formats?**
A: mbox stores all of a user's emails in a single file (requiring locking for concurrent access, and one corruption can affect many messages). Maildir stores each email as an individual file in `new/cur/tmp` subdirectories, making it more robust, easier to back up individually, and better suited for NFS.

**Q10. What do the Maildir flags D, F, P, R, S, T represent?**
A: Draft, Flagged, Passed/Forwarded, Replied, Seen/Read, Trashed — appended to the filename to track message state without needing a separate database.

**Q11. Does a recipient need to be online to receive an email?**
A: No — the sender's MTA delivers to the recipient's mail server regardless of whether the recipient's device is online; the mail is stored server-side (mbox/Maildir) until the recipient connects via IMAP/POP3 to read it.

**Q12. What's the difference between the DELE command in POP3 and actual deletion?**
A: DELE only marks a message for deletion during the session. The deletion is only committed when the session ends successfully with QUIT. RSET can undo the marks before quitting, and an abrupt disconnect leaves messages un-deleted.

**Q13. When would you choose IMAP over POP3 for a business setup?**
A: When users access mail from multiple devices (phone, laptop, webmail) and need synchronized read/unread status, folder organization, and server-side search — POP3's single-device download model doesn't support this well.

---

### Summary Cheat-Sheet (30-second revision)

```text
SEND:     MUA → MSA(587) → MTA → DNS MX → MTA(25) → MDA → Mailbox
READ:     Mailbox → Dovecot → IMAP(993)/POP3(995) → MUA

Software: Postfix=SMTP/MTA | Dovecot=IMAP/POP3 | Procmail=filtering

Ports:    25=server-server | 587=client submit | 465=implicit TLS
          110=POP3 | 995=POP3S | 143=IMAP | 993=IMAPS

Codes:    2xx=success | 3xx=more data | 4xx=retry later | 5xx=permanent fail

Storage:  mbox=one big file | Maildir=one file per mail (new/cur/tmp)

Key line: SMTP sends, POP3 downloads, IMAP synchronizes.
```
