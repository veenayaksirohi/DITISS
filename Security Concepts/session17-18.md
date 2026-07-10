# Session 17 (4T + 2L): Web Servers, Web Apps & Wireless Hacking

**Topics:** Hacking Web Servers | Web Application Vulnerabilities | Web-Based Password Cracking | Wireless Hacking | WEP/WPA Auth & Cracking | Wireless Sniffers, SSID Location & MAC Spoofing | Wireless Hacking Techniques | Securing Wireless Networks

---

## 1. Hacking Web Servers

### 1.1 What Is a Web Server?

A **web server** is software (and often the underlying OS/hardware) that hosts websites and web applications accessible over HTTP/HTTPS. Common web servers: **Apache, Nginx, IIS, Lighttpd, Tomcat**. Because they are publicly exposed, they are high-value targets.

### 1.2 Why Web Servers Are Targeted

- Always reachable from the internet → large attack surface
- Often run outdated software or misconfigured services
- Host sensitive data: user creds, sessions, databases, APIs
- Compromise can lead to: data theft/defacement, lateral movement into internal network, use as a pivot/C2 node, DDoS amplification or botnet node

### 1.3 Common Web Server Attacks & Techniques

**Exploiting Outdated / Unpatched Software**

- Attackers scan for known CVEs in OS, web server software, modules/extensions (mod_ssl, mod_php, CGI scripts)
- Tools: Nmap scripts (`http-vuln-*`, `http-enum`), Nikto, OpenVAS/Nessus, Metasploit

**Directory Traversal Attacks (Path Traversal)**

- Attacker manipulates file paths to access files outside the web root
- Payloads: `../../etc/passwd`, `....//....//etc/shadow`
- Occurs when the app concatenates user input into file paths without validation
- **Impact:** Read config files, source code, credentials; sometimes leads to RCE if combined with file inclusion or log poisoning

**Remote Code Execution (RCE)**

- Vectors: vulnerable CGI/PHP/ASP scripts, deserialization bugs, command injection in parameters, unrestricted file upload (`.php`, `.asp`, `.jsp` shells)
- Once achieved: attacker can run commands, install backdoors, pivot inside the network

**Misconfigured Permissions & Services**

- World-writable directories/files under web root
- Default accounts & passwords (`admin:admin`)
- Unnecessary services enabled (FTP, Telnet, debug/tracing)
- Verbose error messages leaking stack traces, paths, DB info
- Improper SSL/TLS config (weak ciphers, expired certs, misconfigured HSTS)

**SQL Injection Affecting Backend via Web Server**

- Primarily a web-app issue but directly impacts server security posture
- Attacker can read/modify DB, extract admin credentials, sometimes escalate to OS command execution (e.g., `xp_cmdshell` in MSSQL)

**Cross-Site Scripting (XSS) with Server Impact**

- Stored XSS can deface pages served by the server
- Admin panels vulnerable to XSS can lead to session hijack and server config changes

### 1.4 Web Server Hacking Methodology (Attacker View)

**Information Gathering**

- WHOIS, DNS enumeration, subdomain brute-forcing
- Fetch `robots.txt`, `sitemap.xml`, `.git/`, `.env` if exposed
- Identify tech stack via headers (`Server`, `X-Powered-By`); tools: WhatWeb, Wappalyzer, BuiltWith

```bash
nmap -sV -p80,443 <target>
nmap --script http-enum -p80 <target>
nmap --script http-methods <target>
```

**Footprinting & Banner Grabbing**

- `nc <target> 80` then send `GET / HTTP/1.0`
- Tools: Netcat, telnet, Wfetch, HTTPRecon, ID Serve
- Enumerate virtual hosts and common paths: `/admin`, `/phpmyadmin`, `/backup`, `/wp-admin`
- Tools: Nikto, Nmap, HTTPrint, Netcraft

**Mirroring the Website**

- `wget --mirror <url>`, HTTrack, BlackWidow, WebCopier, SurfOffline
- Helps in manual code review and searching for hidden endpoints, comments, JS files with secrets

**Vulnerability Scanning**

- Nikto (server-specific vulns/misconfigs), OpenVAS/Nessus (broader OS + service vulns), w3af, Burp Suite (for web apps)
- Look for outdated software, dangerous HTTP methods (`PUT`, `DELETE`, `TRACE`, `CONNECT`), default files & test pages

```bash
nmap --script http-methods <target>
```

**Session Hijacking & Password Cracking**

- Session hijacking: steal cookies over unencrypted HTTP, predictable session IDs, XSS to steal tokens
- Password cracking: brute-force/dictionary attacks on HTTP Basic/Digest auth, SSH, FTP, RDP, admin panels
- Tools: THC Hydra, Medusa, Burp Intruder

```bash
hydra -l admin -P wordlist.txt <target> http-get /admin
```

### 1.5 Securing Web Servers (Defender View)

| Area                         | Measures                                                                                                                                                              |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Patch Management**         | Regularly update OS packages, web server software & modules, frameworks & libraries; subscribe to vendor security advisories                                          |
| **Hardening (General)**      | Disable unnecessary modules, dangerous HTTP methods, directory listing; run server as non-root; restrict file permissions; remove default pages/test scripts/accounts |
| **Hardening (IIS)**          | Disable tracing & debug compilation; remove unnecessary ISAPI extensions/filters; harden `machine.config` and app pools                                               |
| **Hardening (Apache/Nginx)** | Use `ServerTokens Prod`, `ServerSignature Off`; restrict access to sensitive dirs; enable mod_security or similar WAF                                                 |
| **Network & Architecture**   | Place web servers in a DMZ; multi-tier architecture (web/app/DB tiers separated by firewalls/ACLs); restrict inbound ports to 80/443; host-based firewalls            |
| **Secure Communication**     | Enforce HTTPS; TLS 1.2/1.3 only with strong ciphers; valid certs with expiry monitoring; HSTS; secure cookies (`HttpOnly`, `Secure`, `SameSite`)                      |
| **Logging & Monitoring**     | Detailed access/error logs; centralize (SIEM, ELK, Splunk); monitor unusual request patterns and web-root changes (FIM); hash checks on critical files                |
| **Additional**               | WAF (ModSecurity, cloud WAFs); regular pen tests/vuln scans; rate limiting & account lockout; segment management interfaces; MFA for admin access                     |

---

## 2. Web Application Vulnerabilities

These sit on top of the web server and are often the main entry point.

### 2.1 SQL Injection (SQLi)

Attacker injects malicious SQL into input fields, altering query logic.

**Types:** In-band (error-based, union-based, results visible), Blind (inferred via true/false or time delays), Out-of-band (data exfiltrated via DNS/HTTP)

**Impact:** Data theft (users, passwords, PII); authentication bypass; data modification/deletion; in some DBs, OS command execution

**Prevention:** Parameterized queries/prepared statements; ORM frameworks used properly; input validation; least-privilege DB accounts; WAF rules for SQLi patterns

### 2.2 Cross-Site Scripting (XSS)

