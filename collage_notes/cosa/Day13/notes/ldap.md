# LDAP

## server configuration

```bash

# change the hostname to server
> sudo vim /etc/hostname

# reboot the machine
> sudo reboot

# start using root user
> sudo -i

# install epel-release to enable the extra packages for enterprise linux
> yum install -y epel-release

# create a file epel.repo in /etc/yum.repos.d
# create a file named /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

# update the yum repositories
> yum update

# install open ldap and dependencies
> yum install -y openldap openldap-clients openldap-servers openssl wget tar

# install perl (optional, install only if the rpm is failed to install)
> yum install -y perl

# download latest migration tools packages
> cd /tmp
> wget https://www.rpmfind.net/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/m/migrationtools-47-39.fc44.noarch.rpm

# install the migrationtools using rpm command
> rpm -ivh migrationtools-47-39.fc44.noarch.rpm

# confirm the migration tools scripts are available
> cd /usr/share/migrationtools/

# set ldap password for administration
# slappasswd -s <password> -n > /etc/openldap/passwd
> slappasswd -s test -n > /etc/openldap/passwd

# confirm the generated password
> cat /etc/openldap/passwd

# create private and public certificates
# req: request to create a certificate (combination of two keys: private and public)
# -new: create a new certificate
# -x509: type of certificate to create
# -nodes: do not use DES algo
# -out: create a public key using pem format
# -keyout: create a private key using pem format
# -days: validity of the keys
> openssl req -new -x509 -nodes -out /etc/openldap/certs/cert.pem -keyout /etc/openldap/certs/priv.pem -days 365

# Country Name: IN
# State or Province Name: MH
# Locality Name: Pune
# Organization Name: Sunbeam
# Organizational Unit Name: hinjawadi
# Common Name: server
# Email Address: admin@test.com

# verify if the key files are created
> cd /etc/openldap/certs

# change the ownership from root to ldap
# as openLDAP uses ldap user for client server communication
> chown ldap:ldap *
# verify the ownership using ls -l command

# enable the service
> systemctl enable slapd

# start the service
> systemctl start slapd

# check the status
> systemctl status slapd

# firewall configuration
> firewall-cmd --add-service=ldap --permanent
> firewall-cmd --add-service=ldaps --permanent
> firewall-cmd --reload
> firewall-cmd --list-services

# go the schema directory
> cd /etc/openldap/schema

# add configuration
> ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f cosine.ldif
> ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f nis.ldif

# copy the password generated earlier from the following file
> cat /etc/openldap/passwd

# create configuration file
> vim /etc/openldap/changes.ldif

# NOTE:
# - please paste the password from /etc/openldap/passwd in olcRootPW field (line number 20)
# - please do not add any brackets
# - please add the following contents in the /etc/openldap/changes.ldif file

dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"
  read by dn.base="cn=Manager,dc=example,dc=com" read by * none

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=example,dc=com

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=com

dn: olcDatabase={2}mdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: [copy your slap password here]

dn: olcDatabase={2}mdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by
  dn="cn=Manager,dc=example,dc=com" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=Manager,dc=example,dc=com" write by * read

# add the configuration
> ldapmodify -Y EXTERNAL -H ldapi:/// -f /etc/openldap/changes.ldif

# create base configuration
> vim /etc/openldap/base.ldif

# add the following contents

dn: dc=example,dc=com
dc: example
objectClass: top
objectClass: domain

dn: ou=People,dc=example,dc=com
ou: People
objectClass: top
objectClass: organizationalUnit

dn: ou=Group,dc=example,dc=com
ou: Group
objectClass: top
objectClass: organizationalUnit

# add the configuration
> ldapadd -x -D cn=Manager,dc=example,dc=com -w test -f /etc/openldap/base.ldif

# create directory for ldap users
> mkdir /home/guests

# create users for ldap auth
> useradd -d /home/guests/ldapuser1 ldapuser1
> echo "ldapuser1:test" | chpasswd

# create users for ldap auth
> useradd -d /home/guests/ldapuser2 ldapuser2
> echo "ldapuser2:test" | chpasswd

# go to the migration tools directory
> cd /usr/share/migrationtools

# open common file to change the domain name
> vim migrate_common.ph

# change the domain name on line no 71 and 74
$DEFAULT_MAIL_DOMAIN = "example.com";
$DEFAULT_BASE = "dc=example,dc=com";

# get all the users whose id > 1000
> grep ":10[0-9][0-9]" /etc/passwd > passwd

# verify the users
# should include ldapuser1 and ldapuser2
> cat passwd

# migrate all the users
> ./migrate_passwd.pl passwd users.ldif
> ldapadd -x -D cn=Manager,dc=example,dc=com -w test -f users.ldif

# get all the groups whose id > 1000
> grep ":10[0-9][0-9]" /etc/group > groups

# migrate all the users
> ./migrate_group.pl groups groups.ldif
> ldapadd -x -D cn=Manager,dc=example,dc=com -w test -f groups.ldif

# confirm if ldapuser1 is added in ldap
> ldapsearch -x cn=ldapuser1 -b dc=example,dc=com

# check the configuration
> slaptest


```

## client configuration

```bash

# change the hostname to client
> sudo vim /etc/hostname

# reboot the machine
> sudo reboot

# login with root
> sudo -i

# install required packages
> yum -y install openldap-clients sssd sssd-ldap oddjob-mkhomedir

# configure your domain details for sssd
> vim /etc/sssd/sssd.conf

# NOTE:
# - please change the ldap_uri to point to the server IP address

[domain/default]
id_provider = ldap
autofs_provider = ldap
auth_provider = ldap
chpass_provider = ldap
ldap_uri = ldap://172.16.140.216
ldap_search_base = dc=example,dc=com
ldap_id_use_start_tls = False
ldap_tls_cacertdir = /etc/openldap/certs
cache_credentials = True
ldap_tls_reqcert = allow

[sssd]
services = nss, pam, autofs
domains = default

[nss]
homedir_substring = /home

# change the permissions of sssd configuration file
> chmod 600 /etc/sssd/sssd.conf

# configure ldap client
> vim /etc/openldap/ldap.conf

URI ldap://172.16.140.216/
BASE dc=example,dc=com

# change the auth mechanism to sssd (PAM with LDAP)
> authselect select sssd with-mkhomedir --force

# restart the sssd service
> systemctl enable --now sssd oddjobd

# check if you can login with user ldapuser1
> su - ldapuser1

```
