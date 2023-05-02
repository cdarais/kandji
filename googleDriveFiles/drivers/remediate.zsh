#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/googleDriveFiles"

files=(
	"Remediate-GoogleDriveFiles.ps1"
	"Audit-GoogleDriveFiles.ps1"
	"functions.ps1"
	"variables.ps1"
	"functions.zsh"
	"variables.zsh"
)

source $baseDirectory/variables.zsh
source $baseDirectory/functions.zsh

if [[ -e /usr/local/bin/pwsh ]]
then
	for i in {1..${#files[@]}}
	do
		curl -s "${baseUri}/scripts/${files[$i]}" -o "${baseDirectory}/${files[$i]}"
	done

	runAsUser /usr/local/bin/pwsh "${baseDirectory}/${files[1]}" "${baseDirectory}" 2>&1

	for i in {1..${#files[@]}}
	do
		rm -rf "${baseDirectory}/${files[$i]}"
	done
fi

if [[ -e "$baseDirectory/1" ]]
then
	rm -rf "$baseDirectory/1"
	echo "failure to revert to default"
	exit 1
fi

/usr/local/bin/kandji display-alert --title "Success" --message "Successfully fixed your google drive files"

exit 0