---
title: "A2 - OS Administration Syllabus and Interview Checklist"
aliases:
  - "OS Administration Syllabus and Interview Checklist"
  - "02 - OS Administration Syllabus and Interview Checklist"
  - "Concept of Operating Systems and Administration — CDAC DITISS Syllabus"
tags:
  - operating-systems
  - windows
  - linux
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]]

# Concept of Operating Systems & Administration — Interview Checklist

**Duration:** 210 hrs (90T + 90L + 30SL) | **CMCE Module**
**Courseware:** Linux All-In-One for Dummies (Dulaney); Mastering Windows Server 2016 R2; Windows Server 2022 Administration Fundamentals

---

## Completion Checklist

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

## 🔴 Priority 1 — Must Know

- [ ] Windows OS architecture — kernel mode vs user mode, installation/upgrade/migration types
- [ ] Active Directory — DC, ADC, ADDS, Domain, OU, replication (authoritative vs non-authoritative restore)
- [ ] DNS, DHCP, IPAM concepts and configuration
- [ ] Linux file system, permissions (chmod/chown/ACL), boot process (GRUB, initramfs, runlevels)
- [ ] User & Group management, SSH key-based auth vs password auth
- [ ] Disk management — MBR vs GPT, LVM, RAID basics
- [ ] Windows Server Backup (WSB) — Full/Incremental/System State

## 🟠 Priority 2 — Important

- [ ] Group Policy / Local Policy — default vs custom GPO
- [ ] IIS Web Server — attack surface, hardening
- [ ] DFS, Branch Office solutions
- [ ] Hyper-V — install/configure, VM settings, security concerns
- [ ] Samba, NFS, FTP, Apache (virtual hosting, security), Squid proxy
- [ ] Postfix/Dovecot mail stack (e-mail delivery concepts)
- [ ] Patch management & service lifecycle (systemctl)
- [ ] Kickstart automation, YUM/RPM vs DEB package management

## 🟡 Priority 3 — Good to Know

- [ ] FSRM, NPS, NLB, WDS
- [ ] Exchange Server basics
- [ ] PowerShell scripting, error handling, background jobs, remote administration
- [ ] BASH CLI scripting — loops, variables, regex, automation, logging
- [ ] LDAP/NIS network authentication, Apache clustering/load balancing

---

## 📌 Interview Case Studies to Know

| Scenario | Root Cause | Key Learning |
|---|---|---|
| Ransomware on Windows server | Missing/failed backups | Importance of System State backup |
| AD compromise | Weak DNS + excessive privileges | Least privilege, authoritative vs non-authoritative restore |
| Unauthorized server access | Weak SSH config | Key-based auth > password, disable root login |
| Privilege escalation | World-writable files, bad /etc/passwd perms | File permission hygiene |
| Web server compromise | Weak Apache config | Virtual host isolation, disable directory listing |

## 📌 Windows Registry Hives Quick Reference

| Hive | Purpose |
|---|---|
| SAM | Local user account & password hashes |
| SYSTEM | Hardware/driver/service config |
| SOFTWARE | Installed software settings |
| SECURITY | Local security policy |
| NTUSER.DAT | Per-user profile settings |

## 📌 Linux Boot Sequence

BIOS/UEFI → Bootloader (GRUB) → Kernel + Initial RAM Disk → systemd/init → Runlevel/Target → Login

---

## Related Notes

- [[Index|Linux OS and Security Notes Index]]
- [[00 - Syllabus and Interview Checklist|Linux OS and Security Syllabus and Interview Checklist]]
