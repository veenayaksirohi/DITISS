# Mobile Security Notes: Web-Based Attacks on Android Devices, Network-Based Attacks & Social Engineering Attacks

---

# 1. Web-Based Attacks on Android Devices

## Introduction

Web-based attacks occur when attackers exploit browsers, web applications, WebView components, or online services accessed through Android devices.

These attacks can lead to:

* Credential theft
* Session hijacking
* Malware installation
* Financial fraud
* Device compromise

---

## Android WebView

### What is WebView?

WebView allows Android apps to display web pages inside applications.

Examples:

* Banking apps
* Shopping apps
* Social media apps

### Risks

Improper WebView configuration may allow:

* JavaScript Injection
* Cross-Site Scripting (XSS)
* Arbitrary code execution
* Phishing pages

---

# Common Web-Based Attacks

---

## 1. Phishing Attacks

### Definition

Fake websites designed to steal:

* Username
* Password
* Credit card details
* OTPs

### Process

1. Victim receives malicious link
2. Fake login page opens
3. User enters credentials
4. Credentials sent to attacker

### Indicators

* Misspelled URLs
* Suspicious domains
* HTTP instead of HTTPS
* Urgent messages

### Prevention

✔ Verify URLs

✔ Use password managers

✔ Enable MFA

✔ Avoid unknown links

---

## 2. Cross-Site Scripting (XSS)

### Definition

Attacker injects malicious JavaScript into web pages.

### Types

### Stored XSS

Payload stored in server database.

### Reflected XSS

Payload reflected from request.

### DOM XSS

Manipulates webpage DOM.

### Impact

* Cookie theft
* Session hijacking
* Credential theft

### Prevention

* Input validation
* Output encoding
* Content Security Policy (CSP)

---

## 3. Cross-Site Request Forgery (CSRF)

### Definition

Forces authenticated users to perform unwanted actions.

### Example

User logged into banking site.

Attacker tricks victim into clicking malicious link.

Transaction executes automatically.

### Prevention

* CSRF Tokens
* SameSite Cookies
* Re-authentication

---

## 4. Drive-by Download Attacks

### Definition

Malware automatically downloads when user visits malicious website.

### Impact

* Spyware
* Banking Trojans
* Ransomware

### Prevention

* Update browser
* Avoid suspicious sites

---

## 5. Malvertising

### Definition

Malicious advertisements inject malware.

### Process

1. User clicks ad
2. Redirects to malicious site
3. Malware installation

### Prevention

* Ad blockers
* Trusted websites

---

## 6. Session Hijacking

### Definition

Stealing session identifiers.

### Methods

* Cookie theft
* XSS
* Network sniffing

### Impact

Attacker gains account access without password.

### Prevention

* Secure cookies
* HTTPS
* Session expiration

---

## 7. Watering Hole Attack

### Definition

Attacker compromises websites frequently visited by target users.

### Steps

1. Identify target website
2. Inject malware
3. Victim visits site
4. Device infected

---

## 8. Browser Exploitation

### Definition

Exploiting browser vulnerabilities.

### Impact

* Code execution
* Privilege escalation
* Data theft

### Prevention

* Update browser
* Patch Android OS

---

# Web-Based Attack Summary Table

| Attack            | Goal                   | Impact              |
| ----------------- | ---------------------- | ------------------- |
| Phishing          | Credential theft       | Account compromise  |
| XSS               | Script injection       | Session theft       |
| CSRF              | Unauthorized action    | Financial loss      |
| Malvertising      | Malware delivery       | Infection           |
| Drive-by Download | Silent malware install | Device compromise   |
| Session Hijacking | Session theft          | Unauthorized access |
| Watering Hole     | Targeted infection     | Malware execution   |

---

# 2. Network-Based Attacks

## Introduction

Network attacks target communication channels between:

* Device
* Wi-Fi
* Mobile Network
* Internet

---

# Types of Network Attacks

---

## 1. Man-in-the-Middle (MITM)

### Definition

Attacker secretly intercepts communication.

### Process

Victim ⇄ Attacker ⇄ Server

### Impact

* Password theft
* Session theft
* Data manipulation

### Prevention

✔ HTTPS

✔ VPN

✔ Certificate Pinning

---

## 2. Rogue Wi-Fi Access Point

### Definition

Fake Wi-Fi hotspot created by attacker.

### Example

Free_Airport_Wifi

