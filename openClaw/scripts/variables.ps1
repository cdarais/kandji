$script:appName = "OpenClaw"

# Process / command-line markers (substring match against full `ps ... args` line)
# Keep this minimal; it will match openclaw, openclaw-gateway, openclaw-agent, etc.
$script:OpenClawProcessMarkers = @(
	"openclaw"
)

# Homebrew paths
$script:brews = @(
	"/opt/homebrew/bin/brew",
	"/usr/local/bin/brew"
)

# Common binaries / shims (wildcards expanded by Get-ExistingPaths)
$script:binaries = @(
	"/opt/homebrew/bin/openclaw*",
	"/usr/local/bin/openclaw*"
)

# Global node_modules install locations (wildcards expanded by Get-ExistingPaths)
$script:modules = @(
	"/opt/homebrew/lib/node_modules/openclaw*",
	"/usr/local/lib/node_modules/openclaw*"
)

# Per-user artifact directory
$script:OpenClawUserStateDirName = ".openclaw"

# Optional: known config file inside state dir
$script:OpenClawUserConfigFile = "openclaw.json"