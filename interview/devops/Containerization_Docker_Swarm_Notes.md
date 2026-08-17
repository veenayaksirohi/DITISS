# Containerization, Docker & Docker Swarm — Complete Revision Notes

---

## PART 1: CONTAINERIZATION FUNDAMENTALS

### 1.1 What is Containerization?

> **Containerization = OS-level virtualization.** It packages an application with everything needed to run it (code, libraries, frameworks, runtime, dependencies, config files, system utilities) into one unit called a **container**.

> ⚠️ A container does NOT normally contain a complete guest operating system.

### 1.2 Why Containerization is Needed

**"It works on my machine"** problem:

| Component | Development | Staging | Production |
|---|---|---|---|
| OS | Windows | Ubuntu 24.04 | Ubuntu 24.04 |
| Python | 3.12 | 3.11 | 3.10 |
| NumPy | 1.26 | 2.1 | 2.0 |

Different environments → compatibility errors. A container packages the app **with** its exact dependency versions, so the same container runs identically everywhere.

### 1.3 Core Components

| Term | Meaning |
|---|---|
| **Container Image** | Read-only template (app code + runtime + libraries + config) |
| **Container** | Running instance of an image |
| **Container Runtime** | Software that creates/starts/stops/manages containers (Docker Engine, containerd, CRI-O, Podman) |

> **Image = blueprint, Container = running instance built from that blueprint.** One image → many containers.

### 1.4 Container Architecture

```
Applications inside containers
        ↓
Container Runtime
        ↓
Host Operating System
        ↓
Host Kernel and Device Drivers
        ↓
Physical or Virtual Hardware
```

All containers on one host **share the host OS kernel**.

### 1.5 Hardware Virtualization vs OS Virtualization ⭐

#### Hardware Virtualization (Virtual Machines)
```
Virtual Machines → Guest OS → Hypervisor → Physical Hardware
```
Each VM has: app, libraries, **guest OS**, virtual kernel, virtual hardware.
**Hypervisors:** VMware ESXi, Hyper-V, KVM, VirtualBox, VMware Workstation.

#### OS Virtualization (Containers)
```
Containers → Container Runtime → Shared Host OS Kernel → Hardware
```
Each container has its own: app, libraries, filesystem, processes, network interface, env vars, resource limits — but **shares the host kernel**.

---

## PART 1.6: HARDWARE VIRTUALIZATION vs OS VIRTUALIZATION — Full Architecture Diagram ⭐

### Hardware Virtualization (Bare Metal → Type I Hypervisor)

```
┌─────────────────────────┐   ┌─────────────────────────┐
│      Virtual Machine     │   │      Virtual Machine     │
│  ┌────────┐ ┌────────┐   │   │      ┌────────┐          │
│  │  App1  │ │  App2  │    │   │      │  App   │           │
│  └────────┘ └────────┘   │   │      └────────┘          │
│  Lib / Framework          │   │  Lib / Framework          │
│  email   calc            │   │                            │
│  Ubuntu (Guest OS)        │   │  Guest OS                  │
│  vHardware                │   │  vHardware                 │
└─────────────┬─────────────┘   └─────────────┬─────────────┘
              │                                │
              └────────────────┬───────────────┘
                                ▼
        ┌───────────────────────────────────────────┐
        │  vStorage    vCPU    vRAM                   │
        │  vAudio             vNIC                    │
        └───────────────────────────────────────────┘
                                ▼
        ┌───────────────────────────────────────────┐
        │              Hypervisor                     │
        └───────────────────────────────────────────┘
                                ▼
        ┌───────────────────────────────────────────┐
        │       HAL → Device Drivers                  │
        └───────────────────────────────────────────┘
                                ▼
        ┌───────────────────────────────────────────┐
        │  Storage         Memory                     │
        │  Audio    CPU    NIC                        │
        └───────────────────────────────────────────┘
                    Physical Hardware
```

**Layer-by-layer (bottom → top):**
1. **Physical hardware** — Storage, Memory, CPU, Audio, NIC
2. **HAL → Device Drivers** — Hardware Abstraction Layer
3. **Hypervisor** — divides physical hardware into VMs (Type I = bare-metal hypervisor, runs directly on hardware — e.g., VMware ESXi, Hyper-V, KVM)
4. **Virtual hardware** — vStorage, vCPU, vRAM, vAudio, vNIC (virtualized resources presented to each VM)
5. **Guest OS** — each VM has its own complete OS (e.g., Ubuntu) plus its own virtual hardware
6. **Libraries/Frameworks** — app-level dependencies inside the guest OS
7. **Applications** — one VM can run multiple apps (App1, App2 — e.g., email, calc)

> **Key point:** Every VM carries its own full guest OS + virtual hardware stack — this is why VMs are heavier (GBs in size, slower to boot).

---

### Operating System Virtualization (Sharing OS With the Machine)

```
        ┌─────────────────┐        ┌─────────────────┐
        │   Container 1     │        │   Container 2     │
        │   ┌────────┐      │        │   ┌────────┐      │
        │   │  App   │       │        │   │  App   │       │
        │   └────────┘      │        │   └────────┘      │
        │   dependencies     │        │   dependencies     │──┐
        └─────────┬─────────┘        └─────────┬─────────┘   │
                  │                              │             │  libraries
                  └──────────────┬───────────────┘             │  framework(s)
                                  ▼                              │  configuration files
                ┌───────────────────────────────┐               │  resources
                │       Container Runtime          │            ┘  OS libraries
                └───────────────────────────────┘
                                  ▼
                ┌───────────────────────────────┐
                │   OS → Kernel + Utilities        │
                │   HAL → Device Drivers            │
                └───────────────────────────────┘
                                  ▼
                ┌───────────────────────────────┐
                │  Storage           Memory         │
                │  Audio     CPU     NIC            │
                └───────────────────────────────┘
                    Physical or Virtual Machine
```

**Layer-by-layer (bottom → top):**
1. **Physical or virtual machine** — Storage, Memory, CPU, Audio, NIC (can itself be a VM — containers can run inside a VM too)
2. **OS → Kernel + Utilities / HAL → Device Drivers** — the **single, shared** host OS kernel
3. **Container Runtime** — creates/manages containers on top of the shared kernel (Docker Engine, containerd, CRI-O, Podman)
4. **Containers** — each container packages: **App + dependencies** — which expand out to:
   - Libraries
   - Framework(s)
   - Configuration files
   - Resources
   - OS libraries

> **Key point:** All containers share **one OS kernel** (via the container runtime) instead of each carrying a full guest OS — this is why containers are lightweight (MBs), start almost instantly, and use fewer resources than VMs.

### Side-by-Side Summary

