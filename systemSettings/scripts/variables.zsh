currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")

declare -a writeSettings=(
	"system.preferences"
	"system.preferences.datetime"
	"system.preferences.network"
	"system.services.systemconfiguration.network"
	"com.apple.wifi"
	"system.preferences.battery"
)

# $writeSettings = @(
# 	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences" },
# 	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences.network" },
# 	@{ file = "authorizationdb"; readWrite = "write"; blockAllow = "allow"; pane = "system.preferences.battery" }
# ); $systemSettings | Out-Null
# $writeSettings = @(
# 	"system.preferences",
# 	"system.preferences.network",
# 	"system.preferences.battery"
# ); $writeSettings | Out-Null