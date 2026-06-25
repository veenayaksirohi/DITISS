Compliane Audit 

Why to use latest Versions - Vuln patch 
Stable Release
TLS 
SSL ==> Many Vuln 


Compliance Audit ==> Provide basic level of security + 
Addit follow minimum compliance 

DMZ Zone ==> filter data before reaching the network 

Internet
   │
[Firewall]
   │
 DMZ ─ Public Servers
   │
[Firewall]
   │
Internal Network ─ Private/Trusted Servers & Devices

CHeck Permission of /etc/passwd 
in ubuntu 
in seliux 

Learn in detain passwd and shadow syntax ls syntax + permission r,w,,x,s 

harsh@Harshal96507C1:/mnt/c/Users/harsh$ ls -l /usr/bin/passwd
-rwsr-xr-x 1 root root 64152 May 30  2024 /usr/bin/passwd
harsh@Harshal96507C1:/mnt/c/Users/harsh$


What is MAC/DAC

Ansible => Automated configuration 

what can be the vulnera with ansible playbook ?? 

nmcli 
nmtli 
Diff betn passwd and shadow all scenario
Kerberos and all ==> GFG
Differnet firewall and generation 
	ufw firewalld iptables 

Seven principle of GDPR

# Sticky Bit 
```
Sticky Bit in Linux ==> try to apply sticky bit 
sticky bit is indicated by t 

harsh@Harshal96507C1:/mnt/c/Users/harsh$ ls -ld /tmp
drwxrwxrwt 11 root root 12288 Jun  9 05:58 /tmp

drwxrwxrwt
         ^

The t indicates Sticky Bit is enabled.

How to apply sticky bit Directory/folder  
					chmod +t shared_dir 
```

SSL/TLS and Diff ==> Imp


---------------------------------------------------------------------------------------------------------------------------------

Compliance Audit 

1. Identify and Perimeter Audit - Focus on user login eCircle and perimeter form where Authentication take place; Whol is responsible to Authenticate 
	A) Zero-Trust Architecture -  Verify that no device or user is trusted by default; never inside the perimeter as well 


	B) MFA 
		1. smtng you know ==> Password , OTP . 
		2. smtng you have ==> PAN AADHAR 
		3. smthng you are ==> biometric scan 
		4. sm where you are  ==> IP address

	C) Least Privileage Access - RBAC 
	
	D) Microsegmentation - Desing a separate Network Segments for each different projects if possible according to organization policy 


2. Visibility and Discovery Audit ==> Focuses on device and network visibility outside of perimeter ==>  Block All the BYOD Devices 
                Endpoint (url+port)


3. Devsecops and Configuration Audit 
    1. Continous Configuraton Audit - Evaluate The softwae and Tool that continously access the location and respective data for any knid of unAuthorized changes or accidently public exposure of critical data 
    2. Vulnerability and Compliance Audit - Software vulnerability checks to be do ealways development stage; Integration stage and at last at development stage; integrating stage and at last at deployment stage 


HIPPA 
GPDR
DPDP




Target               Artifacts  
Zero Trust          conditional Access Polic Configuraton 
What is proves to Author - confirm that access control is role based lacation based and follows MFA 
CI/CD Pipeline - Proves security Scanning is done in development not in deployment 


Incoming Deletion Request 
            


