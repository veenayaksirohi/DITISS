# Kubernetes — Complete Revision Notes
### (Cluster Architecture → Namespaces → Pods → Services → ReplicaSets → Deployments)

---

## 0. Full-Form / Key Terms Table

| Term | Full Form / Meaning |
|---|---|
| K8s | Kubernetes (8 letters between K and s) |
| API | Application Programming Interface |
| CP | Control Plane |
| etcd | "et cetera distributed" — distributed key-value store |
| CRI | Container Runtime Interface |
| CNI | Container Network Interface |
| RBAC | Role-Based Access Control |
| HA | High Availability |
| CIDR/IP | Internet Protocol (addressing) |
| CLI | Command Line Interface |
| OCI | Open Container Initiative (image standard) |
| VIP | Virtual IP |
| DNS | Domain Name System |
| PVC | PersistentVolumeClaim |
| PV | PersistentVolume |
| RS | ReplicaSet |
| RC | ReplicationController (legacy) |

---

# PART A — KUBERNETES CLUSTER & CORE COMPONENTS

## 1. What is Kubernetes?

**Kubernetes (K8s)** is an open-source **container orchestration platform**.

It helps to:
- Deploy containerized applications
- Run containers across multiple machines
- Automatically restart failed containers
- Scale applications up or down
- Distribute network traffic (load balancing)
- Perform rolling updates
- Maintain the required number of application instances

**Real-life example:**
An online shopping app has a frontend, backend API, and database. During a sale, traffic suddenly spikes. Kubernetes automatically starts more backend Pods to handle the load. If a Pod crashes, Kubernetes automatically replaces it — no manual intervention needed.

> 🧠 **Exam one-liner:** Kubernetes = automated deployment, scaling, and management of containerized applications.

---

## 2. What is a Kubernetes Cluster?

A **cluster** is a group of physical/virtual machines that run containerized applications under Kubernetes management.

A cluster has **two main parts**:
1. **Control Plane** — the "brain"; manages the cluster
2. **Worker Nodes** — run the actual application Pods

Production clusters commonly use **multiple** control-plane and worker nodes for fault tolerance and high availability.

```
User/Admin → kubectl → Control Plane → Worker Node 1 → App Pods
                                      → Worker Node 2 → App Pods
```

### ⚠️ Terminology Correction (Exam Trap)

| Old (Outdated) Term | Current Correct Term |
|---|---|
| Master Node | Control-Plane Node |
| Minion | Worker Node |
| Master Components | Control-Plane Components |

---

## 3. Node, Pod, Container, Cluster — Key Definitions

| Term | Meaning |
|---|---|
| **Container** | A packaged application + its dependencies |
| **Pod** | Smallest deployable Kubernetes unit; holds 1+ containers |
| **Node** | A physical/virtual machine that runs Pods |
| **Cluster** | Group of control-plane + worker nodes |
| **Service** | Stable network address to reach a group of Pods |

### Cluster Structure (ASCII)

```
Kubernetes Cluster
├── Control Plane
│   ├── kube-apiserver
│   ├── etcd
│   ├── kube-scheduler
│   └── kube-controller-manager
│
├── Worker Node 1
│   ├── kubelet
│   ├── kube-proxy
│   ├── containerd
│   └── Pods
│
└── Worker Node 2
    ├── kubelet
    ├── kube-proxy
    ├── containerd
    └── Pods
```

---

## 4. Types of Kubernetes Clusters

### 4.1 Minikube Cluster

**Minikube** runs a Kubernetes cluster **locally** on a personal computer.

Used for: learning, local development, testing YAML files, testing Deployments/Services, demos.

> ⚠️ **Common Misconception:** "Minikube is only a simulated cluster." — **Incorrect.** Minikube creates a **real local Kubernetes cluster**, usually inside a VM or container. By default it uses a single node that acts as **both** control-plane and worker. It can also run a multi-node local cluster.

**Advantages:** Easy install, runs on laptop, low resource need, good for practice, easy start/stop/delete.

**Disadvantages:** Not HA, limited by laptop resources, not for production, doesn't fully mirror a large prod environment.

#### Important Minikube Commands

```bash
minikube start
```
Creates and starts a local Kubernetes cluster.

```bash
minikube start --driver=docker
```
- `--driver=docker`: Runs the Minikube node using Docker instead of a separate VM driver.

```bash
minikube start --nodes=3
```
- `--nodes=3`: Creates a 3-node local cluster.

```bash
minikube status
```
Shows status of host, kubelet, API Server, kubeconfig.

```bash
minikube stop
```
Stops the cluster (data preserved).

```bash
minikube delete
```
Deletes the cluster and its stored data.

```bash
minikube dashboard
```
Opens the Kubernetes Dashboard UI.

---

### 4.2 Single-Control-Plane Cluster

Contains **1 control-plane node** + one or more worker nodes.
Used for: development, testing, training, small non-critical environments.

```
        Control Plane 1
              |
      ----------------
      |              |
   Worker 1       Worker 2
```

**Advantages:** Simple, easy to configure, fewer servers, low cost.

**Disadvantages:** Control plane = single point of failure. If it fails:
- `kubectl` commands fail
- New Pods can't be scheduled
- Failed workloads may not be replaced
- Controllers can't reconcile state
- Scaling/rolling updates stop

> ⚠️ **Important:** Pods **already running** on worker nodes may continue running (kubelet + container runtime manage them locally), but no new management actions can happen.

---

### 4.3 Multi-Control-Plane (HA) Cluster

Contains **multiple control-plane nodes** + multiple worker nodes + usually a **load balancer** in front of the API Servers. Also called **Highly Available (HA) Cluster**.

```
kubectl/Clients → API Load Balancer → Control Plane 1
                                     → Control Plane 2
                                     → Control Plane 3
                                            ↓
                                      Worker Nodes
```

**Use cases:** Production, banking, e-commerce, healthcare, large enterprise, low-downtime apps.

**Advantages:** High availability, fault tolerance, reliability, survives node failures, low-downtime maintenance.

**Disadvantages:** Expensive, complex install/maintenance, needs load balancing, needs correct etcd design + backup.

---

### 4.4 Cluster Type Comparison

| Feature | Minikube | Single Control Plane | Multi-Control Plane |
|---|---|---|---|
| Main purpose | Learning/local dev | Dev & testing | Production |
| Control-plane nodes | Usually 1 | 1 | Usually 3+ |
| Worker nodes | Same/multiple local | 1 or more | Multiple |
| High availability | No | No | Yes |
| Cost | Low | Medium | High |
| Complexity | Low | Medium | High |
| Failure protection | Low | Low | High |
| Example | Laptop cluster | Lab cluster | EKS/enterprise |

> ⚠️ **Exam Trap:** "3 nodes always means HA" — **False**. HA depends on how control-plane components, etcd members, load balancers, and failure domains are distributed — not just node count.

---

## 5. Kubernetes Control Plane — Overview

