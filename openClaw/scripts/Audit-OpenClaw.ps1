$ErrorActionPreference = "Stop"

# Source the helper files passed via argument
. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$found = $false
Write-Host "=== Kandji Audit: $($script:appName) ==="

# 1) Running processes
Write-Info "Checking running processes..."
$procHits = Find-OpenClawProcesses
if ($procHits.Count -gt 0) {
  Write-Fail "Found running OpenClaw-related processes:"
  $procHits | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No OpenClaw-related processes found."
}

# 2) Brew formula/cask installed
$brew = Get-BrewPath
if ($brew) {
  Write-Info "Checking Homebrew for 'openclaw' (formula OR cask)..."

  $hasFormula = $false
  $hasCask = $false
  $foundCasks = @()

  # Check formulas
  try { 
    $formulas = & $brew list --formula 2>$null
    $hasFormula = ($formulas -contains "openclaw") -or ($formulas -contains "open-claw")
  }
  catch {}

  # Check casks - look for any openclaw variations
  try { 
    $casks = & $brew list --cask 2>$null
    $foundCasks = $casks | Where-Object { $_ -match "openclaw|open-claw" }
    $hasCask = ($foundCasks.Count -gt 0)
  }
  catch {}

  if ($hasFormula -or $hasCask) {
    Write-Fail "Homebrew package installed:"
    if ($hasFormula) {
      Write-Host "  Formula: openclaw or open-claw"
    }
    if ($hasCask) {
      Write-Host "  Cask(s): $($foundCasks -join ', ')"
    }
    $found = $true
  }
  else {
    Write-Ok "No Homebrew package named 'openclaw' installed."
  }
}
else {
  Write-Ok "Homebrew not found in standard paths."
}

# 3) Known binary paths
Write-Info "Checking common binary paths..."
$bins = Get-ExistingPaths -Paths $script:binaries
if ($bins.Count -gt 0) {
  Write-Fail "Found OpenClaw binary/shim paths:"
  $bins | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No OpenClaw binaries/shims found in common paths."
}

# 3.5) Application directories (cask installs)
Write-Info "Checking application directories..."
$apps = Get-ExistingPaths -Paths $script:applications
if ($apps.Count -gt 0) {
  Write-Fail "Found OpenClaw application directories:"
  $apps | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No OpenClaw applications found."
}

# 4) Global node_modules openclaw
Write-Info "Checking global node_modules paths..."
$mods = Get-ExistingPaths -Paths $script:modules
if ($mods.Count -gt 0) {
  Write-Fail "Found global OpenClaw module directory:"
  $mods | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No global OpenClaw module directory found."
}

# 5) Per-user ~/.openclaw
Write-Info "Checking per-user state directories..."
$userState = Find-OpenClawUserStateDirs
if ($userState.Count -gt 0) {
  Write-Fail "Found per-user OpenClaw state directories:"
  $userState | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No per-user OpenClaw state directories found."
}

Write-Host ""
if ($found) {
  Write-Host "RESULT: NON-COMPLIANT - OpenClaw detected"
  # Create marker file for the zsh wrapper
  New-Item -Path "$($args[0])/1" -ItemType File -Force | Out-Null
  exit 1
}
else {
  Write-Host "RESULT: COMPLIANT - No OpenClaw found"
  exit 0
}