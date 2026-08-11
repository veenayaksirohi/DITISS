# Linux Boot Process & Systemd — Study Notes
**Quick Revision Guide for Exam / Viva Prep**

---

## 1. Key Abbreviations

| Abbreviation | Full Form |
|---------------|-----------|
| BIOS | Basic Input Output System |
| UEFI | Unified Extensible Firmware Interface |
| MBR | Master Boot Record |
| GPT | GUID Partition Table |
| GUID | Globally Unique Identifier |
| GRUB | Grand Unified Bootloader |
| FHS | Filesystem Hierarchy Standard |
| LVM | Logical Volume Manager |
| PV/VG/LV | Physical Volume / Volume Group / Logical Volume |

---

## 2. Core Booting Concepts

| Term | Meaning |
|------|---------|
| **Booting** | The process from computer power-on to OS startup |
| **Bootable device** | A storage device (disk, USB, CD/DVD) whose boot block contains a bootstrap program |
| **Bootstrap program** | Loads the OS kernel into RAM and starts execution; different per OS/version; located in the **first sector (512 bytes)** of a disk/partition |
| **Bootloader program** | Shows multiple boot options to the user; based on selection, runs the corresponding bootstrap program |
| **Firmware** | Set of programs fixed in Base ROM (motherboard) — BIOS or UEFI |
| **Bootstrap loader** | A program from firmware that finds the bootable device (as per boot device priority in BIOS/UEFI setup) and starts its bootloader |

### Well-Known Bootloaders (by OS)

| Bootloader | OS |
|------------|-----|
| `ntldr` → `boot.ini` | Windows (before Vista) |
| `bootmgr` → `bcd` | Windows (Vista onwards); managed via `bcdedit` |
| **LiLo** (Linux Loader) | Older Linux |
| **GRUB** → `menu.lst`/`grub.cfg` | Modern Linux |
| BTX (BooT eXtended) | BSD Unix |
| SILO (Sparc Interactive Loader) | Solaris |
| Bootcamp | Mac OS X |
| uBoot | Embedded Linux |

🔴 **Exam Trap:** Bootstrap ≠ Bootloader. **Bootstrap program** = fixed, tiny, loads the next stage; **Bootloader program** = the user-facing menu (e.g., GRUB screen) that lets you pick an OS/kernel.

---

## 3. BIOS vs UEFI

### BIOS (Basic Input Output System)
- Firmware standard stored on the motherboard's ROM chip.
- Runs on power-on: tests hardware, then runs the bootloader.
- Has access to basic input device ports (keyboard, mouse).
- Dominant standard for decades; being replaced by UEFI.

**Functions:** Initialize hardware (CPU, RAM, disk) → Perform **POST** (Power-On Self Test) → Load bootloader from disk.

### UEFI (Unified Extensible Firmware Interface)
- Modern replacement for BIOS.
- Runs **faster**, supports more memory, larger storage drives, more hardware types, and better security.
- Most modern motherboards/PCs ship with UEFI by default.

**Functions:** Initialize hardware → Load OS → Provide advanced features (Secure Boot, network boot, etc.)

**EFI Partition:** Special partition at `/boot/efi` — stores bootloader files, used exclusively by UEFI systems.

### Comparison Table

| Feature | BIOS | UEFI |
|---------|------|------|
| Age | Older (legacy) | Modern replacement |
| Speed | Slower | Faster |
| Max disk size supported | ~2TB (MBR limit) | Much larger (GPT) |
| Security | Basic | **Secure Boot** support |
| Partition table used | MBR | GPT |
| Boot storage | Boot sector (512B) | EFI partition (`/boot/efi`) |
| Network boot | Limited | ✅ Supported |

🔴 **Exam Trap:** UEFI's **Secure Boot** feature verifies that only digitally-signed/trusted bootloaders and kernels can run — protects against bootkit malware. Classic security interview question.

---

## 4. GRUB / GRUB2 — Boot Loader Deep Dive

