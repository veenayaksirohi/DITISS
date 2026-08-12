# Jenkins

## commands to automate the website hosting process

```bash

# build the image
# > docker image build -t website .
> docker image build -t amitksunbeam/website .

# create a container to test the website
> docker container run -d --name website -p 8001:80 website

# generate access token on docker hub
# login to hub.docker.com
# visit the account settings -> personal access tokens

# interactive login to docker hub
# > docker login -u <docker hub username>

# non-interactive login to docker hub (used in jenkins)
# > echo <token> | docker login -u <username> --password-stdin

# logout from docker hub account
> docker logout

# the image name must be in the format: <docker hub username>/<image name>
# website => amitksunbeam/website
# > docker image tag <existing image name> <new image name>
> docker image tag website amitksunbeam/website

# push the image to docker hub
# > docker image push <image name>
> docker image push amitksunbeam/website

# create a service
> docker service create --name website -p 8001:80 <docker hub username>/website

```

## jenkins job

```bash

# set the env variable named "PATH"
export PATH=$PATH:/usr/bin/

# remove the service named website
docker service rm website

# logout from docker hub account
docker logout

# build new version of website image
docker image build -t amitksunbeam/website .

# login to the docker hub account
echo <docker hub access token> | docker login -u amitksunbeam --password-stdin

# push the image to the docker hub
docker image push amitksunbeam/website

# create the service again
docker service create --name website -p 8001:80 amitksunbeam/website

```

# advanced jobs

```bash

# install pip3
> sudo apt-get update
> sudo apt-get install python3-pip

# install the python packages
> pip3 install -r requirements.txt

```
