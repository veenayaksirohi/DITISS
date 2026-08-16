---
title: "08 - Cyber Forensics Syllabus and Interview Checklist"
aliases:
  - "Cyber Forensics — CDAC DITISS Syllabus"
tags:
  - cyber-forensics
  - digital-forensics
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

# Cyber Forensics — Interview Checklist

**Duration:** 60 hrs (20T + 20L + 20SL) | **CCEE Module**
**Reference:** Guide to Computer Forensics and Investigations (Nelson); Digital Forensic (Dr. Nilakshi, Dr. Dhananjay)

---

## Completion Checklist

- [ ] Computer Forensics process & cyber laws overview
- [ ] File systems, metadata, timestamps
- [ ] Chain of custody & incident response
- [ ] Hexadecimal notation, hashing, hash collisions
- [ ] Standard Operating Procedures for crime scenes
- [ ] Forensic tools (FTK, Sysinternals, Hex editor)
- [ ] Live system & Linux forensics
- [ ] Intro to Mobile forensics

---

## 🔴 Priority 1 — Must Know

- [ ] Computer Forensics process — Preservation, Identification, Extraction, Documentation, Interpretation
- [ ] Chain of Custody — evidence checkout log, handling evidence
- [ ] File systems — FAT32 vs NTFS, MFT, slack space, unallocated space, file signatures
- [ ] Imaging — logical vs physical (bit-by-bit), live vs dead imaging, write blockers
- [ ] Hashing — MD5/SHA before & after imaging, hash collisions

## 🟠 Priority 2 — Important

- [ ] Windows Registry hives — SAM, SYSTEM, SOFTWARE, SECURITY, NTUSER.DAT
- [ ] Linux artifacts — /var/log, auth.log, bash_history, /proc
- [ ] Network forensics — Wireshark packet analysis, capture vs display filters
- [ ] Timestamps — created/modified/accessed, manipulation detection
- [ ] Forensic tools — FTK Imager, Sysinternals Suite, Hex editors

## 🟡 Priority 3 — Good to Know

- [ ] Live system forensics vs dead-box forensics
- [ ] Linux-specific artifact collection
- [ ] Introduction to Mobile forensics
- [ ] Common image formats — RAW/DD, E01, AFF

---

## 📌 Interview Favorite: File Deletion Myth

> "Deleting a file ≠ erasing data" — only the file table entry / pointer is removed; actual data remains in unallocated space until overwritten. This is a near-guaranteed forensics interview question.

## 📌 Imaging Types Quick Reference

| Type | Description | Use Case |
|---|---|---|
| Logical Imaging | Copies files/folders only | Quick, targeted evidence |
| Physical (Bit-by-Bit) | Copies every bit including deleted/slack space | Full forensic soundness |
| Live Imaging | Captures a running system's state | Volatile data, memory |
| Dead Imaging | System is powered off before imaging | Preserves evidence integrity |

---

## Related Notes
- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
- [[09 - Public Key Infrastructure Syllabus and Interview Checklist]]
