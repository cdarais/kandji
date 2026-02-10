. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$dockerApp = "/Applications/Docker.app"
$currentHostsData = Get-Content -Path "/etc/hosts"
$defaultHostsData = $plainHostsFile

"Comparing Data"
if (Test-Path -Path $dockerApp) {
	Write-Host "docker found, using default docker host file"
	$defaultHostsData = $dockerHostsFile
}

if (compareHostsData -currentData $currentHostsData -defaultData $defaultHostsData) {
	Write-Host "no discrepency found"
}
else {
	Write-Host "discrepency found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}