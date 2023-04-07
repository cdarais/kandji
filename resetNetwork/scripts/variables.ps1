$files = @(
	"com.apple.wifi.message-tracer.plist",
	"com.apple.wifi.message-tracer.plist.backup",
	"NetworkInterfaces.plist",
	"NetworkInterfaces.plist.backup",
	"com.apple.airport.preferences.plist",
	"com.apple.airport.preferences.plist.backup",
	"com.apple.network.eapolclient.configuration.plist",
	"com.apple.network.eapolclient.configuration.plist.backup",
	"preferences.plist",
	"preferences.plist.backup"
)

$baseFilePath = "/Library/Preferences/SystemConfiguration"

Write-Output $files | Out-Null
Write-Output $baseFilePath | Out-Null