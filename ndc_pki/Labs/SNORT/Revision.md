snort -i 1 -c C:\snort\etc\snort.conf -l C:\snort\log\ -A console

```
| Parameter | Meaning | Example |
|-----------|---------|---------|
| `snort` | Starts the Snort IDS program. | Runs the Snort executable. |
| `-i 1` | Specifies the network interface to monitor. `1` is the interface ID. | Monitor Interface #1 (find using `snort -W`). |
| `-c C:\snort\etc\snort.conf` | Specifies the configuration file to use. | Loads rules and settings from `snort.conf`. |
| `-l C:\snort\log\` | Specifies the directory where logs and alerts are stored. | Logs are saved in `C:\snort\log\`. |
| `-A console` | Specifies the alert mode. Displays alerts on the terminal. | Alerts appear immediately on the console. |
```

All changes + this one i want the kiwi 

output alert_syslog: host=192.168.129.135:514 LOG_AUTH LOG_ALERT




