---
title: 02B - Special Permission Bits
aliases:
  - Special Permission Bits
  - Special_Bits_SUID_SGID_Sticky
  - SUID SGID and Sticky Bit
tags:
  - linux
  - permissions
  - security
  - interview-preparation
syllabus-topic:
  - 2
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]] · Related: [[02A - File Permissions Ownership and ACLs|File Permissions Ownership and ACLs]]

# Special Permission Bits in Linux — SUID, SGID, Sticky Bit

## 1. Overview

Apart from the normal `rwx` permissions (read, write, execute) for owner/group/others, Linux has **three special permission bits** that control extra behavior:

| Bit | Numeric Value | Applies To |
|---|---|---|
| SUID (Set User ID) | 4 | Executable files |
| SGID (Set Group ID) | 2 | Executable files & Directories |
| Sticky Bit | 1 | Directories |

These are added as a **4th digit** in front of normal permissions.
Example: `chmod 4755 file` → `4` = SUID, `755` = normal rwx permissions.

---

## 2. SUID — Set User ID (4)

### What it means
When a file with SUID is executed, the process runs with the **permissions of the file's owner**, not the user who launched it.

### Why it's used
Allows a normal user to perform a privileged task (usually requiring root) through a controlled program, **without giving the user permanent root access**.

### Numeric value
`4` → e.g. `chmod 4755 filename`

### Command
```bash
chmod u+s filename
chmod 4755 filename
```

### `ls -l` symbol
- Owner's `x` becomes `s` → execute + SUID present
- Owner's `x` becomes `S` (capital) → SUID set but **no execute permission** underneath (broken/unusual state)

```
-rwsr-xr-x 1 root root 64152 May 30 2024 /usr/bin/passwd
```

### Real example (from `/etc/shadow` case)
- `/etc/shadow` → `rw-r----- root shadow` → normal users have **no access**
- `/usr/bin/passwd` → has SUID → runs as **root** temporarily
- Result: a normal user can change their own password without ever having direct access to `/etc/shadow`

### Analogy
Like a bank attendant with vault access — you hand over your request, the attendant (SUID program) goes in with **their own permission**, does the task, and comes back. You never get vault access yourself.

### Risk
- **High security risk if misused.**
- Any SUID root-owned script/binary is a potential **privilege escalation** point.
- If an SUID program has a vulnerability (buffer overflow, shell escape, etc.), an attacker can gain root shell.
- Common VAPT/audit check: `find / -perm -4000 -type f 2>/dev/null` → lists all SUID files on the system.

---

## 3. SGID — Set Group ID (2)

### What it means
- On an **executable file**: process runs with the permissions of the **file's group**.
- On a **directory**: any new file/folder created inside automatically inherits the **directory's group** (instead of the creator's own primary group).

### Why it's used
Mainly for **shared team/project directories** — ensures all files created by different users automatically belong to the same group, so the whole team can access them without manual `chgrp` every time.

### Numeric value
`2` → e.g. `chmod 2775 dirname`

### Command
```bash
chmod g+s dirname
chmod 2775 dirname
```

### `ls -l` symbol
- Group's `x` becomes `s` → execute + SGID present
- Group's `x` becomes `S` (capital) → SGID set but no group execute permission

```
drwxrwsr-x 2 root devteam 4096 Jan 1 12:00 team_project
```

### Real example
`/data/team_project` shared by multiple developers:
```bash
sudo chmod 2775 /data/team_project
```
Now any file created inside (by any user) automatically belongs to group `devteam`, so the whole team can read/write it — no permission mismatch.

### Risk
- **Moderate risk.**
- SGID on an executable (like SUID) can allow privilege escalation if the group has elevated access.
- SGID on directories is generally safe and is a common, recommended practice for collaborative folders.
- Audit check: `find / -perm -2000 -type f 2>/dev/null` → lists all SGID files.

---

## 4. Sticky Bit (1)

### What it means
When set on a **directory**, only the **file's owner** (or root) can delete or rename files inside — even if other users have write permission on the directory itself.

### Why it's used
Protects files in a **publicly writable shared directory** from being deleted or renamed by other users.

### Numeric value
`1` → e.g. `chmod 1777 dirname`

### Command
```bash
chmod +t dirname
chmod 1777 dirname
```

### `ls -l` symbol
- Others' `x` becomes `t` → execute + sticky bit present
- Others' `x` becomes `T` (capital) → sticky bit set but no execute permission for others

```
drwxrwxrwt 10 root root 4096 Aug 10 09:00 /tmp
```

### Real example (tested)
Shared folder `/shared_dir` used by `veena` and `siddhant`:

**Without sticky bit (`777`):**
```bash
# siddhant can delete veena's file
rm /shared_dir/veena_file.txt   # succeeds — BAD
```

**With sticky bit (`1777`):**
```bash
sudo chmod 1777 /shared_dir
rm /shared_dir/veena_file.txt
# Output: rm: cannot remove 'veena_file.txt': Operation not permitted
```

Classic real-world example: **`/tmp`** — world-writable, but sticky bit stops users from deleting each other's temp files.

### Risk
- **Low security risk** — it only restricts deletion, doesn't grant any extra privilege.
- Misconfiguration (forgetting to set it on a public directory) can lead to users tampering with/deleting others' files — mostly an availability/integrity issue, not a privilege escalation issue.

---

## 5. Combined Comparison Table

| Feature | SUID | SGID | Sticky Bit |
|---|---|---|---|
| Applies to | Executable files | Files & Directories | Directories |
| Effect | Process runs as **file owner** | Process runs as **file group** / new files inherit dir's group | Only **owner** can delete/rename their files |
| Numeric value | 4 | 2 | 1 |
| Symbol in `ls -l` | `s` / `S` in owner's execute spot | `s` / `S` in group's execute spot | `t` / `T` in others' execute spot |
| Set command | `chmod u+s file` | `chmod g+s dir` | `chmod +t dir` |
| Numeric example | `chmod 4755 file` | `chmod 2775 dir` | `chmod 1777 dir` |
| Typical real use | `passwd`, `ping`, `sudo` | Shared team/project folders | `/tmp`, public upload folders |
| Security risk level | **High** (privilege escalation) | **Moderate** (mainly on executables) | **Low** (only affects delete rights) |
| Audit command | `find / -perm -4000 -type f` | `find / -perm -2000 -type f` | `find / -perm -1000 -type d` |

---

## 6. Exam / Viva Quick Points

- All three bits occupy the **4th (leftmost) digit** in `chmod XYZW` notation (X = special bit).
- Lowercase (`s`, `t`) = special bit **+** underlying execute permission both present.
- Uppercase (`S`, `T`) = special bit set but **execute permission missing** — a common "spot the trap" question.
- SUID/SGID = about **identity change during execution**.
- Sticky bit = about **restricting deletion**, not execution.
- SUID + SGID are common **privilege escalation vectors** in penetration testing (`find` with `-perm -4000` / `-2000` is a standard enumeration step in Linux privilege escalation checklists).
- Sticky bit does **not** grant any extra permission — it only removes the ability to delete/rename others' files.
