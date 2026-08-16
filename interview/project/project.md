# Interview-Ready Project Introduction

## Overview

My project is called AnzenOps. It is an end-to-end DevSecOps project built around a three-tier web application.

The application uses React for the frontend, Flask for the backend REST APIs, and PostgreSQL for the database.

The main objective of this project was to integrate security into every stage of software delivery instead of performing security checks only after deployment.

## Pipeline Flow

Whenever a developer pushes code to GitHub, GitHub Actions starts the CI/CD pipeline. First, TruffleHog scans the complete Git history to detect leaked secrets.

After secret scanning, SonarQube performs static application security testing (SAST) to identify code-quality and security issues, while Trivy scans project dependencies and generates a CycloneDX software bill of materials (SBOM) for software composition analysis (SCA).

Next, Docker Compose builds the frontend, backend, and database images. The pipeline starts the containers and checks whether the application is responding. After successful validation, all three images are pushed to Docker Hub.

Trivy then scans the container images for vulnerabilities. It also scans the Terraform and Kubernetes configuration files for infrastructure misconfigurations.

After image scanning, the application is deployed to a preproduction namespace on AWS EKS. Kubernetes manages frontend and backend replicas, Services, health probes, resource limits, and Horizontal Pod Autoscalers. The frontend is exposed using an AWS LoadBalancer.

Once the application is running, OWASP ZAP performs dynamic security testing against the live preproduction application. Reports from SonarQube, Trivy, and OWASP ZAP are uploaded to DefectDojo for centralized vulnerability tracking and deduplication.

Prometheus and Grafana are deployed on EKS using Helm. Prometheus collects Kubernetes and infrastructure metrics, while Grafana displays the collected information through dashboards. Wazuh is also configured as an optional security-monitoring component.

Terraform provisions the AWS VPC, EKS cluster, worker nodes, and EC2 instances for the security tools. Ansible installs and configures SonarQube, DefectDojo, and Wazuh on those instances.

My main contribution was to the GitHub Actions pipeline, DefectDojo integration and deduplication, Prometheus and Grafana automation, Grafana Secret handling, Kubernetes deployment scripts, frontend exposure, and HPA-based autoscaling.

The final result was a working DevSecOps pipeline that successfully performed security scanning, image building, preproduction deployment, dynamic testing, vulnerability reporting, monitoring, and environment cleanup.

## GitHub Actions

GitHub Actions is a CI/CD automation service provided by GitHub. It automatically performs tasks when an event happens in a GitHub repository, such as a code push or pull request.

| GitHub Actions | Jenkins |
| --- | --- |
| Built directly into GitHub | Separate CI/CD server |
| Easy YAML configuration | Uses Jenkinsfile and plugins |
| GitHub-hosted runners are available | Usually requires server/agent setup |
| Easy access to repository events | Webhooks normally need configuration |
| Built-in encrypted Secrets | Credentials need Jenkins configuration |
| Large Actions marketplace | Large plugin ecosystem |
| Less infrastructure maintenance | Jenkins controller and plugins require maintenance |
| Suitable for GitHub-based projects | Suitable for complex and highly customized pipelines |

## SonarQube

SonarQube is a static code-analysis platform. It examines source code without running the application.

It can identify:

- Security vulnerabilities
- Bugs
- Code smells
- Duplicate code
- Maintainability issues
- Security hotspots
- Some insecure coding patterns

This type of testing is called SAST, or Static Application Security Testing.

### How SonarQube Finds Insecure Code

SonarQube uses predefined security and quality rules for different programming languages.

1. It reads the source code.

The SonarQube scanner collects the application's source files and sends the analysis results to the SonarQube server.

2. It understands the code structure.

It converts the code into an internal tree structure called an Abstract Syntax Tree, or AST.

For example:

```text
if username == "admin":
    allow_access()
```

SonarQube understands that this contains:

- A condition
- A username comparison
- A function call

It does not treat the code as ordinary text.

3. It checks security rules.

SonarQube compares the code against security rules.

## OWASP ZAP

