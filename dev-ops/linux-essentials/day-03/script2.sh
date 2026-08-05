#! /bin/bash

echo "enter a valid password"
read PASSWORD
echo $PASSWORD > temp.txt
if grep -E ".{8,}" temp.txt  | grep -E ".*[0-9]+.*" | grep -E ".*[a-z]+.*" | grep -E ".*[A-Z]+.*" | grep -E ".*[@#$%.,;:'_-]+.*"; then	
	echo "$PASSWORD is valid"
	exit 0
fi

echo "$PASSWORD is invalid"
exit 1
