---
title: 03 - User and Group Management
aliases:
  - User and Group Management
  - Linux_User_Group_Management_Notes
  - Linux User and Group Management
tags:
  - linux
  - users
  - groups
  - interview-preparation
syllabus-topic:
  - 3
---

> Navigation: [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]] · [[Index]] · Related: [[02A - File Permissions Ownership and ACLs|File Permissions Ownership and ACLs]] · [[16 - LDAP and NIS Authentication|LDAP and NIS Authentication]]

# Linux User & Group Management — Study Notes

**Quick Revision Guide for Exam / Viva Prep**

---

## 1. User Management Commands

### 1.1 `useradd` / `adduser` — Create a user

```bash
useradd veenay                          # basic user creation (no home dir on some distros)
useradd -m veenay                       # create with home directory
useradd -m -s /bin/bash -c "Veenayak" veenay   # full setup: shell + comment
adduser veenay                          # Debian/Ubuntu — interactive, friendlier wrapper
```

| Flag | Meaning                                |
| ---- | -------------------------------------- |
| `-m` | Create home directory                  |
| `-s` | Set login shell (e.g., `/bin/bash`)    |
| `-c` | Comment/full name                      |
| `-d` | Custom home directory path             |
| `-g` | Primary group                          |
| `-G` | Supplementary groups (comma-separated) |
| `-u` | Specify custom UID                     |

### Comparison Table: `useradd` vs `adduser`

| Feature                     | `useradd`                    | `adduser`                                      |
| --------------------------- | ---------------------------- | ---------------------------------------------- |
| Type                        | Low-level binary (all Linux) | High-level Perl script (Debian/Ubuntu only)    |
| Interaction                 | Non-interactive, needs flags | Interactive — prompts for password, name, etc. |
| Home dir created by default | ❌ No (needs `-m`)           | ✅ Yes, automatically                          |

🔴 **Exam Trap:** `useradd` alone does NOT create a home directory or set a password — many beginners forget `-m` and are surprised the user has no `/home/username`.

---

### 1.2 `usermod` — Modify an existing user

```bash
usermod -aG developers veenay     # ADD to supplementary group (append)
usermod -s /bin/zsh veenay        # change login shell
usermod -l newname oldname        # rename user (login name)
usermod -d /new/home -m veenay    # change home dir & move contents
usermod -L veenay                 # lock account (like passwd -l)
usermod -U veenay                 # unlock account
```

🔴 **Exam Trap:** `usermod -G developers user` **without `-a`** will **REPLACE** all existing supplementary groups with just `developers` — always use `-aG` (append) unless you intentionally want to overwrite group membership.

---

### 1.3 `userdel` — Delete a user

```bash
userdel veenay              # delete user, KEEP home directory
userdel -r veenay            # delete user AND home directory + mail spool
```

---

### 1.4 `groupadd` / `addgroup` — Create a group

```bash
groupadd developers
addgroup developers          # Debian/Ubuntu equivalent
groupadd -g 1500 developers  # custom GID
```

### 1.5 `groupmod` — Modify a group

```bash
groupmod -n newname oldname   # rename group
groupmod -g 2000 developers   # change GID
```

### 1.6 `groupdel` — Delete a group

```bash
groupdel developers
```

🟠 **Note:** You cannot delete a group that is still set as a user's **primary** group — remove/change that first.

---

## 2. Password, Identity & Login-History Commands

### 2.1 `passwd` — Set/change password

```bash
passwd veenay          # set/change password (as root, for another user)
passwd                 # change your OWN password
passwd -l veenay        # lock account (prepends ! to hash in /etc/shadow)
passwd -u veenay        # unlock account
passwd -e veenay        # force password expiry (must change at next login)
passwd -S veenay        # show password status
```

### 2.2 `chage` — Manage password aging

```bash
chage -l veenay                     # list current aging info
chage -M 90 veenay                   # max 90 days before password must change
chage -m 7 veenay                    # min 7 days before it CAN be changed again
chage -W 7 veenay                    # warn user 7 days before expiry
chage -E 2026-12-31 veenay           # set account expiry date
chage -d 0 veenay                    # force password change at NEXT login
```

| Flag | Meaning                                 |
| ---- | --------------------------------------- |
| `-l` | List aging details                      |
| `-M` | Max days password is valid              |
| `-m` | Min days before change allowed          |
| `-W` | Warning days before expiry              |
| `-E` | Account expiry date                     |
| `-d` | Last change date (0 = force change now) |