| Layer | Hardware Virtualization (VMs) | OS Virtualization (Containers) |
|---|---|---|
| Top | App(s) + Lib/Framework | App + dependencies (libs, frameworks, config, resources) |
| Isolation boundary | **Guest OS** (each VM has its own) | **Container Runtime** (shared kernel underneath) |
| Middle | vHardware (vCPU/vRAM/vStorage/vNIC) | OS Kernel + Utilities + HAL/Device Drivers (shared, single instance) |
| Virtualization layer | **Hypervisor** (Type I = bare-metal) | *(no hypervisor needed)* |
| Bottom | HAL → Device Drivers → Physical Hardware | Physical or Virtual Machine (Storage/Memory/CPU/Audio/NIC) |

---

## PART 2: PROCESS-BASED ISOLATION ⭐ (High-yield topic)

### 2.1 What is Process-Based Isolation?

A container is essentially an **isolated group of processes** running on the host OS. E.g., Nginx inside a container is still a process on the host — isolation mechanisms just prevent it from freely seeing/controlling other processes.

The container gets an isolated view of: processes, network, filesystem, hostname, users, mounted storage, CPU/memory resources.

### 2.2 How Isolation Works — Two Key Kernel Features

#### a) Namespaces — control what a container CAN SEE

| Namespace | Isolates |
|---|---|
| PID | Processes & process IDs |
| Network | Interfaces, ports, routing |
| Mount | Filesystems & mount points |
| UTS | Hostname & domain name |
| IPC | Inter-process communication |
| User | User IDs & group IDs |
| Cgroup | Resource-control information |

**PID isolation example:**
```
Host:                          Inside Nginx container:
PID 1   systemd                PID 1   nginx
PID 500 database
PID 700 nginx container
PID 800 backend container
```
The container sees only its own isolated process list.

#### b) Control Groups (cgroups) — control HOW MUCH a container can USE

Limits/monitors: CPU, memory, disk I/O, process count, network resources.
```bash
docker run --memory="512m" --cpus="1" nginx
```

#### Additional Security Mechanisms
Linux capabilities, SELinux, AppArmor, Seccomp, read-only filesystems, non-root users.

> **Memory trick:** Namespaces = "what you can **see**"; Cgroups = "how much you can **use**."

### 2.3 Process Isolation vs Full (VM) Isolation

```
VM:        Application → Guest OS → Guest Kernel → Hypervisor
Container: Application → Isolated Process → Shared Host Kernel
```
Shared kernel = containers are smaller, faster, more efficient — but **provide less isolation** than VMs.

---

## PART 3: CONTAINERS vs VIRTUAL MACHINES — MASTER COMPARISON

| Feature | Virtual Machine | Container |
|---|---|---|
| Virtualization level | Hardware-level | OS-level |
| Size | GBs | MBs |
| OS | Each VM has guest OS | Share host kernel |
| Startup time | Seconds–minutes | Seconds or less |
| Resource usage | High | Low |
| Performance | Some overhead | Near-native |
| Isolation | Strong | Process-level (lighter) |
| Security | Generally stronger | Depends on host-kernel security |
| Portability | VM image movable | Highly portable |
| Provisioning | Slower | Fast |
| Instances/host | Fewer | More |
| Common use | Different OSs, strong isolation | Microservices, cloud-native |

> ⚠️ **Common misconception:** "Every container is a small VM." **FALSE.** VM virtualizes hardware and runs a full OS; a container isolates processes and shares the host kernel — that's WHY containers start faster & use fewer resources.

### 3.1 Portability Clarification

> ⚠️ "A container can run on any OS" is **not fully accurate.**
- Linux containers need a Linux kernel.
- Windows containers need a compatible Windows kernel.
- Must match CPU architecture (AMD64/ARM64).
- Docker Desktop runs Linux containers on Windows/macOS via an internal lightweight Linux VM.

> ✅ Accurate statement: "A container runs consistently on any compatible platform that provides the required runtime, kernel, and CPU architecture."

---

## PART 4: BENEFITS OF CONTAINERIZATION

| Benefit | Explanation |
|---|---|
| **Portability** | Same image: dev laptop → test → staging → prod |
| **Efficiency** | No full guest OS → less memory/storage, faster start, more apps/host |
| **Consistency** | Same environment across dev/test/staging/prod |
| **Scalability** | Multiple instances started quickly (horizontal scaling) |
| **Isolation** | Different apps can use different library versions without conflict |
| **Version Control** | Tag images: `myapp:1.0`, `myapp:1.1`, `myapp:2.0` — easy rollback |
| **Fast Deployment** | No OS boot needed → great for CI/CD, microservices, auto-scaling |

### 4.1 Vertical vs Horizontal Scaling

| Vertical Scaling | Horizontal Scaling |
|---|---|
| Increase CPU/memory of ONE instance | Add MORE container instances |
| Example: 2 vCPU → 4 vCPU | Example: 1 backend container → 4 backend containers |

Kubernetes can auto-scale container count based on CPU/memory usage.

---

## PART 5: MUTABLE vs IMMUTABLE INFRASTRUCTURE ⭐

### VMs — Often Mutable
```
Create VM → Install package → Update config → Patch software → Change app
```
Repeated changes over time → **configuration drift**.

### Containers — Immutable Approach
```
Change required → Build new image → Remove old container → Deploy new container
```
> A running container IS technically writable, but manual changes inside are temporary and **not recommended**. Containers should be **destroyed and recreated** from version-controlled images.

**Persistent data** must live OUTSIDE the container:
- Docker volumes
- Bind mounts
- Cloud storage
- External databases

---

## PART 6: SECURITY CONSIDERATIONS (Containerization)

**Risks:** vulnerable images, running as root, excessive Linux capabilities, exposed secrets, unpatched host kernel, publicly exposed ports, untrusted images.

**Good practices:**
- Use trusted, minimal base images
- Scan images (e.g., **Trivy**)
- Run as non-root user
- Regularly update base images
- Remove unnecessary packages
- Set CPU/memory limits
- Never store passwords in images
- Use SELinux/AppArmor/seccomp
- Use read-only filesystems where possible

---

## PART 7: DOCKER — CORE CONCEPTS

### 7.1 What is Docker?

> **Docker is an open-source platform to build, package, distribute, and run applications inside containers.**

Docker packages: app code, runtime, libraries, frameworks, dependencies, config, utilities → stored as a **Docker image** → when started, becomes a **Docker container**.

> Docker is the *platform*; a container is the *isolated environment* it creates and manages.

### 7.2 Docker Solves "It works on my machine"

Without Docker: different versions, missing libraries, OS config differences, app conflicts, complex installs, slow deploys.

```
Application + Dependencies + Configuration
                     ↓
                Docker Image
                     ↓
       Development → Testing → Production
```

### 7.3 Is Docker = Container? — NO

| Term | Meaning |
|---|---|
| Containerization | The technology/method of isolating apps |
| Docker | A platform that **implements** containerization |
| Docker image | Template to create containers |
| Docker container | Running instance of an image |
| Docker Engine | Software that builds/manages Docker objects |
| Container runtime | Component that starts/manages container processes |

