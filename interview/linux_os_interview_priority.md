# Linux OS & Security — CDAC DITISS Syllabus
## Topics, Interview Priority & Important Commands/Configs

---

## 🔴 PRIORITY 1 — MUST KNOW (Most Asked in Interviews)

### 1. Linux Filesystem & Core Commands
- Linux Filesystem Hierarchy Standard (FHS) — `/etc`, `/var`, `/home`, `/proc`, `/tmp`, `/usr`, `/bin`
- Essential commands: `ls`, `cp`, `mv`, `rm`, `cat`, `grep`, `find`, `diff`, `wc`, `sort`, `head`, `tail`
- Archive & compression: `tar -czvf` / `tar -xzvf`, `gzip`, `gunzip`, `zip`, `unzip`, `zcat`
- Process commands: `ps`, `top`, `kill`, `jobs`, `bg`, `fg`, `nohup`
- Hard link vs Soft link — inode behavior, `ln` vs `ln -s`, cross-filesystem restriction
- `man`, `whatis`, `whereis`, `locate`, `find` — difference between locate (index) vs find (live search)

### 2. File Permissions, Ownership & ACLs
- Permission notation: symbolic (`rwx`) and octal (`755`, `644`)
- `chmod`, `chown`, `chgrp` — syntax and recursive use
- Special bits: **SUID** (4), **SGID** (2), **Sticky bit** (1) — use cases and risks
- Sticky bit on shared directories like `/tmp` — only file owner/root can delete or rename files
- `umask` — default permission mask for newly created files/directories; `umask 022` is a common default
- ACL (`setfacl`, `getfacl`) vs traditional permissions — when ACL is needed
- `mask` entry in ACL — effective permission limiter
- World-writable files (`777`) — exploitation risk, `find / -perm -o+w`

### 3. User & Group Management
- `useradd`, `usermod`, `userdel`, `passwd`, `chage`
- `/etc/passwd` — `username:x:UID:GID:comment:home:shell`
- `/etc/shadow` — password hash, aging, `!` = locked account
- `/etc/group` — `group_name:x:GID:member_list`
- `su` vs `sudo` — `su` needs target password, `sudo` needs own password
- `/etc/sudoers` & `visudo` — `%wheel ALL=(ALL) ALL`, `NOPASSWD` option
- Primary group vs supplementary groups — `id`, `groups`, `newgrp`

### 4. Linux Boot Process & Systemd
- Full boot sequence: **BIOS/UEFI → MBR/GPT → GRUB2 → Kernel → initramfs → systemd → Target → Login**
- GRUB2 — `grub.cfg` location, rescue mode, `GRUB_TIMEOUT`
- `initramfs` / Initial RAM Disk — why it exists, `dracut`, `pivot_root`
- Runlevels vs Systemd Targets:

| Runlevel | Systemd Target | Description |
|----------|----------------|-------------|
| 0 | poweroff.target | Shutdown |
| 1 | rescue.target | Single-user / recovery |
| 3 | multi-user.target | CLI multi-user |
| 5 | graphical.target | GUI multi-user |
| 6 | reboot.target | Reboot |

- `systemctl start/stop/restart/enable/disable/status/is-enabled/daemon-reload`
- **`start` vs `enable`** — start = runs now, enable = persists across reboots

### 5. Package & Repository Management
- RPM: `rpm -ivh` (install), `-Uvh` (upgrade), `-e` (erase), `-qa` (list all), `-ql` (list files)
- DEB: `dpkg -i`, `dpkg -r`, `dpkg -l`
- Package managers: `yum`/`dnf` (RHEL), `apt`/`apt-get` (Debian)
- Repository config: `/etc/yum.repos.d/`, `/etc/apt/sources.list`, GPG key verification
- `yum --security update` — security-only patches

### 6. SSH & Remote Access Security
- `sshd_config` critical directives:

```bash
PermitRootLogin no           # Never allow root SSH
PasswordAuthentication no    # Force key-based auth
MaxAuthTries 3               # Brute-force mitigation
AllowUsers <specific_user>   # Whitelist users
Port 2222                    # Change default port
ClientAliveInterval 300      # Session timeout
```

