# Helper Functions for OpenClaw Detection and Removal

function Write-Info {
	param([string]$Message)
	Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Ok {
	param([string]$Message)
	Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Fail {
	param([string]$Message)
	Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Write-Warn {
	param([string]$Message)
	Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Get-ConsoleUser {
	# Get the currently logged in user (not root)
	try {
		$user = (& /usr/bin/stat -f%Su /dev/console 2>$null)
		if ($user -and $user -ne "root" -and $user -ne "_mbsetupuser") {
			return $user
		}
	}
	catch {
		Write-Warn "Could not determine console user"
	}
	return $null
}

function Invoke-AsUser {
	param(
		[string]$User,
		[string]$Command
	)

	if ($User) {
		# Run command as the actual user, not root
		$output = & /usr/bin/su - $User -c $Command 2>&1
		return $output
	}
	else {
		# Fallback to running as current user
		$output = Invoke-Expression $Command 2>&1
		return $output
	}
}

function Get-BrewPath {
	foreach ($path in $script:brewPaths) {
		if (Test-Path $path) {
			return $path
		}
	}
	return $null
}

function Get-NpmPath {
	# Try to find npm in common locations
	foreach ($path in $script:npmPaths) {
		if ($path -like "*`**") {
			# Handle wildcards (like nvm paths)
			try {
				$resolved = Get-Item $path -ErrorAction SilentlyContinue | Select-Object -First 1
				if ($resolved) {
					return $resolved.FullName
				}
			}
			catch {
				continue
			}
		}
		elseif (Test-Path $path) {
			return $path
		}
	}

	# Try to find npm via 'which' command as the console user
	$consoleUser = Get-ConsoleUser
	if ($consoleUser) {
		try {
			$npmPath = Invoke-AsUser -User $consoleUser -Command "which npm 2>/dev/null"
			if ($npmPath -and (Test-Path $npmPath.Trim())) {
				return $npmPath.Trim()
			}
		}
		catch {
			# Continue to next method
		}
	}

	return $null
}

function Test-NpmHasPackage {
	param(
		[string]$NpmPath,
		[string]$PackageName,
		[string]$User
	)
	try {
		$cmd = "'$NpmPath' list -g --depth=0 2>/dev/null | grep '$PackageName'"
		$output = Invoke-AsUser -User $User -Command $cmd
		return ($output -match $PackageName)
	}
	catch {
		return $false
	}
}

function Get-InstalledOpenClawNpmPackages {
	param(
		[string]$NpmPath,
		[string]$User
	)
	$packages = @()
	try {
		# Get list of globally installed packages
		$cmd = "'$NpmPath' list -g --depth=0 --json 2>/dev/null"
		$output = Invoke-AsUser -User $User -Command $cmd

		if ($output) {
			# Parse JSON output
			try {
				$json = $output | ConvertFrom-Json
				if ($json.dependencies) {
					$json.dependencies.PSObject.Properties | ForEach-Object {
						if ($_.Name -match "openclaw|open-claw") {
							$packages += $_.Name
						}
					}
				}
			}
			catch {
				# Fallback to grep if JSON parsing fails
				$cmd = "'$NpmPath' list -g --depth=0 2>/dev/null"
				$output = Invoke-AsUser -User $User -Command $cmd
				$lines = $output -split "`n"
				foreach ($line in $lines) {
					if ($line -match "openclaw|open-claw") {
						# Extract package name (format is usually "├── package@version" or "└── package@version")
						if ($line -match "[├└]── ([^@\s]+)") {
							$packages += $matches[1]
						}
					}
				}
			}
		}
	}
	catch {
		Write-Warn "Error checking npm packages: $($_.Exception.Message)"
	}
	return $packages
}

function Find-OpenClawProcesses {
	$hits = @()
	try {
		$allProcs = Get-Process -ErrorAction SilentlyContinue
		foreach ($pattern in $script:processPatterns) {
			$matches = $allProcs | Where-Object {
				$_.ProcessName -like $pattern -or
				$_.Path -like $pattern
			}
			foreach ($proc in $matches) {
				$info = "$($proc.ProcessName) (PID: $($proc.Id))"
				if ($proc.Path) {
					$info += " - $($proc.Path)"
				}
				$hits += $info
			}
		}
	}
	catch {
		Write-Warn "Error checking processes: $($_.Exception.Message)"
	}
	return $hits
}

function Stop-OpenClawProcesses {
	Write-Info "Stopping OpenClaw processes..."
	$stopped = 0
	try {
		$allProcs = Get-Process -ErrorAction SilentlyContinue
		foreach ($pattern in $script:processPatterns) {
			$matches = $allProcs | Where-Object {
				$_.ProcessName -like $pattern -or
				$_.Path -like $pattern
			}
			foreach ($proc in $matches) {
				try {
					Write-Info "  Stopping process: $($proc.ProcessName) (PID: $($proc.Id))"
					Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
					$stopped++
				}
				catch {
					Write-Warn "  Failed to stop PID $($proc.Id): $($_.Exception.Message)"
				}
			}
		}
	}
	catch {
		Write-Warn "Error stopping processes: $($_.Exception.Message)"
	}

	if ($stopped -eq 0) {
		Write-Ok "No OpenClaw processes to stop."
	}
	else {
		Write-Ok "Stopped $stopped process(es)."
	}
}

function Test-BrewHasFormula {
	param(
		[string]$BrewPath,
		[string]$FormulaName,
		[string]$User
	)
	try {
		$cmd = "'$BrewPath' list --formula 2>/dev/null"
		$installed = Invoke-AsUser -User $User -Command $cmd
		return ($installed -match $FormulaName)
	}
	catch {
		return $false
	}
}

function Test-BrewHasCask {
	param(
		[string]$BrewPath,
		[string]$CaskName,
		[string]$User
	)
	try {
		$cmd = "'$BrewPath' list --cask 2>/dev/null"
		$installed = Invoke-AsUser -User $User -Command $cmd
		# Check for both the cask name and variations
		return ($installed -match $CaskName)
	}
	catch {
		return $false
	}
}

function Get-InstalledOpenClawCasks {
	param(
		[string]$BrewPath,
		[string]$User
	)
	$casks = @()
	try {
		$cmd = "'$BrewPath' list --cask 2>/dev/null"
		$allCasks = Invoke-AsUser -User $User -Command $cmd

		# Match both 'openclaw' and 'open-claw' variations
		if ($allCasks -match "openclaw|open-claw") {
			$caskArray = $allCasks -split "`n" | Where-Object { $_ -match "openclaw|open-claw" }
			foreach ($cask in $caskArray) {
				$casks += $cask.Trim()
			}
		}
	}
	catch {
		# Ignore errors
	}
	return $casks
}

function Get-ExistingPaths {
	param([string[]]$Paths)
	$existing = @()
	foreach ($path in $Paths) {
		# Handle wildcards
		if ($path -like "*`**") {
			try {
				$resolved = Get-Item $path -ErrorAction SilentlyContinue
				if ($resolved) {
					$existing += $resolved.FullName
				}
			}
			catch {
				# Silently continue if wildcard doesn't match anything
			}
		}
		else {
			if (Test-Path $path) {
				$existing += $path
			}
		}
	}
	return $existing
}

function Find-OpenClawUserStateDirs {
	$dirs = @()
	try {
		# Get all user home directories
		$userDirs = Get-ChildItem "/Users" -Directory -ErrorAction SilentlyContinue
		foreach ($userDir in $userDirs) {
			$openclawDir = Join-Path $userDir.FullName ".openclaw"
			if (Test-Path $openclawDir) {
				$dirs += $openclawDir
			}
		}
	}
	catch {
		Write-Warn "Error checking user state directories: $($_.Exception.Message)"
	}
	return $dirs
}

function Remove-PathsBestEffort {
	param([string[]]$Paths)
	foreach ($path in $Paths) {
		if (Test-Path $path) {
			try {
				Write-Info "  Removing: $path"
				Remove-Item $path -Recurse -Force -ErrorAction Stop
				Write-Ok "  Successfully removed: $path"
			}
			catch {
				Write-Warn "  Failed to remove $path : $($_.Exception.Message)"
			}
		}
	}
}