**Other container tech:** Podman, containerd, CRI-O, LXC, LXD.

### 7.4 Docker History (Exam trivia)

- Started by **Solomon Hykes**
- Company originally a PaaS provider called **dotCloud**
- Publicly introduced in **2013**
- Company renamed dotCloud → Docker Inc.
- Early versions used **LXC (Linux Containers)**
- From **Docker 0.9 (2014)**: switched to own library **libcontainer** (written in Go)
- libcontainer later contributed to **runc** (low-level OCI runtime)

> ⚠️ Docker did **NOT invent containers** — isolation tech existed before it (FreeBSD Jails, LXC, lmctfy, rkt).

| Technology | Description |
|---|---|
| FreeBSD Jails | OS-level isolation in FreeBSD |
| LXC | Linux Containers — OS-level virtualization |
| LXD | System-container/VM manager built on LXC |
| lmctfy | Earlier Google container project |
| rkt | Discontinued CoreOS container runtime |
| Podman | Daemonless container management tool |
| containerd | Widely used container runtime |
| CRI-O | Container runtime designed for Kubernetes |

> Docker became popular because it made containers **simple to build, distribute, and run.**

---

## PART 8: DOCKER ARCHITECTURE

### 8.1 Client–Server Architecture

```
User → Docker Client → (Docker REST API) → Docker Daemon
                                                ↓
                          Images, Containers, Networks, Volumes
                                                ↕
                                        Docker Registry
```

### 8.2 Docker Client
The main interface (`docker` CLI):
```bash
docker run nginx
docker build -t myapp:1.0 .
docker pull ubuntu
docker push username/myapp:1.0
docker ps
```
- Accepts user commands
- Sends requests to Docker daemon
- Receives/displays responses
- Can talk to local or **remote** daemon
- Uses Docker REST API

### 8.3 Docker Daemon (`dockerd`)
Background service that **actually does the work**:
- Listens for API requests
- Builds images
- Downloads/uploads images
- Creates/manages containers, networks, volumes
- Applies resource limits and isolation
- Talks to container runtimes

> Client gives instructions → Daemon performs the actual work. `docker run nginx` → client sends request to `dockerd` → daemon creates/starts the container.

### 8.4 Docker REST API
Client ↔ Daemon communicate via this API, through:
- Unix socket (Linux default: `/var/run/docker.sock`)
- Windows named pipe
- TCP network connection

> ⚠️ Docker socket access is **highly privileged** — controlling the daemon can effectively give root-level control of the host.

### 8.5 Docker Registry
Stores/distributes images.

| Public | Private/Cloud |
|---|---|
| Docker Hub | Amazon ECR |
| GitHub Container Registry | Google Artifact Registry |
| Quay.io | Azure Container Registry / self-hosted |

```bash
docker pull nginx
docker push username/myapp:1.0
docker search nginx
```

### 8.6 Complete `docker run nginx` Flow

```
1. Docker client → sends request to daemon
2. Daemon checks if nginx image exists locally
3. If not, pulls from registry
4. Creates writable container layer
5. Creates required networking
6. Assigns isolated filesystem & process space
7. Container runtime starts the Nginx process
8. Container keeps running while its main process runs
```

### 8.7 Docker Engine — Layered Breakdown

```
Docker CLI → Docker Daemon → containerd → runc → Linux Kernel
```

| Component | Role |
|---|---|
| `containerd` | Manages container lifecycle: image transfer, storage, execution, supervision |
| `runc` | Low-level runtime: creates isolated environment, configures namespaces, applies cgroups, starts container process |

> Docker = user-friendly platform; **containerd and runc do the low-level work.**

---

## PART 9: DOCKER OBJECTS — REFERENCE

### 9.1 Image
Read-only template. Example images: `ubuntu:24.04`, `nginx:latest`, `python:3.12-slim`, `postgres:17`.
```bash
docker images                 # list local images
docker pull nginx             # download
docker image rm nginx         # remove
```

### 9.2 Container
Running/stopped instance of an image.
```bash
docker run -d --name web-server -p 8080:80 nginx
```

| Option | Meaning |
|---|---|
| `docker run` | Creates & starts container |
| `-d` | Background (detached) mode |
| `--name` | Assigns container name |
| `-p 8080:80` | Maps host:container port |

```bash
docker ps            # running containers
docker ps -a          # all containers
docker stop web-server
docker rm web-server
```

### 9.3 Network
Enables container↔container, container↔host, container↔internet communication + isolation.
```bash
docker network ls
docker network create app-network
docker run -d --name backend --network app-network my-backend
docker run -d --name database --network app-network postgres
```
Backend reaches DB via container name: `database:5432`

### 9.4 Volume
Persistent storage OUTSIDE the container's writable layer.
```bash
docker volume create postgres-data
docker run -d --name database -v postgres-data:/var/lib/postgresql/data postgres
docker volume ls
```

| Container writable layer | Docker volume |
|---|---|
| Tied to the container | Managed separately |
| Usually temporary | Persistent |
| Data lost on removal | Survives container replacement |
| Not ideal for DBs | Suitable for DB data |

### 9.5 Registry Naming
```
registry/namespace/image:tag
docker.io/veenayak/backend:1.0
```

### 9.6 Docker Swarm Objects (Preview — see Part 12)

| Object | Purpose |
|---|---|
| Node | Machine running Docker Engine in a Swarm cluster |
| Service | Defines how an app runs in Swarm (image, replicas, ports, etc.) |
| Secret | Stores sensitive data (passwords, keys, tokens, certs) for Swarm services |
| Stack | Group of related Swarm services deployed together (Compose-style YAML) |

```bash
docker service create --name web --replicas 3 -p 80:80 nginx
printf 'StrongPassword' | docker secret create db_password -
docker stack deploy -c compose.yaml myapp
docker stack ls
```
> ⚠️ Secrets should NEVER be written directly in a Dockerfile or stored in an image.

### 9.7 Docker Objects — Master Summary Table

| Object | Purpose |
|---|---|
| Image | Read-only template used to create containers |
| Container | Running/stopped instance of an image |
| Network | Enables/controls container communication |
| Volume | Persistent storage |
| Registry | Stores/distributes images |
| Node | Machine in a Docker Swarm cluster |
| Service | Container deployment definition in Swarm |
| Secret | Securely provides sensitive data to Swarm services |
| Stack | Group of related Swarm services |

---

## PART 10: DOCKER MODES OF OPERATION

### 10.1 Native Linux Containers
Uses Linux kernel features directly: namespaces, cgroups, capabilities, seccomp, union filesystems.
```
Linux Containers → Docker Engine → Linux Kernel → Hardware
```
Near-native performance, low overhead — common in production.

### 10.2 Docker Desktop (Windows/macOS)
Linux containers can't use Windows/macOS kernel directly → Docker Desktop runs a **managed Linux VM**.

