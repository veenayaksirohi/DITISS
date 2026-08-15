---
title: 08C - Core Infrastructure Services - File Sharing Protocols
aliases:
  - Core Infrastructure Services - File Sharing Protocols
  - File_Sharing_Protocols_Notes
  - File Sharing Protocols
  - FTP NFS Samba SMB and TFTP
tags:
  - linux
  - file-sharing
  - infrastructure-services
  - interview-preparation
syllabus-topic:
  - 8
  - 19
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]] · Related: [[08A - Core Infrastructure Services - DNS|DNS]] · [[08B - Core Infrastructure Services - DHCP|DHCP]] · [[16 - LDAP and NIS Authentication|LDAP and NIS Authentication]]

# File Sharing Protocols — FTP, NFS, Samba/SMB, TFTP

### Exam-Ready Notes (CDAC DITISS — Linux OS & Security / Networking)

---

## 1. FTP (File Transfer Protocol)

### 1.1 Overview

FTP is used to transfer files between a client and a server. It uses **two separate connections**, not one.

| Port   | Purpose                                                                |
| ------ | ---------------------------------------------------------------------- |
| **21** | Control port — commands & replies (login, LIST, RETR, PORT, PASV etc.) |
| **20** | Data port (used traditionally in Active mode)                          |

- Daemon: `vsftpd` (Very Secure FTP Daemon) — same package/service name on RHEL and Ubuntu.
- Control connection stays open for the whole session; data connection opens/closes per transfer.

```text
Control port (21) → commands, login, replies
Data port    (20) → actual file/data transfer
```

> **Exam trap:** Students often think FTP uses only port 21. Remember — port 21 is for _control_, actual data moves on a **separate** connection (port 20 in active mode, or a dynamic high port in passive mode).

FTP has two modes of operation: **Active FTP** and **Passive FTP**. The difference is entirely about **who initiates the data connection**.

---

### 1.2 Active FTP — Full Flow

**Key idea: The SERVER connects back to the CLIENT for data.**

```text
Client IP: 192.168.1.10        Server IP: 203.0.113.10
```

| Step | Action                                                                               |
| ---- | ------------------------------------------------------------------------------------ |
| 1    | Client opens control connection: `Client:50000 → Server:21`                          |
| 2    | Client logs in: `USER veenayak`, `PASS ****` → Server replies `230 Login successful` |
| 3    | Client picks a data port (e.g. 50001) and tells server using `PORT` command          |
| 4    | Client sends a data request: `LIST` or `RETR file.txt`                               |
| 5    | **Server initiates** the data connection: `Server:20 → Client:50001`                 |
| 6    | Data (file/listing) is transferred                                                   |
| 7    | Data connection closes; control connection (21) may stay open                        |

```text
CLIENT                                   FTP SERVER
50000 ────────────────────────────────►  21      (Control)
              USER / PASS / PORT 50001 / LIST

50001 ◄────────────────────────────────  20      (Data)
              File / Data
```

**Problem with Active FTP:**
The server tries to make a **new inbound connection** to the client.

```text
Internet → Client Firewall/NAT → Client
```

This inbound connection is commonly **blocked** by client-side firewalls/NAT (home routers, corporate firewalls) — because from the firewall's point of view, it's an _unsolicited incoming connection_.

---

### 1.3 Passive FTP — Full Flow

**Key idea: The CLIENT initiates BOTH connections.**

| Step | Action                                                                  |
| ---- | ----------------------------------------------------------------------- |
| 1    | Client opens control connection: `Client:50000 → Server:21`             |
| 2    | Client logs in (same as active)                                         |
| 3    | Client sends `PASV` command ("give me a port to connect to")            |
| 4    | Server picks a data port (e.g. 45000) and tells the client              |
| 5    | **Client initiates** the data connection: `Client:50001 → Server:45000` |
| 6    | Client sends `LIST` / `RETR file.txt`                                   |
| 7    | Data transferred over `Client:50001 ↔ Server:45000`                     |
| 8    | Data connection closes; control connection may stay open                |

```text
CLIENT                                   FTP SERVER
50000 ────────────────────────────────►  21       (Control)
              USER / PASS / PASV
                                          "Use port 45000"

50001 ────────────────────────────────►  45000    (Data)
              File / Data
```

Both connections start **from the client**, so a stateful firewall easily allows it:

```text
Client starts connection → Allow outgoing → Allow related return traffic
```

> **Note:** Passive FTP doesn't magically bypass firewalls on its own — the **server's** firewall must still open the passive port range (e.g. `50000–51000`) in addition to port 21.

---

### 1.4 Active vs Passive — Comparison Table

