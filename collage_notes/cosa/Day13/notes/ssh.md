# SSH

## client configuration

```bash

# create a key pair (private and public key)
> ssh-keygen

# verify if the key files exist in ~/.ssh directory
> cd ~/.ssh
# id_rsa: private key
# id_rsa.pub: public key

# copy public key of client to server
# > ssh-copy-id <server user>@<server ip address>
> ssh-copy-id sunbeam@172.16.140.216

# try login to the server using ssh command
# > ssh <server user>@<server ip address>
> ssh sunbeam@172.16.140.216

```