| Windows | macOS |
|---|---|
| WSL 2 or Hyper-V | Lightweight Linux VM via macOS virtualization framework |

```
Linux Containers → Docker Engine → Linux VM → Windows/macOS → Hardware
```
Docker Desktop integrates: files, networking, CLI, volumes, port forwarding (mostly transparent to user).

### 10.3 Native Windows Containers
Need compatible Windows images (Windows Server Core, Nano Server). **A Linux image cannot run as a native Windows container.**
```
Windows Containers → Docker Engine → Windows Kernel → Hardware
```

### 10.4 Linux vs Windows Containers

| Feature | Linux Container | Windows Container |
|---|---|---|
| Kernel | Linux | Windows |
| Base image | Ubuntu, Alpine, Debian | Server Core, Nano Server |
| Common use | Web apps, microservices, DBs | Windows/.NET Framework apps |
| Native host | Linux | Windows |
| On Windows Desktop | Runs inside Linux VM (usually) | Can use Windows container mode |

---

## PART 11: DOCKERFILE & DOCKER IMAGES — DEEP DIVE

### 11.1 Basic Dockerfile Example (Flask app)

```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

```bash
docker build -t flask-app:1.0 .
docker run -d -p 5000:5000 --name flask-container flask-app:1.0
```

### 11.2 Key Docker Commands (Reference Table)

| Command | Purpose |
|---|---|
| `docker version` | Client & server versions |
| `docker info` | System info |
| `docker pull IMAGE` | Download image |
| `docker push IMAGE` | Upload image |
| `docker build -t NAME .` | Build image |
| `docker images` | List local images |
| `docker run IMAGE` | Create + start container |
| `docker ps` / `docker ps -a` | Running / all containers |
| `docker stop/start/restart CONTAINER` | Lifecycle control |
| `docker logs CONTAINER` | View logs |
| `docker exec -it CONTAINER sh` | Shell into running container |
| `docker inspect OBJECT` | Detailed info |
| `docker rm CONTAINER` / `docker rmi IMAGE` | Remove |
| `docker network ls` / `docker volume ls` | List networks/volumes |

### 11.3 Docker vs Virtual Machine (Repeat, Docker-specific framing)

| Feature | Docker Container | Virtual Machine |
|---|---|---|
| Virtualization | OS-level | Hardware-level |
| Guest OS | None | Full guest OS |
| Size | MBs | GBs |
| Startup | Seconds or less | Seconds–minutes |
| Isolation | Process-level | Strong VM-level |
| Main use | Portable app deployment | Full OS environments, strong isolation |

### 11.4 Advantages & Limitations of Docker

**Advantages:** fast deployment, consistent environments, lightweight, simple dependency mgmt, isolation, easy versioning/rollback, better resource use, CI/CD support, microservices-friendly.

**Limitations:** shares host kernel (weaker isolation than VM), persistent storage needs planning, poor config = security risk, complex networking at scale, needs orchestration at scale, Linux/Windows images not interchangeable, Docker doesn't auto-secure app/image.

---

## PART 12: DOCKER IMAGES — DEEP DIVE

### 12.1 What is a Docker Image?

> A **read-only template** used to create containers: app code, runtime, libraries, dependencies, system packages, env-var defaults, config, default startup command.

### 12.2 Image vs Container

| Docker Image | Docker Container |
|---|---|
| Read-only template | Running/stopped instance |
| Used to create containers | Created FROM an image |
| Doesn't execute itself | Runs the app process |
| Normally doesn't change | Has a writable layer |
| One image → many containers | Each container is separate |

### 12.3 Read-Only Layers + Writable Container Layer

```
Container Writable Layer   ← changes go here
-------------------------
Application Code Layer
Dependency Layer
Runtime Layer
Base Image Layer           ← all read-only
```
> Data in the writable layer is normally **lost if the container is removed**. Use volumes/bind mounts/external DBs/cloud storage for persistence.

### 12.4 Image Layers — How They're Built

```dockerfile
FROM python:3.12-slim      # Layer 1: base image
WORKDIR /app                 # metadata
COPY requirements.txt .        # Layer: requirements file
RUN pip install -r requirements.txt   # Layer: installed deps
COPY . .                          # Layer: application code
CMD ["python", "app.py"]            # metadata only (no filesystem layer)
```
> `RUN`, `COPY`, `ADD` → create filesystem layers. `ENV`, `CMD`, `ENTRYPOINT`, `EXPOSE`, `LABEL` → mainly update **image metadata**, not filesystem.

### 12.5 Types of Layers

| Layer Type | Example |
|---|---|
| **Base layer** | `FROM ubuntu:24.04`, `FROM alpine:3.21`, `FROM scratch` (empty, for compiled binaries) |
| **Intermediate layers** | Package installs, copying dependency files, creating dirs |
| **Final application layer** | Source code, config, startup command |

### 12.6 Why Layers Improve Efficiency

Shared base layers across images → Docker stores common layers **once**:
```
App A Image                App B Image
     ↓                            ↓
App A deps                 App B deps
        \                      /
         Shared Python 3.12 Base Layer (stored once)
```
Benefits: reduced storage, faster downloads/builds, reusable base images.

### 12.7 Docker Build Cache

Docker reuses unchanged layers if inputs haven't changed.

```dockerfile
# ✅ GOOD ordering (cache-friendly)
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
```
If only app code changes → dependency layer is **reused**, only the last `COPY` rebuilds.

```dockerfile
# ❌ BAD ordering
COPY . .
RUN pip install -r requirements.txt
```
Any code change invalidates the pip install step too.

> **Rule: place instructions that change LESS frequently near the TOP of the Dockerfile.**

Build without cache:
```bash
docker build --no-cache -t myapp:1.0 .
```

### 12.8 Building an Image

```bash
docker build -t flask-app:1.0 .
```
| Part | Meaning |
|---|---|
| `-t` | Assigns name:tag |
| `flask-app` | Image name |
| `1.0` | Tag |
| `.` | Build context (current directory) |

### 12.9 Build Context & `.dockerignore`

**Build context** = set of files Docker can access during build (usually current dir `.`). Files outside context can't be `COPY`'d.

`.dockerignore` example:
```
.git
.env
node_modules
__pycache__
*.log
README.md
```
Benefits: smaller/faster builds, prevents accidental secret inclusion.

### 12.10 Image Naming, Tags & Digests

**Full reference format:**
```
registry/namespace/repository:tag
docker.io/veenayak/flask-app:1.0
```

| Part | Meaning |
|---|---|
| `docker.io` | Registry |
| `veenayak` | Namespace |
| `flask-app` | Repository/image name |
| `1.0` | Version tag |

**Tags** (`myapp:1.0`, `myapp:latest`, etc.):
> ⚠️ `latest` does NOT automatically mean newest/most stable — it's just the **default tag** when none is specified. Use specific versions in production (`nginx:1.27.4`, not `nginx:latest`).

**Digest** — cryptographic content identifier:
```
nginx@sha256:abc123...
```

| Tag | Digest |
|---|---|
| Human-readable | Cryptographic identifier |
| Can point to different content over time | Identifies exact content — immutable |
| Convenient for versioning | Best for reproducible deployment |

### 12.11 Image Commands (Reference)

| Command | Purpose |
|---|---|
| `docker build` | Build image from Dockerfile |
| `docker image ls` / `docker images` | List local images |
| `docker pull` / `docker push` | Download / upload |
| `docker image rm` / `docker rmi` | Remove image |
| `docker history IMAGE` | Layer history |
| `docker image inspect IMAGE` | Detailed metadata (JSON) |
| `docker tag SRC DST` | Add another name/tag (no copy, same content) |
| `docker save -o file.tar IMG` | Export to tar |
| `docker load -i file.tar` | Import from tar |
| `docker image prune [-a]` | Remove unused/dangling images |

> ⚠️ `docker save`/`docker load` ≠ `docker export`/`docker import` (the latter work on container filesystems, not full image history/metadata).

### 12.12 Registry / Repository / Image / Tag — Relationship

```
Docker Registry
├── ubuntu repository
│   ├── ubuntu:22.04
│   ├── ubuntu:24.04
│   └── ubuntu:latest
└── nginx repository
    ├── nginx:1.26
    ├── nginx:1.27
    └── nginx:latest
