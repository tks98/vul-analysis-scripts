#!/bin/bash
# Travis Smith
# ITMS 543 Vulnerability Analysis and Control
# Fall 2020
# Bash TCP port scanner

# get host from user input
echo "Please input host to scan"
read host
echo "Scanning host ports from 1..1024"

# scan ports
for port in {1..1024}; do
    nc -z $host $port; # run netcat, if result is 0, port is open
    if [ $? -eq 0 ]
    then
        echo "Port: $port is open"
    fi
done
