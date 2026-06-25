# Android Architecture, File Structure, Build Process, App Fundamentals, Security Model & Device Rooting

## Complete Exam Notes (Placement + University + Viva)

---

# 1. Introduction to Android Architecture

## What is Android?

Android is an open-source mobile operating system developed by Google based on the Linux Kernel.

Used in:

* Smartphones
* Tablets
* Smart TVs
* Wearables
* Automotive Systems
* IoT Devices

### Features

* Open Source
* Multi-tasking
* Rich UI
* Security Framework
* Application Sandbox
* Hardware Support
* Large Developer Ecosystem

---

# Android Architecture Layers

Android follows a layered architecture.

```text
Applications
↑
Application Framework
↑
Android Runtime (ART) + Native Libraries
↑
Hardware Abstraction Layer (HAL)
↑
Linux Kernel
```

---

## Layer 1: Linux Kernel

Foundation of Android.

Responsibilities:

* Process Management
* Memory Management
* Device Drivers
* Security
* Power Management
* Networking

### Drivers Managed

* Camera
* Bluetooth
* Wi-Fi
* USB
* Audio
* Display

### Exam Point

Android is NOT Linux.

Android uses Linux Kernel as its core.

---

## Layer 2: Hardware Abstraction Layer (HAL)

Acts as bridge between hardware and software.

Example:

```text
Camera App
↓
Camera API
↓
HAL
↓
Camera Hardware
```

Benefits:

* Hardware independence
* Easier device support

---

## Layer 3: Native Libraries

Written mainly in C/C++.

Important Libraries:

| Library         | Purpose        |
| --------------- | -------------- |
| SQLite          | Database       |
| OpenGL ES       | Graphics       |
| WebKit          | Browser Engine |
| SSL             | Security       |
| Media Framework | Audio/Video    |
| Surface Manager | Display        |

---

## Layer 4: Android Runtime (ART)

ART = Android Runtime

Older Android versions used Dalvik VM.

### Functions

* Executes Applications
* Memory Management
* Garbage Collection
* JIT Compilation
* AOT Compilation

### JIT

Just-In-Time Compilation

Compile while running.

### AOT

Ahead-Of-Time Compilation

Compile before execution.

Benefits:

* Faster Apps
* Better Battery Life

---

## Layer 5: Application Framework

Provides APIs for developers.

Major Components:

| Component            | Purpose            |
| -------------------- | ------------------ |
| Activity Manager     | Activity Lifecycle |
| Window Manager       | Screen Windows     |
| Package Manager      | App Installation   |
| Resource Manager     | Resources          |
| Notification Manager | Notifications      |
| Location Manager     | GPS                |

---

## Layer 6: Applications

User-facing applications.

Examples:

* Phone
* Chrome
* WhatsApp
* Camera
* Gmail

---

# Android Architecture Diagram

```text
+---------------------+
| Applications        |
+---------------------+
| Application Framework|
+---------------------+
| ART + Libraries     |
+---------------------+
| HAL                 |
+---------------------+
| Linux Kernel        |
+---------------------+
```

---

# 2. Android File Structure

Android uses Linux-style filesystem.

Root Directory:

```text
/
```

---

## Important Directories

### /system

Contains Android OS files.

```text
/system/app
/system/bin
/system/lib
```

---

### /data

Stores user data.

```text
/data/data
/data/app
```

Contains:

* Installed apps
* User databases
* Preferences

---

### /cache

Temporary files.

Used for:

* Updates
* Cached data

---

### /sdcard

External storage.

Stores:

* Images
* Videos
* Downloads

---

### /vendor

Device-specific files.

Contains:

* Drivers
* Hardware libraries

---

### /proc

Virtual filesystem.

Contains:

* Running processes
* System information

---

### /dev

Device files.

Examples:

```text
/dev/camera
/dev/input
```

---

## App Internal Structure

After installation:

```text
/data/data/package_name/
```

Contains:

```text
files/
cache/
shared_prefs/
databases/
```

---

# Android Application Project Structure

```text
app/
├── manifests
│   └── AndroidManifest.xml
├── java/
├── res/
├── assets/
└── Gradle Scripts
```

---

## AndroidManifest.xml

Most important file.

Contains:

* App permissions
* Activities
* Services
* Receivers
* Package name

Example:

