# Process Internals, Shell Execution, Redirection & Pipes — Study Notes
**Quick Revision Guide for Exam / Viva Prep**

---

## 1. Program vs Process — Memory Layout

### 1.1 What is a Program?

A **program** is a passive file sitting on the **hard disk** (e.g., `.exe`, `.out`, an ELF binary on Linux). It has a fixed structure:

```text
Executable File (on Hard Disk)
┌────────────────────┐
│  Executable Header  │   ← metadata: entry point, arch, etc.
├────────────────────┤
│  Text               │   ← compiled machine code (instructions)
├────────────────────┤
│  Data                │   ← initialized global/static variables
├────────────────────┤
│  BSS                 │   ← uninitialized global/static variables
├────────────────────┤
│  RO Data             │   ← read-only data (constants, string literals)
├────────────────────┤
│  Symbol Table        │   ← function/variable names for linking/debugging
└────────────────────┘
```

💡 **Tools to inspect executables:** `readelf`, `objdump`, `xxd`

### 1.2 What is a Process?

When a program is **loaded into RAM** (by the **Loader**) and starts running, it becomes a **process**. A process has its own memory layout inside **User Space**:

```text
Process Memory Layout (in RAM — User Space)
┌────────────────────┐
│  Stack               │   ← function calls, local variables, grows DOWN
├────────────────────┤
│  Heap                │   ← dynamic memory (malloc/new), grows UP
├────────────────────┤
│  RO Data             │   ← read-only constants (copied from disk)
├────────────────────┤
│  BSS                 │   ← uninitialized globals (zeroed out)
├────────────────────┤
│  Data                │   ← initialized globals
├────────────────────┤
│  Text                │   ← executable code
└────────────────────┘
```

### Comparison Table: Program vs Process

| Feature | Program | Process |
|---------|---------|---------|
| Location | Hard disk (static file) | RAM (loaded, running) |
| State | Passive, does nothing on its own | Active, executing instructions |
| Memory sections | Header, Text, Data, BSS, RO Data, Symbol Table | Stack, Heap, RO Data, BSS, Data, Text |
| Created via | Compilation | Loader loads program → becomes process |

🔴 **Exam Trap:** A program becomes a process only after the **Loader** loads it into memory — the same program file on disk can be loaded multiple times to create **multiple separate processes** (e.g., opening two terminal windows).

---

## 2. Kernel Space vs User Space

```text
        RAM
┌──────────────────────────────┐
│         User Space            │  ← Process (Stack/Heap/Data/Text)
│                                │
├──────────────────────────────┤
│        Kernel Space           │  ← PCB (Process Control Block)
└──────────────────────────────┘
```

- **User Space:** Where normal application code/process memory lives. Limited privileges.
- **Kernel Space:** Where the OS kernel operates — manages hardware, scheduling, and stores the **PCB** for every process. Full privileges.

💡 The PCB lives in **Kernel Space** because the kernel — not the process itself — is responsible for controlling and scheduling that process.

---

## 3. Process Control Block (PCB)

**PCB = Process Descriptor** — a data structure the **kernel** maintains for **every** running process, holding all the info needed to **control the execution of the program**.

- On Linux, implemented as `struct task_struct` (defined in `sched.h`).

### What the PCB Stores

| Category | Details |
|----------|---------|
| Identity | PID (Process ID), PPID (Parent Process ID) |
| Exit info | Exit status |
| Scheduling | CPU scheduling info (priority, state, etc.) |
| Memory | Memory info (page tables, memory segments) |
| IPC info | Message queues, pipes, signals, sockets, shared memory |
| File info | Table of open files (File Descriptor Table) |

```text
PCB (struct task_struct in sched.h) tracks:
 - pid, ppid
 - exit status
 - CPU sched info
 - memory info
 - IPC info    → message queue, pipe, signals, socket, shared memory
 - file info   → open file descriptor table
```

