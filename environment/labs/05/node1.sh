#!/bin/sh

# Lab 05: Discovering SELinux



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1

# show SELinux mode
getenforce
cat /etc/sysconfig/selinux
echo "Waiting before showing process and file contexts"
sleep 30

# show SELinux process context
ps -Z

# show SELinux file context
ls -lZd
