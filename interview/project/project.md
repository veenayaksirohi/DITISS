# Interview-Ready Project Introduction

## 1. Project Overview

My project is called **AnzenOps**. It is an end-to-end **DevSecOps project** built around a **three-tier web application**.

The application uses:

- **React** for the frontend
- **Flask** for the backend REST APIs
- **PostgreSQL** for the database

The main objective of this project was to **integrate security into every stage of the software delivery lifecycle**, instead of performing security checks only after deployment.

The project combines:

- CI/CD automation
- Containerization
- Kubernetes orchestration
- Cloud infrastructure
- Security scanning
- Vulnerability management
- Monitoring and observability
- Infrastructure automation

---

# 2. Project Architecture

```text
Developer
   |
   | git push
   v
GitHub Repository
   |
   v
GitHub Actions CI/CD Pipeline
   |
   +--> TruffleHog
   |      Secret Scanning
   |
   +--> SonarQube
   |      SAST
   |
   +--> Trivy
   |      SCA + SBOM
   |
   v
Docker Compose
   |
   +--> Frontend Image
   +--> Backend Image
   +--> PostgreSQL Image
   |
   v
Application Validation
   |
   v
Docker Hub
   |
   +--> Trivy Image Scanning
   +--> Trivy IaC Scanning
   |
   v
AWS EKS - Preproduction
   |
   +--> Frontend Pods
   +--> Backend Pods
   +--> PostgreSQL Pod
   +--> Kubernetes Services
   +--> HPA
   +--> Health Probes
   |
   v
AWS LoadBalancer
   |
   v
OWASP ZAP
   |
   v
DefectDojo
   |
   +--> SonarQube Reports
   +--> Trivy Reports
   +--> ZAP Reports
   |
   v
Monitoring
   |
   +--> Prometheus
   +--> Grafana
   +--> Wazuh
```

---

# 3. CI/CD Pipeline Flow

Whenever a developer pushes code to GitHub, **GitHub Actions** automatically starts the CI/CD pipeline.

## Step 1: Secret Scanning

First, **TruffleHog** scans the repository and complete Git history to detect accidentally committed secrets.

Examples include:

- API keys
- Passwords
- Access tokens
- Private keys
- Cloud credentials

```text
Developer Push
      |
      v
GitHub Repository
      |
      v
TruffleHog
      |
      v
Secret Detection
```

---

## Step 2: Static Application Security Testing

After secret scanning, **SonarQube** performs **Static Application Security Testing (SAST)**.

SonarQube analyzes the source code without running the application.

It checks for:

- Security vulnerabilities
- Bugs
- Code smells
- Security hotspots
- Duplicate code
- Maintainability problems
- Insecure coding patterns

---

## Step 3: Software Composition Analysis

**Trivy** scans the application's dependencies.

This process is called **Software Composition Analysis (SCA)**.

It checks third-party packages and libraries for known vulnerabilities.

Trivy also generates a **CycloneDX Software Bill of Materials (SBOM)**.

An SBOM provides a list of software components used by the application.

```text
Application
     |
     v
Dependency Files
     |
     v
Trivy
     |
     +--> Vulnerability Detection
     |
     +--> CycloneDX SBOM
```

---

## Step 4: Docker Image Build

**Docker Compose** builds the container images for the three application tiers:

- Frontend
- Backend
- PostgreSQL database

```text
Source Code
     |
     v
Docker Compose
     |
     +--> Frontend Image
     +--> Backend Image
     +--> PostgreSQL Image
```

---

## Step 5: Application Validation

The pipeline starts the Docker containers and verifies that the application is responding correctly.

This helps ensure that the application works before it is deployed to Kubernetes.

```text
Build Images
     |
     v
Start Containers
     |
     v
Application Health Check
     |
     +--> Success -> Continue
     |
     +--> Failure -> Stop Pipeline
```

---

## Step 6: Push Images to Docker Hub

After successful validation, the container images are pushed to **Docker Hub**.

The images include:

- Frontend image
- Backend image
- PostgreSQL image

---

## Step 7: Container Image Scanning

**Trivy** scans the container images for known vulnerabilities.

It checks:

- Operating-system packages
- Application libraries
- Package versions
- Known CVEs
- Vulnerability severity

---

## Step 8: Infrastructure-as-Code Scanning

Trivy also scans infrastructure configuration files.

It checks:

- Terraform files
- Kubernetes YAML manifests
- Dockerfiles
- Docker Compose files

This helps identify insecure infrastructure configurations before deployment.

---

## Step 9: Preproduction Deployment

After the security scans, the application is deployed to the **preproduction namespace on AWS EKS**.

Kubernetes manages:

- Frontend replicas
- Backend replicas
- Database pod
- Deployments
- ReplicaSets
- Services
- Health probes
- Resource requests and limits
- Horizontal Pod Autoscalers
- Persistent storage

The frontend application is exposed using an **AWS LoadBalancer**.

```text
Docker Images
      |
      v
AWS EKS
      |
      v
Preproduction Namespace
      |
      +--> Frontend Pods
      |
      +--> Backend Pods
      |
      +--> PostgreSQL Pod
      |
      v
AWS LoadBalancer
      |
      v
Users / Security Testing
```

---

## Step 10: Dynamic Application Security Testing

Once the application is running in preproduction, **OWASP ZAP** performs **Dynamic Application Security Testing (DAST)**.

Unlike SAST, DAST tests the **running application**.

```text
Running Application
       |
       v
OWASP ZAP
       |
       v
HTTP Requests
       |
       v
Analyze Responses
       |
       v
Security Findings
```

---

## Step 11: Vulnerability Management

Reports generated by:

- SonarQube
- Trivy
- OWASP ZAP

are uploaded to **DefectDojo**.

DefectDojo provides:

- Centralized vulnerability management
- Finding tracking
- Severity management
- Deduplication
- Security-report organization

Deduplication prevents the same vulnerability from being repeatedly stored as a completely new finding.

---

## Step 12: Monitoring and Observability

**Prometheus** and **Grafana** are deployed on AWS EKS using **Helm**.

### Prometheus

Prometheus collects metrics from:

- Kubernetes nodes
- Pods
- Containers
- Deployments
- Kubernetes components

### Grafana

Grafana reads the metrics stored by Prometheus and displays them through dashboards.

```text
Kubernetes
    |
    v
Metrics
    |
    v
Prometheus
    |
    v
Grafana
    |
    v
Dashboards
```

**Wazuh** is also configured as an optional security-monitoring component.

---

# 4. Infrastructure Automation

## Terraform

**Terraform** is used to provision the AWS infrastructure.

It creates and manages resources such as:

- AWS VPC
- Subnets
- EKS cluster
- Worker nodes
- Security groups
- IAM-related infrastructure
- EC2 instances for security tools

```text
Terraform Code
      |
      v
AWS API
      |
      +--> VPC
      +--> EKS
      +--> Worker Nodes
      +--> EC2
      +--> Security Groups
```

---

## Ansible

**Ansible** is used for configuration management.

After Terraform creates the EC2 instances, Ansible installs and configures tools such as:

- SonarQube
- DefectDojo
- Wazuh

```text
Terraform
   |
   v
Create EC2 Instances
   |
   v
Ansible
   |
   +--> Install SonarQube
   +--> Install DefectDojo
   +--> Install Wazuh
```

---

# 5. My Contribution

My main contribution to the project included:

- GitHub Actions CI/CD pipeline
- DefectDojo integration
- DefectDojo vulnerability deduplication
- Prometheus automation
- Grafana automation
- Grafana Secret handling
- Kubernetes deployment scripts
- Frontend exposure using LoadBalancer
- Horizontal Pod Autoscaler configuration
- Environment deployment and cleanup automation

---

# 6. Final Result

The final result was a working **end-to-end DevSecOps pipeline** that successfully performed:

```text
Code Push
   |
   v
Secret Scanning
   |
   v
SAST
   |
   v
SCA + SBOM
   |
   v
Docker Build
   |
   v
Application Validation
   |
   v
Container Image Scanning
   |
   v
IaC Scanning
   |
   v
AWS EKS Preproduction Deployment
   |
   v
DAST
   |
   v
Vulnerability Reporting
   |
   v
Monitoring
   |
   v
Environment Cleanup
```

---

# 7. GitHub Actions

## What Is GitHub Actions?

**GitHub Actions** is a CI/CD automation service provided by GitHub.

It automatically performs tasks when an event occurs in a GitHub repository.

Examples of events include:

- Code push
- Pull request
- Merge
- Manual workflow execution
- Scheduled execution