The **control plane** is the **brain** of the cluster. It manages: worker nodes, Pod scheduling, desired state, scaling, cluster config, API requests, recovery.

| Component | Main Responsibility |
|---|---|
| `kube-apiserver` | Receives/processes API requests |
| `etcd` | Stores cluster data/state |
| `kube-scheduler` | Selects a node for each new Pod |
| `kube-controller-manager` | Keeps actual state = desired state |
| `cloud-controller-manager` | Integrates K8s with a cloud provider |

---

## 6. kube-apiserver

**Definition:** Exposes the Kubernetes API — the **"front door"** of Kubernetes and the main communication hub.

Components that talk through it: `kubectl`, Scheduler, Controller Manager, Kubelets, Cloud Controller Manager, Operators, external apps.

> ⚠️ **Exam Point:** Almost every component talks **only** through the API Server. Components normally do **not** modify `etcd` directly. `kubectl` never talks to `etcd` or worker nodes directly.

### Request Processing Stages

1. **Authentication** — Who are you?
2. **Authorization** — What are you allowed to do?
3. **Admission Control** — Is this permitted under cluster policy? (runs *after* authN/authZ, *before* storage)
4. **Validation** — Is the object technically correct?
5. **Persistence** — Store accepted state in `etcd`

### Example

```bash
kubectl create deployment web --image=nginx
```
- `create` → creates a resource
- `deployment` → resource type
- `web` → Deployment name
- `--image=nginx` → container image to use

### Features
Provides REST API · validates objects · handles authN/authZ · reads/writes cluster state · communication hub · can run multiple instances · **is stateless**.

**Why stateless?** It does not keep important state in local memory/disk — state lives in `etcd`. So multiple API Server replicas can run behind a load balancer (this enables HA).

**Advantages:** Single controlled entry point, security checks, automation via REST, horizontal scaling.

---

## 7. etcd

**Definition:** A **distributed, strongly consistent key-value store**.

Stores: Pod definitions/status, Deployments, Services, ConfigMaps, Secrets, Node info, Namespaces, Roles/RoleBindings, desired & current state.

```
Key:   /registry/pods/default/web-pod
Value: Pod configuration and state
```

> `etcd` is called the **"source of truth"** — the control plane relies on it for the cluster's stored state. If data is lost with no backup, the cluster loses its saved state.

**Best practices:** regular backups, restrict access, use TLS, protect backup files, test restore procedures, consider encryption at rest.

---

## 8. etcd Leader Election & Raft Consensus

> ⚠️ Correct term: **"Raft consensus algorithm"** — NOT "Raft Census."

Raft helps etcd members: elect a leader, replicate data, agree on changes, stay consistent, tolerate limited failures.

### How Raft Works
1. One member becomes leader.
2. Others become followers.
3. Write requests go through the leader.
4. Change replicated to other members.
5. Committed once a **majority (quorum)** agrees.
6. If leader fails → remaining members elect a new leader.

### Quorum Formula

```
Quorum = floor(n / 2) + 1
```

| etcd Members | Quorum Needed | Failures Tolerated |
|---:|---:|---:|
| 1 | 1 | 0 |
| 2 | 2 | 0 |
| 3 | 2 | 1 |
| 4 | 3 | 1 |
| 5 | 3 | 2 |
| 7 | 4 | 3 |

> 🧠 **Interview point:** Odd-numbered etcd clusters are preferred — going from 3→4 members increases quorum requirement without increasing fault tolerance (waste of a node).

### Two Different Leader-Election Mechanisms (common confusion)

| Process | Used By | Mechanism |
|---|---|---|
| etcd leader election | etcd members | Raft consensus |
| K8s component leader election | Scheduler & Controller Manager replicas | Kubernetes **Lease** objects |

> ⚠️ **Exam Trap:** Not all K8s leader elections use Raft — only etcd does.

---

## 9. Kubernetes Component Leader Election (Scheduler / Controller Manager)

In HA clusters, multiple replicas of `kube-scheduler` and `kube-controller-manager` may run, but **only one actively leads** at a time — using **Lease objects**.

### Working
1. Multiple instances start.
2. They compete to acquire a Lease.
3. One wins → becomes leader.
4. Leader **renews** the Lease regularly.
5. Others stay on standby.
6. If leader stops renewing → another instance takes over.

---

## 10. kube-scheduler

**Definition:** Chooses the best node for a new (unassigned) Pod.

### What it Considers
CPU/memory requests · available node resources · node selector · node affinity · Pod affinity/anti-affinity · taints & tolerations · Pod priority · storage requirements · scheduling policies

### Scheduling Process

**Step 1 — Filtering:** Removes nodes that cannot run the Pod.
Example: Pod needs 2GB RAM; Worker-1 has only 1GB (filtered out); Worker-2 has 4GB (stays).

**Step 2 — Scoring:** Remaining nodes are scored.

**Step 3 — Binding:** Highest-scoring node selected; assignment recorded via API Server.

> ⚠️ **Exam Trap:** The Scheduler **only picks the node** — it does **NOT** start containers. The kubelet + container runtime on that node start containers.

```yaml
resources:
  requests:
    cpu: "500m"      # requests half of one CPU core
    memory: "256Mi"  # requests 256 MiB memory
```

---

## 11. Affinity, Taints & Tolerations

| Concept | Meaning |
|---|---|
| **Node affinity** | Pod prefers/requires nodes with specific labels |
| **Pod affinity** | Place Pod near other selected Pods (e.g., app near cache) |
| **Pod anti-affinity** | Keep selected Pods apart (e.g., spread replicas across nodes) |
| **Taint** | Marks a node to repel ordinary Pods |
| **Toleration** | Allows a specific Pod to be scheduled despite a taint |

```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
            - key: disk
              operator: In
              values: ["ssd"]
```
This Pod can be scheduled **only** on nodes labeled `disk=ssd`.

> 🧠 Control-plane nodes are commonly **tainted** so normal app workloads aren't scheduled there.

---

## 12. kube-controller-manager

**Definition:** Runs several **controller loops**, each comparing:

```
Desired State  vs.  Actual State
```
If different → controller takes corrective action.

**Example:** Desired = 3 frontend Pods; Actual = 2 → controller creates 1 more Pod.

### Common Controllers

| Controller | Responsibility |
|---|---|
| Node Controller | Monitors node status |
| Deployment Controller | Manages Deployment rollout |
| ReplicaSet Controller | Maintains required Pod replicas |
| Job Controller | Ensures a Job completes |
| EndpointSlice Controller | Maintains Service backend endpoint data |
| ServiceAccount Controller | Manages default ServiceAccounts |
| Namespace Controller | Handles namespace lifecycle |

> ⚠️ **Correction:** Legacy **ReplicationController** still exists, but modern apps use `Deployment → ReplicaSet → Pods`. Also, modern Services mainly use **EndpointSlice** objects (not the old "Endpoints" object) to track backends.

