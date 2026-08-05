#!/bin/sh
echo; echo
# escaping a newline

echo "This will print
as two lines."
# this will print
# as two lines.

echo "This will print \
as one line."
# this will print as one line

echo; echo
echo "\v\v\v\v" # prints \v\v\v\v literally

# use the -e option with 'echo' to print escaped characters
echo -e "\v\v\v\v" # prints 4 vertical tabs

echo -e "\042" # prints " (quote, octal ASCII character 42)

# the $'\?' construct makes the -e option unnecessary
echo $'\n' # newline.
echo $'\a' # alert (beep)

# in this case, '\nnn' is an octal value
echo $'\t \042 \t' # quote (") framed by tabs

quote=$'\042' # " assigned to a variable.
echo "$quote This is a quoted string, $quote and this lies outside the quotes."
echo
echo; echo

escape=$'\033' # 033 is octal for escape
echo "\"escape\" echoes as $escape"
# no visible output
echo; echo