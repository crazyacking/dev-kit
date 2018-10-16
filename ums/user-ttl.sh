#!/bin/sh

# author: shanbiao.jsb
# date  : Tue 26 Jun 2018 06:37:34 PM CST

# This will take the username as a parameter referred to as $0

# ------------------------
# param1: user_name
# param2: time to expire
# param3: public key

user=$1
ttl=$2

if [ "$user" == "" ]; then
    echo "Missing username"
    exit 1
fi

if [ "$ttl" == "" ]; then
    echo "Missing expired date"
    exit 1
fi

if id -u "$user" >/dev/null 2>&1 ; then
    echo ""
else
    echo "User not exists"
    exit 1
fi

expired_date=`date -d "${ttl} days" +"%Y-%m-%d"`

chage -E $expired_date $user

div="_________________________________________"
echo ""
echo $div
echo "extension user's TTL success~"
echo "user: $user"
echo "expire: $expired_date"
echo ""