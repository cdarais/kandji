$userName = (echo 'show State:/Users/ConsoleUser' | scutil | awk '/Name :/ { print $3 }')
$userId = (id -u $userName)
# $dock = "/Users/$userName/Library/Preferences/com.apple.dock.plist"
$dock = "com.apple.dock"

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


Write-Output $dock | Out-Null
Write-Output $dockApps | Out-Null
Write-Output $dockOthers | Out-Null