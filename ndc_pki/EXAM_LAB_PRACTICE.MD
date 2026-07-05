# Wireshark, tcpdump, Fail2Ban & iptables NAT — Study Notes

### CDAC DITISS | Network Monitoring, Intrusion Prevention & NAT

---

# PART A: Wireshark Display Filters & tcpdump Cheat Sheet

## 1. Wireshark Display Filters

Display filters narrow down packets **already captured** — they don't stop capture, they hide/show rows in the GUI.

### 1.1 IP Filters

```text
ip.addr == 192.168.1.10     # traffic to OR from this IP
ip.src  == 192.168.1.10     # traffic FROM this IP only
ip.dst  == 192.168.1.10     # traffic TO this IP only
```

### 1.2 TCP / UDP Filters

```text
tcp
udp
tcp.port == 80
tcp.srcport == 443
tcp.dstport == 22
udp.port == 53
```

### 1.3 Protocol Filters

```text
http
https
dns
icmp
arp
ftp
ssh
tls
```

### 1.4 HTTP Filters

```text
http
http.request
http.response
http.host contains "google"
http.request.method == "GET"
```

### 1.5 TLS / HTTPS Filters

```text
tls
tls.handshake
tls.handshake.type == 1        # Client Hello
tls.handshake.type == 2        # Server Hello
```

### 1.6 ICMP (Ping)

```text
icmp
icmp.type == 8    # Echo Request
icmp.type == 0    # Echo Reply
```

### 1.7 Finding Errors / Anomalies

```text
tcp.analysis.retransmission
tcp.analysis.lost_segment
tcp.flags.reset == 1
tcp.flags.syn   == 1
```

### 1.8 TCP Flag Reference Table

| Filter                 | Meaning                                   |
| ---------------------- | ----------------------------------------- |
| `tcp.flags.syn == 1`   | SYN packet (connection start)             |
| `tcp.flags.ack == 1`   | ACK packet (acknowledgment)               |
| `tcp.flags.fin == 1`   | FIN packet (graceful close)               |
| `tcp.flags.reset == 1` | RST packet (forced/abrupt close)          |
| `tcp.flags.push == 1`  | PSH packet (push data to app immediately) |
| `tcp.flags.urg == 1`   | URG packet (urgent pointer set)           |

### 1.9 Combining Filters

**AND**

```text
ip.addr == 192.168.1.10 && tcp.port == 443
```

**OR**

```text
dns || http
```

**NOT**

```text
!(arp)
```

### 1.10 Useful Troubleshooting Filters

| Goal                                          | Filter                                     |
| --------------------------------------------- | ------------------------------------------ |
| All traffic to/from a host                    | `ip.addr == 10.0.0.5`                      |
| Web traffic only                              | `tcp.port == 80 \|\| tcp.port == 443`      |
| DNS requests only (not responses)             | `dns && dns.flags.response == 0`           |
| Failed / reset TCP connections                | `tcp.flags.reset == 1`                     |
| SYN packets (connection attempts, no ACK yet) | `tcp.flags.syn == 1 && tcp.flags.ack == 0` |

---

## 2. tcpdump — CLI Packet Capture

Unlike Wireshark's display filters, tcpdump filters (BPF syntax) apply **at capture time**.

### 2.1 Interfaces

```bash
sudo tcpdump -D              # list all available capture interfaces (numbered)
sudo tcpdump -i eth0         # capture on interface eth0
sudo tcpdump -i eth0 -c 10   # capture only 10 packets on eth0
```

### 2.2 Output Verbosity & Name Resolution

```bash
sudo tcpdump -n       # don't resolve hostnames (show IPs)
sudo tcpdump -nn      # don't resolve hostnames OR port names (show raw numbers)
sudo tcpdump -v       # verbose
sudo tcpdump -vv      # more verbose
sudo tcpdump -vvv     # most verbose
```

**Why `-nn` matters (interview trap):** `-nn` is the standard in security work — it prevents DNS lookups from tipping off the target being scanned/monitored, and it's faster since no reverse lookups happen.

