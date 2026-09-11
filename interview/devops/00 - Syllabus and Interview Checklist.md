---
title: 00 - Syllabus and Interview Checklist
aliases:
  - IT Infrastructure Management & DevOps - CDAC DITISS Syllabus
  - devops-it-infrastructure-interview-notes
tags:
  - devops
  - syllabus
  - interview-preparation
syllabus-topic: []
---

# IT Infrastructure Management & DevOps - CDAC DITISS Syllabus

## Topics, Interview Priority & Important Commands/Tools

---

## Priority 1 - Must Know

### 1. Docker

- [x] Images vs containers - layered filesystem, union FS
- [x] Dockerfile - `FROM`, `RUN`, `COPY`, `CMD`, `ENTRYPOINT`, `EXPOSE`, `VOLUME`
- [x] Docker networking modes: bridge, host, none, overlay
- [x] Volumes vs bind mounts - persistent data
- [ ] Docker Compose - multi-container orchestration, `docker-compose.yml`
- [x] Image tagging and pushing to Docker Hub
- [x] `docker exec`
- [x] `docker logs`
- [x] `docker inspect`
- [ ] `docker cp`

### 2. Kubernetes / Container Orchestration

- [x] Why orchestration is needed: self-healing, scaling, rolling updates
- [x] Master node components: API Server, etcd, Scheduler, Controller Manager
- [x] Worker node components: kubelet, kube-proxy, container runtime
- [x] Pods, ReplicaSets, Deployments, Services
- [x] Docker Swarm vs Kubernetes - key differences
- [x] Replicas, rolling updates, self-healing concepts
- [x] Microservices deployment and scaling patterns

### 3. Git & GitHub

- [ ] `git init`
- [ ] `git clone`
- [ ] `git add`
- [ ] `git commit`
- [ ] `git push`
- [ ] `git pull`
- [ ] Git configuration - `user.name`, `user.email`
- [ ] Branching, merging, `git status`, `.gitignore`
- [ ] Git workflow: local repo -> staging -> remote (GitHub)
- [ ] GitHub Actions vs Jenkins - CI/CD comparison

### 4. Jenkins (CI/CD)

- [ ] Jenkins architecture - Master/Agent (Controller/Node)
- [ ] Freestyle jobs vs Pipeline jobs (declarative vs scripted)
- [ ] Jenkinsfile basics - stages, steps
- [ ] Integrating Jenkins with GitHub (webhooks/polling)
- [ ] Integrating Jenkins with Docker - build, test, deploy automation
- [ ] CI vs CD vs Continuous Deployment - differences

### 5. AWS Core Services

- [x] EC2 - instance types, AMI, key pairs, security groups
- [ ] S3 - buckets, storage classes, versioning
- [ ] Lambda - serverless, event-driven functions
- [x] VPC - CIDR blocks, public/private subnets, route tables, IGW, NAT Gateway
- [x] IAM - users, roles, policies

### 6. Ansible

- [x] Agentless architecture - SSH-based, no daemon on managed nodes
- [x] Control node vs managed nodes
- [x] Inventory file (static/dynamic) - `/etc/ansible/hosts`
- [x] Playbooks - YAML syntax, tasks, modules
- [x] Ansible Roles - reusable, structured automation (`roles/` directory layout)
- [x] `ansible -m ping all` - connectivity test
- [x] Idempotency - running a playbook multiple times produces the same end state

### 7. Terraform (IaC)

- [x] Infrastructure as Code - declarative vs imperative
- [x] Terraform workflow: `init` -> `plan` -> `apply` -> `destroy`
- [x] `.tf` files - providers, resources, variables, outputs
- [x] Terraform state (`terraform.tfstate`) - why it matters
- [x] Remote backend (for example S3) - state locking, team collaboration
- [x] Terraform modules - reusable infrastructure blocks

---

## Priority 2 - Important

### 8. Virtualization

- [x] Type 1 hypervisor (bare-metal: ESXi, Hyper-V) vs Type 2 (hosted: VirtualBox, VMware Workstation)
- [ ] Hardware virtualization vs para-virtualization
- [x] Cloning vs snapshot vs template
- [x] Why virtualization matters for DevOps/cloud: resource isolation, rapid provisioning

### 9. Cloud Computing

- [x] Service models: IaaS, PaaS, SaaS (with examples)
- [x] Deployment models: Public, Private, Hybrid
- [x] Cloud SPI model
- [x] SLA (Service Level Agreement) and IAM (Identity Access Management)
- [x] Cloud API integration basics

### 10. Prometheus & Monitoring

