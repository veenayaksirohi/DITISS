# 🐧 Linux Filesystem Paths — Complete Reference

---

## Part 1 — 🗂️ Root Directory Overview

| 📂 Path     | 🧠 Purpose                  | 📌 What Is Stored Here                                                  |
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

---

## Part 2 — ⚡ Quick Revision Table

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

---

## Part 3 — 🔤 Ultra-Short One-Word Revision Table

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

---

## Part 4 — ⚙️ `/etc` Important Files (Configuration Files)

| 📂 Path            | 🧠 Purpose                | 📌 What It Stores / Controls                                   |
| ------------------ | ------------------------- | -------------------------------------------------------------- |
| `/etc/passwd`      | User account info         | Stores usernames, UID, GID, home directory, shell              |
| `/etc/shadow`      | Password security         | Stores encrypted user passwords                                |
| `/etc/group`       | Group management          | Stores group names and members                                 |
| `/etc/fstab`       | Filesystem mounting       | Defines partitions to mount automatically at boot              |
| `/etc/hostname`    | System hostname           | Stores the machine's hostname (used at boot)                   |
| `/etc/hosts`       | Local hostname resolution | Maps IP address to hostname locally                            |
| `/etc/resolv.conf` | DNS configuration         | Stores DNS server IP addresses                                 |
| `/etc/services`    | Service port mapping      | Maps service names to port numbers and protocols               |
| `/etc/ssh/`        | SSH configuration         | Contains SSH server/client configuration files                 |
| `/etc/systemd/`    | Service configuration     | Contains systemd service and unit files                        |

---

## Part 5 — 📦 `/var` Important Directories (Variable Data)

| 📂 Path       | 🧠 Purpose       | 📌 What It Stores                       |
| ------------- | ---------------- | --------------------------------------- |
| `/var/log/`   | System logging   | Stores logs of system, services, errors |
| `/var/www/`   | Web server data  | Stores website files                    |
| `/var/mail/`  | Mail storage     | Stores user mailboxes                   |
| `/var/spool/` | Queue storage    | Stores queued jobs like mail & printing |
| `/var/lib/`   | Application data | Stores databases and service data       |

---

## Part 6 — 💻 `/usr` Important Directories (User Programs)

| 📂 Path       | 🧠 Purpose        | 📌 What It Stores                           |
| ------------- | ----------------- | ------------------------------------------- |
| `/usr/bin/`   | User commands     | Stores normal user executable programs      |
| `/usr/sbin/`  | Admin commands    | Stores system administration commands       |
| `/usr/lib/`   | Program libraries | Stores libraries required by programs       |
| `/usr/local/` | Local software    | Stores manually installed software          |
| `/usr/share/` | Shared data       | Stores documentation, manuals, shared files |

---

## Part 7 — 🔍 Important System Subpaths

<<<<<<< HEAD
| 📂 Path                | 🧠 Purpose                          | 📌 What It Stores                                                          |
| ---------------------- | ----------------------------------- | -------------------------------------------------------------------------- |
| `/etc`                 | System-wide config hub              | Main config files for almost all services and system tools                 |
| `/etc/passwd`          | User account DB                     | List of users: UID, GID, home, shell (no password hashes)                  |
| `/etc/shadow`          | User password DB                    | Hashed passwords, aging, expiry (root-only access)                         |
| `/etc/group`           | Group DB                            | Group names, GID, user lists                                               |
| `/etc/gshadow`         | Secure group DB                     | Group passwords and admins (if used)                                       |
| `/etc/hosts`           | Local hostnames                     | Static hostname-to-IP mapping (fallback to DNS)                            |
| `/etc/fstab`           | Persistent filesystems              | Mount options for disks, partitions, and network mounts                    |
| `/etc/init.d/`         | SysV-style init scripts (RHEL/CentOS) | Boot-time startup/shutdown scripts                                       |
| `/proc`                | Runtime kernel & process info       | Virtual FS showing processes, memory, CPU, etc.                            |
| `/var/log`             | Log directory                       | Application and system logs (central for security and troubleshooting)     |
| `/var/log/auth.log`    | Authentication logs (Debian)        | SSH, sudo, login, fail2ban, etc. events                                    |
| `/var/log/secure`      | Authentication logs (RHEL)          | SSH, su, sudo, and auth logs (RHEL/CentOS)                                 |
| `/boot`                | Bootloader & kernel                 | `vmlinuz`, `initramfs`, GRUB config, kernel images                         |
| `/dev`                 | Device files                        | Hardware devices as files (e.g., `/dev/sda`, `/dev/ttyS0`)                |
| `/sys`                 | Kernel device info                  | Exported kernel data for device and driver configuration                   |
| `/tmp`                 | System-wide temp                    | Volatile temporary files, often cleared on reboot                          |
=======
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
<<<<<<< Updated upstream

