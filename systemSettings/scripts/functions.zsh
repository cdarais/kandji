waitForDesktop () {
	count=0
	until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null
	do
		delay=$(( $RANDOM % 30 + 5 ))
		echo " + Dock not running, waiting [$delay] seconds"
		sleep $delay
		if [ $count -eq 3 ]
		then
			break
		fi
		((count++))
	done
	
	if [ $count -ne 0 ]
	then
		echo "User not logged in"
	else
		echo "Dock is here, lets carry on"
	fi
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