Attacker injects malicious scripts into pages viewed by other users.

**Types:** Reflected (payload in URL/request, immediately reflected), Stored (payload stored in DB/comments, served to many users), DOM-based (vulnerability in client-side JS logic)

**Impact:** Session hijacking (cookie theft); defacement, phishing; keylogging, malware delivery

**Prevention:** Output encoding (HTML, JS, URL context); input validation; Content Security Policy (CSP); frameworks that auto-escape by default

### 2.3 Cross-Site Request Forgery (CSRF)

Attacker tricks an authenticated user's browser into sending unwanted requests (e.g., fund transfer, password change).

**Requirements:** User logged in; site relies only on cookies for auth (no CSRF token)

**Prevention:** Anti-CSRF tokens per session/form; check `Origin`/`Referer` headers; `SameSite` cookie attribute; require re-authentication for sensitive actions

### 2.4 File Inclusion Vulnerabilities

- **Local File Inclusion (LFI):** include files from local filesystem
- **Remote File Inclusion (RFI):** include files from remote URLs

**Causes:** User input directly used in `include`, `require`, `fopen`, etc., without validation

**Impact:** Read sensitive files (`/etc/passwd`, configs); execute remote code (via RFI or log poisoning + LFI)

**Prevention:** Avoid dynamic includes with user input; whitelist allowed files; disable `allow_url_include` in PHP; strict input validation and path checks

### 2.5 Broken Authentication & Session Management

**Issues:** Weak password policies; credentials in URLs/logs/error messages; predictable session IDs; no session timeout/invalidation on logout; missing MFA

**Impact:** Account takeover; privilege escalation; persistent access via stolen sessions

**Prevention:** Strong password rules + MFA; secure session generation (random, long IDs); invalidate sessions on logout & password change; HTTPS everywhere; secure cookie flags

### 2.6 Security Misconfiguration

**Examples:** Default credentials & sample apps left enabled; verbose error messages showing stack traces/DB schema; unnecessary services/ports open; improper CORS/security headers

**Prevention:** Hardened, minimal installations; remove default accounts/docs/examples; centralized secure configuration baselines; regular audits and automated config checks

### 2.7 OWASP Top 10 — Context for Web Apps

A baseline of critical web app risks:

- A01: Broken Access Control
- A02: Cryptographic Failures
- A03: Injection (SQLi, OS command, LDAP, etc.)
- A04: Insecure Design
- A05: Security Misconfiguration
- A06: Vulnerable and Outdated Components
- A07: Identification and Authentication Failures
- A08: Software and Data Integrity Failures
- A09: Security Logging and Monitoring Failures
- A10: Server-Side Request Forgery (SSRF)

Use OWASP as a checklist when designing apps, doing code reviews, or planning security assessments.

---

## 3. Web-Based Password Cracking Techniques

Attackers focus on web authentication because compromised credentials give direct access to accounts, admin panels, and sometimes entire systems.

### 3.1 Brute Force Attacks

Try all possible combinations of characters until the correct password is found — fully automated, sending thousands/millions of attempts.

**How it works:** Attacker specifies target URL/login form, username(s), character set, password length range; tool generates and tests passwords systematically.

**Tools:** THC Hydra, Medusa, Burp Suite Intruder, custom Python scripts.

**Effectiveness:** Very effective against short passwords / simple patterns; ineffective against long random passwords or accounts with lockout/rate limiting.

**Defenses:** Minimum password length (12+ chars); account lockout after N failed attempts; rate limiting and CAPTCHAs; monitor logs for repeated failed logins.

### 3.2 Dictionary Attacks

Use a precompiled wordlist (e.g., `rockyou.txt`) instead of trying all combinations, often combined with simple mutations (`password` → `Password1`, `P@ssw0rd`).

**Tools:** Hydra, Burp Intruder, Hashcat/John (for offline hashes).

**Why it works:** Users often choose common words/predictable patterns; leaked password lists are reused as dictionaries.

**Defenses:** Disallow common passwords via policy; password strength meters; user education; combine with MFA.

### 3.3 Credential Stuffing

Reuse leaked username/password pairs from one breach to log in to other sites, exploiting password reuse — often at scale using botnets.

**Impact:** Account takeover on multiple sites from a single breach; financial fraud, identity theft, spam.

**Defenses:** Unique password per site (password manager); MFA/2FA everywhere; monitor for breached credentials (Have I Been Pwned–style services); IP reputation checks, anomalous login patterns, device fingerprinting.

### 3.4 Rainbow Tables (Offline Hash Cracking)

Use precomputed tables mapping password hashes back to plaintext, trading storage for computation time. Attacker obtains hashes (DB dump, `/etc/shadow`, leaked dataset) and looks up matches instead of hashing every guess in real time.

**Limitations:** Ineffective against properly salted hashes and strong hashing algorithms (bcrypt, Argon2, scrypt) with high cost factors.

**Defenses:** Strong, salted password hashing (bcrypt/Argon2); never store plain or weakly hashed passwords; protect password databases rigorously.

### 3.5 Phishing

Trick users into voluntarily revealing credentials via fake websites, emails, or messages impersonating a trusted service.

**Variants:** Spear phishing (targeted); clone phishing (copies legitimate emails); Evilginx-style attacks (reverse proxy to real site, capturing creds in real time).

**Defenses:** User education & awareness training; verify URLs/sender addresses/certificates; MFA (phishing-resistant where possible, e.g., FIDO2/WebAuthn); SPF, DKIM, DMARC, anti-phishing gateways.

### 3.6 Man-in-the-Middle (MITM) on Web

Attacker intercepts communication between user and web server on unencrypted HTTP or poorly configured HTTPS (public Wi-Fi, compromised router), often combined with DNS spoofing, ARP poisoning, or rogue APs.

**Tools:** Wireshark, BetterCAP, Ettercap, MITM frameworks.

**Impact:** Capture of usernames/passwords, session cookies/tokens; potential to modify requests/responses.

**Defenses:** Enforce HTTPS everywhere (HSTS); avoid sending credentials over HTTP; use secure Wi-Fi/VPN; certificate pinning where appropriate.

### 3.7 General Defenses for Web Authentication

- Strong password policies (12+ chars, complexity, no common passwords)
- Rate limiting & account lockout
- Multi-Factor Authentication (TOTP apps, hardware tokens, push notifications)
- Monitoring & logging to detect brute force, credential stuffing, suspicious logins
- Secure session management (random session IDs, secure/HttpOnly/SameSite cookies, proper logout)

---

## 4. Wireless Hacking — Overview

Wireless networks use radio waves, making them inherently more exposed than wired networks — attackers can intercept, inject, or disrupt traffic without physical access.

### 4.0 Wi-Fi Adapter Modes

Wireless NICs can operate in different modes depending on the task. Understanding these is a prerequisite for the sniffing/cracking techniques below, since most attacks require switching out of the default mode.