OWASP ZAP stands for OWASP Zed Attack Proxy.

It is a web application security-testing tool used for DAST, or Dynamic Application Security Testing.

Unlike SonarQube, ZAP does not directly read the source code. It tests the running application by sending HTTP requests and analyzing HTTP responses.

### How OWASP ZAP Finds Vulnerabilities

1. ZAP receives the application URL.
2. ZAP explores the application.

ZAP uses a crawler or spider to discover:

- Web pages
- API endpoints

It monitors requests and responses.

It examines:

- HTTP headers
- Cookies

4. It checks for security weaknesses.

ZAP may identify problems such as:

- Missing security headers
- Insecure cookies

5. Active scanning can send attack payloads.

During a full active scan, ZAP can modify input parameters and send test payloads.

## TruffleHog

TruffleHog is a secret-scanning tool. It searches the repository and Git history for accidentally committed credentials.

It can find:

- API keys
- Access tokens
- Private keys

## Trivy

Trivy is a vulnerability and misconfiguration scanner.

In AnzenOps, Trivy is used for:

- Software Composition Analysis
- SBOM generation
- Container-image scanning
- Infrastructure-as-Code scanning
- Secret and configuration scanning

### How Trivy Finds Vulnerabilities

Dependency scanning

Trivy reads dependency files such as:

- `requirements.txt`
- `package-lock.json`

It identifies the libraries and their versions.

For example:

```text
Package: example-library
Installed version: 1.2.0
Known vulnerable version: 1.2.0
CVE: CVE-XXXX-XXXXX
```

Trivy compares the dependency versions with its vulnerability database.

### Container-Image Scanning

Container-image scanning checks a Docker image for known vulnerabilities before it is deployed.

In AnzenOps, Trivy scans three images:

- Frontend image
- Backend image
- PostgreSQL database image

Container-image scanning process:

```text
Docker image
-> Read image layers
-> Identify installed packages
-> Detect package versions
-> Compare with vulnerability database
-> Generate security report
-> Upload report to DefectDojo
```

### Infrastructure-as-Code Scanning

Infrastructure-as-Code, or IaC, scanning checks infrastructure configuration files for security mistakes before deployment.

In AnzenOps, Trivy performs the IaC scan.

It can scan:

- Terraform files
- Kubernetes YAML manifests
- Dockerfiles
- Docker Compose files

How IaC scanning works:

```text
Infrastructure files
-> Trivy reads and parses them
-> Compares settings with security rules
-> Detects misconfigurations
-> Assigns severity
-> Generates a report
-> Uploads the report to DefectDojo
```

1. Trivy reads the configuration files.

For example:

- `infra/terraform/`
- `k8s/preprod/`
- `k8s/prod/`
- `Dockerfile`
- `docker-compose.yml`

Trivy does not create or modify the infrastructure. It only analyzes the configuration.

2. It understands the resources.

Trivy identifies resources such as:

- AWS security groups
- EKS clusters
- EC2 instances
- Kubernetes Deployments
- Kubernetes Services
- Containers
- Storage volumes

3. It checks security rules.

Trivy compares each resource with built-in security rules.

For example, this allows traffic from the entire internet:

```text
cidr_blocks = ["0.0.0.0/0"]
```

Trivy may report it as broad or unrestricted network access.

A privileged container can also be reported:

```yaml
securityContext:
  privileged: true
```

4. It identifies misconfigurations.

IaC scanning can find:

- Security groups open to `0.0.0.0/0`
- Publicly exposed resources
- Privileged containers
- Containers running as root
- Missing security contexts

## AWS EKS

AWS EKS stands for Amazon Elastic Kubernetes Service.

It is a managed Kubernetes service provided by AWS. It helps us deploy, manage, and scale containerized applications using Kubernetes.

EKS = Kubernetes managed by AWS

### What AWS Manages

AWS manages the Kubernetes control plane, including:

- Kubernetes API server
- etcd database
- Control-plane availability
- Control-plane maintenance
- Security patches and updates

We manage:

- Worker nodes
- Kubernetes Deployments
- Pods and containers
- Services
