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

# download essential images
> docker image pull httpd
> docker image pull mysql
> docker image pull node
> docker image pull nginx
> docker image pull python

```

## image customization

```bash

```

## containers

```bash

# get the list of running containers
> docker container ls

# get the list of all containers (running/Up, Created, stopped/Exited)
> docker container ls -a

# create a new container
# > docker container create <image name or id>
> docker container create 192.168.0.52:5000/httpd

# start a container
# > docker container start <container name or id>

# stop a running container
# > docker container stop <container name or id>

# remove a stopped container
# > docker container rm <container name or id>

# get the details of selected container
> docker container inspect <container name or iddo>


```

## volumes

```bash

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
