$baseDirectory = $args[0]
$company = $args[1]
$token = $args[2]
$oldBlueprint = $args[3]
$newBlueprint = $args[4]

. "$baseDirectory/functions.ps1" -company $company -oldBlueprint $oldBlueprint -newBlueprint $newBlueprint
. "$baseDirectory/variables.ps1"



Write-Output "checking data"
if ((getDevice -token $token -serial $serial).blueprint_id -eq $newBlueprint) {
	Write-Host "no discrepency found"
} else {
	Write-Host "discrepency found"
	New-Item -Path "$baseDirectory/1" -ItemType File | Out-Null
}