| Feature                      | Active FTP         | Passive FTP        |
| ---------------------------- | ------------------ | ------------------ |
| Control connection           | Client → Server:21 | Client → Server:21 |
| Data port selected by        | Client             | Server             |
| FTP command used             | `PORT`             | `PASV`             |
| Data connection initiated by | **Server**         | **Client**         |
| Traditional data port        | 20                 | Dynamic high port  |
| Firewall/NAT friendly        | ❌ Less            | ✅ More            |
| Common today                 | Rare               | Widely preferred   |

**Easiest memory trick:**

```text
ACTIVE:   Control → Client initiates | Data → SERVER initiates
PASSIVE:  Control → Client initiates | Data → CLIENT initiates
```

> **Viva one-liner:**
> "Active FTP: server connects back to the client for data.
> Passive FTP: client connects to the server for data."

---

## 2. NFS (Network File System)

### 2.1 What is NFS?

NFS lets a Linux system **share directories over a network** so another machine can mount and use them almost like local folders. Files physically live on the **server**; the client accesses them over the network.

```text
NFS Client ────Network──── NFS Server
/mnt/data                   /data (actual files)
```

Example:

```bash
sudo mount 192.168.1.10:/data /mnt/data
ls /mnt/data      # shows files physically stored on 192.168.1.10
```

### 2.2 NFS vs Windows File Sharing

| OS Family  | Protocol |
| ---------- | -------- |
| Linux/Unix | NFS      |
| Windows    | SMB/CIFS |

### 2.3 Client–Server Roles

| Role       | Responsibility                                                                            |
| ---------- | ----------------------------------------------------------------------------------------- |
| **Server** | Stores files, decides which directories are shared (**exported**), controls client access |
| **Client** | Requests the shared directory, **mounts** it locally, reads/writes per permissions        |

### 2.4 Key Terms

**Export** — making a server directory available to other machines. Configured in `/etc/exports`.

```text
/data 192.168.1.0/24(rw,sync)
```

Meaning: share `/data` with the `192.168.1.0/24` subnet, allow read+write, write synchronously.

**Mount** — attaching a remote (or local) filesystem to a local directory.

```bash
sudo mount serverA:/home /mnt/nfs
```

> **Exam/practical trap:** Never mount a remote share directly onto an existing important directory like `/home` — it can **hide** the client's existing local content while mounted. Use a safe empty mount point like `/mnt/nfs`.

**Internal flow when reading a file over NFS:**

```text
Application → Linux filesystem → NFS client → Network → NFS server → Server filesystem → file.txt
```

The application doesn't handle network packets itself — the OS/NFS layer does it transparently.

### 2.5 RPC (Remote Procedure Call)

RPC lets one computer request a function/service from another over the network.

```text
Client: "Server, perform this operation for me."  →  Server: "Here's the result."
```

Older NFS versions depend on several RPC-based helper services: `rpcbind`, `mountd`, `statd`, `lockd`.

### 2.6 NFS Versions

| Feature                    | NFSv2    | NFSv3                               | NFSv4                    |
| -------------------------- | -------- | ----------------------------------- | ------------------------ |
| Age                        | Very old | Improved v2                         | Modern                   |
| Transport                  | TCP/UDP  | TCP/UDP                             | Primarily TCP            |
| Main port                  | —        | 2049 (+ RPC helpers)                | **2049**                 |
| RPC helper services needed | Yes      | Yes (mountd, rpcbind, lockd, statd) | Mostly not needed        |
| File size limits           | Yes      | Larger support                      | Large                    |
| Firewall friendliness      | Poor     | More complex                        | **Easier (single port)** |
| Kerberos/security          | —        | Limited                             | **Strong integration**   |
| ACL support                | —        | Limited                             | **Improved**             |
| Recommended today          | ❌       | Older systems                       | ✅ Preferred             |

```text
NFSv3: Client → [rpcbind, mountd, NFS, lock, status services] → Server   (complex firewall rules)
NFSv4: Client → TCP 2049 → Server                                       (simple firewall rule)
```

> **Exam trap:** NFSv4's biggest advantage is often mis-stated as "faster." The real exam-relevant advantage is: **consolidated onto a single well-known port (2049), reducing RPC dependency and simplifying firewall configuration**, plus built-in Kerberos/ACL support.

### 2.7 Server Configuration (RHEL/Rocky/Alma family)

| Step                 | Command                                                               |
| -------------------- | --------------------------------------------------------------------- |
| 1. Install           | `sudo dnf install nfs-utils -y`                                       |
| 2. Create shared dir | `sudo mkdir -p /nfs/share`                                            |
| 3. Edit exports      | `sudo vim /etc/exports` → add `/nfs/share 192.168.1.0/24(rw,sync)`    |
| 4. Apply exports     | `sudo exportfs -a` (apply) / `sudo exportfs -v` (view active exports) |
| 5. Start service     | `sudo systemctl enable --now nfs-server`                              |
| 6. Check status      | `systemctl status nfs-server`                                         |

