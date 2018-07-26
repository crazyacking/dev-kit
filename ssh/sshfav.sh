#! /bin/bash

clear

echo ____________________________________________________________________________________
echo
cat ~/bin/hosts.txt
echo
echo ____________________________________________________________________________________
echo
echo
echo "choose one:"

read opt
if [[ "$opt" = "q"  ]]; then
    echo Bye.
    exit
fi

line=`cat ~/bin/hosts.txt | grep "($opt)"`
user=`echo $line | awk '{print $2}'`
host=`echo $line | awk '{print $3}'`
desc=`echo $line | awk '{print $4}'`

echo ________________________________________________________
echo
echo  user: $user
echo  host: $host
echo  desc: $desc
echo ________________________________________________________
echo

#add auth file to the remote server
#scp ~/.ssh/id_rsa.pub "$user"@"$host":~/.ssh/id_rsa.pub.bak
#ssh "$user"@"$host" 'cat ~/.ssh/id_rsa.pub.bak >> ~/.ssh/authorized_keys'

ssh "$user"@"$host"
