---
title: "13 - Router IOS and Management"
aliases:
  - "Cisco Router Fundamentals and IOS"
  - "Router Fundamentals: IOS, Boot Process, Memory, CLI Modes, Remote Access, Password Recovery & Troubleshooting"
  - "Router Fundamentals Boot Memory SSH Notes"
tags:
  - computer-networks
  - cisco-ios
  - routers
  - troubleshooting
syllabus-topic:
  - 13
---

# Router Fundamentals: IOS, Boot Process, Memory, CLI Modes, Remote Access, Password Recovery & Troubleshooting

---

## Table of Contents

- [[#0. Full Forms / Abbreviations]]
- [[#PART A — What Is Cisco IOS?]]
- [[#PART B — Router Hardware Components (The "Big 5")]]
- [[#PART C — Cisco IOS CLI Modes]]
- [[#PART D — Router Boot Sequence]]
- [[#1. Boot Sequence Overview]]
- [[#1.1 Detailed Step-by-Step Flow]]
- [[#PART E — Telnet vs SSH (Remote Access Security)]]
- [[#PART F — Ways to Access the Cisco IOS CLI]]
- [[#PART G — Configuration Registers]]
- [[#What Is the Configuration Register?]]
- [[#PART H — Cisco IOS Password Recovery (Full Procedure)]]
- [[#PART I — Debugging & Logging]]
- [[#Why Debugging and Logging Matter]]
- [[#PART J — Master Quick Revision]]
- [[#Related Notes]]

---

## 0. Full Forms / Abbreviations

| Abbreviation | Full Form                                                              |
| ------------ | ---------------------------------------------------------------------- |
| **POST**     | Power-On Self-Test                                                     |
| **IOS**      | Internetwork Operating System (Cisco)                                  |
| **ROM**      | Read-Only Memory                                                       |
| **RAM**      | Random-Access Memory                                                   |
| **NVRAM**    | Non-Volatile Random-Access Memory                                      |
| **Flash**    | Flash Memory                                                           |
| **SSH**      | Secure Shell                                                           |
| **Telnet**   | Teletype Network                                                       |
| **CLI**      | Command-Line Interface                                                 |
| **TFTP**     | Trivial File Transfer Protocol                                         |
| **ROMmon**   | ROM Monitor (also written RXBOOT)                                      |
| **VTY**      | Virtual Teletype (virtual terminal line, used for remote CLI sessions) |
| **AUX**      | Auxiliary (port)                                                       |

---

## PART A — What Is Cisco IOS?

**Cisco IOS** is the operating system that runs on Cisco routers and switches. It is responsible for:

- **Routing** — moving packets between networks
- **Switching** — forwarding frames within a network
- **Network device management** — CLI, configuration, monitoring
- **Security** — passwords, ACLs, AAA, encryption features (e.g., SSH)

---

## PART B — Router Hardware Components (The "Big 5")

| Component | Role                                                                                                  |
| --------- | ----------------------------------------------------------------------------------------------------- |
| **CPU**   | Executes IOS instructions and processes                                                               |
| **RAM**   | Stores the running-config, routing tables, ARP cache, buffers, and the currently _loaded/running_ IOS |
| **ROM**   | Stores POST routines, the Bootstrap program, and a bare-bones mini-IOS (ROMmon)                       |
| **NVRAM** | Stores the startup-config                                                                             |
| **Flash** | Stores the full IOS image file (the OS itself)                                                        |

### Memory Cheat Sheet

| Memory Type | Stores                                                                            | Volatile?                           | Analogy                       |
| ----------- | --------------------------------------------------------------------------------- | ----------------------------------- | ----------------------------- |
| **ROM**     | Bootstrap program, POST routines, mini-IOS (ROMmon)                               | ❌ No — permanent                   | The router's built-in "BIOS"  |
| **Flash**   | The full **IOS image**                                                            | ❌ No — persists across reboots     | The router's "hard drive"     |
| **NVRAM**   | The **startup-config**                                                            | ❌ No — persists across reboots     | Saved settings file           |
| **RAM**     | The **running-config** + currently running IOS + routing tables/ARP cache/buffers | ✅ Yes — wiped on reboot/power loss | The router's "working memory" |

**Memory mnemonic:** _"Real Networks Feel Real"_ → **R**AM (Running-config) → **N**VRAM (Startup-config) → **F**lash (Full IOS) → **R**OM (ROMmon/Bootstrap).

### Key Distinctions

| Concept                                                  | Lives In    | Notes                                                         |
| -------------------------------------------------------- | ----------- | ------------------------------------------------------------- |
| `show running-config`                                    | RAM         | The **currently active** config — lost on reboot unless saved |
| `show startup-config`                                    | NVRAM       | The config that will load **at the next boot**                |
| `copy running-config startup-config` (or `write memory`) | RAM → NVRAM | Saves the active config so it survives a reboot               |
| IOS image file (`.bin`)                                  | Flash       | The actual OS software; Flash can hold multiple IOS versions  |
| ROMmon / mini-IOS                                        | ROM         | Emergency recovery mode if the real IOS can't load            |

---

## PART C — Cisco IOS CLI Modes

| Mode                           | Purpose                                                                             | Prompt                 | How to Enter                          |
| ------------------------------ | ----------------------------------------------------------------------------------- | ---------------------- | ------------------------------------- |
| **A. User EXEC**               | Limited access — basic monitoring commands only (e.g., `ping`, `show version`)      | `Router>`              | Default mode on login                 |
| **B. Privileged EXEC**         | Full administrative access — debugging, copying/saving config, entering config mode | `Router#`              | `Router> enable`                      |
| **C. Global Configuration**    | Configure system-wide settings (hostname, passwords, routing, etc.)                 | `Router(config)#`      | `Router# configure terminal`          |
| **D. Interface Configuration** | Configure a specific interface (IP address, description, etc.)                      | `Router(config-if)#`   | `Router(config)# interface <name>`    |
| **E. Line Configuration**      | Configure console / VTY / AUX lines (passwords, login method, transport)            | `Router(config-line)#` | `Router(config)# line vty 0 4` (etc.) |

### Common User EXEC Commands

```text
Router> show ?
Router> show history
Router> show version
Router> ping 192.168.1.1
Router> traceroute 8.8.8.8
Router> telnet 192.168.1.10
Router> logout
```

### Privileged EXEC — Common Uses

Once in `Router#`, you can:

- View detailed information (`show running-config`, `show startup-config`, `show version`)
- Copy/save configuration
- Run `debug` commands
- Enter global configuration mode

```text
Router# show running-config
```

Shows the **active** configuration in RAM. Includes: interfaces, hostname, passwords, routing configuration, VTY line settings, and enabled services.

```text
Router# show startup-config
```

Shows the configuration **saved in NVRAM** that will be used on the next reboot.

```text
Router# copy running-config startup-config
```

Saves the current (active) configuration to NVRAM so it survives a reboot:

```text
RAM (running-config)
        │  copy
        ▼
NVRAM (startup-config)
```

### Types of Line Passwords

- **Console password** — protects local console-port access (`line console 0`)
- **Telnet / SSH password** — protects remote CLI access (`line vty 0 4`)

---

## PART D — Router Boot Sequence

## 1. Boot Sequence Overview

```
 POST  →  Bootstrap  →  Locate & Load IOS  →  Load Configuration
```

| Stage                            | What Happens                                                                                                    | Stored In                                    |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| **1. POST** (Power-On Self-Test) | Hardware diagnostic check — CPU, RAM, interfaces, and other components are tested for basic functionality       | Executed from **ROM**                        |
| **2. Bootstrap**                 | A small program that locates and loads the IOS image                                                            | Stored in **ROM**                            |
| **3. IOS Load**                  | The bootstrap program loads the Cisco IOS image into RAM, following the order set by the configuration register | Loaded from **Flash** (default) into **RAM** |
| **4. Configuration**             | The router loads its saved configuration (startup-config) into running memory to become operational             | Loaded from **NVRAM** into **RAM**           |

## 1.1 Detailed Step-by-Step Flow

```
┌────────────────────────────────────────────────────────────────┐
│ STEP 1: POST (Power-On Self-Test)                                │
│ • Runs from ROM                                                  │
│ • Tests CPU, RAM, NVRAM, Flash, and interface hardware           │
│ • If POST fails → router halts / reports an error via console    │
└────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────────┐
│ STEP 2: Bootstrap Program Runs                                   │
│ • Located in ROM                                                 │
│ • Its job: find and load the IOS image                           │
│ • Checks the CONFIGURATION REGISTER to determine WHERE to look   │
│   for the IOS (see Part F)                                       │
└────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────────┐
│ STEP 3: IOS Image Is Located and Loaded                          │
│ Default search order:                                            │
│   1. Flash memory   (most common default location)               │
│   2. TFTP server    (if configured / Flash fails)                │
│   3. ROM (mini-IOS) (fallback if all else fails)                 │
│ • IOS image is loaded (decompressed if needed) INTO RAM          │
│ • Router now has a running, functional operating system          │
└────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌────────────────────────────────────────────────────────────────┐
│ STEP 4: Configuration File Is Loaded                             │
│ • Router looks in NVRAM for startup-config                       │
│   ├── Found?     → copied into RAM as running-config → router    │
│   │                is fully configured and operational           │
│   └── Not found? → tries TFTP → if still not found, enters       │
│                     SETUP MODE (interactive Q&A wizard) with a   │
│                     blank/default configuration                  │
└────────────────────────────────────────────────────────────────┘
```

### Simplified Flow (as commonly drawn)

```text
Power ON
   │
   ▼
POST
   │
   ▼
Bootstrap
   │
   ▼
Locate and load IOS
   │
   ▼
Search startup-config
   │
   ├── Found → Copy to RAM → Running configuration
   │
   └── Not found → Search TFTP → still not found → Setup mode
```

### Exam One-Liners

- Order to remember: **P**OST → **B**ootstrap → **I**OS → **C**onfig ("**P**lease **B**ring **I**ce **C**ream").
- POST and Bootstrap both run from **ROM**.
- IOS is normally loaded from **Flash**; startup-config is loaded from **NVRAM**.
- If startup-config is missing, the router tries **TFTP**, and if that also fails, it enters **Setup Mode**.

---

## PART E — Telnet vs SSH (Remote Access Security)

Both protocols allow **remote CLI access** to a router/switch through **VTY lines**, but they differ fundamentally in security.

By default a router has 5 VTY lines (`line vty 0 4` = VTY 0 through VTY 4), meaning up to 5 simultaneous remote CLI sessions.

| Feature                          | Telnet                                                             | SSH                                                      |
| -------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------- |
| **Encryption**                   | ❌ None — sends everything, including passwords, in **plain text** | ✅ Full encryption of the entire session                 |
| **Port**                         | TCP 23                                                             | TCP 22                                                   |
| **Authentication security**      | Weak — credentials easily captured via packet sniffing             | Strong — supports password AND public-key authentication |
| **Data integrity checking**      | ❌ No                                                              | ✅ Yes (cryptographic integrity checks)                  |
| **Vulnerable to eavesdropping?** | ✅ Very — anyone on the path can read the traffic                  | ❌ No — traffic is encrypted end-to-end                  |
| **Recommended today?**           | ❌ No — legacy/insecure, mainly seen in labs/older environments    | ✅ Yes — industry standard for remote device management  |

### Why Telnet Is Insecure — Visualized

```
 Telnet Session (PLAIN TEXT):

  Admin PC ──── "Username: admin" ────────────► Router
  Admin PC ──── "Password: Cisco123" ─────────► Router
                        │
                        ▼
        Anyone capturing packets on this path
        (e.g., via Wireshark) can read the
        password DIRECTLY — no decryption needed.
```

Example command: `telnet 192.168.1.1`

### Why SSH Is Secure — Visualized

```
 SSH Session (ENCRYPTED):

  Admin PC ──── [encrypted blob: xK9$#mP2...] ────► Router
                        │
                        ▼
        An eavesdropper only sees scrambled
        ciphertext — username/password/commands
        are unreadable without the correct key.
```

Example command: `ssh admin@192.168.1.1`

### Basic SSH Configuration (Cisco IOS)

```text
Step 1 — Set hostname and domain name (required for RSA key generation):
  Router(config)# hostname R1
  R1(config)# ip domain-name mylab.com

Step 2 — Generate the RSA key pair:
  R1(config)# crypto key generate rsa
  (choose a modulus size, e.g. 1024 or 2048 bits)

Step 3 — Create a local user account:
  R1(config)# username admin secret StrongPass123

Step 4 — Configure the VTY lines to use SSH + local login:
  R1(config)# line vty 0 4
  R1(config-line)# transport input ssh
  R1(config-line)# login local
```

> `transport input ssh` **disables Telnet** on the VTY lines (only SSH is accepted). Using `transport input telnet ssh` would allow both — not recommended for security.

### Exam One-Liners

- Telnet = **unencrypted**, TCP port 23 — never use on production networks.
- SSH = **encrypted**, TCP port 22 — the modern standard for remote device administration.
- SSH requires a **hostname + domain name + RSA key pair** before it can be enabled.
- Best practice: `transport input ssh` on VTY lines to **disable Telnet entirely**.
- Default VTY lines: **0 to 4** (5 lines total).

---

## PART F — Ways to Access the Cisco IOS CLI

There are four common ways an administrator can reach the CLI of a router:

### 1. Console — Local, Out-of-Band Access

```text
PC/Laptop ── Console cable ── Router
```

Direct physical connection to the router's console port, accessed via a terminal program.

**Used when:**

- Router is being configured for the first time (no network config exists yet)
- Network access is unavailable
- Password recovery is needed

### 2. SSH — Remote, Encrypted Access (Preferred)

```text
Admin PC ── SSH ──► Router
```

Example: `ssh admin@192.168.1.1`

**Used when:** administering the router remotely and secure access is required. SSH encrypts the entire communication (see Part E).

### 3. Telnet — Remote, Unencrypted Access

```text
Admin PC ── Telnet ──► Router
```

Example: `telnet 192.168.1.1`

**Used when:** remote CLI access is needed — typically only in labs or older environments. ⚠️ Not recommended for production since credentials and data are sent in plain text.

### 4. AUX Port — Out-of-Band Remote/Modem Access

```text
Remote Admin ── Modem ── AUX port ── Router
```

Some Cisco routers have an **AUX (Auxiliary) port**, traditionally connected to a modem for **out-of-band management** — i.e., accessing the router when the normal in-band network path is down or unavailable. It is not used for day-to-day remote administration like SSH/Telnet, but as a backup access path.

### Exam One-Liners

- Console and AUX are physical/out-of-band access methods; SSH and Telnet are network/in-band (VTY) access methods.
- Console access is required for the **very first configuration** of a router (no IP/network config exists yet).
- SSH is preferred over Telnet for all remote in-band access.

---

## PART G — Configuration Registers

## What Is the Configuration Register?

The **configuration register** is a **16-bit (4 hex-digit) value** stored in **NVRAM** that tells the router **how to boot** — where to look for the IOS, whether to load the startup-config, and other boot-time behaviors.

```text
View current value:
  Router# show version
  (look for the line: "Configuration register is 0x XXXX")
```

### Common Configuration Register Values

| Value      | Meaning                                                                                                                                |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **0x2102** | **Default** — boot normally: load IOS from Flash, load startup-config from NVRAM                                                       |
| **0x2142** | **Ignore startup-config** at boot — router boots into Setup Mode with a blank running-config (commonly used for **password recovery**) |
| **0x2100** | Boot into **ROMmon** (ROM Monitor) mode — minimal recovery environment, does not load IOS normally                                     |

### Changing the Configuration Register

```text
Router(config)# config-register 0x2142
```

- Takes effect **after the next reload** — not immediately.
- Commonly used during **password recovery**: set to `0x2142` to skip loading the (password-protected) startup-config, log in with no password, then manually reload the old config and change the password, and finally set the register **back to 0x2102** before the final reload/save.

### Exam One-Liners

- Config register = 16-bit value in **NVRAM**, controls boot behavior.
- `0x2102` = normal/default boot.
- `0x2142` = ignore (skip loading) startup-config — the classic password-recovery value.
- `0x2100` = boot straight into ROMmon.
- Changes to the register only take effect **after a reload**.
- Always remember to set it **back to 0x2102** after password recovery — otherwise the router will keep ignoring its saved config on every future boot.

---

## PART H — Cisco IOS Password Recovery (Full Procedure)

If you forget a Cisco router's password, you can recover access using **ROMmon mode**, since physical/console access effectively lets you bypass password protection by controlling the boot process.

### Step 1 — Restart and Enter ROMmon

Power off/on the router, and during boot send the **Break** signal to interrupt the normal boot and drop into ROMmon:

```text
rommon 1 >
```

### Step 2 — Change the Configuration Register

Tell the router to **ignore the startup-config** on the next boot:

```text
rommon 1 > confreg 0x2142
```

Why this works:

- `0x2102` → normally loads startup-config (including the password)
- `0x2142` → **ignores** startup-config, so the router boots with no password set

### Step 3 — Reset/Reload

```text
rommon 2 > reset
```

The router reboots without loading the old (password-protected) configuration.

### Step 4 — Enter Privileged Mode

Since the old configuration was skipped, no password is currently applied:

```text
Router> enable
Router#
```

### Step 5 — Copy the Old Configuration into RAM

The old configuration is still safely stored in NVRAM — it was only skipped, not deleted:

```text
Router# copy startup-config running-config
```

```text
NVRAM (startup-config)
        │  copy
        ▼
RAM (running-config)
```

This restores your old configuration (interfaces, routing, etc.) **without** re-locking you out with the old password.

### Step 6 — Change the Password

```text
Router# configure terminal
Router(config)# enable secret NewPassword123
```

If needed, also change the console password:

```text
Router(config)# line console 0
Router(config-line)# password NewPassword123
Router(config-line)# login
```

### Step 7 — Restore Normal Boot Behavior

This step is critical — don't skip it:

```text
Router(config)# config-register 0x2102
```

This ensures the router will load the startup-config normally on all future reboots.

### Step 8 — Save the Configuration

```text
Router# copy running-config startup-config
```

### Complete Sequence to Remember

```text
Power ON
   │
   ▼
Break
   │
   ▼
ROMmon
   │
   ▼
confreg 0x2142
   │
   ▼
reset
   │
   ▼
Router> enable
   │
   ▼
copy startup-config running-config
   │
   ▼
configure terminal → change password
   │
   ▼
config-register 0x2102
   │
   ▼
copy running-config startup-config
```

### ⭐ Exam Shortcut

- **2142 = Ignore startup-config** (skip password)
- **2102 = Normal boot**

> **2142 → Recover → 2102 → Save.**

> ⚠️ Important exam trap: password recovery via ROMmon requires **physical console access** to the router — it cannot be done remotely via Telnet/SSH, since it relies on interrupting the boot process at the console.

---

## PART I — Debugging & Logging

## Why Debugging and Logging Matter

Routers and switches constantly generate information about their internal operations, errors, and state changes. **Logging** captures this passively; **debugging** actively surfaces detailed real-time information about specific processes — both are essential for troubleshooting.

### Logging (`show logging` / Syslog)

- The router keeps an internal **log buffer** of system messages (interface up/down, config changes, errors, etc.) by default.
- Logs can be sent to multiple destinations simultaneously:

| Destination                 | Command                              | Notes                                                                            |
| --------------------------- | ------------------------------------ | -------------------------------------------------------------------------------- |
| **Console**                 | (default, always on unless disabled) | Shown directly on the console session                                            |
| **Internal buffer**         | `logging buffered`                   | Stored in RAM; view with `show logging`                                          |
| **Terminal (VTY sessions)** | `terminal monitor`                   | Needed to see log messages when connected via Telnet/SSH (not shown by default!) |
| **External Syslog server**  | `logging <syslog-server-ip>`         | Centralizes logs from many devices for long-term storage/analysis                |

```text
 Log Message Severity Levels (0 = most severe → 7 = least severe):

  0 Emergency   1 Alert           2 Critical   3 Error
  4 Warning     5 Notice          6 Informational   7 Debugging
```

> ⚠️ **Common gotcha:** if you're remotely connected via Telnet/SSH and don't see log messages that appear on the console, run `terminal monitor` to enable them for your session.

### Debugging (`debug` commands)

- `debug` commands provide **real-time, detailed** output about a specific process as it happens (e.g., `debug ip routing`, `debug ip icmp`, `debug spanning-tree events`).
- Extremely useful for diagnosing **active, in-progress** problems (e.g., watching routing updates arrive, or watching an authentication exchange fail step-by-step).

```text
Router# debug ip routing
Router# debug ip icmp
Router# undebug all      ← or "u all" — disables ALL active debug output
```

> ⚠️ **Warning:** `debug` commands are **CPU-intensive** — running heavy debugs (like `debug ip packet` on a busy router) can significantly load the CPU and, in extreme cases, cause the router to become unresponsive. Always disable debugging (`undebug all`) as soon as you're done.

### Why This Matters — Practical Importance

| Without Debugging/Logging                                | With Debugging/Logging                                                                                 |
| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| Problems are invisible until they cause an outage        | Early warning signs (interface flaps, failed logins, routing changes) are visible before they escalate |
| Root-cause analysis after an incident is guesswork       | Log history + timestamps let you reconstruct exactly what happened and when                            |
| No audit trail of configuration/security events          | Logs provide accountability — who did what, and when (especially combined with AAA accounting)         |
| Diagnosing live/intermittent issues is nearly impossible | `debug` shows the process happening in real time, letting you catch transient issues                   |

### Best Practices

- Always timestamp log messages: `service timestamps log datetime msec`
- Send logs to a **centralized syslog server** in production — local buffers are limited in size and lost on reload.
- Use `debug` **sparingly and temporarily** in production — prefer testing in a lab first, and always run `undebug all` when finished.
- Match the **logging severity level** to what's actually needed (`logging console <level>`, `logging buffered <level>`) to avoid being flooded with noise.

### Exam One-Liners

- **Logging** = passive record-keeping of system events; **Debugging** = active, real-time, detailed process tracing.
- Logging severity levels run **0 (Emergency) → 7 (Debugging)** — lower number = more severe.
- `terminal monitor` is required to see log messages over a remote (Telnet/SSH) session.
- `debug` commands are CPU-intensive — always `undebug all` when finished.
- Centralized **Syslog servers** are the production-standard destination for logs (local buffers are volatile and size-limited).

---

## PART J — Master Quick Revision

```text
CISCO IOS
  Operating system for Cisco routers/switches: routing, switching,
  management, security

HARDWARE COMPONENTS
  CPU    : executes instructions
  RAM    : running-config, routing table, ARP cache, buffers, running IOS
  ROM    : POST + Bootstrap + ROMmon (permanent)
  NVRAM  : startup-config (persists across reboot)
  Flash  : full IOS image (persists across reboot)

CLI MODES
  User EXEC          Router>            basic/limited commands
  Privileged EXEC     Router#            full admin access (enable)
  Global Config        Router(config)#    configure terminal
  Interface Config     Router(config-if)# interface <name>
  Line Config           Router(config-line)# line vty/console/aux

BOOT SEQUENCE
  POST → Bootstrap → Locate/Load IOS → Load Config
  POST & Bootstrap  : run from ROM
  IOS                : loaded from Flash → into RAM (fallback: TFTP, then ROM)
  Startup-config     : loaded from NVRAM → into RAM (as running-config)
  No startup-config found → try TFTP → Setup Mode

ACCESS METHODS
  Console : local, out-of-band, cable — first-time setup/password recovery
  SSH     : remote, encrypted, TCP 22 — preferred
  Telnet  : remote, unencrypted, TCP 23 — legacy/labs only
  AUX     : out-of-band via modem — backup access when network is down

TELNET vs SSH
  Telnet : TCP 23, PLAIN TEXT, insecure — avoid in production
  SSH    : TCP 22, ENCRYPTED, secure — industry standard
  SSH setup requires: hostname + domain-name + RSA key pair
  `transport input ssh` on VTY lines disables Telnet
  Default VTY lines: 0–4 (5 lines)

CONFIG REGISTER
  16-bit value in NVRAM controlling boot behavior
  0x2102 : normal/default boot
  0x2142 : SKIP startup-config (used for password recovery)
  0x2100 : boot to ROMmon
  Takes effect only AFTER reload

PASSWORD RECOVERY (requires physical console access)
  Break → ROMmon → confreg 0x2142 → reset → enable →
  copy startup-config running-config → change password →
  config-register 0x2102 → copy running-config startup-config

DEBUGGING & LOGGING
  Logging   : passive, ongoing record of events (0=Emergency ... 7=Debugging)
  Debugging : active, real-time, CPU-intensive process tracing
  terminal monitor : needed to see logs over Telnet/SSH session
  undebug all       : stops all active debug output — always run when done
  Best practice     : centralized Syslog server for production logging
```

---

_Router Fundamentals Reference Notes — CDAC Exam Prep_

---

## Related Notes

- [[00 - Syllabus and Interview Checklist]]
- [[Index|Computer Networks Index]]
- [[04A - Network Routing Fundamentals]]
- [[04B - Routing Protocols and Administrative Distance]]
