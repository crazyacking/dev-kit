#!/usr/bin/env bash

RD=`tput setaf 1`
GR=`tput setaf 2`
RES=`tput sgr0`

printf "Memory\t\tDisk\t\tCPU\n"
end=$((SECONDS+3600))
while [ $SECONDS -lt ${end} ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
echo "$MEMORY$DISK$CPU"

MEMORY_NUM=$(echo ${MEMORY} | tr -s ' ' | cut -d' ' -f1 | tr -d '%')
DISK_NUM=$(echo ${DISK} | tr -s ' ' | cut -d' ' -f1 | tr -d '%')
CPU_NUM=$(echo ${CPU} | tr -s ' ' | cut -d' ' -f1 | tr -d '%')

if (( $(echo "${DISK_NUM} > 70" | bc -l) ))
then
    echo "${RD}DISK_USAGE:${DISK} ${RES}"
     mail_res=sh python mail-sender.py
fi
if ((  $(echo "${MEMORY_NUM} > 80" | bc -l) ))
then
        echo "${RD}MEM_USAGE:${MEMORY} ${RES}"
         mail_res=sh python mail-sender.py
fi
if (( $(echo "${CPU_NUM} > 90" | bc -l) ))
then
        echo "${RD}CPU_USAGE:${CPU} ${RES}"
         mail_res=sh python mail-sender.py
fi

sleep 5
done
