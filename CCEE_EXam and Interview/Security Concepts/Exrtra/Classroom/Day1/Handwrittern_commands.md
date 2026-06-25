# namp Scans 

| Purpose                 | Description                       | Example                           |
| ----------------------- | --------------------------------- | --------------------------------- |
| Host Discovery          | Find which systems are online     | `nmap -sn 192.168.1.0/24`         |
| Port Scanning           | Detect open ports                 | `nmap 192.168.1.10`               |
| Service Detection       | Identify running services         | `nmap -sV 192.168.1.10`           |
| OS Detection            | Guess target operating system     | `nmap -O 192.168.1.10`            |
| Version Detection       | Detect software versions          | `nmap -sV 192.168.1.10`           |
| Network Inventory       | List devices in a network         | `nmap -sn subnet`                 |
| Vulnerability Scanning  | Run NSE security scripts          | `nmap --script vuln target`       |
| Firewall Detection      | Identify filtered ports/firewalls | `nmap -sA target`                 |
| Stealth Scanning        | Reduce detection chances          | `nmap -sS target`                 |
| UDP Scanning            | Scan UDP services                 | `nmap -sU target`                 |
| Aggressive Scanning     | Combined detailed scan            | `nmap -A target`                  |
| Script Automation       | Use NSE scripts for automation    | `nmap --script http-title target` |
| Network Troubleshooting | Diagnose connectivity issues      | `nmap -Pn target`                 |
| Security Auditing       | Assess exposed services           | `nmap -sV -O target`              |
| Compliance Checking     | Verify allowed ports/services     | custom scans                      |


# `TCP UDP '
| Scan Type                | Option | Example Command              | Stealth | Speed  | Privilege Needed |
| ------------------------ | ------ | ---------------------------- | ------- | ------ | ---------------- |
| TCP Connect Scan         | `-sT`  | `nmap -sT 192.168.1.10`      | Low     | Medium | No               |
| TCP SYN (Half-Open) Scan | `-sS`  | `sudo nmap -sS 192.168.1.10` | High    | Fast   | Yes              |
| UDP Scan                 | `-sU`  | `sudo nmap -sU 192.168.1.10` | Medium  | Slow   | Yes              |

# Most Frequently Used

| Purpose                   | Command                |
| ------------------------- | ---------------------- |
| Check live hosts          | `nmap -sn target`      |
| Basic port scan           | `nmap target`          |
| Stealth scan              | `sudo nmap -sS target` |
| Service/version detection | `nmap -sV target`      |
| OS detection              | `sudo nmap -O target`  |
| Aggressive scan           | `sudo nmap -A target`  |
| UDP ports                 | `sudo nmap -sU target` |

| Task                | Command                    |
| ------------------- | -------------------------- |
| Scan specific port  | `nmap -p 80 target`        |
| Scan multiple ports | `nmap -p 22,80,443 target` |
| Scan port range     | `nmap -p 1-1000 target`    |
| Scan all ports      | `nmap -p- target`          |

# Detailed Nmap Report Output Table

| Option            | Full Form              | File Extension      | Purpose                                | Human Readable | Machine Readable | Best Use Case                    | Example Command                                       |
| ----------------- | ---------------------- | ------------------- | -------------------------------------- | -------------- | ---------------- | -------------------------------- | ----------------------------------------------------- |
| `-oN`             | Normal Output          | `.nmap` / `.txt`    | Standard text report                   | Yes            | No               | Manual analysis                  | `nmap 192.168.1.10 -oN report.txt`                    |
| `-oX`             | XML Output             | `.xml`              | Structured XML data                    | Medium         | Yes              | Automation, parsing, importing   | `nmap 192.168.1.10 -oX report.xml`                    |
| `-oG`             | Grepable Output        | `.gnmap`            | Compact grep-friendly output           | Limited        | Partial          | Filtering with grep/awk/scripts  | `nmap 192.168.1.10 -oG report.gnmap`                  |
| `-oA`             | All Formats            | `.nmap .xml .gnmap` | Generates all report types together    | Yes            | Yes              | Professional pentesting workflow | `nmap 192.168.1.10 -oA fullscan`                      |
| `--append-output` | Append Existing Output | Existing file       | Adds new results without overwrite     | Yes            | Depends          | Continuous logging               | `nmap scanme.nmap.org -oN report.txt --append-output` |
| `-v`              | Verbose Mode           | Terminal            | More detailed live output              | Yes            | No               | Troubleshooting scans            | `nmap -v 192.168.1.10`                                |
| `-vv`             | Very Verbose           | Terminal            | Highly detailed runtime info           | Yes            | No               | Debugging scans                  | `nmap -vv 192.168.1.10`                               |
| `-d`              | Debugging              | Terminal            | Internal debugging information         | Noisy          | No               | Advanced troubleshooting         | `nmap -d 192.168.1.10`                                |
| `--reason`        | Port State Reason      | Included in report  | Shows why Nmap marked port open/closed | Yes            | Partial          | Understanding responses          | `nmap --reason 192.168.1.10`                          |
| `--open`          | Show Only Open Ports   | Filtered output     | Hides closed/filtered ports            | Yes            | Partial          | Cleaner reports                  | `nmap --open 192.168.1.10`                            |
| `--packet-trace`  | Packet Trace           | Terminal            | Displays sent/received packets         | Advanced       | No               | Packet-level analysis            | `nmap --packet-trace 192.168.1.10`                    |
| `--stats-every`   | Periodic Statistics    | Terminal            | Shows scan progress periodically       | Yes            | No               | Long scans monitoring            | `nmap --stats-every 10s 192.168.1.10`                 |

