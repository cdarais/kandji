. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$ErrorActionPreference = "Stop"

Write-Host "=== remediation: $($script:appName) ==="

# 1) Stop processes (best-effort; matches args so it catches node-running gateway too)
Stop-OpenClawProcesses

# 2) Uninstall via Homebrew if present
$brew = Get-BrewPath
if ($brew) {
    Write-Info "Checking Homebrew for installed package 'openclaw' (formula OR cask)…"
    $brewStatus = Get-BrewPackageStatus -BrewPath $brew -Name "openclaw"

    if ($brewStatus.HasFormula -or $brewStatus.HasCask) {
        Write-Info "Uninstalling 'openclaw' via Homebrew (best-effort)…"
        Uninstall-BrewPackageBestEffort -BrewPath $brew -Name "openclaw"
        Write-Ok "brew uninstall attempted (formula=$($brewStatus.HasFormula), cask=$($brewStatus.HasCask))"
    }
    else {
        Write-Ok "No Homebrew package named 'openclaw' installed."
    }
}
else {
    Write-Ok "Homebrew not found in standard paths."
}

# 3) Remove per-user state directories (~/.openclaw)
Write-Info "Removing per-user OpenClaw state (~/.openclaw)…"
$userState = Find-OpenClawUserStateDirs
if ($userState.Count -gt 0) {
    Remove-PathsBestEffort -Paths $userState
}
else {
    Write-Ok "No per-user OpenClaw state directories to remove."
}

# 4) Remove global node_modules directories (wildcards expanded)
Write-Info "Removing global OpenClaw module directories…"
$mods = Get-ExistingPaths -Paths $script:modules
if ($mods.Count -gt 0) {
    Remove-PathsBestEffort -Paths $mods
}
else {
    Write-Ok "No global OpenClaw module directories to remove."
}

# 5) Remove OpenClaw binaries/shims (wildcards expanded)
Write-Info "Removing OpenClaw binaries/shims…"
$bins = Get-ExistingPaths -Paths $script:binaries
if ($bins.Count -gt 0) {
    Remove-PathsBestEffort -Paths $bins
}
else {
    Write-Ok "No OpenClaw binaries/shims to remove."
}

# 6) Final stop pass (in case anything restarted while cleaning)
Stop-OpenClawProcesses

Write-Host "Remediation complete."

exit 0