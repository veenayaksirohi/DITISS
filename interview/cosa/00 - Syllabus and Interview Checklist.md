---
title: 00 - Syllabus and Interview Checklist
aliases:
  - Syllabus and Interview Checklist
  - linux_os_interview_priority
  - Linux OS and Security CDAC DITISS Revision Checklist
  - A2 - OS Administration Syllabus and Interview Checklist
  - OS Administration Syllabus and Interview Checklist
  - 02 - OS Administration Syllabus and Interview Checklist
  - Concept of Operating Systems and Administration — CDAC DITISS Syllabus
tags:
  - linux
  - operating-systems
  - windows
  - syllabus
  - checklist
  - moc
  - interview-preparation
syllabus-topic: []
---

> Navigation: [[Index]]

## Note Availability Map

1. Linux Filesystem & Core Commands — **Distributed complete coverage:** [[01A - Linux Filesystem and File Types|Linux Filesystem and File Types]], [[01B - Linux Core Commands|Linux Core Commands]], [[01C - Linux File Links|Linux File Links]], [[07 - Disk Management and Filesystem Partition Layout|Filesystem Partition Layout]]
2. File Permissions, Ownership & ACLs — **Distributed complete coverage:** [[01A - Linux Filesystem and File Types|Linux Filesystem and File Types]], [[02A - File Permissions Ownership and ACLs|File Permissions, Ownership and ACLs]], [[02B - Special Permission Bits|Special Permission Bits]]
3. User & Group Management — **Complete coverage:** [[03 - User and Group Management|User and Group Management]]
4. Linux Boot Process & Systemd — **Complete coverage:** [[04 - Linux Boot Process and Systemd|Linux Boot Process and Systemd]]
5. Package & Repository Management — **Unavailable:** No dedicated note provided.
6. SSH & Remote Access Security — **Partial coverage:** [[16 - LDAP and NIS Authentication|SSH Key Exchange appendix]]
7. Disk Management & LVM — **Partial coverage:** [[07 - Disk Management and Filesystem Partition Layout|Disk Management and Filesystem Partition Layout]]
8. Core Infrastructure Services — **Distributed partial coverage:** [[08A - Core Infrastructure Services - DNS|DNS]], [[08B - Core Infrastructure Services - DHCP|DHCP]], [[08C - Core Infrastructure Services - File Sharing Protocols|File Sharing Protocols]], [[15 - Email Services - Postfix and Dovecot|Mail Services (MX support)]]
9. Apache Web Server Security — **Unavailable:** No dedicated note provided.
10. Logging, Monitoring & NTP — **Distributed partial coverage:** [[01B - Linux Core Commands|Linux Core Commands]], [[03 - User and Group Management|User and Group Management]], [[04 - Linux Boot Process and Systemd|Linux Boot Process and Systemd]]
11. Bash Scripting & Automation — **Distributed partial coverage:** [[02A - File Permissions Ownership and ACLs|File Permissions and Cron Risk]], [[12A - Interprocess Communication and Process Internals|Shell Redirection and Pipes]]
12. Interprocess Communication (IPC) — **Distributed partial coverage:** [[01A - Linux Filesystem and File Types|FIFO and Socket File Types]], [[01B - Linux Core Commands|Process Commands and Signals]], [[12A - Interprocess Communication and Process Internals|Interprocess Communication and Process Internals]], [[12B - User Space and Kernel Space|User Space and Kernel Space]]
13. Patch & Update Management — **Unavailable:** No dedicated note provided.
14. Service Management & System Config Files — **Distributed partial coverage:** [[03 - User and Group Management|User and Group Management]], [[04 - Linux Boot Process and Systemd|Linux Boot Process and Systemd]]
15. Email Services — Postfix, Dovecot — **Distributed partial coverage:** [[08A - Core Infrastructure Services - DNS|DNS (MX records)]], [[15 - Email Services - Postfix and Dovecot|Email Services - Postfix and Dovecot]]
16. LDAP & NIS Authentication — **Complete coverage:** [[16 - LDAP and NIS Authentication|LDAP and NIS Authentication]]
17. Squid Proxy — **Unavailable:** No dedicated note provided.
18. Virtual Machine Management — **Unavailable:** No dedicated note provided.
19. NIS, Print Services & NFS Advanced — **Distributed partial coverage:** [[01B - Linux Core Commands|Linux Core Commands]], [[08C - Core Infrastructure Services - File Sharing Protocols|File Sharing Protocols]], [[16 - LDAP and NIS Authentication|LDAP and NIS Authentication]]
20. Kickstart Unattended Installation — **Partial coverage:** [[08C - Core Infrastructure Services - File Sharing Protocols|PXE and TFTP]]
21. X Window System & Performance Tuning — **Distributed partial coverage:** [[01B - Linux Core Commands|Linux Core Commands]], [[04 - Linux Boot Process and Systemd|Linux Boot Process and Systemd]]
22. BIND DNS Security (Advanced) — **Unavailable:** No dedicated note provided.

