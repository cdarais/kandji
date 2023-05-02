#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/googleDriveFiles"

files=(
	"Audit-GoogleDriveFiles.ps1"
	"functions.ps1"
	"variables.ps1"
)

currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")

runAsUser () {
	if [[ "$currentUser" != "loginwindow" ]]
	then
		echo "running as $currentUser"
		launchctl asuser "$uid" "$@"
	else
		echo "no user logged in"
	fi
}

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
	exit 1
fi

exit 0