GRUB (**GR**and **U**nified **B**ootloader) works in **stages**, loading the OS progressively:

| Stage | Component | Function |
|-------|-----------|----------|
| 1 | **Boot sector program** | Fixed 512-byte program loaded by firmware on startup; loads the second-stage bootloader (can also load another sector or a kernel directly) |
| 2 | **Second-stage boot loader** | Loads the operating system; contains a **kernel loader** |
| 3 | **Boot loader installer** | Controls installation of drive sectors; only runs when booting from a drive; coordinates boot sector + boot loader activities |

### GRUB2 Configuration

| Item | Detail |
|------|--------|
| Config file location | `/boot/grub2/grub.cfg` (RHEL/CentOS) or `/boot/grub/grub.cfg` (Debian/Ubuntu) |
| Template/source file | `/etc/default/grub` (edit this, NOT `grub.cfg` directly) |
| Regenerate config | `grub2-mkconfig -o /boot/grub2/grub.cfg` (RHEL) or `update-grub` (Debian) |

```bash
# /etc/default/grub — common settings
GRUB_TIMEOUT=5            # seconds to show boot menu before default boots
GRUB_DEFAULT=0            # which menu entry boots by default (0 = first)
GRUB_CMDLINE_LINUX="..."  # kernel boot parameters
```

🔴 **Exam Trap:** Never hand-edit `grub.cfg` directly — it's **auto-generated**. Edit `/etc/default/grub`, then regenerate with `grub2-mkconfig` / `update-grub`. Any manual edit to `grub.cfg` gets overwritten on the next regeneration.

### GRUB Rescue Mode

- If GRUB fails to find its config or the boot files are corrupted, it drops into **GRUB rescue mode** — a minimal command-line prompt (`grub rescue>`).
- Used to manually locate the boot partition and repair GRUB.

```bash
grub rescue> ls                        # list available partitions
grub rescue> set root=(hd0,1)          # manually set root partition
grub rescue> set prefix=(hd0,1)/boot/grub
grub rescue> insmod normal
grub rescue> normal
```

🟠 **Note:** GRUB rescue mode is a common real-world troubleshooting scenario — e.g., after a dual-boot Windows install overwrites the MBR/GRUB.

---

## 5. Full Boot Sequence (High-Level)

```text
BIOS/UEFI → MBR/GPT → GRUB2 → Kernel → initramfs → systemd → Target → Login
```

| Stage | What happens |
|-------|----------------|
| **BIOS/UEFI** | Firmware initializes hardware, runs POST, finds bootable device |
| **MBR/GPT** | Partition table read; boot sector/EFI partition located |
| **GRUB2** | Bootloader shows menu, loads selected kernel + initramfs into RAM |
| **Kernel** | Linux kernel starts executing, initializes CPU/memory/devices |
| **initramfs** | Temporary root filesystem in RAM; loads drivers needed to mount the REAL root filesystem |
| **systemd** | First real process (PID 1) starts; brings system to a target state |
| **Target** | Final desired state reached (e.g., multi-user, graphical) |
| **Login** | Login prompt (CLI or GUI) appears; system ready for use |

---

## 6. `initramfs` — Initial RAM Filesystem

**Purpose:** A small, temporary root filesystem loaded into **RAM** by GRUB alongside the kernel — it exists to solve a chicken-and-egg problem.

### Why does `initramfs` exist?

The kernel needs **drivers** (e.g., for disk controllers, RAID, LVM, encrypted volumes) to mount the **real** root filesystem — but those drivers themselves might live *on* that real root filesystem. `initramfs` breaks this deadlock by providing just enough of a minimal environment (with the needed kernel modules) to:

1. Detect and load necessary drivers/modules (disk controller, filesystem type, LVM, RAID, etc.)
2. Locate and mount the **actual** root filesystem
3. Switch control over to it

### Key Tools