---

### 2.3 `id` — Show UID, GID, and groups

```bash
id veenay
# uid=1001(veenay) gid=1001(veenay) groups=1001(veenay),27(sudo),1002(developers)
```

### 2.4 `groups` — Show group memberships

```bash
groups veenay
# veenay : veenay sudo developers
```

### 2.5 `who` — Who is currently logged in

```bash
who
# veenay   tty1    2026-08-11 09:00
```

### 2.6 `whoami` — Show current effective user

```bash
whoami
# veenay
```

💡 Useful after `su`/`sudo` to confirm which user context you're actually in.

### 2.7 `last` — Login history

```bash
last                  # show recent login history (from /var/log/wtmp)
last veenay            # login history for a specific user
last -x                # include shutdown/reboot events
```

🔴 **Exam Trap:** `last` reads from `/var/log/wtmp` — a classic **forensic/log-analysis** question: "How do you check who logged in last week?" → `last`.

### Comparison Table: Identity/Session Commands

| Command  | Purpose                               |
| -------- | ------------------------------------- |
| `id`     | Shows UID, GID, all group memberships |
| `groups` | Shows just the group names            |
| `who`    | Shows who is currently logged in      |
| `whoami` | Shows YOUR current effective username |
| `last`   | Shows login **history** (past logins) |

---

## 3. `/etc/passwd` — User Account Database

**Format:** `username:x:UID:GID:comment:home:shell`

```text
veenay:x:1001:1001:Veenayak:/home/veenay:/bin/bash
```

| Field                   | Meaning                                                  | Example        |
| ----------------------- | -------------------------------------------------------- | -------------- |
| 1. Username             | Login name                                               | `veenay`       |
| 2. Password placeholder | Always `x` — real hash lives in `/etc/shadow`            | `x`            |
| 3. UID                  | User ID (0 = root, 1–999 = system, 1000+ = normal users) | `1001`         |
| 4. GID                  | Primary Group ID                                         | `1001`         |
| 5. Comment (GECOS)      | Full name/description                                    | `Veenayak`     |
| 6. Home directory       | Path to user's home                                      | `/home/veenay` |
| 7. Shell                | Login shell (or `/sbin/nologin` to block login)          | `/bin/bash`    |

🔴 **Exam Trap:** UID `0` = root ALWAYS, regardless of username. If any non-root-named account has UID `0`, that's a major security red flag (backdoor account).

🟠 **Note:** `/sbin/nologin` or `/bin/false` in the shell field = account can't get an interactive shell — common for **service accounts** (e.g., `www-data`, `nginx`).

---

## 4. `/etc/shadow` — Password & Aging Database

**Format:** `username:hash:lastchange:min:max:warn:inactive:expire:reserved`

```text
veenay:$6$abc123...xyz:19850:7:90:7:::
```

| Field            | Meaning                                                   |
| ---------------- | --------------------------------------------------------- |
| 1. Username      | Matches `/etc/passwd`                                     |
| 2. Password hash | Encrypted password (e.g., `$6$` = SHA-512)                |
| 3. Last changed  | Days since Jan 1, 1970 (epoch) when password last changed |
| 4. Min days      | Minimum days before password can change again             |
| 5. Max days      | Maximum days password is valid                            |
| 6. Warn days     | Days before expiry to warn user                           |
| 7. Inactive days | Grace period after expiry before account disabled         |
| 8. Expire date   | Absolute account expiry date (epoch days)                 |
| 9. Reserved      | Unused                                                    |

### Special Hash Field Values

| Value        | Meaning                                                       |
| ------------ | ------------------------------------------------------------- |
| `$6$...`     | Normal encrypted password (SHA-512)                           |
| `!` (prefix) | Account **locked** (e.g., `!$6$abc...`)                       |
| `!!`         | Password never set (new account, no password yet)             |
| `*`          | Login via password disabled entirely (often service accounts) |

🔴 **Exam Trap:** Only **root** should be able to read `/etc/shadow` (permission `640` or `600`, owned by root). If it's world-readable, an attacker can grab password hashes and crack them offline (hashcat/John the Ripper) — classic security audit finding.

### `/etc/passwd` vs `/etc/shadow`

