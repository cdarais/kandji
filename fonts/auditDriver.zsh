#!/bin/zsh

declare -a files
declare -a uris

baseDirectory="/Users/chris.darais/code/kandji/fonts"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/fonts"

files=(
    "$baseDirectory/Audit-Fonts.ps1"
    "$baseDirectory/variables.ps1"
)

uris=(
    "$baseUri/Audit-Fonts.ps1"
    "$baseUri/variables.ps1"
)

if [[ -e /usr/local/bin/pwsh ]]
then
    # for i in {1..${#uris[@]}}
    # do
    #     curl -s "${uris[$i]}" -o "${files[$i]}"
    # done

    /usr/local/bin/pwsh ${files[1]} ${baseDirectory} 2>&1
    # for i in {0..${#uris[@]}}
    # do
    #     rm -rf "${files[$i]}"
    # done
fi

if [[ -e "$baseDirectory/1" ]] 
then
	rm -rf "$baseDirectory/1"
	exit 1
fi

exit 0