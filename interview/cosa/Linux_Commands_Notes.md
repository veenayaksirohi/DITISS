# Linux Commands — Study Notes
**Quick Revision Guide for Exam / Viva Prep**

---

## 1. Essential Commands

### 1.1 `ls` — List directory contents

| Flag | Meaning |
|------|---------|
| `-l` | Long listing (permissions, owner, size, date) |
| `-a` | Show hidden files (starting with `.`) |
| `-h` | Human-readable sizes (KB/MB/GB) |
| `-R` | Recursive listing |
| `-t` | Sort by modification time |
| `-S` | Sort by file size |

```bash
ls -lah          # most commonly used combo
ls -lt /var/log   # newest files first
```

🔴 **Exam Trap:** `ls -l` first column shows file type + permissions, e.g. `-rwxr-xr--`. First char: `-` = file, `d` = directory, `l` = symlink.

---

### 1.2 `cp` — Copy files/directories

| Flag | Meaning |
|------|---------|
| `-r` / `-R` | Recursive (needed for directories) |
| `-p` | Preserve permissions, timestamps |
| `-i` | Interactive (confirm before overwrite) |
| `-v` | Verbose |
| `-u` | Copy only if source is newer |

```bash
cp file1.txt /backup/
cp -rp projectDir/ /backup/projectDir_copy/
```

---

### 1.3 `mv` — Move / Rename

```bash
mv old.txt new.txt          # rename
mv file.txt /home/user/docs/  # move
mv -i a.txt b.txt           # prompt before overwrite
```

💡 `mv` = **move**, not copy — no `-r` needed for directories (unlike `cp`).

---

### 1.4 `rm` — Remove files/directories

| Flag | Meaning |
|------|---------|
| `-r` | Recursive (delete directories) |
| `-f` | Force (no prompt, ignore non-existent files) |
| `-i` | Interactive confirm |
| `-v` | Verbose |

```bash
rm -rf oldproject/    # ⚠️ dangerous — no undo, no recycle bin
```

🔴 **Exam Trap:** `rm -rf /` (or `rm -rf /*`) can wipe the entire filesystem — classic "why sudo is dangerous" interview question.

---

### 1.5 `cat` — Concatenate & display files

```bash
cat file.txt              # print content
cat file1 file2 > merged.txt   # merge files
cat -n file.txt            # show line numbers
cat > newfile.txt          # create file, type content, Ctrl+D to save
```

---

### 1.6 `grep` — Search text using patterns

| Flag | Meaning |
|------|---------|
| `-i` | Case-insensitive |
| `-r` | Recursive search in directories |
| `-n` | Show line numbers |
| `-v` | Invert match (show non-matching lines) |
| `-c` | Count matching lines |
| `-E` | Extended regex (egrep) |
| `-w` | Match whole word only |

```bash
grep -in "error" logfile.txt
grep -rn "TODO" ./src/
ps aux | grep nginx
```

---

### 1.7 `find` — Search files (live filesystem search)

```bash
find /home -name "*.txt"
find / -type f -size +100M
find . -mtime -7              # modified in last 7 days
find . -name "*.log" -exec rm {} \;   # find + delete
```

| Option | Meaning |
|--------|---------|
| `-name` | Match by filename |
| `-type f/d` | File or directory |
| `-size` | Match by size |
| `-mtime` | Modified N days ago |
| `-exec` | Run a command on results |

---

### 1.8 `diff` — Compare files line by line

```bash
diff file1.txt file2.txt
diff -u file1.txt file2.txt   # unified diff (used in patches/git)
diff -r dir1/ dir2/           # compare directories
```

- `<` = line from file1
- `>` = line from file2

---

### 1.9 `wc` — Word count

| Flag | Meaning |
|------|---------|
| `-l` | Line count |
| `-w` | Word count |
| `-c` | Byte count |
| `-m` | Character count |

```bash
wc -l file.txt        # count lines
cat file.txt | wc -w  # count words via pipe
```

---

### 1.10 `sort` — Sort lines of text

| Flag | Meaning |
|------|---------|
| `-n` | Numeric sort |
| `-r` | Reverse order |
| `-k` | Sort by column/field |
| `-u` | Unique (remove duplicates) |
| `-t` | Set field delimiter |

```bash
sort names.txt
sort -nr scores.txt          # numeric, descending
sort -t',' -k2 data.csv      # sort CSV by 2nd column
```

---

### 1.11 `head` / `tail` — View start/end of files

```bash
head -n 10 file.txt      # first 10 lines
tail -n 20 file.txt       # last 20 lines
tail -f /var/log/syslog   # live-follow (used for log monitoring)
```

