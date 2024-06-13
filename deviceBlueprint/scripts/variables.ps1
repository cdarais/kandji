$auditFile = "Get-AppAudit.ps1"
$onboardingBlueprint = "85335437-d32a-4758-8961-ec83332494e2"
$newBlueprint = "baa9c249-69d7-48f8-b35d-ff4f89c2b6e8"
$apiURL = "https://workboard.api.kandji.io/api/v1"
$serial = system_profiler SPHardwareDataType | grep Serial
$serial = $serial.Substring($serial.IndexOf(":") + 1).Trim()


Write-Output $auditFile | Out-Null
Write-Output $onboardingBlueprint | Out-Null
Write-Output $newBlueprint | Out-Null
Write-Output $apiURL | Out-Null