### 2.8 Common `/etc/exports` Options

| Option           | Meaning                                                            |
| ---------------- | ------------------------------------------------------------------ |
| `ro`             | Read-only                                                          |
| `rw`             | Read and write                                                     |
| `sync`           | Write changes synchronously (safer)                                |
| `async`          | Faster but risk of data loss on failure                            |
| `root_squash`    | Remote root user is **not** treated as local root (safer, default) |
| `no_root_squash` | Remote root keeps root privileges on server — **risky**            |

Safe example:

```text
/nfs/share 192.168.1.0/24(rw,sync,root_squash)
```

### 2.9 Firewall Rules

```bash
# NFSv4 (simple — single port)
sudo firewall-cmd --add-service=nfs --permanent
sudo firewall-cmd --reload

# NFSv3 (needs extra RPC-related services)
sudo firewall-cmd --add-service=nfs --permanent
sudo firewall-cmd --add-service=mountd --permanent
sudo firewall-cmd --add-service=rpc-bind --permanent
sudo firewall-cmd --reload
```

---

## 3. Samba / SMB / CIFS

### 3.1 What is Samba?

Samba is software that lets **Linux and Windows** share files, printers, and authentication using the **SMB/CIFS** protocol.

```text
Windows Client → SMB/CIFS → Linux Server (Samba) → Shared Folder
```

Mainly used to let **Windows clients** access files stored on a **Linux server**.

### 3.2 What is SMB/CIFS?

**SMB = Server Message Block** — the network protocol Windows primarily uses for file sharing, printer sharing, network folders, and authentication. **CIFS** is an older related name/version of SMB.

```text
Windows PC → \\192.168.1.10\share → Samba Server → /var/smb/share
```

### 3.3 Samba Services / Daemons

| Daemon | Role                                                                  |
| ------ | --------------------------------------------------------------------- |
| `smbd` | Handles file sharing, printer sharing, SMB connections (main service) |
| `nmbd` | Historically handled NetBIOS name services (older setups)             |

### 3.4 Authentication Methods in Samba

| Method                            | Description                                                                                                                                                                                                          |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Local Samba users**             | Create a Linux user + a separate Samba password: `sudo useradd veenayak` → `sudo smbpasswd -a veenayak`                                                                                                              |
| **PAM + Domain Controller**       | PAM (Pluggable Authentication Modules) is Linux's auth framework; can integrate with a Windows domain for centralized credentials                                                                                    |
| **Samba as AD Domain Controller** | Samba can act as an **Active Directory DC**, so Windows PCs authenticate against a Linux server (users, passwords, groups, policies)                                                                                 |
| **LDAP Backend**                  | LDAP (Lightweight Directory Access Protocol) can store centralized users/groups/passwords. _Modern Samba AD DC deployments typically use Samba's own built-in directory rather than plain LDAP as a password store._ |

### 3.5 NFS vs Samba

| NFS                                        | Samba                            |
| ------------------------------------------ | -------------------------------- |
| Common in Linux/Unix-to-Linux environments | Common between Windows and Linux |
| Uses NFS protocol                          | Uses SMB/CIFS protocol           |
| Default port: **2049**                     | Default port: **TCP 445**        |

---

## 4. TFTP (Trivial File Transfer Protocol)

### 4.1 Overview

| Property           | Detail                         |
| ------------------ | ------------------------------ |
| Transport          | **UDP**                        |
| Default port       | **69**                         |
| Authentication     | ❌ None (no username/password) |
| Directory browsing | ❌ Not supported               |
| Complexity         | Very simple/lightweight        |

```text
Client → Request file (must know exact filename) → TFTP Server
Server → Sends file in small blocks → Client
```

### 4.2 Common Uses

- Network boot / **PXE boot**
- Router/switch **configuration backup**
- **Firmware** transfer
- Small boot/config files

```text
PXE Client → TFTP Server → bootloader / kernel file
```

### 4.3 FTP vs TFTP

| Feature           | FTP                              | TFTP                                |
| ----------------- | -------------------------------- | ----------------------------------- |
| Full name         | File Transfer Protocol           | Trivial File Transfer Protocol      |
| Transport         | TCP                              | UDP                                 |
| Port              | 21 (control) + 20/dynamic (data) | 69                                  |
| Login/auth        | ✅ Username/password             | ❌ None                             |
| Directory listing | ✅ Supported                     | ❌ Not supported                    |
| Feature set       | Rich                             | Minimal                             |
| Typical use       | General-purpose file transfer    | Boot files, firmware, config backup |

**Directory listing — explained simply:**

```text
FTP:   Client → "Show me files"         → Server → file1.txt, file2.txt, docs/
TFTP:  Client → "Give me boot.img"      → Server → sends boot.img (must already know the name)
```

