# VPC

- private cloud (network) on aws

## create vpc

- Resources to create: VPC only
- name: myvpc
- IPv4 CIDR block: 10.0.0.0/16
- tenancy: default (shared)

## create subnets

### public

- vpc: myvpc
- subnet name: subnet-public
- availability zone preference: No
- IPv4 VPC CIDR block: 10.0.0.0/16
- IPv4 subnet CIDR block: 10.0.10.0/24

- set the flag to auto assign public IPs to the instance
  - edit the subnet settings
  - Auto-assign IP settings: enabled

### private

- vpc: myvpc
- subnet name: subnet-private
- availability zone preference: No
- IPv4 VPC CIDR block: 10.0.0.0/16
- IPv4 subnet CIDR block: 10.0.20.0/24

## internet gateway

- used to provide the internet connectivity to the EC2 instances

- name: my-igw
- attach to the VPC: myvpc

## route table

- name: rtb-public
- vpc: my-vpc
- subnet association
  - subnet: subnet-public
- routes
  - 10.0.0.0/16 - local
  - 0.0.0.0/0 - igw (my-igw)

## ec2

### public

- bastion host

  - a new public instance is reserved to connect to the private instance(s)
  - also known as jump-box

- name: web-server
- AMI: ubuntu
- instance type: t3.micro
- network settings
  - vpc: myvpc
  - subnet: subnet-public

### private

- name: backend-server
- AMI: ubuntu
- instance type: t3.micro
- network settings
  - vpc: myvpc
  - subnet: subnet-private
