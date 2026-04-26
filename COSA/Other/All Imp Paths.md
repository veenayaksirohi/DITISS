<!-- CORE SYSTEM PATHS -->

| 📂 Path     | 🧠 Purpose                  | 📌 What Stored Here                                                     |
| ----------- | --------------------------- | ----------------------------------------------------------------------- |
| `/`         | **Root directory**          | Top-most directory; all other directories exist inside it               |
| `/bin`      | **Essential user commands** | Basic commands like `ls`, `cp`, `mv`, `cat` needed for system operation |
| `/sbin`     | **System admin commands**   | Administrative commands like `fdisk`, `reboot`, `iptables`              |
| `/boot`     | **Boot files**              | Kernel files, bootloader files (GRUB), initramfs                        |
| `/boot/efi` | **EFI boot files**          | Files used by UEFI firmware during system startup                       |
| `/dev`      | **Device files**            | Hardware devices like disks (`/dev/sda`), USB, terminals                |
| `/etc`      | **Configuration files**     | System-wide config files (users, network, services)                     |
| `/home`     | **User home directories**   | Personal files of users (e.g., `/home/user`)                            |
| `/lib`      | **Essential libraries**     | Libraries needed by `/bin` and `/sbin` programs                         |
| `/lib64`    | **64-bit libraries**        | 64-bit system libraries                                                 |
| `/media`    | **Removable media mount**   | USB drives, CDs automatically mounted here                              |
| `/mnt`      | **Temporary mounts**        | Manual mounting of filesystems (temporary use)                          |
| `/opt`      | **Optional software**       | Third-party applications installed manually                             |
| `/proc`     | **Process information**     | Virtual files showing CPU, memory, running processes                    |
| `/root`     | **Root user home**          | Home directory of the root (admin) user                                 |
| `/run`      | **Runtime data**            | Temporary system runtime files (PIDs, sockets)                          |
| `/srv`      | **Service data**            | Data used by services like web or FTP servers                           |
| `/sys`      | **System hardware info**    | Hardware and kernel information interface                               |
| `/tmp`      | **Temporary files**         | Short-term files deleted on reboot                                      |
| `/usr`      | **User programs**           | Installed applications, libraries, documentation                        |
| `/var`      | **Variable data**           | Logs, mail, cache, spool files                                          |




Linux Root Directories — Quick Revision Table

| 📂 Path     | 🔑 Keyword (Memory Hint) | 🧠 Quick Purpose        |
| ----------- | ------------------------ | ----------------------- |
| `/`         | **Root**                 | Top of all directories  |
| `/bin`      | **Basic Commands**       | Essential user commands |
| `/sbin`     | **System Commands**      | Admin/system commands   |
| `/boot`     | **Boot Files**           | Kernel & bootloader     |
| `/boot/efi` | **EFI Boot**             | UEFI boot files         |
| `/dev`      | **Devices**              | Hardware devices        |
| `/etc`      | **Settings**             | System config files     |
| `/home`     | **Users**                | User personal files     |
| `/lib`      | **Libraries**            | Essential libraries     |
| `/lib64`    | **64-bit Lib**           | 64-bit libraries        |
| `/media`    | **Removable**            | USB/CD mounts           |
| `/mnt`      | **Manual Mount**         | Temporary mounts        |
| `/opt`      | **Optional Apps**        | Third-party software    |
| `/proc`     | **Processes**            | CPU/process info        |
| `/root`     | **Root User**            | Admin home directory    |
| `/run`      | **Runtime**              | Temporary runtime data  |
| `/srv`      | **Services**             | Service data            |
| `/sys`      | **System Info**          | Hardware/kernel info    |
| `/tmp`      | **Temp Files**           | Temporary files         |
| `/usr`      | **User Programs**        | Installed software      |
| `/var`      | **Variable Data**        | Logs & cache            |



Ultra-Short One-Word Revision Table

