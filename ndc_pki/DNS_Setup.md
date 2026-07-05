# BIND DNS Server Documentation

## Overview

This document describes the configuration of a BIND9 DNS server hosted on a Linux system with hostname `DNS` and IP address `192.168.80.10/24`. The server is configured to use itself as the resolver through `/etc/resolv.conf`, where the nameserver is set to `192.168.80.10`. The setup includes forward zones for `example.com` and `lab.local`, along with the default local and reverse zones shown in the BIND configuration.

## Installation

Install BIND9 and the related DNS utilities using `apt`:

```bash
sudo apt update
sudo apt install bind9 bind9utils bind9-doc dnsutils -y
```

- `bind9` — the core DNS server (`named`) and its service unit.
- `bind9utils` — provides `named-checkconf`, `named-checkzone`, and `rndc`.
- `bind9-doc` — local documentation and man pages for BIND.
- `dnsutils` — provides `dig` and `nslookup` for testing queries.

After installation, enable and start the service:

```bash
sudo systemctl enable bind9
sudo systemctl start bind9
```

## System Details

The server uses interface `ens33` with IPv4 address `192.168.80.10/24` and loopback interface `lo` with `127.0.0.1/8`. The `/etc/hosts` file maps `127.0.0.1` to `localhost` and `127.0.1.1` to the hostname `DNS`. The resolver configuration sets both the domain and search suffix to `localdomain` and points DNS queries to the local BIND server.

## Resolver Configuration

The resolver file `/etc/resolv.conf` contains the following effective settings:

```conf
domain localdomain
search localdomain
nameserver 192.168.80.10
```

This means the machine sends DNS lookups to its own BIND service running on `192.168.80.10`.

## BIND Configuration Files

The main BIND configuration file is located at `/etc/bind/named.conf`, which includes three other files:

```conf
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/etc/bind/named.conf.default-zones";
```

This modular structure separates global options, custom local zones, and default zone definitions.

## Global Options

Located at `/etc/bind/named.conf.options`, the active options section is configured as follows:

```conf
options {
    directory "/var/cache/bind";
    dnssec-validation auto;
    listen-on-v6 { any; };
};
```

This sets BIND's working directory to `/var/cache/bind`, enables automatic DNSSEC validation, and allows the service to listen on IPv6 interfaces.

## Default Zones

The server keeps the standard default BIND zones for root hints, localhost, loopback reverse mapping, and broadcast-related reverse zones. These include `localhost`, `127.in-addr.arpa`, `0.in-addr.arpa`, and `255.in-addr.arpa`. The configuration also includes empty reverse zones such as `10.in-addr.arpa` and `168.192.in-addr.arpa` using `/etc/bind/db.empty`.

## Custom Forward Zones

Two custom master zones are defined in `/etc/bind/named.conf.local`:

```conf
zone "example.com" {
    type master;
    file "/etc/bind/db.example.com";
};

zone "lab.local" {
    type master;
    file "/etc/bind/db.lab.local";
};
```

These declarations make this server authoritative for both `example.com` and `lab.local`.

## Zone File: example.com

Located at `/etc/bind/db.example.com`, this zone file defines `ns1.example.com` as the authoritative name server and maps the domain and `www` host to `192.168.80.1`.

```conf
$TTL 86400
@   IN  SOA ns1.example.com. admin.example.com. (
            2024123001 ; Serial
            3600       ; Refresh
            1800       ; Retry
            1209600    ; Expire
            86400 )    ; Minimum TTL

@   IN  NS  ns1.example.com.
ns1 IN  A   192.168.80.1

@   IN  A   192.168.80.1
www IN  A   192.168.80.1
```

This zone answers for the apex domain `example.com`, the host `www.example.com`, and the name server `ns1.example.com`.

## Zone File: lab.local

Located at `/etc/bind/db.lab.local`, this zone file defines `ns1.lab.local` as the authoritative name server and maps the domain and `www` host to `192.168.80.2`.

```conf
$TTL 86400
@   IN  SOA ns1.lab.local.  admin.lab.local. (
            2024123001 ; Serial
            3600       ; Refresh
            1800       ; Retry
            1209600    ; Expire
            86400 )    ; Minimum TTL

@   IN  NS  ns1.lab.local.
ns1 IN  A   192.168.80.2

@   IN  A   192.168.80.2
www IN  A   192.168.80.2
```

This makes the server authoritative for `lab.local`, `www.lab.local`, and `ns1.lab.local` according to the configured zone data.

## Important Observation

The machine IP address is `192.168.80.10`, but the `A` records in the custom zone files point to `192.168.80.1` and `192.168.80.2`. That is valid if those records are intended to resolve to other hosts, but it is not correct if the DNS server itself is supposed to host `ns1.example.com` or `ns1.lab.local` on its own address. In that case, the `A` records should be updated to `192.168.80.10` and the zone serial should be incremented before reloading BIND.

## Suggested Validation Commands

Use these commands to validate and test the DNS configuration:

```bash
sudo named-checkconf
sudo named-checkzone example.com /etc/bind/db.example.com
sudo named-checkzone lab.local /etc/bind/db.lab.local
sudo systemctl restart bind9
sudo systemctl status bind9
```

For query testing:

