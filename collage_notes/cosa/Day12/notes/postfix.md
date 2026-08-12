# SMTP (postfix)

## vim configuration

```bash

# open vim configuration
> vim ~/.vimrc

# add following lines
set number

```

## server configuration

```bash

# update yum repositories
> sudo yum update

# install postfix telnet
> sudo yum install postfix telnet

# change the machine hostname
> sudo vim /etc/hostname
# server.example.com
> sudo reboot

# configure the postfix
> sudo vim /etc/postfix/main.cf

# change the host name
myhostname = server.example.com

# change the domain name
mydomain = example.com

# uncomment myorigin (uncomment line no 119)
myorigin = $mydomain

# change the interfaces value from localhost to all
inet_interfaces = all

# add $mydomain to mydestination
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

# set the mail storage directory
home_mailbox = Maildir/

# change the ip address matching with your network address
# mynetworks = 172.16.140.0/24, 127.0.0.0/8
mynetworks = 192.168.80.0/24, 127.0.0.0/8

# check the service status
> sudo systemctl status postfix

# start the service
> sudo systemctl start postfix

# auto start the service
> sudo systemctl enable postfix

# if the service fails, use this command to debug
> sudo journalctl -xeu postfix.service

# configure the firewall
> sudo firewall-cmd --add-service=smtp --permanent
> sudo firewall-cmd --reload

# confirm if firewall has whitelisted the service
> sudo firewall-cmd --list-services

```

## test server configuration

```bash

# create two users named user1 and user2
> sudo useradd user1
> sudo useradd user2

# set the password for both the users to test
> echo "user1:test" | sudo chpasswd
> echo "user2:test" | sudo chpasswd

# test the postfix with a smtp session
> telnet localhost 25

# start session
> EHLO localhost

# set the sender of a message
> MAIL FROM:user1@example.com

# set the receiver of a message
> RCPT TO:user2@example.com

# send the body using DATA command
> DATA

# end the session
> QUIT

```