### Self-Healing Example (Pod crash)
1. kubelet reports failure
2. Cluster state updated
3. Controller notices fewer replicas than desired
4. Replacement Pod created
5. Scheduler assigns it to a node
6. kubelet starts it

---

## 13. cloud-controller-manager

**Definition:** Connects Kubernetes to a **cloud provider** (AWS, Azure, GCP).

**Responsibilities (varies by provider):** cloud nodes, cloud routes, load balancers, node lifecycle info, cloud-specific integrations.

**Example:** `spec.type: LoadBalancer` on AWS → cloud integration provisions an AWS load balancer.

> ⚠️ It is **optional** — not needed in Minikube, bare-metal clusters without cloud integration, or local labs.

---

## 14. Worker-Node Components — Overview

| Component | Function |
|---|---|
| `kubelet` | Manages Pods assigned to the node |
| `kube-proxy` | Implements Service network forwarding |
| Container runtime | Runs containers |
| CNI plugin | Provides Pod networking |

---

## 15. kubelet

**Definition:** The primary Kubernetes **agent** on each node. Talks to the API Server and manages assigned Pods.

### Responsibilities
Registers node · watches for assigned Pods · calls container runtime · ensures containers run · runs health probes · reports Pod/node status · mounts volumes · restarts failed containers per policy.

### Working Example
1. Scheduler assigns `frontend-pod` to `worker-1` (recorded via API Server).
2. kubelet on `worker-1` notices the assignment.
3. kubelet tells containerd to pull the image.
4. containerd creates/starts the container.
5. kubelet runs health checks.
6. kubelet reports status to API Server.

> ⚠️ **Exam Trap:** kubelet does **NOT** decide *where* a Pod runs — that's the Scheduler's job. kubelet only *manages* the Pod once assigned.

---

## 16. kube-proxy

**Definition:** Implements the **network rules** needed for Kubernetes Services. Watches Services + EndpointSlices and configures node-level networking.

### Responsibilities
Maintains Service network rules · forwards Service traffic to Pod endpoints · load-balances across backend Pods · supports `ClusterIP`/`NodePort` · uses OS networking rules.

**Traditional modes:** `iptables`, `IPVS`, `nftables` (in newer setups).

> 🧠 Some CNI/eBPF systems (e.g., Cilium) can **replace** kube-proxy entirely — so it's considered "optional" in architectures with an equivalent implementation.

### Example

```
backend-pod-1: 10.244.1.10
backend-pod-2: 10.244.2.12
backend-pod-3: 10.244.3.15
```
Pod IPs change over time, but the Service address (`backend-service:5000`) stays stable and forwards to a healthy Pod.

---

## 17. Kubernetes Service (Core Concept)

> ⚠️ A **Service is NOT** a separate server, node, or container. It is a **network abstraction** providing stable access to a group of Pods.

**Why needed?** Pods are temporary — they crash, get recreated, change IPs, and can move nodes. A Service gives a stable **name + virtual IP + port**.

### Common Service Types (quick view — full detail in Part D)

| Type | Access | Use Case |
|---|---|---|
| `ClusterIP` | Inside cluster only | Backend/database |
| `NodePort` | `NodeIP:Port` on every node | Testing/simple external access |
| `LoadBalancer` | Cloud/external LB | Production external access |
| `ExternalName` | Maps to external DNS name | Access external service |

---

## 18. Container Runtime

**Definition:** Software that actually **runs containers**.

Common runtimes: `containerd`, `CRI-O`, other CRI-compatible runtimes, Docker Engine (via adapter `cri-dockerd`).

### Container Runtime Interface (CRI)

```
kubelet → CRI → container runtime → container
```
CRI lets Kubernetes support different runtimes without rewriting kubelet for each one.

**Responsibilities:** pull images · create/start/stop containers · manage execution · report status · delete containers.

---

## 19. Docker Clarification (Important Interview Point)

> ⚠️ "Docker Engine was deprecated in Kubernetes 1.24" needs clarification.

What was actually removed = the **`dockershim`** integration (K8s built-in Docker shim). This does **NOT** mean:
- Docker images stopped working ❌
- Dockerfiles stopped working ❌
- Docker-built images can't run on K8s ❌

Docker images follow the **OCI standard** and run fine through `containerd`/other runtimes.

> ✅ **Correct interview statement:** "Kubernetes removed dockershim in v1.24. Docker-built images continue to work since they're OCI-compliant. Kubernetes commonly uses CRI-compatible runtimes like containerd or CRI-O. Docker Engine can still connect via `cri-dockerd` if needed."

---

## 20. CNI & Pod Networking

**CNI (Container Network Interface) plugin** — provides Pod networking.

Common CNI plugins: **Calico, Cilium, Flannel, AWS VPC CNI**.

Provides: Pod IP addresses · Pod-to-Pod connectivity · inter-node routes · NetworkPolicy enforcement (if supported).

### kube-proxy vs CNI

| Component | Main Purpose |
|---|---|
| CNI plugin | Creates/manages Pod networking |
| kube-proxy | Implements Service traffic forwarding |
| NetworkPolicy | Defines permitted Pod traffic |
| Host firewall/security group | Controls traffic entering/leaving nodes |

---

## 21. Kubernetes & Firewall Rules

Required rules depend on cluster design + CNI plugin.

| Port | Protocol | Purpose |
|---:|---|---|
| 6443 | TCP | Kubernetes API Server |
| 2379–2380 | TCP | etcd client & member communication |
| 10250 | TCP | Kubelet API |
| 10257 | TCP | Controller Manager secure port |
| 10259 | TCP | Scheduler secure port |
| 10256 | TCP | kube-proxy health/metrics |
| 30000–32767 | TCP/UDP | Default NodePort range |

> ⚠️ **Never expose etcd or kubelet ports publicly.**

### Firewall vs NetworkPolicy

| Feature | Firewall/Security Group | Kubernetes NetworkPolicy |
|---|---|---|
| Protects | Nodes & networks | Pod traffic |
| Level | Infrastructure | K8s workload |
| Example | Allow API port only from admin network | Allow frontend Pods → backend Pods |
| Enforced by | OS firewall / cloud controls | Network (CNI) plugin |

---

## 22. RBAC Security

**RBAC = Role-Based Access Control.** Controls which users/ServiceAccounts can do what.

**Examples:** developer views Pods only · CI/CD pipeline updates Deployments · monitoring SA reads metrics · DBA accesses only DB resources.

### Main RBAC Resources

