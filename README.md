# Linux_server_hardening

Configures Linux server running a webserver comprised of Apache & Nginx 'safe' way. Make sure to check the script if you need any of the services, if you don't use Apache or Nginx make sure to delete those from the script and adjust the rules and/or configurations accordingly. Always apply a zero-trust policy.


# Dependancies

    ufw firewall
    fail2ban
    logwatch
    rsyslog
    logrotate
    apparmor 
    apparmor-utils
    selinux-basics
    selinux-policy-default
