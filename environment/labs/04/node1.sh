#!/bin/sh

# Lab 04: Using AIDE



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# install AIDE
dnf install -y aide

# initializing database
aide --init
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

# running check
aide --check
echo -e "\nWaiting before continuing..."
sleep 30

# create some changes
touch /usr/bin/hackertool
echo "i bims 1 datei" > /usr/lib64/libsus.so.6

# running check (again)
aide --check
echo -e "\nWaiting before continuing..."
sleep 30

# showing log
less /var/log/aide/aide.log
