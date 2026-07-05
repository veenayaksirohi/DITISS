# iptables GeoIP — Xtables-Addons

> **CDAC DITISS | Linux Security Module**
> Topic: iptables Extension — GeoIP filtering via `xtables-addons`

---

## 1. What is Xtables-Addons?

`xtables-addons` is a **third-party extension package** for iptables that provides additional match/target modules **not included** in the mainline Linux kernel. One of the most useful modules it provides is **`xt_geoip`** — which allows iptables rules to **match packets based on the source/destination country** using a GeoIP database.

```
iptables (core)
    |
    +-- xtables (extension framework)
            |
            +-- xtables-addons (extra modules — compiled separately)
                    |
                    +-- xt_geoip  <-- GeoIP country-based filtering
                    +-- xt_psd, xt_ipp2p, xt_TARPIT, etc.
```

### Why is it needed?

- Standard iptables can filter by IP, port, protocol, state — **not by country**
- GeoIP filtering is useful for **blocking traffic from specific countries/regions**
- Common in firewall hardening, threat mitigation, and geo-restriction policies

---

## 2. Dependencies

Install all required packages before building from source:

```bash
apt install -y \
    automake \
    ca-certificates \
    gcc \
    libc6-dev \
    libnet-cidr-lite-perl \
    libtext-csv-xs-perl \
    libxtables-dev \
    linux-headers-$(uname -r) \
    make \
    pkg-config \
    unzip \
    wget \
    xz-utils \
    iptables
```

| Package                     | Purpose                                                      |
| --------------------------- | ------------------------------------------------------------ |
| `gcc`, `make`, `automake`   | C compiler + build tools                                     |
| `libc6-dev`                 | Standard C library headers                                   |
| `libxtables-dev`            | iptables extension development headers                       |
| `linux-headers-$(uname -r)` | Kernel headers (must match running kernel)                   |
| `libnet-cidr-lite-perl`     | Perl module for CIDR calculations (used by `xt_geoip_build`) |
| `libtext-csv-xs-perl`       | Perl module to parse the CSV database                        |
| `pkg-config`                | Helps compiler locate library paths                          |
| `ca-certificates`, `wget`   | For downloading source and GeoIP data                        |

> ⚠️ **Exam Trap:** `linux-headers-$(uname -r)` must match your **currently running kernel version**. Mismatch = build failure.

---

## 3. Key Files Provided by Xtables-Addons

After installation, helper scripts are placed under `/usr/local/libexec/xtables-addons/`:

| Script                   | Function                                                    |
| ------------------------ | ----------------------------------------------------------- |
| `xt_geoip_dl`            | Downloads GeoIP CSV database from DB-IP (free country-lite) |
| `xt_geoip_build`         | Builds binary DB from CSV → `/usr/share/xt_geoip/`          |
| `xt_geoip_dl_maxmind`    | Alternative downloader for MaxMind GeoIP2 database          |
| `xt_geoip_build_maxmind` | Builds binary DB from MaxMind CSV format                    |
| `xt_asn_dl`              | Downloads ASN (Autonomous System Number) data               |
| `xt_asn_fetch`           | Fetches ASN data (alternative)                              |
| `xt_asn_build`           | Builds binary ASN database for `xt_asn` module              |

> **Lab verified path (xtables-addons 3.26 on Debian):** `/usr/local/libexec/xtables-addons/`

---

## 4. Installation Steps (Source Build)

### Step 1 — Download source to `/tmp`

```bash
cd /tmp
wget https://sourceforge.net/projects/xtables-addons/files/Xtables-addons/xtables-addons-<version>.tar.xz
```

### Step 2 — Extract the archive

```bash
tar -xf xtables-addons-<version>.tar.xz
cd xtables-addons-<version>/
```

### Step 3 — Configure, Build, Install

```bash
./configure
make
make install
```

### Step 4 — Verify shared modules are installed

```bash
ls -l /usr/local/libexec/xtables-addons/
```

Actual `ls -l` output from lab (xtables-addons 3.26 on Debian):

