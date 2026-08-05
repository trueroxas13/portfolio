#!/bin/sh
true
echo $? # prints 0
false
echo $? # prints 1

if true; then
  echo true
elif false; then
  echo false
fi

if [ 0 ]; then
  echo 0
fi
if [ 1 ]; then
  echo 1
fi