# HAProxy

## lab setup

- frontend: 172.16.140.211
- backend1: 172.16.140.218
- backend2: 172.16.140.219

## configure both the backend machines with httpd

```bash

# update yum
> sudo yum update

# install httpd
> sudo yum install httpd vim

# create a default index.html with content: <h1>This is backend1 / backend2</h1>
> sudo vim /var/www/html/index.html

# start the service
> sudo systemctl start httpd

# enable the service
> sudo systemctl enable httpd

# add the firewall rules to expose service http
> sudo firewall-cmd --add-service http --permanent
> sudo firewall-cmd --add-service https --permanent
> sudo firewall-cmd --reload
> sudo firewall-cmd --list-services

```

## configure the haproxy on frontend machine

```bash

# update the yum repositories
> sudo yum update

# install haproxy
> sudo yum install haproxy

# check the status of haproxy
> sudo systemctl status haproxy

# enable the haproxy service and start it immediately
> sudo systemctl enable --now haproxy

# configure the haproxy to use the required backends
> sudo vim /etc/haproxy/haproxy.cfg

# update the configuration
# backend app
#    balance     roundrobin
#    server  app1 <backend1 ip address>:80 check
#    server  app2 <backend2 ip address>:80 check

# restart the haproxy
> sudo systemctl restart haproxy

# debug the issue
> sudo journalctl -xeu haproxy.service

# verify if the haproxy is working
> curl localhost:5000

# add firewall rules to unblock port 5000
> sudo firewall-cmd --add-port 5000/tcp --permanent
> sudo firewall-cmd --reload
> sudo firewall-cmd --list-ports


```
