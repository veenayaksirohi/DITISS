```
Session 11: (2T)
Theory:• Payment Card Industry Data Security Standard (PCI DSS) • History of PCI-DSS
• Different Levels of PCI
```
# Session 11: Payment Card Industry Data Security Standard (PCI DSS)

---

# 1. Introduction to PCI DSS

**PCI DSS (Payment Card Industry Data Security Standard)** is a globally accepted security standard designed to protect cardholder data and reduce payment card fraud.

It applies to any organization that:

* Stores cardholder data
* Processes card payments
* Transmits cardholder data

Examples:

* Banks
* E-commerce websites
* Payment gateways
* Retail stores
* Service providers

---

## Why PCI DSS Was Created

Before PCI DSS:

* Credit card fraud was increasing rapidly.
* Different card brands had different security requirements.
* Organizations found compliance difficult.

To solve this problem, major payment card companies created a common security standard.

---

# 2. History of PCI DSS

## Formation

In **2006**, five major card brands formed the:

PCI Security Standards Council

### Founding Members

1. Visa Inc.
2. Mastercard
3. American Express
4. Discover Financial Services
5. JCB Co., Ltd.

---

## Evolution of PCI DSS

| Version       | Year | Major Changes                    |
| ------------- | ---- | -------------------------------- |
| PCI DSS 1.0   | 2004 | Initial standard                 |
| PCI DSS 1.1   | 2006 | Clarifications                   |
| PCI DSS 1.2   | 2008 | Improved requirements            |
| PCI DSS 2.0   | 2010 | Virtualization guidance          |
| PCI DSS 3.0   | 2013 | Increased security awareness     |
| PCI DSS 3.2   | 2016 | Multi-Factor Authentication      |
| PCI DSS 4.0   | 2022 | Flexible and risk-based approach |
| PCI DSS 4.0.1 | 2024 | Minor updates and clarifications |

---

## Goal of PCI DSS

### Protect:

* Cardholder Data (CHD)
* Sensitive Authentication Data (SAD)

### Reduce:

* Credit card fraud
* Data breaches
* Identity theft

### Improve:

* Security controls
* Monitoring
* Compliance

---

# 3. Cardholder Data (CHD)

## Includes

* Primary Account Number (PAN)
* Cardholder Name
* Expiration Date
* Service Code

### Example

```text
Cardholder Name : John Doe
Card Number     : 1234 5678 9012 3456
Expiry Date     : 12/28
```

---

# 4. Sensitive Authentication Data (SAD)

Includes:

* CVV/CVC
* PIN
* PIN Block
* Magnetic Stripe Data

### Important

Sensitive Authentication Data must NOT be stored after authorization.

---

# 5. PCI DSS Objectives

PCI DSS has **6 security objectives**.

---

## Objective 1

### Build and Maintain Secure Network

Requirements:

* Install firewalls
* Secure configurations

---

## Objective 2

### Protect Cardholder Data

Requirements:

* Encrypt stored data
* Encrypt data during transmission

---

## Objective 3

### Maintain Vulnerability Management Program

Requirements:

* Anti-virus
* Secure software development
* Patch management

---

## Objective 4

### Implement Strong Access Control

Requirements:

* Need-to-know access
* Unique user IDs
* Physical security

---

## Objective 5

### Monitor and Test Networks

Requirements:

* Logging
* Monitoring
* Vulnerability Scanning
* Penetration Testing

---

## Objective 6

### Maintain Information Security Policy

Requirements:

* Security awareness
* Policies
* Risk management

---

# 6. PCI DSS 12 Requirements

## Goal 1: Secure Network

### Requirement 1

Install and maintain network security controls.

### Requirement 2

Apply secure configurations.

---

## Goal 2: Protect Data

### Requirement 3

Protect stored account data.

### Requirement 4

Protect data during transmission.

---

## Goal 3: Vulnerability Management

### Requirement 5

Protect systems from malware.

### Requirement 6

Develop secure systems and software.

---

## Goal 4: Access Control

### Requirement 7

Restrict access based on business need.

### Requirement 8

Identify and authenticate users.

### Requirement 9

Restrict physical access.

---

## Goal 5: Monitoring

### Requirement 10

Log and monitor activities.

### Requirement 11

Test security systems regularly.

---

## Goal 6: Security Policy

### Requirement 12

Support information security through policies and programs.

---

# 7. Different PCI DSS Compliance Levels

Organizations are classified based on transaction volume.

---

# Merchant Level 1

### More than 6 Million Transactions/Year

Examples:

* Large banks
* Global retailers

Requirements:

* Annual onsite audit
* Quarterly scans

---

# Merchant Level 2

### 1 Million – 6 Million Transactions/Year

Requirements:

* Self-Assessment Questionnaire (SAQ)
* Quarterly scans

