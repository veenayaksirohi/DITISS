# DHCP Server

## server configuration

```bash

# change the hostname to server
> sudo vim /etc/hostname
# set the hostname to server

# reboot the machine
> sudo reboot

# install the dhcp server package
> sudo yum install -y dhcp-server

# change the IP address to 192.168.50.10/24
> sudo nmcli connection modify "ens160" ipv4.method manual ipv4.address 192.168.50.10/24
> sudo nmcli connection down ens160
> sudo nmcli connection up ens160

# get the confirmation on ip address
> ip a

# configure the dhcp server
> sudo vim /etc/dhcp/dhcpd.conf

# add the following configurations

default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 192.168.50.0 netmask 255.255.255.0 {
    range 192.168.50.2 192.168.50.200;
    option routers 192.168.50.1;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 8.8.8.8;
}

# bind interfaces
> sudo vim /etc/sysconfig/dhcpd
DHCPDARGS=ens160

# start the server
> sudo systemctl start dhcpd

# enable the server for auto start
> sudo systemctl enable dhcpd

# check the status of server
> sudo systemctl status dhcpd

# debug the issue
> sudo journalctl -xeu dhcpd

# configure firewall for dhcp
> firewall-cmd --add-service dhcp --permanent

# reload the firewall instance
> firewall-cmd --reload

# list the all services
> firewall-cmd --list-services

```

## client configuration

```bash

# change the hostname to client
> sudo vim /etc/hostname
# set the hostname to client

# reboot the machine
> sudo reboot

# install dhcp-client
> sudo yum install dhcp-client

# Release current IP
> sudo dhclient -r

# renew ip address
> sudo dhclient -v

# Request new IP
> sudo dhclient

# check new ip address
> ip a

```