## Supplemental Notes

- [[A1 - HAProxy Web Server Path|HAProxy Web Server Path]] — Not part of a numbered syllabus topic.

---

# Linux OS & Security — CDAC DITISS Revision Checklist

**Tick off each item as you revise/master it. Priority-ordered for exam prep.**

---

## 🔴 PRIORITY 1 — MUST KNOW

### 1. Linux Filesystem & Core Commands

- [x] FHS layout — `/etc`, `/var`, `/home`, `/proc`, `/tmp`, `/usr`, `/bin`
- [x] FHS details — `/boot`, `/dev`, `/lib`, `/media`, `/mnt`, `/opt`, `/sbin`, `/srv`, `/usr/local`
- [ ] Linux file types — regular file, directory, symlink, block device, character device, FIFO, socket
- [x] `ls`, `cp`, `mv`, `rm`, `cat`, `grep`, `find`, `diff`, `wc`, `sort`, `head`, `tail`
- [x] Common command flags — `ls -lah`, `cp -rp`, `mv -i`, `rm -rf`, `grep -rn`, `find -type/-name/-size/-mtime/-exec`
- [x] Archive/compression — `tar -czvf`/`-xzvf`, `gzip`, `gunzip`, `zip`, `unzip`, `zcat`
- [x] Process commands — `ps`, `top`, `kill`, `jobs`, `bg`, `fg`, `nohup`
- [x] Process extras — `killall`, `htop`, `top` keys for kill/quit
- [x] Hard link vs soft link — inode behavior, `ln` vs `ln -s`, cross-filesystem restriction
- [x] `man`, `whatis`, `whereis`, `locate`, `updatedb` vs `find`

### 2. File Permissions, Ownership & ACLs

- [x] Symbolic (`rwx`) vs octal (`755`, `644`) notation
- [x] `chmod`, `chown`, `chgrp` — syntax + recursive use
- [x] SUID (4), SGID (2), Sticky bit (1) — use cases & risks
- [x] Sticky bit on `/tmp` — only owner/root can delete/rename
- [ ] `umask` — default mask, `umask 022`
- [ ] ACL — `setfacl`, `getfacl` vs traditional permissions
- [ ] ACL `mask` entry — effective permission limiter
- [ ] World-writable file risk — `find / -perm -o+w`

### 3. User & Group Management

- [ ] `useradd`, `adduser`, `usermod`, `userdel`, `groupadd`, `addgroup`, `groupmod`, `groupdel`, `gpasswd`
- [ ] `passwd`, `chage`, `id`, `groups`, `who`, `whoami`, `last`
- [ ] `/etc/passwd` format — `username:x:UID:GID:comment:home:shell`
- [ ] `/etc/shadow` — hash, aging, `!` = locked
- [ ] `/etc/group` — `group_name:x:GID:member_list`
- [ ] `su` vs `sudo` — target password vs own password
- [ ] `su -` vs `su` — full login shell vs current environment
- [ ] `/etc/sudoers` & `visudo` — `%wheel ALL=(ALL) ALL`, `NOPASSWD`
- [ ] Primary vs supplementary groups — `id`, `groups`, `newgrp`

### 4. Linux Boot Process & Systemd

- [ ] Full boot sequence: BIOS/UEFI → MBR/GPT → GRUB2 → Kernel → initramfs → systemd → Target → Login
- [ ] GRUB2 — `grub.cfg` location, rescue mode, `GRUB_TIMEOUT`
- [ ] `initramfs` purpose — `dracut`, `pivot_root`
- [ ] Runlevels vs systemd targets (0/1/3/5/6 mapping)
- [ ] `systemctl start/stop/restart/enable/disable/status/is-enabled/daemon-reload`
- [ ] `start` vs `enable` distinction
- [ ] Live troubleshooting basics — `journalctl`, `top`, `htop`