```xml
<uses-permission android:name=
"android.permission.INTERNET"/>
```

---

## res Folder

Stores resources.

### drawable

Images

### layout

UI Layout XML

### values

Strings and Colors

### mipmap

Launcher Icons

---

## assets Folder

Raw files.

Examples:

```text
PDF
HTML
JSON
```

---

# 3. Android Build Process

Converts source code into APK.

---

## Build Steps

### Step 1: Source Code

```java
MainActivity.java
```

---

### Step 2: Resource Compilation

XML resources compiled.

Tool:

```text
AAPT
```

(Android Asset Packaging Tool)

---

### Step 3: Java Compilation

```text
.java → .class
```

---

### Step 4: DEX Conversion

```text
.class → classes.dex
```

DEX = Dalvik Executable

Tool:

```text
D8
```

---

### Step 5: Packaging

Combine:

* Manifest
* Resources
* DEX

into APK.

---

### Step 6: Signing

APK must be digitally signed.

Types:

### Debug Key

Testing

### Release Key

Production

---

### Step 7: Zipalign

Optimizes APK.

---

### Step 8: Installation

APK installed using Package Manager.

---

## APK Structure

```text
app.apk
├── AndroidManifest.xml
├── classes.dex
├── resources.arsc
├── assets/
├── res/
└── META-INF/
```

---

# 4. Android App Fundamentals

Android application consists of components.

---

## Activity

Represents UI Screen.

Example:

```text
Login Screen
Home Screen
```

Lifecycle:

```text
onCreate()
onStart()
onResume()
onPause()
onStop()
onDestroy()
```

### Memory Trick

Create → Start → Resume → Pause → Stop → Destroy

---

## Service

Runs in background.

Examples:

* Music Player
* Sync Service

Types:

* Foreground Service
* Background Service

---

## Broadcast Receiver

Receives system events.

Examples:

```text
Battery Low
WiFi Connected
SMS Received
```

---

## Content Provider

Shares data.

Examples:

* Contacts
* Media Store

Uses URI.

Example:

```text
content://contacts
```

---

## Intent

Communication mechanism.

### Explicit Intent

Specific component.

### Implicit Intent

General action.

Example:

```java
ACTION_VIEW
```

---

# Android Activity Lifecycle

Important Exam Question

```text
onCreate()
↓
onStart()
↓
onResume()
↓
Running
↓
onPause()
↓
onStop()
↓
onDestroy()
```

---

# 5. Android Security Model

Android follows a defense-in-depth approach.

---

## Security Goals

* Confidentiality
* Integrity
* Availability

(CIA Triad)

---

## Linux User Isolation

Every app gets:

```text
Unique UID
```

Apps cannot access each other's data.

---

## Application Sandbox

Each app runs in separate sandbox.

Benefits:

* Isolation
* Malware Prevention
* Data Protection

---

## Permission Model

Apps require permissions.

Examples:

```text
CAMERA
LOCATION
CONTACTS
SMS
```

---

## Types of Permissions

### Normal

Low risk.

Examples:

```text
Internet
Wallpaper
```

---

### Dangerous

User approval required.

Examples:

```text
Camera
Location
Contacts
```

---

## Runtime Permissions

Introduced from Android 6.

Permission requested while app runs.

Example:

```text
Allow Camera Access?
```

---

## Application Signing

Every APK must be signed.

Benefits:

* Authenticity
* Integrity
* Updates Verification

---

## Secure IPC

Inter Process Communication secured using:

* Binder
* Permissions
* UID Checking

---

## SELinux

Security Enhanced Linux.

Introduced for mandatory access control.

Benefits:

* Restricts unauthorized actions
* Limits damage from compromised apps

---

## Verified Boot

Checks integrity during startup.

Ensures:

* OS not modified
* Trusted boot process

---

## Encryption

Protects stored data.

Types:

### Full Disk Encryption

Entire device encrypted.

### File-Based Encryption

Individual files encrypted.

---

## Google Play Protect

Scans applications.

Functions:

* Malware Detection
* Risk Analysis
* App Verification

---

# Android Security Threats

### Malware

Malicious applications.

### Spyware

Steals information.

### Rootkits

Gain privileged access.

### Ransomware

Locks device.

### Phishing Apps

Fake applications stealing credentials.

---

# 6. Device Rooting

## What is Rooting?

