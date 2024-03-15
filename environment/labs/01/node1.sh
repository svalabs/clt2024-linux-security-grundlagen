#!/bin/sh

# Lab 01: Analyze/clean-up systems and enable automatic updates



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# list packages without repository
dnf list installed | grep commandline

# remove tilde
dnf remove -y tilde

# trying to auto-remove dependencies (hint: won't work)
dnf autoremove -y
dnf remove -y libt3* libtranscript1

# listing installed packages
echo "Listing installed packages..."
sleep 10
rpm -qa | less

# removing unnecessary packages
dnf remove -y telnet cowsay figlet

# installing dnf-automatic
dnf install -y dnf-automatic

# alter configuration file
cp automatic.conf /etc/dnf/automatic.conf

# enable timer
systemctl enable --now dnf-automatic.timer