```bash
dig @192.168.80.10 example.com
dig @192.168.80.10 www.example.com
dig @192.168.80.10 lab.local
dig @192.168.80.10 www.lab.local
nslookup example.com 192.168.80.10
```

These commands help confirm that the configuration syntax is valid, zones load correctly, and queries return the expected records.

## Troubleshooting Notes

If the server does not answer queries, check whether the `bind9` service is running and whether the firewall allows DNS traffic on port 53 over UDP and TCP. If zone changes are made, increment the SOA serial number before restarting or reloading the service. The `rndc.key` file returned a permission denied error during `cat *`, which is expected for non-root users and does not by itself indicate a DNS problem.

## File Summary

| File                           | Purpose                                                                      |
| ------------------------------ | ---------------------------------------------------------------------------- |
| `/etc/resolv.conf`             | Makes the system use `192.168.80.10` as its DNS resolver.                    |
| `/etc/hosts`                   | Defines local hostname mappings for `localhost` and `DNS`.                   |
| `/etc/bind/named.conf`         | Main BIND configuration file that includes modular configuration files.      |
| `/etc/bind/named.conf.options` | Stores global BIND options such as DNSSEC validation and listening behavior. |
| `/etc/bind/named.conf.local`   | Stores custom forward zone declarations for `example.com` and `lab.local`.   |
| `/etc/bind/db.example.com`     | Zone database for `example.com`.                                             |
| `/etc/bind/db.lab.local`       | Zone database for `lab.local`.                                               |

## Deployment Steps

1. Install BIND9 on the Linux server: `sudo apt update && sudo apt install bind9 bind9utils bind9-doc dnsutils -y`.
2. Configure the host with a static IP address, here `192.168.80.10/24` on `ens33`.
3. Point `/etc/resolv.conf` to the local DNS server using `nameserver 192.168.80.10`.
4. Define zone declarations in `/etc/bind/named.conf.local`.
5. Create the forward zone files `/etc/bind/db.example.com` and `/etc/bind/db.lab.local` with the required SOA, NS, and A records.
6. Validate the configuration with `named-checkconf` and `named-checkzone`.
7. Restart BIND9 and test resolution using `dig` or `nslookup`.

## Notes for Practical Use

For a lab setup, this configuration is enough to demonstrate authoritative DNS for private domains. For production-style setups, add reverse zones, configure proper forwarders if internet resolution is needed, restrict recursion as required, and maintain accurate serial numbers in every zone file after changes.

---

## Reverse Zone Configuration

A reverse zone maps IP addresses back to hostnames using **PTR records**. For the subnet `192.168.80.0/24`, the reverse zone name is `80.168.192.in-addr.arpa` — the network portion of the IP reversed and suffixed with `.in-addr.arpa`.

### Step 1: Declare the Zone in `named.conf.local`

Open the local config file:

```bash
sudo nano /etc/bind/named.conf.local
```

Add this block at the bottom:

```conf
zone "80.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.80";
};
```

### Step 2: Create the Reverse Zone File

```bash
sudo nano /etc/bind/db.192.168.80
```

Paste this content:

```conf
$TTL 86400
@   IN  SOA ns1.example.com. admin.example.com. (
            2024123001 ; Serial
            3600       ; Refresh
            1800       ; Retry
            1209600    ; Expire
            86400 )    ; Minimum TTL

@   IN  NS  ns1.example.com.

; PTR Records — last octet only
10  IN  PTR DNS.localdomain.
1   IN  PTR ns1.example.com.
2   IN  PTR ns1.lab.local.
```

Here, `10` maps `192.168.80.10` → `DNS.localdomain`, `1` maps `192.168.80.1` → `ns1.example.com`, and `2` maps `192.168.80.2` → `ns1.lab.local`.

### Step 3: Validate and Restart

```bash
# Check main config syntax

sudo named-checkconf

# Check the reverse zone file

sudo named-checkzone 80.168.192.in-addr.arpa /etc/bind/db.192.168.80

# Restart BIND

sudo systemctl restart bind9
sudo systemctl status bind9
```

### Step 4: Test the Reverse Zone

```bash
# Reverse lookup for the DNS server itself

dig @192.168.80.10 -x 192.168.80.10

# Reverse lookup for another host

dig @192.168.80.10 -x 192.168.80.1

# Using nslookup

nslookup 192.168.80.10 192.168.80.10
```

A successful response will show `10.80.168.192.in-addr.arpa. → DNS.localdomain.` for the first query.

### PTR Record Mapping

| IP Address      | Last Octet (used in zone file) | PTR maps to        |
| --------------- | ------------------------------ | ------------------ |
| `192.168.80.10` | `10`                           | `DNS.localdomain.` |
| `192.168.80.1`  | `1`                            | `ns1.example.com.` |
| `192.168.80.2`  | `2`                            | `ns1.lab.local.`   |

> **Important:** PTR target names must always end with a trailing dot (`.`) — this tells BIND it is an absolute FQDN, not relative to the zone.

### Updated File Summary

| File                         | Purpose                                                                        |
| ---------------------------- | ------------------------------------------------------------------------------ |
| `/etc/bind/named.conf.local` | Updated to include the reverse zone declaration for `80.168.192.in-addr.arpa`. |
| `/etc/bind/db.192.168.80`    | Reverse zone database containing PTR records for the `192.168.80.0/24` subnet. |