```

| Term | Meaning | Example |
|---|---|---|
| Registry | Server storing repositories | Docker Hub, Amazon ECR |
| Repository | Collection of related images | `ubuntu`, `nginx`, `myapp` |
| Image | Read-only template | Nginx image |
| Tag | Human-readable version | `1.27`, `latest` |
| Digest | Content-based identifier | `sha256:abc...` |

### 12.13 Creating a Custom Image — Two Methods

| Method | Suitable For |
|---|---|
| `docker commit` | Quick experiments, troubleshooting, learning |
| Dockerfile | Repeatable, automated, production-ready builds ✅ **RECOMMENDED** |

#### `docker commit` — Example Workflow
```bash
docker pull ubuntu:latest
docker run -it --name ubuntu-container ubuntu:latest bash
# inside container:
mkdir /mydata
echo "Created inside the container" > /mydata/file.txt
exit
# commit:
docker commit --author "Veenayak" --message "Added mydata" ubuntu-container custom-ubuntu:v1
docker image ls
docker run --rm custom-ubuntu:v1 cat /mydata/file.txt
```

**Limitations of `docker commit`:**
- Manual changes hard to reproduce
- Others can't easily see how it was built
- Difficult to audit
- No clear build process → unsuitable for CI/CD
- Mounted-volume data NOT included
- May include unwanted temp files

> Use `docker commit` for experiments only; use a **Dockerfile** for real applications.

### 12.14 Layered / Union Filesystem

Docker presents multiple read-only layers as ONE combined filesystem.

> Docker has used various storage backends historically (AUFS, OverlayFS, Device Mapper, Btrfs, ZFS). **Modern Linux systems commonly use `overlay2`** (based on OverlayFS).

```bash
docker info   # look for "Storage Driver: overlay2"
```

### 12.15 Copy-on-Write ⭐

When a container modifies a file from a read-only image layer:
```
1. Find file in image layer
2. Copy it into container's writable layer
3. Modify the COPY
4. Original image file stays unchanged
```
This lets many containers share the same image layers while keeping their own changes separate.

### 12.16 File Deletion in Layered FS (Trap!)

> ⚠️ Deleting a file in an upper layer does NOT physically remove it from a lower (read-only) layer — it's just **hidden**. The data may still exist in an earlier layer, so image size may NOT shrink.

```dockerfile
# ❌ Inefficient — cache remains in earlier layer
RUN apt-get update
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

