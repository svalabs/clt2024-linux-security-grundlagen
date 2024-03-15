#!/bin/sh

# Lab 14: Utilizing Dev-Sec



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_controller
check_user

# cloning the baseline
git clone https://github.com/dev-sec/linux-baseline.git

# analzying node1
inspec exec linux-baseline -t ssh://user@node1 --sudo --password 'SVA2024-SCgLKzeyj9v4maXsxqJuWD'
echo "Waiting before hardening..."
sleep 60

# downloading Ansible content
ansible-galaxy collection install -r requirements.yml

# running Ansible playbook
ansible-playbook hardening.yml -i inventory -kK
echo "Waiting before analyzing for a second time..."
sleep 60

# analyzing node1 (again)
inspec exec linux-baseline -t ssh://user@node1 --sudo --password 'SVA2024-SCgLKzeyj9v4maXsxqJuWD'