### Impact

All traffic passes through attacker.

### Prevention

* Verify network names
* Use VPN

---

## 3. Evil Twin Attack

### Definition

Clone of legitimate Wi-Fi network.

### Process

1. Fake AP created
2. Victim connects
3. Traffic intercepted

### Prevention

* Verify SSID
* Avoid auto-connect

---

## 4. Packet Sniffing

### Definition

Capturing network packets.

### Tools

* Wireshark
* tcpdump

### Captured Data

* Usernames
* Passwords
* Cookies

### Prevention

* Encryption
* HTTPS

---

## 5. ARP Spoofing

### Definition

Attacker sends forged ARP messages.

### Result

Traffic redirected to attacker.

### Impact

MITM attack possible.

### Prevention

* Static ARP
* Dynamic ARP Inspection

---

## 6. DNS Spoofing

### Definition

Fake DNS responses redirect users.

### Example

bank.com → attacker site

### Impact

Phishing

Credential theft

### Prevention

* DNSSEC
* Secure DNS

---

## 7. SSL Stripping

### Definition

Downgrades HTTPS to HTTP.

### Impact

Traffic becomes readable.

### Prevention

* HTTPS Everywhere
* HSTS

---

## 8. Bluetooth Attacks

### Bluejacking

Sending unsolicited messages.

### Bluesnarfing

Stealing data over Bluetooth.

### Bluebugging

Taking control of device.

### Prevention

* Disable Bluetooth
* Non-discoverable mode

---

## 9. NFC Attacks

### Definition

Exploiting Near Field Communication.

### Impact

* Unauthorized payments
* Data theft

### Prevention

* Disable NFC when unused

---

## 10. DHCP Attacks

### DHCP Starvation

Consumes all IP addresses.

### Rogue DHCP

Attacker provides malicious network settings.

### Impact

Traffic redirection

MITM attacks

### Prevention

* DHCP Snooping
* Port Security

---

# Network Attack Summary Table

| Attack            | Target                |
| ----------------- | --------------------- |
| MITM              | Communication         |
| Rogue AP          | Wi-Fi                 |
| Evil Twin         | Wi-Fi                 |
| ARP Spoofing      | LAN                   |
| DNS Spoofing      | DNS                   |
| SSL Stripping     | HTTPS                 |
| Packet Sniffing   | Traffic               |
| DHCP Attacks      | Network Configuration |
| Bluetooth Attacks | Bluetooth             |
| NFC Attacks       | NFC                   |

---

# 3. Social Engineering Attacks

## Definition

Manipulating humans into revealing confidential information.

### Fact

Over 90% of successful cyber attacks involve human error.

---

# Types of Social Engineering

---

## 1. Phishing

Email-based deception.

### Goal

* Credentials
* Financial information

---

## 2. Spear Phishing

Targeted phishing attack.

### Example

Personalized email sent to employee.

---

## 3. Whaling

Targets high-level executives.

Examples:

* CEO
* CFO
* Directors

---

## 4. Smishing

SMS-based phishing.

Example:

"Your bank account is locked. Click here."

---

## 5. Vishing

Voice-based phishing.

Example:

Fake bank support call.

---

## 6. Pretexting

Attacker creates fake scenario.

Example:

Pretending to be IT support.

---

## 7. Baiting

Offering something attractive.

Examples:

* Free software
* Free movies
* Free USB drive

---

## 8. Quid Pro Quo

Service offered in exchange for information.

Example:

"Give me password and I'll fix your computer."

---

## 9. Tailgating

Unauthorized person follows authorized employee.

### Example

Attacker enters office behind employee.

---

## 10. Shoulder Surfing

Watching victim enter:

* Passwords
* PINs

---

## 11. Dumpster Diving

Searching discarded documents.

### Goal

* Passwords
* Personal information

---

## Social Engineering Attack Lifecycle

### Step 1

Information Gathering

↓

### Step 2

Build Trust

↓

### Step 3

Manipulation

↓

### Step 4

Information Extraction

↓

### Step 5

Attack Execution

---

# Prevention Against Social Engineering

### Technical Controls

* MFA
* Email filtering
* Antivirus
* Web filtering

### Human Controls

* Security awareness training
* Verify identities
* Don't share OTPs
* Follow company policies

---

# Quick Comparison

