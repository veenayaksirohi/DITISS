# docker

## installation

```bash

# update apt repositories
> sudo apt update

# install the pre-requisites
> sudo apt install ca-certificates curl

# download and configure the gpg key which will be used to download the docker from docker apt repository
> sudo install -m 0755 -d /etc/apt/keyrings
> sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
> sudo chmod a+r /etc/apt/keyrings/docker.asc

#  Add the repository to Apt sources:
> sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# update the apt repositories
> sudo apt update

# install docker
> sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# start the docker daemon
> sudo systemctl enable --now docker

# add the current user in the docker group
> sudo usermod -aG docker $USER

# reboot the machine
> sudo reboot

```

## commands

### docker commands

```bash

# get the docker version
> docker --version

# get the system information
> docker system info
> docker info

# get the space utilization
> docker system df

# remove all dangling objects without volumes
> docker system prune

# remove all dangling objects with volumes
> docker system prune --volumes

# login with docker hub account
# > docker login -u <docker username>

# logout from the docker hub account
> docker logout

```

### image commands

```bash

# get the list of images available on machine
> docker image ls

# pull an image from docker hub to local machine
# > docker image pull <image name>
> docker image pull hello-world
> docker image pull httpd
> docker image pull nginx
> docker image pull ubuntu
> docker image pull python
> docker image pull mysql
> docker image pull alpine

# find the details (metadata) of a selected image
# > docker image inspect <image name>
> docker image inspect hello-world

# remove a selected image
# > docker image rm <image name>
> docker image rm hello-world

# remove the dangling images
> docker image prune

# tag an image (create an alias for an existing image)
# > docker image tag <old name> <docker username>/<image name>
> docker image tag mywebsite amitksunbeam/mywebsite

# push an image to docker hub
# > docker image push <docker hub account name>/<image name>
> docker image push amitksunbeam/mywebsite
```

### custom images

- to create custom image use Dockerfile
- commands used in Dockerfile
  - FROM
    - used to set the base image for the image to be created
    - e.g.
      - for websites: httpd, nginx
      - for database: mysql, mongo
      - for backend
        - flask: python
        - express: node
  - COPY
    - used to copy the resource(s) from local machine to the image
    - syntax: COPY <local machine path> <image path>
  - EXPOSE
    - used to expose a port number
    - e.g.
      - for web servers: httpd (80), nginx (80)
      - for databases: mysql (3306), mongo (27017)
  - WORKDIR
    - used to set the working directory of the image
    - if the directory does not exist, the image creates it automatically
  - RUN
    - used to execute the command at the time of building the image
    - Dockerfile may contain more than one RUN commands
    - e.g.
      - RUN pip install flask
        - flask packages gets installed at the time of building the image
  - CMD
    - used to execute the command at the time of starting a container
    - Dockerfile must container only one CMD command
    - when the CMD command is over the container stops itself
    - e.g.
      - CMD python server.py
        - the server.py will start at the time of starting a container

```bash

# build a custom image using Dockerfile
# note: if tag is not configured, by default it used latest tag
# > docker image build -t <image name>:<tag> <directory containing Dockerfile>
> docker image build -t myimage .

```

### container commands

