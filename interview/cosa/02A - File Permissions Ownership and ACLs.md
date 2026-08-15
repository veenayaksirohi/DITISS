---
title: 02A - File Permissions Ownership and ACLs
aliases:
  - File Permissions Ownership and ACLs
  - Linux_Permissions_ACL_Notes
  - Linux File Permissions and ACLs
tags:
  - linux
  - permissions
  - acl
  - interview-preparation
syllabus-topic:
  - 2
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]] · Related: [[02B - Special Permission Bits|Special Permission Bits]] · [[03 - User and Group Management|User and Group Management]]

# Linux File Permissions & ACLs — Study Notes
**Quick Revision Guide for Exam / Viva Prep**

---

## 1. Permission Notation: Symbolic vs Octal

Every file/directory has **3 permission sets**: Owner (u), Group (g), Others (o) — each can have Read (r), Write (w), Execute (x).

### 1.1 Symbolic Notation

```
-  rwx  r-x  r--
1   2    3    4

1 = File type (- file, d directory, l symlink)
2 = Owner permissions
3 = Group permissions
4 = Others permissions
```

| Symbol | Meaning (file) | Meaning (directory) |
|--------|-----------------|----------------------|
| `r` | Read file contents | List directory contents (`ls`) |
| `w` | Modify/delete file contents | Create/delete files inside |
| `x` | Execute the file (run as program/script) | Enter the directory (`cd`) |
| `-` | Permission denied | Permission denied |

### 1.2 Octal (Numeric) Notation

Each permission has a value:

| Permission | Value |
|------------|-------|
| Read (r) | 4 |
| Write (w) | 2 |
| Execute (x) | 1 |
| None (-) | 0 |

Add the values for each set (owner, group, others):

```
rwx = 4+2+1 = 7
rw- = 4+2   = 6
r-x = 4+1   = 5
r-- = 4     = 4
```

### Common Octal Combos

| Octal | Symbolic | Meaning |
|-------|----------|---------|
| `755` | `rwxr-xr-x` | Owner: full, Group/Others: read+execute (typical for scripts/binaries) |
| `644` | `rw-r--r--` | Owner: read+write, Group/Others: read-only (typical for regular files) |
| `700` | `rwx------` | Owner only — private script/dir |
| `600` | `rw-------` | Owner only, no execute — private files (e.g., SSH keys) |
| `777` | `rwxrwxrwx` | Everyone full access — 🔴 dangerous, avoid on production |
| `666` | `rw-rw-rw-` | Everyone read+write, no execute — also risky |

🔴 **Exam Trap:** `755` for directories, `644` for regular files = safe Linux defaults. `777` anywhere = major red flag in a security audit.

💡 **Quick memory trick:** r=4, w=2, x=1 → just like binary bit positions (100, 010, 001).

---

## 2. `chmod` — Change Mode (Permissions)

### 2.1 Numeric (Octal) Mode

```bash
chmod 755 script.sh      # rwxr-xr-x
chmod 644 file.txt       # rw-r--r--
chmod -R 755 /var/www/    # recursive — apply to all files/subdirs
```

### 2.2 Symbolic Mode

| Operator | Meaning |
|----------|---------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exact permission |

```bash
chmod u+x script.sh       # add execute for owner (u)
chmod g-w file.txt        # remove write for group (g)
chmod o=r file.txt        # set others to read-only
chmod a+x script.sh       # add execute for all (a = u+g+o)
chmod ug+rw file.txt      # add read+write for owner AND group
```

| Target | Meaning |
|--------|---------|
| `u` | User/owner |
| `g` | Group |
| `o` | Others |
| `a` | All (u+g+o) |

🟠 **Note:** Symbolic mode is useful when you want to change **one** permission without affecting others. Numeric mode always resets **all three** sets at once.

---

## 3. `chown` — Change Owner

```bash
chown alice file.txt              # change owner to alice
chown alice:developers file.txt   # change owner AND group together
chown -R alice:developers /data/   # recursive — whole directory tree
chown :developers file.txt        # change group only (alt to chgrp)
```

Syntax: `chown <user>:<group> <file>`

---

## 4. `chgrp` — Change Group

