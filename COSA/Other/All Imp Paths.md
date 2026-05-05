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

/usr/bin
/usr/sbin
/usr/lib
/usr/local

/var/log
/var/spool
/var/cache
/var/tmp

/proc/cpuinfo
/proc/meminfo
/proc/[PID]

/dev/sda
/dev/sdb
/dev/sdc
/dev/sda1
/dev/sda2
/dev/sdb1
/dev/null
/dev/tty


Part C) USER & SHELL PATHS
~/.bashrc
~/.profile
/home/<user>
$HOME
$PATH
$USER
$SHELL

Used for:

Environment setup
Login shell config
User settings

Part D ) SYSTEMD PATHS 

/etc/systemd/system/
/usr/lib/systemd/system/
/lib/systemd/system/
/run/systemd

/etc/systemd/system/default.target
/etc/systemd/system/myapp.service
/etc/systemd/system/mydisk.mount
/usr/lib/systemd/systemd

Very important for:
Services
Boot targets
Daemons

Part E ) MOUNT & FILESYSTEM PATHS  
/etc/fstab
/mnt
/home

Used for:

Persistent mounts
NFS mounts

Part F ) NETWORK CONFIGURATION PATHS

/etc/sysconfig/network-scripts/
/etc/sysconfig/dhcpd
/etc/services
/etc/protocols
/etc/hosts

Important for:

Networking
DHCP binding
Host resolution

Part E ) DHCP PATHS

/etc/dhcp/dhcpd.conf
/etc/sysconfig/dhcpd

Used for:

IP allocation
DHCP subnet config

Part F ) DNS PATHS
/etc/hosts

Used for:
Local DNS mapping

Part G ) FTP (VSFTPD) PATHS
/etc/vsftpd/vsftpd.conf
/etc/vsftpd/chroot_list
/run/sshd.pid


Used for:
FTP configuration
User restrictions


Part 7 ) 🗂️ NFS PATHS
/etc/idmapd.conf
/etc/exports

Used for:
Network file sharing

Part 8 ) 🖥️ SAMBA PATHS
/etc/samba/smb.conf
/var/smb/share

Used for:
Windows file sharing

Part 9 ) APACHE (WEB SERVER) PATHS
/etc/httpd/conf/httpd.conf
/etc/httpd/conf.d/
/etc/httpd/conf.d/example.conf

/var/www/html/
/var/www/example

/var/log/httpd/

Used for:
Website hosting
Virtual hosts
Logs


Part  10)  MAIL SERVER PATHS (DOVECOT)
/etc/dovecot/conf.d/10-mail.conf
/etc/dovecot/conf.d/10-auth.conf
/etc/dovecot/conf.d/10-master.conf

/var/spool/postfix/private/auth

/var/mail/<user>
/home/<user>/Maildir/new/

Used for:
Email services

Part 11) SQUID PROXY PATHS  

/etc/squid/squid.conf
/etc/squid/blocked_domains.txt
/etc/squid/blocked_extensions.txt
/etc/squid/ad_patterns.txt

Used for:

Web filtering
Proxy control

part 12) PACKAGE MANAGEMENT PATHS  

Debian / Ubuntu
/etc/apt/sources.list
/etc/apt/sources.list.d/*.list
/var/lib/dpkg/


RHEL / CentOS
/etc/yum.repos.d/

Used for:
Software repositories

part 13) 🔐 LDAP PATHS
/etc/openldap/schema/

/etc/openldap/schema/core.ldif
/etc/openldap/schema/cosine.ldif
/etc/openldap/schema/inetorgperson.ldif
/etc/openldap/schema/nis.ldif
/etc/openldap/schema/openldap.ldif

Used for:

Directory services


Part 14) USER DATABASE PATHS 

/etc/passwd
/etc/shadow
/etc/group
/etc/hosts
/etc/services
/etc/protocols

Used for:

Authentication
Users
Networking

part 15 ) LOGGING PATHS

/var/log
/tmp/session.log

Used for:

Troubleshooting
Debugging


part 16 ) MOST IMPORTANT EXAM PATHS (Revise these first) 

/etc/passwd
/etc/shadow
/etc/group

/etc/fstab

/etc/systemd/system/
/usr/lib/systemd/system/

/etc/dhcp/dhcpd.conf

/etc/httpd/conf/httpd.conf
/var/www/html/

/etc/samba/smb.conf

/etc/vsftpd/vsftpd.conf

/etc/exports

/etc/apt/sources.list

/etc/openldap/schema/

/var/log