#!/bin/zsh

# source $1/variables.zsh

# echo "test"

# for i in "${writeSettings[@]}"
# do
# 	/usr/bin/security authorizationdb write $i allow
# done

. "$($args[0])/variables.ps1"

foreach ($w in $writeSettings) {
	/usr/bin/security authorizationdb write $w allow
}