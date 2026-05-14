## 1) Remote login and file transfer

### `telnet`

Connects to a remote host using the Telnet protocol. It is **not secure** because data is sent in plain text.

```bash
telnet example.com 23
```

### `ftp`

Transfers files to and from an FTP server. Also **not secure** because it does not encrypt data.

```bash
ftp ftp.example.com
```

### `ssh`

Securely logs in to a remote machine using encryption.

```bash
ssh user@192.168.1.10
```

### `sftp`

Secure file transfer over SSH.

```bash
sftp user@192.168.1.10
```

Inside `sftp`:

```bash
put file.txt
get report.pdf
```

### `finger`

Shows information about a user, such as login name and last login. It may not be installed on many systems.

```bash
finger john
```

---

## 2) File and directory commands

### `ls`

Lists files and directories.

```bash
ls
ls -l
ls -la
```

### `cp`

Copies files or directories.

```bash
cp file1.txt file2.txt
cp -r folder1 folder2
```

### `mv`

Moves or renames files and directories.

```bash
mv oldname.txt newname.txt
mv file.txt /tmp/
```

### `rm`

Removes files.

```bash
rm file.txt
rm -r folder1
rm -f file.txt
```

### `mkdir`

Creates a directory.

```bash
mkdir mydir
mkdir -p a/b/c
```

### `rmdir`

Removes an empty directory.

```bash
rmdir mydir
```

### `cd`

Changes the current directory.

```bash
cd /etc
cd ..
cd ~
```

### `pwd`

Prints the current working directory.

```bash
pwd
```

### `ln`

Creates a hard link.

```bash
ln file1.txt file2.txt
```

### `ln -s`

Creates a symbolic link.

```bash
ln -s /var/log/syslog loglink
```

---

## 3) Viewing and reading files

### `cat`

Displays file contents or joins files.

```bash
cat file.txt
cat file1.txt file2.txt
```

### `tac`

Displays file contents in reverse line order.

```bash
tac file.txt
```

### `more`

Shows file content one screen at a time.

```bash
more file.txt
```

### `head`

Shows the first lines of a file.

```bash
head file.txt
head -n 5 file.txt
```

### `tail`

Shows the last lines of a file.

```bash
tail file.txt
tail -n 10 file.txt
tail -f /var/log/syslog
```

### `man`

Displays the manual page for a command.

```bash
man ls
man grep
```

### `whatis`

Gives a one-line description of a command.

```bash
whatis ls
```

### `whereis`

Shows locations of a command’s binary, source, and manual page.

```bash
whereis gcc
```

### `locate`

Finds files quickly using a database.

```bash
locate passwd
```

### `find`

Searches for files in the directory tree.

```bash
find /home -name "*.txt"
find . -type f
```

### `diff`

Compares two files line by line.

```bash
diff file1.txt file2.txt
```

### `file`

Shows the file type.

```bash
file test.txt
file /bin/ls
```

---

## 4) Searching and text processing

### `grep`

Searches for text inside files.

```bash
grep "error" logfile.txt
grep -i "linux" notes.txt
grep -n "root" /etc/passwd
```

### `sort`

Sorts lines of text.

```bash
sort names.txt
sort -r names.txt
sort -n numbers.txt
```

### `wc`

Counts lines, words, and characters.

```bash
wc file.txt
wc -l file.txt
wc -w file.txt
```

---

## 5) Compression and archiving

### `gzip`

Compresses a file.

```bash
gzip file.txt
```

This creates `file.txt.gz`.

### `gunzip`

Decompresses a `.gz` file.

```bash
gunzip file.txt.gz
```

### `zip`

Compresses files into a `.zip` archive.

```bash
zip archive.zip file1.txt file2.txt
```

### `unzip`

Extracts files from a `.zip` archive.

```bash
unzip archive.zip
```

### `tar`

Archives files and directories.

Create a tar archive:

```bash
tar -cvf backup.tar folder/
```

Extract a tar archive:

```bash
tar -xvf backup.tar
```

Create compressed tar archive with gzip:

```bash
tar -czvf backup.tar.gz folder/
```

Extract compressed tar archive:

```bash
tar -xzvf backup.tar.gz
```

Create compressed tar archive with bzip2:

```bash
tar -cjvf backup.tar.bz2 folder/
```

Extract bzip2 archive:

```bash
tar -xjvf backup.tar.bz2
```

---

## 6) Working with compressed text

### `zcat`

Displays contents of a `.gz` file without uncompressing it first.

```bash
zcat file.txt.gz
```

---

## 7) Date and calendar

### `cal`

Shows the calendar.

```bash
cal
cal 2026
cal 5 2026
```

### `date`

Displays or sets the system date and time.

```bash
date
date "+%d-%m-%Y"
```

### `time`

Measures how long a command takes.

```bash
time ls -l
```

---

## 8) Math and display tools

### `bc`

A calculator in the shell.

```bash
bc
5+3
```

### `bc -l`

Starts `bc` with the math library for advanced calculations.

```bash
bc -l
sqrt(25)
```

### `banner`

Prints large text characters. It may not be installed on every system.

```bash
banner HELLO
```

---

## 9) File creation and output

### `touch`

Creates an empty file or updates the timestamp of an existing file.

```bash
touch newfile.txt
```

### `echo`

Prints text to the screen.

```bash
echo "Hello Linux"
echo $HOME
```

---

## 10) User and system information

### `who`

Shows users currently logged in.

```bash
who
```

### `finger`

Shows detailed user information.

```bash
finger
finger alice
```

### `w`

Shows who is logged in and what they are doing.

```bash
w
```

### `whoami`

Displays your effective username.

```bash
whoami
```

### `who am i`

Shows information about your current login session.

```bash
who am i
```

---

## 11) Aliases

### `alias`

Creates a shortcut for a command.

```bash
alias ll='ls -l'
alias rm='rm -i'
```

### `unalias`

Removes an alias.

```bash
unalias ll
```

---

## 12) Directory stack commands

You wrote `push` and `pop`, which usually means:

### `pushd`

Saves the current directory and changes to another one.

```bash
pushd /etc
```

### `popd`

Returns to the previous directory from the directory stack.

```bash
popd
```

---

## 13) Jobs and process commands

### `jobs`

Shows background jobs in the current shell.

```bash
jobs
```

### `ps`

Shows running processes.

```bash
ps
ps -ef
ps aux
```

Useful examples:

```bash
ps -ef | grep ssh
```

---

## OpenSSH

OpenSSH is a free, open-source implementation of the SSH protocol for secure remote login, file transfer, and tunneling over networks. It replaces insecure tools like Telnet by encrypting all communication on TCP port 22.

### Core Components

The **client** (`ssh`, `scp`, `sftp`) initiates connections from your machine. The **server** (`sshd`) runs on remote hosts, listening for encrypted sessions with authentication via passwords or public keys.

Key directives in `/etc/ssh/sshd_config`:

- `Port 22`: Listening port (change for security).
- `PermitRootLogin no`: Blocks root logins.
- `PasswordAuthentication yes/no`: Enables/disables passwords.
- `PubkeyAuthentication yes`: Allows key-based auth.
- Restart with `sudo systemctl restart sshd` after edits.

### Client Usage

- Connect: `ssh user@hostname` or `ssh user@192.168.1.100`.
- Copy files: `scp localfile user@host:/path/`.
- Secure copy: `sftp user@host` (like FTP but encrypted).

### Key-Based Authentication

- Generate keys: `ssh-keygen -t ed25519` (modern, secure).
- Copy public key: `ssh-copy-id user@host`.
- Now log in without passwords—private key stays on client.

### Server Setup (Ubuntu/Debian)

```bash
sudo apt update && sudo apt install openssh-server
sudo systemctl enable --now ssh
sudo ufw allow 22
```

Verify: `ss -tlnp | grep :22`. Test from another machine: `ssh user@your-ip`.

### Security Best Practices

- Use keys over passwords.
- Disable root login and password auth.
- Change default port.
- Install fail2ban for brute-force protection.
- Keep updated: `sudo apt upgrade openssh-server`.

For your CDAC labs, this covers OpenSSH configuration from the previous network theory context. Run `man sshd_config` locally for full options.

## VNC

VNC (Virtual Network Computing) is a remote desktop technology that lets you see and control another computer’s graphical desktop over the network, using the RFB (Remote Frame Buffer) protocol.

### What VNC Does