- SSH key-based auth: `ssh-keygen` → `~/.ssh/authorized_keys`
- SSH vs Telnet — encrypted vs plaintext, Telnet deprecated (never use in production)
- SFTP vs FTP — SFTP runs over SSH (port 22), FTP is plaintext (port 21)
- `~/.ssh/known_hosts` — server fingerprint verification, TOFU model

### 7. Disk Management & LVM
- `fdisk` (MBR, max 2TB, 4 primary partitions) vs `gdisk` (GPT, max 9ZB, 128 partitions)
- LVM pipeline: **Physical Volume → Volume Group → Logical Volume**

```
pvcreate /dev/sdb → vgcreate vg1 /dev/sdb → lvcreate -L 10G -n lv1 vg1 → mkfs.ext4 /dev/vg1/lv1 → mount
```

- LVM Snapshots — Copy-on-Write (COW), used for backup before patching
- `df -h`, `du -sh`, `lsblk`, `blkid`, `mount`, `/etc/fstab` (UUID-based)
- RAID levels:

| RAID | Min Disks | Fault Tolerance | Use Case |
|------|-----------|-----------------|----------|
| RAID 0 | 2 | None | Speed only |
| RAID 1 | 2 | 1 disk | Mirror, redundancy |
| RAID 5 | 3 | 1 disk | Balanced perf + redundancy |
| RAID 6 | 4 | 2 disks | Higher fault tolerance |
| RAID 10 | 4 | 1 per mirror pair | High perf + redundancy |

### 8. Core Infrastructure Services — DNS, DHCP, NFS, Samba

**DNS (BIND9 / named):**
- Record types: A, AAAA, MX, CNAME, PTR, NS, SOA, TXT
- Forward zone vs Reverse zone, `/etc/named.conf`, zone file syntax
- `/etc/resolv.conf` — `nameserver`, `search`, `domain`
- `/etc/nsswitch.conf` — resolution order: `hosts: files dns`
- **Zone transfer abuse (AXFR)** — restrict with `allow-transfer { none; };`
- DNS attacks: cache poisoning, DNS amplification, unauthorized AXFR

**DHCP:**
- DORA process: **Discover → Offer → Request → Acknowledge**
- `dhcpd.conf` — `subnet`, `range`, `default-lease-time`, `option routers`
- DHCP starvation attack — flood server with fake MACs, exhaust IP pool
- DHCP Snooping — switch-level protection against rogue DHCP

**NFS:**
- `/etc/exports` — `rw`, `ro`, `root_squash`, `no_root_squash`
- `exportfs -ra`, `showmount -e <server>`
- **`no_root_squash` danger** — remote root = local root access

**Samba:**
- `smb.conf` — `[share]`, `valid users`, `writable`, `path`
- Samba vs NFS: Samba = Windows+Linux interop, NFS = Linux/Unix only
- Port 445 (SMB), Port 139 (NetBIOS)

### 9. Apache Web Server Security
- Config files: `httpd.conf` (RHEL), `apache2.conf` (Debian)
- `DocumentRoot`, `VirtualHost`, `Directory` blocks, `.htaccess`
- Name-based vs IP-based virtual hosting

```apache
Options -Indexes          # Disable directory browsing
ServerTokens Prod         # Hide Apache version
ServerSignature Off       # Hide version in error pages
TraceEnable Off           # Disable HTTP TRACE
Header always set X-Frame-Options "DENY"
```

- `mod_ssl` (HTTPS), `mod_rewrite` (URL rewriting), `mod_security` (WAF)
- `a2enmod` / `a2dismod` — enable/disable modules

### 10. Logging, Monitoring & NTP
- Key log files in `/var/log/`:

| Log File | Content |
|----------|---------|
| `auth.log` / `secure` | Authentication events, sudo, SSH |
| `syslog` / `messages` | General system messages |
| `kern.log` | Kernel messages |
| `dmesg` | Boot-time hardware messages |
| `cron` | Cron job execution |
| `apache2/access.log` | Web server access |

