# Session 21 (3T + 2L): Android Architecture, File Structure & Security Fundamentals

**Topics:** Introduction to Android Architecture | Android File Structure | Android Build Process | Android App Fundamentals | Android Security Model | Device Rooting

---

## 1. Introduction to Android Architecture

Android is a Linux-based, open-source operating system designed primarily for mobile devices like smartphones and tablets. It follows a **layered architecture**, where each layer provides specific functionality and interacts with the layers above and below it.

### 1.1 Linux Kernel (Base Layer)

The foundation of Android — acts as the core of the OS.

**Provides low-level system services:**

- Process management (creation, scheduling, termination)
- Memory management
- Device drivers (camera, display, Wi-Fi, Bluetooth)
- Power management
- Security (SELinux enforcement)

Works as a hardware abstraction foundation for upper layers.

### 1.2 Hardware Abstraction Layer (HAL)

Acts as a bridge between hardware and software layers, providing standard interfaces for hardware components (camera, sensors like accelerometer/gyroscope, audio devices). Ensures device independence so Android runs on different hardware without modifying upper layers.

### 1.3 Native Libraries

Written in C/C++, stored in `/system/lib` or `/system/lib64`. Provide essential functionalities:

| Category | Library                          |
| -------- | -------------------------------- |
| Graphics | OpenGL ES, Skia                  |
| Database | SQLite                           |
| Media    | Stagefright (audio/video codecs) |
| Web      | WebKit/Chromium                  |
| Security | SSL libraries                    |

Used by the Android framework via **JNI (Java Native Interface)**.

### 1.4 Android Runtime (ART)

Executes Android applications; replaced the older **Dalvik Virtual Machine (DVM)**.

**Key features:**

- Uses **AOT (Ahead-of-Time)** compilation for better performance
- Improved garbage collection
- Efficient memory usage
- Each app runs in its own process and instance of ART (sandboxing)

### 1.5 Application Framework

Provides high-level APIs for developers, simplifying development by hiding low-level complexity.

**Major components:**

- **Activity Manager** — manages app lifecycle
- **Window Manager** — handles UI windows
- **Content Providers** — data sharing between apps
- **Notification Manager** — manages alerts
- **Resource Manager** — handles non-code resources (layouts, strings)
- **Location Manager, Telephony Manager**, etc.

### 1.6 Applications (Top Layer)

- **System apps** — Dialer, SMS, Settings, Browser (pre-installed)
- **User-installed apps** — from Play Store or APK
- Built using Java/Kotlin with the Android SDK
- Run in isolated environments (sandboxing) for security

### 1.7 Quick Example (Flow Understanding)

When you open a camera app:

```
1. App (Application layer) requests camera access
2. Framework (Camera Manager API) processes the request
3. HAL communicates with camera hardware
4. Linux Kernel interacts with the device driver
5. Image captured and returned up the stack
```

---

## 2. Android File Structure

Android uses a Linux-based hierarchical file system.

### 2.1 Important Directories

| Directory                   | Purpose                                                                                                                                                                                                                                            |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`/system`**               | Contains core OS files and system apps (pre-installed apps, framework libraries); typically read-only for users (requires root to modify)                                                                                                          |
| **`/data`**                 | Stores user and application data — installed apps, app-specific data, user settings. Critical path: `/data/data/<package_name>/` — each app has its own directory containing databases, shared preferences, and files. Highly secure and sandboxed |
| **`/cache`**                | Temporary system files (app caching, system updates); can be cleared without affecting user data                                                                                                                                                   |
| **`/sdcard` or `/storage`** | External/shared storage accessible by user apps (with permissions); stores media files, downloads. Not strictly secure — apps can access shared files with permission                                                                              |
| **`/proc`**                 | Virtual filesystem providing process and kernel information (e.g., `/proc/cpuinfo` → CPU details, `/proc/meminfo` → memory usage)                                                                                                                  |
| **`/dev`**                  | Contains device files representing hardware; used by the kernel to interact with devices                                                                                                                                                           |
| **`/sys`**                  | Provides kernel and device interface information — used for device configuration and hardware status                                                                                                                                               |

### 2.2 Application Sandboxing (Important Concept)

- Each app runs as a **separate Linux user (UID)**
- App data stored in `/data/data/<package_name>/`

**Benefits:**

- Prevents unauthorized access between apps
- Enhances security

**Communication between apps:**

- Via **Intents**
- Via **Content Providers**

---

## 3. Android Build Process

The build process converts application source code into a signed, installable **APK (Android Package)** file.

### 3.1 Source Code

- Java/Kotlin files (business logic)
- XML files (UI layouts, manifest, resources)
- Assets (images, fonts, raw files)
- Key file: **`AndroidManifest.xml`** — defines app components, permissions, and configuration

### 3.2 Compilation

- Java/Kotlin code is compiled into Java bytecode (`.class` files)
- Kotlin is first converted to Java-compatible bytecode
- Tools: `javac` (Java compiler), Kotlin compiler

### 3.3 Dexing (Dalvik Executable Conversion)

- `.class` files are converted into `.dex` (Dalvik Executable) format
- Tool: **D8** (or the older DX tool)
- Why `.dex`? Optimized for low memory and mobile environments; combines multiple class files into a single executable format

### 3.4 Resource Processing

- XML resources are compiled into a binary format
- Resource IDs are generated and stored in `R.java` (or `R.class`)
- Tool: **AAPT** (Android Asset Packaging Tool)

### 3.5 Packaging (APK Creation)

All components are bundled into an APK: `.dex` files, compiled resources, native libraries (`.so`), manifest file. An APK is essentially a ZIP archive with a specific structure.

### 3.6 Signing

- The APK must be digitally signed before installation
- **Debug key** (development) vs **Release key** (production)
- Purpose: ensures authenticity and integrity; identifies the developer

### 3.7 Optimization (Optional but Important)

- Tools: **ProGuard / R8**
- Functions: code shrinking (removes unused code), obfuscation (renames classes/methods), performance optimization
- Reduces APK size and protects code from reverse engineering

### 3.8 Final Output

APK file ready for installation via ADB or distribution via the Play Store.

**Build Process Flow:**

```
1. Developer writes Kotlin code + XML UI
2. Code → compiled to .class
3. .class → converted to .dex
4. Resources + .dex → packaged into APK
5. APK → signed → optimized → installed on device
```

---

## 4. Android App Fundamentals

Android applications are built using four core components, each serving a specific role.

### 4.1 Activities (UI Layer)

Represents a single screen with a user interface (e.g., login screen, dashboard screen).

- Managed via the **Activity Lifecycle** (`onCreate`, `onStart`, `onResume`, etc.)
- Handles user interaction
- Navigation between activities via **Intents**

### 4.2 Services (Background Processing)

Runs in the background without a UI — used for music playback, data syncing, network operations.

**Types:**

- **Foreground Service** — visible to the user (e.g., music player)
- **Background Service**

