# AWS IAM — Short Notes

**IAM (Identity and Access Management)** is an AWS service used to **control who can access AWS resources and what actions they can perform**.

### 1. Main Components

| Component  | Meaning                                                                              |
| ---------- | ------------------------------------------------------------------------------------ |
| **User**   | Represents an individual person/application                                          |
| **Group**  | Collection of IAM users                                                              |
| **Role**   | An identity that provides temporary permissions and can be assumed by users/services |
| **Policy** | JSON document that defines permissions                                               |

---

### 2. IAM Policy

A policy defines **Allow** or **Deny** permissions.

Example:

```json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "*"
}
```

- **Effect** → Allow/Deny
- **Action** → What operation is allowed
- **Resource** → Which AWS resource
- **Condition** → Optional rules for when permission applies

**Easy meaning:**

> **Policy = What you are allowed to do**

---

### 3. IAM Role

An **IAM Role** is an identity that can be **assumed** by users, AWS services, or workloads. It usually provides **temporary credentials**.

Roles are commonly used when one AWS service needs to access another AWS service.

Examples:

```text
EC2 → IAM Role → S3
Lambda → IAM Role → DynamoDB
EKS Pod → IAM Role → AWS Services
```

For example:

> EC2 needs to read files from S3 → attach an IAM Role to EC2 → the Role has a Policy allowing `s3:GetObject`.

**Easy meaning:**

> **Role = Identity that can be temporarily assumed**

---

### 4. Trust Policy

A Role has a **Trust Policy** that defines:

> **Who is allowed to assume this Role?**

Example:

```text
EC2-S3-Role

Trust Policy:
    EC2 can assume this Role

Permission Policy:
    Allow reading from S3
```

So remember:

```text
Trust Policy    → Who can use/assume the Role?
Permission Policy → What can the Role do?
```

---

### 5. Role vs Policy

Think of it like a job:

```text
Role   → Job position
Policy → Permissions of that position
```

Example:

```text
EC2-S3-Role
     ↓
S3 Read Policy
     ↓
s3:GetObject
```

Therefore:

> **Role = Who/which service?**
> **Policy = What can it do?**
> **Trust Policy = Who can assume the Role?**

---

### 6. Authentication vs Authorization

- **Authentication** → _Who are you?_
- **Authorization** → _What are you allowed to do?_

Example:

**Logging into AWS** = Authentication
**Permission to create an EC2 instance** = Authorization

---

### 7. Root User

The AWS account **Root User** has complete access to the account.

Best practices:

- Don't use root for daily work
- Enable **MFA**
- Use IAM users/roles for normal operations

---

### 8. Principle of Least Privilege

Give users/services **only the permissions they actually need**.

Example:

❌ `s3:*` on all buckets

✅ Only `s3:GetObject` on the required bucket

---

### 9. IAM Best Practices

- Enable **MFA**
- Use **IAM Roles** instead of long-term access keys where possible
- Follow **least privilege**
- Avoid using the root account
- Rotate/remove unnecessary credentials
- Review policies regularly
- Use groups for common user permissions

---

### 10. Important Interview Question

**Q: What is the difference between IAM User and IAM Role?**

**User:** A permanent identity generally associated with a person and can have long-term credentials.

**Role:** An identity that can be assumed and provides **temporary credentials**. It is commonly used by AWS services.

**Q: What is the difference between Role and Policy?**

> **Role provides an identity**, while **Policy defines what permissions that identity has.**

### Easy way to remember:

> **User = Who you are**
> **Role = What identity you can temporarily assume**
> **Policy = What you are allowed to do**
> **Trust Policy = Who can assume the Role**

# AWS EC2 — Short Notes

**EC2 (Elastic Compute Cloud)** is an AWS service that provides **virtual servers in the cloud**.

You can use an EC2 instance to run applications, websites, Docker containers, backend services, etc.

### 1. EC2 Instance

An **EC2 instance** is a virtual machine/server running in AWS.

Example:

```text
Your Application
       ↓
   EC2 Instance
       ↓
      AWS
```

You can choose CPU, RAM, storage, operating system, and network settings.

---

### 2. AMI

**AMI (Amazon Machine Image)** is a **template used to create an EC2 instance**.

It contains things like:

- Operating system
- Software
- Configuration

Examples:

```text
Ubuntu AMI
Amazon Linux AMI
Windows AMI
```

**Easy meaning:**

> **AMI = Template for creating an EC2 server**

---

### 3. Instance Type

Instance type decides the **CPU, RAM, network performance, etc.**

Examples:

```text
t3.micro
t3.small
t3.medium
```

Example:

> `t3.small` provides more resources than `t3.micro`.

---

### 4. Key Pair

A **Key Pair** is used to securely connect to an EC2 instance.

For Linux:

```text
Your Laptop
     ↓ SSH
EC2 Instance
```

Example:

```bash
ssh -i my-key.pem ubuntu@<public-ip>
```

**Easy meaning:**

> **Key Pair = Secure login method for EC2**

---

### 5. Security Group

A **Security Group** acts like a **virtual firewall for an EC2 instance**.

It controls **inbound and outbound traffic**.

Example:

```text
Inbound:
SSH   → 22
HTTP  → 80
HTTPS → 443
```

For example, allowing:

```text
Port 22 → Your IP
Port 80 → 0.0.0.0/0
```

**Easy meaning:**

> **Security Group = Firewall for EC2**

---

### 6. EBS

**EBS (Elastic Block Store)** provides **persistent storage** for EC2.

Example:

```text
EC2 Instance
     |
    EBS
     |
  Storage
```

Even if the EC2 instance is stopped, EBS data normally remains.

**Easy meaning:**

> **EBS = Hard disk/storage for EC2**

---

### 7. Public IP and Private IP

**Private IP**

- Used inside the AWS VPC/network
- For communication between AWS resources

**Public IP**

- Used to communicate with the EC2 instance from the internet

Example:

```text
Internet
   ↓
Public IP
   ↓
EC2
   ↓
Private IP
   ↓
Other AWS Resources
```

---

### 8. IAM Role with EC2

Instead of storing AWS access keys inside EC2, we can attach an **IAM Role**.

Example:

```text
EC2
 ↓
IAM Role
 ↓
Policy
 ↓
S3 Access
```

So EC2 can securely access S3.

---

### 9. EC2 Instance States

Common states:

| State          | Meaning                                  |
| -------------- | ---------------------------------------- |
| **Pending**    | Instance is starting                     |
| **Running**    | Instance is active                       |
| **Stopping**   | Instance is being stopped                |
| **Stopped**    | Instance is off but can be started again |
| **Terminated** | Instance is permanently deleted          |

**Stopped vs Terminated:**

> **Stopped = Can start again**
> **Terminated = Deleted**

---

### 10. User Data

**User Data** is a script that can run when an EC2 instance starts for the first time.

Example:

```bash
#!/bin/bash
apt update
apt install nginx -y
systemctl start nginx
```

This can automatically install and configure software.

---

### 11. Elastic IP

An **Elastic IP** is a **static public IPv4 address** that you can associate with an EC2 instance.

Useful when you need a fixed public IP.

---

### 12. Auto Scaling

**Auto Scaling** automatically increases or decreases the number of EC2 instances based on demand.

Example:

```text
Low Traffic
   ↓
2 EC2 Instances

High Traffic
   ↓
5 EC2 Instances
```

This helps with **availability and scalability**.

---

### 13. Load Balancer + EC2

A Load Balancer distributes traffic across multiple EC2 instances.

```text
              Load Balancer
             /      |      \
           EC2     EC2     EC2
```

This prevents one server from handling all the traffic.

---

# Important EC2 Interview Questions

**Q: What is EC2?**

> EC2 is an AWS service that provides resizable virtual servers in the cloud.

**Q: What is an AMI?**

> AMI is a template used to launch EC2 instances.

