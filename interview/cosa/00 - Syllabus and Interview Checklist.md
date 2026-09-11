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

# Concept of OS & Administration — CDAC DITISS

## Course Duration

Linux track: 50T+50L+15SL=115hrs · Windows+Linux combined module: 90T+90L+30SL=210hrs

## Note Availability Map

| #   | Topic                              | Coverage                  | Notes                                                                                                                                                                                                                   |
| --- | ---------------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| 1   | Linux Filesystem & Core Commands   | ✅ Complete (distributed) | [[01A - Linux Filesystem and File Types]], [[01B - Linux Core Commands]], [[01C - Linux File Links]], [[01D - Linux Filesystem and File Types PDF Reference]], [[07 - Disk Management and Filesystem Partition Layout]] |
| 2   | File Permissions, Ownership & ACLs | ✅ Complete (distributed) | [[01A - Linux Filesystem and File Types]], [[01D - Linux Filesystem and File Types PDF Reference]], [[02A - File Permissions Ownership and ACLs]], [[02B - Special Permission Bits]]                                    |
| 3   | User & Group Management            | ✅ Complete               | [[03 - User and Group Management]]                                                                                                                                                                                      |
| 4   | Linux Boot Process & Systemd       | ✅ Complete               | [[04 - Linux Boot Process and Systemd]]                                                                                                                                                                                 |
| 5   | Package & Repository Management    | ❌ None                   | —                                                                                                                                                                                                                       |
| 6   | SSH & Remote Access Security       | 🟡 Partial                | [[16 - LDAP and NIS Authentication                                                                                                                                                                                      | SSH Key Exchange appendix]]                                           |
| 7   | Disk Management & LVM              | 🟡 Partial                | [[07 - Disk Management and Filesystem Partition Layout]]                                                                                                                                                                |
| 8   | Core Infrastructure Services       | 🟡 Partial (distributed)  | [[08A - Core Infrastructure Services - DNS]], [[08B - Core Infrastructure Services - DHCP]], [[08C - Core Infrastructure Services - File Sharing Protocols]], [[15 - Email Services - Postfix and Dovecot               | Mail (MX support)]]                                                   |
| 9   | Apache Web Server Security         | ❌ None                   | —                                                                                                                                                                                                                       |
| 10  | Logging, Monitoring & NTP          | 🟡 Partial (distributed)  | [[01B - Linux Core Commands]], [[03 - User and Group Management]], [[04 - Linux Boot Process and Systemd]]                                                                                                              |
| 11  | Bash Scripting & Automation        | 🟡 Partial (distributed)  | [[02A - File Permissions Ownership and ACLs                                                                                                                                                                             | Cron Risk]], [[12A - Interprocess Communication and Process Internals | Redirection/Pipes]]                                                      |
| 12  | Interprocess Communication (IPC)   | 🟡 Partial (distributed)  | [[01A - Linux Filesystem and File Types                                                                                                                                                                                 | FIFO/Socket]], [[01B - Linux Core Commands                            | Process/Signals]], [[01D - Linux Filesystem and File Types PDF Reference | FHS file types]], [[12A - Interprocess Communication and Process Internals]], [[12B - User Space and Kernel Space]] |
| 13  | Patch & Update Management          | ❌ None                   | —                                                                                                                                                                                                                       |
| 14  | Service Mgmt & System Config Files | 🟡 Partial                | [[03 - User and Group Management]], [[04 - Linux Boot Process and Systemd]]                                                                                                                                             |
| 15  | Email Services — Postfix, Dovecot  | 🟡 Partial                | [[08A - Core Infrastructure Services - DNS                                                                                                                                                                              | DNS MX]], [[15 - Email Services - Postfix and Dovecot]]               |
| 16  | LDAP & NIS Authentication          | ✅ Complete               | [[16 - LDAP and NIS Authentication]]                                                                                                                                                                                    |
| 17  | Squid Proxy                        | ❌ None                   | —                                                                                                                                                                                                                       |
| 18  | Virtual Machine Management         | ❌ None                   | —                                                                                                                                                                                                                       |
| 19  | NIS, Print Services & NFS Advanced | 🟡 Partial                | [[01B - Linux Core Commands]], [[08C - Core Infrastructure Services - File Sharing Protocols]], [[16 - LDAP and NIS Authentication]]                                                                                    |
| 20  | Kickstart Unattended Install       | 🟡 Partial                | [[08C - Core Infrastructure Services - File Sharing Protocols                                                                                                                                                           | PXE/TFTP]]                                                            |
| 21  | X Window System & Perf Tuning      | 🟡 Partial                | [[01B - Linux Core Commands]], [[04 - Linux Boot Process and Systemd]]                                                                                                                                                  |
| 22  | BIND DNS Security (Advanced)       | ❌ None                   | —                                                                                                                                                                                                                       |

