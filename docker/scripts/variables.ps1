$dockerFile = "/Library/Application Support/com.docker.docker/registry.json"

$currentDockerFileValidity = Get-Content -Path $dockerFile | Test-Json
$currentDockerFile = (Get-Content -Path $dockerFile) | ConvertFrom-Json
$defaultDockerFile = '{"allowedOrgs":["workboardinc"]}' | ConvertFrom-Json

Write-Output $dockerFile | Out-Null
Write-Output $defaultDockerFile | Out-Null
Write-Output $currentDockerFile | Out-Null
Write-Output $currentDockerFileValidity | Out-Null