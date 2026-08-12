# Apache

```bash

# update the yum repos
> sudo yum update

# install apache (httpd)
> sudo yum install httpd

# check if apache is installed
> sudo yum list installed | grep httpd

# check the status of httpd
> sudo systemctl status httpd

# start the httpd server
> sudo systemctl start httpd

# enable the httpd to auto start on reboot
> sudo systemctl enable httpd

# enable the httpd to autostart and start now
> sudo systemctl enable --now httpd

# check if the httpd can serve the http request
# curl: console url which is use to send request to any server
# note: if you get following output, then the httpd server is not running. So start it using systemctl start command
# curl: (7) Failed to connect to localhost port 80: Connection refused
> curl http://localhost
> curl http://127.0.0.1

```

## configure firewall to accept http and https requests

```bash

# open service http (port 80)
> sudo firewall-cmd --add-service http --permanent

# open service https (port 443)
> sudo firewall-cmd --add-service https --permanent

# refresh the firewall settings
> sudo firewall-cmd --reload

# get the list of services opened in the firewall settings
> sudo firewall-cmd --list-services

# remove/close a service from firewall
> sudo firewall-cmd --remove-service http --permanent
> sudo firewall-cmd --remove-service https --permanent
> sudo firewall-cmd --reload

# open a specific port from firewall
> sudo firewall-cmd --add-port 80/tcp --permanent
> sudo firewall-cmd --add-port 443/tcp --permanent
> sudo firewall-cmd --reload

# get the list of opened ports
> sudo firewall-cmd --list-ports


# check if the web server is working on the network IP address
# by visiting the url in your machine's browser

```

## hosting a website

```bash

# go to the htcontent directory
> cd /var/www/html

# create or copy the website pages here
# index.html: default page of the website
> sudo vim index.html

```

## install console browser

```bash

# enable extra packages on rocky linux
# epel: extra packages on enterprise linux
> sudo yum install epel-release
> sudo yum update

# install the console web browser
> sudo yum install elinks

# open console browser
> elinks http://localhost


```

## virtual hosting

```bash

# create directories for hosting the websites

> sudo mkdir /var/www/website1
> sudo mkdir /var/www/website2
> sudo mkdir /var/www/website3

# create the default page for the websites

> sudo vim /var/www/website1/index.html
> sudo vim /var/www/website2/index.html
> sudo vim /var/www/website3/index.html
```

```bash
# create configuration file to virtually host the website1
> sudo vim /etc/httpd/conf.d/website1.conf
```

```xml
<VirtualHost *:80>
        ServerName website1.local
        DocumentRoot /var/www/website1
</VirtualHost>
```

```bash
# create configuration file to virtually host the website2
> sudo vim /etc/httpd/conf.d/website2.conf
```

```xml
<VirtualHost *:80>
        ServerName website2.local
        DocumentRoot /var/www/website2
</VirtualHost>
```

```bash
# create configuration file to virtually host the website3
> sudo vim /etc/httpd/conf.d/website3.conf
```

```xml
<VirtualHost *:80>
        ServerName website3.local
        DocumentRoot /var/www/website3
</VirtualHost>
```

```bash

# restart the httpd server
> sudo systemctl restart httpd

# debug the error
> sudo journalctl -xeu httpd.service

# add the following entries in /etc/hosts file
> sudo vim /etc/hosts
127.0.0.1   website1.local
127.0.0.1   website2.local
127.0.0.1   website3.local

# verify all the websites
> curl website1.local
> curl website2.local
> curl website3.local

# to access these websites on your physical machine

# on ubuntu and macOS:
> sudo vim /etc/hosts
<ip address of vm>  website1.local
<ip address of vm>  website2.local
<ip address of vm>  website3.local

# on windows:
> notepad c:\Windows\System32\Drivers\etc\hosts
<ip address of vm>  website1.local
<ip address of vm>  website2.local
<ip address of vm>  website3.local



```
