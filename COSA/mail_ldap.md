# Mail Services, SMTP, POP3, and IMAP

This page is about **how email services work in Linux/networking**, a common theory topic. The main idea is: email is sent by **SMTP**, received/read by **IMAP or POP3**, and handled by server components like **Postfix, Dovecot, Procmail, and Sendmail**.

## Core Idea

A mail service is a client-server system used to send, receive, store, and manage email over a network.

The sender uses a **mail client** like Thunderbird or Outlook, and the servers use standard protocols to move the message to the recipient.

## Main Components

### MUA

The **Mail User Agent (MUA)** is the email program the user sees, such as Thunderbird, Outlook, Evolution, mutt, or mail/mailx.

Its job is to let the user **compose, send, and read** emails, but it does not actually transfer mail between servers.

### MSA

The **Mail Submission Agent (MSA)** accepts outgoing mail from the user's MUA, often on SMTP port 587.

It checks whether the user is allowed to send, whether the message size is valid, and sometimes basic spam rules.

### MTA

The **Mail Transfer Agent (MTA)** moves mail from one machine to another using SMTP.

Examples include Postfix, Exim, and Sendmail.

### MDA

The **Mail Delivery Agent (MDA)** stores the message into the correct user mailbox on the local machine.

Examples include Dovecot, Procmail, Cyrus IMAP, fetchmail, getmail, and fdm.

## Protocols

- **SMTP** is used to send mail from client to server and between mail servers.
- **IMAP** is used to read and sync mail while keeping it on the server.
- **POP3** downloads mail to the client, often for offline access.

In exam words: SMTP is for **sending**, and IMAP/POP3 are for **receiving/accessing**.

## Envelope, Headers, and Body

An email has three parts:

- **Envelope information**: used by the mail system to route the message; includes From, To, Cc, Bcc, Subject, Date, and attachments.
- **Headers**: visible message metadata like sender, recipient, date, Message-ID, and Received lines.
- **Body**: the actual content of the email.

A good theory sentence is: "The envelope is for transport, the header is for message metadata, and the body contains the actual message."

## Mail Storage Formats

### mbox

All mail for a mailbox is stored in **one single file**.

This makes backup simple at mailbox level, but deletion is slower and corruption risk is higher because one file holds everything.

### Maildir

Each message is stored as a **separate file** inside `cur`, `new`, and `tmp` directories.

This is safer, faster for deletion, and better for NFS/network storage.

| Feature         | mbox                      | Maildir              |
| --------------- | ------------------------- | -------------------- |
| Storage         | One file for all messages | One file per message |
| Locking         | Required                  | Not usually required |
| NFS safety      | Poor                      | Good                 |
| Corruption risk | Higher                    | Lower                |

## Working of Email

The flow from sender to receiver is:

```text
+----------------+          SMTP          +----------------+        SMTP        +----------------+
|  Alice's MUA   |  ---->  (port 587)  -> |  Sender MSA/MTA|  ----(25)-------> | Receiver MTA   |
| (Thunderbird)  |                        | (Postfix @gmail)|                  | (Postfix       |
+----------------+                        +----------------+                  +----------------+
        |                                          |                                   |
        |                                          | DNS MX lookup (company.com)       |
        |                                          v                                   v
        |                                   +----------------+                 +----------------+
        |                                   |   DNS Server   |                 |   MDA (Dovecot |
        |                                   +----------------+                 |   Procmail)    |
        |                                                                                |
        |                                                                                v
        |                                                                       +----------------+
        |                                                                       |  Mailbox       |
        |                                                                       |(mbox/Maildir)  |
        |                                                                       +----------------+
        |                                                                                ^
        |                              IMAP/POP3                                         |
        +----------------------- (port 993/995/143/110) ---------------------------------+
                                Bob's MUA (Outlook)
```

The working steps are:

1. The sender composes a mail in the MUA.
2. The MUA connects to the MSA over SMTP, usually port 587.
3. The MTA adds routing headers and performs DNS MX lookup to find the recipient mail server.
4. The sender's MTA connects to the recipient MTA over SMTP port 25.
5. The recipient side MDA stores the message in the mailbox using mbox or Maildir.
6. The recipient reads the mail using IMAP or POP3 through a mail client.

For the diagram, label **SMTP**, **IMAP/POP3**, **MUA**, **MTA**, **MDA**, and **Mailbox**.

## Common Scenarios

- If both users are on the same server, the message can be delivered locally without an external network hop.
- If the recipient is offline, the server keeps the mail until they connect later.
- If the recipient does not exist, the sender receives a bounce message or DSN.
- Greylisting is used as an anti-spam method by temporarily rejecting unknown senders and accepting them later if they retry.

## SMTP

### Definition

- SMTP (Simple Mail Transfer Protocol) is the de facto Internet standard for transporting email between mail servers and from mail clients to servers.
- It was first designed around 1980 and is fully specified in RFC 5321 as a platform-independent, text-based protocol.
- Any mail server that wants to send/receive email over the Internet must support SMTP.

A good 2-3 line exam definition:

"SMTP is an application-layer protocol used to send email between mail transfer agents (MTAs) and from mail user agents (MUAs) to servers. It is standardized in RFC 5321 and is platform-independent, so any OS can implement it."

### SMTP Ports and Uses

| Port | Name       | Encryption               | Typical use                         |
| ---- | ---------- | ------------------------ | ----------------------------------- |
| 25   | SMTP       | None / STARTTLS optional | MTA -> MTA server-to-server relay   |
| 587  | Submission | STARTTLS recommended     | MUA -> MSA/MTA authenticated submit |
| 465  | SMTPS      | Implicit TLS legacy      | Older secure submission by clients  |

