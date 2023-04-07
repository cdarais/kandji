#!/bin/zsh

declare -a files

baseDirectory="/var/tmp"
baseUri="https://raw.githubusercontent.com/cdarais/kandji/main/kandjiCliCollectApps"

files=(
	"Collect-Apps.ps1"
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

/usr/local/bin/kandji display-alert --title "Success" --message "Collected apps via Kandji and reported them to IT"

exit 0