An **HTTP Proxy** is an intermediary server between a **client (browser/user)** and a **web server**.

Instead of connecting directly to the website:

```text
Client  →  Proxy Server  →  Website
```

The proxy receives the request, forwards it to the destination server, gets the response, and sends it back to the client.

---

# Basic Working

## Without Proxy

```text
Browser  ─────► Website
```

## With HTTP Proxy

```text
Browser ─► Proxy ─► Website
          ◄───────
```

---

# What an HTTP Proxy Does

| Function         | Description                              |
| ---------------- | ---------------------------------------- |
| Forward Requests | Sends client requests to websites        |
| Hide IP Address  | Website sees proxy IP instead of user IP |
| Filtering        | Blocks websites/content                  |
| Monitoring       | Logs traffic                             |
| Caching          | Stores webpages for faster loading       |
| Security         | Inspects traffic                         |

---

# Types of HTTP Proxies

| Type                       | Purpose                       |
| -------------------------- | ----------------------------- |
| Forward Proxy              | Used by clients/users         |
| Reverse Proxy              | Used by servers/websites      |
| Transparent Proxy          | User may not know it exists   |
| Anonymous Proxy            | Hides user IP                 |
| Elite/High Anonymous Proxy | Hides both IP and proxy usage |

---

# Forward Proxy

Used by users inside a network.

Example:

```text
Employee PC → Company Proxy → Internet
```

Purpose:

* Monitoring employees
* Blocking websites
* Logging traffic

---

# Reverse Proxy

Placed in front of web servers.

```text
Client → Reverse Proxy → Web Server
```

Used for:

* Load balancing
* SSL termination
* DDoS protection
* Caching

Common reverse proxy software:

* Nginx
* HAProxy
* Cloudflare

---

# HTTP Proxy vs HTTPS Proxy

| Feature         | HTTP | HTTPS     |
| --------------- | ---- | --------- |
| Encryption      | No   | Yes       |
| Secure          | No   | Yes       |
| Port            | 80   | 443       |
| Traffic Visible | Yes  | Encrypted |

---

# HTTP CONNECT Method

For HTTPS websites, proxy usually uses:

```http
CONNECT example.com:443 HTTP/1.1
```

This creates a tunnel between client and server.

---

# Common Ports

| Service     | Port |
| ----------- | ---- |
| HTTP Proxy  | 8080 |
| Squid Proxy | 3128 |
| HTTP        | 80   |
| HTTPS       | 443  |

---

# Common Proxy Headers

| Header          | Meaning            |
| --------------- | ------------------ |
| X-Forwarded-For | Original client IP |
| Via             | Proxy information  |
| Forwarded       | Proxy chain info   |

Example:

```http
X-Forwarded-For: 192.168.1.10
```

---

# Proxy vs VPN

| Proxy                    | VPN                   |
| ------------------------ | --------------------- |
| Usually browser/app only | Entire device traffic |
| May not encrypt          | Encrypts traffic      |
| Faster                   | Slightly slower       |
| Simpler                  | More secure           |

---

# Popular Proxy Tools

| Tool          | Purpose                  |
| ------------- | ------------------------ |
| Burp Suite    | Web testing/interception |
| OWASP ZAP     | Security testing         |
| Squid         | Proxy server             |
| Charles Proxy | Debugging                |
| Fiddler       | HTTP inspection          |

---

# Example Request Flow

```http
GET /index.html HTTP/1.1
Host: example.com
```

Flow:

```text
Browser
   ↓
Proxy Server
   ↓
example.com
```

---

# Advantages

* Privacy
* Access control
* Monitoring
* Caching
* Content filtering

---

# Disadvantages

* Can log traffic
* Slower sometimes
* HTTP proxies are insecure
* Proxy misconfiguration risks

---

# In Cyber Security

HTTP proxies are heavily used for:

| Use                 | Example             |
| ------------------- | ------------------- |
| Intercept Requests  | Modify headers      |
| Security Testing    | Capture traffic     |
| Debugging APIs      | Inspect requests    |
| Bypass Restrictions | Route traffic       |
| Malware Analysis    | Monitor connections |

---

# Simple Real-Life Analogy

Think of a proxy like a **middleman receptionist**:

```text
You → Receptionist → Company
```

The company talks to the receptionist, not directly to you.