A GitHub Actions pipeline is normally defined using a **YAML file** inside:

```text
.github/workflows/
```

Example:

```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Run tests
        run: echo "Running tests"
```

---

# 8. GitHub Actions vs Jenkins

| GitHub Actions                           | Jenkins                                          |
| ---------------------------------------- | ------------------------------------------------ |
| Built directly into GitHub               | Separate CI/CD server                            |
| Uses YAML workflow files                 | Commonly uses a Jenkinsfile                      |
| GitHub-hosted runners are available      | Usually requires controller/agent infrastructure |
| Easy integration with repository events  | Webhooks usually need configuration              |
| Built-in encrypted GitHub Secrets        | Credentials are configured inside Jenkins        |
| Large GitHub Actions Marketplace         | Large Jenkins plugin ecosystem                   |
| Requires less infrastructure maintenance | Jenkins and plugins require maintenance          |
| Good for GitHub-based projects           | Good for highly customized CI/CD environments    |

### Interview-Ready Answer

> **GitHub Actions is integrated directly with GitHub and is easier to configure and maintain for GitHub-based projects. Jenkins is a separate CI/CD server and provides more customization, but it requires additional infrastructure, plugins, configuration, and maintenance.**

---

# 9. SonarQube

## What Is SonarQube?

**SonarQube** is a static code-analysis platform.

It examines source code **without running the application**.

This type of testing is called:

**SAST — Static Application Security Testing**

SonarQube can identify:

- Security vulnerabilities
- Bugs
- Code smells
- Duplicate code
- Maintainability issues
- Security hotspots
- Some insecure coding patterns

---

# 10. How SonarQube Finds Insecure Code

## Step 1: Read the Source Code

The SonarQube scanner analyzes the application's source files and sends analysis information to the SonarQube server.

```text
Source Code
     |
     v
Sonar Scanner
     |
     v
Static Analysis
     |
     v
SonarQube Server
```

---

## Step 2: Understand the Code Structure

SonarQube parses the code and understands its programming structure.

Internally, static-analysis tools can represent code using structures such as an **Abstract Syntax Tree (AST)**.

Example:

```python
if username == "admin":
    allow_access()
```

The analyzer understands that the code contains:

- A conditional statement
- A variable
- A comparison
- A function call

It does not simply treat the source code as plain text.

---

## Step 3: Check Security and Quality Rules

SonarQube compares the code against predefined security and quality rules.

For example, it may identify:

```python
password = "admin123"
```

as an insecure coding practice.

The flow is:

```text
Source Code
     |
     v
Code Parsing
     |
     v
Security Rules
     |
     v
Issue Detection
     |
     v
SonarQube Dashboard
```

---

# 11. OWASP ZAP

## What Is OWASP ZAP?

**OWASP ZAP** stands for:

**OWASP Zed Attack Proxy**

It is a web application security-testing tool used for:

**DAST — Dynamic Application Security Testing**

Unlike SonarQube, ZAP does not primarily analyze application source code.

Instead, it tests the **running application** by sending HTTP/HTTPS requests and analyzing the responses.

---

# 12. How OWASP ZAP Finds Vulnerabilities

## Step 1: Provide the Application URL

ZAP receives the URL of the running application.

Example:

```text
http://application.example.com
```

---

## Step 2: Explore the Application

ZAP can use crawling or spidering techniques to discover:

- Web pages
- Links
- Forms
- API endpoints
- Application resources

---

## Step 3: Analyze Requests and Responses

ZAP analyzes HTTP requests and responses.

It can inspect:

- HTTP headers
- Cookies
- Response content
- Request parameters
- Authentication behavior
- Security-related headers

---

## Step 4: Detect Security Weaknesses

ZAP may identify issues such as:

- Missing security headers
- Insecure cookies
- Information disclosure
- Improper HTTP configuration
- Some injection-related weaknesses
- Cross-site scripting-related issues

---

## Step 5: Active Scanning

During an **active scan**, ZAP can modify application inputs and send security-testing payloads.

```text
Application URL
      |
      v
ZAP Spider / Crawler
      |
      v
Discover Endpoints
      |
      v
Send Test Requests
      |
      v
Analyze Responses
      |
      v
Security Findings
```

### Interview-Ready Answer

> **OWASP ZAP is a DAST tool. It tests a running web application by sending HTTP requests, analyzing the responses, discovering endpoints, and checking for web security vulnerabilities.**

