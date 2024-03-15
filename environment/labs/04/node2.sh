#!/bin/sh

# Lab 04: Using AIDE



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# install AIDE
apt-get install -y aide

# initializing database
aideinit
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# running check
aide --config /etc/aide/aide.conf --check
echo -e "\nWaiting before continuing..."
sleep 30

# create some changes
touch /usr/bin/hackertool
echo "i bims 1 datei" > /usr/lib64/libsus.so.6

# running check (again)
aide --config /etc/aide/aide.conf --check
echo -e "\nWaiting before continuing..."
