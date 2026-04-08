. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$scriptCommand = "$($args[0])/$auditFile -profileName ""$profileName"" -appName ""$appName"" -appVersion ""$appVersion"""

Write-Output "checking data"
if (Invoke-Expression -Command $scriptCommand ) {
	Write-Host "no discrepency found"
} else {
	Write-Host "discrepency found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}