| Tool | Purpose |
|------|---------|
| `dracut` | Modern tool used to **generate/build** the `initramfs` image on RHEL/Fedora-based systems |
| `pivot_root` | System call/command used to **switch** from the temporary initramfs root to the real root filesystem, once it's mounted |

```bash
dracut --force                  # rebuild initramfs for the current kernel
lsinitrd /boot/initramfs-*.img  # inspect contents of an initramfs image
```

🔴 **Exam Trap (very common Viva Q):** *"Why can't the kernel just mount the real root filesystem directly?"*
→ Because the drivers needed to access the real root disk (e.g., a RAID controller driver, or LVM logical volume mapping) might not be built into the kernel itself and instead live as modules on that very disk. `initramfs` provides a minimal RAM-based environment with just enough drivers to bootstrap access to the real filesystem — solving the chicken-and-egg problem.

🟠 **Note:** `pivot_root` is conceptually similar to `chroot`, but specifically designed for the boot-time handoff from a temporary root (initramfs) to the permanent one — it also properly unmounts/cleans up the old root.

---

## 7. Startup Process — Who Starts First?

```text
Linux kernel → accesses root filesystem → systemd/init (PID = 1) executes
```

- **`systemd`** (or legacy `init`) lives in `/sbin/` and is always the **very first user-space process**, given **PID 1**.
- It starts multiple **child processes** as per the configured runlevel/target.
- Runlevels/targets act like **"checkpoints"** or **"states"** the system moves through.

### `systemd` vs legacy `init` (SysV)

| Feature | SysV `init` | `systemd` |
|---------|--------------|-------------|
| Service startup | **Sequential** (one at a time) | **Parallel** (much faster boot) |
| Config style | Shell scripts in `/etc/rc.d/rcX.d/` | Declarative unit files |
| PID | 1 | 1 |
| Speed | Slower | Faster |
| Dependency handling | Manual/ordered scripts | Automatic dependency resolution |

---

## 8. Runlevels vs systemd Targets — Full Mapping

Traditional **SysV init** used numbered **runlevels**; modern **systemd** uses named **targets**. Both represent a "state" the system boots into.

| Runlevel | systemd Target | Description |
|----------|------------------|--------------|
| **0** | `poweroff.target` | Shutdown / Halt the system |
| **1** | `rescue.target` | Single-user mode — failsafe/rescue, minimal services |
| **2** | (no exact systemd equivalent; roughly `multi-user.target`) | Multi-user mode, user login enabled, files accessible |
| **3** | `multi-user.target` | Multi-user, **networking**, CLI only (no GUI) |
| **4** | (unused/reserved) | Reserved — custom use only |
| **5** | `graphical.target` | Multi-user, networking, **GUI** |
| **6** | `reboot.target` | Reboot the system |

