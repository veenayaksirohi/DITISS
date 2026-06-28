Based on your notes, the practical is about **OSSIM SIEM + OSSEC HIDS** to detect an **SSH brute-force attack**. Below is the corrected **end-to-end flow** in the proper order.

---

# OSSIM + OSSEC Practical Flow

## Machines Used

| Machine               | Purpose                                 | Example IP     |
| --------------------- | --------------------------------------- | -------------- |
| OSSIM Server (SIEM)   | Collects and displays security events   | 192.168.129.100 |
| Linux Server (Victim) | Runs OSSEC Agent and SSH service        | 192.168.129.133  |
| Attacker Machine      | Performs SSH brute-force/login attempts | Any machine    |


```
[Host Machine]
   ↓
OSSEC Agent → Collects logs, monitors files, detects rootkits
   ↓
OSSEC Manager → Aggregates alerts/events
   ↓
OSSIM SIEM → Correlates with Snort (network IDS), OpenVAS (vuln scans),
              Nagios (availability), Nmap (discovery)
   ↓
Security Dashboard → Centralized monitoring & incident response
```

---

# Step 1: Create OSSIM Virtual Machine

Minimum Requirements

* CPU : 2 Core
* RAM : 8 GB
* HDD : 50 GB
* Intel E1000 Network Adapter

Assign Static IP

```
IP Address : 192.168.80.101
Subnet Mask : 255.255.255.0
Gateway : 192.168.80.2
DNS : 192.168.80.2
```

---

# Step 2: Login to OSSIM

Open browser

```
https://192.168.80.101
```

Default Login

```
Username : admin
Password : sunbeam
```

---

# Step 3: Complete OSSIM Wizard

Wizard

```
Start
↓

Next
↓

Scan
↓

Next
↓

Next
↓

Skip
↓

Skip
↓

Finish
```

After setup

```
Dashboard
↓

Top 10 Hosts
↓

Explore Dashboard
```

---

# Step 4: Add the Linux Machine

Navigate

```
Environment
    ↓
Detection
    ↓
Agents
    ↓
Agent Control
    ↓
Add Agent
```

Select

```
Network Scan
```

If server is not detected

```
Manual Scan
```

---

# Step 5: Add Asset

Go to

```
Environment
↓

Assets
↓

Add Asset
↓

Manual Scan
```

After scan

```
Select Linux Server

Save
```

A new asset entry is created.

Click the **Key icon** on the right side.

Copy the generated **Agent Key**.
---
**MDAxIEhvc3QtMTkyLTE2OC0xMjktMTMzIDE5Mi4xNjguMTI5LjEzMyBlY2NhMzM5N2U2YzU0NGMwODMyYzM2NjY5ZjI0YzcwMDNmOTMyZDQ2ODc3OTVlN2I0ZTVkOTMxNmNmMDEzNGE4**
---
Save it in Notepad.

You will use it while installing the OSSEC agent.

---

# Step 6: Configure Linux Server (Victim)

Install rsyslog

```bash
sudo apt update
sudo apt install rsyslog
```

Check service

```bash
systemctl status rsyslog
```

---

## Configure SSH Logging

Open

```bash
sudo vim /etc/ssh/sshd_config
```

Enable

```
SyslogFacility AUTH

LogLevel INFO
```

Save

```
:wq
```

---

Restart SSH

```bash
sudo systemctl restart ssh
```

Verify logs

```bash
sudo tail -f /var/log/auth.log
```

Now every SSH login attempt will be stored inside

```
/var/log/auth.log
```

---

# Step 7: Install OSSEC Agent on Linux Server

Install wget

```bash
sudo apt install wget
```

Download OSSEC

```bash
wget <OSSEC Download URL>
```

Install dependencies

```bash
sudo apt install build-essential \
libevent-dev \
libpcre2-dev \
zlib1g-dev \
libssl-dev \
ca-certificates \
libsystemd-dev
```

Extract

```bash
tar -xzf ossec*.tar.gz
```

Move inside directory

```bash
cd ossec*
```

Install

```bash
sudo ./install.sh
```

---

## Installation Options

Choose

```
Installation Type :
Agent
```

Default installation path

```
Press Enter
```

Manager IP

```
192.168.80.101
```

Accept defaults

```
Y
Y
Y
Enter
Enter
```

Installation completes.

---

Create sender file

```bash
sudo touch /var/ossec/queue/rids/sender
```

---

# Step 8: Register OSSEC Agent

Run

```bash
sudo /var/ossec/bin/manage_agents
```

Choose

```
I
```

Paste the **Agent Key** copied from OSSIM.

Confirm

```
yes
```

Quit

```
Q
```

---

Start OSSEC

```bash
sudo /var/ossec/bin/ossec-control start
```

---

# Step 9: Verify Agent in OSSIM

Open

```
OSSIM Dashboard
↓

Environment
↓

Detection
↓

Agents
```

Agent should show

```
Connected
```

---

# Step 10: Monitor SIEM Events

Go to

```
Analysis
↓

SIEM
↓

Real Time
```

Keep this window open.

---

# Step 11: Perform SSH Attack

From attacker machine

```bash
ssh username@<Linux_Server_IP>
```

Enter an incorrect password several times.

Example

```bash
ssh student@192.168.80.120
```

Wrong Password

```
password123
```

Repeat 5–10 times.

---

# Step 12: Observe Detection

Flow of events

```
Attacker
      │
      │ Wrong SSH Password
      ▼
Linux Server
      │
      │ SSH logs
      ▼
/var/log/auth.log
      │
      │
OSSEC Agent
      │
      │ Sends alert
      ▼
OSSIM SIEM
      │
      ▼
Real-Time Dashboard
```

OSSIM will generate alerts like

```
Authentication Failure

SSH Failed Login

Multiple Failed Login Attempts

Possible Brute Force Attack
```

---

# Overall Architecture

```text
                 SSH Attack
Attacker
     │
     ▼
Linux Server (Victim)
     │
     │ Generates logs
     ▼
/var/log/auth.log
     │
     ▼
OSSEC Agent
     │
     │ Sends Events
     ▼
OSSIM Server (SIEM)
     │
     ▼
Dashboard → Analysis → SIEM → Real-Time Alerts
```

---

# Complete Practical Flow (One-Line Summary)

```text
Create OSSIM VM
        ↓
Configure Static IP
        ↓
Login to OSSIM
        ↓
Complete Wizard
        ↓
Add Linux Asset
        ↓
Generate Agent Key
        ↓
Configure SSH Logging on Linux
        ↓
Install OSSEC Agent
        ↓
Import Agent Key
        ↓
Start OSSEC Agent
        ↓
Verify Agent in OSSIM
        ↓
Open Analysis → SIEM → Real-Time
        ↓
Launch SSH Brute Force Attack
        ↓
OSSIM Detects Authentication Failure and Displays Real-Time Alerts
```

This is the corrected sequence with the installation, configuration, agent registration, and attack demonstration arranged in the proper order for performing the practical.
