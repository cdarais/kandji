$userName = (echo 'show State:/Users/ConsoleUser' | scutil | awk '/Name :/ { print $3 }')
$userId = (id -u $userName)
$userPath = "/Users/$userName/"
$dock = "$userPath/Library/Preferences/com.apple.dock"

$dockApps = @(
	"/System/Applications/Launchpad.app",
	"/Applications/Microsoft Edge.app",
	"/System/Applications/Messages.app",
	"/System/Applications/Mail.app",
	"/System/Applications/Calendar.app",
	"/Applications/Microsoft Teams.app",
	"/Applications/Slack.app",
	"/Applications/zoom.us.app",
	"/System/Applications/TV.app",
	"/System/Applications/Music.app",
	"/Applications/Visual Studio Code.app"
)

$dockOthers = @(
	"$userPath/Downloads"
)

Write-Output $userId | Out-Null
Write-Output $dock | Out-Null
Write-Output $dockApps | Out-Null
Write-Output $dockOthers | Out-Null