**Lifecycle:** `onCreate`, `onStartCommand`, `onDestroy`

### 4.3 Broadcast Receivers (Event Handling)

Respond to system-wide or app-specific events (battery low, network change, boot completed). Works using **Intents** (broadcast messages); a lightweight component with no UI.

### 4.4 Content Providers (Data Sharing)

Manages and shares structured data between apps (e.g., access contacts, share media files). Uses a **URI (Uniform Resource Identifier)** to access data. Supports CRUD operations (Create, Read, Update, Delete).

### 4.5 Application Sandbox and Security

- Each Android app runs in a separate sandbox with a unique **Linux User ID (UID)**
- Ensures process isolation and data protection
- App data stored in `/data/data/<package_name>/`

**Security mechanisms:**

- Permission-based access (camera, location, storage)
- Inter-process communication (IPC) via Intents and Content Providers

### 4.6 Example (Real App Flow)

For a music streaming app:

```
Activity          → Displays UI (song list)
Service           → Plays music in background
Broadcast Receiver → Detects headphone unplug event
Content Provider  → Accesses local media files
```

---

## 5. Android Security Model

Android uses a multi-layered security model to protect user data, system integrity, and application isolation.

### 5.1 Sandboxing

- Each app runs in a separate Linux process, assigned a unique **User ID (UID)**
- Ensures isolation of apps from each other — no direct access to another app's data
- App data stored in `/data/data/<package_name>/`
- Prevents unauthorized access unless explicitly permitted

### 5.2 Permission Model

- Apps must declare permissions in `AndroidManifest.xml`
- Required for accessing sensitive resources: camera, location, microphone, storage

**Types of permissions:**
| Type | Description |
|---|---|
| **Normal** | Low-risk, granted automatically |
| **Dangerous** | Require user approval at runtime |

**Example:** A maps app requests location permission before accessing GPS.

### 5.3 Application Signing

- Every APK must be digitally signed before installation
- Ensures app authenticity (verified developer identity) and integrity (APK not tampered)
- Apps signed with the same key can share data or run in the same process (if configured)

### 5.4 SELinux (Security-Enhanced Linux)

- Implements **Mandatory Access Control (MAC)**
- Enforces strict policies on processes and system resources
- Works in **enforcing mode** (blocks unauthorized access)
- Prevents privilege escalation and limits damage from exploits

### 5.5 Verified Boot

- Ensures the device boots using trusted and unmodified software
- Verifies the bootloader, kernel, and system partitions
- Detects tampering and prevents a compromised OS from loading

### 5.6 Google Play Protect

- Built-in malware protection system
- Scans apps during installation, periodic background scanning, detects harmful behavior
- Protects users from malicious apps, even outside the Play Store

### 5.7 Security Flow Example

```
1. App requests camera access → Permission check
2. Runs in sandbox → Cannot access other apps' data
3. SELinux enforces access rules
4. APK signature verified before install
5. Play Protect scans for malware
```

---

## 6. Device Rooting

Rooting is the process of obtaining **superuser (root) privileges** on an Android device, bypassing built-in security restrictions.

### 6.1 What Is Root Access?

The root user has full control over the system (like Linux root) — can modify system files, access restricted directories, and change system behavior.

### 6.2 Why Root a Device?

- Install custom ROMs (modified Android OS)
- Remove pre-installed apps (bloatware)
- Use advanced tools: firewall apps, packet sniffers, system-level automation
- Perform deep customization: UI themes, kernel tweaks
- Useful in security research and penetration testing

### 6.3 Rooting Methods

- Unlocking bootloader + flashing custom recovery (e.g., TWRP)
- Flashing modified system images
- Exploiting vulnerabilities in the OS (less common now)
- Tools: **Magisk** (systemless rooting), Fastboot/ADB

### 6.4 Risks of Rooting

- Voids device warranty
- Increased security risks — malware can gain root access
- System instability: boot loops, crashes
- OTA (Over-the-Air) updates may fail
- Potential data loss if done incorrectly

### 6.5 Security Impact of Rooting

- Breaks the Android sandbox model
- Weakens SELinux enforcement (may be bypassed) and Verified Boot integrity
- Makes the device more vulnerable to rootkits and privilege escalation attacks

**Example (Practical Understanding):**

- Normal device: an app cannot access the `/system` directory
- Rooted device: a user (or malicious app) can modify `/system` files — e.g., replace system binaries or inject malware

---

---

# Session 22 (3T + 2L): Android Debug Bridge & Penetration Testing Tools

**Topics:** Android Debug Bridge (ADB) | Penetration Testing Tools

---

## 1. Android Debug Bridge (ADB)

ADB is a versatile command-line tool that enables communication between a computer and an Android device (physical or emulator). It is part of the **Android SDK Platform Tools**, used by developers, testers, and security professionals to interact directly with the Android system for debugging and control.

### 1.1 Key Features of ADB

- Install and uninstall applications directly from the terminal
- Execute Linux shell commands on the device
- Transfer files between host (PC) and device
- Access system logs for debugging
- Perform port forwarding for network debugging
- Control device state (reboot, sideload updates, etc.)

### 1.2 ADB Architecture (How It Works)

ADB follows a **client–server architecture** with three main components:

| Component           | Role                                                                                                                                                                          |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Client**          | Runs on the user's computer (development machine); invoked via command line (e.g., `adb devices`); sends commands to the server                                               |
| **Server**          | Runs as a background process on the host machine; manages communication between client and devices; handles multiple devices/emulators; starts automatically when ADB is used |
| **Daemon (`adbd`)** | Runs on the Android device; executes commands received from the server; provides shell access and system interaction                                                          |

**Working Flow (Example):**

```
1. User runs: adb shell
2. Client sends request → Server
3. Server communicates with device daemon (adbd)
4. Daemon executes command and returns output
```

### 1.3 Common ADB Commands

**Device Management**

```bash
adb devices              # Lists all connected devices and their status
```

**Shell Access**

```bash
adb shell                # Opens a Linux shell on the Android device
adb shell ls /data       # Example command within the shell
```

**App Management**

```bash
adb install <apk>              # Installs an APK file
adb uninstall <package_name>   # Removes an installed app
```

**File Transfer**

```bash
adb push <local> <remote>   # Copies file from PC to device
adb pull <remote> <local>   # Copies file from device to PC
```

**Logs and Debugging**

```bash
adb logcat               # Displays real-time system logs; useful for debugging crashes and runtime issues
```

**Device Control**

```bash
adb reboot                # Reboots the device
adb reboot bootloader     # Boots into bootloader mode
```

**Port Forwarding**

```bash
adb forward tcp:<local_port> tcp:<device_port>   # Redirects traffic for debugging apps (e.g., web servers)
```

**Practical Example (Install and Debug an App):**

```
1. adb devices    → confirm device connected
2. adb install app.apk → install app
3. adb logcat     → monitor logs during execution
```

### 1.4 Security Considerations

