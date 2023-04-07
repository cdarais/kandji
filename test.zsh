#!/bin/zsh

fontFile="/var/tmp/fonts.ps1"
uri="https://raw.githubusercontent.com/cdarais/kandji/main/fonts/fonts.ps1"


if [[ -e /usr/local/bin/pwsh ]]; then
    curl -s $uri -o $fontFile
    /usr/local/bin/pwsh $fontFile
    rm -rf $fontFile
    exit 0 
fi

exit 1