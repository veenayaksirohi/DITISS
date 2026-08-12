```bash

# change ip address to 192.168.110.3/24
> sudo nmcli connection modify "ens160" ipv4.method manual ipv4.address 192.168.110.3/24
> sudo nmcli connection down ens160
> sudo nmcli connection up ens160

```