Process of obtaining root (administrator) privileges on Android device.

Equivalent to Linux root user.

---

## Why Root?

* Remove bloatware
* Install custom ROMs
* Advanced customization
* Full file access
* Security testing

---

## Root Access

```text
Normal User
↓
Restricted Access

Root User
↓
Full Access
```

---

## Rooting Methods

### Bootloader Unlocking

Unlock device bootloader.

---

### Custom Recovery

Examples:

* TWRP
* OrangeFox

---

### Magisk Rooting

Popular modern rooting method.

Features:

* Systemless Root
* Module Support
* Hide Root

---

## Advantages of Rooting

| Advantage        | Description              |
| ---------------- | ------------------------ |
| Full Control     | Access all files         |
| Remove Bloatware | Delete preinstalled apps |
| Custom ROMs      | Install modified OS      |
| Better Backup    | Full backups             |
| Advanced Tools   | Pentesting utilities     |

---

## Disadvantages of Rooting

| Disadvantage       | Description              |
| ------------------ | ------------------------ |
| Warranty Void      | Manufacturer issues      |
| Security Risk      | Malware gets root access |
| Bootloops          | Device may fail to boot  |
| Banking Apps Fail  | Root detection           |
| OTA Updates Issues | Update failures          |

---

# Rooting Security Risks

### Privilege Escalation

Malware gains root access.

---

### System Tampering

OS files modified.

---

### Weakened Sandbox

Application isolation reduced.

---

### Data Theft

Sensitive information exposed.

---

# Root Detection Methods

Developers often detect rooting using:

* su binary
* Magisk detection
* Root management apps
* Modified boot image
* SafetyNet / Integrity checks

---

# Viva Questions

1. What is Android Runtime?
2. Difference between ART and Dalvik?
3. What is HAL?
4. What is APK?
5. What is DEX?
6. What is Manifest file?
7. What is Intent?
8. What is Activity Lifecycle?
9. What is Android Sandbox?
10. What is SELinux?
11. What is Verified Boot?
12. What is rooting?
13. Difference between rooting and bootloader unlocking?
14. What is Play Protect?
15. Why does Android use permissions?

---

# Important Exam Points (Must Remember)

✅ Android is based on Linux Kernel

✅ ART replaced Dalvik

✅ APK contains classes.dex

✅ Manifest defines permissions and components

✅ Four Core Components:

* Activity
* Service
* Broadcast Receiver
* Content Provider

✅ Every app runs with a unique UID

✅ Android uses application sandboxing

✅ SELinux provides Mandatory Access Control

✅ Verified Boot checks OS integrity

✅ Rooting grants administrator privileges

✅ Magisk provides systemless root

✅ Runtime permissions introduced in Android 6

---

# MCQs (30 Important)

### 1. Android is based on:

A) Windows
B) Linux Kernel ✅
C) Unix
D) DOS

---

### 2. Android Runtime currently uses:

A) JVM
B) ART ✅
C) CLR
D) Python VM

---

### 3. DEX stands for:

A) Data Execution
B) Dalvik Executable ✅
C) Device Execution
D) Dynamic Extension

---

### 4. APK stands for:

A) Android Package Kit ✅
B) Android Programming Kit
C) App Package Kernel
D) Android Permission Key

---

### 5. Manifest file stores:

A) Images
B) Permissions and Components ✅
C) Videos
D) Databases

---

### 6. Activity represents:

A) Background task
B) UI Screen ✅
C) Database
D) Driver

---

### 7. Background execution is handled by:

A) Activity
B) Service ✅
C) Intent
D) Receiver

---

### 8. Android sandbox provides:

A) Networking
B) Isolation ✅
C) UI
D) Storage

---

### 9. SELinux provides:

A) UI Management
B) Mandatory Access Control ✅
C) Graphics
D) Backup

---

### 10. Rooting provides:

A) User Access
B) Administrator Access ✅
C) Guest Access
D) Network Access

---

### 11–30 Quick Answers

