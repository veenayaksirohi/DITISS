check wsl version ==> wsl -l -v
-arfv backup config file 

if service failed 
run manually 
sudo snort -A console -q -i eth0 -c /etc/snort/snort.conf

-q : quite mode (dont give detail )
-A : console 
-i : interface 

# Common Configuration Files Used in IDS/IPS Labs

| File / Path                        | Tool                   | Purpose                      | Common Usage                           |
| ---------------------------------- | ---------------------- | ---------------------------- | -------------------------------------- |
| `/etc/snort/snort.conf`            | Snort                  | Main Snort configuration     | HOME_NET, rule includes, preprocessors |
| `/etc/snort/rules/local.rules`     | Snort                  | Custom detection rules       | ICMP, Nmap, SSH alerts                 |
| `/etc/snort/snort.debian.conf`     | Snort                  | Debian/Ubuntu startup config | Interface selection (`eth0`)           |
| `/var/log/snort/alert`             | Snort                  | Alert log file               | View triggered alerts                  |
| `/var/log/snort/snort.log.*`       | Snort                  | Packet capture logs          | Traffic analysis                       |
| `/etc/snort/rules/community.rules` | Snort                  | Community ruleset            | Prebuilt attack signatures             |
| `/etc/iptables/rules.v4`           | iptables               | Firewall rules               | IPS blocking                           |

* It is suggested that take backup of snort.conf in case of DR
* $(command) ==> In linux called as sub shell execution 

* In entire network architecture Two type of network monitor (External_NET - can be single ip or network depending on organization) , (HOME_NET ) 
ipvar EXTERNAL_NET any   (any ==> 0.0.0.0/0)
HOME_NET ==> your local/internal network 
set ipvar HOME_any
Rule Path ==> `/etc/snort/rules/....`

snort can run in foreground and Backgroud 
Background as a Service => Alerts are stored as log  ==> snort -D

sudo snort -T -i eth0 -c /etc/snort/snort.conf

-T ==> test 
-i ==> interface 
eth0 ==> interface name 
-c ==> configuration file 

sed ==> commentts all community rules expect local rules 
after commneting now initially local rules is empty


1. rule header rule==>  action , protocol , sIP , sport, DIP , dport , netmask 
2. 

how to write rule :
<action> <>
100000==> community rules you can start your 

Rule Action 
alert 
log 
pass ==> ignore
drop  ==> block and log 
reject  ==> block , log , reset 
sdrop   ==> only block 



----------------------------------------------------------------------------------------------------------------------------------------------------------------
when packet detected 
1:1000001:0 ==> classification map 
Priority: 0 ==> bug priority 




ping ==> 4 pkt in windows
     ==> continous pkts in linux 
ping -c 1 `<ip>`


# Most Important Files For YOUR Current Snort Lab

| Priority | File                                   | Why Important             |
| ---------------- | ------------------------------ | ------------------------- |
| ⭐⭐⭐⭐⭐     | `/etc/snort/snort.conf`        | Main Snort engine config  |
| ⭐⭐⭐⭐⭐     | `/etc/snort/rules/local.rules` | Your custom IDS rules     |
| ⭐⭐⭐⭐       | `/etc/snort/snort.debian.conf` | Interface configuration   |
| ⭐⭐⭐⭐       | `/var/log/snort/alert`         | View generated alerts     |
| ⭐⭐⭐          | `/var/log/auth.log`            | SSH brute-force detection |
| ⭐⭐⭐          | `/etc/iptables/rules.v4`       | IPS-style blocking        |

---

# Important Snort Directories

| Directory           | Purpose               |
| ------------------- | --------------------- |
| `/etc/snort/`       | Main config directory |
| `/etc/snort/rules/` | Rule files            |
| `/usr/share/snort/` | Default rules/maps    |
| `/var/log/snort/`   | Logs and alerts       |



<!-- Check ping is working or not  -->
| Terminal   | System     | Command                                                     |
| ---------- | ---------- | ----------------------------------------------------------- |
| Terminal 1 | WSL Ubuntu | `sudo snort -A console -q -i eth0 -c /etc/snort/snort.conf` |
| Terminal 2 | WSL Ubuntu | `sudo tail -f /var/log/snort/snort.alert.fast`              |
| Terminal 3 | Kali Linux | `ping WSL_IP`                                               |

```

# Validate Snort files and all 

## 1. Rule Exists
cat /etc/snort/rules/local.rules

Must contain:
alert icmp any any -> $HOME_NET any (msg:"ICMP PING DETECTED"; sid:1000001; rev:1;)
           
## 2. Config Valid
sudo snort -T -i eth0 -c /etc/snort/snort.conf

## 3. Snort Running
sudo systemctl status snort
```

# Simple Flow

Kali Sends Ping
       ↓
WSL Ubuntu Receives Traffic
       ↓
Snort Detects ICMP
       ↓
Alert Generated





| `/etc/suricata/suricata.yaml`      | Suricata               | Main Suricata config         | Interface, logging, IPS mode           |
| `/etc/suricata/rules/*.rules`      | Suricata               | Detection rules              | Attack signatures                      |
| `/var/log/suricata/fast.log`       | Suricata               | Fast alert logs              | Quick alert monitoring                 |
| `/var/log/suricata/eve.json`       | Suricata               | JSON event logs              | SIEM integration                       |

| `/etc/network/interfaces`          | Linux Networking       | Network interface config     | Static IP configuration                |
| `/etc/netplan/*.yaml`              | Ubuntu                 | Modern network config        | IP/interface setup                     |
| `/etc/hosts`                       | Linux                  | Local hostname mapping       | Lab hostname resolution                |
| `/etc/resolv.conf`                 | Linux                  | DNS configuration            | DNS troubleshooting                    |

| `/etc/ufw/ufw.conf`                | Uncomplicated Firewall | UFW config                   | Firewall enable/disable                |
| `/etc/fail2ban/jail.conf`          | Fail2Ban               | Ban policies                 | SSH brute-force blocking               |
| `/var/log/auth.log`                | Linux                  | Authentication logs          | SSH attack analysis                    |
| `/var/log/syslog`                  | Linux                  | System logs                  | General troubleshooting                |
| `/etc/rsyslog.conf`                | rsyslog                | Log forwarding config        | Centralized logging                    |
| `/etc/tcpdump.conf`                | tcpdump                | Packet capture settings      | Traffic monitoring                     |
| `/etc/wireshark/`                  | Wireshark              | Wireshark configs            | Packet inspection                      |
| `/etc/nmap/nmap-service-probes`    | Nmap                   | Service fingerprinting       | Scan tuning                            |
| `/etc/ssh/sshd_config`             | OpenSSH                | SSH server settings          | Secure remote access                   |
| `/etc/apache2/apache2.conf`        | Apache HTTP Server     | Web server config            | HTTP attack labs                       |
| `/etc/nginx/nginx.conf`            | NGINX                  | Nginx config                 | Reverse proxy labs                     |

---


