#! /bin/bash

echo "how many passwords would you like to generate?"
read REQ

if [ $((REQ)) -le 0 ]; then
	echo "you have provided an invalid input, terminating"
	exit 1
fi

COUNT=0

LOWER="abcdefghijklmnopqrstuvwxyz"
UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUMBER="0123456789"
SPECIAL="!@#$%^&*<>/?:"

ARRAY=($LOWER $UPPER $NUMBER $SPECIAL)


while [ $COUNT != $REQ  ]; do
	SIZE=$((12 + RANDOM % 4))
	COUNT=$(($COUNT+1))
	CURRENT=""
	check=false
	while [ "$check" = false  ]; do
		RANDPICK=$((0 + RANDOM % 4))
		case $RANDPICK in
			0)
			RAND=$((0+ RANDOM % 26))
			CURRENT+="${LOWER:$RAND:1}"
			;;
			1)
			RAND=$((0+ RANDOM % 26))
			CURRENT+="${UPPER:$RAND:1}"
			;;
			2)
			RAND=$((0+ RANDOM % 10))
			CURRENT+="${NUMBER:$RAND:1}"
			;;
			3)
			RAND=$((0+ RANDOM % 13))
			CURRENT+="${SPECIAL:$RAND:1}"
			;;
		esac
		echo $CURRENT > temp.txt
		if grep -E ".{$SIZE,}" temp.txt | grep -E ".*[0-9]+.*" | grep -E ".*[a-z]+.*" | grep -E ".*[A-Z]+.*" | grep -E ".*[!@#$%^&<>/?:;]+.*" > /dev/null;then
			check=true
		fi
	done
	echo "password $COUNT is $CURRENT"
done

rm temp.txt
exit 0