### 5. Package & Repository Management

- [ ] RPM — `rpm -ivh`, `-Uvh`, `-e`, `-qa`, `-ql`
- [ ] DEB — `dpkg -i`, `-r`, `-l`
- [ ] `yum`/`dnf` (RHEL) vs `apt`/`apt-get` (Debian)
- [ ] Repo config — `/etc/yum.repos.d/`, `/etc/apt/sources.list`, GPG verification
- [ ] `yum --security update`

### 6. SSH & Remote Access Security

- [ ] Key `sshd_config` directives — `PermitRootLogin no`, `PasswordAuthentication no`, `MaxAuthTries`, `AllowUsers`, `Port`, `ClientAliveInterval`
- [ ] SSH key-based auth — `ssh-keygen` → `~/.ssh/authorized_keys`
- [ ] SSH vs Telnet — encrypted vs plaintext
- [ ] SFTP vs FTP — port 22 vs port 21
- [ ] `~/.ssh/known_hosts` — fingerprint verification, TOFU model

### 7. Disk Management & LVM

- [ ] `fdisk` (MBR) vs `gdisk` (GPT)
- [ ] LVM pipeline — PV → VG → LV (`pvcreate` → `vgcreate` → `lvcreate` → `mkfs` → `mount`)
- [ ] LVM snapshots — Copy-on-Write (COW)
- [ ] `df -h`, `du -sh`, `lsblk`, `blkid`, `mount`, `/etc/fstab` (UUID-based)
- [ ] RAID levels 0/1/5/6/10 — min disks, fault tolerance, use case

### 8. Core Infrastructure Services

- [ ] DNS record types — A, AAAA, MX, CNAME, PTR, NS, SOA, TXT
- [ ] Forward vs reverse zone, `/etc/named.conf`
- [ ] `/etc/resolv.conf`, `/etc/nsswitch.conf` resolution order
- [ ] Zone transfer (AXFR) abuse & `allow-transfer { none; };`
- [ ] DNS attacks — cache poisoning, amplification, unauthorized AXFR
- [ ] DHCP DORA process (Discover → Offer → Request → Acknowledge)
- [ ] `dhcpd.conf` — `subnet`, `range`, `default-lease-time`, `option routers`
- [ ] DHCP starvation attack & DHCP snooping
- [ ] NFS `/etc/exports` — `rw`, `ro`, `root_squash`, `no_root_squash`
- [ ] `no_root_squash` danger
- [ ] Samba `smb.conf` — `[share]`, `valid users`, `writable`, `path`
- [ ] Samba vs NFS use case, ports 445/139

### 9. Apache Web Server Security

- [ ] Config files — `httpd.conf` (RHEL) vs `apache2.conf` (Debian)
- [ ] `DocumentRoot`, `VirtualHost`, `Directory` blocks, `.htaccess`
- [ ] Name-based vs IP-based virtual hosting
- [ ] Hardening directives — `Options -Indexes`, `ServerTokens Prod`, `ServerSignature Off`, `TraceEnable Off`, `X-Frame-Options`
- [ ] `mod_ssl`, `mod_rewrite`, `mod_security`
- [ ] `a2enmod` / `a2dismod`

### 10. Logging, Monitoring & NTP

- [ ] Key logs — `auth.log`/`secure`, `syslog`/`messages`, `kern.log`, `dmesg`, `cron`, `access.log`
- [ ] `rsyslog` facility + severity levels (0=emerg to 7=debug)
- [ ] `journalctl -u sshd -f`, `--since`, `-p err`
- [ ] `logrotate` — `/etc/logrotate.conf`, `rotate`, `compress`, `daily`
- [ ] NTP (port 123/UDP) — `ntpd` vs `chronyd`
- [ ] NTP amplification attack (monlist abuse)
- [ ] `tail -f` for live log monitoring
- [ ] Delayed breach detection risk — unmonitored logs

### 11. Bash Scripting & Automation

