DAY4
Theory :

# Task 1 – Recording Terminal Activities Using Script

## Objective
Record all terminal activities performed during a forensic investigation session and save them into a log file for documentation and auditing purposes.
---

# About the `script` Command
The `script` command records everything displayed in the terminal, including commands entered and their output.

### Features

* Records terminal activity.
* Useful for forensic documentation.
* Stores session data in a log file.
* Creates a complete audit trail of actions performed.

---
# Start Recording Session

Create a log file and begin recording:

```bash
script -f /cyberforensics/session4.log
```

### Explanation

* `script` → Starts terminal recording.
* `-f` → Flushes output immediately to the log file.
* `/cyberforensics/session4.log` → Destination log file.

After executing this command, all terminal activities are recorded.

---

# Commands Executed During Recording

## Check System Uptime

```bash
uptime
```

**Purpose:** Displays how long the system has been running along with load averages.

---

## Display Current User

```bash
whoami
```

**Purpose:** Shows the username of the currently logged-in user.

---

## Display Kernel Version

```bash
uname -r
```

**Purpose:** Displays the Linux kernel version.

---

## Display Date and Time Information

```bash
timedatectl
```

**Purpose:** Shows:

* Current date and time
* Time zone
* NTP synchronization status
* RTC information

---

# Stop Recording

```bash
exit
```

**Purpose:** Ends the script recording session and saves the log file.

---

# Viewing the Recorded Log

## View Log with Formatting Preserved

```bash
less -r /cyberforensics/session4.log
```

**Purpose:** Displays the recorded session while preserving terminal formatting.

---

## Display Entire Log

```bash
cat /cyberforensics/session4.log
```

**Purpose:** Prints the complete session log to the terminal.

---

# Workflow

```text
Start Recording
      ↓
script -f /cyberforensics/session4.log
      ↓
Execute Commands
(uptime, whoami, uname -r, timedatectl)
      ↓
exit
      ↓
View Log
(less -r /cyberforensics/session4.log)
      ↓
Display Log
(cat /cyberforensics/session4.log)
```

---

# Key Commands Summary

```bash
script -f /cyberforensics/session4.log

uptime

whoami

uname -r

timedatectl

exit

less -r /cyberforensics/session4.log

cat /cyberforensics/session4.log
```


Task 2

```
2. Memory Capture 

AVML(Acquire volative Memory for linux) - capture the snapshot of linux memory which can be used to identify malicious program 


# Linux Memory Acquisition and Analysis using AVML & Volatility3

## Objective

Acquire a memory dump from a Linux virtual machine using AVML and analyze it using Volatility3.

---

# 1. Disable SELinux

```bash
setenforce 0
```

**Purpose:** Temporarily disables SELinux enforcement to avoid permission-related issues during memory acquisition.

---

# 2. Install AVML

```bash
avml install
```

**Purpose:** Installs Azure Virtual Machine Memory Dumper (AVML).

---

# 3. Give Execute Permission

```bash
chmod +x avml
```

**Purpose:** Makes the AVML binary executable.

---

# 4. Mount VMware Shared Folder

```
First Go to VM setting ==> option add shared directory then execute the following commands 
```

Create the mount directory:

```bash
sudo mkdir -p /mnt/hgfs
```

Mount VMware shared folders:

```bash
sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
```

Verify mounted folders:

```bash
ls /mnt/hgfs
ls /mnt
```

---

# 5. Install VMware Tools (If Shared Folder is Not Working)

Install EPEL repository:

```bash
sudo dnf install -y epel-release
```

Install VMware tools packages:

```bash
sudo dnf install -y open-vm-tools open-vm-tools-desktop fuse3
```

Enable VMware tools service:

```bash
sudo systemctl enable --now vmtoolsd
```

Reboot the system:

```bash
sudo reboot
```

---

# 6. Acquire Memory Dump

Run AVML to capture memory:

```bash
sudo ./avml memory.lime
```

Verify dump creation:

```bash
ls
```

**Output:** `memory.lime`

---

# 7. Transfer Memory Dump to Host Machine

Move the memory image to the shared folder:

```bash
mv memory.lime /mnt/hgfs/D/Cyber\ FOrencis/Evidence/
```

---

# 8. Identify Linux Kernel Version

On the host machine, execute:

```bash
python volatility3-develop/vol.py -f Evidence/memory.lime linux.banners.Banners
```

**Purpose:** Extracts Linux kernel banner information from the memory image.

---

# 9. Volatility Symbol Table Issue

If Volatility displays errors such as:

```text
Unsatisfied requirement
Unable to validate Linux symbol table
```

Then:

1. Note the exact Linux kernel version from `linux.banners.Banners`.
2. Download the corresponding Linux symbol table from the Volatility3 symbols repository.
3. Place the symbol file in the appropriate Volatility symbols directory.
4. Re-run the analysis command.

**Important:** Volatility3 requires the correct symbol table for the kernel version used by the memory image.

---

# 10. List Running Processes

```bash
python volatility3-develop/vol.py -f Evidence/memory.lime linux.pslist
```

### Purpose

Displays active processes linked in the kernel process list.

### Information Obtained

* PID
* PPID
* Process Name
* Start Time

---

# 11. Scan Memory for Processes

```bash
python volatility3-develop/vol.py -f Evidence/memory.lime linux.psscan
```

### Purpose

Scans memory structures directly to locate process objects.

### Information Obtained

* Active Processes
* Hidden Processes
* Terminated Processes still present in memory

---

# Difference Between pslist and psscan

| Feature              | pslist                     | psscan          |
| -------------------- | -------------------------- | --------------- |
| Source               | Active Kernel Process List | Raw Memory Scan |
| Active Processes     | ✅                          | ✅               |
| Hidden Processes     | ❌                          | ✅               |
| Terminated Processes | ❌                          | ✅               |
| Faster               | ✅                          | ❌               |
| Forensic Value       | Medium                     | High            |

---

# Analysis Workflow

```text
Acquire Memory (AVML)
        ↓
Transfer memory.lime
        ↓
Run linux.banners.Banners
        ↓
Download Symbol Table (if required)
        ↓
Run linux.pslist
        ↓
Run linux.psscan
        ↓
Compare Results
        ↓
Identify Hidden/Suspicious Processes
```

---

# Key Commands Summary

```bash
setenforce 0

avml install

chmod +x avml

sudo mkdir -p /mnt/hgfs

sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other

sudo dnf install -y epel-release

sudo dnf install -y open-vm-tools open-vm-tools-desktop fuse3

sudo systemctl enable --now vmtoolsd

sudo reboot

sudo ./avml memory.lime

mv memory.lime /mnt/hgfs/D/Cyber\ FOrencis/Evidence/

python volatility3-develop/vol.py -f Evidence/memory.lime linux.banners.Banners

python volatility3-develop/vol.py -f Evidence/memory.lime linux.pslist

python volatility3-develop/vol.py -f Evidence/memory.lime linux.psscan
```




if error in volatrility vol.py image banners.Banners
download the volatitity symbol table for that particular veriosn from github then only volatility will run 
------------------------------------------------------------------


-----------------

Rocky linux command to disable the selinux 
whaty is the purpose of command ??

set enforce 0
---------------------------------------------------------------------------------------------






