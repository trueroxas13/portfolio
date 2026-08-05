#!/bin/sh
# listing the planets
for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune
do
  echo $planet # each planet on a separate line
done
echo; echo

# all planets on same line
# entire 'list' enclosed in quotes creates a single variable
for planet in "Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune"
do
  echo $planet
done
echo; echo

exit 0