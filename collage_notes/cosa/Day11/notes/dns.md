# DNS

## server configuration

```bash

# change the hostname to server.example.local
> sudo vim /etc/hostname

# install dns server
> sudo yum install -y bind bind-utils

# open the configuration file for bind
> sudo vim /etc/named.conf
> sudo vim /etc/named/named.conf

# comment the line 11 and 12
# // listen-on port 53 { 127.0.0.1; };
# // listen-on-v6 port 53 { ::1; };

# configure the line no 19
# > allow-query     { localhost; <network ip>; };
# > allow-query     { localhost; 172.16.140.0/24; };
> allow-query     { localhost; 192.168.80.0/24; };

# add following sections
# forward zone: used to resolve the domain name to ip address

zone "example.local" IN {
        type master;
        file "example.local.db";
        allow-update { none; };
        allow-query { any; };
};

# backward zone: used to resolve the ip address to domain name

zone "80.168.192.in-addr.arpa" IN {
        type master;
        file "example.local.rev";
        allow-update { none; };
        allow-query { any; };
};

# check if the named configuration is OKAY
> sudo named-checkconf

# add following contents in /var/named/example.local.db
> sudo vim /var/named/example.local.db

$TTL 86400
@ IN SOA server.example.local. client.example.local. (
        2020011800 ;Serial
        3600 ;Refresh
        1800 ;Retry
        604800 ;Expire
        86400 ;Minimum TTL
)

;Name Server Information
@ IN NS server.example.local.

;IP Address for name server
server IN A 172.16.140.216
client IN A 172.16.140.211


# update the reverse zone settings
> vim /var/named/example.local.rev

# add following contents
$TTL 86400
@ IN SOA server.example.local. client.example.local. (
        2020011800 ;Serial
        3600 ;Refresh
        1800 ;Retry
        604800 ;Expire
        86400 ;Minimum TTL
)

;Name Server Information
@ IN NS server.example.local.

;IP Address for name server
server IN A 172.16.140.216
client IN A 172.16.140.211

;Reverse lookup for name server
160 IN PTR server.example.local
167 IN PTR client.example.local

# check the configuration
> named-checkzone example.local /var/named/example.local.db
> named-checkzone example.local /var/named/example.local.rev

# change the ownership of both the files
> sudo chown named:named /var/named/example.local.db
> sudo chown named:named /var/named/example.local.rev

# start the server
> sudo systemctl start named

# enable the server
> sudo systemctl enable named

# check the named server status
> sudo systemctl status named

# if error, use the command to debug
> sudo journalctl -xeu named.service

# configure firewall
> sudo firewall-cmd --add-service dns --permanent
> sudo firewall-cmd --reload
> sudo firewall-cmd --list-services

# test the dns server
> dig @localhost server.example.local
> dig @localhost client.example.local

```

## client configuration

```bash

# change the hostname to client.example.local
> sudo vim /etc/hostname

# install bind utils
> sudo yum install bind-utils

# change ip address of dns server
> vim /etc/resolv.conf
# add the server ip address
# nameserver 172.16.140.216

# check if server and client can be resolved
> nslookup server.example.local
> nslookup client.example.local

```
