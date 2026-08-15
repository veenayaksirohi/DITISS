---
title: 06 - Ansible YAML and Configuration Management
aliases:
  - IaC (Ansible Focus), Ansible Deep Dive & YAML — Revision Notes
  - Ansible_YAML_Notes
tags:
  - devops
  - ansible
  - yaml
  - configuration-management
  - interview-preparation
syllabus-topic:
  - 6
  - 7
  - 11
---

# IaC (Ansible Focus), Ansible Deep Dive & YAML — Revision Notes

---

## PART 1: IaC — PROVISIONING vs CONFIGURATION MANAGEMENT

### 1.1 What is IaC (Recap)

**IaC** = creating/managing infrastructure using code instead of manual setup.

Infrastructure can include: VMs/servers, networks/subnets, load balancers, databases, security groups/firewalls, OS packages, application configuration.

**Without IaC (manual):**
```
Open Console → Create EC2 → SSH in → Install Apache/NGINX →
Configure LB → Repeat for every server
```
Problems: human errors, inconsistent configs, slow to recreate, hard to track changes, hard to scale.

**With IaC:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```
```
IaC code → IaC tool → Cloud API → Infrastructure
```

### 1.2 Two Broad Categories of IaC Tools

| Category | Purpose | Tools |
|---|---|---|
| **Provisioning** | Creates infra resources (VMs, VPCs, subnets, LBs, DBs, K8s clusters) | Terraform, Pulumi, AWS CloudFormation |
| **Configuration Management** | Configures OS/software *after* servers exist (install packages, users, files, services, security settings) | Ansible, Puppet, Chef, SaltStack |

> ⚠️ Not a strict boundary — Terraform can do limited config tasks, and Ansible can create cloud resources. But **primary use** stays as above.

**Common combo (memorize):**
```
Terraform creates server → Ansible configures server
```

### 1.3 Declarative vs Imperative (Recap with Ansible angle)

| Declarative | Imperative |
|---|---|
| Describe *what* should exist | Describe *how* to do it, step by step |
| Tool decides the steps | You write every step |
| Usually easier to make idempotent | Idempotency must often be handled manually |
| Example: Terraform, Puppet, K8s YAML, most Ansible modules | Example: Bash script, Python script |

```hcl
# Declarative
resource "aws_instance" "web" { instance_type = "t2.micro" }
```
```bash
# Imperative
sudo apt update
sudo apt install apache2 -y
sudo systemctl start apache2
```

### 1.4 Benefits of IaC (Quick List)

| Benefit | Key Point |
|---|---|
| Consistency | Same code → same config every time (fixes "works on my machine") |
| Version Control | Git: review, history, blame, rollback, PRs |
| Automation | CI/CD pipelines — GitHub Actions, Jenkins, HCP Terraform |
| Scalability | `count = 100` → creates 100 identical instances |
| Disaster Recovery | Code helps rebuild — but **not** a complete DR solution by itself (still need DB/storage/state/secret backups) |

### 1.5 Idempotency (Deep Dive)

> **Idempotency** = running automation multiple times produces the **same final result** without duplicate/unnecessary changes.

**Ansible example:**
```yaml
- name: Install Apache
  ansible.builtin.apt:
    name: apache2
    state: present
```
```
1st run: Apache missing   → Installed        (changed)
2nd run: Apache present   → No action taken  (ok)
5th run: Apache present   → No action taken  (ok)
```

**Why it matters:**
- Prevents duplicate resources
- Avoids unnecessary changes
- Safe to re-run automation
- Helps recover from partial failures
- Predictable infra, fewer config errors

**Bash comparison (NOT idempotent by default):**
```bash
sudo apt install apache2 -y     # ❌ may act every time
```
Manual fix needed:
```bash
if ! dpkg -s apache2 >/dev/null 2>&1; then
  sudo apt install apache2 -y
fi
```
✅ Ansible modules do this state-checking **automatically**.

> ⚠️ Correction: Idempotency depends on the **module**. Raw shell/command tasks are NOT automatically idempotent — the script/command must handle it itself.

### 1.6 Push-Based vs Pull-Based Architecture ⭐ (High-yield topic)

#### Push-Based
Controller **initiates** and sends config to nodes.
```
                    ┌──→ Managed Node 1
Control Node/Master ├──→ Managed Node 2
                    └──→ Managed Node 3