# ✅ Better — install + cleanup in ONE RUN layer
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*
```

---

## PART 13: DOCKERFILE INSTRUCTIONS — COMPLETE REFERENCE ⭐

### 13.1 Instruction Summary Table

| Instruction | Purpose |
|---|---|
| `FROM` | Selects base image |
| `ENV` | Sets environment variables |
| `RUN` | Executes commands during build |
| `CMD` | Default container command/arguments |
| `EXPOSE` | Documents expected port (doesn't publish it!) |
| `WORKDIR` | Sets working directory |
| `ADD` | Copies files + extra features (e.g., tar extraction) |
| `COPY` | Copies files (preferred for normal copying) |
| `LABEL` | Adds metadata |
| `MAINTAINER` | ❌ Deprecated — use `LABEL` instead |
| `ENTRYPOINT` | Defines the main executable |

### 13.2 `FROM`
```dockerfile
FROM ubuntu:24.04
FROM python:3.12-slim
FROM scratch          # empty base — for standalone compiled binaries
```
Normally the first instruction (except parser directives / early `ARG`).

### 13.3 `ENV`
```dockerfile
ENV APP_ENV=production
ENV APP_PORT=5000
```
Available in later build steps AND in running containers.
```bash
docker run -e APP_ENV=development myapp   # override at runtime
```
> ⚠️ Never store passwords/tokens/API keys via `ENV` — inspectable via image config.

### 13.4 `RUN`
Executes **during build** (`docker build`), NOT at container startup.
```dockerfile
RUN apt-get update && apt-get install -y curl     # shell form
RUN ["executable", "arg1", "arg2"]                  # exec form
```

### 13.5 `CMD` vs `ENTRYPOINT` ⭐ (Very frequently tested)

```dockerfile
CMD ["python", "app.py"]        # exec form (preferred)
CMD python app.py                # shell form
```

| `CMD` | `ENTRYPOINT` |
|---|---|
| Default command/arguments | Main fixed executable |
| Easily overridden by runtime args | Runtime args are normally **appended** |
| Only last effective `CMD` used | Only last effective `ENTRYPOINT` used |
| Good for changeable defaults | Good for fixed apps |

**Combined pattern:**
```dockerfile
ENTRYPOINT ["python", "app.py"]
CMD ["--port", "5000"]
```
```bash
docker run myapp                 # → python app.py --port 5000
docker run myapp --port 8000      # → python app.py --port 8000
docker run --entrypoint sh myapp    # override entrypoint itself
```

**`RUN` vs `CMD`:**

| `RUN` | `CMD` |
|---|---|
| Executes during image BUILD | Executes when container STARTS |
| Creates filesystem changes | Defines default runtime command |
| Can appear multiple times | Only final effective one is used |

### 13.6 `EXPOSE` — Common Trap!

```dockerfile
EXPOSE 5000
```
> ⚠️ `EXPOSE` does **NOT** publish the port to the host — it only **documents** intent. To actually publish:
```bash
docker run -p 8080:80 nginx     # host:container
```

### 13.7 `WORKDIR`
```dockerfile
WORKDIR /app
```
Sets working directory for later instructions; creates the dir if missing.
> ⚠️ Better than `RUN cd /app` — each `RUN` runs in a separate step, so `cd` in one `RUN` doesn't persist to later instructions.

### 13.8 `COPY` vs `ADD`

| `COPY` | `ADD` |
|---|---|
| Simple, predictable file copying | Extra behavior (e.g., auto-extracts local tar archives) |
| **Preferred** for normal copying | Use only when its special behavior is needed |

```dockerfile
COPY requirements.txt /app/requirements.txt
ADD application.tar.gz /app/    # auto-extracted into /app
```

### 13.9 `LABEL` (replaces deprecated `MAINTAINER`)
```dockerfile
LABEL maintainer="Veenayak Sirohi"
LABEL version="1.0"
LABEL description="Flask backend application"
```
```bash
docker image inspect myapp:1.0   # view labels
```

### 13.10 Complete Example — Flask App

```dockerfile
FROM python:3.12-slim
LABEL maintainer="Veenayak Sirohi"
LABEL version="1.0"
ENV APP_ENV=production
ENV APP_PORT=5000
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]
```

---

## PART 14: MULTI-STAGE BUILDS ⭐

Uses multiple `FROM` instructions to separate **build environment** from **final runtime environment**.

```dockerfile
FROM node:22 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.27-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
```

**Benefits:**
- Smaller final image (no dev tools/build deps in final image)
- Fewer unnecessary tools → reduced attack surface
- Faster image transfer

---

## PART 15: IMAGE SECURITY BEST PRACTICES

| Practice | Why |
|---|---|
| Use trusted/official base images | Avoid unmaintained/malicious images |
| Use small base images (slim/alpine) | Faster, smaller attack surface — but balance with maintainability |
| **Never store secrets in images** | Secrets can remain in earlier layers even if later deleted |
| Scan images (e.g., Trivy) | `trivy image myapp:1.0` — finds vulnerable OS/app packages |
| Run as non-root user | `RUN useradd --create-home appuser` + `USER appuser` |
| Pin specific versions | `FROM python:3.12.5-slim` not `FROM python:latest`; digest pinning is even stronger |
| Combine install+cleanup in one `RUN` | Prevents cache/secret leftovers in earlier layers |
| Use `.dockerignore` | Prevents leaking `.env`, `.git`, secrets into build context |

**Secrets — unsafe pattern:**
```dockerfile
# ❌ UNSAFE — secret persists in earlier layer even after deletion
COPY secret.txt /app/secret.txt
RUN use-secret-command
RUN rm /app/secret.txt
```
✅ Use: BuildKit secret mounts, runtime secret injection, Docker secrets, Kubernetes Secrets, external secret managers.

---

## PART 16: COMMON MISUNDERSTANDINGS (Docker/Images) — Exam Traps

| Misconception | Reality |
|---|---|
| Image contains a complete OS | Usually just Linux userspace filesystem/utilities — **no own kernel** (shares host's) |
| `EXPOSE` publishes a port | It only documents intent — use `-p` to actually publish |
| Changing a running container updates the image | No — changes stay in the container's writable layer; image is unchanged. Must rebuild + retag to update permanently |
| Docker always uses UnionFS/AUFS | Modern Linux systems commonly use **`overlay2`** |
| Every Dockerfile instruction creates a filesystem layer | Only `RUN`/`COPY`/`ADD` typically do; `CMD`/`ENV`/`EXPOSE`/`LABEL` mainly update metadata |
| Deleting a file in a later layer shrinks the image | It only hides the file — data may remain in an earlier layer |

---

## PART 17: DOCKER SWARM — ORCHESTRATION ⭐

### 17.1 What is Docker Swarm?

> **Docker Swarm = Docker's built-in container orchestration/clustering system.** Combines multiple Docker Engine hosts into one logical cluster called a **swarm**.

Capabilities: deploy containers across nodes, scale replicas, auto-replace failed containers, service discovery, load balancing, rolling updates, maintain desired state.

```
Docker Swarm Cluster
├── Manager Node
├── Worker Node 1
└── Worker Node 2
```

### 17.2 Main Features (Table)

| Feature | Explanation |
|---|---|
| Integrated cluster mgmt | Built into Docker Engine — no separate install |
| Decentralized design | Multiple manager/worker nodes, Raft consensus |
| Declarative service model | Specify desired result (e.g., 3 replicas) |
| Scaling | Increase/decrease replica count |
| Desired-state reconciliation | Auto-corrects drift between desired vs actual |
| Multi-host networking | Overlay networks span nodes |
| Service discovery | Internal DNS resolves service names |
| Load balancing | Distributes requests across replicas |
| Secure by default | Certificates + mutual TLS for control-plane |
| Rolling updates | Gradual container replacement |
| Self-healing | Failed tasks auto-replaced |

### 17.3 Decentralized Design & Raft Consensus

Manager nodes use the **Raft consensus algorithm** to keep cluster state consistent (nodes, services, tasks, networks, secrets, desired replica counts).

One manager = elected **leader**; other managers stay available for consensus/failover.

### 17.4 Declarative Service Model

```bash
docker service create --name web --replicas 3 nginx
```
You describe *what* (3 replicas); the **Swarm scheduler** decides *where*.

### 17.5 Desired-State Reconciliation ⭐

```
Desired: 3 replicas
Actual: 2 replicas
     ↓
Swarm creates a replacement task
     ↓
