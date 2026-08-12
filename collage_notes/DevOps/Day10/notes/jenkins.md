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

## automating the html website deployment

- jenkins configuration

```bash

# add the jenkins user to the docker group
> sudo usermod -aG docker jenkins

# restart the jenkins service
> sudo systemctl restart jenkins

# check the groups for jenkins
> id jenkins

# find the absolute path of docker (/usr/bin/docker)
> which docker

# first version:
# create a new job of freestyle project
# add build step: execute shell
# add following lines

# set the environment variable PATH to include the docker path
export PATH=$PATH:/usr/bin/

# restart the service
docker service update --force --image <dockerhub accountname>/website website

# second version
# create a GitHub repository and push your changes to it
# set the git config
> git config --global user.name <username>
> git config --global user.email <email>
> git init
> git add .
> git commit -m "initial commit"
> git push origin master

# if you are facing credentials issues, edit the git credentials to comment the sunbeam's token
> vim ~/.git-credentials
# add # in front of the url and try pushing the changes again

# create a jenkins freestyle project
# - under General settings select "GitHub project" and add the GitHub project url (the url you can find in browser's address is the project url)
# - under Source Code Management settings
#   - select git and add the github repository url (use the same project url and add a .git extension)
#   - change the "Branch Specifier" use the right branch name (master or main)
# - add a build step (execute shell) and add the following settings

# set the environment variable PATH to include the docker path
export PATH=$PATH:/usr/bin/

# build an image
docker image build -t <docker hub accountname>/website .

# login to docker hub (non-interactive login)
echo <docker access token> | docker login -u <dockerhub acccount name> --password-stdin

# push the image to docker hub account
docker image push <dockerhub accountname>/website

# restart the service
# > docker service update --force --image <dockerhub accountname>/<image name> <service name>
docker service update --force --image amitksunbeam/website website

```

```bash

# build an image
> docker image build -t <docker hub accountname>/website .

# login to docker hub (non-interactive login)
> echo <docker access token> | docker login -u <dockerhub acccount name> --password-stdin

# push the image to docker hub account
> docker image push <dockerhub accountname>/website

# create the service (manual step: do not include it in jenkins)
> docker service create --name website -p 8000:80 <dockerhub accountname>/website

# restart the service
# > docker service update --force --image <dockerhub accountname>/<image name> <service name>
> docker service update --force --image amitksunbeam/website website

```