ADB is powerful and can pose security risks if misused — especially if left enabled on a production device, since it grants deep system access.

**Risks:**

- Unauthorized access if USB debugging is enabled
- Attackers can install malicious apps, extract sensitive data, or execute system-level commands

**Protection Measures:**

- Disable USB Debugging when not in use (always disable ADB on devices not under active development or testing)
- Authorize only trusted computers (RSA key prompt)
- Avoid using ADB on public/shared systems
- Use a secure lock screen (prevents unauthorized ADB access)

### 1.5 ADB in Cybersecurity

Used in penetration testing and forensics for:

- Data extraction from devices
- Log analysis
- App behavior monitoring

Combined with tools like `logcat` (runtime analysis) and `tcpdump` (if rooted, for packet capture). Helps in reverse engineering and malware analysis on Android.

---

## 2. Penetration Testing Tools — Detailed Theory

Penetration Testing (PenTest) tools are software used by ethical hackers and security professionals to **identify, exploit, and fix vulnerabilities** in systems and applications.

### 2.1 Common Tool Categories

| #   | Category                          | Purpose                                                        | Examples                          |
| --- | --------------------------------- | -------------------------------------------------------------- | --------------------------------- |
| 1   | **Network Scanners**              | Identify devices, open ports, and services on a network        | Nmap, Angry IP Scanner            |
| 2   | **Vulnerability Scanners**        | Automatically scan for known security weaknesses               | Nessus, OpenVAS, Qualys           |
| 3   | **Exploitation Tools**            | Exploit discovered vulnerabilities to gain unauthorized access | Metasploit Framework, Core Impact |
| 4   | **Web Application Testing Tools** | Test for web vulnerabilities (SQLi, XSS, CSRF)                 | Burp Suite, OWASP ZAP             |
| 5   | **Wireless Testing Tools**        | Focus on Wi-Fi network security                                | Aircrack-ng, Kismet               |
| 6   | **Password Cracking Tools**       | Brute force passwords or recover passwords from hashes         | John the Ripper, Hashcat          |
| 7   | **Packet Sniffers**               | Capture and analyze network traffic                            | Wireshark, tcpdump                |

### 2.2 Category Details

**1. Network Scanners**

- Discover live hosts, open ports, running services, and OS fingerprinting on a network
- **Nmap** — the industry-standard scanner for host/port discovery and service enumeration
- **Angry IP Scanner** — lightweight, fast IP/port scanner

**2. Vulnerability Scanners**

- Compare discovered services/versions against known vulnerability databases (CVEs)
- **Nessus** — widely used commercial vulnerability scanner
- **OpenVAS** — open-source vulnerability scanning framework
- **Qualys** — cloud-based vulnerability management platform

**3. Exploitation Tools**

- Provide frameworks to actually exploit identified vulnerabilities (proof-of-concept or full compromise)
- **Metasploit Framework** — the most widely used exploitation framework, with a large library of exploits/payloads
- **Core Impact** — commercial exploitation and penetration testing platform

**4. Web Application Testing Tools**

- Target web-specific vulnerabilities: SQL Injection (SQLi), Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF)
- **Burp Suite** — intercepting proxy + scanner, industry standard for web app pentesting
- **OWASP ZAP** — free, open-source alternative to Burp Suite

**5. Wireless Testing Tools**

- Assess Wi-Fi security: WEP/WPA/WPA2 cracking, rogue AP detection, packet injection
- **Aircrack-ng** — suite for capturing and cracking Wi-Fi keys
- **Kismet** — wireless network detector and sniffer

**6. Password Cracking Tools**

- Recover plaintext passwords via brute force, dictionary, or hash-cracking attacks
- **John the Ripper** — versatile password cracker supporting many hash formats
- **Hashcat** — GPU-accelerated password/hash cracking tool

**7. Packet Sniffers**

- Capture and analyze raw network traffic for credentials, protocols, and anomalies
- **Wireshark** — GUI-based deep packet inspection tool
- **tcpdump** — CLI packet capture tool, often used on rooted Android devices

### 2.3 Integration with Android Testing

Penetration testers combine **ADB** with the above tool categories to test Android apps and devices:

- Use ADB to **extract data** (`adb pull /data/data/<package>/`) for offline analysis
- Use ADB `logcat` for **debugging and runtime log analysis**
- Use ADB `shell` to **simulate attacker-level access** on a test/rooted device
- Pair with **Burp Suite/OWASP ZAP** to intercept app network traffic
- Pair with **Wireshark/tcpdump** to capture raw packets from the device
- Pair with **Metasploit** to test exploitation of exposed Android components/services

### 2.4 Quick Reference Flow

```
Recon          → Network Scanners (Nmap)
   ↓
Vulnerability   → Vulnerability Scanners (Nessus, OpenVAS)
Identification
   ↓
Exploitation    → Exploitation Tools (Metasploit)
   ↓
Web/App Layer   → Burp Suite / OWASP ZAP
   ↓
Wireless Layer  → Aircrack-ng / Kismet
   ↓
Credential      → John the Ripper / Hashcat
Attacks
   ↓
Traffic         → Wireshark / tcpdump
Analysis
   ↓
Android Device  → ADB (install, shell, pull/push, logcat)
Integration
```

---

# Session 23 (2T + 2L): OWASP Top 10 Mobile App Vulnerabilities

**Topics:** OWASP Top 10 Mobile App Vulnerabilities | Attacks on Mobile Applications

---

## 1. OWASP Top 10 Mobile App Vulnerabilities

**OWASP (Open Web Application Security Project)** publishes a list of the top risks for mobile applications, helping developers and testers understand and prioritize critical security issues.

### 1.1 The Top 10 List

| #      | Risk                           | Description                                                                                                                    |
| ------ | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| **1**  | **Improper Platform Usage**    | Misuse of platform features or failure to use platform security controls properly (e.g., Android intents, iOS Keychain misuse) |
| **2**  | **Insecure Data Storage**      | Storing sensitive data insecurely on the device (e.g., in plain text files, SQLite databases without encryption)               |
| **3**  | **Insecure Communication**     | Failing to protect data in transit (e.g., lack of SSL/TLS, using weak protocols)                                               |
| **4**  | **Insecure Authentication**    | Weak authentication mechanisms, improper session management, or storing credentials insecurely                                 |
| **5**  | **Insufficient Cryptography**  | Using weak or flawed cryptographic algorithms, or improper implementation of cryptography                                      |
| **6**  | **Insecure Authorization**     | Failing to properly restrict user access to resources (e.g., broken access control)                                            |
| **7**  | **Client Code Quality Issues** | Bugs in the mobile app code such as buffer overflows, insecure randomness, or improper error handling                          |
| **8**  | **Code Tampering**             | Attackers modify the app binary or resources to change app behavior (e.g., via repackaging or patching)                        |
| **9**  | **Reverse Engineering**        | Lack of obfuscation or anti-debugging allows attackers to analyze the app's internals, discover secrets, or modify behavior    |
| **10** | **Extraneous Functionality**   | Hidden backdoors, debug code, or other features not intended for production that can be exploited                              |