```
total 36
-rwxr-xr-x 1 root root 4609 Jun 28 19:25 xt_asn_build
-rwxr-xr-x 1 root root  384 Jun 28 19:25 xt_asn_dl
-rwxr-xr-x 1 root root 2069 Jun 28 19:25 xt_asn_fetch
-rwxr-xr-x 1 root root 2574 Jun 28 19:25 xt_geoip_build
-rwxr-xr-x 1 root root 6332 Jun 28 19:25 xt_geoip_build_maxmind
-rwxr-xr-x 1 root root  157 Jun 28 19:25 xt_geoip_dl
-rwxr-xr-x 1 root root  404 Jun 28 19:25 xt_geoip_dl_maxmind
```

---

## 5. Building the GeoIP Database

### Step 5 — Create a working directory and cd into it

```bash
sudo mkdir /home/shuhari/xtables        # or any directory you prefer
cd ~/xtables
```

> ⚠️ **Lab Note:** `xt_geoip_dl` downloads `dbip-country-lite.csv` into the **current working directory**.  
> You must `cd` into your target folder **before** running it.

### Step 6 — Download GeoIP CSV data (requires sudo)

```bash
sudo /usr/local/libexec/xtables-addons/xt_geoip_dl
```

Running without `sudo` gives:

```
/usr/local/libexec/xtables-addons/xt_geoip_dl: 5: cannot create dbip-country-lite.csv: Permission denied
```

After successful run:

```bash
ls ~/xtables/
# dbip-country-lite.csv
```

> ⚠️ **Lab Note:** If you accidentally run `xt_geoip_dl` from the wrong directory (e.g. `/tmp/xtables-addons-3.26/`), the CSV lands there instead. Always `cd` first.

### Step 7 — Create destination directory for binary DB

```bash
sudo mkdir -p /usr/share/xt_geoip
```

Running without `sudo`:

```
mkdir: cannot create directory '/usr/share/xt_geoip': Permission denied
```

### Step 8 — Build binary database from CSV

```bash
sudo /usr/local/libexec/xtables-addons/xt_geoip_build -D /usr/share/xt_geoip ~/xtables/dbip-country-lite.csv
```

Syntax breakdown:

```
xt_geoip_build  -D  <OUTPUT_DIR>              <INPUT_CSV>
                     /usr/share/xt_geoip       ~/xtables/dbip-country-lite.csv
```

Expected output:

```
701689 entries total
```

> ⚠️ **Common Mistake (lab-verified):**
>
> ```bash
> # WRONG — passes "usr/share/xt_geoip/*.csv" as the -D directory argument
> sudo xt_geoip_build -D usr/share/xt_geoip/*.csv
> # Error: Target directory "usr/share/xt_geoip/*.csv" does not exist.
> ```
>
> Two errors in that command:
>
> 1. `-D` expects the **output directory** — the CSV is a **separate positional argument after it**
> 2. Missing leading `/` → `usr/share/` is a relative path, not `/usr/share/`

### Step 9 — Verify database files were created

```bash
ls -l /usr/share/xt_geoip/
```

Expected output — one binary file per country code:

```
-rw-r--r-- 1 root root  ... CN.iv4
-rw-r--r-- 1 root root  ... CN.iv6
-rw-r--r-- 1 root root  ... US.iv4
...
```

---

## 6. Load Kernel Module

```bash
depmod -a
```

This updates the kernel module dependency map so the GeoIP kernel module can be loaded on demand when iptables rules reference it.

---

## 7. Verify GeoIP Match is Available

```bash
iptables -m geoip -h
```

- Should print geoip match options without errors
- If it fails → module not loaded or database not built correctly

---

## 8. Writing GeoIP iptables Rules

### Block all traffic from China (CN)

```bash
iptables -I INPUT -m geoip --src-cc CN -j DROP
```

### Log traffic from China (before dropping)

```bash
iptables -I INPUT -m geoip --src-cc CN -j LOG \
    --log-level debug \
    --log-prefix "traffic from china: "
```

### Combined — Log then Drop (correct order)

```bash
# Rule 1 — LOG first (lower rule number = higher priority with -I)
iptables -A INPUT -m geoip --src-cc CN -j LOG \
    --log-level debug \
    --log-prefix "traffic from china: "

# Rule 2 — DROP after logging
iptables -A INPUT -m geoip --src-cc CN -j DROP
```

> ⚠️ **Exam Trap:** With `-I` (insert), **last inserted = first matched**.  
> To LOG then DROP, either use `-A` (append) in order, or use `-I` with explicit rule numbers.

### Block multiple countries

```bash
iptables -I INPUT -m geoip --src-cc CN,RU,KP -j DROP
```

