# Systemd/service management

## basic service management

```bash

# install an application named httpd
> sudo yum install httpd

# check status of the httpd daemon
# > sudo systemctl status <daemon name>
> sudo systemctl status httpd

# start the daemon
# > sudo systemctl start <daemon name>
> sudo systemctl start httpd

# restart the daemon
# > sudo systemctl restart <daemon name>
> sudo systemctl restart httpd

# enable the service to start automatically on boot
# > sudo systemctl enable <daemon name>
> sudo systemctl enable httpd

# disable the service
# > sudo systemctl disable <daemon name>
> sudo systemctl disable httpd

```

## systemd unit

- what systemd manages is known as a unit
- types: service, mount, swap, timer etc.
- the custom systemd units are located under
  - /etc/systemd/system

```bash

# get the list of unit types
> sudo systemctl -t help

# get the list of all available systemd units
> sudo systemctl list-unit-files

# filter the list of available units
# > sudo systemctl list-unit-files --type <type>
> sudo systemctl list-unit-files --type service
> sudo systemctl list-unit-files --type mount
> sudo systemctl list-unit-files --type target
> sudo systemctl list-unit-files --type socket
> sudo systemctl list-unit-files --type timer

```
