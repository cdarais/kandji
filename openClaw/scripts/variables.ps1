# OpenClaw Detection Variables
$ErrorActionPreference = "Stop"

# Application name for logging
$script:appName = "OpenClaw"

# Process patterns to detect OpenClaw
$script:processPatterns = @(
	"*openclaw*",
	"*open-claw*"
)

# Binary/executable paths to check
$script:binaries = @(
	"/usr/local/bin/openclaw",
	"/opt/homebrew/bin/openclaw",
	"/usr/local/bin/open-claw",
	"/opt/homebrew/bin/open-claw",
	"$env:HOME/.local/bin/openclaw",
	"$env:HOME/bin/openclaw"
)

# Application directories (common cask install locations)
$script:applications = @(
	"/Applications/OpenClaw.app",
	"/Applications/Open-Claw.app",
	"/Applications/openclaw.app",
	"/Applications/open-claw.app",
	"$env:HOME/Applications/OpenClaw.app",
	"$env:HOME/Applications/Open-Claw.app"
)

# Global node_modules paths to check
$script:modules = @(
	"/usr/local/lib/node_modules/openclaw",
	"/opt/homebrew/lib/node_modules/openclaw",
	"/usr/local/lib/node_modules/@openclaw/*",
	"/opt/homebrew/lib/node_modules/@openclaw/*"
)

# Common Homebrew paths
$script:brewPaths = @(
	"/opt/homebrew/bin/brew",  # Apple Silicon
	"/usr/local/bin/brew"      # Intel
)