- [ ] Shebang, variable quoting — `"$var"` vs `'$var'`
- [ ] Conditionals — `if [ ]` vs `if [[ ]]`
- [ ] Loops — `for`, `while read`, `until`
- [ ] Functions & `local` variables
- [ ] Error handling — `$?`, `set -e`, `trap`
- [ ] Redirection — `>`, `>>`, `2>&1`, `/dev/null`
- [ ] `grep -E`, `sed`, `awk` for regex/field extraction
- [ ] Crontab field format (min/hour/day/month/weekday)
- [ ] Bash as attack vector — world-writable cron, PATH hijacking

### 12. Interprocess Communication (IPC)

- [ ] IPC definition — processes sharing data & synchronizing
- [ ] Pipes & named pipes (FIFO)
- [ ] Signals — `kill`, `pkill`, `SIGTERM`, `SIGKILL`, `SIGINT`, `SIGCHLD`
- [ ] Shared memory
- [ ] Semaphores — mutual exclusion
- [ ] Message queues
- [ ] Sockets — local & network
- [ ] `ps`, `ipcs`, `ipcrm`, `lsof`

---

## 🟠 PRIORITY 2 — IMPORTANT

### 13. Patch & Update Management

- [ ] `yum update --security` vs `apt upgrade`
- [ ] Unattended upgrades — auto-patch, reboot risk
- [ ] LVM snapshot before patching — rollback
- [ ] `journalctl` + `auditd` for patch tracking
- [ ] Unpatched service risk — CVE exposure, lateral movement

### 14. Service Management & System Config Files

- [ ] Systemd unit file sections — `[Unit]`, `[Service]`, `[Install]`
- [ ] Key files — `/etc/hostname`, `/etc/hosts`, `/etc/resolv.conf`, `/etc/nsswitch.conf`, `/etc/fstab`, `/etc/crontab`, `/etc/ssh/sshd_config`, `/etc/sudoers`
- [ ] `systemctl list-units --failed`

### 15. Email Services — Postfix, Dovecot

- [ ] Ports — SMTP 25/587, IMAP 143/993, POP3 110/995
- [ ] Delivery chain — MUA → Postfix (MTA) → Internet → Remote MTA → Dovecot (MDA) → MUA
- [ ] Postfix `main.cf` — `myhostname`, `mydestination`, `smtpd_relay_restrictions`
- [ ] Open relay danger
- [ ] SPF, DKIM, DMARC — anti-spoofing DNS records

### 16. LDAP & NIS Authentication

- [ ] LDAP ports 389 (plain) / 636 (LDAPS)
- [ ] DN structure — `cn=user,ou=users,dc=cdac,dc=in`
- [ ] LDAP auth flow — bind DN → search → compare hash
- [ ] LDAP vs NIS comparison (security, structure, status, port)

### 17. Squid Proxy

- [ ] Port 3128, `squid.conf`, ACL-based access control
- [ ] Forward proxy vs reverse proxy
- [ ] Content filtering & caching

### 18. Virtual Machine Management

- [ ] KVM (Type-1) vs VirtualBox (Type-2)
- [ ] VM network modes — NAT, Bridged, Host-Only
- [ ] `virsh list`, `virsh start`, `virsh snapshot-create`
- [ ] VM escape risk
- [ ] Isolation — VLANs + resource limits per VM

---

## 🟡 PRIORITY 3 — GOOD TO KNOW

### 19. NIS, Print Services & NFS Advanced

- [ ] NIS commands — `ypbind`, `ypcat`, `ypmatch` (legacy, prefer LDAP)
- [ ] CUPS — web UI at `localhost:631`
- [ ] NFSv4 vs NFSv3 — single port 2049, Kerberos support in v4
- [ ] `locate` index refresh — `updatedb` and why results can lag behind the filesystem

### 20. Kickstart Unattended Installation

- [ ] `ks.cfg` — `%packages`, `%post`, `%pre` sections
- [ ] PXE + TFTP + DHCP deployment
- [ ] Automation risk — hardcoded credentials, no post-install hardening

### 21. X Window System & Performance Tuning

- [ ] `DISPLAY` variable, Xorg, `startx`
- [ ] `top`, `htop`, `vmstat`, `iostat`, `sar`
- [ ] `ulimit` — per-user/process resource limits

### 22. BIND DNS Security (Advanced)