### 1.2 Detailed Notes per Risk

**1. Improper Platform Usage**

- Occurs when developers don't correctly use platform-provided security features
- Android example: misusing Intents (unprotected exported components); iOS example: misusing Keychain storage
- Leads to unintended data exposure or component hijacking

**2. Insecure Data Storage**

- Sensitive data (passwords, tokens, PII) stored without encryption
- Common insecure locations: plain text files, unencrypted SQLite databases, SharedPreferences
- Attackers with physical/root access can directly read this data

**3. Insecure Communication**

- Data in transit not properly protected
- Causes: no SSL/TLS, outdated protocol versions, missing certificate validation
- Enables interception and tampering of network traffic

**4. Insecure Authentication**

- Weak login mechanisms, poor session handling, insecure credential storage
- Includes issues like no session expiry, weak password policies, storing credentials in plaintext

**5. Insufficient Cryptography**

- Use of weak/broken algorithms (e.g., MD5, DES) or flawed implementation of otherwise-strong algorithms
- Improper key management (hardcoded keys, weak key generation)

**6. Insecure Authorization**

- Distinct from authentication — this is about **what an authenticated user is allowed to do**
- Broken access control: a user can access resources/functions beyond their privilege level

**7. Client Code Quality Issues**

- Low-level coding flaws: buffer overflows, format string issues, insecure randomness, improper error/exception handling
- Often exploitable for crashes or code execution

**8. Code Tampering**

- Attacker modifies the APK (repackaging, patching binaries/resources) to alter app behavior
- Used to bypass license checks, inject malicious code, or disable security controls

**9. Reverse Engineering**

- Without obfuscation or anti-debugging protections, attackers can decompile the APK
- Reveals business logic, hardcoded secrets (API keys, credentials), and enables behavior modification

**10. Extraneous Functionality**

- Debug code, test backdoors, or hidden features accidentally left in production builds
- Can be discovered and exploited by attackers to bypass security controls entirely

### 1.3 Quick Reference Table

| Category                  | Root Cause                    | Example Impact                     |
| ------------------------- | ----------------------------- | ---------------------------------- |
| Improper Platform Usage   | Misusing OS security features | Exposed intents, keychain misuse   |
| Insecure Data Storage     | No encryption at rest         | Data theft on rooted/stolen device |
| Insecure Communication    | No/weak SSL-TLS               | MITM data interception             |
| Insecure Authentication   | Weak login/session logic      | Account takeover                   |
| Insufficient Cryptography | Weak/broken crypto            | Data decryption by attacker        |
| Insecure Authorization    | Broken access control         | Privilege escalation               |
| Client Code Quality       | Coding bugs                   | Crashes, code execution            |
| Code Tampering            | Binary modification           | Malicious repackaged app           |
| Reverse Engineering       | No obfuscation                | Secrets/logic exposed              |
| Extraneous Functionality  | Leftover debug/backdoor code  | Hidden exploitable access          |

---

## 2. Attacks on Android Apps — Common Vectors

### 2.1 Vector List

**1. Insecure Data Storage**

- Android apps sometimes store sensitive data (passwords, tokens) in SharedPreferences, files, or databases without encryption
- Attackers who gain physical or root access can extract this data

**2. Intent Spoofing and Injection**

- Android uses Intents to communicate between apps
- Malicious apps can send crafted intents to exploit vulnerabilities or escalate privileges

**3. Insecure Communication**

- Apps may send data over unencrypted HTTP or weak SSL/TLS configurations
- Makes MITM (Man-in-the-Middle) attacks possible

**4. Reverse Engineering and Code Injection**

- Android apps are distributed as APK files, which can be unpacked and analyzed
- Attackers reverse engineer apps to find hardcoded secrets or inject malicious code

**5. Dynamic Code Loading**

- Apps can load code at runtime from external sources
- This capability can be exploited to inject malicious payloads

**6. Insecure Authentication and Session Management**

- Flaws in login, token management, or session expiration can lead to unauthorized access

**7. Over-privileged Permissions**

- Apps requesting more permissions than necessary increase the attack surface

**8. Code Injection via WebViews**

- If WebViews are not secured, they can be exploited with JavaScript injection attacks

### 2.2 Summary Table

| #   | Vector                               | Root Weakness                              | Typical Attacker Action                    |
| --- | ------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| 1   | Insecure Data Storage                | Unencrypted local storage                  | Extract data via physical/root access      |
| 2   | Intent Spoofing/Injection            | Unprotected exported components            | Send crafted intents to escalate privilege |
| 3   | Insecure Communication               | HTTP / weak TLS                            | MITM interception of traffic               |
| 4   | Reverse Engineering / Code Injection | Unobfuscated APK                           | Extract secrets, inject malicious code     |
| 5   | Dynamic Code Loading                 | Runtime code loading from external sources | Inject malicious payload at runtime        |
| 6   | Insecure Auth/Session Mgmt           | Weak login/token/session handling          | Unauthorized account access                |
| 7   | Over-privileged Permissions          | Excess permission requests                 | Larger attack surface for abuse            |
| 8   | WebView Code Injection               | Unsecured WebView + JS enabled             | JavaScript injection attacks               |

### 2.3 Mapping Vectors to OWASP Top 10

```
OWASP Risk                     ←→   Related Attack Vector
─────────────────────────────────────────────────────────
Insecure Data Storage          ←→   Vector 1 (Insecure Data Storage)
Improper Platform Usage        ←→   Vector 2 (Intent Spoofing/Injection)
Insecure Communication         ←→   Vector 3 (Insecure Communication)
Reverse Engineering            ←→   Vector 4 (Reverse Engineering/Code Injection)
Extraneous Functionality       ←→   Vector 5 (Dynamic Code Loading)
Insecure Authentication        ←→   Vector 6 (Auth/Session Management)
Insecure Authorization         ←→   Vector 7 (Over-privileged Permissions)
Client Code Quality Issues     ←→   Vector 8 (WebView Code Injection)
```

---

---

# Session 24 (3T + 2L): Web, Network & Social Engineering Attacks on Android

**Topics:** Web-Based Attacks on Android Devices | Network-Based Attacks | Social Engineering Attacks

---

## 1. Web-Based Attacks on Android Devices

Android devices heavily rely on web connectivity and web applications, making them vulnerable to various web-based attacks. These exploit weaknesses in web protocols, browser implementations, and app–WebView integrations.

### 1.1 Cross-Site Scripting (XSS)

**Definition:** Malicious scripts injected into trusted websites or apps with embedded web views.

**Attack Method:** Attacker injects JavaScript into a page → script executes in the victim's browser context → accesses cookies, session tokens, or DOM data.

**Android-Specific Risk:** Apps using WebView may be vulnerable if they don't sanitize input, allow JavaScript execution (`setJavaScriptEnabled(true)`), or load untrusted URLs.

