# IMAP/POP3 (dovecot)

## server configuration

```bash

# install dovecot
> sudo yum install dovecot

```

```bash

# file 1: configure the main file
> sudo vim /etc/dovecot/dovecot.conf

# uncomment line no 24
# lmtp: local mail transfer protocol
protocols = imap pop3 lmtp submission

# uncomment line no 30
# *  => IPv4
# :: => IPv6
listen = *, ::

```

```bash

# file 2: 10-auth.conf
> sudo vim /etc/dovecot/conf.d/10-auth.conf

# uncomment line no 10
# and change the yes value to no
disable_plaintext_auth = no

# add login after plain on line no 100
auth_mechanisms = plain login

```

```bash

# file 3 10-mail.conf
> sudo vim /etc/dovecot/conf.d/10-mail.conf

# add maildir:~/Maildir to the line no 30
mail_location = maildir:~/Maildir

```

```bash

# file 4 10-master.conf
> sudo vim /etc/dovecot/conf.d/10-master.conf

# add the following settings on line no 116 (under service auth worker)
# make sure that the following settings are in the service auth section
unix_listener /var/spool/postfix/private/auth {
    mode = 0666
    user = postfix
    group = postfix
}

```

```bash

# file 5 /etc/dovecot/conf.d/10-ssl.conf
> sudo vim /etc/dovecot/conf.d/10-ssl.conf

# set the ssl flag to no (line number 8)
ssl = no

```

```bash
# enable the dovecot service
> sudo systemctl enable dovecot

# start the dovecot service
> sudo systemctl start dovecot

# check the status of dovecot service
> sudo systemctl status dovecot

# check the errors if there are any
> sudo journalctl -xeu dovecot

# configure firewall to whitelist the imap and pop3
> sudo firewall-cmd --add-service=imap --permanent
> sudo firewall-cmd --add-service=pop3 --permanent
> sudo firewall-cmd --reload

# confirm firewall settings
> sudo firewall-cmd --list-services

```

## test server configuration

```bash

# start a session with dovecot using telnet
> telnet localhost 110

# authenticate with user name
> USER user2

# set the password
> PASS test

# get the statistics
> STAT

# get the list of messages
> LIST

# read or retrieve the message
# > RETR <message id>
> RETR 1

# end the session
> QUIT

```
