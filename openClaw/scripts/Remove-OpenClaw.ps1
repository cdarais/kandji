. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "attempting to resolve discrepencies"

Out-File -FilePath $sudoersFile
$defaultSudoersData | Out-File -FilePath $sudoersFile -Append

Invoke-Expression "$($args[0])/Audit-SudoersFile.ps1 $($args[0])"

$ErrorActionPreference = "Stop"

. "$PSScriptRoot/variables.ps1"
. "$PSScriptRoot/functions.ps1"

Write-Host "=== Kandji Remediation: $($script:appName) ==="

# 1) Stop processes (best-effort; matches args so it catches node-running gateway too)
Stop-OpenClawProcesses

# 2) Uninstall via Homebrew if present
$brew = Get-BrewPath
if ($brew) {
    Write-Info "Checking Homebrew for installed formula 'openclaw'…"
    if (Test-BrewHasFormula -BrewPath $brew -FormulaName "openclaw") {
        Write-Info "Uninstalling 'openclaw' via Homebrew…"
        try {
            & $brew uninstall --force openclaw 2>$null | Out-Host
            Write-Ok "brew uninstall --force openclaw executed"
        }
        catch {
            Write-Warn "brew uninstall failed: $($_.Exception.Message)"
        }
    }
    else {
        Write-Ok "No brew formula 'openclaw' installed."
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