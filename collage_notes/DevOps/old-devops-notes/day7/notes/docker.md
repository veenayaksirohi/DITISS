# docker

## vagrant VM cluster

```ruby

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"

  config.vm.define "manager" do |m|
    m.vm.hostname = "manger"
  end

  config.vm.define "worker" do |m|
    m.vm.hostname = "worker"
  end

end

```

## installation

```bash

# update the apt repositories
> sudo apt-get update

# install pre-requisites
> sudo apt install ca-certificates curl

# create a directory to keep apt key for docker repo
> sudo install -m 0755 -d /etc/apt/keyrings

# download the apt repo key
> sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# chang the permissions
> sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
> sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# update the apt repositories
> sudo apt update

# install docker
> sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# check the status of docker daemon
> sudo systemctl status docker

# start the docker service
> sudo systemctl start docker

# enable the docker service to autostart at the booting time
> sudo systemctl enable docker

# add the current user in docker group
> sudo usermod -aG docker $USER
# either restart the machine or logout and login again

# verify the installation
> docker system info

```

## private registry

- add a private registry as insecure registry
- create a file named daemon.json in /etc/docker
  > sudo vim /etc/docker/daemon.json
- add following content
  { "insecure-registries" : [ "192.168.0.52:5000" ]}
- restart the docker service
  > sudo systemctl restart docker
- after the docker restarts, use the registry ip address while pulling an image
  > docker image pull 192.168.0.52:5000/httpd - 80
  > docker image pull 192.168.0.52:5000/node
  > docker image pull 192.168.0.52:5000/mysql - 3306
  > docker image pull 192.168.0.52:5000/python
  > docker image pull 192.168.0.52:5000/nginx - 80
  > docker image pull 192.168.0.52:5000/mongo - 27017

## system

```bash

# get the system information
> docker system info

# remove all unused/dangling objects
> docker system prune --volumes

```

## images

```bash

# get the list of images (downloaded on the machine)
> docker image ls

# download an image from docker hub (registry)
# > docker image pull <image name>
> docker image pull hello-world

# get details of selected image
# > docker image inspect <image name or id>
> docker image inspect hello-world

# remove a selected image
# > docker image rm <image name or id>
> docker image rm hello-world

# removing an image
# - image CAN NOT be removed when at least one container of the image exists
# - in case if the image is removed using --force argument, docker removes the entry of the image from the docker image ls output
# - such images whose layers exist on the disk but entries are not visible in the `image ls` outout are known as `dangling or hanging images`

# remove the dangling or hanging images
> docker image prune


# download essential images
> docker image pull httpd
> docker image pull mysql
> docker image pull node
> docker image pull nginx
> docker image pull python

```

## image customization

- used to build a custom image with required application and its dependencies
- ways to build an image
  - commit a running container
  - using Dockerfile
- Dockerfile is a text file which contains the template (set of instructions) to create a new image
- every custom image requires a base image
- Dockerfile commands
  - must be written in upper case
  - must have a value/parameter associated with them
- commands
  - FROM
    - used to set a base image for a custom image
    - e.g. FROM httpd
  - COPY
    - used to copy file(s) from local machine to image
    - syntax: COPY <local machine path> <image path>
    - e.g. COPY index.html /usr/local/apache2/htdocs/
  - WORKDIR:
    - used to set the current working directory
    - if the working directory is not present, it will get created
    - e.g. WORKDIR /src
  - ADD
    - similar to COPY command
    - used to copy file(s) from local machine to image
    - ADD can also extract compressed files like .tar.gz, .zip etc
  - EXPOSE
    - expose a port number for the container
    - e.g. EXPOSE 5000
  - RUN
    - used to execute a command at the time of building the image
    - this command will be executed only once
    - e.g. RUN pip3 install -r requirements.txt
  - CMD
    - used to execute a command inside container
    - must be present only ONCE
    - must be the last command of Dockerfile
    - if this command fails inside the container, the container will stop immediately
    - e.g. CMD python3 server.py

```bash

# create an image using a container
# > docker container commit <container name or id> <image name>

# build an image using a Dockerfile
# > docker image build -t <image name>:<tag> <context>
> docker image build -t myimage .

```

## containers

- a container is designed to run ONLY one command (program) at a time
- if the command finishes its life (successfully or with error), the container automatically gets exited (stopped)

```bash

# get the list of running (Up) containers
> docker container ls

# get the list of all containers (running/Up, Created, stopped/Exited)
> docker container ls -a

# create a new container
# - every container must have a unique name and unique id
# > docker container create <image name or id>
# > docker container create 192.168.0.52:5000/httpd
> docker container create httpd

# start a container
# > docker container start <container name or id>

# stop a running container
# > docker container stop <container name or id>

# remove a stopped container
# > docker container rm <container name or id>

# remove a running container
# > docker container rm --force <container name or id>
# > docker container rm -f <container name or id>

# remove all the containers
# note: execute this command on your own risk
> docker container rm --force $(docker container ls -aq)

# get the details of selected container
# > docker container inspect <container name or iddo>

# run a container in attached mode (first create a new container and immediately start it)
> docker container run <image name or id>

# container execution modes
# - attached mode
#   - the container runs in foreground
#   - it captures the keyboard (input device) and console (output device)
#   - when the terminal is closed, the container stops
# - detached mode
#   - the container runs in background
#   - does not capture keyboard or console

# run command parameters
# -d
# - used to run the container in detached mode
# - e.g. docker container run -d <image name>

# --name
# - used to assign a unique name to the container
# - syntax: docker container run -d --name <container name> <image name>
# - e.g. docker container run -d --name myhttpd httpd

# -e
# - used to set an environment variable
# - syntax: docker container run -d --name <container name> -e <env variable>=<value> <image name>
# - e.g. docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root mysql

# -v
# - used to mount a volume inside a container
# - only way to persist the data outside the container
# - syntax: docker container run -d --name <container name> -v <volume name>:<container mount point> <image name>
# - e.g. docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -v myvolume:/var/lib/mysql mysql

# -p
# - used to forward a port from OS to container
# - more than one containers can not use the same OS port
# - please make sure that the OS is available at the time
# - syntax: docker container run -d --name <container name> -p <OS port>:<container port> <image name or id>
# - e.g. docker container run -d --name httpd -p 8001:80 httpd

# bring a container in attached mode
# > docker container attach <container name or id>

# change the timezone to IST
> sudo timedatectl set-timezone Asia/Kolkata

# execute a command inside a container
# > docker container exec <container name or id> <command>

# get the terminal or shell of a container
# -i: interactive mode (pass the commands and get the output)
# -t: get the terminal out of selected container
> docker container exec -it <container name or id> <bash or sh>

# get the logs generated by a container
# > docker container logs <container name or id>

```

## volumes

- a way to persist the data outside the container
- is a directory created on the local machine
- the path on local machine: /var/lib/docker/volumes/<volume_name>

```bash

# remove the unused volumes
> docker volume prune

# get a list of volumes
> docker volume ls

# create a volume
# > docker volume create <volume name>
> docker volume create mysql-volume

# get details of selected volume
# > docker volume inspect <volume name>
> docker volume inspect mysql-volume

# delete a volume
# > docker volume rm <volume name>
> docker volume rm mysql-volume

```

## networks

```bash

```

## compose

```bash

```

## swarm

```bash

```

## service

```bash

```

## stack