Actual: 3
```

### 17.6 Scaling
```bash
docker service scale web=5     # scale up
docker service scale web=2     # scale down
```

### 17.7 Service Discovery (Internal DNS)
```
Frontend → backend:5000
Backend  → database:5432
```
Service names auto-resolve — useful since container IPs change when tasks are replaced.

### 17.8 Load Balancing

| Type | What it distributes |
|---|---|
| External/ingress | Traffic arriving at a published port |
| Internal | Service-to-service traffic between replicas |

### 17.9 Secure by Default

Swarm init creates a **PKI**: node certificates, mutual TLS, encrypted management comms, cert rotation, join tokens.

> ⚠️ Control-plane comms are secured automatically — but **application data on overlay networks is NOT necessarily encrypted by default**.

```bash
docker network create --driver overlay --opt encrypted secure-network
```
(Encryption adds overhead.)

### 17.10 Rolling Updates
```bash
docker service update --image nginx:1.27 web
```
```
Old: v1 v1 v1
Step 1: v2 v1 v1
Step 2: v2 v2 v1
Step 3: v2 v2 v2
```
```bash
docker service update --image nginx:1.27 --update-parallelism 1 --update-delay 10s web
```

---

## PART 18: DOCKER SWARM — NODES

### 18.1 What is a Node?
An **instance of Docker Engine participating in a swarm** — normally one machine = one node.

### 18.2 Manager vs Worker Nodes

| Manager Node | Worker Node |
|---|---|
| Manages the cluster | Executes assigned tasks |
| Accepts service definitions | Runs service containers |
| Schedules tasks | Reports task status |
| Maintains desired state | Runs the worker agent |
| Stores swarm state | Doesn't participate in Raft consensus |
| Can also run tasks by default | Mainly application workloads |

### 18.3 Leader Manager & Quorum ⭐

Multiple managers elect one **leader** to coordinate orchestration. If leader fails + quorum remains → new leader elected.

**Manager Quorum Table (memorize):**

| # Managers | Majority Required | Failures Tolerated |
|---|---|---|
| 1 | 1 | 0 |
| 3 | 2 | 1 |
| 5 | 3 | 2 |
| 7 | 4 | 3 |

> Use an **odd number** of managers: 1 (test/learning), 3 (small prod), 5 (larger prod).
> ⚠️ Losing quorum blocks cluster-management CHANGES, but **existing tasks may keep running**.

### 18.4 Worker Node Responsibilities

```
Manager assigns task → Worker agent downloads image → creates/runs container →
monitors task → reports status back to manager
```
States reported: Starting, Running, Completed, Failed, Rejected, Shutdown.

### 18.5 Can a Manager Run Containers? — YES (by default)

```bash
docker node update --availability drain manager-node   # prevent scheduling on it
docker node update --availability active manager-node   # restore
```

| Mode | Meaning |
|---|---|
| `active` | New tasks can be scheduled |
| `pause` | Existing tasks continue; no new tasks |
| `drain` | Existing tasks moved/replaced; no new tasks |

---

## PART 19: SERVICES & TASKS ⭐

### 19.1 What is a Service?

> A **service = definition of how an app should run in Swarm** (image, replicas, ports, env vars, networks, volumes, secrets, resource limits, placement, update/restart policy).

```bash
docker service create --name web --replicas 3 --publish 8080:80 nginx:1.27
```

### 19.2 What is a Task?

> A **task = atomic scheduling unit** of Swarm — contains service config, assigned node, container, command, current state.

```
Service: web
├── Task 1 → Container on Worker 1
├── Task 2 → Container on Worker 2
└── Task 3 → Container on Worker 3
```
`1 replica = 1 task`

### 19.3 Service vs Task vs Container

| Service | Task | Container |
|---|---|---|
| Defines desired app | Scheduling unit for a service | Running application process |
| Created by user | Created by manager | Created on assigned node |
| Can request N replicas | Assigned to ONE node | Runs from an image |
| Maintains desired state | Has lifecycle/state | Executes actual workload |

### 19.4 Failed Task — Does It Move? ⭐ (Common exam trap)

> ⚠️ **No — a task does NOT move to another node.** If a task/node fails, the old task stays failed; the manager creates a **replacement task**, which may run on a different node.

```
Task 1 on Worker 1 fails → remains failed → Manager creates Task 2 → runs on Worker 2
```

### 19.5 Replicated vs Global Services

| Replicated | Global |
|---|---|
| Runs a specified # of tasks | Runs ONE task per eligible node |
| Example: 3 web replicas | Example: monitoring agent on every node |
| Scaled via replica count | Scales automatically as nodes join/leave |

```bash
docker service create --name web --replicas 3 nginx                       # replicated
docker service create --name monitoring-agent --mode global monitoring-image  # global
```

---

## PART 20: BUILDING A SWARM CLUSTER — STEP BY STEP

### 20.1 Requirements
- Docker Engine on every node
- Unique hostnames
- Network reachability between nodes
- Required firewall ports open
- Stable IPs, synced time
- Compatible Docker versions (Swarm mode requires Docker Engine ≥ 1.12; use a currently supported version)

### 20.2 Required Ports ⭐ (Memorize)

| Port | Protocol | Purpose |
|---|---|---|
| **2377** | TCP | Swarm control-plane / cluster management |
| **7946** | TCP + UDP | Node communication & discovery |
| **4789** | UDP | Overlay network data traffic |

> ⚠️ Port `2377` should **not be exposed to the public internet**.

### 20.3 Initialize Swarm (on Manager)
```bash
docker swarm init --advertise-addr 192.168.1.10
```
```bash
docker info                # check "Swarm: active", "Is Manager: true"
docker node inspect self
docker node ls              # list all nodes
```

### 20.4 Add Worker Nodes
```bash
docker swarm join-token worker      # get join command (run on manager)
# then, on the worker:
docker swarm join --token SWMTKN-1-xxxxxxxx 192.168.1.10:2377
```

### 20.5 Add Manager Nodes
```bash
docker swarm join-token manager     # get manager join command
```
> ⚠️ Protect manager tokens carefully — manager nodes control the cluster.

### 20.6 Rotate Tokens (if exposed)
```bash
docker swarm join-token --rotate worker
docker swarm join-token --rotate manager
```

### 20.7 Leave / Remove Nodes
```bash
docker swarm leave              # worker
docker swarm leave --force       # manager (use carefully!)
docker node rm worker1           # remove unavailable node (from manager)
```

---

## PART 21: OVERLAY NETWORKS ⭐

### 21.1 What is an Overlay Network?

> A **virtual network spanning multiple Docker hosts**, letting containers on different swarm nodes communicate as if on the same network.

```
Container A (Worker 1)     Container B (Worker 2)
      \____ Overlay Network ____/
              ↓
       Physical Host Network
```

### 21.2 Bridge vs Overlay

| Bridge network | Overlay network |
|---|---|
| Usually limited to ONE Docker host | Spans MULTIPLE Docker hosts |
| Local containers | Swarm services |

### 21.3 Default Swarm Networks

| Network | Purpose |
|---|---|
| `ingress` | Routing mesh + load balancing for published ports |
| `docker_gwbridge` | Local bridge connecting overlays to a node's external network |

```bash
docker network create --driver overlay app-network
docker network create --driver overlay --opt encrypted secure-app-network   # encrypted
```

### 21.4 Swarm Routing Mesh ⭐

> A published service port becomes reachable on **every swarm node** — even nodes NOT running a replica. Requests are routed internally to an available replica.

```bash
docker service create --name web --replicas 3 --publish 8080:80 nginx
# or: --publish published=8080,target=80
```

---

## PART 22: WORKING WITH SWARM SERVICES — COMMAND REFERENCE

```bash
# Create
docker service create --replicas 3 --name web --publish 8080:80 nginx:1.27

# List
docker service ls
# Output shows e.g. "3/3" = running tasks / desired tasks

# Inspect
docker service inspect web
docker service inspect --pretty web

# View tasks
docker service ps web
docker node ps worker1

# Scale
docker service scale web=5
docker service update --replicas 5 web

# Update
docker service update --image nginx:1.27 web
docker service update --env-add APP_ENV=production web
docker service update --publish-add 9090:80 web

# Rollback
docker service rollback web
docker service update --image myapp:2.0 --update-failure-action rollback web