| 📂 Path  | 🧠 One-Word Memory |
| -------- | ------------------ |
| `/`      | Root               |
| `/bin`   | Commands           |
| `/sbin`  | Admin              |
| `/boot`  | Startup            |
| `/dev`   | Devices            |
| `/etc`   | Config             |
| `/home`  | Users              |
| `/lib`   | Libraries          |
| `/media` | USB                |
| `/mnt`   | Mount              |
| `/opt`   | Software           |
| `/proc`  | Process            |
| `/root`  | AdminHome          |
| `/run`   | Runtime            |
| `/srv`   | Service            |
| `/sys`   | System             |
| `/tmp`   | Temp               |
| `/usr`   | Programs           |
| `/var`   | Logs               |





Subdirectories

Here are the **3 clean purpose tables** for your selected **most important paths** — compact and **exam-revision friendly**.

---

# 📂 Table 1 — `/etc` Important Files (Configuration Files)

| 📂 Path            | 🧠 Purpose                | 📌 What It Stores / Controls                      |
| ------------------ | ------------------------- | ------------------------------------------------- |
| `/etc/passwd`      | User account info         | Stores usernames, UID, GID, home directory, shell |
| `/etc/shadow`      | Password security         | Stores encrypted user passwords                   |
| `/etc/group`       | Group management          | Stores group names and members                    |
| `/etc/fstab`       | Filesystem mounting       | Defines partitions to mount automatically at boot |
| `/etc/hosts`       | Local hostname resolution | Maps IP address to hostname locally               |
| `/etc/resolv.conf` | DNS configuration         | Stores DNS server IP addresses                    |
| `/etc/ssh/`        | SSH configuration         | Contains SSH server/client configuration files    |
| `/etc/systemd/`    | Service configuration     | Contains systemd service and unit files           |

---

# 📂 Table 2 — `/var` Important Directories (Variable Data)

| 📂 Path       | 🧠 Purpose       | 📌 What It Stores                       |
| ------------- | ---------------- | --------------------------------------- |
| `/var/log/`   | System logging   | Stores logs of system, services, errors |
| `/var/www/`   | Web server data  | Stores website files                    |
| `/var/mail/`  | Mail storage     | Stores user mailboxes                   |
| `/var/spool/` | Queue storage    | Stores queued jobs like mail & printing |
| `/var/lib/`   | Application data | Stores databases and service data       |

---

# 📂 Table 3 — `/usr` Important Directories (User Programs)

| 📂 Path       | 🧠 Purpose        | 📌 What It Stores                           |
| ------------- | ----------------- | ------------------------------------------- |
| `/usr/bin/`   | User commands     | Stores normal user executable programs      |
| `/usr/sbin/`  | Admin commands    | Stores system administration commands       |
| `/usr/lib/`   | Program libraries | Stores libraries required by programs       |
| `/usr/local/` | Local software    | Stores manually installed software          |
| `/usr/share/` | Shared data       | Stores documentation, manuals, shared files |


Part B )  IMPORTANT SYSTEM SUBPATHS

Part C) USER & SHELL PATHS

Part D ) SYSTEMD PATHS 

Part E ) MOUNT & FILESYSTEM PATHS  

Part F ) NETWORK CONFIGURATION PATHS

Part E ) DHCP PATHS

Part F ) DNS PATHS

Part G ) FTP (VSFTPD) PATHS

Part 7 ) 🗂️ NFS PATHS


Part 8 ) 🖥️ SAMBA PATHS


Part 9 ) APACHE (WEB SERVER) PATHS

Part  10)  MAIL SERVER PATHS (DOVECOT)


Part 11) SQUID PROXY PATHS  


part 12) PACKAGE MANAGEMENT PATHS  

part 13) 🔐 LDAP PATHS

Part 14) USER DATABASE PATHS 

part 15 ) LOGGING PATHS

part 16 ) MOST IMPORTANT EXAM PATHS (Revise these first) 

