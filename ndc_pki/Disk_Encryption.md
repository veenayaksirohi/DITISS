# EFS — Encrypting File System (Windows)

> **Tool:** `cipher.exe` (built-in Windows command)
> **Topic:** CDAC DITISS — OS Security / File System Security
> **Exam Tag:** EFS · NTFS Encryption · cipher command

---

## Table of Contents

1. [What is EFS?](#1-what-is-efs)
2. [How EFS Works (Internals)](#2-how-efs-works-internals)
3. [Lab Setup — Folder & File Structure](#3-lab-setup--folder--file-structure)
4. [cipher Commands](#4-cipher-commands)
5. [EFS Behaviour on New Files](#5-efs-behaviour-on-new-files)
6. [Recursive Encryption](#6-recursive-encryption)
7. [Decryption](#7-decryption)
8. [Status Indicators](#8-status-indicators)
9. [Common Exam Traps](#9-common-exam-traps)
10. [Viva Q&A](#10-viva-qa)

---

## 1. What is EFS?

**EFS (Encrypting File System)** is a Windows NTFS feature that allows files and folders to be encrypted **transparently** using the logged-in user's certificate and key pair.

| Property             | Detail                                            |
| -------------------- | ------------------------------------------------- |
| OS Support           | Windows NTFS only (not FAT32, not exFAT)          |
| Built-in tool        | `cipher.exe`                                      |
| Key type             | Symmetric key (FEK) wrapped with RSA public key   |
| Transparent to owner | Owner reads files normally without manual decrypt |
| Others cannot read   | Other users see gibberish / Access Denied         |

---

## 2. How EFS Works (Internals)

```
File to encrypt
      │
      ▼
Generate FEK (File Encryption Key)
  [random symmetric key]
      │
      ├─── Encrypt FILE DATA with FEK (AES)
      │
      └─── Encrypt FEK with USER's RSA Public Key
                  │
                  ▼
           Stored in file's
           DDF (Data Decryption Field)

To decrypt:
  User's RSA Private Key → decrypts FEK → decrypts File
```

> **Key Point for Exam:**
> EFS uses **hybrid encryption** — symmetric (AES) for data, asymmetric (RSA) for the key.

---

## 3. Lab Setup — Folder & File Structure

Create the following structure before running commands:

```
one\
└── oneone\
        a.txt    ← created during lab
        b.txt    ← created during lab
```

Create folder and file manually or via command:

```cmd
mkdir one\oneone
echo test > one\oneone\a.txt
```

---

## 4. cipher Commands

### 4.1 Encrypt a Folder

```cmd
cipher /e one\oneone
```

| Part         | Meaning               |
| ------------ | --------------------- |
| `cipher`     | EFS command-line tool |
| `/e`         | Encrypt flag          |
| `one\oneone` | Target folder path    |

> **Effect:** Marks the folder as encrypted.
> Files **already inside** are NOT encrypted yet.
> **New files created inside** WILL be automatically encrypted.

---

### 4.2 Check Encryption Status of a Folder

```cmd
cipher one\oneone\
```

> No flag = status check only. No encryption/decryption happens.

#### Output legend:

```
U = Unencrypted
E = Encrypted
```

Example output:

```
 Listing one\oneone\
 New files added to this directory will be encrypted.

U  a.txt
E  b.txt
```

---

### 4.3 Create a New File and Verify Auto-Encryption

```cmd
echo hello > one\oneone\a.txt
```

or (PowerShell / bash on Windows):

```cmd
type nul > one\oneone\a.txt
```

Now check status:

```cmd
cipher one\oneone\
```

Expected output:

```
E  a.txt
```

> **Why auto-encrypted?**
> The folder was marked `/e` — any new file created inherits the encryption attribute.

---

### 4.4 Encrypt All Files Already in a Folder (Non-Recursive)

```cmd
cipher /e one\oneone
```

> This encrypts **existing files** in `one\oneone` but NOT files in subfolders.

---

## 5. EFS Behaviour on New Files

| Scenario                                     | Result                                      |
| -------------------------------------------- | ------------------------------------------- |
| Folder marked `/e`, new file created         | File is **auto-encrypted** (E)              |
| Folder marked `/e`, file copied from outside | File **inherits** encryption                |
| Folder marked `/e`, existing files           | NOT encrypted until you run `/e` explicitly |
| File moved to non-EFS folder                 | File may **lose** encryption                |
| File copied to FAT32/USB                     | Encryption **stripped** (FAT32 has no EFS)  |

---

## 6. Recursive Encryption

To encrypt **all files and subfolders** inside a directory tree:

```cmd
cipher /e /s:one\oneone
```

| Flag      | Meaning                                              |
| --------- | ---------------------------------------------------- |
| `/e`      | Encrypt                                              |
| `/s:path` | Recursive — apply to all subdirectories under `path` |

> **Syntax note:** `/s:` takes the path immediately after the colon — no space.

#### Example — Full Recursive Encrypt:

```cmd
cipher /e /s:one\oneone
```

This encrypts:

```
one\oneone\            ← folder attribute set
one\oneone\a.txt       ← encrypted
one\oneone\b.txt       ← encrypted
one\oneone\sub1\       ← subfolder attribute set
one\oneone\sub1\c.txt  ← encrypted
```

---

## 7. Decryption

### Decrypt a Single Folder

```cmd
cipher /d one\oneone
```

### Decrypt Recursively

```cmd
cipher /d /s:one\oneone
```

> **Effect:** Removes the encryption attribute from folder.
> Existing encrypted files stay encrypted until explicitly decrypted.

---

## 8. Status Indicators

### Full Status of All Files in a Folder

```cmd
cipher one\oneone\
```

### Verbose Mode — Show Key Info

```cmd
cipher /c one\oneone\a.txt
```

Shows:

```
Encrypted file:   one\oneone\a.txt
Compatible with Windows XP: No
Encryption Algorithm: AES-256
Certificate thumbprint: AB CD EF ...
```

---

## 9. Common Exam Traps

| Trap                                              | Correct Understanding                                                                          |
| ------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| "Encrypting a folder encrypts all existing files" | **FALSE** — only marks folder; new files are auto-encrypted; existing files need explicit `/e` |
| "EFS works on FAT32"                              | **FALSE** — EFS is NTFS only                                                                   |
| "cipher /e folder encrypts recursively"           | **FALSE** — use `/s:` flag for recursive                                                       |
| "Any user can read an EFS file"                   | **FALSE** — only the encrypting user (or Data Recovery Agent) can read it                      |
| "Copying EFS file to USB keeps encryption"        | **FALSE** — FAT32/exFAT strips EFS                                                             |
| "`cipher` with no flag decrypts"                  | **FALSE** — no flag = **status check**                                                         |

---

## 10. Viva Q&A

**Q1. What is EFS?**
EFS (Encrypting File System) is a Windows NTFS feature that encrypts files transparently using the user's certificate key pair. Only the encrypting user can read the files.

---

**Q2. What algorithm does EFS use?**
EFS uses hybrid encryption:

- **AES** (symmetric) to encrypt the actual file data using a FEK (File Encryption Key)
- **RSA** (asymmetric) to encrypt the FEK using the user's public key

---

**Q3. What is the cipher command used for?**
`cipher.exe` is the Windows built-in command-line tool to encrypt, decrypt, and check the status of EFS-encrypted files and folders.

---

**Q4. What does `cipher /e one\oneone` do?**
It marks the folder `one\oneone` as encrypted. New files created inside will be automatically encrypted. Existing files inside are NOT encrypted until you explicitly encrypt them.

---

**Q5. How do you check if a file is encrypted?**

```cmd
cipher one\oneone\
```

Output shows `E` (Encrypted) or `U` (Unencrypted) for each file.

---

**Q6. How do you encrypt recursively?**

```cmd
cipher /e /s:one\oneone
```

The `/s:` flag applies encryption to all files and subdirectories under the given path.

---

**Q7. What is a FEK?**
FEK = File Encryption Key. It is a randomly generated symmetric key used to encrypt the file's data. The FEK itself is then encrypted with the user's RSA public key and stored in the file's metadata (DDF).

---

**Q8. What happens if the user's certificate is deleted?**
The FEK cannot be decrypted (since the RSA private key is gone), making the encrypted files permanently inaccessible — unless a **Data Recovery Agent (DRA)** certificate was configured.

---

**Q9. What is a Data Recovery Agent (DRA)?**
A DRA is a special administrator certificate configured in Group Policy that can decrypt any EFS-encrypted file in the domain — used for corporate recovery scenarios.

---

## Quick Reference Card

```
cipher /e folder\           → Encrypt folder (new files auto-encrypted)
cipher /e /s:folder\        → Encrypt folder + all subfolders recursively
cipher /d folder\           → Decrypt folder
cipher /d /s:folder\        → Decrypt recursively
cipher folder\              → Check status (U = plain, E = encrypted)
cipher /c file.txt          → Show detailed encryption info for a file
```