| Resource | Scope | Meaning |
|---|---|---|
| `Role` | One namespace | Defines permissions |
| `ClusterRole` | Cluster-wide/reusable | Wider permissions |
| `RoleBinding` | One namespace | Assigns Role/ClusterRole |
| `ClusterRoleBinding` | Whole cluster | Assigns ClusterRole globally |

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: development
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
```
- `resources: ["pods"]` → applies to Pods
- `get` → read one Pod · `list` → list Pods · `watch` → watch changes

> ⚠️ **Exam Trap:** RBAC is enforced by the **API Server** during authorization — it is **NOT** a Controller Manager feature.

---

## 23. Complete Pod Deployment Workflow (End-to-End)

```bash
kubectl apply -f deployment.yaml
```

```
kubectl → API Server → etcd (store state)
Scheduler → API Server (find unscheduled Pod, bind to node)
Kubelet → API Server (read assigned Pod)
Kubelet → Runtime (start containers)
Kubelet → API Server (report status)
```

### Step-by-Step
1. User writes YAML manifest.
2. `kubectl` sends it to API Server.
3. API Server authenticates the user.
4. RBAC checks authorization.
5. Admission control + validation checks the request.
6. Desired state stored in `etcd`.
7. Deployment + ReplicaSet controllers create Pod objects.
8. Scheduler finds unassigned Pods.
9. Scheduler filters + scores nodes.
10. Scheduler selects a node.
11. kubelet on that node reads the Pod spec.
12. kubelet asks runtime to pull/start the image.
13. CNI plugin sets up Pod networking.
14. kubelet runs health checks.
15. kubelet reports status to API Server.
16. Controllers keep checking desired vs actual state continuously.

---

## 24. Practical Example — Deployment + Service

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
```

### Useful Commands

```bash
kubectl apply -f deployment.yaml     # create/update Deployment
kubectl apply -f service.yaml        # create/update Service
kubectl get nodes                    # list cluster nodes
kubectl get pods -o wide             # list Pods (+IP, node info)
kubectl get services                 # list Services
kubectl describe pod <pod-name>      # detailed Pod info/events
kubectl logs <pod-name>              # container logs
kubectl scale deployment nginx-deployment --replicas=5   # scale to 5 Pods
```

---

## 25. Component Comparison Table

| Component | Runs On | Main Job | Stores Cluster State? |
|---|---|---|---|
| API Server | Control plane | Handles API requests | No |
| etcd | Control plane | Stores cluster state | **Yes** |
| Scheduler | Control plane | Selects nodes for Pods | No |
| Controller Manager | Control plane | Maintains desired state | No |
| Cloud Controller Manager | Control plane | Cloud integration | No |
| kubelet | Nodes | Runs/monitors assigned Pods | No |
| kube-proxy | Nodes | Service networking | No |
| Container runtime | Nodes | Runs containers | No |

---

## 26. Common Misconceptions (High-Yield Exam Traps)

| Myth | Reality |
|---|---|
| Minikube is only simulated | It's a real local K8s cluster |
| Scheduler starts containers | Scheduler only picks the node; kubelet+runtime start it |
| kubelet selects the node | Scheduler selects; kubelet manages the assigned Pod |
| kube-proxy is a firewall | It implements Service traffic rules, not a firewall |
| A Service is a physical server | It's a logical networking abstraction |
| Every HA election uses Raft | Only etcd uses Raft; Scheduler/Controller Manager use Leases |
| K8s no longer supports Docker images | Only dockershim was removed; OCI images still work |
| 3 nodes = always HA | Depends on component/etcd distribution, not just node count |

---

## 27. Interview Q&A — Cluster & Components

| # | Question | Answer |
|---|---|---|
| 1 | What is a Kubernetes cluster? | A group of control-plane and worker nodes used to deploy/manage containerized apps. |
| 2 | Control plane vs worker node? | Control plane manages the cluster; worker nodes run application Pods. |
| 3 | What is Minikube? | A tool creating a local K8s cluster for learning/dev/testing. |
| 4 | Is Minikube simulated? | No, it's a real local Kubernetes implementation. |
| 5 | What is kube-apiserver? | Main entry point of the control plane; processes API requests. |
| 6 | Does kubectl talk to etcd directly? | No, only through the API Server. |
| 7 | What is etcd? | Distributed key-value store holding cluster state. |
| 8 | What happens if etcd is lost? | Cluster loses stored state unless recovered from members/backup. |
| 9 | Role of kube-scheduler? | Selects a suitable node for each new unscheduled Pod. |
| 10 | Role of kube-controller-manager? | Runs controllers that move actual state toward desired state. |
| 11 | What is kubelet? | Node agent ensuring assigned Pods/containers run correctly. |
| 12 | What is kube-proxy? | Implements network forwarding rules for Services. |
| 13 | What is a container runtime? | Software that pulls images and runs containers (e.g., containerd). |
| 14 | What is CRI? | Interface between kubelet and the container runtime. |
| 15 | Why multiple control-plane nodes? | For high availability and continued management if one fails. |
| 16 | What is leader election? | Selecting one active leader among multiple instances. |
| 17 | What is Raft? | Consensus algorithm etcd uses to elect leader/agree on data. |
| 18 | What is quorum? | Minimum majority of etcd members needed to approve operations. |
| 19 | What is desired state? | The state declared by the user (e.g., "3 Pods must run"). |
| 20 | What is actual state? | The real current condition of the cluster. |
| 21 | What is RBAC? | Controls actions users/ServiceAccounts can perform via roles. |
| 22 | Did K8s remove Docker support? | Only dockershim was removed; Docker-built images still work. |

---

# PART B — NAMESPACES

## 1. Kubernetes Object Hierarchy (Big Picture)

```
Namespace → Deployment → ReplicaSet → Pods
Service → (selects/exposes) → Pods
```

- **Namespace** organizes/separates resources
- **Deployment** manages app updates & scaling
- **ReplicaSet** maintains required Pod count
- **Pod** runs the application container
- **Service** gives Pods a stable network address

---

## 2. Namespace — Definition & Purpose

A **Namespace** is a **logical division** inside a cluster. Useful when one cluster is shared by multiple teams, projects, customers, or environments (dev/test/prod).

**Real-life example:**
```
Kubernetes Cluster
├── development namespace
├── testing namespace
├── preprod namespace
├── production namespace
└── monitoring namespace
```
Dev and prod run in the *same* cluster but stay logically separated.

### Naming Rules
- Resource names must be **unique within their type + namespace**.
- ✅ Allowed: `development/Pod:frontend` and `production/Pod:frontend`
- ❌ Not allowed: two Pods named `frontend` in the **same** namespace
- ✅ Allowed: `development/Pod:frontend` and `development/Service:frontend` (different resource types can share a name)
- Every object also gets a cluster-wide unique **UID**.

### Important Namespace Properties
- Namespaces **cannot be nested**.
- A namespaced resource belongs to **only one** namespace.
- You **cannot move** a resource between namespaces directly — recreate it in the destination.
- Deleting a namespace **deletes all its namespaced resources** (⚠️ dangerous).
- Namespaces give logical separation but are **not complete security boundaries** alone.

**Nesting NOT possible:**
```
production
└── backend      ❌ Invalid
    └── database
```
Instead create separate namespaces: `production-backend`, `production-database`.

---

## 3. Namespaced vs Cluster-Scoped Resources

