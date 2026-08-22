# Interview - Consolidated

## Symmetric & Asymmetric Encryption / Diffie-Hellman

### 11.21 Scenario-Based Quick Answers

| Scenario | Attack/Issue |
|---|---|
| Attacker modifies messages between user and server | MITM |
| Attacker tries every possible key | Brute-force attack |
| Attacker tries "password", "admin123", etc. | Dictionary attack |
| Attacker finds two files with the same hash | Birthday/collision attack |
| Attacker measures CPU time to learn the key | Side-channel (timing) attack |
| Attacker resends a captured login message | Replay attack |
| Attacker knows plaintext and matching ciphertext | Known plaintext attack |
| Attacker repeatedly modifies ciphertext, watches errors | Chosen ciphertext attack (e.g., padding oracle) |
| Company still uses DES | Weak/deprecated algorithm |
| Keys generated from timestamps | Weak randomness |
| AES-256 key stored in GitHub source code | Poor key management |
| Server supports old TLS/weak ciphers | Cryptographic configuration weakness |

> **Interview-Ready Answer (Crypto Attacks Overview):** Cryptographic attacks try to break or bypass encryption, hashing, authentication, or key exchange. Examples: brute force, MITM, replay, birthday attacks, side-channel attacks, chosen-ciphertext attacks. Many real failures also come from weak algorithms, bad randomness, poor key management, wrong implementation, or bad configuration — not just broken math.

> **Interview-Ready Answer (MITM):** A MITM attack happens when an attacker secretly intercepts communication between two parties, possibly reading or changing messages while both sides think they're talking directly to each other. Reduced by authenticated key exchange, certificate validation, digital signatures, and correct TLS setup.

> **Interview-Ready Answer (Birthday Attack):** A birthday attack targets a hash function's collision resistance — finding two different inputs with the same hash. Due to the birthday paradox, an n-bit hash gives only about `2^(n/2)` resistance to generic collision attacks, not `2^n`.

> **Interview-Ready Answer (Replay Attack):** A replay attack is when an attacker captures a valid message/request and sends it again later. Prevented using nonces, timestamps, sequence numbers, one-time tokens, and anti-replay checks.

> **Interview-Ready Answer (Side-Channel):** A side-channel attack learns secrets by observing how a system behaves while doing crypto operations (time, power, cache) instead of attacking the algorithm's math directly.

> **Interview-Ready Answer (Poor Key Management):** Poor key management means insecure key generation, storage, distribution, reuse, rotation, or destruction. Even strong AES encryption fails if attackers can steal or guess the key.

---

## PKI

### PART 16: MOST IMPORTANT INTERVIEW QUESTIONS

1. What is PKI, and why is it needed?
2. Why is PKI called "people + process + technology"?
3. What is X.509?
4. What security services can PKI support?
5. CA vs RA?
6. What is a digital certificate, and what does it contain?
7. What is a TSA? What is an HSM?
8. Why should CA keys be stored in HSMs?
9. Root CA vs Intermediate CA — why not let root issue end-user certs directly?
10. What is a self-signed certificate? Is it automatically trusted?
11. What is a chain of trust, and how does a browser verify it?
12. Hierarchical vs Mesh vs Bridge PKI models?
13. What is Proof of Possession (PoP)?
14. What is a CSR (PKCS #10), and what does it contain?
15. Which key signs the CSR? Which key signs the final certificate?
16. What is X.509 v3, and why do extensions matter?
17. Explain SAN, Key Usage, EKU, Basic Constraints, AKI, SKI.
18. DV vs OV vs EV certificates?
19. What are Indian DSC classes?
20. PEM vs DER? P7B vs PFX/P12?
21. What is a CRL? What is OCSP? CRL vs OCSP?
22. What is OCSP Stapling?
23. Renewal vs Expiration vs Revocation?
24. What is CP? What is CPS? CP vs CPS?
25. Explain PKCS #1 / #5 / #7 / #8 / #10 / #11 / #12.
26. What is FIPS 140-2 vs FIPS 140-3?
27. What is CMVP?

---
