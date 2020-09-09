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
# start timer
start=$(date +%s.%N)
for port in {1..1024}; do
  if 2> /dev/null > /dev/tcp/$host/$port; # re-direct stderr (2) to dev/null, run dev/tcp, if port is open, result is true, echo open port
  then
    echo "port $port is open"
  fi
done

# calculate time taken
finish=$(echo "$(date +%s.%N) - $start" | bc) # pipe expression into bc calulator to get runtime
echo "Scan took $finish seconds"
