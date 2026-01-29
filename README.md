# Secure AWS Production EC2 (Linux Hardening – RHEL)

## 📌 Project Overview

This project demonstrates how to secure a production-grade AWS EC2 Linux server using **industry-standard hardening and monitoring practices**.  
The goal is to protect the server against unauthorized access, brute-force attacks, and resource exhaustion while maintaining visibility through monitoring and alerts.

This setup is suitable for **real-world production environments** and addresses a very common client concern:

> “My server got hacked / I’m afraid my AWS EC2 is not secure.”

---

## 🎯 Client Problem

- Fear of unauthorized SSH access
- Risk of brute-force login attempts
- No monitoring or alerts for high CPU or disk usage
- Overly open firewall rules
- Lack of security visibility

---

## ✅ Solution Summary

A **defense-in-depth security approach** was implemented using multiple layers:

- AWS IAM (least privilege)
- EC2 Security Groups
- OS-level firewall hardening
- SSH hardening with key-based authentication
- Fail2Ban for brute-force protection
- CloudWatch monitoring and alerts
- Professional dashboards for visibility

---

## 🧱 Architecture Overview

**Security Layers Implemented:**

1. AWS IAM (root + least-privilege IAM users)
2. EC2 Security Groups (network firewall)
3. firewalld (OS-level firewall)
4. SSH hardening (key-based access only)
5. Fail2Ban (using `jail.local`)
6. CloudWatch metrics, alarms, and dashboards

Architecture diagram available in:
/docs/architecture.png


---

## ☁️ AWS Configuration

### EC2
- Instance Type: `t2.medium`
- OS: **Red Hat Enterprise Linux (RHEL)**
- Elastic IP attached for stable access
- Root volume: gp3

### IAM Design (Best Practice)
- **Root account** used only for infrastructure creation
- **IAM Role attached to EC2**:
  - `CloudWatchAgentServerPolicy`
- **IAM Monitoring User**:
  - `AmazonEC2ReadOnlyAccess`
  - `CloudWatchReadOnlyAccess`

This ensures **strict separation between human access and service permissions**.

---

## 🔐 Network Security

### Security Groups
- SSH (22): **Allowed only from a trusted IP**
- HTTP/HTTPS: Optional (if required by application)
- No public SSH access (`0.0.0.0/0` is strictly avoided)

---

## 🔥 OS Firewall Hardening (firewalld)

- firewalld enabled and enforced
- Only required services allowed
- SSH restricted using **rich rules**

### SSH Access Policy
- SSH access allowed **only from the Elastic IP**
- Rich rule added explicitly for Elastic IP
- All other SSH traffic denied

This ensures that even if Security Groups are misconfigured, the OS firewall remains protected.

---

## 🔑 SSH Hardening

The SSH service was hardened using industry best practices:

- Root login disabled
- Password authentication disabled
- Key-based authentication enforced
- SSH access restricted to authorized user only
- Limited authentication attempts

Result:
- No password-based logins
- No root SSH access
- Reduced attack surface

---

## 🚫 Brute-Force Protection (Fail2Ban)

Fail2Ban was configured to protect SSH from repeated login attempts.

### Configuration Approach
- Default configuration **was not modified**
- Custom rules applied using:
/etc/fail2ban/jail.local


### SSH Jail Settings
- SSH jail enabled
- Maximum retry limit enforced
- Automatic IP banning after repeated failures
- Ban duration configured for production safety

This approach follows **Fail2Ban best practices** and ensures configuration persistence across updates.

---

## 📊 Monitoring & Alerts (CloudWatch)

### Metrics Monitored
- CPU Utilization (default EC2 metric)
- Disk Usage (via CloudWatch Agent)

### Alarms Configured
- **CPU Utilization > 80%**
- **Disk Usage > 75%**

Alarms help detect:
- Performance bottlenecks
- Capacity issues
- Potential denial-of-service conditions

---

## 📈 CloudWatch Dashboard

A professional CloudWatch dashboard was created to provide real-time visibility.

### Dashboard Widgets
- EC2 CPU Utilization (line graph)
- Root Disk Usage Percentage
- Alarm Status Overview



This dashboard enables **quick operational decision-making**.

---

## 🛠️ Automation

A Bash hardening script was created to automate key security tasks.

Location:

Includes:
- System updates
- Firewall setup
- SSH hardening
- Security service enablement

Automation ensures **consistency and repeatability**.

---


---

## 🎉 Final Result

✔ SSH access restricted to Elastic IP  
✔ Root login fully disabled  
✔ Brute-force attacks automatically blocked  
✔ Firewall hardened at OS and AWS level  
✔ Real-time monitoring with alerts  
✔ Production-ready security posture  

---

## 🧠 Key Takeaways

- Least privilege IAM is critical for security
- Defense-in-depth prevents single-point failures
- Monitoring is as important as hardening
- Automation increases reliability
- This setup reflects **real-world enterprise practices**

---

## 📸 Screenshots (for LinkedIn & Portfolio)

- EC2 instance running
- Security Group rules
- firewalld rules
- Fail2Ban status
- CloudWatch alarms
- CloudWatch dashboard

---

## 🚀 Use Case

This project is ideal for:
- Securing new AWS EC2 servers
- Fixing hacked or vulnerable servers
- Freelance DevOps & Cloud Security services
- Production Linux environments

---

**Author:**  
Syed Amjad Ali  
DevOps | Cloud | Linux Security


