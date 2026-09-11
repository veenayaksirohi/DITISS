---
title: A1 - IT Infrastructure Management and DevOps Checklist
aliases:
  - "IT Infrastructure Management & DevOps — CDAC DITISS Syllabus"
  - "04 - IT Infrastructure Management and DevOps Syllabus and Interview Checklist"
tags:
  - devops
  - itil
  - aws
  - docker
  - kubernetes
  - terraform
  - ansible
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

# IT Infrastructure Management & DevOps — Interview Checklist

**Duration:** 120 hrs (50T + 40L + 30SL) | **CMCE Module — directly ties to CDAC DevSecOps project work**
**Courseware:** Cloud Computing Black Book (Kailash Jayaswal)

---

## Completion Checklist

- [ ] ITIL lifecycle (Strategy, Design, Transition, Operation, CSI)
- [ ] Data Center Management
- [ ] Virtualization basics
- [ ] Storage Area Network (SAN/ZFS)
- [ ] Cloud Computing (IaaS/PaaS/SaaS)
- [ ] Chef & Puppet
- [ ] Prometheus monitoring
- [ ] Docker & Docker Compose
- [ ] Git & GitHub
- [ ] Jenkins CI/CD
- [ ] AWS (EC2, Lambda, S3, VPC)
- [ ] Container Orchestration (Kubernetes, Docker Swarm)
- [ ] Ansible
- [ ] Terraform

---

## 🔴 Priority 1 — Must Know

- [ ] ITIL lifecycle — Service Strategy, Design, Transition, Operation, CSI
- [ ] Virtualization — Type 1 vs Type 2 hypervisors, snapshots/cloning/templates
- [ ] Cloud computing — IaaS/PaaS/SaaS, deployment models, shared responsibility
- [ ] AWS core services — EC2, S3, Lambda, VPC (public/private subnets)
- [ ] Docker — images, containers, volumes, networking, Docker Compose, image tagging
- [ ] Git & GitHub — clone/commit/push workflow, branching
- [ ] Jenkins — CI/CD pipeline concepts, Jenkins + Docker + GitHub integration
- [ ] Terraform — IaC concepts, plan/apply/destroy, state management, modules

## 🟠 Priority 2 — Important

- [ ] Ansible — playbooks, YAML, inventory, roles, idempotency, agentless automation
- [ ] Kubernetes vs Docker Swarm — replicas, rolling updates, self-healing
- [ ] Prometheus monitoring — Node Exporter, metrics, alerting
- [ ] Chef & Puppet — configuration management basics, architecture
- [ ] Data Center design — physical/logical/network security, HVAC, cabling, NOC
- [ ] SAN/ZFS storage, iSCSI

## 🟡 Priority 3 — Good to Know

- [ ] Agile/Lean — Scrum vs Kanban
- [ ] DevOps culture and CI/CD pipeline stage design end-to-end

---

## 📌 Direct Mapping to CDAC DevSecOps Project

| Syllabus Topic   | Project Application                                                           |
| ---------------- | ----------------------------------------------------------------------------- |
| EC2, VPC, S3     | AWS-hosted EKS cluster infra                                                  |
| Docker/Compose   | Three-tier app containerization (PostgreSQL, Flask, React/Vite)               |
| Jenkins + GitHub | GitHub Actions CI/CD pipeline                                                 |
| Terraform        | `infra/terraform/eks`, `infra/terraform/monitoring-security`                  |
| Ansible          | `infra/ansible` playbooks                                                     |
| Kubernetes       | EKS cluster manifests in `k8s/`                                               |
| Prometheus       | Considered, later dropped from final stack in favor of SonarQube + DefectDojo |

## 📌 ITIL Lifecycle Quick Reference

| Stage              | Focus                                                        |
| ------------------ | ------------------------------------------------------------ |
| Service Strategy   | Market space, financial mgmt, service portfolio              |
| Service Design     | SDP, service catalog, capacity, continuity, security         |
| Service Transition | Change mgmt, release/deployment, config mgmt, knowledge mgmt |
| Service Operation  | Incident, problem, event mgmt, service desk                  |
| CSI                | Training, ongoing scheduling, metrics-driven improvement     |

---

## Related Notes

- [[00 - Syllabus and Interview Checklist|Syllabus and Interview Checklist]]
- [[Index|Vault Index and Reading Order]]