| Attack Type        | Exploits                    |
| ------------------ | --------------------------- |
| Web-Based          | Browser/App vulnerabilities |
| Network-Based      | Communication channels      |
| Social Engineering | Human psychology            |

---

# Exam-Oriented Important Points (Very Important)

### Remember

**MITM = Intercept Communication**

**ARP Spoofing = Fake MAC Mapping**

**DNS Spoofing = Fake DNS Response**

**CSRF = Force User Action**

**XSS = Inject JavaScript**

**Phishing = Fake Website**

**Smishing = SMS Phishing**

**Vishing = Voice Phishing**

**Whaling = Executives**

**Bluebugging = Device Control**

**Bluesnarfing = Data Theft**

**Rogue DHCP = Fake DHCP Server**

**Evil Twin = Fake Wi-Fi Clone**

---

# Frequently Asked MCQs

### 1. Which attack uses a fake Wi-Fi hotspot?

A. XSS

B. CSRF

C. Evil Twin

D. SQL Injection

✅ Answer: C

---

### 2. Which attack steals session cookies using JavaScript?

A. XSS

B. DHCP

C. MITM

D. Smishing

✅ Answer: A

---

### 3. SMS phishing is called:

A. Whaling

B. Smishing

C. Vishing

D. Baiting

✅ Answer: B

---

### 4. Voice-based phishing is:

A. Vishing

B. XSS

C. CSRF

D. MITM

✅ Answer: A

---

### 5. Fake DHCP server attack is:

A. DHCP Starvation

B. Rogue DHCP

C. DNS Spoofing

D. ARP Poisoning

✅ Answer: B

---

### 6. Which attack redirects traffic using forged ARP replies?

A. ARP Spoofing

B. Smishing

C. XSS

D. Baiting

✅ Answer: A

---

### 7. Which attack targets CEOs and executives?

A. Smishing

B. Whaling

C. Tailgating

D. Bluejacking

✅ Answer: B

---

### 8. Which attack downgrades HTTPS to HTTP?

A. DNS Spoofing

B. SSL Stripping

C. Rogue DHCP

D. XSS

✅ Answer: B

---

# Last-Minute Revision Sheet (2-Minute Revision)

| Term          | Meaning                  |
| ------------- | ------------------------ |
| XSS           | JavaScript Injection     |
| CSRF          | Forced User Action       |
| MITM          | Intercept Communication  |
| Evil Twin     | Fake Wi-Fi Clone         |
| Rogue AP      | Fake Hotspot             |
| DNS Spoofing  | Fake DNS                 |
| ARP Spoofing  | Fake ARP                 |
| Smishing      | SMS Phishing             |
| Vishing       | Voice Phishing           |
| Whaling       | Executive Target         |
| Tailgating    | Physical Entry           |
| Bluesnarfing  | Bluetooth Data Theft     |
| Bluebugging   | Bluetooth Device Control |
| Rogue DHCP    | Fake DHCP Server         |
| SSL Stripping | HTTPS → HTTP             |

## Memory Trick

**"SVPW" for phishing attacks**

* **S**mishing → SMS
* **V**ishing → Voice
* **P**hishing → Email/Web
* **W**haling → VIPs (Executives)

These are the most commonly asked theory and MCQ topics in Android Security, Mobile Security, Cyber Security, and OWASP-related university exams.


# 100 MCQs – Web-Based Attacks, Network-Based Attacks & Social Engineering Attacks

## Web-Based Attacks (1–35)

### 1.

What is the primary goal of a phishing attack?

A. Encrypt files
B. Steal credentials
C. Increase bandwidth
D. Improve security

✅ Answer: B

---

### 2.

Which protocol provides encrypted web communication?

A. FTP
B. HTTP
C. HTTPS
D. SMTP

✅ Answer: C

---

### 3.

XSS stands for:

A. Cross Server Scripting
B. Cross Site Scripting
C. Cross Session Security
D. Extended Site Security

✅ Answer: B

---

### 4.

Which attack injects malicious JavaScript into a webpage?

A. SQL Injection
B. XSS
C. MITM
D. ARP Spoofing

✅ Answer: B

---

### 5.

Stored XSS payload is:

A. Stored on victim device
B. Stored in browser cache
C. Stored on server/database
D. Stored in RAM

✅ Answer: C

---

### 6.

Reflected XSS payload comes from:

A. Database
B. Request/Response cycle
C. DNS server
D. DHCP server