- `rsyslog` — facility (kern, auth, daemon) + severity (0=emerg to 7=debug)
- `journalctl -u sshd -f`, `--since`, `-p err` — systemd journal queries
- `logrotate` — `/etc/logrotate.conf`, `rotate`, `compress`, `daily`
- NTP (port 123/UDP) — `ntpd` vs `chronyd`, time sync critical for forensic log integrity
- **NTP Amplification Attack** — Monlist command abuse, reflected UDP DDoS
- **Delayed breach detection** = logs not monitored → forensic analysis impossible

### 11. Bash Scripting & Automation
- Shebang `#!/bin/bash`, variables, quoting: `"$var"` (expands) vs `'$var'` (literal)
- Conditionals: `if [ ]` (POSIX) vs `if [[ ]]` (bash extended)
- Loops: `for i in {1..10}`, `while read line`, `until`
- Functions: `function_name() { ... }`, `local` variables
- Error handling: `$?` (exit code), `set -e` (exit on error), `trap` for cleanup
- Redirection: `>` (overwrite), `>>` (append), `2>&1` (stderr to stdout), `/dev/null`
- Regex: `grep -E`, `sed`, `awk` for field extraction
- Crontab format:

```
┌─ min (0-59)
│ ┌─ hour (0-23)
│ │ ┌─ day of month (1-31)
│ │ │ ┌─ month (1-12)
│ │ │ │ ┌─ weekday (0-6, Sun=0)
* * * * * /path/to/script.sh
```

- **Bash as attack vector** — world-writable cron scripts, PATH hijacking, use absolute paths

---

## 🟠 PRIORITY 2 — IMPORTANT (Frequently Asked)

### 12. Patch & Update Management
- `yum update --security` (RHEL), `apt upgrade` (Debian)
- Unattended upgrades — auto-security patches, reboot risks
- LVM snapshot before patching — rollback strategy
- `journalctl` + `auditd` for tracking patch-related changes
- Risk of unpatched services — CVE exposure, lateral movement

### 13. Service Management & System Config Files
- Systemd unit files (`/etc/systemd/system/`) — `[Unit]`, `[Service]`, `[Install]` sections
- Key config files:

| File | Purpose |
|------|---------|
| `/etc/hostname` | System hostname |
| `/etc/hosts` | Static name-to-IP mappings |
| `/etc/resolv.conf` | DNS resolver config |
| `/etc/nsswitch.conf` | Name resolution order |
| `/etc/fstab` | Persistent filesystem mounts |
| `/etc/crontab` | System-wide cron jobs |
| `/etc/ssh/sshd_config` | SSH server config |
| `/etc/sudoers` | Sudo permissions |

- `systemctl list-units --failed` — find broken services post-boot

### 14. Email Services — Postfix, Dovecot
- Email protocol ports: SMTP=25/587, IMAP=143/993(SSL), POP3=110/995(SSL)
- Full delivery chain: **MUA → Postfix (MTA) → Internet → Remote MTA → Dovecot (MDA) → Recipient MUA**
- Postfix `main.cf` — `myhostname`, `mydestination`, `smtpd_relay_restrictions`
- **Open relay danger** — misconfigured Postfix becomes a spam relay
- Anti-spoofing DNS records: **SPF** (authorized senders), **DKIM** (signature), **DMARC** (policy)

### 15. LDAP & NIS Authentication
- LDAP ports: 389 (plain), 636 (LDAPS)
- DN structure: `cn=user,ou=users,dc=cdac,dc=in`
- LDAP auth flow: bind DN → search → compare hash
- LDAP vs NIS:

| Feature | LDAP | NIS |
|---------|------|-----|
| Security | Encrypted (TLS) | Plaintext |
| Structure | Hierarchical | Flat |
| Status | Modern standard | Legacy |
| Port | 389 / 636 | 111 (RPC) |

