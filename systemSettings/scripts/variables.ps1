# currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }')
# uid=$(id -u "$currentUser")

# declare -a dockApps=(
# 	"Launchpad"
# 	"Microsoft Edge"
# 	"Google Chrome"
# 	"Firefox"
# 	"Messages"
# 	"Mail"
# 	"Calendar"
# 	"Microsoft Outlook"
# 	"Microsoft Teams"
# 	"Slack"
# 	"zoom.us"
# 	"Music"
# 	"Spotify"
# 	"Visual Studio Code"
# 	"Postman"
# 	"MySQLWorkbench"
# 	"PhpStorm"
# 	"Kandji Self Service"
# )

$systemSettings = @(
	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences" },
	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences.network" },
	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences.battery" }
); $systemSettings | Out-Null