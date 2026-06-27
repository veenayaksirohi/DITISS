# VMware Network Adapters Notes (Corrected)

When VMware is installed, it creates **virtual Ethernet adapters** on the host machine.

## Physical Ethernet Adapter

- Your **Ethernet/Wi-Fi adapter** connects your computer to the **Local Network (LAN)** and the **Internet (World Wide Web)**.
- It is the real network interface of the host machine.

## VMware Virtual Adapters

**VMnet0 (Bridged Mode)**

- VM is connected directly to the physical network.
- VM gets an IP address from the same network as the host.
- VM appears as a separate device on the LAN.

**VMnet1 (Host-Only Mode)**

- Creates a private network between the host and VMs.
- No Internet access by default.
- Used for isolated lab environments.

**VMnet8 (NAT Mode)**

- VMware creates a virtual NAT router.
- VMs access the Internet through the host machine.
- The host acts like a router/NAT device for the VMs.

## Simple Diagram

```text
Internet
  |
  |
Physical Ethernet/Wi-Fi Adapter
  |
Host Machine (Windows)
  |
  +-- VMnet0 (Bridged)
  |      |
  |      +-- VM (same network as host)
  |
  +-- VMnet1 (Host-Only)
  |      |
  |      +-- VM (host <-> VM only)
  |
  +-- VMnet8 (NAT)
         |
         +-- VMware NAT Service
                 |
                 +-- VM (Internet through host)
```

## Why Do I See Many Adapters?

VMware can create up to **20 virtual networks (VMnet0-VMnet19)**, although usually only:

- **VMnet0 = Bridged**
- **VMnet1 = Host-Only**
- **VMnet8 = NAT**

are created by default.

## Important Note

**In NAT mode, the physical Ethernet adapter is NOT the NAT device itself.**

The flow is:

```text
VM -> VMnet8 -> VMware NAT Service -> Host Ethernet/Wi-Fi -> Internet
```

So, the **host machine performs the NAT function** for the virtual machines.

## Ways to Install Packages in Linux

### 1. Binary Package Installation (.deb / .rpm)

- Pre-compiled software package (already converted to binary).
- No source code compilation is required.
- If dependencies are missing, they must be installed separately.

**Examples:**

```bash
sudo apt install ./package.deb
sudo dpkg -i package.deb
```

---

### 2. Package Manager Installation

- Uses package managers such as **APT, DNF, YUM, Snap**, or **Flatpak**.
- Automatically downloads and installs required dependencies.
- Recommended method for most users.

**Examples:**

```bash
sudo apt install <package>
sudo snap install <package>
```

---

### 3. Source Code Installation

- Software is installed from its source code.

**Step 1: Configure**

```bash
./configure
```

- Checks for required libraries, tools, and dependencies.
- Creates build files (Makefiles).

**Step 2: Make**

```bash
make
```

- Compiles the source code.
- Converts source code into binary/executable files.

**Step 3: Make Install**

```bash
sudo make install
```

- Copies binaries and libraries to system directories (e.g., `/usr/local/bin`).
- Makes the program available system-wide through the system PATH.

Here are your **fixed and clean notes**:

## Debian APT Repository Configuration

- **APT** is one of the default package managers in Debian.
- The main configuration file is:

```bash
/etc/apt/sources.list
```

- To check the file:

```bash
ls -l /etc/apt/sources.list
```

## Repository Entry Format

```bash
deb <repository-location> <codename> <component>
```

Example:

```bash
deb <repository-url> bookworm main
```

Where:

- **repository-url** -> Repository location
- **bookworm** -> Debian 12 codename
- **main** -> Repository component

## Local Repository Example

```bash
deb [trusted=1] <local-repository-url> bookworm main
```

Where:

- **local-repository-url** -> Local repository location
- **bookworm** -> Debian 12 codename
- **main** -> Repository component
- **[trusted=1]** -> Tells APT to trust the local repository

## Typical `sources.list` Entries

```bash
deb <repository-url> bookworm main
deb <security-repository-url> bookworm-security main
deb <repository-url> bookworm-updates main
deb [trusted=1] <local-repository-url> bookworm main
```

## Thumb Rule

After every change in `/etc/apt/sources.list`, run:

```bash
sudo apt update
```

This refreshes the package database and loads the new repository information.

## Short Exam Notes

```text
Debian uses APT as a default package manager.

Main configuration file:
/etc/apt/sources.list

Repository format:
deb <repository-location> <codename> <component>

bookworm = Debian 12 codename
main = repository component

Local repo:
deb [trusted=1] <local-repository-url> bookworm main

[trusted=1] is used to trust the local repository.

Thumb Rule:
After every change in sources.list, run:
sudo apt update
```

## Exit Status in Linux

- `echo $?` displays the **exit status (return code)** of the last command executed.
- Exit status values range from **0 to 255**.

### Meaning of Exit Codes

- **0** -> Command executed successfully.
- **Non-zero (1-255)** -> An error occurred or the command did not complete successfully.

### Example

```bash
ls
echo $?
```

Output:

```bash
0
```

This means the `ls` command executed successfully.

### Short Exam Notes

```text
echo $? displays the exit status (return code) of the last executed command.

0     = Success
Non-zero = Error/Failure

Example:
ls
echo $?

Output: 0
(Successful execution)
```

## VMware Network Modes

### NAT (Network Address Translation)

- Traffic can go **from the VM to the outside network/Internet**.
- Outside systems **cannot directly access the VM** unless port forwarding is configured.
- VM shares the host's Internet connection.

### Bridged Mode

- Communication is **bidirectional**.
- The VM appears as a separate device on the physical network.
- Both the VM and other devices on the network can communicate directly with each other.

### Host-Only Mode

- Communication is only between the **host machine and the VM**.
- No direct access to the external network or Internet.
- Useful for isolated lab environments.

---

## Hashing (Quick Reference)

**Hashing** = One-way conversion of data into fixed-length "garbage" form that **cannot be reversed** (unlike encryption).

### Common Hashing Algorithms

| Algorithm   | Status      | Use Case                   |
| ----------- | ----------- | -------------------------- |
| **MD5**     | Broken      | File checksums only        |
| **SHA-1**   | Broken      | Deprecated                 |
| **SHA-256** | Secure      | Passwords, TLS, Blockchain |
| **SHA-512** | Secure      | High-security apps         |
| **SHA-3**   | Most modern | Future-proof apps          |

### Key Points

- **One-way** -> Cannot reverse to original data
- **Fixed output** -> Same length regardless of input size
- **Deterministic** -> Same input = same hash
- **Fast** -> Computationally efficient

### Best Practices (2026)

- Use **Argon2** or **bcrypt** + **salting** for passwords
- Use **SHA-256** or **SHA-512** for data integrity
- Avoid MD5 and SHA-1 because they are vulnerable

---

## `127.0.0.1` vs `localhost`

- `127.0.0.1` is the IPv4 loopback address.
- `localhost` is a hostname that usually resolves to `127.0.0.1` or `::1` depending on the system.

# UAC - User Account Control (Windows)

> **Tag:** OS Security · Windows · Privilege Control

---

## What is UAC?

Windows security feature that **blocks unauthorized system changes** by prompting for consent or admin credentials before any elevated action runs.
Introduced in **Windows Vista** - present in all versions since.

---

## How it Works

```text
App requests elevated action
          |
          v
    UAC Intercepts
    +-------------+
    v             v
 Admin User   Std User
 "Allow?"     "Enter admin
               password"
    |            |
    +------------+
          v
   Elevated Process runs
```

---

## UAC Levels

| Level                             | Behaviour                            |
| --------------------------------- | ------------------------------------ |
| Always notify                     | Prompt for everything - most secure  |
| **Notify when apps make changes** | **Default**                          |
| Notify (no dim screen)            | Same, no secure desktop              |
| Never notify                      | UAC off - dangerous                  |

---

## Key Concepts

| Concept               | Meaning                                                           |
| --------------------- | ----------------------------------------------------------------- |
| **Split Token**       | Admin gets 2 tokens - standard (always) + elevated (UAC approved) |
| **Secure Desktop**    | Screen dims on prompt - stops malware auto-clicking Yes           |
| **Consent Prompt**    | Admin user - just click Allow                                     |
| **Credential Prompt** | Standard user - must type admin password                          |