- [ ] Prometheus architecture - scraping model (pull-based)
- [ ] Node Exporter (Linux) vs Windows Exporter
- [ ] PromQL basics
- [ ] Metrics: CPU, memory, disk, network
- [ ] Role of monitoring in SRE - alerting, troubleshooting, capacity planning
- [ ] Grafana for visualization - commonly paired with Prometheus

### 11. Chef & Puppet (Configuration Management)

- [ ] Chef architecture: Workstation, Chef Server, Nodes (Chef-client)
- [ ] Chef terms: Cookbooks, Recipes, Resources
- [ ] Puppet architecture: Puppet Master, Puppet Agent, Catalog
- [x] Declarative configuration - desired state enforcement
- [x] Legacy Chef/Puppet vs modern Ansible/Terraform DevOps tooling trends

### 12. Storage Area Network (SAN)

- [ ] SAN vs NAS - block-level vs file-level storage
- [ ] FreeNAS / ZFS - pooling, snapshots, data integrity (checksums)
- [ ] iSCSI - IP-based block storage protocol
- [ ] Role of shared storage in HA and CI/CD pipelines

---

## Priority 3 - Good to Know

### 13. Data Center Management

- [x] Data center architecture - physical space, power, cooling (HVAC), bandwidth
- [ ] Modular cabling design, Points of Distribution
- [ ] Network Operations Center (NOC) and monitoring
- [ ] Physical, logical, and network security in a DC
- [ ] Raised floor design, structural planning, disaster recovery

### 14. Agile & DevOps Culture

- [ ] DevOps principles - Dev and Ops collaboration, culture shift
- [ ] CI/CD pipeline stages: Build -> Test -> Deploy -> Monitor
- [ ] Agile methodologies: Scrum vs Kanban
- [ ] Lean principles applied to DevOps
- [ ] Sprint, backlog, standups (Scrum artifacts)

### 15. Docker Swarm (Orchestration Alternative)

- [x] Swarm mode - manager and worker nodes
- [x] Services, tasks, replicas
- [x] `docker service scale` - scaling replicas up/down
- [x] Swarm vs Kubernetes - simplicity vs feature-richness

---

## Interview Special - Commands & Quick Reference

> These are almost always asked in DevOps and Cloud interviews.

### Docker - Key Commands

- [x] `docker build -t name:tag .` - build image from Dockerfile
- [x] `docker run -d -p 8000:80 --name web5 httpd` - run container, detached, port mapping
- [x] `docker ps` / `docker ps -a` - list running / all containers
- [x] `docker exec -it <container> bash` - interactive shell into container
- [ ] `docker cp file.html container:/path` - copy file into container
- [x] `docker images` - list local images
- [x] `docker push user/image:v1` - push image to Docker Hub
- [x] `docker save -o img.tar image:v1` - export image to tar file
- [x] `docker network ls` - list networks
- [x] `docker volume ls` - list volumes
- [ ] `docker-compose up -d` - start multi-container app

### Kubernetes - Key Commands

- [x] `kubectl get pods` - list pods
- [x] `kubectl get nodes` - list cluster nodes
- [x] `kubectl apply -f deploy.yaml` - apply a manifest
- [x] `kubectl scale deployment app --replicas=10` - scale replicas
- [x] `kubectl rollout status deployment app` - check rolling update status
- [x] `kubectl describe pod <name>` - debug pod details/events
- [x] `kubectl logs <pod>` - view pod logs
- [ ] `kubeadm init` - initialize master node
- [ ] `kubeadm join` - join worker node to cluster

### Git - Key Commands

- [ ] `git init` - initialize repo
- [ ] `git clone <url>` - copy remote repo locally
- [ ] `git config --global user.name/user.email` - set identity
- [ ] `git add .` - stage changes
- [ ] `git commit -m "msg"` - commit staged changes
- [ ] `git push origin main` - push to remote
- [ ] `git pull origin main` - fetch and merge from remote
- [ ] `git status` - check working tree state
- [ ] `git log --oneline` - compact commit history

### Ansible - Key Commands

- [x] `ansible -m ping all` - test connectivity to all hosts
- [x] `ansible-playbook site.yml` - run a playbook
- [x] `ansible-playbook site.yml --check` - dry run
- [x] `ansible-inventory --list` - view inventory
- [x] `ansible-galaxy init rolename` - scaffold a new role

### Terraform - Key Commands

- [x] `terraform init` - initialize working dir, download providers
- [x] `terraform plan` - preview changes
- [x] `terraform apply` - apply changes to infra
- [x] `terraform destroy` - tear down infra
- [x] `terraform validate` - syntax check
- [x] `terraform state list` - list resources in state
- [x] `terraform fmt` - format `.tf` files