---

# 13. TruffleHog

## What Is TruffleHog?

**TruffleHog** is a secret-scanning tool.

It searches repositories and Git history for accidentally committed credentials.

It can detect things such as:

- API keys
- Access tokens
- Private keys
- Cloud credentials
- Authentication tokens
- Other sensitive secrets

```text
Git Repository
      |
      v
TruffleHog
      |
      v
Scan Files + Git History
      |
      v
Possible Secrets
```

### Interview-Ready Answer

> **TruffleHog is used for secret scanning. In my project, it scans the repository and Git history to detect accidentally committed credentials such as API keys, tokens, and private keys.**

---

# 14. Trivy

## What Is Trivy?

**Trivy** is an open-source security scanner.

In AnzenOps, Trivy is used for:

- Software Composition Analysis
- SBOM generation
- Container-image scanning
- Infrastructure-as-Code scanning
- Configuration scanning

---

# 15. Trivy Software Composition Analysis

**Software Composition Analysis (SCA)** checks third-party dependencies for known vulnerabilities.

Trivy reads dependency files such as:

```text
requirements.txt
package-lock.json
```

It determines:

- Package name
- Installed version
- Known vulnerabilities
- CVE
- Severity
- Fixed version, when available

Example:

```text
Package: example-library
Installed Version: 1.2.0
Vulnerability: CVE-XXXX-XXXXX
Severity: HIGH
Fixed Version: 1.2.1
```

The process is:

```text
Dependency File
      |
      v
Identify Packages
      |
      v
Identify Versions
      |
      v
Compare with Vulnerability Database
      |
      v
Find CVEs
      |
      v
Generate Report
```

---

# 16. SBOM

## What Is an SBOM?

**SBOM** stands for:

**Software Bill of Materials**

It is an inventory of the components and dependencies used inside an application.

Example:

```text
Application
 |
 +--> React
 |
 +--> Flask
 |
 +--> Python Libraries
 |
 +--> JavaScript Packages
 |
 +--> Operating-System Packages
```

In AnzenOps, Trivy generates the SBOM using the **CycloneDX format**.

### Why Is an SBOM Useful?

It helps us understand:

- What software components we are using
- Which versions are installed
- Whether a vulnerable library exists
- Which applications may be affected by a newly discovered CVE

---

# 17. Container-Image Scanning

Container-image scanning checks Docker images for known vulnerabilities before deployment.

In AnzenOps, Trivy scans three images:

- Frontend image
- Backend image
- PostgreSQL database image

The scanning process is:

```text
Docker Image
      |
      v
Read Image Layers
      |
      v
Identify Installed Packages
      |
      v
Detect Package Versions
      |
      v
Compare with Vulnerability Database
      |
      v
Identify CVEs
      |
      v
Generate Security Report
      |
      v
Upload Report to DefectDojo
```

---

# 18. Infrastructure-as-Code Scanning

## What Is IaC Scanning?

**Infrastructure-as-Code scanning** checks infrastructure configuration files for security mistakes before infrastructure is deployed.

In AnzenOps, **Trivy** performs IaC scanning.

It scans:

- Terraform files
- Kubernetes YAML manifests
- Dockerfiles
- Docker Compose files

---

# 19. How Trivy Performs IaC Scanning

## Step 1: Read Configuration Files

Trivy scans locations such as:

```text
infra/terraform/
k8s/preprod/
k8s/prod/
Dockerfile
docker-compose.yml
```

Trivy does **not create or modify the infrastructure**.

It only analyzes the configuration.

---

## Step 2: Understand Infrastructure Resources

Trivy identifies resources such as:

- AWS security groups
- EKS clusters
- EC2 instances
- Kubernetes Deployments
- Kubernetes Services
- Containers
- Storage volumes

---

## Step 3: Apply Security Rules

Trivy compares the infrastructure configuration with built-in security rules.

For example:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

This means traffic may be allowed from any IPv4 address.

Depending on the resource and exposed port, Trivy may report this as **unrestricted or overly broad network access**.

Another example:

```yaml
securityContext:
  privileged: true
```

A privileged container receives elevated access to the host system.

Trivy may report this as a security risk.

---

## Step 4: Detect Misconfigurations

IaC scanning can identify issues such as:

