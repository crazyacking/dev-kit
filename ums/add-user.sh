
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
public_key=$3

if [ "$user" == "" ]; then
    echo "Missing username"
    exit 1
fi

if [ "$ttl" == "" ]; then
    echo "Missing expired date"
    exit 1
fi

if [ "$public_key" == "" ]; then
    echo "Missing public key"
    exit 1
fi

if id -u "$user" >/dev/null 2>&1; then
    echo "User already exists"
    exit 1
fi

# yum -y install pwgen
password=`pwgen -s -1 10`

useradd $user
echo $password | passwd $user --stdin

expired_date=`date -d "${ttl} days" +"%Y-%m-%d"`

chage -E $expired_date $user

su $user -c 'cd ~ && cat /dev/zero | ssh-keygen -q -N "" && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'

echo $public_key >> /home/${user}/.ssh/authorized_keys

div="_________________________________________"
echo ""
echo $div
echo "user: $user"
echo "password: $password"
echo "expire: $expired_date"
echo ""

# ----------------------------------------
# For example:
# ./add-user.sh test17 1 "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrEa35xaJDOKkGC8vGdscch6TfFJpB4G8drqjR5O2+NDNOXspYsAURS6G1HPIICDKuxM5ePmuCo7OGrLj9uuzT2IVUBfWXH672bIJ2xF8rR/gLXJFrF5mD00grZvzcHP58x/gWNvbjQtHrjzd2/RapsijxpLry02fu/nXJ5Am2fnJJVbE9FyHyu2PUuqxgYzL/AWLtnC2breuxtRIzW9juOds++dl7X67xmLz4LbjDhXNsfEMYwfnak5joccybfz7U9LagDecX2okpwB3Za/wiGC/mJAo3N/kwdqtroAbO39OgdfnSOUUiktPbKsjpaREcM3Xm/UwWUJ9KNvs0YRZD crazyacking@gmail.com"
