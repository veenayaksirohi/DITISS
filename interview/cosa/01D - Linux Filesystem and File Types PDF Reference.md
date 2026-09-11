---
title: 01D - Linux Filesystem and File Types PDF Reference
aliases:
	- pdf
	- Linux File Hierarchy Structure (FHS) & File Types
	- FHS and File Types PDF Reference
tags:
	- linux
	- filesystem
	- file-types
	- interview-preparation
syllabus-topic:
	- 1
	- 2
	- 12
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]] · Related: [[01A - Linux Filesystem and File Types|Linux Filesystem and File Types]] · [[01B - Linux Core Commands|Linux Core Commands]] · [[01C - Linux File Links|Linux File Links]] · [[02A - File Permissions Ownership and ACLs|File Permissions and ACLs]] · [[12A - Interprocess Communication and Process Internals|Interprocess Communication and Process Internals]]

# Linux File Hierarchy Structure (FHS) & File Types — Study Notes

**Quick Revision Guide for Exam / Viva Prep**

---

## 1. What is FHS?

**FHS = Filesystem Hierarchy Standard.** It defines a standard layout for directories and their contents on Linux, so software and users know where to expect things (configs in one place, logs in another, etc.).

Everything starts from the **root directory `/`** — all other directories branch out from it.

```text

/

├── bin      ├── lib     ├── proc

├── boot     ├── media    ├── sbin

├── dev      ├── mnt      ├── srv

├── etc      ├── opt      ├── tmp

├── home     ├── usr      ├── var

```

---

## 2. Core FHS Directories

### `/` — Root Directory

- Topmost directory; everything else lives under it.

- Only **root user** can normally modify files directly inside `/`.

```text

/ = Starting point of the entire Linux filesystem

```

---

### `/etc` — Configuration Files

System-wide config files for users, network, services, and applications.

```text

/etc/passwd        # user account info

/etc/resolv.conf   # DNS resolver config

/etc/logrotate.conf

```

```text

/etc = System configuration ("editable text configs")

```

---

### `/home` — User Home Directories

Personal directories for **normal (non-root) users** — Documents, Downloads, personal settings.

```text

/home/veenay/Documents

```

```text

/home = Normal users' personal files

```

---

### `/var` — Variable Data

Contains data that **changes/grows constantly** while the system runs — the opposite of static config files.

| Subdirectory | Contains |

| ------------ | --------------------------------------------------- |

| `/var/log` | System & application log files |

| `/var/spool` | Print/mail queues, cron jobs waiting to run |

| `/var/cache` | Cached data from applications |

| `/var/www` | Web server content (common on many distros) |

| `/var/lib` | Persistent application state/data (e.g., databases) |

```bash

tail -f /var/log/syslog     # very common real-world command

```

```text

/var = Variable — data that keeps changing (logs, mail, cache)

```

🔴 **Exam Trap:** `/etc` = static configuration (rarely changes), `/var` = dynamic/growing data (changes constantly). Interviewers love this contrast question.

---

### `/proc` — Process & System Information

A **virtual/pseudo filesystem** — not real files stored on disk. It's generated live by the kernel to expose info about running processes, CPU, memory, uptime, etc.

```text

/proc/1234        # info for process with PID 1234

/proc/meminfo     # memory info

/proc/uptime      # system uptime

/proc/cpuinfo     # CPU details

```

```text

/proc = Live process & kernel info (not real disk files)

```

---

### `/tmp` — Temporary Files

Temporary files created by programs/users. May be **auto-cleared** on reboot.

```text

/tmp/test.txt

```

🟠 **Note:** `/tmp` is world-writable by design, but protected by the **Sticky Bit** — only the file's owner (or root) can delete/rename files inside it, even though anyone can create files there.

```text

/tmp = Temporary, short-lived data

```

---

### `/usr` — User Programs & Utilities

