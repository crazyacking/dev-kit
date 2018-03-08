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
                ret=`curl ${host}:8080/_health`

               if [ "$ret" = "OK" -o "$ret" = "success" ]; then
                       echo "${GR}${ret}, health!${RES}"
               else
                       echo "${RD} ${ret} ${RES}"
                       mail_res=sh python mail-sender.py
                       echo ${mail_res}
               fi
               echo
        done < services.txt
        sleep 60
done

