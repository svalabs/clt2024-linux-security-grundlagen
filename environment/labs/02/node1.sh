#!/bin/sh

# Lab 02: Check and fix filesystem permissions



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

# find files with too broad permissions
find / -type f -perm 777
echo -e "\n\nweb-passwords looks suspicious - here is its content:\n\n"
cat /var/www/html/web-passwords
echo -e "\n\nWaiting before showing next results\n\n"
sleep 30

# find files with setuid
find / -perm /4000
echo -e "\n\nnotarootshell looks suspicious - here is its content:\n\n"
cat /usr/bin/notarootshell
echo -e "\n\nWaiting before showing next results\n\n"
sleep 30

# find files with setgid
find / -perm /2000
echo -e "\n\ndatabase_dispatcher.php looks suspicious - here is its content:\n\n"
cat /var/www/html/database_dispatcher.php
echo -e "\n\nWaiting before showing next results\n\n"
sleep 30

# find files with sticky bit
find / -perm /1000
echo -e "\n\nNo suspicious results. Waiting before removing too broad permissions.\n\n"
sleep 30

# remove too broad permissions
chmod u-x,g-x,o-rwx /var/www/html/web-passwords
chmod u-s /usr/bin/notarootshell
chmod g-s /var/www/html/database_dispatcher.php
