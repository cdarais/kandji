#!/bin/zsh

source $1/variables.zsh

echo "test"

for i in "${writeSettings[@]}"
do
	/usr/bin/security authorizationdb write $i allow
done
