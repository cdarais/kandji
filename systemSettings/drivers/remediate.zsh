#!/bin/zsh

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/systemSettings"

declare -a files=(
	"Remediate-SystemSettings.zsh"
	"Audit-SystemSettings.ps1"
	"variables.zsh"
	"functions.zsh"
)

if [[ -e /usr/local/bin/pwsh ]]
then
	for i in {1..${#files[@]}}
	do
		curl -s "${baseUri}/scripts/${files[$i]}" -o "${baseDirectory}/${files[$i]}"
	done

	/bin/zsh ${baseDirectory}/${files[1]} ${baseDirectory}

	for i in {1..${#files[@]}}
	do
		rm -rf "${baseDirectory}/${files[$i]}"
	done
fi

if [[ -e "$baseDirectory/1" ]]
then
	rm -rf "$baseDirectory/1"
	exit 1
fi

exit 0