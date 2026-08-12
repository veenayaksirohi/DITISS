# Red Hat Package manager

## yum

```bash

# update the current package list from current repositories
> sudo yum update

# install a package
# > sudo yum install <package name>
> sudo yum install vim

# remove a package
# > sudo yum remove <package name>
> sudo yum remove vim

# remove all unnecessary fils
> sudo yum autoremove

# reinstall a package (package must be installed in order to reinstall)
# > sudo yum reinstall <package name>
> sudo yum reinstall vim

# get the history of yum command
> sudo yum history

# update a package
# > sudo yum update <package name>
> sudo yum update vim

# upgrade a package
# > sudo yum upgrade <package name>
> sudo yum upgrade vim

# downgrade a package
> sudo yum downgrade vim

# get the list of installed software
> sudo yum list installed

# check if a software is installed on the machine
# > sudo yum list installed | grep <software name>
> sudo yum list installed | grep httpd

# get the list of available software
> sudo yum list available

# get the list of both installed and available software
> sudo yum list all

# get the list of updates available
# use sudo yum update command to install all the available updates
> sudo yum list updates

# get the information about a package
# > sudo yum info <package name>
> sudo yum info vim

# search for a package
# > sudo yum search <keyword>
> sudo yum search ftp

# find the package which provides a file
# > sudo yum provides <file name>
> sudo yum provides /usr/bin/vim

# find the dependencies of a package
# > sudo yum deplist <package name>
> sudo yum deplist httpd

# check if any updates are available without installed them
> sudo yum check-update

# find the yum groups
> sudo yum group list

# find the information about a group
# > sudo yum group info <group name>
> sudo yum group info Server

# install a group
# > sudo yum group install <group name>
> sudo yum group install Server
> sudo yum group install "Development Tools"

```

## dnf

```bash

# update the current package list from current repositories
> sudo dnf update

# install a package
# > sudo dnf install <package name>
> sudo dnf install vim

# remove a package
# > sudo dnf remove <package name>
> sudo dnf remove vim

# reinstall a package (package must be installed in order to reinstall)
# > sudo dnf reinstall <package name>
> sudo dnf reinstall vim

# get the history of dnf command
> sudo dnf history

# update a package
# > sudo dnf update <package name>
> sudo dnf update vim

# upgrade a package
# > sudo dnf upgrade <package name>
> sudo dnf upgrade vim

# downgrade a package
> sudo dnf downgrade vim

```

# Debian package manager

```bash

# update the apt repositories
> sudo apt update

# install an application
# > sudo apt install <package name>
> sudo apt install vim

# remove an application but keep the config files
# > sudo apt remove <package name>
> sudo apt remove vim

# remove an application also removing the config files
# > sudo apt purge <package name>
> sudo apt purge vim

# remove all unnecessary fils
> sudo apt autoremove

# get details of selected package
# > sudo apt show <package name>
> sudo apt show apache2

# install aptitude (cui version of package management)
> sudo apt install aptitude
> sudo apt install synaptic

```
