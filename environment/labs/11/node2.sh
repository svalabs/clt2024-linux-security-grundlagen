#!/bin/sh

# Lab 11: Managing AppArmor



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# checking loaded profiles
aa-status
echo "Waiting before removing the sus module..."
sleep 30

# removing the sus module
ln -s /etc/apparmor.d/usr.local.bin.sus /etc/apparmor.d/disable/
apparmor_parser -R /etc/apparmor.d/usr.local.bin.sus
echo "Waiting before manually loading AppArmor profile to complain mode"
sleep 30

rm /etc/apparmor.d/disable/usr.local.bin.sus
apparmor_parser -C /etc/apparmor.d/usr.local.bin.sus
echo "Waiting before stopping AppArmor"
sleep 30

# stopping AppArmor
systemctl stop apparmor.service
aa-teardown
echo "Waiting before starting AppArmor again"
sleep 30

# starting AppArmor
systemctl start apparmor.service
aa-status
