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

persistentApp="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$i</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
# otherAppDownloadFolder=<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$downloadFolder</string><key>_CFURLStringType</key><integer>0</integer></dict><key>file-label</key><string>Downloads</string><key>file-type</key><string>2</string></dict><key>tile-type</key><string>directory-tile</string></dict>
otherAppDownloadFolder="com.apple.launchpad.launcher"