### Jenkins - Pipeline Flow

- [ ] GitHub code push triggers Jenkins via webhook
- [ ] Jenkins pulls code
- [ ] Docker build
- [ ] Run tests
- [ ] Push image to Docker Hub
- [ ] Deploy container
- [ ] Freestyle job - GUI-configured, simple single tasks
- [ ] Pipeline job - code-defined (`Jenkinsfile`), stages/steps
- [ ] Declarative pipeline - structured, easier syntax (`pipeline { stages {} }`)
- [ ] Scripted pipeline - Groovy-based, more flexible
- [ ] Agent - where the pipeline/stage executes

### AWS - Core Services Quick Reference

- [x] EC2 - compute, virtual servers
- [x] S3 - storage, object storage, static hosting, logs
- [x] Lambda - serverless, event-driven functions, no server management
- [x] VPC - networking, isolated network, public/private subnets
- [x] IAM - security, users, roles, policies, permissions
- [ ] Sample VPC lab design
- [ ] VPC CIDR: `172.20.0.0/16`
- [ ] Public subnet: `172.20.5.0/24`
- [ ] Private subnet: `172.20.10.0/24`
- [ ] Public instance -> Internet Gateway
- [ ] Private instance -> NAT Gateway
- [ ] Test with `curl` from public instance to `httpd` running on private instance

### Virtualization - Quick Reference

- [x] Type 1 hypervisors: VMware ESXi, Hyper-V, KVM
- [x] Type 2 hypervisors: VirtualBox, VMware Workstation
- [x] Snapshot - point-in-time save of VM state
- [x] Clone - full independent copy of a VM
- [x] Template - reusable master image for new VM deployment

### Cloud Service Models - Quick Reference

- [x] IaaS - AWS EC2, Azure VM
- [x] PaaS - Heroku, AWS Elastic Beanstalk
- [x] SaaS - Gmail, Office 365
- [x] Provider manages hardware, virtualization, network for IaaS
- [x] User manages OS, runtime, apps, data for IaaS
- [x] Provider manages OS and runtime for PaaS
- [x] User manages apps and data for PaaS
- [x] Provider manages everything for SaaS
- [x] User mainly uses the service and handles data usage

### Chef vs Puppet vs Ansible - Comparison

- [ ] Chef language - Ruby DSL
- [ ] Puppet language - Puppet DSL
- [x] Ansible language - YAML
- [ ] Chef architecture - agent-based (Chef-client + Server)
- [x] Puppet architecture - agent-based (Master-Agent)
- [x] Ansible architecture - agentless (SSH)
- [ ] Chef learning curve - steep
- [ ] Puppet learning curve - moderate
- [x] Ansible learning curve - easy
- [x] Chef push/pull - pull
- [x] Puppet push/pull - pull
- [x] Ansible push/pull - push
- [ ] Chef config unit - Cookbook/Recipe
- [ ] Puppet config unit - Manifest
- [ ] Ansible config unit - Playbook

### Docker Swarm vs Kubernetes

- [ ] Docker Swarm setup complexity - simple
- [ ] Kubernetes setup complexity - complex
- [ ] Docker Swarm scaling - `docker service scale`
- [ ] Kubernetes scaling - `kubectl scale`
- [ ] Docker Swarm networking - simpler overlay
- [ ] Kubernetes networking - advanced (CNI plugins)
- [ ] Docker Swarm self-healing - yes, basic
- [ ] Kubernetes self-healing - yes, advanced
- [ ] Docker Swarm ecosystem - smaller
- [ ] Kubernetes ecosystem - large, CNCF standard
- [ ] Docker Swarm auto-scaling - manual
- [ ] Kubernetes auto-scaling - HPA (Horizontal Pod Autoscaler)

### SAN - Quick Reference

- [ ] SAN - block-level shared storage over dedicated network
- [ ] NAS - file-level storage over standard network
- [ ] ZFS - filesystem/volume manager with snapshots, pooling, checksums
- [ ] iSCSI - IP-based protocol to access SAN storage as if local disk

## Quick Syllabus Topic List

