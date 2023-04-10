#!/bin/zsh
declare -a dockApps
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )
uid=$(id -u "$currentUser")
userPath="/Users/$userName"


others_item () {
    printf '%s%s%s%s%s%s' \
        '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
        '<key>_CFURLString</key><string>' \
        "$1" \
        '</string><key>_CFURLStringType</key><integer>0</integer></dict>' \
        '<key>file-label</key><string>Downloads</string><key>file-type</key><string>2</string></dict>' \
        '<key>tile-type</key><string>directory-tile</string></dict>' 
}

waitForDesktop () {
  until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null; do
    delay=$(( $RANDOM % 50 + 10 ))
    echo "$(date) |  + Dock not running, waiting [$delay] seconds"
    sleep $delay
  done
  echo "$(date) | Dock is here, lets carry on"
}

runAsUser {
	if [ "$currentUser" != "loginwindow" ]; then
    launchctl asuser "$uid" /usr/bin/sudo -u "$currentUser" "$@"
  else
    echo "no user logged in"
  fi
}

waitForDesktop

dockApps=(
    "/System/Applications/Launchpad.app"
)

echo "$(date) | Removing Dock Persistent Apps"
runAsUser defaults delete "$userPath/Library/Preferences/com.apple.dock" persistent-apps
runAsUser defaults delete "$userPath/Library/Preferences/com.apple.dock" persistent-others

echo "$(date) | Adding Apps to Dock"
for i in "${dockApps[@]}"; do
        echo "$(date) | Adding $i to Dock"
        runAsUser defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$i</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

echo "$(date) | Adding Downloads Stack"
downloadFolder="$userPath/Downloads"
runAsUser defaults write com.apple.dock persistent-others -array-add "$(others_item $downloadFolder)"

echo "$(date) | Disable show recent items"
runAsUser defaults write com.apple.dock show-recents -bool FALSE

echo "$(date) | Enable Minimize Icons into Dock Icons"
runAsUser defaults write com.apple.dock minimize-to-application -bool yes

echo "$(date) | Restarting Dock"
killall Dock