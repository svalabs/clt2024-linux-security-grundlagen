#!/bin/sh

# Lab 07: Managing SELinux booleans



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# check web application
curl http://localhost/app.php

# check SELinux log
audit2why -i /var/log/audit/audit.log
echo "Waiting before showing SELinux booleans"
sleep 30

# show SELinux booleans
getsebool -a | less

# permanently setting a boolean
setsebool -P httpd_can_network_connect on
getsebool httpd_can_network_connect

# check web application
curl http://localhost/app.php
