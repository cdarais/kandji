#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main"

files=(
	"Update-SplashtopStreamer.ps1"
	"Audit-SplashtopStreamer.ps1"
	"functions.ps1"
	"variables.ps1"
)

if [[ -e /usr/local/bin/pwsh ]]
then
	for i in {1..${#files[@]}}
	do
		curl -s "${baseUri}/splashtopStreamer/scripts/${files[$i]}" -o "${baseDirectory}/${files[$i]}"
	done

	curl -s "${baseUri}/Get-AppAudit.ps1" -o "${baseDirectory}/Get-AppAudit.ps1"

	/usr/local/bin/pwsh "${baseDirectory}/${files[1]}" "${baseDirectory}" 2>&1

	for i in {1..${#files[@]}}
	do
		rm -rf "${baseDirectory}/${files[$i]}"
	done

	rm -rf "${baseDirectory}/Get-AppAudit.ps1"

fi

if [[ -e "$baseDirectory/1" ]]
then
	rm -rf "$baseDirectory/1"
	echo "failure to revert to default"
	exit 1
fi

/usr/local/bin/kandji display-alert --title "Success" --message "Reset hosts file back to default"

exit 0