✅ Answer: B

---

### 7.

DOM-based XSS affects:

A. DNS Records
B. Browser DOM
C. DHCP Configuration
D. Network Switch

✅ Answer: B

---

### 8.

CSRF stands for:

A. Cross Site Request Forgery
B. Client Side Request Failure
C. Cross Security Response Filter
D. Client Session Recovery Framework

✅ Answer: A

---

### 9.

CSRF attacks exploit:

A. User authentication state
B. Antivirus software
C. Bluetooth settings
D. Hardware ports

✅ Answer: A

---

### 10.

Which helps prevent CSRF?

A. ARP Table
B. CSRF Token
C. DNS Cache
D. Proxy Server

✅ Answer: B

---

### 11.

Session hijacking involves stealing:

A. IP Address
B. MAC Address
C. Session Token
D. Hostname

✅ Answer: C

---

### 12.

Drive-by download occurs when:

A. Malware downloads automatically from a website
B. User downloads a PDF
C. User installs antivirus
D. DNS updates occur

✅ Answer: A

---

### 13.

Malvertising refers to:

A. Malware in advertisements
B. Malware in routers
C. Malware in switches
D. Malware in USB drives

✅ Answer: A

---

### 14.

Which attack uses compromised websites frequently visited by targets?

A. Phishing
B. Watering Hole
C. MITM
D. DHCP Starvation

✅ Answer: B

---

### 15.

A fake banking login page is an example of:

A. XSS
B. Phishing
C. CSRF
D. ARP Spoofing

✅ Answer: B

---

### 16.

HTTPS mainly protects against:

A. Physical theft
B. Eavesdropping
C. Power failure
D. Hardware damage

✅ Answer: B

---

### 17.

Content Security Policy (CSP) helps mitigate:

A. ARP Spoofing
B. XSS
C. DHCP Starvation
D. Smishing

✅ Answer: B

---

### 18.

Cookie theft is commonly associated with:

A. XSS
B. DHCP
C. Bluetooth
D. NFC

✅ Answer: A

---

### 19.

Which attack forces a user to perform unwanted actions?

A. XSS
B. CSRF
C. Smishing
D. Whaling

✅ Answer: B

---

### 20.

WebView is used to:

A. Store passwords
B. Display web content in apps
C. Encrypt traffic
D. Scan ports

✅ Answer: B

---

### 21.

Input validation helps prevent:

A. XSS
B. Flooding
C. Bluetooth attacks
D. NFC attacks

✅ Answer: A

---

### 22.

The most common goal of phishing is:

A. Credential theft
B. Bandwidth usage
C. Network routing
D. DNS caching

✅ Answer: A

---

### 23.

An attacker stealing login cookies is performing:

A. Session Hijacking
B. Rogue AP
C. Smishing
D. Tailgating

✅ Answer: A

---

### 24.

Which attack may occur through malicious browser extensions?

A. XSS
B. Browser Exploitation
C. DHCP Starvation
D. Rogue DHCP

✅ Answer: B

---

### 25.

Which website is safer?

A. HTTP
B. HTTPS
C. FTP
D. SMTP

✅ Answer: B

---

### 26.

Web attacks primarily target:

A. Browsers and web apps
B. RAM chips
C. Printers
D. UPS devices

✅ Answer: A

---

### 27.

Stored XSS is generally considered:

A. More dangerous
B. Less dangerous
C. Physical attack
D. Bluetooth attack

✅ Answer: A

---

### 28.

A malicious advertisement is called:

A. Adware
B. Malvertisement
C. Bluejacking
D. Tailgating

✅ Answer: B

---

### 29.

What is the main target of session hijacking?

A. Session ID
B. Keyboard
C. CPU
D. GPU

✅ Answer: A

---

### 30.

Which attack relies on user trust?

A. Phishing
B. DNS Cache
C. Routing
D. Switching

✅ Answer: A

---

### 31.

Clicking fake login links can result in:

A. Credential theft
B. Faster internet
C. Better security
D. VPN activation

✅ Answer: A

---

### 32.

WebView misuse can lead to:

A. JavaScript Injection
B. Cooling issues
C. Hardware failure
D. Battery replacement

✅ Answer: A

---

### 33.

The safest response to suspicious links is:

A. Open immediately
B. Verify URL first
C. Disable antivirus
D. Share with others

✅ Answer: B

---

### 34.