**Impact:** Session hijacking; data theft (credentials, tokens); execution of unwanted actions on behalf of the user.

**Example:** A WebView-based search feature with URL parameter `?query=<script>stealCookies()</script>` executes the script in the WebView context.

**Mitigation:** Disable JavaScript if not needed (`webView.getSettings().setJavaScriptEnabled(false)`); sanitize/validate all input; use Content Security Policy (CSP) headers; load only trusted content in WebView.

### 1.2 Cross-Site Request Forgery (CSRF)

**Definition:** Tricks authenticated users into submitting malicious requests unknowingly.

**Attack Method:** Attacker crafts a malicious link/form → victim clicks while authenticated on the legitimate site → request executes with the victim's credentials.

**Android-Specific Risk:** Apps with embedded browsers/WebViews that don't use anti-CSRF tokens or rely solely on cookies for authentication.

**Impact:** Unauthorized transactions (money transfer, password change); account compromise; data manipulation.

**Example:** A user logged into a banking app clicks a malicious link in an email; a hidden form submits a transfer request.

**Mitigation:** Anti-CSRF tokens for all state-changing requests; require re-authentication for sensitive actions; `SameSite` cookie attribute; validate `Referer`/`Origin` headers.

### 1.3 Phishing via Malicious Websites

**Definition:** Fake websites mimicking legitimate ones to steal credentials or sensitive data.

**Attack Method:** Phishing links via email/SMS/social media → fake login page captures credentials → redirects to the legitimate site to avoid suspicion.

**Android-Specific Risk:** Small screens make URL inspection difficult; apps opening external URLs without warning.

**Impact:** Credential theft; account compromise; identity theft.

**Example:** A fake Instagram login page at `instagram-secure.com` (instead of `instagram.com`) captures entered credentials.

**Mitigation:** Educate users to verify URLs; use HTTPS and certificate validation; app-specific authentication (OAuth, biometrics); warn users before opening external links.

### 1.4 Drive-by Downloads

**Definition:** Visiting a compromised/malicious website triggers automatic malware downloads without user consent.

**Attack Method:** Exploit browser/WebView vulnerabilities → trigger automatic download of a malicious APK/executable → user unknowingly installs malware.

**Android-Specific Risk:** Devices with "Install from Unknown Sources" enabled; outdated browser components.

**Impact:** Malware installation; data theft; device compromise.

**Example:** A user visits a compromised news site; a malicious script downloads a fake "Flash Player" APK; the user installs it and the device is infected.

**Mitigation:** Keep browsers/WebView updated; disable installation from unknown sources; use Google Play Protect; implement safe browsing features.

### 1.5 Man-in-the-Browser (MitB) Attacks

**Definition:** Malware inside the browser intercepts or modifies web communications between the user and the website.

**Attack Method:** Malicious app hooks into the browser (via accessibility/overlay permissions), captures or modifies requests, alters transaction details, or steals credentials.

**Android-Specific Risk:** Malicious apps with accessibility/overlay permissions; apps that draw over other apps; keylogging via overlay attacks.

**Impact:** Transaction manipulation (e.g., changing a bank account number); credential theft; session hijacking.

**Example:** A malicious app with overlay permission captures keystrokes or modifies a transaction when the user opens a banking app.

**Mitigation:** Avoid granting unnecessary overlay/accessibility permissions; app integrity checks; transaction confirmation via a separate channel (SMS/email); detect and block overlay attacks.

### 1.6 Malicious Ad Injection

**Definition:** Ads served through ad networks contain malicious code or redirect to harmful sites ("malvertising").

**Attack Method:** Attacker purchases ad space on legitimate networks; the ad contains malicious JavaScript or redirects to phishing sites.

**Android-Specific Risk:** Apps using third-party ad libraries; WebView-based ad rendering.

**Impact:** Malware distribution; phishing attacks; unwanted redirects.

**Example:** A free game app displays ads from a network; an ad redirects to a fake antivirus site; the user downloads malware.

**Mitigation:** Use reputable ad networks; validate ad content before display; educate users to avoid suspicious ads; implement ad-blocking for sensitive apps.

### 1.7 Browser Exploits

**Definition:** Vulnerabilities in mobile browsers or embedded WebView components exploited to execute code or escalate privileges.

**Attack Method:** Exploit zero-day vulnerabilities in the browser engine (Chrome, WebView) → execute arbitrary code → escalate privileges or install malware.

**Android-Specific Risk:** Outdated WebView components (not updated via Play Store); fragmented Android ecosystem (delayed patches).

**Impact:** Remote code execution; device compromise; full app control.

**Example:** A browser vulnerability (Stagefright-like bug); a user visits a malicious site → code executes → device compromised.

**Mitigation:** Keep browsers/WebView updated; use the latest Android version; disable unnecessary browser features; sandbox WebView (`setAllowFileAccess(false)`).

### 1.8 Quick Summary Table

| Attack             | Key Vulnerability                 | Mitigation                              |
| ------------------ | --------------------------------- | --------------------------------------- |
| XSS                | Unsanitized input in WebView      | Disable JS, validate input              |
| CSRF               | Missing anti-CSRF tokens          | Use tokens, validate headers            |
| Phishing           | Fake websites                     | Verify URLs, educate users              |
| Drive-by Downloads | Browser vulnerabilities           | Update browser, disable unknown sources |
| MitB               | Overlay/accessibility permissions | Limit permissions, detect overlays      |
| Malicious Ads      | Third-party ad networks           | Use reputable networks                  |
| Browser Exploits   | Outdated WebView/browser          | Update components, sandbox WebView      |

---

## 2. Network-Based Attacks on Android Devices

Android devices depend heavily on Wi-Fi and mobile networks, making them vulnerable to various network-level attacks.

### 2.1 Man-in-the-Middle (MITM) Attacks

**Definition:** Attacker intercepts communication between the device and server, capturing sensitive data or injecting malicious content.

**Attack Method:** Attacker positions between victim and server, capturing/modifying traffic — often on unsecured/public Wi-Fi networks.

**Android-Specific Risk:** Apps using HTTP instead of HTTPS; apps not validating SSL certificates; public Wi-Fi usage.

**Impact:** Credential theft; session hijacking; data manipulation.

**Mitigation:** HTTPS with proper SSL/TLS validation; certificate pinning; avoid public Wi-Fi for sensitive transactions; use a VPN.

### 2.2 Wi-Fi Eavesdropping

**Definition:** Listening to unencrypted network traffic to steal transmitted data.

**Attack Method:** Attacker uses packet sniffers (Wireshark, tcpdump) to capture unencrypted traffic and extract sensitive information.

**Android-Specific Risk:** Apps sending data in plaintext (HTTP); unencrypted API calls; legacy apps without TLS.

**Impact:** Password theft; personal data exposure; session token interception.

