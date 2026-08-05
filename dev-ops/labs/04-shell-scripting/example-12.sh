#!/bin/sh
echo
while [ "$var1" != "end" ] # the quotes are required to avoid a syntax error
do
  echo -n "Input variable #1 (end to exit): "
  # printf "Input variable #1 (end to exit): "
  read var1
  echo "variable #1 = $var1"
  echo
done

exit 0