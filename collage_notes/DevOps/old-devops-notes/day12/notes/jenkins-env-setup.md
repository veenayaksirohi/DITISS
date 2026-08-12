# Vagrant

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
	config.vm.hostname = "jenkins-server"
end
```

# docker

```bash

# update apt cache
> sudo apt-get update

# install pre-requisites
> sudo apt install ca-certificates curl

# install docker apt repo key
> sudo install -m 0755 -d /etc/apt/keyrings
> sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
> sudo chmod a+r /etc/apt/keyrings/docker.asc

# add the repository to Apt sources:
> sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# update the apt repo
> sudo apt update

# install docker
> sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# add current user to docker group
> sudo usermod -aG docker $USER

# start the docker server automatically after reboot
> sudo systemctl enable --now docker

```

# jenkins

```bash

# update apt repo
> sudo apt update

# install pre-requisites
> sudo apt install fontconfig openjdk-21-jre

# verify the java installation
> java -version

# download the jenkins apt repo key
> sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# add the jenkins apt repo
> echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# update apt repo
> sudo apt update

# install latest version of jenkins
> sudo apt install jenkins

# check the jenkins server status
> sudo systemctl status jenkins

# start jenkins server automatically after restart
> sudo systemctl enable --now jenkins

```

## initial configuration

```bash

# open browser with following url
# > localhost:8080
# > <vagrant machine ip address>:8080

# copy a password from initialAdminPassword file
> sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# install suggested plugins
# create a admin user
# login to the dashboard (http://localhost:8080)

# check if jenkins user exists
> id jenkins
> cat /etc/passwd | grep jenkins

# add jenkins user to docker group
> sudo usermod -aG docker jenkins

# restart the jenkins server to get added to docker group
> sudo systemctl restart jenkins

```

## commands to deploy application in container

```bash

# build the image
> docker image build -t myimage .

# create a container
> docker container run -d --name mycontainer -p 8001:80 myimage

```

## configure a job in jenkins to host website in container

- connect your local repository to GitHub
- create "Freestyle job" in jenkins
- Job configuration
  - GitHub Project URL: copy github project url from browser
  - git repository url: use the url that ends with .git
  - branch: main - add build step: Execute shell
    `

```bash

# update the environment variable PATH to include docker executable
export PATH=$PATH:/usr/bin/docker

# remove existing container
docker container rm --force mycontainer

# build the image
docker image build -t myimage .

# create a container
docker container run -d --name mycontainer -p 8001:80 myimage

```
