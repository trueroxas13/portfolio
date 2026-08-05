#!/bin/bash

#check if site already exists

if cd ~/site > /dev/null 2>&1 ; then
	echo "Site is already initialized!"
	exit 0
fi

#verify if hugo is installed
./utils/check-install.sh hugo hugo

if hugo new site ~/site > /dev/null 2>&1 ; then
	echo "Site initialized..."
	git init -q ~/site
	echo "Publication repository initialized..."
else
	echo "Site initialization failed!"
	echo "Terminating."
	exit 1
fi

cd ~/site
if git submodule add -q https://github.com/CaiJimmy/hugo-theme-stack.git ~/site/themes/stack 2>&1 ; then
	echo "theme = 'stack'" >> ~/site/hugo.toml
	echo "Theme 'Stack' applied."
fi

exit 0

