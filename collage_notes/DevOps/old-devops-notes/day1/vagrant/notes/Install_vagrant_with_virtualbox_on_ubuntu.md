## install required dependancies for virtualbox 
sudo apt update
sudo apt install -y build-essential dkms libxcb-cursor0 linux-headers-$(uname -r)

## Download virtualbox for your linux distribution from this site
https://www.virtualbox.org/wiki/Linux_Downloads

## Install virtual box
# for ex: > sudo dpkg -i virtualbox-7.2_7.2.4-170995~Ubuntu~jammy_amd64.deb

## Install vagrant
> wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
> sudo apt update && sudo apt install vagrant

## Download vagrant ubuntu 24 box
> vagrant init bento/ubuntu-24.04 --minimal

> vagrant up