| Namespaced Resources | Cluster-Scoped Resources |
|---|---|
| Pod | Node |
| Deployment | Namespace |
| ReplicaSet | PersistentVolume |
| Service | StorageClass |
| ConfigMap | ClusterRole |
| Secret | ClusterRoleBinding |
| Role | CustomResourceDefinition |
| PersistentVolumeClaim | |

```bash
kubectl api-resources --namespaced=true    # list namespaced resource types
kubectl api-resources --namespaced=false   # list cluster-scoped resource types
```

---

## 4. Default Namespaces in a New Cluster

| Namespace | Purpose |
|---|---|
| `default` | Used when no namespace is specified |
| `kube-system` | Kubernetes system components |
| `kube-public` | Publicly readable cluster info |
| `kube-node-lease` | Lease objects used for node heartbeats |

> 🧠 If you don't specify a namespace, K8s uses `default`.

---

## 5. Namespace Commands

```bash
kubectl get namespaces                # list namespaces
kubectl get ns                        # short form

kubectl create namespace development  # create a namespace

kubectl get pods --namespace development   # get Pods in a namespace
kubectl get pods -n development             # short form

kubectl get pods --all-namespaces     # Pods from ALL namespaces
kubectl get pods -A                   # short form

kubectl config set-context --current --namespace=development
# sets 'development' as the default namespace for the current context
# (commands can then omit -n development)

kubectl delete namespace development  # ⚠️ deletes namespace + its resources
```

### Namespace YAML

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
```
```bash
kubectl apply -f namespace.yaml
```

---

## 6. ResourceQuota

Limits **total resource usage** inside a namespace: CPU, memory, Pod count, Service count, Secret count, PVC count.

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: development-quota
  namespace: development
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    pods: "20"
```
This namespace can request max 4 CPU cores, 8GiB memory, limit up to 8 CPU/16GiB, and run max 20 Pods.

---

## 7. Namespace Advantages & Limitations

**Advantages:** organizes resources · separates teams/projects · allows namespace-level RBAC · supports ResourceQuota · eases resource search · allows duplicate names across namespaces · separates dev/prod.

**Limitations:** no complete physical isolation · cannot be nested · resource can't belong to multiple namespaces · some resources are cluster-scoped · network traffic is **not** automatically blocked between namespaces.

> ⚠️ **Exam Trap:** Namespaces do **NOT** automatically block Pod-to-Pod traffic across namespaces. Use **NetworkPolicy** for that.

---

# PART C — PODS

## 1. Pod — Definition

The **smallest deployable compute object** in Kubernetes. Represents one or more closely related containers running together.

A Pod gives its containers:
- Shared networking
- Shared storage volumes
- A Pod IP address
- Container execution config
- Resource requests/limits
- Health-check config
- Restart policies

---

## 2. Pod as a Deployment Unit

Kubernetes schedules the **entire Pod**, never individual containers separately.

```
Pod
├── Application container
├── Logging sidecar
└── Proxy sidecar
```
All three: run on the **same node**, share the Pod network, can share volumes, and are created/deleted together.

---

## 3. What a Pod Can Encapsulate

1. **Application containers** — main programs (Nginx, Flask, Java app, PostgreSQL)
2. **Storage resources** — volumes: `emptyDir`, ConfigMap volume, Secret volume, PVC
3. **Networking** — Pod gets its own IP (e.g., `10.244.0.5`)
4. **Container-running options** — image, command/args, env vars, ports, CPU/memory requests & limits, volumes, security context, health probes, restart policy

---

## 4. Pod Networking

### 4.1 One Pod = One IP
All containers **inside the same Pod** share:
- Same Pod IP
- Same network interfaces
- Same port space

They can talk to each other via **`localhost`**.

**Example:** Flask app on port `5000` + Nginx proxy on port `80` in the same Pod → Nginx reaches Flask via `http://localhost:5000`.

> ⚠️ **Port conflict:** Two containers in the same Pod **cannot** both bind to `0.0.0.0:8080`.

### 4.2 Pod IP is Temporary
If a Pod is deleted/recreated, its IP usually **changes**:
```
Old Pod IP: 10.244.0.5
New Pod IP: 10.244.1.8
```
→ Always use a **Service** instead of a raw Pod IP.

---

## 5. Types of Pods

### 5.1 Single-Container Pod
```
Pod
└── Nginx container
```
**Use cases:** simple web server, backend API, batch job, independent microservice.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
    - name: nginx
      image: nginx:1.27
```

### 5.2 Multi-Container Pod
```
Pod
├── Main application
└── Supporting container
```
Good pairings: app + log collector, app + proxy, app + config reloader, app + monitoring agent.

> ⚠️ **Poor design:** Do NOT put unrelated services (frontend + backend + database) in one Pod just to reduce Pod count — they need independent scaling/updates/failure handling.

---

## 6. Sidecar Container Pattern

A **sidecar** runs **alongside** the main container, providing supporting functionality: log collection, traffic forwarding, config refresh, service-mesh proxy, file sync. Runs concurrently and shares the Pod network (and storage, if configured).

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-with-logger
spec:
  volumes:
    - name: logs
      emptyDir: {}
  containers:
    - name: web
      image: nginx:1.27
      volumeMounts:
        - name: logs
          mountPath: /var/log/nginx
    - name: log-reader
      image: busybox:1.36
      command: ["sh", "-c", "tail -F /var/log/nginx/access.log"]
      volumeMounts:
        - name: logs
          mountPath: /var/log/nginx
```
**Working:** Both containers run in one Pod → `web` writes logs → shared `emptyDir` volume stores them → `log-reader` reads them.

---

## 7. Init Containers

**Definition:** Performs **initialization work** before the regular application containers start. Examples: wait for a DB, download configs, set permissions, generate config, run checks.

### Working
1. Pod starts.
2. First init container runs and **must complete successfully**.
3. Next init container runs (if any).
4. **All** regular init containers must finish.
5. Application containers start only after that.

> ⚠️ **Correction:** It's incorrect to say "only one init container exists, then only one main container runs." A Pod may have **multiple init containers**, **multiple app containers**, and **sidecars**.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-with-init
spec:
  initContainers:
    - name: create-file
      image: busybox:1.36
      command: ["sh", "-c", "echo 'Application initialized' > /work/message.txt"]
      volumeMounts:
        - name: shared-data
          mountPath: /work
  containers:
    - name: web
      image: nginx:1.27
      volumeMounts:
        - name: shared-data
          mountPath: /usr/share/nginx/html
  volumes:
    - name: shared-data
      emptyDir: {}
```

### Init Container vs Sidecar

| Feature | Init Container | Sidecar Container |
|---|---|---|
| Starts before main app | Yes | Can start before or alongside |
| Runs to completion | Yes (regular init) | Usually no |
| Runs throughout Pod life | No | Usually yes |
| Main purpose | Initialization | Continuous supporting function |
| Example | Wait for database | Log collector |
| Can share volumes | Yes | Yes |
| Shares Pod network | Yes | Yes |

---

## 8. Pod YAML Structure — Field by Field

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  namespace: development
  labels:
    app: myapp
    environment: development
spec:
  containers:
    - name: myapp-container
      image: httpd:2.4
      ports:
        - name: http
          containerPort: 80
          protocol: TCP
```

