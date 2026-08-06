# Linux File Links — Hard Link vs Soft Link

---

## 1. How Linux Stores Files (Foundation Concept)

Before understanding links, you must understand **inode**.

```
  ┌─────────────────────────────────────────────────────────────────────┐
  │                     LINUX FILE SYSTEM STRUCTURE                     │
  │                                                                     │
  │   FILENAME          INODE                    DATA BLOCKS            │
  │   (Directory)       (Metadata)               (Actual Content)       │
  │                                                                     │
  │  ┌──────────┐      ┌─────────────────┐      ┌──────────────────┐   │
  │  │ file.txt │─────►│  inode #1234    │─────►│  Hello World     │   │
  │  └──────────┘      │                 │      │  (file data)     │   │
  │                    │  - file size    │      └──────────────────┘   │
  │                    │  - owner/group  │                              │
  │                    │  - permissions  │                              │
  │                    │  - timestamps   │                              │
  │                    │  - link count   │                              │
  │                    │  - data pointer │                              │
  │                    └─────────────────┘                              │
  │                                                                     │
  │   Filename ──► inode ──► Data Blocks                               │
  │                                                                     │
  │   > Filename is just a LABEL pointing to inode                     │
  │   > inode contains ALL metadata + pointer to actual data           │
  │   > inode does NOT store the filename                              │
  └─────────────────────────────────────────────────────────────────────┘
```

---

## 2. Hard Link

**Definition:** A hard link is a **second filename pointing to the SAME inode**.
Both the original file and the hard link share the **exact same inode number**.

```
  ┌─────────────────────────────────────────────────────────────────────┐
  │                        HARD LINK DIAGRAM                            │
  │                                                                     │
  │   FILENAMES              INODE                DATA BLOCKS           │
  │   (Directory)            (Metadata)           (Actual Content)      │
  │                                                                     │
  │  ┌──────────────┐                                                   │
  │  │ original.txt │──────┐                                           │
  │  └──────────────┘      │    ┌─────────────────┐   ┌─────────────┐ │
  │                         ├──►│   inode #1234   │──►│ Hello World │ │
  │  ┌──────────────┐      │    │  link count = 2 │   │ (file data) │ │
  │  │  hardlink.txt│──────┘    └─────────────────┘   └─────────────┘ │
  │  └──────────────┘                                                   │
  │                                                                     │
  │   Both names ──► SAME inode ──► SAME data                          │
  │                                                                     │
  │   > link count increases by 1 when hard link is created            │
  │   > Deleting original.txt → data still accessible via hardlink.txt │
  │   > Data is deleted ONLY when link count reaches 0                 │
  └─────────────────────────────────────────────────────────────────────┘
```

### What happens when original is deleted?

```
  BEFORE DELETE:
  ──────────────
  original.txt ──────┐
                      ├──► inode #1234 (link count=2) ──► "Hello World"
  hardlink.txt ──────┘

  AFTER DELETE original.txt:
  ──────────────────────────
  [original.txt removed]
                             inode #1234 (link count=1) ──► "Hello World"
  hardlink.txt ─────────────────────────────────────────────────────────►

  > Data is STILL SAFE — accessible via hardlink.txt
  > inode is deleted only when link count = 0
```

---

## 3. Soft Link (Symbolic Link / Symlink)

**Definition:** A soft link is a **separate file that stores the PATH of the original file**.
It has its **own inode** — it just contains a pointer (path) to the original.

```
  ┌─────────────────────────────────────────────────────────────────────┐
  │                       SOFT LINK DIAGRAM                             │
  │                                                                     │
  │   FILENAMES         INODES                  DATA BLOCKS             │
  │   (Directory)       (Metadata)              (Actual Content)        │
  │                                                                     │
  │  ┌──────────────┐   ┌─────────────────┐    ┌──────────────────┐    │
  │  │ original.txt │──►│  inode #1234    │───►│  Hello World     │    │
  │  └──────────────┘   │  link count = 1 │    │  (actual data)   │    │
  │          ▲          └─────────────────┘    └──────────────────┘    │
  │          │                                                           │
  │          │ (stores path: "/home/user/original.txt")                 │
  │          │                                                           │
  │  ┌──────────────┐   ┌─────────────────┐                            │
  │  │ softlink.txt │──►│  inode #5678    │                            │
  │  └──────────────┘   │  link count = 1 │                            │
  │                     │  type = symlink  │                            │
  │                     └─────────────────┘                            │
  │                                                                     │
  │   softlink.txt ──► its own inode ──► stores PATH ──► original.txt  │
  │                                                   ──► inode #1234  │
  │                                                   ──► "Hello World" │
  └─────────────────────────────────────────────────────────────────────┘
```

### What happens when original is deleted?