Used for:

Environment setup
Login shell config
User settings
=======
>>>>>>> Stashed changes

Used for:

Environment setup
Login shell config
User settings
>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7

---

<<<<<<< HEAD
## Part 8 — 👤 User & Shell Paths
=======
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
<<<<<<< Updated upstream

Used for:

Persistent mounts
NFS mounts
=======
>>>>>>> Stashed changes

Used for:

Persistent mounts
NFS mounts
>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7

| 📂 Path                    | 🧠 Purpose             | 📌 What It Stores                                              |
| -------------------------- | ---------------------- | -------------------------------------------------------------- |
| `/etc/passwd`              | User account list      | Login name, UID, GID, home directory, login shell              |
| `/etc/shadow`              | Secure auth info       | Password hashes, minimum/max age, expiry, lockout              |
| `/etc/login.defs`          | Login defaults         | PASS_MIN_DAYS, PASS_MAX_DAYS, UID/GID ranges                   |
| `/home/username`           | User home (Debian/Ubuntu) | Personal config, data, scripts, SSH keys for user           |
| `/root`                    | Root user home         | Root-specific dot-files and scripts                            |
| `/etc/skel`                | Skeleton home          | Template files copied into each new user's home on creation    |
| `/etc/default/useradd`     | `useradd` defaults (RHEL) | Default shell, home base, group creation options            |
| `/etc/shells`              | Allowed login shells   | List of valid shells (`/bin/bash`, `/bin/sh`, etc.)            |
| `~/.bashrc`                | User-level bash config | Aliases, prompt, PATH, and environment variables               |
| `~/.profile`               | User profile script    | Environment variables and startup commands for login shells    |

<<<<<<< HEAD
---

## Part 9 — 🔧 Systemd Paths

| 📂 Path                              | 🧠 Purpose                  | 📌 What It Stores                                              |
| ------------------------------------ | --------------------------- | -------------------------------------------------------------- |
| `/lib/systemd/system/`               | Vendor unit files (Debian)  | Default units shipped by OS packages (e.g., `ssh.service`)     |
| `/usr/lib/systemd/system/`           | Vendor unit files (RHEL)    | Default units provided by packages (e.g., `httpd.service`)     |
| `/etc/systemd/system/`               | Admin-created units         | Custom service, timer, socket files and drop-in overrides      |
| `/run/systemd/system/`               | Runtime unit files          | Transient units generated at runtime                           |
| `/etc/systemd/system/*.service`      | Custom service definitions  | `.service` files for custom apps or tweaks                     |
| `/etc/systemd/system/*.service.d/`   | Service overrides           | Drop-in dirs to override vendor unit without changing it       |
| `/etc/systemd/system/default.target` | Default boot target         | Symlink defining the default runlevel (e.g., multi-user, graphical) |
| `/etc/systemd/journald.conf`         | journalctl config           | Log-retention, storage, and forwarding settings for journald   |

**Useful `systemd` exam commands:**

- `systemctl status ssh` / `systemctl status sshd`
- `systemctl enable httpd` / `systemctl enable apache2`
- `systemctl list-units --type=service --state=active`
- `systemctl daemon-reload` (after editing units)

---

## Part 10 — 🌐 DHCP Paths

