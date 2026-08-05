#!/bin/sh
if ! grep $USER /etc/passwd # no square brackets
# if ! grep $1 /etc/passwd; # > /dev/null
then
  echo "Your user account is not managed locally."
fi