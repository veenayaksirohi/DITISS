## 🧠 Wireshark (Simple Notes)

### 📌 What is Wireshark?

**Wireshark** is a **network packet analyzer tool** used to capture and inspect data traveling over a network in real time.

👉 It helps you see:

- What data is being sent and received
- Which devices are communicating
- What protocols are used (HTTP, DNS, TCP, etc.)

\---

## 🎯 Uses of Wireshark

- Network troubleshooting
- Cybersecurity analysis
- Detecting suspicious traffic
- Learning networking protocols
- Packet inspection and debugging

\---

## 📦 PCAP (Packet Capture Libraries)

**PCAP** is a library used to capture network packets.

### Common Packet Capture Libraries

- **libpcap** → Used in **Linux**
- **Npcap** → Used in **Windows** (modern, replaces WinPcap)
- **WinPcap** → Old Windows version, now mostly replaced by Npcap
- **AirPcap** → Used for **wireless packet capture** in some older setups

\---

## 🖥️ What is an Interface?

An **interface** is a connection point that allows a device to send and receive network data. It's the network device from which Wireshark captures traffic.

### Examples of Interfaces:

- **Ethernet adapter**
- **Wi-Fi adapter**
- **Loopback interface** (`localhost`)
- **Virtual network adapter**

### Simple Meaning:

**Interface = the place where Wireshark listens to network traffic**

\---

## 📑 Main Windows in Wireshark

### 1\. Packet List

- Shows all captured packets
- Each line represents one packet
- Displays: Source, Destination, Protocol, Time, and Info

### 2\. Packet Details

- Shows the selected packet in a structured, hierarchical form
- Displays layers like:
  - **Ethernet** (Layer 1/2)
  - **IP** (Layer 3)
  - **TCP/UDP** (Layer 4)
  - **Application Layer** (Layer 7)

### 3\. Packet Bytes

- Shows the raw packet data
- Displayed in:
  - **Hexadecimal** (hex view)
  - **ASCII** (text view)

\---

## 🔍 Filters in Wireshark

| Filter Type        | When to Use                                                       |
| ------------------ | ----------------------------------------------------------------- |
| **Capture Filter** | Set **before** capturing (limits what is captured)                |
| **Display Filter** | Use **before, during, or after** capturing (filters what you see) |

### Expression Builder

- Use the **Expression Builder** to create complex filters
- Click the **"Edit"** button in the filter bar to build expressions

\---

## 🧑‍🔧 TCPdump (Father of Wireshark)

**TCPdump** is the command-line packet analyzer that inspired Wireshark (Wireshark is essentially the GUI version of tcpdump).

### Installation \& Testing

```bash
# Check if tcpdump is installed
sudo tcpdump

# List all available interfaces
sudo tcpdump -D
```

### Basic tcpdump Commands

```bash
# Capture on interface e0
sudo tcpdump -i e0

# Capture TCP packets only on interface e0
sudo tcpdump -i e0 tcp

# Capture UDP packets only on interface e0
sudo tcpdump -i e0 udp

# Capture only 2 packets (count limit)
sudo tcpdump -i e0 -c 2

# Don't do name resolution (show IPs instead)
sudo tcpdump -i e0 -c 2 -n

# Save capture to file (binary format)
sudo tcpdump -i e0 -c 2 -n -w hello.world

# Read capture from file
sudo tcpdump -i e0 -c 2 -n -r hello.world
```

⚠️ **Note:** The `.world` file is **binary** — you cannot use `cat` to view it.

\---

## 🎯 TCPdump Filter Examples

### By Host (IP Address)

```bash
# Host going to AND from this IP (bidirectional)
tcpdump host x.x.x.x

# Host sending TO this IP (destination)
tcpdump dst host x.x.x.x

# Host sending FROM this IP (source)
tcpdump src host x.x.x.x

# Network range (e.g., x.x.x.0/24)
tcpdump net x.x.x.0/24
```

### By Port

```bash
# Specific port (e.g., SSH = 22)
tcpdump port 22

# Port range
tcpdump portrange 22-15
```

### Complex Filters (with `-i`)

```bash
# Combine multiple conditions (AND/OR)
tcpdump -i e0 '((tcp) and (port 80) and (dst host x.x.x.254)) or (dst host x.x.x.200)'

# OR condition between two hosts
tcpdump host x.x.x.1 or host x.x.x.2
```
