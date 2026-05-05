# 📘 Network Access Control (ACS, TACACS+, RADIUS)

## 1. For an Administrator:

Managing 100 routers one by one is a lot of work because you have to create and update usernames and passwords on each device separately.

## 2. Solution: Cisco ACS

To make this easier, Cisco ACS is used. It keeps all user accounts in one central place and also controls what each user is allowed to do.

Instead of checking login details locally, routers ask ACS to verify users. They communicate with ACS using two protocols:

a. TACACS+
b. RADIUS

---

# 3. ACS (Access Control Server)

**ACS - 1997 [Core protocols: RADIUS and TACACS+]**

Access Control Server (ACS) was a network access policy and identity management platform developed by Cisco Systems.

### 3.1 ACS Overview Table

| Attribute           | Description                                 |
| ------------------- | ------------------------------------------- |
| Full Name           | Access Control Server                       |
| Developed By        | Cisco Systems                               |
| Year                | 1997                                        |
| Function            | Network access policy & identity management |
| Protocols Supported | TACACS+ (TCP, Port 49), RADIUS [UDP , Port 1812 , 1813 ]           |

---

# 4. TACACS+

## 4.1 Definition

TACACS+ is an advanced AAA security protocol used to provide centralized control and monitoring access of network devices such as routers, switches, and firewalls.

TACACS+  (Terminal Access Controller Access-Control System Plus)
AAA =    Authentication, Authorization, and Accounting

**AAA** stands for:

* **Authentication** → Verifies *who the user is* (e.g., username/password, OTP)
* **Authorization** → Determines *what the user is allowed to do* (permissions, access level)
* **Accounting** → Tracks *what the user does* (logging, session records, usage monitoring)

In short:
👉 **AAA = Authentication + Authorization + Accounting**


---

## 4.2 Features of TACACS+

a. Cisco-developed protocol for AAA framework (used between Cisco devices and ACS server)  
b. Uses TCP as a transmission protocol (Port 49)  
c. Encrypts entire packet (not just password)  
d. Separates AAA into distinct elements  
e. Provides greater granular control (command-level authorization)  
f. Provides accounting support (less extensive than RADIUS)  

---

## 4.3 Advantages of TACACS+

a. Greater granular control than RADIUS (command-level control)  
b. Encrypts entire AAA packet  
c. Uses TCP → reliable communication  

---

## 4.4 Disadvantages of TACACS+

a. Cisco proprietary (though standardized in RFC 8907)  
b. Less extensive accounting support than RADIUS  

---

## 4.5 Working of TACACS+

**Step-by-step working:**

1. The client device (NAD/NAS) contacts the TACACS+ server for authentication
2. The server prompts for username and password via CONTINUE messages
3. User credentials are sent to the server
4. Server responds with:

   a. ACCEPT → valid credentials  
   b. REJECT → invalid credentials  
   c. ERROR → communication issue    
5. For authorization, the server returns permissions
6. For accounting, the client sends activity records and the server acknowledges

---

# 5. RADIUS

## 5.1 Definition

RADIUS is a security protocol used in the AAA framework to provide centralized authentication for users who want to gain access to the network.

RADIUS ==> Remote Authentication Dial-In User Service

---

## 5.2 Features of RADIUS

a. Open standard protocol (multi-vendor support)  
b. Uses UDP as transmission protocol  
c. Ports:  
   - 1812 → Authentication & Authorization  
   - 1813 → Accounting 
 
d. Encrypts only passwords (not full packet)  
e. Authentication and authorization are coupled  
f. No explicit command authorization  
g. Provides extensive accounting support  

---

## 5.3 Working of RADIUS

1. A device sends an access-request to the NAS (client)  
2. NAS forwards request to ACS server  
3. ACS validates credentials  
4. Server responds:  
   a. Access-Accept → valid credentials  
   b. Access-Reject → invalid credentials  

---

## 5.4 Advantages of RADIUS

a. Open standard → works with multiple vendors  
b. Extensive accounting support  
c. Centralized authentication and authorization  
d. Flexible user management  
e. Integration with other protocols (LDAP, Kerberos)  
f. Highly scalable  

## 5.5 Disadvantages of RADIUS
a. Uses UDP → less reliable than TCP  
b. No command-level authorization  
c. Encrypts only passwords (not full packet)  
d. Vulnerable to attacks (spoofing, replay, dictionary attacks)  
e. Lacks full encryption  
f. Complex configuration in large environments  
g. Possible compatibility issues  

# 6. TACACS+ vs RADIUS

| Feature               | TACACS+               | RADIUS                                  |
| --------------------- | --------------------- | --------------------------------------- |
| Transport Protocol    | TCP                   | UDP                                     |
| Port Number           | 49                    | 1812 / 1813                             |
| Encryption            | Full packet           | Password only                           |
| AAA Structure         | Fully separated       | Authentication & Authorization combined |
| Command Authorization | Supported             | Not supported                           |
| Accounting            | Limited               | Extensive                               |
| Vendor Support        | Cisco-centric         | Multi-vendor                            |
| Reliability           | High (TCP)            | Lower (UDP)                             |
| Use Case              | Device administration | Network access (Wi-Fi, VPN)             |

---

# 7. Summary

Cisco ACS simplifies network management through centralized AAA.

## 7.1 TACACS+ is best for:

a. Device administration
b. High security
c. Command-level control

## 7.2 RADIUS is best for:

a. Network access (Wi-Fi, VPN)
b. Multi-vendor environments
c. Scalable deployments

---

If you want, I can convert this into **exam notes, flashcards, or diagrams** for faster revision.