Key points:

- Port 25 is for **server-to-server relay**.
- Ports 587/465 are for **client submission**.

### Basic SMTP Commands

- `HELO hostname` - start a basic SMTP session.
- `EHLO hostname` - start a session and request extensions.
- `MAIL FROM:<sender>` - specify the envelope sender.
- `RCPT TO:<recipient>` - specify a recipient; it can appear multiple times.
- `DATA` - begin the message content; ends with a line containing only a dot (`.`).
- `RSET` - reset/abort the current mail transaction.
- `VRFY user` - verify if a user exists; often disabled for security.
- `EXPN list` - expand a mailing list; often disabled.
- `NOOP` - no operation; used as a keep-alive.
- `QUIT` - end the SMTP session.

Remember the flow: **HELO/EHLO -> MAIL FROM -> RCPT TO -> DATA -> QUIT**.

### SMTP Response Codes

- `2xx` - Success, such as `250 OK`.
- `3xx` - Need more information, such as `354 Start mail input` before the DATA body.
- `4xx` - Temporary error; client should retry later, such as `450 Mailbox busy`.
- `5xx` - Permanent error; do not retry, such as `550 No such user`.

In theory: "2xx = success, 4xx = soft fail, 5xx = hard fail."

### How SMTP Works

SMTP defines **how mail is sent** from one host to another, including the dialogue between MTAs and from client to server.

SMTP does not define:

- How mail is stored on disk, such as mbox, Maildir, or a database.
- How mail is displayed to the user; that is handled by MUAs like Thunderbird or Outlook.

SMTP is independent of the underlying transport, as long as it provides a reliable stream like TCP. It is also independent of the operating system and storage format.

In FOSS, SMTP is implemented by servers like **Postfix, Exim, Sendmail, and OpenSMTPD**. These are MTAs that speak SMTP and handle queuing, relaying, and delivery decisions.

## POP3

**Purpose:** Download emails from server to client, usually then delete from the server.

- RFC: 1939.
- Typical ports:
  - 110 - POP3 plain, can upgrade with STARTTLS.
  - 995 - POP3S, POP3 over implicit TLS.
- Characteristics:
  - Simple, older design.
  - Usually only one mailbox: **INBOX**.
  - Messages are downloaded and then classically removed from the server.
  - Limited features: no folders, weak state, and no proper "seen/flagged" status on the server.

### POP3 Limitations

- No server-side folders.
- No persistent server-side flags; read/unread flags are lost if the client changes.
- No partial fetch; the client must download the entire message.
- No server-side searching.

### Important POP3 Commands

- `USER`, `PASS` - login.
- `STAT` - mailbox status, including message count and size.
- `LIST` - list messages.
- `RETR` - retrieve a message.
- `DELE` - mark message for deletion.
- `RSET` - undo deletions.
- `QUIT` - end session and commit deletions.

## IMAP

**Purpose:** Remote mailbox management - mail stays on the server, and the client syncs with it.

- RFC: 3501 (IMAP4rev1), 9051 (updated IMAP).
- Ports:
  - 143 - IMAP plain with optional STARTTLS.
  - 993 - IMAPS, IMAP over implicit TLS.

### IMAP Characteristics

- Messages remain on the server; the client syncs headers and bodies.
- Supports **multiple folders** such as Inbox, Sent, and custom folders.
- Supports **message flags** like Seen, Answered, Flagged, Deleted, and Draft.
- Allows **partial fetch**, such as fetching just headers or part of the body.
- Supports **server-side search** and multiple simultaneous clients, such as phone plus laptop.

## POP3 vs IMAP

| Feature           | POP3                    | IMAP                         |
| ----------------- | ----------------------- | ---------------------------- |
| Role              | Download mail to client | Sync/mail stays on server    |
| Mailbox           | Single INBOX only       | Multiple folders             |
| Message storage   | Mainly local            | Stored on server             |
| Flags (seen etc.) | No persistent flags     | Yes, server-side flags       |
| Partial fetch     | No, full download       | Yes, headers/parts           |
| Server search     | No                      | Yes                          |
| Devices           | Usually single device   | Many devices at same time    |
| Bandwidth         | Higher, full messages   | Lower, header-only possible  |

## Protocol Selection Guide

Use **POP3** when:

- Only one device is used.
- Server storage is limited.
- Always-online access is not required.
- Requirements are simple.

Use **IMAP** when:

- The same account is used on multiple devices, such as mobile, laptop, and webmail.
- Server-side folders and flags are needed.
- Collaboration or shared mailboxes are needed.
- Low-bandwidth optimization and server search are needed.

SMTP is still used for sending in both cases:

- Port 587 with TLS for submission: MUA -> server.
- Port 25 with STARTTLS for server-to-server relay.

## Exam Answer Structure

If the question is "Explain Mail Services," write this structure:

- Definition of mail service.
- Components: MUA, MSA, MTA, MDA.
- Protocols: SMTP, IMAP, POP3.
- Mail storage formats: mbox and Maildir.
- Email flow from sender to recipient.
- Mention Postfix, Dovecot, Sendmail, Procmail as examples.

A strong one-line conclusion is:

**Mail services use SMTP to transfer messages, and IMAP/POP3 to store or retrieve them, while servers such as Postfix and Dovecot handle relay and delivery.**
