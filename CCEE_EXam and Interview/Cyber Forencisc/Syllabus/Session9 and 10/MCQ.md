# Cyber Forensics (Session 9 & 10) – 100 MCQs with Answers

**Topics:** Live Forensics, Linux Forensics, Mobile Forensics

---

## Live System Forensics (1–35)

### 1.

What is Live Forensics?

* A) Analysis of powered-off systems
* B) Analysis of running systems
* C) Cloud investigation
* D) Database analysis

**Answer: B**

---

### 2.

Which evidence is most volatile?

* A) Hard Disk
* B) Backup Tape
* C) RAM
* D) USB Drive

**Answer: C**

---

### 3.

Which tool is commonly used for memory analysis?

* A) Wireshark
* B) Volatility
* C) Nmap
* D) Nessus

**Answer: B**

---

### 4.

RAM acquisition means:

* A) Formatting memory
* B) Capturing memory contents
* C) Deleting memory
* D) Encrypting memory

**Answer: B**

---

### 5.

Which command lists running processes in Windows?

* A) tasklist
* B) ps
* C) top
* D) who

**Answer: A**

---

### 6.

Which command lists running processes in Linux?

* A) tasklist
* B) ps aux
* C) netstat
* D) route

**Answer: B**

---

### 7.

Which data disappears after shutdown?

* A) Disk Data
* B) Registry
* C) RAM Data
* D) Log Files

**Answer: C**

---

### 8.

What does netstat display?

* A) Users
* B) Files
* C) Network Connections
* D) Registry

**Answer: C**

---

### 9.

Which is NOT volatile data?

* A) Cache
* B) RAM
* C) Running Processes
* D) Hard Disk

**Answer: D**

---

### 10.

What is the first priority during live evidence collection?

* A) Disk Imaging
* B) Collect Volatile Data
* C) Delete Malware
* D) Restart System

**Answer: B**

---

### 11.

DumpIt is used for:

* A) Password Recovery
* B) RAM Acquisition
* C) Network Monitoring
* D) Imaging Disk

**Answer: B**

---

### 12.

FTK Imager can capture:

* A) RAM
* B) Registry
* C) Disk Images
* D) All of these

**Answer: D**

---

### 13.

Which command displays logged-in users in Linux?

* A) who
* B) tasklist
* C) ping
* D) ipconfig

**Answer: A**

---

### 14.

The process tree is displayed using:

* A) pslist
* B) pstree
* C) netstat
* D) hashdump

**Answer: B**

---

### 15.

Live forensics is useful because:

* A) It captures volatile evidence
* B) It formats systems
* C) It hides logs
* D) It encrypts evidence

**Answer: A**

---

### 16.

What is a memory dump?

* A) Deleted file
* B) Copy of RAM
* C) Log file
* D) Registry backup

**Answer: B**

---

### 17.

Which Volatility plugin lists processes?

* A) pslist
* B) netscan
* C) filescan
* D) hashdump

**Answer: A**

---

### 18.

Which plugin displays command-line history?

* A) pstree
* B) cmdline
* C) dlllist
* D) psscan

**Answer: B**

---

### 19.

Which plugin shows DLL information?

* A) dlllist
* B) netscan
* C) pslist
* D) cmdline

**Answer: A**

---

### 20.

Open ports can reveal:

* A) Malware Communication
* B) Installed RAM
* C) BIOS Version
* D) File Ownership

**Answer: A**

---

### 21.

Which is an anti-forensics technique?

* A) Logging
* B) Hashing
* C) Rootkits
* D) Imaging

**Answer: C**

---

### 22.

Which evidence may contain encryption keys?

* A) RAM
* B) Hard Disk
* C) Printer
* D) Monitor

**Answer: A**

---

### 23.

The chain of custody ensures:

* A) Evidence integrity
* B) Faster internet
* C) Disk formatting
* D) Password storage

**Answer: A**

---

### 24.

Hash values are used to:

* A) Encrypt files
* B) Verify integrity
* C) Delete data
* D) Compress evidence

**Answer: B**

---

### 25.

Which tool captures RAM?

* A) WinPMEM
* B) Nmap
* C) Burp Suite
* D) Hydra

**Answer: A**

---

### 26.

Network sessions are found in:

* A) RAM
* B) Keyboard
* C) BIOS
* D) CMOS

**Answer: A**

---

### 27.

Volatility analyzes:

* A) Memory Images
* B) Databases
* C) Routers
* D) Firewalls

**Answer: A**

---

### 28.

A reverse shell is usually identified through:

* A) Network Connections
* B) Wallpapers
* C) Printer Logs
* D) USB Names

**Answer: A**

---

### 29.

Which is collected before disk imaging?

* A) RAM
* B) Backup
* C) Documentation
* D) Report

**Answer: A**

---

### 30.

Volatile evidence includes:

* A) Registry
* B) Running Processes
* C) Documents
* D) Emails

**Answer: B**

---

### 31.

The order of volatility begins with:

* A) Hard Disk
* B) CPU Registers
* C) Logs
* D) Backup Media

**Answer: B**

---

### 32.

A suspicious process may indicate:

* A) Malware
* B) Backup
* C) Antivirus
* D) Patch Update

**Answer: A**

---

### 33.

Which command shows active connections in Windows?

* A) netstat -ano
* B) dir
* C) taskkill
* D) chkdsk

**Answer: A**

---

### 34.

Memory analysis helps identify:

* A) Running Malware
* B) Wallpaper
* C) BIOS Password
* D) Printer Ink

**Answer: A**

---

### 35.

Live forensics should be performed:

* A) Before shutdown
* B) After formatting
* C) After deleting logs
* D) Never

**Answer: A**

---

# Linux Forensics (36–75)

### 36.

Linux user account information is stored in:

* A) /etc/passwd
* B) /etc/shadow
* C) /boot
* D) /var

**Answer: A**

### 37.

Password hashes are stored in:

* A) /etc/shadow
* B) /etc/passwd
* C) /home
* D) /tmp

**Answer: A**

### 38.

Which file stores command history?

* A) .bash_history
* B) syslog
* C) boot.log
* D) passwd

**Answer: A**

### 39.

Authentication logs are stored in:

* A) auth.log
* B) passwd
* C) hosts
* D) profile

**Answer: A**

### 40.

The Linux root user's home directory is:

* A) /root
* B) /home/root
* C) /admin
* D) /sys

**Answer: A**

### 41.

Which directory stores logs?

* A) /var/log
* B) /tmp
* C) /boot
* D) /opt

**Answer: A**

### 42.

Which command displays login history?

* A) last
* B) ping
* C) pwd
* D) cat

**Answer: A**

### 43.

Current users can be viewed using:

* A) who
* B) ps
* C) top
* D) ls

**Answer: A**

### 44.

Which command shows open files?

* A) lsof
* B) ls
* C) stat
* D) pwd

**Answer: A**

### 45.

Which filesystem is commonly used by Linux?

* A) FAT32
* B) NTFS
* C) EXT4
* D) exFAT

**Answer: C**

---

### 46–75 Quick MCQs

46. EXT4 is a Linux → **Filesystem (A)**
47. /home stores → **User Data (B)**
48. /etc stores → **Configuration Files (A)**
49. ps aux displays → **Processes (C)**
50. ss -tulnp displays → **Open Ports (D)**
51. stat command shows → **MAC Times (A)**
52. M in MAC means → **Modified (B)**
53. A in MAC means → **Accessed (C)**
54. C in MAC means → **Changed (D)**
55. Sleuth Kit is used for → **Filesystem Analysis (A)**
56. Autopsy is → **GUI Forensic Tool (B)**
57. Foremost performs → **File Carving (C)**
58. Scalpel is used for → **Recovery (D)**
59. TestDisk recovers → **Partitions (A)**
60. syslog contains → **System Logs (B)**
61. kern.log contains → **Kernel Logs (C)**
62. boot.log contains → **Boot Information (D)**
63. UID means → **User Identifier (A)**
64. Linux logs are mainly in → **/var/log (B)**
65. Hidden files start with → **Dot (C)**
66. passwd file contains → **User Accounts (D)**
67. shadow file contains → **Password Hashes (A)**
68. top command shows → **Running Processes (B)**
69. Forensic timeline uses → **MAC Times (C)**
70. Bash history helps identify → **Executed Commands (D)**
71. Root user ID is → **0 (A)**
72. Linux forensic acquisition begins with → **Volatile Data (B)**
73. Deleted file recovery tool → **Foremost (C)**
74. Open network sockets → **ss (D)**
75. Most critical Linux artifact → **auth.log (A)**

---

# Mobile Forensics (76–100)

### 76.

Mobile forensics focuses on:

* A) Routers
* B) Smartphones
* C) Switches
* D) Printers

**Answer: B**

### 77.

Best acquisition method is:

* A) Manual
* B) Logical
* C) Physical
* D) Visual

**Answer: C**

### 78.

Physical acquisition creates:

* A) Summary Report
* B) Bit-by-bit Copy
* C) Screenshot
* D) Log File

**Answer: B**

### 79.

Logical acquisition generally cannot recover:

* A) Contacts
* B) SMS
* C) Deleted Data
* D) Call Logs

**Answer: C**

### 80.

Cellebrite UFED is:

* A) Mobile Forensic Tool
* B) Antivirus
* C) Browser
* D) Firewall

**Answer: A**

---

### 81–100 Quick MCQs

81. Oxygen Forensics is → **Mobile Tool (A)**
82. Magnet AXIOM performs → **Artifact Analysis (B)**
83. MOBILedit is used for → **Mobile Extraction (C)**
84. Andriller focuses on → **Android Forensics (D)**
85. GPS data provides → **Location Information (A)**
86. SIM stores → **IMSI (B)**
87. ICCID identifies → **SIM Card (C)**
88. SMS evidence includes → **Messages (D)**
89. Call logs contain → **Incoming/Outgoing Calls (A)**
90. WhatsApp data is → **Mobile Artifact (B)**
91. Browser history reveals → **Visited Websites (C)**
92. Cloud storage is a → **Forensic Challenge (D)**
93. Remote wipe can → **Destroy Evidence (A)**
94. Device encryption protects → **Stored Data (B)**
95. Mobile acquisition occurs after → **Preservation (C)**
96. Examination follows → **Acquisition (D)**
97. Reporting is the → **Final Step (A)**
98. Tablet forensics is part of → **Mobile Forensics (B)**
99. Android stores data mainly in → **SQLite Databases (C)**
100. The primary goal of mobile forensics is → **Evidence Recovery and Analysis (D)**

---

## High-Probability Exam MCQs

1. Volatility analyzes → **Memory Dumps**
2. Most volatile evidence → **CPU Registers**
3. Linux password hashes → **/etc/shadow**
4. Command history → **.bash_history**
5. Open files command → **lsof**
6. Mobile physical acquisition → **Bit-by-Bit Copy**
7. SIM identifier → **ICCID**
8. GPS artifact provides → **Location**
9. TestDisk recovers → **Partitions**
10. Cellebrite UFED is used for → **Mobile Forensics**
