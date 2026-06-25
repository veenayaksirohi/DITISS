## Fork Bomb

A **fork bomb** is a type of **Denial-of-Service (DoS) attack** that overwhelms a computer system by continuously creating new processes. These processes rapidly multiply until the system runs out of resources such as CPU time, memory, and process table entries, causing the operating system to slow down, freeze, or crash.

Fork bombs are most commonly associated with **Unix/Linux systems**, though similar attacks can exist on other operating systems.

---

## How a Fork Bomb Works

A fork bomb works through **recursive process creation**:

1. A process starts running.
2. It creates copies of itself (child processes).
3. Each child process creates more copies.
4. The number of processes increases exponentially.

Within seconds, the system may become overloaded because all available resources are consumed.

This rapidly:

* Uses all CPU power
* Consumes available memory
* Exhausts process table entries

As a result, legitimate programs and users cannot access system resources.

---

## Classic Linux Fork Bomb

```bash
:(){ :|:& };:
```

### Explanation of the Command

* `:` → Defines a function named `:`
* `(){}` → Function definition syntax
* `:|:` → The function calls itself twice
* `|` → Pipes output between processes
* `&` → Runs processes in the background
* `;:` → Executes the function

| Part     | Meaning                     | Brief Explanation                                    |
| -------- | --------------------------- | ---------------------------------------------------- |
| `:`      | Function name               | Function is named `:`                                |
| `()`     | Function declaration        | Declares/defines a function                          |
| `{ }`    | Function body               | Contains commands executed by function               |
| `: \| :` | Function calls itself twice | Recursive self-replication creating more processes   |
| `\|`     | Pipe operator               | Creates separate processes and connects output/input |
| `&`      | Run in background           | Processes run simultaneously in background           |
| `;`      | End statement               | Separates/end commands                               |
| `:`      | Execute function            | Starts the fork bomb execution                       |

This creates an uncontrolled number of background processes, leading to exponential process creation.

---

## Effects of a Fork Bomb

A fork bomb can cause:

* CPU usage to reach 100%
* Memory (RAM) exhaustion
* System slowdown or complete freeze
* Denial of service to legitimate users
* Possible system crash or forced reboot

---

## Type of Attack

A fork bomb is classified as:

* A **resource exhaustion attack**
* A form of **Denial-of-Service (DoS) attack**

---

## Prevention Methods

System administrators can reduce the risk of fork bombs by:

* Limiting the number of processes a user can create (`ulimit` in Linux)
* Monitoring abnormal process activity
* Using containerization or cgroups
* Applying proper user privilege restrictions

---

## Conclusion

A fork bomb is a malicious or accidental program that continuously replicates processes until system resources are exhausted. Because it can quickly make a computer unusable, it is considered a dangerous form of DoS attack and is an important topic in operating system and cybersecurity studies.


