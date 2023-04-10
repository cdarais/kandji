$userName = (zsh -c "dscl . list /Users | grep -v '_'") | Where-Object { $_ -notlike "*admin" -and $_ -ne "daemon" -and $_ -ne "root" -and $_ -ne "nobody"}
# $dock = "/Users/$userName/Library/Preferences/com.apple.dock.plist"

$dockApps = @(
	"/System/Applications/Launchpad.app",
	"/Applications/Microsoft Edge.app",
	"/System/Applications/Messages.app",
	"/System/Applications/Mail.app",
	"/System/Applications/Calendar.app",
	"/Applciations/Microsoft Teams.app",
	"/Applications/Slack.app",
	"/Applciations/zoom.us.app",
	"/System/Applications/TV.app",
	"/System/Applications/Music.app",
	"/Applications/Visual Studio Code.app"
)

$dockOthers = @(
	"/Users/$userName/Downloads"
)


# Write-Output $dock | Out-Null
Write-Output $dockApps | Out-Null
Write-Output $dockOthers | Out-Null