```bash
chgrp developers file.txt
chgrp -R developers /project/     # recursive
```

- Simpler dedicated command when you only need to change the **group**, not the owner.

### Comparison Table

| Command | Changes | Needs Root/Sudo? |
|---------|---------|-------------------|
| `chmod` | Permission bits (rwx) | Only owner or root |
| `chown` | Owner (and optionally group) | Root only (normal users can't give away files) |
| `chgrp` | Group only | Owner (if member of target group) or root |

🔴 **Exam Trap:** A regular user **cannot** `chown` a file to another user — only root can transfer ownership. This is a very common Viva question.

---

## 5. `umask` — Default Permission Mask

`umask` decides the **default permissions** given to newly created files and directories — it works by **subtracting** from the maximum possible permission.

### Maximum defaults (before umask is applied):
- Files: `666` (rw-rw-rw-) — files never get execute by default
- Directories: `777` (rwxrwxrwx)

### Formula:
```
Final permission = Maximum default − umask
```

```bash
umask          # view current umask value
umask 022      # set umask (common default)
```

### Example: `umask 022`

| Type | Max default | Umask | Result |
|------|-------------|-------|--------|
| File | 666 | 022 | 644 (rw-r--r--) |
| Directory | 777 | 022 | 755 (rwxr-xr-x) |

💡 **How to calculate quickly:** umask digit tells you what to **remove** from each permission set (7-0=7, 7-2=5, 6-2=4, 6-0=6, etc.) — subtract per-digit, not a simple whole-number subtraction.

🔴 **Exam Trap:** `umask 022` is the standard Linux default → gives owner full access, group/others read-only (and no write) on new files. `umask 077` = private by default (owner only) — often used for sensitive user home directories.

---

## 6. ACL — Access Control Lists

### Why ACL?

Traditional permissions (`rwx` for owner/group/others) only allow **ONE** owner and **ONE** group per file. 

**Problem:** What if you need to give a *specific* extra user (not the owner, not in the group) read access — without changing the file's actual group or making it world-readable?

**Solution: ACL** — lets you assign permissions to **multiple specific users/groups** on the same file.

### 6.1 `setfacl` — Set ACL permissions

```bash
setfacl -m u:bob:rwx file.txt        # give user 'bob' rwx access
setfacl -m g:interns:r-- file.txt    # give group 'interns' read-only
setfacl -x u:bob file.txt            # remove bob's ACL entry
setfacl -b file.txt                  # remove ALL ACL entries (reset)
setfacl -R -m u:bob:rwx /project/     # recursive
```

| Flag | Meaning |
|------|---------|
| `-m` | Modify (add/update) an ACL entry |
| `-x` | Remove a specific ACL entry |
| `-b` | Remove all ACL entries |
| `-R` | Recursive |
| `-d` | Set default ACL (inherited by new files in a directory) |

### 6.2 `getfacl` — View ACL permissions

```bash
getfacl file.txt
```

Example output:
```
# file: file.txt
# owner: alice
# group: developers
user::rw-
user:bob:rwx          <- extra ACL entry for bob
group::r--
mask::rwx
other::r--
```

### Comparison Table: Traditional Permissions vs ACL

| Feature | Traditional (`chmod`) | ACL (`setfacl`) |
|---------|------------------------|-------------------|
| Users supported | 1 owner only | Multiple specific users |
| Groups supported | 1 group only | Multiple specific groups |
| Granularity | Coarse (owner/group/others) | Fine-grained (per user/group) |
| Command | `chmod`, `chown` | `setfacl`, `getfacl` |
| Viewing | `ls -l` | `getfacl` (also `ls -l` shows a `+` after permissions if ACL is set) |

💡 **Tip:** If `ls -l` shows `rwxr-xr--+` — that trailing `+` means the file **has an ACL** applied beyond normal permissions.

---

### 6.3 ACL `mask` — Effective Permission Limiter

The **mask** entry defines the **maximum effective permissions** that any *named user* or *named group* ACL entry can have — it acts like a ceiling/cap.

**Important:** Even if you grant `rwx` to a user via ACL, if the `mask` is only `r-x`, the user's **effective** permission is capped at `r-x` (write is blocked).

```bash
setfacl -m u:bob:rwx file.txt     # bob granted rwx
setfacl -m mask::r-x file.txt     # mask caps everyone at r-x
getfacl file.txt
# user:bob:rwx    #effective:r-x   <- capped by mask!
```

🔴 **Exam Trap (very common Viva Q):** *"You gave a user `rwx` via ACL, but they still can't write. Why?"*
→ Because the **mask** entry is restricting the effective permission. Always check `getfacl` output for `#effective:` — if it differs from the granted permission, the **mask** is the cause.

- `setfacl -m mask::rwx file.txt` → widen the mask to allow full effective permissions.
- The mask does **NOT** affect the file **owner** or **others** — only named users/groups and the owning group.

---

## 7. World-Writable Files — Security Risk

A **world-writable** file/directory means the "Others" (`o`) permission set includes write (`w`) — i.e., permission like `666`, `777`, `-rw-rw-rw-`, or `drwxrwxrwx`.

### Why it's dangerous:
- **Any** user on the system (not just owner/group) can modify or delete the file.
- Attackers with low-privilege access can **inject malicious code** into scripts, configs, or binaries that get executed later (often by root via cron or services) → **privilege escalation**.
- World-writable directories let attackers **plant files** (e.g., fake libraries, malicious scripts).

### Finding world-writable files:

```bash
find / -perm -o+w -type f 2>/dev/null       # world-writable FILES
find / -perm -o+w -type d 2>/dev/null       # world-writable DIRECTORIES
find / -perm -002 -type f 2>/dev/null        # alternate syntax (numeric)
```

| Flag | Meaning |
|------|---------|
| `-perm -o+w` | Match files where "others" has write permission |
| `-type f` | Only regular files |
| `-type d` | Only directories |
| `2>/dev/null` | Suppress "permission denied" errors while scanning |

### Fixing it:

```bash
chmod o-w file.txt        # remove write access for others
```

🔴 **Exam Trap:** A **world-writable cron script** owned by root is a classic privilege escalation path — any user can edit the script, insert malicious commands, and wait for root's cron job to execute it with root privileges.

🟠 **Special case:** `/tmp` is world-writable **by design** (needed for all users to create temp files), but it's protected using the **Sticky Bit** (`chmod +t /tmp`) — this ensures only the file's **owner** (or root) can delete/rename it, even though everyone can write into the directory.

---

## 8. Quick-Fire Viva Q&A

| Question | Answer |
|----------|--------|
| What does `chmod 644` mean? | Owner: read+write, Group & Others: read-only |
| Who can run `chown` to give a file to someone else? | Only root (regular users cannot give away ownership) |
| Default umask value on most Linux systems? | `022` |
| Why do files never get execute permission by default? | Max default for files is `666`, not `777` — execute must be added explicitly |
| How do you give one specific user access without changing the group? | Use ACL — `setfacl -m u:username:rwx file` |
| What does the `+` after permissions in `ls -l` mean? | The file has an ACL applied |
| What does the ACL `mask` do? | Caps the effective permission of all named users/groups (acts as a ceiling) |
| How to find all world-writable files on the system? | `find / -perm -o+w -type f 2>/dev/null` |
| Why is `/tmp` writable by everyone but still safe? | Sticky bit ensures only the file owner/root can delete/rename files inside |
| Command to remove ALL ACL entries from a file? | `setfacl -b file.txt` |

---

## 9. One-Page Summary Table

| Topic | Key Command | Key Point |
|-------|--------------|-----------|
| Permissions | `ls -l` | rwx for owner/group/others; r=4,w=2,x=1 |
| Change permission | `chmod 755 file` / `chmod u+x file` | Numeric = reset all; Symbolic = targeted change |
| Change owner | `chown user:group file` | Root only |
| Change group | `chgrp group file` | Owner (if member) or root |
| Default permission | `umask 022` | Files=644, Dirs=755 with umask 022 |
| Multi-user permission | `setfacl -m u:name:rwx file` | Fine-grained, beyond owner/group/others |
| View ACL | `getfacl file` | Shows all entries + effective perms |
| ACL cap | `mask::rwx` | Limits effective perms of named users/groups |
| Security risk | `find / -perm -o+w` | World-writable = injection/escalation risk |
