# EC2

- used to create instances (virtual machines)

## create an instance

- name: web-server
- AMI: ubuntu server 24.04
- architecture: x64
- instance type: t3.micro
- key-pair
  - name: aug25-batch
  - type: RSA
  - format: pem

## elastic IP address

- public IP address given by AWS to an EC2 instance so that it wont loose it even if the machine gets shut down and rebooted

```bash

# change the permissions of key file
# > chmod 400 <pem file>
> chmod 400 ~/Downloads/aug25-batch.pem

# connect the instance
# usernames
# - ubuntu: ubuntu
# - amazon linux: ec2-user
# > ssh -i <pem file path> ubuntu@<public ip address>
> ssh -i ~/Downloads/aug25-batch.pem ubuntu@3.7.183.179
# add the identity in ssh cache
# the pem file will be kept in the cache till the time the machine is live
# > ssh-add <pem file path>
> ssh-add ~/Downloads/aug25-batch.pem

```

## configure the ec2 instance

### web server

```bash

# update the apt repo
> sudo apt-get update

# install required web server
> sudo apt-get install apache2

# check the status of apache2 service
> sudo systemctl status apache2

# start the apache2 service
> sudo systemctl start apache2

# auto start the service
> sudo systemctl enable apache2

# test the apache2 service
> curl http://localhost:80

```

- configure the security groups

  - select the required instance
  - open the security groups
  - edit the inbound rules
  - add a rule
    - type: http
    - protocol: TCP
    - port range: 80
    - source: Anywhere IPv4 (0.0.0.0/0)

- hosting a web application

  - copy the website pages to the HT_DOCS directory of apache2
  - HT_DOCS: directory which holds the website pages
    - default apache2 service uses following directory as HT_DOCS
    - /var/www/html

- host one file website on server

```bash

# upload all the files to the server
# note: please execute this command on your local machine
# > scp <file> <username>@<public ip address>:<destination path>
> scp index.html ubuntu@3.7.183.179:~/

# move the website file(s) to HT_DOCS directory
# note: please execute this command on your ec2 instance
# > sudo mv <file> /var/www/html/
> sudo mv ~/index.html /var/www/html

```

- host multi-page website

```bash

# archive all the files
# archive
# - bring multiple files together in one single file
# - e.g. tar
# compression
# - reduce the size of a selected file
# - e.g. gzip, bzip, xzip
# note: please execute these commands on your local machine

# tar: tape archive
# -c: create
# -v: verbose
# -f: file name
# > tar -cvf <archive file name> <list of files to be archived>
> tar -cvf website.tar *
> tar -cvf website.tar .

# upload the archived file
> scp website.tar ubuntu@3.7.183.179:~/

# note: execute these commands on the ec2 instance

# move the website.tar to HT_DOCS
> sudo mv website.tar /var/www/html
> cd /var/www/html

# unarchive the website.tar
# -x: extract
> sudo tar -xvf website.tar

```

### python application

```bash

# install the pip3 manager
> sudo apt-get install python3-pip

# install all python application dependencies
# create a requirements.txt file with all package names

# for python <= 3.11.x
> pip3 install -r requirements.txt

# for python > 3.11.x
> pip3 install -r requirements.txt --break-system-packages

# run the application (command) in background
> python3 server.py &

# check the background processes
> bg

# move a process from background to foreground
> fg <process id>

# move the foreground process to background
# > press ctrl + z

```

- run a process continuously in the background

```bash

# using nohup
# > nohup <command> &
> nohup python3 server.py &

# using process manger (pm2)

# install nodejs

# Download and install nvm:
> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
> \. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
> nvm install 24

# Verify the Node.js version:
> node -v # Should print "v24.11.1".

# Verify npm version:
> npm -v # Should print "11.6.2".

# install pm2
> npm install -g pm2

# start the server using pm2
# > pm2 start --name <logical name> <file name>
> pm2 start --name backend-server server.py

# check the status
> pm2 status

# get details of a selected application using pm2
# > pm2 info <id>

# stop the application using pm2
# > pm2 stop <id>

# restart the application using pm2
# > pm2 restart <id>

# delete the application from pm2 queue
# > pm2 delete <id>

```

## securing the website

```bash

# install certbot (Let's Encrypt)
> sudo snap install --classic certbot

```

- add 'A' record in DNS service
- configure the apache for SSL
  - add the following configuration in /etc/apache2/sites-enabled/aug25.sunbeamapps.org.conf

```text
<VirtualHost *:80>
    ServerAdmin amit.kulkarni@sunbeaminfo.com
    ServerName aug25.sunbeamapps.org
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/aug25.sunbeamapps.org.error.log
    CustomLog ${APACHE_LOG_DIR}/aug25.sunbeamapps.org.access.log combined
    RewriteEngine on
    RewriteCond %{SERVER_NAME} =aug25.sunbeamapps.org
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```

# S3

- simple storage service
- store files in AWS cloud in the form of object
- object based storage
- stores the object in buckets
- bucket is a container to store the files (objects)
- bucket name must be unique throughout universe
