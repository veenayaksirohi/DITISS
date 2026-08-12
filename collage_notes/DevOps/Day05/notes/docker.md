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

```
