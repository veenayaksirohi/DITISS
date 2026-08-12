# Proxy Server (Squid)

## installation

```bash

# update yum repositories
> sudo yum update

# install squid
> sudo yum install squid

# check the status of the server
> sudo systemctl status squid

# start the squid server
> sudo systemctl start squid

# enable the squid server to autostart on reboot
> sudo systemctl enable squid

# check if the squid is running and working fine
> squid -v

# check if the squid configuration is okay
> sudo squid -k parse

# add firewall settings
> sudo firewall-cmd --add-port 3128/tcp --permanent
> sudo firewall-cmd --reload
> sudo firewall-cmd --list-ports

```

## configure squid to block websites

- the below methods will block the domains by matching the whole domain name
- apple.com: will block only apple.com not www.apple.com

### method A

```bash

# open the squid configuration file
> sudo vim /etc/squid/squid.conf

# add these lines on top
acl blocked_sites dstdomain apple.com amazon.in sunbeaminfo.in
http_access deny blocked_sites

# restart the squid server
> sudo systemctl restart squid

```

### method B

```bash

# open the squid configuration file
> sudo vim /etc/squid/squid.conf

# add these lines on top
acl blocked_sites dstdomain "/etc/squid/blocked_sites.txt"
http_access deny blocked_sites

# add the domain names to be blocked in blocked_sites.txt file
> sudo vim /etc/squid/blocked_sites.txt
.microsoft.com
.youtube.com
.apple.com
.amazon.in

# restart the squid server
> sudo systemctl restart squid

```

### configure squid to block files by extensions

```bash

# open the squid configuration file
> sudo vim /etc/squid/squid.conf

# add these lines on top
acl blocked_files urlpath_regex -i \.mp3$ \.mp4$ \.torrent$
http_access deny blocked_files

# restart the squid server
> sudo systemctl restart squid


```
