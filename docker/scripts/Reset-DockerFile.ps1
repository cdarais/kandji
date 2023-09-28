. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "attempting to resolve discrepencies"

# $currentDockerFile | ConvertTo-Json -Depth 100 | Out-File -FilePath $dockerFile
Set-Content -Path $dockerFile -Value $defaultDockerFile

Invoke-Expression "$($args[0])/Audit-DockerFile.ps1 $($args[0])"