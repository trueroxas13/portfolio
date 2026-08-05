#!/bin/sh
name=resolv.conf
for file in "$(ls /etc)"; do
  if [ "$file" = "$name" ]; then
    echo $file found!
    matches=$(grep -o nameserver "/etc/$file" | wc -l)
    echo $matches
    exit
  fi
done

echo resolv.conf not found!