| Mode                      | Description                                                                                                                                                              | Typical Use                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| **Managed (Client) Mode** | Default mode; NIC associates with a single AP as a normal client                                                                                                         | Everyday browsing/connectivity                                           |
| **Master (AP) Mode**      | NIC acts as an access point, allowing other devices to connect to it                                                                                                     | Turning a machine into a rogue AP / evil twin (`hostapd`, `airbase-ng`)  |
| **Ad-Hoc Mode**           | Peer-to-peer connection between devices without an AP                                                                                                                    | Direct device-to-device links                                            |
| **Monitor Mode**          | NIC captures all 802.11 frames on a channel (management, control, data) without associating to any AP; required for packet injection and passive sniffing                | Sniffing, handshake capture, WEP/WPA cracking (`airodump-ng`, Wireshark) |
| **Promiscuous Mode**      | Captures all frames on the _associated_ network segment (still requires association); more relevant to wired NICs, but sometimes conflated with monitor mode on wireless | General traffic capture within an already-joined network                 |

**Switching to Monitor Mode (Linux example):**

```bash
airmon-ng check kill        # stop interfering processes (NetworkManager, wpa_supplicant)
airmon-ng start wlan0       # enables monitor mode, often creates wlan0mon
# or manually:
ip link set wlan0 down
iwconfig wlan0 mode monitor
ip link set wlan0 up
```

**Notes:**

- Not all Wi-Fi chipsets/drivers support monitor mode or packet injection — this is why pentesters use specific adapters (e.g., Alfa AWUS036 series with Atheros/Ralink chipsets).
- Monitor mode is what enables `airodump-ng`, Wireshark, and Kismet to capture beacons, probe requests, and the WPA 4-way handshake described in Section 5.
- Return to managed mode (`airmon-ng stop wlan0mon` or `iwconfig wlan0 mode managed`) to reconnect normally after an assessment.

### 4.1 Eavesdropping (Wireless Sniffing)

Capture unencrypted or weakly encrypted wireless traffic by putting a Wi-Fi adapter into **monitor mode** and using tools like Wireshark, tcpdump, Airodump-ng.

**What can be captured:** Websites visited (on HTTP); unencrypted credentials; metadata (SSIDs, MAC addresses, device types).

**Defenses:** Use WPA3 (or WPA2 with strong config); encrypt application traffic (HTTPS, SSH, TLS); avoid sensitive data over open Wi-Fi without a VPN.

### 4.2 Man-in-the-Middle (MITM) on Wireless

Attacker positions themselves between client and AP using ARP spoofing, DNS spoofing, or ICMP redirects (tools: BetterCAP, Ettercap, MITMf, responder), routing victim traffic through their machine.

**Impact:** Credential theft; session hijacking; injection of malicious content (JS, redirects).

**Defenses:** HTTPS with certificate validation; avoid trusting unknown Wi-Fi networks; HSTS/certificate pinning; network-side port security, 802.1X, dynamic VLANs.

### 4.3 Rogue Access Points (Evil Twin)

Attacker sets up a fake AP with the same/similar SSID as a legitimate network (often with a stronger signal) to attract clients; once connected, all traffic passes through the attacker's system.

**Variants:** Evil Twin (clones legitimate AP); Karma attacks (responds to any probe request with the requested SSID).

**Tools:** Aircrack-ng suite, hostapd, airbase-ng, Wi-Fi Pumpkin, Mana, Evilginx (credential phishing via Wi-Fi).

**Defenses:** Users verify SSID carefully and prefer 802.1X/EAP enterprise auth; organizations use WPA3-Enterprise, 802.1X, wireless IDS/IPS to detect rogue APs, and user education.

### 4.4 Deauthentication Attacks

Forcefully disconnect clients from a Wi-Fi AP by sending forged deauthentication/disassociation frames with spoofed source MAC, targeting a client or broadcasting.

**Why attackers do it:** Force a client to reconnect to capture the WPA/WPA2 4-way handshake; create opportunities for MITM/evil twin attacks; simple DoS against Wi-Fi users.

**Tools:** `aireplay-ng` (deauth mode), `mdk4`/`mdk3`, BetterCAP/Kismet plugins.

**Mitigation:** WPA3 with management frame protection (802.11w); monitor for abnormal deauth rates (wireless IDS/IPS); 802.1X and strong monitoring in enterprise.

### 4.5 WPS PIN Brute Forcing

Targets routers with WPS (Wi-Fi Protected Setup) enabled, especially the PIN method.

**Why it's weak:** WPS PIN is 8 digits, but the last digit is a checksum (effectively 7 digits), and the protocol validates the PIN in two halves (first 4 digits, then last 3). Attacker needs only ~10⁴ + 10³ ≈ 11,000 attempts, not 10⁸.

**Attack flow:**

1. Discover APs with WPS enabled (`wash`)
2. Run WPS PIN brute-force (Reaver, Bully)
3. Once PIN is recovered, attacker often obtains the WPA/WPA2 PSK as well

**Time:** Often a few hours depending on rate limits and signal.

**Mitigation:** Disable WPS in router settings; use WPA2/WPA3-Personal with strong passphrase or WPA2/WPA3-Enterprise; update firmware.

### 4.6 Jamming and Signal Interference

- **RF jamming:** Transmit noise on 2.4/5 GHz bands to block legitimate Wi-Fi signals (often requires dedicated hardware; may be illegal)
- **Protocol-level DoS:** Deauth/disassociation floods, beacon flooding (many fake SSIDs) — tools: `aireplay-ng`, `mdk4`, `mdk3`

**Impact:** Loss of connectivity; can distract while other attacks occur; serious in critical environments (hospitals, factories).

**Mitigation:** WPA3 with 802.11w; wireless IDS/IPS to detect flood/deauth patterns; physical security and RF monitoring; redundant networks/wired fallbacks.

### 4.7 MAC Spoofing

Deliberately changing the NIC's MAC address to impersonate another device or evade controls (bypass MAC filtering, evade NAC, blend in with legitimate devices).

**Tools:** Linux — `macchanger`, `ip link set dev <iface> address <new-MAC>`; Windows — Device Manager → Advanced → "Network Address".

**Typical lab steps:** Sniff traffic to identify an allowed MAC → bring interface down → change MAC to the allowed one → bring interface up and attempt connection.

**Defenses:** Don't rely on MAC filtering as a security control; use WPA2/WPA3-Enterprise with 802.1X, certificate/user-based auth, NAC solutions.

---

## 5. WEP, WPA Authentication Mechanisms and Cracking Techniques

### 5.1 WEP — Wired Equivalent Privacy

Original Wi-Fi security standard (late 1990s) using the **RC4 stream cipher**, supporting 64-bit and 128-bit keys, with a static pre-shared key configured on all devices and the AP.

**How WEP Encryption Works (Simplified):**

- A 24-bit **Initialization Vector (IV)** is generated per packet and concatenated with the key to form the RC4 key
- RC4 generates a keystream, XORed with plaintext (+ integrity check value) to produce ciphertext
- The IV is sent in clear so the receiver can decrypt

