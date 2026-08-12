# host a single page website on apache

```bash

> sudo yum update
> sudo yum install httpd -y
> sudo systemctl status httpd
> sudo systemctl enable --now httpd
> curl http://localhost
> sudo vim /var/www/index.html

> sudo firewall-cmd --add-service http --permanent
> sudo firewall-cmd --add-service https --permanent
> sudo firewall-cmd --reload
> sudo firewall-cmd --list-services

```
