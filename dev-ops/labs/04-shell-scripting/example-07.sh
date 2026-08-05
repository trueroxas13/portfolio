#!/bin/sh
# printf "%s\n" {0..100} > work.txt
num=$(wc -l < work.txt)
echo $num
if [ $num -gt 150 ]
then
  echo "You have worked hard enough for today."
  echo
fi