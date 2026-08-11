# Filesystem Partition Layout — Study Notes
**Quick Revision Guide for Exam / Viva Prep**

---

## 1. What is a Partition Made Of?

Every disk **partition** is internally divided into **4 logical regions**, laid out in order:

```text
┌───────────┬──────────────────┬───────────────────┬───────────────────────────┐
│  BP        │  BL                │  FCB (inode) table  │  Data blocks                │
│  (Boot     │  (Volume Control   │  (Master File      │                              │
│   Sector)  │   Block)           │   Table)            │                              │
└───────────┴──────────────────┴───────────────────┴───────────────────────────┘
```

| Region | Generic Name | Linux-Specific Name |
|--------|----------------|-------------------------|
| **BP** | Boot Sector | **Boot block** |
| **BL** | Volume Control Block | **Super block** |
| — | Master File Table (MFT) | **inode list** |
| — | Data blocks | **Data blocks** |

💡 **Naming note:** The generic OS-textbook terms (Boot Sector, Volume Control Block, Master File Table) map directly to the Linux/Unix filesystem terms (Boot block, Super block, inode list) — same concepts, different names depending on which OS/textbook you're reading.

---

## 2. The 4 Regions Explained

### 2.1 Boot Sector / Boot Block

- The **first region** of the partition.
- Contains the bootstrap code needed to start loading the OS, **if** this partition is bootable.
- Fixed, small size (traditionally 512 bytes for the very first sector of a disk/partition).

```text
BP = Boot sector / Boot block
```

---

### 2.2 Volume Control Block / Super Block

- Stores **metadata about the entire filesystem/partition itself** — not about individual files.
- Contains info like:
  - Total number of blocks in the partition
  - Number of free/used blocks
  - Block size
  - Filesystem type
  - Pointer to the free block list
  - inode count (total & free)

```text
BL = Volume Control Block / Super block
```

💡 **Analogy:** If the partition were a library, the **super block** is the library's own administrative record — "how many shelves total, how many books total, how many are checked out" — NOT information about any specific book.

---

### 2.3 Master File Table (MFT) / inode List

- A **table/list of FCBs (File Control Blocks)** — one entry per file on the partition.
- On Linux/Unix, each entry is called an **inode**; on Windows NTFS, the equivalent structure is literally called the **Master File Table (MFT)**.
- Each **FCB/inode** stores metadata about ONE file:
  - File size
  - Permissions (rwx)
  - Owner (UID) & Group (GID)
  - Timestamps (created, modified, accessed)
  - **Pointers to the actual data blocks** where the file's content lives

```text
Master File Table = inode list
Each entry = FCB (File Control Block) = inode
```

🔴 **Exam Trap:** The inode does **NOT** store the filename! Filenames are stored separately in the **directory entry**, which just maps a name → inode number. This is exactly why **hard links** work — multiple filenames (directory entries) can point to the SAME inode.

---

### 2.4 Data Blocks

- The actual **content/data** of files is physically stored here.
- Each FCB/inode holds **pointers** to the specific data blocks that make up that file.
- A single file may be spread across **multiple, non-contiguous data blocks** — the inode's pointers keep track of all of them in order.

```text
Data blocks = where actual file CONTENT lives
```

---

## 3. FCB (File Control Block) / inode — How It Connects to Data

From the diagram: each FCB entry in the Master File Table/inode list points to one or more data blocks belonging to that file.

```text
FCB (inode) Table              Data Blocks

  F1  ────────────────────►  [ Block A ]

  F2  ────────────────────►  [ Block B ]──►[ Block C ]──►[ Block D ]
```

- **F1** → points to **1 data block** → this file's content fits in a single block.
- **F2** → points to a **chain of 3 data blocks** → this file is larger, so its content is spread across multiple blocks, linked together.

💡 **Key takeaway:** The inode/FCB is like an **index card** — it doesn't hold the file's content itself, it just holds **pointers** telling the filesystem exactly where to go find that content among the data blocks.

---

## 4. Comparison Table — Generic vs Linux Terms

| Generic (OS Textbook) Term | Linux/Unix Term | Stores |
|------------------------------|--------------------|--------|
| Boot Sector (BP) | Boot block | Bootstrap code to start OS |
| Volume Control Block (BL) | Super block | Metadata about the WHOLE partition/filesystem |
| Master File Table (MFT) | inode list | One FCB/inode per file — metadata + pointers to data |
| Data blocks | Data blocks | Actual file content |
| File Control Block (FCB) | inode | Per-file metadata (size, permissions, owner, timestamps, data block pointers) — NOT the filename |

---

## 5. Quick-Fire Viva Q&A

| Question | Answer |
|----------|--------|
| What are the 4 main regions of a partition? | Boot sector, Volume Control Block, Master File Table (FCB/inode table), Data blocks |
| What is the Linux name for "Volume Control Block"? | Super block |
| What is the Linux name for "Master File Table"? | inode list |
| What does the super block store? | Metadata about the entire filesystem (total blocks, free blocks, block size, inode count, etc.) |
| What does an inode (FCB) store? | Per-file metadata — size, permissions, owner, timestamps, and pointers to data blocks |
| Does an inode store the filename? | No — filenames live in directory entries, which map name → inode number |
| Where is actual file content stored? | In the data blocks region |
| Why can one file's content span multiple data blocks? | The inode holds pointers to ALL the blocks that make up the file, even if they're scattered/non-contiguous |
| Why does this design allow hard links to work? | Multiple directory entries (filenames) can point to the SAME inode number, sharing the same data |

---

## 6. One-Page Summary

```text
Partition Layout:

┌──────────┬───────────────┬──────────────────┬─────────────┐
│ Boot      │ Volume Control │ Master File Table │ Data         │
│ Sector    │ Block          │ (FCB/inode table)  │ Blocks       │
└──────────┴───────────────┴──────────────────┴─────────────┘

Generic  → Boot Sector → Volume Control Block → Master File Table → Data Blocks
Linux    → Boot block  → Super block          → inode list        → Data blocks

Each inode/FCB:
  - Stores: size, permissions, owner, timestamps
  - Points to: 1 or more data blocks holding actual content
  - Does NOT store: the filename (that's in the directory entry)
```

