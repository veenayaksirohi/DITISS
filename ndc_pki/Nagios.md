# Nagios — Architecture & Installation Notes

---

## What is Nagios?

**Nagios** is an open-source **IT infrastructure monitoring tool** used to monitor systems, networks, and services. It alerts administrators when something goes wrong and when it recovers.

---

## Nagios Architecture

```
┌─────────────────────────────────────────┐
│             Nagios Core                 │
│     (Scheduler + Monitoring Engine)     │
└──────────────────┬──────────────────────┘
                   │  schedules & executes
                   ▼
┌─────────────────────────────────────────┐
│           Nagios Plugins                │
│  check_cpu / check_mem / check_procs /  │
│  check_disk / check_http / check_ping   │
└──────────────────┬──────────────────────┘
                   │  monitors
                   ▼
┌──────────────────┬──────────────────────┐
│    Services      │       Hosts          │
│  (HTTP, SSH,     │  (Servers, PCs,      │
│   FTP, DB...)    │   Routers...)        │
└──────────────────┴──────────────────────┘

Web Access (Separate Layer):
┌─────────────────────────────────────────┐
│          Apache Web Server              │
│   http://<server-ip>/nagios             │
│   (CGI scripts ↔ Nagios Core)          │
└─────────────────────────────────────────┘
```

---

## Component Breakdown

### 1. Nagios Core

The **heart of Nagios** — the main scheduling and monitoring daemon:

- Schedules **when** to run each check
- Processes plugin **return codes** (OK / WARNING / CRITICAL / UNKNOWN)
- Sends **alert notifications** (email, SMS) when thresholds are breached
- Maintains state history and downtime records

### 2. Apache Web Server

Nagios uses **Apache (httpd)** to serve its web dashboard:

- Accessible at `http://<server-ip>/nagios`
- Shows real-time status of all monitored hosts and services
- Uses **CGI scripts** to communicate between Web UI and Nagios Core

### 3. Nagios Plugins

Plugins are the **actual workers** — they perform real checks:

- Separate executables/scripts (Bash, Python, Perl, PHP, etc.)
- Nagios Core calls them on schedule and reads **exit code + output**
- Return one of four states:

| Exit Code | Status      | Meaning                          |
| --------- | ----------- | -------------------------------- |
| `0`       | ✅ OK       | Service is working fine          |
| `1`       | ⚠️ WARNING  | Threshold approaching            |
| `2`       | ❌ CRITICAL | Service is down/failed           |
| `3`       | ❓ UNKNOWN  | Check could not determine status |

---

## Key Plugins

| Plugin        | What It Checks              |
| ------------- | --------------------------- |
| `check_cpu`   | CPU usage percentage        |
| `check_mem`   | RAM usage (free/used)       |
| `check_procs` | Number of running processes |
| `check_disk`  | Disk space usage            |
| `check_http`  | Web server availability     |
| `check_ping`  | Host reachability (ICMP)    |
| `check_ssh`   | SSH port availability       |

> **Plugin Abstraction:** Nagios Core doesn't care _how_ a check is done — plugins can be written in any language. Community plugins available at **Nagios Exchange** (`exchange.nagios.org`).

---

## Quick Reference Tree

```
Nagios Architecture
│
├── Nagios Core          ← Scheduling + Alert Engine
│
├── Apache               ← Web UI (Dashboard)
│
├── Nagios Plugins       ← Actual check executables
│     ├── check_cpu
│     ├── check_mem      ← Memory monitoring
│     ├── check_procs    ← Process monitoring
│     └── check_disk
│
└── Monitored Targets    ← Hosts, Services, Network Devices
```

---

## Lab — Nagios Core Installation on Ubuntu/Debian

### Pre-Lab Checklist

- [ ] Change hostname
- [ ] Assign **static IP** (outside DHCP scope)
- [ ] Fix system **date/time** (`timedatectl set-ntp true`)

---

### Step 1 — Install Dependencies

```bash
sudo apt-get install -y \
  apache2 \
  apache2-utils \
  autoconf \
  gcc \
  libc6 \
  libgd-dev \
  make \
  php \
  python3 \
  tree \
  unzip \
  wget \
  libkrb5-dev \
  openssl \
  libssl-dev
```

---

### Step 2 — Download & Extract Nagios Source Code

```bash
cd /tmp

wget -O nagioscore.tar.gz \
  https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.5.10.tar.gz

tar -zxf nagioscore.tar.gz

cd nagioscore-nagios-4.5.10/
```

---

### Step 3 — Configure Build

```bash
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
```

---

### Step 4 — Compile

```bash
sudo make all
```

---

### Step 5 — Create Nagios User/Group

```bash
sudo make install-groups-users

sudo passwd nagios

sudo usermod -a -G nagios www-data
```

---

### Step 6 — Install Binaries

```bash
sudo make install
```

Verify:

```bash
ls -l /usr/local/nagios/
ls -l /usr/local/nagios/bin/
```

---

### Step 7 — Install Service / Daemon Init

```bash
sudo make install-daemoninit
```

---

### Step 8 — Install Command Mode (for plugins)

```bash
sudo make install-commandmode
```

---

### Step 9 — Install Default Config Files

```bash
sudo make install-config
```

Verify:

```bash
ls -l /usr/local/nagios/etc/
```

---

### Step 10 — Install Apache Web Config

```bash
sudo make install-webconf

sudo a2enmod rewrite
sudo a2enmod cgi
```

---

### Step 11 — Create Web UI Admin User

```bash
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
```

> ⚠️ `-c` creates a new file. Don't use `-c` if adding more users later (it will overwrite).

---

### Step 12 — Verify Nagios Config

```bash
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
```

Look for: `Total Warnings: 0` and `Total Errors: 0`

---

### Step 13 — Start Services

```bash
sudo systemctl restart apache2
sudo systemctl enable nagios
sudo systemctl start nagios
```

---

### Step 14 — Access Web UI

Open browser:

```
http://<server-ip>/nagios
```

Login: `nagiosadmin` / `<password set in Step 11>`

---

## Common Mistakes / Interview Traps

| Mistake                            | Correct                              |
| ---------------------------------- | ------------------------------------ |
| `apache2/sites/enables`            | `apache2/sites-enabled`              |
| `/etc/local/nagios`                | `/usr/local/nagios`                  |
| `htpasswd` username `nagiousadmin` | `nagiosadmin`                        |
| `nrgios -v config`                 | `nagios -v nagios.cfg` (full path)   |
| Skip `a2enmod cgi`                 | CGI must be enabled or web UI breaks |
