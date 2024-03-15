#!/bin/sh

# Lab 06: Managing SELinux file context



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# changing DocumentRoot
sed -i "s/\/var\/www\/html/\/data/g" /etc/httpd/conf.d/vhosts.conf
mkdir /data
echo "Hello World" > /data/index.html

# start Apache and check access
systemctl enable --now httpd
systemctl restart httpd
curl http://localhost
tail /var/log/httpd/error_log
echo "Waiting before temporarily disabling SELinux"
sleep 60

# temporarily disable SELinux and check if problem persists
setenforce 0
getenforce
curl http://localhost
echo "Waiting before checking file context"
sleep 30

# checking file context
setenforce 1
getenforce
ls -Zd1 /var/www/html /data
ls -Z1 /data/index.html
echo "Waiting before temporarily setting file context"
sleep 30

# temporarily set file context
chcon -t httpd_sys_content_t /data/index.html
curl http://localhost
restorecon -Rv /data
echo "Waiting before make file context change persistent"
sleep 30

# set file context persistently
semanage fcontext -a -t httpd_sys_content_t "/data(/.*)?"
restorecon -Rv /data
curl http://localhost
echo "Waiting before resetting DocumentRoot change"
sleep 30

# reset DocumentRoot
sed -i "s/\/data/\/var\/www\/html/g" /etc/httpd/conf.d/vhosts.conf
systemctl restart httpd
