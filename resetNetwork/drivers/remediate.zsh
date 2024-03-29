#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/resetNetwork"

files=(
	"Reset-Network.ps1"
	"variables.ps1"
)

if [[ -e /usr/local/bin/pwsh ]]
then
	for i in {1..${#files[@]}}
	do
		curl -s "${baseUri}/scripts/${files[$i]}" -o "${baseDirectory}/${files[$i]}"
	done

	/usr/local/bin/pwsh "${baseDirectory}/${files[1]}" "${baseDirectory}" 2>&1

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

/usr/local/bin/kandji display-alert --title "Success" --message "Successfully reset network. A reboot is required within 30 minutes"

exit 0