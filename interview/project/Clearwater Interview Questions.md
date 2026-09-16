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

heaptrace

# HeapTrace Technology — Complete Interview Questions

## 1. Introduction

1. Introduce yourself.
2. Tell me about yourself.

## 2. AWS — General

3. What are the top 5 AWS services you know?
4. Why did you choose AWS?
5. What is the difference between AWS and Azure?
6. If any AWS service goes down at 2 AM, what steps will you follow?
7. How will you host a static website in AWS?
8. What is load balancing?
9. What are the types of AWS Load Balancers?
10. Explain Auto Scaling.
11. What is a Target Group?

## 3. VPC / Networking

12. What is a VPC?
13. What are subnets?
14. What is CIDR and what is its full form?
15. Explain the VPC structure.
16. What was the VPC architecture for your project?
17. What is the difference between a public subnet and a private subnet?
18. How will a private subnet connect to the internet?
19. What is a NAT Gateway?
20. How do you connect to a private EC2 instance?
21. What is a Bastion Host and how does it work?
22. If two EC2 instances are in the same VPC but cannot communicate with each other, what are the possible reasons?
23. If two VPCs are not connected, how will you establish networking between them?

## 4. EC2

24. What is EC2?
25. What is an AMI?
26. What are the different categories/types of EC2 instances?
27. Which EC2 instance type have you used in your project?
28. What was the configuration of that EC2 instance in terms of CPU and RAM?
29. Why did you choose that EC2 instance type?
30. What are the cost optimization strategies for EC2?
31. What is EBS?
32. Why do we need EBS?
33. What is the difference between EBS and S3?
34. How will you store EC2 data in S3?

## 5. Load Balancing

35. What is load balancing and how does it work?
36. What are the different types of AWS Load Balancers?
37. What is a Target Group?
38. How does a Load Balancer communicate with a Target Group?
39. What is a health check in a Load Balancer?

## 6. Lambda

40. What is AWS Lambda?
41. How does Lambda work?
42. What is the maximum execution timeout for Lambda?
43. What are some use cases of Lambda?

## 7. S3

44. What is S3?
45. Should an S3 bucket be public or private, and why?
46. What are the storage classes of S3?
47. What is S3 Versioning?
48. How will you host a static website using S3?
49. What are S3 IAM policies?
50. How will you give an EC2 instance permission to access S3?
51. How will EC2 data be stored in S3?
52. What is the difference between EBS and S3?

## 8. Route 53

53. What is Route 53?
54. What is DNS?
55. If you have registered a domain on GoDaddy, how will you connect it to AWS?
56. How does Route 53 route traffic to an AWS application?

## 9. AWS Security

57. What is a Security Group?
58. What is a NACL?
59. What is the difference between a Security Group and a NACL?
60. What is an inbound rule?
61. What is an outbound rule?
62. What are the default inbound and outbound rules for a Security Group?
63. What is AWS WAF?
64. What is AWS Shield?
65. What is the difference between WAF and Shield?
66. How would you secure an EC2 instance?

## 10. IAM

67. What is IAM?
68. What are IAM policies?
69. What is an IAM Role?
70. What is the difference between an IAM Role and an IAM Policy?
71. How do IAM policies work with S3?
72. How will you define an IAM policy?
73. How will you give an EC2 instance permission to access another AWS service?
74. Why should we avoid hardcoding AWS credentials?

## 11. CI/CD Workflow

75. A developer has pushed code to GitHub. What will be the next steps until the application is available to the end user?
76. Explain the complete CI/CD workflow of your project.
77. Where does Docker fit into the CI/CD pipeline?
78. Where does security scanning fit into the CI/CD pipeline?
79. How do you deploy an application after the Docker image is created?
80. How do you monitor an application after deployment?

## 12. Terraform

81. What is Terraform and why is it used?
82. What is the current version of Terraform?
83. Which providers does Terraform support?
84. What is a `.tf` file?
85. What are the different types of Terraform files?
86. What is a Terraform state file?
87. Why is the Terraform state file important?
88. What is Terraform lifecycle?
89. What is `terraform init`?
90. What is the difference between `terraform plan` and `terraform apply`?
91. What does `terraform plan` compare?
92. What happens if you create infrastructure using Terraform and then make changes using the AWS console?
93. What is configuration drift?
94. How do you detect configuration drift?
95. How do you prevent configuration drift?
96. How do you remediate configuration drift?
97. What happens if two developers are working on the same Terraform state file?
98. How do you solve the Terraform state locking problem?
99. How do you store AWS credentials securely in Terraform?
100.  If you don't want to type `terraform` every time and want to use `tf`, what will you do?
101.  If you want to save the `tf` alias permanently, which file will you configure?

## 13. ECR

102. What is ECR?
103. Why do we use ECR?
104. How does Jenkins push images to private ECR?
105. How does Jenkins pull images from private ECR?
106. How do you authenticate Jenkins with private ECR?

