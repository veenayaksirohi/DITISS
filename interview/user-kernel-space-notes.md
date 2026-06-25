# User Mode, Kernel Mode, User Space & Kernel Space

> **Core idea:** The OS divides the world into two zones — a privileged zone (kernel) that controls everything, and a restricted zone (user) where your programs run safely. The CPU hardware enforces this split.

---

## 1. The Two CPU Execution Modes

These are **hardware-level CPU states**, not software constructs.

### Kernel Mode (Privileged Mode)
- The CPU runs with **full, unrestricted privileges**
- Can execute **any CPU instruction**
- Can access **any memory address**
- Can talk **directly to hardware** (disk, network card, GPU, etc.)
- A bug here can **crash the entire system**
- The OS kernel runs here

### User Mode (Unprivileged Mode)
- The CPU runs with **strict restrictions**
- **Cannot** issue privileged CPU instructions
- **Cannot** access hardware directly
- **Cannot** read/write another process's memory
- A bug here only **crashes that one process**
- Your applications run here (browser, Python script, web server)

> **Analogy:** Kernel mode is the pilot in the cockpit — full control of the aircraft. User mode is a passenger — seated, belted, and cannot touch the controls.

---

## 2. User Space vs Kernel Space

These are **regions of virtual memory**, not execution modes. Both concepts work together:

```
Virtual Address Space (per process)
┌──────────────────────────────────┐  ← High addresses
│                                  │
│         KERNEL SPACE             │  ← Only kernel can access
│   (kernel code, drivers, data)   │
│                                  │
├──────────────────────────────────┤  ← Boundary (enforced by hardware)
│                                  │
│          USER SPACE              │  ← App's private memory
│  (stack, heap, code, libraries)  │
│                                  │
└──────────────────────────────────┘  ← Low addresses
```

### Kernel Space
- Upper region of virtual memory
- Holds: kernel code, device drivers, system data structures, interrupt handlers
- **Shared across all processes** — one kernel, many processes
- Only accessible when the CPU is in kernel mode
- Contains things like the process table, file descriptor table, network buffers

### User Space
- Lower region of virtual memory
- Each process gets its **own isolated chunk** — process A cannot see process B's memory
- Holds: program code, stack, heap, environment variables, shared libraries (libc, etc.)
- Managed by the kernel's memory manager (via virtual memory + paging)

> **Key insight:** Two processes may have the same virtual address (e.g., both have a stack at `0x7ffe1234`) but they map to **different physical RAM pages**. The kernel's page tables make this work.

---

## 3. CPU Protection Rings

The CPU enforces privilege levels using **hardware rings** (x86 architecture has 4):

```
        ┌─────────────────────────┐
        │        Ring 3           │  ← User applications (least privileged)
        │  ┌───────────────────┐  │
        │  │      Ring 2       │  │  ← OS services (rarely used)
        │  │  ┌─────────────┐  │  │
        │  │  │   Ring 1    │  │  │  ← Device drivers (rarely used)
        │  │  │  ┌───────┐  │  │  │
        │  │  │  │Ring 0 │  │  │  │  ← Kernel (most privileged)
        │  │  │  └───────┘  │  │  │
        │  │  └─────────────┘  │  │
        │  └───────────────────┘  │
        └─────────────────────────┘
              ↑ More privilege
```

| Ring | Name | Who Uses It | Privileges |
|------|------|-------------|------------|
| Ring 0 | Kernel | OS Kernel | Full — any instruction, any memory |
| Ring 1 | Driver | Some OS designs | Partial hardware access |
| Ring 2 | Driver | Some OS designs | Partial hardware access |
| Ring 3 | User | All applications | No direct hardware access |

> **Important:** Linux, Windows, and macOS only use **Ring 0 and Ring 3** in practice. Rings 1 and 2 exist in the CPU spec but modern OSes skip them. This creates a sharp cliff between kernel and user — no gradual transition.

---

## 4. The System Call — Crossing the Boundary

