#!/bin/bash
echo "Please input host to scan"
read host
echo "Scanning host ports from 1..1024"
for port in {1..1024}; do
    nc -z $host $port; # run netcat, if result is 0, port is open
    if [ $? -eq 0 ]
    then
        echo "Port: $port is open"
    fi
done
