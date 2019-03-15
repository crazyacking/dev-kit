#!/usr/bin/env bash

for i in $(curl -s -L www.cnblogs.com |egrep --only-matching 'http(s?):\/\/[^ \"\(\)\<\>]*' | uniq)
do
     echo ${i}
     curl -s -I "$i" 2>/dev/null | head -n 1 | cut -d' ' -f2
done