- [ ] DNSSEC — zone signing, trust chain
- [ ] `allow-recursion { trusted; };` — prevent open resolver abuse
- [ ] Response Rate Limiting (RRL)
- [ ] Split-horizon DNS — internal vs external views

---

## 📌 CASE STUDIES — Attack Vector → Prevention

- [ ] Privilege escalation via file permissions → `find / -perm -4000`, remove unneeded SUID
- [ ] Unauthorized SSH access → `PermitRootLogin no`, key-auth, `fail2ban`
- [ ] Data loss from poor disk/patch mgmt → `yum --security update`, LVM snapshot pre-patch
- [ ] Web server compromise (Apache) → `Options -Indexes`, `mod_security`, `ServerTokens Prod`
- [ ] DNS zone transfer abuse (AXFR) → `allow-transfer { none; };`
- [ ] Delayed breach detection → centralized logging via `rsyslog`/SIEM, `auditd`, `fail2ban`
- [ ] Postfix open relay → restrict relay, add SPF/DKIM/DMARC
- [ ] Bash script attack vector → `chmod 700 script.sh`, absolute paths in scripts

---

## 📌 PORTS & SERVICES — Memorize These

- [ ] 20/21 FTP (plaintext — avoid)
- [ ] 22 SSH/SFTP (encrypted)
- [ ] 23 Telnet (plaintext — never use)
- [ ] 25 SMTP (open relay risk)
- [ ] 53 DNS (TCP for zone transfer)
- [ ] 67/68 DHCP server/client
- [ ] 80 HTTP / 443 HTTPS
- [ ] 110 POP3 / 995 POP3S
- [ ] 111 RPC/portmapper (NFS dependency)
- [ ] 123 NTP (amplification risk)
- [ ] 143 IMAP / 993 IMAPS
- [ ] 389 LDAP / 636 LDAPS
- [ ] 445 SMB/Samba
- [ ] 514 Syslog
- [ ] 587 SMTP submission (authenticated)
- [ ] 631 CUPS
- [ ] 2049 NFS (v4 unified)
- [ ] 3128 Squid proxy
- [ ] 5900 VNC (unencrypted)

---

## 📌 TOP 12 INTERVIEW TRAPS — Self-Test

- [ ] Can explain why `chmod 777` is dangerous
- [ ] Can explain `no_root_squash` risk in NFS
- [ ] Can explain why `PermitRootLogin yes` is a fail
- [ ] Can justify SSH/SFTP over Telnet/FTP
- [ ] Can explain open SMTP relay risk
- [ ] Can explain SUID on scripts (ignored) vs binaries (exploitable)
- [ ] Can explain risk of world-readable `/etc/shadow`
- [ ] Can explain unrestricted DNS AXFR risk
- [ ] Can explain world-writable cron script risk
- [ ] Can explain why unsynced NTP breaks forensic log analysis
- [ ] Can explain `start` vs `enable` in systemctl
- [ ] Can explain `su -` vs `su` (environment loading)

---

## 📋 SESSION-WISE COVERAGE TRACKER

- [ ] Session 1–2: Filesystem, core commands, links, permissions, sticky bit, umask, ACLs, network commands
- [ ] Session 3–4: Installation, boot process, GRUB, initramfs, runlevels/targets, RPM/DEB
- [ ] Session 5: Kickstart, user administration
- [ ] Session 6: IPv4/IPv6, SSH, VNC, network authentication
- [ ] Session 7: User/group management, sudoers
- [ ] Session 8: Disk management, fdisk/gdisk, LVM, RAID
- [ ] Session 9: Network implementation, CUPS
- [ ] Session 10: systemctl, key config files, NIS
- [ ] Session 11: Patch management, tuning, X server config
- [ ] Session 12: IPC — pipes, signals, shared memory, semaphores, queues, sockets
- [ ] Session 13: DNS (BIND9, named, zone files)
- [ ] Session 14: NFS server, FTP server (vsftpd)
- [ ] Session 15: Samba, DHCP, DNS combined
- [ ] Session 16: Apache, virtual hosting, Squid proxy
- [ ] Session 17: Postfix, Dovecot, SquirrelMail
- [ ] Session 18: Performance tuning, troubleshooting, threat model
- [ ] Session 19: Basic service security, rsyslog, NTP, BIND security
- [ ] Session 20: LDAP, NIS, Apache clustering/load balancing, NTP server
- [ ] Session 21: VM management, VM networking
- [ ] Session 22–23: Bash scripting — CLI, control structures, loops, variables, regex
- [ ] Session 24: Bash automation, security patch scripting
- [ ] Session 25: Logging & monitoring via bash scripts
- [ ] Session 26: Case studies, forensic log analysis, automation as attack vector