> **FTP supports browsing/listing files. TFTP requires you to know the file name beforehand.**

**Easy memory:**

```text
FTP  = Full-featured file transfer
TFTP = Tiny/simple file transfer
```

---

## 5. Quick Reference — Packages, Daemons & Services

| Service       | RHEL/Rocky/Alma Package | Ubuntu/Debian Package | Main Daemon    | Common systemd Service                           |
| ------------- | ----------------------- | --------------------- | -------------- | ------------------------------------------------ |
| **SMB/Samba** | `samba`                 | `samba`               | `smbd`, `nmbd` | RHEL: `smb`, `nmb` • Ubuntu: `smbd`, `nmbd`      |
| **NFS**       | `nfs-utils`             | `nfs-kernel-server`   | `nfsd`         | RHEL: `nfs-server` • Ubuntu: `nfs-kernel-server` |
| **FTP**       | `vsftpd`                | `vsftpd`              | `vsftpd`       | `vsftpd`                                         |
| **TFTP**      | `tftp-server`           | `tftpd-hpa`           | `in.tftpd`     | often `tftp`/`tftpd-hpa` or socket-activated     |

### Port Cheat Sheet

| Protocol            | Port(s)           | Transport |
| ------------------- | ----------------- | --------- |
| FTP (control)       | 21                | TCP       |
| FTP (data, active)  | 20                | TCP       |
| FTP (data, passive) | Dynamic high port | TCP       |
| SSH/SFTP            | 22                | TCP       |
| TFTP                | 69                | UDP       |
| NFS (v3/v4)         | 2049              | TCP/UDP   |
| SMB                 | 445               | TCP       |

---

## 6. Viva / Interview Q&A

**Q1. What's the fundamental difference between Active and Passive FTP?**
A: In Active FTP the **server** initiates the data connection back to the client; in Passive FTP the **client** initiates both the control and data connections. Passive is more firewall/NAT friendly.

**Q2. Why does Active FTP often fail behind NAT/firewalls?**
A: Because the server tries to open a new **inbound** connection to the client, which stateful client-side firewalls typically block as unsolicited traffic.

**Q3. What port does NFSv4 use and why is that significant?**
A: Port **2049** (TCP) — significant because NFSv4 consolidated functionality that older versions spread across multiple RPC services (`rpcbind`, `mountd`, `lockd`, `statd`), making firewall rules much simpler.

**Q4. What does "export" mean in NFS?**
A: Making a directory on the NFS server available for remote clients to mount, defined in `/etc/exports`.

**Q5. What's the risk of `no_root_squash` in NFS exports?**
A: It lets a remote root user retain root privileges on the server's filesystem — a serious security risk, since a compromised/malicious client's root user can act as root on the server's shared files.

**Q6. Why is `/etc/exports` important and where is it applied from?**
A: It defines which directories are shared, with whom (IP/subnet), and what permissions (`ro`/`rw`/`sync`/`async`/`root_squash`). Changes are applied using `exportfs -a`.

**Q7. What protocol does Samba use, and what is its primary use case?**
A: SMB/CIFS — primarily used to let Windows clients access shares on a Linux server (or vice versa).

**Q8. Difference between NFS and Samba?**
A: NFS is native to Linux/Unix-to-Linux sharing (port 2049); Samba/SMB is used for Windows-to-Linux interoperability (port 445).

**Q9. What is RPC and why does older NFS depend on it?**
A: Remote Procedure Call — lets one machine invoke a function on another over the network. NFSv2/v3 rely on RPC-based helper daemons (rpcbind, mountd, statd, lockd) for mounting, locking, and status tracking.

**Q10. Why is TFTP used for PXE boot instead of FTP?**
A: TFTP is extremely lightweight, connectionless (UDP), and requires no authentication — ideal for simple, fast boot-file/firmware transfers in controlled network environments where FTP's overhead (TCP handshake, login) isn't needed.

**Q11. Does TFTP support directory listing?**
A: No — the client must already know the exact filename to request it; there's no "browse" capability like FTP's `LIST`.

**Q12. Name the main authentication approaches Samba supports.**
A: Local Samba users (`smbpasswd`), PAM integration with a domain controller, Samba acting as its own AD Domain Controller, and (historically) LDAP-backed directories.

---

### Summary Cheat-Sheet (30-second revision)

```text
FTP     → TCP 21(control)+20/dynamic(data) | Active=server initiates data | Passive=client initiates both
NFS     → TCP/UDP 2049 | Linux-to-Linux | v4 = single port, better security, less RPC dependency
Samba   → TCP 445 | SMB/CIFS | Windows ↔ Linux
TFTP    → UDP 69  | No auth, no listing | Used for PXE boot/firmware/config
```
