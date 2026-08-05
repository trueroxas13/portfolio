#!/bin/sh
# count to 10 using a while loop
LIMIT=10
a=1
while [ $a -le $LIMIT ]
do
  echo -n "$a "
  a=$((a + 1))
done
echo; echo