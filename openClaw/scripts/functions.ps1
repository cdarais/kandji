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

function Get-BrewPath {
	foreach ($path in $script:brewPaths) {
		if (Test-Path $path) {
			return $path
		}
	}
	return $null
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
		[string]$FormulaName
	)
	try {
		$installed = & $BrewPath list --formula 2>$null
		return ($installed -contains $FormulaName)
	}
	catch {
		return $false
	}
}

function Test-BrewHasCask {
	param(
		[string]$BrewPath,
		[string]$CaskName
	)
	try {
		$installed = & $BrewPath list --cask 2>&1 | Out-String
		# Check for both the cask name and variations
		return ($installed -match $CaskName)
	}
	catch {
		return $false
	}
}

function Get-InstalledOpenClawCasks {
	param([string]$BrewPath)
	$casks = @()
	try {
		$allCasks = & $BrewPath list --cask 2>&1 | Out-String
		# Match both 'openclaw' and 'open-claw' variations
		if ($allCasks -match "openclaw|open-claw") {
			$caskList = & $BrewPath list --cask 2>$null
			foreach ($cask in $caskList) {
				if ($cask -match "openclaw|open-claw") {
					$casks += $cask
				}
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