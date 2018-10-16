#! /bin/bash
clear

ips=(
127.0.0.1
127.0.0.2
127.0.0.3
127.0.0.4
)

for ip in "${ips[@]}"
do 
     echo '-------------------------------------'
    echo [$ip] beginning...

    endpoint=root@${ip}
    ssh-copy-id $endpoint
done
