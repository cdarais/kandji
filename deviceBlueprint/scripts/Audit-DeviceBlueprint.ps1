. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "checking data"

if ((getDevice -token $args[1] -serial $serial).blueprint_id -eq $newBlueprint) {
	Write-Host "no discrepency found"
}
else {
	Write-Host "discrepency found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}
