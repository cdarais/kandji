#!/bin/zsh

users=$(/usr/bin/dscl . -list /Users)

for u in "${users[@]}"; do
    if [[ $u == "jamf-ssh" ]]; then
        sudo /usr/bin/dscl . -delete /private/var/jamf-ssh
    fi
done