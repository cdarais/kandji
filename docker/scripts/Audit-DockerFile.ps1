. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "Comparing Data"
if (compareDockerFiles -currentData $currentDockerFile -defaultData $defaultDockerFile) {
	Write-Host "no discrepency found"
} else {
	Write-Host "discrepency found"
	Write-Host "expected ""$defaultDockerFile"" and found ""$($currentDockerFile.allowedOrgs)"""
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}