### 16. Squid Proxy
- Port 3128 (default), `squid.conf`, ACL-based access control
- Forward proxy (client anonymity) vs Reverse proxy (server protection)
- Content filtering, bandwidth saving via caching

### 17. Virtual Machine Management
- KVM (Type-1, bare metal) vs VirtualBox (Type-2, hosted)
- VM network modes: **NAT** (private, internet via host), **Bridged** (own IP on LAN), **Host-Only** (isolated lab)
- `virsh list`, `virsh start`, `virsh snapshot-create`
- **VM escape** — guest process breaks hypervisor isolation — critical security concern
- Isolation best practice: separate VLANs + resource limits per VM

---

## 🟡 PRIORITY 3 — GOOD TO KNOW (Asked in Advanced Rounds)

### 18. NIS, Print Services & NFS Advanced
- NIS (`ypbind`, `ypcat`, `ypmatch`) — centralized user DB, legacy, plaintext — prefer LDAP
- CUPS print server — web UI at `localhost:631`
- NFSv4 vs NFSv3 — single port 2049, Kerberos auth support in v4

### 19. Kickstart Unattended Installation
- `ks.cfg` file — `%packages`, `%post`, `%pre` sections
- Deployment via PXE + TFTP + DHCP
- Automation risks — hardcoded credentials in `ks.cfg`, no post-install hardening

### 20. X Window System & Performance Tuning
- `DISPLAY` variable, Xorg, `startx` — desktop role specific
- `top`, `htop`, `vmstat`, `iostat`, `sar` — bottleneck identification
- `ulimit` — resource limits per user/process

### 21. BIND DNS Security (Advanced)
- DNSSEC — zone signing, trust chain validation
- `allow-recursion { trusted; };` — prevent open resolver abuse
- Response Rate Limiting (RRL) — anti-amplification mitigation
- Split-horizon DNS — internal vs external zone views

---

## 📌 CASE STUDY ANALYSIS — High Priority for CCEE / Viva

| Case Study | Attack Vector | Prevention |
|------------|---------------|------------|
| Privilege Escalation via File Permissions | World-writable `/etc/passwd`, SUID misuse | `find / -perm -4000`, remove unnecessary SUID bits |
| Unauthorized SSH Access | Root login enabled, password auth, weak passwords | `PermitRootLogin no`, key-based auth, `fail2ban` |
| Data Loss — Poor Disk/Patch Management | Unpatched kernel, no LVM snapshots | `yum --security update`, LVM snapshot pre-patch |
| Web Server Compromise (Apache) | Directory listing ON, version exposed, no WAF | `Options -Indexes`, `mod_security`, `ServerTokens Prod` |
| DNS Zone Transfer Abuse (AXFR) | `allow-transfer` unrestricted in BIND | `allow-transfer { none; };` in `named.conf` |
| Delayed Breach Detection | No centralized logging, logs unmonitored | `rsyslog` → SIEM, `auditd`, `fail2ban` alerts |
| Postfix Open Relay | `smtpd_relay_restrictions` misconfigured | Restrict relay, add SPF/DKIM/DMARC DNS records |
| Bash Script Attack Vector | World-writable cron script, PATH hijacking | `chmod 700 script.sh`, use absolute paths in scripts |

---

## 📌 IMPORTANT PORTS & SERVICES — Linux Quick Reference