11. Linux Kernel manages → Drivers ✅
12. HAL stands for → Hardware Abstraction Layer ✅
13. SQLite is used for → Database ✅
14. APK must be → Signed ✅
15. Play Protect scans → Malware ✅
16. UID means → Unique User ID ✅
17. Intent used for → Communication ✅
18. Boot integrity checked by → Verified Boot ✅
19. Runtime permissions introduced in → Android 6 ✅
20. Contacts data shared using → Content Provider ✅
21. Foreground music app uses → Service ✅
22. Resources stored in → res folder ✅
23. Raw files stored in → assets folder ✅
24. Launcher icons stored in → mipmap ✅
25. Images stored in → drawable ✅
26. XML layouts stored in → layout folder ✅
27. Temporary data stored in → cache ✅
28. App databases stored in → databases folder ✅
29. Magisk provides → Systemless Root ✅
30. ART improves → Performance and Battery ✅

---

# Last-Minute Revision Sheet (1 Minute Before Exam)

```text
Android = Linux Kernel + HAL + ART + Framework + Apps

Core Components:
Activity
Service
Broadcast Receiver
Content Provider

APK:
Manifest
classes.dex
res
assets

Security:
UID
Sandbox
Permissions
SELinux
Verified Boot
Encryption

Rooting:
Administrator Access
Magisk
Custom ROM
Security Risks

ART > Dalvik
DEX = Dalvik Executable
APK = Android Package Kit
```

These notes cover the full syllabus topics typically asked in university exams, practical vivas, placements, and Android security fundamentals.


# Android Architecture, File Structure, Build Process, App Fundamentals, Security Model & Rooting

# 100 MCQs with Answers

---

## Android Architecture

### 1. Android is based on which kernel?

A) Windows Kernel
B) Linux Kernel ✅
C) Unix Kernel
D) Solaris Kernel

---

### 2. Which layer is at the bottom of Android Architecture?

A) Applications
B) Framework
C) Linux Kernel ✅
D) Runtime

---

### 3. HAL stands for:

A) Hardware Access Layer
B) Hardware Abstraction Layer ✅
C) High Access Layer
D) Hybrid Application Layer

---

### 4. Android Runtime currently uses:

A) JVM
B) Dalvik
C) ART ✅
D) CLR

---

### 5. ART stands for:

A) Android Runtime ✅
B) Android Resource Tool
C) Application Runtime Tool
D) Android Rendering Tool

---

### 6. Which runtime was used before ART?

A) JVM
B) Dalvik VM ✅
C) Hyper-V
D) KVM

---

### 7. SQLite belongs to:

A) Kernel
B) Native Libraries ✅
C) Application Layer
D) HAL

---

### 8. OpenGL ES is used for:

A) Networking
B) Graphics Rendering ✅
C) Security
D) Storage

---

### 9. WebKit is mainly used for:

A) Database
B) Browser Engine ✅
C) Security
D) Kernel

---

### 10. Which layer provides APIs to developers?

A) Framework Layer ✅
B) HAL
C) Kernel
D) Hardware

---

## Android File Structure

### 11. User-installed applications are stored in:

A) /system
B) /data/app ✅
C) /cache
D) /vendor

---

### 12. Android operating system files are mainly stored in:

A) /system ✅
B) /cache
C) /data
D) /tmp

---

### 13. Temporary files are stored in:

A) /cache ✅
B) /system
C) /boot
D) /etc

---

### 14. Device-specific drivers are usually located in:

A) /vendor ✅
B) /cache
C) /sdcard
D) /tmp

---

### 15. External storage is commonly represented as:

A) /proc
B) /vendor
C) /sdcard ✅
D) /boot

---

### 16. Process information is available under:

A) /proc ✅
B) /tmp
C) /cache
D) /dev

---

### 17. Shared preferences are stored in:

A) shared_prefs ✅
B) cache
C) drawable
D) mipmap

---

### 18. AndroidManifest.xml contains:

A) Images
B) Permissions and Components ✅
C) Videos
D) Databases

---

### 19. Launcher icons are stored in:

A) drawable
B) layout
C) mipmap ✅
D) values

---

### 20. UI layouts are stored in:

A) drawable
B) layout ✅
C) values
D) assets

---

## Android Build Process

### 21. APK stands for:

A) Android Package Kit ✅
B) Android Permission Key
C) Application Package Key
D) Android Package Kernel

---

### 22. AAPT stands for:

A) Android Asset Packaging Tool ✅
B) Android Application Processing Tool
C) Application Packaging Tool
D) Android Package Testing

---

### 23. Java source files are first compiled into:

A) APK
B) .class files ✅
C) DEX
D) XML

---

### 24. DEX stands for:

A) Dynamic Execution
B) Dalvik Executable ✅
C) Device Execution
D) Data Extension

---

### 25. Which tool converts .class files into DEX?

A) GCC
B) D8 ✅
C) APKTool
D) Nmap

---

### 26. APK signing ensures:

A) Compression
B) Authenticity and Integrity ✅
C) Faster Execution
D) Networking

---

### 27. Debug signing key is used for:

A) Production Apps
B) Testing Apps ✅
C) Rooting
D) Recovery

---

### 28. Release key is used for:

A) Development
B) Testing
C) Production Deployment ✅
D) Recovery

---

### 29. Zipalign is used for:

A) Security
B) Optimization ✅
C) Rooting
D) Networking

---

### 30. classes.dex contains:

A) Images
B) Compiled App Code ✅
C) Resources
D) Certificates

---

## Android App Fundamentals

### 31. Which component represents a screen?

A) Service
B) Activity ✅
C) Receiver
D) Provider

---

### 32. Which component runs in background?

A) Activity
B) Service ✅
C) Intent
D) Layout

---

### 33. Broadcast Receiver handles:

A) Database
B) Events ✅
C) UI
D) Graphics

---

### 34. Content Provider is used for:

A) Data Sharing ✅
B) Encryption
C) UI
D) Drivers

---

### 35. Activity lifecycle starts with:

A) onResume
B) onPause
C) onCreate ✅
D) onDestroy

---

### 36. Activity becomes interactive in:

A) onResume ✅
B) onPause
C) onStop
D) onDestroy

---

### 37. Activity enters background in:

A) onPause ✅
B) onCreate
C) onResume
D) onStart

---

### 38. Activity is completely hidden in:

A) onStop ✅
B) onCreate
C) onResume
D) onStart

---

### 39. Explicit Intent targets:

A) Specific Component ✅
B) Any App
C) Network
D) Database

---

### 40. Implicit Intent specifies:

A) Component Name
B) Action to Perform ✅
C) UID
D) Package Name

---

## Android Security Model

### 41. Android security follows:

A) CIA Triad ✅
B) AAA
C) CRUD
D) SDLC

---

### 42. CIA stands for:

A) Confidentiality, Integrity, Availability ✅
B) Control, Integrity, Access
C) Confidentiality, Identification, Access
D) None

---

### 43. Every Android app gets:

A) Same UID
B) Unique UID ✅
C) Root Access
D) Shared Process

---

### 44. Android applications run inside:

A) Sandbox ✅
B) Hypervisor
C) Container
D) Emulator

---

### 45. Sandbox provides:

A) Isolation ✅
B) Faster Processing
C) Networking
D) Backup

---

### 46. Dangerous permissions require:

A) Runtime Approval ✅
B) Root Access
C) Reboot
D) Recovery Mode

---

### 47. Camera permission is:

A) Normal
B) Dangerous ✅
C) System
D) Signature

---

### 48. Location permission is:

A) Dangerous ✅
B) Normal
C) Root
D) Vendor

---

### 49. Runtime permissions were introduced in:

A) Android 4
B) Android 5
C) Android 6 ✅
D) Android 7

---

### 50. SELinux provides:

A) MAC ✅
B) DAC
C) VPN
D) NAT

---

### 51. SELinux stands for:

A) Security Enhanced Linux ✅
B) Secure Linux
C) System Enhanced Linux
D) Service Linux

---

### 52. Verified Boot checks:

A) OS Integrity ✅
B) Storage
C) Camera
D) Network

---

### 53. Play Protect scans:

A) Malware ✅
B) Images
C) SMS
D) GPS

---

### 54. APKs must be:

A) Signed ✅
B) Encrypted
C) Compressed
D) Decompiled

---

### 55. Binder is used for:

A) IPC ✅
B) Graphics
C) Storage
D) Networking

---

## Device Rooting

### 56. Rooting provides:

A) Guest Access
B) Root Privileges ✅
C) User Access
D) Read-only Access

---

### 57. Root user is equivalent to:

A) Guest
B) Administrator ✅
C) Operator
D) User

---

### 58. Popular modern rooting solution:

A) Metasploit
B) Magisk ✅
C) Wireshark
D) Nmap

---

### 59. Magisk provides:

A) Systemless Root ✅
B) Antivirus
C) Emulator
D) Firewall

---

