## Clearwater Interview Questions — Corrected Version

### Project & Introduction

1. Introduce yourself.
2. What was your role in the project?
3. Draw your project architecture.
4. Explain the project architecture and overall project flow.
5. What security measures did you implement in your project?
6. Why did you need to implement security in the project?
7. What are your achievements during C-DAC?
8. Why do you think you are a better candidate than others?

### Docker & Kubernetes

9. What is the difference between Docker and Kubernetes?
10. How do Kubernetes Pods communicate with each other?
11. What does a Deployment do in Kubernetes?
12. What is a ReplicaSet?
13. What is a ReplicaSet used for?
14. What are Kubernetes Services used for?
15. If we can deploy an application using Docker, why do we need Kubernetes?
16. How do Pods get the credentials required to access the database?
17. Can a ReplicaSet created by a Deployment be deleted manually? What happens if you delete it?
18. What is the `kind` field used for in a Kubernetes manifest?
19. What format is generally used for Kubernetes Deployment files?
20. Does Kubernetes support formats other than YAML for Deployment manifests?

### AWS & EKS

21. What AWS services are you familiar with?
22. Why did you use Amazon EKS instead of creating and managing your own Kubernetes cluster?

### CI/CD & Secrets

23. What is the difference between Jenkins and GitHub Actions?
24. How do you store credentials and sensitive information in your project?
25. Why should credentials be stored as secrets instead of directly in the code or configuration files?

### DevSecOps & Security Tools

26. What does Trivy scan?
27. What does SonarQube do?
28. How does Falco monitor or collect security events from applications running in other Pods?
29. What is a SIEM?
30. How does Wazuh work?
31. What is a CVE?
32. What is a vulnerability?

### Python & OOP

33. What is a class?
34. What is an object?
35. How do you reverse a string in Python?
36. How does `[::-1]` work in Python?

Example:

```python
text = "hello"
print(text[::-1])
```

Output:

```text
olleh
```

### Cryptography

37. What is a public key?
38. What is a private key?
39. What is the difference between encryption and hashing?
40. If **A wants to send an encrypted message to B**, which key is used for encryption and which key is used for decryption?

### Puzzles / Logical Questions

41. **Two Ropes Puzzle:**
    You have two ropes. Each rope takes exactly **60 minutes to burn completely**, but they do not burn at a uniform rate. How can you measure exactly **45 minutes**?

42. **Two Glass Balls and N-Floor Building Puzzle:**
    You have **two glass balls** and a building with **N floors**. You need to find the highest floor from which a ball can be dropped without breaking. How would you minimize the number of drops in the worst case?

43. **Missing Number Puzzle:**
    You have a series containing numbers from **1 to 100**, but one number is missing. How would you find the missing number?

44. **Clock Angle Puzzle:**
    What is the angle between the **hour hand and minute hand at 12:12**?

For question 44, the correct answer is **66°**:

- Minute hand at 12 minutes = `12 × 6° = 72°`
- Hour hand moves `0.5°` per minute.
- Hour hand at 12:12 = `12 × 0.5° = 6°`
- Angle = `72° − 6° = 66°`
