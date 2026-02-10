$ErrorActionPreference = "Stop"

# Source the helper files passed via argument
. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$consoleUser = Get-ConsoleUser

Write-Host "=== Kandji Remediation: $($script:appName) ==="
if ($consoleUser) {
    Write-Info "Running brew commands as console user: $consoleUser"
}
else {
    Write-Warn "Could not determine console user - brew commands may fail"
}

# 1) Stop processes (best-effort; matches patterns to catch all OpenClaw processes)
Stop-OpenClawProcesses

# 2) Uninstall via Homebrew if present
$brew = Get-BrewPath
if ($brew) {
    Write-Info "Checking Homebrew for installed packages..."
    
    # Check and remove formula (both openclaw and open-claw)
    $formulasToRemove = @("openclaw", "open-claw")
    foreach ($formula in $formulasToRemove) {
        if (Test-BrewHasFormula -BrewPath $brew -FormulaName $formula -User $consoleUser) {
            Write-Info "Uninstalling '$formula' formula via Homebrew..."
            try {
                $cmd = "'$brew' uninstall --force --ignore-dependencies '$formula' 2>&1"
                $output = Invoke-AsUser -User $consoleUser -Command $cmd
                Write-Host $output
                Write-Ok "brew uninstall --force $formula (formula) executed"
            }
            catch {
                Write-Warn "brew uninstall (formula) failed: $($_.Exception.Message)"
            }
        }
    }
    
    # Get all OpenClaw-related casks
    $casksToRemove = Get-InstalledOpenClawCasks -BrewPath $brew -User $consoleUser
    if ($casksToRemove.Count -gt 0) {
        Write-Info "Found OpenClaw casks to remove: $($casksToRemove -join ', ')"
        foreach ($cask in $casksToRemove) {
            Write-Info "Uninstalling '$cask' cask via Homebrew..."
            try {
                # Try with --zap first to remove all associated files
                $cmd = "'$brew' uninstall --cask --zap --force '$cask' 2>&1"
                $output = Invoke-AsUser -User $consoleUser -Command $cmd
                Write-Host $output
                
                # Check if it actually worked
                if ($output -match "Error|error") {
                    Write-Warn "brew uninstall --zap had errors, trying without --zap"
                    # Fallback without --zap
                    $cmd = "'$brew' uninstall --cask --force '$cask' 2>&1"
                    $output = Invoke-AsUser -User $consoleUser -Command $cmd
                    Write-Host $output
                }
                
                Write-Ok "brew uninstall cask '$cask' executed"
            }
            catch {
                Write-Warn "brew uninstall (cask) failed: $($_.Exception.Message)"
            }
        }
    }
    else {
        Write-Ok "No OpenClaw-related brew casks found."
    }
    
    # Verify removal
    $remainingCasks = Get-InstalledOpenClawCasks -BrewPath $brew -User $consoleUser
    if ($remainingCasks.Count -gt 0) {
        Write-Warn "Some casks remain after uninstall attempt: $($remainingCasks -join ', ')"
    }
    else {
        Write-Ok "All OpenClaw casks successfully removed from Homebrew."
    }
}
else {
    Write-Ok "Homebrew not found in standard paths."
}

# 3) Remove per-user state directories (~/.openclaw)
Write-Info "Removing per-user OpenClaw state (~/.openclaw)..."
$userState = Find-OpenClawUserStateDirs
if ($userState.Count -gt 0) {
    Remove-PathsBestEffort -Paths $userState
}
else {
    Write-Ok "No per-user OpenClaw state directories to remove."
}

# 3.5) Remove application directories
Write-Info "Removing OpenClaw applications..."
$apps = Get-ExistingPaths -Paths $script:applications
if ($apps.Count -gt 0) {
    Remove-PathsBestEffort -Paths $apps
}
else {
    Write-Ok "No OpenClaw applications to remove."
}

# 4) Remove global node_modules directories (wildcards expanded)
Write-Info "Removing global OpenClaw module directories..."
$mods = Get-ExistingPaths -Paths $script:modules
if ($mods.Count -gt 0) {
    Remove-PathsBestEffort -Paths $mods
}
else {
    Write-Ok "No global OpenClaw module directories to remove."
}

# 5) Remove OpenClaw binaries/shims (wildcards expanded)
Write-Info "Removing OpenClaw binaries/shims..."
$bins = Get-ExistingPaths -Paths $script:binaries
if ($bins.Count -gt 0) {
    Remove-PathsBestEffort -Paths $bins
}
else {
    Write-Ok "No OpenClaw binaries/shims to remove."
}

# 6) Final stop pass (in case anything restarted while cleaning)
Stop-OpenClawProcesses

Write-Host ""
Write-Host "=== Running post-remediation audit ==="
Write-Host ""

# 7) Run audit to verify remediation
& "$($args[0])/Audit-OpenClaw.ps1" "$($args[0])"
$auditResult = $LASTEXITCODE

if ($auditResult -eq 0) {
    Write-Host ""
    Write-Host "Remediation SUCCESSFUL - System is now compliant"
    exit 0
}
else {
    Write-Host ""
    Write-Host "Remediation INCOMPLETE - Some OpenClaw components remain"
    # The audit script will have already created the marker file
    exit 1
}