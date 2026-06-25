# Nmap Commands and Their Purpose
nmap -sV -p- -oX scan.xml 192.168.0.

| Command                                   | Purpose                       |
| ----------------------------------------- | ----------------------------- |
| `nmap <target>`                           | Basic port scan               |
| `nmap -sn <target>`                       | Host discovery (ping scan)    |
| `nmap -sS <target>`                       | TCP Half-Open (SYN) scan      |
| `nmap -sT <target>`                       | TCP Connect scan              |
| `nmap -sU <target>`                       | UDP scan                      |
| `nmap -sV <target>`                       | Service/version discovery     |
| `nmap -O <target>`                        | OS discovery                  |
| `nmap -A <target>`                        | Aggressive scan               |
| `nmap -p 80 <target>`                     | Scan specific port            |
| `nmap -p 21,22,80 <target>`               | Scan multiple ports           |
| `nmap -p- <target>`                       | Scan all 65535 TCP ports      |
| `nmap -F <target>`                        | Fast scan (common ports only) |
| `nmap --open <target>`                    | Show only open ports          |
| `nmap -sC <target>`                       | Run default NSE scripts       |
| `nmap -Pn <target>`                       | Skip host discovery           |
| `nmap -v <target>`                        | Verbose output                |
| `nmap -vv <target>`                       | More verbose output           |
| `nmap -vvv <target>`                      | Very detailed verbose output  |
| `nmap -T4 <target>`                       | Faster scan timing            |
| `nmap -T5 <target>`                       | Very aggressive timing        |
| `nmap -sA <target>`                       | ACK scan                      |
| `nmap -sF <target>`                       | FIN scan                      |
| `nmap -sX <target>`                       | Xmas scan                     |
| `nmap -sN <target>`                       | NULL scan                     |
| `nmap -6 <target>`                        | IPv6 scan                     |
| `nmap --traceroute <target>`              | Perform traceroute            |
| `nmap --top-ports 100 <target>`           | Scan top 100 ports            |
| `nmap --script vuln <target>`             | Vulnerability scan using NSE  |
| `nmap --script http-enum <target>`        | Enumerate web directories     |
| `nmap --script ftp-anon <target>`         | Check anonymous FTP login     |
| `nmap --script smb-os-discovery <target>` | SMB OS detection              |
| `nmap -oN file.txt <target>`              | Save normal report            |
| `nmap -oX file.xml <target>`              | Save XML report               |
| `nmap -oG file.gnmap <target>`            | Save grepable report          |
| `nmap -oA report <target>`                | Save all report formats       |

---


sudo nmap -vvv -p- -sS -sV 192.168.0.68

# Combined Commands

| Command                                   | Purpose                               |
| ----------------------------------------- | ------------------------------------- |
| `nmap -sS -sV -O <target>`                | SYN scan + version + OS detection     |
| `nmap -A -p- <target>`                    | Aggressive full-port scan             |
| `nmap -sS -sU -sV <target>`               | TCP + UDP + version scan              |
| `nmap -p- -sS --open <target>`            | Full SYN scan showing only open ports |
| `sudo nmap -vvv -p- -sS --open <target>`  | Verbose full SYN scan                 |
| `nmap -p- -sS -sU -sV -O --open <target>` | Full TCP/UDP scan + OS + versions     |

---

# Wireshark Filters Used with Nmap

Using Wireshark:

| Filter                                     | Purpose                      |
| ------------------------------------------ | ---------------------------- |
| `tcp.flags.syn == 1`                       | SYN packets                  |
| `tcp.flags.syn == 1 && tcp.flags.ack == 0` | SYN scan packets             |
| `tcp.flags.syn == 1 && tcp.flags.ack == 1` | Open port replies            |
| `tcp.flags.reset == 1`                     | RST packets                  |
| `icmp.type == 3`                           | ICMP destination unreachable |
| `udp`                                      | UDP traffic                  |
| `tcp.port == 80`                           | HTTP packets                 |
| `tcp.port == 22`                           | SSH packets                  |
| `tcp.port == 21`                           | FTP packets                  |

---

# Important Port Numbers

| Port  | Service |
| ----- | ------- |
| 21    | FTP     |
| 22    | SSH     |
| 23    | Telnet  |
| 25    | SMTP    |
| 53    | DNS     |
| 67/68 | DHCP    |
| 69    | TFTP    |
| 80    | HTTP    |
| 110   | POP3    |
| 123   | NTP     |
| 143   | IMAP    |
| 161   | SNMP    |
| 443   | HTTPS   |
| 445   | SMB     |
| 3306  | MySQL   |
| 3389  | RDP     |

---

# One-Liner Revision

> Nmap uses different scan types and options like `-sS`, `-sV`, `-O`, and `-p-` to perform host discovery, port scanning, service detection, OS fingerprinting, and vulnerability assessment.