🔴 **Exam Trap:** `tail -f` is heavily used in Viva for "how do you monitor logs in real time?"

---

## 2. Archive & Compression

### 2.1 `tar` — Tape Archive (bundle files, no compression by itself)

| Flag | Meaning |
|------|---------|
| `-c` | Create archive |
| `-x` | Extract archive |
| `-z` | Use gzip compression |
| `-v` | Verbose |
| `-f` | Filename (must come last before name) |
| `-t` | List contents without extracting |

```bash
tar -czvf backup.tar.gz /home/user/project/   # create compressed archive
tar -xzvf backup.tar.gz                       # extract compressed archive
tar -tvf backup.tar.gz                        # list contents
```

💡 Mnemonic: **c**reate, e**x**tract, **z**ip, **v**erbose, **f**ile.

---

### 2.2 `gzip` / `gunzip` — Single-file compression

```bash
gzip file.txt        # creates file.txt.gz, removes original
gunzip file.txt.gz   # decompresses, restores file.txt
zcat file.txt.gz      # view content of .gz file WITHOUT extracting
```

🟠 **Note:** `gzip` compresses **one file at a time**. To compress multiple files, `tar` them first, then `gzip` (or use `tar -z` directly).

---

### 2.3 `zip` / `unzip` — Cross-platform archive + compression

```bash
zip archive.zip file1 file2         # zip specific files
zip -r archive.zip myFolder/        # zip a directory (recursive)
unzip archive.zip                   # extract
unzip -l archive.zip                # list contents without extracting
```

### Comparison Table: `tar.gz` vs `zip`

| Feature | tar.gz | zip |
|---------|--------|-----|
| Native OS | Linux/Unix | Windows (also cross-platform) |
| Preserves permissions | ✅ Yes | ⚠️ Limited |
| Compression + archiving | Two steps (tar + gzip) combined via `-z` | Single step |
| Common use | Backups, source distribution | Cross-platform file sharing |

---

## 3. Process Commands

### 3.1 `ps` — Snapshot of running processes

```bash
ps           # processes in current shell
ps aux       # ALL processes, all users, detailed (most used)
ps -ef       # alternate full-format listing
```

Key columns in `ps aux`: `USER`, `PID`, `%CPU`, `%MEM`, `STAT`, `COMMAND`.

---

### 3.2 `top` — Live process monitor

```bash
top
```
- Shows real-time CPU/memory usage, updates every few seconds.
- Press `k` inside `top` to kill a process, `q` to quit.
- `htop` = improved, color, interactive version (not built-in by default).

---

### 3.3 `kill` — Terminate a process

```bash
kill PID            # sends SIGTERM (15) — graceful shutdown
kill -9 PID          # sends SIGKILL (9) — force kill, immediate
kill -l              # list all available signals
killall firefox      # kill by process name
```

🔴 **Exam Trap:** `SIGTERM (15)` = polite request (process can clean up); `SIGKILL (9)` = forced, cannot be caught/ignored.

---

### 3.4 `jobs`, `bg`, `fg` — Job Control

```bash
sleep 100 &      # run in background (& at end)
jobs             # list background jobs of current shell
bg %1            # resume job 1 in background
fg %1            # bring job 1 to foreground
```

- `Ctrl+Z` → suspends (pauses) a foreground job.
- `bg` → resumes suspended job **in background**.
- `fg` → brings background job **to foreground**.

---

### 3.5 `nohup` — Run command immune to hangups

```bash
nohup python3 script.py &
```
- Keeps a process running even after you **log out** or close the terminal.
- Output redirected to `nohup.out` by default if not specified.

🟠 **Real-world use:** Running long server scripts/deployments over SSH so they survive disconnection.

---

## 4. Hard Link vs Soft (Symbolic) Link

### Core Concept: Inodes

Every file on Linux has an **inode** — a data structure storing metadata (permissions, owner, size, pointers to data blocks) but **NOT the filename**. The filename is just a pointer stored in the directory entry, mapped to an inode number.

```
Directory Entry            Inode Table                Data Blocks
  file.txt  ---> inode 1234 ---> [permissions, size] ---> [actual data on disk]
```

### 4.1 Hard Link

```bash
ln original.txt hardlink.txt
```

- Creates a **new directory entry pointing to the SAME inode** as the original.
- Both filenames are equal — there's no "original" vs "copy"; deleting one leaves the data accessible via the other.
- File data is deleted only when **link count reaches 0** (all hard links removed).

```
file.txt   ---\
                >---> inode 1234 ---> data blocks
hardlink.txt --/
```

### 4.2 Soft Link (Symbolic Link)

```bash
ln -s original.txt softlink.txt
```