**Mitigation:** Always use HTTPS/TLS; encrypt sensitive data before transmission; use Android's network security config.

### 2.3 Rogue Access Points (Evil Twins)

**Definition:** Fake Wi-Fi access points impersonating legitimate hotspots to lure victims and intercept data.

**Attack Method:** Attacker sets up an AP with the same name as a legitimate network (e.g., "Starbucks_WiFi"); users connect unknowingly; all traffic passes through the attacker's device.

**Android-Specific Risk:** Auto-connect to known networks; no warning for unsecured networks.

**Impact:** Full traffic interception; credential theft; malware distribution.

**Mitigation:** Verify network name with staff; disable auto-connect to Wi-Fi; use a VPN on public networks; check for HTTPS on websites.

### 2.4 DNS Spoofing / Poisoning

**Definition:** Attacker manipulates DNS responses to redirect the device to malicious sites instead of legitimate ones.

**Attack Method:** Corrupts the DNS cache on the device/router; a legitimate domain resolves to a malicious IP; the user thinks they're on the real site.

**Android-Specific Risk:** Apps not validating domain certificates; users not checking URLs; DNS over HTTPS not enforced.

**Impact:** Phishing attacks; malware downloads; credential theft.

**Mitigation:** Use DNS over HTTPS (DoH); validate SSL certificates; use trusted DNS servers (Google DNS, Cloudflare); certificate pinning.

### 2.5 ARP Spoofing / Poisoning

**Definition:** Attacker poisons the ARP cache of devices to intercept network traffic or launch MITM attacks.

**Attack Method:** Attacker sends fake ARP replies, associating their MAC address with a legitimate IP; traffic is redirected through the attacker's device.

**Android-Specific Risk:** Devices on the same local network; no ARP spoofing detection; unencrypted local traffic.

**Impact:** Traffic interception; session hijacking; network-wide compromise.

**Mitigation:** Encrypted protocols (HTTPS, SSH); static ARP entries (enterprise); ARP spoofing detection tools; network segmentation (VLANs).

### 2.6 Session Hijacking over Networks

**Definition:** Capturing session tokens/cookies over unsecured networks to gain unauthorized account access.

**Attack Method:** Sniff unencrypted traffic → extract session cookies/tokens → replay tokens to impersonate the user.

**Android-Specific Risk:** Apps using HTTP for session management; session tokens in URL parameters; no token expiration.

**Impact:** Account takeover; unauthorized transactions; data manipulation.

**Mitigation:** HTTPS for all session-related traffic; secure, HttpOnly cookies; token expiration and rotation; secure session storage.

---

## 3. Social Engineering Attacks on Android Devices

Social engineering exploits human psychology to trick users into compromising security.

### 3.1 Phishing

**Definition:** Emails, SMS (smishing), or messaging apps trick users into clicking malicious links or providing credentials.

**Attack Method:** Fake message from a trusted entity → urgent call-to-action (account suspension, reward) → link leads to a fake login page.

**Android-Specific Risk:** SMS phishing (smishing); messaging apps (WhatsApp, Telegram); small screens make URL verification difficult.

**Impact:** Credential theft; malware installation; financial fraud.

**Mitigation:** Verify sender before clicking links; check URLs carefully; use official apps, not browser links; enable 2FA.

### 3.2 Vishing (Voice Phishing)

**Definition:** Attackers use phone calls to impersonate trusted entities and extract sensitive information.

**Attack Method:** Caller claims to be from a bank/tech support/government; requests OTP, passwords, or personal info; creates urgency to bypass rational thinking.

**Android-Specific Risk:** Caller ID spoofing; trust in phone communication; less awareness than email phishing.

**Impact:** Credential theft; financial fraud; identity theft.

**Mitigation:** Never share OTP/passwords over the phone; verify caller identity independently; hang up and call the official number; report suspicious calls.

### 3.3 Pretexting

**Definition:** Creating a fabricated scenario to gain trust and gather confidential data.

**Attack Method:** Attacker pretends to be a colleague, IT support, or authority; requests sensitive information for "verification"; builds rapport to lower suspicion.

**Android-Specific Risk:** Enterprise apps with sensitive data; employees tricked into sharing credentials; fake IT support requests.

**Impact:** Corporate data breach; credential compromise; unauthorized access.

**Mitigation:** Verify identity through official channels; follow security policies strictly; never share credentials via phone/chat; report suspicious requests.

### 3.4 Baiting

**Definition:** Luring users with promises of freebies, rewards, or exclusive content to install malicious apps or click harmful links.

**Attack Method:** "Free gift card" offers; "exclusive content" downloads; "limited-time offers."

**Android-Specific Risk:** Third-party app stores; pop-up ads in apps; social media promotions.

**Impact:** Malware installation; data theft; device compromise.

**Mitigation:** Download apps only from official stores; avoid "too good to be true" offers; use Play Protect; educate users on baiting tactics.

### 3.5 Quizzes, Surveys, or Fake Offers

**Definition:** Using social platforms or apps to lure users into giving up private information through seemingly harmless activities.

**Attack Method:** "What's your superhero name?" quizzes; surveys asking for personal details; fake contests requiring personal info.

**Android-Specific Risk:** Social media apps (Facebook, Instagram); data-harvesting apps; over-privileged app permissions.

**Impact:** Personal data exposure; identity theft; targeted attacks.

**Mitigation:** Avoid sharing personal info in quizzes; review app permissions; use privacy settings; be skeptical of data requests.

### 3.6 Impersonation on Social Media

**Definition:** Attackers impersonate contacts, friends, or trusted entities to send malicious links or requests.

**Attack Method:** Clone a friend's profile; send a message like "Hey, check this out!"; the link leads to phishing/malware.

**Android-Specific Risk:** Messaging apps (WhatsApp, Telegram); social media platforms; trust in familiar contacts.

**Impact:** Malware spread; credential theft; financial fraud.

**Mitigation:** Verify unusual messages through other channels; don't click suspicious links even from friends; report fake profiles; enable 2FA.

### 3.7 Malicious App Installation through Social Engineering

**Definition:** Convincing users to download apps from unofficial sources that contain malware.

**Attack Method:** Fake "security update" prompts; "premium version free" offers; fake system apps.

**Android-Specific Risk:** Third-party app stores; "Install from Unknown Sources" enabled; users unaware of app authenticity.

**Impact:** Malware installation; data theft; device compromise.

**Mitigation:** Download only from Google Play Store; disable "Install from Unknown Sources"; use Play Protect; check app reviews and permissions.

### 3.8 Summary Table

| Attack Type           | Description                                         | Android-Specific Example                  | Mitigation Strategy                      |
| --------------------- | --------------------------------------------------- | ----------------------------------------- | ---------------------------------------- |
| Web-based Attacks     | Exploits browser or app web components              | XSS in WebView, malicious ads             | Input validation, secure WebViews        |
| Network-based Attacks | Intercept or redirect network traffic               | MITM on public Wi-Fi, rogue access points | Use VPN, SSL pinning, avoid public Wi-Fi |
| Social Engineering    | Manipulates users to reveal info or install malware | Phishing SMS, fake app installs           | User awareness, app permissions review   |