```
**Workflow:** admin stores config on control node → runs `ansible-playbook site.yaml` → Ansible connects via SSH → applies config.

**Examples:** Ansible, SaltStack (push mode)

**Pros:** simple, immediate changes, real-time control, no permanent agent needed (Ansible)
**Cons:** control node must reach every node; firewall/network must allow; scaling to 1000s of nodes needs extra design

#### Pull-Based
Agent on each node **initiates**, periodically contacts central server, downloads & applies config.
```
Managed Node 1 ──┐
Managed Node 2 ──┼──→ Central Configuration Server
Managed Node 3 ──┘
```
**Workflow:** config stored centrally → agent on every node → agents poll periodically → download config → apply locally.

Example command (Puppet): `puppet agent --test`

**Examples:** Puppet, Chef, SaltStack (pull mode)

**Pros:** scales well to large fleets; nodes self-correct; brief central-server outage doesn't stop already-running services; nodes initiate (fits some restricted networks)
**Cons:** needs agent on every node; more complex setup; changes not immediate (depends on poll interval); agents need install/update/monitoring

#### Push vs Pull — Comparison Table

| Point | Push-based | Pull-based |
|---|---|---|
| Who initiates | Controller | Managed-node agent |
| Permanent agent | Usually no (Ansible) | Yes |
| Change execution | Immediate | Periodic (polling) |
| Example tools | Ansible, SaltStack (push) | Puppet, Chef, SaltStack (pull) |
| Setup complexity | Simpler | More complex |
| Large-scale mgmt | Needs extra design | Naturally suited |
| Network requirement | Controller → nodes | Nodes → central server |
| Speed | Usually immediate | Depends on interval |

### 1.7 Agentless vs Agent-Based

| Agentless | Agent-Based |
|---|---|
| No permanent management agent | Agent installed on every node |
| Simpler initial setup | Extra installation required |
| Example: **Ansible** (SSH/WinRM) | Examples: **Puppet, Chef** (Puppet Agent, Chef Client, Salt Minion) |
| Usually push-based | Usually pull-based |

```
Agentless:   Ansible Control Node ──SSH──→ Linux Server
Agent-based: Central Server ←── Agent ──── Managed Node
```

### 1.8 Master Tool Comparison Table

| Tool | Category | Style | Architecture |
|---|---|---|---|
| Terraform | Provisioning | Declarative | API-based execution |
| CloudFormation | AWS provisioning | Declarative | AWS-managed |
| Pulumi | Provisioning | Declarative (general-purpose langs) | API-based execution |
| Ansible | Config mgmt + automation | Mainly declarative modules | Push-based, agentless |
| Puppet | Config management | Declarative | Pull-based, agent-based |
| Chef | Config management | Code-driven | Pull-based, agent-based |
| SaltStack | Config management | Declarative/imperative mix | Push or pull |

---

## PART 2: ANSIBLE — CORE CONCEPTS

### 2.1 What is Ansible?

- **Open-source IT automation tool**
- Automates: installing software, configuring servers, creating users, copying files, deploying apps, security patches, provisioning cloud resources, managing network devices
- Automation written in **Playbooks** using **YAML**

> "Ansible lets you describe what a system should look like, then performs the required tasks."

### 2.2 Ansible Architecture — 2 Main Systems

#### 1. Control Node
Machine where Ansible is **installed and run**.
- Reads inventory
- Reads playbook
- Connects to managed nodes
- Sends tasks
- Collects results

```bash
ansible-playbook webserver.yaml
```

> Linux/macOS/WSL are normal control nodes. **Native Windows is not normally used as a control node** (but CAN be a managed/target node).

#### 2. Managed Nodes
Target systems Ansible configures: Linux servers, Windows servers, cloud VMs, routers/switches, DB servers.

```
                    SSH
Control Node ──────────────→ Linux Server 1
      │
      ├──────── SSH ───────→ Linux Server 2
      │
      └──────── WinRM/PSRP → Windows Server
```

**Connection methods:**

| Target | Connection |
|---|---|
| Linux/Unix server | SSH |
| Windows server | WinRM or PSRP |
| Network device | SSH, network CLI, or API |
| Cloud service | Cloud provider API |
| Local system | Local connection |

> ⚠️ Managed nodes usually don't need Ansible installed, but **still need**: SSH access, valid user account, sudo permissions, Python (Linux) or PowerShell (Windows), network/firewall connectivity. "Agentless" ≠ "nothing required."

### 2.3 Ansible Workflow (End-to-End)

```
Inventory + Playbook
         ↓
   Ansible Control Node
         ↓
   SSH / WinRM / PSRP
         ↓
     Managed Nodes
         ↓
   Execution Results
         ↓
   Back to Control Node