- Security groups open to `0.0.0.0/0`
- Unnecessarily publicly exposed resources
- Privileged containers
- Containers running as root
- Missing security contexts
- Insecure container configurations
- Insecure cloud settings

### Interview-Ready Answer

> **IaC scanning checks infrastructure configuration files before deployment. In my project, Trivy scans Terraform, Kubernetes YAML, Dockerfiles, and Docker Compose files to identify security misconfigurations such as unrestricted security groups, privileged containers, and insecure container settings.**

---

# 20. AWS EKS

## What Is AWS EKS?

**AWS EKS** stands for:

**Amazon Elastic Kubernetes Service**

It is a **managed Kubernetes service provided by AWS**.

It allows us to deploy, manage, and scale containerized applications using Kubernetes without manually building and maintaining the Kubernetes control plane.

```text
AWS EKS = Kubernetes managed by AWS
```

---

# 21. What AWS Manages in EKS

AWS manages the Kubernetes control plane, including:

- Kubernetes API servers
- etcd
- Control-plane availability
- Control-plane infrastructure
- Control-plane maintenance
- Control-plane patching

AWS runs the control plane across multiple Availability Zones for high availability.

---

# 22. What We Manage

We are responsible for application-level Kubernetes resources and workload configuration, including:

- Deployments
- ReplicaSets
- Pods
- Containers
- Services
- ConfigMaps
- Secrets
- Persistent storage
- Resource requests and limits
- Health probes
- Horizontal Pod Autoscalers
- Kubernetes manifests

Depending on the EKS compute model being used, we may also configure or manage the worker-node capacity.

---

# 23. Why Use EKS Instead of Creating Our Own Kubernetes Cluster?

Creating Kubernetes manually requires us to manage:

- Control-plane nodes
- API server
- etcd
- High availability
- Control-plane patching
- Kubernetes upgrades
- Control-plane recovery
- Security maintenance

With EKS, AWS manages the Kubernetes control plane.

This allows us to focus more on:

- Application deployment
- Security
- Scaling
- Monitoring
- CI/CD automation

### Interview-Ready Answer

> **We used Amazon EKS because it provides a managed Kubernetes control plane. AWS manages components such as the API server, etcd, high availability, and control-plane maintenance. This reduces operational overhead and allows us to focus on deploying, securing, monitoring, and scaling our applications.**

---

# 24. Complete AnzenOps Security Flow

```text
Developer
    |
    v
GitHub Push
    |
    v
GitHub Actions
    |
    +-------------------------------+
    |                               |
    v                               |
TruffleHog                          |
Secret Scanning                     |
    |                               |
    v                               |
SonarQube                           |
SAST                                |
    |                               |
    v                               |
Trivy                               |
SCA + SBOM                          |
    |                               |
    v                               |
Docker Build                        |
    |                               |
    v                               |
Application Validation              |
    |                               |
    v                               |
Docker Hub                          |
    |                               |
    v                               |
Trivy                               |
Image + IaC Scanning                |
    |                               |
    v                               |
AWS EKS Preproduction               |
    |                               |
    v                               |
OWASP ZAP                           |
DAST                                |
    |                               |
    v                               |
DefectDojo                          |
Vulnerability Management            |
    |                               |
    +-------------------------------+
    |
    v
Prometheus + Grafana
Monitoring
```

---

# 25. Short Interview Project Introduction

> **My project is called AnzenOps. It is an end-to-end DevSecOps implementation built around a three-tier application using React, Flask, and PostgreSQL.**
>
> **GitHub Actions is used for CI/CD automation. We integrated TruffleHog for secret scanning, SonarQube for SAST, Trivy for SCA, SBOM generation, container-image scanning and IaC scanning, and OWASP ZAP for DAST.**
>
> **The application is containerized using Docker and deployed on AWS EKS. Terraform provisions the AWS infrastructure, while Ansible configures tools such as SonarQube, DefectDojo, and Wazuh.**
>
> **DefectDojo centralizes security findings and performs vulnerability deduplication. Prometheus and Grafana are used for monitoring and visualization.**
>
> **My main contribution was to the GitHub Actions pipeline, DefectDojo integration and deduplication, Prometheus and Grafana automation, Grafana Secret handling, Kubernetes deployment scripts, frontend exposure, and HPA-based autoscaling.**
>
> **The main goal of the project was to shift security left and integrate security checks throughout the software delivery lifecycle instead of checking security only after deployment.**
