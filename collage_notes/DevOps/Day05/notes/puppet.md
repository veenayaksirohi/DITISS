# puppet

## create vm cluster using vagrant

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.define "controller" do |m|
    m.vm.hostname = "controller"
    m.vm.network "private_network", ip: "192.168.80.40"
  end

  config.vm.define "target1" do |m|
    m.vm.hostname = "target1"
    m.vm.network "private_network", ip: "192.168.80.41"
  end

end
```

## server (controller) configuration

```bash

# connect the controller
> vagrant ssh controller

# change the hostname
> sudo hostnamectl set-hostname puppetmaster.example.com

# or
> sudo vim /etc/hostname
> sudo reboot

# add the following entries in hosts file
> sudo vim /etc/hosts

# [master ip address] puppet puppetmaster puppetmaster.example.com
# [client ip address] puppetclient puppetclient.example.com

192.168.0.40 puppet puppetmaster puppetmaster.example.com
192.168.0.41 puppetclient puppetclient.example.com

# 172.16.140.248 puppet puppetmaster puppetmaster.example.com
# 172.16.140.249 puppetclient puppetclient.example.com

# download the puppet8 deb file (which contains the apt repo details)
> wget https://apt.puppetlabs.com/puppet8-release-jammy.deb

# install the deb file
> sudo dpkg -i puppet8-release-jammy.deb

# update the apt repositories
> sudo apt update

# install puppet server
> sudo apt install puppetserver

# update the Java arguments to use less memory (1G)
> sudo vim /etc/default/puppetserver
# JAVA_ARGS="-Xms1g -Xmx1g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"

# update puppet master configuration
> sudo vim /etc/puppetlabs/puppet/puppet.conf

[master]
certname = puppetmaster.example.com
dns_alt_names = puppet,puppetmaster,puppetmaster.example.com

[main]
environment = production

# start the server
> sudo systemctl start puppetserver

# enable the server to auto start
> sudo systemctl enable puppetserver

# check the status of the server
> sudo systemctl status puppetserver

# add the puppet path in PATH environment variable
> vim ~/.bashrc
export PATH=$PATH:/opt/puppetlabs/bin

# reload the bashrc
> source ~/.bashrc

```

## client (target) configuration

```bash
# connect the target1
> vagrant ssh target1

# change the hostname
> sudo hostnamectl set-hostname puppetclient.example.com

# or
> sudo vim /etc/hostname
> sudo reboot

# add the following entries in hosts file
> sudo vim /etc/hosts

# [master ip address] puppet puppetmaster puppetmaster.example.com
# [client ip address] puppetclient puppetclient.example.com

192.168.0.40 puppet puppetmaster puppetmaster.example.com
192.168.0.41 puppetclient puppetclient.example.com

# 172.16.140.248 puppet puppetmaster puppetmaster.example.com
# 172.16.140.249 puppetclient puppetclient.example.com

# download the puppet8 deb file (which contains the apt repo details)
> wget https://apt.puppetlabs.com/puppet8-release-jammy.deb

# install the deb file
> sudo dpkg -i puppet8-release-jammy.deb

# update the apt repositories
> sudo apt update

# install puppet agent
> sudo apt-get install puppet-agent

# update puppet configuration
> sudo vim /etc/puppetlabs/puppet/puppet.conf

[main]
certname = puppetclient.example.com
server = puppetmaster.example.com

[agent]
environment = production

# add the puppet path in PATH environment variable
> vim ~/.bashrc
export PATH=$PATH:/opt/puppetlabs/bin

# reload the bashrc
> source ~/.bashrc

# set the puppet server name
# > sudo puppet config set server [puppet server name] --section agent
> sudo puppet config set server puppetmaster --section agent

# start the puppet agent
> sudo systemctl start puppet

# enable the puppet agent for auto start
> sudo systemctl enable puppet

# check the status of puppet agent
> sudo systemctl status puppet



```

## server certificate management

```bash

# note: execute these commands on server

# get the list of pending certificate requests
> sudo puppetserver ca list
# note:
# - initially before adding any agent you will get no certificates
# - after configuring the agent, you will see the entry of a client certificate

# get the list of all certificate requests
> sudo puppetserver ca list --all

# approve (sign) the client certificate
# > sudo puppetserver ca sign --certname <certificate name>
> sudo puppetserver ca sign --certname puppetclient.example.com

# execute this command on client
> sudo puppet agent --test

```

## puppet manifest configuration

```bash

# note: execute these commands on server

# go to the manifest directory
> cd /etc/puppetlabs/code/environments/production/manifests

# create required manifest file using puppet language
> sudo vim site1.pp

# note:
# - use this command only to test if agent can download the catalog from server and apply it on client
# - in the real environment, this command is NOT required, as the client will communicate with server every after configured time
# - execute these commands on client
> sudo puppet agent --test


```