```

**Steps:**
1. Define targets in **inventory**
2. Write tasks in a **playbook**
3. Run playbook from control node
4. Ansible connects to targets
5. Checks current state
6. Performs required changes
7. Reports results

### 2.4 Key Ansible Components — Master Table

| Component | Meaning |
|---|---|
| Control node | Machine where Ansible commands run |
| Managed node | Target machine managed by Ansible |
| Inventory | List of managed hosts and groups |
| Playbook | YAML file containing automation instructions |
| Play | Connects a host group with a set of tasks |
| Task | One automation operation |
| Module | Code that performs the task's action |
| Collection | Package of modules, plugins, roles |
| Role | Reusable structure for organizing automation |
| Variable | Value that can differ between systems |
| Handler | Task triggered only when notified |
| Template | Dynamic config file (usually Jinja2) |
| Ansible Vault | Encrypts sensitive data |

### 2.5 Key Features of Ansible (Exam Favorite Section)

#### a) Agentless
Uses SSH (Linux/Unix), WinRM/PSRP (Windows), cloud APIs, device-specific connections.
**Benefits:** no permanent agent, low maintenance, uses existing SSH infra.
> ⚠️ Still needs SSH access, account, sudo, Python/PowerShell, network connectivity.

#### b) Simple YAML Syntax
See PART 4 for full YAML rules.

#### c) Idempotency
(Covered in 1.5 above) — Results types:

| Result | Meaning |
|---|---|
| `ok` | Already in desired state |
| `changed` | Ansible made a change |
| `failed` | Task could not complete |
| `skipped` | Intentionally not executed |
| `unreachable` | Couldn't connect to host |

#### d) Desired-State Configuration
Ansible checks/applies desired state **only when the playbook runs** — it does NOT continuously monitor.
```
Playbook runs → State checked & corrected
Manual change happens later
Playbook runs again → State corrected again
```

#### e) Cross-Platform Support
Linux, Windows, Unix-like, cloud (AWS/Azure/GCP), containers, K8s, VMware, routers/switches/firewalls/LBs (Cisco, Juniper).

#### f) Extensibility
Modules, plugins, collections, roles. Custom modules/plugins can be developed too.

#### g) Inventory Management
See PART 3.

#### h) Push-Based Operation
(Covered in 1.6)

#### i) Event-Driven Automation
```
Monitoring alert → Automation rule → Ansible playbook → Remediation
```
**Event-Driven Ansible** is purpose-built for this; AWX / Ansible Automation Platform manage jobs, workflows, schedules, API triggers.

### 2.6 Common Ansible Use Cases

| Use Case | Examples |
|---|---|
| **Provisioning** | Cloud VMs, containers, storage, networks, LBs (though Terraform usually preferred for heavy infra) |
| **Configuration Management** | Install packages, create users/groups, configure SSH, firewall rules, copy files, configure services |
| **Application Deployment** | Copy app files, install deps, update env vars, DB migration, restart services, health checks |
| **Orchestration** | Coordinate multi-step, multi-system tasks in order (e.g., rolling deployments) |
| **Security & Compliance** | Patches, disable insecure services, password policy, firewall config, SSH key mgmt, audit collection |

**Common combo workflow:**
```
Terraform creates infrastructure
             ↓