### 8.1 `apiVersion`

| Resource | API Version |
|---|---|
| Pod | `v1` |
| Service | `v1` |
| Namespace | `v1` |
| ConfigMap | `v1` |
| Secret | `v1` |
| Deployment | `apps/v1` |
| ReplicaSet | `apps/v1` |
| StatefulSet | `apps/v1` |

> ⚠️ `v1` does NOT mean "basic" and `apps/v1` does NOT simply mean "advanced." `v1` = **core API group**, version 1. `apps/v1` = **apps API group**, version 1.

### 8.2 `kind`
The object type: `Pod`, `Service`, `Deployment`, `ReplicaSet`, `Namespace`, etc.

### 8.3 `metadata`

| Field | Meaning |
|---|---|
| `name` | Object name |
| `namespace` | Namespace it belongs to |
| `labels` | Key-value pairs used to identify/select objects |
| `annotations` | Extra non-identifying info |

### 8.4 Labels
```yaml
labels:
  app: myapp
  tier: frontend
  environment: production
```
Used by Services/controllers to **select** Pods.
> ⚠️ Label matching is **case-sensitive**: `MyApp` ≠ `myapp`.

### 8.5 `spec`
Describes the desired configuration: containers, init containers, volumes, restart policy, node selection, service account, security settings, resource requirements.

### 8.6 `containers`
A **list**; each entry = one regular container (`name`, `image`, etc.).

### 8.7 `containerPort`
```yaml
ports:
  - containerPort: 80
```
> ⚠️ This is **documentation only** — it does **not** expose the app outside the Pod. A **Service** is needed for stable external/internal access, and the app must actually listen on that port.

---

## 9. Pod Commands

```bash
kubectl apply -f pod.yaml                  # create/update Pod

kubectl get pods                           # list Pods
kubectl get pods -o wide                   # + Pod IP & assigned node

kubectl describe pod myapp-pod             # detailed info: config, node, IP,
                                            # container status, conditions, events

kubectl logs myapp-pod                     # view logs
kubectl logs myapp-pod -c myapp-container  # -c: select container (multi-container Pod)

kubectl exec -it myapp-pod -- sh
# exec: run command inside container
# -i: keep stdin open   -t: allocate terminal
# --: separates kubectl options from container command
# sh: command to run

kubectl exec -it myapp-pod -c myapp-container -- sh   # target specific container

kubectl delete pod myapp-pod               # delete Pod
```
> ⚠️ A **manually created** Pod is **not** auto-recreated after deletion. A Pod managed by a ReplicaSet/Deployment normally **is** replaced.

---

# PART D — SERVICES

## 1. Service — Definition

A **network abstraction** that exposes one or more Pods through a **stable endpoint**: stable virtual IP, stable DNS name, stable port, and traffic distribution across backend Pods — even as Pods are replaced and IPs change.

---

## 2. Why is a Service Required?

| Pod | Pod IP |
|---|---|
| `web-1` | `10.244.0.3` |
| `web-2` | `10.244.0.4` |
| `web-3` | `10.244.0.5` |

Pod IPs change → a Service gives one **stable address**:
```
Service IP: 10.106.247.157
Service DNS: web-service
```
Clients contact the Service, never individual Pod IPs directly.

---

## 3. How a Service Finds Pods — Label Selector

Pod label:
```yaml
labels:
  app: myapp
```
Service selector:
```yaml
selector:
  app: myapp
```
Labels **must match exactly** (case-sensitive).

❌ Incorrect (mismatch): Pod `app: myapp` vs Service `app: MyApp` → **fails to select**.
✅ Correct: both use `app: myapp`.

### EndpointSlice
Kubernetes records matching backend Pod IPs in **EndpointSlice** objects:
```
Service: web-service
EndpointSlice:
- 10.244.0.3:80
- 10.244.0.4:80
- 10.244.0.5:80
```
Endpoints are added/removed automatically as Pods become ready/are removed.

```bash
kubectl get endpointslices
```

---

## 4. Service Ports

```yaml
ports:
  - port: 80
    targetPort: 8080
    nodePort: 32000
```

| Field | Meaning |
|---|---|
| `port` | Port exposed **by the Service** |
| `targetPort` | Port on the **destination Pod/container** |
| `nodePort` | Port exposed **on every node** (NodePort Service only) |

### Traffic Flow
```
NodeIP:32000 → Service port 80 → Pod targetPort 8080
```

---

## 5. Service Types

### 5.1 ClusterIP (default)
Exposes the app **only inside the cluster**.
```yaml
spec:
  type: ClusterIP
```
**Use cases:** backend API, internal DB, Redis, internal microservice, frontend→backend.
**Advantages:** stable internal IP/DNS, not directly exposed externally.
**Limitation:** cannot be reached directly from outside the cluster.

### 5.2 NodePort
Exposes the Service via a port on **every node**: `<NodeIP>:<NodePort>` (e.g., `192.168.1.20:32000`). Default range: **30000–32767**.

**Use cases:** labs, testing, bare-metal, external LB forwarding to node ports.
**Advantages:** simple, no cloud LB needed.
**Disadvantages:** high port numbers, node IP must be reachable, not ideal as main public method, firewall must allow the port.

### 5.3 LoadBalancer
Requests an **external load balancer** from a supported environment (AWS, Azure, GCP, MetalLB on bare metal).

```
User → External LB → K8s Service → Selected Pod
```
**Advantages:** external access, good for production TCP/UDP, integrates with cloud, distributes traffic.
**Disadvantages:** cloud cost, needs supported LB implementation, each Service may create its own LB, provisioning takes time.

### 5.4 ExternalName
Maps a Service name to an **external DNS name** — no normal Pod selector used.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-database
spec:
  type: ExternalName
  externalName: database.example.com
```

### 5.5 Service Type Comparison

| Feature | ClusterIP | NodePort | LoadBalancer |
|---|---|---|---|
| Internal access | Yes | Yes | Yes |
| External access | No (normally) | Yes | Yes |
| External method | None | `NodeIP:NodePort` | LB address |
| Default type | Yes | No | No |
| Cloud integration needed | No | No | Usually |
| Common use | Internal services | Labs/testing | Production exposure |

> 🧠 Conceptually: `LoadBalancer` (includes Service functionality) → uses `NodePort`-like mechanism (impl-dependent) → built on `ClusterIP`.

---

## 6. Service YAML Examples

### ClusterIP
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
  namespace: development
spec:
  type: ClusterIP
  selector:
    app: myapp
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
```

### NodePort
```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-nodeport
  namespace: development
spec:
  type: NodePort
  selector:
    app: myapp
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 32000
```
Access via `<NodeIP>:32000`. If `nodePort` omitted, K8s auto-picks from the NodePort range.