### 60. Rooting may:

A) Improve Security
B) Increase Risk ✅
C) Disable Apps
D) Remove Kernel

---

### 61. Rooting can void:

A) Battery
B) Warranty ✅
C) Storage
D) RAM

---

### 62. Custom recovery example:

A) TWRP ✅
B) APKTool
C) Gradle
D) ART

---

### 63. Root access allows:

A) Full File Access ✅
B) Limited Access
C) Guest Access
D) Temporary Access

---

### 64. Banking apps often block:

A) Rooted Devices ✅
B) Wi-Fi
C) Bluetooth
D) Camera

---

### 65. Bootloader unlocking is commonly required before:

A) Rooting ✅
B) Browsing
C) Calling
D) Messaging

---

## Mixed Important Questions

### 66. Android is primarily written using:

A) Java/Kotlin ✅
B) COBOL
C) Pascal
D) BASIC

### 67. Database used in Android:

A) Oracle
B) SQL Server
C) SQLite ✅
D) MongoDB

### 68. Notification management is handled by:

A) Notification Manager ✅
B) Package Manager
C) Activity Manager
D) Window Manager

### 69. Package installation is handled by:

A) Package Manager ✅
B) Service Manager
C) Resource Manager
D) Boot Manager

### 70. GPS services are managed by:

A) Window Manager
B) Location Manager ✅
C) Package Manager
D) Service Manager

### 71. Which folder contains images?

A) drawable ✅
B) values
C) assets
D) java

### 72. Which folder stores strings.xml?

A) values ✅
B) layout
C) mipmap
D) assets

### 73. Which file identifies app permissions?

A) AndroidManifest.xml ✅
B) build.gradle
C) strings.xml
D) styles.xml

### 74. Which manager handles activities?

A) Activity Manager ✅
B) Package Manager
C) Window Manager
D) Resource Manager

### 75. Android apps are packaged as:

A) EXE
B) APK ✅
C) MSI
D) BIN

### 76. ART improves:

A) Performance ✅
B) Screen Size
C) Storage
D) Camera

### 77. Full Disk Encryption protects:

A) Entire Storage ✅
B) RAM
C) CPU
D) GPU

### 78. File Based Encryption protects:

A) Individual Files ✅
B) Entire Kernel
C) Drivers
D) Processes

### 79. Malware with root privileges is especially:

A) Dangerous ✅
B) Useful
C) Harmless
D) Temporary

### 80. Android uses Linux permissions for:

A) Security ✅
B) Gaming
C) Graphics
D) Browsing

---

## One-Liner MCQs (81–100)

81. Android app communication uses → Intent ✅

82. SMS received event handled by → Broadcast Receiver ✅

83. Contacts sharing uses → Content Provider ✅

84. Android's predecessor runtime → Dalvik VM ✅

85. Kernel manages memory → Yes ✅

86. APK contains classes.dex → Yes ✅

87. Rooting removes sandbox protections partially → Yes ✅

88. Android is open source → Yes ✅

89. Native libraries mainly written in C/C++ → Yes ✅

90. ART supports AOT compilation → Yes ✅

91. Android 6 introduced runtime permissions → Yes ✅

92. Unique UID isolates applications → Yes ✅

93. Verified Boot protects startup process → Yes ✅

94. Play Protect detects malware → Yes ✅

95. Magisk modules extend functionality → Yes ✅

96. Rootkits seek privileged access → Yes ✅

97. Foreground music app uses Service → Yes ✅

98. Resources are compiled during build process → Yes ✅

99. Debug key should not be used for production → Yes ✅

100. Android Security Model relies on sandboxing and permissions → Yes ✅

# Most Repeated University Exam MCQs

⭐ Linux Kernel is the foundation of Android
⭐ ART replaced Dalvik VM
⭐ DEX = Dalvik Executable
⭐ APK = Android Package Kit
⭐ AndroidManifest.xml stores permissions
⭐ Four Components = Activity, Service, Broadcast Receiver, Content Provider
⭐ Every App gets Unique UID
⭐ SELinux = Security Enhanced Linux
⭐ Verified Boot checks OS integrity
⭐ Magisk = Systemless Rooting

These 100 MCQs cover nearly all commonly asked questions from Android Architecture, Android Security, Mobile Security, Android Development, Cyber Security, and Digital Forensics examinations.
