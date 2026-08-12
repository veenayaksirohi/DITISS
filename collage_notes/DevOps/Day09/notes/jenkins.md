# Jenkins

## installation

```bash

# update the apt repositories
> sudo apt update

# install open jdk
> sudo apt install fontconfig openjdk-21-jre

# check if java is installed properly
> java -version

# download the jenkins apt repository key
> sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# add the apt repository for jenkins
> echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# update the apt repositories
> sudo apt update

# install jenkins
> sudo apt install jenkins

# enable the jenkins service
> sudo systemctl enable --now jenkins

# check the status of jenkins service
> sudo systemctl status jenkins

# visit the url
> http://localhost:8080
> http://<ip address>:8080

# get the admin password
> sudo cat /var/lib/jenkins/secrets/initialAdminPassword

```
