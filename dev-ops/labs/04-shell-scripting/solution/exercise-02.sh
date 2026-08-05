#!/bin/sh
echo -n "Filename: "
read file

if [ -e "$file" ]; then
  lines=$(cat "$file" | wc -l)
  if [ $lines -lt 30 ]; then
    cat "$file"
  else
    more "$file"
  fi
else
  echo "$file" does not exist.
fi