# Delete
docker service rm web
```
> `docker service rm` removes the service definition, its tasks, and the containers — but does NOT auto-remove images from every node.

---

## PART 23: PLACEMENT CONSTRAINTS & RESOURCE LIMITS

### 23.1 Placement Constraints
```bash
docker service create --name web --constraint 'node.role==worker' nginx
docker node update --label-add environment=production worker1
docker service create --name backend --constraint 'node.labels.environment==production' backend-image:1.0
```

### 23.2 Resource Limits vs Reservations

```bash
docker service create --name backend --limit-cpu 1 --limit-memory 512M backend-image:1.0
docker service create --name backend --reserve-cpu 0.5 --reserve-memory 256M backend-image:1.0
```

| Limit | Reservation |
|---|---|
| Maximum resource usage allowed | Minimum required for scheduling |
| Prevents excessive consumption | Helps scheduler pick a suitable node |

---

## PART 24: COMPLETE SWARM WORKFLOW EXAMPLE

```bash
# 1. Init manager
docker swarm init --advertise-addr 192.168.1.10

# 2. Get worker token + join both workers
docker swarm join-token worker
# (run join command on Worker1 and Worker2)

# 3. Verify
docker node ls

# 4. Create overlay network
docker network create --driver overlay web-network

# 5. Deploy service
docker service create --name web --replicas 3 --network web-network --publish 8080:80 nginx:1.27

# 6. Verify
docker service ls
docker service ps web

# 7. Scale
docker service scale web=5

# 8. Update
docker service update --image nginx:latest web

# 9. Rollback if needed
docker service rollback web

# 10. Delete
docker service rm web
```

---

## PART 25: IMPORTANT CORRECTIONS SUMMARY (High-Yield)

| Common Wrong Belief | Correct Understanding |
|---|---|
| A container is a mini VM | A container isolates processes & shares host kernel; a VM virtualizes hardware with a full guest OS |
| A container can run on ANY OS | Needs a compatible kernel + CPU architecture; Docker Desktop uses an internal Linux VM for Linux containers on Win/macOS |
| Docker invented containers | Container tech (FreeBSD Jails, LXC, etc.) predates Docker; Docker made it easy to use |
| `EXPOSE` publishes a port | It only documents intent — use `docker run -p` to publish |
| Changing a container changes the image | Changes live in the writable layer only; image stays unchanged |
| Docker always uses AUFS/UnionFS | Modern Linux commonly uses `overlay2` |
| Deleting a file in a later layer shrinks the image | File is only hidden; data may remain in earlier layer |
| `MAINTAINER` is still the way to add author metadata | Deprecated — use `LABEL maintainer="..."` |
| `latest` tag = newest/most stable image | It's just the default tag when none specified |
| A failed Swarm task "moves" to another node | The failed task stays failed; manager creates a NEW replacement task elsewhere |
| Swarm overlay network traffic is always encrypted | Only control-plane traffic is secured by default; app data needs `--opt encrypted` explicitly |
| Manager nodes only manage, never run containers | Managers CAN run tasks by default unless drained |
| `docker commit` is the recommended way to build images | Dockerfile is recommended for repeatable, reviewable, CI/CD-friendly builds |

---

## PART 26: EXAM ONE-LINERS

- **Containerization** = OS-level virtualization; containers **share the host kernel**.
- **Namespaces** = control what a container can SEE; **Cgroups** = control how much it can USE.
- **Image** = read-only template; **Container** = running instance (adds writable layer).
- **Copy-on-write** = modified files get copied into the writable layer before editing.
- **Docker** = platform that implements containerization; uses **client-server architecture**.
- `docker` = CLI client; `dockerd` = daemon (does the actual work).
- `containerd` = manages container lifecycle; `runc` = low-level runtime (namespaces/cgroups/starts process).
- **Registry** stores **repositories**, which contain **images** identified by **tags** or **digests**.
- `COPY` preferred over `ADD` for normal copying; `ADD` can extract local tar archives.
- `CMD` = default/overridable command; `ENTRYPOINT` = fixed main executable.
- **Multi-stage builds** = smaller final images by separating build & runtime environments.
- **Docker Swarm** = built-in orchestration; nodes = Manager (control) or Worker (execute).
- **Service** = desired app definition; **Task** = atomic scheduling unit (1 task = 1 container instance).
- Failed tasks are **replaced, not moved**.
- **Overlay network** spans multiple hosts; **bridge network** is single-host.
- **Ingress network** = routing mesh; **docker_gwbridge** = connects overlay to external network.
- Ports: **2377** (management), **7946** (node discovery), **4789** (overlay data).
- Manager **quorum** needs a majority (odd number of managers recommended: 3 or 5).

---

## PART 27: INTERVIEW-READY SUMMARY ANSWERS

**Q: What is containerization and how is it different from virtualization?**
> "Containerization is OS-level virtualization — it packages an app with its dependencies into an isolated unit called a container, which shares the host OS kernel. Traditional (hardware) virtualization uses a hypervisor to run full virtual machines, each with its own guest OS and kernel. Because containers share the kernel, they're much smaller, faster to start, and more resource-efficient, but they provide lighter isolation than VMs."

**Q: How does container isolation actually work at the kernel level?**
> "Linux containers rely on two main kernel features: namespaces, which control what a container can see — like its own process list, network stack, and filesystem — and control groups (cgroups), which control how much CPU, memory, and other resources it can use. Additional hardening comes from Linux capabilities, SELinux, AppArmor, and seccomp."

**Q: What is the difference between a Docker image and a Docker container?**
> "An image is a read-only, layered template containing the application, its dependencies, and configuration. A container is a running (or stopped) instance of that image, with an additional thin writable layer on top where runtime changes are stored. One image can be used to create many containers."

**Q: Explain the Docker architecture.**
> "Docker uses a client-server architecture. The Docker client is the CLI the user interacts with; it sends requests over the Docker REST API to the Docker daemon (dockerd), which does the actual work — pulling images, building images, and creating containers, networks, and volumes. Underneath, containerd manages the container lifecycle and runc handles the low-level kernel isolation."

**Q: How does Docker Swarm handle a failed task?**
> "Swarm continuously compares the desired state to the actual state. If a task fails, the manager doesn't move the failed task — it marks it as failed and creates a brand-new replacement task, which may be scheduled on a different available node, restoring the desired replica count."

**Q: What's the difference between CMD and ENTRYPOINT in a Dockerfile?**
> "ENTRYPOINT defines the fixed, main executable that always runs when the container starts. CMD provides default arguments (or a default command if there's no ENTRYPOINT) that can be easily overridden at runtime. A common pattern combines both: ENTRYPOINT sets the app binary, and CMD supplies default flags that users can override."

---

*Notes consolidated from: Containerization fundamentals, Docker platform & architecture, Docker Images (creation, layers, Dockerfile instructions, security), and Docker Swarm (orchestration, nodes, services, tasks, networking).*