| Port | Service | Transport | Notes |
|------|---------|-----------|-------|
| 20 | FTP Data | TCP | Plaintext — avoid |
| 21 | FTP Control | TCP | Plaintext — avoid |
| 22 | SSH / SFTP | TCP | Encrypted remote access |
| 23 | Telnet | TCP | Plaintext — never use in prod |
| 25 | SMTP | TCP | Send mail, open relay risk |
| 53 | DNS | TCP/UDP | Zone transfer via TCP |
| 67 | DHCP Server | UDP | DORA process |
| 68 | DHCP Client | UDP | Client side |
| 80 | HTTP | TCP | Apache, unencrypted |
| 110 | POP3 | TCP | Download mail, deletes from server |
| 111 | RPC/portmapper | TCP/UDP | NFS dependency |
| 123 | NTP | UDP | Time sync, amplification risk |
| 143 | IMAP | TCP | Sync mail, keeps on server |
| 389 | LDAP | TCP | Directory auth, plaintext |
| 443 | HTTPS | TCP | Apache + TLS |
| 445 | SMB/Samba | TCP | Windows file sharing |
| 514 | Syslog | UDP | Remote log forwarding |
| 587 | SMTP (submission) | TCP | Authenticated mail sending |
| 631 | CUPS | TCP | Print server web UI |
| 636 | LDAPS | TCP | LDAP over TLS |
| 993 | IMAPS | TCP | IMAP over TLS |
| 995 | POP3S | TCP | POP3 over TLS |
| 2049 | NFS | TCP/UDP | NFSv4 unified port |
| 3128 | Squid Proxy | TCP | HTTP proxy / cache |
| 5900 | VNC | TCP | Remote GUI, unencrypted |

---

## 📌 MOST ASKED INTERVIEW TRAPS — Linux

1. **`chmod 777`** = all users full read/write/execute — never on production files
2. **`no_root_squash` in NFS** = remote root acts as local root — critical misconfiguration
3. **`PermitRootLogin yes`** = instant security fail — always set to `no`
4. **Telnet / FTP over SSH / SFTP** — always choose encrypted transport
5. **Open SMTP relay** = your server becomes a spam cannon
6. **SUID on shell scripts** = kernel ignores it; SUID on binaries = privilege escalation path
7. **`/etc/shadow` readable by non-root** = hash exposed = offline cracking via hashcat/john
8. **DNS AXFR unrestricted** = attacker gets full network map
9. **Cron scripts world-writable** = attacker injects commands running as root
10. **NTP not synced** = log timestamps unreliable = forensic analysis compromised
11. **`start` vs `enable` in systemctl** — `start` is immediate only, `enable` is boot persistence; both needed
12. **`su -` vs `su`** — `su -` loads full environment of target user; `su` keeps current environment

---

## 📋 QUICK SYLLABUS TOPIC MAP (All Sessions)

| Session | Topics |
|---------|--------|
| 1–2 | Linux intro, filesystem hierarchy, core commands, hard/soft links, permissions, sticky bit, `umask`, ACLs, network commands |
| 3–4 | Installation, boot process, GRUB, initramfs, runlevels/targets, RPM & DEB package management |
| 5 | Kickstart unattended install, user administration |
| 6 | IPv4/IPv6 network config, SSH, VNC, network authentication |
| 7 | User & group management (`useradd`, `groupadd`, `sudo`, `/etc/sudoers`) |
| 8 | Disk management — `fdisk`, `gdisk`, LVM, RAID |
| 9 | Network implementation, print services (CUPS) |
| 10 | Service management (`systemctl`), key system config files, NIS |
| 11 | Patch management, system tuning, X server config |
| 12 | DNS configuration (BIND9, named, zone files) |
| 13 | NFS server, FTP server (`vsftpd`) |
| 14 | Samba, DHCP server, DNS server combined |
| 15 | Apache web server, virtual hosting, Squid proxy |
| 16 | Postfix (SMTP), Dovecot (IMAP/POP3), SquirrelMail |
| 17 | Performance tuning, troubleshooting, Linux threat model |
| 18 | Basic service security, logging (`rsyslog`), NTP, BIND security |
| 19 | LDAP, NIS, Apache clustering, load balancing, NTP server |
| 20 | VM management, VM network configuration |
| 21–22 | Bash scripting — CLI, control structures, loops, variables, regex |
| 23 | Bash automation, security patch scripting |
| 24 | Logging & monitoring via bash scripts |
| 25 | Case studies, forensic log analysis, automation as attack vector |

---

*CDAC DITISS — PGCP-ITISS | Linux OS & Security | Feb 2026*
*Total: 50T + 50L + 15SL = 115 hrs*