| Session | Topics                                                                   |
| ------- | ------------------------------------------------------------------------ |
| 5       | Data Center Architecture, Requirements, Security                         |
| 6       | Virtualization - Type 1/2, Cloning, Snapshot, Template                   |
| 7       | SAN - FreeNAS, ZFS, iSCSI, High Availability                             |
| 8       | Cloud Computing - IaaS/PaaS/SaaS, SLA, IAM                               |
| 9-10    | Chef & Puppet - Infra Provisioning                                       |
| 11      | Prometheus - Monitoring, Node/Windows Exporter                           |
| 12-15   | DevOps + Docker - CI/CD, Images, Compose, Networking, Agile/Scrum/Kanban |
| 16-17   | Git & GitHub - Core workflow, GitHub Actions vs Jenkins                  |
| 18-19   | Jenkins - CI/CD Pipelines, Docker + GitHub integration                   |
| 20-21   | AWS - EC2, Lambda, S3, VPC                                               |
| 22-23   | Container Orchestration - Kubernetes, Docker Swarm, Microservices        |
| 24-25   | Ansible - Playbooks, Inventory, Roles                                    |
| 26-27   | Terraform - IaC, State Management, Modules                               |

---

_CDAC DITISS - PGCP-ITISS | IT Infrastructure Management & DevOps | Feb 2026_
_Total: 40T + 40L + 27SL (DevOps section) + Data Center session_

---

## Obsidian Topic Coverage and Navigation

> This section adds navigation and coverage labels only. The original syllabus and checklist above remain unchanged.

| Topic | Syllabus topic                           | Coverage    | Related note or status                                    |
| ----: | ---------------------------------------- | ----------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------- | --------------------------------------------------------- | ---------------- |
|     1 | Docker                                   | Complete    | [[01 - Docker Containerization and Docker Swarm           | Docker, Containerization, and Docker Swarm]]                                             |
|     2 | Kubernetes / Container Orchestration     | Distributed | [[01 - Docker Containerization and Docker Swarm           | Docker Swarm]]; [[02 - Kubernetes Container Orchestration                                | Kubernetes]]; [[07 - Terraform and Infrastructure as Code | Kubernetes IaC]] |
|     3 | Git & GitHub                             | Unavailable | No dedicated note provided.                               |
|     4 | Jenkins (CI/CD)                          | Unavailable | No dedicated note provided.                               |
|     5 | AWS Core Services                        | Complete    | [[05 - AWS Cloud Computing Virtualization and Data Center | AWS Cloud Computing, Virtualization, and Data Center]]                                   |
|     6 | Ansible                                  | Distributed | [[06 - Ansible YAML and Configuration Management          | Ansible YAML and Configuration Management]]; [[07 - Terraform and Infrastructure as Code | Terraform and Infrastructure as Code]]                    |
|     7 | Terraform (IaC)                          | Complete    | [[07 - Terraform and Infrastructure as Code               | Terraform and Infrastructure as Code]]                                                   |
|     8 | Virtualization                           | Complete    | [[05 - AWS Cloud Computing Virtualization and Data Center | AWS Cloud Computing, Virtualization, and Data Center]]                                   |
|     9 | Cloud Computing                          | Complete    | [[05 - AWS Cloud Computing Virtualization and Data Center | AWS Cloud Computing, Virtualization, and Data Center]]                                   |
|    10 | Prometheus & Monitoring                  | Unavailable | No dedicated note provided.                               |
|    11 | Chef & Puppet (Configuration Management) | Distributed | [[06 - Ansible YAML and Configuration Management          | Ansible YAML and Configuration Management]]; [[07 - Terraform and Infrastructure as Code | Terraform and Infrastructure as Code]]                    |
|    12 | Storage Area Network (SAN)               | Unavailable | No dedicated note provided.                               |
|    13 | Data Center Management                   | Complete    | [[05 - AWS Cloud Computing Virtualization and Data Center | AWS Cloud Computing, Virtualization, and Data Center]]                                   |
|    14 | Agile & DevOps Culture                   | Unavailable | No dedicated note provided.                               |
|    15 | Docker Swarm (Orchestration Alternative) | Complete    | [[01 - Docker Containerization and Docker Swarm           | Docker Containerization and Docker Swarm]]                                               |

### Vault Navigation

- [[Index|Vault Index and Reading Order]]
- [[01 - Docker Containerization and Docker Swarm|Docker, Containerization, and Docker Swarm]]
- [[02 - Kubernetes Container Orchestration|Kubernetes Container Orchestration]]
- [[05 - AWS Cloud Computing Virtualization and Data Center|AWS Cloud Computing, Virtualization, and Data Center]]
- [[06 - Ansible YAML and Configuration Management|Ansible YAML and Configuration Management]]
- [[07 - Terraform and Infrastructure as Code|Terraform and Infrastructure as Code]]
- Supplemental: [[A1 - IT Infrastructure Management and DevOps Checklist|IT Infrastructure Management and DevOps Checklist]]
