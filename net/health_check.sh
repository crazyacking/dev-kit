#!/usr/bin/env bash

ips=(
192.168.0.148
192.168.0.149
192.168.0.150
192.168.0.151
)

while true ; do
  for ip in "${ips[@]}"; do {
    endpoint="http://$ip:7480"
    res=`curl -m 1 -fIsS ${endpoint} | head -n 1`
    echo ${endpoint} ${res} > health.log
  } &
  done
  sleep 1
done