```bash

# get the list of running containers
> docker container ls

# get the list of all containers
# status: CREATED (Created), RUNNING (Up), STOPPED (Exited)
> docker container ls -a

# create a container
# --name: name of the container to be created
# note:
# - every container must have a unique name
# - every container gets a unique id when created
# > docker container create --name <container name> <image name>
> docker container create --name mycontainer hello-world

# start a container
# lifecycle:
# - container starts its life (it goes in Up or running state)
# - container executes the command it is meant to execute
# - once the command is executed successfully or with error, the container stops
# - once the containers stops, it goes in Exited state
# > docker container start <container name or id>
> docker container start mycontainer

# restart the container
# > docker container restart <container name or id>
> docker container restart mycontainer

# stop the running container
# > docker container stop <container name or id>
> docker container stop mycontainer

# get the logs generated by the container
# > docker container logs <container name or id>
> docker container logs mycontainer

# get the details of selected container
# > docker container inspect <container name or id>
> docker container inspect mycontainer

# remove a stopped container
# > docker container rm <container name or id>
> docker container rm mycontainer

# remove a running container
# > docker container rm --force <container name or id>
# > docker container rm -f <container name or id>
> docker container rm --force mycontainer

# run a container in attached mode (combination of create + start)
# note: first creates a new container and then starts immediately
# > docker container run --name <container name> <image name>
> docker container run --name mycontainer nginx

# run a container in detached mode (combination of create + start)
# note: first creates a new container and then starts immediately
# > docker container run -d --name <container name> <image name>
> docker container run -d --name mycontainer nginx

# run a container with port published to make accessible over the network
# note:
# - os port: can be any available port
# - container port: must be the port the application inside container is expecting
# > docker container run -d --name <container name> -p <os port>:<container port> <image name>
> docker container run -d --name mycontainer -p 8000:80 httpd

# execute a command inside the container
# -i: interactive (you can pass input to container)
# -t: tty (get the terminal access of the container)
# > docker container exec -it <container name> <command>
> docker container exec -it mycontainer date

# get the terminal or shell from a container
# > docker container exec -it <container name> <bash/sh>
> docker container exec -it mycontainer bash

# create a container along with environment variables
# > docker container run -d --name <container name> -e <env var name>=<value> <image name>
> docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root mysql

# create a container along with a volume
# > docker container run -d --name <container name> -v <volume name>:<mount point> <image name>
> docker container run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -v mysql-volume:/var/lib/mysql mysql

# remove stopped containers
> docker container prune

# get the current statistics of all the containers
# notes: NAME, CPU %, MEM USAGE / LIMIT, MEM %, NET I/O, BLOCK I/O, PIDS
> docker container stats

# copy a file from local machine to a container
# > docker container cp <source file name> <container name>:<destination path>
> docker container cp myfile.txt httpd:/tmp/myfile.txt

# copy a file from container to local machine
# > docker container cp <container name>:<source path> <destination path>
> docker container cp httpd:/tmp/myfile.txt ./myfile.txt

# copy a file from one container to another
# > docker container cp <source container name>:<source path> <destination container name>:<destination path>
> docker container cp httpd:/tmp/myfile.txt nginx:/tmp/myfile.txt

# build a custom image using container commit command
# > docker container commit <container name or id> <image name>
> docker container commit httpd myhttpd

```

### volume commands

```bash

# get the list of volumes
> docker volume ls

# remove the dangling (unused) volumes
> docker volume prune

# create a volume
# > docker volume create <volume name>
> docker volume create mysql-volume

# get the details of the volume
# > docker volume inspect <volume name>
> docker volume inspect mysql-volume

# remove a volume
# > docker volume rm <volume name>
> docker volume rm mysql-volume

```

### swarm commands

```bash

# check if swarm is enabled on the node
> docker system info | grep Swarm

# initialize the swarm
# > docker swarm init --advertise-addr <ip address of manager node>
> docker swarm init --advertise-addr 172.16.140.250

# stop the swarm or leave from the swarm
# note: this command will remove the current machine from swarm
> docker swarm leave --force

# generate a token to add a node as a worker
> docker swarm join-token worker

# generate a token to add a node as a manager
> docker swarm join-token manager

```

### node commands

```bash

# get the list of nodes in a swarm
> docker node ls

# get the details of selected node
# > docker node inspect <node id>

# remove a node from manager
# > docker node rm <node id>

# demote a manager to worker
# > docker node demote <manager id>

# promote a worker to manager
# > docker node promote <worker id>

```

### service commands

```bash

# get the list of services
> docker service ls

# create a service
# > docker service create --name <service name> <image name>
> docker service create --name httpd httpd

# check if a required port is busy
# > lsof -i :<port number>
> lsof -i :8000

# create a service with publishing a required port
# > docker service create --name <service name> -p <os port>:<container port> <image name>
> docker service create --name httpd -p 8000:80 httpd

# create a service with 5 replicas
# > docker service create --name <service name> -p <os port>:<container port> --replicas <desired count> <image name>
> docker service create --name httpd -p 8000:80 --replicas 5 httpd

# get the service details
# > docker service inspect <service name>
> docker service inspect httpd

# get the list of containers created by a service
# > docker service ps <service name>
> docker service ps httpd

# remove a service
# > docker service rm <service name>
> docker service rm httpd

# run a command every after 1 second
> watch -n 1 docker container ls

# scale the service
# > docker service scale <service name>=<new desired count>
> docker service scale httpd=10

```
