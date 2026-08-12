# NFS

## server configuration

```bash

# update yum repositories
> sudo yum update

# install nfs server package
> sudo yum install nfs-utils

# create a directory to host shared files
> sudo mkdir /nfs_share
> cd /nfs_share
> sudo touch file{1..10}

# share the directory with all clients
> sudo vim /etc/exports

# add following line
# rw: read write permissions
# no_root_squash: root can also access the nfs_share directory
# /nfs_share  <network address>/24(rw,no_root_squash)
/nfs_share  172.16.140.0/24(rw,no_root_squash)

# export all the directories mentioned in /etc/exports
# -a: all directories mentioned in /etc/exports
> sudo exportfs
> sudo exportfs -a

# enable the nfs server
> sudo systemctl enable nfs-server

# start the nfs server
> sudo systemctl start nfs-server

# check the status of nfs server
> sudo systemctl status nfs-server

# show the NFS mounts available with the server
> showmount -e localhost


# add the firewall settings
> sudo firewall-cmd --add-service=nfs --permanent
> sudo firewall-cmd --add-service=rpc-bind --permanent
> sudo firewall-cmd --add-service=mountd --permanent
> sudo firewall-cmd --reload

# check the list of services allowed in firewall
> sudo firewall-cmd --list-services
```

## client configuration

```bash

# update yum repositories
> sudo yum update

# install nfs server package
> sudo yum install nfs-utils

# check the shared contents from server machine
# > sudo showmount -e <server ip address>

# create a mount point
> sudo mkdir /client-nsf-share

# mount the nfs share on client machine
# > sudo mount <server ip address>:<share name> <mount point>
> sudo mount 172.16.140.211:/nfs_share /client-nsf-share/

# check if the nfs share is mounted correctly
> sudo findmnt

```