Multiple country codes are **comma-separated** (no spaces).

---

## 9. Verify Rules

```bash
iptables -L -v
```

| Flag             | Meaning                                              |
| ---------------- | ---------------------------------------------------- |
| `-L`             | List all rules                                       |
| `-v`             | Verbose — shows packet/byte counters and interface   |
| `-n`             | Numeric — don't resolve hostnames (faster)           |
| `--line-numbers` | Show rule numbers (useful for `-D` delete by number) |

Full recommended command:

```bash
iptables -L INPUT -v -n --line-numbers
```

---

## 10. Data Flow Summary

```
xtables-addons source (.tar.xz)
        |
        v
  ./configure && make && make install
        |
        v
/usr/local/libexec/xtables-addons/
    sudo xt_geoip_dl     --> downloads dbip-country-lite.csv
                              into CURRENT DIRECTORY (cd first!)
        |
        v
~/xtables/dbip-country-lite.csv     (701689 entries)
        |
        v
sudo mkdir -p /usr/share/xt_geoip
        |
        v
sudo /usr/local/libexec/xtables-addons/xt_geoip_build \
    -D /usr/share/xt_geoip ~/xtables/dbip-country-lite.csv
    ^^ output dir ^^        ^^ input CSV (separate arg) ^^
        |
        v
/usr/share/xt_geoip/     --> CN.iv4, CN.iv6, US.iv4 ...
        |
        v
  depmod -a               --> kernel module index updated
        |
        v
  iptables -m geoip --src-cc CN -j DROP
```

---

## 11. Viva / Exam Q&A

**Q: Why can't stock iptables block by country?**  
A: iptables matches on IP, port, protocol, and state — it has no built-in GeoIP database. `xtables-addons` adds this via a kernel loadable module (`xt_geoip`).

**Q: What does `xt_geoip_dl` do?**  
A: Downloads the DB-IP free country-lite CSV database that maps IP ranges to country codes.

**Q: What does `xt_geoip_build` do?**  
A: Converts the CSV file into binary lookup files (per country, `.iv4` / `.iv6`) stored in `/usr/share/xt_geoip/`. iptables uses these for fast matching.

**Q: Why is `linux-headers-$(uname -r)` needed?**  
A: Xtables-addons compiles kernel modules. Kernel headers matching the **running kernel version** are required for the build to succeed.

**Q: What does `depmod -a` do?**  
A: Scans all installed kernel modules and rebuilds the dependency map (`modules.dep`), allowing the kernel to automatically load `xt_geoip` when an iptables rule references it.

**Q: Difference between `-I` and `-A` in iptables?**  
A: `-I` inserts at the top (or specified position) — highest priority. `-A` appends to the bottom. For LOG then DROP, use `-A` in order, or `-I` with explicit position numbers.

**Q: Country code format for `--src-cc`?**  
A: ISO 3166-1 alpha-2 codes (2-letter uppercase). Multiple countries: `--src-cc CN,RU,KP` (comma-separated, no spaces).

---

## 12. Quick Reference Card

```
INSTALL DEPS    apt install automake gcc libc6-dev libxtables-dev
                linux-headers-$(uname -r) libnet-cidr-lite-perl
                libtext-csv-xs-perl make pkg-config wget unzip

BUILD SOURCE    tar -xf xtables-addons-*.tar.xz
                cd xtables-addons-*/
                ./configure && make && make install

DOWNLOAD DB     sudo mkdir /home/$USER/xtables
                cd ~/xtables
                sudo /usr/local/libexec/xtables-addons/xt_geoip_dl
                # --> dbip-country-lite.csv saved in cwd (701689 entries)

BUILD DB        sudo mkdir -p /usr/share/xt_geoip
                sudo /usr/local/libexec/xtables-addons/xt_geoip_build \
                    -D /usr/share/xt_geoip ~/xtables/dbip-country-lite.csv
                # -D = output dir | last arg = input CSV (separate!)

LOAD MODULE     depmod -a

VERIFY          iptables -m geoip -h

BLOCK COUNTRY   iptables -I INPUT -m geoip --src-cc CN -j DROP
LOG COUNTRY     iptables -A INPUT -m geoip --src-cc CN -j LOG \
                    --log-level debug --log-prefix "traffic from china: "

LIST RULES      iptables -L INPUT -v -n --line-numbers
```
