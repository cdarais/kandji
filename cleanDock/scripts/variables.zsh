#!/bin/zsh

currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
uid=$(id -u "$currentUser")
downloadFolder=/Users/$currentUser/Downloads

declare -a dockApps=(
	"/Applications/Microsoft Edge.app"
	"/System/Applications/Messages.app"
	"/System/Applications/Mail.app"
	"/System/Applications/Calendar.app"
	"/Applications/Microsoft Teams.app"
	"/Applications/Slack.app"
	"/Applications/zoom.us.app"
	"/System/Applications/TV.app"
	"/System/Applications/Music.app"
	"/Applications/Visual Studio Code.app"
)