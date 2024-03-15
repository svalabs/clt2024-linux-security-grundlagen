#!/bin/sh

# Lab 13: Utilizing fail2ban



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_node1
check_root

unban_ip () {
    # wait for banned IPs
    ips=`fail2ban-client get sshd banned | tr -d "[]' "`
    while [ -z "${ips}" ]; do
        echo "Waiting until IP addresses were banned..."
        sleep 10
        ips=`fail2ban-client get sshd banned | tr -d "[]' "`
    done
    # unban banned IPs
    ips=`echo ${ips} | tr ",", "\n"`
    for ip in ${ips}; do
        echo "Unbanning ${ip}"
        fail2ban-client unban ip ${ip}
    done
}

# copy jail configuration
cp 10-sshd.conf /etc/fail2ban/jail.d/
chown root:root /etc/fail2ban/jail.d/10-sshd.conf
chmod 0644 /etc/fail2ban/jail.d/10-sshd.conf

# start fail2ban and check status
systemctl enable --now fail2ban
fail2ban-client status
echo "Banned IPs:"
fail2ban-client get sshd banned
echo "Waiting before checking banned IPs..."
sleep 60

# check for banned IP and unban it
unban_ip
