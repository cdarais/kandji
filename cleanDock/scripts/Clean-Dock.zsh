#!/bin/zsh
declare -a dockApps
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
uid=$(id -u "$currentUser")


waitForDesktop () {
  until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null
  do
	delay=$(( $RANDOM % 50 + 10 ))
	echo " + Dock not running, waiting [$delay] seconds"
	sleep $delay
  done
  echo "Dock is here, lets carry on"
}

runAsUser (){
	if [[ "$currentUser" != "loginwindow" ]]
	then
		launchctl asuser "$uid" /usr/bin/sudo -u "$currentUser" "$@"
	else
		echo "no user logged in"
	fi
}

waitForDesktop

dockApps=(
	"/System/Applications/Launchpad.app"
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

echo "Removing Dock Persistent Apps"
runAsUser defaults delete com.apple.dock persistent-apps
# runAsUser defaults delete com.apple.dock persistent-others

echo "Adding Apps to Dock"
for i in "${dockApps[@]}"
do
	if [[ -e $i ]]
	then
		echo "Adding $i to Dock"
		runAsUser defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>label</key><string>$label</string><key>url</key><dict><key>_CFURLString</key><string>$downloadsFolder</string><key>_CFURLStringType</key><integer>15</integer></dict></dict><key>tile-type</key><string>url-tile</string></dict>"
	fi
done

# echo "Adding Downloads Stack"
# downloadFolder="/Users/$userName/Downloads"
# runAsUser defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$downloadFolder</string><key>_CFURLStringType</key><integer>0</integer></dict><key>file-label</key><string>Downloads</string><key>file-type</key><string>2</string></dict><key>tile-type</key><string>directory-tile</string></dict>"

echo "Disable show recent items"
runAsUser defaults write com.apple.dock show-recents -bool FALSE

echo "Enable Minimize Icons into Dock Icons"
runAsUser defaults write com.apple.dock minimize-to-application -bool yes

echo "Restarting Dock"
killall Dock