| 📂 Path                           | 🧠 Purpose            | 📌 What It Stores                                              |
| --------------------------------- | --------------------- | -------------------------------------------------------------- |
| `/etc/dhcp/dhcpd.conf` (Debian)   | DHCP server config    | Subnets, ranges, DNS, routers, lease time for ISC-DHCP         |
| `/etc/dhcpd.conf` (older RHEL)    | DHCP server config    | Main ISC-DHCP server config (RHEL/CentOS legacy)               |
| `/etc/sysconfig/dhcpd` (RHEL)     | DHCP daemon options   | Interfaces DHCP server should listen on                        |
| `/var/lib/dhcp/dhcpd.leases`      | DHCP leases DB        | Current/previous IP-lease assignments to MACs                  |

---

## Part 11 — 🌍 DNS Paths (BIND)
=======
/etc/sysconfig/network-scripts/
/etc/sysconfig/dhcpd
/etc/services
/etc/protocols
/etc/hosts

Important for:

Networking
DHCP binding
Host resolution

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
<<<<<<< Updated upstream
=======

/var/spool/postfix/private/auth

/var/mail/<user>
/home/<user>/Maildir/new/

Used for:
Email services
>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7

| 📂 Path                                          | 🧠 Purpose           | 📌 What It Stores                                              |
| ------------------------------------------------ | -------------------- | -------------------------------------------------------------- |
| `/etc/named.conf` (RHEL)                         | BIND main config     | Global options, logging, zone declarations, ACLs               |
| `/etc/bind/named.conf` (Debian)                  | BIND main config     | Debian BIND main config file                                   |
| `/etc/bind/named.conf.options`                   | Global BIND options  | Listening interfaces, recursion, DNSSEC, logging               |
| `/etc/bind/named.conf.local`                     | Local zones          | Forward/reverse zones for your network (Debian)                |
| `/var/named/` (RHEL)                             | Zone files directory | Default location for zone DBs like `example.com.zone`         |
| `/var/lib/bind/` (Debian)                        | Zone files directory | Debian BIND zone-file storage                                  |
| `/var/log/messages` (RHEL) / `/var/log/syslog` (Debian) | DNS logs     | DNS-related messages if BIND logging is enabled                |

<<<<<<< HEAD
---
=======
/etc/squid/squid.conf
/etc/squid/blocked_domains.txt
/etc/squid/blocked_extensions.txt
/etc/squid/ad_patterns.txt

Used for:

Web filtering
Proxy control
>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7

## Part 12 — 🖥️ Samba Paths