🔴 **Exam Trap:** *"Where is the PCB stored?"* → **Kernel space**, NOT inside the process's own user-space memory. This is what allows the OS to control/schedule processes securely — a process cannot tamper with its own PCB.

---

## 4. Shell Internals — How Commands Execute

**Scenario:** You type `ls` in the terminal. What actually happens?

```text
Terminal> ls

/usr/bin/ls (on disk)          bash (running process)              ls (new process)
┌────────────────┐             ┌──────┐                            ┌──────┐
│ Exe header       │             │  S    │                          │  S S' │
│ Data              │             │  H    │  ---- fork() ---->      │  H H' │
│ Text              │  <----exec()---- D    │                          │  D D' │
│ Sym tbl           │             │  T    │                          │  T T' │
└────────────────┘             └──────┘                            └──────┘
                                    ↑                                   ↑
                                  PCB                                 PCB
                              (parent process)                    (child process)
```

### Step-by-step:

1. **`bash`** is itself already a running process, loaded from `/bin/bash` on disk, with its own memory (Stack, Heap, Data, Text) and its own PCB.
2. When you type `ls`, bash calls **`fork()`**.
   - `fork()` creates a **child process** — an almost-exact **copy** of the parent (`bash`), including a duplicate memory layout (S', H', D', T') and a new PCB.
   - At this point, the child is still running a copy of **bash's** code.
3. The child process then calls **`exec()`**.
   - `exec()` **replaces** the child's memory content (code, data) with the new program's content — in this case, loaded from `/usr/bin/ls` on disk.
   - The child process now **becomes** `ls`, keeping the **same PID** but running entirely different code.
4. Result: `bash` (parent) continues running, waiting for the child; `ls` (child) executes and eventually exits.

### `fork()` vs `exec()`

| Function | What it does | Result |
|----------|----------------|--------|
| `fork()` | Duplicates the calling process (parent) into a new child process | Two processes now running the SAME code |
| `exec()` | Replaces the current process's code/memory with a new program | Same process (same PID), but now runs DIFFERENT code |

🔴 **Exam Trap (very common Viva Q):** *"Why does Linux use `fork()` + `exec()` instead of just directly running a new program?"*
→ `fork()` gives the child a copy of the parent's environment/context (open files, environment variables, working directory) to inherit, and `exec()` then swaps in the actual new program — this two-step design is what allows shells to do things like redirection and piping **before** the new program starts (by modifying the child's file descriptors after `fork()` but before `exec()`).

🟠 **Note:** Parent = `bash`, Child = `ls`. This parent-child relationship is why every process (except the very first, `init`/`systemd`) has a **PPID** (Parent PID) in its PCB.

---

## 5. Standard Streams (stdin, stdout, stderr)

By **default**, every program:

| Stream | Full Name | Purpose | FD Number |
|--------|------------|---------|-----------|
| `stdin` | Standard Input | Takes input (usually from keyboard) | 0 |
| `stdout` | Standard Output | Writes normal output (usually to terminal) | 1 |
| `stderr` | Standard Error | Writes error messages (usually to terminal) | 2 |

**Example: `cat`**

```text
PCB → OFDT (Open File Descriptor Table)
        0 → stdin
        1 → stdout
        2 → stderr
```

- Every process's PCB points to an **Open File Descriptor Table (OFDT)** — a list of all files/streams the process currently has open.
- Slots **0, 1, 2** are always reserved for stdin, stdout, stderr respectively.
- Any additional file the process opens gets the **next available number**: FD 3, FD 4, and so on.

We can **change this default behavior** using **redirection**.

---

## 6. File Descriptors (FD) — Detailed

**File Descriptor (FD):** A non-negative integer used by the OS/kernel to identify an **open file** (or stream) belonging to a process. Maintained in the process's file descriptor table (part of what the PCB tracks).

| FD | Default Meaning |
|----|-------------------|
| 0 | stdin |
| 1 | stdout |
| 2 | stderr |
| 3 | First additional file opened by the process |
| 4 | Next file opened |
| ... | And so on |

