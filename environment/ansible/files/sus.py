#!/usr/bin/env python3
"""
Suspicious application
"""
FILES = [
    '/home/user/.bashrc',
    '/etc/profile',
    '/var/run/crond.pid'
]

# read _all_ the files
for file in FILES:
    try:
        with open(file, encoding="utf-8") as f:
            content = f
            print(f"Successfully read file {file}")
    except PermissionError:
        print(f"Unable to read file {file}")
