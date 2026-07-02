ques : To connect Two Network 
Routing Basically Two Types 
1) IP Forwarding   (private to private ) or (public to public) only [not publc to private] i.e lan to lan or want to wan , not lan to wan

vi /proc/sys/net/ipv4/ip_forward


2) NAT  
        snat
        dnat
# LAN = ens33 (40)
# Wan = ens36 (50)
lan to wan snat 
wan to lan/dmz dnat  



apt install iptables 

iptabeles -t nat -L
Pre-routing ==> dnat
POst-routing ==> snat
objective : perfoem SNAT 
sudo iptables -t nat -A POSTROUTING -o ens36 -j MASQUERADE 
iptabeles -t nat -L





























---------------------------



deb1 (jail)                         deb2 (attacker)
deb1 ip: 
iptables
fail2ban 


deb1
apt get install -y iptables python3-systemd fail2ban 

fail2ban-server --version 
systemctl status fail2ban.service (failed)  


instaed of making changes in fail2ban config file 
create /etc/fail2ban/jail.local
vi /etc/fail2ban/jail.local
    [sshd]
    jail.local
    backend = systemd
    enabled = true 
    port = 22
    filter = sshd
    maxretry =3 
    bantime = 3600
    findtime = 600 
:wq
systemctl restart fail2ban.service
systemctl start fail2ban.service
sudo fail2ban-client status
sudo fail2ban-client status sshd 


iptables -L 
watch 
from another attacj now ente wrong pass three timesn 
iptables -L   


