# Snort on Windows — Installation, Usage & Rules

---

## Pre-Installation Setup

### Step 1 — Create Snort Folder Structure

```
C:\Snort\
├── bin\
├── etc\
├── log\
├── lib\
│   └── snort_dynamicrules\
└── rules\
```

Create via CMD (Run as Admin):

```cmd
mkdir C:\Snort\bin
mkdir C:\Snort\etc
mkdir C:\Snort\log
mkdir C:\Snort\lib\snort_dynamicrules
mkdir C:\Snort\rules
```

---

### Step 2 — Add Windows Defender Exclusion

> Without this, Defender will flag/delete Snort files and rules.

1. Open **Windows Security** → **Virus & Threat Protection**
2. → **Manage Settings** → **Exclusions** → **Add or remove exclusions**
3. → **Add an exclusion** → **Folder** → Select `C:\Snort`

---

### Step 3 — Install WinPcap & Npcap (Correct Order)

> Snort requires **WinPcap** for packet capture. **Npcap** (by default) is NOT compatible.

```
1. Uninstall Npcap (if already installed)
   → Control Panel → Programs → Uninstall Npcap

2. Install WinPcap
   → https://www.winpcap.org/install/

3. Install Npcap (after WinPcap is in place)
   → https://npcap.com/#download
   → During install: check "WinPcap API-compatible Mode"
```

---

### Step 4 — Download Snort

- Download from: https://www.snort.org/downloads
- Install to `C:\Snort`

> ⚠️ **Always run Snort as Administrator** (right-click → Run as Admin)

---

## Snort CLI — Interface Discovery

### List All Interfaces (by number only)

```cmd
snort -W
```

> This shows interface numbers but **NOT human-readable names**.

### Map Interface Number → Name

```cmd
getmac /fo csv /v
```

> Cross-reference this output with `snort -W` to identify which number = which NIC.

---

## Snort — Packet Capture Mode

### Basic Capture on Interface

```cmd
snort -i 2
```

> Default interface is `1`. Use `-i <number>` to select another.

### Verbose Capture Flags

```cmd
snort -i 2 -dev
```

| Flag | Meaning                    |
| ---- | -------------------------- |
| `-d` | Application layer data     |
| `-e` | Link layer (Ethernet) data |
| `-v` | Verbose output             |

---

## Snort — Modes

| #   | Mode               | Description                                      |
| --- | ------------------ | ------------------------------------------------ |
| 1   | **Packet Capture** | Captures and displays packets (sniffer mode)     |
| 2   | **IDS Mode**       | Reads config + rules, alerts on matching traffic |

---

## Snort — IDS Mode (with Config)

### Run IDS Mode

```cmd
snort -i 1 -c C:\Snort\etc\snort.conf -l C:\Snort\log -A console
```

| Flag         | Meaning                 |
| ------------ | ----------------------- |
| `-i 1`       | Use interface 1         |
| `-c`         | Path to snort.conf      |
| `-l`         | Log directory           |
| `-A console` | Print alerts to console |

### Test Config (without capturing)

```cmd
snort -i 1 -c C:\Snort\etc\snort.conf -l C:\Snort\log -T
```

> `-T` = test/validate config only, does not capture traffic

---

## Common Config Errors & Fixes

Open `C:\Snort\etc\snort.conf` and apply these fixes:

| #   | Error                                      | Fix                                           |
| --- | ------------------------------------------ | --------------------------------------------- |
| 1   | `ipvar` not recognized (IPv6 keyword)      | Replace `ipvar` → `var`                       |
| 2   | Snort dynamic preprocessor path error      | Comment out `dynamicpreprocessor` line        |
| 3   | Dynamic engine path error                  | Comment out `dynamicengine` line              |
| 4   | Dynamic rules path error                   | Comment out `dynamicrules` line               |
| 5   | `normalize_ip4` error                      | Comment out that line                         |
| 6   | `white_list` / `black_list` file not found | Comment out those lines or create empty files |

**To comment out a line in snort.conf:**

```
# dynamicpreprocessor directory C:\Snort\lib\snort_dynamicrules
```

---

## Snort Rules

### Rule Syntax

```
action protocol src_ip src_port direction dst_ip dst_port (options)
```

### Example Rule — Detect Any IP Packet

```
alert ip any any -> any any (msg:"IP packet detected"; sid:1000001;)
```