**Supplemental:** [[A1 - HAProxy Web Server Path|HAProxy Web Server Path]] (not part of numbered syllabus)

---

## 🔴 Priority 1 — Must Know

### 1. Filesystem & Core Commands

- [x] FHS: `/etc /var /home /proc /tmp /usr /bin` + `/boot /dev /lib /media /mnt /opt /sbin /srv /usr/local`
- [x] File types — regular, directory, symlink, block, char, FIFO, socket
- [x] Core cmds: `ls cp mv rm cat grep find diff wc sort head tail` + flags (`-lah -rp -i -rf -rn -type/-name/-size/-mtime/-exec`)
- [x] Archives: `tar -czvf/-xzvf`, `gzip/gunzip`, `zip/unzip`, `zcat`
- [x] Process cmds: `ps top kill jobs bg fg nohup` + `killall`, `htop`
- [x] Hard vs soft link — inode behavior, `ln` vs `ln -s`, cross-fs restriction
- [x] `man whatis whereis locate updatedb` vs `find`

### 2. Permissions, Ownership & ACLs

- [x] Symbolic (`rwx`) vs octal (`755/644`)
- [x] `chmod chown chgrp` (+ recursive)
- [x] SUID(4)/SGID(2)/Sticky(1) — use cases & risks; sticky bit on `/tmp`
- [x] `umask` (e.g. `022`)
- [x] `setfacl`/`getfacl` vs traditional perms; ACL `mask` entry
- [x] World-writable risk: `find / -perm -o+w`

### 3. User & Group Management

- [x] `useradd/adduser/usermod/userdel`, `groupadd/addgroup/groupmod/groupdel`, `gpasswd`
- [x] `passwd chage id groups who whoami last`
- [x] `/etc/passwd` → `user:x:UID:GID:comment:home:shell`
- [x] `/etc/shadow` — hash, aging, `!`=locked
- [x] `/etc/group` → `name:x:GID:members`
- [x] `su` vs `sudo` (target pw vs own pw); `su -` vs `su` (full login env vs current)
- [x] `/etc/sudoers` & `visudo` — `%wheel ALL=(ALL) ALL`, `NOPASSWD`
- [x] Primary vs supplementary groups — `id groups newgrp`

### 4. Boot Process & Systemd

- [x] Sequence: BIOS/UEFI → MBR/GPT → GRUB2 → Kernel → initramfs → systemd → Target → Login
- [x] GRUB2 — `grub.cfg`, rescue mode, `GRUB_TIMEOUT`
- [x] `initramfs` purpose — `dracut`, `pivot_root`
- [x] Runlevels ↔ systemd targets (0/1/3/5/6)
- [x] `systemctl start/stop/restart/enable/disable/status/is-enabled/daemon-reload` — **`start` ≠ `enable`**
- [x] Troubleshooting: `journalctl`, `top`, `htop`

### 5. Package & Repository Management

- [ ] RPM: `rpm -ivh/-Uvh/-e/-qa/-ql` · DEB: `dpkg -i/-r/-l`
- [ ] `yum/dnf` (RHEL) vs `apt/apt-get` (Debian)
- [ ] Repo config — `/etc/yum.repos.d/`, `/etc/apt/sources.list`, GPG verification
- [ ] `yum --security update`

### 6. SSH & Remote Access Security

- [ ] `sshd_config`: `PermitRootLogin no`, `PasswordAuthentication no`, `MaxAuthTries`, `AllowUsers`, `Port`, `ClientAliveInterval`
- [ ] Key auth — `ssh-keygen` → `~/.ssh/authorized_keys`
- [ ] SSH vs Telnet (encrypted vs plaintext); SFTP(22) vs FTP(21)
- [ ] `~/.ssh/known_hosts` — fingerprint verification, TOFU model

### 7. Disk Management & LVM

