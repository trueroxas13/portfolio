#!/bin/sh
a=4
b=5

echo $a $b

if [ $a != $b ]
then
  echo "\"$a\" is not equal to \"$b\"."
  echo "(string comparison)"
fi
echo

if [ $a -ne $b ]
then
  echo "$a is not equal to $b."
  echo "(integer comparison)"
fi
echo

if [ $a -gt 0 ] && [ $a -lt 5 ]
then
  echo "The value of \"a\" lies between 0 and 5."
fi
echo