**Why WEP Is Weak:**

1. **Small IV space (24 bits):** ~16.7 million possible IVs; repeats frequently on busy networks → reused IV + same key → same keystream → statistical attacks
2. **Predictable/poorly implemented IVs:** Some devices increment sequentially or reuse patterns
3. **No robust integrity protection:** CRC-32 is linear, not cryptographically secure → allows bit-flipping/packet modification
4. **Static keys:** Same key used for long periods; once cracked, entire network compromised until manually changed

**WEP Cracking Techniques:**

- **Passive:** Sniff traffic in monitor mode, collect tens/hundreds of thousands of packets, use FMS attack (Fluhrer, Mantin, Shamir) or PTW attack (needs fewer packets)
- **Active:** ARP request replay — capture an ARP request, replay it to the AP many times to generate new IVs rapidly (tool: `aireplay-ng`)

**Lab flow:** Monitor mode → `airodump-ng` to capture → `aireplay-ng` for ARP replay/fake auth to generate traffic → capture 10k–100k+ data frames → `aircrack-ng` to recover the key.

**Effectiveness:** Often cracked in minutes on an active network. **Status:** Completely broken; must not be used.

### 5.2 WPA — Wi-Fi Protected Access

Interim replacement for WEP, improved as WPA2, and later WPA3.

**Modes:**

- **WPA-Personal (WPA-PSK):** Pre-shared passphrase on AP and clients; suitable for home/SOHO; initially TKIP, WPA2 mandates AES-CCMP
- **WPA-Enterprise (WPA-802.1X):** RADIUS server for authentication; unique credentials/certificates per user; more secure

**Key Management (WPA-PSK):**

- Passphrase (8–63 chars) + SSID (as salt) → **PBKDF2** (HMAC-SHA1, 4096 iterations) derives a 256-bit **Pairwise Master Key (PMK)**
- **4-way handshake** generates session keys: **PTK** (unicast traffic), **GTK** (multicast/broadcast)

**Encryption:** WPA (original) uses TKIP with RC4; WPA2 uses AES-CCMP (much stronger).

### 5.3 WPA Cracking Techniques

**WPA-PSK Cracking via 4-Way Handshake:**

- Attacker captures the 4-way handshake (EAPOL frames) when a client connects
- Tries candidate passphrases from a wordlist, deriving PMK/PTK for each guess and checking against the handshake
- **Tools:** Capture — Aircrack-ng suite (`airodump-ng`, `aireplay-ng` for deauth); Crack — Aircrack-ng, Hashcat, John the Ripper

**Lab flow (WPA2-PSK):** Monitor mode → `airodump-ng` to find target AP/clients and capture → optional deauth to force reconnect → save handshake (`.cap`) → run dictionary/brute-force attack on the file.

**Effectiveness:** Depends entirely on passphrase strength — weak/common passphrases crack quickly; long random passphrases are practically infeasible to brute-force.

**WPA-TKIP Specific Weaknesses:** Susceptible to cryptographic attacks (e.g., Beck-Tews); allows limited packet injection/decryption under specific conditions, though doesn't directly reveal the PSK. **Mitigation:** Use WPA2/WPA3 with AES-CCMP, disable TKIP.

### 5.4 WPS — Wi-Fi Protected Setup and Its Weaknesses

Simplifies Wi-Fi setup via Push Button Connect (PBC) or an 8-digit PIN.

**How WPS PIN Works:** 8-digit number; last digit is a checksum (7 digits of entropy); protocol validates the PIN in two halves (first 4 digits, then last 3 + checksum) → ≈11,000 total attempts needed, not 10⁸.

**Result:** WPS PIN can be brute-forced in hours even with simple rate limits; once obtained, attacker often gets the WPA/WPA2 PSK too.

**Tools:** Reaver, Bully, `wash` (Reaver suite).

**Mitigation:** Disable WPS whenever possible; use WPA2/WPA3-Personal with a strong passphrase, or WPA2/WPA3-Enterprise.

### 5.5 Comparison: WEP vs WPA vs WPA2 vs WPA3 vs WPS

Note that WPS is not an encryption/security _protocol_ like the other four — it's a **setup/onboarding mechanism** that can be layered on top of WPA/WPA2/WPA3 to simplify connecting new devices. It is included here because enabling it undermines whatever encryption standard sits underneath it.

| Feature                      | WEP                                                                                            | WPA (TKIP)                                                         | WPA2 (AES-CCMP)                                                                           | WPA3                                                                                                    | WPS                                                                                                                                                                        |
| ---------------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **What it is**               | Encryption standard                                                                            | Encryption standard                                                | Encryption standard                                                                       | Encryption standard                                                                                     | Setup/onboarding mechanism (PIN or Push-Button) layered on WPA/WPA2/WPA3                                                                                                   |
| **Year introduced**          | 1997                                                                                           | 2003                                                               | 2004                                                                                      | 2018                                                                                                    | 2006                                                                                                                                                                       |
| **Encryption**               | RC4, static key + 24-bit IV                                                                    | TKIP (RC4-based, per-packet key mixing)                            | AES-CCMP                                                                                  | AES-CCMP (stronger), SAE                                                                                | N/A — reuses whatever the AP's WPA/WPA2/WPA3 encryption is                                                                                                                 |
| **Key mgmt**                 | Static pre-shared key                                                                          | PSK or 802.1X                                                      | PSK or 802.1X                                                                             | SAE (Personal), 192-bit (Enterprise)                                                                    | 8-digit PIN (7 usable digits + checksum) or physical button press, used to exchange the real PSK                                                                           |
| **Authentication handshake** | Open/Shared-key auth (weak)                                                                    | 4-way handshake                                                    | 4-way handshake                                                                           | SAE ("Dragonfly") handshake — resists offline dictionary attacks                                        | 2-stage PIN exchange (M1–M8 EAP-WSC messages), validated in two halves                                                                                                     |
| **Known flaws**              | Severely broken — small IV space causes IV reuse → key recovery via FMS/PTW attacks in minutes | TKIP weaknesses (Beck-Tews attack); still RC4-based under the hood | PSK vulnerable to offline dictionary/brute-force attacks against captured 4-way handshake | Resists offline PSK cracking (SAE); still maturing, some early implementation flaws (e.g., Dragonblood) | PIN's 2-halves validation reduces search space to ~11,000 attempts → brute-forceable in hours (Reaver/Bully); recovering the PIN often reveals the underlying WPA/WPA2 PSK |
| **Typical attack tool**      | `aircrack-ng` (FMS/PTW), `aireplay-ng` (ARP replay)                                            | `aircrack-ng`, packet injection tools                              | `aircrack-ng`, Hashcat/John on captured handshake                                         | Limited practical tools; SAE downgrade/side-channel research attacks                                    | `Reaver`, `Bully`, `wash` (to discover WPS-enabled APs)                                                                                                                    |
| **Mitigation**               | Do not use — migrate to WPA2/WPA3                                                              | Disable TKIP, use AES-CCMP only                                    | Strong, long random passphrase; consider WPA3                                             | Use where supported; keep firmware updated                                                              | Disable WPS entirely (PIN and push-button)                                                                                                                                 |
| **Status**                   | Obsolete, must not be used                                                                     | Deprecated, avoid TKIP                                             | Current minimum baseline                                                                  | Recommended for new deployments                                                                         | Should be disabled regardless of which encryption standard is in use                                                                                                       |

