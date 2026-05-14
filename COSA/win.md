# Part 1: Windows Policies: Local vs Group Policy (GPO)

This document compares **Local Policies** and **Group Policies (GPOs)** in Windows and shows when to use which.

**Quick summary:** Local = only this machine, Group Policy = centralized via domain.

---

## 1. Local Policies (on a single machine)

Local Policies are security/configuration settings that apply **only to that one computer**.

### How to access

- Run `secpol.msc` (Local Security Policy)
- Or: Control Panel -> Administrative Tools -> Local Security Policy

### Main components

- **Audit Policy** - decides which events are logged (logon, object access, etc.)
- **User Rights Assignment** - what users are allowed to do (log on locally, shut down system, etc.)
- **Security Options** - various security tweaks (UAC behavior, admin approval mode, etc.)

### Typical use cases

- Standalone PCs
- Test labs
- Workgroup machines not joined to a domain

---

## 2. Group Policies (GPOs via Active Directory)

Group Policies are settings applied **centrally through Active Directory** to many machines/users.

### How to access

- Run `gpmc.msc` (Group Policy Management Console)

### Where GPOs can be linked

- **Sites** - AD Sites
- **Domains** - Domain level (e.g., corp.local)
- **OUs** - Organizational Units

### Two main sections inside a GPO

- **Computer Configuration** - affects computers regardless of which user logs in
- **User Configuration** - affects users regardless of which computer they use

Both **Computer Configuration** and **User Configuration** share the same structure inside the _Policies_ node:

```
Policies
  +-- Software Settings
  +-- Windows Settings
  +-- Administrative Templates
```

---

## 2.1 Software Settings

Used mainly for **software deployment via Group Policy**.

### Deployment methods

- **Assign** - software is automatically installed (to a computer or user)
- **Publish** - software is made available for the user to install from Programs and Features

**Summary:** _Software Settings = control which applications get installed, and how._

---

## 2.2 Windows Settings

Contains **OS-level and security-related settings**, plus scripts.

### What's included

- **Scripts** - startup/shutdown (computer), logon/logoff (user)
- **Security settings** - account policies, local policies, firewall rules, IPSec, etc.

**Summary:** _Windows Settings = core OS behavior, security, and scripts._

---

## 2.3 Administrative Templates

Large collection of **registry-based settings** that customize Windows and some apps (Explorer, Control Panel, Start Menu, etc.).

### Examples

- Disable Control Panel, hide certain tabs
- Set desktop wallpaper, configure Start Menu and Taskbar behavior
- Configure Windows components like Windows Update, Windows Installer, etc.

**Summary:** _Administrative Templates = fine-tuning the user/computer environment via registry-based policies._

---

## Quick Reference

| Component                    | Purpose                               |
| ---------------------------- | ------------------------------------- |
| **Software Settings**        | What software is installed            |
| **Windows Settings**         | How the OS behaves and secures itself |
| **Administrative Templates** | Detailed UI and component tweaks      |

---

## 2.4 GPO Inheritance Order (LSDOU)

**Rule:** Local -> Site -> Domain -> OU, and later ones override earlier ones.

### What LSDOU means

When a user or computer in a domain gets policies, Windows processes GPOs in this sequence:

1. **L - Local**  
   Local Group Policy on that machine is applied first

2. **S - Site**  
   Then any GPOs linked to the AD Site the computer belongs to

3. **D - Domain**  
   Then GPOs linked at the domain level (e.g., corp.local)

4. **OU - Organizational Unit**  
   Then GPOs linked to the OU, and if there are nested OUs, from parent OU down to the child OU that directly contains the object

### Processing rule

**Last applied wins:** If two GPOs configure the same setting differently, the policy closer to the object (OU) overrides the earlier ones (Domain, Site, Local).

**In practice:** OU GPO > Domain GPO > Site GPO > Local GPO (for conflicting settings)

### Example scenario

Imagine this setting: "Disable Control Panel"

| Level      | Setting        | Result                |
| ---------- | -------------- | --------------------- |
| Local GPO  | Not configured | -                     |
| Site GPO   | Disabled       | Control Panel allowed |
| Domain GPO | Enabled        | Control Panel blocked |
| OU GPO     | Disabled       | Control Panel allowed |

**Processing order:** Local -> Site -> Domain -> OU

**Final result:** OU setting wins, so Control Panel is **allowed** for that user/computer.

---

## 3. Key Differences (Local vs Group Policy)

| Aspect          | Local Policies                                    | Group Policies                                   |
| --------------- | ------------------------------------------------- | ------------------------------------------------ |
| **Scope**       | Only that machine                                 | Many machines/users via AD                       |
| **Tools**       | `secpol.msc`, `gpedit.msc`                        | `gpmc.msc`                                       |
| **Management**  | Decentralized (configure each machine separately) | Centralized (configure once, applied to many)    |
| **Application** | Applied immediately on that machine               | Applied according to AD links (Site, Domain, OU) |
| **Users**       | Local accounts                                    | Domain users and computers                       |
| **Override**    | Can be overridden by domain GPOs                  | Can enforce organization-wide policy             |

---

## 4. Example Scenarios

| Scenario                                       | Use              |
| ---------------------------------------------- | ---------------- |
| Set logon hours on **one PC only**             | **Local Policy** |
| Enforce screensaver lock for **all employees** | **Group Policy** |
| Enable auditing on a **personal laptop**       | **Local Policy** |
| Disable USB ports **company-wide**             | **Group Policy** |