- Creates a **new inode** that simply stores the **path** to the target file (like a shortcut).
- If the original file is deleted or moved, the symlink becomes a **"dangling"/broken link**.

```
softlink.txt ---> inode 5678 ("points to path: /home/user/original.txt")
                                     |
                                     v
                        file.txt ---> inode 1234 ---> data blocks
```

### Comparison Table

| Feature | Hard Link | Soft Link (Symlink) |
|---------|-----------|----------------------|
| Command | `ln target link` | `ln -s target link` |
| Inode | Shares SAME inode as target | Has its OWN new inode |
| Points to | Data blocks directly | Path/filename of target |
| Works across filesystems/partitions | ❌ No | ✅ Yes |
| Can link to a directory | ❌ No (usually restricted) | ✅ Yes |
| If original deleted | Data still accessible (link count > 0) | Symlink breaks ("dangling link") |
| `ls -l` indicator | Normal file, link count shown | Shown as `l`, with `->` pointing to target |

🔴 **Exam Trap (very common Viva Q):** *"Why can't hard links cross filesystems?"*
→ Because inode numbers are only unique **within a single filesystem/partition**. A hard link is literally a reference to an inode number, which has no meaning on a different filesystem. Soft links work across filesystems because they just store a **text path**, not an inode reference.

🔴 **Exam Trap:** Check link count via `ls -l` — the number after permissions (e.g., `-rw-r--r-- 2 user user ...`) shows how many hard links point to that inode.

---

## 5. `man`, `whatis`, `whereis`, `locate`, `find`

### 5.1 `man` — Manual pages (full documentation)

```bash
man ls
man 5 passwd     # section 5 = file formats
```

### 5.2 `whatis` — One-line description of a command

```bash
whatis ls
# ls (1) - list directory contents
```

### 5.3 `whereis` — Locate binary, source, and man page

```bash
whereis ls
# ls: /usr/bin/ls /usr/share/man/man1/ls.1.gz
```

### 5.4 `locate` — Fast search using a pre-built index/database

```bash
locate httpd.conf
sudo updatedb     # manually refresh the index database (mlocate.db)
```

### 5.5 `find` — Live, real-time filesystem search

```bash
find / -name "httpd.conf" 2>/dev/null
```

### Comparison Table: `locate` vs `find`

| Feature | `locate` | `find` |
|---------|----------|--------|
| Search method | Searches a pre-built **index/database** (`mlocate.db`) | Searches the **live filesystem** in real time |
| Speed | ⚡ Very fast | 🐢 Slower (scans disk directly) |
| Accuracy | May be outdated if `updatedb` hasn't run recently | Always up-to-date/accurate |
| New/recently created files | ❌ May NOT show up until index updates | ✅ Always shows up |
| Search criteria | Filename only | Name, size, type, time, permissions, owner, and more (very flexible) |
| Needs root/sudo to update DB | `sudo updatedb` | Not needed |

🔴 **Exam Trap:** *"Why did `locate` not find a file I just created?"*
→ Because the `mlocate.db` index hasn't been refreshed yet. Run `sudo updatedb`, or use `find` instead, which always searches live.

---

## 6. Quick-Fire Viva Q&A

| Question | Answer |
|----------|--------|
| Difference between `mv` and `cp`? | `cp` duplicates data (two copies exist); `mv` relocates/renames (one copy, no data duplication) |
| How to force-kill an unresponsive process? | `kill -9 PID` (SIGKILL) |
| How to run a script that survives terminal logout? | `nohup command &` |
| Command to view compressed log without extracting? | `zcat file.gz` |
| How to see how many hard links a file has? | `ls -l` → link count column |
| Can a soft link point to a directory? | Yes; a hard link cannot |
| Fastest way to search for a file by name? | `locate filename` (if index is current) |
| Command to compare two directories? | `diff -r dir1 dir2` |
| Which command shows live CPU/memory usage? | `top` (or `htop`) |
| Difference between `Ctrl+Z` and `kill`? | `Ctrl+Z` suspends (pauses) a job; `kill` terminates it |

---

## 7. One-Page Summary Table (Ultra-Quick Revision)

| Category | Commands |
|----------|----------|
| File ops | `ls`, `cp`, `mv`, `rm`, `cat` |
| Text search/processing | `grep`, `find`, `diff`, `wc`, `sort`, `head`, `tail` |
| Archiving | `tar`, `gzip`/`gunzip`, `zip`/`unzip`, `zcat` |
| Process mgmt | `ps`, `top`, `kill`, `jobs`, `bg`, `fg`, `nohup` |
| Links | `ln` (hard), `ln -s` (soft) |
| Lookup/Help | `man`, `whatis`, `whereis`, `locate`, `find` |

