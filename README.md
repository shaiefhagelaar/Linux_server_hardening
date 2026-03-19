# Linux_server_hardening

Configures Linux server running a webserver comprised of Apache & Nginx 'safe' way. Make sure to check the script if you need any of the services, if you don't use Apache or Nginx make sure to delete those from the script and adjust the rules and/or configurations accordingly. Always apply a zero-trust policy.

Make sure to check which SSH keys are available with a strong algorithm(s) like so:

ssh -Q kex | sort

    Why would you use algorithm(s)? If you use strong & modern algorithm(s) the chances of a malicious actors gaining access to your system will reduce signifcantly, nothing is 100% secure. There're several other steps you can take to reduce the attack surface. Have a look at dependancies/awareness and google the repositories for additional security measure you can take.
    
    curve25519-sha256
    curve25519-sha256@libssh.org
    diffie-hellman-group14-sha1
    diffie-hellman-group14-sha256
    diffie-hellman-group16-sha512
    diffie-hellman-group18-sha512
    diffie-hellman-group1-sha1
    diffie-hellman-group-exchange-sha1
    diffie-hellman-group-exchange-sha256
    ecdh-sha2-nistp256
    ecdh-sha2-nistp384
    ecdh-sha2-nistp521
    sntrup761x25519-sha512@openssh.com


## Source

Google or look up the following prompt:

strong ssh algorithm

https://www.simplified.guide/ssh/kex-algorithms-harden

https://infotechys.com/list-secure-ssh-macs-ciphers-kexalgorithms/#elementor-toc__heading-anchor-1

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
    configuration of sshd file

# Awareness

    Zero trust by default
    Abide by company policies set by the Security Team (aka Security Operations Center/SOC)
    Gamify your policy use feedback ruleset to improve
    Update devices and policies whenever possible after SOC clearance
    
    Clean desk policy
    Usage of a password manager (KeePass etcetera)
    No notes that contain sensitive information
    No usage of BYOD (aka Bring Your Own Device) malicious actors can comprimise devices in the broad sense like: phones; keyboards; mouses; usb's etcetera 

    No hardcoded credentials
    Don't click links or download files, it is possible for malicious actors to spoof e-mails; url's; domains; documents etcetera
    Urgency to reset passwords or fill out forms as soon as possible: contact your IT department
    Understanding behaviour of your employees

    When you use AI make sure that it's running internally and without sharing data
    No sensitive information disclosed in the prompts or code

## Sources

Google or look up the following prompt:

security awareness best practices

https://www.infosecinstitute.com/resources/security-awareness/ultimate-guide/


# ROI (Return Of Investment)

If you do apply all of the above it should significantly reduce the attack service. But be vigilant, the malicious actors are always crafty with their approaches. Applying new & old psychological as well as technical techniques to gain either your trust and/or comprimise systems.
