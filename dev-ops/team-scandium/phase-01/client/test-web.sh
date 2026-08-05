#!/bin/bash

echo "Enter IP address: "
read address

if curl -k http://$address:80 > /dev/null 2>&1 ; then
	echo "Server found."
	#ensure w3m is installed
	./utils/check-install.sh w3m w3m > /dev/null 2>&1
	w3m http://$address:80
else 
	echo "Could not locate the server."
fi
