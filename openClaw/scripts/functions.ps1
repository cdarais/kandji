$ErrorActionPreference = "Stop"

function Write-Info { param( $message ) Write-Host "[INFO] $message" }
function Write-Ok { param( $message ) Write-Host "[OK] $message" }
function Write-Fail { param( $message ) Write-Host "[FAIL] $message" }
function Write-Warn { param( $message ) Write-Host "[WARN] $message" }

function Get-BrewPath {
	foreach ($p in $script:brews) {
		if (Test-Path $p) { return $p }
	}
	return $null
}

function Get-MacProcessLines {
	# Returns lines: "pid comm args"
	try {
		return & /bin/ps -axo pid=, comm=, args= 2>$null
	}
 catch {
		Write-Warn "Unable to read process list: $($_.Exception.Message)"
		return @()
	}
}

function Find-OpenClawProcesses {
	$lines = Get-MacProcessLines
	$hits = New-Object System.Collections.Generic.List[string]

	foreach ($m in $script:OpenClawProcessMarkers) {
		$lineMatches = $lines | Where-Object { $_ -match "(?i)" + [regex]::Escape($m) }
		foreach ($line in $lineMatches) { $hits.Add($line) }
	}

	# de-dupe
	return $hits | Select-Object -Unique
}

function Test-AnyPathExists {
	param (
		$paths
	)

	foreach ($p in $paths) {
		if (Test-Path $p) { return $true }
	}
	return $false
}

function Get-ExistingPaths {
	param(
		$paths
	)

	$existing = @()

	foreach ($p in $paths) {
		if (-not $p) { continue }

		# If the pattern contains wildcard characters, expand it.
		if ($p -match '[\*\?\[]') {
			try {
				$matches = Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue
				foreach ($m in $matches) {
					if ($m -and $m.FullName) { $existing += $m.FullName }
				}
			}
			catch {
				# ignore
			}
			continue
		}

		if (Test-Path $p) { $existing += $p }
	}

	return ($existing | Select-Object -Unique)
}

function Get-LocalUserHomes {
	$root = "/Users"
	if (-not (Test-Path $root)) { return @() }

	return Get-ChildItem -Path $root -Directory -ErrorAction SilentlyContinue |
	Where-Object { $_.Name -notin @("Shared", "Guest") } |
	Select-Object -ExpandProperty FullName
}

function Find-OpenClawUserStateDirs {
	$userHomes = Get-LocalUserHomes
	$hits = @()

	foreach ($userHome in $userHomes) {
		$stateDir = Join-Path $userHome $script:OpenClawUserStateDirName
		if (Test-Path $stateDir) { $hits += $stateDir }
	}

	return $hits
}

function Test-BrewHasFormula {
	param(
		[string]$BrewPath,
		[string]$FormulaName
	)

	if (-not $BrewPath) { return $false }

	try {
		$formulae = & $BrewPath list --formula 2>$null
		return ($formulae -contains $FormulaName)
	}
 catch {
		Write-Warn "brew list failed: $($_.Exception.Message)"
		return $false
	}
}

function Stop-OpenClawProcesses {
	Write-Info "Stopping OpenClaw-related processes…"

	# best-effort: pkill -f catches command-line execution under node too
	foreach ($m in $script:OpenClawProcessMarkers) {
		try { & /usr/bin/pkill -f $m 2>$null | Out-Null } catch {}
	}

	Start-Sleep -Seconds 1

	foreach ($m in $script:OpenClawProcessMarkers) {
		try { & /usr/bin/pkill -9 -f $m 2>$null | Out-Null } catch {}
	}
}

function Remove-PathsBestEffort {
	param (
		$paths
	)

	foreach ($p in $paths) {
		if (Test-Path $p) {
			try {
				Remove-Item -LiteralPath $p -Recurse -Force -ErrorAction Stop
				Write-Ok "Removed: $p"
			}
			catch {
				Write-Warn "Failed to remove $p : $($_.Exception.Message)"
			}
		}
	}
}