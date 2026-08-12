# Environment setup

## create multi-machine vagrant environment

```bash

# create a vagrant infra
> vagrant init

# open the Vagrantfile
> vim Vagrantfile

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.define "controller" do |m|
    m.vm.hostname = "controller"
    m.vm.network "private_network", ip: "192.168.56.11"
  end

  config.vm.define "target1" do |m|
    m.vm.hostname = "target1"
    m.vm.network "private_network", ip: "192.168.56.12"
  end
end


# create the infra
> vagrant up

# get the list of boxes
> vagrant box list

# get the list of vagrant machines running
> vagrant status

# download the ubuntu box
> vagrant box add bento/ubuntu-22.04

```

## server or controller (rocky) configuration

```bash

# connect to the controller node
> vagrant ssh controller

# enable the epel
> sudo yum install epel-release

# update the yum repositories
> sudo yum update

# install ansible
> sudo yum install ansible

# create the directory for keeping the inventory
> sudo mkdir /etc/ansible

# create the inventory file
> sudo vim /etc/ansible/hosts

[all]
target1 ansible_host=192.168.56.12


```

## server or controller (ubuntu) configuration

```bash

# connect to the controller node
> vagrant ssh controller

# update the apt repositories
> sudo apt-get update

# install ansible
> sudo apt-get install ansible

# create the directory for keeping the inventory
> sudo mkdir /etc/ansible

# create the inventory file
> sudo vim /etc/ansible/hosts

[all]
target1 ansible_host=192.168.56.12

```

## ansible commands

- please please please execute these commands on controller node

```bash

# check the inventory file
> ansible inventory --list

# check if the controller node can connect to all managed nodes
# ansible will use a module named ping to check the connectivity with managed nodes
> ansible all -m ping
# note: this command will fail for the first time as the passwordless auth is not yet set up

# setting up passwordless auth

# create ssh keys
> ssh-keygen

# copy the public key to managed node
# > ssh-copy-id <username>@<managed node ip address>
> ssh-copy-id vagrant@172.16.140.237
# note:
# - use password as vagrant
# - once done, execute the ansible all -m ping command again and see if it works


# execute a playbook
# > ansible-playbook <playbook file name>

```