---

## 6. Wireless Sniffers, Locating SSIDs, and MAC Spoofing

### 6.1 Wireless Sniffers

Tools that capture and analyze 802.11 frames over the air, operating with the Wi-Fi adapter in monitor mode.

**Common tools:** Wireshark (with monitor-mode interface), tcpdump, Aircrack-ng suite (`airodump-ng`), Kismet, BetterCAP.

**What they can capture:** Management frames (beacons, probe requests/responses, auth, assoc); control frames (ACKs, RTS/CTS); data frames (encrypted or unencrypted); metadata (SSIDs, BSSIDs, client MACs, channels, signal strength).

**Uses:** Network troubleshooting; security auditing (rogue APs, weak configs); offensive security labs (handshake capture, WEP/WPA analysis).

### 6.2 SSID — Service Set Identifier

Human-readable network name broadcast by the AP in beacon frames; clients use it to identify and connect.

**Hidden SSIDs (SSID Cloaking):** Admin disables SSID broadcast (beacon shows length 0) to "hide" the network.

**Why it's weak:** SSID still appears in probe requests from clients, probe responses from the AP, and association/authentication frames — sniffers easily capture and reveal it. `airodump-ng` shows hidden SSIDs once clients connect/probe; Wireshark can filter for probe frames; Kismet auto-discovers hidden networks.

**Conclusion:** SSID hiding is obscurity, not security.

### 6.3 MAC Addresses and MAC Filtering

A MAC address is the 48-bit hardware address of a network interface, used at Layer 2 for frame delivery and often in MAC filtering ACLs on APs/routers.

**MAC Filtering:** AP/router allows or denies devices based on MAC address ("allow list" or "deny list").

**Why it's weak:** MAC addresses are transmitted in clear over Wi-Fi — an attacker can sniff traffic to see allowed MACs, then change their own NIC's MAC to match and bypass the filter.

**Conclusion:** MAC filtering provides no real security, only a false sense of control — must be combined with strong encryption/auth (WPA2/3-Enterprise, 802.1X).

### 6.4 Putting It Together: Wireless Attack Perspective

```
1. Recon           → airodump-ng/Kismet to list SSIDs, BSSIDs, channels, clients;
                      identify hidden SSIDs via probe traffic
2. Target selection → WEP → plan WEP cracking
                      WPA/WPA2-PSK + WPS enabled → plan WPS PIN attack
                      WPA/WPA2-PSK, no WPS → plan handshake capture + dictionary
3. Bypass controls  → spoof allowed MAC if filtering is used; sniff for hidden SSID
4. Post-association → MITM (ARP/DNS spoofing) on the LAN; sniff/capture credentials
                      and session tokens if not properly encrypted
```

---

## 7. Methods Used to Secure Wireless Networks

These map directly to countering the attacks above and form a layered defense strategy.

| #   | Method                                          | Details                                                                                                                                                                                                |
| --- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | **WPA2/WPA3 with Strong AES**                   | Minimum WPA2-Personal (AES-CCMP) or WPA2-Enterprise; preferred WPA3-Personal (SAE) or WPA3-Enterprise. WPA3 adds SAE (resists offline PSK cracking) and forward secrecy. Disable TKIP; use AES only    |
| 2   | **Disable WPS**                                 | WPS PIN is vulnerable to fast brute-force; disable both PIN and PBC in router settings                                                                                                                 |
| 3   | **Strong, Complex Passphrases**                 | 20+ random characters, not in dictionaries; avoid common words/patterns/company names; use a password manager; rotate on device loss or staff departure                                                |
| 4   | **Change Default SSIDs & Admin Passwords**      | Default SSID reveals router model (helps attackers find known vulnerabilities); default admin logins are widely known — use strong unique credentials and restrict admin access                        |
| 5   | **MAC Filtering (Cautiously)**                  | Not real security — only a supplementary control in small environments; never the primary protection                                                                                                   |
| 6   | **Network Segmentation & Firewalls**            | Separate guest Wi-Fi, IoT devices, and critical systems via VLANs; enforce least-privilege firewall rules between segments                                                                             |
| 7   | **VPN for Sensitive Communications**            | Encrypts traffic end-to-end even on "secure" Wi-Fi; corporate VPN for remote workers; app-level VPN/TLS for sensitive apps                                                                             |
| 8   | **Regular Firmware Updates**                    | Fixes CVEs, stability issues, and sometimes adds features (WPA3, better WPS handling); enable auto-update where trusted; replace unsupported devices                                                   |
| 9   | **Monitor for Rogue APs & Suspicious Activity** | Wireless IDS/IPS; periodic site surveys (Kismet, Aircrack-ng); correlate logs from controllers, RADIUS, firewalls, SIEM; watch for unknown SSIDs/BSSIDs, high deauth rates, unusual auth failures      |
| 10  | **802.1X with RADIUS (Enterprise)**             | Per-user/device authentication via supplicant–authenticator–RADIUS server model; EAP-TLS (certificate-based, strongest) or EAP-TTLS/PEAP; unique credentials, easy revocation, stronger accountability |

---

---

# Session 18 (2T + 3L): Backdoors, DDoS, Biometric Spoofing, Linux Security & IDS/Honeypots/Firewalls

**Topics:** Backdoor Devices | Distributed DoS Attacks | Biometric Spoofing | Linux Hacking | Linux Backdoors | IDSs, Honeypots and Firewalls

---

## 1. Backdoor Devices

### 1.1 What Is a Backdoor?

A **backdoor** is a covert method of bypassing normal authentication or security controls to gain unauthorized access to a system, device, or network.

**Categories:**

- **Software-based:** hidden accounts, modified binaries, web shells, rootkits
- **Hardware-based:** malicious implants, firmware modifications, compromised components
- **Intentional:** added by developers/vendors for "maintenance" or remote support
- **Malicious:** inserted by attackers after compromise or during supply-chain attacks

Once present, a backdoor allows persistent remote access, command execution, data exfiltration, and lateral movement.

### 1.2 Types of Backdoors

**Software Backdoors**

- Hidden admin accounts or hard-coded credentials
- Modified system binaries/services accepting special commands
- **Web shells:** malicious scripts on web servers allowing remote command execution
- **Rootkits:** hide processes, files, network connections; maintain persistence
- Trojanized applications with embedded backdoor functionality
- Installed via malware, vulnerable web apps (RCE → web shell), or by insiders/prior attackers
- Designed to be stealthy, survive reboots, and blend with normal traffic (ports 80/443)

**Hardware Backdoors**