💡 **Key idea:** Redirection doesn't change *what* `cat` does — it changes *where FD 0/1/2 point to*. The program itself has no idea whether it's talking to a terminal or a file; it just reads from FD 0 and writes to FD 1/2.

---

## 7. Redirection — Three Types

There are **3 types of redirection**, all achieved by changing what a file descriptor points to:

| Type | Symbol(s) | Effect |
|------|------------|--------|
| **Output redirection** | `>`, `>>` | Instead of writing output to stdout (terminal), it's written into a file |
| **Input redirection** | `<` | Instead of taking input from stdin (keyboard), it's read from a file |
| **Error redirection** | `2>`, `2>>` | Instead of writing errors to stderr (terminal), they're written into a file |

`>` and `2>` **overwrite** the target file; `>>` and `2>>` **append** to it.

---

### 7.1 Output Redirection — `cat > file.txt`

**Command:** `cat > file.txt`

**Normally (before redirection):**

| FD | Points to |
|----|------------|
| 0 | stdin (keyboard) |
| 1 | terminal (stdout) |
| 2 | terminal (stderr) |

**After output redirection:**

| FD | Points to |
|----|------------|
| 0 | stdin (keyboard) |
| 1 | **file.txt** |
| 2 | terminal (stderr) |

**Meaning:** `cat > file.txt` means the output of `cat` is written into `file.txt` instead of the terminal. (Since no input file is given, `cat` reads from the keyboard and writes whatever you type into `file.txt`, until you press `Ctrl+D`.)

```bash
cat > file.txt
Hello World
Ctrl+D              # saves and exits
```

---

### 7.2 Input Redirection — `cat < input.txt`

**Command:** `cat < input.txt`

**Normally:**

| FD | Points to |
|----|------------|
| 0 | stdin |
| 1 | stdout |
| 2 | stderr |

**After input redirection:**

| FD | Points to |
|----|------------|
| 0 | **input.txt** |
| 1 | stdout |
| 2 | stderr |

**Meaning:** `cat` takes its input from `input.txt` instead of the keyboard, and prints it to the terminal (stdout is unchanged).

```bash
cat < input.txt      # reads input.txt, prints its content to terminal
```

---

### 7.3 Error Redirection — `ls -w 2> error.txt`

**Command:** `ls -w 2> error.txt`

`2>` specifically redirects **FD 2 (stderr)** to `error.txt`.

**Before:**

| FD | Points to |
|----|------------|
| 0 | stdin |
| 1 | stdout |
| 2 | terminal |

**After:**

| FD | Points to |
|----|------------|
| 0 | stdin |
| 1 | stdout |
| 2 | **error.txt** |

**Meaning:** Error messages produced by the command are saved in `error.txt` instead of being shown on the terminal. Normal (non-error) output still goes to the terminal via stdout.

```bash
ls -w 2> error.txt     # any error from ls is saved into error.txt
```

---

### 7.4 Difference Between `<` and `>`

```text
cat < input.txt
   input.txt  →  cat  →  terminal      (input.txt feeds INTO cat)

cat > file.txt
   keyboard/input  →  cat  →  file.txt   (cat's output goes INTO file.txt)
```

| Symbol | Direction | Meaning |
|--------|-----------|---------|
| `<` | File → Command | Command reads its input FROM the file |
| `>` | Command → File | Command's output is written INTO the file |

🔴 **Exam Trap:** `<` always feeds data **into** the command (input side); `>` always sends data **out of** the command (output side). Easy to mix up under exam pressure — remember the arrow direction matches the symbol's "point."

---

### 7.5 Quick Revision Table — Redirection

| FD | Name | Purpose |
|----|------|---------|
| 0 | stdin | Input |
| 1 | stdout | Normal output |
| 2 | stderr | Error output |

| Symbol | Meaning |
|--------|---------|
| `<` | Input redirection |
| `>` | Output redirection (overwrite) |
| `>>` | Output redirection (append) |
| `2>` | Error redirection (overwrite) |
| `2>>` | Error redirection (append) |