```
  BEFORE DELETE:
  ──────────────
  original.txt ──► inode #1234 ──► "Hello World"
       ▲
       │ (path stored)
  softlink.txt ──► inode #5678

  AFTER DELETE original.txt:
  ──────────────────────────
  [original.txt removed] ──► inode #1234 DELETED ──► data GONE

       ▲ (path stored — but target is gone!)
       │
  softlink.txt ──► inode #5678   ← DANGLING LINK ⚠️

  > softlink.txt now points to a NON-EXISTENT file
  > Accessing softlink.txt gives: "No such file or directory"
  > This is called a DANGLING / BROKEN symlink
```

---

## 4. Hard Link vs Soft Link — Side by Side

```
  ┌──────────────────────┬───────────────────────┬───────────────────────┐
  │  Feature             │  Hard Link            │  Soft Link (Symlink)  │
  ├──────────────────────┼───────────────────────┼───────────────────────┤
  │  Own inode?          │  NO (shares original) │  YES (new inode)      │
  │  inode number        │  SAME as original     │  DIFFERENT            │
  │  Points to           │  inode directly       │  PATH of original     │
  │  If original deleted │  Data still exists ✅ │  Broken link ❌       │
  │  Cross filesystem    │  ❌ NOT allowed        │  ✅ Allowed           │
  │  Link directories    │  ❌ NOT allowed        │  ✅ Allowed           │
  │  File size shown     │  Same as original     │  Size of path string  │
  │  Works across mounts │  ❌ NO                │  ✅ YES               │
  │  ls -l indicator     │  no special symbol    │  shown as link -> path│
  │  Link count effect   │  Increases by 1       │  No effect on original│
  └──────────────────────┴───────────────────────┴───────────────────────┘
```

---

## 5. Commands

### Create Hard Link
```bash
ln  original.txt  hardlink.txt
```

### Create Soft Link
```bash
ln -s  original.txt  softlink.txt
#  -s = symbolic (soft)
```

### View inode numbers (to verify)
```bash
ls -li
# -l = long format
# -i = show inode number
```

### Output example:
```
  $ ls -li

  1234  -rw-r--r-- 2  user user  12  Jun 24  original.txt
  1234  -rw-r--r-- 2  user user  12  Jun 24  hardlink.txt
  5678  lrwxrwxrwx 1  user user  12  Jun 24  softlink.txt -> original.txt

  │     │           │                          │
  │     │           │                          └─ symlink shows -> target
  │     │           └─ link count (2 = hard link exists)
  │     └─ file type: l = symlink, - = regular file
  └─ inode number (1234 same for both hard links)
```

---

## 6. Visual Summary

```
  ┌─────────────────────────────────────────────────────────────────────┐
  │                    COMPLETE COMPARISON DIAGRAM                      │
  │                                                                     │
  │   HARD LINK:                                                        │
  │   ──────────                                                        │
  │                                                                     │
  │   original.txt ──────┐                                             │
  │                        ├──► [ inode #1234 ] ──► [ DATA: "Hello" ]  │
  │   hardlink.txt ───────┘                                            │
  │                         (same inode, same data, link count = 2)    │
  │                                                                     │
  │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─  │
  │                                                                     │
  │   SOFT LINK:                                                        │
  │   ──────────                                                        │
  │                                                                     │
  │   original.txt ──────► [ inode #1234 ] ──► [ DATA: "Hello" ]       │
  │         ▲                                                           │
  │         │ path: "/home/user/original.txt"                           │
  │         │                                                           │
  │   softlink.txt ──────► [ inode #5678 ] ──► [ PATH STORED ]         │
  │                         (different inode, stores path, not data)   │
  │                                                                     │
  └─────────────────────────────────────────────────────────────────────┘
```

---

## 7. Key Exam Points 🎯

| Question | Answer |
|----------|--------|
| What is an inode? | Metadata block storing file info (size, owner, permissions, data pointer) — NOT the filename |
| Does inode store filename? | ❌ NO — filename is stored in the directory entry |
| Hard link has same inode as original? | ✅ YES — same inode number |
| Soft link has same inode as original? | ❌ NO — different inode |
| What does soft link store? | PATH of the original file |
| Hard link across filesystems? | ❌ NOT possible |
| Soft link across filesystems? | ✅ Possible |
| Hard link on directories? | ❌ NOT allowed (prevents loops) |
| Soft link on directories? | ✅ Allowed |
| What is a dangling symlink? | Soft link whose original file has been deleted |
| Command for hard link? | `ln original.txt hardlink.txt` |
| Command for soft link? | `ln -s original.txt softlink.txt` |
| When is data actually deleted? | When inode link count reaches **0** |
| `ls -li` shows what? | inode number + file details |
| How to identify soft link in `ls -l`? | File type shown as `l` and `->` pointing to target |