<<<<<<< HEAD
| 📂 Path                   | 🧠 Purpose              | 📌 What It Stores                                              |
| ------------------------- | ----------------------- | -------------------------------------------------------------- |
| `/etc/samba/smb.conf`     | Main Samba config       | Shares, security mode, workgroup, authentication, mappings     |
| `/etc/samba/smbusers`     | UID/username mapping    | Map Samba user names to local Linux accounts                   |
| `/var/lib/samba/`         | Samba DB & runtime      | TDB files for user/SID mapping, locking, etc.                  |
| `/var/log/samba/`         | Samba logs              | Access, authentication, and error logs for each share          |
=======
Debian / Ubuntu
/etc/apt/sources.list
/etc/apt/sources.list.d/*.list
/var/lib/dpkg/
>>>>>>> Stashed changes

/var/spool/postfix/private/auth

/var/mail/<user>
/home/<user>/Maildir/new/

Used for:
Email services

RHEL / CentOS
/etc/yum.repos.d/

<<<<<<< Updated upstream
/etc/squid/squid.conf
/etc/squid/blocked_domains.txt
/etc/squid/blocked_extensions.txt
/etc/squid/ad_patterns.txt

Used for:

Web filtering
Proxy control

part 12) PACKAGE MANAGEMENT PATHS  
=======
Used for:
Software repositories
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream

/etc/openldap/schema/core.ldif
/etc/openldap/schema/cosine.ldif
/etc/openldap/schema/inetorgperson.ldif
/etc/openldap/schema/nis.ldif
/etc/openldap/schema/openldap.ldif

Used for:

Directory services

=======
>>>>>>> Stashed changes

/etc/openldap/schema/core.ldif
/etc/openldap/schema/cosine.ldif
/etc/openldap/schema/inetorgperson.ldif
/etc/openldap/schema/nis.ldif
/etc/openldap/schema/openldap.ldif

Used for:

Directory services

>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7

---

<<<<<<< HEAD
## Part 13 — 📧 Mail Server Paths (Postfix + Dovecot)

### Postfix

| 📂 Path                          | 🧠 Purpose            | 📌 What It Stores                                              |
| -------------------------------- | --------------------- | -------------------------------------------------------------- |
| `/etc/postfix/main.cf`           | Main Postfix config   | Hostname, network, relay, TLS, auth, security parameters       |
| `/etc/postfix/master.cf`         | Service-type config   | Listener definitions (SMTP, submission, smtps, pickups)        |
| `/etc/postfix/aliases`           | Local aliases         | Mail aliases to other users or mailboxes                       |
| `/var/spool/postfix/`            | Postfix mail queue    | Queued messages, deferred mail, etc.                           |
| `/etc/postfix/header_checks`     | Content filtering     | Regex checks on mail headers (spam/blocking)                   |

### Dovecot

| 📂 Path                          | 🧠 Purpose            | 📌 What It Stores                                              |
| -------------------------------- | --------------------- | -------------------------------------------------------------- |
| `/etc/dovecot/dovecot.conf`      | Main Dovecot config   | Protocols, ports, SSL, mail location                           |
| `/etc/dovecot/conf.d/`           | Split-config dir      | Modular config files (auth, ssl, mail, etc.)                   |
| `/var/mail/` / `/var/spool/mail/` | Maildirs or spools   | Default mailboxes for system users (mbox style)                |
| `/etc/dovecot/dovecot-sql.conf.ext` | SQL auth backend  | If using SQL for Dovecot mailboxes                             |

---

## Part 14 — 🔒 Squid Proxy Paths

| 📂 Path                              | 🧠 Purpose               | 📌 What It Stores                                              |
| ------------------------------------ | ------------------------ | -------------------------------------------------------------- |
| `/etc/squid/squid.conf`              | Main Squid config        | Listening port, ACLs, cache, authentication, access rules      |
| `/etc/squid/squidGuard.conf`         | SquidGuard filter config | Web-filtering rules and blacklists (if installed)              |
| `/etc/squid/ad_patterns.txt`         | Ad/block pattern list    | Custom URL patterns or keywords used in ACL blocking rules     |
| `/var/log/squid/`                    | Squid logs               | Access, cache, and error logs for troubleshooting              |

---

## Part 15 — 📦 Package Management Paths

### Debian / Ubuntu (APT / DPKG)

| 📂 Path                       | 🧠 Purpose              | 📌 What It Stores                                              |
| ----------------------------- | ----------------------- | -------------------------------------------------------------- |
| `/var/lib/dpkg/status`        | Installed-package DB    | List of all installed packages and their status                |
| `/var/lib/dpkg/available`     | Available-package DB    | Available packages from last `apt` update (older)              |
| `/var/cache/apt/archives/`    | Downloaded packages     | `.deb` files cached by APT                                     |
| `/etc/apt/sources.list`       | APT repo list           | Debian/Ubuntu repository URLs                                  |
| `/etc/apt/sources.list.d/`    | Repo fragments          | Additional repo files dropped by packages or admin             |

### RHEL / CentOS (RPM / YUM / DNF)

| 📂 Path                   | 🧠 Purpose          | 📌 What It Stores                                              |
| ------------------------- | ------------------- | -------------------------------------------------------------- |
| `/var/lib/rpm/`           | RPM database        | All installed packages and metadata                            |
| `/etc/yum.repos.d/`       | YUM repo files      | Repository configurations for EL-based systems                |
| `/etc/dnf/dnf.conf`       | DNF global config   | Main config for DNF (RHEL/CentOS 8+)                          |
| `/var/cache/dnf/`         | DNF cache           | Downloaded RPMs and metadata cache                             |

---

## Part 16 — 🔐 LDAP Paths (OpenLDAP)

| 📂 Path                     | 🧠 Purpose                  | 📌 What It Stores                                              |
| --------------------------- | --------------------------- | -------------------------------------------------------------- |
| `/etc/ldap/ldap.conf`       | LDAP client config          | Global LDAP settings (URI, TLS, default base)                  |
| `/etc/ldap/ldap.conf.d/`    | Client config fragments     | Extra client-side options (Debian/Ubuntu)                      |
| `/etc/ldap/slapd.d/`        | Configurable slapd config   | OpenLDAP server config in LDIF-style directory                 |
| `/etc/ldap/slapd.conf`      | Legacy slapd config         | Older OpenLDAP config file (if used)                           |
| `/var/lib/ldap/`            | LDAP DB directory           | Database files for OpenLDAP (BER-encoded entries)              |
| `/var/log/slapd.log`        | OpenLDAP server log         | Connection, auth, search, and error logs                       |

---

## Part 17 — 📝 Logging Paths

| 📂 Path                | 🧠 Purpose                    | 📌 What It Stores                                              |
| ---------------------- | ----------------------------- | -------------------------------------------------------------- |
| `/var/log/syslog`      | Syslog — Debian/Ubuntu        | General system logs (rsyslog/syslog-ng forwarded logs)         |
| `/var/log/messages`    | Syslog — RHEL/CentOS          | General system messages and service logs                       |
| `/var/log/auth.log`    | Auth log — Debian             | SSH, sudo, login, and PAM-related events                       |
| `/var/log/secure`      | Auth log — RHEL               | SSH, su, sudo, and authentication logs                         |
| `/var/log/boot.log`    | Boot log                      | Messages from system boot sequence                             |
| `/var/log/kern.log`    | Kernel messages               | Kernel-level logs and hardware messages                        |
| `/var/log/apache2/`    | Apache logs — Debian          | `access.log`, `error.log` for each virtual host                |
| `/var/log/httpd/`      | Apache logs — RHEL            | `access_log`, `error_log` per service                          |
| `/var/log/journal/`    | systemd journal logs          | Binary logs used by `journalctl`                               |

---

## Part 18 — 🌐 Apache / HTTPD Paths

### RHEL / CentOS (httpd)

| 📂 Path                         | 🧠 Purpose               | 📌 What It Stores                                              |
| ------------------------------- | ------------------------ | -------------------------------------------------------------- |
| `/etc/httpd/conf/httpd.conf`    | Main Apache config       | Global server settings, ports, document root, modules          |
| `/etc/httpd/conf.d/`            | Extra configs            | Additional config files loaded by Apache (SSL, PHP, vhosts)    |
| `/etc/httpd/conf.d/site1.conf`  | Virtual host config      | Per-site settings for name-based virtual hosting               |
| `/var/www/html/`                | Default website root     | Default document root; `index.html` served from here          |
| `/var/log/httpd/`               | Apache logs — RHEL       | `access_log` and `error_log` per service                       |

### Debian / Ubuntu (apache2)

| 📂 Path                              | 🧠 Purpose               | 📌 What It Stores                                              |
| ------------------------------------ | ------------------------ | -------------------------------------------------------------- |
| `/etc/apache2/apache2.conf`          | Main Apache config       | Global server settings and include directives                  |
| `/etc/apache2/sites-available/`      | Available virtual hosts  | Virtual host config files (not yet enabled)                    |
| `/etc/apache2/sites-enabled/`        | Enabled virtual hosts    | Symlinks to active virtual hosts from `sites-available/`       |
| `/etc/apache2/conf-available/`       | Available extra configs  | Additional configuration snippets (not yet enabled)            |
| `/var/www/html/`                     | Default website root     | Default document root; `index.html` served from here          |
| `/var/log/apache2/`                  | Apache logs — Debian     | `access.log` and `error.log` for each virtual host             |

---

## Part 19 — ⚖️ HAProxy Paths

| 📂 Path                    | 🧠 Purpose          | 📌 What It Stores                                                      |
| -------------------------- | ------------------- | ---------------------------------------------------------------------- |
| `/etc/haproxy/haproxy.cfg` | Main HAProxy config | Frontend/backend definitions, load balancing rules, ACLs, health checks |
| `/var/log/haproxy.log`     | HAProxy logs        | Connection, request, and error logs for load balancer traffic           |

---

## Part 20 — 📁 FTP (vsftpd) Paths

| 📂 Path                     | 🧠 Purpose               | 📌 What It Stores                                              |
| --------------------------- | ------------------------ | -------------------------------------------------------------- |
| `/etc/vsftpd/vsftpd.conf`   | Main vsftpd config       | FTP settings: anonymous access, chroot, passive mode, TLS      |
| `/etc/vsftpd/chroot_list`   | Chroot user list         | List of users restricted to their home directory (jailed)      |
| `/etc/vsftpd/user_list`     | User allow/deny list     | Users explicitly allowed or denied FTP access                  |
| `/var/log/vsftpd.log`       | FTP server logs          | Login attempts, file transfers, and error messages             |

---

## Part 21 — 📂 NFS Paths

| 📂 Path             | 🧠 Purpose            | 📌 What It Stores                                                        |
| ------------------- | --------------------- | ------------------------------------------------------------------------ |
| `/etc/exports`      | NFS share definitions | Directories exported over NFS with client IPs and permissions            |
| `/etc/nfs.conf`     | NFS server settings   | NFS daemon options (threads, versions, ports)                            |
| `/etc/idmapd.conf`  | ID mapping config     | Maps UIDs/GIDs between client and server (NFSv4)                         |
| `/var/lib/nfs/`     | NFS runtime data      | State files, locks, client tracking info                                 |
| `/var/log/messages` | NFS logs (RHEL)       | NFS-related messages; use `grep nfs /var/log/messages` to filter         |

**Example `/etc/exports` entry:**
```
/home  192.168.1.0/24(rw,sync)
```
This shares `/home` with the `192.168.1.0/24` network with read/write access and synchronous writes.

---

## Part 22 — ⭐ Most Important Exam Paths (Revise These First)

| 📂 Path                                              | 🧠 Purpose (One-Line Summary)                         |
| ---------------------------------------------------- | ----------------------------------------------------- |
| `/etc/passwd`                                        | User list + home + shell                              |
| `/etc/shadow`                                        | Secure password & ageing DB                           |
| `/etc/group`                                         | Group definitions + members                           |
| `/etc/hostname`                                      | Machine's hostname                                    |
| `/etc/hosts`                                         | Static IP-to-hostname mapping                         |
| `/etc/services`                                      | Service name to port number mapping                   |
| `/etc/fstab`                                         | Filesystems to auto-mount at boot                     |
| `/etc/ssh/sshd_config`                               | SSH server settings (port, root login, auth)          |
| `/etc/systemd/system/*.service`                      | Custom service unit files                             |
| `/etc/systemd/system/default.target`                 | Default boot target (runlevel)                        |
| `/lib/systemd/system/` / `/usr/lib/systemd/system/`  | Vendor (OS default) unit files                        |
| `/etc/httpd/conf/httpd.conf`                         | Apache main config (RHEL)                             |
| `/etc/apache2/sites-available/`                      | Apache virtual hosts (Debian)                         |
| `/var/www/html/`                                     | Default web server document root                      |
| `/etc/haproxy/haproxy.cfg`                           | HAProxy load balancer config                          |
| `/etc/vsftpd/vsftpd.conf`                            | FTP server main config                                |
| `/etc/vsftpd/chroot_list`                            | FTP chroot (jailed) users list                        |
| `/etc/exports`                                       | NFS share definitions                                 |
| `/etc/nfs.conf`                                      | NFS server settings                                   |
| `/etc/samba/smb.conf`                                | Samba shares & security                               |
| `/etc/postfix/main.cf`                               | Postfix mail server settings                          |
| `/etc/dovecot/dovecot.conf`                          | IMAP/POP3 server config                               |
| `/etc/squid/squid.conf`                              | Proxy ACLs, ports, caching                            |
| `/etc/named.conf`                                    | BIND DNS global config                                |
| `/etc/dhcp/dhcpd.conf`                               | ISC-DHCP server config                                |
| `/etc/apt/sources.list`                              | APT repository list (Debian/Ubuntu)                   |
| `/etc/yum.repos.d/`                                  | YUM repository configs (RHEL/CentOS)                  |
| `/var/log/auth.log` / `/var/log/secure`              | Authentication logs (SSH, sudo)                       |
| `/var/log/messages` / `/var/log/syslog`              | General system logs                                   |
| `/var/log/journal/`                                  | systemd journal logs                                  |
=======
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

<<<<<<< Updated upstream
/var/log
=======
/var/log
>>>>>>> cf1495547c7c71ef277e9456d70815447516f1b7
>>>>>>> Stashed changes