### 2.3 Save / Read Capture Files

```bash
sudo tcpdump -w capture.pcap        # write capture to file
sudo tcpdump -r capture.pcap        # read/replay a saved capture
```

### 2.4 Filtering by Protocol on a Specific Interface

```bash
sudo tcpdump -i 1 tcp -nn
sudo tcpdump -i 1 udp -nn
sudo tcpdump -i 1 icmp -nn
```

> ⚠️ **Fixed from raw notes:** `tcp(udp or icmp)` isn't valid syntax — you capture **one interface**, and the protocol keyword (`tcp`, `udp`, `icmp`, `arp`) is a single filter expression. To capture udp OR icmp together, use:
>
> ```bash
> sudo tcpdump -i 1 -nn 'udp or icmp'
> ```

### 2.5 Filtering by Host

```bash
sudo tcpdump src 192.168.1.10        # traffic FROM this host
sudo tcpdump dst 192.168.1.10        # traffic TO this host
sudo tcpdump host 192.168.1.10       # traffic TO or FROM this host (both directions)
```

### 2.6 Filtering by Port

```bash
sudo tcpdump port 80
```

### 2.7 Host + Direction + Negation

```bash
sudo tcpdump host 192.168.1.100          # all traffic involving this host
sudo tcpdump not host 192.168.1.100      # everything EXCEPT this host
```

> ⚠️ **Cleaned up from raw notes:** The original shorthand `sud tcp src=192.168.1.100 | dst=192.168.1.100()` isn't valid tcpdump syntax. There's no `src=`/`dst=` key-value format and no `sud` command. The correct forms are:
>
> ```bash
> sudo tcpdump src 192.168.1.100      # from this host
> sudo tcpdump dst 192.168.1.100      # to this host
> ```

### 2.8 Combining tcpdump Filters (BPF logic)

```bash
sudo tcpdump -nn 'host 192.168.1.10 and port 443'
sudo tcpdump -nn 'tcp and (port 80 or port 443)'
sudo tcpdump -nn 'not arp'
```

---

## 3. Quick Reference Card

| Task                     | Wireshark Display Filter               | tcpdump Capture Filter                |
| ------------------------ | -------------------------------------- | ------------------------------------- |
| Traffic to/from a host   | `ip.addr == x.x.x.x`                   | `host x.x.x.x`                        |
| Traffic from a host only | `ip.src == x.x.x.x`                    | `src x.x.x.x`                         |
| Traffic to a host only   | `ip.dst == x.x.x.x`                    | `dst x.x.x.x`                         |
| Specific port            | `tcp.port == 80`                       | `port 80`                             |
| Exclude a protocol       | `!(arp)`                               | `not arp`                             |
| Combine conditions       | `&&`, `\|\|`                           | `and`, `or`                           |
| DNS only                 | `dns`                                  | `port 53`                             |
| SYN scan detection       | `tcp.flags.syn==1 && tcp.flags.ack==0` | `'tcp[13] == 2'` (SYN-only flag byte) |

**Key conceptual difference (common viva question):**

- **tcpdump filters (BPF)** decide **what gets captured/written** — packets that don't match are discarded and gone.
- **Wireshark display filters** decide **what gets shown** from a capture that already contains everything — you can always clear the filter and see the rest.

---

# PART B: Fail2Ban & iptables NAT

## 4. Fail2Ban Concept

Fail2Ban monitors log files (e.g. SSH auth logs) for repeated failed login attempts and automatically bans the offending IP by inserting a block rule (iptables/nftables) for a set duration.

## 5. Install

```bash
sudo apt install iptables python3-systemd fail2ban
```

## 6. Check Version

```bash
fail2ban-server --version
```

## 7. Service Management (systemd)

```bash
sudo systemctl start fail2ban
sudo systemctl status fail2ban
sudo systemctl reload fail2ban
sudo systemctl enable fail2ban
```

## 8. Sudo Privilege Config (if needed)

```bash
sudo visudo
```

## 9. Config Files

