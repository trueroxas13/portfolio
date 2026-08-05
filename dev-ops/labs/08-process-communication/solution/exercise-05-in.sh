#!/bin/sh
mkfifo pipe
ls -l > pipe
# cat < pipe
rm pipe