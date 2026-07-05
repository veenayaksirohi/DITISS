# Fail2Ban & iptables NAT — Notes

## 1. Fail2Ban Concept

Fail2Ban monitors log files (e.g. SSH auth logs) for repeated failed login attempts and automatically bans the offending IP by inserting a block rule (iptables/nftables) for a set duration.

## 2. Install

```bash
sudo apt install iptables python3-systemd fail2ban
```

## 3. Check Version

```bash
fail2ban-server --version
```

## 4. Service Management (systemd)

```bash
sudo systemctl start fail2ban
sudo systemctl status fail2ban
sudo systemctl reload fail2ban
sudo systemctl enable fail2ban
```

## 5. Sudo Privilege Config (if needed)

```bash
sudo visudo
```

## 6. Config Files

```bash
ls -l /etc/fail2ban/jail.conf
sudo vim /etc/fail2ban/jail.local
```

`jail.conf` = default config (don't edit directly — gets overwritten on updates).
`jail.local` = your override file (created/edited by admin, takes precedence).

## 7. jail.local — sshd Jail Example

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

## 8. Status Commands

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

---

## 9. iptables NAT

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