- A **VNC server** runs on the remote machine you want to control (e.g., your Linux lab VM).
- A **VNC viewer/client** runs on your local machine (Windows, Linux, macOS, even browser).
- The server sends screen updates to the viewer; the viewer sends keyboard/mouse input back to the server, so it feels like you are sitting at the remote machine.

VNC typically uses TCP port `5900 + display_number` (for example, `:1` = port 5901); some servers also offer a web viewer on `5800 + display_number`.

### Security Aspect

By default, classic VNC uses simple password auth and very weak or no encryption, so on its own it is **not** as secure as SSH.

Common best practice (what your syllabus hints): run VNC on localhost only and tunnel it through OpenSSH for encryption.

Example secure setup:

- Start VNC server on remote: `vncserver :1` → listens on `127.0.0.1:5901`.
- On your local machine:
  ```bash
  ssh -L 5901:localhost:5901 user@server-ip
  ```
- Open your viewer to `localhost:5901`; traffic is now encrypted inside SSH.

### Typical Linux Lab Workflow

For a CDAC-style lab on Ubuntu:

1. Install a VNC server (e.g., TigerVNC, TightVNC):

   ```bash
   sudo apt install tigervnc-standalone-server
   vncpasswd      # set VNC password
   vncserver :1   # starts server on display :1 (port 5901)
   ```

2. From Windows host: install a viewer (RealVNC Viewer, TightVNC Viewer), then connect to:
   - `server-ip:1` (direct, not encrypted), **or**
   - `localhost:5901` after creating an SSH tunnel for secure access (recommended).

3. Once connected, you see the remote desktop (e.g., XFCE, GNOME) and can open terminals, browsers, editors etc., as if physically at the lab machine.

---

To tie this into your assignment: how would you explain, in your own words, the difference between using OpenSSH and using VNC for remote access to a Linux server?

For theory exam, this PDF is basically giving you **points to write** about two main topics:

1. **User & Group Management**
2. **Disk Management + fdisk/gdisk/LVM labs**

Let’s turn each into theory-style answers you can remember and write.

---

## 1. User & Group Management (theory view)

Linux is **multi‑user**, so it needs a way to manage many users and control access using groups.

### User management – important points

- **Account creation**
  - `useradd username`: low-level tool to create a user.
  - `adduser username`: Debian/Ubuntu friendly wrapper (interactive).
  - After that: `passwd username` to set password.
  - Theory line: “User accounts are created using useradd/adduser and secured with passwords via passwd.”

- **Modify user**
  - `usermod -s /bin/bash username`: change login shell.
  - `usermod -aG groupname username`: add user to supplementary group.
  - `usermod -L username`: lock account (disables password login).

- **Delete user**
  - `userdel username`: remove account only.
  - `userdel -r username`: also removes home directory.

- **User info files & commands**
  - `/etc/passwd`: stores username, UID, GID, home, shell.
  - `/etc/shadow`: stores **hashed** passwords, readable only by root.
  - `id username`: shows UID, primary GID, all groups.
  - `who`, `whoami`, `w`: show logged-in users / current user.

In exam: define these files and commands and mention that they are used for identifying and controlling users.

### Group management – important points

Groups let you **assign permissions to many users at once**.

- **Create group**
  - `groupadd groupname`.

- **Add / remove user in group**
  - `gpasswd -a username groupname`: add user to group.
  - `gpasswd -d username groupname`: remove user from group.

- **Change primary group**
  - `usermod -g groupname username`: sets primary group.

- **Delete group & view**
  - `groupdel groupname`: delete group.
  - `groups username`: list groups of a user.
  - `cat /etc/group`: view all groups on system.

These are typical short theory questions: “Command to add a user to a group?”, “File containing group information?”, etc.

---

## 2. Disk Management – concepts for theory

PDF next talks about **MBR, GPT, filesystem types, and tools**.

### Partition table types

- **MBR (Master Boot Record)**
  - Old / legacy partitioning.
  - Maximum **4 primary partitions** on a disk.
  - Supports disks **up to 2 TB**.

- **GPT (GUID Partition Table)**
  - Modern standard, part of UEFI.
  - Supports **more than 128 partitions**.
  - Supports disks **larger than 2 TB**.

### Filesystem types (just list in exam)

Common Linux / dual‑boot filesystems:

- `ext4`, `xfs`, `btrfs`, `FAT32`, `NTFS`.

### Disk info commands

Tools for checking storage:

- `lsblk`: list block devices (disks and partitions).
- `blkid`: show UUIDs and filesystem types.
- `df -h`: show disk space usage of mounted partitions.
- `mount`, `umount`: attach/detach filesystems.

---

## 3. fdisk, gdisk, formatting, mounting (lab but also theory)

### fdisk – MBR partitioning

- Used on `/dev/sdX` for **MBR** disks.
- Typical options (they love these in viva/theory):
  - `n`: create new partition
  - `d`: delete partition
  - `p`: print partition table
  - `w`: write changes to disk

Command: `fdisk /dev/sdX`.

### gdisk – GPT partitioning

- Used on `/dev/sdX` with GPT disks.
- Similar interactive style to fdisk but supports GPT.
- Command: `gdisk /dev/sdX`.

### Format & mount partition

Once a partition exists (like `/dev/sdX1`):

- Create filesystem:
  `mkfs.ext4 /dev/sdX1`
- Mount it:
  `mount /dev/sdX1 /mnt`
- Unmount:
  `umount /mnt`

In theory: “Steps to make a new partition usable: create partition (fdisk/gdisk) → format (mkfs.ext4) → mount.”

---

## 4. LVM (Logical Volume Manager) – high‑level theory

LVM gives **flexible disk management** by separating physical disks from logical volumes.

### Components

- **PV (Physical Volume)**: e.g., `/dev/sdb1` – a disk or partition prepared for LVM.
- **VG (Volume Group)**: pool of storage created from one or more PVs (e.g., `my_vg`).
- **LV (Logical Volume)**: “virtual partition” created inside a VG; you format & mount it like a normal partition.

### Typical workflow (you can describe steps in words)

Commands from the PDF:

```bash
pvcreate /dev/sdb1
vgcreate my_vg /dev/sdb1
lvcreate -L 5G -n my_lv my_vg
mkfs.ext4 /dev/my_vg/my_lv
mount /dev/my_vg/my_lv /mnt
```

Theory description:

1. Convert a partition to a PV with `pvcreate`.
2. Create a VG from one or more PVs with `vgcreate`.
3. Create an LV of required size with `lvcreate`.
4. Create filesystem and mount LV.

Useful commands to mention:

- `vgs`, `lvs`, `pvs`: show information about volume groups, logical volumes, and physical volumes.
- `lvextend`, `lvreduce`: change size of logical volumes.
- `vgextend`, `vgreduce`: add/remove PVs to/from VG.

---

## 1. Network Implementation (Linux)

Linux uses config files + commands to set up and troubleshoot networking.

### Important network config files

You can write a small table in the exam:

- `/etc/hostname` – stores the system hostname (machine name).
- `/etc/hosts` – static mapping of hostname ↔ IP, used for local name resolution.
- `/etc/network/interfaces` – Debian/Ubuntu style interface config.
- `/etc/sysconfig/network-scripts/ifcfg-*` – Red Hat/CentOS/RHEL style interface config files.
- `/etc/resolv.conf` – DNS server addresses (nameservers).

### Important network commands

These commands are used to view and test network settings:

- `ip a` – show IP addresses on all interfaces.
- `ip r` – show routing table.
- `ip link` – show network interfaces and link state.
- `nmcli` – manage NetworkManager (create, modify connections).
- `ifconfig` – legacy command for interface configuration (older tool).
- `ping`, `traceroute` – test connectivity and path to remote host.

You can add: “Network security is implemented using firewall tools like `iptables` or `firewalld`, and tools like `fail2ban` can block malicious IPs automatically.”

---

## 2. Print Services (CUPS)

Linux printing is usually handled by **CUPS (Common Unix Printing System)**.

### CUPS features

- Provides a **web interface** at `http://localhost:631` for managing printers and jobs.
- Supports **IPP (Internet Printing Protocol)** for network printing.
- Can share printers using Samba, LPD, or IPP for network clients.

### Print commands to remember

- `lp file.txt` – send a file to the default printer.
- `lpstat -p` – list printers and their status.
- `lpq` – view the print queue.
- `cancel <job-id>` – cancel a specific print job.
- `lpadmin -p printer_name` – add or manage printers (admin-level command).

Main config file:

- `/etc/cups/cupsd.conf` – core CUPS server configuration file.

