#!/bin/sh

# Lab 03: Alter ServerTokens



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check ServerTokens
curl -I http://localhost
sleep 10

# install mod_security
dnf install -y mod_security

# copy configuration
cp serversignature.conf /etc/httpd/conf.d/serversignature.conf
chown root: /etc/httpd/conf.d/serversignature.conf
chmod 0644 /etc/httpd/conf.d/serversignature.conf

# reload apache configuration
systemctl reload httpd

# check ServerTokens again
curl -I http://localhost

# try to fingerprint web server
nmap -sV -p T:80 localhost
