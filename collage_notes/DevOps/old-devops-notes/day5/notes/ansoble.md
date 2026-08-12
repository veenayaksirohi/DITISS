# ansible

## controller setup

- installation

```bash

# update apt cache
> sudo apt-get update

# install ansible
> sudo apt-get install ansible

# verify installation
> ansible --version

# setup the password less ssh authentication with targets
> ssh-keygen
# > ssh-copy-id ubuntu@<target machine ip>
> ssh-copy-id ubuntu@172.31.76.72
> ssh-copy-id ubuntu@172.31.71.4

```

- create a file named inventory.ini with ip addresses of all target machines

```ini
[servers]
172.31.76.72
172.31.71.4
```

## tasks

```bash

# check if controller can ping all the targets
# > ansible -i <inventory file path> <target group name> -m <module>
> ansible -i inventory.ini all -m ping
> ansible -i inventory.ini servers -m ping

# get the facts from targets
> ansible -i inventory.ini all -m setup

# execute any command on target machine
# > ansible -i inventory.ini all -a <command>
> ansible -i inventory.ini all -a date
> ansible -i inventory.ini all -a uptime
> ansible -i inventory.ini all -a "df -h"

# execute a playbook
# > ansible-playbook <playbook file> -i <inventory file path>

```

```bash

```