A compromised website infecting visitors is:

A. Watering Hole Attack
B. ARP Attack
C. DHCP Attack
D. Smishing

✅ Answer: A

---

### 35.

Which attack steals authentication cookies?

A. XSS
B. DHCP Starvation
C. NFC
D. Rogue AP

✅ Answer: A

---

# Network-Based Attacks (36–70)

### 36.

MITM stands for:

A. Multiple Internet Transfer Mode
B. Man In The Middle
C. Mobile Internet Transfer Method
D. Main Traffic Monitoring

✅ Answer: B

---

### 37.

MITM attackers position themselves:

A. Between victim and server
B. Inside BIOS
C. Inside CPU
D. Inside RAM

✅ Answer: A

---

### 38.

A fake Wi-Fi hotspot is:

A. Rogue AP
B. DHCP Snooping
C. SSL Pinning
D. CSP

✅ Answer: A

---

### 39.

An Evil Twin attack is:

A. Fake copy of legitimate Wi-Fi
B. DNS server attack
C. Bluetooth attack
D. NFC attack

✅ Answer: A

---

### 40.

Packet sniffing captures:

A. Network traffic
B. Battery power
C. Storage blocks
D. CPU cycles

✅ Answer: A

---

### 41.

Which tool captures packets?

A. Wireshark
B. Paint
C. VLC
D. Word

✅ Answer: A

---

### 42.

ARP stands for:

A. Address Resolution Protocol
B. Advanced Routing Process
C. Application Relay Protocol
D. Access Routing Process

✅ Answer: A

---

### 43.

ARP Spoofing enables:

A. MITM attacks
B. Printing
C. Video streaming
D. Routing updates

✅ Answer: A

---

### 44.

DNS Spoofing provides:

A. Fake DNS responses
B. Real DNS records
C. Better routing
D. Faster bandwidth

✅ Answer: A

---

### 45.

SSL Stripping downgrades:

A. HTTPS to HTTP
B. HTTP to HTTPS
C. FTP to SSH
D. SMTP to POP3

✅ Answer: A

---

### 46.

DNS translates:

A. Domain names to IPs
B. MAC to IP
C. Packets to files
D. Files to packets

✅ Answer: A

---

### 47.

Bluejacking involves:

A. Sending unwanted Bluetooth messages
B. Stealing data
C. Device control
D. Network scanning

✅ Answer: A

---

### 48.

Bluesnarfing involves:

A. Data theft via Bluetooth
B. Wi-Fi cloning
C. DNS spoofing
D. ARP poisoning

✅ Answer: A

---

### 49.

Bluebugging allows:

A. Device control
B. DNS updates
C. Routing
D. Switching

✅ Answer: A

---

### 50.

NFC stands for:

A. Near Field Communication
B. Network File Control
C. Near Frequency Channel
D. Network Field Connection

✅ Answer: A

---

### 51.

NFC attacks often require:

A. Close proximity
B. Internet access
C. VPN
D. DNS

✅ Answer: A

---

### 52.

DHCP provides:

A. IP addresses
B. MAC addresses
C. DNS records
D. Passwords

✅ Answer: A

---

### 53.

DHCP Starvation consumes:

A. Available IP addresses
B. DNS records
C. Web cookies
D. SSL certificates

✅ Answer: A

---

### 54.

Rogue DHCP server provides:

A. Malicious network settings
B. Software updates
C. Antivirus signatures
D. Routing protocols

✅ Answer: A

---

### 55.

Certificate Pinning helps prevent:

A. MITM
B. Smishing
C. Tailgating
D. Dumpster Diving

✅ Answer: A

---

### 56-70 Quick MCQs

56. HTTPS uses encryption? → **A. Yes** ✅

57. Fake DNS reply? → **DNS Spoofing** ✅

58. Intercept network traffic? → **MITM** ✅

59. Fake Wi-Fi hotspot? → **Rogue AP** ✅

60. Clone Wi-Fi network? → **Evil Twin** ✅

61. Capture packets? → **Sniffing** ✅

62. Bluetooth data theft? → **Bluesnarfing** ✅

63. Bluetooth control? → **Bluebugging** ✅

64. Forged ARP messages? → **ARP Spoofing** ✅

65. HTTPS downgrade? → **SSL Stripping** ✅

66. DHCP attack creating fake settings? → **Rogue DHCP** ✅

