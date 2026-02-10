waitForDesktop () {
	until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null
	do
		delay=$(( $RANDOM % 50 + 10 ))
		echo " + Dock not running, waiting [$delay] seconds"
		sleep $delay
	done

	echo "Dock is here, lets carry on"
}

runAsUser () {
	if [[ "$currentUser" != "loginwindow" ]]
	then
		echo "running as $currentUser"
		launchctl asuser "$uid" "$@"
	else
		echo "no user logged in"
	fi
}

installLatestDockUtil () {
	uri=$(curl -sL  https://api.github.com/repos/kcrawford/dockutil/releases/latest | grep "browser_download_url" | cut -d":" -f3 | tr -d \")

	pkgLocation="/var/tmp/dockutil.pkg"

	echo "https:$uri"

	curl -Ls "https:$uri" -o "$pkgLocation"

	sudo -E /usr/sbin/installer -pkg "$pkgLocation" -target /

	sudo rm -rf "$pkgLocation"
}

checkAndAddItem () {
	application="/Applications/$1.app"

	if [[ -e $application ]]
	then
		runAsUser /usr/local/bin/dockutil --add $application --no-restart --allhomes --replacing $1
	fi

	application="/System$application"

	if [[ -e $application ]]
	then
		runAsUser /usr/local/bin/dockutil --add $application --no-restart --allhomes --replacing $1
	fi
}