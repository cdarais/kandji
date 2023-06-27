#!/bin/zsh

currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")

declare -a dockApps=(
	"Launchpad"
	"Microsoft Edge"
	"Google Chrome"
	"Firefox"
	"Messages"
	"Mail"
	"Calendar"
	"Microsoft Outlook"
	"Microsoft Teams"
	"Slack"
	"zoom.us"
	"Music"
	"Spotify"
	"Visual Studio Code"
	"Postman"
	"MySQLWorkbench"
	"PhpStorm"
	"Kandji Self Service"
)