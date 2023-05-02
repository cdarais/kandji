runAsUser () {
	if [[ "$currentUser" != "loginwindow" ]]
	then
		echo "running as $currentUser"
		launchctl asuser "$uid" "$@"
	else
		echo "no user logged in"
	fi
}