| Feature          | `/etc/passwd`                        | `/etc/shadow`                |
| ---------------- | ------------------------------------ | ---------------------------- |
| Contains         | Account info (UID, GID, home, shell) | Password hash + aging policy |
| Readable by      | All users (world-readable)           | Root only                    |
| Password stored? | No (just `x` placeholder)            | Yes (hashed)                 |

---

## 5. `/etc/group` — Group Database

**Format:** `group_name:x:GID:member_list`

```text
developers:x:1002:veenay,alice,bob
```

| Field                   | Meaning                                         |
| ----------------------- | ----------------------------------------------- |
| 1. Group name           | e.g., `developers`                              |
| 2. Password placeholder | Almost always `x` (group passwords rarely used) |
| 3. GID                  | Group ID                                        |
| 4. Member list          | Comma-separated **supplementary** members       |

🟠 **Note:** A user's **primary** group (set via GID in `/etc/passwd`) does **NOT** need to be listed in the member list of `/etc/group` — only supplementary memberships appear there.

---

## 6. `su` vs `sudo`

| Feature                 | `su`                             | `sudo`                                              |
| ----------------------- | -------------------------------- | --------------------------------------------------- |
| Password required       | **Target user's** password       | **Your own** password                               |
| Switches full identity? | Yes, becomes that user           | Runs single command as another user (usually root)  |
| Logging                 | Minimal by default               | Detailed logging in `/var/log/auth.log` or `secure` |
| Typical use             | `su - root` to become root fully | `sudo apt update` for one-off admin commands        |
| Config file             | None (PAM-based)                 | `/etc/sudoers` (fine-grained control)               |

```bash
su root          # switch to root, needs ROOT's password
sudo apt update   # run one command as root, needs YOUR OWN password
```

🔴 **Exam Trap (very common Viva Q):** _"Why is `sudo` generally considered safer than `su`?"_
→ `sudo` requires the **user's own password** (root password stays secret/unused), logs every command run, and can be restricted to specific commands via `/etc/sudoers` — `su` gives full, unrestricted root access with no command-level logging by default.

---

## 7. `su -` vs `su`

```bash
su veenay      # switch user, but KEEP current shell's environment
su - veenay    # switch user with a FULL LOGIN shell (fresh environment)
```

| Feature                                    | `su user`                                                 | `su - user`                                |
| ------------------------------------------ | --------------------------------------------------------- | ------------------------------------------ |
| Environment variables                      | Inherited from current shell (old `$PATH`, `$HOME`, etc.) | Reset to the target user's own environment |
| Working directory                          | Stays in current directory                                | Changes to target user's home directory    |
| Runs login scripts (`.bash_profile`, etc.) | ❌ No                                                     | ✅ Yes                                     |

🔴 **Exam Trap:** `su - user` is the "correct"/safe way to fully become another user (especially root) — using plain `su user` can carry over the wrong `$PATH`, potentially running unintended binaries (a security risk known as PATH-based privilege confusion).

💡 **Memory trick:** the `-` = "start fresh, like a real login."

---

## 8. `/etc/sudoers` & `visudo`

### 8.1 Why use `visudo` instead of editing directly?

```bash
visudo    # ALWAYS use this to edit /etc/sudoers
```

`visudo` **locks the file** while editing and **checks syntax** before saving — a broken `/etc/sudoers` file (e.g., from a typo) can lock EVERYONE out of `sudo`, including root recovery via sudo. Never use `vim /etc/sudoers` directly.

### 8.2 Key Syntax Examples

```text
# user   host = (runas) commands
veenay   ALL = (ALL) ALL              # veenay: full sudo, any host, any user, any command

%wheel   ALL=(ALL) ALL                 # any user in "wheel" group: full sudo

veenay   ALL=(ALL) NOPASSWD: ALL       # sudo WITHOUT password prompt (risky!)

veenay   ALL=(ALL) /usr/bin/systemctl restart nginx   # sudo for ONE specific command only
```

| Part            | Meaning                                      |
| --------------- | -------------------------------------------- |
| `%wheel`        | `%` prefix = this is a **group**, not a user |
| `ALL` (host)    | Applies on any host machine                  |
| `(ALL)`         | Can run command as any target user           |
| `ALL` (command) | Any command allowed                          |
| `NOPASSWD:`     | Skips password prompt — use very sparingly   |

🔴 **Exam Trap:** `NOPASSWD` sudo access is a major security risk if the account is ever compromised — an attacker gets instant root with no extra credential needed. Restrict it to very specific commands/scripts only, never `ALL`.

