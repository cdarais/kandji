$dockerFile = "/Library/Application Support/com.docker.docker/registry.json"

$currentDockerFile = (Get-Content -Path $dockerFile) | ConvertFrom-Json
$defaultDockerFile = "workboardinc"

Write-Output $dockerFile | Out-Null
Write-Output $defaultDockerFile | Out-Null
Write-Output $currentDockerFile | Out-Null