| Attack                         | Year | Type                | Target                                                                             | Impact                           |
| ------------------------------ | ---- | ------------------- | ---------------------------------------------------------------------------------- | -------------------------------- |
| Morris Worm                    | 1988 | Worm                | Early Internet                                                                     | First major internet worm        |
| ILOVEYOU Virus                 | 2000 | Email Worm          | Windows PCs                                                                        | Millions infected worldwide      |
| Code Red Worm                  | 2001 | Worm                | Microsoft IIS Servers                                                              | Massive internet disruption      |
| SQL Slammer                    | 2003 | Worm                | SQL Servers                                                                        | Global internet slowdown         |
| Mydoom                         | 2004 | Worm                | Email Systems                                                                      | Huge financial damage            |
| Operation Aurora               | 2009 | APT Attack          | [Google](https://www.google.com?utm_source=chatgpt.com) & others                   | Intellectual property theft      |
| Stuxnet                        | 2010 | Cyberweapon/Worm    | Iranian Nuclear Program                                                            | Physical infrastructure damage   |
| Sony Pictures Hack             | 2014 | Data Breach         | [Sony Pictures Entertainment](https://www.sonypictures.com?utm_source=chatgpt.com) | Data leaks and destruction       |
| WannaCry Ransomware Attack     | 2017 | Ransomware          | Global systems                                                                     | Hospitals and companies affected |
| NotPetya                       | 2017 | Wiper Malware       | Ukraine/global firms                                                               | Billions in damages              |
| Equifax Data Breach            | 2017 | Data Breach         | [Equifax](https://www.equifax.com?utm_source=chatgpt.com)                          | 147M records leaked              |
| SolarWinds Supply Chain Attack | 2020 | Supply Chain Attack | Governments & companies                                                            | Massive espionage campaign       |
| Colonial Pipeline Cyberattack  | 2021 | Ransomware          | [Colonial Pipeline](https://www.colpipe.com?utm_source=chatgpt.com)                | Fuel supply disruption           |




# Important Cyber Attacks Every Cybersecurity Enthusiast Should Know

| Attack Type                 | Description                                   |
| --------------------------- | --------------------------------------------- |
| Phishing                    | Fake emails/websites to steal credentials     |
| Spear Phishing              | Targeted phishing against specific person/org |
| Whaling                     | Phishing targeting executives                 |
| Vishing                     | Voice-call phishing                           |
| Smishing                    | SMS phishing                                  |
| Malware                     | Malicious software                            |
| Virus                       | Infects files and spreads                     |
| Worm                        | Self-spreading malware                        |
| Trojan                      | Malicious software disguised as legitimate    |
| Ransomware                  | Encrypts files and demands payment            |
| Spyware                     | Secretly monitors users                       |
| Adware                      | Displays unwanted advertisements              |
| Rootkit                     | Hides attacker presence                       |
| Keylogger                   | Records keyboard keystrokes                   |
| Botnet                      | Network of infected systems                   |
| DoS                         | Denial of Service attack                      |
| DDoS                        | Distributed Denial of Service                 |
| SYN Flood                   | TCP connection exhaustion attack              |
| Ping Flood                  | Massive ICMP traffic                          |
| Fork Bomb                   | Infinite process creation                     |
| Brute Force                 | Trying all password combinations              |
| Dictionary Attack           | Uses wordlists for password guessing          |
| Credential Stuffing         | Reusing leaked credentials                    |
| Password Spraying           | Trying common passwords on many accounts      |
| Rainbow Table Attack        | Precomputed hash cracking                     |
| SQL Injection (SQLi)        | Injecting SQL queries into apps               |
| Blind SQLi                  | SQLi without direct output                    |
| XSS                         | Injecting malicious JavaScript                |
| Stored XSS                  | Payload permanently stored on server          |
| Reflected XSS               | Payload reflected in response                 |
| DOM XSS                     | Client-side JavaScript manipulation           |
| CSRF                        | Forces victim to perform unwanted actions     |
| SSRF                        | Server requests internal resources            |
| Command Injection           | Execute OS commands through app               |
| Code Injection              | Inject malicious code                         |
| File Inclusion (LFI/RFI)    | Include local/remote files                    |
| Directory Traversal         | Access restricted directories                 |
| Buffer Overflow             | Overwrite memory                              |
| Stack Overflow              | Overflow stack memory                         |
| Heap Overflow               | Overflow heap memory                          |
| Integer Overflow            | Arithmetic overflow exploitation              |
| Race Condition              | Exploit timing issues                         |
| Privilege Escalation        | Gain higher privileges                        |
| Remote Code Execution (RCE) | Execute commands remotely                     |
| Zero-Day Attack             | Exploit unknown vulnerability                 |
| MITM                        | Man-in-the-Middle attack                      |
| Session Hijacking           | Steal active session                          |
| Cookie Hijacking            | Steal session cookies                         |
| ARP Spoofing                | Fake ARP messages                             |
| DNS Spoofing                | Fake DNS responses                            |
| IP Spoofing                 | Fake IP address                               |
| MAC Spoofing                | Fake MAC address                              |
| Email Spoofing              | Fake sender email                             |
| Evil Twin Attack            | Fake Wi-Fi hotspot                            |
| Wi-Fi Deauthentication      | Disconnect Wi-Fi users                        |
| Packet Sniffing             | Capture network traffic                       |
| Snooping                    | Secretly monitoring data                      |
| Replay Attack               | Reuse captured packets                        |
| LDAP Injection              | Inject LDAP queries                           |
| XML Injection               | Inject malicious XML                          |
| XXE                         | XML External Entity attack                    |
| Deserialization Attack      | Exploit unsafe object deserialization         |
| API Abuse                   | Exploit weak APIs                             |
| GraphQL Abuse               | Abuse GraphQL endpoints                       |
| Cloud Misconfiguration      | Exploit bad cloud setup                       |
| Container Escape            | Escape Docker/container isolation             |
| Kubernetes Attack           | Attack K8s clusters                           |
| Supply Chain Attack         | Compromise trusted software source            |
| Dependency Confusion        | Upload malicious packages                     |
| Typosquatting               | Fake package/domain names                     |
| Watering Hole Attack        | Compromise frequently visited site            |
| Drive-by Download           | Silent malware download                       |
| USB Attack                  | Malware through USB                           |
| BadUSB                      | Reprogram USB devices maliciously             |
| Social Engineering          | Manipulating humans                           |
| Shoulder Surfing            | Watching credentials physically               |
| Dumpster Diving             | Recovering sensitive trash data               |
| Insider Threat              | Attack from internal users                    |
| Data Exfiltration           | Stealing sensitive data                       |
| Cryptojacking               | Unauthorized crypto mining                    |
| Logic Bomb                  | Triggered malicious code                      |
| Backdoor                    | Hidden unauthorized access                    |
| Persistence Mechanism       | Maintain long-term access                     |
| Pivoting                    | Move across compromised networks              |
| Lateral Movement            | Spread inside network                         |
| Enumeration                 | Gather system/network information             |
| Reconnaissance              | Information gathering phase                   |
| Footprinting                | Collect target details                        |
| OSINT                       | Open-source intelligence gathering            |
| Port Scanning               | Discover open ports                           |
| Vulnerability Scanning      | Find vulnerabilities automatically            |
| Exploit Development         | Create exploit code                           |
| Payload Delivery            | Deliver malicious code                        |
| Shellcode Injection         | Inject executable payload                     |
| Reverse Shell               | Target connects back to attacker              |
| Bind Shell                  | Target opens listening shell                  |
| Sandbox Escape              | Escape restricted environment                 |
| VM Escape                   | Escape virtual machine                        |
| Firmware Attack             | Compromise firmware                           |
| BIOS/UEFI Attack            | Attack boot firmware                          |
| Hardware Keylogger          | Physical keystroke logger                     |
| Side-Channel Attack         | Leak info via physical properties             |
| Timing Attack               | Analyze execution time                        |
| Cold Boot Attack            | Recover RAM contents after reboot             |
| Rogue DHCP                  | Fake DHCP server                              |
| DHCP Starvation             | Exhaust DHCP pool                             |
| VLAN Hopping                | Access other VLANs                            |
| STP Attack                  | Manipulate spanning tree                      |
| BGP Hijacking               | Redirect internet traffic                     |
| DNS Tunneling               | Hide data inside DNS                          |
| ICMP Tunneling              | Hide traffic inside ICMP                      |
| Steganography               | Hide data inside files/images                 |
| Watermarking Attack         | Remove/alter watermarks                       |
| AI Poisoning                | Poison ML training data                       |
| Prompt Injection            | Manipulate AI prompts                         |
| Adversarial ML              | Fool ML models                                |
| Deepfake Attack             | AI-generated fake media                       |

---

# Core Categories

| Category           | Examples                     |
| ------------------ | ---------------------------- |
| Web Attacks        | SQLi, XSS, CSRF              |
| Network Attacks    | MITM, ARP Spoofing           |
| Malware            | Trojan, Worm, Ransomware     |
| Wireless Attacks   | Evil Twin, Deauth            |
| Password Attacks   | Brute Force, Dictionary      |
| Cloud Attacks      | IAM abuse, misconfigurations |
| Social Engineering | Phishing, Vishing            |
| Memory Exploits    | Buffer Overflow              |
| Advanced Attacks   | APT, Zero-Day                |

---

# Most Important Attacks to Master First

## Beginner

* Phishing
* Brute Force
* SQL Injection
* XSS
* Port Scanning
* Packet Sniffing

## Intermediate

* RCE
* Buffer Overflow
* ARP Spoofing
* Reverse Shells
* Privilege Escalation

## Advanced

* Exploit Development
* Kernel Exploitation
* Malware Analysis
* Active Directory Attacks
* Cloud Exploitation

---

# Most Commonly Used Tools

| Purpose           | Tool                 |
| ----------------- | -------------------- |
| Scanning          | Nmap                 |
| Exploitation      | Metasploit Framework |
| Packet Analysis   | Wireshark            |
| Web Testing       | Burp Suite           |
| Password Cracking | Hashcat              |
| IDS/IPS           | Snort                |
