#!/bin/bash

# Update the system
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# Install and enable firewall
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Secure SSH configuration
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Configure automatic security updates
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Install and configure fail2ban
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo sed -i 's/bantime = 600/bantime = 3600/' /etc/fail2ban/jail.local
sudo sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local
sudo systemctl restart fail2ban

# Install and configure logwatch
sudo apt install logwatch -y
sudo sed -i 's/^Output = mail/Output = file/' /etc/logwatch/conf/logwatch.conf
sudo sed -i 's/^MailTo = root/MailTo = admin@example.com/' /etc/logwatch/conf/logwatch.conf
sudo sed -i 's/^Detail = Low/Detail = Med/' /etc/logwatch/conf/logwatch.conf
sudo systemctl restart logwatch

# Install and configure auditd
sudo apt install auditd -y
sudo systemctl enable auditd
sudo systemctl start auditd

# Configure auditd rules
sudo cat <<EOF > /etc/audit/rules.d/audit.rules
-w /etc/passwd -p wa -k audit_passwd
-w /etc/shadow -p wa -k audit_shadow
-w /etc/group -p wa -k audit_group
-w /etc/sudoers -p wa -k audit_sudoers
-w /var/log/auth.log -p wa -k audit_auth
-w /var/log/syslog -p wa -k audit_syslog
-w /var/log/apache2/ -p wa -k audit_apache
-w /var/log/nginx/ -p wa -k audit_nginx
EOF
sudo systemctl restart auditd

# Install and configure rsyslog
sudo apt install rsyslog -y
sudo sed -i 's/#$ModLoad imudp/$ModLoad imudp/' /etc/rsyslog.conf
sudo sed -i 's/#$ModLoad imtcp/$ModLoad imtcp/' /etc/rsyslog.conf
sudo sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/' /etc/rsyslog.conf
sudo sed -i 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/' /etc/rsyslog.conf
sudo systemctl restart rsyslog

# Install and configure logrotate
sudo apt install logrotate -y
sudo cat <<EOF > /etc/logrotate.d/apache2
/var/log/apache2/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 640 root adm
    sharedscripts
    postrotate
        /bin/kill -HUP `cat /var/run/apache2.pid 2>/dev/null` 2> /dev/null || true
    endscript
}
EOF
sudo cat <<EOF > /etc/logrotate.d/nginx
/var/log/nginx/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 640 root adm
    sharedscripts
    postrotate
        /bin/kill -USR1 `cat /var/run/nginx.pid 2>/dev/null` 2> /dev/null || true
    endscript
}
EOF

# Install and configure fail2ban for Apache and Nginx
sudo apt install fail2ban -y
sudo cat <<EOF > /etc/fail2ban/jail.d/apache-nx.conf
[apache]
enabled = true
port = http,https
filter = apache-auth
logpath = /var/log/apache2/*error.log
maxretry = 3
bantime = 3600

[nginx-http-auth]
enabled = true
port = http,https
filter = nginx-http-auth
logpath = /var/log/nginx/*error.log
maxretry = 3
bantime = 3600
EOF
sudo systemctl restart fail2ban

# Install and configure AppArmor
sudo apt install apparmor apparmor-utils -y
sudo aa-enforce /etc/apparmor.d/*

# Install and configure SELinux
sudo apt install selinux-basics selinux-policy-default -y
sudo sed -i 's/SELINUX=permissive/SELINUX=enforcing/' /etc/selinux/config
sudo reboot
