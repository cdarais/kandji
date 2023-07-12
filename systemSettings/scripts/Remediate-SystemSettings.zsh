#!/bin/zsh

source $1/variables.zsh
source $1/functions.zsh

waitForDesktop


for i in "${writeSettings[@]}"
do
	runAsUser /usr/bin/security authorizationdb write $i allow
done

# . "$($args[0])/variables.ps1"

# foreach ($w in $writeSettings) {
# 	/usr/bin/security authorizationdb write $w allow
# }