# Infrastructure

## VPC

- Resources to create: VPC only
- Name tag: myvpc
- IPv4 CIDR block: 10.0.0.0/16
- IPv6 CIDR block: No IPv6 CIDR block
- Tenancy: Default
- VPC encryption control: None

## subnet

- VPC ID: myvpc
- IPv4 CIDRs: 10.0.0.0/16

- subnet1
  - Subnet name: public-subnet
  - Availability Zone: no preference
  - IPv4 VPC CIDR block: 10.0.0.0/16
  - IPv4 subnet CIDR block: 10.0.10.0/24
  - Auto-assign IP settings: Enable auto-assign public IPv4 address
  - after creation of IGW
    - edit routes and add a route
    - destination: 0.0.0.0/0
    - target: internet gateway (my-igw)

- subnet2
  - Subnet name: private-subnet
  - Availability Zone: no preference
  - IPv4 VPC CIDR block: 10.0.0.0/16
  - IPv4 subnet CIDR block: 10.0.20.0/24

## route table

- public route table
  - rename the default route table created by myvpc to: public-rt
  - subnet association: public-subnet

- private route table
  - Name: private-rt
  - VPC: myvpc
  - subnet association: private-subnet

## internet gateway

- Name tag: my-igw
- attach to VPC: myvpc

# connecting to the private ec2 instance

```bash

# add the pem file to ssh cache
# > ssh-add <pem file path>

# ssh into the public ev2 instance (frontend)
# -A: pass the ssh cache to the connection
# > ssh -A ubuntu@<public ip>

```

## bastion host

- also known as jump box
- a publicly accessible ec2 instance which can be used to connect all the private instances
