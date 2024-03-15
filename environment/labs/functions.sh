#!/bin/sh

function check_controller {
    # check hostname
    if [[ "`hostname`" != *"controller"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on controller."
        echo ""
        exit 1
    fi
}

function check_node {
    if [[ "`hostname`" != *"node"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node1 and/or node2."
        echo ""
        exit 1
    fi
}

function check_node1 {
    if [[ "`hostname`" != *"node1"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node1."
        echo ""
        exit 1
    fi
}

function check_node2 {
    if [[ "`hostname`" != *"node2"* ]]; then
        echo "ERROR: You're running the script on the wrong node."
        echo "Please run this script on node2."
        echo ""
        exit 1
    fi
}

function check_root {
    if [[ "${EUID}" != 0 ]]; then
        echo "ERROR: You're running the script without root permissions."
        echo "Please run this script as root user."
        echo ""
        exit 1
    fi
}

function check_user {
    if [[ "${USER}" != "user" ]]; then
        echo "ERROR: You're running the script with root permissions."
        echo "Please run this script as user 'user'."
        echo ""
        exit 1
    fi
}