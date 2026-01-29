#!/bin/bash

echo "Updating system..."
dnf update -y

echo "Installing security packages..."
dnf install firewalld fail2ban -y

systemctl enable firewalld --now
systemctl enable fail2ban --now

echo "Configuring firewall..."
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload

echo "Hardening SSH..."
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

systemctl restart sshd

echo "Hardening complete."

