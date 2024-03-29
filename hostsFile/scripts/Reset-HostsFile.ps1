. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$dockerApp = "/Applications/Docker.app"
$defaultHostsData = $plainHostsFile
$hostsFile = "/etc/hosts"

if (Test-Path -Path $dockerApp) {
	$defaultHostsData = $dockerHostsFile
}

Write-Host "attempting to resolve discrepencies"

Out-File -FilePath $hostsFile
$defaultHostsData | Out-File -FilePath $hostsFile -Append

Invoke-Expression "$($args[0])/Audit-HostsFile.ps1 $($args[0])"