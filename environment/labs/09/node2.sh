#!/bin/sh

# Lab 09: Discovering AppArmor



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# check AppArmor status
systemctl enable --now apparmor.service
aa-enabled
aa-status

# show defined profiles
ls /etc/apparmor.d
