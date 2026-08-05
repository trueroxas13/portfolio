#!/bin/sh
list="one two three"
for a in $list # splits the variable in parts at whitespace
do
  echo $a
done
# one
# two
# three
echo "---"
for a in "$list" # preserves whitespace in a single variable
do
  echo $a # would using "$a" make any difference?
done
# one two three