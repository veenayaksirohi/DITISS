---
title: "03 - Programming Concepts Syllabus and Interview Checklist"
aliases:
  - "Programming Concepts (MySQL + Python) — CDAC DITISS Syllabus"
tags:
  - programming
  - python
  - mysql
  - syllabus
  - interview-preparation
  - moc
syllabus-topic: []
---

# Programming Concepts (MySQL + Python) — Interview Checklist

**Duration:** 90 hrs (30T + 40L + 20SL) | **CMCE Module**
**Courseware:** Learning with Python (Allen Downey); Python for Unix and Linux System Administration

---

## Completion Checklist

- [ ] MySQL: databases, tables, schemas, ER diagrams
- [ ] SELECT / WHERE / ORDER BY / JOIN
- [ ] Aggregate functions, GROUP BY, HAVING, subqueries
- [ ] MySQL security — users/roles/privileges, SQL injection
- [ ] Backup/restore, cloud databases (RDS)
- [ ] Python basics, data types, functions
- [ ] Dictionaries, Lists, Tuples, Sets
- [ ] Regular expressions, file handling
- [ ] OOP, sockets, exploit basics via sockets
- [ ] Algorithmic problem solving

---

## 🔴 Priority 1 — Must Know

- [ ] SQL fundamentals — CREATE/DROP DB, tables, schemas, ER diagrams
- [ ] SELECT, WHERE, ORDER BY, JOINs (INNER/basic)
- [ ] Aggregate functions (SUM, COUNT, AVG), GROUP BY, HAVING, subqueries
- [ ] SQL Injection concepts, GRANT/REVOKE, principle of least privilege
- [ ] Python basics — data types, functions, loops, conditionals
- [ ] Lists, Dictionaries, Tuples, Sets — CRUD operations
- [ ] File handling, regular expressions (re module)
- [ ] Socket programming basics (client-server)

## 🟠 Priority 2 — Important

- [ ] Backup/Restore concepts — logical vs physical backup, disaster recovery
- [ ] On-prem vs Cloud MySQL (RDS), vertical vs horizontal scaling, indexing, slow queries
- [ ] OOP in Python — classes, objects
- [ ] Directory/file operations — os/path handling, permissions checks
- [ ] Common algorithm patterns: sliding window, two-pointer, sorting/searching, time complexity

## 🟡 Priority 3 — Good to Know

- [ ] Number theory, bit manipulation, divide-and-conquer vs DP
- [ ] Exploit development basics via sockets, debugging techniques
- [ ] Libraries: hashlib, shodan, datetime

---

## 📌 Common Coding Interview Patterns Covered

- Longest consecutive sequence (O(n))
- Product of array except self
- Merge overlapping intervals
- Longest substring without repeating characters
- Longest palindromic substring
- Valid parentheses matching
- Single number (XOR trick)
- GCD of two numbers
- CamelCase → snake_case conversion using regex
- IP address leading-zero stripping

## 📌 SQL vs Python Security Quick Reference

| Concept | Risk | Mitigation |
|---|---|---|
| SQL Injection | Unsanitized input in queries | Parameterized queries, least privilege DB users |
| Unauthorized DB access | Over-privileged accounts | GRANT only needed privileges, use readonly_user for reporting |
| Data leakage | Poor error handling exposing schema | Generic error messages, logging separate from user output |

---

## Related Notes
- [[00 - PGCP-ITISS Full Syllabus and Interview Checklist]]