These are classic short questions: “Name the configuration file of CUPS”, “Command to check print queue”, etc.

---

## 3. Service Management (systemd + older tools)

Modern Linux distros (Ubuntu, RHEL 7+, etc.) use **systemd** for service and boot management.

### systemd / systemctl commands

Examples given with `apache2.service`, but same pattern for any service:

- `systemctl start apache2.service` – start the service now.
- `systemctl stop apache2.service` – stop the service.
- `systemctl restart apache2.service` – restart service.
- `systemctl enable apache2` – enable at boot (auto-start).
- `systemctl disable apache2` – disable auto-start at boot.
- `systemctl status apache2` – show status, logs summary, PID, etc.

Theory line: “systemd is the init system that manages services via systemctl.”

### Older tools (init / service)

Older or SysV-style systems use `service` and `chkconfig`:

- `service apache2 start` – start service (older style wrapper).
- `chkconfig --list` – list services and their boot levels.

You can mention: “On legacy distributions, SysV init scripts and tools like service and chkconfig are used instead of systemd.”

---

## 4. System Configuration Files (very common theory table)

This part is very exam-friendly: they can ask “write any four important system configuration files and their purpose”.

From the PDF:

- `/etc/fstab` – defines filesystems to mount automatically at boot.
- `/etc/hostname` – sets the system hostname.
- `/etc/hosts` – static host name ↔ IP mappings.
- `/etc/passwd` – basic user account information.
- `/etc/group` – group definitions.
- `/etc/shadow` – hashed user passwords (secure, root-only).
- `/etc/resolv.conf` – DNS name servers.
- `/etc/network/interfaces` or `/etc/sysconfig/network-scripts/ifcfg-*` – network interface configs (Debian vs RedHat style).
- `/etc/sysctl.conf` – kernel parameters (network, memory, etc.).
- `/etc/crontab` – system-wide scheduled jobs (cron).

### sysctl usage (kernel parameters)

- Change at runtime:
  `sysctl -w net.ipv4.ip_forward=1` (enables IP forwarding temporarily).
- Make permanent:
  `echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf` then `sysctl -p` to reload.

In theory, you can say:

“`sysctl` is used to view and modify kernel parameters at runtime; `/etc/sysctl.conf` stores persistent settings like `net.ipv4.ip_forward`.”

---

## 1. Patches in Linux

**Definition (must write):**

A _patch_ is a small update applied to software or kernel to fix bugs, add new features, or close security vulnerabilities. It can be applied to **source code**, **packages**, or even **binaries**.

### Types of patches

You can list like this in the exam:

- **Security patches** – fix vulnerabilities (CVE issues) to protect the system.
- **Bug-fix patches** – correct software errors/defects.
- **Feature patches** – add or change functionality.
- **Kernel patches** – modify the Linux kernel (e.g., tools like kpatch, kgraft for live kernel patching).

### Applying and creating patches (source code level)

- Apply a patch to source code:
  `patch < original.patch` – uses the `patch` tool to modify files based on a patch file.
- Create a patch:
  `diff -u original_file updated_file > patch.diff` – unified diff between old and new file, saved as a patch.

### Patch management tools (package level)

You can make a small table or bullet points:

- `patch` – apply patch files to source code.
- `yum update` / `apt upgrade` – apply package updates that include patches.
- `kpatch`, `kgraft` – live kernel patching, allows applying kernel patches **without reboot**.
- `dnf-automatic`, `unattended-upgrades` – automate applying updates/patches.

For theory, they might ask: _“What is a patch? Name any two patch management tools in Linux.”_

---

## 2. System Management (overview answer)

System management in Linux means administering **system-wide configurations, users, services, storage, logs, networking, and updates**.

You can list major tasks with associated commands (this is very exam-friendly):

1. **User & Group Management** – `useradd`, `passwd`, `usermod`, `groupadd`.
2. **Service Management** – `systemctl`, `service` to start/stop/enable services.
3. **Package Management** – `apt`, `dnf`, `yum`, `zypper`, `pacman` for installing/updating software.
4. **Scheduled Jobs** – `cron`, `at`, `systemd` timers for automating tasks.
5. **Disk & Filesystem Management** – `lsblk`, `mount`, `fdisk`, `lvm`, `df`, `du`.
6. **Monitoring Tools** – `top`, `htop`, `vmstat`, `iostat`, `free`, `uptime` to monitor CPU, memory, IO, and system load.
7. **System Logs** – stored under `/var/log/` (e.g., `syslog`, `auth.log`, `dmesg`, `messages`).
8. **Backup and Recovery** – `rsync`, `tar`, `timeshift`, `Deja Dup`.
9. **Networking** – `ip`, `nmcli`, `hostname`, `ifconfig`, `netstat`.
10. **Boot & Kernel Management** – `grub`, `initrd`, `systemd`, `sysctl`.

