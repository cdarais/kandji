$dockerFile = "/Library/Application Support/com.docker.docker/registry.json"

$defaultDockerFile = '{"allowedOrgs":["workboardinc"]}'

Write-Output $dockerFile | Out-Null
Write-Output $defaultDockerFile | Out-Null