#! /bin/bash

clear
echo ""
echo ""
echo "<< ssh Connector >>"
echo ""
echo ""
cat hosts.txt
echo ""

echo "Which host would you like to ssh to? Enter the number:"
read opt
if [ "$opt" = "q"  ]; then
    echo "Exiting Utility..."
    exit
fi

host=`cat hosts.txt | grep "$opt)" | awk '{print $2}'`
echo "Connecting to the $host"
echo ""
ssh root@"$host"