### 3.9 Combined Attack Scenario (Illustrative)

```
1. User connects to rogue Wi-Fi at a cafe (Network-based)
2. Attacker performs MITM and captures HTTP traffic
3. Sends phishing SMS with a fake bank link (Social Engineering)
4. User clicks → enters credentials on the fake site
5. Attacker uses credentials + session token to access the account
6. Installs malicious app via a baiting offer
```

---

---

# Session 25 (3T + 2L + 3SL): Mobile Malware & Android App Analysis

**Topics:** Overview of Mobile Malware | Android App Analysis

---

## 1. Overview of Mobile Malware

**What Is Mobile Malware?**
Mobile malware is malicious software specifically designed to attack mobile devices like smartphones and tablets. These threats can steal sensitive data (credentials, banking info), track user activities and location, send unauthorized messages or make calls, control the device remotely, and encrypt data and demand ransom.

Mobile malware has grown significantly due to the widespread use of smartphones, mobile banking, and the open nature of the Android ecosystem.

### 1.1 Common Types of Mobile Malware

| Type                | Definition                                                              | Characteristics                                                                                                                         | Examples                                                      | Impact                                                                          |
| ------------------- | ----------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Trojans**         | Malicious apps disguised as legitimate software                         | Appears harmless (games, utilities); runs hidden malicious code in background; can steal data, send SMS, or download additional malware | Fake utility apps, counterfeit banking apps, pirated software | Data theft; unauthorized transactions; device compromise                        |
| **Spyware**         | Monitors user activity and sends data to attackers                      | Runs silently in background; tracks keystrokes, calls, messages, location; sends data to a remote C2 server                             | Pegasus spyware, mobile monitoring apps (stalkerware)         | Privacy violations; credential theft; corporate espionage                       |
| **Adware**          | Floods the device with unwanted advertisements                          | Displays excessive pop-up ads; redirects browsers to ad sites; may track browsing habits                                                | Ad-displaying apps, browser hijackers                         | Annoying UX; data collection for targeted ads; battery drain/performance issues |
| **Ransomware**      | Locks device or encrypts data, demanding ransom                         | Displays lock screen with ransom message; encrypts files; demands cryptocurrency payment                                                | Android.Ransom, WannaCry mobile variants                      | Data loss; financial loss; device unusable                                      |
| **Worms**           | Self-replicating malware spreading via SMS, Bluetooth, or infected apps | Automatically propagates to contacts; uses messaging apps/Bluetooth; no user interaction needed after initial infection                 | SMS worms, Bluetooth-propagating malware                      | Rapid spread; network congestion; secondary infections                          |
| **Banking Trojans** | Specialized Trojans targeting financial apps and credentials            | Overlays fake login screens on banking apps; captures OTPs and credentials; initiates unauthorized transactions                         | Cerberus, Anubis, TrickBot mobile variant                     | Financial fraud; account takeover; significant monetary loss                    |
| **Rootkits**        | Gain root access and hide from security software                        | Exploits vulnerabilities to gain root; hides processes/files/network connections; extremely difficult to detect/remove                  | Rooting malware, privilege escalation tools                   | Full device control; persistent infection; complete security bypass             |

### 1.2 Infection Vectors

How mobile malware spreads to devices:

| Vector                          | Description                                                                                             |
| ------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Malicious Apps (Sideloaded)** | Downloaded from third-party app stores; pirated/cracked apps; fake versions of popular apps             |
| **SMS or Email Links**          | Phishing messages with malicious links; smishing (SMS phishing); infected attachments                   |
| **Public Wi-Fi Attacks**        | MITM attacks on unsecured networks; rogue access points (Evil Twins); malicious redirects               |
| **Bluetooth or NFC Exploits**   | Pairing with malicious devices; Blueborne vulnerabilities; NFC-based attacks                            |
| **Fake App Stores**             | Counterfeit Google Play Store; third-party stores with no verification; modified APK distribution sites |
| **Drive-by Downloads**          | Visiting compromised websites; automatic malware download; exploit kits                                 |

### 1.3 Common Malware Capabilities

What mobile malware can do once installed:

| Capability                                 | Description                                                                                             |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| **Keylogging**                             | Records all keystrokes; captures passwords, messages, search queries; sends data to attacker            |
| **SMS Interception**                       | Reads incoming/outgoing messages; captures OTPs and 2FA codes; sends premium SMS (financial fraud)      |
| **Data Exfiltration**                      | Steals contacts, photos, documents; uploads to remote server; sells on dark web                         |
| **Screenshot Capture**                     | Periodically captures screen; monitors app usage; captures sensitive information                        |
| **Command-and-Control (C2) Communication** | Receives instructions from attacker; downloads additional payloads; updates malware capabilities        |
| **Device Location Tracking**               | Tracks GPS coordinates; monitors movement patterns; stalking or corporate espionage                     |
| **Additional Capabilities**                | Camera/microphone activation; call recording; app installation/uninstallation; device locking or wiping |

### 1.4 Mobile Malware Infection Lifecycle

```
1. Delivery         → malware distributed via app, link, or network
2. Installation     → user installs malicious app or clicks link
3. Execution        → malware runs in background
4. Persistence      → ensures it survives reboots
5. C2 Communication → connects to attacker's server
6. Action           → performs malicious activities (data theft, fraud)
7. Cover-up         → hides presence from user and security tools
```

### 1.5 Prevention and Mitigation

**For Users:**

- Download apps only from official stores (Google Play, App Store)
- Keep device and apps updated
- Use mobile security apps (antivirus)
- Avoid clicking suspicious links
- Review app permissions carefully
- Enable Google Play Protect
- Disable "Install from Unknown Sources"

**For Organizations:**

- Implement Mobile Device Management (MDM)
- Enforce app whitelisting
- Conduct security awareness training
- Use network segmentation
- Monitor for suspicious activity

### 1.6 Summary Table

| Malware Type   | Primary Goal                | Infection Method  | Mitigation           |
| -------------- | --------------------------- | ----------------- | -------------------- |
| Trojan         | Data theft, remote control  | Fake apps         | Official app stores  |
| Spyware        | Surveillance                | Malicious apps    | Permission review    |
| Adware         | Ad revenue, data collection | Free apps         | Ad blockers          |
| Ransomware     | Financial extortion         | Infected apps     | Regular backups      |
| Worm           | Self-replication            | SMS, Bluetooth    | Disable auto-connect |
| Banking Trojan | Financial fraud             | Fake banking apps | App verification     |
| Rootkit        | Full control, hiding        | Exploits          | Keep OS updated      |

### 1.7 Real-World Example

