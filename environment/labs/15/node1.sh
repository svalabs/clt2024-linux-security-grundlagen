#!/bin/sh

# Lab 15: Creating a InSpec profile



# check hostname and user
source `dirname ${0}`/../functions.sh || exit
check_controller
check_user

# run InSpec
inspec exec mycompany-baseline -t ssh://user@node1 --password 'SVA2024-SCgLKzeyj9v4maXsxqJuWD'
