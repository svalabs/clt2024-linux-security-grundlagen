#!/bin/sh

# Lab 10: Creating AppArmor profiles



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# run strange command
sus
echo "Waiting before auto-creating profile for application"
sleep 30

# create profile
aa-autodep sus
cat /etc/apparmor.d/usr.local.bin.sus
echo "Waiting before enabling Enforce mode"
sleep 30

# enable enforce mode
aa-enforce sus
sus
echo "Waiting before setting profile into complain mode"
sleep 30

# copy profile
cp usr.local.bin.sus /etc/apparmor.d/
chown root:root /etc/apparmor.d/usr.local.bin.sus
chmod 0644 /etc/apparmor.d/usr.local.bin.sus

# load profile
apparmor_parser -r /etc/apparmor.d/usr.local.bin.sus

# start application
/usr/local/bin/sus
exit 0