Holds the bulk of installed programs, libraries, and documentation (despite the name, NOT user home data — that's `/home`).

| Subdirectory | Contains |

| ------------ | ----------------------------------------------------------------- |

| `/usr/bin` | Most user commands (`awk`, `less`, `scp`) |

| `/usr/sbin` | Admin commands (`sshd`, `cron`, `useradd`) |

| `/usr/lib` | Libraries used by `/usr/bin` & `/usr/sbin` programs |

| `/usr/local` | Software installed manually/from source (not via package manager) |

| `/usr/src` | Kernel source code, headers |

```text

/usr = User-space applications & utilities (the "big library" of installed software)

```

🔴 **Exam Trap:** Don't confuse `/usr` (programs) with `/home` (personal user files) — a very common beginner mix-up.

---

### `/bin` — Essential User Commands

Basic commands needed by **all users**, available even in minimal/recovery mode.

```bash

ls, cp, ping, grep, ps, kill

```

```text

/bin = Basic binary commands

```

> 💡 On modern distros, `/bin` is often just a **symlink** to `/usr/bin` (merged-usr layout).

---

## 3. Other Important FHS Directories

### `/boot` — Boot Files

Files needed to **start Linux** — kernel, bootloader, initial RAM disk.

```text

vmlinuz      # Linux kernel image

initrd.img   # Initial RAM disk

grub/        # GRUB bootloader files

```

```text

/boot = Files used to boot/start Linux

```

---

### `/dev` — Device Files

Linux treats hardware as files. `/dev` holds these device representations.

```text

/dev/sda      # first hard disk

/dev/sda1     # first partition on that disk

/dev/tty1     # terminal

```

```text

/dev = Devices (disks, USB, terminals, mic, speakers)

```

---

### `/lib` — Shared Libraries

Libraries required by programs in `/bin` and `/sbin` to actually run.

```text

libncurses.so

ld-2.11.1.so

```

```text

/lib = Libraries needed by programs

```

---

### `/media` — Removable Media

Auto-mount point for **removable devices**: USB, CD/DVD, pen drives.

```text

/media/cdrom

/media/floppy

```

```text

/media = Removable devices

```

---

### `/mnt` — Temporary Manual Mount Point

Used by **admins** to manually/temporarily mount a filesystem.

```bash

mount /dev/sdb1 /mnt

```

```text

/mnt = Manual/temporary mounting

```

### `/media` vs `/mnt`

| Feature | `/media` | `/mnt` |

| ---------- | ------------------------------ | -------------------------------- |

| Used for | Removable devices (auto-mount) | Manual/temporary mounts by admin |

| Who mounts | System (automatically) | Sysadmin (manually) |

---

### `/opt` — Optional / Third-Party Software

Software **not part of the default OS install** — usually vendor apps.

```text

/opt/company-name/application

```

```text

/opt = Optional third-party applications

```

---

### `/sbin` — System Administration Commands

Commands mainly used by **root/sysadmins** for system maintenance.

```bash

fdisk, reboot, iptables, fsck, swapon

```

### `/bin` vs `/sbin`

| Directory | Used By | Examples |

| --------- | ----------- | ------------------------- |

| `/bin` | All users | `ls`, `cp`, `grep` |

| `/sbin` | Admins/root | `fdisk`, `reboot`, `fsck` |

```text

/sbin = System binaries (admin-only tools)

```

---

### `/srv` — Service Data

Data served by services running on the system (web, FTP, version control).

```text

/srv/cvs

/srv/www

```

```text

/srv = Server/service data

```

---

### `/usr/local` — Manually Installed Software

Part of `/usr`, but called out separately because it's important: holds software **compiled/installed from source**, kept separate from package-manager-installed software to avoid conflicts/overwrites on updates.

```text

/usr/local/apache2

/usr/local/bin

```

```text

/usr/local = Manually installed / locally-built software

```

---

## 4. Quick Revision Table — All FHS Directories

| Directory | Purpose | Easy Meaning |

| ------------ | --------------------------- | ------------------ |

| `/` | Top of filesystem | Root |

| `/bin` | Essential commands | Basic binaries |

| `/boot` | Boot files | Starts Linux |

| `/dev` | Hardware/device files | Devices |

| `/etc` | Configuration files | Settings (static) |

| `/home` | User personal files | User homes |

| `/lib` | Shared libraries | Libraries |

| `/media` | Removable device mounts | USB/CD |

| `/mnt` | Temporary mounts | Manual mount |

| `/opt` | Third-party software | Optional software |

| `/proc` | Process/system info | Live process info |

| `/sbin` | Admin commands | System binaries |

| `/srv` | Service/server data | Services |

| `/tmp` | Temporary files | Temporary data |

| `/usr` | Programs and utilities | Applications |

| `/usr/local` | Manually installed software | Locally-built apps |

| `/var` | Variable/changing data | Logs, mail, cache |

---

## 5. Linux File Types

Linux is famous for the philosophy **"everything is a file"** — not just documents, but devices, pipes, and sockets too. You can identify a file's type from the **first character** in `ls -l` output.

```bash

ls -l

-rw-r--r--   1 user user   120 Aug 11 file.txt

drwxr-xr-x   2 user user  4096 Aug 11 folder/

lrwxrwxrwx   1 user user     7 Aug 11 link -> target

brw-rw----   1 root disk    8,  0 Aug 11 sda

crw-rw-rw-   1 root root  1,   3 Aug 11 null

prw-r--r--   1 user user     0 Aug 11 mypipe

srwxr-xr-x   1 user user     0 Aug 11 mysocket

```

| Symbol (1st char in `ls -l`) | File Type | Description | Example |

| ---------------------------- | --------------------------- | ---------------------------------------------------------------------------------- | ----------------------- |

| `-` | **Regular file** | Normal file — text, binary, images, scripts | `file.txt`, `photo.jpg` |

| `d` | **Directory** | A folder that contains other files/directories | `/home/user/` |

| `l` | **Symbolic link (symlink)** | Shortcut/pointer to another file's path | `ln -s target link` |

| `b` | **Block device** | Hardware device that transfers data in **blocks** (chunks); supports random access | `/dev/sda` (hard disk) |

| `c` | **Character device** | Hardware device that transfers data as a **stream of characters**, one at a time | `/dev/tty`, `/dev/null` |

| `p` | **FIFO (named pipe)** | Allows one-way communication between two unrelated processes | Created via `mkfifo` |

| `s` | **Socket** | Enables communication between processes (often over a network or locally) | `/var/run/docker.sock` |

### 5.1 Quick Explanations with Examples

**Regular file (`-`)**

```bash

touch myfile.txt

ls -l myfile.txt

# -rw-r--r--  ...  myfile.txt

```

Everyday files: text, scripts, binaries, images.

---

**Directory (`d`)**

```bash

mkdir myfolder

ls -ld myfolder

# drwxr-xr-x ...  myfolder

```

Container for other files and directories.

---

**Symbolic Link (`l`)**

```bash

ln -s /etc/passwd mylink

ls -l mylink

# lrwxrwxrwx ... mylink -> /etc/passwd

```

Points to another file by **path**; breaks if target is deleted/moved.

---

**Block Device (`b`)**

```bash

ls -l /dev/sda

# brw-rw---- ... /dev/sda

```

Represents storage hardware (hard disks, SSDs, USB drives). Data is read/written in **fixed-size blocks**, and random access (jumping to any block) is possible.

---

**Character Device (`c`)**

```bash

ls -l /dev/null

# crw-rw-rw- ... /dev/null

```

Represents devices that send/receive data as a continuous **stream**, one character at a time — no random access. Examples: keyboards, mice, terminals, `/dev/null`, `/dev/zero`.

---

**FIFO / Named Pipe (`p`)**

```bash

mkfifo mypipe

ls -l mypipe

# prw-r--r-- ... mypipe

```

Used for **one-way** inter-process communication (IPC) — one process writes, another reads, in **First-In-First-Out** order. Unlike an anonymous pipe (`|` in bash), a named pipe has an actual path on the filesystem so unrelated processes can use it.

---

**Socket (`s`)**

```bash

ls -l /var/run/docker.sock

# srwxr-xr-x ... docker.sock

```

Enables **bidirectional** communication between processes — locally (Unix domain socket) or across a network. Example: Docker daemon communicates with the Docker CLI via a Unix socket.

---

### 5.2 Comparison Table: Block vs Character Device

| Feature | Block Device | Character Device |

| ------------------ | ----------------------------------------- | --------------------------------------------------- |

| Data transfer | In fixed-size blocks/chunks | Byte/character stream |

| Random access | ✅ Yes (can jump to any block) | ❌ No (sequential only) |

| Buffered by kernel | ✅ Yes | Usually not |

| Examples | Hard disks, SSDs, USB drives (`/dev/sda`) | Keyboard, mouse, terminal, `/dev/null`, `/dev/zero` |

---

### 5.3 All File Types — Summary Table

| Type | `ls -l` symbol | Real-world example |

| ----------------- | -------------- | ----------------------------------------- |

| Regular file | `-` | `.txt`, `.jpg`, `.sh` |

| Directory | `d` | `/home/user/` |

| Symbolic link | `l` | Shortcut created via `ln -s` |

| Block device | `b` | `/dev/sda` (disk) |

| Character device | `c` | `/dev/null`, `/dev/tty` |

| FIFO (named pipe) | `p` | Created via `mkfifo`, one-way IPC |

| Socket | `s` | `/var/run/docker.sock`, bidirectional IPC |

🔴 **Exam Trap:** Command to check any file's type quickly (beyond `ls -l`):

```bash

file filename    # tells you the type in plain English

stat filename     # detailed metadata including type

```

---

## 6. Quick-Fire Viva Q&A

| Question | Answer |

| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |

| What does FHS stand for? | Filesystem Hierarchy Standard |

| Difference between `/etc` and `/var`? | `/etc` = static config files; `/var` = dynamic/growing data (logs, cache, mail) |

| Difference between `/usr` and `/home`? | `/usr` = installed programs/utilities; `/home` = personal user files |

| Difference between `/media` and `/mnt`? | `/media` = auto-mount for removable devices; `/mnt` = manual/temporary mount by admin |

| Difference between `/bin` and `/sbin`? | `/bin` = commands for all users; `/sbin` = admin-only commands |

| What is `/proc`? | A virtual filesystem showing live process & kernel info, not real disk files |

| Where does manually-installed (from source) software go? | `/usr/local` |

| What is "everything is a file" in Linux? | Even hardware devices, pipes, and sockets are represented and accessed as files |

| Difference between block and character device? | Block = data in chunks, random access (disks); Character = data as stream, sequential (keyboard, `/dev/null`) |

| What is a FIFO / named pipe? | A special file enabling one-way IPC between unrelated processes, in FIFO order |

| What is a socket file? | Enables two-way communication between processes, locally or over network |

| How to identify a symlink in `ls -l`? | First character is `l`, and it shows `link -> target` |

| Command to check a file's type quickly? | `file filename` or `stat filename` |

---

## 7. One-Page Memory Trick

```text

/       → Root

/bin    → Commands (everyone)

/boot   → Boot files

/dev    → Devices

/etc    → Config (static)

/home   → User personal files

/lib    → Libraries

/media  → Removable media (auto)

/mnt    → Manual mount

/opt    → Optional/3rd-party software

/proc   → Live process info

/sbin   → Admin commands

/srv    → Service data

/tmp    → Temporary files

/usr    → Applications/utilities

/var    → Variable/changing data (logs, cache)

```

```text

File types (ls -l 1st char):

-  → regular file

d  → directory

l  → symlink

b  → block device

c  → character device

p  → FIFO/named pipe

s  → socket

```

---

_CDAC DITISS — PGCP-ITISS | Linux OS & Security | FHS + File Types_