Every time a user-space program needs a privileged operation, it makes a **system call (syscall)**.

### Step-by-step flow

```
User Space                          Kernel Space
──────────────────────────────────────────────────────────
  printf("hello")
       │
       ▼
  libc's write()         ──syscall──►   sys_write() handler
  (wraps the syscall)                        │
                                             │  writes to
                                             ▼  hardware buffer
                         ◄──return──   returns bytes written
       │
       ▼
  program continues
```

### What happens at the CPU level

1. App calls `read()`, `write()`, `open()`, `fork()`, `malloc()` (via libc)
2. libc sets up arguments and triggers a **trap instruction** (`syscall` on x86-64, `svc` on ARM)
3. CPU **switches to Ring 0** and jumps to the kernel's syscall handler
4. Kernel validates the request, performs the operation
5. CPU **switches back to Ring 3** and returns the result to user space

### Common syscalls to know

| Syscall | What it does |
|---------|-------------|
| `read()` | Read bytes from a file descriptor |
| `write()` | Write bytes to a file descriptor |
| `open()` | Open a file, get a file descriptor |
| `fork()` | Create a child process |
| `exec()` | Replace current process with a new program |
| `mmap()` | Map memory (used by malloc under the hood) |
| `socket()` | Create a network socket |
| `exit()` | Terminate the process |

> **Performance note:** A syscall involves a full CPU mode switch — it costs roughly **100–1000 nanoseconds**. High-performance systems try to batch operations or use techniques like `io_uring` (Linux) to minimize mode switches.

---

## 5. What Lives Where — Quick Reference

### In Kernel Space
- Process scheduler (decides which process runs next)
- Memory manager (virtual memory, page tables, swap)
- File system drivers (ext4, NTFS, etc.)
- Network stack (TCP/IP, socket buffers)
- Device drivers (keyboard, disk, NIC)
- Interrupt handlers (respond to hardware signals)

### In User Space
- Your applications (Python, Node.js, Java, C++)
- System daemons (nginx, sshd, cron, systemd services)
- Standard libraries (libc, libpthread, libssl)
- Shell (bash, zsh)
- GUI frameworks and apps

---

## 6. Why This Design Exists

| Problem | How the split solves it |
|---------|------------------------|
| A buggy app crashing the OS | User mode crash = only that process dies |
| One process reading another's passwords | Isolated virtual memory per process |
| A virus directly controlling hardware | Hardware access blocked in Ring 3 |
| Untrusted code running wild | Kernel validates every resource request |

---

## 7. Summary Cheat Sheet

| | **User Mode / User Space** | **Kernel Mode / Kernel Space** |
|---|---|---|
| CPU Ring | Ring 3 | Ring 0 |
| Hardware access | ❌ Must ask kernel | ✅ Direct |
| Memory isolation | Per-process (isolated) | Global (shared kernel) |
| What runs here | Apps, browsers, services | OS core, drivers, scheduler |
| Crash impact | Kills one process | Can crash the whole OS |
| Privilege level | Unprivileged | Fully privileged |
| How to cross boundary | System call (trap instruction) | Return from syscall |

---

## 8. Key Terms Glossary

**User Mode** — CPU execution state with restricted privileges; where apps run.

**Kernel Mode** — CPU execution state with full privileges; where the OS runs.

**User Space** — Virtual memory region allocated to a user process (stack, heap, code).

**Kernel Space** — Virtual memory region reserved for the OS kernel; inaccessible from user mode.

**System Call (syscall)** — The mechanism for user-space code to request kernel services.

**Protection Ring** — Hardware-enforced CPU privilege level (Ring 0 = most, Ring 3 = least).

**Virtual Memory** — An abstraction where each process sees its own isolated address space, mapped to physical RAM by the kernel.

**Page Table** — Kernel data structure that maps virtual addresses to physical memory addresses.

**Trap / Interrupt** — A CPU signal that transfers control from user mode to kernel mode.

**Context Switch** — The kernel saving one process's CPU state and restoring another's.
