#!/bin/sh
echo hello
echo $? # exit status 0 returned because the command executed successfully
lskdf # unrecognized command.
echo $? # non-zero exit status returned because the command failed to execute
echo
exit 113 # will return 113 to the shell
# to verify this, type "echo $?" after the script terminates