67. NFC attack requires close distance? → **Yes** ✅

68. VPN helps against? → **MITM** ✅

69. Wireshark is used for? → **Packet Analysis** ✅

70. Network attack targets? → **Communication Channel** ✅

---

# Social Engineering (71–100)

### 71.

Social engineering primarily targets:

A. Humans
B. Routers
C. Switches
D. Firewalls

✅ Answer: A

---

### 72.

Phishing commonly uses:

A. Emails
B. RAM
C. BIOS
D. CPU

✅ Answer: A

---

### 73.

Smishing uses:

A. SMS
B. Voice
C. Bluetooth
D. NFC

✅ Answer: A

---

### 74.

Vishing uses:

A. Voice Calls
B. Email
C. DNS
D. ARP

✅ Answer: A

---

### 75.

Whaling targets:

A. Executives
B. Students
C. Printers
D. Servers

✅ Answer: A

---

### 76.

Spear phishing is:

A. Targeted phishing
B. Random phishing
C. DNS attack
D. DHCP attack

✅ Answer: A

---

### 77.

Pretexting relies on:

A. Fake scenario
B. Encryption
C. VPN
D. Routing

✅ Answer: A

---

### 78.

Baiting uses:

A. Attractive offers
B. DNS
C. ARP
D. SSL

✅ Answer: A

---

### 79.

Quid Pro Quo means:

A. Information for service
B. Free VPN
C. Wi-Fi cloning
D. Packet sniffing

✅ Answer: A

---

### 80.

Tailgating is:

A. Unauthorized physical entry
B. DNS attack
C. Bluetooth attack
D. XSS

✅ Answer: A

---

### 81.

Shoulder surfing involves:

A. Watching credentials being entered
B. Sniffing packets
C. Cloning Wi-Fi
D. DNS poisoning

✅ Answer: A

---

### 82.

Dumpster diving searches:

A. Discarded documents
B. DNS cache
C. RAM
D. Packets

✅ Answer: A

---

### 83.

Most successful attacks exploit:

A. Human error
B. Hardware failure
C. RAM
D. BIOS

✅ Answer: A

---

### 84.

An OTP should be shared with:

A. Nobody
B. Friends
C. Caller
D. Support agent

✅ Answer: A

---

### 85.

Unexpected prize messages are usually:

A. Baiting
B. DNS
C. SSL
D. Routing

✅ Answer: A

---

### 86.

CEO-targeted phishing:

A. Whaling
B. Smishing
C. Bluejacking
D. XSS

✅ Answer: A

---

### 87.

SMS phishing:

A. Smishing
B. Vishing
C. Whaling
D. XSS

✅ Answer: A

---

### 88.

Phone-call phishing:

A. Vishing
B. Smishing
C. MITM
D. ARP

✅ Answer: A

---

### 89.

Security awareness training helps prevent:

A. Social Engineering
B. DNS
C. ARP
D. DHCP

✅ Answer: A

---

### 90.

Trust manipulation is central to:

A. Social Engineering
B. Encryption
C. Routing
D. VPN

✅ Answer: A

---

### 91-100 Quick MCQs

91. Fake IT support call? → **Pretexting** ✅

92. Free USB drive attack? → **Baiting** ✅

93. Human hacking? → **Social Engineering** ✅

94. Physical follow-in attack? → **Tailgating** ✅

95. Watching PIN entry? → **Shoulder Surfing** ✅

96. Searching trash for information? → **Dumpster Diving** ✅

97. Best defense against phishing? → **User Awareness** ✅

98. MFA reduces impact of? → **Credential Theft** ✅

99. Social engineering exploits? → **Psychology** ✅

100. Most important defense? → **Verify Before Trusting** ✅

# Exam Super-Tips

### Remember This Sequence

**Phishing Family**

* Phishing = Email/Web
* Smishing = SMS
* Vishing = Voice
* Spear Phishing = Targeted
* Whaling = Executives

**Bluetooth Family**

* Bluejacking = Messages
* Bluesnarfing = Data Theft
* Bluebugging = Device Control

**Network Family**

* MITM = Intercept
* ARP Spoofing = Fake MAC Mapping
* DNS Spoofing = Fake DNS
* SSL Stripping = HTTPS → HTTP
* Evil Twin = Fake Wi-Fi Clone

These 20–25 concepts account for the majority of university, placement, and cyber security exam MCQs from these topics.