---

## 5. Important Notes

- On domain-joined machines, **GPOs override local policies**
- Group Policies can be filtered (security filtering, WMI filters) to target specific groups or machines
- By default, GPOs refresh every ~90 minutes with a random offset
- Force refresh with: `gpupdate /force`

---

## Practice Question

**Scenario:** Your company wants to **block USB storage for every domain user**, but allow it on one standalone testing PC.

**Question:** How would you use **Group Policy** and **Local Policy** together to achieve that?

<details>
<summary>Click to see answer</summary>

1. **Group Policy (Domain-wide):** Create a GPO linked to the domain or appropriate OU that blocks USB storage for all domain users
2. **Local Policy (Testing PC):** If the testing PC is domain-joined, you'd need to either:
   - Remove it from the domain (make it standalone/workgroup), then configure Local Policy to allow USB
   - Or use security filtering/WMI filters to exclude that specific computer from the GPO
3. **If truly standalone:** Simply configure the Local Policy on that testing PC to allow USB storage (it won't receive domain GPOs anyway)

</details>

---

# Part 2: Network Connectivity & Remote Access

---

## 1. Network Connectivity Solutions

### Goal

Give **secure, reliable remote access** to internal resources for remote workers, with traffic **encrypted and authenticated**.

### Technologies

- VPN (Remote Access VPN, Site-to-Site VPN)
- DirectAccess
- NPS, RRAS, firewalls/NAT, DNS, DHCP, Group Policy

> **Summary:** Network connectivity solutions like VPN and DirectAccess allow secure remote access to enterprise networks over the Internet, using encryption and proper authentication.

---

## 2. VPN (Virtual Private Network)

### Definition

A VPN creates a **secure encrypted tunnel** between a client and a private network over the Internet or untrusted networks.

### Types of VPN

**Remote Access VPN (user -> network)**

- Used by individual users (employees working from home)
- Connect from single device to company network over internet
- Once connected, device behaves as if inside office network

**Site-to-Site VPN (network -> network)**

- Connects two whole networks (branch office to HQ)
- Devices in both offices communicate as if in one big private network

> **Exam note:** Remote Access VPN is user-to-network; Site-to-Site VPN is network-to-network.

---

### What is RRAS?

**RRAS = Routing and Remote Access Service** (Windows Server role)

RRAS is a Windows Server role that lets the server act as a router and remote access/VPN server. It provides routing between networks and secure remote access for users over VPN or dial-up.

### Main Functions

**Remote access (VPN / dial-up)**

- Allows remote users to connect securely to the company network (Remote Access VPN)
- Can also create site-to-site VPNs between two locations

**Routing**

- Lets the server route traffic between different networks/subnets (LAN-to-LAN, LAN-to-WAN)
- Supports NAT, so many internal clients can share one public IP to access the internet

**Integration**

- Works with Active Directory and Network Policy Server (NPS) for authentication and policies

---

### Implementation Steps (Remote Access VPN via RRAS)

1. **Install RRAS/Remote Access role**
   - Server Manager -> Add Roles and Features -> Remote Access
   - Enable "DirectAccess and VPN (RAS)" and include Routing

2. **Configure RRAS for VPN**
   - Open RRAS console -> right-click server -> "Configure and Enable Routing and Remote Access"
   - Choose **Custom configuration** -> select **VPN access** -> start service

3. **Configure VPN protocols**
   - Support PPTP, L2TP/IPsec, SSTP, IKEv2
   - Use **certificates** for L2TP/IPsec, SSTP, IKEv2 for secure authentication

4. **User configuration**
   - In ADUC, allow dial-in access or configure NPS policies to control who can connect

5. **Firewall/ports** (important for viva)
   - PPTP: TCP 1723, GRE 47
   - L2TP: UDP 500, 1701, 4500
   - SSTP: TCP 443

6. **Client side**
   - Windows client: Settings -> Network & Internet -> VPN -> Add a VPN connection

> **Exam tip:** Be ready to list definition, two types, and 3-4 bullets of implementation steps.

---

## 3. DirectAccess

### Definition

DirectAccess gives **seamless, always-on remote connectivity** for **domain-joined Windows Enterprise clients**, without the user starting a VPN manually.

### Requirements

- Windows Server (2012 or later)
- Windows 10/11 **Enterprise** clients
- Active Directory domain
- Public IPv4 address or NAT device

### How It Works

- Uses IPv6 transition technologies (6to4, Teredo, IP-HTTPS)
- Uses IPsec to secure traffic between client and internal network
- Configuration and policies pushed via Group Policy

### Deployment Steps (High-Level)

1. **Install Remote Access role** with DirectAccess and VPN (RAS)

2. **Configure DirectAccess** in Remote Access Management Console:
   - Choose topology (edge or behind NAT)
   - Select security groups for DirectAccess clients
   - Configure authentication (certificates, smartcards)
   - Set DNS and infrastructure servers

3. **Group Policies** - wizard auto-creates and links GPOs for clients and servers

4. **Certificates** - DirectAccess needs machine certificates, usually via AD CS

5. **Firewall** - ensure required ports (e.g., TCP 443 for IP-HTTPS, IPsec ports) are open

6. **Monitoring** - use Remote Access Management Console and Event Viewer, test from external client

> **Theory answer format:** What it is, requirements, how it works (IPv6 + IPsec + GPO), and 2-3 steps of deployment.

---

## 4. VPN vs DirectAccess

| Feature        | VPN                                   | DirectAccess                                       |
| -------------- | ------------------------------------- | -------------------------------------------------- |
| Connection     | Manual (user clicks connect)          | Automatic, always-on                               |
| OS support     | Any OS with VPN client                | Windows 10/11 Enterprise only                      |
| Authentication | Username/password, certificates, etc. | Certificates/IPsec                                 |
| Management     | Less centralized                      | Centralized via Group Policy                       |
| Always on      | No                                    | Yes                                                |
| Best for       | Mixed OS, temporary remote access     | Full-time staff with domain-joined Windows devices |

**Key takeaways:**

- VPN is good for general, cross-platform remote access
- DirectAccess is good for corporate laptops that must always stay connected and manageable

---

# Part 3: Internet Information Services (IIS)

---

## 1. IIS Definition and Core Functions

### What is IIS?

IIS (Internet Information Services) is Microsoft's web server that runs on Windows Server (and some client Windows) to host websites, web apps, and APIs. It supports content and apps built with HTML, ASP.NET, PHP, etc.

> **Default installation path:** `C:\inetpub\wwwroot\iisstart.htm` (default IIS welcome page)

### Core Functions

- **HTTP/HTTPS web hosting** - serves web pages over HTTP/HTTPS
- **Application hosting** - runs web apps (ASP.NET, PHP, etc.)
- **Security management** - SSL certificates, authentication, authorization
- **Logging & monitoring** - logs requests, performance counters
- **Load balancing** - with ARR or NLB to distribute traffic

> **Exam definition (2-3 marks):** "IIS is a Windows-based web server used to host websites and web applications, supporting HTTP/HTTPS, security features, and logging."

---

## 2. IIS Architecture and Key Components

### Architecture Points (4-5 marks)

- **Web server engine** - accepts HTTP requests and sends responses
- **Worker process (w3wp.exe)** - actually runs the web apps and handles requests
- **Application pools** - isolate applications into separate worker processes for security and stability
- **Modules** - plug-ins that add features like authentication, compression, caching
- **Configuration files** - applicationHost.config (server/site level) and web.config (app level)

### Supported Protocols

- HTTP/HTTPS, FTP/FTPS, optional SMTP, WebSocket

### Key Components

| Component           | Purpose                                          |
| ------------------- | ------------------------------------------------ |
| Application Pools   | Process isolation between applications           |
| Sites               | Logical containers for hosted apps               |
| Bindings            | IP + port + hostname mapping (e.g., _:80, _:443) |
| Virtual Directories | Map URLs to folders outside site root            |
| Modules & Handlers  | Control how IIS processes specific requests      |

---

## 3. Security, Logging, and Common Use Cases

### Security Features

- **Authentication** - Basic, Digest, Windows, Forms
- **Authorization rules** - who can access what
- **SSL/TLS** - HTTPS encryption
- **Request filtering** - block dangerous patterns
- **IP restrictions** - limit access by IP address

### Logging and Monitoring Tools

- **IIS logs** - track requests, status codes, client IPs
- **Failed Request Tracing** - debug failures
- **Performance Monitor** - monitor IIS/app pool performance
- **Event Viewer** - view related system/app events

### Common Use Cases (Exam-Friendly)

- Hosting static websites
- Running ASP.NET / PHP dynamic apps
- Serving REST APIs
- Intranet portals
- Reverse proxy/load balancer using ARR

---

## 4. Installing IIS and Useful Tools

### Installation Steps on Windows Server

1. Open **Server Manager**
2. Click **Add Roles and Features**
3. Select **Web Server (IIS)**
4. Choose extra features (ASP.NET, FTP, etc.)
5. Install and then configure using IIS Manager or PowerShell

### Common Tools/Add-ons

| Tool                              | Purpose                                    |
| --------------------------------- | ------------------------------------------ |
| IIS Manager                       | GUI to manage sites, app pools, bindings   |
| Web Deploy                        | Deploy applications from dev to production |
| Application Request Routing (ARR) | Reverse proxy, load balancing              |
| URL Rewrite                       | Clean URLs, redirects, rewrite rules       |

---

# Part 4: Core & Distributed Network Solutions

---

## 1. Core Network Solutions

### Definition

The **core network** is the central part of an enterprise network that connects servers, data centers, storage, and gateways with high speed and reliability.

### Key Features

- **High throughput** - handles large volumes of traffic
- **Low latency** - fast packet delivery
- **Centralized traffic management** - single point of control
- **Redundant design** - no single point of failure
- **Scalability** - supports future growth

### Technologies

- High-end routers and Layer 3 switches (routing and switching)
- VLANs and trunking
- Dynamic routing: OSPF, EIGRP, BGP
- Load balancing and failover (F5, HA pairs)
- QoS for VoIP/video

> **Exam angle:** "What is core network? Explain any four features/technologies."

---

## 2. Distributed Network Solutions

### Definition

Instead of everything in one central data center, distributed networks place services **close to users** - like in branch offices.

### Why Used

- Reduces latency for remote offices
- Increases fault tolerance
- Allows local data processing/storage
- Uses WAN links more efficiently

### Common Use Cases

- Branch office deployments
- Multi-site enterprises
- Global content distribution
- Hybrid cloud integration

> **Exam angle:** "Define distributed network. Mention advantages and two use cases."

---

## 3. IPv4 vs IPv6 Addressing

| Feature        | IPv4                               | IPv6                                             |
| -------------- | ---------------------------------- | ------------------------------------------------ |
| Address length | 32 bits                            | 128 bits                                         |
| Notation       | Dotted decimal (e.g., 192.168.1.1) | Hexadecimal, colon-separated (e.g., 2001:db8::1) |
| Address space  | ~4.3 billion                       | ~3.4 - 10-8                                      |
| NAT required   | Yes (addresses are limited)        | No (enough addresses for all devices)            |
| IPsec support  | Optional                           | Built-in / supported                             |
| Subnetting     | Required for efficient use         | Less critical due to huge space                  |

> **Exam angle:** "Differentiate IPv4 and IPv6 (any 4 points)."

---

## 4. Distributed File System (DFS)

### Definition

DFS Namespace allows administrators to combine shared folders from multiple servers into a single logical path, such as `\\domain\dfsroot`. Users access files using this unified path and do not need to know the actual server names or share locations.

### Two Components

#### 1. DFS Namespaces (single logical path)

DFS Namespaces show users one common path even though the real shared folders live on different servers.

- Users always go to `\\corp.local\Files\HR`
- But "HR" might actually live on `FS1\HRShare` in HQ and `FS2\HRShare` in a branch
- The namespace hides the real server names and presents a single logical tree

> "DFS Namespace provides a virtual folder structure that combines shared folders from multiple servers into one unified logical path, so users don't care where the data is physically stored."

#### 2. DFS Replication (DFSR - multi-master sync)

DFS Replication copies and synchronizes files between servers.

- **Multi-master:** any member server can accept changes; changes are then replicated to the others
- If a file changes on Server A, DFSR sends only the changed blocks (using RDC) to Server B and others
- If one server is down, users can still access the same data from another replicated server

> "DFS Replication is a multi-master replication service that keeps shared folders synchronized across multiple servers, improving availability and fault tolerance."

### Use Cases

- Same file path for HQ and branch users
- Fault-tolerant file access
- Better performance via local file access

> **Exam angle:** "What is DFS? Explain DFS Namespace and DFS Replication."

---

## 5. Branch Office Solutions

### Goal

Provide file access, print services, and secure internet to remote/small offices over WAN.

### Key Technologies

| Technology                             | Purpose                                            |
| -------------------------------------- | -------------------------------------------------- |
| **RODC** (Read-Only Domain Controller) | Safer AD in branches - no writable AD data exposed |
| **DFS Replication**                    | Local file access with central sync                |
| **BranchCache**                        | Local cache of content from HQ servers             |
| **DHCP/DNS**                           | Local or forwarded to HQ                           |
| **VPN**                                | Site-to-site or client VPN for secure connectivity |

### Benefits

- Better performance and autonomy for branches
- Secure access to HQ resources
- Less need for full-time IT staff at branch

---

# Part 5: Windows Deployment Services (WDS)

---

## 1. What is WDS?

**Windows Deployment Services (WDS)** is a Windows Server role that allows network-based installation of Windows operating systems to client computers using **PXE boot**, without physical media.

> **Exam definition (2-3 marks):** "WDS is a Windows Server role that enables network-based installation of Windows OS to multiple clients using PXE boot and image files, useful for mass deployment in enterprises."

---

## 2. Key Components

| Component                                    | Purpose                                                          |
| -------------------------------------------- | ---------------------------------------------------------------- |
| **PXE Boot** (Preboot Execution Environment) | Lets clients boot from the network                               |
| **WDS Server**                               | Domain-member server that stores and serves OS images            |
| **Boot Image**                               | Windows PE image used to boot clients into a minimal environment |
| **Install Image**                            | The actual Windows OS (e.g., Windows 10/11) that gets installed  |
| **Image Groups**                             | Logical containers to organize install images                    |

---

## 3. Requirements

- **Active Directory Domain Services (AD DS)** - WDS server must be domain-joined; AD controls which computers/users can use WDS
- **DHCP Server** - assigns IP to PXE-booting clients (can be on same or different server)
- **DNS**
- **NTFS partition** on the WDS server
- **Windows image files in .wim format**

### Supported Image Types

- `.wim` - standard Windows image format
- `.vhd` - for booting from virtual hard disks
- Custom captured images from sysprepped reference machines

---

## 4. How WDS Works (Step-by-Step)

1. Client boots using **PXE** and sends a request on the network
2. WDS server responds and offers a **boot image**
3. Client downloads and starts **Windows PE** (boot image)
4. Technician/script selects the required **install image**
5. OS installs automatically or semi-automatically on the client

---

## 5. Deployment Modes

| Mode                        | Description                                                                                  |
| --------------------------- | -------------------------------------------------------------------------------------------- |
| **Unattended installation** | Uses answer files to fully automate OS installation (no user input)                          |
| **Multicast deployment**    | Sends one stream of data to multiple clients simultaneously - efficient for many PCs at once |
| **Capture image**           | Special boot image used to capture a `.wim` from a configured reference machine              |
| **Discover image**          | Bootable image for machines that cannot PXE boot; they can still connect to WDS              |

---

## 6. Tools Used with WDS

| Tool            | Purpose                                                         |
| --------------- | --------------------------------------------------------------- |
| **DISM**        | Deployment Image Servicing and Management - edit `.wim` images  |
| **Sysprep**     | Prepares OS on a reference PC for imaging (removes unique info) |
| **Windows SIM** | Creates unattended answer files                                 |
| **WAIK/ADK**    | Toolkit to manage and customize deployments                     |

---

## 7. Use Cases

- Large organizations deploying OS to many machines
- Automated lab setups for students/test environments
- Quickly restoring systems to a baseline image
- Reducing manual work/time in OS installation

---

## 8. Security Considerations

- Restrict who can deploy images via PXE
- Use AD-integrated WDS for better control
- Protect unattended answer files that contain credentials

---

# Part 6: Hyper-V, Disks, Storage & FSRM

---

## 1. Hyper-V (Virtualization)

### Definition

Hyper-V is Microsoft's hypervisor for creating and managing virtual machines on Windows Server (and some Windows 10/11 editions). It allows multiple OSes to run on one physical machine.

---

### VM Generations

| Feature     | Generation 1                      | Generation 2                    |
| ----------- | --------------------------------- | ------------------------------- |
| Firmware    | Legacy BIOS                       | UEFI                            |
| Hardware    | Emulated legacy (IDE, legacy NIC) | Modern synthetic devices (SCSI) |
| OS support  | Older OSes, 32-bit                | Modern 64-bit OSes              |
| Secure Boot | No                                | Yes                             |
| Boot from   | IDE virtual disks                 | SCSI virtual disks              |

> **Gen 1 = legacy BIOS + older hardware support**
> **Gen 2 = UEFI + Secure Boot + modern OSes**

---

### Key Features

- Virtual networking via virtual switches
- Virtual hard disks (VHD, VHDX)
- Live migration and replication in failover clusters
- Integration services for better guest OS performance
- Checkpoints (snapshots) to save VM state

### Key Components

| Component                                 | Purpose                    |
| ----------------------------------------- | -------------------------- |
| Hypervisor                                | Abstracts hardware for VMs |
| VMMS (Virtual Machine Management Service) | Manages VM lifecycle       |
| Virtual Switch                            | Networking for VMs         |
| Virtual Hard Disks                        | Disk images used by VMs    |

### Installation

```powershell
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
```

Manage via **Hyper-V Manager** or PowerShell.

---

## 2. Disks and Volumes

### Disk Types

| Type             | Description                                                |
| ---------------- | ---------------------------------------------------------- |
| **Basic disk**   | Uses MBR or GPT partition tables; traditional partitions   |
| **Dynamic disk** | Supports advanced volumes spanning disks and software RAID |

### Volume Types

| Volume                | Description                                                                       |
| --------------------- | --------------------------------------------------------------------------------- |
| **Simple**            | Space on one disk                                                                 |
| **Spanned**           | Extends across multiple disks (no redundancy)                                     |
| **Striped (RAID 0)**  | Stripes data over disks for performance, no fault tolerance                       |
| **Mirrored (RAID 1)** | Duplicates data on two disks for redundancy                                       |
| **RAID 5**            | Striping with parity across 3+ disks - balance of performance and fault tolerance |

### Tools

- **Disk Management MMC** - GUI tool
- **PowerShell** - `Get-Disk`, `Initialize-Disk`, `New-Partition`

> **Exam angle:** "Differentiate basic and dynamic disks" or "Explain various volume types in Windows Server."

---

## 3. Storage Spaces

Storage Spaces lets you pool physical disks and create virtual disks on top.

### Resiliency Modes

| Mode       | Description                                         |
| ---------- | --------------------------------------------------- |
| **Simple** | No resiliency (like RAID 0)                         |
| **Mirror** | Keeps copies for redundancy (like RAID 1)           |
| **Parity** | Uses parity for fault tolerance (similar to RAID 5) |

### Related Concepts

- **Storage Pools** - group of physical disks forming a pool
- **Storage Tiers** - mixing SSD + HDD to optimize performance and capacity

### File Systems

| File System | Description                                                                          |
| ----------- | ------------------------------------------------------------------------------------ |
| **NTFS**    | Default Windows file system                                                          |
| **ReFS**    | Resilient File System - high resilience and scalability, common in storage scenarios |

---

## 4. Data Deduplication

### Definition

Data deduplication is a storage optimization technique that removes duplicate copies of data to save disk space.

### How It Works

1. Breaks files into small chunks
2. Stores only unique chunks on disk
3. Uses metadata to reconstruct files by referencing those chunks

### Benefits

- Reduces storage usage
- Improves backup and restore times
- Saves bandwidth in replication scenarios

### Enabling Deduplication

```powershell
Enable-DedupVolume -Volume "D:"
```

Configure schedule, file age, and exclusions via Server Manager or PowerShell.

> **Exam angle:** "What is data deduplication? Explain its working and benefits."

---

## 5. File Server Resource Manager (FSRM)

### Definition

FSRM is a Windows Server feature used to **manage, monitor, and control storage** on file servers. It helps admins limit disk usage, block unwanted file types, generate storage reports, and automate file management.

---

### 5.1 Quota Management

Quotas are applied to volumes or folders (e.g., user home folders, department shares).

| Type           | Behavior                                                         |
| -------------- | ---------------------------------------------------------------- |
| **Hard quota** | Strict limit - users cannot save more data when quota is reached |
| **Soft quota** | Generates warnings only, does not block writing                  |

FSRM can send email alerts, log events, or run scripts when thresholds are hit (e.g., 85%, 95%, 100%).

---

### 5.2 File Screening Management

File screens control which file extensions users are allowed to store on a path.

| Type                    | Behavior                                                                            |
| ----------------------- | ----------------------------------------------------------------------------------- |
| **Active file screen**  | Blocks saving disallowed files (e.g., `.mp3`, `.avi`, `.exe`) and alerts admin/user |
| **Passive file screen** | Allows saving but logs/audits and optionally sends alerts                           |

**Uses:**

- Stop users from storing personal media (movies, songs)
- Prevent risky files like unknown `.exe` on shares

---

### 5.3 Storage Reports Management

Generates predefined and custom reports:

- Large files
- Duplicate files
- Files by type
- Quota usage
- Most/least recently accessed files

Reports can be **scheduled** (e.g., weekly email to admin) or run **on demand**.

---

### 5.4 Classification Management

FSRM can automatically tag (classify) files using rules based on file name, extension, location, or content.

Define classification properties like `Confidential`, `Department`, `RetentionPeriod`. Once classified, other tools can apply business rules (e.g., stricter access to "Confidential" files).

---

### 5.5 File Management Tasks

Automate actions based on classifications or conditions (file age, size):

- Move files to another folder/volume (e.g., archive old files after 1 year)
- Delete files older than a certain age from temp folders
- Send email notifications to owners or admins

---

### 5.6 Installation

Install via Server Manager:

> File and Storage Services -> File and iSCSI Services -> **File Server Resource Manager**

### Useful PowerShell Cmdlets

| Cmdlet                  | Purpose               |
| ----------------------- | --------------------- |
| `New-FsrmQuota`         | Create a quota        |
| `New-FsrmFileScreen`    | Create a file screen  |
| `New-FsrmScheduledTask` | Automate report tasks |
| `Get-FsrmReport`        | View storage reports  |

---

### Why FSRM Matters (Exam Points)

- Prevents storage abuse by enforcing quotas
- Improves security and compliance by blocking certain file types
- Gives visibility into storage usage through reports
- Automates data management, reducing admin workload

---

# Part 7: Network Policy Server (NPS)

---

## 1. What is NPS?

**Network Policy Server (NPS)** is a Windows Server role that acts as a **RADIUS server and proxy**, centralizing authentication, authorization, and accounting (AAA) for network access.

NPS is commonly used for:

- VPN access
- Wi-Fi authentication
- Wired 802.1X authentication
- Dial-up access

> **Exam definition:** "Network Policy Server (NPS) in Windows Server is a RADIUS server/proxy that centralizes authentication, authorization, and accounting for network access."

---

## 2. Key Functions

| Function                | Purpose                                                                                             |
| ----------------------- | --------------------------------------------------------------------------------------------------- |
| **RADIUS Server**       | Receives requests from RADIUS clients, authenticates users/devices, and authorizes or denies access |
| **RADIUS Proxy**        | Forwards RADIUS requests to other RADIUS servers in large or distributed networks                   |
| **NAP Server (legacy)** | Checks client health through Network Access Protection before granting access                       |

---

## 3. Main Components

| Component                       | Purpose                                                                                 |
| ------------------------------- | --------------------------------------------------------------------------------------- |
| **RADIUS Clients**              | Network access servers that send RADIUS requests to NPS                                 |
| **Connection Request Policies** | Decide whether NPS processes requests locally or forwards them to another RADIUS server |
| **Network Policies**            | Define who can connect, when they can connect, and under what conditions                |
| **Accounting**                  | Logs session details such as start time, duration, and usage                            |

### Examples of RADIUS Clients

- VPN servers
- Wireless access points
- 802.1X-capable switches

### Common Network Policy Conditions

- User group
- Time of day
- NAS type
- Authentication method

---

## 4. How NPS Works

1. User or device tries to connect to a network service, such as VPN or Wi-Fi
2. Access server, such as a VPN server, AP, or switch, sends a RADIUS request to NPS
3. NPS checks credentials against Active Directory
4. NPS evaluates connection request policies and network policies
5. NPS replies with **Access-Accept** or **Access-Reject**
6. NPS can log accounting data for the session

---

## 5. Why NPS Is Used

- Centralizes authentication and authorization for network access devices
- Applies policy-based control for consistent security rules
- Supports VPN, wireless, wired 802.1X, and dial-up connections
- Integrates with Active Directory for user/group-based rules
- Provides accounting logs for auditing and usage tracking

> **Exam angle:** "Explain NPS as a RADIUS server/proxy and describe how it supports centralized network access control."

---

## 6. Installing and Managing NPS

### High-Level Steps

1. Install **Network Policy and Access Services / NPS** via Server Manager
2. Configure RADIUS clients, such as VPN servers, APs, and switches, with shared secrets
3. Define **Connection Request Policies**
4. Define **Network Policies**
5. Optionally enable accounting to log to a local file or SQL database
6. Monitor activity and issues through Event Viewer and NPS logs

---

# Part 8: Network Load Balancing (NLB)

---

## 1. What is NLB?

**Network Load Balancing (NLB)** is a Windows Server feature that distributes incoming network traffic across multiple servers in a cluster to improve availability, scalability, and reliability.

> **Exam definition:** "Network Load Balancing allows multiple servers to present one virtual service and automatically share client traffic, preventing any single server from being overloaded."

---

## 2. Purpose

| Purpose               | Meaning                                                        |
| --------------------- | -------------------------------------------------------------- |
| **Scalability**       | Multiple servers share the load, increasing total capacity     |
| **Fault tolerance**   | If one node fails, other nodes continue serving clients        |
| **High availability** | Users can still reach the service even if one server goes down |

---

## 3. How NLB Works

1. Servers form an NLB cluster
2. The cluster uses a shared **virtual IP (VIP)**
3. Clients connect to the VIP instead of individual node IPs
4. NLB distributes requests among nodes using a hashing algorithm
5. The hash can use client IP, port, and protocol to decide which node handles each request

---

## 4. NLB Modes

| Mode               | Description                                                                                                     |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **Unicast**        | All nodes share the same cluster MAC address; simple for clients, but node-to-node communication can be limited |
| **Multicast**      | Nodes use a multicast MAC address along with their unique MAC addresses; may need switch/router configuration   |
| **IGMP multicast** | Uses IGMP snooping to reduce network flooding in multicast mode                                                 |

### Unicast Note

In unicast mode, the NLB driver replaces the NIC's MAC address on each node with the same shared cluster MAC.

---

## 5. Clusters

- An NLB cluster contains **2 or more servers**, called nodes
- Each node has its own IP address plus the shared virtual IP
- Nodes can be added or removed without major downtime

---

## 6. Port Rules, Load Distribution, and Affinity

### Port Rules

Port rules define how traffic is handled based on:

- Protocol, such as TCP or UDP
- Port range, such as 80 or 443
- Filtering mode, such as multiple hosts, single host, or disabled

**Example:** one rule for HTTP on port 80 and another for HTTPS on port 443.

### Load Distribution

NLB uses a hash of client IP and port to choose the node. This can help keep a given client's session on the same node when needed.

### Session Persistence (Affinity)

| Affinity    | Behavior                                                                      |
| ----------- | ----------------------------------------------------------------------------- |
| **None**    | No affinity; each request can go to a different node, good for stateless apps |
| **Single**  | All requests from a single client IP go to the same node                      |
| **Class C** | All clients from the same Class C subnet go to the same node                  |

---

## 7. Troubleshooting

### Common Issues

- Nodes not synchronizing or not converged
- NLB service stopped or hung
- Load not distributed evenly
- Node-to-node communication problems, often due to multicast configuration
- Clients cannot reach the virtual IP

### Troubleshooting Steps

1. Check cluster state in NLB Manager or PowerShell
2. Verify static IPs, correct VIP, and switch support for multicast/IGMP
3. Ensure the NLB service is running
4. Review event logs for NLB or system errors
5. Verify port rules and confirm there are no overlaps
6. Test connectivity by pinging the VIP and node IPs
7. Use NLB Manager diagnostics and network tools such as Wireshark for deeper analysis

```powershell
Get-NlbClusterNode
```

---

## 8. Best Practices

- Use static IPs for nodes and the VIP
- Ensure switches support multicast/IGMP if using those modes
- Monitor cluster health
- Test failover regularly
- Avoid DHCP for cluster node IPs

---

# Part 9: Exchange Server

---

## 1. What is Exchange Server?

**Exchange Server** is a mail and calendaring server that runs on Windows Server and provides enterprise-level email, calendar, contacts, scheduling, and collaboration services.

> **Exam definition:** "Exchange Server is Microsoft's enterprise mail and calendaring server used to provide email, calendars, contacts, scheduling, and collaboration services."

---

## 2. Core Functions

| Function                       | Purpose                                                  |
| ------------------------------ | -------------------------------------------------------- |
| **Email services**             | Sending, receiving, and storing mail                     |
| **Calendaring and scheduling** | Meetings, appointments, and shared calendars             |
| **Contact management**         | Central address book and contacts                        |
| **Task management**            | Assigning and tracking tasks                             |
| **Unified messaging**          | Voicemail, email, and fax in one inbox                   |
| **Mobility**                   | Mobile sync through Exchange ActiveSync                  |
| **Collaboration**              | Shared mailboxes, public folders, and team collaboration |

---

## 3. Exchange Server Architecture

Modern Exchange versions, such as Exchange 2016/2019 and Exchange Online, mainly use these roles and services:

| Component                  | Purpose                                                                                                                           |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Mailbox Server Role**    | Hosts user mailboxes, stores data in mailbox databases, provides client access services, and handles mailbox transactions         |
| **Client Access Services** | Authenticates client connections and provides protocols such as MAPI over HTTP, Outlook Anywhere, ActiveSync, IMAP, POP3, and OWA |
| **Transport Services**     | Routes and delivers email, enforces mail flow policies, and uses SMTP for sending/receiving mail                                  |
| **Edge Transport Server**  | Optional DMZ server that handles internet mail flow and adds anti-spam/antivirus protection at the perimeter                      |

> **Exam angle:** "Explain the architecture of Exchange Server using Mailbox, Client Access, Transport, and Edge roles/services."

---

## 4. Key Features and Versions

### Key Features

- **High availability and DR** - Database Availability Groups (DAGs) replicate mailbox databases across multiple servers
- **Security** - TLS encryption, anti-malware, anti-spam, and RBAC
- **Integration with AD** - uses Active Directory for user authentication and policy
- **Web access** - Outlook on the web (OWA) for browser-based email access
- **Compliance** - archiving, retention policies, legal hold, and auditing
- **Unified messaging** - telephony integration for voicemail/fax in some versions
- **Mobile Device Management** - ActiveSync for email, calendar, and contacts on phones

### Important Versions

| Version                | Key Point                                        |
| ---------------------- | ------------------------------------------------ |
| **Exchange 2010**      | Introduced DAG for high availability             |
| **Exchange 2013**      | Simplified roles, mainly Mailbox + Client Access |
| **Exchange 2016/2019** | Improved security and performance                |
| **Exchange Online**    | Cloud-hosted Exchange in Microsoft 365           |

---

## 5. Key Terminology and Admin Tools

### Terminology

| Term                   | Meaning                                                            |
| ---------------------- | ------------------------------------------------------------------ |
| **Mailbox Database**   | Stores user mailboxes                                              |
| **Public Folders**     | Shared folders for group collaboration                             |
| **OWA**                | Outlook Web Access / Outlook on the web                            |
| **ActiveSync**         | Protocol for mobile sync                                           |
| **DAG**                | Database Availability Group for mailbox database high availability |
| **Transport Pipeline** | Path that messages take through Exchange transport services        |

### Administration Tools

| Tool                                | Purpose                                  |
| ----------------------------------- | ---------------------------------------- |
| **Exchange Admin Center (EAC)**     | Web-based GUI management console         |
| **Exchange Management Shell (EMS)** | PowerShell-based advanced administration |
| **Performance Monitor**             | Performance monitoring                   |
| **Event Viewer**                    | Troubleshooting and event logs           |

---

## 6. Common Use Cases

- Corporate email for thousands of users
- Central calendar and scheduling system
- Collaboration through shared mailboxes and public folders
- Secure access for mobile and remote users

---

# Part 10: PowerShell

---

## 1. What is PowerShell?

**PowerShell** is a task automation and configuration management framework from Microsoft. It includes a command-line shell and a scripting language built on .NET, designed for system administrators and power users.

> **Exam definition:** "PowerShell is a Microsoft automation and scripting framework that provides a command-line shell and scripting language, used to manage and automate Windows and other systems."

---

## 2. Key Features

- **Cmdlets** - Verb-Noun commands such as `Get-Process` and `Set-Service`
- **Scripting** - `.ps1` files for automating complex tasks
- **Object-oriented pipeline** - works with .NET objects, not plain text
- **Remoting** - manage remote systems
- **Modules** - extend functionality for AD, Exchange, Azure, and more
- **Editors** - ISE or modern editors for writing and debugging scripts
- **Cross-platform support** - PowerShell 7+ runs on Windows, Linux, and macOS

---

## 3. Basic PowerShell Concepts

### Cmdlet Syntax

```powershell
Verb-Noun -ParameterName ParameterValue
Get-Service -Name "wuauserv"
```

### Variables

Variables start with `$`.

```powershell
$userName = "Alice"
```

### Data Types

- Strings
- Integers
- Arrays
- Hash tables
- Objects

### Pipeline

```powershell
Get-Process | Where-Object { $_.CPU -gt 100 }
```

`Get-Process` outputs process objects, and `Where-Object` filters those with CPU greater than 100.

### Control Structures

- Conditionals: `if`, `else`, `switch`
- Loops: `for`, `foreach`, `while`, `do-while`

> **Exam angle:** "Explain the pipeline" or "What is a cmdlet?"

---

## 4. Remoting, Modules, and Error Handling

### PowerShell Remoting

PowerShell Remoting allows commands to run on remote computers using WS-Management (WinRM).

| Cmdlet            | Purpose                            |
| ----------------- | ---------------------------------- |
| `Invoke-Command`  | Run a script block remotely        |
| `Enter-PSSession` | Open an interactive remote session |

### Modules

Modules are packages of cmdlets and functions.

```powershell
Get-Module -ListAvailable
Import-Module ModuleName
```

### Error Handling

PowerShell supports `try`, `catch`, and `finally` blocks for robust script error handling.

```powershell
try {
    Get-Service -Name "wuauserv" -ErrorAction Stop
}
catch {
    Write-Host "Service not found"
}
finally {
    Write-Host "Check complete"
}
```

The `-ErrorAction` parameter controls behavior such as `Continue`, `Stop`, and `SilentlyContinue`.

---

## 5. Common Cmdlets and Execution Policy

### Common Cmdlets

| Cmdlet                | Purpose                          |
| --------------------- | -------------------------------- |
| `Get-Help`            | Show help for cmdlets            |
| `Get-Command`         | List available cmdlets/functions |
| `Get-Service`         | View services                    |
| `Get-Process`         | List running processes           |
| `Set-ExecutionPolicy` | Set script execution policy      |
| `New-Item`            | Create file system items         |
| `Remove-Item`         | Remove file system items         |
| `Get-EventLog`        | View event logs                  |

### Execution Policy

PowerShell restricts scripts for security.

| Policy           | Behavior                                                 |
| ---------------- | -------------------------------------------------------- |
| **Restricted**   | No scripts allowed; default on many systems              |
| **RemoteSigned** | Local scripts allowed; downloaded scripts must be signed |
| **Unrestricted** | All scripts can run, but warnings may appear             |

---

## 6. Advanced Features

- **Desired State Configuration (DSC)** - declarative configuration management
- **PowerShell Jobs** - background and asynchronous tasks
- **Custom functions and scripts** - extend PowerShell behavior
- **Native/.NET interoperability** - works with native commands, .NET classes, and COM objects