- [ ] `fdisk`(MBR) vs `gdisk`(GPT)
- [ ] LVM: PV→VG→LV (`pvcreate→vgcreate→lvcreate→mkfs→mount`)
- [ ] LVM snapshots — Copy-on-Write
- [ ] `df -h du -sh lsblk blkid mount`, `/etc/fstab` (UUID-based)
- [ ] RAID 0/1/5/6/10 — min disks, fault tolerance, use case

### 8. Core Infrastructure Services

- [x] DNS records: A, AAAA, MX, CNAME, PTR, NS, SOA, TXT
- [x] Forward vs reverse zone, `/etc/named.conf`
- [x] `/etc/resolv.conf`, `/etc/nsswitch.conf` resolution order
- [x] AXFR abuse → `allow-transfer { none; };`
- [x] DNS attacks — cache poisoning, amplification, unauthorized AXFR
- [x] DHCP DORA (Discover→Offer→Request→Acknowledge); `dhcpd.conf` (`subnet range default-lease-time option routers`)
- [x] DHCP starvation attack & snooping
- [x] NFS `/etc/exports` — `rw ro root_squash no_root_squash` (danger of `no_root_squash`)
- [x] Samba `smb.conf` — `[share] valid users writable path`; Samba vs NFS, ports 445/139

### 9. Apache Web Server Security

- [ ] `httpd.conf`(RHEL) vs `apache2.conf`(Debian)
- [ ] `DocumentRoot`, `VirtualHost`, `Directory` blocks, `.htaccess`
- [ ] Name-based vs IP-based vhosting
- [ ] Hardening: `Options -Indexes`, `ServerTokens Prod`, `ServerSignature Off`, `TraceEnable Off`, `X-Frame-Options`
- [ ] `mod_ssl mod_rewrite mod_security`; `a2enmod/a2dismod`

### 10. Logging, Monitoring & NTP

- [ ] Logs: `auth.log`/`secure`, `syslog`/`messages`, `kern.log`, `dmesg`, `cron`, `access.log`
- [ ] `rsyslog` facility+severity (0=emerg → 7=debug)
- [ ] `journalctl -u sshd -f`, `--since`, `-p err`
- [ ] `logrotate` — `/etc/logrotate.conf` (`rotate compress daily`)
- [ ] NTP (123/UDP) — `ntpd` vs `chronyd`; amplification attack (monlist)
- [ ] `tail -f`; unmonitored-log breach-detection risk

### 11. Bash Scripting & Automation

- [ ] Shebang; `"$var"` vs `'$var'`
- [ ] `if [ ]` vs `if [[ ]]`; loops `for/while read/until`; functions & `local`
- [ ] Error handling — `$? set -e trap`
- [ ] Redirection — `> >> 2>&1 /dev/null`
- [ ] `grep -E`, `sed`, `awk`
- [ ] Crontab fields (min hour day month weekday)
- [ ] Attack vectors — world-writable cron, PATH hijacking

### 12. Interprocess Communication (IPC)

- [x] Definition — processes sharing data & synchronizing
- [x] Pipes & named pipes (FIFO)
- [x] Signals — `kill pkill SIGTERM SIGKILL SIGINT SIGCHLD`
- [x] Shared memory · Semaphores (mutual exclusion) · Message queues · Sockets (local/network)
- [x] `ps ipcs ipcrm lsof`

---

## 🟠 Priority 2 — Important

### 13. Patch & Update Management

- [ ] `yum update --security` vs `apt upgrade`
- [ ] Unattended upgrades — auto-patch/reboot risk
- [ ] LVM snapshot pre-patch → rollback
- [ ] `journalctl` + `auditd` patch tracking
- [ ] Unpatched service risk — CVE exposure, lateral movement

### 14. Service Management & System Config Files

- [ ] Unit file sections — `[Unit] [Service] [Install]`
- [ ] Key files: `/etc/hostname /etc/hosts /etc/resolv.conf /etc/nsswitch.conf /etc/fstab /etc/crontab /etc/ssh/sshd_config /etc/sudoers`
- [ ] `systemctl list-units --failed`

### 15. Email Services — Postfix, Dovecot

- [x] Ports: SMTP 25/587, IMAP 143/993, POP3 110/995
- [x] Chain: MUA → Postfix(MTA) → Internet → Remote MTA → Dovecot(MDA) → MUA
- [x] `main.cf` — `myhostname mydestination smtpd_relay_restrictions`
- [x] Open relay danger; SPF/DKIM/DMARC anti-spoofing

