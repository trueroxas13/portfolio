#!/bin/bash

temp=$(pwd)

if ! cd ~/site; then
	echo "Initialize the  site first!"
	exit 1
fi

cd $temp

#checking if rsync is installed
./utils/check-install.sh rsync rsync > /dev/null 2>&1

echo "Enter Username: "
read username

echo "Enter Server: "
read server

destination="$username@$server"

if rsync -a ~/site/ $destination:~/site > /dev/null 2>&1; then
	echo "Publication successful."
fi