**Q: What is a Security Group?**

> Security Group is a virtual firewall that controls traffic to and from an EC2 instance.

**Q: What is EBS?**

> EBS is persistent block storage used with EC2 instances.

**Q: What is the difference between Stop and Terminate?**

> **Stop** shuts down the instance temporarily and it can be started again. **Terminate** permanently deletes the instance.

### Easy way to remember

```text
AMI            → Template
Instance Type  → CPU/RAM configuration
EC2            → Virtual Server
Key Pair       → Login
Security Group → Firewall
EBS            → Storage
IAM Role       → AWS permissions
Elastic IP     → Static public IP
Auto Scaling   → Automatically add/remove EC2
Load Balancer  → Distribute traffic
```

# AWS Security Group — Short Notes

**Security Group (SG)** is a **virtual firewall** in AWS that controls **network traffic to and from AWS resources**, mainly EC2 instances.

### 1. What does a Security Group do?

It controls:

- **Inbound traffic** → Traffic coming **into** the resource
- **Outbound traffic** → Traffic going **out of** the resource

Example:

```text
Internet
   ↓
Security Group
   ↓
EC2 Instance
```

---

### 2. Inbound Rules

Inbound rules decide **who can access your EC2 and on which port**.

Example:

| Type  | Port | Source    | Purpose            |
| ----- | ---: | --------- | ------------------ |
| SSH   |   22 | My IP     | SSH login          |
| HTTP  |   80 | 0.0.0.0/0 | Web traffic        |
| HTTPS |  443 | 0.0.0.0/0 | Secure web traffic |

Example:

```text
Port 22 → Your IP → SSH
Port 80 → Internet → HTTP
Port 443 → Internet → HTTPS
```

---

### 3. Outbound Rules

Outbound rules control traffic **leaving the EC2 instance**.

For example:

```text
EC2
 ↓
Security Group
 ↓
Internet / Other AWS Services
```

By default, a Security Group generally allows **all outbound traffic** unless you change the rules.

---

### 4. Stateful Firewall

Security Groups are **stateful**.

This means:

> If inbound traffic is allowed, the response traffic is automatically allowed.

Example:

```text
Client → EC2
        Allowed
           ↓
EC2 → Client
    Response automatically allowed
```

You don't need to create a separate outbound rule just for the response.

---

### 5. Security Group is Instance-Level

A Security Group is associated with an **EC2 network interface (ENI)**.

It is not a firewall for the entire VPC.

Example:

```text
VPC
 |
 +-- EC2-1 → SG-1
 |
 +-- EC2-2 → SG-2
```

Different EC2 instances can have different Security Groups.

---

### 6. Important Characteristics

- **Stateful**
- Supports **Allow rules only**
- There is **no explicit Deny rule** in a Security Group
- Changes take effect **immediately**
- One EC2 instance can have **multiple Security Groups**
- A Security Group can be attached to **multiple resources**
- You can use another **Security Group as a source** instead of an IP address

---

### 7. Security Group vs NACL

| Security Group                  | NACL                           |
| ------------------------------- | ------------------------------ |
| Works at **instance/ENI level** | Works at **subnet level**      |
| **Stateful**                    | **Stateless**                  |
| Only **Allow** rules            | Allow + Deny rules             |
| Rules are evaluated together    | Rules evaluated by rule number |

### Easy way to remember

> **Security Group = Firewall for the EC2/resource**

```text
Inbound  → Who can come IN?
Outbound → Where can traffic go OUT?
Port     → Which service?
Source   → Who is allowed?
```

### Common Ports

|     Port | Service    |
| -------: | ---------- |
|   **22** | SSH        |
|   **80** | HTTP       |
|  **443** | HTTPS      |
| **3389** | RDP        |
|   **53** | DNS        |
| **5432** | PostgreSQL |
| **3306** | MySQL      |

**Interview answer:**

> A Security Group is a stateful virtual firewall in AWS that controls inbound and outbound network traffic for resources such as EC2 instances.