### 7.6 Bonus: Process Substitution & `diff`

```bash
diff <(cat input.txt) <(cat file.txt)
# or simply:
diff input.txt file.txt
```

- Both commands compare the contents of the two files.
- `<(...)` is **process substitution** — it runs the command inside and makes its output act like a temporary file/FD that `diff` can read from. Advanced usage, but functionally equivalent here to just passing the filenames directly.

---

## 8. Pipes (`|`)

A **pipe** connects the **output of one command directly to the input of another** — without needing an intermediate file.

### Key Points

- A pipe can be used to **nest/chain multiple commands** together.
- The **output of the first command** is given as **input to the second command**.
- A pipe is a **unidirectional** IPC (Inter-Process Communication) mechanism — data flows only **one way** (from writer to reader).

```text
cmd1 | cmd2

is really:

cmd1 → [pipe] → cmd2
        ↑   ↑
     write  read
      end   end
```

### Example: `sort numbers.txt | uniq`

```text
sort numbers.txt        |        uniq
     (cmd1)                      (cmd2)

           writer                          reader
        ┌────────┐                      ┌────────┐
        │  S       │                      │  S       │
        │  H       │  --[write]-->[PIPE]--[read]-->│  H       │
        │  D       │                      │  D       │
        │  T       │                      │  T       │
        └────────┘                      └────────┘
             ↑                                  ↑
           PCB                                PCB
              \                                /
               \      circular buffer         /
                \___________↕________________/
```

### How it works internally:

1. `sort numbers.txt` (cmd1) runs as the **writer** — it writes its output into the pipe instead of the terminal.
2. `uniq` (cmd2) runs as the **reader** — it reads its input from the pipe instead of the keyboard.
3. Under the hood, the kernel maintains a small **circular buffer** in kernel memory that temporarily holds the data being passed between the two processes.
4. Each process has a PCB; the pipe connects the **write end** (cmd1's stdout, FD 1) to the **read end** (cmd2's stdin, FD 0).

### Comparison Table: Pipe vs Redirection

| Feature | Pipe (`|`) | Redirection (`>`, `<`) |
|---------|--------------|----------------------------|
| Connects | Two processes/commands | A process and a file |
| Direction | Unidirectional, process → process | File ↔ process |
| Storage | Kernel circular buffer (in-memory, temporary) | Actual file on disk |
| Use case | Chaining commands (`cmd1 \| cmd2`) | Saving output or reading input from a file |

🔴 **Exam Trap:** A pipe is **unidirectional** — data flows only from the writer to the reader in one pipe. For **bidirectional** communication between processes, you'd need something like a **socket**, not a plain pipe.

🟠 **Note:** Pipes use a **circular buffer** with limited size (kernel-managed) — if the reader is slow and the buffer fills up, the writer process **blocks** (pauses) until the reader consumes some data. This is why pipes naturally provide **flow control** between chained commands.

### 8.1 Blocking Behavior — Buffer Full vs Buffer Empty

The kernel's circular buffer has a limited, fixed size. Its fill-level controls whether the writer or the reader gets **blocked (paused)**:

| Buffer State | Who gets blocked? | Why |
|---------------|----------------------|-----|
| **Buffer FULL** | **Writer (left/cmd1) blocks** | No more space to write into — cmd1 must pause until cmd2 reads some data and frees up room |
| **Buffer EMPTY** | **Reader (right/cmd2) blocks** | Nothing available to read yet — cmd2 must pause and wait until cmd1 writes some data |

```text
cmd1  →  [circular buffer]  →  cmd2
(writer)                        (reader)

Buffer FULL   → cmd1 (writer) BLOCKS  (can't write more)
Buffer EMPTY  → cmd2 (reader) BLOCKS  (nothing to read)
```

💡 **Memory trick:** Left/writer blocks when there's no room LEFT (full). Right/reader blocks when there's nothing RIGHT there yet (empty).