### 16. LDAP & NIS Authentication

- [x] Ports 389 (plain) / 636 (LDAPS)
- [x] DN structure — `cn=user,ou=users,dc=cdac,dc=in`
- [x] Bind DN → search → compare hash
- [x] LDAP vs NIS (security, structure, status, port)

### 17. Squid Proxy

- [ ] Port 3128, `squid.conf`, ACL-based access control
- [ ] Forward vs reverse proxy; content filtering & caching

### 18. Virtual Machine Management

- [ ] KVM (Type-1) vs VirtualBox (Type-2)
- [ ] Network modes — NAT, Bridged, Host-Only
- [ ] `virsh list/start/snapshot-create`
- [ ] VM escape risk; isolation via VLANs + resource limits

---

## 🟡 Priority 3 — Good to Know

### 19. NIS, Print Services & NFS Advanced

- [ ] NIS legacy: `ypbind ypcat ypmatch` (prefer LDAP)
- [ ] CUPS — `localhost:631`
- [ ] NFSv4 vs NFSv3 — single port 2049, Kerberos in v4
- [ ] `updatedb`/`locate` lag vs `find`

### 20. Kickstart Unattended Installation

- [ ] `ks.cfg` — `%packages %post %pre`
- [ ] PXE + TFTP + DHCP deployment
- [ ] Risk — hardcoded creds, no post-install hardening

### 21. X Window System & Performance Tuning

- [ ] `DISPLAY` var, Xorg, `startx`
- [ ] `top htop vmstat iostat sar`
- [ ] `ulimit` — per-user/process resource limits

### 22. BIND DNS Security (Advanced)

- [ ] DNSSEC — zone signing, trust chain
- [ ] `allow-recursion { trusted; };` — prevent open resolver abuse
- [ ] Response Rate Limiting (RRL)
- [ ] Split-horizon DNS — internal vs external views

---

## 📌 Case Studies — Attack → Prevention

| Attack Vector                       | Prevention                                                 |
| ----------------------------------- | ---------------------------------------------------------- |
| Privilege escalation via file perms | `find / -perm -4000`, remove unneeded SUID                 |
| Unauthorized SSH access             | `PermitRootLogin no`, key-auth, `fail2ban`                 |
| Data loss (poor disk/patch mgmt)    | `yum --security update`, LVM snapshot pre-patch            |
| Web server compromise (Apache)      | `Options -Indexes`, `mod_security`, `ServerTokens Prod`    |
| DNS zone transfer abuse (AXFR)      | `allow-transfer { none; };`                                |
| Delayed breach detection            | Centralized logging (`rsyslog`/SIEM), `auditd`, `fail2ban` |
| Postfix open relay                  | Restrict relay, add SPF/DKIM/DMARC                         |
| Bash script attack vector           | `chmod 700 script.sh`, absolute paths in scripts           |

## 📌 Ports & Services — Memorize

`20/21 FTP(plaintext)` · `22 SSH/SFTP` · `23 Telnet(never use)` · `25 SMTP(relay risk)` · `53 DNS(TCP=AXFR)` · `67/68 DHCP` · `80/443 HTTP/S` · `110/995 POP3/S` · `111 RPC(NFS dep)` · `123 NTP(amp risk)` · `143/993 IMAP/S` · `389/636 LDAP/S` · `445 SMB` · `514 Syslog` · `587 SMTP submission` · `631 CUPS` · `2049 NFSv4` · `3128 Squid` · `5900 VNC(unencrypted)`

## 📌 Top 12 Interview Traps — Self-Test

- [ ] Why `chmod 777` is dangerous
- [ ] `no_root_squash` risk in NFS
- [ ] Why `PermitRootLogin yes` is a fail
- [ ] SSH/SFTP over Telnet/FTP — justification
- [ ] Open SMTP relay risk
- [ ] SUID on scripts (ignored) vs binaries (exploitable)
- [ ] World-readable `/etc/shadow` risk
- [ ] Unrestricted DNS AXFR risk
- [ ] World-writable cron script risk
- [ ] Unsynced NTP breaks forensic log analysis
- [ ] `start` vs `enable` in systemctl
- [ ] `su -` vs `su` (environment loading)

