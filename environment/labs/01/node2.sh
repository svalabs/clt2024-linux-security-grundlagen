#!/bin/sh

# Lab 01: Analyze/clean-up systems and enable automatic updates



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node2
check_root

# list packages without repository
apt list --installed|fgrep '[installed,local]'

# remove tilde
apt-get remove -y tilde

# trying to auto-remove dependencies (hint: won't work)
apt-get autoremove -y
apt-get remove -y libt3* libtranscript1

# listing installed packages
echo "Listing installed packages..."
sleep 10
dpkg -l

# removing unnecessary packages
apt-get remove --purge -y telnet cowsay figlet

# installing unattended-upgrades
apt-get install -y unattended-upgrades

# create configuration file
cp 20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

# run functional test
unattended-upgrades --dry-run --debug

# enable service
systemctl enable --now unattended-upgrades.service