🔴 **Exam Trap:** This blocking is exactly how pipes achieve automatic **flow control** — neither process needs to manually coordinate speed; the kernel buffer handles pacing both sides.

### 8.2 Pipe Does NOT Use Terminal stdin/stdout

- A pipe **replaces** what FD 0 (stdin) and FD 1 (stdout) point to — it does **not** route data through the actual terminal at all.
- In `cmd1 | cmd2`:
  - cmd1's **FD 1 (stdout)** is redirected to point to the pipe's **write end** (instead of the terminal).
  - cmd2's **FD 0 (stdin)** is redirected to point to the pipe's **read end** (instead of the keyboard).
- The terminal is never touched in between — data goes **directly kernel-buffer → kernel-buffer**, process to process, without ever being displayed or typed.

```text
Normal (no pipe):
  cmd1: FD1 → terminal (stdout)
  cmd2: FD0 → keyboard (stdin)

With pipe (cmd1 | cmd2):
  cmd1: FD1 → pipe write end   (NOT terminal)
  cmd2: FD0 → pipe read end    (NOT keyboard)
```

🟠 **Note:** This is conceptually the same trick used in **redirection** (Section 7) — the pipe is just redirecting FD 1 of cmd1 and FD 0 of cmd2 to point at each other's shared kernel buffer, instead of pointing at a file or the terminal.

---

## 9. Quick-Fire Viva Q&A

| Question | Answer |
|----------|--------|
| Difference between a program and a process? | Program = static file on disk; Process = program loaded into RAM and executing |
| Where is the PCB stored — user space or kernel space? | Kernel space |
| What does PCB stand for, and what's the Linux struct name? | Process Control Block; `struct task_struct` (in `sched.h`) |
| What does `fork()` do? | Creates a child process that is a duplicate of the parent |
| What does `exec()` do? | Replaces the current process's memory/code with a new program, keeping the same PID |
| Why does the shell use `fork()` THEN `exec()` instead of exec() alone? | So the child can inherit/modify file descriptors (for redirection/piping) before the new program takes over |
| What are the 3 default standard streams and their FD numbers? | stdin=0, stdout=1, stderr=2 |
| What does `>` do vs `<`? | `>` sends command output into a file; `<` feeds a file's content as command input |
| Difference between `>` and `>>`? | `>` overwrites the file; `>>` appends to it |
| How do you redirect only error messages to a file? | `command 2> error.txt` |
| Is a pipe unidirectional or bidirectional? | Unidirectional — one-way, writer to reader |
| What kernel structure temporarily holds piped data? | A circular buffer |
| What happens if a pipe's buffer is full? | The writer (left/cmd1) process blocks (pauses) until the reader consumes data |
| What happens if a pipe's buffer is empty? | The reader (right/cmd2) process blocks (pauses) until the writer produces data |
| Does a pipe route data through the terminal's stdin/stdout? | No — it redirects cmd1's FD1 and cmd2's FD0 to point directly at each other via the kernel buffer, bypassing the terminal/keyboard entirely |
| Command to inspect an executable's internal structure? | `readelf`, `objdump`, or `xxd` |

---

## 10. One-Page Summary

```text
Program (disk) --Loader--> Process (RAM)
                                 |
                          PCB (kernel space)
                          tracks: pid, ppid, exit status,
                          CPU sched, memory, IPC, open files

Shell command execution:
  bash --fork()--> child (copy of bash) --exec()--> becomes new command

Standard streams (default):
  FD 0 = stdin   FD 1 = stdout   FD 2 = stderr

Redirection:
  >   output → file (overwrite)      cat > file.txt
  >>  output → file (append)
  <   file → input                    cat < input.txt
  2>  error → file (overwrite)        ls -w 2> error.txt
  2>> error → file (append)

Pipe:
  cmd1 | cmd2   → cmd1's stdout feeds cmd2's stdin, via kernel circular buffer
  Unidirectional IPC mechanism
```