- Malicious code in firmware (BIOS/UEFI, BMC/iLO, drive firmware, NIC firmware)
- Modified/counterfeit hardware components (routers, switches, NICs)
- Custom implants added to intercepted devices; dedicated spy hardware in cables/peripherals
- Hard to detect with conventional tools; can bypass OS reinstall and disk encryption; enable large-scale supply-chain attacks
- Real-world context: counterfeit devices found in critical infrastructure, implant firmware on intercepted network gear

**Developer / Vendor Backdoors**

- Intentionally built for debugging, remote support, or recovery
- Risks: if discovered, attackers can abuse them; poorly protected "maintenance" accounts become easy targets; may violate compliance requirements

### 1.3 How Backdoors Are Used by Attackers

```
1. Initial access        → phishing, exploiting vulnerabilities, weak RDP/SSH, compromised creds
2. Privilege escalation  → gain admin/root access
3. Backdoor installation → deploy web shell, trojan, rootkit, or firmware backdoor
4. Persistence           → ensure backdoor survives reboots and updates
5. Command & control     → establish covert channel to attacker infrastructure
6. Objectives            → espionage, data theft, ransomware, lateral movement, long-term access
```

### 1.4 Detecting Backdoors

**Software indicators:** unknown services/processes/startup entries; unexpected listening ports or outbound connections; unusual scheduled tasks/cron jobs; modified system binaries or web directories; logs showing logins from unusual IPs/times

**Hardware/firmware indicators:** devices behaving oddly after OS reinstall; unexpected features in management interfaces (iLO, BMC); firmware version mismatches; supply-chain anomalies (counterfeit devices)

**Tools & techniques:** EDR/anti-malware; file integrity monitoring (FIM); network traffic analysis for C2 patterns; firmware scanning/validation; vendor integrity checks and hardware audits

### 1.5 Preventing and Mitigating Backdoor Risks

| Area                        | Best Practices                                                                                                                                         |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **General**                 | Change default credentials; disable/remove unnecessary accounts and services; apply patches and firmware updates; use EDR/antivirus and host firewalls |
| **Development & Ops**       | Avoid hard-coded credentials or secret admin interfaces; secure coding practices; audit third-party libraries/plugins; scan web apps for web shells    |
| **Hardware & Supply Chain** | Procure from trusted vendors; perform hardware audits and firmware checks; validate firmware signatures; consider hardware attestation and secure boot |
| **Monitoring**              | Continuously monitor network traffic, logs (suspicious logins, privilege use), and file systems for unexpected changes                                 |

---

## 2. Distributed Denial of Service (DDoS) Attacks

### 2.1 What Is a DDoS Attack?

A **DDoS** attack overwhelms a target system, service, or network with traffic from many distributed sources, making it unavailable to legitimate users.

**Key characteristics:** multiple sources (often a botnet of compromised devices); high volume of traffic or resource-exhausting requests; goal is to disrupt availability, cause damage, or distract from other attacks.

### 2.2 Botnets — The Engine Behind DDoS

A **botnet** is a network of compromised devices (PCs, servers, IoT) under attacker control, managed via C2 servers (centralized or P2P).

**How devices join:** malware infections; compromised IoT devices (default passwords, unpatched firmware); brute-forced or misconfigured cloud instances.

**Use in DDoS:** attacker sends commands to all bots; bots simultaneously send traffic to the target; aggregate traffic can reach hundreds of Gbps or more.

### 2.3 Types of DDoS Attacks

| Category                        | Goal                                                                               | Examples                                                                                                      |
| ------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Volume-Based (Volumetric)**   | Saturate bandwidth/connection capacity (measured in bps/pps)                       | UDP floods; ICMP floods; DNS/NTP/SSDP amplification (spoofed small query → large response directed at victim) |
| **Protocol Attacks**            | Exhaust server/network device resources (CPU, memory, connection tables)           | SYN floods (never completing handshake); ACK/RST floods; fragmentation attacks (Teardrop); Ping of Death      |
| **Application Layer (Layer 7)** | Exhaust application resources with seemingly legitimate requests (measured in RPS) | HTTP GET/POST floods; Slowloris (many slow connections held open); API abuse (expensive endpoints)            |

Application-layer attacks use lower traffic volume than volumetric attacks but are harder to detect since traffic resembles normal user requests.

### 2.4 Impacts of DDoS

- Service downtime and loss of availability
- Financial losses (e-commerce, SaaS, critical services)
- Reputation damage and loss of customer trust
- Operational disruption (internal tools, APIs)
- Can be used as a distraction while other attacks (data theft, intrusions) occur

### 2.5 Defending Against DDoS

| Layer                                    | Measures                                                                                                                                                                                                                         |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Traffic Filtering & Rate Limiting**    | ACLs/firewall rules to drop malicious traffic; rate limiting per IP/session; blackholing/null routing during extreme attacks; geo-blocking for regional services                                                                 |
| **Firewalls, IDS/IPS, Load Balancers**   | Stateful firewalls (SYN cookies/proxying); IDS/IPS to detect and block attack patterns; load balancers to distribute traffic and drop malicious sessions                                                                         |
| **Scrubbing Centers & Cloud Mitigation** | Scrubbing centers filter malicious traffic before forwarding clean traffic; cloud DDoS protection (Cloudflare, Akamai, AWS Shield) offers massive bandwidth and advanced filtering                                               |
| **Architecture & Operations**            | Redundancy/scaling across regions; CDNs and caching to reduce origin load; OS/stack hardening (SYN cookies, timeouts); real-time monitoring with traffic baselines; incident response plan with ISP/mitigation provider contacts |
| **By Attack Type**                       | Volumetric — upstream filtering, scrubbing, CDNs, Anycast; Protocol — SYN cookies, connection rate limits, firewall tuning; Application layer — WAF rules, CAPTCHAs, JS challenges, strict rate limits, behavioral bot detection |

---

## 3. Biometric Spoofing

### 3.1 What Is Biometric Spoofing?

**Biometric spoofing** (a "presentation attack") is when an attacker tricks a biometric authentication system by presenting fake or synthetic biometric samples instead of the genuine user's live trait. Common systems: fingerprint scanners, face recognition, iris/retina scanners, voice recognition (also vein patterns, gait, keystroke dynamics).

### 3.2 Types of Biometric Spoofing

| Modality        | How It Works                                                                                                                                      | Advanced Techniques                                                                                                            |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **Fingerprint** | Attacker lifts a print from surfaces or leaked images/templates and creates a fake finger (silicone, gelatin, latex, conductive ink, 3D printing) | High-resolution imaging + AI to reproduce ridge patterns, minutiae, sweat-pore details; latent print lifting + mold creation   |
| **Face**        | Presents printed photos, screen images/videos, masks, or 3D models                                                                                | Deepfakes (AI-generated synthetic faces/videos); 3D facial models from a few photos; IR/depth cameras with tailored masks      |
| **Iris**        | High-resolution printed iris images, printed contact lenses, synthetic/digitally modified images, or videos of the target's eye                   | 3D eye models to mimic depth/texture; high-quality printers/imaging for fine iris detail                                       |
| **Voice**       | Mimics the user's voice using pre-recorded samples, voice conversion tools, or AI speech synthesis                                                | Deep learning models trained on victim's voice data; real-time voice conversion to bypass voice-based auth (call centers, IVR) |