| Field     | Meaning                                 |
| --------- | --------------------------------------- |
| `alert`   | Action — generate alert                 |
| `ip`      | Protocol                                |
| `any any` | Source IP and Port (any)                |
| `->`      | Direction (src → dst)                   |
| `any any` | Destination IP and Port (any)           |
| `msg`     | Alert message string                    |
| `sid`     | Unique rule ID (custom rules: 1000001+) |

> Rules file location: `C:\Snort\rules\local.rules`

---

## Centralized Syslog from Multiple Snort Machines

To forward alerts from multiple Snort instances to a **central syslog server**:

### In `snort.conf` (on each Snort machine):

```
output alert_syslog: host=192.168.80.128:514, log_auth, log_console
```

### Run Snort with syslog flag:

```cmd
snort -i 1 -c C:\Snort\etc\snort.conf -l C:\Snort\log -A syslog
```

> Port `514` = standard Syslog port (UDP)

---

## Kiwi Syslog Server — Setup & Integration with Snort

### What is Kiwi Syslog?

**Kiwi Syslog Server** (by SolarWinds) is a Windows-based syslog receiver used to **collect, display, and store** log/alert messages from multiple network devices and tools like Snort.

```
  Snort Machine 1  ──┐
  Snort Machine 2  ──┼──► Kiwi Syslog Server (UDP 514) ──► Log Files / Alerts
  Snort Machine 3  ──┘         192.168.80.128
```

---

### Step 1 — Download & Install Kiwi Syslog

- Download: https://www.solarwinds.com/free-tools/kiwi-free-syslog-server
- Install on the **central log collection machine**
- Default listening port: **UDP 514**

> Free version supports up to 5 sources. For lab use, free version is sufficient.

---

### Step 2 — Configure Kiwi to Listen

1. Open **Kiwi Syslog Service Manager**
2. Go to **File** → **Setup**
3. Under **Inputs** → **UDP** → ensure port `514` is enabled
4. Click **OK / Apply**

---

### Step 3 — Configure Snort to Send Alerts to Kiwi

In `C:\Snort\etc\snort.conf` on **each Snort machine**, add:

```
output alert_syslog: host=192.168.80.128:514, log_auth, log_console
```

| Field            | Meaning                               |
| ---------------- | ------------------------------------- |
| `192.168.80.128` | IP of the machine running Kiwi Syslog |
| `514`            | Syslog port (UDP)                     |
| `log_auth`       | Log to auth facility                  |
| `log_console`    | Also display on console               |

---

### Step 4 — Run Snort with Syslog Output

```cmd
snort -i 1 -c C:\Snort\etc\snort.conf -l C:\Snort\log -A syslog
```

---

### Step 5 — Verify in Kiwi

- Open Kiwi Syslog Server UI
- Alerts from Snort will appear in **real-time** in the display window
- Logs are saved to: `C:\Program Files\Syslogd\Logs\` (default)

---

### Kiwi Syslog — Key Points

| Feature      | Detail                                         |
| ------------ | ---------------------------------------------- |
| Protocol     | UDP (default) / TCP                            |
| Default Port | 514                                            |
| Purpose      | Centralized log collection from multiple hosts |
| Used With    | Snort, routers, firewalls, Linux syslog        |
| Log Format   | Plain text, filterable by source/severity      |

> **Interview point:** Kiwi Syslog acts as a **SIEM-lite** — it centralizes logs but does not correlate events. For full SIEM, use tools like Splunk or ELK.

---

## Hashing — Quick Reference

### Concept

```
Data / File (variable size)  ──►  Hash Function  ──►  Fixed-size Digest
```

- **One-way** mathematical function — cannot be reversed
- **Purpose:** Integrity verification
- Same input → always same output
- Even 1-bit change → completely different hash

### Common Hash Commands (Linux)

```bash
sha256sum filename.txt
md5sum filename.txt
```

### Hash Algorithms

| Algorithm | Output Size            | Status                    |
| --------- | ---------------------- | ------------------------- |
| MD5       | 128-bit (32 hex chars) | Weak — collision possible |
| SHA-1     | 160-bit                | Deprecated                |
| SHA-256   | 256-bit                | ✅ Recommended            |
| SHA-512   | 512-bit                | ✅ Strongest              |

> **Interview point:** Hashing ≠ Encryption. Hashing is one-way; encryption is two-way.
