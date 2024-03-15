#!/bin/sh

# Lab 08: Managing SELinux ports



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# changing listen port
sed -i "s/^Listen 80/Listen 1337/g" /etc/httpd/conf/httpd.conf
systemctl restart httpd
systemctl status httpd
echo "Waiting before temporarily disabling SELinux"
sleep 30

# temporarily disable SELinux
setenforce 0
getenforce
systemctl restart httpd
curl http://localhost:1337
echo "Waiting before adding a new port definition"
sleep 30

# add a new port definition for httpd
setenforce 1
getenforce
semanage port -l|grep ^http
semanage port -a -t http_port_t -p tcp 1337
semanage port -l|grep ^http
systemctl restart httpd
curl http://localhost:1337