### 3.3 Why Biometric Spoofing Is Dangerous

- Biometrics are treated as "something you are" — assumed hard to steal
- Unlike passwords, biometric traits cannot be easily changed if compromised, and may leak from databases or sensors
- Successful spoofing can bypass device unlock, physical access control, banking apps, government e-services, enabling identity fraud and unauthorized transactions

### 3.4 Countermeasures Against Biometric Spoofing

| Countermeasure                             | Details                                                                                                                                                                                                                                                             |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Liveness Detection**                     | Fingerprint — pulse, skin conductivity, temperature, micro-movements; Face — eye blinking, micro-expressions, IR/depth 3D structure, challenge-response; Iris — pupil light response, texture analysis; Voice — challenge-response phrases, natural speech dynamics |
| **Multi-Factor Authentication**            | Combine biometrics with something you know (PIN/password) or something you have (token/phone/smart card) so a spoofed biometric alone isn't enough                                                                                                                  |
| **Improved Sensor Technology**             | Multispectral fingerprint sensors; 3D/IR face cameras; high-quality iris cameras with liveness checks; biometric fusion (multiple modalities)                                                                                                                       |
| **Behavioral & Continuous Authentication** | Analyze typing rhythm, mouse movement, swipe patterns, navigation habits; continuously verify identity during a session, not just at login                                                                                                                          |
| **System & Policy Measures**               | Store biometric templates encrypted/salted/non-reversible; monitor suspicious auth patterns; update biometric SDKs/firmware; educate users on risks of biometric-only auth for high-value actions                                                                   |

---

## 4. Linux Hacking

### 4.1 Why Linux Is a Target

Widely used for web/database servers, cloud infrastructure, IoT/embedded devices, and developer workstations — often exposed to the internet (SSH, web services, APIs), with common misconfigurations, unpatched systems, and weak credentials.

### 4.2 Common Linux Hacking Vectors

**Exploiting Unpatched Vulnerabilities**

- Unpatched kernel, services (Apache, Nginx, SSH, Samba), or applications with known public CVEs
- **Impact:** RCE, privilege escalation, full system compromise
- **Tools:** Nmap (version detection), Metasploit, public exploit scripts, OpenVAS/Nessus

**Weak SSH Configurations**

- Password-based auth with weak passwords; root login permitted; outdated SSH versions; no key-based auth/MFA
- **Attacks:** Brute-force with Hydra/Medusa; credential stuffing; exploiting weak keys/misconfigs
- **Impact:** Direct shell access, often as root if misconfigured

**Privilege Escalation**

- Misconfigured **sudo** permissions (GTFOBins-style abuses via `vim`, `find`, `python`, etc.)
- Kernel exploits (local privilege escalation bugs, e.g., dirty cow, overlayfs bugs)
- Writable sensitive files (`/etc/passwd`, `/etc/shadow` if misconfigured); cron jobs, init scripts, systemd units
- Misconfigured capabilities or SUID binaries
- **Tools:** `linpeas`, `linux-exploit-suggester`; manual enumeration via `sudo -l`, `id`, `uname -a`, cron, `systemctl`

**Misconfigured Permissions and Services**

- World-writable directories under web root; sensitive files readable by all users
- Unnecessary services (FTP, Telnet, old RPC); poorly configured NFS/Samba shares; debug/test apps left enabled
- **Impact:** Data leakage, configuration tampering, additional attack surface for RCE/priv-esc

### 4.3 Tools Commonly Used in Linux Hacking

- **Metasploit:** remote/local exploits, payloads
- **John the Ripper, Hashcat:** offline password cracking (e.g., `/etc/shadow` hashes)
- **Hydra, Medusa:** online brute-force (SSH, FTP, HTTP auth)
- Custom Python/Bash scripts for enumeration, exploitation, persistence

### 4.4 Defending Linux Systems (Hardening Checklist)

| Area                   | Measures                                                                                                                                         |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Patch Management**   | Regular `apt update && apt upgrade` (or equivalent); subscribe to security advisories                                                            |
| **SSH Hardening**      | Disable root login (`PermitRootLogin no`); key-based auth, disable password auth where possible; non-standard port + firewall rules; MFA for SSH |
| **Firewalls**          | `iptables`/`nftables`, `ufw`, or firewalld; allow only necessary ports/sources                                                                   |
| **Security Modules**   | SELinux or AppArmor in enforcing mode with proper profiles                                                                                       |
| **Least Privilege**    | Minimal sudo rights; separate users for services                                                                                                 |
| **Auditing & Logging** | `auditd` for system call auditing; centralized logging (rsyslog, SIEM); monitor `/var/log/auth.log` / `/var/log/secure`                          |

---

## 5. Linux Backdoors

### 5.1 What Are Linux Backdoors?

Hidden programs, scripts, or configurations that allow an attacker to regain access to a compromised system, bypassing normal authentication and security controls. Often installed after initial exploitation (RCE, weak SSH, web shell), as part of rootkits, or via compromised packages/scripts or insiders.

### 5.2 Common Types of Linux Backdoors

| Type                                      | Description                                                                                                                                                                           |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Modified Binaries and Trojans**         | Legitimate binaries replaced/wrapped with malicious code (e.g., trojanned `sshd` accepting a special key/password; modified `login`, `su`, `passwd`); often part of advanced rootkits |
| **Malicious Kernel Modules**              | `.ko` files loaded to hide processes/files/connections and provide hidden backdoor interfaces; operate at kernel level → hard to detect from user space; can survive reboots          |
| **Hidden User Accounts**                  | Extra accounts with UID 0 (root-equivalent); accounts with no password or authorized SSH keys; unusual/hidden names; direct modification of `/etc/passwd` and `/etc/shadow`           |
| **Malicious Cron Jobs & Startup Scripts** | Scheduled tasks running reverse shells/C2 beacons (`/etc/cron.*`, user crontabs); modified `/etc/rc.local`, init scripts, systemd units to run on boot                                |
| **Web Shells & Service Backdoors**        | PHP/Python/Perl scripts in web directories allowing command execution; custom daemons on unusual ports; bind/reverse shell mechanisms                                                 |

### 5.3 Detecting Linux Backdoors

| Method                      | Tools / Indicators                                                                                                                                           |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **File & Binary Integrity** | Tripwire, OSSEC, or similar FIM tools; compare critical binaries against known-good hashes; watch `/bin`, `/usr/bin`, `/sbin`, `/etc` for unexpected changes |
| **Rootkit Scanners**        | Chkrootkit, Rootkit Hunter (rkhunter) — check known rootkit signatures/suspicious files (not perfect, but useful in layered detection)                       |
| **Log Monitoring**          | Auth logs (`/var/log/auth.log`, `/var/log/secure`), cron logs, system logs; watch for logins from unknown IPs, new users, unusual root commands              |
| **Runtime Inspection**      | `ps auxf`, `top`/`htop`, `netstat -tulpn`/`ss -tulpn` for unknown daemons/connections; `lsmod` to inspect loaded kernel modules                              |