---

_CDAC DITISS — PGCP-ITISS | Linux OS & Security | Feb 2026_
_Total: 50T + 50L + 15SL = 115 hrs_

---

## Concept of Operating Systems & Administration — Interview Checklist

**Duration:** 210 hrs (90T + 90L + 30SL) | **CMCE Module**
**Courseware:** Linux All-In-One for Dummies (Dulaney); Mastering Windows Server 2016 R2; Windows Server 2022 Administration Fundamentals

---

### Completion Checklist

- [ ] Windows OS architecture & installation
- [ ] Active Directory (ADDS, DC, ADC, OU)
- [ ] DNS / DHCP / IPAM
- [ ] Group Policy & Local Policy
- [ ] IIS, DFS, Hyper-V
- [ ] WSB / FSRM / NPS / NLB / WDS
- [ ] Exchange Server, PowerShell
- [ ] Linux fundamentals & file system
- [ ] Linux installation, boot process, GRUB
- [ ] User/Group management, SSH, disk management (LVM)
- [ ] Network services: NFS, FTP, Samba, DNS, DHCP
- [ ] Apache, Squid, Postfix/Dovecot mail stack
- [ ] Patch management, LDAP/NIS
- [ ] BASH scripting & automation

---

### 🔴 Priority 1 — Must Know

- [ ] Windows OS architecture — kernel mode vs user mode, installation/upgrade/migration types
- [ ] Active Directory — DC, ADC, ADDS, Domain, OU, replication (authoritative vs non-authoritative restore)
- [ ] DNS, DHCP, IPAM concepts and configuration
- [ ] Linux file system, permissions (chmod/chown/ACL), boot process (GRUB, initramfs, runlevels)
- [ ] User & Group management, SSH key-based auth vs password auth
- [ ] Disk management — MBR vs GPT, LVM, RAID basics
- [ ] Windows Server Backup (WSB) — Full/Incremental/System State

### 🟠 Priority 2 — Important

- [ ] Group Policy / Local Policy — default vs custom GPO
- [ ] IIS Web Server — attack surface, hardening
- [ ] DFS, Branch Office solutions
- [ ] Hyper-V — install/configure, VM settings, security concerns
- [ ] Samba, NFS, FTP, Apache (virtual hosting, security), Squid proxy
- [ ] Postfix/Dovecot mail stack (e-mail delivery concepts)
- [ ] Patch management & service lifecycle (systemctl)
- [ ] Kickstart automation, YUM/RPM vs DEB package management

### 🟡 Priority 3 — Good to Know

- [ ] FSRM, NPS, NLB, WDS
- [ ] Exchange Server basics
- [ ] PowerShell scripting, error handling, background jobs, remote administration
- [ ] BASH CLI scripting — loops, variables, regex, automation, logging
- [ ] LDAP/NIS network authentication, Apache clustering/load balancing

---

### 📌 Interview Case Studies to Know

| Scenario | Root Cause | Key Learning |
|---|---|---|
| Ransomware on Windows server | Missing/failed backups | Importance of System State backup |
| AD compromise | Weak DNS + excessive privileges | Least privilege, authoritative vs non-authoritative restore |
| Unauthorized server access | Weak SSH config | Key-based auth > password, disable root login |
| Privilege escalation | World-writable files, bad /etc/passwd perms | File permission hygiene |
| Web server compromise | Weak Apache config | Virtual host isolation, disable directory listing |

### 📌 Windows Registry Hives Quick Reference

| Hive | Purpose |
|---|---|
| SAM | Local user account & password hashes |
| SYSTEM | Hardware/driver/service config |
| SOFTWARE | Installed software settings |
| SECURITY | Local security policy |
| NTUSER.DAT | Per-user profile settings |

### 📌 Linux Boot Sequence

BIOS/UEFI → Bootloader (GRUB) → Kernel + Initial RAM Disk → systemd/init → Runlevel/Target → Login

---

> Back to [[Index|Linux OS and Security Notes Index]]
