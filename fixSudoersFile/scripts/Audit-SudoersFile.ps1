. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$currentSudoersData = Get-Content -Path $sudoersFile

Write-Host "Comparing Data"
if (compareRootPermissions -currentData $currentSudoersData -defaultData $defaultSudoersData) {
	Write-Host "no discrepency found"
}
else {
	Write-Host "discrepency found"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}