## 📋 Session-Wise Coverage Tracker

- [ ] 1–2: Filesystem, core cmds, links, perms, sticky bit, umask, ACLs, network cmds
- [ ] 3–4: Installation, boot process, GRUB, initramfs, runlevels/targets, RPM/DEB
- [ ] 5: Kickstart, user administration
- [ ] 6: IPv4/IPv6, SSH, VNC, network auth
- [ ] 7: User/group mgmt, sudoers
- [ ] 8: Disk mgmt, fdisk/gdisk, LVM, RAID
- [ ] 9: Network implementation, CUPS
- [ ] 10: systemctl, key config files, NIS
- [ ] 11: Patch mgmt, tuning, X server config
- [ ] 12: IPC — pipes, signals, shared memory, semaphores, queues, sockets
- [ ] 13: DNS (BIND9, named, zone files)
- [ ] 14: NFS server, FTP server (vsftpd)
- [ ] 15: Samba, DHCP, DNS combined
- [ ] 16: Apache, virtual hosting, Squid proxy
- [ ] 17: Postfix, Dovecot, SquirrelMail
- [ ] 18: Performance tuning, troubleshooting, threat model
- [ ] 19: Basic service security, rsyslog, NTP, BIND security
- [ ] 20: LDAP, NIS, Apache clustering/load balancing, NTP server
- [ ] 21: VM management, VM networking
- [ ] 22–23: Bash scripting — CLI, control structures, loops, variables, regex
- [ ] 24: Bash automation, security patch scripting
- [ ] 25: Logging & monitoring via bash scripts
- [ ] 26: Case studies, forensic log analysis, automation as attack vector

---

## Windows Track (combined 210hr module)

**Courseware:** Linux All-In-One for Dummies (Dulaney) · Mastering Windows Server 2016 R2 · Windows Server 2022 Administration Fundamentals

### Completion Checklist

- [ ] Windows OS architecture & installation
- [ ] Active Directory (ADDS, DC, ADC, OU)
- [ ] DNS/DHCP/IPAM · Group Policy & Local Policy
- [ ] IIS, DFS, Hyper-V
- [ ] WSB / FSRM / NPS / NLB / WDS
- [ ] Exchange Server, PowerShell

### 🔴 Priority 1

- [ ] Windows architecture — kernel vs user mode; install/upgrade/migration types
- [ ] AD — DC, ADC, ADDS, Domain, OU, replication (authoritative vs non-authoritative restore)
- [ ] DNS, DHCP, IPAM concepts & config
- [ ] Windows Server Backup (WSB) — Full/Incremental/System State

### 🟠 Priority 2

- [ ] Group Policy / Local Policy — default vs custom GPO
- [ ] IIS — attack surface, hardening
- [ ] DFS, Branch Office solutions
- [ ] Hyper-V — install/config, VM settings, security

### 🟡 Priority 3

- [ ] FSRM, NPS, NLB, WDS
- [ ] Exchange Server basics
- [ ] PowerShell — scripting, error handling, background jobs, remote admin

### 📌 Windows Case Studies

| Scenario                     | Root Cause                                    | Key Learning                                                |
| ---------------------------- | --------------------------------------------- | ----------------------------------------------------------- |
| Ransomware on Windows server | Missing/failed backups                        | Importance of System State backup                           |
| AD compromise                | Weak DNS + excessive privileges               | Least privilege, authoritative vs non-authoritative restore |
| Unauthorized server access   | Weak SSH config                               | Key-based auth > password, disable root login               |
| Privilege escalation         | World-writable files, bad `/etc/passwd` perms | File permission hygiene                                     |
| Web server compromise        | Weak Apache config                            | Vhost isolation, disable directory listing                  |

### 📌 Windows Registry Hives

| Hive       | Purpose                               |
| ---------- | ------------------------------------- |
| SAM        | Local user accounts & password hashes |
| SYSTEM     | Hardware/driver/service config        |
| SOFTWARE   | Installed software settings           |
| SECURITY   | Local security policy                 |
| NTUSER.DAT | Per-user profile settings             |

### 📌 Linux Boot Sequence (quick ref)

BIOS/UEFI → GRUB → Kernel + initramfs → systemd/init → Runlevel/Target → Login

---

> Back to [[Index|Linux OS and Security Notes Index]]
