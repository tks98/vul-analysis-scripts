#!/bin/bash
echo "Please input host to scan"
read host
echo "Scanning host ports from 1..1024"
for port in {1..1024}; do
  if 2> /dev/null > /dev/tcp/$host/$port; # re-direct stderr (2) to dev/null, # run dev/tcp, if port is open, result is true, echo open port
  then
    echo "port $port is open"
  fi
done