🟠 **Note:** The `wheel` group is the traditional Linux/Unix group whose members are allowed to `su`/`sudo` to root — common on RHEL/CentOS. Debian/Ubuntu often use the `sudo` group instead.

---

## 9. Primary vs Supplementary Groups

- **Primary group**: Every user has exactly **ONE**. Defined by the GID field in `/etc/passwd`. New files created by the user get this group by default.
- **Supplementary (secondary) groups**: A user can belong to **MANY**. Listed in `/etc/group`'s member list. Used to grant extra access (e.g., `sudo`, `developers`, `docker`).

```bash
id veenay
# uid=1001(veenay) gid=1001(veenay) groups=1001(veenay),27(sudo),1002(developers)
#                   ^^^^^^^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#                   primary group      ALL groups (primary + supplementary)

groups veenay
# veenay : veenay sudo developers
```

### `newgrp` — Temporarily switch active primary group

```bash
newgrp developers    # starts a new shell where "developers" is the ACTIVE primary group
```

- Useful when a user is in multiple groups but needs new files to be created with a **different** group ownership temporarily, without permanently changing their primary group.
- Exit the shell (`exit`) to return to the original group context.

### Comparison Table

| Feature            | Primary Group              | Supplementary Group                              |
| ------------------ | -------------------------- | ------------------------------------------------ |
| Count per user     | Exactly 1                  | 0 or more                                        |
| Defined in         | `/etc/passwd` (GID field)  | `/etc/group` (member list)                       |
| New file ownership | Uses this group by default | Not used unless via `newgrp` or explicit `chgrp` |
| View via           | `id -g`                    | `id -G` or `groups`                              |

🔴 **Exam Trap:** `id -g` shows only the **primary** group; `id -G` (capital G) shows **all** groups (primary + supplementary). Common command-flag confusion in Viva.

---

## 10. Quick-Fire Viva Q&A

| Question                                                            | Answer                                                                                     |
| ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Difference between `useradd` and `adduser`?                         | `useradd` = low-level, non-interactive; `adduser` = interactive script (Debian/Ubuntu)     |
| How to add a user to a group WITHOUT removing existing groups?      | `usermod -aG groupname username` (always use `-a`)                                         |
| What does `userdel -r` do differently from plain `userdel`?         | `-r` also deletes the user's home directory and mail spool                                 |
| Where is the password hash actually stored?                         | `/etc/shadow`, NOT `/etc/passwd`                                                           |
| What does `!` at the start of the hash field in `/etc/shadow` mean? | Account is locked                                                                          |
| Difference between `su` and `sudo`?                                 | `su` needs the target user's password; `sudo` needs your own password                      |
| Why use `su -` instead of `su`?                                     | `su -` gives a full login shell with a clean environment; plain `su` inherits old env vars |
| Why always use `visudo` to edit sudoers?                            | It locks the file and validates syntax before saving, preventing lockouts                  |
| What does `NOPASSWD` in sudoers do?                                 | Allows sudo without prompting for a password — high risk if overused                       |
| How many primary groups can a user have?                            | Exactly one                                                                                |
| Command to see a user's login history?                              | `last username`                                                                            |
| Command to see who is CURRENTLY logged in?                          | `who`                                                                                      |
| Which UID is always root?                                           | `0`                                                                                        |
| What shell blocks interactive login for service accounts?           | `/sbin/nologin` or `/bin/false`                                                            |

---

## 11. One-Page Summary Table

| Task                            | Command                            |
| ------------------------------- | ---------------------------------- |
| Create user                     | `useradd -m -s /bin/bash username` |
| Modify user's groups (append)   | `usermod -aG groupname username`   |
| Delete user + home dir          | `userdel -r username`              |
| Create group                    | `groupadd groupname`               |
| Add user to group               | `gpasswd -a username groupname`    |
| Set/change password             | `passwd username`                  |
| Lock/unlock account             | `passwd -l` / `passwd -u` username |
| Set password aging              | `chage -M 90 -m 7 -W 7 username`   |
| View UID/GID/groups             | `id username`                      |
| View login history              | `last username`                    |
| Switch user (full env)          | `su - username`                    |
| Run one command as root         | `sudo command`                     |
| Edit sudo permissions safely    | `visudo`                           |
| Temporarily switch active group | `newgrp groupname`                 |