🔴 **Exam Trap:** Runlevel **4 is reserved/unused** by convention — a classic trick question ("what does runlevel 4 do?" → nothing by default, it's reserved for custom/site-specific configuration).

### Legacy Runlevel Commands

```bash
runlevel          # show current runlevel
init 0            # shutdown
init 6            # reboot
init 3            # switch to runlevel 3 (GUI stops if running)
init 5            # switch to runlevel 5 (GUI starts)
startx            # manually start GUI (run this from runlevel 3)
```

### Modern systemd Equivalent Commands

```bash
systemctl get-default                       # show current default target
systemctl set-default multi-user.target      # set default boot target (like editing inittab)
systemctl isolate graphical.target            # switch to a target NOW (like `init 5`)
systemctl isolate rescue.target                # go to rescue/single-user mode
```

### Comparison Table: Legacy vs Modern Commands

| Task | SysV (legacy) | systemd (modern) |
|------|-----------------|----------------------|
| Show current level/target | `runlevel` | `systemctl get-default` |
| Shutdown | `init 0` | `systemctl poweroff` |
| Reboot | `init 6` | `systemctl reboot` |
| Switch to CLI multi-user | `init 3` | `systemctl isolate multi-user.target` |
| Switch to GUI | `init 5` | `systemctl isolate graphical.target` |
| Set default boot target | Edit `/etc/inittab` | `systemctl set-default <target>` |

---

## 9. SysV init — Boot Process (Step-by-Step)

1. **Power ON** — BIOS/UEFI runs, hardware initialized.
2. **Bootloader executes** — GRUB loads the Linux kernel into memory.
3. **Kernel initialization** — CPU, memory, devices initialized; kernel starts the `init` process.
4. **Init starts (PID = 1)** — kernel executes `/sbin/init`.
5. **Read config file** — `init` reads `/etc/inittab` for the default runlevel and what to execute.
6. **Determine default runlevel** — e.g., `id:3:initdefault:` → system enters **runlevel 3**.
7. **Execute startup scripts** — based on runlevel, `init` runs scripts from `/etc/rc.d/rcX.d/` (X = runlevel number).
8. **Script execution order** — scripts run **sequentially**, named by convention:
   - `S10network` (Start, priority 10, network service)
   - `S20ssh` (Start, priority 20, SSH service)
   - `K10httpd` (Kill/stop, priority 10, httpd service)
9. **Start services** — one by one, **no parallel execution** (network, SSH, database, etc.).
10. **System ready** — after all scripts run, login prompt appears.

💡 **Naming convention:** `S` prefix = **Start** this service when entering the runlevel; `K` prefix = **Kill** (stop) this service when leaving the runlevel. The number controls execution **order**.

---

## 10. systemd — Boot Process (Step-by-Step)

1. **Power ON** — BIOS/UEFI starts, hardware initialized.
2. **Bootloader executes** — GRUB loads the Linux kernel into memory.
3. **Kernel initialization** — CPU, memory, devices initialized; kernel starts **systemd**.
4. **systemd starts (PID = 1)** — kernel executes `/usr/lib/systemd/systemd`, the **first user-space process**.
5. **Load default target** — systemd reads the default target from `/etc/systemd/system/default.target` (a symlink to the actual target).
6. **Identify target** — e.g., `multi-user.target` → equivalent to runlevel 3 (CLI mode).
7. **Load unit files** — systemd loads unit definitions from `/etc/systemd/system/` and `/lib/systemd/system/`.
8. **Resolve dependencies** — systemd determines which services depend on others, and which can run **in parallel**.
9. **Parallel service startup** — unlike SysV, systemd starts independent services **simultaneously** → faster boot, more efficient resource usage.
10. **Activate required units** — types include:
    - `.service` → services (daemons)
    - `.mount` → filesystem mounts
    - `.socket` → communication sockets
11. **Mount filesystems** — systemd auto-mounts required filesystems, using `/etc/fstab`.
12. **Start system services** — e.g., network, SSH, logging.
13. **System ready** — target reached; login prompt (or GUI) appears.

### SysV vs systemd Boot — Side-by-Side

| Step | SysV init | systemd |
|------|-----------|---------|
| PID 1 process | `/sbin/init` | `/usr/lib/systemd/systemd` |
| Config source | `/etc/inittab` | `/etc/systemd/system/default.target` |
| Service definitions | Shell scripts (`/etc/rc.d/rcX.d/`) | Unit files (`.service`, `.mount`, `.socket`) |
| Execution style | Sequential | Parallel (dependency-resolved) |
| Speed | Slower | Faster |

---

## 11. `systemctl` — Core Commands

`systemctl` is the primary tool to **manage services (units)** under systemd.

| Command | Purpose |
|---------|---------|
| `systemctl start <service>` | Start a service **NOW** (this session only) |
| `systemctl stop <service>` | Stop a running service |
| `systemctl restart <service>` | Stop + start again (full restart) |
| `systemctl enable <service>` | Configure service to **start automatically on every boot** (does NOT start it now) |
| `systemctl disable <service>` | Remove service from auto-start at boot (does NOT stop it now if running) |
| `systemctl status <service>` | Show current status — running/stopped, recent logs, PID |
| `systemctl is-enabled <service>` | Check if a service is set to auto-start at boot (`enabled`/`disabled`) |
| `systemctl daemon-reload` | Reload systemd's unit file configuration after editing/adding a `.service` file |

```bash
systemctl start nginx           # start nginx now
systemctl enable nginx          # make nginx start automatically on every future boot
systemctl status nginx          # check nginx status right now
systemctl is-enabled nginx      # is nginx set to auto-start? yes/no
systemctl daemon-reload         # after editing a .service unit file, reload systemd's cache
```

### `start` vs `enable` — The Critical Distinction

| Command | Effect NOW | Effect on next REBOOT |
|---------|-------------|---------------------------|
| `systemctl start` | ✅ Starts immediately | ❌ Does nothing for future boots |
| `systemctl enable` | ❌ Does NOT start now | ✅ Will auto-start on every future boot |
| `systemctl enable --now` | ✅ Starts immediately | ✅ AND auto-starts on future boots |

🔴 **Exam Trap (extremely common Viva Q):** *"I ran `systemctl enable nginx` but nginx isn't running. Why?"*
→ `enable` only creates the **symlinks** that tell systemd to start the service **on the next boot** — it does **NOT** start the service in the current session. You must also run `systemctl start nginx`, or combine both with `systemctl enable --now nginx`.

💡 **Memory trick:** `start` = "now"; `enable` = "forever (from next boot onward)". They are **independent** — you can start without enabling (temporary, won't survive reboot) or enable without starting (won't run until next reboot).

### `daemon-reload` — When is it needed?

- Required whenever you **create, edit, or delete** a `.service` unit file (e.g., after writing a custom systemd service).
- Without it, systemd keeps using its **cached/old** version of the unit file — your edits won't take effect.

```bash
vim /etc/systemd/system/myapp.service   # edit/create a custom unit file
systemctl daemon-reload                  # tell systemd to re-read unit files
systemctl start myapp                    # now start it with the updated config
```

🔴 **Exam Trap:** Forgetting `daemon-reload` after editing a unit file is one of the most common real-world systemd mistakes — the service will start with the **OLD** config until you reload.

---

## 12. Live Troubleshooting Basics

### 12.1 `journalctl` — systemd's Centralized Log Viewer

Reads logs from the **systemd journal** — a binary, structured log store (replaces plain-text `/var/log/messages` on many systems).

```bash
journalctl                          # show ALL logs (oldest first)
journalctl -u sshd                   # logs for a SPECIFIC service/unit
journalctl -u sshd -f                # follow/tail logs live (like tail -f)
journalctl --since "10 min ago"      # logs from a relative time
journalctl --since today             # logs from today only
journalctl -p err                    # only show priority "error" and above
journalctl -b                        # logs since the LAST boot only
journalctl -b -1                     # logs from the PREVIOUS boot
journalctl -k                        # kernel messages only (like dmesg)
journalctl --disk-usage              # how much disk space journal logs are using
```

| Flag | Meaning |
|------|---------|
| `-u` | Filter by unit/service name |
| `-f` | Follow (live tail) |
| `--since` / `--until` | Time range filtering |
| `-p` | Filter by priority (emerg, alert, crit, err, warning, notice, info, debug) |
| `-b` | Filter by boot session |
| `-k` | Kernel messages only |

🔴 **Exam Trap:** `journalctl -u sshd -f` is the go-to command to **live-debug why a service failed to start** — extremely common real-world/interview scenario.

---

### 12.2 `top` — Classic Live Process Monitor

```bash
top
```
- Shows real-time CPU/memory usage per process, updates every few seconds by default.
- Inside `top`: press `k` to kill a process, `q` to quit, `M` to sort by memory, `P` to sort by CPU.

### 12.3 `htop` — Improved Interactive Process Monitor

```bash
htop
```
- Color-coded, scrollable, mouse-supported version of `top`.
- Not installed by default on most distros — needs `yum install htop` / `apt install htop`.
- Allows easily killing processes, filtering, and tree-view of parent/child processes.

### Comparison Table: `top` vs `htop`

| Feature | `top` | `htop` |
|---------|--------|---------|
| Pre-installed | ✅ Yes (almost always) | ❌ No (needs install) |
| Interface | Plain text, keyboard-only | Color, mouse-supported, scrollable |
| Process tree view | ❌ Limited | ✅ Yes |
| Ease of killing processes | Press `k`, type PID | Select with arrow keys, press `F9` |

💡 **Quick troubleshooting combo:** `systemctl status <service>` (is it running?) → `journalctl -u <service> -f` (why did it fail?) → `top`/`htop` (is something hogging CPU/RAM?).

---

## 13. Quick-Fire Viva Q&A

| Question | Answer |
|----------|--------|
| Difference between bootstrap program and bootloader program? | Bootstrap = fixed 512-byte program that loads the next stage; Bootloader = user-facing menu program (e.g., GRUB) offering OS choices |
| What is POST? | Power-On Self Test — hardware check performed by BIOS/UEFI at startup |
| Difference between BIOS and UEFI? | UEFI is faster, supports larger disks (GPT), more hardware, and Secure Boot; BIOS is legacy, limited to MBR/2TB |
| Where should you edit GRUB settings? | `/etc/default/grub`, then regenerate `grub.cfg` — never edit `grub.cfg` directly |
| Why does `initramfs` exist? | To provide drivers needed to mount the real root filesystem, before the real root is accessible |
| Tool used to build initramfs? | `dracut` |
| What does `pivot_root` do? | Switches from the temporary initramfs root to the real root filesystem during boot |
| What is systemd's PID? | 1 (first user-space process) |
| Which runlevel is reserved/unused? | Runlevel 4 |
| systemd equivalent of runlevel 5? | `graphical.target` |
| systemd equivalent of runlevel 3? | `multi-user.target` |
| Difference between `systemctl start` and `systemctl enable`? | `start` runs it now (not persistent); `enable` makes it auto-start on future boots (doesn't start now) |
| How to both start AND enable a service in one command? | `systemctl enable --now servicename` |
| When do you need `systemctl daemon-reload`? | After creating/editing/deleting a `.service` unit file |
| Command to live-tail logs for a specific service? | `journalctl -u servicename -f` |
| Difference between SysV init and systemd service startup? | SysV = sequential; systemd = parallel, dependency-resolved (faster boot) |
| Naming convention `S10network` in SysV — what does it mean? | `S` = Start this service, `10` = execution order/priority |

---

## 14. One-Page Summary

```text
Full Boot Sequence:
BIOS/UEFI → MBR/GPT → GRUB2 → Kernel → initramfs → systemd → Target → Login

GRUB2:
  Config: /etc/default/grub (edit) → grub.cfg (auto-generated, don't edit)
  GRUB_TIMEOUT = seconds before default boots
  Rescue mode = minimal CLI when GRUB can't find config/boot files

initramfs:
  Purpose: temporary RAM root, loads drivers to mount REAL root
  Build tool: dracut
  Switch tool: pivot_root

Runlevel → systemd Target:
  0 → poweroff.target
  1 → rescue.target
  3 → multi-user.target
  5 → graphical.target
  6 → reboot.target
  (4 = reserved/unused)

systemctl commands:
  start / stop / restart   → immediate action, NOT persistent
  enable / disable          → persistent across reboot, NOT immediate
  enable --now               → both at once
  status / is-enabled        → check current state
  daemon-reload               → required after editing unit files

Troubleshooting:
  systemctl status <svc>     → is it running?
  journalctl -u <svc> -f      → live logs, why did it fail?
  top / htop                  → CPU/memory usage right now
```