---

---
---

# Example Generated Files

If command is:

```bash id="h6bcld"
nmap 192.168.1.10 -oA network_scan
```

Generated files:

| File                 | Content               |
| -------------------- | --------------------- |
| `network_scan.nmap`  | Human-readable report |
| `network_scan.xml`   | XML structured data   |
| `network_scan.gnmap` | Grepable compact data |

---

# Sample XML to HTML Conversion Flow

| Step            | Command                            |
| --------------- | ---------------------------------- |
| Generate XML    | `nmap 192.168.1.10 -oX scan.xml`   |
| Convert HTML    | `xsltproc scan.xml -o report.html` |
| Open in browser | `firefox report.html`              |

---

# Professional Pentesting Example

```bash id="7jxk6x"
sudo nmap -sS -sV -O -A -p- -T4 192.168.1.10 -oA enterprise_scan
```

| Parameter | Purpose                 |
| --------- | ----------------------- |
| `-sS`     | SYN stealth scan        |
| `-sV`     | Version detection       |
| `-O`      | OS fingerprinting       |
| `-A`      | Aggressive detection    |
| `-p-`     | Scan all ports          |
| `-T4`     | Faster timing           |
| `-oA`     | Save all report formats |

---

# Interview Questions

| Question                                          | Answer            |
| ------------------------------------------------- | ----------------- |
| Which output is best for automation?              | XML (`-oX`)       |
| Which option creates all formats?                 | `-oA`             |
| Which format supports grep filtering?             | `-oG`             |
| Which format converts to HTML?                    | XML               |
| Which option prevents overwriting reports?        | `--append-output` |
| Which option shows runtime statistics?            | `--stats-every`   |
| Which option displays packet-level communication? | `--packet-trace`  |




























# Host Discovery 

`namp -sn <target_ip>`

This command uses Nmap to perform a **host discovery (ping scan)** against the IP address `<target_ip>`.

Breakdown:

* `nmap`
  Runs the Nmap network scanner.

* `-sn`
  Means **“Ping Scan”** (older versions called it `-sP`).

  It tells Nmap:

  * **Do not do port scanning**
  * Only check whether the host is **up/reachable**

* `<target_ip>`
  The target IP address being checked.

What Nmap typically does with `-sn`:

* Sends ICMP echo requests (“ping”)
* May send TCP SYN/ACK probes
* May use ARP requests on local networks

The exact probes depend on:

* Your privileges (root/admin or not)
* Operating system
* Whether the target is local or remote

Example output:

```bash
Starting Nmap 7.94
Nmap scan report for 123.60.57.169
Host is up (0.12s latency).
Nmap done: 1 IP address (1 host up) scanned in 2.15 seconds
```

Meaning:

* The host responded
* No ports were scanned

If the host does not respond:

```bash
Note: Host seems down.
```

# Common use cases:

* Checking if a server is online
* Discovering active hosts in a subnet
* Quick network inventory
* Pre-scan before deeper enumeration

Related commands:

```bash
nmap 123.60.57.169                      #  Performs a normal port scan.
```

```bash
nmap -sn 192.168.1.0/24                  #  Discovers live hosts on an entire subnet.
```



```bash
sudo nmap -sn -PE 123.60.57.169
```

Uses ICMP echo requests explicitly.
