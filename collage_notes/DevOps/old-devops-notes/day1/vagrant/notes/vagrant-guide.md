# Vagrant Setup & Usage Guide

## Prerequisites

- Install **VirtualBox** and **Extension Pack**  
  👉 <https://www.virtualbox.org/wiki/Downloads>

- Install **Vagrant**  
  👉 <https://developer.hashicorp.com/vagrant/install>

---

## Basic Commands

### Check if Vagrant is Installed

```bash
vagrant --version
```

### List Available Boxes

```bash
vagrant box list
```

### Download Base Image (Box)

Search and download **bento/ubuntu-24.04 (VirtualBox provider)**  
👉 <https://portal.cloud.hashicorp.com/vagrant/discover>

### Add Downloaded Box

```bash
vagrant box add <box-name> </path/to/box-file>
```

Example:

```bash
vagrant box add ubuntu24 "E:\Chrome-Downloads\DevOps\e40798fa-b2c0-11f0-8512-fe80f7412099"
```

---

## Demo 1: Single Node Setup

### Initialize Vagrant

```bash
vagrant init
```

Edit **Vagrantfile**:

```bash
config.vm.box = "ubuntu24"
```

### Start the VM

```bash
vagrant up
```

### Access the VM

```bash
vagrant ssh
```

### Shutdown the VM

```bash
vagrant halt
```

### Delete the VM

```bash
vagrant destroy
# or force delete
vagrant destroy --force
```

---

## Demo 2: Multi Node Setup

### Create Minimal Vagrantfile

```bash
vagrant init ubuntu24 --minimal
```

### Edit `Vagrantfile` and add

```ruby
# Configuration for 1st machine 
config.vm.define "master" do |master|
  master.vm.hostname = "master"
end

# Configuration for 2nd machine 
config.vm.define "worker" do |worker|
  worker.vm.hostname = "worker"
end
```

### Validate Syntax

```bash
vagrant validate
```

### Start VMs

```bash
vagrant up
```

### Status Check

```bash
vagrant status
```

### SSH Access

```bash
vagrant ssh master
vagrant ssh worker
```

---

## Demo 3: Static IP Setup

Add the following in Vagrantfile:

```ruby
config.vm.define "master" do |master|
  master.vm.hostname = "master"
  master.vm.network "private_network", ip: "192.168.56.10"
end
```

> Use any free IP from **192.168.56.0/24**

---

## Demo 4: Shell Provisioning

Create a shell script (e.g., `main.sh`) and modify Vagrantfile:

```ruby
config.vm.define "master" do |master|
  master.vm.hostname = "master"
  master.vm.network "private_network", ip: "192.168.56.10"

  # Run shell script during provisioning
  master.vm.provision "shell", path: "main.sh"
end
```

---

## Global VM Status

```bash
vagrant global-status
```

---
