. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "Comparing Data"
if (compareDockerFiles -currentData $currentDockerFile -defaultData $defaultDockerFile) {
	Write-Host "no discrepency found"
	return
}

if ( -not (Get-Content -Path $dockerFile | Test-Json) ) {
	Write-Host "bad json found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
	return
}

Write-Host "discrepency found"
Write-Host "expected ""$defaultDockerFile"" and found ""$($currentDockerFile.allowedOrgs)"""
New-Item -Path "$($args[0])/1" -ItemType File | Out-Null