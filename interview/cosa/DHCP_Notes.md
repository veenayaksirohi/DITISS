# DHCP (Dynamic Host Configuration Protocol) — Exam-Ready Notes
### CDAC DITISS — Networking / Linux OS & Security

---

## 1. What is DHCP?

**DHCP = Dynamic Host Configuration Protocol** — automatically gives network settings to devices, instead of manual configuration.

Manually you'd configure:
```text
IP address
Subnet mask
Default gateway
DNS server
```

With DHCP, this happens automatically:
```text
DHCP Server (Pool: 192.168.50.100 - 192.168.50.200)
        ↓
Laptop connects
        ↓
Gets:
IP      → 192.168.50.105
Gateway → 192.168.50.1
DNS     → 8.8.8.8
```

---

## 2. Why DHCP is Needed

Without DHCP, every device needs manual configuration:
```text
Laptop 1 → 192.168.50.10
Laptop 2 → 192.168.50.11
Laptop 3 → 192.168.50.12
```
For hundreds of devices, this is impractical and error-prone.

With DHCP:
```text
Device joins network → DHCP automatically gives configuration
```

---

## 3. DHCP Layer & Ports

- DHCP is an **Application Layer** protocol.
- Uses **UDP** — because the client may not even have an IP address yet (UDP doesn't require an established connection like TCP does).

| Device | Port |
|---|---|
| **DHCP Server** | UDP **67** |
| **DHCP Client** | UDP **68** |

**Easy memory:**
```text
Server → 67
Client → 68
```

> **Exam trap:** DHCP uses UDP, not TCP — because at the DISCOVER stage the client has no IP address, so it can't establish a TCP connection. UDP allows broadcast communication without a prior handshake.

---

## 4. Benefits of DHCP

| Benefit | Explanation |
|---|---|
| **Automation** | New device connects → gets IP automatically, no manual work |
| **Avoids IP conflicts** | Prevents accidentally assigning the same IP to two devices |
| **Efficient IP usage** | IPs given as time-limited **leases**; unused addresses get reclaimed and reused |
| **Mobility** | A laptop moving between Home → Office → College gets correct config automatically at each location |
| **Centralized management** | Gateway, DNS, domain, IP range, lease time — all configured once on the server |

---

## 5. Key DHCP Components

| Component | Meaning |
|---|---|
| **DHCP Server** | Machine that manages IP addresses (pool, gateway, DNS, lease duration, reservations) |
| **DHCP Client** | Any device requesting config — laptop, phone, desktop, printer, smart TV |
| **Scope** | The range of IPs DHCP can hand out, e.g. `192.168.50.100 – 192.168.50.200` |
| **Lease** | An IP given to a client for a specific time period, e.g. 2 hours |
| **Reservation** | A specific device (identified by MAC address) always gets the same IP — a.k.a. **MAC-to-IP binding** |
| **DHCP Options** | Extra config sent along with the IP — gateway, DNS, subnet mask, domain name |

**Reservation example:**
```text
Printer MAC: AA:BB:CC:11:22:33
Always gets: 192.168.50.50
```

---

## 6. DHCP DORA Process (Most Important!)

**DORA = Discover → Offer → Request → Acknowledge**

```text
CLIENT                         DHCP SERVER
   |                                |
   | ---- DHCPDISCOVER -----------> |
   |                                |
   | <---- DHCPOFFER -------------- |
   |                                |
   | ---- DHCPREQUEST ------------> |
   |                                |
   | <---- DHCPACK ---------------- |
   |                                |
Client now has IP
```

### Step 1 — DHCPDISCOVER
Client has **no IP** and **no known DHCP server**. It **broadcasts**:
```text
Client:68 → broadcast → Server:67
"Is there any DHCP server available?"
```

### Step 2 — DHCPOFFER
Server replies with an offer:
```text
"I can give you 192.168.50.101"
```
May include: IP address, subnet mask, gateway, DNS, lease time.

### Step 3 — DHCPREQUEST
Client accepts the offer:
```text
"I want 192.168.50.101"
```
This is commonly **broadcast** too, so all DHCP servers on the network know which offer was accepted (and the ones not chosen can withdraw their offers).

### Step 4 — DHCPACK
Server confirms:
```text
"Confirmed. You can use this IP."
```
Client now has: IP, Gateway, DNS, Lease time.

**Memory trick:**
```text
Discover → Find server
Offer    → Server offers IP
Request  → Client requests IP
ACK      → Server confirms IP
```

> **Exam trap:** DHCPREQUEST is typically **broadcast**, not unicast — this lets every DHCP server on the segment know which offer the client accepted, so the other servers can release their reserved offers back to their pools.

---

## 7. Other DHCP Messages

| Message | Meaning | Example Scenario |
|---|---|---|
| **DHCPNAK** | Negative Acknowledgement — server rejects the request | Client asks for an IP that's invalid, unavailable, or the client moved to a different subnet |
| **DHCPDECLINE** | Client rejects an offered IP because it's already in use | Client checks via **ARP**, finds the address occupied, sends DHCPDECLINE |
| **DHCPRELEASE** | Client gives back the IP when done with it | Client shuts down / disconnects → server can reuse the address |
| **DHCPINFORM** | Client already has a static IP but wants DHCP *options* (DNS, domain name, etc.) without requesting a new IP | Statically configured server that still wants DNS settings from DHCP |

```text
DHCPDECLINE flow:
Server offers 192.168.50.110
        ↓
Client checks using ARP
        ↓
Address already in use!
        ↓
Client sends DHCPDECLINE
```

> **Exam trap:** Don't confuse DHCPDECLINE (client refuses a specific offered IP because it's already taken) with DHCPNAK (server refuses the client's requested IP). One is client-initiated, the other server-initiated.

---

## 8. DHCP Lease Lifecycle

Suppose lease time = **8 hours**. The client does NOT wait for the full 8 hours to try renewing — it starts early.

| Stage | Timing | What Happens |
|---|---|---|
| **1. Initialization** | Boot | Client boots → runs DORA → gets IP (e.g. `192.168.50.110`) |
| **2. Normal Operation** | — | Client simply uses the assigned IP normally |
| **3. T1 (Renewal)** | ~**50%** of lease time (e.g. ~4 hrs of 8) | Client sends **unicast** DHCPREQUEST to the **original** DHCP server: "Can I continue using this IP?" |
| **4. T2 (Rebinding)** | ~**87.5%** of lease time | If original server didn't respond, client **broadcasts** DHCPREQUEST — now willing to accept help from ANY DHCP server |
| **5. Expiration** | 100% of lease time | If still no response, client **must stop using the IP** and restarts DORA from scratch |

```text
DORA → Get IP → Use IP
        ↓
    T1 = 50%  → try ORIGINAL server (unicast)
        ↓ (fail)
    T2 = 87.5% → try ANY server (broadcast)
        ↓ (fail)
    Lease expires → stop using IP → restart DORA
```

> **Exam trap:** T1 renewal is **unicast to the original server**; T2 rebinding is **broadcast to any server**. This distinction (who it talks to, and how) is a classic exam/viva question.

> **Memory trick:** T1 = "Talk to the one I know" (50%) → T2 = "Talk to anyone" (87.5%) → Expire = "Start over".

---

## 9. DHCP Server Configuration (RHEL-family)

### Step 1 — Give the DHCP Server a Static IP
A DHCP server should itself have a stable, unchanging address.
```bash
sudo nmcli connection modify "ens160" ipv4.addresses 192.168.50.5/24
sudo nmcli connection modify "ens160" ipv4.method manual
sudo nmcli connection down "ens160"
sudo nmcli connection up "ens160"
ip address show
```

### Step 2 — Install DHCP Server
```bash
sudo dnf update -y
sudo dnf install dhcp-server -y
```

### Step 3 — Configure `/etc/dhcp/dhcpd.conf`
```conf
default-lease-time 600;
max-lease-time 7200;

authoritative;

subnet 192.168.50.0 netmask 255.255.255.0 {
    range 192.168.50.100 192.168.50.200;
    option routers 192.168.50.1;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 8.8.8.8;
}
```

### Configuration Directive Breakdown

| Directive | Meaning |
|---|---|
| `default-lease-time 600;` | Default lease = 600 seconds = **10 minutes** |
| `max-lease-time 7200;` | Maximum lease = 7200 seconds = **2 hours** |
| `authoritative;` | "I am the authoritative DHCP server for this network" |
| `subnet 192.168.50.0 netmask 255.255.255.0` | Defines the network `192.168.50.0/24` |
| `range 192.168.50.100 192.168.50.200;` | The DHCP **pool** — addresses that can be handed out |
| `option routers 192.168.50.1;` | Tells clients their **default gateway** |
| `option subnet-mask 255.255.255.0;` | Tells clients their **subnet mask** |
| `option domain-name-servers 8.8.8.8;` | Tells clients their **DNS server** |

**Resulting client config:**
```text
IP       → 192.168.50.100 - 200 (from pool)
Mask     → 255.255.255.0
Gateway  → 192.168.50.1
DNS      → 8.8.8.8
Lease    → per configured settings
```

### Step 4 — Validate Configuration
```bash
sudo dhcpd -t
```
Checks `/etc/dhcp/dhcpd.conf` for syntax errors **before** restarting the service.

```text
Edit dhcpd.conf → dhcpd -t → No errors → Restart DHCP
```

### Step 5 — Bind DHCP to an Interface
File: `/etc/sysconfig/dhcpd`
```text
DHCPDARGS=ens160
```
Meaning: DHCP server should listen on interface `ens160`.

### Step 6 — Start the DHCP Server
```bash
sudo systemctl enable --now dhcpd
systemctl status dhcpd
```
`enable` = start automatically at boot; `--now` = start it immediately too.

### Step 7 — Firewall
```bash
sudo firewall-cmd --add-service=dhcp --permanent
sudo firewall-cmd --reload
```

---

## 10. Complete DHCP Architecture

```text
                   DHCP SERVER
                  192.168.50.5
                       |
              Pool configured:
          192.168.50.100 - 200
                       |
                  Network/Switch
                       |
          ┌────────────┼────────────┐
          ↓            ↓            ↓
       Laptop        Phone       Printer
         |             |             |
     .100-.200      .100-.200     .100-.200
```
Each device gets a unique address from the pool.

---

## 11. Best Practices

| Practice | Why |
|---|---|
| **DHCP server should have a static IP** | If the DHCP server's own IP changes, clients lose track of where to renew leases |
| **Don't overlap DHCP pool with statically assigned IPs** | Prevents IP conflicts between manually configured devices and the DHCP pool |
| **Avoid uncontrolled multiple DHCP servers** | Two independent DHCP servers (e.g. router's built-in DHCP + a Linux DHCP server) both answering DHCPDISCOVER causes unpredictable client configuration |

**Example of separating static vs. pool addresses:**
```text
Static (outside pool):
192.168.50.1  → Router
192.168.50.5  → DHCP server
192.168.50.10 → File server
192.168.50.20 → Printer

DHCP pool:
192.168.50.100 - 192.168.50.200
```

---

## 12. Quick Revision Table

| Term | Meaning |
|---|---|
| DHCP | Automatic network configuration |
| Server port | UDP 67 |
| Client port | UDP 68 |
| Scope | Range of available IPs |
| Lease | Temporary IP assignment |
| Reservation | Fixed IP for a specific MAC |
| Options | Gateway, DNS, mask, etc. |
| DORA | Discover, Offer, Request, ACK |
| T1 | Renewal at ~50% (unicast to original server) |
| T2 | Rebinding at ~87.5% (broadcast to any server) |
| `dhcpd.conf` | Main DHCP server config file |
| `dhcpd -t` | Validate configuration syntax |
| `dhcpd` | DHCP server service/daemon |

---

## 13. Viva / Interview Q&A

**Q1. Why does DHCP use UDP instead of TCP?**
A: Because at the DISCOVER stage the client has no IP address yet and cannot establish a TCP connection. UDP supports connectionless broadcast communication, which DHCP needs for its initial discovery step.

**Q2. What are the DHCP server and client port numbers?**
A: Server listens on UDP port 67; client uses UDP port 68.

**Q3. Explain the DORA process.**
A: Discover (client broadcasts to find a DHCP server) → Offer (server proposes an IP) → Request (client broadcasts acceptance of an offer) → Acknowledge (server confirms the lease).

**Q4. Why is DHCPREQUEST broadcast rather than unicast?**
A: So all DHCP servers on the network segment can see which offer was accepted — servers whose offers weren't chosen can release those reserved addresses back into their pools.

**Q5. What's the difference between DHCPNAK and DHCPDECLINE?**
A: DHCPNAK is sent by the *server* to reject a client's request (e.g. invalid IP or wrong subnet). DHCPDECLINE is sent by the *client* to refuse an offered IP because it detected (via ARP) that the address is already in use.

**Q6. What are T1 and T2 in the DHCP lease lifecycle?**
A: T1 (~50% of lease time) is when the client tries to renew the lease with a unicast request to the *original* DHCP server. T2 (~87.5% of lease time) is the rebinding stage, where the client broadcasts to *any* available DHCP server if the original server hasn't responded.

**Q7. What happens if a lease expires with no renewal?**
A: The client must stop using that IP address and restart the entire DORA process from scratch.

**Q8. What is a DHCP reservation, and how is it identified?**
A: A configuration that ensures a specific device always receives the same IP address, typically bound to the device's MAC address (MAC-to-IP binding).

**Q9. What's the difference between DHCP scope and DHCP lease?**
A: Scope is the overall range/pool of IPs the server can assign (e.g. `.100`–`.200`). Lease is the time-limited assignment of one specific IP from that scope to one client.

**Q10. When would a client send DHCPINFORM?**
A: When it already has a statically configured IP address but wants additional DHCP options (like DNS servers or domain name) without requesting a new IP lease.

**Q11. Why should the DHCP server itself have a static IP rather than getting one via DHCP?**
A: Clients need a stable, predictable address to reach the server for lease renewals; if the server's own IP kept changing, clients wouldn't reliably find it again.

**Q12. What risk arises from running multiple, uncoordinated DHCP servers on the same network?**
A: Clients may receive conflicting or unexpected configuration, since more than one server could respond to a DHCPDISCOVER broadcast — this is why intentional DHCP infrastructure design (e.g. disabling router DHCP if using a dedicated server) matters.

**Q13. What does the `authoritative;` directive do in `dhcpd.conf`?**
A: It tells the DHCP server to consider itself the authoritative source for that network, allowing it to actively send DHCPNAK for invalid/unknown lease requests from that subnet, rather than silently ignoring them.

---

### Summary Cheat-Sheet (30-second revision)

```text
Ports:     Server=UDP 67 | Client=UDP 68
DORA:      Discover → Offer → Request → ACK
Messages:  NAK=server rejects | DECLINE=client rejects (IP in use)
           RELEASE=client gives back | INFORM=client wants options only
Lease:     T1(50%)=unicast original server | T2(87.5%)=broadcast any server
           Expire=stop using IP, restart DORA
Config:    /etc/dhcp/dhcpd.conf → dhcpd -t (validate) → systemctl enable --now dhcpd
Key rule:  DHCP server needs a STATIC IP; keep pool separate from static assignments
```