---

# Merchant Level 3

### 20,000 – 1 Million E-commerce Transactions/Year

Requirements:

* SAQ
* Quarterly scans

---

# Merchant Level 4

### Fewer than 20,000 E-commerce Transactions/Year

OR

### Less than 1 Million Total Transactions/Year

Requirements:

* Basic compliance validation
* SAQ

---

# Service Provider Levels

Organizations that process payments on behalf of others.

Examples:

* Payment gateways
* Managed service providers

## Level 1

More than 300,000 transactions annually

## Level 2

Less than 300,000 transactions annually

---

# 8. Benefits of PCI DSS

### Security Benefits

* Protect customer data
* Reduce cyber attacks
* Minimize fraud

### Business Benefits

* Customer trust
* Brand reputation
* Reduced penalties

### Operational Benefits

* Better security controls
* Improved monitoring
* Stronger risk management

---

# 9. Consequences of Non-Compliance

Organizations may face:

### Financial Penalties

Thousands to millions of dollars.

### Legal Issues

Regulatory investigations.

### Data Breaches

Loss of sensitive information.

### Reputation Damage

Loss of customer trust.

### Loss of Card Processing Privileges

Unable to accept card payments.

---

# Exam Important Points

## Very Important

### PCI DSS Full Form

**Payment Card Industry Data Security Standard**

---

### PCI DSS Created By

Five major card brands:

* Visa
* Mastercard
* American Express
* Discover
* JCB

---

### PCI SSC Formed

**2006**

---

### Current Major Version

**PCI DSS 4.0 / 4.0.1**

---

### Number of Objectives

**6**

---

### Number of Requirements

**12**

---

### CHD

Cardholder Data

---

### SAD

Sensitive Authentication Data

---

### Can CVV Be Stored?

❌ No (after authorization)

---

### PCI DSS Applies To

Any organization that stores, processes, or transmits cardholder data.

---

# Memory Tricks

## Remember Objectives

### B P M A M P

**B**uild Secure Network

**P**rotect Cardholder Data

**M**aintain Vulnerability Management

**A**ccess Control

**M**onitor Networks

**P**olicies

Mnemonic:

> "**B**ig **P**eople **M**ake **A**mazing **M**oney **P**olicies"

---

## Remember Levels

### 6M → Level 1

### 1M–6M → Level 2

### 20K–1M → Level 3

### <20K → Level 4

Mnemonic:

**6 → 1, 1 → 2, 20K → 3, Smallest → 4**

---

# MCQs (Exam Practice)

### 1. What does PCI DSS stand for?

A. Payment Card Industry Data Security Standard
B. Payment Control Internet Data Standard
C. Personal Card Information Data Standard
D. Payment Card Integrated Data Security

✅ Answer: A

---

### 2. PCI DSS was developed by how many major card brands?

A. 3
B. 4
C. 5
D. 6

✅ Answer: C

---

### 3. PCI Security Standards Council was formed in?

A. 2004
B. 2005
C. 2006
D. 2008

✅ Answer: C

---

### 4. Which is Cardholder Data?

A. PAN
B. Cardholder Name
C. Expiry Date
D. All of the Above

✅ Answer: D

---

### 5. Which is Sensitive Authentication Data?

A. CVV
B. PIN
C. Magnetic Stripe Data
D. All of the Above

✅ Answer: D

---

### 6. How many PCI DSS requirements exist?

A. 8
B. 10
C. 12
D. 14

✅ Answer: C

---

### 7. PCI DSS has how many security objectives?

A. 4
B. 5
C. 6
D. 8

✅ Answer: C

---

### 8. Which requirement deals with logging and monitoring?

A. Requirement 8
B. Requirement 9
C. Requirement 10
D. Requirement 11

✅ Answer: C

---

### 9. Merchant Level 1 processes:

A. Less than 20,000 transactions
B. 20,000–1M transactions
C. 1M–6M transactions
D. More than 6M transactions

✅ Answer: D

---

### 10. PCI DSS primarily protects:

A. Source Code
B. Cardholder Data
C. Employee Data
D. Cloud Data

✅ Answer: B

---

# 2-Minute Revision Sheet (Before Exam)

✔ PCI DSS = Payment Card Industry Data Security Standard

✔ PCI SSC formed in **2006**

✔ Founders = Visa, Mastercard, American Express, Discover, JCB

✔ 6 Security Objectives

✔ 12 Security Requirements

✔ CHD = PAN + Name + Expiry + Service Code

✔ SAD = CVV + PIN + Magnetic Stripe Data

✔ CVV cannot be stored after authorization

✔ Level 1 = >6 Million Transactions

✔ Goal = Protect cardholder data and reduce payment fraud

✔ Applies to anyone who stores, processes, or transmits payment card data.





