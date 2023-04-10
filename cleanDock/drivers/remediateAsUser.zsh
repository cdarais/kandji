#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/cleanDock"

files=(
	"Clean-Dock.ps1"
	"functions.ps1"
	"variables.ps1"
)

if [[ -e /usr/local/bin/pwsh ]]
then
	/usr/local/bin/pwsh "${baseDirectory}/${files[1]}" "${baseDirectory}" 2>&1
fi

if [[ -e "$baseDirectory/1" ]]
then
	rm -rf "$baseDirectory/1"
	exit 1
fi

exit 0