Ansible installs and configures software
```

**Orchestration example (rolling deployment):**
```
1. Remove server from load balancer
2. Stop application
3. Deploy new version
4. Start application
5. Health check
6. Add server back to load balancer
7. Repeat for next server
```

### 2.7 Complete Example

**Inventory (`inventory.ini`):**
```ini
[webservers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu
web2 ansible_host=192.168.1.11 ansible_user=ubuntu
```

**Playbook (`apache-playbook.yaml`):**
```yaml
---
- name: Configure Apache web servers
  hosts: webservers
  become: true

  tasks:
    - name: Update package information
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 3600

    - name: Install Apache
      ansible.builtin.apt:
        name: apache2
        state: present

    - name: Start and enable Apache
      ansible.builtin.service:
        name: apache2
        state: started
        enabled: true

    - name: Create home page
      ansible.builtin.copy:
        content: "Welcome to the Ansible web server\n"
        dest: /var/www/html/index.html
        owner: root
        group: root
        mode: "0644"
```

**Useful commands:**
```bash
ansible-playbook -i inventory.ini apache-playbook.yaml         # run
ansible-playbook --syntax-check -i inventory.ini apache-playbook.yaml  # syntax check
ansible all -i inventory.ini -m ansible.builtin.ping            # connectivity test
```

> ⚠️ Ansible's `ping` module ≠ ICMP `ping` command — it tests Ansible connectivity + ability to run a module (Python on target, etc.)

### 2.8 Why Choose Ansible? (Interview Points)

| Reason | Detail |
|---|---|
| Simple learning curve | Readable YAML, minimal programming needed for basics |
| Agentless | No permanent agent, uses existing SSH, easy to adopt |
| Large ecosystem | Modules/collections for OS, cloud, network, DB, containers, security |
| Cost-effective | Core tools open source (enterprise platform/support costs extra) |
| Security | Encrypted SSH/WinRM, key-based auth, `become` privilege escalation, Ansible Vault |
| Scalability | Parallel execution, dynamic inventories, reusable roles, controllers |

### 2.9 Ansible Community vs Enterprise

| Option | Meaning |
|---|---|
| Ansible Core | Main CLI automation engine |
| Ansible Community Package | Core + selected community collections |
| AWX | Open-source web UI/controller project |
| Red Hat Ansible Automation Platform | Commercial enterprise platform |

---

## PART 3: INVENTORY, MODULES, PLUGINS, ROLES (Deep Dive)

### 3.1 Inventory

Defines systems Ansible can manage — hostnames, IPs, FQDNs, groups, host/group variables, connection info.

Default location (traditional): `/etc/ansible/hosts` — but project-specific inventory is more common:
```
ansible-project/
├── inventory.ini
├── ansible.cfg
└── site.yaml
```

#### Static Inventory (manually written)

```ini
# single host
webserver ansible_host=192.168.1.10

# group
[webservers]
web1 ansible_host=192.168.1.11
web2 ansible_host=192.168.1.12

# multiple groups + group vars
[databases]
db1 ansible_host=192.168.1.20

[all:vars]
ansible_user=ubuntu

# host-specific variables
[webservers]
web1 ansible_host=192.168.1.11 http_port=80
web2 ansible_host=192.168.1.12 http_port=8080
```

#### Dynamic Inventory
Auto-generated from external source (AWS, Azure, GCP, VMware, OpenStack, K8s).
```
Cloud provider → API query → Dynamic inventory plugin → Current host list → Playbook
```
Useful when VMs are created/deleted often (auto-scaling).

**Static vs Dynamic:**

| Static | Dynamic |
|---|---|
| Manually written | Generated from external source |
| Best for stable environments | Best for frequently changing environments |
| Simple | Requires plugin config |
| Manual updates | Auto-discovery |
| INI/YAML file | e.g., AWS inventory plugin |

**Inventory commands:**
```bash
ansible-inventory -i inventory.ini --list
ansible-inventory -i inventory.ini --graph
ansible webservers -i inventory.ini --list-hosts
ansible all -i inventory.ini -m ansible.builtin.ping
```

### 3.2 Modules, Plugins, Playbooks — Terminology (Important distinction)

| Component | Meaning |
|---|---|
| Playbook | YAML file containing one or more **plays** |
| Play | Applies a set of tasks to selected hosts |
| Task | One named automation step |
| Module | Function a task uses to actually perform the work |
| Plugin | Extends/modifies Ansible's **internal** behavior (not the "work" itself) |

```yaml
---
- name: Configure web servers             # Play
  hosts: webservers
  tasks:
    - name: Install NGINX                 # Task
      ansible.builtin.dnf:                # Module
        name: nginx
        state: present
```

#### Plugin Types

| Plugin | Purpose |
|---|---|
| Action plugin | Controls how a module/task is prepared & executed |
| Connection plugin | Defines how Ansible connects to a target (e.g., SSH) |
| Callback plugin | Controls output/logging/notifications |
| Lookup plugin | Retrieves data from files/external systems |
| Inventory plugin | Dynamically produces inventory |
| Filter plugin | Transforms variable values |
| Cache plugin | Stores facts/inventory info |
| Become plugin | Provides privilege-escalation methods |

```yaml
# Lookup plugin
password: "{{ lookup('env', 'APP_PASSWORD') }}"

# Filter plugin
server_name: "{{ inventory_hostname | upper }}"
```

### 3.3 Facts

Info **collected from managed nodes** automatically: OS name/family, IPs, hostname, CPU/memory, network interfaces, storage.

Collected by module: `ansible.builtin.setup`

```bash
ansible all -i inventory.ini -m ansible.builtin.setup
ansible all -i inventory.ini -m ansible.builtin.setup -a "filter=ansible_distribution"
```

Usage:
```yaml
- name: Display operating system
  ansible.builtin.debug:
    msg: "This system runs {{ ansible_distribution }}"

- name: Install Apache on Debian-based systems
  ansible.builtin.apt:
    name: apache2
    state: present
  when: ansible_os_family == "Debian"
```

### 3.4 Variables, Conditionals, Loops

**Variables:**
```yaml
vars:
  http_port: 80
  package_name: nginx
tasks:
  - name: Install web-server package
    ansible.builtin.package:
      name: "{{ package_name }}"
```
Sources: playbooks, inventory, host vars, group vars, roles, facts, var files, CLI args, external secrets.

**Conditionals:**
```yaml
- name: Install Apache on Debian systems
  ansible.builtin.apt:
    name: apache2
    state: present
  when: ansible_os_family == "Debian"
```

**Loops:**
```yaml
- name: Install required packages
  ansible.builtin.apt:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - git
    - curl
```

### 3.5 Handlers

Special task that runs **only when notified** by another task — typically used to restart services after config changes.

```yaml
tasks:
  - name: Copy NGINX configuration
    ansible.builtin.copy:
      src: nginx.conf
      dest: /etc/nginx/nginx.conf
      mode: "0644"
    notify: Restart NGINX

handlers:
  - name: Restart NGINX
    ansible.builtin.service:
      name: nginx
      state: restarted
```
```
Config unchanged → Handler does NOT run
Config changed   → Handler runs (once, usually at end of play)
```

### 3.6 Roles

Standard directory structure for reusable automation.

```
roles/
└── webserver/
    ├── tasks/main.yaml
    ├── handlers/main.yaml
    ├── templates/
    ├── files/
    ├── defaults/main.yaml
    └── vars/main.yaml
```
```yaml
- name: Configure web servers
  hosts: webservers
  become: true
  roles:
    - webserver
```
Benefits: reusability, organization, maintainability, team collaboration.

### 3.7 Ansible Vault

Encrypts sensitive data — passwords, API keys, tokens, DB credentials.

```bash
ansible-vault create secrets.yaml        # create encrypted file
ansible-vault edit secrets.yaml           # edit
ansible-vault encrypt secrets.yaml        # encrypt existing file
ansible-playbook site.yaml --ask-vault-pass   # run with vault
```
> Vault protects file contents — but access control, secret handling & logging must still be managed carefully elsewhere.

### 3.8 Execution Environment

A **container image** with everything needed to run automation consistently: Ansible Core, Ansible Runner, Python version, libraries, collections, system packages.

```
Without EE: Dev system, CI/CD, automation server → may use different versions → inconsistent results
With EE:    Same container everywhere → consistent, portable, reproducible
```
Optional for basic CLI use; common in controlled automation platforms.

### 3.9 Full Ansible Workflow (Step-by-Step)

```bash
# 1. Prepare inventory
[webservers]
web1 ansible_host=192.168.1.11 ansible_user=admin

# 2. Test connectivity
ansible webservers -i inventory.ini -m ansible.builtin.ping

# 3. Write playbook (see example above)

# 4. Syntax check
ansible-playbook -i inventory.ini site.yaml --syntax-check

# 5. Preview with check mode (dry run — not perfectly accurate for every module)
ansible-playbook -i inventory.ini site.yaml --check

# 6. Execute
ansible-playbook -i inventory.ini site.yaml
```

**Play recap example:**
```
PLAY RECAP
web1 : ok=4 changed=2 unreachable=0 failed=0 skipped=0
web2 : ok=4 changed=1 unreachable=0 failed=0 skipped=0
```

### 3.10 Playbook Structure Reference

| Component | Purpose |
|---|---|
| `name` | Human-readable description |
| `hosts` | Target host/group |
| `become` | Enables privilege escalation (sudo) |
| `vars` | Defines variables |
| `tasks` | Automation steps |
| `handlers` | Notified tasks |
| `roles` | Reusable automation |
| `when` | Conditions |
| `loop` | Repeats a task |

---

## PART 4: COMMON ANSIBLE MODULES (Reference Table)

Use **FQCN** (Fully Qualified Collection Name) where possible: `collection_namespace.collection_name.module_name` — e.g. `ansible.builtin.service`.

### 4.1 Service Management

```yaml
- name: Start and enable NGINX
  ansible.builtin.service:
    name: nginx
    state: started
    enabled: true
```

| State | Meaning |
|---|---|
| `started` | Must be running |
| `stopped` | Must be stopped |
| `restarted` | Restart it |
| `reloaded` | Reload config, no full restart |

**`service` vs `systemd_service`:**

| `service` | `systemd_service` |
|---|---|
| General interface, portable | Systemd-specific options |
| Works via detected service manager | Requires systemd target |

```yaml
- name: Restart Apache using systemd
  ansible.builtin.systemd_service:
    name: httpd
    state: restarted
    enabled: true
    daemon_reload: true    # = systemctl daemon-reload
```

### 4.2 Users & Groups

```yaml
- name: Create application user
  ansible.builtin.user:
    name: appuser
    shell: /bin/bash
    create_home: true
    state: present

- name: Create developers group
  ansible.builtin.group:
    name: developers
    state: present

- name: Add user to group
  ansible.builtin.user:
    name: veenayak
    groups: [developers]
    append: true    # ⚠️ without this, other groups get removed!
```

### 4.3 Firewall / Networking

```yaml
# RHEL-based (needs ansible.posix collection)
- name: Allow HTTPS through FirewallD
  ansible.posix.firewalld:
    service: https
    permanent: true
    immediate: true
    state: enabled

# Ubuntu (needs community.general collection)
- name: Allow SSH through UFW
  community.general.ufw:
    rule: allow
    port: "22"
    proto: tcp
```

```yaml
# HTTP API interaction
- name: Check application health
  ansible.builtin.uri:
    url: http://192.168.1.10:8080/health
    method: GET
    status_code: 200
```

### 4.4 Database Modules (separate collections)

```yaml
# MySQL (community.mysql)
- name: Create application database
  community.mysql.mysql_db:
    name: application_db
    state: present
    login_user: root
    login_password: "{{ mysql_root_password }}"

# PostgreSQL (community.postgresql)
- name: Create PostgreSQL application user
  community.postgresql.postgresql_user:
    name: appuser
    password: "{{ database_password }}"
    state: present
```

### 4.5 Cloud & Virtualization

```yaml
# AWS (amazon.aws collection)
- name: Create an EC2 instance
  amazon.aws.ec2_instance:
    name: web-server
    image_id: ami-1234567890abcdef0
    instance_type: t3.micro
    region: ap-south-1
    exact_count: 1

# Azure (azure.azcollection)
- name: Create an Azure resource group
  azure.azcollection.azure_rm_resourcegroup:
    name: application-resources
    location: centralindia

# Docker (community.docker)
- name: Run NGINX container
  community.docker.docker_container:
    name: nginx-web
    image: nginx:latest
    state: started
    restart_policy: always
    ports: ["8080:80"]
```

### 4.6 Command Execution — `command` vs `shell` vs `raw` ⭐ (Frequently tested)

| Module | Runs through shell? | Common use |
|---|---|---|
| `command` | No | Safe execution of simple commands |
| `shell` | Yes | Pipes, redirection, shell features |
| `raw` | Direct remote execution | Bootstrapping systems without Python |
| Dedicated module | N/A | **Always preferred** when one exists |

```yaml
# command — no shell features (pipes/redirects fail!)
- name: Display uptime
  ansible.builtin.command:
    cmd: uptime

# This will NOT work as expected with `command`:
# ansible.builtin.command: cmd: ps aux | grep nginx

# Idempotency helper for command:
- name: Create DB only if marker missing
  ansible.builtin.command:
    cmd: /opt/create-database.sh
    creates: /opt/database-created

# shell — supports pipes/redirection
- name: Find NGINX process
  ansible.builtin.shell:
    cmd: ps aux | grep '[n]ginx' > /tmp/nginx-processes.txt

# raw — for bootstrapping (e.g., Python not yet installed)
- name: Install Python for Ansible
  ansible.builtin.raw: apt-get update && apt-get install -y python3
```

> ⚠️ Prefer a **dedicated module** over `shell`/`command` whenever possible — e.g., `ansible.builtin.service` instead of `shell: systemctl start nginx`. Reduces security risk, quoting issues, portability & idempotency problems.

### 4.7 Other Useful Modules

```yaml
# Cron job
- name: Create daily backup job
  ansible.builtin.cron:
    name: Daily application backup
    minute: "0"
    hour: "2"
    job: /opt/scripts/backup.sh
    user: root

# Git clone
- name: Clone application repository
  ansible.builtin.git:
    repo: https://github.com/example/application.git
    dest: /opt/application
    version: main

# Debug / display
- name: Display HTTP port
  ansible.builtin.debug:
    var: http_port
```

---

## PART 5: ANSIBLE GALAXY, AWX & AUTOMATION CONTROLLER

### 5.1 Ansible Galaxy

Public platform + CLI tool for finding/sharing/installing reusable content: **Roles** and **Collections**.

```
Ansible Galaxy → Download role/collection → Use in playbook
```

**Role vs Collection:**

| Role | Collection |
|---|---|
| Organizes automation for **one purpose** | Larger package: multiple roles + modules + plugins + playbooks + docs |
| Example: `nginx` role | Example: `community.docker` collection |

**Common commands:**
```bash
ansible-galaxy search nginx
ansible-galaxy role install geerlingguy.nginx
ansible-galaxy role init webserver
ansible-galaxy collection install community.docker
ansible-galaxy collection init veenayak.system_tools
ansible-galaxy collection list
```

**requirements.yaml (dependency management):**
```yaml
---
roles:
  - name: geerlingguy.nginx
collections:
  - name: community.docker
  - name: community.mysql
  - name: amazon.aws
```
```bash
ansible-galaxy install -r requirements.yaml
```

> ⚠️ There's no official universal Galaxy "quality score" as a standard current feature. Evaluate community content via: docs, recent updates, supported Ansible versions, repo activity, issue history, downloads, maintainer reputation.

### 5.2 Ansible Tower → AWX → Automation Controller (Naming History — Common Exam Trap)

> ⚠️ **Ansible Tower** = OLD commercial product name. It was renamed/replaced by **Automation Controller**, a component of **Red Hat Ansible Automation Platform**.
> **AWX** = open-source **upstream** project providing similar controller capabilities (community version).

```
AWX (open-source upstream)
          ↓
Automation Controller (supported component of Red Hat AAP)
          ↑
Previously called "Ansible Tower"
```

### 5.3 Why Use a Controller (AWX/Automation Controller)?

Plain CLI: `ansible-playbook -i inventory.ini deploy.yaml`

Controller adds:
```
Users/Teams → AWX/Controller → Inventory+Credentials+Projects
           → Job templates & workflows → Execution environments → Infra
```

**Main Features:**

| Feature | What it does |
|---|---|
| Web-based interface | Launch playbooks, view jobs/output, manage inventories/projects, workflows, schedules |
| RBAC | Controls who can do what (dev/ops/security/admin roles) |
| Centralized credentials | Stores SSH keys, vault passwords, cloud creds — users don't see secret values |
| Job templates | Saved settings: project, playbook, inventory, creds, variables, EE |
| Workflow automation | Chains job templates with success/failure branches |
| Scheduling | Run automation at set times (patch every Sunday, nightly reports) |
| Logging & auditing | Who ran what, when, on which hosts, success/failure |
| Notifications | Email, Slack, PagerDuty on job start/success/fail |
| REST API | External systems (CI/CD) can launch/monitor jobs |
| Scalability | Distributes work across execution capacity |

### 5.4 CLI vs AWX vs Automation Controller

| Feature | Ansible CLI | AWX | Automation Controller |
|---|---|---|---|
| Command-line execution | Yes | Via managed jobs | Via managed jobs |
| Web interface | No | Yes | Yes |
| Job templates | No | Yes | Yes |
| RBAC | OS-level only | Yes | Yes |
| Scheduling | External tool needed | Built-in | Built-in |
| Workflow designer | No | Yes | Yes |
| Central logging | Manual setup | Yes | Yes |
| Open source | Yes | Yes | No (enterprise subscription) |
| Support | Community | Community | Red Hat support |
| Old name | — | — | Ansible Tower |

---

## PART 6: YAML BASICS ⭐ (Foundation for Ansible/K8s/Docker Compose/CI-CD)

### 6.1 What is YAML?

- **YAML** = "**YAML Ain't Markup Language**" (recursive acronym)
- A **human-readable data serialization standard** (NOT a markup language like HTML/XML)
- Used for: **Ansible playbooks, Kubernetes manifests, Docker Compose, CI/CD pipeline configs**
- **Goal:** easy for humans to read/write, portable across programming languages

### 6.2 Basic Syntax Rules (Memorize — Exam Favorite)

| Rule | Detail |
|---|---|
| **Case-sensitive** | `Name` ≠ `name` |
| **Whitespace-sensitive** | Indentation defines structure — **use spaces only, NEVER tabs** |
| **Comments** | Start with `#` — **single-line only** (no multi-line comment syntax) |
| **File extensions** | `.yaml` or `.yml` |

```yaml
# This is a comment
name: veenayak     # inline comment example
```

### 6.3 Key Features of YAML

| Feature | Explanation |
|---|---|
| Matches native data structures | Maps naturally to structures in Perl, Python, PHP, Ruby, JavaScript (lists, dicts/maps) |
| Portable | Same YAML can be parsed across different programming languages |
| Consistent data model | Predictable structure/behavior across implementations |
| Human-readable | Easy to read/write compared to XML/JSON |
| One-direction processing | Can be processed as a data stream (no need to see the whole document to start parsing, generally sequential) |
| Easy implementation & usage | Simple to adopt in tools and pipelines |

### 6.4 Core Rules — Details & Examples

#### a) Case Sensitivity
```yaml
Name: Veenayak
name: veenayak
```
These are **two different keys** — YAML treats `Name` and `name` as distinct.

#### b) No Tabs — Spaces Only
```yaml
# ❌ WRONG (using a tab character) → causes a parsing error
tasks:
	- name: Install NGINX

# ✅ CORRECT (using spaces)
tasks:
  - name: Install NGINX
```
> Indentation is how YAML shows **structure/nesting** — inconsistent indentation is one of the most common YAML errors.

#### c) Comments
```yaml
# This is a valid single-line comment
name: nginx   # comment must be separated from other tokens by whitespace
```
- Comments must have **whitespace before the `#`** if placed after content.
- ⚠️ YAML has **no block/multi-line comment syntax** — every commented line needs its own `#`.

#### d) File Extension
Always save as `.yaml` or `.yml` — both are valid and equivalent; teams usually pick one convention consistently.

### 6.5 YAML Data Structures (Practical, used constantly in Ansible)

**Key-value pair (scalar):**
```yaml
name: nginx
port: 80
enabled: true
```

**List / Sequence** (`-` prefix):
```yaml
packages:
  - nginx
  - git
  - curl
```

**Dictionary / Mapping (nested):**
```yaml
server:
  name: web1
  ip: 192.168.1.10
  port: 80
```

**List of dictionaries (very common in Ansible tasks):**
```yaml
tasks:
  - name: Install NGINX
    ansible.builtin.apt:
      name: nginx
      state: present
  - name: Start NGINX
    ansible.builtin.service:
      name: nginx
      state: started
```

### 6.6 Why Ansible Uses YAML

- Human-readable → playbooks are easy to review, even for non-programmers
- Structured (nested key-values/lists) → maps naturally to tasks, variables, handlers, roles
- Widely adopted → same skillset transfers to Kubernetes, Docker Compose, CI/CD

### 6.7 Common YAML Mistakes (Exam Trap List)

| Mistake | Why it fails |
|---|---|
| Using **tabs** for indentation | YAML forbids tabs — spaces only |
| Inconsistent indentation | Breaks structure/nesting — parsing error |
| Missing space after `:` | `name:nginx` ❌ → should be `name: nginx` ✅ |
| Missing `-` for list items | Breaks sequence parsing |
| Treating it as case-insensitive | `Name` and `name` are different keys |
| Assuming block comments exist | Only single-line `#` comments are supported |

### 6.8 Quick Revision — YAML

- **YAML** = YAML Ain't Markup Language — human-readable data serialization format.
- Used in: Ansible, Kubernetes, Docker Compose, CI/CD pipelines.
- **Case-sensitive**, **whitespace-sensitive** (spaces only, no tabs).
- Comments: single-line only, start with `#`.
- File extensions: `.yaml` / `.yml`.
- Portable across languages; matches native data structures (lists/maps).
- Common structures: scalars (`key: value`), lists (`- item`), mappings (nested `key:`), list-of-dicts.

---

## PART 7: IMPORTANT CORRECTIONS SUMMARY (High-Yield)

| Common Wrong Belief | Correct Understanding |
|---|---|
| YAML is a markup language | YAML is a **data-serialization** language |
| All Ansible tasks are idempotent | Most **modules** are idempotent; `shell`/`command`/custom scripts may NOT be |
| Ansible continuously enforces desired state | It checks/corrects **only when the playbook runs** |
| Managed nodes need nothing | They need connectivity, credentials, and often Python/PowerShell |
| Modules always run on managed nodes | Some run locally on the control node and call APIs |
| Inventory is always at `/etc/ansible/hosts` | That's the traditional default; project-specific inventories are common |
| Windows only uses WinRM | Windows can use **WinRM or PSRP** |
| `ec2` / `azure_rm` are the modern module names | Modern playbooks use FQCN: `amazon.aws.ec2_instance`, `azure.azcollection.azure_rm_resourcegroup` |
| Ansible Tower is the current product name | It was renamed to **Automation Controller** (Red Hat AAP); **AWX** is the open-source upstream |
| Galaxy has an official universal "quality score" | Not a standard current feature — evaluate via docs/activity/maintainer reputation |
| YAML allows tabs for indentation | **Tabs are forbidden** — spaces only |
| `command` module supports pipes/redirects | It does NOT — use `shell` for that |

---

## PART 8: EXAM ONE-LINERS

- **Provisioning tools** create infra (Terraform, Pulumi, CloudFormation); **Config management tools** configure it (Ansible, Puppet, Chef, SaltStack).
- **Push-based** = controller sends config (Ansible); **Pull-based** = agent fetches config (Puppet/Chef).
- **Agentless** = no permanent agent (Ansible); **Agent-based** = agent runs on every node (Puppet/Chef).
- **Idempotency** = same automation run repeatedly → same end result, no duplicate changes.
- **Control node** = where Ansible runs; **Managed node** = target system.
- **Inventory** = list of managed hosts (static = manual, dynamic = auto-discovered).
- **Module** = performs the actual task work; **Plugin** = extends Ansible's internal behavior.
- **Play** → runs on hosts; **Task** → one step; **Handler** → runs only when notified.
- **Role** = reusable automation structure; **Collection** = larger package (roles+modules+plugins).
- **Ansible Vault** = encrypts secrets.
- **AWX** = open-source controller; **Automation Controller** = enterprise version (was "Ansible Tower").
- **YAML** = human-readable data format; case-sensitive; spaces only; `#` for single-line comments.
- **`command`** = no shell features; **`shell`** = supports pipes/redirection; **`raw`** = bootstrap without Python.

---

## PART 9: INTERVIEW-READY SUMMARY ANSWERS

**Q: What is the difference between provisioning tools and configuration management tools?**
> "Provisioning tools like Terraform create the infrastructure itself — VMs, networks, databases. Configuration management tools like Ansible then configure the software and settings on top of that infrastructure — installing packages, managing users, starting services. In practice, they're combined: Terraform provisions, Ansible configures."

**Q: Explain push vs pull architecture with examples.**
> "In push-based architecture, like Ansible, the control node initiates the connection and pushes configuration to managed nodes immediately, usually over SSH, with no permanent agent required. In pull-based architecture, like Puppet or Chef, an agent installed on each managed node periodically contacts a central server and pulls its configuration down. Push is simpler and immediate; pull scales better for very large fleets since nodes self-correct on their own schedule."

**Q: Why is idempotency important in automation?**
> "Idempotency ensures that running the same playbook or script multiple times produces the same final state without creating duplicates or unnecessary changes. This makes automation safe to re-run, helps recover from partial failures, and gives predictable, reliable infrastructure. Most Ansible modules are idempotent, but shell/command tasks are not by default and need explicit handling."

**Q: What is Ansible and how does it work?**
> "Ansible is an open-source, agentless IT automation tool that uses YAML-based playbooks to describe the desired state of systems. It follows a push-based model: the control node connects to managed nodes over SSH (or WinRM/PSRP for Windows), checks their current state using modules, and applies only the changes needed to reach the desired state."

**Q: What replaced Ansible Tower?**
> "Ansible Tower was renamed to Automation Controller, which is now a component of the Red Hat Ansible Automation Platform. AWX is the open-source upstream project that provides similar controller capabilities in the community edition."

---

*Notes consolidated from: IaC provisioning vs configuration management overview, Ansible introduction, Ansible architecture components (inventory/modules/plugins/roles/vault), common Ansible modules reference, Ansible Galaxy/AWX/Automation Controller, and YAML fundamentals.*

---

## Obsidian Navigation

- [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]]
- [[Index|Vault Index and Reading Order]]
- Related: [[05 - AWS Cloud Computing Virtualization and Data Center|AWS Cloud Computing, Virtualization, and Data Center]]
- Related: [[07 - Terraform and Infrastructure as Code|Terraform and Infrastructure as Code]]
