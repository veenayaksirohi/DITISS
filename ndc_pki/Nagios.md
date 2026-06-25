\*\*\*



\## Nagios — Architecture Overview



\*\*Nagios\*\* is an open-source IT infrastructure \*\*monitoring tool\*\* used to monitor systems, networks, and services. It alerts administrators when something goes wrong and when it recovers.



\*\*\*



\## Nagios Architecture Diagram (Fixed)



```

\&#x20;┌─────────────────────────────────────┐

\&#x20;│          Nagios Core                │

\&#x20;│  (Scheduler + Monitoring Engine)    │

\&#x20;└────────────────┬────────────────────┘

\&#x20;                 │  executes

\&#x20;                 ▼

\&#x20;┌─────────────────────────────────────┐

\&#x20;│         Apache Web Server           │

\&#x20;│  (Web UI — nagios/index.php)        │

\&#x20;└────────────────┬────────────────────┘

\&#x20;                 │  displays results via

\&#x20;                 ▼

\&#x20;┌─────────────────────────────────────┐

\&#x20;│         Nagios Plugins              │

\&#x20;│  check\\\_cpu / check\\\_mem /            │

\&#x20;│  check\\\_procs / check\\\_disk /         │

\&#x20;│  check\\\_http / check\\\_ping ...        │

\&#x20;└────────────────┬────────────────────┘

\&#x20;                 │  monitors

\&#x20;                 ▼

\&#x20;┌─────────────────┬───────────────────┐

\&#x20;│   Services      │   Hosts           │

\&#x20;│  (HTTP, SSH,    │  (Servers, PCs,   │

\&#x20;│   FTP, DB...)   │   Routers...)     │

\&#x20;└─────────────────┴───────────────────┘

```



\*\*\*



\## Component-by-Component Breakdown



\### Nagios Core

The \*\*heart of Nagios\*\* — it is the main scheduling and monitoring daemon: \[assets.nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/plugins.html)

\- Schedules \*\*when\*\* to run each check

\- Processes plugin \*\*return codes\*\* (OK / WARNING / CRITICAL / UNKNOWN)

\- Sends \*\*alert notifications\*\* (email, SMS) when thresholds are breached

\- Maintains state history and downtime records



\### Apache Web Server

Nagios uses \*\*Apache (httpd)\*\* to serve its web-based dashboard: \[scribd](https://www.scribd.com/document/702329825/Install-Nagios-Core)

\- Accessible via browser at `http://<server-ip>/nagios`

\- Shows real-time status of all monitored hosts and services

\- Uses \*\*CGI scripts\*\* to communicate between the web UI and Nagios Core



\### Nagios Plugins

Plugins are the \*\*actual workers\*\* — they perform the real checks: \[assets.nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/plugins.html)

\- Are \*\*separate executables/scripts\*\* (Bash, Python, Perl, PHP etc.)

\- Nagios Core calls them on schedule and reads their \*\*exit code + output\*\*

\- Return one of four states:



| Exit Code | Status | Meaning |

|---|---|---|

| `0` | ✅ OK | Service is working fine |

| `1` | ⚠️ WARNING | Threshold approaching |

| `2` | ❌ CRITICAL | Service is down/failed |

| `3` | ❓ UNKNOWN | Check could not determine status |



\*\*\*



\## Key Plugins: CPU / Processes / Memory



These are the most common system-level checks: \[nagios-plugins](https://nagios-plugins.org/doc/man/check\_procs.html)



| Plugin | What It Checks |

|---|---|

| `check\\\_cpu` | CPU usage percentage |

| `check\\\_mem` | RAM usage (free/used) |

| `check\\\_procs` | Number of running processes |

| `check\\\_disk` | Disk space usage |

| `check\\\_http` | Web server availability |

| `check\\\_ping` | Host reachability (ICMP) |

| `check\\\_ssh` | SSH port availability |





\*\*\*



\## Plugin Abstraction — Why It Matters



Plugins act as an \*\*abstraction layer\*\* between Nagios Core and the actual services being monitored. This means: \[assets.nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/plugins.html)

\- Nagios Core \*\*doesn't care\*\* how a check is done

\- Plugins can be written in \*\*any language\*\*

\- Community plugins available at \*\*Nagios Exchange\*\* (`exchange.nagios.org`) — hundreds of ready-made plugins for everything from AWS to Docker to Cisco routers \[nagios-plugins](https://nagios-plugins.org)



\*\*\*



\## Your Corrected Original Notes (Clean Version)



```

Nagios Architecture

│

├── Nagios Core          ← Scheduling + Alert Engine

│

├── Apache               ← Web UI (Dashboard)

│

├── Nagios Plugins       ← Actual check executables

│     ├── check\\\_cpu

│     ├── check\\\_mem      ← Memory monitoring

│     ├── check\\\_procs    ← Process monitoring

│     └── check\\\_disk

│

└── Monitored Targets    ← Hosts, Services, Network Devices

```

``````````````````````````````````````````````````````````lab

chabe host name 



give statios ip to data , out of dhcp scope 



fix date 



instal dependencies

sudo apt-get install -y \\

&#x20; apache2 \\

&#x20; apache2-utils \\

&#x20; autoconf \\

&#x20; gcc \\

&#x20; libc6 \\

&#x20; libgd-dev \\

&#x20; make \\

&#x20; php \\

&#x20; python3 \\

&#x20; tree \\

&#x20; unzip \\

&#x20; wget \\

&#x20; libkrb5-dev \\

&#x20; openssl \\

&#x20; libssl-dev

download  nagios source code 
cd /tmp

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.5.10.tar.gz

tar xzf nagioscore.tar.gz
extarch and unzip (tar -zxf)

chek the config 

sudo ./configure --with-httpd-conf=/etc/apeach2/sites/enables





sudo make all
make install-groups-users


sudo passwd nagios


usermod -a -G nagios www-data


INSTALL THE BINARY  
make install

VERY IT ls -l /etc/local/nagions ls -l /etc/local/nagions/bin







make install-daemoninit 

make install-commandmode to on the plugins 


make install-config  this config files to ls -l /etc/local/nagions/etc





make install-webconf  bing the nagio.cong to the /etc/apache/siteebale/

a2enmod rewrite

a2enmod cgi

sudo htpasswd -c /usr/local/nigios/etc/htpasswd.users nagiousadmin



nrgios -v config 



sudo  /usr/local/nigios/bin/nagios -v  /usr/local/nigios/etc/nagios.


systemctl restart apache2.service

systemctl start nagios.service