```bash
ls -l /etc/fail2ban/jail.conf
sudo vim /etc/fail2ban/jail.local
```

`jail.conf` = default config (don't edit directly — gets overwritten on updates).
`jail.local` = your override file (created/edited by admin, takes precedence).

## 10. jail.local — sshd Jail Example

```ini
[sshd]
enabled = true
port    = 22
filter  = sshd
backend = systemd
bantime  = 3600
findtime = 600
maxretry = 5
```

| Field      | Meaning                                                                              |
| ---------- | ------------------------------------------------------------------------------------ |
| `enabled`  | turns this jail on                                                                   |
| `port`     | port(s) this jail monitors/blocks                                                    |
| `filter`   | log-pattern filter used to detect failures (`/etc/fail2ban/filter.d/sshd.conf`)      |
| `backend`  | log-reading method — `systemd` on systems using journald, `auto`/`polling` otherwise |
| `bantime`  | how long (seconds) an IP stays banned                                                |
| `findtime` | time window (seconds) in which failures are counted                                  |
| `maxretry` | number of failures allowed within `findtime` before ban                              |

## 11. Status Commands

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

---

## 12. iptables NAT — Concepts

```bash
iptables -t nat -L
```

### Example Topology

| Interface | Network |
| --------- | ------- |
| LAN       | ens33   |
| WAN       | ens36   |

- **LAN → WAN**: SNAT (Source NAT) — rewrites the source IP of outbound LAN traffic to the router's WAN IP
- **WAN → LAN**: DNAT (Destination NAT) — rewrites the destination IP of inbound WAN traffic to an internal LAN IP (port forwarding)

### MASQUERADE (dynamic SNAT) on the WAN interface

```bash
sudo iptables -t nat -A POSTROUTING -o ens36 -j MASQUERADE
```

- `-t nat` — use the NAT table
- `-A POSTROUTING` — append to POSTROUTING chain (applies just before packet leaves the interface)
- `-o ens36` — outbound interface (WAN)
- `-j MASQUERADE` — dynamically replace source IP with the outgoing interface's IP (used when WAN IP is dynamic/DHCP; use `-j SNAT --to-source <ip>` instead if WAN IP is static)

---

## 13. Fail2Ban Practical — Protect SSH from Brute Force Attack

Your practical was almost correct. Here's a clean version for your lab record.

### Topology

| Machine                   | IP Address          | Purpose                   |
| ------------------------- | ------------------- | ------------------------- |
| Deb1 (Victim/Jail Server) | **192.168.129.136** | Runs SSH + Fail2Ban       |
| Machine 2 (Attacker)      | **192.168.0.22**    | Attempts wrong SSH logins |

### Step 1: Install Required Packages (Victim)

```bash
apt update
apt install -y iptables python3-systemd fail2ban
```

### Step 2: Verify Installation

```bash
fail2ban-server --version      # check Fail2Ban version
systemctl status fail2ban      # check service status
```

Initially it may show **failed** because no jail is configured.

### Step 3: Create Local Configuration

Instead of editing the original configuration file, create a local override file.

```bash
vi /etc/fail2ban/jail.local
```

Add:

```ini
[sshd]
enabled = true
backend = systemd
port = 22
filter = sshd
maxretry = 3
findtime = 600
bantime = 3600
```

Save and exit:

```
:wq
```

> ⚠️ **Correction from raw notes:** a stray line reading `jail.local` (as a config _option_ inside the file) was in the original draft — that is not a valid configuration key and must not appear inside the `[sshd]` block. `jail.local` is only the **filename**, not a setting.

### Step 4: Restart Fail2Ban

```bash
systemctl restart fail2ban
```

If not running:

```bash
systemctl start fail2ban
```

Enable at boot (optional):

```bash
systemctl enable fail2ban
```

### Step 5: Verify Jail

Check overall status:

```bash
fail2ban-client status
```

Expected:

```
Status
|- Number of jail: 1
`- Jail list: sshd
```

Check SSH jail:

```bash
fail2ban-client status sshd
```

Expected output:

```
Status for the jail: sshd

Currently failed:
Currently banned:
Banned IP list:
```

### Step 6: Check IPTables Rules

Initially:

```bash
iptables -L
```

Or continuously monitor:

```bash
watch iptables -L
# or
watch -n 1 iptables -L
```

Initially, no Fail2Ban chain will contain banned IPs.

### Step 7: Attack from Machine 2

From attacker machine:

```bash
ssh user@192.168.129.136
```

Enter a **wrong password** three times.

Example:

```
password: abc
password: 123
password: hello
```

Since `maxretry = 3`, the attacker IP will be banned.

### Step 8: Verify Ban

On victim machine:

```bash
fail2ban-client status sshd
```

Expected:

```
Currently banned: 1

Banned IP list:
192.168.0.22
```

Also verify using:

```bash
iptables -L
```

You should see a Fail2Ban chain similar to:

```
Chain f2b-sshd

target     source

REJECT     192.168.0.22
```

or an equivalent DROP/REJECT rule depending on configuration.

### Step 9: Test Again

From attacker machine:

```bash
ssh user@192.168.129.136
```

Connection should now fail because the IP is banned.

### Unban a Specific IP

If an IP was banned (e.g. during testing, or a legitimate user got locked out), it can be manually removed from the ban list without waiting for `bantime` to expire.

```bash
sudo fail2ban-client set sshd unbanip 192.168.0.22
```

**Theory:** This removes the IP from Fail2Ban's internal ban list **and** deletes the corresponding iptables/nftables block rule for that IP in one step — you don't need to manually edit iptables separately. Verify it worked with:

```bash
fail2ban-client status sshd
```

The IP should no longer appear under `Banned IP list`.

### Useful Commands Reference

```bash
fail2ban-client status                                # overall status
fail2ban-client status sshd                            # sshd jail status
journalctl -u fail2ban                                  # view logs (systemd)
tail -f /var/log/fail2ban.log                            # view logs (log file)
fail2ban-client set sshd unbanip 192.168.0.22            # unban an IP manually
systemctl restart fail2ban                               # restart service
iptables -L                                              # check firewall rules
```

### Viva Questions

**Q1. What is Fail2Ban?**
Fail2Ban is an intrusion prevention tool that monitors log files and automatically bans IP addresses after repeated failed login attempts.

**Q2. Which service is protected in this practical?**
SSH (`sshd`).

**Q3. What does `maxretry = 3` mean?**
The IP is banned after **3 failed login attempts**.

**Q4. What does `findtime = 600` mean?**
The 3 failed attempts must occur within **600 seconds (10 minutes)**.

**Q5. What does `bantime = 3600` mean?**
The IP remains blocked for **3600 seconds (1 hour)**.

**Q6. Why use `jail.local` instead of modifying `jail.conf`?**
Because `jail.local` overrides the default configuration and is not overwritten during package updates.

---

## 14. iptables NAT & Port Forwarding — Practical Reference

### 14.1 DNAT (Destination NAT)

**Theory:**
DNAT changes the **destination IP/port** of an incoming packet before it is routed, so traffic arriving at a public/router IP gets redirected to a different internal (private) IP. It's applied in the `PREROUTING` chain, since the destination must be rewritten **before** the kernel makes its routing decision. This is the mechanism behind exposing an internal server (e.g., a web server on a private LAN IP) to the outside world through a single public-facing router IP.

**Command:**

```bash
sudo iptables -t nat -A PREROUTING \
  -p tcp --dport 80 \
  -j DNAT --to-destination 192.168.1.100:80
```

**Meaning:**

| Part               | Meaning                 |
| ------------------ | ----------------------- |
| `-t nat`           | NAT table               |
| `PREROUTING`       | Before routing decision |
| `--dport 80`       | Incoming HTTP traffic   |
| `DNAT`             | Change destination      |
| `--to-destination` | New destination         |

### 14.2 Port Forwarding

**Theory:**
Port forwarding is a specific, very common **application of DNAT** — instead of just changing the destination IP, it also maps a specific external port to a different internal port on the target machine. This lets you expose an internal service (e.g., SSH on port 22) to the outside world via a non-standard external port (e.g., 2222), which also adds a small layer of obscurity against automated scans of the default port.

**Command:**

```bash
sudo iptables -t nat -A PREROUTING \
  -p tcp --dport 2222 \
  -j DNAT --to-destination 192.168.1.100:22
```

**Diagram:**

```
Internet
    │
203.0.113.10:2222
    │
    ▼
Router
    │
    ▼
192.168.1.100:22
```

### 14.3 Enable IP Forwarding

**Theory:**
By default, a Linux machine only processes packets addressed to itself — it does **not** route/forward packets between two other networks/interfaces, since it isn't behaving as a router. `ip_forward` is a kernel parameter that must be explicitly enabled (`0` → `1`) to allow the machine to act as a router/gateway, forwarding packets from one network interface to another. Without this, NAT/DNAT rules are pointless because the kernel will never pass the packet along in the first place.

```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

### 14.4 Allow Forwarded Traffic

**Theory:**
Enabling `ip_forward` at the kernel level only makes forwarding _possible_ — it does not make the firewall _permit_ it. iptables evaluates forwarded (routed, non-local) packets against the **FORWARD** chain of the `filter` table, separately from `INPUT`/`OUTPUT` (which only apply to traffic destined for or originating from the local machine itself). If the FORWARD chain's default policy is DROP (common on hardened systems), traffic will be silently discarded even though NAT rewrote the destination correctly.

Even if IP forwarding is enabled, the firewall may still block forwarded packets.

The **FORWARD chain** decides whether forwarded packets are allowed.

**Command:**

```bash
sudo iptables -A FORWARD \
  -p tcp \
  -d 192.168.1.100 \
  --dport 22 \
  -j ACCEPT
```

**Meaning:**

- Add a rule to the FORWARD chain.
- Allow TCP packets.
- Destination is 192.168.1.100.
- Destination port is 22.
- Accept the packet.

> ⚠️ Without this rule (or another matching rule), forwarded traffic can be dropped even after DNAT rewrites the destination.

### 14.5 SNAT (Source NAT)

**Theory:**
SNAT changes the **source IP** of an outgoing packet, typically rewriting a private internal LAN IP to a public IP before it leaves the router onto the internet. It's applied in the `POSTROUTING` chain, since the source is rewritten **after** routing has already decided which interface the packet will leave from. This allows multiple internal hosts (all with private IPs) to share a single public IP address for outbound connections, and is the core mechanism behind how home/office routers let many LAN devices access the internet through one WAN IP. SNAT requires a **fixed, known** public IP to rewrite to.

```bash
sudo iptables -t nat -A POSTROUTING \
  -o eth0 \
  -j SNAT --to-source 203.0.113.10
```

### 14.6 MASQUERADE

**Theory:**
MASQUERADE is functionally a variant of SNAT, but instead of requiring you to hardcode a fixed public IP with `--to-source`, it automatically detects and uses whatever IP is **currently assigned** to the outgoing interface at the moment each packet leaves. This makes it the right choice whenever the public/WAN IP can change (DHCP leases, PPPoE reconnects, mobile broadband) — the router doesn't need reconfiguring every time its IP changes, since MASQUERADE looks it up dynamically per packet (which is also why it has a small extra performance cost compared to static SNAT).

MASQUERADE is a special type of SNAT.

It automatically uses the IP address assigned to the outgoing interface, making it ideal for **dynamic public IPs** (DHCP, PPPoE).

**Command:**

```bash
sudo iptables -t nat -A POSTROUTING \
  -o eth0 \
  -j MASQUERADE
```

### 14.7 SNAT vs MASQUERADE

| SNAT                   | MASQUERADE                                        |
| ---------------------- | ------------------------------------------------- |
| Static public IP       | Dynamic public IP                                 |
| Faster                 | Slightly slower (looks up interface IP each time) |
| `--to-source` required | No `--to-source` needed                           |

---

## 15. Master Quick Reference — iptables NAT Chains

| Chain         | Table  | Purpose                                                        | Common Use                               |
| ------------- | ------ | -------------------------------------------------------------- | ---------------------------------------- |
| `PREROUTING`  | nat    | Alters packets as they arrive, before routing decision         | DNAT / port forwarding                   |
| `POSTROUTING` | nat    | Alters packets just before they leave the interface            | SNAT / MASQUERADE                        |
| `FORWARD`     | filter | Decides whether routed (non-local) packets are allowed through | Must ACCEPT forwarded traffic explicitly |

**⚠️ Exam Trap:** DNAT rewrites the destination address in `PREROUTING`, but the packet must _still_ pass the `FORWARD` chain filter rules to actually reach the internal host — a very common mistake in port-forwarding labs is forgetting the `FORWARD ACCEPT` rule and wondering why the DNAT "isn't working."

---

## 16. iptables Logging

**Theory:**
By default, iptables silently ACCEPTs or DROPs packets with no record of what happened. The `LOG` target lets you write matching packets to the **kernel log** (viewable via `dmesg`, `journalctl -k`, or `/var/log/kern.log`) before continuing to the next rule. `LOG` is **not terminal** — unlike `DROP`/`ACCEPT`/`REJECT`, it doesn't decide the packet's fate; it only records it and then processing falls through to the next matching rule. This is why a separate `DROP`/`ACCEPT` rule is usually needed right after a `LOG` rule matching the same traffic.

### 16.1 Log All Dropped Packets

```bash
sudo iptables -A INPUT -j LOG --log-prefix "IPTABLES-DROP: " --log-level 4
```

| Option               | Meaning                                                              |
| -------------------- | -------------------------------------------------------------------- |
| `-j LOG`             | send matching packets to the kernel log                              |
| `--log-prefix "..."` | tag added to each log line, useful for `grep`-ing specific rule hits |
| `--log-level 4`      | syslog severity level (4 = `warning`)                                |

> ⚠️ On its own, this rule only **logs** — it does not drop anything. You still need an explicit `-j DROP` rule (see below) to actually block the traffic.

### 16.2 Log Before Dropping (Rate-Limited)

```bash
sudo iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "DROP: " --log-level 4
sudo iptables -A INPUT -j DROP
```

**Theory:** Logging _every_ dropped packet during an active scan/flood can fill up disk space and the log file within minutes. The `-m limit --limit 5/min` match module caps logging to at most 5 matching log entries per minute, giving you visibility into an attack pattern without a denial-of-service on your own logging system. The `LOG` rule fires first (recording a sample of the traffic), then the un-limited `DROP` rule below it actually blocks **all** matching packets — only the _logging_ is rate-limited, not the blocking.

### 16.3 Log Forwarded Packets

```bash
sudo iptables -A FORWARD -j LOG --log-prefix "FORWARD: " --log-level 4
```

Useful for auditing traffic passing _through_ a router/gateway (as opposed to traffic destined for the local machine itself) — e.g. to see what's happening with NAT/port-forwarded connections.

### 16.4 Log Outgoing Packets

```bash
sudo iptables -A OUTPUT -j LOG --log-prefix "OUTPUT: " --log-level 4
```

Useful for catching unexpected outbound connections — e.g. malware phoning home, or verifying a server isn't making connections it shouldn't.

### 16.5 Viewing the Logs

Search by your custom log prefix:

```bash
sudo journalctl -k | grep IPTABLES-DROP
```

If `rsyslog` is installed, logs may also be written to:

```bash
sudo tail -f /var/log/kern.log
```

### ⚠️ Exam Trap

`LOG` is a **non-terminating target** — it does NOT stop rule processing like `DROP`/`ACCEPT`/`REJECT` do. If you only add a `LOG` rule and nothing else, the packet still falls through to whatever chain policy or later rule applies (often the default `ACCEPT`). Always pair `LOG` with an explicit terminating rule matching the same criteria if you actually want to block the traffic.
