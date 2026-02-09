$ErrorActionPreference = "Stop"

. "$PSScriptRoot/variables.ps1"
. "$PSScriptRoot/functions.ps1"

$found = $false
Write-Host "=== Kandji Audit: $($script:appName) ==="

# 1) Running processes
Write-Info "Checking running processes…"
$procHits = Find-OpenClawProcesses
if ($procHits.Count -gt 0) {
  Write-Fail "Found running OpenClaw-related processes:"
  $procHits | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No OpenClaw-related processes found."
}

# 2) Brew formula installed
$brew = Get-BrewPath
if ($brew) {
  Write-Info "Checking Homebrew for installed formula 'openclaw'…"
  if (Test-BrewHasFormula -BrewPath $brew -FormulaName "openclaw") {
    Write-Fail "Homebrew formula installed: openclaw"
    $found = $true
  }
  else {
    Write-Ok "No Homebrew formula named 'openclaw' installed."
  }
}
else {
  Write-Ok "Homebrew not found in standard paths."
}

# 3) Known binary paths
Write-Info "Checking common binary paths…"
$bins = Get-ExistingPaths -Paths $script:binaries
if ($bins.Count -gt 0) {
  Write-Fail "Found OpenClaw binary/shim paths:"
  $bins | ForEach-Object { Write-Host "  $_" }
  $found = $true
}
else {
  Write-Ok "No OpenClaw binaries/shims found in common paths."
}

# 4) Global node_modules openclaw
Write-Info "Checking global node_modules paths…"
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
Write-Info "Checking per-user state directories…"
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
  Write-Host "RESULT: NON-COMPLIANT"
  exit 1
}
else {
  Write-Host "RESULT: COMPLIANT"
  exit 0
}