### LoadBalancer
```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-loadbalancer
  namespace: production
spec:
  type: LoadBalancer
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```
```bash
kubectl get service myapp-loadbalancer -n production   # get external address
```

---

## 7. Service Commands

```bash
kubectl get services                       # list Services
kubectl get svc                             # short form

kubectl describe service my-service         # type, ClusterIP, selector, ports,
                                             # endpoints, events

kubectl get endpointslices                  # endpoint backend info

kubectl port-forward service/my-service 8080:80
# port-forward: temporary local connection
# service/my-service: target Service
# 8080:80: local port 8080 → Service port 80
# Access at http://localhost:8080
```

---

# PART E — REPLICASETS & DEPLOYMENTS

## 1. ReplicaSet — Definition

Ensures a **specified number** of matching Pod replicas are running.

```yaml
replicas: 3
```
K8s tries to always keep 3 Pods running.

> 🧠 Deployments are normally preferred over creating ReplicaSets directly, since RS alone doesn't give controlled rolling updates.

### How It Works

| Situation | Action |
|---|---|
| Too few Pods (Desired 3, Actual 2) | Creates 1 more Pod |
| Too many Pods (Desired 3, Actual 5) | Terminates 2 Pods |
| A Pod fails | Creates a replacement |
| A worker node fails | Control plane notices missing Pods, creates replacements (subject to scheduling) |

### Correct ReplicaSet YAML

> ⚠️ **Common mistake:** using `apiVersion: v1` for a ReplicaSet — **incorrect**. Correct version is `apps/v1`.

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
  namespace: development
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - containerPort: 80
```

### Key Fields
- `replicas` → desired Pod count
- `selector.matchLabels` → identifies Pods managed by this RS
- `template` → defines how new Pods are created

> ⚠️ **Important rule:** `selector.matchLabels` **must match** `template.metadata.labels`, or Kubernetes rejects the manifest.

### ReplicaSet Commands

```bash
kubectl apply -f replicaset.yaml                       # create
kubectl get replicasets                                # list
kubectl get rs                                          # short form
kubectl describe replicaset nginx-replicaset            # details
kubectl scale replicaset nginx-replicaset --replicas=5  # scale to 5
kubectl delete pod <pod-name>                           # RS auto-replaces it
```

### Advantages / Disadvantages

**Advantages:** maintains desired Pod count, replaces failed/deleted Pods, manual scaling, better availability.

**Disadvantages:** no controlled rolling updates, no convenient rollout history, rollback inconvenient, **normally should not be created directly**.

---

## 2. Deployment — Definition

Provides **declarative management and updates** for Pods and ReplicaSets. You declare the desired state; the Deployment Controller moves the actual state toward it.

```
Deployment → ReplicaSet → Pods
```

### What a Deployment Can Do
Create a ReplicaSet · create desired Pods · scale up/down · rolling updates · check rollout status · pause/resume rollouts · rollback to earlier revision · replace failed Pods (via its RS) · clean up old ReplicaSets.

---

## 3. Desired State vs Actual State (Recap)

```
Desired: replicas: 4
Actual:  3 Pods running
```
→ Deployment + ReplicaSet controllers work to create the 4th Pod.

---

## 4. Deployment YAML — Full Example

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: development
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.27
          ports:
            - name: http
              containerPort: 80
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
```

| Field | Meaning |
|---|---|
| `replicas: 3` | Maintain 3 Pods |
| `selector` | Selects Pods managed by this Deployment |
| `template` | Pod creation template |
| `strategy` | Update method |
| `maxUnavailable: 1` | Max 1 desired Pod may be unavailable during rollout |
| `maxSurge: 1` | Max 1 extra Pod may be created during rollout |
| `requests` | Used for scheduling decisions |
| `limits` | Maximum container resource usage |

---

## 5. Deployment Update Strategies

### 5.1 RollingUpdate (default)
Gradually replaces old Pods with new ones:
```
V1 Pods: 3 → create 1 V2 Pod → remove 1 V1 Pod → repeat → all V2
```
**Advantages:** reduced/zero downtime (if configured well), gradual rollout, easier failure detection, supports rollback.
**Limitation:** during rollout, old & new versions may run simultaneously — must be compatible.

### 5.2 Recreate
Terminates **all** old Pods before creating new ones.
```yaml
strategy:
  type: Recreate
```
**Use cases:** old/new versions incompatible, dev environments, apps needing exclusive resource access.
**Disadvantage:** causes downtime.

---

## 6. Deployment Commands

```bash
kubectl apply -f deployment.yaml                     # create/update

kubectl get deployments                              # list
kubectl get deploy                                    # short form

kubectl get deployments,replicasets,pods              # see relationships

kubectl scale deployment nginx-deployment --replicas=5   # scale

kubectl set image deployment/nginx-deployment nginx=nginx:1.28
# set image: change container image
# deployment/nginx-deployment: target
# nginx=nginx:1.28: container name = new image:tag

kubectl rollout status deployment/nginx-deployment    # check rollout status
kubectl rollout history deployment/nginx-deployment   # view revision history

kubectl rollout undo deployment/nginx-deployment                    # rollback to previous
kubectl rollout undo deployment/nginx-deployment --to-revision=2    # rollback to rev 2

kubectl rollout pause deployment/nginx-deployment      # pause rollout
kubectl rollout resume deployment/nginx-deployment     # resume rollout
kubectl rollout restart deployment/nginx-deployment    # restart Pods (new rollout, same image)
```

---

## 7. Pod vs ReplicaSet vs Deployment — Comparison

| Feature | Pod | ReplicaSet | Deployment |
|---|---|---|---|
| Runs containers | Yes | Through Pods | Through RS + Pods |
| Maintains replicas | No | Yes | Yes |
| Replaces failed Pods | No (if manual) | Yes | Yes |
| Supports scaling | Not directly | Yes | Yes |
| Rolling update | No | Not directly | **Yes** |
| Rollback | No | No convenient built-in | **Yes** |
| Recommended for apps | Usually no | Usually no (directly) | **Yes** |
| API version | `v1` | `apps/v1` | `apps/v1` |

> 🧠 **Interview one-liner:** "A Pod runs containers. A ReplicaSet maintains the required number of Pods. A Deployment manages ReplicaSets and provides rolling updates, scaling, and rollback."

---

## 8. Complete Application Example (Namespace + Deployment + Service)

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:1.27
          ports:
            - containerPort: 80
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: production
spec:
  type: LoadBalancer
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

### Request Flow
```
User → External Load Balancer → Service:80 → Pod1:80 / Pod2:80 / Pod3:80
```

### Working
1. User sends a request to the external LB address.
2. LB forwards traffic to the K8s Service.
3. Service selects Pods with `app=web`.
4. EndpointSlices list current backend Pod addresses.
5. Traffic sent to a ready Pod on `targetPort: 80`.
6. If a Pod fails, the ReplicaSet creates a replacement.
7. Service automatically updates to use the healthy endpoint set.

---