```
1. User downloads fake "Battery Saver" app from a third-party store
2. App requests SMS and accessibility permissions
3. Background service runs a keylogger and SMS interceptor
4. Captures banking app credentials and OTP
5. Attacker transfers money from the victim's account
6. Malware sends data to a C2 server
```

---

## 2. Android App Analysis

**What Is Android App Analysis?**
The process of reverse-engineering or examining Android applications (APK files) to understand their behavior, functionality, requested permissions, data handling practices, potentially malicious activities, and security vulnerabilities. Essential for malware analysis, security auditing, vulnerability assessment, and app verification before installation.

### 2.1 Key Tools for Android App Analysis

**APKTool**

- Decompiles APK into readable resources and smali code
- Unpacks APK to resources (XML, images, layouts); converts DEX to Smali (assembly-like code); allows modification and repackaging
- Use cases: analyze `AndroidManifest.xml`; inspect resources/assets; modify app behavior for testing

```bash
apktool d app.apk -o output_folder
apktool b output_folder -o modified_app.apk
```

**JADX**

- Converts APKs/DEX files to readable Java source code
- Decompiles DEX to Java; GUI and CLI versions; search functionality for strings/classes/methods; cross-referencing support
- Use cases: understand app logic; find hardcoded secrets; identify suspicious code patterns

```bash
jadx -d output_folder app.apk
```

**MobSF (Mobile Security Framework)**

- Automated static and dynamic analysis framework
- Static analysis (code review); dynamic analysis (runtime monitoring); malware detection; vulnerability scanning; generates security reports
- Use cases: comprehensive security audits; malware identification; compliance checking

**Frida / Xposed**

- Dynamic instrumentation and runtime modification
- **Frida:** injects JavaScript into running apps; hooks functions and modifies behavior; monitors API calls in real-time
- **Xposed Framework:** module-based framework; modifies system/app behavior without repackaging; requires a rooted device
- Use cases: bypass security checks; monitor runtime behavior; manipulate app logic

**Drozer**

- Security testing and attack framework for Android
- Identifies security vulnerabilities; tests component exposure; exploits common misconfigurations
- Use cases: find exported components; test intent vulnerabilities; attack surface mapping

**ADB (Android Debug Bridge)**

- Interacts with an Android device/emulator for analysis
- Use cases: install/uninstall apps; capture logs (logcat); access device shell; pull/push files; monitor runtime behavior

```bash
adb devices
adb install app.apk
adb logcat
adb shell
adb pull /data/data/package.name/
```

### 2.2 Techniques Used in Android App Analysis

**1. Static Analysis** — analyzing code and resources without executing the app.

- Tools: JADX, APKTool, Androguard
- Steps: decompile the APK; review `AndroidManifest.xml` for permissions, exported components (activities, services, receivers), and intent filters; analyze Smali/Java code for hardcoded secrets (API keys, passwords), suspicious API calls, and obfuscation techniques; inspect resources (layouts, strings)
- Advantages: safe (no execution), comprehensive code review, identifies hidden functionality
- Limitations: cannot detect runtime behavior; obfuscated code is harder to analyze

**2. Dynamic Analysis** — running the app in a controlled environment and monitoring behavior.

- Tools: Frida, Xposed, Burp Suite, Wireshark, ADB logcat
- Steps: install on an emulator/test device; monitor file access, API calls, network traffic, system calls; intercept HTTP/HTTPS requests (Burp Suite); hook functions with Frida/Xposed; capture logs with logcat
- Advantages: observes actual runtime behavior; detects hidden payloads; identifies C2 communication
- Limitations: requires an execution environment; some malware detects emulators

**3. Behavioral Analysis** — observing how the app behaves on a real or emulated device during normal usage.

- Focus areas: permission usage vs. app functionality; network connections (C2 servers, data exfiltration); embedded payloads or obfuscation; sensitive data handling (storage, transmission); runtime behavior (screenshots, recording, keylogging)
- Techniques: monitor network traffic; check file system changes; observe CPU/memory usage; track permission usage

### 2.3 Key Focus Areas in Android App Analysis

| Focus Area                                   | What to Check                                      | Tools                          | Red Flag                                                                                                              |
| -------------------------------------------- | -------------------------------------------------- | ------------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| **Requested Permissions vs Actual Behavior** | Does the app request more permissions than needed? | Manifest review                | Over-privileged apps (e.g., a calculator app requesting SMS and contacts)                                             |
| **Network Connections**                      | Where does the app send data?                      | Burp Suite, Wireshark, tcpdump | Connections to unknown/suspicious servers (C2)                                                                        |
| **Embedded Payloads or Obfuscation**         | Is code obfuscated (ProGuard, custom techniques)?  | JADX, APKTool                  | Heavy obfuscation may hide malicious logic                                                                            |
| **Sensitive Data Handling and Leakage**      | How does the app store/transmit sensitive data?    | Manual review                  | Plain-text storage, unencrypted network traffic, hardcoded credentials, data in SharedPreferences or external storage |
| **Runtime Behavior**                         | What does the app do during execution?             | Frida, Xposed, logcat          | Screenshot capture, keylogging, screen recording, unexpected background services                                      |

### 2.4 Android App Analysis Workflow (Step-by-Step)

```
Phase 1: Static Analysis
  1. Download APK
  2. Decompile with JADX/APKTool
  3. Review AndroidManifest.xml
  4. Analyze permissions and components
  5. Search for suspicious strings (URLs, IPs, API keys)

Phase 2: Dynamic Analysis
  1. Install on emulator/test device
  2. Run app and monitor behavior
  3. Intercept network traffic (Burp Suite)
  4. Hook functions with Frida
  5. Capture logs with logcat

Phase 3: Behavioral Analysis
  1. Observe permission usage
  2. Check file system changes
  3. Monitor network connections
  4. Identify suspicious runtime activities

Phase 4: Reporting
  1. Document findings
  2. Identify vulnerabilities
  3. Provide mitigation recommendations
```

### 2.5 Summary Table

| Technique           | Purpose                        | Tools             | Key Focus                      |
| ------------------- | ------------------------------ | ----------------- | ------------------------------ |
| Static Analysis     | Analyze code without execution | JADX, APKTool     | Permissions, hardcoded secrets |
| Dynamic Analysis    | Monitor runtime behavior       | Frida, Burp Suite | Network traffic, API calls     |
| Behavioral Analysis | Observe app behavior           | ADB, logcat       | Permission usage, data leakage |

### 2.6 Practical Example

**Scenario:** Analyzing a suspicious "Battery Saver" app

```
Static Analysis:
  - Decompile with JADX
  - AndroidManifest.xml requests SMS and contacts permissions
  - Discover a hardcoded URL to an unknown server

Dynamic Analysis:
  - Install on emulator
  - Use Burp Suite to intercept traffic
  - App sends contacts and SMS to an external server

Behavioral Analysis:
  - Monitor with logcat
  - App captures screenshots every 5 minutes
  - Background service runs continuously

Conclusion: Malware stealing user data → Report and remove
```
