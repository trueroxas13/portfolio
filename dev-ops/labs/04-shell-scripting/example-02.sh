#!/bin/sh
a=375
hello=$a

echo hello # hello
# not a variable reference, just the string "hello" .

echo $hello # 375
# this is a variable reference

echo ${hello} # 375
# also a variable reference, as above

# quoting
echo "$hello" # 375
echo "${hello}" # 375
echo

hello="A B    C D"
echo $hello # A B C D
echo "$hello" # A B    C D
# echo $hello and echo "$hello" give different results
# why? because quoting a variable preserves whitespace

echo
echo '$hello' # $hello
# variable referencing is disabled (escaped) by single quotes, which
# causes the "$" to be interpreted literally
# notice the effect of different types of quoting

hello= # setting it to an empty value