## 14. ECS / Fargate

107. What is AWS ECS?
108. What is a task in AWS ECS?
109. What is a Task Definition?
110. What is the difference between a Task and a Task Definition?
111. What is AWS Fargate?
112. What is the difference between ECS and Fargate?
113. How does ECS pull a Docker image from private ECR?

## 15. Docker

114. What is Docker?
115. Why do we use Docker?
116. What is a Dockerfile?
117. What is the command to get inside a running Docker container's terminal?
118. If you want to see Docker container logs, how will you do it?
119. How will you configure Python in Docker?
120. What is the difference between a Docker image and a container?
121. What is Docker Compose?

## 16. Kubernetes

122. What do you know about Kubernetes?
123. Why do we use Kubernetes?
124. What is Minikube?
125. What is kubectl?
126. What is the difference between Minikube and kubectl?
127. What is a Pod?
128. What is a Deployment?
129. What is a ReplicaSet?
130. What is a Kubernetes Service?
131. What is the difference between a Deployment and a Service?
132. How does Kubernetes expose an application to users?
133. What is an HPA?
134. How does Kubernetes handle pod failures?
135. How does Kubernetes handle pod scheduling issues?
136. If some nodes are overutilized while others are underutilized, how would you diagnose and solve it?

## 17. Jenkins

137. What is Jenkins?
138. Why is Jenkins used?
139. How do you store credentials in Jenkins?
140. How does Jenkins push images to private ECR?
141. How does Jenkins pull images from private ECR?
142. How do you create a Jenkins CI/CD pipeline?
143. What is a Jenkinsfile?
144. What is the difference between CI and CD?

## 18. CloudFormation

145. What is AWS CloudFormation?
146. Why is CloudFormation used?
147. What is the difference between Terraform and CloudFormation?
148. Which one would you prefer between Terraform and CloudFormation, and why?

## 19. Linux / Bash

149. What is Linux?
150. What is Bash?
151. Why is Bash used?
152. What is the first line in a `.sh` file?
153. How will you execute a Bash script in Linux?
154. What does `chmod` do?
155. What does `chown` do?
156. What is the difference between `chmod` and `chown`?
157. What is the use of `grep`?
158. What is the use of `find`?
159. How do you check running processes?
160. How do you check disk usage?
161. How do you check memory usage?
162. How do you check CPU usage?
163. How do you check whether a service is running?

## 20. Project

164. Explain your project.
165. What was your role in the project?
166. What technologies did you use in the project?
167. What was the architecture of your project?
168. Explain the project workflow.
169. How does your CI/CD pipeline work?
170. How is your project different from other projects?
171. What was your biggest contribution to the project?
172. What challenges did you face in the project?
173. How did you solve those challenges?
174. How did you implement security in your project?
175. How did you implement monitoring?
176. How did you deploy your application?
177. How did you use Terraform in your project?
178. How did you use Docker in your project?
179. How did you use Kubernetes in your project?
180. How did you use AWS in your project?
181. Explain your project to a non-technical person in one line.

## 21. High Availability / AWS Architecture

182. What happens if an AWS Region goes down?
183. What happens if an Availability Zone goes down?
184. How does AWS handle high availability?
185. What is the difference between a Region and an Availability Zone?
186. How would you design a highly available application in AWS?
187. How would you handle disaster recovery?

## 22. Deployment / Production Scenarios

188. A critical production deployment introduced unexpected bugs. How would you design a rollback strategy?
189. How would you prevent similar deployment issues in the future?
190. What is a rolling deployment?
191. What is a Blue-Green deployment?
192. What is a Canary deployment?
193. When would you use Blue-Green vs Canary deployment?
194. How would you troubleshoot a production application that suddenly becomes unavailable?

## 23. Infrastructure Drift / Terraform Scenarios

195. You implemented Infrastructure as Code, but production has drifted because of manual changes. How would you detect it?
196. How would you prevent configuration drift?
197. How would you remediate configuration drift?
198. What would happen if someone manually changes an AWS resource created by Terraform?
199. What is the role of `terraform plan` in detecting drift?

## 24. Work Experience

200. Tell me about your work experience.
201. Tell me about your internship experience.
202. What role did you perform?
203. What AWS services have you worked with?
204. What technologies did you use?
205. What challenges did you face in your project/work?
206. What did you personally work on?
207. What was your biggest contribution?
208. What did you learn from your work experience?
209. How is your work experience relevant to this DevOps role?

## 25. AI / Automation

210. How do you use AI in your daily work?
211. How has AI helped you in your learning or development work?
212. Which tasks can you automate to reduce manual work?
213. What DevOps tasks can be automated?
214. How would you use AI in DevOps?
215. Do you blindly trust AI-generated commands or code?
