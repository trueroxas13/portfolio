#!/bin/sh
sleep 10
sleep 400 &
ps -e
find / -name core > list 2> /dev/null &
jobs