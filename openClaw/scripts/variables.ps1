$script:appName = "OpenClaw"

$script:OpenClawProcessMarkers = @(
	"$($appName.tolower())*"
)

# Homebrew paths
$script:brews = @(
	"/opt/homebrew/bin/brew",
	"/usr/local/bin/brew"
)

# Common binaries / shims (may or may not exist depending on install method)
$script:binaries = @(
	"/opt/homebrew/bin/$($appName.tolower())*",
	"/usr/local/bin/$($appName.tolower())*"
)

# Global npm module install locations (common with brew node global installs)
$script:modules = @(
	"/opt/homebrew/lib/node_modules/$($appName.tolower())",
	"/usr/local/lib/node_modules/$($appName.tolower())"
)

# Per-user artifact directory
$script:OpenClawUserStateDirName = ".$($appName.tolower())"

# Optional: known config file inside state dir
$script:OpenClawUserConfigFile = "$($appName.tolower()).json"