For a long-answer question “Explain system management tasks in Linux”, this list with 1–2 lines each is perfect.

---

## 3. X Configuration Server (X.Org / X11)

This part is about the **graphical system** in Linux.

### What is X Server?

- X server (X.Org Server) is the **core component of the traditional Linux graphical stack**.
- It is responsible for:
  - Handling **input devices** (mouse, keyboard)
  - Managing **display output** (monitor)
  - Drawing windows and moving them on the screen.

### Important X configuration files

You can list 3–4 files:

- `/etc/X11/xorg.conf` – manual X server configuration (rarely used nowadays; modern systems auto-configure).
- `/etc/X11/xorg.conf.d/` – directory containing extra configuration snippets.
- `~/.xinitrc` – user’s X session startup script (what to run when X starts).
- `~/.Xresources` – per-user settings for GUI appearance (fonts, colors, etc.).

### Useful X-related commands

- `startx` – start an X session from the console.
- `xrandr` – configure display resolution, orientation, and multiple screens.
- `xinput` – manage input devices (mouse, keyboard).
- `glxinfo` – show information about OpenGL / 3D acceleration.
- `xev` – event tester, shows keyboard/mouse events.

### Display managers and desktops

- **Display managers**: GUI login managers like **GDM**, **LightDM**, **SDDM**.
- **Desktop environments**: Built on X (GNOME, KDE, XFCE, etc.).

### Wayland mention (modern note)

- **Wayland** is a modern alternative to X11, designed for better security and performance.
- Many modern distros support both; GNOME often uses Wayland as default.

Exam-style question could be:

- “What is X server? Name any two files used to configure X.”
- “What is Wayland and how is it related to X?”

---

## 1. Performance Tuning (Theory view)

**Definition:** Process of optimizing system performance by adjusting hardware/software parameters to achieve efficiency and responsiveness.

### Exam points to write:

- **Goals:** Reduce latency, maximize throughput, ensure efficient resource utilization, improve system stability, and reduce downtime.
- **Key Areas:**
  - CPU: Load balancing, processor affinity.
  - Memory: Swap usage, buffer management.
  - Disk I/O: Filesystem, RAID, block size.
  - Network: TCP stack tuning, bandwidth.
- **Common tools:** `top`/`htop` (CPU/RAM), `vmstat` (memory), `iotop` (Disk), `netstat`/`ss` (network), `perf` (performance counters), `sysctl` (kernel tuning).

---

## 2. System Maintenance & Troubleshooting

**Maintenance definition:** Regular activities to ensure systems are secure, up-to-date, stable, and optimized.

### Exam points to write:

- **Types of Maintenance:**
  1. Preventive (backups, patches).
  2. Corrective (fixing failing services).
  3. Adaptive (scaling for new needs).
  4. Perfective (improving usability).
- **Troubleshooting Approach (Standard 5-step process):**
  1. Identify the problem (symptoms/logs).
  2. Isolate the cause (check logs like `/var/log/syslog`).
  3. Implement a fix.
  4. Test the fix.
  5. Document the solution.

---

## 3. Threat Model and Protection Methods

**Threat Model definition:** Structured representation of threats to a system, detailing attack surfaces, vulnerabilities, and defenses.

### Exam points to write:

- **Elements:** Assets, Adversaries, Entry Points (ports), Attack Vectors, Countermeasures.
- **Frameworks:**
  - **STRIDE:** Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege.
  - **DREAD:** Damage, Reproducibility, Exploitability, Affected users, Discoverability.
- **Protection Methods (Table format for exam):**
  - Authentication: MFA, strong passwords.
  - Authorization: RBAC.
  - Data Security: Encryption (TLS, GPG), backups.
  - Network Security: Firewalls, IDS/IPS, VPN.
  - Monitoring: SIEM, audit logs.

---

