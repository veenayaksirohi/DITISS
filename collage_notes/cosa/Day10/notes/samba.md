# Samba

## server configuration

```bash

# update yum repositories
> sudo yum update

# install samba server
> sudo yum install samba

# create a new user for samba
> sudo useradd smbuser

# set password
> echo "smbuser:test" | sudo chpasswd

# add this user for samba
> sudo smbpasswd -a smbuser

# check if the user is added to samba auth database
> sudo pdbedit -L

# open samba configuration file
> sudo vim /etc/samba/smb.conf

# add the following lines
# comment: to show the comments to the users
# path: directory path to share the contents
# writeable: make the share writeable
# public: publicly available
# browseable: user can see the contents of the shared directory
# create mask: used to set the file permissions
# directory mask: user to set the directory permissions
# valid users: list of users who can access the smb share
# force users: force clients to use this user
[share]
    comment = My Share
    path = /var/smb/share
    writeable = yes
    public = yes
    browseable = yes
    create mask = 0644
    directory mask = 0755
    valid users = smbuser
    force user = smbuser

# create a directory for sharing the files
> sudo mkdir -p /var/smb/share

# set the permissions to allow everyone to read and write the contents
> sudo chmod 777 -R /var/smb/share

# stop SELinux (not recommended)
> sudo setenforce 0

# get the status of SELinux
> sudo getenforce

# enable the samba server
> sudo systemctl enable smb

# start the samba server
> sudo systemctl start smb

# check the status samba server
> sudo systemctl status smb

# add the firewall settings
> sudo firewall-cmd --add-service=samba --permanent

# reload the firewall settings
> sudo firewall-cmd --reload

# verify the services
> sudo firewall-cmd --list-services

```

## linux client configuration

```bash

# update yum repositories
> sudo yum update

# install samba client and CIFS utils
> sudo yum install samba-client cifs-utils

# verify if the samba server is running
> sudo smbclient -L 172.16.140.216 -U smbuser

# create a mount point
> sudo mkdir /client_smb_share

# mount the smb drive
# > sudo mount -t cifs -o username=<user> //<ip address>/share <mount point>
> sudo mount -t cifs -o username=smbuser //172.16.140.216/share /client_smb_share

# verify the mounted fs
> sudo findmnt

```

## windows client configuration

- there is no configuration required on windows
- open "Run dialog" (windows + R)
- \\<server ip address>