## 9. Common Mistakes (Exam Traps — Namespaces/Pods/Services/Deployments)

| Mistake | Correct Approach |
|---|---|
| `apiVersion: v1` for ReplicaSet | Use `apiVersion: apps/v1` |
| Service selector `app: MyApp` vs Pod label `app: myapp` | Labels are case-sensitive — must match exactly |
| Treating `containerPort` as external exposure | It's documentation only — a Service is required |
| Accessing Pods directly by IP | Pod IPs change — always use a Service |
| Creating standalone Pods for production | Manual Pods aren't auto-replaced — use a Deployment |
| Creating ReplicaSets directly | Deployment gives better update/rollback management |
| Mixing unrelated containers in 1 Pod | Containers in a Pod should be tightly related, scale together |
| Assuming namespaces block network traffic | They don't — use NetworkPolicy for isolation |

---

## 10. Interview Q&A — Namespaces, Pods, Services, Deployments

| # | Question | Answer |
|---|---|---|
| 1 | What is a Namespace? | Logical division inside a cluster for organizing resources by team/project/env. |
| 2 | Can two Pods have the same name? | Yes, in different namespaces; not in the same one. |
| 3 | Can namespaces be nested? | No. |
| 4 | Can a resource belong to two namespaces? | No, only one. |
| 5 | Are all resources namespaced? | No — Nodes, Namespaces, PVs, ClusterRoles are cluster-scoped. |
| 6 | Is a Namespace a security boundary? | No — combine with RBAC, ResourceQuota, NetworkPolicy. |
| 7 | What is a Pod? | Smallest deployable K8s object; holds 1+ closely related containers. |
| 8 | Do containers in a Pod get different IPs? | No — they share the Pod IP/network. |
| 9 | How do containers in a Pod communicate? | Via `localhost` and different ports. |
| 10 | Can one Pod run multiple containers? | Yes, if closely related. |
| 11 | What is a sidecar container? | Runs alongside the main app, providing continuous support functionality. |
| 12 | What is an init container? | Runs and must complete before regular app containers start. |
| 13 | Can a Pod have multiple init containers? | Yes; they run sequentially. |
| 14 | Why avoid using Pod IPs directly? | They can change when Pods are recreated. |
| 15 | What is a Service? | Provides stable network access to a logical group of Pods. |
| 16 | How does a Service find Pods? | Via label selector; matches stored in EndpointSlices. |
| 17 | What is ClusterIP? | Default type; exposes Service internally only. |
| 18 | What is NodePort? | Exposes Service on a static port on each node (`NodeIP:NodePort`). |
| 19 | What is LoadBalancer? | Requests an external LB from a supported environment. |
| 20 | Difference: `port` vs `targetPort`? | `port` = Service port; `targetPort` = destination Pod port. |
| 21 | What is `nodePort`? | Port exposed on every node for a NodePort Service. |
| 22 | What is a ReplicaSet? | Ensures the specified number of matching Pods keeps running. |
| 23 | What happens when a RS-managed Pod is deleted? | RS creates a replacement to maintain desired count. |
| 24 | What is a Deployment? | Manages ReplicaSets; gives declarative scaling, rolling updates, rollback. |
| 25 | Why use Deployment over ReplicaSet? | Controlled updates, rollout history, and rollback. |
| 26 | Deployment hierarchy? | Deployment → ReplicaSet → Pods. |
| 27 | What is a rolling update? | Gradually replaces old Pods with new ones, keeping app available. |
| 28 | RollingUpdate vs Recreate? | RollingUpdate replaces gradually; Recreate stops all old Pods first (causes downtime). |

---

# PART F — MASTER QUICK-REVISION SUMMARY

## Cluster
```
Kubernetes Cluster = Control Plane + Worker Nodes
```

### Control-Plane Components
```
API Server            → Receives & validates requests (stateless, front door)
etcd                  → Stores cluster state (source of truth)
Scheduler              → Selects the node for a Pod (filter → score → bind)
Controller Manager     → Maintains desired state via controller loops
Cloud Controller Mgr   → Connects K8s with a cloud provider (optional)
```

### Node Components
```
kubelet         → Manages assigned Pods (agent on each node)
kube-proxy      → Implements Service traffic forwarding
Container runtime → Runs containers (containerd, CRI-O)
CNI plugin      → Provides Pod networking (Calico, Cilium, Flannel)
```

### High Availability
```
Multiple API Servers + Multiple Scheduler/Controller instances
+ Multiple etcd members + Load balancer
= Highly Available Control Plane
```

### Leader Election
```
etcd members                        → Raft consensus
Scheduler & Controller Manager      → Kubernetes Lease objects
```

### Core Workflow
```
kubectl → API Server → etcd → Controllers → Scheduler → kubelet
→ Container runtime → Running Pod
```

## Namespace
```
→ Logically divides the cluster
→ For teams, projects, environments
→ Resource names unique within a namespace
→ Cannot be nested
→ Use RBAC + ResourceQuota + NetworkPolicy for real isolation
```

## Pod
```
→ Smallest deployable K8s compute object
→ Holds 1+ containers
→ Gets one Pod IP (shared by all its containers)
→ Containers can share volumes
→ Should be managed via a Deployment, not created standalone
```

## Container Patterns
```
Single-container Pod → one app container
Multi-container Pod  → closely related containers
Init container       → runs & completes BEFORE app containers start
Sidecar               → runs ALONGSIDE the app, continuously
```

## Service
```
→ Stable IP + DNS name
→ Selects Pods via label selector (case-sensitive match)
→ Sends traffic to EndpointSlice-listed backends
```

### Port Mapping
```
NodeIP:nodePort → Service port → Pod targetPort
```

### Service Types
```
ClusterIP    → Internal access only (default)
NodePort     → NodeIP:NodePort access
LoadBalancer → External load-balancer access
ExternalName → Maps to external DNS name
```

## ReplicaSet
```
→ Maintains the desired Pod count
→ Creates Pods if too few
→ Removes Pods if too many
→ Replaces failed/deleted Pods
→ apiVersion: apps/v1 (NOT v1)
```

## Deployment
```
→ Manages ReplicaSets → ReplicaSet manages Pods
→ Supports scaling, rolling updates, rollback
→ Default strategy: RollingUpdate (also: Recreate)
```

## Final Object Relationship
```
Namespace
└── Deployment
    └── ReplicaSet
        └── Pods

Service
└── Selects and exposes the Pods
```

## One-Line Master Answer (Say this in interviews)
> "A Kubernetes cluster consists of a control plane and worker nodes. The control plane uses the API Server, etcd, Scheduler, and Controller Manager to manage the cluster, while worker nodes use kubelet, kube-proxy, a CNI plugin, and a container runtime to run and connect application Pods. Namespaces logically divide the cluster, Pods are the smallest deployable unit, Services give Pods a stable network identity, ReplicaSets maintain the desired Pod count, and Deployments manage ReplicaSets to provide rolling updates, scaling, and rollback."
