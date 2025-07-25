param (
	$company,
	$oldBlueprint,
	$newBlueprint
)

$auditFile = "Get-AppAudit.ps1"
$onboardingBlueprint = $oldBlueprint
$newBlueprint = $newBlueprint
$apiURL = "https://$company.api.kandji.io/api/v1"
$serial = (system_profiler SPHardwareDataType | grep Serial)
$serial = $serial.Substring($serial.IndexOf(":") + 1).Trim()


Write-Output $auditFile | Out-Null
Write-Output $onboardingBlueprint | Out-Null
Write-Output $newBlueprint | Out-Null
Write-Output $apiURL | Out-Null