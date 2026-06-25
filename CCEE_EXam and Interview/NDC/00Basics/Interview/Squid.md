# Squid Proxy Server

**Squid** is a **proxy server** and **web caching server** that sits between a client (user) and the internet. It receives requests from clients, processes them, and forwards them to the destination server. It can also store (cache) frequently accessed web pages to improve speed and reduce bandwidth usage.

---

## Definition

> **Squid is an open-source proxy server used for web caching, internet access control, bandwidth optimization, and content filtering.**

It mainly supports:

* HTTP
* HTTPS (with configuration)
* FTP

---

## How Squid Works

```text
           Request
+--------+ -------> +---------------+ -------> +----------------+
| Client |          | Squid Proxy   |          | Web Server      |
+--------+ <------- +---------------+ <------- +----------------+
           Response        ^
                            |
                     Cache Storage
```

### Step-by-Step

1. Client requests a website.
2. Request goes to the Squid server.
3. Squid checks if the page is already in its cache.
4. If found (Cache Hit), Squid returns the cached copy.
5. If not found (Cache Miss), Squid fetches it from the internet.
6. Squid sends the response to the client and stores it in cache for future requests.

---

## Why Use Squid?

### 1. Web Caching

* Stores frequently visited websites.
* Faster loading times.
* Saves internet bandwidth.

Example:

* Student A opens `www.example.com`.
* Squid downloads it.
* Student B opens the same site.
* Squid serves it from cache.

---

### 2. Access Control

Allows administrators to:

* Block websites
* Allow only specific websites
* Restrict internet access based on users or IP addresses

Example:

```
Allow:
www.google.com

Block:
facebook.com
youtube.com
```

---

### 3. Bandwidth Saving

Since cached content isn't downloaded repeatedly:

* Less internet usage
* Faster browsing

---

### 4. Logging

Squid records:

* Visited websites
* Time of access
* Client IP
* Data transferred

Useful for monitoring users.

---

### 5. Security

Acts as a middle layer between users and the internet.

Can:

* Hide internal IP addresses
* Filter malicious websites
* Restrict unwanted traffic

---

# Types of Proxy

## 1. Forward Proxy (Most Common)

```
Client
   |
   v
Squid Proxy
   |
Internet
```

* Used by organizations
* Controls users' internet access

---

## 2. Reverse Proxy

```
Internet
    |
    v
Squid
    |
Web Server
```

Used to:

* Protect web servers
* Cache server responses
* Balance traffic

---

# Cache Hit vs Cache Miss

### Cache Hit

```
Client --> Squid --> Cache
               |
            Found
               |
           Response
```

Fast response.

---

### Cache Miss

```
Client --> Squid
             |
        Cache Empty
             |
        Internet
             |
        Store Cache
             |
          Response
```

Slower on first request.

---

# Advantages

| Advantage       | Description               |
| --------------- | ------------------------- |
| Faster browsing | Cached pages load quickly |
| Saves bandwidth | Downloads only once       |
| Access control  | Block or allow websites   |
| User monitoring | Logs internet usage       |
| Security        | Hides internal network    |
| Free            | Open source               |

---

# Disadvantages

| Disadvantage     | Description                          |
| ---------------- | ------------------------------------ |
| Initial setup    | Requires configuration               |
| Cache storage    | Needs disk space                     |
| HTTPS inspection | More complex to configure            |
| Cache updates    | May occasionally serve stale content |

---

# Common Uses

* Schools
* Colleges
* Offices
* Companies
* Cyber cafés
* ISPs
* Data centers

---

# Squid Configuration File

Main configuration file:

```bash
/etc/squid/squid.conf
```

---

# Important Squid Commands

### Install

```bash
sudo apt update
sudo apt install squid
```

### Start

```bash
sudo systemctl start squid
```

### Stop

```bash
sudo systemctl stop squid
```

### Restart

```bash
sudo systemctl restart squid
```

### Enable at Boot

```bash
sudo systemctl enable squid
```

### Check Status

```bash
sudo systemctl status squid
```

### Test Configuration

```bash
sudo squid -k parse
```

### Reload Configuration

```bash
sudo squid -k reconfigure
```

---

# Default Port

```
3128
```

Clients connect to Squid using this port unless it is changed.

---

# Example Network

```
           Internet
               |
         +-------------+
         | Squid Proxy |
         +-------------+
          /           \
         /             \
   Client 1        Client 2
```

Both clients access the internet through the Squid proxy.

---

# Summary

| Feature      | Squid                                                |
| ------------ | ---------------------------------------------------- |
| Type         | Proxy and Web Cache Server                           |
| License      | Open Source                                          |
| Default Port | 3128                                                 |
| Config File  | `/etc/squid/squid.conf`                              |
| Main Purpose | Proxy, caching, filtering, access control            |
| Supports     | HTTP, HTTPS, FTP                                     |
| Benefits     | Faster browsing, bandwidth saving, security, logging |

### Exam Definition (2–5 Marks)

> **Squid is an open-source proxy and web caching server that improves web access performance by caching frequently requested content. It also provides internet access control, bandwidth optimization, user activity logging, and content filtering, making it widely used in organizations, schools, and enterprises.**
