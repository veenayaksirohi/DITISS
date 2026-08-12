# FTP

## server configuration

```bash

# update yum repositories
> sudo yum update

# install vsftpd (ftp server) and ftp (client)
> sudo yum install vsftpd ftp

# open the vsftpd configuration file
> sudo vim /etc/vsftpd/vsftpd.conf

# add the following configuration
# when a file is created, the date and time will be set from server
use_localtime=YES

# give access to the users created on this server
chroot_local_user=YES

# give access to the list of users
chroot_list_enable=YES

# configure the server to run in passive mode
pasv_enable=YES

# range of ephemeral ports used to communicate with client
pasv_min_port=30000
pasv_max_port=31000


# create a user for testing
> sudo useradd ftpuser

# change the password of ftp user
> sudo passwd ftpuser
> echo "ftpuser:test" | sudo chpasswd

# add the user the enabled users list
> sudo vim /etc/vsftpd/chroot_list
# add the user name
ftpuser

# enable and start the server
> sudo systemctl enable --now vsftpd

# check the status of vsftpd
> sudo systemctl status vsftpd

# add the ftp service to the firewall
> sudo firewall-cmd --add-service ftp --permanent

# reload the firewall settings
> sudo firewall-cmd --reload

# confirm the ftp is listed in opened services list
> sudo firewall-cmd --list-services

# test the ftp on server
> ftp localhost

```

## client configuration

```bash

# update yum repositories
> sudo yum update

# install ftp client
> sudo yum install ftp

# create a temp file
> vim /tmp/client-file

# open ftp connection with server
# > ftp <server ip address>
# ftp> cd ~
# ftp> pwd
# ftp> put /tmp/client-file client-file
# the above comment will upload a file named client-file from client machine to server machine (at /home/ftpuser directory)

# create a file on server machine at /tmp/server-file
# ftp> cd /tmp
# ftp> get server-file /tmp/server-file

```