### 5.4 Preventing Linux Backdoors

- **Least privilege:** minimal sudo rights, restricted users
- **Patch and update:** kernel, packages, firmware
- **Secure configurations:** harden SSH, web servers, databases; disable unnecessary services
- **Monitoring:** continuous log analysis and alerting; FIM for critical paths
- **Secure deployment:** trusted repositories and signed packages; avoid running unverified scripts from the internet

---

## 6. Intrusion Detection Systems (IDS), Honeypots, and Firewalls

These three controls work together in a **defense-in-depth** strategy: firewalls enforce access control at network boundaries, IDS detects suspicious activity inside or at the edge, and honeypots deceive and study attackers while protecting real assets.

### 6.1 Intrusion Detection Systems (IDS)

**What Is an IDS?**
Monitors network or host activity to detect malicious actions (exploits, scans, malware C2), policy violations, and signs of compromise. Primarily **detective**, not preventive — generates alerts for analysts or automated systems; can be passive or integrated with IPS/firewalls for active response.

**Types of IDS by Placement:**

| Type                         | Deployment                                                          | Monitors                                                                                                                                                 | Examples                     |
| ---------------------------- | ------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| **Network-Based IDS (NIDS)** | Strategic network points (just inside firewall, DMZ, core segments) | Network traffic on the wire vs. signatures/behavioral baselines; detects scans, DoS, exploit attempts, suspicious protocols                              | Snort, Suricata              |
| **Host-Based IDS (HIDS)**    | Agent/service on individual hosts                                   | System logs, file integrity, process activity, privileged commands, config changes; effective even against encrypted traffic (inspects host-side events) | OSSEC, Wazuh, Tripwire (FIM) |

**Detection Techniques:**

| Technique                      | Description                                                  | Strengths                                                       | Limitations                                                   |
| ------------------------------ | ------------------------------------------------------------ | --------------------------------------------------------------- | ------------------------------------------------------------- |
| **Signature-Based**            | Matches traffic/events against known attack pattern database | High accuracy for known attacks; low false positives when tuned | Cannot detect new/zero-day attacks; requires frequent updates |
| **Anomaly-Based (Behavioral)** | Builds a normal-behavior baseline, flags deviations          | Detects new/modified attacks; useful for insider threats/APTs   | Higher false positive rate; depends on training data quality  |

Many modern IDS use a **hybrid** approach: signature + anomaly + heuristics + threat intel.

**IDS vs IPS:** IDS detects and alerts (typically passive); IPS (Intrusion Prevention System) can block or modify traffic in real time. Often implemented in the same device (configurable IDS/IPS mode).

### 6.2 Honeypots

**What Is a Honeypot?**
A decoy system or service designed to attract attackers by appearing vulnerable/valuable, gather intelligence on TTPs (Tactics, Techniques, and Procedures), and distract attackers from real production assets. Any interaction with a honeypot is, by design, suspicious.

**Types by Interaction Level:**

| Type                 | Characteristics                                                                                                                            | Pros                                          | Cons                                                          | Examples                                       |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- | ------------------------------------------------------------- | ---------------------------------------------- |
| **Low-Interaction**  | Emulates a limited set of services (SSH, Telnet, HTTP); no full OS/real apps; captures scans, basic exploit attempts, brute-force patterns | Safer, easier to deploy, lower resource usage | Limited realism; less insight into post-exploitation behavior | Honeyd, Kippo (SSH), Dionaea (malware capture) |
| **High-Interaction** | Runs full OS and real services; allows deep interaction; captures full attack chains, malware samples, lateral movement                    | Very realistic; rich intelligence             | Higher risk if not isolated; more complex to manage           | Custom VMs, Honeynet projects                  |

**Uses:** Threat intelligence (new exploits, malware, C2 infra); early warning (detect scanning/intrusion attempts); research (attacker behavior/tools/trends); distraction (waste attacker time/resources).

**Important:** Must be strictly isolated from production (network segmentation, monitoring); legal/ethical considerations apply (logging, data handling, jurisdiction).

### 6.3 Firewalls

**What Is a Firewall?**
A network security device/software that controls incoming and outgoing traffic based on defined rules, enforcing an access control policy between networks (Internet ↔ DMZ ↔ Internal). Primarily **preventive**, but does not reliably detect attacks once inside the network.

**Types of Firewalls:**

| Type                                  | Layer                | Basis for Decisions                                                                                       | Strengths                                                                 | Limitations                                                                            |
| ------------------------------------- | -------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| **Packet-Filtering**                  | L3/L4                | Source/dest IP, port, protocol, flags                                                                     | Simple, fast, low overhead                                                | Stateless (basic form); bypassed via fragmentation/rule evasion; no content inspection |
| **Stateful Inspection**               | L3/L4 (with context) | Connection state (e.g., TCP handshake status); allows return traffic only for established sessions        | More secure than packet filters; blocks spoofed/incomplete connections    | Still limited application-layer visibility; complex rule sets can be misconfigured     |
| **Proxy (Application-Level Gateway)** | L7                   | Acts as intermediary, terminates and re-initiates connections; deep protocol inspection (HTTP, FTP, SMTP) | Content/URL filtering, malware scanning; hides internal network structure | Higher latency/resource use; complex to configure; may break some apps                 |

**Next-Generation Firewalls (NGFWs)** combine stateful inspection, application awareness, integrated IPS, URL filtering, malware analysis, and sometimes sandboxing.

### 6.4 How IDS, Honeypots, and Firewalls Work Together

**Typical layered design:**

- **Perimeter:** NGFW/stateful firewall with IPS blocks obvious unauthorized access and known attacks
- **Internal network:** NIDS sensors at key segments (core, DMZ, data center); HIDS agents on critical servers
- **Honeypots:** Placed in DMZ or isolated segments to attract and log attacker activity, feeding intelligence into IDS/IPS rules and SOC processes

**Key differences at a glance:**

| Control      | Primary Role      | Where It Operates            | Strengths                                                               | Limitations                              |
| ------------ | ----------------- | ---------------------------- | ----------------------------------------------------------------------- | ---------------------------------------- |
| **Firewall** | Access control    | Network perimeter/segments   | Blocks unauthorized traffic                                             | Limited detection of internal threats    |
| **IDS**      | Detection         | Network (NIDS) / Host (HIDS) | Detects attacks & anomalies                                             | Mostly passive; needs response process   |
| **Honeypot** | Deception & intel | Isolated/DMZ networks        | Gathers TTPs (Tactics, Techniques, and Procedures), distracts attackers | Risk if not isolated; no direct blocking |
