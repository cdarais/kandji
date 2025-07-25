$baseDirectory = $args[0]
$company = $args[1]
$token = $args[2]
$oldBlueprint = $args[3]
$newBlueprint = $args[4]

. "$baseDirectory/functions.ps1"
. "$baseDirectory/variables.ps1" -company $company -oldBlueprint $oldBlueprint -newBlueprint $newBlueprint


Write-Host "attempting to resolve discrepencies"

updateDevice -token $token -serial $serial

Invoke-Expression "$baseDirectory/Audit-DeviceBlueprint.ps1 $baseDirectory $company $token $oldBlueprint $newBlueprint"