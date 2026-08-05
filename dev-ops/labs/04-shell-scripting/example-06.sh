#!/bin/sh
string='' # zero-length ("null") string variable
if [ -z $string ]
then
    echo "\$string is null."
else
    echo "\$string is not null."
fi # $string is null.