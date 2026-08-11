# Linux File Hierarchy Structure (FHS) – Easy Notes

## 1. What is Linux File Hierarchy Structure?

The **Linux File Hierarchy Structure**, also called **FHS (Filesystem Hierarchy Standard)**, defines how files and directories are organized in Linux.

In Linux:

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── media
├── mnt
├── opt
├── sbin
├── srv
├── tmp
├── usr
└── proc
```

Everything starts from the **root directory `/`**.

---

# 2. `/` – Root Directory

`/` is the topmost directory in Linux.

All other directories exist under it.

Example:

```bash
/
├── home
├── etc
├── boot
└── usr
```

Normally, only the **root user** can modify important files directly inside `/`.

### Easy way to remember

```text
/ = Starting point of Linux filesystem
```

---

# 3. `/bin` – Essential Commands

`/bin` contains important command programs required by users and the system.

Examples:

```bash
ls
cp
ping
grep
ps
kill
```

These commands can be used by normal users as well.

### Example

```bash
/bin/ls
```

### Easy way to remember

```text
/bin = Basic binary commands
```

---

# 4. `/boot` – Boot Files

`/boot` contains files needed to start Linux.

It contains things such as:

- Linux kernel files
- GRUB bootloader files
- initrd files

Examples:

```text
vmlinuz
initrd.img
grub
```

### Easy way to remember

```text
/boot = Files used to boot/start Linux
```

---

# 5. `/dev` – Device Files

`/dev` contains files representing hardware devices.

Linux treats hardware devices like files.

Examples:

```text
/dev/sda
/dev/sda1
/dev/tty1
```

Devices can include:

- Hard disks
- USB devices
- Terminals
- Speakers
- Microphones

### Example

```text
/dev/sda1
```

may represent a disk partition.

### Easy way to remember

```text
/dev = Devices
```

---

# 6. `/etc` – Configuration Files

`/etc` contains system-wide configuration files.

It stores configuration for:

- Users
- Networks
- Services
- Applications
- System settings

Examples:

```text
/etc/passwd
/etc/resolv.conf
/etc/logrotate.conf
```

### Easy way to remember

```text
/etc = System configuration
```

---

# 7. `/home` – User Home Directories

`/home` contains personal directories of normal users.

For example, if the username is:

```text
veenay
```

the home directory can be:

```text
/home/veenay
```

Users normally store their:

- Documents
- Downloads
- Personal files
- User settings

inside their home directory.

### Example

```bash
/home/veenay/Documents
```

### Easy way to remember

```text
/home = Normal users' personal files
```

---

# 8. `/lib` – Libraries

`/lib` contains important shared libraries required by programs.

Programs stored in directories such as `/bin` may depend on these libraries.

Examples:

```text
libncurses.so
ld-2.11.1.so
```

### Easy way to remember

```text
/lib = Libraries needed by programs
```

---

# 9. `/media` – Removable Media

`/media` is commonly used to mount removable devices.

Examples:

- CD/DVD
- USB drive
- Pen drive
- Floppy disk

Examples of directories:

```text
/media/cdrom
/media/floppy
```

### Easy way to remember

```text
/media = Removable devices
```

---

# 10. `/mnt` – Temporary Mount Point

`/mnt` is used by administrators to temporarily mount a filesystem or external drive.

Example:

```bash
mount /dev/sdb1 /mnt
```

After this, the files on `/dev/sdb1` can be accessed through:

```text
/mnt
```

### Easy way to remember

```text
/mnt = Manual or temporary mounting
```

---

# 11. `/opt` – Optional Software

`/opt` contains third-party or additional software that is not part of the default Linux installation.

Example:

```text
/opt/application
```

A vendor can install its application inside:

```text
/opt/company-name/
```

### Easy way to remember

```text
/opt = Optional/third-party applications
```

---

# 12. `/sbin` – System Administration Commands

`/sbin` contains important commands mainly used by system administrators.

Examples:

```bash
fdisk
reboot
iptables
fsck
swapon
```

These commands are mainly related to system maintenance.

### `/bin` vs `/sbin`

```text
/bin  → Common user commands
/sbin → System administrator commands
```

### Easy way to remember

```text
/sbin = System binaries
```

---

# 13. `/srv` – Service Data

`/srv` contains data related to services provided by the system.

Examples:

- Web server data
- FTP server data
- Version-control repository data

Example:

```text
/srv/cvs
```

### Easy way to remember

```text
/srv = Server/service data
```

---

# 14. `/tmp` – Temporary Files

`/tmp` contains temporary files created by programs and users.

Example:

```text
/tmp/test.txt
```

Files inside `/tmp` may be deleted automatically or when the system is restarted.

### Easy way to remember

```text
/tmp = Temporary files
```

---

# 15. `/usr` – User Programs and Utilities

`/usr` contains many programs, libraries, documentation, and utilities.

Important directories inside `/usr` include:

```text
/usr/bin
/usr/sbin
/usr/lib
/usr/local
/usr/src
```

## `/usr/bin`

Contains many normal user commands.

Examples:

```bash
awk
less
scp
```

## `/usr/sbin`

Contains system administration commands.

Examples:

```bash
sshd
cron
useradd
userdel
```

## `/usr/lib`

Contains libraries used by programs inside `/usr/bin` and `/usr/sbin`.

## `/usr/local`

Contains software installed manually or from source.

Example:

```text
/usr/local/apache2
```

## `/usr/src`

Contains source code, kernel source, header files, and related documentation.

### Easy way to remember

```text
/usr = User applications and utilities
```

---

# 16. `/proc` – Process and System Information

`/proc` is a **virtual/pseudo filesystem**.

It does not mainly contain normal files stored on the disk.

Instead, it provides information about:

- Running processes
- CPU
- Memory
- System uptime
- Other system resources

Each process can have its own directory based on its **PID**.

Example:

```text
/proc/1234
```

where `1234` is a process ID.

Important examples:

```bash
/proc/meminfo
/proc/uptime
```

`/proc/meminfo` gives information about system memory.

### Easy way to remember

```text
/proc = Process and system information
```

---

# Quick Revision Table

| Directory | Purpose                    | Easy Meaning      |
| --------- | -------------------------- | ----------------- |
| `/`       | Top of filesystem          | Root              |
| `/bin`    | Essential commands         | Basic binaries    |
| `/boot`   | Boot files                 | Starts Linux      |
| `/dev`    | Hardware/device files      | Devices           |
| `/etc`    | Configuration files        | Settings          |
| `/home`   | User personal files        | User homes        |
| `/lib`    | Shared libraries           | Libraries         |
| `/media`  | Removable device mounts    | USB/CD            |
| `/mnt`    | Temporary mounts           | Manual mount      |
| `/opt`    | Third-party software       | Optional software |
| `/sbin`   | Admin commands             | System binaries   |
| `/srv`    | Service/server data        | Services          |
| `/tmp`    | Temporary files            | Temporary data    |
| `/usr`    | Programs and utilities     | Applications      |
| `/proc`   | Process/system information | Process info      |

# Important Interview Questions

## Q1. What is FHS?

**FHS stands for Filesystem Hierarchy Standard.**

It defines how files and directories are organized in Linux.

---

## Q2. What is the root directory?

The root directory is:

```text
/
```

It is the top-level directory of Linux.

---

## Q3. Where are user files stored?

Normal users' personal files are usually stored in:

```text
/home
```

Example:

```text
/home/veenay
```

---

## Q4. Where are configuration files stored?

System configuration files are mainly stored in:

```text
/etc
```

---

## Q5. Where are boot files stored?

Boot-related files are stored in:

```text
/boot
```

---

## Q6. Where are device files stored?

Device files are stored in:

```text
/dev
```

---

## Q7. Difference between `/media` and `/mnt`?

```text
/media → Usually used for removable devices
/mnt   → Usually used for temporary/manual mounting
```

---

## Q8. Difference between `/bin` and `/sbin`?

```text
/bin
→ Essential commands used by users.

Examples:
ls
cp
grep

/sbin
→ System administration commands.

Examples:
fdisk
reboot
fsck
```

---

## Q9. What is `/proc`?

`/proc` is a virtual filesystem containing information about running processes and system resources.

Example:

```text
/proc/meminfo
```

shows memory information.

---

# One-Line Memory Trick

```text
/      → Root
/bin   → Commands
/boot  → Boot
/dev   → Devices
/etc   → Configuration
/home  → Users
/lib   → Libraries
/media → Removable media
/mnt   → Mount
/opt   → Optional software
/sbin  → Admin commands
/srv   → Services
/tmp   → Temporary files
/usr   → Applications
/proc  → Processes
```

## Most Important Directories for Interviews

Remember these first:

```text
/etc   → Configuration
/home  → User files
/var   → Variable/changing data
/bin   → Commands
/sbin  → Admin commands
/boot  → Boot files
/dev   → Devices
/tmp   → Temporary files
/proc  → Process information
/usr   → Programs
```
