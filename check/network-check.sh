#! /bin/bash
# worker09
# 172.19.12.166
# docker exec -it 27757c46cd08 /bin/bash

RD=`tput setaf 1`
GR=`tput setaf 2`
RES=`tput sgr0`

while true ; do

        while read host
        do
                echo ------------
                echo service: ${host}
                ret=`ping -c 2 ${host}`

               if [[ ${ret} = "" ]]; then
                       echo "${RD}[ERROR] network is unreachable ${RES}"
                       ans=sh python mail-sender.py
               else
                       echo "${GR} ${ret} ${RES}"
               fi
                echo
        done < services-all.txt
        sleep 60
done