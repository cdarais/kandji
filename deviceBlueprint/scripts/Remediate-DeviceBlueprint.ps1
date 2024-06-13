. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


Write-Host "attempting to resolve discrepencies"

updateDevice -token $args[1] -serial $serial

Invoke-Expression "$($args[0])/Audit-DeviceBlueprint.ps1 $($args[0]) $($args[1])"