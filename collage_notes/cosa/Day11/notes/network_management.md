# Network management

```bash

# use root privileges
> sudo -i

# update the yum repositories
> sudo yum update

# install nmtui
> sudo yum install NetworkManager NetworkManager-tui

# launch the nmtui user interface
> sudo nmtui

# get all network information
> sudo nmcli

# get all connections
> sudo nmcli connection show

# get all devices
> sudo nmcli device show

# take a connection down
# > sudo nmcli connection down <connection name>
> sudo nmcli connection down ens160

# take a connection up
# > sudo nmcli connection up <connection name>
> sudo nmcli connection up ens160

# change the ipv4 method to manual
> sudo nmcli connection modify "ens160" ipv4.method manual ipv4.address 192.168.50.5/24
> sudo nmcli connection down ens160
> sudo nmcli connection up ens160

# change the ipv4 method to auto
> sudo nmcli connection modify "ens160" ipv4.method auto
> sudo nmcli connection down ens160
> sudo nmcli connection up ens160

```
