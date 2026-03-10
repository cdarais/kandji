. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Output "checking data"
if ( checkXcode -version $appVersion ) {
	Write-Host "no discrepency found"
} else {
	Write-Host "discrepency found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}