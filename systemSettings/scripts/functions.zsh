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